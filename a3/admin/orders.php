<?php 
	$title = "Orders";

	include("templates/header.php"); 
?>
<div class="row" id="orders">
	<div class="col-lg-12">
		<div class="content">
			<h1>Orders</h1>
			<br>
			<form id="searchBar" role="search">
				<div class="input-group">
					<input type="text" class="form-control" name="search" placeholder="Search...">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
					</span>
				</div>
			</form>
			<br>
			<div class="sort_div">
				<select class="form-control" id="sel_sort">
					<option value="" disabled selected>Sort by</option>
					<option>a..z</option>
					<option>z..a</option>
					<option>Price asc.</option>
					<option>Price desc.</option>
					<option>Date asc.</option>
					<option>Date desc.</option>
				</select>
				<label class="checkbox-inline">
					<input type="checkbox" checked="checked" name="show_shipped" id="show_shipped"> Show only pending shipments
				</label>
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
				<div class="panel panel-default" id="accordion">
					<div class="panel-heading">
						<div class="top_row row">
							<div class="col-xs-4">Number</div>
							<div class="col-xs-4">Date</div>
							<div class="col-xs-2 hidden-xs">Total</div>
							<div class="col-xs-2 hidden-xs"></div>
						</div>
					</div>
					<div id="accordion-container" class="panel-orders-list panel-body">
						<div class="panel panel-primary">
							<!-- order1 START -->
							<a class="order_tab" data-toggle="collapse" data-parent="#accordion-container" href="#order1">
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
												<img class="product_img" src="../Images/product-2.jpg" alt="">
											</a>
											<span class="qty">2x </span><a href="#"><span>Classic Laundry Green Graphic T-Shirt</span></a>
										</div>
										<div class="col-xs-4">
											<div class="qty_price"><span class="vert_centered"><span class="vert_centered">70€</span></span>
											</div>
										</div>
									</div>
									<div class="order-details row">
										<div class="visible-xs"><span class="bold">Total:</span> 70€</div>
										<br>
										<div><span class="bold">Payment method:</span> Credit Card </div>
										<div>
											<br><span class="bold">Shipment address:</span>
											<br> John Smith
											<br> 660 Sherwood Drive
											<br> Coram, NY 11727
										</div>
									</div>
									<div class="btns pull-right">
										<button type="button" class="btn-ship btn btn-warning" aria-label="Left Align">Mark as Shipped</button>
									</div>
								</div>
							</div>
							<!-- #order1 END -->
							<!-- #order2 START -->
							<a class="order_tab" data-toggle="collapse" data-parent="#accordion-container" href="#order2">
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
												<img class="product_img" src="../Images/product-1.jpg" alt="">
											</a>
											<!-- TODO prevent title text break -->
											<a href="#"><span>Age Of Wisdom Tan Graphic Tee</span></a>
										</div>
										<div class="col-xs-4">
											<div class="qty_price"><span class="vert_centered">49.99€</span></div>
										</div>
									</div>
									<div class="order-details row">
										<div class="visible-xs"><span class="bold">Total:</span> 44.99€</div>
										<br>
										<div><span class="bold">Payment method:</span> Credit Card </div>
										<div>
											<br><span class="bold">Shipment address:</span>
											<br> John Smith
											<br> 660 Sherwood Drive
											<br> Coram, NY 11727
										</div>
									</div>
									<div class="btns pull-right">
										<button type="button" class="btn-ship btn btn-warning" aria-label="Left Align">Mark as Shipped</button>
									</div>
								</div>
							</div>
							<!-- #order2 END -->
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
