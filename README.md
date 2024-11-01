# GT-course-projects

Examples of my code from various projects and assignments completed during my BS Biology/MS Bioinformatics at Georgia Tech.

## Python Scripts for DNA Seq Analysis

DNA_seq_python: Python scripts developed for assignments in a bioinformatics programming course.

kmer_count.py: Takes in a DNA sequence and value for k, outputs number of occurrences of each k-mer. 

Run script: 

	python kmer_counter.py <k> <input FASTA>
	python kmer_count.py 2 aagcggagtttcggtagatg

Output example:

	Program name:  kmer_count.py
	aa 	 1
	ag 	 3
	at 	 1
	cg 	 2
	ga 	 2
	gc 	 1
	gg 	 2
	gt 	 2
	ta 	 1
	tc 	 1
	tg 	 1
	tt 	 1

nwAlign.py: Aligns two sequences using the Needleman-Wunsch algorithm. Takes in two fasta files and outputs 

Run script:

	./_nwAlign.py <seq1_nw.fa> <seq2_nw.fa>

Output example:

	tactataccg-t-ag-tgggtt
	| | ***||| | || *||||*|
	t-c-ccgccgctaagcagggtc
	Alignment score:  3


## Implementing Relational Database with SQL

database_system_SQL: Relational database system modeling a travel reservations service.

