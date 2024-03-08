// 1 
insert into cd.facilities values(
9, 'Spa', 20, 30, 100000, 800)

// 2

insert into cd.facilities values
(9, 'Spa', 20, 30, 100000, 800),
(10, 'Squash Court 2', 3.5, 17.5, 5000, 80)

// 3

insert into cd.facilities 
(facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
select (select max(facid) from cd.facilities) + 1, 'Spa', 20, 30, 100000, 800;

// 4

update cd.facilities f
set f.initialoutlay = 10000
where f.name = 'Tennis Court 2'

// 5

update cd.facilities 
set membercost = 6, guestcost = 30
where name like 'Tennis Court%'

// 6

update cd.facilities
set membercost = 
(select membercost * 1.1 from cd.facilities where name like 'Tennis Court 1'),
guestcost = 
(select guestcost * 1.1 from cd.facilities where name like 'Tennis Court 1')
where name like 'Tennis Court 2'

// 7

delete from cd.bookings

// 8

delete from cd.members 
where memid = 37

// 9

delete from cd.members m1
where m1.memid not in (select b.memid from cd.bookings b)


