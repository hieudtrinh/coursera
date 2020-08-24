#Python 3:


fname = input("Enter file: ")
if len(fname) < 1 : fname = "regex_sum_42.txt"
fh = open(fname)
data = fh.read()
#print( sum( [ for line in fh: ('[0-9]+',**************************.read()) ] ) )