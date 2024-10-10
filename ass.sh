mkdir $1
touch ./$1/$1.s ./$1/makefile


echo -e "
$1: $1.o
	# Remove the old executable if it exists
	rm -f $1
	# Link the $1.o file into an executable in 32-bit mode
	ld -m elf_i386 -o $1 $1.o

$1.o: $1.s
	# Assemble the $1.s file in 32-bit mode
	as --32 -o $1.o $1.s

clean:
	# Remove object file and executable
	rm -f *.o $1
" > ./$1/makefile
