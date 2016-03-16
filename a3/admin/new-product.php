<?php 
$title = "New Product";
$css = ["checkout.css"];
include("templates/header.php"); 
?>

<div class="row">
	<div class="col-lg-12">
		<div class="new-product_content tab-content">
			<div id="new_address" class="tab-pane fade in active">
				<div id="new-product-title">
					<h1>New Product</h1>
				</div>
				<form>
					<div id="new-product" class="row">
						<div class="col-md-6">
							<div class="col-md-12">
								<fieldset class="form-group">
									<label for="name">Name</label>
									<input type="text" class="form-control" id="name">
								</fieldset>
								<fieldset class="form-group">
									<span class="btn btn-default btn-file">
										Browse <input type="file">
									</span>
									<label class="control-label">Select Images</label>
								</fieldset>
							</div>
							<div class="col-md-6">
								<fieldset class="form-group">
									<label for="country">Category</label>
									<select size="7" class="form-control insert-category" id="country">
										<option>Appliances</option>
										<option>Apps &amp; Games</option>
										<option>Arts, Crafts &amp; Sewing</option>
										<option>Automotive</option>
										<option>Baby</option>
										<option>Beauty</option>
										<option>Books</option>
										<option>CDs &amp; Vinyl</option>
										<option>Cell Phones &amp; Accessories</option>
										<option>Clothing, Shoes &amp; Jewelry</option>
										<option>&nbsp;&nbsp;&nbsp;Women</option>
										<option>&nbsp;&nbsp;&nbsp;Men</option>
										<option>&nbsp;&nbsp;&nbsp;Girls</option>
										<option>&nbsp;&nbsp;&nbsp;Boys</option>
										<option>&nbsp;&nbsp;&nbsp;Baby</option>
										<option>Collectibles &amp; Fine Art</option>
										<option>Computers</option>
										<option>Credit and Payment Cards</option>
										<option>Digital Music</option>
										<option>Electronics</option>
										<option>Gift Cards</option>
										<option>Grocery &amp; Gourmet Food</option>
										<option>Handmade</option>
										<option>Health &amp; Personal Care</option>
										<option>Home &amp; Business Services</option>
										<option>Home &amp; Kitchen</option>
										<option>Industrial &amp; Scientific</option>
										<option>Kindle Store</option>
										<option>Luggage &amp; Travel Gear</option>
										<option>Luxury Beauty</option>
										<option>Magazine Subscriptions</option>
										<option>Movies &amp; TV</option>
										<option>Musical Instruments</option>
										<option>Office Products</option>
										<option>Patio, Lawn &amp; Garden</option>
										<option>Pet Supplies</option>
										<option>Prime Pantry</option>
										<option>Software</option>
										<option>Sports &amp; Outdoors</option>
										<option>Tools &amp; Home Improvement</option>
										<option>Toys &amp; Games</option>
										<option>Video Games</option>
										<option>Wine</option>
									</select>
								</fieldset>
							</div>
							<div class="col-md-3">
								<fieldset class="form-group">
									<label for="name">Price</label>
									<input type="number" class="insert-number form-control" id="addr2" placeholder="">
								</fieldset>
							</div>
							<div class="col-md-3">
								<fieldset class="form-group">
									<label for="name">Stock</label>
									<input type="number" class="insert-number form-control" id="city" min="1" max="500" value="1">
								</fieldset>
							</div>
						</div>
						<div class="col-md-6">
							<fieldset class="form-group">
								<label for="name">Description</label>
								<textarea class="form-control" rows="12" cols="50"> 
								</textarea>
							</fieldset>
						</div>
					</div>
					<div id="row-submit" class="row">
						<div id="field-submit" class="col-md-3">
							<fieldset class="form-group">
								<button id="btn-new-product" class="btn btn-info" type="submit" value="Submit">Submit</button>
							</fieldset>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<?php include("templates/footer.php"); ?>