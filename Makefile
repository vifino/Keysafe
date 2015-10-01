IDIR =../include
CC=gcc
CFLAGS=-I$(IDIR) -Os
TRG = keysafe

OBJECTDIR=obj

LDIR =../lib

LIBS= -l bcm2835

CFILES = $(wildcard src/*.c)

# List all object files we need to create
_OBJDEPS=$(CFILES:.c=.o)
OBJDEPS=$(_OBJDEPS:./=$(OBJECTDIR)/src)

$(OBJECTDIR)/%.o: %.c $(DEPS)
		$(CC) -c -o $@ $< $(CFLAGS)

all: safe

preenv:
	@if [ ! -d $(OBJECTDIR) ]; then \
		echo mkdir $(OBJECTDIR); \
		mkdir $(OBJECTDIR); \
	fi

safe: preenv $(OBJDEPS) 
	$(CC) -o $(TRG) $(wildcard $(OBJECTDIR)/*.o) -lm $(LIBS)

%.o: %.c
	@echo ------------------------------------------------------------
	@echo Compile c: $<
	@echo ------------------------------------------------------------
	$(dir_guard)
	$(CC) $(CFLAGS) -c $< -o $(patsubst src/%, $(OBJECTDIR)/%, $@)

clean:
	rm -rf $(TRG) $(OBJECTDIR)
.PHONY: clean
