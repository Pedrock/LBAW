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
	idUser INTEGER NOT NULL REFERENCES Users(idUser),
	isDeleted BOOLEAN NOT NULL DEFAULT FALSE
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





