# RSYNC Tool

include ../Makefile.config

PROG=rsync-tools
PWD=`pwd`
DATE=`date +%Y-%m-%d`


RSYNC_VERSION=3.0.9
RSYNC_FOLDER=rsync-$(RSYNC_VERSION)
RSYNC_ARCHIVE=$(RSYNC_FOLDER).tar.gz
#RSYNC_PATCH=rsync-patches-$(RSYNC_VERSION).tar.gz

RSYNC_RELEASE=$(RSYNC_FOLDER)-arm-$(DATE)
RSYNC_LOCATION=$(RELEASEDIR)/rsync-package
RSYNC_DAEMON=rsync




all: $(PROG) release

$(PROG): rsync-build  

rsync-build: rsync-init rsync_unpack
	@echo Compiling rsync $(RSYNC_VERSION) source...
	@$(MAKE) -C $(RSYNC_FOLDER)
	@$(MAKE) -C $(RSYNC_FOLDER) install
	@echo $@ ready!

rsync-init:
	@mkdir -p $(RSYNC_LOCATION)

rsync_unpack: $(RSYNC_ARCHIVE) 
	@echo Decompressing rsync $(RSYNC_VERSION) source...
	@tar xf $(RSYNC_ARCHIVE) 
	@(cd $(RSYNC_FOLDER) && CC=$(CC) ./configure --host=$(TARGET) --prefix=$(RSYNC_LOCATION) )
	@touch $@

rsync-clean:
	@echo Cleaning rsync...
	@rm -rf $(RSYNC_LOCATION) $(RSYNC_FOLDER) rsync_unpack   
	@echo rsync cleanup done!

release-init:
	@rm -rf *.tbz2


release : release-init 
	@$(STRIP) --strip-unneeded $(RSYNC_LOCATION)/bin/$(RSYNC_DAEMON)	
	@(tar -c --exclude share --owner root --group root -C $(RSYNC_LOCATION) . | bzip2 > $(RSYNC_RELEASE).tbz2 )

.PHONY: all rsync-clean release
