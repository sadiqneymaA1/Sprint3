SELECT vendor_name,count(invoices.vendor_id) AS vcount,sum(invoice_total)
FROM  invoices
Join Vendors
On invoices.vendor_id = vendors.vendor_id
GROUP BY invoices.vendor_id
ORDER BY vcount DESC