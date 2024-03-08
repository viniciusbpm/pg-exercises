// 1

select (surname) || ', ' || (firstname) as name from cd.members

// 2

select * from cd.facilities
where name like 'Tennis%'

// 3

select * from cd.facilities
where upper(name) like upper('Tennis%')

// 4

select memid, telephone from cd.members
where telephone ~ '[()]';          

// 5

select lpad(cast(zipcode as char(5)),5,'0') zip from cd.members order by zip          

// 6

select substr(surname,1,1) as letter, count(substr(surname,1,1)) from cd.members
group by substr(surname,1,1)
order by letter

// 7

select memid, translate(telephone, '-() ', '') as telephone from cd.members
order by memid; 

