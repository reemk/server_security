include ../Makefile.config
EXEC=foo
SRCS=$(wildcard *.c)
OBJS=$(SRCS:.c=.o)
CFLAGS=-Wall
LDFLAGS=-L$(LIB_DIR_HOST)

all : $(EXEC)

$(EXEC):$(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)

$(OBJS):$(SRCS)
	$(CC) $(CLAGS) -c $<