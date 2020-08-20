fname = input("Enter file name: ")
fh = open(fname)
lst = list()
for line in fh:
    pieces = line.split()
    for p in pieces:
        if p not in lst:
            lst.append(p)
lst.sort()
print(lst)