$('input#show_pending').on('change', function() {
    if ($('input#show_pending').prop('checked'))
        window.location = "orders.php?pending";
    else
        window.location = "orders.php";
});

function getOrderInfo() {
    var order_a = $(this);
    if (!order_a.hasClass('loadable')) return;

    var order_id = order_a.attr('data-id');
    order_a.removeClass('loadable');

    $.ajax({
        url: "../../api/admin/get_order.php",
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

$("#accordion").on("click", ".dropdown-menu > li", function(event){
    event.preventDefault();
    var button = $(this).closest('.dropdown').children('.btn');
    var text = $(this).text();
    button.children(':first-child').text(text);
    fix_button_classes(button);
});

function fix_button_classes(buttons)
{
    buttons.removeClass('btn-warning btn-danger btn-success');
    buttons.each(function () {
        switch ($(this).children(':first-child').text())
        {
            case 'Pending': $(this).addClass('btn-warning'); break;
            case 'Canceled': $(this).addClass('btn-danger'); break;
            case 'Sent': $(this).addClass('btn-success'); break;
        }
    });
}

function displayInfo(panel, info)
{
    for (var i = 0; i < info.products.length; i++)
    {
        var product = info.products[i];
        panel.append('<div class="row product" data-id="'+product.id+'"> \
                        <div class="col-xs-7 col-md-8 product_title"> \
                            <a href="../product.php?id='+product.id+'" class="link-p"> \
                                <img class="product_img" src="../../images/products/'+product.photo+'" alt=""> \
                            </a> \
                            <span class="qty">'+product.quantity+'x </span><a href="../product.php?id='+product.id+'"><span>'+product.name+'</span></a> \
                        </div> \
                        <div class="col-xs-2 col-md-2"> \
                            <div class="qty_price"><span class="vert_centered"><span class="vert_centered">'+product.price+'€</span></span></div> \
                        </div> \
                        <div class="dropdown col-sm-3 col-md-2"> \
                          <button class="btn dropdown-toggle btn-status pull-right" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"> \
                            <span>'+product.product_status+'</span> \
                            <span class="caret"></span> \
                          </button> \
                          <ul class="dropdown-menu" aria-labelledby="dropdownMenu1"> \
                            <li><a href="#">Pending</a></li> \
                            <li><a href="#">Sent</a></li> \
                            <li><a href="#">Canceled</a></li> \
                          </ul> \
                        </div> \
                    </div>');
    }
    fix_button_classes(panel.find('.btn'));
    var coupon = info.coupon_discount ? '<div><span class="bold">Coupon Discount:</span> '+info.coupon_discount+'%</div>' : '';

    panel.append('<div class="order-details row"> \
                        <div><span class="bold">Shipping Costs:</span> '+info.shippingcost+' €</div>'
                        + coupon +
                        '<div><span class="bold">Total:</span> '+info.totalprice+' €</div> \
                        <br><div><span class="bold">State:</span> '+info.status+'</div> \
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
                    </div> \
                    <div class="btns pull-right"> \
                        <button type="button" class="btn-ship btn btn-success" aria-label="Left Align">Mark All As Shipped</button>\
                    </div>'); 
}

$(".order-accordion").on('click', getOrderInfo);
