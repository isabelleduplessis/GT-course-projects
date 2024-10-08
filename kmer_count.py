#!/usr/bin/env python3

import sys
print("Program name: ", sys.argv[0])
k = sys.argv[1]
fasta_seq = sys.argv[2]


# kmer counter
# read in FASTA file and assign to variable
#fasta_seq = "AACTACGCGACTGTCTATCGTACGTACTGCTGCTG"
# read in value of k and assign to variable
k = 3
# count number of times each kmer is observed
# figure out how to come up with kmers to look for based on number
kmer_list = []
for i in range(0, len(fasta_seq)-(k-1)):
    temp_str = fasta_seq[i]
    count = 0
    for j in range(1, k):
        count += 1
        temp_str = temp_str + fasta_seq[i+count]
    if temp_str not in kmer_list:
        kmer_list.append(temp_str)
kmer_list.sort()
for seq in kmer_list:
    print(seq, "\t", fasta_seq.count(seq))



