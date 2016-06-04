-- Update product’s average score
CREATE OR REPLACE FUNCTION update_product_average_score() RETURNS TRIGGER AS $BODY$
BEGIN
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
		 UPDATE product SET averagescore = (SELECT avg(score) FROM review WHERE idproduct=NEW.idproduct) WHERE idproduct=NEW.idproduct;
	END IF;
	IF TG_OP = 'DELETE' OR (TG_OP = 'UPDATE' AND OLD.idproduct <> NEW.idproduct) THEN
		UPDATE product SET averagescore = (SELECT avg(score) FROM review WHERE idproduct=OLD.idproduct) WHERE idproduct=OLD.idproduct;
	END IF;
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
		RETURN NEW;
	ELSE
		RETURN OLD;
	END IF;
END;
$BODY$
LANGUAGE plpgsql;
 
DROP TRIGGER IF EXISTS ProductAverageScore ON Review;
CREATE TRIGGER ProductAverageScore AFTER INSERT OR DELETE OR UPDATE
    ON Review
    FOR EACH ROW
    EXECUTE PROCEDURE update_product_average_score();
-- Add product to cart
CREATE OR REPLACE FUNCTION add_to_cart(user_id INTEGER, product_id INTEGER, quantity_product INTEGER) RETURNS void AS $BODY$
BEGIN
	IF EXISTS (SELECT * FROM ProductCart WHERE idProduct = product_id AND idUser = user_id) THEN
		UPDATE ProductCart SET quantity = quantity + quantity_product WHERE idProduct = product_id AND idUser = user_id;
	ELSE
		INSERT INTO ProductCart(idUser,idProduct,quantity,price) 
			VALUES (user_id,product_id,quantity_product, (SELECT price FROM Product WHERE idProduct = product_id));
	END IF;
END;
$BODY$
LANGUAGE plpgsql;
-- Add products to cart from JSON
CREATE OR REPLACE FUNCTION add_to_cart_from_json(user_id INTEGER, products_json JSON) RETURNS void AS $BODY$
DECLARE
	item RECORD;
BEGIN
	FOR item IN
		SELECT * FROM json_to_recordset(products_json) as x(p int, q int)
	LOOP
		PERFORM add_to_cart(user_id, item.p, item.q);
	END LOOP;
END;
$BODY$
LANGUAGE plpgsql;
-- Get product price considering its discount 
CREATE OR REPLACE FUNCTION get_product_price(product_id INTEGER) RETURNS FLOAT AS $BODY$
DECLARE discount_percentage INTEGER;
DECLARE original_price NUMERIC;
BEGIN
	SELECT COALESCE((SELECT percentage FROM Discount WHERE idproduct = product_id AND startdate <= now() AND enddate >= now() ORDER BY percentage DESC LIMIT 1),0) 
		INTO discount_percentage;
	SELECT price FROM Product WHERE idproduct = product_id INTO original_price;
	RETURN round(original_price * (100-discount_percentage) / 100.0, 2);
END;
$BODY$
LANGUAGE plpgsql;
-- Get product discount and price with discount 
CREATE OR REPLACE FUNCTION get_product_discount_and_price(product_id INTEGER, OUT discount INTEGER, OUT new_price NUMERIC) AS $BODY$
DECLARE discount_percentage INTEGER;
DECLARE original_price NUMERIC;
BEGIN
	SELECT percentage FROM Discount WHERE idproduct = product_id AND startdate <= now() AND enddate >= now() ORDER BY percentage DESC LIMIT 1
		INTO discount_percentage;
	SELECT price FROM Product WHERE idproduct = product_id INTO original_price;
	IF discount_percentage IS NULL THEN
		SELECT NULL, original_price INTO discount,new_price;
	ELSE
		SELECT discount_percentage, round(original_price * (100-discount_percentage) / 100.0, 2) INTO discount,new_price;
	END IF;
