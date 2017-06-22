n = int(input("enter  the no"))
if n < 0:
    print(" its negative no")
else:
    s = 0
    while ( n > 0):
        s = s + n
        n = n - 1
    print("the sum is ",s)
