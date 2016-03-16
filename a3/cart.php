<?php 
$title = "Cart";
$css = ["cart.css"];
$remove_categories = true;
include("templates/header.php") ?>

		<div id="cart">
			<div class="top_row row">
				<div id="cart_title" class="col-xs-12 col-sm-8">
					<span class="title"><span class="glyphicon glyphicon-shopping-cart"></span> Shopping Cart</span>
				</div>
				<div class="hidden-xs col-xs-2">
					Quantity
				</div>
				<div class="hidden-xs col-xs-2">
					Price
				</div>
			</div>
			<div class="content">
				<div class="row">
					<div class="col-xs-12 col-sm-8">
						<a href="#" class="link-p">
							<img class="product_img" src="Images/product-1.jpg" alt="">
						</a>
						<div class="product_info">
							<a href="#"><span class="product_title">Age Of Wisdom Tan Graphic Tee</span></a>
							<br>
							<div class="desc">
							</div>
							<a href="#"><span class="glyphicon glyphicon-remove"></span>Delete</a>
						</div>
					</div>
					<div class="col-xs-2">
						<div class="qty_price">
							<input type="text" class="form-control qty" value="1">
						</div>
					</div>
					<div class="col-xs-2">
						<div class="qty_price">49.99€</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-8">
						<a href="#" class="link-p">
							<img class="product_img" src="Images/product-2.jpg" alt="">
						</a>
						<div class="product_info">
							<a href="#"><span class="product_title">Classic Laundry Green Graphic T-Shirt</span></a>
							<br>
							<div class="desc">
							</div>
							<a href="#"><span class="glyphicon glyphicon-remove"></span>Delete</a>
						</div>
					</div>
					<div class="col-xs-2">
						<div class="qty_price">
							<input type="text" class="form-control qty" value="2">
						</div>
					</div>
					<div class="col-xs-2">
						<div class="qty_price">70€</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-8">
						<a href="#" class="link-p">
							<img class="product_img" src="Images/product-3.jpg" alt="">
						</a>
						<div class="product_info">
							<a href="#"><span class="product_title">Classic Laundry Green Graphic T-Shirt</span></a>
							<br>
							<div class="desc">
							</div>
							<a href="#"><span class="glyphicon glyphicon-remove"></span>Delete</a>
						</div>
					</div>
					<div class="col-xs-2">
						<div class="qty_price">
							<input type="text" class="form-control qty" value="1">
						</div>
					</div>
					<div class="col-xs-2">
						<div class="qty_price">34.99€</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-8"></div>
					<div class="col-xs-2 subtotal">Subtotal: </div>
					<div class="col-xs-2">
						<span>154.89€</span>
					</div>
				</div>
			</div>
		</div>
		<a href="checkout.php" id="btn-update" class="btn btn-primary pull-right">
			<span>Checkout </span><span class="glyphicon glyphicon-chevron-right"></span>
		</a>
		<a href="#" id="btn-checkout" class="btn btn-warning pull-right">
			<span>Update </span><span class="glyphicon glyphicon-refresh"></span>
		</a>
<?php include("templates/footer.php") ?>