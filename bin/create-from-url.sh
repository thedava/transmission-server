#!/usr/bin/env bash

set -e

. /custom/bin/_create.sh

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
echo "Downloading file '${file}' from url '${url}' now..."
wget -O "/downloads/complete/${file}" "${url}"

# Create torrent
create_torrent "${file}"
