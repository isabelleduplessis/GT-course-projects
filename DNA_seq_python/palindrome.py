#!/usr/bin/env python3

# Detect biological palindrome

seq = input("Enter sequence: ")
reverse_seq = seq[::-1]
print(reverse_seq)

# iterate through each character
palindrome = False
for i in range(0, len(seq)):
    if seq[i] == "A":
        if reverse_seq[i] == "T":
            palindrome = True
        else:
            palindrome = False
            break
    if seq[i] == "C":
        if reverse_seq[i] == "G":
            palindrome = True
        else:
            palindrome = False
            break
    if seq[i] == "G":
        if reverse_seq[i] == "C":
            palindrome = True
        else:
            palindrome = False
            break
    if seq[i] == "T":
        if reverse_seq[i] == "A":
            palindrome = True
        else:
            palindrome = False
            break
print(palindrome)