INSERT INTO vehicle (vehicle_id, make, model, year, type, engine)
VALUES
(1, 'honda', 'accord', 2010, 'a', '2.4l'),
(2, 'honda', 'civic', 2011, 'a', '2.4l'),
(3, 'toyota', 'camry', 2012, 's', '3.6l'),
(4, 'toyota', 'prius', 2013, 's', '2.4l'),
(5, 'toyota', 'rav4', 2014, 's', '3.6l');


INSERT INTO categories (category_id, category_name)
VALUES
(1, 'brakes'),
(2, 'filters'),
(3, 'engine'),
(4, 'clutch'),
(5, 'oils'),
(6, 'lights');

INSERT INTO company (company_id, company_name, email, phone)
VALUES
(1, 'bosch', NULL, NULL),
(2, 'centric parts', NULL, NULL),
(3, 'russell', NULL, NULL),
(4, 'carlson', NULL, NULL),
(5, 'promax', NULL, NULL),
(6, 'raybestos', NULL, NULL);

INSERT INTO parts_location(location_id, aisle_no, shelf_no)
VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 2, 1),
(5, 2, 2),
(6, 2, 3),
(7, 3, 1),
(8, 3, 2),
(9, 3, 3),
(10, 4, 1);

INSERT INTO parts_detail(part_id, part_name, part_number, unit_price, quantity, date_added, category_id, location_id)
VALUES
(1, 'brake pads', 4500, 12, 14, '01-12-2024', 1, 1),
(2, 'brake rotors', 4501, 23, 35, '01-12-2024', 1, 2),
(3, 'brake calipers', 4563, 34, 23, '01-12-2024', 1, 3),
(4, 'fuel filters', 2501, 32, 12, '01-12-2024', 2, 4),
(5, 'throttle body', 3201, 21, 25, '03-12-2024', 3, 5),
(6, 'clutch pads', 4508, 45, 21, '01-12-2024', 4, 6),
(7, 'engine oil', 9654, 9, 16, '01-12-2024', 5, 7),
(8, 'fog light', 7895, 150, 15, '02-12-2024', 6, 8),
(9, 'engine oil filter', 5635, 31, 18, '01-12-2024', 2, 9),
(10, 'brake drums', 4509, 15, 14, '03-12-2024', 1, 10);

INSERT INTO parts_fitment (fitment_id, part_id, vehicle_id)
VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 3),
(4, 4, 2),
(5, 5, 5),
(6, 6, 4),
(7, 7, 2);

INSERT INTO company_part (companyPart_id, company_id, part_id)
VALUES
(1, 2, 1),
(2, 1, 2),
(3, 1, 3),
(4, 3, 4),
(5, 1, 10);

