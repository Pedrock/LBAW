TRUNCATE ShippingCosts RESTART IDENTITY CASCADE;

INSERT INTO ShippingCosts (maxweight, price) VALUES ('2000', '4');
INSERT INTO ShippingCosts (maxweight, price) VALUES ('5000', '5.50');
INSERT INTO ShippingCosts (maxweight, price) VALUES ('10000', '7');
INSERT INTO ShippingCosts (maxweight, price) VALUES ('20000', '9');
INSERT INTO ShippingCosts (maxweight, price) VALUES ('30000', '11');
INSERT INTO ShippingCosts (maxweight, price) VALUES ('50000', '14');