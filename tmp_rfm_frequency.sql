insert into analysis.tmp_rfm_frequency
select user_id,
		ntile(5) over (order by count_orders asc) as rm
	from
			(select us.id as user_id,
					coalesce(ord.count_orders, 0) as count_orders
			from analysis.users us
			LEFT JOIN
			(select user_id, count(order_id) as count_orders
			from analysis.orders ord
			where status = 4
			group by user_id) ord
			on us.id = ord.user_id
			order by count_orders desc) d