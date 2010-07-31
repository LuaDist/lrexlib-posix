# Rules for lrexlib

V = 2.5

TRG    = rex_$(REGNAME)
DEFS   = -DREX_OPENLIB=luaopen_$(TRG) -DREX_LIBNAME=\"$(TRG)\"
CFLAGS = $(MYCFLAGS) $(DEFS) $(INC)
TRG_AR = lib$(TRG).a
TRG_SO = $(TRG).so
LD     = ld
LDFLAGS= -shared

all: $(TRG_AR) $(TRG_SO)

$(TRG_AR): $(OBJ)
	$(AR) $@ $^

$(TRG_SO): $(OBJ)
	$(LD) -o $@.$V $(LDFLAGS) $^ $(LIB) $(LIB_LUA)
	ln -fs $@.$V $@

clean:
	rm -f $(OBJ) $(TRG_AR) $(TRG_SO)*

check: all
	LUA_INIT= LUA_PATH=../../test/?.lua lua ../../test/runtest.lua -d. $(REGNAME)
