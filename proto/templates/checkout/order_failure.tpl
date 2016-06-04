{assign "title" "HashStore - Order Failure"}
{assign "css" ["checkout/confirm.css"]}
{assign "js" []}
{include file='common/header.tpl'}

<div id="order">
    <div class="top_row row">
        <span class="title">Order Failure</span>
    </div>
    <div class="row content text-center">
        <div id="order1" class="order-info">
            <div class="row">
                {$message}
            </div>
        </div>
    </div>
</div>

{include file='common/footer.tpl'}
