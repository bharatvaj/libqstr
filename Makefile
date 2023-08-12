include config.mk

all: libqstr.a

options:
	@echo libqstr build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

test: test.c libqstr.a
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $^

qstr.c.o: qstr.c qstr.h
	$(CC) -o $@ $(CFLAGS) $< -c

libqstr.a: qstr.c.o
	$(AR) cr $@ $<

clean:
	$(RM) libqstr.a qstr.c.o test libqstr-${VERSION}.tar.gz

dist: clean
	$(MKDIR) libqstr-${VERSION}
	cp LICENSE Makefile README config.mk qstr.h qstr.c \
		libqstr-${VERSION}
	tar -cf libqstr-${VERSION}.tar libqstr-${VERSION}
	gzip libqstr-${VERSION}.tar
	$(RM) libqstr-${VERSION}

install: libqstr.a
	$(INSTALL) $< $(DESTDIR)/$(PREFIX)/lib
	$(INSTALL) qstr.h $(DESTDIR)/$(PREFIX)/include

uninstall:
	$(RM) $(DESTDIR)/$(PREFIX)/lib/libqstr.a
	$(RM) $(DESTDIR)/$(PREFIX)/include/qstr.h
