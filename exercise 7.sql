SELECT vendor_name, default_account_number AS default_account, account_description AS description
FROM vendors 
JOIN general_ledger_accounts ON vendors.default_account_number = general_ledger_accounts.account_number
ORDER BY account_description, vendor_name ;