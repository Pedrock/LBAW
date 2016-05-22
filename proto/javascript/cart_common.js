var modal =
	'<div class="modal fade" id="cartModal" tabindex="-1" role="dialog" aria-labelledby="cartModal" aria-hidden="true"> \
		<div class="modal-dialog"> \
			<div class="modal-content"> \
				<div class="modal-header"> \
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> \
					<h4 class="modal-title" id="myModalLabel">Added to Cart</h4> \
				</div> \
				<div class="modal-body"> \
					 <a href="" class="link-p"><img height="100" src="" alt=""></a> \
					 <span><a href="" class="link-p" id="modal-product-name"></a></span> \
				</div> \
				<div class="modal-footer"> \
					<a type="button" class="btn btn-default" href="cart.php">Go to Cart</a> \
					<button type="button" class="btn btn-primary" data-dismiss="modal">Continue purchasing</button> \
				</div> \
			</div> \
		</div> \
	</div>';

$("body").prepend(modal);

function addToCart(product, quantity)
{
	if (quantity === undefined) quantity = 1;

	$.ajax({
		type: "POST",
		url: base_url + "api/cart/add.php",
		data: {product: product, quantity: quantity}
	}).done(function() {
		showCartModal(product);
	});
}

function showCartModal(product)
{
	var elem = $('[data-id="'+product+'"]');
	var image = elem.find('img').attr('src');
	var name = elem.find('.product-name').text();
	var link = elem.find('a.link-p').attr('href');

	var modal = $('#cartModal');
	modal.find('.link-p').attr('href',link);
	modal.find('img').attr('src',image);
	modal.find('#modal-product-name').text(name);
	modal.modal('show');
}

