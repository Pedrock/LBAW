--Drops
DROP TABLE IF EXISTS MetadataCategory CASCADE;
DROP TABLE IF EXISTS Metadata CASCADE;
DROP TABLE IF EXISTS Product CASCADE;
DROP TABLE IF EXISTS Category CASCADE;
DROP TABLE IF EXISTS ShippingCosts CASCADE;
DROP TABLE IF EXISTS Photo CASCADE;
DROP TABLE IF EXISTS Discount CASCADE;
DROP TABLE IF EXISTS Users CASCADE;
DROP TABLE IF EXISTS FavoriteList CASCADE;
DROP TABLE IF EXISTS Address CASCADE;
DROP TABLE IF EXISTS ProductOrder CASCADE;
DROP TABLE IF EXISTS ProductCart CASCADE;
DROP TABLE IF EXISTS Review CASCADE;
DROP TABLE IF EXISTS Favorite CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS ZipCode CASCADE;
DROP TABLE IF EXISTS City CASCADE;
DROP TABLE IF EXISTS Coupon CASCADE;
DROP TABLE IF EXISTS CategoryProduct CASCADE;
DROP TABLE IF EXISTS CarouselPhoto CASCADE;
DROP TABLE IF EXISTS password_recovery;
DROP TABLE IF EXISTS login_tokens;
DROP TYPE IF EXISTS OrderStatus CASCADE;
DROP TYPE IF EXISTS ProductOrderStatus CASCADE;
 
 
--Creates
 
CREATE TABLE Product(
	idProduct SERIAL PRIMARY KEY,
	averageScore FLOAT CHECK(averageScore >= 1 AND averageScore <= 5),
	description TEXT NOT NULL,
	name TEXT NOT NULL,
	price NUMERIC(12,2) NOT NULL CHECK(price > 0), 
        purchases INTEGER NOT NULL DEFAULT 0,
	stock INTEGER NOT NULL CHECK(stock >= 0),
	weight INTEGER NOT NULL CHECK(weight > 0),
        isDeleted BOOLEAN DEFAULT FALSE
);
 
CREATE TABLE Photo(
	idProduct INTEGER NOT NULL REFERENCES Product(idProduct),
	photo_order INTEGER NOT NULL,
	location TEXT NOT NULL,
	CONSTRAINT PhotoPrimary PRIMARY KEY (idProduct, photo_order) DEFERRABLE INITIALLY DEFERRED
);
 
CREATE TABLE MetadataCategory(
	idMetadataCategory SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);
 
CREATE TABLE Metadata(
	idMetadataCategory INTEGER NOT NULL REFERENCES MetadataCategory(idMetadataCategory),
	idProduct INTEGER NOT NULL REFERENCES Product(idProduct),
	description TEXT NOT NULL,
	CONSTRAINT MetadataPrimary PRIMARY KEY (idMetadataCategory, idProduct)
);
 
CREATE TABLE Category(
	idCategory SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	idSuperCategory INTEGER REFERENCES Category(idCategory) ON DELETE CASCADE,
	CHECK (idCategory != idSuperCategory) 
);
 
CREATE TABLE ShippingCosts(
	idShippingCosts SERIAL PRIMARY KEY,
	maxWeight INTEGER NOT NULL CHECK(maxWeight > 0),
	price NUMERIC(12,2) NOT NULL CHECK(price > 0)
);
 
 
CREATE TABLE Users(
	idUser SERIAL PRIMARY KEY,
	email TEXT NOT NULL UNIQUE,
	isAdmin BOOLEAN NOT NULL DEFAULT FALSE,
	isDeleted BOOLEAN NOT NULL DEFAULT FALSE,
	nif TEXT NOT NULL,
	password TEXT NOT NULL,
	username TEXT NOT NULL UNIQUE
);
 
 
CREATE TABLE Discount(
	idDiscount SERIAL PRIMARY KEY,
	endDate TIMESTAMP NOT NULL,
	percentage INTEGER NOT NULL CHECK(percentage > 0 AND percentage < 100),
	startDate TIMESTAMP NOT NULL CHECK(startDate < endDate),
	idProduct INTEGER NOT NULL REFERENCES Product(idProduct),
	idUser INTEGER NOT NULL REFERENCES Users(idUser)
);
 
 
CREATE TABLE FavoriteList(
	idFavoriteList SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	idUser INTEGER NOT NULL REFERENCES Users(idUser)
);
 
 
CREATE TABLE City(
	idCity SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);
 
