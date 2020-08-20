name = input("Enter file:")
if len(name) < 1 : name = "mbox_short.txt"

handle = open(name)
counts = dict()
for line in handle:
    if not line.startswith("From ") :
        continue
    pieces = line.split()
    counts[pieces[1]] = counts.get(pieces[1], 0) + 1

#print(counts)
max = 0
maxkey = None
for key in counts:
    #print(key)
    #if maxkey == None:
    #    maxkey = key
    #    max = counts[key]
    #    continue

    val = counts[key]
    if (val > max):
        max = val
        maxkey = key

print(maxkey, max)