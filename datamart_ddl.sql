create table if not exists analysis.dm_rfm_segments
 (user_id int4 primary key,
 recency smallint check (recency between 1 and 5),
 frequency smallint check (frequency between 1 and 5),
 monetary_value smallint check (monetary_value between 1 and 5))