#!/bin/bash

if [ $# -eq 0 ];
then

	for file in $(ls traces/)
	do
		./sdriver.pl -t ./traces/$file -s ./tshref > ./test_output/tshref/tshref_$file
		./sdriver.pl -t ./traces/$file -s ./tsh > ./test_output/tsh/tsh_$file
	done 

	for file in $(ls traces/)
	do
		diff ./test_output/tsh/tsh_$file ./test_output/tshref/tshref_$file > ./test_output/diff/diff_$file
	done

	for file in $(ls ./test_output/diff)
	do
		echo $file " :"
		cat ./test_output/diff/$file 
		echo "-------------------------------------\n"
	done

else

	file="trace$1.txt"
	./sdriver.pl -t ./traces/$file -s ./tshref > ./test_output/tshref/tshref_$file
	./sdriver.pl -t ./traces/$file -s ./tsh > ./test_output/tsh/tsh_$file
	diff ./test_output/tsh/tsh_$file ./test_output/tshref/tshref_$file > ./test_output/diff/diff_$file

	echo "-------------------------------------"
	echo diff_$file " :\n"
	cat ./test_output/diff/diff_$file
	echo "-------------------------------------\n"

fi