function getOrderInfo() {
	var order_a = $(this);
	if (!order_a.hasClass('loadable')) return;

	var order_id = order_a.attr('data-id');
	order_a.removeClass('loadable');

	$.ajax({
		url: "../../api/users/my_orders.php",
		type: "POST",
		data: {order_id: order_id},
		dataType: 'json'
	}).done(function(data) {
		displayInfo(order_a.next('.order-info').children('.panel-body') , data);
		order_a.next('.order-info').find('.loading').remove();
	})
	.fail(function(data) {
		order_a.next('.order-info').find('.fa-spinner').removeClass('fa-spinner');
		order_a.addClass('loadable');
	});
};

function displayInfo(panel, info)
{
	for (var i = 0; i < info.products.length; i++)
	{
		var product = info.products[i];
		panel.append('<div class="row"> \
						<div class="col-xs-8 product_title"> \
							<a href="../product.php?id='+product.id+'" class="link-p"> \
								<img class="product_img" src="../../images/products/'+product.photo+'" alt=""> \
							</a> \
							<span class="qty">'+product.quantity+'x </span><a href="../product.php?id='+product.id+'"><span>'+product.name+'</span></a> \
						</div> \
						<div class="col-xs-4"> \
							<div class="qty_price"><span class="vert_centered"><span class="vert_centered">'+product.price+' €</span></span></div> \
						</div> \
					</div>');
	}

	var coupon = info.coupon_discount ? '<div><span class="bold">Coupon Discount:</span> '+info.coupon_discount+'%</div>' : '';
	panel.append('<div class="order-details row"> \
						<div><span class="bold">Shipping Costs:</span> <span class="order_shipping">'+info.shippingcost+'</span> €</div>'
						+ coupon +
						'<div><span class="bold">Total:</span> <span class="order_total">'+info.totalprice+'</span> €</div> \
                        <br><div><span class="bold">State:</span> <span class="order_status">'+info.status+'</span></div> \
                        <div> \
							<br><span class="bold">Shipping Address:</span> \
							<div>'+info.shipping_name+'</div> \
							<div>'+info.shipping_phone+'</div> \
							<div>'+info.shipping_address1+'</div> \
							<div>'+info.shipping_address2+'</div> \
							<div>'+info.shipping_zip1+'-'+info.shipping_zip2+', '+info.shipping_city+'</div> \
						</div> \
						<div> \
							<br><span class="bold">Billing Address:</span> \
							<div>'+info.billing_name+'</div> \
							<div>'+info.billing_phone+'</div> \
							<div>'+info.billing_address1+'</div> \
							<div>'+info.billing_address2+'</div> \
							<div>'+info.billing_zip1+'-'+info.billing_zip2+', '+info.billing_city+'</div> \
						</div> \
					</div>\
					<div id="button-wrapper"> \
					<a href="#" onclick="addOrderToCart(' + info.order_id + ');return false;" id="btn-add-to-cart" class="btn btn-info">Add to Cart</a> \
					<div>');
}

$(".order-accordion").on('click', getOrderInfo);

function addOrderToCart(order)
{
	$.ajax({
		type: "POST",
		url: base_url + "api/users/my_orders.php",
		dataType: 'json',
		data: {action: "add", order_id: order}
	}).done(function(e) {
		$("#cartModal").modal("toggle");
	});
}