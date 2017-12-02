filterdir = $(libdir)/cups/filter

filter_PROGRAMS = pstocapt

DESTDIR = 

pstocapt_SOURCES = \
	pstocapt.c paramlist.c paramlist.h

pstocapt_LDADD = -lbuftool -lcups 

AM_CFLAGS = -O2 -Wall -fPIC

LDFLAGS = -L/$(DESTDIR)/usr/lib -L/usr/lib
