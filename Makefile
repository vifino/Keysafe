IDIR =../include
CC=gcc
CFLAGS=-I$(IDIR) -Os
TRG = keysafe

OBJECTDIR=obj
$(shell mkdir -p $(OBJECTDIR)/src)

LDIR =../lib

LIBS=-l bcm2835

PRJSRC = $(wildcard *.c)
CFILES=$(filter %.c, $(PRJSRC))

# List all object files we need to create
_OBJDEPS=$(CFILES:.c=.o)
OBJDEPS=$(_OBJDEPS:./=$(OBJECTDIR)/src)

$(OBJECTDIR)/%.o: %.c $(DEPS)
		$(CC) -c -o $@ $< $(CFLAGS)

all: safe

safe: $(OBJDEPS) 
	$(CC) -o $(TRG) $(wildcard $(OBJECTDIR)/*.o) -lm $(LIBS)

.c.o:
	@echo ------------------------------------------------------------
	@echo Compile c: $<
	@echo ------------------------------------------------------------
	$(dir_guard)
	$(CC) $(CFLAGS) -c $< -o $(OBJECTDIR)/$@ 

.PHONY: clean
