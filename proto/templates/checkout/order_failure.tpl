{assign "title" "HashStore - Order Failure"}
{assign "css" ["checkout/order_failure.css"]}
{assign "js" []}
{include file='common/header.tpl'}

<div id="order">
    <div class="top_row row">
        <span class="title">Order Failure</span>
    </div>
    <div class="row content text-center">
        <div class="row">
            {$message}
        </div>
        <a href="{$BASE_URL}pages/cart.php" class="btn btn-success pull-right">Go To Cart</a>
    </div>
</div>

{include file='common/footer.tpl'}
