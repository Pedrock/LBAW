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