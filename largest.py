n1 = int(input(""))
n2 = int(input(""))
n3 = int(input(""))
l = n1
if l < n2:
	if n2 > n3:
		l = n2
	else:
		l = n3
elif l < n3:
	if n3 > n2:
		l = n3
	else:
		l = n2
else:
	l = n1
print("Largest of given three numbers is",l,"\n")
