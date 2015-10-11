# $Id: Makefile,v 1.9 2011-11-17 11:21:48 henes Exp $


include ../../../Makefile.config.default
-include ../../../Makefile.config
include ../../lib/config

PROG=hostapd_nl80211
HOSTAPD_VERSION=0.7.3
HOSTAPD_ARCHIVE=hostapd-$(HOSTAPD_VERSION).tar.gz
HOSTAPD_FOLDER=hostapd-$(HOSTAPD_VERSION)/hostapd
HOSTAPD_LOCATION=usr/sbin
LIBNL=../../../../lib/libnl/libnl-$(LIBNL_VERSION)

all: $(PROG)

$(PROG): $(HOSTAPD_FOLDER)/hostapd

$(HOSTAPD_FOLDER)/hostapd: hostapd_done
	@echo Compiling hostapd $(HOSTAPD_VERSION) source...
	@$(MAKE) CC=$(CC) LIBNL=$(LIBNL) -C $(HOSTAPD_FOLDER)
	@$(STRIP) --strip-unneeded $(HOSTAPD_FOLDER)/hostapd -o $(PROG)
	@chmod u+x $(PROG)
	@echo $@ ready!

hostapd_done: $(HOSTAPD_ARCHIVE)
	@echo Decompressing hostapd $(HOSTAPD_VERSION) source...
	@rm -rf hostapd-$(HOSTAPD_VERSION)
	@tar xf $(HOSTAPD_ARCHIVE)
	@echo Copy config of hostapd $(HOSTAPD_VERSION)...
	@(cd $(HOSTAPD_FOLDER) && cp ../../.config . && sed -e "s/CONFIG_TLS=openssl/CONFIG_TLS=none/g" -i Makefile)
	@touch $@

clean:
	@echo Cleaning hostapd...
	@rm -rf hostapd-$(HOSTAPD_VERSION) hostapd_done $(PROG)
	@echo hostapd cleanup done!

release: all
	@mkdir -p $(RELEASEDIR)/$(HOSTAPD_LOCATION)
	@$(UPX) --lzma -9 -o $(RELEASEDIR)/$(HOSTAPD_LOCATION)/$(PROG) $(PROG)

.PHONY: all clean release
