-- 1. ยอดเงินรวมของแต่ละลูกค้า --
select c.first_name , c.last_name , sum(balance) as total_balance
from customer c 
	join account a on (c.idcustomer = a.customer_idcustomer)
group by c.first_name , c.last_name;

-- 2. ดึงพนักงานที่ทำธุรกรรมมากที่สุด --
select e.first_name , e.last_name , count(t.employees_idemployees) as num_transactions
from employees e
	join transactions t on (e.idemployees = t.employees_idemployees)
group by e.first_name , e.last_name 
order by num_transactions desc
limit 1;

-- 3. ดึงลูกค้าที่มีบัญชีหลายประเภท (saving + current) --
select c.first_name , c.last_name
from customer c
	join account a on (c.idcustomer = a.customer_idcustomer)
where a.account_type in('saving' , 'current')
group by c.first_name , c.last_name
having count(distinct a.account_type) = 2;

-- 4. แสดงรายงานที่สถานะเป็น pending --
select idreport, status, note, auditors_idauditors , transaction_idtransaction
from report
where status = 'pending';

-- 5. ยอดเงินรวม + จำนวนบัญชี + จำนวน transaction ของลูกค้าแต่ละคน --
select c.idcustomer, c.first_name, c.last_name, 
	count(distinct a.idaccount) as num_accounts,
    count(distinct t.idtransactions) as num_transactions,
    sum(a.balance) as total_balance
from customer c
	left join account a on (c.idcustomer = a.customer_idcustomer)
    left join transactions t on (a.idaccount = t.account_idaccount)
group by c.idcustomer, c.first_name, c.last_name
order by total_balance desc;

-- 6. พนักงานที่ไม่เคยทำ transaction เลย --
select e.idemployees , e.first_name , e.last_name
from employees e
	left join transactions t on (e.idemployees = t.employees_idemployees)
where t.idtransactions is null;

-- 7. แสดงชื่อพนักงานที่มีการทำธุรกรรมเกิน 50 ครั้ง --
select e.idemployees, e.first_name, e.last_name, count(t.idtransactions) as total_tx
from employees e
	join transactions t on (e.idemployees = t.employees_idemployees)
group by e.idemployees, e.first_name, e.last_name
having count(t.idtransactions) > 50;

-- 8. หาลูกค้าที่มียอดเงินรวมในทุกบัญชีสูงที่สุด 5 อันดับแรก --
select c.idcustomer, c.first_name, c.last_name, SUM(a.balance) AS total_balance
from customer c
	join account a on c.idcustomer = a.customer_idcustomer
group by c.idcustomer, c.first_name, c.last_name
order by total_balance desc
limit 5;

-- 9. แสดงประเภทบัญชี (saving/current) พร้อมยอดเงินเฉลี่ยของแต่ละประเภท --
select account_type, avg(balance) as avg_balance
from account
group by account_type;

-- 10. แสดงชื่อ + ยอดเงิน ของลูกค้าที่มียอดเงินมากกว่า 90,000 บาท ในบัญชีอย่างน้อย 1 บัญชี --
select distinct c.first_name, c.last_name , a.balance
from customer c
	join account a on (c.idcustomer = a.customer_idcustomer)
where a.balance > 90000;

