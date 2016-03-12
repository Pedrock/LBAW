<?php 
$title = "Product Page";
$css = ["product-page.css"];
include("templates/header.php");
?>
<div id="title-products">
	<div class="col-xs-10">
		<h1 id="product-name">Age Of Wisdom Tan Graphic Tee</h1>
	</div>
	<div class="col-sm-2 hidden-xs">
		<button id="btn-favorites" type="button" class="btn btn-primary pull-right" aria-label="Left Align">
			<span aria-hidden="true"> Add to Favorites</span>
		</button>
	</div>
</div>

<div id="info-product" class="container-fluid">
	<div class="row">
		<div class="col-lg-3 col-md-4">
			<div id="product-main-img" class="row">
				<img class="img-responsive" src="Images/product-1.jpg" alt="">
			</div>
			<div id="product-imgs" class="row">
				<div class="col-xs-3 other-photos"><a href="#x"><img src="http://static.planetminecraft.com/files/resource_media/screenshot/1341/11Minecraft-Creeper-Wallpaper-1080p-HD-250x250up_6509836_lrg.jpg" alt="Image" class="img-responsive"></a>
				</div>
				<div class="col-xs-3 other-photos"><a href="#x"><img src="http://www.autreplanete.com/ap-social-media-image-maker/ressources/img/img_format/google_profil_252x252.png" alt="Image" class="img-responsive"></a>
				</div>
				<div class="col-xs-3 other-photos"><a href="#x"><img src="https://i.warosu.org/data/vr/img/0014/31/1393441050054.jpg" alt="Image" class="img-responsive"></a>
				</div>
				<div class="col-xs-3 other-photos"><a href="#x" ><img src="http://www.cigarsnapshot.com/wp-content/uploads/2011/07/ad-placeholder250x250.gif" alt="Image" class="img-responsive"></a>
				</div>
			</div>
		</div>
		<div class="col-lg-9 col-md-8">
			<div class="row">
				<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.
				</p>
				<p> It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
				</p>
			</div>
			<div class="row">
				<form class="form-inline" role="form">
					<div class="form-group form-product">
						<label for="text">Quantity</label>
						<input type="text" class="form-control" id="quantity">
					</div>
					<label for="text">3 Available</label>
				</form>
			</div>
			<div class="row form-row">
				<form class="form-inline" role="form">
					<label class="form-product" for="text">49.99€</label>
					<button id="btn-add-to-cart" class="btn btn-info" type="submit" form="nameform" value="Submit">Add to Cart</button>
				</form>
			</div>
			<div id="row-score" class="row form-row">
				<span id="product-score">3.5<span class="glyphicon glyphicon-star star" aria-hidden="true"></span></span>
				<button id="btn-favorites" type="button" class="btn btn-primary visible-xs" aria-label="Left Align">
					<span aria-hidden="true"> Add to Favorites</span>
				</button>
			</div>
		</div>
	</div>
</div>
<div id="product-reviews" class="row">
	<div class="well">

		<div class="text-right">
			<a id="leave-a-review" class="btn btn-success">Leave a Review</a>
		</div>

		<hr>

		<div class="row">
			<div class="col-md-12">
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star star "></span>
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star-empty star"></span>
				<span class="info-review">Anonymous</span>
				<span class="info-review pull-right">10 days ago</span>
				<p>This product was great in terms of quality. I would definitely buy another!</p>
			</div>
		</div>

		<hr>

		<div class="row">
			<div class="col-md-12">
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star-empty star"></span>
				<span class="info-review">Anonymous</span>
				<span class=" info-review pull-right">12 days ago</span>
				<p>I've alredy ordered another one!</p>
			</div>
		</div>

		<hr>

		<div class="row">
			<div class="col-md-12">
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star-empty star"></span>
				<span class="glyphicon glyphicon-star-empty star"></span>
				<span class="info-review">Anonymous</span>
				<span class="info-review pull-right">15 days ago</span>
				<p>I've seen some better than this, but not at this price. I definitely recommend this item.</p>
			</div>
		</div>

	</div>
</div>
</div>

<?php include("templates/footer.php") ?>