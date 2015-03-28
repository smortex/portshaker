SCRIPTS=	enlightenment \
		gecko \
		github \
		haskell \
		marcuscom_ports \
		marcuscom_ports_stable \
		ports \
		redports \
		xorg

.for script in ${SCRIPTS}
${script}: ${script}.in
	@echo "  GEN    ${script}"
	@sed -e "s|@@PREFIX@@|${PREFIX}|" \
		< ${script}.in \
		> ${script}
.endfor

SCRIPTSDIR=	${ETCDIR}/portshaker.d

clean:
	rm -f ${SCRIPTS}

.include <bsd.prog.mk>
