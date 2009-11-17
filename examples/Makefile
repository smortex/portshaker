# $Id$

FILES=		portshaker.conf
FILESDIR_portshaker.conf=	${ETCDIR}

SUBDIR=		portshaker.d

.include <bsd.prog.mk>

beforeinstall:
.if ! exists(${PREFIX}${ETCDIR}/portshaker.d)
	@echo " ,----------------------------( Error )----------------------------."
	@printf " | The %-59s |\n" "'${PREFIX}${ETCDIR}/portshaker.d' directory does not exist."
	@echo " |                                                                 |"
	@echo " | Ensure that portshaker(8) is installed and \$$PREFIX is set      |"
	@echo " | properly, then try again.                                       |"
	@echo " \`-----------------------------------------------------------------'"
	@false
.endif
