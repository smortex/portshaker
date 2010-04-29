SCRIPTS=	bsd_sharp \
		bsd_sharp_releng_2_0 \
		bsd_sharp_releng_2_2 \
		bsd_sharp_releng_2_4 \
		freebsd_texlive_2009 \
		freebsd_texlive_releng_2009 \
		freebsd_texlive_ports \
		freebsd_texlive_ports_marcuscom \
		marcuscom_ports \
		marcuscom_ports_stable \
		ports

.for script in ${SCRIPTS}
${script}: ${script.in}
	sed -e "s|@@PREFIX@@|${PREFIX}|" \
		< ${script}.in \
		> ${script}
.endfor

SCRIPTSDIR=	${ETCDIR}/portshaker.d

clean:
	rm -f ${SCRIPTS}

.include <bsd.prog.mk>
