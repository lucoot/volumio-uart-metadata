# volumio-uart-metadata

Description:

This bash shell script prints JSON music playback metadata from Volumio music server on Raspberry Pi 
out of UART ttyAMA0 for a listening microcontroller driven OLED display (or whatever other display), every second.

Prerequisites:
1. Volumio 2.0 +
2. jq JSON parser(pre-installed on Volumio)
3. Something listening to UART output from Pi (Arduino, MCU, COM port) @ 115200 baud

Setup:
1. Copy script to usr/local/bin/
2. Set permisions of script to be executed
   $chmod 755 volumio-print.sh
3. Disable kernel output to ttyAMA0
   $sudo systemctl mask serial-getty@ttyAMA0.service)
4. Disable shell output to ttyAMA0 in /boot/cmndline.txt
   delete line "console=serial0,115200"
5. Disable Bluetooth use of ttyAMA0 in /boot/config.txt
   add line "dtoverlay=pi3-disable-bt"
6. Set to script to execute at startup in rc.local
   $sudo nano /etc/rc.local
   add line "/usr/local/bin/vol-print.sh &"
7. $reboot
   
  UART JSON Output:
  
  {
  
  "status": "pause",
  
  "title": "The Game of Love",
  
  "artist": "Daft Punk",
  
  "album": "Random Access Memories",
  
  "seek": "60765",
  
  "duration": "322",
  
  "samplerate": "44.1 KHz",
  
  "bitdepth": "16 bit"
  
}
