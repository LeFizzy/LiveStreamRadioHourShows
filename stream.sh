. ./config.sh

tee_muxer_output=""
i=0

for platform in "${PLATFORMS[@]}"
do
    if (( $i > 0 )); then
        tee_muxer_output+="|"
    fi
    tee_muxer_output+="[f=fifo:fifo_format=flv:queue_size=120:drop_pkts_on_overflow=1:attempt_recovery=1:recovery_wait_time=10:max_recovery_attempts=0:restart_with_keyframe=1]${platform}"
    i=$((i+1))
done

while true :
do
	while true : 
	do
		current_hour=$(date +%H)
		current_minutes=$(date +%M)

		live_background=""
		for show_time in "${SHOW_TIMES[@]}"
		do
			curr_show_timecodeArr=(${show_time//-/ })

			curr_show_startsArr=(${curr_show_timecodeArr[0]//:/ })
			curr_show_startsHour=$((curr_show_startsArr[0]))
			curr_show_startsMinute=$((curr_show_startsArr[1]))

			curr_show_endsArr=(${curr_show_timecodeArr[1]//:/ })
			curr_show_endsHour=$((curr_show_endsArr[0]))
			curr_show_endsMinute=$((curr_show_endsArr[1]))

			if (( curr_show_startsHour >= current_hour )) && (( curr_show_startsMinute >= current_minutes )) && (( curr_show_endsHour <= current_hour )) && (( curr_show_endsMinute <= current_minutes )); then
				live_background=SHOW_BACKGROUNDS[0]
			else
				live_background=SHOW_BACKGROUNDS[1]
			fi
		done

		ffmpeg -threads "${THREAD_COUNT}" -loglevel warning \
			-fflags "+autobsf+genpts+discardcorrupt" -avoid_negative_ts "make_zero" -copytb 1 \
			-re -stream_loop -1 -i "${live_background}" \
			-f alsa -ac 2 -thread_queue_size 1024 -i ${MUSIC_STREAM_URL} -c:v copy -c:a aac -filter:a "volume=${VOLUME}" -map 0:v -map 1:a \
			-f tee "${tee_muxer_output}"

		sleep 1m
	done

	 echo "[ERROR] `date '+%Y-%m-%d %H:%M:%S'` Stream crashed. Restarting..." >> ${SCRIPT_DIR}/event.log
	 on_stream_restart
done