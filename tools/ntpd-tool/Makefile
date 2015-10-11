# NTP Tool

include ../Makefile.config

PROG=ntpd-tools
PWD=`pwd`
DATE=`date +%Y-%m-%d`

TARGET_NTP=$(TARGET)-unknown-linux
NTP_VERSION=4.2.6p5
NTP_FOLDER=ntp-$(NTP_VERSION)
NTP_ARCHIVE=$(NTP_FOLDER).tar.gz
NTP_RELEASE=$(NTP_FOLDER)-arm-$(DATE)

NTP_LOCATION=$(RELEASEDIR)/ntp-package

NTP_DAEMON=ntpd
NTP_DAEMON_LOCATION=$(NTP_LOCATION)/sbin

NTP_DAEMON_CONFIG=ntp.conf
NTP_DAEMON_CONFIG_LOCATION=$(NTP_LOCATION)/etc

NTP_DAEMON_SCRIPT=ntpd.sh
NTP_DAEMON_SCRIPT_LOCATION=$(NTP_LOCATION)/etc/rc.d/init.d

all: $(PROG) release

$(PROG): ntp-build  

ntp-build: ntp-init ntp_unpack
	@echo Compiling ntp $(NTP_VERSION) source...
	@$(MAKE) -C $(NTP_FOLDER)
	@$(MAKE) -C $(NTP_FOLDER) install
	@echo $@ ready!

ntp-init:
	@mkdir -p $(NTP_LOCATION)

ntp_unpack: $(NTP_ARCHIVE)
	@echo Decompressing ntp $(NTP_VERSION) source...
	@tar xf $(NTP_ARCHIVE)
	@(cd $(NTP_FOLDER) && CC=$(CC) ./configure --host=$(TARGET_NTP) --prefix=$(NTP_LOCATION) )
	@touch $@

ntp-clean:
	@echo Cleaning ntp...
	@rm -rf $(NTP_LOCATION) $(NTP_FOLDER) ntp_unpack   
	@echo ntp cleanup done!

release-init:
	@mkdir -p $(NTP_DAEMON_SCRIPT_LOCATION)
	@@rm -rf *.tbz2


release : release-init 
	@( $(STRIP) --strip-unneeded $(NTP_LOCATION)/bin/$(NTP_DAEMON) -o $(NTP_LOCATION)/sbin/$(NTP_DAEMON) && \
	   cp -a $(NTP_DAEMON_SCRIPT)  $(NTP_DAEMON_SCRIPT_LOCATION) && \
	   cp    $(NTP_DAEMON_CONFIG)  $(NTP_DAEMON_CONFIG_LOCATION) )	
	@(tar -c --exclude bin --exclude lib --exclude share --owner root --group root -C $(NTP_LOCATION) . | bzip2 > $(NTP_RELEASE).tbz2 )

.PHONY: all ntp-clean release
