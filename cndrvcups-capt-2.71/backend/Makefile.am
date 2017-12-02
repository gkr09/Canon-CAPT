backenddir = $(libdir)/cups/backend

backend_PROGRAMS = ccp

DESTDIR =

ccp_SOURCES = ccp.c

ccp_LDADD = -lcups -lbuftool

AM_CFLAGS = -O2 -Wall -fPIC

LDFLAGS = -L/$(DESTDIR)/usr/lib -L/usr/lib
