// 1 

select b.starttime from cd.bookings b
inner join cd.members m
on b.memid = m.memid
where m.surname = 'Farrell'
and m.firstname = 'David'

// 2

select b.starttime as start, f.name from cd.bookings b
inner join cd.facilities f
on b.facid = f.facid
where date(b.starttime) = '2012-09-21'
and f.name like 'Tennis Court%'
order by b.starttime

// 3

select distinct m2.firstname, m2.surname from cd.members m
inner join cd.members m2
on m2.memid = m.recommendedby
order by m2.surname, m2.firstname

// 4

select m.firstname as memfname, m.surname as memsname, m2.firstname as recfname, m2.surname as recsname 
from cd.members m
left join cd.members m2
on m2.memid = m.recommendedby
order by m.surname, m.firstname

// 5

select distinct (m.firstname || ' ' || m.surname) as member, f.name as facility from cd.members m
inner join cd.bookings b
on b.memid = m.memid
inner join cd.facilities f
on f.facid = b.facid
where f.name like 'Tennis Court%'
order by member, facility

// 6

select (m.firstname || ' ' || m.surname) as member, f.name as facility, (
case
when m.memid = 0
then f.guestcost * b.slots
else f.membercost * b.slots
end) as cost from cd.members m
inner join cd.bookings b
on b.memid = m.memid
inner join cd.facilities f
on f.facid = b.facid
where b.starttime >= '2012-09-14' and 
b.starttime < '2012-09-15' and (
(m.memid = 0 and b.slots * f.guestcost > 30) or
(m.memid != 0 and b.slots * f.membercost > 30)
)
order by cost desc


// 7

select distinct(m.firstname || ' ' || m.surname) as member, 
(select (m2.firstname || ' ' || m2.surname) from cd.members m2 where m2.memid = m.recommendedby) as recommender
from cd.members m
order by member

// 8

select member, facility, cost from (
select 
m.firstname || ' ' || m.surname as member,
f.name as facility,
case
when m.memid = 0 then
b.slots*f.guestcost
else
b.slots*f.membercost
end as cost
from
cd.members m
inner join cd.bookings b
on m.memid = b.memid
inner join cd.facilities f
on b.facid = f.facid
where
b.starttime >= '2012-09-14' and
b.starttime < '2012-09-15' )as bookings
where cost > 30
order by cost desc;  

