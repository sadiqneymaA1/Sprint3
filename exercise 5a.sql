select distinct v1.vendor_id, v1.vendor_name, CONCAT(v1.vendor_contact_first_name, ' ' ,v1.vendor_contact_last_name) as contact_name
From vendors v1
join vendors v2
 on (v1.vendor_id <> v2.vendor_id)
 and (v1.vendor_contact_last_name = v2.vendor_contact_last_name)
 order by contact_name ;

