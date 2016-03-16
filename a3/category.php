<?php 
$title = "Online Store - Subitem 1 a";
$css = ["category.css"];
$category = true;

include("templates/header.php") ?>

<div id="main-title">
	<span class="title">Subitem 1 a</span>
</div>
<div class="sort_div pull-left">
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
<div class="text-center">
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
			<a href="product-page.php" class="link-p">
				<img src="Images/product-1.jpg" alt="">
				</a>
				<div class="caption">
				
					<h4><a href="product-page.php">Age Of Wisdom Tan Graphic Tee</a></h4>
					&nbsp;
						<div class="pull-left price">49.99€</div>
						<a href="#" class="pull-right button-product">
						<span class="glyphicon glyphicon-shopping-cart"></span> <div class="plus"><span class="glyphicon glyphicon-plus"></span></div></a>
				</div>
			</div>
		</div>
		<div class="col-lg-3 col-md-4 col-sm-6 text-center">
			<div class="thumbnail">
			<a href="#" class="link-p">
				<img src="Images/product-2.jpg" alt="">
				</a>
				<div class="caption">
					<h4><a href="#">Classic Laundry Green Graphic T-Shirt</a></h4>
					&nbsp;
						<div class="pull-left price">49.99€</div>
						<a href="#" class="pull-right button-product">
						<span class="glyphicon glyphicon-shopping-cart"></span> <div class="plus"><span class="glyphicon glyphicon-plus"></span></div></a>

				</div>
			</div>
		</div>
		<div class="col-lg-3 col-md-4 col-sm-6 text-center">
			<div class="thumbnail">
			<a href="#" class="link-p">
				<img src="Images/product-3.jpg" alt="">
				</a>
				<div class="caption">
					<h4><a href="#">Classic Laundry Green Graphic T-Shirt</a></h4>

					&nbsp;
						<div class="pull-left price">49.99€</div>
						<a href="#" class="pull-right button-product">
						<span class="glyphicon glyphicon-shopping-cart"></span> <div class="plus"><span class="glyphicon glyphicon-plus"></span></div></a>

				</div>
			</div>
		</div>
		<div class="col-lg-3 col-md-4 col-sm-6 text-center">
			<div class="thumbnail">
			<a href="#" class="link-p">
				<img src="Images/product-4.jpg" alt="">
				</a>
				<div class="caption">
					<h4><a href="#">Classic Laundry Green Graphic T-Shirt</a></h4>

					&nbsp;
						<div class="pull-left price">49.99€</div>
						<a href="#" class="pull-right button-product">
						<span class="glyphicon glyphicon-shopping-cart"></span> <div class="plus"><span class="glyphicon glyphicon-plus"></span></div></a>

				</div>
			</div>
		</div>
		<div class="col-lg-3 col-md-4 col-sm-6 text-center">
			<div class="thumbnail">
			<a href="#" class="link-p">
				<img src="Images/product-5.jpg" alt="">
				</a>
				<div class="caption">
					<h4><a href="#">Classic Laundry Green Graphic T-Shirt</a></h4>

					&nbsp;
						<div class="pull-left price">49.99€</div>
						<a href="#" class="pull-right button-product">
						<span class="glyphicon glyphicon-shopping-cart"></span> <div class="plus"><span class="glyphicon glyphicon-plus"></span></div></a>

				</div>
			</div>
		</div>
		<div class="col-lg-3 col-md-4 col-sm-6 text-center">
			<div class="thumbnail">
			<a href="#" class="link-p">
				<img src="Images/product-6.jpg" alt="">
				</a>
				<div class="caption">
					<h4><a href="#">Classic Laundry Green Graphic T-Shirt</a></h4>
					&nbsp;
						<div class="pull-left price">49.99€</div>
						<a href="#" class="pull-right button-product">
						<span class="glyphicon glyphicon-shopping-cart"></span> <div class="plus"><span class="glyphicon glyphicon-plus"></span></div></a>
				</div>
			</div>
		</div>
		<div class="col-lg-3 col-md-4 col-sm-6 text-center">
			<div class="thumbnail">
			<a href="#" class="link-p">
				<img src="Images/product-7.jpg" alt="">
				</a>
				<div class="caption">
					<h4><a href="#">Classic Laundry Green Graphic T-Shirt</a></h4>
					&nbsp;
						<div class="pull-left price">49.99€</div>
						<a href="#" class="pull-right button-product">
						<span class="glyphicon glyphicon-shopping-cart"></span> <div class="plus"><span class="glyphicon glyphicon-plus"></span></div></a>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="text-center">
	<ul class="pagination pagination-sm">
		<li><a href="#">&laquo;</a></li>
		<li><a href="#">1</a></li>
		<li class="active"><a href="#">2</a></li>
		<li><a href="#">3</a></li>
		<li><a href="#">4</a></li>
		<li><a href="#">&raquo;</a></li>
	</ul>
</div>

<?php include("templates/footer.php") ?>