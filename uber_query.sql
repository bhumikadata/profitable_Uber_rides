with cte1 as 
(
select
  id,
  count(*)  as total_rides 
from 
  drivers
group by 
  id  
)     
, cte2 as
(
select 
  d1.id  as id,
  count(*)  as profit_rides
from 
  drivers  d1
join
  drivers d2
on d1.end_loc = d2.start_loc and d1.end_time = d2.start_time    
group by 
  d1.id  
)
select
  c1.id,
  c1.total_rides,
  coalesce(c2.profit_rides,0) as profit_rides
from 
  cte1 c1
left join
  cte2 c2
on 
  c1.id = c2.id      