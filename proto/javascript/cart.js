function deleteFromCart(product)
{
    $.ajax({
        type: "POST",
        url: base_url + "api/cart/delete.php",
        data: {product: product}
    }).done(function() {
        $('.product-cart[data-id="'+product+'"]').slideUp(400, function() {$(this).remove(); updateTotal();});
        $('.empty-cart').hide().removeClass('hidden').slideDown();
    });
}

$('.qty_price input').on('change', function() {
    var product = $(this).closest('.product-cart').attr('data-id');
    $(this).closest('.qty_price').children('a').removeClass('hidden');
    updateQuantity(product);
});

function updateQuantity(product)
{
    var product_row = $('.product-cart[data-id="'+product+'"]');
    product_row.find('.fa-refresh').addClass('fa-spin');
    var quantity = product_row.find('.qty').val();
    $.ajax({
        type: "POST",
        url: base_url + "api/cart/update.php",
        data: {product: product, quantity: quantity},
        dataType: "json"
    }).done(function(enough_stock) {
        product_row.attr('data-quantity',quantity);
        product_row.find('.fa-refresh').removeClass('fa-spin').addClass('hidden');
        product_row.find('.qty_price > input').toggleClass('low-stock',!enough_stock);
        updateTotal();
    }).error(function() {
        product_row.find('.fa-refresh').removeClass('fa-spin');
    });
}

function updateTotal()
{
    var total = 0;
    $('.product-cart').each(function() {
        total += $(this).attr('data-quantity') * $(this).attr('data-price');
    });
    $('#subtotal').text(Math.round(total * 100) / 100);
    updateTooltips();
}

$('#btn-checkout').click(function() {
    if ($('.product-cart').length && !$('.low-stock').length)
        window.location = "checkout/checkout.php";
});

function updateTooltips()
{
    var inputs = $('.qty_price > input');
    inputs.filter('.low-stock').tooltip('show');
    inputs.not('.low-stock').tooltip('hide');
}

$('#cart').tooltip({
    trigger: 'manual'
});

updateTooltips();