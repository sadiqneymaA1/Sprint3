import math #for later calculations for finding number of digits

import csv #for dealing with csv

dictionary={} #initialise dictionary


with open("products.csv",'rb') as csv_file:
    csv_reader = csv.reader(csv_file) #get the content of it
    next(csv_reader) #Skip the header row
    for row in csv_reader:
        temp=int(row[0]) #read product# and use it as a key of the dictionary
        mylist=[]
        mylist.append(row[1]) #append Name of Product
        mylist.append(row[4]) #append Price of Product
                
        dictionary[temp]=mylist #Store in the dictioanry  

#loop
while True:
    #promopt the user for input
    print('Please enter a product number: ')

    #check for integer
    try:
          val = int(input())
    except ValueError:
          print("Invalid character in product number")
          continue

    import math
    #find digits
    digits = int(math.log10(val))+1

    #digits less than 5
    if(digits)<5:
        print("Invalid product number: too few digits")
        continue
    #digits greater than 5
    if(digits)>5:
        print("Invalid product number: too many digits")
        continue

    #product exist in dictionary or not
    if val in dictionary:
        print(dictionary[val][0]+', '+dictionary[val][1])
        break
    else:
        print('No such product')
        break