END;
$BODY$
LANGUAGE plpgsql;
-- Make an order
CREATE OR REPLACE FUNCTION make_order(user_id INTEGER, billingAddress INTEGER, shippingAddress INTEGER, order_nif TEXT, coupon_code TEXT) RETURNS INTEGER AS $BODY$
DECLARE order_id INTEGER;
DECLARE coupon_id INTEGER;
DECLARE coupon_discount INTEGER;
BEGIN
 
	IF NOT EXISTS (SELECT * FROM ProductCart WHERE idUser = user_id) THEN
		RAISE EXCEPTION 'Empty cart';
	END IF;
 
	IF EXISTS (SELECT * FROM ProductCart WHERE idUser = user_id AND price != get_product_price(idProduct)) THEN
		RAISE EXCEPTION 'Prices have changed';
	END IF;
 
	IF NOT EXISTS (SELECT * FROM Address WHERE idAddress = billingAddress AND idUser = user_id) THEN
		RAISE EXCEPTION 'Invalid billing address';
	END IF;
 
	IF NOT EXISTS (SELECT * FROM Address WHERE idAddress = shippingAddress AND idUser = user_id) THEN
		RAISE EXCEPTION 'Invalid shipping address';
	END IF;
 
	IF coupon_code IS NOT NULL THEN
		SELECT idCoupon FROM Coupon WHERE code = coupon_code AND startdate <= now() AND enddate >= now() INTO coupon_id;
		IF coupon_id IS NULL THEN
			RAISE EXCEPTION 'Invalid coupon';
		END IF;
	END IF;
 
	IF coupon_id IS NOT NULL THEN
		SELECT percentage FROM Coupon WHERE idCoupon = coupon_id INTO coupon_discount;
	ELSE
		coupon_discount := 0;
	END IF;
	INSERT INTO Orders(billing_address1, billing_address2, billing_city, billing_name, billing_phone, billing_zip1, billing_zip2,
					shipping_address1, shipping_address2, shipping_city, shipping_name, shipping_phone, shipping_zip1, shipping_zip2,
					nif, totalPrice, shippingCost, idUser, idCoupon)  
				(SELECT * FROM
					(SELECT address1 billing_address1, address2 billing_address2, City.name billing_city, 
						Address.name billing_name, phoneNumber billing_phone, code1 billing_zip1, code2 billing_zip2  
					 FROM address
					 NATURAL JOIN ZipCode 
					 INNER JOIN City ON ZipCode.idCity = City.idCity 
					 WHERE idAddress = billingAddress) billing_address,
					(SELECT address1 shipping_address1, address2 shipping_address2, City.name shipping_city, 
						Address.name shipping_name, phoneNumber shipping_phone, code1 shipping_zip1, code2 shipping_zip2  
					 FROM address
					 NATURAL JOIN ZipCode
					 INNER JOIN City ON ZipCode.idCity = City.idCity
					 WHERE idAddress = shippingAddress) shipping_address,
					 (SELECT order_nif, user_id AS idUser, coupon_id AS idCoupon) extraFields
				)	RETURNING idOrder INTO order_id;
	INSERT INTO ProductOrder(idproduct,idorder,price,quantity
)		SELECT idproduct,order_id AS idorder, price, quantity FROM ProductCart WHERE idUser = user_id ORDER BY product_position;
	DELETE FROM ProductCart WHERE idUser = user_id;
	RETURN order_id;
END;
$BODY$
LANGUAGE plpgsql;
-- Check if the favorites list belongs to the user
CREATE OR REPLACE FUNCTION check_favorite() RETURNS TRIGGER AS $BODY$
BEGIN
 IF NEW.idFavoriteList IS NOT NULL AND NOT EXISTS (SELECT * FROM FavoriteList WHERE idFavoriteList=NEW.idFavoriteList AND idUser = NEW.idUser) THEN
  RAISE EXCEPTION 'Favorite list % does not belong to user %', NEW.idFavoriteList, NEW.idUser;
 ELSE 
  RETURN NEW;
 END IF;
END;
$BODY$
LANGUAGE plpgsql;
 
DROP TRIGGER IF EXISTS FavoriteCheck ON Favorite;
CREATE TRIGGER FavoriteCheck BEFORE INSERT OR UPDATE
 ON Favorite
 FOR EACH ROW
 EXECUTE PROCEDURE check_favorite();
-- Check if discount doesn’t overlap with existing one and if creator the discount is admin
CREATE OR REPLACE FUNCTION check_discount() RETURNS TRIGGER AS $BODY$
BEGIN
 IF EXISTS (SELECT * FROM Discount WHERE idProduct = NEW.idProduct AND Discount.idDiscount <> NEW.idDiscount AND startDate <= NEW.endDate AND NEW.startDate <= endDate) THEN
  RAISE EXCEPTION 'Discount % overlaps with existing one', NEW.iddiscount;
 ELSIF NOT EXISTS (SELECT * FROM Users WHERE idUser = NEW.idUser AND isAdmin) THEN
  RAISE EXCEPTION 'Issuer % is not an admin', NEW.idUser;
 ELSE
  RETURN NEW;
 END IF;
