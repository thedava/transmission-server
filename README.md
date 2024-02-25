# transmission-server

A simple wrapper around linuxserver/transmission


## Trackers

* https://github.com/ngosang/trackerslist


## Create torrent

1. Upload the file which should be shared to the "/downloads/complete" folder

2. Connect to running container via Make target

```sh
make exec
```


3. Create a .torrent file directly in the watch folder now (so it will be added to transmission immediately)

```sh
transmission-create -o "/watch/ubuntu-mate-22.04.3-desktop-amd64.iso.torrent" \
-t "udp://tracker.opentrackr.org:1337/announce" \
-t "udp://open.tracker.cl:1337/announce" \
-t "udp://opentracker.i2p.rocks:6969/announce" \
/downloads/complete/ubuntu-mate-22.04.3-desktop-amd64.iso
```

4. Retriev magnet link for (now added) torrent file


```sh
transmission-show --magnet "/watch/ubuntu-mate-22.04.3-desktop-amd64.iso.torrent.added"
```

5. Share magnet link with second seed server (see list of peers above)
