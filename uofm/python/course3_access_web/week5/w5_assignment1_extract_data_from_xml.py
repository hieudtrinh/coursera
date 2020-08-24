import urllib.request
import xml.etree.ElementTree as ET

# sample: http://py4e-data.dr-chuck.net/comments_42.xml
# actual: http://py4e-data.dr-chuck.net/comments_911246.xml
url = input("Enter location: ")
if len(url) < 1: url = 'http://py4e-data.dr-chuck.net/comments_42.xml'
print("Retrieving ", url)
output = urllib.request.urlopen(url).read()
print("Retrieved ", len(output), " characters")
tree = ET.fromstring(output)

total = 0
counts = 0
for count in tree.findall('.//count'):
    total += int(count.text)
    counts += 1

print("Count: ", counts)
print("Sum: ", total)
