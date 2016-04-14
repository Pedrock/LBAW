-- Search
SELECT idProduct
FROM product_search
INNER JOIN Product USING(idProduct)
WHERE tsv @@ plainto_tsquery(SEARCH_QUERY)
ORDER BY ts_rank_cd(tsv, plainto_tsquery(SEARCH_QUERY));

-- UI01 - Homepage
-- Main Categories
SELECT idCategory, name FROM Category
	WHERE idSuperCategory IS NULL;

-- Featured Products
SELECT idProduct, 
    name, 
    get_product_price(idProduct) price, 
    (SELECT location FROM Photo WHERE Photo.idProduct = Product.idProduct ORDER BY photo_order LIMIT 1)
FROM
((SELECT idProduct
    FROM Product
    INNER JOIN Discount USING(idProduct)
    ORDER BY percentage DESC)
UNION
(SELECT idProduct
    FROM Product
    ORDER BY purchases)) products
LEFT JOIN Product USING(idProduct)
LIMIT 8 OFFSET 0;
	
-- Subcategories
SELECT idCategory, name FROM Category
	WHERE idSuperCategory = CATEGORIA;

-- Carrossel
SELECT location FROM CarrosselPhoto ORDER BY photo_order;

-- UI02 - Login page
SELECT idUser FROM Users WHERE (LOWER(username) = LOWER(INPUT_USERNAME) OR LOWER(email) = LOWER(INPUT_EMAIL)) AND password = INPUT_PASSWORD;

-- UI03 - Register page
INSERT INTO Users(username,email,password) VALUES (INPUT_USERNAME,INPUT_EMAIL,INPUT_PASSWORD);

-- UI04 - Cart page	
-- Cart page
SELECT ProductCart.idProduct idProduct, name, quantity, ProductCart.price cart_price, get_product_price(idProduct) price, stock >= quantity enough_stock
    FROM ProductCart
    INNER JOIN Product USING(idProduct)
    WHERE ProductCart.idUser = USER
    ORDER BY product_position;
 
-- Update quantity
UPDATE ProductCart SET quantity = NOVA_QUANTIDADE WHERE idUser = USER AND idProduct = PRODUTO;

-- Remove product from cart
DELETE FROM ProductCart WHERE idUser = USER AND idProduct = PRODUTO;

-- UI05
-- User Addresses
SELECT idAddress, address1, address2, Address.name, phoneNumber, code1, code2, City.name as cityName 
FROM Address
INNER JOIN zipcode USING(idZipcode)
INNER JOIN city USING(idCity)
WHERE idUser = USER;  

-- UI06 - Order Confirmation
SELECT make_order(user_id, billingAddress, shippingAddress, order_nif, coupon_code);

-- UI07 - Product page
-- Information about a product
SELECT name,description,averagescore,stock,price,discount,new_price FROM Product,get_product_discount_and_price(idProduct)
WHERE idProduct = PRODUCT;

-- Product photos
SELECT location FROM Photo 
	WHERE idProduct = PRODUCT
		ORDER BY photo_order;
		
-- Product reviews
SELECT * FROM Review WHERE Review.idProduct = PRODUTO AND body IS NOT NULL
    ORDER BY review_date DESC
    LIMIT 8 OFFSET 0;

-- Add review
INSERT INTO REVIEW(idProduct,idUser,score,body) VALUES(PRODUTO,USER, Pontuação de 1 a 5, Review ou NULL);

-- UI08 - My Orders page
SELECT idOrder, orderDate, totalPrice 
    FROM Orders 
    ORDER BY orderDate DESC
    LIMIT 10;
    
SELECT idOrder, idProduct, quantity, price, product_status
    FROM ProductOrder
    ORDER BY idOrder, product_position
    WHERE idOrder in (Lista);

-- UI09 - Category page
-- Products belonging to one category
SELECT idproduct,name,get_product_price(idProduct) price FROM get_category_products(CATEGORY) AS idProduct
    INNER JOIN Product USING(idProduct)
        LIMIT 8 OFFSET 0;

-- UI10 - My favorites page     
-- All favorite lists of an user
SELECT idFavoriteList,name FROM FavoriteList
    WHERE idUser = USER
        ORDER BY (idFavoriteList);

-- All products belonging to all the favorite lists of an User
SELECT idFavoriteList,Product.* FROM Favorite
INNER JOIN Product USING(idProduct)
LEFT JOIN FavoriteList USING(idFavoriteList)
WHERE Favorite.idUser = USER
ORDER BY (idFavoriteList) NULLS FIRST;

-- Delete favorite
DELETE FROM Favorite WHERE idUser = USER AND idProduct = PRODUTO 

-- Move favorite
UPDATE Favorite SET idFavoriteList = NEW_LIST;

-- UI11 - Administration - Add product
-- New product
INSERT INTO Product(name, price, stock, weight, description) VALUES (NOME, PREÇO EM EUROS, STOCK, PESO EM GRAMAS, DESCRIÇÃO) RETURNING RETURNING idProduct;
INSERT INTO Photo(idProduct, photo_order, location) VALUES (idProduct, 1, LOCALIZAÇÃO_FOTO1);
INSERT INTO Photo(idProduct, photo_order, location) VALUES (idProduct, 2, LOCALIZAÇÃO_FOTO2);
...
INSERT INTO CategoryProduct(idProduct, idCategory) VALUES(idProduct, ID_CATEGORIA1);
INSERT INTO CategoryProduct(idProduct, idCategory) VALUES(idProduct, ID_CATEGORIA2);
...


--UI05 - Checkout page
SELECT Address.name, address1, address2,nif FROM Address
INNER JOIN Users USING(idUser)
WHERE idUser = USER;


--UI06 - Order Confirmation
--informação relativa aos produtos (EXEMPLO USER 1)
SELECT ProductOrder.idProduct, (SELECT location FROM Photo WHERE Photo.idProduct = Product.idProduct ORDER BY photo_order LIMIT 1), ProductOrder.quantity, name, ProductOrder.price FROM ProductOrder, Product
WHERE ProductOrder.idProduct = Product.idProduct
AND ProductOrder.idOrder = USER;


--informação relativa à encomenda
SELECT totalPrice, shipping_name, shipping_phone, shipping_address1, shipping_address2, shipping_city, shipping_zip1, shipping_zip2, billing_name, billing_phone, billing_address1, billing_address2, billing_city, billing_zip1, billing_zip2 FROM Orders 
WHERE idOrder = USER;









