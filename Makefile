CAPT_DIR ?= ${CURDIR}/cndrvcups-capt-2.71
COMMON_DIR ?= ${CURDIR}/cndrvcups-common-3.21
CUPS_DIR ?= /usr/share/cups/model
DESTDIR ?=
MODEL ?=
$(warning ***Canon CAPT Printer Drivers***)
gen:
	$(info **Configuring cndrvcups-common**)
	cd $(COMMON_DIR)/buftool && /usr/bin/autoreconf -fi && ./autogen.sh --prefix=/usr --libdir=/usr/lib
	cd $(COMMON_DIR)/cngplp && /usr/bin/autoreconf -fi && LIBS='-lgmodule-2.0 -lgtk-x11-2.0 -lglib-2.0 -lgobject-2.0' ./autogen.sh --prefix=/usr --libdir=/usr/lib
	cd ${COMMON_DIR}/backend && /usr/bin/autoreconf -fi && ./autogen.sh --prefix=/usr --libdir=/usr/lib

	$(info **Configuring cndrvcups-capt**)
	for dir in driver ppd backend pstocapt pstocapt2 pstocapt3; do \
		cd $(CAPT_DIR)/"$$dir" && /usr/bin/autoreconf -fi && LDFLAGS=-L${pkgdir}/usr/lib CPPFLAGS=-I${pkgdir}/usr/include ./autogen.sh --prefix=/usr --enable-progpath=/usr/bin --disable-static ; \
	done
	cd $(CAPT_DIR)/statusui && /usr/bin/autoreconf -fi && LDFLAGS=-L${pkgdir}/usr/lib LIBS='-lpthread -lgdk-x11-2.0 -lgobject-2.0 -lglib-2.0 -latk-1.0 -lgdk_pixbuf-2.0' CPPFLAGS=-I${pkgdir}/usr/include ./autogen.sh --prefix=/usr --disable-static
	cd $(CAPT_DIR)/cngplp/ && LDFLAGS=-L${pkgdir}/usr/lib /usr/bin/autoreconf -fi && LDFLAGS=-L${pkgdir}/usr/lib CPPFLAGS=-I${pkgdir}/usr/include ./autogen.sh --prefix=/usr --libdir=/usr/lib
	cd $(CAPT_DIR)/cngplp/files && LDFLAGS=-L${pkgdir}/usr/lib /usr/bin/autoreconf -fi && LDFLAGS=-L${pkgdir}/usr/lib CPPFLAGS=-I${pkgdir}/usr/include ./autogen.sh


common:
	echo "BUILDING"
	$(info **Compiling cndrvcups-common**)
	#cd $(COMMON_DIR) && make
	make -C $(COMMON_DIR)
	make -C $(COMMON_DIR)/c3plmod_ipc
	#cd $(COMMON_DIR)/c3plmod_ipc && make
capt:
	#cd $(CAPT_DIR) && make
	make -C $(CAPT_DIR)

