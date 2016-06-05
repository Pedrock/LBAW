{assign "title" {"HashStore - Cart"}}
{assign var="css" value=["cart.css"]}
{include file='common/header.tpl'}
{assign "js" ['cart.js','cart_common.js']}

<div id="cart">
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
    <div class="content">
        {assign var="total" value=0}
        {foreach from=$cart item=product}
        <div class="row product-cart" data-id="{$product.id}" data-price="{$product.price}" data-quantity="{$product.quantity}">
            <div class="col-xs-12 col-sm-8">
                <a href="product.php?id={$product.id}" class="link-p">
                    <img class="product_img" src="{$BASE_URL}images/products/{$product.photo}" alt="">
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
            <div class="text-center hidden empty-cart">Your cart is empty.</div>
        {foreachelse}
            <div class="text-center empty-cart">Your cart is empty.</div>
        {/foreach}

        <div class="row text-right">
            <div class="col-sm-offset-8 col-sm-2 col-xs-4 col-xs-offset-4">Subtotal: </div>
            <div class="col-sm-2 col-xs-4">
                <span><span id="subtotal">{$total}</span> €</span>
            </div>
        </div>
    </div>
</div>
<button id="btn-checkout" class="btn btn-primary pull-right">
    <span>Checkout </span><span class="glyphicon glyphicon-chevron-right"></span>
</button>

{include file='common/footer.tpl'}