# $Id$

SCRIPTS=	portshaker.sh
VERSION=	0.0.8

MAN5=		portshaker.conf.5 portshaker.d.5
MAN8=		portshaker.8

FILES=		portshaker.conf.sample portshaker.subr
FILESDIR_portshaker.conf.sample=	${ETCDIR}
FILESDIR_portshaker.subr=		${SHAREDIR}/portshaker

DISTDIR=	portshaker-${VERSION}
TARBALL=	${DISTDIR}.tar.gz

CLEANFILES+=	ChangeLog portshaker.conf.5 portshaker.d.5 portshaker.8 \
		portshaker.sh portshaker.subr ${TARBALL}

.SUFFIXES:	.5.in .5 .8.in .8 .sh.in .sh .subr.in .subr

.5.in.5 .8.in.8 .sh.in.sh .subr.in.subr:
	sed -e "s|@@DESTDIR@@|${DESTDIR}|" \
		-e "s|@@ETCDIR@@|${DESTDIR}${ETCDIR}|" \
		-e "s|@@SHAREDIR@@|${DESTDIR}${SHAREDIR}|" \
		< ${.IMPSRC} \
		> ${.TARGET}

ChangeLog: .PHONY
	svn log -v --xml -r HEAD:419 https://bsd-sharp.googlecode.com/svn/branches/portshaker | \
		xsltproc --stringparam strip-prefix "branches/portshaker" \
		--stringparam include-rev "yes" svn2cl.xsl - > ChangeLog

beforeinstall:
	if [ ! -d "${DESTDIR}${SHAREDIR}/portshaker" ]; then mkdir -p "${DESTDIR}${SHAREDIR}/portshaker"; fi
	if [ ! -d "${DESTDIR}${ETCDIR}/portshaker.d" ]; then mkdir -p "${DESTDIR}${ETCDIR}/portshaker.d"; fi

tarball: ChangeLog
	svn export . ${DISTDIR}
	cp ChangeLog ${DISTDIR}
	tar zcf ${TARBALL} ${DISTDIR}
	rm -r ${DISTDIR}

.include "Makefile.inc"
.include <bsd.prog.mk>
