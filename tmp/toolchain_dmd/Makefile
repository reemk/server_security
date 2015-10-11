# $Id: Makefile,v 1.18 2011-11-17 11:16:11 henes Exp $


include config


all: preprocessing binutils gcc postprocessing
	@$(MAKE) -C upx
	@echo
	@echo "********************************************************************************"
	@echo
	@echo All done! Compiler available at `pwd`/tree/bin/$(TARGET)-gcc-$(GCC_VERSION)
	@echo
	@echo "********************************************************************************"


init:
	@mkdir -p src build tree


#
# includes and libs
#
preprocessing: build/preprocessing_done

build/preprocessing_done: $(KERNEL) $(LIBC) $(LIBCDEV) $(LIBEXPATDEV) $(LIBCXX) $(LIBALSADEV) preprocessing.sh
	@$(MAKE) init
	@./preprocessing.sh
	@touch $@


#
# specs file
#
postprocessing: build/postprocessing_done

build/postprocessing_done: $(KERNEL) $(LIBC) $(LIBCDEV) $(LIBEXPATDEV) $(LIBCXX) $(LIBALSADEV) postprocessing.sh
	@$(MAKE) init
	@./postprocessing.sh
	@touch $@


#
# binutils stuff
#
binutils: build/binutils_done

build/binutils_done: binutils-$(BINUTILS_VERSION).tar.bz2
	@$(MAKE) binutils-clean
	@$(MAKE) init
	@$(MAKE) binutils-src binutils-build binutils-install
	@touch $@

binutils-src:
	@mkdir -p src
	@echo Decompressing binutils $(BINUTILS_VERSION) source...
	@tar -xf binutils-$(BINUTILS_VERSION).tar.bz2 -C src

binutils-build:
	@mkdir -p build/binutils
	@echo Configuring binutils $(BINUTILS_VERSION)...
	@(cd build/binutils && ../../src/binutils-$(BINUTILS_VERSION)/configure --target=$(TARGET) --prefix=`pwd`/../../tree --disable-nls --program-transform-name="s/^/$(TARGET)-/")
	@echo Compiling binutils $(GCC_VERSION)...
	@$(MAKE) -C build/binutils

binutils-install:
	@mkdir -p tree
	@$(MAKE) -C build/binutils install

binutils-clean:
	@echo Cleaning binutils...
	@rm -rf build/binutils_done build/binutils src/binutils-$(BINUTILS_VERSION)


#
# gcc stuff
#
gcc: build/gcc_done

build/gcc_done: gcc-core-$(GCC_VERSION).tar.bz2 protector-$(PROTECTOR_VERSION).tar.gz gcc-$(GCC_VERSION).diff gcc-g++-$(GCC_VERSION).tar.bz2
	@$(MAKE) gcc-clean
	@$(MAKE) init
	@$(MAKE) gcc-src gcc-build gcc-install
	@touch $@

gcc-src:
	@mkdir -p src
	@echo Decompressing GCC $(GCC_VERSION) core source...
	@tar -xf gcc-core-$(GCC_VERSION).tar.bz2 -C src
	@echo Decompressing GCC $(GCC_VERSION) g++ source...
	@tar -xf gcc-g++-$(GCC_VERSION).tar.bz2 -C src
	@echo Decompressing protector $(PROTECTTOR_VERSION) source...
	@tar -xf protector-$(PROTECTOR_VERSION).tar.gz -C src/gcc-$(GCC_VERSION)
	@echo Patching GCC source...
	@(cd src/gcc-$(GCC_VERSION) && patch -p0 <gcc_3_4_4.dif)
	@if [ -e gcc-$(GCC_VERSION).diff ]; then patch -p0 <gcc-$(GCC_VERSION).diff; fi

gcc-build:
	@mkdir -p build/gcc
	@echo Configuring GCC $(GCC_VERSION)...
	@(cd build/gcc && ../../src/gcc-$(GCC_VERSION)/configure --enable-languages="c,c++" --target=$(TARGET) --prefix=`pwd`/../../tree --disable-nls )
	@echo Compiling GCC $(GCC_VERSION)...
	@(PATH=`pwd`/tree/bin:$(PATH) && $(MAKE) -C build/gcc)

gcc-install:
	@mkdir -p tree
	@(PATH=`pwd`/tree/bin:$(PATH) && $(MAKE) -C build/gcc install)

gcc-clean:
	@echo Cleaning gcc...
	@rm -rf build/gcc_done build/gcc src/gcc-$(GCC_VERSION)


#
# general stuff
#
clean:
	@echo Cleaning SDK...
	@$(MAKE) -C upx clean
	@$(RM) -rf src build tree
	@echo SDK cleaning done!


#
# .PHONY
#
.PHONY: all init preprocessing postprocessing binutils binutils-src binutils-build binutils-install binutils-clean gcc-src gcc-build gcc-install gcc-clean upx-clean clean
