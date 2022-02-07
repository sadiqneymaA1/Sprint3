SELECT vendor_id ,SUM( invoice_total )
FROM Invoices
GROUP BY vendor_id;