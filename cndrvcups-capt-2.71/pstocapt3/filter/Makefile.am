filterdir = $(libdir)/cups/filter

filter_PROGRAMS = pstocapt3

pstocapt3_SOURCES = \
	pstocapt3.c paramlist.c paramlist.h

DESTDIR =

pstocapt3_LDADD = -lbuftool -lcups 

AM_CFLAGS = -O2 -Wall -fPIC

LDFLAGS = -L/$(DESTDIR)/usr/lib -L/usr/lib
