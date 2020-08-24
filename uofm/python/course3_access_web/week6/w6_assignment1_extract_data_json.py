import json
import urllib.request

# Sample data: http://py4e-data.dr-chuck.net/comments_42.json (Sum=2553)
# Actual data: http://py4e-data.dr-chuck.net/comments_911247.json (Sum ends with 86)

# Enter location: http://py4e-data.dr-chuck.net/comments_42.json
# Retrieving http://py4e-data.dr-chuck.net/comments_42.json
# Retrieved 2733 characters
# Count: 50
# Sum: 2...

url = input("Enter url - ")
if len(url) < 1 : url = "http://py4e-data.dr-chuck.net/comments_42.json"

print("Retrieving ", url)
data = urllib.request.urlopen(url).read()
info = json.loads(data)

total = 0
counts = 0
for item in info["comments"]:
    #print('Name', item['name'])
    #print('Count', item['count'])
    total += int(item['count'])
    counts += 1

print("Count ", counts)
print("Sum ", total)