CREATE TABLE ZipCode(
	idZipCode SERIAL PRIMARY KEY,
	code1 INTEGER NOT NULL,
	code2 INTEGER NOT NULL,
	idCity INTEGER NOT NULL REFERENCES City(idCity),
	CONSTRAINT UniqueZipCode UNIQUE (code1, code2)
);
 
 
CREATE TABLE Address(
	idAddress SERIAL PRIMARY KEY,
	address1 TEXT NOT NULL,
	address2 TEXT,
	name TEXT NOT NULL,
	phoneNumber TEXT NOT NULL,
	idUser INTEGER NOT NULL REFERENCES Users(idUser),
	idZipCode INTEGER NOT NULL REFERENCES ZipCode(idZipCode)
);
 
CREATE TABLE Coupon(
	idCoupon SERIAL PRIMARY KEY,
	endDate TIMESTAMP NOT NULL,
	percentage INTEGER NOT NULL,
	code TEXT NOT NULL,
	startDate TIMESTAMP NOT NULL CHECK(startDate < endDate),
	idUser INTEGER NOT NULL REFERENCES Users(idUser)
);
 
CREATE TYPE OrderStatus AS ENUM ('Payment Pending', 'Pending', 'Sent', 'Canceled', 'Partially Sent');
 
CREATE TABLE Orders(
	idOrder SERIAL PRIMARY KEY,
	billing_address1 TEXT NOT NULL,
	billing_address2 TEXT,
	billing_city TEXT NOT NULL,
	billing_name TEXT NOT NULL,
	billing_phone TEXT NOT NULL,
	billing_zip1 TEXT NOT NULL,
	billing_zip2 TEXT NOT NULL,
	nif TEXT NOT NULL,
	orderDate TIMESTAMP NOT NULL DEFAULT now(),
	order_status OrderStatus DEFAULT 'Payment Pending',
	paymentDate TIMESTAMP,
	shipping_address1 TEXT NOT NULL,
	shipping_address2 TEXT,
	shipping_city TEXT NOT NULL,
	shipping_name TEXT NOT NULL,
	shipping_phone TEXT NOT NULL,
	shipping_zip1 TEXT NOT NULL,
	shipping_zip2 TEXT NOT NULL,
	shippingDate DATE,
	totalPrice NUMERIC(12,2) NOT NULL DEFAULT(0) CHECK(totalPrice >= 0),
	shippingCost NUMERIC(12,2) NOT NULL DEFAULT(0) CHECK(shippingCost >= 0),
	idUser INTEGER NOT NULL REFERENCES Users(idUser),
	idCoupon INTEGER REFERENCES Coupon(idCoupon)
);
 
CREATE TABLE CategoryProduct(
	idCategory INTEGER NOT NULL REFERENCES Category(idCategory) ON DELETE CASCADE,
	idProduct  INTEGER NOT NULL REFERENCES Product(idProduct) ON DELETE CASCADE,
	CONSTRAINT CategoryProductPrimary PRIMARY KEY (idCategory, idProduct)
);
 
CREATE TYPE ProductOrderStatus AS ENUM ('Pending', 'Sent', 'Canceled');
 
CREATE TABLE ProductOrder(
	idProduct INTEGER NOT NULL REFERENCES Product(idProduct),
	idOrder INTEGER NOT NULL REFERENCES Orders(idOrder),
	price NUMERIC(12,2) NOT NULL CHECK(price >= 0), 
	quantity INTEGER NOT NULL CHECK(quantity > 0),
	product_status ProductOrderStatus DEFAULT 'Pending',
	product_position SERIAL NOT NULL,
	CONSTRAINT ProductOrderPrimary PRIMARY KEY (idProduct, idOrder)
);
 
CREATE TABLE ProductCart(
	idProduct INTEGER NOT NULL REFERENCES Product(idProduct),
	idUser INTEGER NOT NULL REFERENCES Users(idUser),
	price NUMERIC(12,2) NOT NULL CHECK(price >= 0), 
	quantity INTEGER NOT NULL CHECK(quantity > 0),
	product_position SERIAL NOT NULL,
	CONSTRAINT ProductCartPrimary PRIMARY KEY (idProduct, IdUser)
);
 
