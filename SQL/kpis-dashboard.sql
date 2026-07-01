-- OVERALL----------------------------------------
--total events:
select count(*) as total_events
from clean_events;
--2,755,641

--total users:
select count(distinct visitorid) as total_users
from clean_events;
--1,407,580

--total products (interacted with)
select count(distinct itemid) as total_products
from clean_events;
--235,061

-- EVENT DISTRIBUTION (view, add to cart, transaction)-------
select event, count(*) as total_events,
round(count(*) * 100.0/sum(count(*)) over(),2) as event_percentage
from clean_events
group by event
order by total_events desc;

-- Daily KPI summary-------------------------------
select date, count(*) as total_events, 
count(distinct visitorid) as users,
sum(case when event = 'transaction' then 1 else 0 end) as transactions
from clean_events
group by date order by date;

--weekdays vs transactions--------------------------
select weekday, count(*) as events,
count(distinct visitorid) as users,
count(*) filter (where event='transaction') as transactions
from clean_events
group by weekday
ORDER BY
case weekday
    when 'Monday' then 1
    when 'Tuesday' then 2
    when 'Wednesday' then 3
    when 'Thursday' then 4
    when 'Friday' then 5
    when 'Saturday' then 6
    when 'Sunday' then 7
end;
--note: used filter instead of case when for optimised query in postgres

--hourly activity summary:--------------------
select hour, count(*) as events,
count(distinct visitorid) as users,
count(*) filter (where event='transaction') as transactions
from clean_events
group by hour order by hour;

--CONVERSION RATES(view/add-to-cart to transactions)
select 
round(count(*) filter (where event='addtocart') * 100.0/count(*) filter (where event='view'),
2) as view_to_cart_rate,
round(count(*) filter (where event='transaction') * 100.0/count(*) filter (where event='addtocart'),
2) as cart_to_purchase_rate,
round(count(*) filter (where event='transaction') * 100.0/count(*) filter (where event='view'),
2) as overall_conversion_rate
from clean_events;

--average events per user--------------------------
select
round(count(*)::numeric/count(distinct visitorid),2) as avg_events_per_user
from clean_events;

--average purchases per purchasing user-------------
select
round(count(*)::numeric/count(distinct visitorid),2) as avg_purchase_per_buyer
from clean_events
where event='transaction';
