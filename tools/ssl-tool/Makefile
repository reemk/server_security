# SSL Tool

include ../Makefile.config

PROG=ssl-tools
DATE=`date +%Y-%m-%d`

SSL_VERSION=1.0.1e
SSL_FOLDER=openssl-$(SSL_VERSION)
SSL_ARCHIVE=$(SSL_FOLDER).tar.gz
SSL_LOCATION=$(RELEASEDIR)/ssl-package
SSL_DEFAULT_DIR=usr/local/ssl
SSL_RELEASE=$(SSL_FOLDER)-arm-$(DATE)


all: $(PROG) release

$(PROG): ssl-build  

ssl-build: ssl-init ssl_unpack
	@echo Compiling ssl $(SSL_VERSION) source...
	@$(MAKE)   CC=$(CC)  LDFLAGS=-L$(LIB_DIR_HOST) -C $(SSL_FOLDER)
	@$(MAKE)   INSTALL_PREFIX=$(SSL_LOCATION)      -C $(SSL_FOLDER)  install
	@sed -e '/^SSL_PATH_ARM=/s,=.*,=$(SSL_LOCATION)/$(SSL_DEFAULT_DIR),' -i ../Makefile.config

ssl-init:
	@mkdir -p $(SSL_LOCATION)

ssl_unpack: $(SSL_ARCHIVE)
	@echo Decompressing ssl $(SSL_VERSION) source...
	@tar xf $(SSL_ARCHIVE)
	@touch $@

release: 
	@rm -rf *arm*.tbz2
	@(tar -c --exclude bin --exclude certs --exclude include --exclude man --exclude misc --exclude private --exclude openssl.cnf --exclude engines --exclude pkgconfig --owner root --group root -C $(SSL_LOCATION)/$(SSL_DEFAULT_DIR) . | bzip2 > $(SSL_RELEASE).tbz2 )


ssl-clean:
	@echo Cleaning ssl...
	@rm -rf $(SSL_LOCATION) $(SSL_FOLDER) ssl_unpack   
	@echo ssl cleanup done!

.PHONY: all ssl-clean release
