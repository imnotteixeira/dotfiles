## For files that are outside ~ but are still relevant for configuration

* 40-libinput.conf -> /usr/share/X11/xorg.conf.d/40-libinput.conf
* 10-sleep.conf -> /etc/systemd/sleep.conf.d/10-sleep.conf
    * Remember to switch to `suspend-then-hibernate` on the HandleLidSwitch config (instead of sleeping normally)
* tlp.conf -> /etc/tlp.conf
