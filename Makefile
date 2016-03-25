CFLAGS=-ansi -pedantic -Oz -Wall -Wextra -Weverything
LDFLAGS=-lits
CC=clang
SOURCE=main.c
BINARY=np

all: $(BINARY)

$(BINARY): $(SOURCE)
	$(CC) $(CFLAGS) -o $(BINARY) $(LDFLAGS) $(SOURCE)

clean:
	rm ./bd

