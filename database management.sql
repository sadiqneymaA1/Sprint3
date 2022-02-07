Step 1
select distinct 
m.member_id
from member m
Join contact c
on c.member_id = m.member_id
Where last_name = 'Sweeney';

Step 2
select last_name, account_number, credit_card_number
from member m
join contact c
on c.member_id = m.member_id
Where last_name = 'Sweeney';

Step 3
select distinct last_name, account_number,credit_card_number
from member m
join contact c
on c.member_id = m.member_id
Where last_name = 'Sweeney';

Step 4
select last_name,account_number,credit_card_number, city|| ', ' || state_province ||' '|| postal_code as address
from member m
join contact c
on c.member_id = m.member_id
join address a
on c.contact_id = a.contact_id
WHERE UPPER(c.last_name) like UPPER('Vizquel%');


Step 5
SELECT DISTINCT c.last_name, m.account_number, m.credit_card_number, sa.street_address || CHR(10)||a.city || ',' || a.state_province || ' ' || a.postal_code as address
FROM member m
JOIN contact c
On m.member_id = c.member_id
Join address a
On c.contact_id = a.contact_id
JOIN street_address sa
ON a.contact_id = sa.street_address_id
WHERE UPPER(c.last_name) like UPPER('Vizquel%');

Step 6
SELECT DISTINCT c.last_name, m.account_number, sa.street_address || CHR(10)||a.city || ',' || a.state_province || ' ' || a.postal_code AS address 
,'('||t.area_code||')'|| ' ' || t.telephone_number AS telephone 
FROM member m
JOIN contact c
On m.member_id = c.member_id
JOIN address a
ON c.contact_id = a.contact_id
JOIN street_address sa
ON a.contact_id = sa.street_address_id
JOIN telephone t
ON sa.street_address_id = t.telephone_id
WHERE UPPER(c.last_name) like UPPER('Vizquel%');

Step 7
SELECT DISTINCT c.last_name, m.account_number, sa.street_address || CHR(10)|| a.city || ', '  || a.state_province || ' ' || a.postal_code AS address ,'('||t.area_code||') '|| t.telephone_number AS telephone 
FROM member m
JOIN contact c
On m.member_id = c.member_id
Join address a
On c.contact_id = a.contact_id
Join street_address sa
ON a.contact_id = sa.street_address_id
JOIN telephone t
ON sa.street_address_id = t.telephone_id;

Step 8
SELECT DISTINCT c.last_name, m.account_number, sa.street_address || CHR(10)||a.city || ',' || a.state_province || ' ' || a.postal_code AS address ,'('||t.area_code||')'|| ' ' || t.telephone_number AS telephone 
FROM member m
JOIN contact c
on m.member_id = c.member_id
JOIN address a
ON c.contact_id = a.contact_id
JOIN street_address sa
ON a.contact_id = sa.street_address_id
JOIN telephone t
ON sa.street_address_id = t.telephone_id
JOIN rental r
ON c.contact_id = r.rental_id


Step 9
SELECT DISTINCT c.last_name, m.account_number, sa.street_address || CHR(10)||a.city || ',' || a.state_province || ' ' || a.postal_code AS address ,'('||t.area_code||')'|| ' ' || t.telephone_number AS telephone 
FROM member m
JOIN contact c
on m.member_id = c.member_id
JOIN address a
ON c.contact_id = a.contact_id
JOIN street_address sa
ON a.contact_id = sa.street_address_id
JOIN telephone t
ON sa.street_address_id = t.telephone_id
JOIN rental r
on c.contact_id = r.rental_id




Step 10
SELECT last_name || ',' || first_name AS last_name, m.account_number,'('||t.area_code||')'|| ' ' || t.telephone_number || CHR(10) ||
sa.street_address || CHR(10)|| a.city || ',' || a.state_province ||' ' || a.postal_code AS address
, item_title
from member m
join contact c
on m.member_id = c.member_id
join address a
on c.contact_id = a.contact_id
join street_address sa
On a.contact_id = sa.street_address_id
join telephone t
On c.contact_id = t.telephone_id
left JOIN rental r
on c.contact_id = r.customer_id
join rental_item ri
On r.rental_id = ri.rental_id

step 9
SELECT DISTINCT
contact.last_name, 
member.account_number, 
street_address.street_address || chr(10) || address.city || ',' || address.state_province || ' ' || address.postal_code as c_address,
'(' || t.area_code || ') ' || t.telephone_number as telephone
FROM contact 
INNER JOIN member ON member.member_id = contact.member_id
INNER JOIN address ON address.contact_id = contact.contact_id
INNER JOIN street_address ON street_address.address_id = address.address_id
INNER JOIN telephone t ON t.contact_id = contact.contact_id
LEFT JOIN rental ON contact.contact_id = rental.customer_id
GROUP BY
contact.last_name, 
member.account_number,
street_address.street_address || chr(10) || address.city || ',' || address.state_province || ' ' || address.postal_code,
'(' || t.area_code || ') ' || t.telephone_number
HAVING
COUNT(rental.rental_id) = 0;
