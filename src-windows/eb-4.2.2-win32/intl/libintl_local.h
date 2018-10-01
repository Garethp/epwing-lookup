/*	$NetBSD: libintl_local.h,v 1.5 2001/02/16 07:20:35 minoura Exp $	*/

/*-
 * Copyright (c) 2000, 2001 Citrus Project,
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 * $Citrus: xpg4dl/FreeBSD/lib/libintl/libintl_local.h,v 1.13 2001/09/27 15:18:45 yamt Exp $
 */

#ifndef PATH_MAX
#ifdef MAXPATHLEN
#define PATH_MAX        MAXPATHLEN
#else /* not MAXPATHLEN */
#define PATH_MAX        1024
#endif /* not MAXPATHLEN */
#endif /* not PATH_MAX */

#ifndef HAVE_STRLCPY
extern size_t strlcpy(char *dst, const char *src, size_t siz);
#endif

#ifndef HAVE_STRLCAT
extern size_t strlcat(char *dst, const char *src, size_t siz);
#endif

#ifndef HAVE_STRSEP
extern char *strsep(char **stringp, const char *delim);
#endif

#ifdef WIN32
#define snprintf _snprintf
#endif

#define MO_MAGIC		0x950412de
#define MO_MAGIC_SWAPPED	0xde120495
#define MO_REVISION		0

#define GETTEXT_MMAP_MAX	(1024 * 1024)	/*XXX*/

#define DEFAULT_DOMAINNAME	"messages"

/* *.mo file format */
struct mo {
	unsigned long mo_magic;	/* determines endian */
	unsigned long mo_revision;	/* file format revision: 0 */
	unsigned long mo_nstring;	/* N: number of strings */
	unsigned long mo_otable;	/* O: original text table offset */
	unsigned long mo_ttable;	/* T: translated text table offset */
	unsigned long mo_hsize;	/* S: size of hashing table */
	unsigned long mo_hoffset;	/* H: offset of hashing table */
};

struct moentry {
	unsigned long len;		/* strlen(str), so region will be len + 1 */
	unsigned long off;		/* offset of \0-terminated string */
};

/* libintl internal data format */
struct moentry_h {
	size_t len;		/* strlen(str), so region will be len + 1 */
	char *off;		/* offset of \0-terminated string */
};

struct mo_h {
	unsigned long mo_magic;	/* determines endian */
	unsigned long mo_revision;	/* file format revision: 0 */
	unsigned long mo_nstring;	/* N: number of strings */
	struct moentry_h *mo_otable;	/* O: original text table offset */
	struct moentry_h *mo_ttable;	/* T: translated text table offset */
	const char *mo_header;
	char *mo_charset;
};

struct mohandle {
	void *addr;		/* mmap'ed region */
	size_t len;
	struct mo_h mo;		/* endian-flipped mo file header */
};

struct domainbinding {
	struct domainbinding *next;
	char domainname[PATH_MAX];
	char path[PATH_MAX];
	struct mohandle mohandle;
};

extern struct domainbinding *__bindings;
extern char __current_domainname[PATH_MAX];
