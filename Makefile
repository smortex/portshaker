# $Id$

SCRIPTS=	portshaker.sh
VERSION=	1.0.10

NO_MANCOMPRESS=
MAN5=		portshaker.conf.5 portshaker.d.5
MAN8=		portshaker.8

FILES=		merge-updating.awk portshaker.conf.sample portshaker.subr
FILESDIR_merge-updating.awk=		${SHAREDIR}/portshaker
FILESDIR_portshaker.conf.sample=	${ETCDIR}
FILESDIR_portshaker.subr=		${SHAREDIR}/portshaker

DISTDIR=	portshaker-${VERSION}
TARBALL=	${DISTDIR}.tar.gz

CLEANFILES+=	portshaker.conf.5 portshaker.d.5 portshaker.8 \
		portshaker.sh portshaker.subr ${TARBALL}

.SUFFIXES:	.5.in .5 .8.in .8 .sh.in .sh .subr.in .subr

.5.in.5 .8.in.8 .sh.in.sh .subr.in.subr:
	@echo "  GEN    ${.TARGET}"
	@sed -e "s|@@PREFIX@@|${PREFIX}|" \
		-e "s|@@ETCDIR@@|${ETCDIR}|" \
		-e "s|@@SHAREDIR@@|${SHAREDIR}|" \
		-e "s|@@VERSION@@|${VERSION}|" \
		< ${.IMPSRC} \
		> ${.TARGET}

beforeinstall:
	if [ ! -d "${DESTDIR}${SHAREDIR}/portshaker" ]; then mkdir -p "${DESTDIR}${SHAREDIR}/portshaker"; fi
	if [ ! -d "${DESTDIR}${ETCDIR}/portshaker.d" ]; then mkdir -p "${DESTDIR}${ETCDIR}/portshaker.d"; fi

tarball:
	git archive -o ${TARBALL} v${VERSION}

tag:
	git diff-index HEAD
	git tag v${VERSION}

.include "Makefile.inc"
.include <bsd.prog.mk>
