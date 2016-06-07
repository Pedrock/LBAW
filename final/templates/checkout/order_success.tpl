{assign "title" "HashStore - Order Complete"}
{assign "css" ["checkout/confirm.css"]}
{assign "js" []}
{include file='common/header.tpl'}

<div id="order">
    <div class="top_row row">
        <span class="title"><span class="glyphicon glyphicon-shopping-cart"> </span> Order Complete</span>
    </div>
    <div class="row content">
        <div class="order-info">
            {foreach from=$products item=product}
                <div class="row">
                    <div class="col-xs-8 product_title">
                        <a href="#" class="link-p">
                            <img class="product_img"{if $product.photo} src="../../images/products/thumb_{$product.photo}"{else} src="../../images/assets/default_product.png"{/if} alt="">
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
                {if $order_info['coupon_discount']}
                    <div class="col-xs-6 col-xs-offset-6 col-sm-4 col-sm-offset-8"><b>Discount:</b> {$order_info['coupon_discount']}%</div>
                {/if}
                <div class="col-xs-6 col-xs-offset-6 col-sm-4 col-sm-offset-8"><b>Subtotal:</b> {$order_info['totalprice']} €</div>
                <div class="col-xs-6 col-xs-offset-6 col-sm-4 col-sm-offset-8"><b>Shipping:</b> {$order_info['shippingcost']} €</div>
                <div class="col-xs-6 col-xs-offset-6 col-sm-4 col-sm-offset-8"><b>Total:</b> {$order_info['totalprice']+ $shipping} €</div>
                <div>
                    <br><b>Shipping address:</b>
                    <br> {$order_info['shipping_name']}
                    <br> {$order_info['shipping_address1']}
                    {if $order_info['shipping_address2']}<br> {$order_info['shipping_address2']}{/if}
                    <br> {$order_info['shipping_zip1']}-{$order_info['shipping_zip2']}, {$order_info['shipping_city']}
                </div>
                <div>
                    <br><b>Billing address:</b>
                    <br> {$order_info['billing_name']}
                    <br> {$order_info['billing_address1']}
                    {if $order_info['billing_address2']}<br> {$order_info['billing_address2']}{/if}
                    <br> {$order_info['billing_zip1']}-{$order_info['billing_zip2']}, {$order_info['billing_city']}
                </div>
                <br>
                <b>NIF:</b> {$order_info['nif']}
                <br><br>
                <b>Payment Method:</b> PayPal
            </div>
        </div>
    </div>
</div>

{include file='common/footer.tpl'}
