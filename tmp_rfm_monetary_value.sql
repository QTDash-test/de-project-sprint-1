insert into analysis.tmp_rfm_monetary_value
select user_id,
		ntile(5) over (order by sum_payment asc) as rm
	from
			(select us.id as user_id,
				coalesce(ord.sum_payment, 0) as sum_payment
			from analysis.users us
			LEFT JOIN
			(select user_id, sum(payment) as sum_payment
			from analysis.orders ord
			where status = 4
			group by user_id) ord
			on us.id = ord.user_id
			order by sum_payment desc) d