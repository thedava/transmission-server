# transmission-server

A simple wrapper around [linuxserver/transmission](https://docs.linuxserver.io/images/docker-transmission/). See their official documentation for information about transmission or the image itself.


## Requirements

* docker
* docker-compose
* GNU make (optional)


## Configuration

Copy the `.env.example` to `.env` and adjust to your needs:

* `TZ` defines the TimeZone. For example `TZ=Europe/Berlin`
* `DOWNLOADS_DIR` defines the directory for all downloads. Useful if you want to store your files on a separate drive. For example `DOWNLOADS_DIR=/mnt/ExternalDrive/transmission`
* `AUTH_USER` and `AUTH_PASSWORD` define the credentials for securing the web UI
* `TRACKERS` contains a comma separated list of trackers that should be used for newly created torrents
  * See [ngosang/trackerslist](https://github.com/ngosang/trackerslist) for a list of public trackers


## Install

1. Checkout this repository
2. Copy the `.env.example` to `.env` and adjust to your needs
3. Start everything with `docker-compose up -d`


## Create torrent

All `create`-commands:
* need a running container (started via docker-compose).
* will add the torrent file immediately to the currently running transmission instance and start seeding. You can retrieve your `.torrent` file from the `watch` directory (with `.torrent.added` file extension)
* will output a magnet link after successful torrent creation


### From File

Place your file in your configured `downloads/complete` directory (the `complete` directory will automatically created on first container start) and execute the following make target:

```sh
make create-from-file -e FILE=YourFile.zip
```

### From URL

```sh
make create-from-url -e URL=https://example.com/YourFile.zip

# You can define a custom file name if necessary
make create-from-url -e URL=https://example.com/YourFile.zip -e FILE=MyFile.zip
```

## Clear all torrents

Will delete all files from the `watch` and `downloads/complete` folder and ask before any file will be deleted. You still have to manually delete active seeds from the WebUI.

```sh
make clear
```
