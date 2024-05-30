-- create database Royal_Hotel;
-- use Royal_Hotel;
 create table Royal_Hotel_Reservation
(booking_id varchar(20) not null,
no_of_adults int not null,
no_of_children int not null,
no_of_weekend_nights int not null,
no_of_week_nights int not null,
type_of_meal_plan varchar(100) not null,
room_type_reserved varchar(100) not null,
lead_time int not null,
arrival_date date not null,
market_segment_type varchar(100) not null,
avg_price_per_room double not null,
booking_status varchar(50) not null,
unique (booking_id)
);

-- 1. What is the total number of reservations in the dataset?
select count(booking_id) as no_of_reservations 
from royal_hotel_reservation;

-- 2. Which meal plan is the most popular among guests?
select type_of_meal_plan ,count(*) as total_guests
from royal_hotel_reservation
group by type_of_meal_plan
order by total_guests
limit 1;

-- 3. What is the average price per room for reservations involving children?
select avg(avg_price_per_room)
from royal_hotel_reservation
where no_of_children > 1;

-- 4. How many reservations were made for the year 20XX (replace XX with the desired year)?
select count(booking_id) as no_of_bookings
from royal_hotel_reservation
where year(arrival_date)  = 2018;

-- 5. What is the most commonly booked room type?
select room_type_reserved,count(*) as room_reserved
from royal_hotel_reservation
group by room_type_reserved
order by room_reserved desc
limit 1;

-- 6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?
select count(booking_id) as no_of_reservations
from royal_hotel_reservation
where no_of_weekend_nights > 0;

-- 7. What is the highest and lowest lead time for reservations?
select max(lead_time),min(lead_time) 
from royal_hotel_reservation;

-- 8. What is the most common market segment type for reservations?
select market_segment_type,count(*) as reservations
from royal_hotel_reservation
group by market_segment_type
order by reservations desc
limit 1;

-- 9. How many reservations have a booking status of "Confirmed"?
select count(booking_id) as reservations
from royal_hotel_reservation
where booking_status = "Confirmed"
order by reservations;

-- 10. What is the total number of adults and children across all reservations?
select sum(no_of_adults) as total_adults,sum(no_of_children) as total_children
from royal_hotel_reservation;

-- 11. What is the average number of weekend nights for reservations involving children?
select avg(no_of_weekend_nights) as average_weekend_nights
from royal_hotel_reservation
where no_of_children > 1;

-- 12. How many reservations were made in each month of the year?
select count(booking_id) as no_of_reservations,month(arrival_date) as booking_month,year(arrival_date) as booking_year
from royal_hotel_reservation
group by month(arrival_date), year(arrival_date)
order by booking_month,booking_year;

-- 13. What is the average number of nights (both weekend and weekday) spent by guests for each room type?
select room_type_reserved,avg(no_of_weekend_nights + no_of_week_nights) as avg_number_of_nights
from royal_hotel_reservation
group by room_type_reserved
order by avg_number_of_nights;

-- 14. For reservations involving children, what is the most common room type, and what is the average price for that room type?
select room_type_reserved,count(*) as num_reservations,avg(avg_price_per_room) as avg_price
from royal_hotel_reservation
where no_of_children > 1
group by room_type_reserved
order by num_reservations desc,avg_price
limit 1 ;


-- 15. Find the market segment type that generates the highest average price per room.
select market_segment_type,avg(avg_price_per_room) as highest_avg_price_per_room
from royal_hotel_reservation
group by market_segment_type
order by highest_avg_price_per_room desc
limit 1;