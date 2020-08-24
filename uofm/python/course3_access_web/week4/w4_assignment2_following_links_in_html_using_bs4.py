# To run this, download the BeautifulSoup zip file
# http://www.py4e.com/code3/bs4.zip
# and unzip it in the same directory as this file

import urllib.request, urllib.error
from bs4 import BeautifulSoup
import ssl
import re

# Ignore SSL certificate errors
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Enter URL: ')
count = int(input('Enter count: '))
position = int(input('Enter position: '))
# if len(url) < 1: url = "http://py4e-data.dr-chuck.net/known_by_Teos.html"
if len(url) < 1: url = "http://py4e-data.dr-chuck.net/known_by_Fikret.html"

# html = urllib.request.urlopen(url, context=ctx).read()
# soup = BeautifulSoup(html, 'html.parser')

# Retrieve all of the anchor tags
# tags = soup('a')
# for tag in tags:
#     print(tag.get('href', None))

# repeat this 'count' times
print(url)
for x in range(count):
    html = urllib.request.urlopen(url, context=ctx).read()
    soup = BeautifulSoup(html, "html.parser")
    tags = soup('a')
    # position = 3, means index at position - 1, which is 3-1
    tag = tags[position-1]
    url = tag.get("href", None)
    print(url)

names = re.findall(".*by_(\S*).html", url)
print(names[0])