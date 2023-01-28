create or replace view analysis.orders as
select
	ord.order_id as order_id,
	ord.order_ts as order_ts,
	ord.user_id as user_id,
	ord.bonus_payment as bonus_payment,
	ord.payment as payment,
	ord.cost as cost,
	ord.bonus_grant as bonus_grant,
	st.status as status
from production.orders ord
left join
	(select order_id, status_id as status
	from
		(select order_id, status_id, dttm, row_number () over (partition by order_id order by dttm desc) as rm
		from production.orderstatuslog
		group by order_id, status_id, dttm) t
	where rm = 1
	) st
on ord.order_id = st.order_id