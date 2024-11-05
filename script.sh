#!/bin/sh

# /script directory locally within the container holds script.sh with +x permissions

log_message() { 
    local message="$1" 
    local log_file="/script/script.log"
    
    if [ ! -f "$log_file" ]; then
        touch "$log_file" 
    fi
    
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S") 
    echo "$timestamp - $message" >> "$log_file" 
}

case "$radarr_eventtype" in
    Download)
        # Inform kodi-blackrack to update the video library.
        /usr/bin/curl --data-binary '{"jsonrpc": "2.0", "method": "VideoLibrary.Scan", "params": {"showdialogs": false}, "id": 1}' -H 'content-type: application/json;' http://username:password@kodi-instance.mydomain:8080/jsonrpc
        log_message "Movies $radarr_movie_title downloaded to $radarr_movie_path"
        ;;
    MovieDelete)
        # Inform kodi-blackrack to clean the video library.
        /usr/bin/curl --data-binary '{"jsonrpc": "2.0", "method": "VideoLibrary.Clean", "id": 1}' -H 'content-type: application/json;' http://username:password@kodi-instance.mydomain:8080/jsonrpc
        log_message "Movie $radarr_movie_title deleted from $radarr_movie_path"
        ;;
    Test)
        # Handle test event
        log_message "Test fire of the custom script"
        ;;
    *)
        # Capture unknown events
        log_message "Unhandled event type: $radarr_eventtype"
        ;;
esac