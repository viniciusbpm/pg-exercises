// 1

select count(*) from cd.facilities

// 2

select count(*) from cd.facilities f
where f.guestcost > 10

// 3

select m.recommendedby, count(m.recommendedby) from cd.members m
where m.recommendedby is not null
group by recommendedby
order by recommendedby

// 4

select f.facid, sum(b.slots) as "Total Slots" from cd.facilities f
inner join cd.bookings b
on b.facid = f.facid
group by f.facid
order by f.facid

// 5

select f.facid, sum(b.slots) as "Total Slots" from cd.facilities f
inner join cd.bookings b
on b.facid = f.facid
where starttime between '09-01-2012' and '10-1-2012'
group by f.facid
order by "Total Slots"

// 6

select b.facid, extract(month from starttime) as month, sum(b.slots) as "Total Slots" from cd.bookings b
where b.starttime between '2012-01-01' and '2013-01-01'
group by b.facid, extract(month from starttime)
order by b.facid, month

// 7

select count(*) from cd.members m
where m.memid in (select distinct b.memid from cd.bookings b)

// 8

select b.facid, sum(b.slots) from cd.bookings b
group by b.facid
having sum(b.slots) > 1000
order by b.facid

// 9

select f.name, sum(b.slots * case
when b.memid = 0 then f.guestcost
else f.membercost
end) as revenue
from cd.bookings b
inner join cd.facilities f
on b.facid = f.facid
group by f.name
order by revenue; 

// 10

select f.name, sum(b.slots * case
when b.memid = 0 then f.guestcost
else f.membercost
end) as revenue
from cd.bookings b
inner join cd.facilities f
on b.facid = f.facid
group by f.name
having sum(b.slots * case
when b.memid = 0 then f.guestcost
else f.membercost
end) < 1000
order by revenue; 

// 11

select b.facid, sum(b.slots) as "Total Slots" from cd.bookings b
group by b.facid
order by "Total Slots" desc
limit 1


// 12

select facid, extract(month from starttime) as month, sum(slots) as slots
from cd.bookings
where
starttime >= '2012-01-01'
and starttime < '2013-01-01'
group by rollup(facid, month)
order by facid, month;          

// 13

select f.facid, f.name, 
trim(to_char(sum(b.slots)/2.0, '9999999999999999D99')) as "Total Hours"
from cd.facilities f
inner join cd.bookings b
on b.facid = f.facid
group by f.facid
order by f.facid

// 14

select distinct m.surname, m.firstname, m.memid, min(b.starttime) from cd.members m
inner join cd.bookings b
on b.memid = m.memid
where date(b.starttime) >= '2012-09-01'
group by m.surname, m.firstname, m.memid
order by memid

// 15

select (select count(memid) from cd.members) as count, m.firstname, m.surname from cd.members m

// 16

select row_number() over(order by m.joindate), m.firstname, m.surname from cd.members m
order by m.joindate

// 17	

select b.facid, sum(b.slots) as total from cd.bookings b
group by b.facid
order by total desc
limit 1

// 18

select firstname, surname, ((sum(b.slots)+10)/20)*10 as hours, rank() over (order by ((sum(b.slots)+10)/20)*10 desc) as rank
from cd.bookings b
inner join cd.members m
on b.memid = m.memid
group by m.memid
order by rank, surname, firstname;   

// 19

select name, rank from (
select f.name as name, rank() over (order by sum(case
when memid = 0 then slots * f.guestcost
else slots * membercost
end) desc) as rank
from cd.bookings b
inner join cd.facilities f
on b.facid = f.facid
group by f.name
) as subq
where rank <= 3
order by rank;          

// 20

