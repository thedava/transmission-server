#!/usr/bin/env bash

set -e

url="${1}"
file="${2}"

# Check if url is empty
if [[ -z "${url}" ]] || [[ "${url}" == "--help" ]]; then
    echo "Usage: ${0} <url> [file]"
    exit 0
fi

# Determine the file name by url if not given
if [ -z "${file}" ]; then
    file=$(basename "${url}")
fi

# Download url
wget -o "/downloads/complete/${file}" "${url}"

# Create torrent file in /tmp
transmission-create -o "/tmp/${file}.torrent" \
-t "udp://tracker.opentrackr.org:1337/announce" \
-t "udp://open.tracker.cl:1337/announce" \
-t "udp://opentracker.i2p.rocks:6969/announce" \
-t "udp://tracker.torrent.eu.org:451/announce" \
"/downloads/complete/${file}"

# Copy torrent file to /watch
cp -f "/tmp/${file}.torrent" "/watch/${file}.torrent"

# Create magnet link
transmission-show --magnet "/tmp/${file}.torrent"

rm -f "/tmp/${file}.torrent"
