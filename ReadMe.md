Enclosed are my rough notes on building a RasPi 4 based bridge firewall.

*** Warning has not been fully tested ***

So PiHole, price to performance is a good cheap fast layer of security to add to a home network but it lacks teeth.
A bridge firewall is transparent and takes existing repudation ip lists, black lists ...etc and blocks it at an IP level.
Its just a flat block so it doesnt tell you why it blocked it, just that an IP was blocked.  

will this cause weirdness? Absolutly, the total dependance on content delivery networks makes straignt IP filtering painful.
Which is why you layer that with dns black holing.

Throw on some IDS sauce and you get a good stream of threat intel (Hopefully!) with out the heavy performance penalties a full IPS causes.

Steps:
* get a pi 4 with 3amp power supply $50 or more depending on model
* get a sdcard $10
* get a pair of 1GBE usb3 dongles (25$ ?) or a usb3 dual ethernet dongle.
* install BR tools
* add br_netfilter to /etc/modules-load.d/modules.conf (so net filtering works on bridge)
* add "net.bridge.bridge-nf-filter-vlan-tagged = 1" to /etc/sysctl.d/97-bridge.conf  (for acting on tagged traffic)
* configure eth1 and eth2 to manual configured in /etc/network/interfaces" to rc.local or some other boot time place.
* add to dhcpcd.conf to "denyinterfaces eth1 eth2 br0"
* configure as manual br0 in interfaces to include eth1 and eth2
* install curl
* install script in crontab
* install script in systemd boot process or in rc.local

future todo list:
* configure suricata ids
* configure syslog with eve json for suricata as well as firewall hits
* add with pihole or similar dns filtering
* fix firewall logging currently not displaying blocks to syslog.

Notes from initial testing:
* Changes: 
** new dhcpcd and the old /etc/network/interface is broken, 
** bridge-firewall mode and working across vlans support needs to be added via kernel module.
