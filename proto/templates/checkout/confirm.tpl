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
                {if $discount}
                    <div class="col-xs-6 col-xs-offset-6 col-sm-4 col-sm-offset-8"><b>Discount:</b> {$discount}%</div>
                {/if}
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
    <div class="btns text-right">
        <a href="#" id="btn-confirm" class="btn btn-success">
            Confirm <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
        <div id="spinner" class="hidden">
            <span aria-label="Loading"></span>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="error" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content panel-danger">
            <div class="modal-header panel-heading">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Error</h4>
            </div>
            <div class="modal-body">
                An error occurred. Please try again.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    var vars = {$vars|json_encode};
</script>
{include file='common/footer.tpl'}
