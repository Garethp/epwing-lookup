localedir = $(datadir)/locale

LIBEB = $(top_builddir)/eb/libeb.la
LIBEBUTILS = $(top_builddir)/libebutils/libebutils.a

bin_PROGRAMS = ebrefile

ebrefile_SOURCES = ebrefile.c
ebrefile_LDADD = $(LIBEBUTILS) $(LIBEB) $(ZLIBLIBS) $(INTLLIBS) $(ICONVLIBS)
ebrefile_DEPENDENCIES = $(LIBEBUTILS) $(LIBEB) $(ZLIBDEPS) $(INTLDEPS) \
	$(ICONVDEPS)

INCLUDES = -I../libebutils -I$(top_srcdir)/libebutils \
	-I../eb -I$(top_srcdir)/eb $(INTLINCS)
