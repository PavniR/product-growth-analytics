--different stages funnel:

select event as stage, count(*) as event_count
from clean_events
where event in ('view', 'addtocart', 'transaction')
group by event
order by case event
when 'view' then 1
when 'addtocart' then 2
when 'transaction' then 3
end;

--different stages with unique users:
select event as stage, count(distinct visitorid) as users
from clean_events
where event in ('view', 'addtocart', 'transaction')
group by event
order by case event
when 'view' then 1
when 'addtocart' then 2
when 'transaction' then 3
end;

--funnel conversion metrics:
with funnel as(
select event, count(distinct visitorid) as users
from clean_events
group by event
)

select 
round(100.0*(max(case when event='addtocart' then users end))/
(max(case when event='view' then users end)),2) as view_to_cart,
round(100.0*(max(case when event='transaction' then users end))/
(max(case when event='addtocart' then users end)),2) as cart_to_purchase,
round(100.0*(max(case when event='transaction' then users end))/
(max(case when event='view' then users end)),2) as overall_conversion
from funnel

--drop-offs:
with funnel as(
select event, count(distinct visitorid) as users
from clean_events
group by event
)

select 
(max(case when event='view' then users end)-max(case when event='addtocart' then users end))
as dropped_after_view,
(max(case when event='addtocart' then users end)-max(case when event='transaction' then users end))
as dropped_after_cart
from funnel

--sequential user funnels 
with user_funnel as(
select visitorid, 
max(case when event = 'view' then 1 else 0 end) as viewed, 
max(case when event = 'addtocart' then 1 else 0 end) as added_to_cart, 
max(case when event = 'transaction' then 1 else 0 end) as purchased 
from clean_events group by visitorid
) 

select count(*) filter (where viewed = 1) as viewed_users, 
count(*) filter (where viewed = 1 and added_to_cart = 1) as cart_users, 
count(*) filter (where viewed = 1 and added_to_cart = 1 and purchased = 1) as purchased_users, 
round(100.0*count(*) filter (where viewed = 1 and added_to_cart = 1)/nullif(count(*) filter (where viewed = 1), 0), 2) as view_to_cart_rate, 
round(100.0*count(*) filter (where viewed = 1 and added_to_cart = 1 and purchased = 1)/nullif(count(*) filter 
(where viewed = 1 and added_to_cart = 1), 0), 2) as cart_to_purchase_rate, 
round(100.0*count(*) filter (where viewed = 1 and added_to_cart = 1 and purchased = 1)/nullif(count(*) filter 
(where viewed = 1), 0), 2) as overall_conversion_rate 
from user_funnel;