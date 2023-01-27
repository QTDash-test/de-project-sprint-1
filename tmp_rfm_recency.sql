insert into analysis.tmp_rfm_recency
select user_id,
	case
		when rm between 1 and 200 then 5
		when rm between 201 and 400 then 4
		when rm between 401 and 600 then 3
		when rm between 601 and 800 then 2
		when rm between 801 and 1000 then 1
	end as recency

from
	(select user_id,
		max_ord_date,
		row_number() over (order by max_ord_date desc nulls last) as rm
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
	group by user_id, max_ord_date) t