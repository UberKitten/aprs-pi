# aprs-pi

Set up your very own RTL-SDR IGate Pi that serves:
* APRS on AGW port 8000 and KISS on port 8001
* GPSD (JSON format) on port 2947
* GPS NMEA (from GPSD) on port 10110

**Do not follow the stupid instructions out there to disable the gpsd service and run it manually!**

Just edit /etc/default/gpsd and add your device, see the gpsd file in this repo. I use /dev/serial0 because I have a serial GPS.

## Setup
0. [Follow standard Pi setup](https://gist.github.com/T3hUb3rK1tten/806bb851f3de625a835350da3706b2fc)
1. sudo apt-get install gpsd socat build-essential libasound2-dev gpsd-clients python-gps libgps-dev moreutils
2. git clone https://github.com/wb2osz/direwolf.git && cd direwolf && make && sudo make install
3. Copy contents of this repo to home directory, set up crontab, **copy config files where they should go**
4. [Edit your GPSD socket.conf to listen on all interfaces](https://gist.github.com/T3hUb3rK1tten/62834c8ed6b1cf0f3a470410e3651118)
5. [Set up socat to broadcast NMEA from GPSD on port 10110](https://gist.github.com/T3hUb3rK1tten/ab631192d44b57914ab762f5f7d3b71b)
6. [Set up CloudFlare Dynamic DNS for WiFI and Ethernet](https://github.com/T3hUb3rK1tten/ddns-cloudflare)

## Windows client virtual COM port
To be written in a future blog post. The gist of it is:
1. Install com0com signed version
2. Create virtual COM port pair in Setup program
3. Download com2tcp and put it somewhere
4. com2tcp --telnet \\.\CNCB0 wlan.yourpi.example.com 10110
