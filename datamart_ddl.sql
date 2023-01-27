create table if not exists analysis.dm_rfm_segments
 (user_id int4 references production.users (id),
 recency smallint,
 frequency smallint,
 monetary_value smallint)