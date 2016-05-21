function deleteFromCart(product)
{
    $.ajax({
        type: "POST",
        url: base_url + "api/cart/delete.php",
        data: {product: product}
    }).done(function() {
        $('.product-cart[data-id="'+product+'"]').slideUp(400, function() {$(this).remove(); updateTotal();});
    });
}

$('.qty_price input').on('change', function() {
    $(this).closest('.qty_price').children('a').removeClass('hidden');
});

function updateQuantity(product)
{
    var product_row = $('.product-cart[data-id="'+product+'"]');
    product_row.find('.fa-refresh').addClass('fa-spin');
    var quantity = product_row.find('.qty').val();
    $.ajax({
        type: "POST",
        url: base_url + "api/cart/update.php",
        data: {product: product, quantity: quantity}
    }).done(function() {
        product_row.attr('data-quantity',quantity);
        product_row.find('.fa-refresh').removeClass('fa-spin').addClass('hidden');
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
}