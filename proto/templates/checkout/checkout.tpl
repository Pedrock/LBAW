{assign "title" {"HashStore - Checkout"}}
{assign var="css" value=["checkout/checkout.css"]}
{assign "js" ['checkout/checkout.js']}
{include file='common/header.tpl'}

<div id="shipping_address">
    <div class="top_row row">
        <div>
            <span class="title"><span class="glyphicon glyphicon-plane"> </span> Shipping Address</span>
        </div>
    </div>
    <div class="row">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#saved_shipping_addresses">Saved addresses</a></li>
            <li><a data-toggle="tab" href="#new_shipping_address">New address</a></li>
        </ul>
        <div class="shipping_tab_content tab-content">
            <div id="saved_shipping_addresses" class="tab-pane fade in active">
                <ul class="row">
                    {foreach from=$addresses name=address item=address}
                    <li class="list-group-item col-sm-6 col-md-4 col-lg-3">
                        <div>
                            <input type="radio" name="ship_addr" id="ship_addr{$smarty.foreach.address.iteration}" value="{$address.id}">
                        </div>
                        <div>
                            <label for="ship_addr{$smarty.foreach.address.iteration}">
                                {$address['name']}
                                <br>{$address['address1']}
                                {if $address['address2']}<br>{$address['address2']}{/if}
                                <br>{$address['zipcode']}, {$address['city']}
                            </label>
                        </div>
                    </li>
                    {foreachelse}
                        <div class="text-center">You do not have any saved address.</div>
                    {/foreach}
                </ul>
            </div>
            <div id="new_shipping_address" class="tab-pane fade">
                <form action="javascript:void(0);">
                    <div class="col-md-6">
                        <div class="row">
                            <fieldset class="form-group">
                                <label for="shipping_name">Name</label>
                                <input required type="text" class="form-control" id="shipping_name" name="shipping_name">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="shipping_addr1">Address line 1</label>
                                <input required type="text" class="form-control" id="shipping_addr1" name="shipping_addr1" placeholder="Street address, P.O. box, company name">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="shipping_addr2">Address line 2</label>
                                <input type="text" class="form-control" id="shipping_addr2" name="shipping_addr2" placeholder="Appartment, suite, unit, building, floor, etc">
                            </fieldset>
                        </div>
                    </div>
                    <div class="col-md-5 col-md-offset-1">
                        <div class="row">
                            <fieldset class="form-group">
                                <label for="shipping_zip">ZIP</label>
                                <input required type="text" class="form-control zipcode" id="shipping_zip" name="shipping_zip" >
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="shipping_city">City</label>
                                <input readonly type="text" class="form-control city" id="shipping_city" name="shipping_city">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="shipping_phone">Phone number</label>
                                <input required type="text" class="form-control phone" id="shipping_phone" name="shipping_phone">
                            </fieldset>
                            {*<fieldset class="form-group">
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="save_shipping"> Save for future purchases
                                </label>
                            </fieldset>*}
                        </div>
                    </div>
                    <div class="row"></div>
                </form>
            </div>
          </div>
    </div>
</div>
<div id="billing_address">
    <div class="top_row row">
        <div>
            <span class="title"><span class="glyphicon glyphicon-euro"> </span> Billing Address</span>
        </div>
    </div>
    <form class="form-inline" role="form" action="javascript:void(0);">
        <fieldset class="form-group">
            <label for="name">NIF</label>
            <input type="text" class="form-control" id="nif" value="{$nif}">
        </fieldset>
        &nbsp;&nbsp;
        <label class="checkbox-inline">
            <input checked="checked" type="checkbox" name="same" id="same"> Same address as shipping
        </label>
    </form>
    <div id="same_as_shipping">
        The shipping address chosen above will be used as billing address.
    </div>
    <div id="billing_box" class="row">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#saved_billing_addresses">Saved addresses</a></li>
            <li><a data-toggle="tab" href="#new_billing_address">New address</a></li>
        </ul>
        <div class="billing_tab_content tab-content">
            <div id="saved_billing_addresses" class="tab-pane fade in active">
                <ul class="row">
                    {foreach from=$addresses name=address item=address}
                    <li class="list-group-item col-sm-6 col-md-4 col-lg-3">
                        <div>
                            <input type="radio" name="bill_addr" id="bill_addr{$smarty.foreach.address.iteration}" value="{$address.id}">
                        </div>
                        <div>
                            <label for="bill_addr{$smarty.foreach.address.iteration}">
                                {$address['name']}
                                <br>{$address['address1']}
                                {if $address['address2']}<br>{$address['address2']}{/if}
                                <br>{$address['zipcode']}, {$address['city']}
                            </label>
                        </div>
                    </li>
                    {foreachelse}
                        <div class="text-center">You do not have any saved address.</div>
                    {/foreach}
                </ul>
            </div>
            <div id="new_billing_address" class="tab-pane fade">
                <form action="javascript:void(0);">
                    <div class="col-md-6">
                        <div class="row">
                            <fieldset class="form-group">
                                <label for="billing_name">Name</label>
                                <input required type="text" class="form-control" id="billing_name" name="billing_name">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="billing_addr1">Address line 1</label>
                                <input required type="text" class="form-control" id="billing_addr1" name="billing_addr1" placeholder="Street address, P.O. box, company name">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="billing_addr2">Address line 2</label>
                                <input type="text" class="form-control" id="billing_addr2" name="billing_addr2" placeholder="Appartment, suite, unit, building, floor, etc">
                            </fieldset>
                        </div>
                    </div>
                    <div class="col-md-5 col-md-offset-1">
                        <div class="row">
                            <fieldset class="form-group">
                                <label for="billing_zip">ZIP</label>
                                <input required type="text" class="form-control zipcode" id="billing_zip" name="billing_zip">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="billing_city">City</label>
                                <input readonly type="text" class="form-control city" id="billing_city" name="billing_city">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="billing_phone">Phone number</label>
                                <input required type="text" class="form-control phone" id="billing_phone" name="billing_phone">
                            </fieldset>
                           {* <fieldset class="form-group">
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="save_billing"> Save for future purchases
                                </label>
                            </fieldset>*}
                        </div>
                    </div>
                    <div class="row"></div>
                </form>
            </div>
        </div>
    </div>
</div>

<form id="payment-form" action="confirm.php" method="post" onsubmit="return payment();">
    {*<div id="payment_methods">
        <div class="top_row row">
            <span class="title"><span class="glyphicon glyphicon-credit-card"> </span> Payment Method</span>
        </div>
        <div class="row content">
            Please choose a payment method:
            <div class="row">
                <div class="col-xs-4 radio">
                    <label>
                        <input type="radio" name="payment_method" value="cc">Credit Card</input>
                    </label>
                </div>
                <div class="col-xs-4 radio">
                    <label>
                        <input type="radio" name="payment_method" value="pp">PayPal</input>
                    </label>
                </div>
                <div class="col-xs-4 radio">
                    <label>
                        <input type="radio" name="payment_method" value="atm">ATM</input>
                    </label>
                </div>
                &nbsp;
            </div>
        </div>
    </div> *}
    <br>
    <button id="btn-update" class="btn btn-success pull-right">
        Continue <span class="glyphicon glyphicon-chevron-right"></span>
    </button>
</form>

{include file='common/footer.tpl'}
