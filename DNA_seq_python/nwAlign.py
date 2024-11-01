#!/usr/bin/env python3
import sys

# initialization
file1 = open(sys.argv[1], "r")
file2 = open(sys.argv[2], "r")


seqa = file1.read()
seqb = file2.read()

file1.close()
file2.close()

rows = len(seqb)
cols = len(seqa)

matrix = [[0 for i in range(cols + 1)] for j in range(rows + 1)]
for i in range(0, cols + 1):
    matrix[0][i] = -i
for j in range(0, rows + 1):
    matrix[j][0] = -j

# matrix filling
rownum = 0
for row in matrix[1:]:
    rownum += 1
    indexnum = 0
    for index in row[1:]:
        indexnum += 1
        if seqb[rownum - 1] == seqa[indexnum - 1]:
            matrix[rownum][indexnum] = matrix[rownum - 1][indexnum - 1] + 1
        else:
            diagonal = matrix[rownum - 1][indexnum - 1] - 1
            up = matrix[rownum - 1][indexnum] - 1
            left = matrix[rownum][indexnum - 1] - 1
            matrix[rownum][indexnum] = max(diagonal, up, left)


# locate backtracking path recursively

rowlist = [rows]
collist = [cols]


def backtrack(lastrow, lastcol):
    match = seqa[lastcol - 1] == seqb[lastrow - 1]
    if lastrow == 0 or lastcol == 0:
        return 0
    else:
        backdiag = matrix[lastrow - 1][lastcol - 1]
        backup = matrix[lastrow - 1][lastcol]
        backleft = matrix[lastrow][lastcol - 1]
        score = max(backdiag, backup, backleft)
        if match or score == backdiag:
            rowlist.append(lastrow - 1)
            collist.append(lastcol - 1)
            return backtrack(lastrow - 1, lastcol - 1)
        if score == backup:
            rowlist.append(lastrow - 1)
            collist.append(lastcol)
            return backtrack(lastrow - 1, lastcol)
        else:
            rowlist.append(lastrow)
            collist.append(lastcol - 1)
            return backtrack(lastrow, lastcol - 1)

backtrack(rows, cols)

# use backtracking numbers to find alignments

collist.reverse()
rowlist.reverse()

seqa_aligned = []
seqb_aligned = []

for i in range(1, len(collist)):
    if collist[i] == collist[i-1]:
        seqa_aligned.append("-")
    else:
        seqa_aligned.append(seqa[collist[i-1]])

for j in range(1, len(rowlist)):
    if rowlist[j] == rowlist[j-1]:
        seqb_aligned.append("-")
    else:
        seqb_aligned.append(seqb[rowlist[j-1]])

# format output

astring = "".join(seqa_aligned)
bstring = "".join(seqb_aligned)

x = []
for i in range(0, len(astring)):
    if astring[i] == bstring[i]:
        x.append("|")
    elif astring[i] == "-" or bstring[i] == "-":
        x.append(" ")
    else:
        x.append("*")

cstring = "".join(x)

print(bstring)
print(cstring)
print(astring)


# determine alignment score
final_score = 0
for i in cstring:
    if i == "|":
        final_score += 1
    else:
        final_score -= 1
print("Alignment score: ", final_score)