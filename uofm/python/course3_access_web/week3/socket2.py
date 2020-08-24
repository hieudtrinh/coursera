import urllib.request, urllib.error

fh = urllib.request.urlopen("http://data.pr4e.org/intro-short.txt")

for line in fh:
    print(line.decode().strip())
