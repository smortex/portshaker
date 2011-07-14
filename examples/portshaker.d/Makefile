SCRIPTS=	bsd_sharp \
		bsd_sharp_releng_2_0 \
		bsd_sharp_releng_2_2 \
		bsd_sharp_releng_2_4 \
		enlightenment \
		freebsd_texlive \
		freebsd_texlive_releng \
		freebsd_texlive_ports \
		freebsd_texlive_ports_marcuscom \
		haskell \
		marcuscom_ports \
		marcuscom_ports_stable \
		ports

.for script in ${SCRIPTS}
${script}: ${script.in}
	@echo "  GEN    ${script}"
	@sed -e "s|@@PREFIX@@|${PREFIX}|" \
		< ${script}.in \
		> ${script}
.endfor

SCRIPTSDIR=	${ETCDIR}/portshaker.d

clean:
	rm -f ${SCRIPTS}

.include <bsd.prog.mk>
