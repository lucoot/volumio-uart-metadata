
#!/bin/bash
#prints music metadata out ttyAMA0 every second
stty -F /dev/ttyAMA0 115200

while true; do
        OUTPUT=$(volumio status)
        IP=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{print "\"" $1"\""}')
        WIFI=$(sudo iwconfig wlan0 | grep 'Link Quality=' |cut -d= -f2 | cut -d/ -f1 | awk '{print "\"" $1"\""}')

        if [[ -z $WIFI ]]
        then
            WIFI="\"0\""
        fi

        if [[ -z $IP ]]
        then
            IP="\"0\""
        fi
        echo -e  $OUTPUT | jq -M  '{status: .status, title: .title, artist: .artist, album: .album, seek: (.seek|tostring), duration: (.duration|tostring), samplerate: .samplerate, bitdepth: .bitdepth, ethernet: '$IP', wifi: '$WIFI'}'\
              > /dev/ttyAMA0
        sleep 1
done
