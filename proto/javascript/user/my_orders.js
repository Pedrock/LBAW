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
	.fail(function() {
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
						<div class="visible-xs"><span class="bold">Total:</span> '+info.totalprice+' €</div>'
						+ coupon +
						'<br><div><span class="bold">State:</span> '+info.status+'</div> \
						<div> \
							<br><span class="bold">Shipping Address:</span> \
							<br> '+info.shipping_name+' \
							<br> '+info.shipping_phone+' \
							<br> '+info.shipping_address1+' \
							<br> '+info.shipping_address2+' \
							<br> '+info.shipping_city+' '+info.shipping_zip1+'-'+info.shipping_zip2+' \
						</div> \
						<div> \
							<br><span class="bold">Billing Address:</span> \
							<br> '+info.billing_name+' \
							<br> '+info.billing_phone+' \
							<br> '+info.billing_address1+' \
							<br> '+info.billing_address2+' \
							<br> '+info.billing_city+' '+info.billing_zip1+'-'+info.billing_zip2+' \
						</div> \
					</div>');
}

$(".order-accordion").on('click', getOrderInfo);