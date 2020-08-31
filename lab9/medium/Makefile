# Makefile generated at Tue  4 Aug 17:14:46 AEST 2020

CC = gcc
CFLAGS = -Wall -g

main:	a.o aaa.o b.o bb.o c.o main.o
	$(CC) $(CFLAGS) -o $@ a.o aaa.o b.o bb.o c.o main.o

a.o: a.h common.h stdio.h a.c
aaa.o: stdio.h aaa.c
b.o: b.h stdio.h b.c
bb.o: bb.h stdio.h bb.c
c.o: ctype.h c.h stdio.h stdlib.h c.c
main.o: stdio.h c.h a.h b.h main.c
