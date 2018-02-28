CC=gcc
CFLAGS=-Wall -Wextra -ansi -Wwrite-strings -Wstrict-prototypes\
 -Wno-self-assign -Wuninitialized -Wunreachable-code          \
 -Wno-unused-parameter -I..\SDL2-2.0.7\i686-w64-mingw32\include
LDFLAGS=-L..\SDL2-2.0.7\i686-w64-mingw32\lib -lmingw32 -lSDL2main -lSDL2
SRC      = $(wildcard src/*.c)
OBJ      = $(SRC:src/%.c=obj/%.o)
EXECUTABLE_NAME=demin
OUT_DIR=bin\\

ifeq ($(DEBUG),no)
CFLAGS+= -O
else
CFLAGS+= -ggdb -O0
LDFLAGS+= -DDEBUG
EXECUTABLE_NAME:=$(EXECUTABLE_NAME).debug
endif

all: $(OBJ)
	$(CC) -o $(OUT_DIR)$(EXECUTABLE_NAME).exe $^ $(CFLAGS) $(LDFLAGS)

indent: $(wildcard src/*.c) $(wildcard src/*.h)
	c:\msys64\mingw64\bin\indent.exe $^ -bli0 -ppi2 -l79 -lc79 -npsl -bbb -bls -blf -ts2 -nce -bl -npcs -di25

#/C/msys64/mingw64/bin/indent.exe $^ -bli0 -ppi2 -l79 -lc79 -npsl -bbb -bls -blf -ts2 -nce -bl -npcs -di25

test: $(wildcard test/*.c:test/%.c=obj/%.o)

obj/%.o: src/%.c
	$(CC) -c $< -o $@ $(CFLAGS) $(LDFLAGS)

clean:
	del obj\*.o src\*~

distclean: clean
	del  bin\*.exe