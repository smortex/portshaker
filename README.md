# portshaker

## Description

The `portshaker` utility maintains a set of *target* ports trees containing
ports provided by *source* ports trees.

A single *target* ports tree can contain ports from any number of *source*
ports trees. If a port is provided by more than one *source* ports tree,
`portshaker` will merge the latest version of this port in the *target* ports
tree.

As `portshaker` can maintain any number of *target* ports tree, it is
particularly handy if you want to use customized ports trees with tinderbox /
poudriere.

## Using postshaker

For install instructions, please refer to the INSTALL file.  After installing,
you will have to configure `portshaker(8)` since it is a toolkit and does nothing
out of the box.  Configuration instructions are provided in the distribution
man pages: `portshaker(8)`, `portshaker.conf(5)` and `portshaker.d(5)`.

IN ORDER TO PRODUCE REPRODUCTIBLE RESULTS, THE `PORTSHAKER(8)` PROGRAM'S FIRST
ACTION WHEN MERGING PORTS IS TO RESET THE DESTINATION PORTS TREE.  AS A
CONSEQUENCE, IF YOU HAVE LOCAL EDITS IN YOUR TARGET PORTS TREE, THEY WILL BE
LOST (AND SO DO ANY OTHER FILE IN THE DIRECTORY, E.G. VCS CONTROL FILES).


Portions of sources of this tools code have been stolen from the following
files from a FreeBSD 7.0-STABLE box:
  - /etc/rc.subr
  - /usr/share/man/man5/rc.conf.5.gz

