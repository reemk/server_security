# Zlib Tool

include ../Makefile.config

PROG=zlib-tools
DATE=`date +%Y-%m-%d`

ZLIB_VERSION=1.2.8
ZLIB_FOLDER=zlib-$(ZLIB_VERSION)
ZLIB_ARCHIVE=$(ZLIB_FOLDER).tar.gz
ZLIB_LOCATION=$(RELEASEDIR)/zlib-package
ZLIB_RELEASE=$(ZLIB_FOLDER)-arm-$(DATE)

all: $(PROG) release

$(PROG): zlib-build  

zlib-build: zlib-init zlib_unpack
	@echo Compiling zlib $(ZLIB_VERSION) source...
	@$(MAKE) -C $(ZLIB_FOLDER)
	@$(MAKE) -C $(ZLIB_FOLDER) install
	@$(STRIP) --strip-unneeded $(ZLIB_LOCATION)/lib/*.$(ZLIB_VERSION)
	@sed -e '/^ZLIB_PATH_ARM=/s,=.*,=$(ZLIB_LOCATION),' -i ../Makefile.config

zlib-init:
	@mkdir -p $(ZLIB_LOCATION)

zlib_unpack: $(ZLIB_ARCHIVE)
	@echo Decompressing zlib $(ZLIB_VERSION) source...
	@tar xf $(ZLIB_ARCHIVE)
	@(cd $(ZLIB_FOLDER) && CC=$(CC) LDFLAGS=-L$(LIB_DIR_HOST) ./configure --prefix=$(ZLIB_LOCATION) )
	@touch $@

release: 
	@rm -rf *arm*.tbz2
	@(tar -c --exclude include --exclude share --exclude --libz.a --exclude pkgconfig --owner root --group root -C $(ZLIB_LOCATION) . | bzip2 > $(ZLIB_RELEASE).tbz2 )


zlib-clean:
	@echo Cleaning zlib...
	@rm -rf $(ZLIB_LOCATION) $(ZLIB_FOLDER) zlib_unpack   
	@echo zlib cleanup done!

.PHONY: all zlib-clean release
