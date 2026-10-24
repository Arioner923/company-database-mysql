-- Sample data reconstructed from the original 2017 SQL script.
-- Obvious transcription errors from the original are corrected here and documented in report.md.
USE company_db;

INSERT INTO branches (branch_id, name, city, street, street_number) VALUES
(1, 'nikos', 'athina', 'ermou', 154),
(2, 'loulis', 'thessaloniki', 'aerodromio', 56),
(3, 'giwrgos', 'patra', 'nikolaou', 100),
(4, 'karanikolas', 'iwannina', 'kapou', 234),
(5, 'mitsos', 'syros', 'filopapou', 546);

INSERT INTO branch_phones VALUES
(1, '234234'), (2, '565646'), (3, '345346'), (4, '566345'), (5, '34645');

INSERT INTO customers VALUES
('ag9534', 'nikos', 'kalogeropulos', 'rodos', 'athinas', 43),
('ak4346', 'thanasis', 'titopoulos', 'hrakleio', 'kornarou', 23),
('ej6532', 'kwstas', 'apostolou', 'nea smirni', 'kalogritsas', 64),
('ie9825', 'antonis', 'karanikolas', 'santorini', 'oia', 75),
('fg8729', 'maria', 'iakovou', 'serres', 'kolokotroni', 873);

-- Uses the explicit M:N "Sinergazetai" relation from the original design.
INSERT INTO branch_customers VALUES
(1, 'ag9534'), (2, 'ak4346'), (3, 'ej6532'), (4, 'ie9825'), (5, 'fg8729');

INSERT INTO employees VALUES
('jf9685', 'iwanna', 'xatzialexandrou', '1980-04-06', 1045.67, '2015-05-13', 'nikaia', 'gewrg_labraki', 56, 3, 'tamias'),
('ds3435', 'ioulia', 'karvela', '1990-12-31', 900.33, '2015-12-13', 'peirais', 'lesbou', 34, 1, 'logistirio'),
('as3245', 'kwstas', 'panagiwtou', '1976-05-27', 945.87, '2000-05-15', 'karditsa', 'meteoron', 43, 4, 'logistirio'),
('lp4632', 'giannis', 'papas', '1968-01-29', 1560.34, '1997-09-20', 'thessaloniki', 'aisopou', 56, 5, 'simboul_pol'),
('ap1000', 'dimitris', 'papadoulos', '1995-10-25', 890.67, '2005-08-25', 'agrinio', 'porou', 65, 2, 'service');

INSERT INTO technicians VALUES ('ap1000', 3, '2013-05-12');
INSERT INTO accountants VALUES
('ds3435', '2014-05-15', 'oikonomologos APTH', 'aristi'),
('as3245', '2000-06-18', 'logistis kapodistriako', 'leian kalos');
INSERT INTO secretaries VALUES
('jf9685', '2005-08-23', 'filologia kapodistriako', 10);

INSERT INTO dependents VALUES
('ds3435', 'ioulia', 'ginaika', 27),
('lp4632', 'giannis', 'antras', 49);

INSERT INTO orders VALUES
(3456, '2017-04-12', 'athina Skoufa 13', '2017-04-13', 234.56, 'ap1000', 'ak4346'),
(6754, '2017-06-05', 'thessaloniki Giavash 51', '2017-06-15', 500.50, 'lp4632', 'ag9534'),
(2345, '2015-11-23', 'santorini dikaiosinis 11', '2015-12-01', 1234.24, 'ds3435', 'ie9825'),
(4352, '2016-07-25', 'Hrakleio evans 12', '2016-07-29', 300.54, 'lp4632', 'ak4346'),
(9837, '2016-09-14', 'syros Gouna 18', '2016-09-20', 345.59, 'ds3435', 'ej6532');

INSERT INTO products VALUES
('kl4353', 345.53, 2, 'karelias', 'ixeia'),
('ok8576', 789.54, 3, 'savidis', 'tileorasis'),
('ys5739', 1049.00, 2, 'HP', 'PC'),
('df8545', 324.30, 1, 'logitech', 'pliktrologia'),
('gf4738', 435.43, 5, 'Samsung', 'TV');

-- Two malformed original rows appear to contain multiple product codes.
-- They are reconstructed here as separate order-item rows.
INSERT INTO order_items (order_id, product_code, quantity) VALUES
(3456, 'kl4353', 1),
(6754, 'ok8576', 1),
(6754, 'df8545', 1),
(2345, 'gf4738', 1),
(2345, 'df8545', 1),
(2345, 'kl4353', 1),
(4352, 'df8545', 1),
(9837, 'kl4353', 1);

INSERT INTO suppliers VALUES
('3234532', 'gewrgiou', 'peiraia', 'filopapou', 32),
('3453267', 'panagiwtou', 'xania', 'nikitara', 45),
('6435325', 'kwtsovolos', 'xalandri', 'xalandras', 56),
('4356326', 'pc_building', 'syntagma', 'ermou', 68),
('3426784', 'zourbielakis', 'rethimno', 'papagianni', 234);

INSERT INTO supplier_phones VALUES
('3234532', '2105435464'),
('3453267', '2310435345'), -- original script used 3453265, which has no matching supplier
('6435325', '2103454356'),
('4356326', '2105674336'),
('3426784', '2410674526');

INSERT INTO product_suppliers VALUES
('kl4353', '3234532', 250.70),
('ok8576', '3453267', 700.40),
('ys5739', '4356326', 950.35),
('df8545', '4356326', 200.45),
('gf4738', '3426784', 370.87);

UPDATE branches SET manager_employee_id = 'ds3435' WHERE branch_id = 2;
UPDATE branches SET manager_employee_id = 'ap1000' WHERE branch_id = 1;
UPDATE branches SET manager_employee_id = 'lp4632' WHERE branch_id = 5;
UPDATE branches SET manager_employee_id = 'as3245' WHERE branch_id = 3;
UPDATE branches SET manager_employee_id = 'jf9685' WHERE branch_id = 4;
