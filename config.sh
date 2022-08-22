#
# Absolute path of the dictory the script is in. Don't touch this unless you know what you're doing
#
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#
# Filter to adjust music volume. Put "1.0" to keep the original volumes
#
VOLUME="0.8"

#
# How many threads FFMPEG will use. Set to "0" to let FFMPEG decide
#
THREAD_COUNT="0"

#
# Local or remote address for the music stream.
#
MUSIC_STREAM_URL="http://server/radio.mp3"

#
# Days, Hours, minutes where the given show is running
# Eg. if you have two shows each day, from monday to sunday where 1st show is starts at 8am, and ends at 9am.
# Insert your show times to each like as strings eg. "16:00-17:00"
#
SHOW_TIMES=(
        "16:00-17:00"
        "17:00-19:00"
    )

SHOW_BACKGROUNDS=(
  "${SCRIPT_DIR}/media/sample_background.mkv"
  "${SCRIPT_DIR}/media/sample_background.mkv"
)

#
# RTMP urls you wish to stream to
#
PLATFORMS=(
        "rtmp://server/key"
        "rtmp://server/key"
        "rtmp://server/key"
    )

#
# Executed before the next song in the playlist starts playing
# Arguments:
#   ${1} File name (String, eg. "Billie_Eilish_-_Ocean_Eyes.mp3")
#   ${2} Cleaned up file name (String, eg. "Billie Eilish - Ocean Eyes")
# Returns:
#   None
#
function on_next_track() {
  # Your custom code goes here
  # The following line writes the currently playing song to a text file.
  # You can safely remove it if you don't need this feature
  echo "${2}" > ${SCRIPT_DIR}/now_playing.txt

  :
}

#
# Executed after the playlist has been reshuffled
# Arguments:
#   None
# Returns:
#   None
#
function on_playlist_reshuffle() {
  # Your custom code goes here

  :
}

#
# Executed when the stream is restarting (e.g. after a crash)
# Arguments:
#   None
# Returns:
#   None
#
function on_stream_restart() {
  # Your custom code goes here

  :
}