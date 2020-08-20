name = input("Enter file:")
if len(name) < 1: name = "mbox_short.txt"
handle = open(name)
counts = dict()
for line in handle:
    if not line.startswith("From "):
        continue

    pieces = line.rstrip().split()
    times = pieces[5]
    h, m, s = times.split(":")

    counts[h] = counts.get(h, 0) + 1

#sorted_list = sorted(counts.keys())
#for key in sorted_list :
#    print(key, counts.get(key))

for (k,v) in sorted(counts.items()):
    print(k,v)
