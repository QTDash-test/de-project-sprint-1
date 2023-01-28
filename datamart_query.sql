insert into analysis.dm_rfm_segments (user_id, recency, frequency, monetary_value)
select
	rec.user_id as user_id,
	coalesce(rec.recency, 1) as recency,
	coalesce(freq.frequency, 1) as frequency,
	coalesce(mv.monetary_value, 1) as monetary_value
from analysis.tmp_rfm_recency rec
left join analysis.tmp_rfm_frequency freq
	on rec.user_id = freq.user_id
left join analysis.tmp_rfm_monetary_value mv
	on rec.user_id = mv.user_id
order by user_id

0	1	3	4
1	4	4	3
2	2	3	5
3	2	3	3
4	4	3	3
5	5	5	5
6	1	3	5
7	4	2	2
8	1	2	3
9	1	3	2