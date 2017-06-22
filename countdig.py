n = int(input("enter a no"))
a = 0
c = 0
b = 0
while n > 0:
    a = int(n/10)
    b = int(n%10)
    n=a
    c = c + 1
print("total no of digit",c)
