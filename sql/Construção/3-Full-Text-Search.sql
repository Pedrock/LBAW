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







