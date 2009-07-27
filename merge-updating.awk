BEGIN {
	if ((in1 == "") || (in2 == "") || (out == "")) {
		print "Error: in1, in2 and out shall be defined. Exiting."
		exit 1
	}
	# Make dates directly accessible
	FS=":"

	# Copy the first file lines up to the first entry
	# (The reason why the UPDATING file exists).
	x = getline < in1
	while (( $0 !~ /^[0-9]+:$/) && (x == 1)) {
		print $0 > out
		x = getline < in1
	}
	trigger_date = $1

	# Read the second file up to the first entry.
	y = getline < in2
	while (( $0 !~ /^[0-9]+:$/) && ( y == 1 ))  {
		y = getline < in2
	}
	date = $1

	# While we are not at EOF of both files, copy entries, from the newest
	# to the oldest.
	while ((x != 0) || (y != 0)) {
		if (date > trigger_date) {
			print date ":" > out
			y = getline < in2
			while (( $0 !~ /^[0-9]+:$/) && (y == 1)) {
				print $0 > out
				y = getline < in2
			}
			if (y == 1) {
				date = $1
			} else {
				date = 0
			}
		} else {
			print trigger_date ":" > out
			x = getline < in1
			while (( $0 !~ /^[0-9]+:$/) && (x == 1)) {
				print $0 > out
				x = getline < in1
			}
			if (x == 1) {
				trigger_date = $1
			} else {
				trigger_date = 0
			}
		}
	}

}