CREATE TABLE Review(
	idProduct INTEGER NOT NULL REFERENCES Product(idProduct),
	idUser INTEGER NOT NULL REFERENCES Users(idUser),
	body TEXT,
	score INTEGER NOT NULL CHECK(score >= 1 AND score <= 5),
	review_date TIMESTAMP NOT NULL DEFAULT now(),
	CONSTRAINT ReviewPrimary PRIMARY KEY (idProduct, IdUser)
);
 
CREATE TABLE Favorite(
	idProduct INTEGER NOT NULL REFERENCES Product(idProduct),
	idUser INTEGER NOT NULL REFERENCES Users(idUser),
	idFavoriteList INTEGER REFERENCES FavoriteList(idFavoriteList) ON DELETE CASCADE,
	product_position SERIAL NOT NULL,
	CONSTRAINT FavoritePrimary PRIMARY KEY (idProduct, IdUser)
);
 
CREATE TABLE CarouselPhoto(
	idCarouselPhoto SERIAL NOT NULL PRIMARY KEY,
        active BOOLEAN NOT NULL DEFAULT TRUE,
	photo_order INTEGER NOT NULL UNIQUE,
	location TEXT NOT NULL UNIQUE,
	link TEXT
);
 
CREATE TABLE login_tokens(
	idUser INTEGER NOT NULL REFERENCES Users(idUser),
	token TEXT NOT NULL
);
 
CREATE TABLE password_recovery(
	idUser INTEGER PRIMARY KEY REFERENCES Users(idUser),
	token TEXT NOT NULL,
	expires TIMESTAMP NOT NULL DEFAULT now() + INTERVAL '1 day'
);








-- View
DROP TABLE IF EXISTS product_search;
CREATE TABLE product_search AS
	SELECT 
		p.idProduct, 
		setweight(to_tsvector(p.name), 'A') 
		|| setweight(to_tsvector(p.description), 'C') 
		|| setweight(to_tsvector((SELECT array_to_string(array(SELECT description FROM metadata WHERE metadata.idProduct=p.idProduct), ', '))), 'B') AS tsv
	FROM Product AS p;
 
-- Index
CREATE INDEX product_search_idx ON product_search USING GIN(tsv);
 
-- Triggers
CREATE OR REPLACE FUNCTION product_search_insert() RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO product_search SELECT 
		Product.idProduct, 
		setweight(to_tsvector(Product.name), 'A') 
		|| setweight(to_tsvector(Product.description), 'C') 
		|| setweight(to_tsvector((SELECT array_to_string(array(SELECT description FROM metadata WHERE metadata.idProduct=Product.idProduct), ', '))), 'B') AS tsv
	FROM Product WHERE Product.idProduct = NEW.idProduct;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE OR REPLACE FUNCTION product_search_update_product(product_id INTEGER) RETURNS void AS $$
BEGIN
	UPDATE product_search SET tsv = (SELECT 
		setweight(to_tsvector(Product.name), 'A') 
		|| setweight(to_tsvector(Product.description), 'C') 
		|| setweight(to_tsvector((SELECT array_to_string(array(SELECT description FROM metadata WHERE metadata.idProduct=Product.idProduct), ', '))), 'B')
			FROM Product WHERE Product.idProduct = product_id)
	WHERE product_search.idProduct = product_id;
END;
$$ LANGUAGE plpgsql;
 
CREATE OR REPLACE FUNCTION product_search_update() RETURNS TRIGGER AS $$
BEGIN
	IF (OLD.idproduct <> NEW.idproduct) THEN
		DELETE FROM product_search WHERE idProduct = OLD.idProduct;
		INSERT INTO product_search SELECT 
			p.idProduct, 
			setweight(to_tsvector(p.name), 'A') 
			|| setweight(to_tsvector(p.description), 'C') 
			|| setweight(to_tsvector((SELECT array_to_string(array(SELECT description FROM metadata WHERE metadata.idProduct=p.idProduct), ', '))), 'B') AS tsv
			FROM Product AS p WHERE p.idProduct = NEW.idProduct;
	ELSE
		PERFORM product_search_update_product(NEW.idProduct);
	END IF;
 
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE OR REPLACE FUNCTION product_search_delete() RETURNS TRIGGER AS $$
BEGIN
	DELETE FROM product_search WHERE idProduct = OLD.idProduct;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;
 
