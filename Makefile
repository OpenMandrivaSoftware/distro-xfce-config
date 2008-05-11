# tpg@mandriva.org
PACKAGE = mandriva-xfce-config
VERSION = `date +%Y%m%d`

prefix=$(prefix)
xfceconfdir=$(sysconfdir)
xfceprofdir=$(localstatedir)/mandriva/xfce-profiles

install:
	-install -d $(DESTDIR)$(xfceconfdir)
	-install -d $(DESTDIR)$(xfceconfdir)/Terminal
	install -m 644 common/Terminal/* $(DESTDIR)$(xfceconfdir)/Terminal/
	-install -d $(DESTDIR)$(xfceconfdir)/Thunar
	install -m 644 common/Thunar/* $(DESTDIR)$(xfceconfdir)/Thunar/
	-install -d $(DESTDIR)$(xfceconfdir)/autostart
	install -m 644 common/autostart/* $(DESTDIR)$(xfceconfdir)/autostart/
	-install -d $(DESTDIR)$(xfceconfdir)/xfce4
	-install -d $(DESTDIR)$(xfceconfdir)/xfce4/desktop
	-install -d $(DESTDIR)$(xfceconfdir)/xfce4/notication-daemon-xfce
	-install -d $(DESTDIR)$(xfceconfdir)/xfce4/panel
	-install -d $(DESTDIR)$(xfceconfdir)/xfce4/theme
	-install -d $(DESTDIR)$(xfceconfdir)/xfce4/volstatus
	install -m 644 common/xfce4/desktop/* $(DESTDIR)$(xfceconfdir)/xfce4/desktop/
	install -m 644 common/xfce4/notication-daemon-xfce/* $(DESTDIR)$(xfceconfdir)/xfce4/notication-daemon-xfce/
	install -m 644 common/xfce4/panel/* $(DESTDIR)$(xfceconfdir)/xfce4/panel/
	install -m 644 common/xfce4/theme/* $(DESTDIR)$(xfceconfdir)/xfce4/theme/
	install -m 644 common/xfce4/volstatus/* $(DESTDIR)$(xfceconfdir)/xfce4/volstatus/
	install -m 644 common/xfce4/*.rc $(DESTDIR)$(xfceconfdir)/xfce4
	install -m 644 common/xfce4/*.xrdb $(DESTDIR)$(xfceconfdir)/xfce4

	-install -d $(DESTDIR)$(xfceprofdir)
	-install -d $(DESTDIR)$(xfceprofdir)/Flash/xfce4/mcs_settings
	install -m 644 Flash/xfce4/mcs_settings/*.xml $(DESTDIR)$(xfceprofdir)/Flash/xfce4/mcs_settings/

	-install -d $(DESTDIR)$(xfceprofdir)/Free/xfce4/mcs_settings
	install -m 644 Free/xfce4/mcs_settings/*.xml $(DESTDIR)$(xfceprofdir)/Free/xfce4/mcs_settings/

	-install -d $(DESTDIR)$(xfceprofdir)/One/xfce4/mcs_settings
	install -m 644 One/xfce4/mcs_settings/*.xml $(DESTDIR)$(xfceprofdir)/One/xfce4/mcs_settings/

	-install -d $(DESTDIR)$(xfceprofdir)/Powerpack/xfce4/mcs_settings
	install -m 644 Powerpack/xfce4/mcs_settings/*.xml $(DESTDIR)$(xfceprofdir)/Powerpack/xfce4/mcs_settings/

cleandist:
	rm -rf $(PACKAGE)-$(VERSION) $(PACKAGE)-$(VERSION).tar.bz2

localcopy:
	svn export -q -rBASE . $(PACKAGE)-$(VERSION)

tar:
	tar cvf $(PACKAGE)-$(VERSION).tar $(PACKAGE)-$(VERSION)
	bzip2 -9vf $(PACKAGE)-$(VERSION).tar
	rm -rf $(PACKAGE)-$(VERSION)

dist: cleandist localcopy tar

.PHONY: ChangeLog log changelog

log: ChangeLog

changelog: ChangeLog

ChangeLog: ../common/username.xml
	svn2cl --accum --authors ../../soft/common/username.xml
	rm -f *.bak
	svn commit -m "Generated by svn2cl the `LC_TIME=C date '+%d_%b'`" ChangeLog