END;
$BODY$
LANGUAGE plpgsql;
 
DROP TRIGGER IF EXISTS DiscountCheck ON Discount;
CREATE TRIGGER DiscountCheck BEFORE INSERT OR UPDATE
 ON Discount
 FOR EACH ROW
 EXECUTE PROCEDURE check_discount();
-- Check if coupon doesn’t overlap with existing one and if who creator the coupon is admin
CREATE OR REPLACE FUNCTION check_coupon() RETURNS TRIGGER AS $BODY$
BEGIN
 IF EXISTS (SELECT * FROM Coupon WHERE code = NEW.code AND startDate <= NEW.endDate AND NEW.startDate <= endDate) THEN
  RAISE EXCEPTION 'Coupon % overlaps with existing one', NEW.idCoupon;
 ELSIF NOT EXISTS (SELECT * FROM Users WHERE idUser = NEW.idUser AND isAdmin) THEN
  RAISE EXCEPTION 'Issuer % is not an admin', NEW.idUser;
 ELSE 
  RETURN NEW;
 END IF;
END;
$BODY$
LANGUAGE plpgsql;
 
DROP TRIGGER IF EXISTS CouponCheck ON Coupon;
CREATE TRIGGER CouponCheck BEFORE INSERT OR UPDATE
 ON Coupon
 FOR EACH ROW
 EXECUTE PROCEDURE check_coupon();
-- Get shipping costs and verify if weight is not null and if it isn’t too heavy
CREATE OR REPLACE FUNCTION get_shipping_costs(weight INTEGER) RETURNS NUMERIC AS $BODY$
DECLARE shipping_cost NUMERIC;
BEGIN
 IF weight IS NULL THEN
 	 RETURN 0;
 END IF;
 SELECT price FROM shippingcosts WHERE maxweight >= weight ORDER BY maxweight LIMIT 1
 	INTO shipping_cost;
 IF shipping_cost IS NULL THEN
  RAISE EXCEPTION 'Too heavy';
 ELSE 
  RETURN shipping_cost;
 END IF;
END;
$BODY$
LANGUAGE plpgsql;
-- Check that there are no categories with the same subcategory as supercategory
CREATE OR REPLACE FUNCTION check_category_loop() RETURNS TRIGGER AS
$$
BEGIN
 IF NEW.idCategory IN (WITH RECURSIVE category_ancestors AS (
  SELECT idCategory, idSuperCategory
  FROM Category
  WHERE idCategory = NEW.idSuperCategory
  UNION ALL
  SELECT c.idCategory, c.idSuperCategory
  FROM Category c
   JOIN category_ancestors p ON p.idSuperCategory = c.idCategory
 ) SELECT idCategory FROM (SELECT * FROM category_ancestors WHERE idCategory <> NEW.idSuperCategory) x)
 THEN
  RAISE EXCEPTION 'Category % would create a loop', NEW.idCategory;
  RETURN OLD;
 END IF;
 RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
DROP TRIGGER IF EXISTS CheckCategoryLoopTrigger ON Category;
CREATE TRIGGER CheckCategoryLoopTrigger
BEFORE UPDATE ON Category
FOR EACH ROW
EXECUTE PROCEDURE check_category_loop();
-- Check if coupon used in an order is valid
CREATE OR REPLACE FUNCTION check_order() RETURNS TRIGGER AS $BODY$
BEGIN
 IF NEW.idCoupon IS NOT NULL AND NOT EXISTS (SELECT * FROM Coupon WHERE idCoupon = NEW.idCoupon AND startDate <= NEW.orderDate AND endDate >= NEW.orderDate) THEN
 	RAISE EXCEPTION 'Order %: Invalid coupon', NEW.idOrder;
 END IF;
 RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;
 
DROP TRIGGER IF EXISTS OrderCheck ON Orders;
CREATE TRIGGER OrderCheck BEFORE INSERT OR UPDATE
 ON Orders
 FOR EACH ROW
 EXECUTE PROCEDURE check_order();
 
-- Get categories products and their subcategories
 CREATE OR REPLACE FUNCTION get_category_products(category_id INTEGER) RETURNS SETOF INTEGER AS
$BODY$
BEGIN
RETURN QUERY 
	WITH RECURSIVE childs( idcategory ) 
	AS (
	  SELECT idcategory, idsupercategory
	  FROM category
	  WHERE idcategory = category_id
 
	  UNION ALL
 
	  SELECT t.idcategory, t.idsupercategory
	  FROM childs c
	  JOIN category t
	  ON t.idsupercategory = c.idcategory
	)
	SELECT DISTINCT idProduct FROM childs
	INNER JOIN CategoryProduct USING(idCategory)
	INNER JOIN Product USING(idProduct);
