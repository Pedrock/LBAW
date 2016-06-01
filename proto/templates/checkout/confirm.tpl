{assign "title" "HashStore - Confirm Order"}
{assign "css" ["checkout/confirm.css"]}
{assign "js" ['cart_common.js', 'product-page.js']}
{include file='common/header.tpl'}

<div id="order">
    <div class="top_row row">
        <span class="title"><span class="glyphicon glyphicon-shopping-cart"> </span> Your order</span>
    </div>
    <div class="row content">
        <div id="order1" class="order-info">
            {assign "total" 0}
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
                    {assign "total" {$total + $product.price * $product.quantity}}
                </div>
            </div>
            {/foreach}
            <div class="order-details row">
                <div class="col-xs-4 col-xs-offset-8"><b>Total:</b> {$total} €</div>
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
                <b>Payment Method:</b> PayPal
            </div>
        </div>
    </div>
    <br>
    <a href="#" id="btn-update" class="btn btn-success pull-right">
        Confirm <span class="glyphicon glyphicon-chevron-right"></span>
    </a>
</div>
{include file='common/footer.tpl'}
