<?php 
$title = "Online Store - My Orders";
$css = ["my_orders.css"];

include("templates/header.php") ?>
<div id="main-title">
	<span class="title">Order History</span>
</div>
<div class="sort_div pull-left">
	<div class="form-group">
		<select class="form-control" id="sel_sort">
			<option>Last 6 months</option>
			<option>2015</option>
			<option>2014</option>
			<option>2013</option>
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
<div class="panel panel-primary" id="accordion">
	<div class="panel-heading">
		<div class="top_row row">
			<div class="col-xs-4">Number</div>
			<div class="col-xs-4">Date</div>
			<div class="col-xs-2 hidden-xs">Total</div>
			<div class="col-xs-2 hidden-xs"></div>
		</div>
	</div>
	<div id="accordion-container" class="panel-orders-list panel-body">
		<div class="order panel panel-primary">
			<!-- order1 START -->
			<a data-toggle="collapse" data-parent="#accordion-container" href="#order1">
				<div class="panel-heading">
					<div class="col-xs-4">#201504201</div>
					<div class="order_date col-xs-4">2016-03-12 12.50</div>
					<div class="col-xs-2 hidden-xs">70€</div>
					<!--<div clas="pull-right shsow-order-info"><span class="glyphicon glyphicon-chevron-down"></span></div>-->
					&nbsp;
				</div>
			</a>
			<div id="order1" class="order-info panel-collapse collapse">
				<div class="panel-body">
					<div class="row">
						<div class="col-xs-8 product_title">
							<a href="#" class="link-p">
								<img class="product_img" src="Images/product-2.jpg" alt="">
							</a>
							<span class="qty">2x </span><a href="#"><span>Classic Laundry Green Graphic T-Shirt</span></a>
						</div>
						<div class="col-xs-4">
							<div class="qty_price"><span class="vert_centered"><span class="vert_centered">70€</span></span></div>
						</div>
					</div>
					<div class="order-details row">
						<div class="visible-xs"><span class="bold">Total:</span> 70€</div><br>
						<div><span class="bold">State:</span> Processing <span class="glyphicon glyphicon-option-horizontal"></span></div>
						<div><span class="bold">Payment method:</span> Credit Card </div>
						<div><span class="bold">Tracking number:</span> EA613412616PT</div>
						<div>
							<br><span class="bold">Shipping Address:</span>
							<br> John Smith
							<br> 660 Sherwood Drive
							<br> Coram, NY 11727
						</div>
						<div>
							<br><span class="bold">Billing Address:</span>
							<br> John Smith
							<br> 664 Sherwood Drive
							<br> Coram, LA 11732
						</div>
					</div>
				</div>
			</div>
			<!-- #order1 END -->
			<!-- #order2 START -->
			<a data-toggle="collapse" data-parent="#accordion-container" href="#order2">
				<div class="panel-heading">
					<div class="col-xs-4">#201502460</div>
					<div class="order_date col-xs-4">2016-03-04 13:52</div>
					<div class="col-xs-2 hidden-xs">49.99€</div>
					<!--<div clas="pull-right shsow-order-info"><span class="glyphicon glyphicon-chevron-down"></span></div>-->
					&nbsp;
				</div>
			</a>
			<div id="order2" class="order-info panel-collapse collapse">
				<div class="panel-body">
					<div class="row">
						<div class="col-xs-8 product_title">
							<a href="#" class="link-p">
								<img class="product_img" src="Images/product-1.jpg" alt="">
							</a>
							<!-- TODO prevent title text break -->
							<a href="#"><span>Age Of Wisdom Tan Graphic Tee</span></a>
						</div>
						<div class="col-xs-4">
							<div class="qty_price"><span class="vert_centered">49.99€</span></div>
						</div>
					</div>
					<div class="order-details row">
						<div class="visible-xs"><span class="bold">Total:</span> 44.99€</div><br>
						<div><span class="bold">State:</span> Delivered <span class="glyphicon glyphicon-ok"></span></div>
						<div><span class="bold">Payment method:</span> Credit Card </div>
						<div><span class="bold">Tracking number:</span> EA634872636PT</div>
						<div>
							<br><span class="bold">Billing &amp; Shipping address:</span>
							<br> John Smith
							<br> 660 Sherwood Drive
							<br> Coram, NY 11727
						</div>
					</div>
				</div>
			</div>
			<!-- #order2 END -->
			<!-- #order3 START -->
			<a data-toggle="collapse" data-parent="#accordion-container" href="#order3">
				<div class="last-panel-heading panel-heading">
					<div class="col-xs-4">#201503201</div>
					<div class="order_date col-xs-4">2016-03-01 22:30</div>
					<div class="col-xs-2 hidden-xs">154.89€</div>
					<!--<div clas="pull-right shsow-order-info"><span class="glyphicon glyphicon-chevron-down"></span></div>-->
					&nbsp;
				</div>
			</a>
			<div id="order3" class="order-info panel-collapse collapse">
				<div class="panel-body">
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
						<div class="visible-xs"><span class="bold">Total:</span> 154.89€</div><br>
						<div><span class="bold">State:</span> Delivered <span class="glyphicon glyphicon-ok"></span></div>
						<div><span class="bold">Payment method:</span> Credit Card </div>
						<div><span class="bold">Tracking number:</span> EA613412616PT</div>
						<div>
							<br><span class="bold">Shipping Address:</span>
							<br> John Smith
							<br> 660 Sherwood Drive
							<br> Coram, NY 11727
						</div>
						<div>
							<br><span class="bold">Billing Address:</span>
							<br> John Smith
							<br> 664 Sherwood Drive
							<br> Coram, LA 11732
						</div>
					</div>
				</div>
			</div>
			<!-- #order3 END -->
		</div>
	</div>
</div>

<?php include("templates/footer.php") ?>
