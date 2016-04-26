{assign "title" {"HashStore - "|cat:$product.name}}
{assign var="css" value=["product-page.css"]}
{include file='common/header.tpl'}
<div id="title-products">
		<h1 id="product-name">{$product.name}</h1>
		<button type="button" class="btn btn-primary btn-favorites pull-right hidden-xs" aria-label="Left Align">
			<span aria-hidden="true"> Add to Favorites</span>
		</button>
</div>

<div id="info-product" class="container-fluid">
	<div class="row">
		<div class="col-lg-3 col-md-4">
			<div id="product-main-img" class="row">
				{if !empty($photos)}
				<img class="img-responsive" src="../images/products/{$photos[0].location}" alt="">
				{/if}
			</div>
			<div id="product-imgs" class="row">
			{foreach from=$photos item=photo} 
				<div class="col-xs-3 other-photos"><a href="#"><img src="../images/products/{$photo.location}" alt="Image {$photo.photo_order}" class="img-responsive"></a></div>
			{/foreach} 
			</div>
		</div>
		<div class="col-lg-9 col-md-8">
			<div id="product-description" class="row">
				{$product.description|nl2br}
			</div>
			<div class="row">
				<div class="form-inline">
					<div class="form-group form-product">
						<label for="quantity">Quantity</label> 
						{if $product.stock > 0}
							{assign var="value" value=1}
						{else}
							{assign var="value" value=0}
						{/if}
						<input type="number" id="quantity" min="0" max="{$product.stock}" value="{$product.stock > 0}">
					</div>
					<span class="bold" >{$product.stock} Available</span>
				</div>
			</div>
			<div class="row form-row">
				<div class="form-inline">
					<span class="form-product bold">{$product.new_price}€</span>
					<button id="btn-add-to-cart" class="btn btn-info">Add to Cart</button> 
					{if $product.discount > 0}
						<br><br><del>{$product.price}€</del> <span id="discount">{$product.discount}% OFF!</span>
					{/if}
				</div>
			</div>
			<div id="row-score" class="row form-row">
				{if $product.averagescore}
				<span id="product-score">{$product.averagescore} <span class="glyphicon glyphicon-star star" aria-hidden="true"></span></span>
				{/if}
				<button type="button" class="btn btn-primary btn-favorites visible-xs" aria-label="Left Align">
					<span aria-hidden="true"> Add to Favorites</span>
				</button>
			</div>
		</div>
	</div>
</div>
<div id="product-reviews" class="row">
	<div class="well">
		<h3>Reviews</h3>
		<button id="leave-a-review" class="btn btn-success">Leave a Review</button>

		{foreach from=$reviews item=review}
		<div class="row">
			<div class="col-md-12">
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star star "></span>
				<span class="glyphicon glyphicon-star star"></span>
				<span class="glyphicon glyphicon-star-empty star"></span>
				<span class="info-review">{$review.reviewer}</span>
				<span class="info-review pull-right">{$review.review_date}</span>
				<p>{$review.body}</p>
			</div>
		</div>
		{foreachelse}
		<div class="row">
		<p>No reviews yet</p>
		</div>
		{/foreach}

	</div>
</div>

{include file='common/footer.tpl'}