install-common:
	echo 'Installing cndrvcups-common'
	for dir in buftool cngplp backend; do \
		cd $(COMMON_DIR)/"$$dir" && make DESTDIR=$(DESTDIR) install; \
	done
	cd $(COMMON_DIR)/c3plmod_ipc && make install DESTDIR=$(DESTDIR) LIBDIR=/usr/lib
	#cd $(COMMON_DIR)
	install -dm755 $(DESTDIR)/usr/bin
	install -c -m 755 $(COMMON_DIR)/libs/c3pldrv $(DESTDIR)/usr/bin
	install -dm755 $(DESTDIR)/usr/lib
	install -c -m 755 $(COMMON_DIR)/libs/libcaiowrap.so.1.0.0 $(DESTDIR)/usr/lib
	install -c -m 755 $(COMMON_DIR)/libs/libcaiousb.so.1.0.0 $(DESTDIR)/usr/lib
	install -c -m 755 $(COMMON_DIR)/libs/libc3pl.so.0.0.1 $(DESTDIR)/usr/lib
	install -c -m 755 $(COMMON_DIR)/libs/libcaepcm.so.1.0 $(DESTDIR)/usr/lib
	install -c -m 755 $(COMMON_DIR)/libs/libColorGear.so.0.0.0 $(DESTDIR)/usr/lib
	install -c -m 755 $(COMMON_DIR)/libs/libColorGearC.so.0.0.0 $(DESTDIR)/usr/lib
	install -c -m 755 $(COMMON_DIR)/libs/libcanon_slim.so.1.0.0 $(DESTDIR)/usr/lib
	install -c -m 755 $(COMMON_DIR)/libs/libcaepcm.so $(DESTDIR)/usr/lib32
	install -c -m 755 $(COMMON_DIR)/libs/libcaepcm.so.1 $(DESTDIR)/usr/lib32
	install -c -m 755 $(COMMON_DIR)/libs/libcaepcm.so.1.0 $(DESTDIR)/usr/lib32
	install -c -m 755 $(COMMON_DIR)/libs/libcaiowrap.so $(DESTDIR)/usr/lib32
	install -c -m 755 $(COMMON_DIR)/libs/libcaiowrap.so.1 $(DESTDIR)/usr/lib32
	install -c -m 755 $(COMMON_DIR)/libs/libcaiowrap.so.1.0.0 $(DESTDIR)/usr/lib32
	install -c -m 755 $(COMMON_DIR)/libs/libcanon_slim.so.1.0.0 $(DESTDIR)/usr/lib32

	echo 'Creating symlinks'
	#cd /usr/lib/ &&
	ln -sf $(DESTDIR)/usr/lib/libc3pl.so.0.0.1 $(DESTDIR)/usr/lib/libc3pl.so.0
	ln -sf $(DESTDIR)/usr/lib/libc3pl.so.0.0.1 $(DESTDIR)/usr/lib/libc3pl.so
	ln -sf $(DESTDIR)/usr/lib/libcaepcm.so.1.0 $(DESTDIR)/usr/lib/libcaepcm.so.1
	ln -sf $(DESTDIR)/usr/lib/libcaepcm.so.1.0 $(DESTDIR)/usr/lib/libcaepcm.so
	ln -sf $(DESTDIR)/usr/lib/libcaiowrap.so.1.0.0 $(DESTDIR)/usr/lib/libcaiowrap.so.1
	ln -sf $(DESTDIR)/usr/lib/libcaiowrap.so.1.0.0 $(DESTDIR)/usr/lib/libcaiowrap.so
	ln -sf $(DESTDIR)/usr/lib/libcaiousb.so.1.0.0 $(DESTDIR)/usr/lib/libcaiousb.so.1
	ln -sf $(DESTDIR)/usr/lib/libcaiousb.so.1.0.0 $(DESTDIR)/usr/lib/libcaiousb.so
	ln -sf $(DESTDIR)/usr/lib/libcanonc3pl.so.1.0.0 $(DESTDIR)/usr/lib/libcanonc3pl.so.1
	ln -sf $(DESTDIR)/usr/lib/libcanonc3pl.so.1.0.0 $(DESTDIR)/usr/lib/libcanonc3pl.so
	ln -sf $(DESTDIR)/usr/lib/libcanon_slim.so.1.0.0 $(DESTDIR)/usr/lib/libcanon_slim.so.1
	ln -sf $(DESTDIR)/usr/lib/libcanon_slim.so.1.0.0 $(DESTDIR)/usr/lib/libcanon_slim.so
	ln -sf $(DESTDIR)/usr/lib/libColorGear.so.0.0.0 $(DESTDIR)/usr/lib/libColorGear.so.0
	ln -sf $(DESTDIR)/usr/lib/libColorGear.so.0.0.0 $(DESTDIR)/usr/lib/libColorGear.so
	ln -sf $(DESTDIR)/usr/lib/libColorGearC.so.0.0.0 $(DESTDIR)/usr/lib/libColorGearC.so.0
	ln -sf $(DESTDIR)/usr/lib/libColorGearC.so.0.0.0 $(DESTDIR)/usr/lib/libColorGearC.so

	install -dm755 $(DESTDIR)/usr/share/caepcm

	cd $(COMMON_DIR) && install -c -m 644 data/*.ICC  $(DESTDIR)/usr/share/caepcm
install-capt:
	echo 'Installing cndrvcups-capt'
	#statusui omitted from below
	for dir in driver ppd backend pstocapt pstocapt2 pstocapt3 cngplp; do \
		cd $(CAPT_DIR)/"$$dir" && make DESTDIR=$(DESTDIR) install; \
	done
	#cd $(CAPT_DIR)/ &&
	install -dm755 $(DESTDIR)/usr/lib
	install -c $(CAPT_DIR)/libs/libcaptfilter.so.1.0.0  $(DESTDIR)/usr/lib
	install -c $(CAPT_DIR)/libs/libcaiocaptnet.so.1.0.0 $(DESTDIR)/usr/lib
	install -c $(CAPT_DIR)/libs/libcncaptnpm.so.2.0.1   $(DESTDIR)/usr/lib
	install -c -m 755 $(CAPT_DIR)/libs/libcnaccm.so.1.0   $(DESTDIR)/usr/lib

	#cd /usr/lib/ &&
	ln -sf $(DESTDIR)/usr/lib/libcaptfilter.so.1.0.0 $(DESTDIR)/usr/lib/libcaptfilter.so.1
	ln -sf $(DESTDIR)/usr/lib/libcaptfilter.so.1.0.0 $(DESTDIR)/usr/lib/libcaptfilter.so
	ln -sf $(DESTDIR)/usr/lib/libcaiocaptnet.so.1.0.0 $(DESTDIR)/usr/lib/libcaiocaptnet.so.1
	ln -sf $(DESTDIR)/usr/lib/libcaiocaptnet.so.1.0.0 $(DESTDIR)/usr/lib/libcaiocaptnet.so
	ln -sf $(DESTDIR)/usr/lib/libcncaptnpm.so.2.0.1 $(DESTDIR)/usr/lib/libcncaptnpm.so.2
	ln -sf $(DESTDIR)/usr/lib/libcncaptnpm.so.2.0.1 $(DESTDIR)/usr/lib/libcncaptnpm.so
	ln -sf $(DESTDIR)/usr/lib/libcnaccm.so.1.0 $(DESTDIR)/usr/lib/libcnaccm.so.1
	ln -sf $(DESTDIR)/usr/lib/libcnaccm.so.1.0 $(DESTDIR)/usr/lib/libcnaccm.so

	install -dm755 $(DESTDIR)/usr/bin

	#cd $(CAPT_DIR)/ &&
	install -c $(CAPT_DIR)/libs/captdrv                 $(DESTDIR)/usr/bin
	install -c $(CAPT_DIR)/libs/captfilter              $(DESTDIR)/usr/bin
	install -c $(CAPT_DIR)/libs/captmon/captmon         $(DESTDIR)/usr/bin
	install -c $(CAPT_DIR)/libs/captmon2/captmon2       $(DESTDIR)/usr/bin
	install -c $(CAPT_DIR)/libs/captemon/captmon*       $(DESTDIR)/usr/bin
	install -c $(CAPT_DIR)/libs64/ccpd                  $(DESTDIR)/usr/sbin
	install -c $(CAPT_DIR)/libs64/ccpdadmin             $(DESTDIR)/usr/sbin

	install -dm755 $(DESTDIR)/etc
	install -c $(CAPT_DIR)/samples/ccpd.conf            $(DESTDIR)/etc
	install -c $(CAPT_DIR)/samples/ccpd            $(DESTDIR)/etc/init.d
	install -dm755 $(DESTDIR)/usr/share/ccpd
	install -dm755 $(DESTDIR)/usr/share/captfilter
	install -c $(CAPT_DIR)/libs/ccpddata/CNA*L.BIN    $(DESTDIR)/usr/share/ccpd
	install -c $(CAPT_DIR)/libs/ccpddata/CNA*LS.BIN    $(DESTDIR)/usr/share/ccpd
	install -c $(CAPT_DIR)/libs/ccpddata/cnab6cl.bin    $(DESTDIR)/usr/share/ccpd
	install -c $(CAPT_DIR)/libs/CnA*INK.DAT $(DESTDIR)/usr/share/captfilter
	install -c $(CAPT_DIR)/libs/captemon/CNAC*.BIN    $(DESTDIR)/usr/share/ccpd
	install -dm755 $(DESTDIR)/usr/share/captmon
	install -c $(CAPT_DIR)/libs/captmon/msgtable.xml    $(DESTDIR)/usr/share/captmon
	install -dm755 $(DESTDIR)/usr/share/captmon2
	install -c $(CAPT_DIR)/libs/captmon2/msgtable2.xml  $(DESTDIR)/usr/share/captmon2
	install -dm755 $(DESTDIR)/usr/share/captemon
	install -c $(CAPT_DIR)/libs/captemon/msgtablelbp*   $(DESTDIR)/usr/share/captemon
	install -c $(CAPT_DIR)/libs/captemon/msgtablecn*    $(DESTDIR)/usr/share/captemon
	install -dm755 $(DESTDIR)/usr/share/caepcm
	install -c -m 644 $(CAPT_DIR)/data/C*   $(DESTDIR)/usr/share/caepcm
	install -dm755 $(DESTDIR)/usr/share/doc/capt-src
	install -c -m 644 $(CAPT_DIR)/*capt*.txt $(DESTDIR)/usr/share/doc/capt-src

	install -dm755 $(DESTDIR)/usr/share/ppd/cupsfilters
	#ln -sf /usr/share/cups/model/CNCUPS$(MODEL)CAPTK.ppd /usr/share/ppd/cupsfilters/CNCUPS$(MODEL)CAPTK.ppd
	cd $(DESTDIR)/usr/share/cups/model && \
	for file in *.ppd; do \
		ln -sf $(notdir "$$file") $(DESTDIR)/usr/share/ppd/cupsfilters/$(notdir "$$file"); \
	done
	install -dm750 -o root -g lp $(DESTDIR)/var/captmon/
	mkdir -p $(DESTDIR)/usr/lib32/i386-linux-gnu/
	install -m755 ${CURDIR}/others/libpopt.so.0.0.0 $(DESTDIR)/usr/lib32/
	install -m755 ${CURDIR}/others/libpopt.so.0 $(DESTDIR)/usr/lib32/
	install -m755 ${CURDIR}/others/captstatusui $(DESTDIR)/usr/bin/

install:gen common install-common capt install-capt
	echo 'FINISHED INSTALLING'