import urllib.request, urllib.error
from bs4 import BeautifulSoup
import ssl

# Scraping Numbers from HTML using BeautifulSoup
# sample data: "http://py4e-data.dr-chuck.net/comments_42.html"
# acutal data: http://py4e-data.dr-chuck.net/comments_911244.html"

# Ignore SSL certificate errors
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Enter - ')
if len(url) < 1: url = "http://py4e-data.dr-chuck.net/comments_42.html"

# url = "http://py4e-data.dr-chuck.net/comments_911244.html"
html = urllib.request.urlopen(url, context=ctx).read()
soup = BeautifulSoup(html, "html.parser")

# Retrieve all of the anchor tags
tags = soup('span')
total = 0
count = 0
for tag in tags:
    # Look at the parts of a tag
    for n in tag.contents:
        total = total + int(n)
        count += 1

print("Count ",  count)
print("Sum ", total)
