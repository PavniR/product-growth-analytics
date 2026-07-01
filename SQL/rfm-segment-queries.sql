--user level R(recency) & F(frequency) table

with purchases as(
select visitorid, max(date) as last_purchase,
count(*) as frequency
from clean_events
where event='transaction'
group by visitorid
)

select visitorid, last_purchase, 
(select max(date) from clean_events)- last_purchase as recency,
frequency
from purchases;


--understanding the RF distribution across data:

with purchases as(
select visitorid, max(date) as last_purchase,
count(*) as frequency
from clean_events
where event='transaction'
group by visitorid
),

RF as (
select visitorid, last_purchase, 
(select max(date) from clean_events)- last_purchase as recency,
frequency
from purchases
)

select min(recency) as min_recency,
max(recency) as max_recency,
round(avg(recency),2) as avg_recency,
min(frequency) as min_frequency,
max(frequency) as max_frequency,
round(avg(frequency),2) as avg_frequency
from RF;

--checking how skewed the frequeny distribution is:

with purchases as(
select visitorid, max(date) as last_purchase,
count(*) as frequency
from clean_events
where event='transaction'
group by visitorid
)

select frequency, count(*) as users
from purchases
group by frequency
order by frequency;

--scoring users using quartiles:

with purchases as(
select visitorid, max(date) as last_purchase,
count(*) as frequency
from clean_events
where event='transaction'
group by visitorid
),

RF as (
select visitorid, last_purchase, 
(select max(date) from clean_events)- last_purchase as recency,
frequency
from purchases
)

select visitorid, recency, frequency,
ntile(4) over(order by recency desc) as r_score,
ntile(4) over(order by frequency asc) as f_score
from RF;

--RF scores:

with purchases as(
select visitorid, max(date) as last_purchase,
count(*) as frequency
from clean_events
where event='transaction'
group by visitorid
),

RF as (
select visitorid, last_purchase, 
(select max(date) from clean_events)- last_purchase as recency,
frequency
from purchases
),

rf_scores as (
select visitorid, recency, frequency,
ntile(4) over(order by recency desc) as r_score,
ntile(4) over(order by frequency asc) as f_score
from RF
)

select *, concat(r_score, f_score) as rf_score
from rf_scores;


--checking rf score distribution:
with purchases as(
select visitorid, max(date) as last_purchase,
count(*) as frequency
from clean_events
where event='transaction'
group by visitorid
),

RF as (
select visitorid, last_purchase, 
(select max(date) from clean_events)- last_purchase as recency,
frequency
from purchases
),

rf_scores as (
select visitorid, recency, frequency,
ntile(4) over(order by recency desc) as r_score,
ntile(4) over(order by frequency asc) as f_score
from RF
)

select concat(r_score, f_score) as rf_score,
count(*) as users
from rf_scores
group by rf_score
order by rf_score desc;


--segmentation based on rf_scores:

with purchases as(
select visitorid, max(date) as last_purchase,
count(*) as frequency
from clean_events
where event='transaction'
group by visitorid
),

RF as (
select visitorid, last_purchase, 
(select max(date) from clean_events)- last_purchase as recency,
frequency
from purchases
),

rf_scores as (
select visitorid, recency, frequency,
ntile(4) over(order by recency desc) as r_score,
ntile(4) over(order by frequency asc) as f_score
from RF
)

select *, concat(r_score,f_score) as rf_score,
case when concat(r_score,f_score)='44' then 'Champions'
when concat(r_score,f_score) in ('43','34','33') then 'High value users'
when concat(r_score,f_score) in ('42','41','32') then 'Emerging users'
when concat(r_score,f_score) in ('31','24','23') then 'Casual users'
when concat(r_score,f_score) in ('22','21','14') then 'Declining Users'
else 'Inactive users'
end as customer_segment,
case when concat(r_score,f_score)='44' then 1
when concat(r_score,f_score) in ('43','34','33') then 2
when concat(r_score,f_score) in ('42','41','32') then 3
when concat(r_score,f_score) in ('31','24','23') then 4
when concat(r_score,f_score) in ('22','21','14') then 5
else 6
end as segment_order
from rf_scores;

--added segment-order for ease in visualisation







