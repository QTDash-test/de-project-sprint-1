insert into analysis.tmp_rfm_monetary_value
select user_id,
	case
		when rm between 1 and 200 then 5
		when rm between 201 and 400 then 4
		when rm between 401 and 600 then 3
		when rm between 601 and 800 then 2
		when rm between 801 and 1000 then 1
	end as monetary_value

from
	(select user_id,
		sum_payment,
		row_number() over (order by sum_payment desc) as rm
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
	group by user_id, sum_payment) t