# Makefile for all tools in this folder


all: ssh-board

ssh-board: zlib-board ssl-board
	@$(MAKE) -C ssh-tool

zlib-board:
	@$(MAKE) -C zlib-tool

ssl-board:
	@$(MAKE) -C ssl-tool

clean : ssh-clean zlib-clean ssl-clean

ssh-clean :
	@$(MAKE) -C ssh-tool $@

zlib-clean:
	@$(MAKE) -C zlib-tool $@

ssl-clean:
	@$(MAKE) -C ssl-tool $@

.PHONY: all ssh-board clean