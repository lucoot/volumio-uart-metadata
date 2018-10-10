
#!/bin/bash
#prints music metadata out ttyAMA0 every second
stty -F /dev/ttyAMA0 11520

IP=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{print "\"ethernet\":\"" $1"\""}')
WIFI=$( sudo iwconfig wlan0 | grep "Link Quality=" |cut -d= -f2 | cut -d/ -f1 | awk '{print "\"wifi\":\"" $1"\""}')

while true; do
        OUTPUT=$(volumio status)
        echo -e  $OUTPUT | jq -M  '{status: .status, title: .title, artist: .artist, album: .album, seek: (.seek|tostring), duration: (.duration|tostring), samplerate: .samplerate, bitdepth: .bitdepth,'$IP','$WIFI' }'\
              > /dev/ttyAMA0
        sleep 1
done