END;
$BODY$ LANGUAGE plpgsql;
-- Add a photo by shifting to the right the photos that have a bigger order than the new one at that specific position
CREATE OR REPLACE FUNCTION add_photo(product_id INTEGER, new_order INTEGER, new_location TEXT) RETURNS void AS $BODY$
BEGIN
	UPDATE Photo SET photo_order = photo_order + 1 WHERE idProduct = product_id AND photo_order >= new_order;
	INSERT INTO Photo(idproduct,photo_order,location) VALUES (product_id, new_order, new_location);
END;
$BODY$
LANGUAGE plpgsql;
 
CREATE OR REPLACE FUNCTION update_photo_order(product_id INTEGER, old_order INTEGER, new_order INTEGER) RETURNS void AS $BODY$
DECLARE photo_location TEXT;
BEGIN
	DELETE FROM Photo WHERE idProduct = product_id AND photo_order = old_order RETURNING location INTO photo_location;
	IF (old_order > new_order) THEN
		UPDATE Photo SET photo_order = photo_order + 1 WHERE idProduct = product_id AND photo_order >= new_order AND photo_order < old_order;
	ELSEIF (old_order < new_order) THEN
		UPDATE Photo SET photo_order = photo_order - 1 WHERE idProduct = product_id AND photo_order > old_order AND photo_order <= new_order;
	END IF;
	INSERT INTO Photo(idProduct,photo_order,location) VALUES (product_id,new_order,photo_location);
END;
$BODY$
LANGUAGE plpgsql;
 
CREATE OR REPLACE FUNCTION delete_photo(product_id INTEGER, delete_order INTEGER) RETURNS TEXT AS $BODY$
DECLARE photo_location TEXT;
BEGIN
	DELETE FROM Photo WHERE idProduct = product_id AND photo_order = delete_order RETURNING location INTO photo_location;
	UPDATE Photo SET photo_order = photo_order - 1 WHERE idProduct = product_id AND photo_order > delete_order;
	RETURN photo_location;
END;
$BODY$
LANGUAGE plpgsql;
 
 
-- Product purchases update
CREATE OR REPLACE FUNCTION product_purchases_update() RETURNS TRIGGER AS $$
BEGIN
	IF TG_OP = 'INSERT' AND (NEW.product_status != 'Canceled') THEN
		UPDATE Product SET purchases = purchases + NEW.quantity WHERE Product.idProduct = NEW.idProduct;
	ELSEIF TG_OP = 'UPDATE' THEN
		IF (OLD.idproduct <> NEW.idproduct) AND (OLD.product_status != 'Canceled') THEN
			UPDATE Product SET purchases = purchases - OLD.quantity WHERE Product.idProduct = OLD.idProduct;
		END IF;
		IF (OLD.product_status = 'Canceled') AND (NEW.product_status != 'Canceled') THEN
			UPDATE Product SET purchases = purchases + NEW.quantity WHERE Product.idProduct = NEW.idProduct;
		END IF;
	ELSEIF TG_OP = 'DELETE' AND (OLD.product_status != 'Canceled') THEN
		UPDATE Product SET purchases = purchases - OLD.quantity WHERE Product.idProduct = OLD.idProduct;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
DROP TRIGGER IF EXISTS OnProductOrderTrigger ON ProductOrder;
CREATE TRIGGER OnProductOrderTrigger
AFTER INSERT OR UPDATE OR DELETE ON ProductOrder
FOR EACH ROW EXECUTE PROCEDURE
product_purchases_update();
-- Insert an address, verifying if zip code is valid
CREATE OR REPLACE FUNCTION insert_address(idUser INTEGER, name TEXT, address1 TEXT, address2 TEXT, phoneNumber TEXT, zip1 INTEGER, zip2 INTEGER) RETURNS void AS $BODY$
DECLARE zipcode_id INTEGER;
BEGIN
 SELECT idZipCode FROM ZipCode WHERE code1 = zip1 AND code2 = zip2 INTO zipcode_id;
IF zipcode_id IS NULL THEN
 RAISE EXCEPTION 'Invalid Zip Code';
END IF;
 INSERT INTO Address (address1, address2, name, phoneNumber, idUser, idZipCode) VALUES (address1,address2,name,phoneNumber,idUser,zipcode_id);
