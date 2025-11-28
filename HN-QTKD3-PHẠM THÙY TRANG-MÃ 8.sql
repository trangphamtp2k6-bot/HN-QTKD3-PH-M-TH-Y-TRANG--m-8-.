create database FlightDB ;
use FlightDB ;
create table Passengers (
passenger_id INT AUTO_INCREMENT Primary key ,
passenger_name Varchar(100) not null,
email Varchar(100) unique ,
phone varchar(15),
nationality varchar(50)
);

create table Flights (
flight_id INT AUTO_INCREMENT PRIMARY KEY ,
flight_number Varchar(20),
airline Varchar(50),
departure_city  Varchar(50),
arrival_city Varchar(50),
ticket_price Decimal(15,2)
);

create table Bookings (
booking_id INT Auto_increment primary key ,
passenger_id INT ,
FOREIGN KEY (passenger_id)  references Passengers(passenger_id),
flight_id Int,
FOREIGN KEY (flight_id)  references Flights (flight_id),
booking_date date,
seat_number Varchar(10)
);
-- Viết các lệnh để thêm dữ liệu mẫu vào 3 bảng như sau

insert into Passengers (passenger_name, email, phone ,nationality )
values 
('Nguyen Van An', 'an.nguyen@email.com', '0901111111', 'Viet Nam'),
('Tran Thi Binh', 'binh.tran@email.com', '0902222222', 'Viet Nam'),
('John Smith', 'john.smith@email.com', '0903333333', 'USA'),
('Pham Thi Dung', 'dung.pham@email.com', '0904444444', 'Viet Nam'),
('Lee Min Ho', 'lee.minho@email.com', '0905555555', 'Korea'),
('Do Thi Hoa', 'hoa.do@email.com', '0906666666', 'Viet Nam'),
('Vu Van Giang', 'giang.vu@email.com', '0907777777', 'Viet Nam'),
('Michael Jordan', 'michael.j@email.com', '0908888888', 'USA'),
('Ngo Van Hung', 'hung.ngo@email.com', '0909999999', 'Viet Nam'),
('Trinh Thi Khoi', 'khoi.trinh@email.com', '0910000000', 'Viet Nam') ;

Insert into Flights (flight_number,airline,departure_city,arrival_city,ticket_price) values 
('VN101', 'Vietnam Airlines', 'Ha Noi', 'TP HCM', 2500000),
('VJ202', 'Vietjet Air', 'Ha Noi', 'Da Nang', 1200000),
('QH303', 'Bamboo Airways', 'TP HCM', 'Phu Quoc', 1800000),
('VN404', 'Vietnam Airlines', 'Da Nang', 'Ha Noi', 2200000),
('VJ505', 'Vietjet Air', 'TP HCM', 'Bangkok', 3000000),
('QH606', 'Bamboo Airways', 'Ha Noi', 'Con Dao', 4500000),
('VN707', 'Vietnam Airlines', 'Can Tho', 'Ha Noi', 2800000),
('VJ808', 'Vietjet Air', 'Hai Phong', 'TP HCM', 1500000),
('QH909', 'Bamboo Airways', 'Ha Noi', 'Nha Trang', 2000000),
('VU001', 'Vietravel Airlines', 'Hue', 'Ha Noi', 1000000);

insert into Bookings (passenger_id,flight_id,booking_date,seat_number) values
(1, 1, '2024-02-01', '12A'),
(2, 2, '2024-02-02', '15B'),
(3, 3, '2024-02-03', '01C'),
(4, 4, '2024-02-04', '22D'),
(5, 5, '2024-02-05', '05A'),
(6, 6, '2024-02-06', '10E'),
(7, 7, '2024-02-07', '18F'),
(8, 8, '2024-02-08', '09A'),
(9, 9, '2024-02-09', '11C'),
(10, 10, '2023-12-15', '20D');

-- cau3 cap nhap du lieu
-- Cập nhật giá vé (ticket_price) của chuyến bay có mã "VN101" thành 3000000.

UPDATE Flights
SET ticket_price = 3000000
WHERE flight_number = 'VN101';


-- Cập nhật số ghế (seat_number) của vé đặt có booking_id = 1 thành "12B"
UPDATE Bookings
SET seat_number = '12B'
WHERE booking_id = 1;

-- cau4 cap nhap du lieu 
-- Xóa các vé đặt trong bảng Bookings có ngày đặt (booking_date) trước ngày '2024-01-01'.

DELETE FROM Bookings
WHERE booking_date < '2024-01-01';

-- Xóa chuyến bay có mã (flight_number) là "VU001" khỏi bảng Flights.

DELETE FROM Flights
WHERE flight_number = 'VU001';

-- cau5 truy van 
-- Lấy ra danh sách các chuyến bay của hãng (airline) là "Vietjet Air".

SELECT *
FROM Flights
WHERE airline = 'Vietjet Air';

-- Lấy ra danh sách hành khách có quốc tịch (nationality) là "Viet Nam".
SELECT *
FROM Passengers
WHERE nationality = 'Viet Nam';

-- Lấy ra các chuyến bay có giá vé (ticket_price) lớn hơn 2,000,000
Select *
From Flights 
Where ticket_price > '2,000,000';

-- Tìm kiếm các hành khách có tên chứa chữ "Nguyen".
select *
From Passengers
where passenger_name ='%Nguyen%';

-- Lấy ra thông tin của 5 chuyến bay có giá vé cao nhất (Sắp xếp giảm dần).
select*
from Flights 
order by ticket_price Desc
limit 5;

-- Lấy ra danh sách gồm: Tên hành khách (passenger_name), Mã chuyến bay (flight_number), Ngày đặt (booking_date) và Số ghế (seat_number).
 SELECT p.passenger_name,
       f.flight_number,
       b.booking_date,
       b.seat_number
FROM Bookings b
JOIN Passengers p ON b.passenger_id = p.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id;

-- Lấy ra tên hành khách và tên hãng hàng không mà họ đã đặt vé.
SELECT 
    p.PassengerName,
    a.AirlineName
FROM 
    Bookings b
JOIN 
    Passengers p ON b.PassengerID = p.PassengerID
JOIN 
    Flights f ON b.FlightID = f.FlightID
JOIN 
    Airlines a ON f.AirlineID = a.AirlineID;

-- Hiển thị mã chuyến bay và tên hành khách cho các chuyến bay đi đến (arrival_city) là "Ha Noi"

SELECT f.flight_number,
       p.passenger_name
FROM Bookings b
JOIN Passengers p ON b.passenger_id = p.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
WHERE f.arrival_city = 'Ha Noi';
-- Hiển thị danh sách các chuyến bay của hãng "Vietnam Airlines" và tên hành khách đã đặt vé.

SELECT f.flight_id,
       f.airline,
       t.passenger_name
FROM flights f
JOIN tickets t ON f.flight_id = t.flight_id
WHERE f.airline = 'Vietnam Airlines';

-- Thống kê số lượng chuyến bay của mỗi hãng hàng không (airline).
SELECT airline,
       COUNT(*) AS so_luong_chuyen_bay
FROM flights
GROUP BY airline;

-- Tính tổng doanh thu (ticket_price) của từng hãng hàng không.

SELECT f.airline,
       SUM(t.ticket_price) AS tong_doanh_thu
FROM flights f
JOIN tickets t ON f.flight_id = t.flight_id
GROUP BY f.airline;

-- Tìm những hãng hàng không (airline) có từ 3 chuyến bay trở lên.

SELECT airline,
       COUNT(*) AS so_luong_chuyen_bay
FROM flights
GROUP BY airline
HAVING COUNT(*) >= 3;
