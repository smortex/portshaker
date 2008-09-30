#!/bin/sh
# $Id$

. /usr/local/share/portshaker/portshaker.subr

usage()
{
	echo "usage: $0 [-stv] [ -U | -u ports_tree ] [ -M | -m ports_tree ]" 1>&2
	exit 1
}

args=`getopt Mm:stUu:v $*`
if [ $? -ne 0 ]; then
	usage
fi

_do_update=0
_do_merge=0
_debug_level=0
set -- $args
for i; do
	case "$i" in
		-s)
			echo $(cd ${config_dir}/portshaker.d && ls)
			exit 0
			;;
		-t)
			echo ${ports_trees}
			exit 0
			;;
		-v)
			_debug_level="$(($_debug_level+1))"
			shift
			;;
		-U)	_do_update=1
			_update_ports_trees="$(cd ${config_dir}/portshaker.d && ls)"
			shift
			;;
		-u)	_do_update=1
			_update_ports_trees="${_update_ports_trees} $2"; shift
			shift
			;;
		-M)	_do_merge=1
			_merge_ports_trees="${ports_trees}"
			shift
			;;
		-m)	_do_merge=1
			_merge_ports_trees="${_merge_ports_trees} $2"; shift
			shift
			;;
		--)	shift
			break
			;;
	esac
done

if [ $# -gt 0 ]; then
	usage
fi

if [ -z "${_update_ports_trees}${_merge_ports_trees}" ]; then
	# Assume -UM when no option is provided
	_do_update=1
	_update_ports_trees="$(cd ${config_dir}/portshaker.d && ls)"
	_do_merge=1
	_merge_ports_trees="${ports_trees}"
fi

if [ ${_debug_level} -gt 0 ]; then
	export portshaker_info="YES"
	if [ ${_debug_level} -gt 1 ]; then
		export portshaker_debug="YES"
	fi
fi

if [ "${_do_update}" -eq 1 ]; then
	for _ports_tree in ${_update_ports_trees}; do
		if [ ! -x "${config_dir}/portshaker.d/${_ports_tree}" ]; then
			err 1 "'${config_dir}/portshaker.d/${_ports_tree}' is not executable."
		fi
		${config_dir}/portshaker.d/${_ports_tree} update
		if [ $? -ne 0 ]; then
			err 1 "Failed to update the '${_ports_tree}' ports tree."
		fi
	done
fi

if [ "${_do_merge}" -eq 1 ]; then
	for _ports_tree in ${_merge_ports_trees}; do
		_target=`eval echo \\\$${_ports_tree}_ports_tree`
		_merge_from=`eval echo \\\$${_ports_tree}_merge_from`
		_first=1
		for _source in ${_merge_from}; do
			if [ ! -x "${config_dir}/portshaker.d/${_source}" ]; then
				err 1 "'${config_dir}/portshaker.d/${_source}' is not executable."
			fi
			if [ "${_first}" -eq 1 ]; then
				${config_dir}/portshaker.d/${_source} clone_to -t ${_target} || exit 1
				_first=0
			else
				${config_dir}/portshaker.d/${_source} merge_to -t ${_target} || exit 1
			fi
		done
	done
fi

exit 0
