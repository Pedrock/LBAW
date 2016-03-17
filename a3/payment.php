<?php 
	$title = "Payment";
	$css = ["payment.css"];
	$remove_categories = true;
	include("templates/header.php")
?>
<div id="order">
	<div class="top_row row">
		<span class="title"><span class="glyphicon glyphicon-shopping-cart"> </span> Your order</span>
	</div>
	<div class="row content">
		<div id="order1" class="order-info">
			<div class="row">
				<div class="col-xs-8 product_title">
					<a href="#" class="link-p">
						<img class="product_img" src="Images/product-1.jpg" alt="">
					</a>
					<!-- TODO prevent title text break -->
					<span class="qty">1x </span><a href="#"><span>Age Of Wisdom Tan Graphic Tee</span></a>
				</div>
				<div class="col-xs-4">
					<div class="qty_price"><span class="vert_centered">49.99€</span></div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-8 product_title">
					<a href="#" class="link-p">
						<img class="product_img" src="Images/product-2.jpg" alt="">
					</a>
					<span class="qty">2x </span><a href="#"><span>Classic Laundry Green Graphic T-Shirt</span></a>
				</div>
				<div class="col-xs-4">
					<div class="qty_price"><span class="vert_centered">70€</span></div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-8 product_title">
					<a href="#" class="link-p">
						<img class="product_img" src="Images/product-3.jpg" alt="">
					</a>
					<span class="qty">1x </span><a href="#"><span>Classic Laundry Green Graphic T-Shirt</span></a>
					<br>
				</div>
				<div class="col-xs-4">
					<div class="qty_price"><span class="vert_centered">34.99€</span></div>
				</div>
			</div>
			<div class="order-details row">
				<div><b>Total:</b> 154.89€</div>
				<div>
					<br><b>Shipping address:</b>
					<br> John Smith
					<br> 660 Sherwood Drive
					<br> Coram, NY 11727
				</div>
				<div>
					<br><b>Billing Address:</b>
					<br> John Smith
					<br> 664 Sherwood Drive
					<br> Coram, LA 11732
				</div>
				<br>
				<b>Payment Method:</b> PayPal
			</div>
		</div>
	</div>
	<br>
	<a href="#" id="btn-update" class="btn btn-success pull-right">
	Confirm <span class="glyphicon glyphicon-chevron-right"></span>
</a>
</div>
<?php include("templates/footer.php") ?>
