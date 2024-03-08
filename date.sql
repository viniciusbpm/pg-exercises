// 1

select timestamp '2012-08-31 01:00:00'

// 2

select timestamp '2012-08-31 01:00:00' - timestamp '2012-07-30 01:00:00' as interval;          

// 3

select generate_series(timestamp '2012-10-01', timestamp '2012-10-31', interval '1 day') as ts;          

// 4

select extract(day from timestamp '2012-08-31')

// 5

select extract(epoch from (timestamp '2012-09-02 00:00:00' - '2012-08-31 01:00:00'));          

// 6

select 	extract(month from cal.month) as month, (cal.month + interval '1 month') - cal.month as length from
(select generate_series(timestamp '2012-01-01', timestamp '2012-12-01', interval '1 month') as month) cal
order by month;    

// 8

select (date_trunc('month',ts.testts) + interval '1 month') - date_trunc('day', ts.testts) as remaining
from (select timestamp '2012-02-11 01:00:00' as testts) ts  

// 9

select starttime, starttime + slots*(interval '30 minutes') endtime
from cd.bookings
order by endtime desc, starttime desc
limit 10

// 10

select date_trunc('month', starttime) as month, count(*)
from cd.bookings
group by month
order by month


// 11

select name, month, round((100*slots)/cast(
			25*(cast((month + interval '1 month') as date)
			- cast (month as date)) as numeric),1) as utilisation
	from  (
		select f.name as name, date_trunc('month', starttime) as month, sum(slots) as slots
			from cd.bookings b
			inner join cd.facilities f
			on b.facid = f.facid
			group by f.facid, month
	) as inn
order by name, month     
