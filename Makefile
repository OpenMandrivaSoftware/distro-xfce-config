# 2012 Author: tpg@mandriva.org
# 2014 Author: tpgxyz@gmail.com

PACKAGE = distro-xfce-config
VERSION = `date +%Y%m%d`

PREFIX=$(prefix)
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
	-install -d $(DESTDIR)$(xfceconfdir)/xfce4/menus
	install -m 644 common/xfce4/menus/xfce-applications.menu $(DESTDIR)$(xfceconfdir)/xfce4/menus/xfce-applications.menu
	-install -d $(DESTDIR)$(xfceconfdir)/xfce4
	-install -d $(DESTDIR)$(xfceconfdir)/xfce4/desktop
	-install -d $(DESTDIR)$(xfceconfdir)/xfce4/panel
	-install -d $(DESTDIR)$(xfceconfdir)/xfce4/theme
	-install -d $(DESTDIR)$(xfceconfdir)/xfce4/xfconf/xfce-perchannel-xml
	-install -d $(DESTDIR)$(PREFIX)/bin
	cp -fr common/xfce4/panel/* $(DESTDIR)$(xfceconfdir)/xfce4/panel/
	install -m 644 common/xfce4/theme/* $(DESTDIR)$(xfceconfdir)/xfce4/theme/
	install -m 644 common/xfce4/xfconf/xfce-perchannel-xml/* $(DESTDIR)$(xfceconfdir)/xfce4/xfconf/xfce-perchannel-xml/
	install -m 644 common/xfce4/*.rc $(DESTDIR)$(xfceconfdir)/xfce4
	install -m 755 tools/xfce4-firstrun $(DESTDIR)$(PREFIX)/bin
	-install -d $(DESTDIR)$(xfceprofdir)
	-install -d $(DESTDIR)$(xfceprofdir)/OpenMandriva/xfce4/xfconf/xfce-perchannel-xml
	install -m 644 OpenMandriva/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml $(DESTDIR)$(xfceprofdir)/OpenMandriva/xfce4/xfconf/xfce-perchannel-xml

dist:
	git archive --format=tar --prefix=$(PACKAGE)-$(VERSION)/ HEAD | xz -2vec -T0 > $(PACKAGE)-$(VERSION).tar.xz;
	$(info $(PACKAGE)-$(VERSION).tar.xz is ready)

.PHONY: ChangeLog log changelog

log: ChangeLog

changelog: ChangeLog


ChangeLog:
	@if test -d "$$PWD/.git"; then \
	  git --no-pager log --format="%ai %aN %n%n%x09* %s%d%n" > $@.tmp \
	  && mv -f $@.tmp $@ \
	  && git commit ChangeLog -m 'generated changelog' \
	  && if [ -e ".git/svn" ]; then \
	    git svn dcommit ; \
	    fi \
	  || (rm -f  $@.tmp; \
	 echo Failed to generate ChangeLog, your ChangeLog may be outdated >&2; \
	 (test -f $@ || echo git-log is required to generate this file >> $@)); \
	else \
	 svn2cl --accum --authors ../common/username.xml; \
	 rm -f *.bak;  \
	fi;
