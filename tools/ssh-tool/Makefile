# SSH Tool

include ../Makefile.config

PROG=ssh-tools
PWD=`pwd`
DATE=`date +%Y-%m-%d`

SSH_VERSION=6.2p2
SSH_FOLDER=openssh-$(SSH_VERSION)
SSH_ARCHIVE=$(SSH_FOLDER).tar.gz
SSH_RELEASE=$(SSH_FOLDER)-arm-$(DATE)

SSH_LOCATION=$(RELEASEDIR)/ssh-package
SSH_ARM_LOCATION=$(SSH_LOCATION)/arm

SSH_DAEMON=sshd
SSH_DAEMON_LOCATION=$(SSH_ARM_LOCATION)/sbin

SSH_DAEMON_CONFIG=sshd_config
SSH_AUTHORIZED_KEYFILE=authorized_keys
SSH_DAEMON_CONFIG_LOCATION=$(SSH_ARM_LOCATION)/etc

SSH_DAEMON_SCRIPT=sshd_start
SSH_DAEMON_SCRIPT_LOCATION=$(SSH_ARM_LOCATION)/etc/rc.d/init.d

SSH_KEYGEN=ssh-keygen
SSH_KEYGEN_LOCATION=$(SSH_ARM_LOCATION)/bin


all: $(PROG) release

$(PROG): ssh-build  

ssh-build: ssh-init ssh_unpack
	@echo Compiling ssh $(SSH_VERSION) source...
	@$(MAKE) -C $(SSH_FOLDER)
	@$(MAKE) -C $(SSH_FOLDER) install-nokeys
	@echo $@ ready!

ssh-init:
	@mkdir -p $(SSH_LOCATION)

ssh_unpack: $(SSH_ARCHIVE)
	@echo Decompressing ssh $(SSH_VERSION) source...
	@tar xf $(SSH_ARCHIVE)
	@(cd $(SSH_FOLDER) && CC=$(CC)  LDFLAGS=-L$(LIB_DIR_HOST) LIBS=-lcrypt ./configure --host=$(TARGET) --with-zlib=$(ZLIB_PATH_ARM) --with-ssl-dir=$(SSL_PATH_ARM) --with-ldflags=-Wl,-Map,$(PWD)/ossh.map --prefix=$(SSH_LOCATION) --with-privsep-path=`pwd` --disable-strip )
	@touch $@

ssh-clean:
	@echo Cleaning ssh...
	@rm -rf $(SSH_ARM_LOCATION) $(SSH_LOCATION) $(SSH_FOLDER) ssh_unpack   
	@echo ssh cleanup done!

release-init:
	@mkdir -p $(SSH_DAEMON_LOCATION) $(SSH_KEYGEN_LOCATION) $(SSH_DAEMON_SCRIPT_LOCATION)
	@@rm -rf *.tbz2

release-dbg: release-init
	@(cp -a $(SSH_LOCATION)/bin/$(SSH_KEYGEN)  $(SSH_KEYGEN_LOCATION)/$(SSH_KEYGEN) && \
	cp   -a $(SSH_LOCATION)/sbin/$(SSH_DAEMON) $(SSH_DAEMON_LOCATION)/$(SSH_DAEMON) && \
	cp    $(SSH_DAEMON_CONFIG)  $(SSH_DAEMON_CONFIG_LOCATION)   && \
	cp -a $(SSH_DAEMON_SCRIPT)  $(SSH_DAEMON_SCRIPT_LOCATION)/$(SSH_DAEMON_SCRIPT) )
	@(tar -c --owner root --group root -C $(SSH_ARM_LOCATION) . | bzip2 > $(SSH_RELEASE).tbz2 )

release-config: release-init
	@cp    $(SSH_DAEMON_CONFIG)  $(SSH_AUTHORIZED_KEYFILE) $(SSH_DAEMON_CONFIG_LOCATION)
	@cp -a $(SSH_DAEMON_SCRIPT)  $(SSH_DAEMON_SCRIPT_LOCATION)
	@(tar -c --exclude bin --exclude sbin --owner root --group root -C $(SSH_ARM_LOCATION) . | bzip2 > $(SSH_RELEASE).tbz2 )

release : release-init 
	@( $(STRIP) --strip-unneeded $(SSH_LOCATION)/bin/$(SSH_KEYGEN) -o $(SSH_KEYGEN_LOCATION)/$(SSH_KEYGEN)    && \
	   $(STRIP) --strip-unneeded $(SSH_LOCATION)/sbin/$(SSH_DAEMON) -o $(SSH_DAEMON_LOCATION)/$(SSH_DAEMON)    && \
	   $(STRIP) --strip-unneeded $(SSH_LOCATION)/bin/scp -o $(SSH_KEYGEN_LOCATION)/scp        && \
	   cp $(SSH_DAEMON_CONFIG)  $(SSH_AUTHORIZED_KEYFILE) $(SSH_DAEMON_CONFIG_LOCATION) && \
	   cp -a $(SSH_DAEMON_SCRIPT)  $(SSH_DAEMON_SCRIPT_LOCATION) \
	)	
	@(tar -c --owner root --group root -C $(SSH_ARM_LOCATION) . | bzip2 > $(SSH_RELEASE).tbz2 )

.PHONY: all ssh-clean release
