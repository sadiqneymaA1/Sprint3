SELECT vendor_name,i.Invoice_number,i.Invoice_date,(invoice_total - payment_total - credit_total) AS balance_due
 FROM Vendors AS v 
 INNER JOIN Invoices AS i ON v.vendor_id = i.vendor_id
 WHERE (invoice_total - payment_total - credit_total) > 0