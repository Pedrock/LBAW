{assign "title" {"HashStore - Cart"}}
{assign var="css" value=["cart.css"]}
{include file='common/header.tpl'}
{assign "js" ['cart.js','cart_common.js']}

<div id="cart" {if $discount}data-discount="{$discount}"{/if}>
    <div class="top_row row">
        <div id="cart_title" class="col-xs-12 col-sm-8">
            <span class="title"><span class="glyphicon glyphicon-shopping-cart"></span> Shopping Cart</span>
        </div>
        <div class="hidden-xs col-sm-2">
            Price
        </div>
        <div class="hidden-xs col-sm-2">
            Quantity
        </div>
    </div>
    {if $prices_changed}
        <div id="prices-changed" class="alert alert-danger">
            <div><strong>Attention!</strong> The price of at least one of your products has changed.
                Please review your cart and press OK to accept it.</div>
            <button class="btn btn-danger">OK</button>
        </div>
    {/if}
    <div class="content">
        {assign var="total" value=0}
        {foreach from=$cart item=product}
        <div class="row product-cart" data-id="{$product.id}" data-price="{$product.price}" data-quantity="{$product.quantity}">
            <div class="col-xs-12 col-sm-8">
                <a href="product.php?id={$product.id}" class="link-p">
                    <img class="product_img"{if $product.photo} src="{$BASE_URL}images/products/thumb_{$product.photo}"{else} src="{$BASE_URL}images/assets/default_product.png"{/if} alt="">
                </a>
                <div class="product_info">
                    <a href="product.php?id={$product.id}"><span class="product_title">{$product.name}</span></a>
                    <br>
                    <div class="desc">
                    </div>
                    <a href="#" onClick="deleteFromCart({$product.id});return false;"><span class="glyphicon glyphicon-remove"></span>Delete</a>
                </div>
            </div>
            <div class="col-xs-7 col-sm-2">
                <div class="qty_price">{$product.price} €</div>
                {assign var="total" value=$total + $product.quantity * $product.price}
            </div>
            <div class="col-xs-5 col-sm-2">
                <div class="qty_price">
                    <a href="#" onclick="updateQuantity({$product.id});return false;" class="fa fa-refresh fa-fw hidden"></a>
                    <input data-toggle="tooltip" data-trigger="manual" title="Not enough stock" type="text" class="form-control qty{if (!$product.enough_stock)} low-stock{/if}" value="{$product.quantity}">
                </div>
            </div>
        </div>
        {foreachelse}
            <div class="text-center empty-cart">Your cart is empty.</div>
        {/foreach}
            <div class="text-center hidden empty-cart">Your cart is empty.</div>
        <div class="row text-right">
            <div class="col-sm-offset-8 col-sm-2 col-xs-4 col-xs-offset-4">Subtotal: </div>
            <div class="col-sm-2 col-xs-4">
                <span><span id="subtotal">{$total}</span> €</span>
            </div>
            {if $discount}
                <div class="col-sm-offset-8 col-sm-2 col-xs-4 col-xs-offset-4">With coupon: </div>
                <div class="col-sm-2 col-xs-4">
                    <span><span id="totalcoupon">{($total*(100-$discount)/100.0)|round:"2"}</span> €</span>
                </div>
                {assign var="total" value={$total*(100-$discount)/100.0}}
            {/if}
            <div class="col-sm-offset-8 col-sm-2 col-xs-4 col-xs-offset-4">Shipping: </div>
            <div class="col-sm-2 col-xs-4">
                <span id="shipping">{$shipping}{if is_numeric($shipping)} €{/if}</span>
            </div>
            <div class="col-sm-offset-8 col-sm-2 col-xs-4 col-xs-offset-4">Total: </div>
            <div class="col-sm-2 col-xs-4">
                <span><span id="total">{($shipping + $total)|round:"2"}</span> €</span>
            </div>
        </div>
    </div>
</div>

<form id="coupon-form"">
    <div class="form-group">
        <label for="couponCode">Coupon Code: </label>
        <div class="input-group">
            <input autocomplete="off" type="text" class="form-control{if $invalid_coupon} invalid{/if}" name="coupon" placeholder="Coupon Code" value="{$coupon}">
            <button class="btn btn-default">OK</button>
        </div>
    </div>
</form>

<button id="btn-checkout" class="btn btn-primary pull-right">
    <span>Checkout </span><span class="glyphicon glyphicon-chevron-right"></span>
</button>


{include file='common/footer.tpl'}