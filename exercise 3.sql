SELECT g.account_number, account_description, invoice_id
FROM general_ledger_accounts AS g 
Left OUTER JOIN invoice_line_items AS i ON  g.account_number = i.account_number
WHERE invoice_id is NULL
order by g.account_number;
