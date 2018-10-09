#!/bin/bash
while true; do
        OUTPUT=$(volumio status)
        echo -e  $OUTPUT | jq '{hi: .status, title: .title, artist: .artist, album: .album, seek: (.seek|tostring), duration: (.duration|tostring), samplerate: .samplerate, bitdepth: .bitdepth }' > /dev/ttyAMA0
        sleep 1
done