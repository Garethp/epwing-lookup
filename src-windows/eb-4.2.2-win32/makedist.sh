#! /bin/sh
#
# Make a source distribution package.
#
VERSION="4.2.2"

rm -f .distfiles
sed -e 's/^    //' > .distfiles <<__END__
    COPYING.txt
    README.txt
    README-ja.txt
    makedist.sh
    makedist.sh.in
    eb.iss
    eb.iss.in
    eb.sln
    eb.vcproj
    ebfont.vcproj
    ebinfo.vcproj
    ebrefile.vcproj
    ebstopcode.vcproj
    ebutils.vcproj
    ebzip.vcproj
    intl.vcproj
    iconv.vcproj
    zlib.vcproj
    iconv/iconv.c
    iconv/iconv.def
    iconv/iconv.h
    iconv/libcharset.c
    iconv/libcharset.h
    intl/gettext.c
    intl/gettext_dummy.c
    intl/intl.def
    intl/libintl.h
    intl/libintl_local.h
    intl/pathnames.h
    intl/strlcat.c
    intl/strlcpy.c
    intl/strsep.c
    intl/textdomain.c
    po/eb.mo
    po/eb.po
    po/ebutils.mo
    po/ebutils.po
    portsrc/arpa/inet.h
    portsrc/build-post.h
    portsrc/config.h
    portsrc/config.h.in
    portsrc/dirent.c
    portsrc/dirent.h
    portsrc/eb.def
    portsrc/eb.rc
    portsrc/eb.rc.in
    portsrc/eb/sysdefs.h
    portsrc/eb/sysdefs.h.in
    portsrc/ebutils.h
    portsrc/localedir.c
    portsrc/netdb.h
    portsrc/netinet/in.h
    portsrc/sys/socket.h
    portsrc/sys/time.h
    portsrc/unistd.h
    portsrc/utime.h
    doc/*.html
    doc/*.css
__END__

rm -rf eb-$VERSION-win32
rm -f eb-$VERSION-win32.zip
mkdir eb-$VERSION-win32

echo "Creating: eb-$VERSION-win32.zip"

cat .distfiles | while read I; do
    for J in $I; do
	[ -f $J ] || continue
	[ -f eb-$VERSION-win32/$J ] && continue
	DIR="`dirname $J`"
	mkdir -p eb-$VERSION-win32/$DIR > /dev/null
	cp $J eb-$VERSION-win32/$J
    done
done

zip -9 -q -r eb-$VERSION-win32.zip eb-$VERSION-win32
rm -rf eb-$VERSION-win32 .distfiles
