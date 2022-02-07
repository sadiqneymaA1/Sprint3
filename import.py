import math
wtire=float(input("Enter the width of the tire in cm (ex 205): "))
atire=float(input("Enter the aspect ratio of the tire (ex 60): "))
dmeater=float(input("Enter the diameter of the tire in inches (ex 15): "))

v=math.pi*wtire*wtire*atire*((wtire*atire)+(2540*dmeater))/10000000
print(round(v,1))
