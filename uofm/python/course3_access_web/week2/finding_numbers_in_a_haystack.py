import re
fname = input("Enter file: ")
if len(fname) < 1 : fname = "regex_sum_42.txt"
fh = open(fname)

total = 0
for line in fh:
    line = line.rstrip()
    stuff = re.findall("([0-9]+)", line)
    if len(stuff) <= 0: continue
    for n in stuff:
        num = int(n)
        total += num

print(total)