CREATE OR REPLACE FUNCTION product_search_metadata_update() RETURNS TRIGGER AS $$
BEGIN
	IF TG_OP = 'DELETE' OR (TG_OP = 'UPDATE' AND OLD.idproduct <> NEW.idproduct) THEN
		PERFORM product_search_update_product(OLD.idProduct);
	END IF;
	IF NOT TG_OP = 'DELETE' THEN
		PERFORM product_search_update_product(NEW.idProduct);
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
DROP TRIGGER IF EXISTS OnProductInsert ON Product;
CREATE TRIGGER OnProductInsert
AFTER INSERT ON Product
FOR EACH ROW EXECUTE PROCEDURE
product_search_insert();
 
DROP TRIGGER IF EXISTS OnProductUpdate ON Product;
CREATE TRIGGER OnProductUpdate
AFTER UPDATE ON Product
FOR EACH ROW EXECUTE PROCEDURE
product_search_update();
 
DROP TRIGGER IF EXISTS OnProductDelete ON Product;
CREATE TRIGGER OnProductDelete
AFTER DELETE ON Product
FOR EACH ROW EXECUTE PROCEDURE
product_search_delete();
 
DROP TRIGGER IF EXISTS OnMetadataTrigger ON Metadata;
CREATE TRIGGER OnMetadataTrigger
AFTER INSERT OR UPDATE OR DELETE ON Metadata
FOR EACH ROW EXECUTE PROCEDURE
product_search_metadata_update();









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
CREATE OR REPLACE FUNCTION add_to_cart(userId INTEGER, productId INTEGER, quantity INTEGER) RETURNS void AS $BODY$
BEGIN
	INSERT INTO ProductCart(userId,productId,quantity,price) 
		VALUES (userId,productId,quantity, (SELECT price FROM Product WHERE productId = productId));
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
 IF EXISTS (SELECT * FROM Discount WHERE idProduct = NEW.idProduct AND startDate <= NEW.endDate AND NEW.startDate <= endDate) THEN
  RAISE EXCEPTION 'Discount % overlaps with existing one', iddiscount;
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
 	 RAISE EXCEPTION 'Null weight';
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
 
CREATE OR REPLACE FUNCTION delete_photo(product_id INTEGER, delete_order INTEGER) RETURNS void AS $BODY$
BEGIN
	DELETE FROM Photo WHERE idProduct = product_id AND photo_order = delete_order;
	UPDATE Photo SET photo_order = photo_order - 1 WHERE idProduct = product_id AND photo_order > delete_order;
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
  	(SELECT (100-coupon_discount)*productsCost/100.0 + shippingCost AS totalPrice, shippingCost FROM
 	 	(SELECT SUM(get_product_price(Product.idProduct)) AS productsCost, get_shipping_costs(SUM(weight)::INTEGER) shippingCost
 		 	FROM ProductOrder
 		 	INNER JOIN Product USING(idProduct)
 		 	WHERE idOrder = NEW.idOrder) subcosts) costs
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







CREATE UNIQUE INDEX UsernameLower ON Users(LOWER(username));
CREATE UNIQUE INDEX EmailLower ON Users(LOWER(email));
CREATE INDEX CouponCode ON Coupon USING hash(code);
CREATE INDEX CouponStartdate ON Coupon (startdate);
CREATE INDEX CouponEnddate ON Coupon (enddate);
CREATE INDEX DiscountProduct ON Discount (idproduct);
CREATE INDEX DiscountStartdate ON Discount (startdate);
CREATE INDEX DiscountEnddate ON Discount (enddate);
CREATE INDEX AddressUser ON Address(idUser);
CREATE INDEX OrderUser ON Orders(idUser);
CREATE INDEX FavoriteUser ON Favorite(idUser,product_position);
CREATE INDEX FavoriteListUser ON FavoriteList(idUser,idFavoriteList);
CREATE INDEX ProductOrderPosition ON ProductOrder(idOrder,product_position);
CREATE INDEX ProductCartPosition ON ProductCart(idUser,product_position);


 
CLUSTER CategoryProduct USING categoryproductprimary; 
CLUSTER Photo USING photoprimary; 
CLUSTER Review USING reviewprimary; 
CLUSTER Orders USING orderuser; 
CLUSTER Favorite USING favoriteuser;
CLUSTER Address USING AddressUser;
CLUSTER FavoriteList USING FavoriteListUser; 
CLUSTER ProductOrder USING ProductOrderPosition; 
CLUSTER ProductCart USING ProductCartPosition;