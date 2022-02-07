SELECT vendor_name,sum(payment_total) AS payment 
FROM    Vendors join invoices on  vendors.vendor_id = invoices.vendor_id
GROUP BY vendors.vendor_id
ORDER BY payment DESC