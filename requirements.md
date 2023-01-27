Требуется создать витрину с названием dm_rfm_segments, которая должна храниться в схеме analysis и состоять из полей: 
- user_id
- recency
- frequency
- monetary_value
Глубина данных в таблице - с 2022 года, обновления таблицы не требуются.

Для расчета будут использованы поля: 
таблица users: 
- id
таблица orders:
- order_id
- order_ts
- payment