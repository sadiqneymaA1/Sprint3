priceChild = float(input("What is the price of a child's meal? "))
priceAdult = float(input("What is the price of an adult meal? "))
childrenNum = int(input("How many children are there? "))
adultsNum = int(input("How many adults are there? "))

drinkPrice = float(input("what is the price of a drink? "))
drinkNum = int(input("How many drinks are there? "))

tax = float(input("What is the sales tax rate? "))

feeBeforeTax = priceChild *childrenNum + priceAdult*adultsNum + drinkPrice*drinkNum
salestax = feeBeforeTax * tax/100
total = feeBeforeTax + salestax

print ("Subtotal: $"+ str(feeBeforeTax)) 
print ("Sales Tax: $" +str(salestax))
print ("Total: $" + str(total))


payment = float(input("What is the payment amount? ")) 
change =  payment -total
print ("Change: $" + str('%.2f' % change))