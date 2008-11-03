# $Id$

FILES=		portshaker.conf
FILESDIR_portshaker.conf=	${ETCDIR}

SUBDIR=		portshaker.d

beforeinstall:
.if ! exists(${DESTDIR}${ETCDIR}/portshaker.d)
	@echo " ,----------------------------( Error )----------------------------."
	@printf " | The %-59s |\n" "'${DESTDIR}${ETCDIR}/portshaker.d' directory does not exist."
	@echo " |                                                                 |"
	@echo " | Ensure that portshaker(8) is installed and \$$DESTDIR is set      |"
	@echo " | properly, then try again.                                       |"
	@echo " \`-----------------------------------------------------------------'"
	@false
.endif

.include <bsd.prog.mk>
