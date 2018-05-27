# aprs-pi

Set up your very own RTL-SDR IGate Pi that gates RF traffic to APRS-IS and also serves:
* APRS on AGW port 8000 and KISS on port 8001
* GPSD (JSON format) on port 2947
* GPS NMEA (from GPSD) on port 10110
* GPS NTP with PPS support on port 123

## Setup
0. [Follow standard Pi setup](https://gist.github.com/T3hUb3rK1tten/806bb851f3de625a835350da3706b2fc)
1. Follow [this excellent Raspberry Pi GPS + PPS tutorial](http://unixwiz.net/techtips/raspberry-pi3-gps-time.html) with a few notes
 - Yes, you do want to build gpsd from source. The Raspbian package is old and you want it to run as root.
 - Install the gpsd systemd unit files to `/etc/systemd/system/` **not** `/lib/systemd/system`
2. `sudo apt-get install socat build-essential libasound2-dev python-gps libgps-dev moreutils`
3. Build direwolf: `cd && git clone https://github.com/wb2osz/direwolf.git && cd direwolf && make && sudo make install`
4. Copy this repo: `cd && git clone https://github.com/T3hUb3rK1tten/aprs-pi.git && cd aprs-pi`
5. Edit the gpsd socket to listen on all interfaces: `cp gpsd.socket /etc/systemd/system/ && sudo systemctl daemon-reload`
6. Set up socat to serve NMEA from GPSD on port 10110: `cp socatgps.service /etc/systemd/system/ && sudo systemctl daemon-reload && sudo systemctl enable socatgps`
7. [Set up CloudFlare Dynamic DNS for WiFI and Ethernet](https://github.com/T3hUb3rK1tten/ddns-cloudflare)
8. Edit crontab as appropriate, [an example is provided](crontab)

## Windows client virtual COM port
To be written in a future blog post. The gist of it is:
1. Install com0com signed version
2. Create virtual COM port pair in Setup program
3. Download com2tcp and put it somewhere
4. com2tcp --telnet \\\\.\CNCB0 wlan.yourpi.example.com 10110
