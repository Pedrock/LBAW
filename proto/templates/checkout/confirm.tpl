{assign "title" "HashStore - Confirm Order"}
{assign "css" ["checkout/confirm.css"]}
{assign "js" ['checkout/confirm.js']}
{include file='common/header.tpl'}

<div id="order">
    <div class="top_row row">
        <span class="title"><span class="glyphicon glyphicon-shopping-cart"> </span> Your order</span>
    </div>
    <div class="row content">
        <div id="order1" class="order-info">
            {foreach from=$cart item=product}
            <div class="row">
                <div class="col-xs-8 product_title">
                    <a href="#" class="link-p">
                        <img class="product_img" src="../../images/products/thumb_{$product.photo}" alt="">
                    </a>
                    <!-- TODO prevent title text break -->
                    <span class="qty">{$product.quantity}x </span><a href="../product.php?id={$product.id}"><span>{$product.name}</span></a>
                </div>
                <div class="col-xs-4">
                    <div class="qty_price"><span class="vert_centered">{$product.price}€</span></div>
                </div>
            </div>
            {/foreach}
            <div class="order-details row">
                <div class="col-xs-6 col-xs-offset-6 col-sm-4 col-sm-offset-8"><b>Subtotal:</b> {$total} €</div>
                <div class="col-xs-6 col-xs-offset-6 col-sm-4 col-sm-offset-8"><b>Shipping:</b> {$shipping} €</div>
                <div class="col-xs-6 col-xs-offset-6 col-sm-4 col-sm-offset-8"><b>Total:</b> {$total + $shipping} €</div>
                <div>
                    <br><b>Shipping address:</b>
                    <br> {$shipping_address['name']}
                    <br> {$shipping_address['address1']}
                    {if $shipping_address['address2']}<br> {$shipping_address['address2']}{/if}
                    <br> {$shipping_address['zipcode']}, {$shipping_address['city']}
                </div>
                <div>
                    <br><b>Shipping address:</b>
                    <br> {$billing_address['name']}
                    <br> {$billing_address['address1']}
                    {if $billing_address['address2']}<br> {$billing_address['address2']}{/if}
                    <br> {$billing_address['zipcode']}, {$billing_address['city']}
                </div>
                <br>
                <b>NIF:</b> {$nif}
                <br><br>
                <b>Payment Method:</b> PayPal
            </div>
        </div>
    </div>
    <br>
    <a href="#" id="btn-confirm" class="btn btn-success pull-right">
        Confirm <span class="glyphicon glyphicon-chevron-right"></span>
    </a>
</div>

<script>
    var vars = {$vars|json_encode};
</script>
{include file='common/footer.tpl'}