END;
$BODY$
LANGUAGE plpgsql;
-- Change product order state  
CREATE OR REPLACE FUNCTION changed_product_order() RETURNS TRIGGER AS $BODY$
DECLARE coupon_discount INTEGER;
BEGIN
	IF NOT EXISTS (SELECT * FROM ProductOrder WHERE idOrder = NEW.idorder AND product_status <> 'Canceled') THEN
 		UPDATE Orders SET order_status = 'Canceled' WHERE idOrder = NEW.idOrder;
 	ELSEIF NOT EXISTS (SELECT * FROM ProductOrder WHERE idOrder = NEW.idorder AND product_status = 'Pending') THEN
 		UPDATE Orders SET order_status = 'Sent' WHERE idOrder = NEW.idOrder;
 	ELSEIF EXISTS (SELECT * FROM ProductOrder WHERE idOrder = NEW.idorder AND product_status = 'Sent') THEN
 		UPDATE Orders SET order_status = 'Partially Sent' WHERE idOrder = NEW.idOrder;
 	ELSEIF NOT EXISTS (SELECT * FROM Orders WHERE idOrder = NEW.idOrder AND order_status = 'Payment Pending') THEN
 		UPDATE Orders SET order_status = 'Pending' WHERE idOrder = NEW.idOrder;
 	END IF;
 	IF TG_OP = 'INSERT' AND NEW.product_status <> 'Canceled' THEN
		UPDATE Product SET stock = stock - NEW.quantity WHERE idProduct = NEW.idProduct;
	ELSEIF TG_OP = 'UPDATE' THEN
   	 	IF NEW.product_status <> 'Canceled' AND NEW.quantity <> OLD.quantity THEN
    		 	UPDATE Product SET stock = stock + OLD.quantity - NEW.quantity WHERE idProduct = NEW.idProduct;
   	 	ELSEIF NEW.product_status = 'Canceled' AND NEW.product_status <> OLD.product_status THEN
    		 	UPDATE Product SET stock = stock + OLD.quantity WHERE idProduct = NEW.idProduct;
   	 	END IF;
 	END IF;
 
 	IF EXISTS (SELECT * FROM Orders WHERE idOrder = NEW.idOrder AND idCoupon IS NOT NULL) THEN
 	 	SELECT percentage FROM Orders
 	 	LEFT JOIN Coupon USING(idCoupon)
	 	WHERE idOrder = NEW.idOrder 
	 	INTO coupon_discount;
  	ELSE
  	 	coupon_discount := 0;
  	END IF;

  	UPDATE Orders SET totalprice = costs.totalprice, shippingCost = costs.shippingCost
  	FROM
  	(SELECT COALESCE((100-coupon_discount)*productsCost/100.0 + shippingCost,0) AS totalPrice, shippingCost FROM
 	 	(SELECT SUM(ProductOrder.price) AS productsCost, get_shipping_costs(SUM(weight)::INTEGER) AS shippingCost
 		 	FROM ProductOrder
 		 	INNER JOIN Product USING(idProduct)
 		 	WHERE idOrder = NEW.idOrder AND product_status != 'Canceled') subcosts) costs
  	WHERE idOrder = NEW.idOrder;
 
 	RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;
 
DROP TRIGGER IF EXISTS OnProductOrderChange ON ProductOrder;
CREATE TRIGGER OnProductOrderChange AFTER INSERT OR UPDATE
	ON ProductOrder
	FOR EACH ROW
	EXECUTE PROCEDURE changed_product_order();

CREATE OR REPLACE FUNCTION create_recovery_token(mail TEXT, rand_token TEXT) RETURNS INTEGER AS $BODY$
DECLARE id INTEGER;
BEGIN
	SELECT idUser FROM users WHERE users.email = mail INTO id;
	IF id IS NULL THEN
		RAISE EXCEPTION 'Email not found';
	ELSE
		DELETE FROM password_recovery WHERE iduser = id;
		INSERT INTO password_recovery (idUser, token) VALUES (id, rand_token);
		RETURN id;
	END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION reset_password(user_id INTEGER, new_pw TEXT, tok TEXT) RETURNS void AS $BODY$
DECLARE id INTEGER;
BEGIN
	SELECT idUser FROM password_recovery WHERE idUser = user_id AND token = tok INTO id;
	IF id IS NULL THEN
		RAISE EXCEPTION 'Invalid token';
	ELSE
		UPDATE users SET password = new_pw WHERE idUser = user_id;
		DELETE FROM password_recovery WHERE iduser = user_id;
	END IF;
END;
$BODY$
LANGUAGE plpgsql;






