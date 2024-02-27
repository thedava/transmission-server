#!/usr/bin/env bash

set -e

function create_torrent {
    file="${1}"

    # Parse trackers from environment variable
    trackers=$(echo "${TRACKERS}" | tr "," "\n")

    # Prepare tracker options for transmission-create
    tracker_opts=""
    tracker_list=""
    for tracker in ${trackers}; do
        trimmed_tracker=$(echo "${tracker}" | sed 's/^ *//;s/ *$//')
        tracker_opts+="-t '${trimmed_tracker}' "
        tracker_list+="${trimmed_tracker}\n"
    done

    echo "Trackers:"
    if [[ "${tracker_list}" == "" ]]; then
        echo "No trackers defined"
    else
        echo -e "${tracker_list}"
    fi

    # Create torrent file in /tmp
    echo "Creating '/tmp/${file}.torrent' now"
    eval transmission-create -o "/tmp/${file}.torrent" $tracker_opts "/downloads/complete/${file}"

    # Copy torrent file to /watch
    cp -f "/tmp/${file}.torrent" "/watch/${file}.torrent"

    # Display magnet link
    echo "Magnet link:"
    transmission-show --magnet "/tmp/${file}.torrent"
    echo

    # Clean up
    rm -f "/tmp/${file}.torrent"
}
