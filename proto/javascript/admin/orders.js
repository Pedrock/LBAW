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
        url: "../../api/admin/orders/get.php",
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

function statusUpdated(order_info, order_status)
{
    if ($('#show_pending').prop('checked') && order_status == 'Sent')
        order_info.prev('a').addBack(order_info).slideUp();
}

$("#accordion").on("click", ".dropdown-menu > li", function(event){
    event.preventDefault();

    var button = $(this).closest('.dropdown').children('.btn');
    var new_status = $(this).text();
    var order_info = $(this).closest('.order-info');
    var order_id = order_info.attr('id');
    var product_id = $(this).closest('.product').attr('data-id');

    button.next('.fa-refresh').remove();
    button.after('<i class="fa fa-refresh fa-spin fa-fw"></i>');

    $.ajax({
        url: "../../api/admin/orders/update_product.php",
        type: "POST",
        data: {order_id: order_id, product_id: product_id, status: new_status},
        dataType: 'json'
    }).done(function(data) {
        button.next('.fa-refresh').remove();
        button.children(':first-child').text(new_status);
        order_info.find('.order_status').text(data.order_status);
        fix_button_classes(button);
        statusUpdated(order_info, data.order_status);
    })
    .fail(function() {
        button.next('.fa-refresh').removeClass('fa-spin');
    });
});

$("#accordion").on("click", ".btn-ship", function(event){

    var button = $(this);
    button.next('.fa-refresh').remove();
    button.after('<i class="fa fa-refresh fa-spin fa-fw"></i>');
    var order_info = $(this).closest('.order-info');
    var order_id = order_info.attr('id');
    $.ajax({
        url: "../../api/admin/orders/ship_order.php",
        type: "POST",
        data: {order_id: order_id},
        dataType: 'json'
    }).done(function(data) {
        button.next('.fa-refresh').remove();
        button.slideUp();
        order_info.find('.order_status').text(data.order_status);
        var order_buttons = order_info.find('.btn-status');
        order_buttons.children(':first-child').text('Sent');
        fix_button_classes(order_buttons);
        statusUpdated(order_info, data.order_status);
    })
    .fail(function() {
        button.next('.fa-refresh').removeClass('fa-spin');
    });
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
    var all_sent = true;
    for (var i = 0; i < info.products.length; i++)
    {
        var product = info.products[i];
        if (product.product_status != 'Sent') all_sent = false;
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
                        <br><div><span class="bold">State:</span> <span class="order_status">'+info.status+'</span></div> \
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
                    </div>' +
                    (all_sent ? '' : '<div class="btn-ship-container pull-right"> \
                        <button type="button" class="btn-ship btn btn-success" aria-label="Left Align">Mark All As Shipped</button>\
                        </div>'));
}

$(".order-accordion").on('click', getOrderInfo);
