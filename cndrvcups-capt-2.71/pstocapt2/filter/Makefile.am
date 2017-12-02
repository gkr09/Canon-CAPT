filterdir = $(libdir)/cups/filter

filter_PROGRAMS = pstocapt2

DESTDIR =

pstocapt2_SOURCES = \
	pstocapt2.c paramlist.c paramlist.h

pstocapt2_LDADD = -lbuftool -lcups 

AM_CFLAGS = -O2 -Wall -fPIC

LDFLAGS = -L/$(DESTDIR)/usr/lib -L/usr/lib
