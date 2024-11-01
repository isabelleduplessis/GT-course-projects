# GT-course-projects
Examples of my code from various projects and assignments completed during my BS Biology/MS Bioinformatics at Georgia Tech.

DNA_seq_python:

Python scripts developed for assignments in a bioinformatics programming course:

kmer_count.py: Takes in a DNA sequence and value for k, outputs number of occurrences of each k-mer. 

Run script: 

	python kmer_counter.py <k> <input FASTA>

Output example:

	Program name:  kmer_count.py
	aaac 	 1
	aaca 	 1
	aagc 	 1
	aatc 	 1
	aatt 	 1
	acaa 	 1
	acca 	 1
	accc 	 1
	acgc 	 1
	acgg 	 1
	acta 	 1
	actt 	 1
	agcg 	 2
	agta 	 1
	atct 	 1
	atgt 	 1
	attg 	 1
	caag 	 1
	caat 	 1
	cagc 	 1
	cagt 	 1
	ccaa 	 1
	ccag 	 1
	cccg 	 1
	ccgt 	 2
	cctt 	 1
	cgac 	 1
	cgcg 	 1
	cgct 	 1
	cggg 	 2
	cggt 	 1
	cgta 	 1
	cgtg 	 1
	cgtt 	 2
	ctac 	 2
	ctcc 	 1
	ctta 	 2
	cttt 	 1
	gaaa 	 1
	gacg 	 1
	gact 	 1
	gcac 	 1
	gcca 	 1
	gcct 	 1
	gcga 	 1
	gcgg 	 2
	gcgt 	 2
	gcta 	 1
	gctt 	 1
	ggca 	 1
	ggcg 	 1
	ggct 	 1
	gggc 	 2
	ggtc 	 1
	gtac 	 2
	gtca 	 1
	gtga 	 1
	gtgc 	 1
	gttc 	 1
	gttg 	 1
	gttt 	 1
	taat 	 1
	tacc 	 2
	tacg 	 1
	tact 	 1
	tatg 	 1
	tcag 	 1
	tccg 	 1
	tcgc 	 1
	tctc 	 1
	tgaa 	 1
	tgac 	 1
	tgcc 	 2
	tgcg 	 1
	tggc 	 1
	tgtt 	 1
	ttaa 	 1
	ttat 	 1
	ttcg 	 1
	ttga 	 1
	ttgc 	 2
	ttgg 	 1
	tttg 	 2

nwAlign.py: Aligns two sequences using the Needleman-Wunsch algorithm. Takes in two fasta files and outputs 

Run script:

	./_nwAlign.py <seq1_nw.fa> <seq2_nw.fa>

Output example:

	tactataccg-t-ag-tgggtt

	| | ***||| | || *||||*|
	t-c-ccgccgctaagcagggtc
	
	Alignment score:  3