SELECT * 
from Vendors 
INNER JOIN Invoices 
ON Vendors.Vendor_ID=Invoices.Vendor_ID;