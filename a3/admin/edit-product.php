<?php 
$title = "Edit Product";
$css = ["checkout.css", "category.css"];
include("templates/header.php"); 
?>

<div class="row">
	<div class="col-lg-12">
		<div class="new-product_content tab-content">
			<div id="new_address" class="tab-pane fade in active">
				<div id="new-product-title">
					<h1>Edit Product</h1>
				</div>
				<form id="form-edit-product" role="search">
					<div class="input-group">
						<div class="input-group-btn">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Categories<span class="caret"></span></button>
							<ul class="dropdown-menu dropdown-menu-right">
								<li><a href="#">Appliances</a></li>
								<li><a href="#">Apps &amp; Games</a></li>
								<li><a href="#">Arts, Crafts &amp; Sewing</a></li>
								<li><a href="#">Automotive</a></li>
								<li><a href="#">Baby</a></li>
								<li><a href="#">Beauty</a></li>
								<li><a href="#">Books</a></li>
								<li><a href="#">CDs &amp; Vinyl</a></li>
								<li><a href="#">Cell Phones &amp; Accessories</a></li>
								<li><a href="#">Clothing, Shoes &amp; Jewelry</a></li>
								<li><a href="#">&nbsp;&nbsp;&nbsp;Women</a></li>
								<li><a href="#">&nbsp;&nbsp;&nbsp;Men</a></li>
								<li><a href="#">&nbsp;&nbsp;&nbsp;Girls</a></li>
								<li><a href="#">&nbsp;&nbsp;&nbsp;Boys</a></li>
								<li><a href="#">&nbsp;&nbsp;&nbsp;Baby</a></li>
								<li><a href="#">Collectibles &amp; Fine Art</a></li>
								<li><a href="#">Computers</a></li>
								<li><a href="#">Credit and Payment Cards</a></li>
								<li><a href="#">Digital Music</a></li>
								<li><a href="#">Electronics</a></li>
								<li><a href="#">Gift Cards</a></li>
								<li><a href="#">Grocery &amp; Gourmet Food</a></li>
								<li><a href="#">Handmade</a></li>
								<li><a href="#">Health &amp; Personal Care</a></li>
								<li><a href="#">Home &amp; Business Services</a></li>
								<li><a href="#">Home &amp; Kitchen</a></li>
								<li><a href="#">Industrial &amp; Scientific</a></li>
								<li><a href="#">Kindle Store</a></li>
								<li><a href="#">Luggage &amp; Travel Gear</a></li>
								<li><a href="#">Luxury Beauty</a></li>
								<li><a href="#">Magazine Subscriptions</a></li>
								<li><a href="#">Movies &amp; TV</a></li>
								<li><a href="#">Musical Instruments</a></li>
								<li><a href="#">Office Products</a></li>
								<li><a href="#">Patio, Lawn &amp; Garden</a></li>
								<li><a href="#">Pet Supplies</a></li>
								<li><a href="#">Prime Pantry</a></li>
								<li><a href="#">Software</a></li>
								<li><a href="#">Sports &amp; Outdoors</a></li>
								<li><a href="#">Tools &amp; Home Improvement</a></li>
								<li><a href="#">Toys &amp; Games</a></li>
								<li><a href="#">Video Games</a></li>
								<li><a href="#">Wine</a></li>
							</ul>
						</div>
						<input type="text" class="form-control" name="search" placeholder="Search...">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
						</span>
					</div>
				</form>
			</div>
				<div class="seleciona sort_div pull-left">
					<div class="form-group">
						<select class="form-control" id="sel_sort">
							<option value="" disabled selected>Sort by</option>
							<option>a..z</option>
							<option>z..a</option>
							<option>Price asc.</option>
							<option>Price desc.</option>
						</select>
					</div>
				</div>
				<div class="next-page text-center">
					<ul class="pagination pagination-sm">
						<li><a href="#">&laquo;</a></li>
						<li><a href="#">1</a></li>
						<li class="active"><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">&raquo;</a></li>
					</ul>
				</div>
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-3 col-md-4 col-sm-6 text-center">
							<div class="thumbnail">
								<a href="#" class="link-p">
									<img src="../Images/product-1.jpg" alt="">
								</a>
								<div class="caption">
									<h4><a href="#">Age Of Wisdom Tan Graphic Tee</a></h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut, minima!</p>
									<div class="btn-group">
										<a href="../product-page.php" class="btn btn-default button-product">See Details</a>
										<a href="#" class="btn btn-danger button-product"><i class="fa fa-shopping-cart"></i>Delete</a>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6 text-center">
							<div class="thumbnail">
								<a href="#" class="link-p">
								<img src="../Images/product-2.jpg" alt="">
								</a>
								<div class="caption">
									<h4><a href="#">Classic Laundry Green Graphic T-Shirt</a></h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut, minima!</p>
									<div class="btn-group">
										<a href="#" class="btn btn-default button-product">See Details</a>
										<a href="#" class="btn btn-danger button-product"><i class="fa fa-shopping-cart"></i>Delete</a>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6 text-center">
							<div class="thumbnail">
								<a href="#" class="link-p">
									<img src="../Images/product-3.jpg" alt="">
								</a>
								<div class="caption">
									<h4><a href="#">Classic Laundry Green Graphic T-Shirt</a></h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut, minima!</p>
									<div class="btn-group">
										<a href="#" class="btn btn-default button-product">See Details</a>
										<a href="#" class="btn btn-danger button-product"><i class="fa fa-shopping-cart"></i>Delete</a>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6 text-center">
							<div class="thumbnail">
								<a href="#" class="link-p">
									<img src="../Images/product-4.jpg" alt="">
								</a>
								<div class="caption">
									<h4><a href="#">Classic Laundry Green Graphic T-Shirt</a></h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut, minima!</p>
									<div class="btn-group">
										<a href="#" class="btn btn-default button-product">See Details</a>
										<a href="#" class="btn btn-danger button-product"><i class="fa fa-shopping-cart"></i>Delete</a>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6 text-center">
							<div class="thumbnail">
								<a href="#" class="link-p">
									<img src="../Images/product-5.jpg" alt="">
								</a>
								<div class="caption">
									<h4><a href="#">Classic Laundry Green Graphic T-Shirt</a></h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut, minima!</p>
									<div class="btn-group">
										<a href="#" class="btn btn-default button-product">See Details</a>
										<a href="#" class="btn btn-danger button-product"><i class="fa fa-shopping-cart"></i>Delete</a>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6 text-center">
							<div class="thumbnail">
								<a href="#" class="link-p">
									<img src="../Images/product-6.jpg" alt="">
								</a>
								<div class="caption">
									<h4><a href="#">Classic Laundry Green Graphic T-Shirt</a></h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut, minima!</p>
									<div class="btn-group">
										<a href="#" class="btn btn-default button-product">See Details</a>
										<a href="#" class="btn btn-danger button-product"><i class="fa fa-shopping-cart"></i>Delete</a>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6 text-center">
							<div class="thumbnail">
								<a href="#" class="link-p">
									<img src="../Images/product-7.jpg" alt="">
								</a>
								<div class="caption">
									<h4><a href="#">Classic Laundry Green Graphic T-Shirt</a></h4>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut, minima!</p>
									<div class="btn-group">
										<a href="#" class="btn btn-default button-product">See Details</a>
										<a href="#" class="btn btn-danger button-product"><i class="fa fa-shopping-cart"></i>Delete</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="next-page text-center">
					<ul class="pagination pagination-sm">
						<li><a href="#">&laquo;</a></li>
						<li><a href="#">1</a></li>
						<li class="active"><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">&raquo;</a></li>
					</ul>
				</div>
			</div>
	</div>
</div>
<?php include("templates/footer.php"); ?>