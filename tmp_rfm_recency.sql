insert into analysis.tmp_rfm_recency
select user_id,
		ntile(5) over (order by max_ord_date asc)
from
	(select us.id as user_id,
			ord.max_ord_date as max_ord_date
	from analysis.users us
		LEFT JOIN
	(select user_id, max(order_ts) as max_ord_date
	 from analysis.orders ord
	 where status = 4
	 group by user_id) ord
		on us.id = ord.user_id
	order by max_ord_date desc) d
order by user_id