{assign "title" {"HashStore - "|cat:$product.name}}
{assign var="css" value=["product-page.css"]}
{assign "js" ['cart_common.js', 'product-page.js']}
{include file='common/header.tpl'}

<span data-id="{$product.id}">
<div id="title-products">
		<h1 id="product-name" class="product-name">{$product.name}</h1>
	{if $smarty.session.user}
		<button type="button" class="btn btn-primary btn-favorites pull-right hidden-xs" aria-label="Left Align">
			<span aria-hidden="true"> Add to Favorites</span>
		</button>
	{/if}
</div>

<div id="info-product" class="container-fluid">
	<a href="product.php?id={$product.id}" class="link-p hidden"></a>
	<div class="row">
		<div class="col-lg-3 col-md-4">
			<div id="product-main-img" class="row">
				{if !empty($photos)}
					<img class="img-responsive" src="../images/products/thumb_{$photos[0].location}" alt="">
				{/if}
			</div>
			<div id="product-imgs" class="row">
			{foreach from=$photos item=photo}
				<div class="col-xs-3 other-photos"><a href="#"><img src="../images/products/thumb_{$photo.location}" alt="Image {$photo.photo_order}" class="img-responsive"></a></div>
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
					<a href="#" onclick="addToCart({$product.id},$('#quantity').val());return false;" id="btn-add-to-cart" class="btn btn-info">Add to Cart</a>
					{if $product.discount > 0}
						<br><br><del>{$product.price}€</del> <span id="discount">{$product.discount}% OFF!</span>
					{/if}
				</div>
			</div>
			<div id="row-score" class="row form-row">
				{if $smarty.session.user}
				<button type="button" class="btn btn-primary btn-favorites visible-xs" aria-label="Left Align">
					<span aria-hidden="true"> Add to Favorites</span>
				</button>
				{/if}
				{if $product.averagescore}
					<div id="score-container" class="col-xs-3">
					<br>
					<span id="product-score">{$product.averagescore}</span>
					<br>
					<div class="ratings">
					    <div class="empty-stars"></div>
					    <div class="full-stars" style="width:{$product.averagescore * 20}%"></div>
					</div>
					<br>
				</div>
				{/if}
			</div>
		</div>
	</div>
</div>
<div id="product-reviews" class="row">
	<div class="well">
		<h3>Reviews</h3>
		{if $smarty.session.user}
			<button id="leave-a-review" class="btn btn-success">Leave a Review</button>
		{/if}
		{foreach from=$reviews item=review}
			<div class="row">
			<div class="col-md-12">
				{for $star=1 to 5}
					<span class="glyphicon glyphicon-star{if $review.score < $star}-empty{/if} star"></span>
				{/for}
				<span class="info-review">{$review.reviewer}</span>
				<span class="info-review pull-right">{$review.review_date}</span>
				<p>{$review.body}</p>
			</div>
		</div>
		{foreachelse}
		<div class="row">
		<p class="text-center">No reviews yet</p>
		</div>
		{/foreach}
	</div>
</div>
</span>

<div class="popup_bg" id="popup_photo">
	<img id="photo_large" src="">
</div>

{include file='common/footer.tpl'}
