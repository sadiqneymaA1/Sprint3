use ap;
SELECT v.vendor_name,invoice_date,invoice_number, li.invoice_sequence AS li_amount
FROM Vendors v
JOIN Invoices i
ON v.vendor_id=i.vendor_id
JOIN invoice_line_items li
ON i.invoice_id=li.invoice_id 
ORDER BY v.vendor_name,i.invoice_date,invoice_number,li.invoice_sequence;