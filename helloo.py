import json
try:
f=open("Lab02.json")
data=f.read().strip()
f.close()
dictionary=json.loads(data)
username = dictionary["username"]
pwds=dictionary["password"]
uname = input('Username: ')
pw=input('Password: ')
found=False
for i in range(len(username)):
if uname==username[i]:
if pw==pwds[i]:
print("You are authenticated!")
found=True
break
if not found:
print("You are not authorized to use the system.")
except FileNotFoundError:
print("Unable to open file Lab02.json.")