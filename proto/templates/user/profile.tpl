{assign "title" {"HashStore - My Orders"}}
{assign var="css" value=['my_orders.css','profile.css']}
{assign var="js" value=['user/profile.js']}
{include file='common/header.tpl'}

<div id="main-title">
    <span class="title">Profile</span>
</div>
<div id="profile">
    <div class="row info-addresses">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#saved_addresses">Saved addresses</a></li>
            <li><a data-toggle="tab" href="#new_address">New address</a></li>
        </ul>
        <div class="tab_content tab-content">
            <div id="saved_addresses" class="tab-pane fade in active">
                <ul class="row">
                    {foreach from=$addresses name=address item=address}
                        <li class="saved-address list-group-item col-sm-6 col-md-4 col-lg-3" data-id="{$address['id']}">
                            <div class="address-btns">
                                <a href="#" class="btn-delete-addr fa fa-trash btn-trash" aria-label="delete"></a>
                                <a href="#" class="btn-edit-addr fa fa-pencil" aria-label="edit"></a>
                            </div>
                            <div class="address">
                                <div>{$address['name']}</div>
                                <div>{$address['address1']}</div>
                                <div>{$address['address2']}</div>
                                <div><span class="zip">{$address['zipcode']}</span>, <span class="city">{$address['city']}</span></div>
                                <div>{$address['phonenumber']}</div>
                            </div>
                        </li>
                        {foreachelse}
                        <div id="no-addresses" class="text-center">You do not have any saved address.</div>
                    {/foreach}
                        {if (!empty($addresses))}
                            <div id="no-addresses" class="text-center hidden">You do not have any saved address.</div>
                        {/if}
                    <li id="dummy-address" class="saved-address list-group-item col-sm-6 col-md-4 col-lg-3 hidden">
                        <div class="address-btns">
                            <a href="#" class="btn-delete-addr fa fa-trash btn-trash" aria-label="delete"></a>
                            <a href="#" class="btn-edit-addr fa fa-pencil" aria-label="edit"></a>
                        </div>
                        <div class="address">
                            <div></div>
                            <div></div>
                            <div></div>
                            <div><span class="zip"></span>, <span class="city"></span></div>
                            <div></div>
                        </div>
                    </li>
                </ul>
            </div>
            <div id="new_address" class="tab-pane fade">
                <form action="javascript:void(0);">
                    <div class="col-md-6">
                        <div class="row">
                            <fieldset class="form-group">
                                <label for="name">Name</label>
                                <input type="text" class="form-control" id="name" name="name">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="addr1">Address line 1</label>
                                <input type="text" class="form-control" id="addr1" name="addr1" placeholder="Street address, P.O. box, company name">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="addr2">Address line 2</label>
                                <input type="text" class="form-control" id="addr2" name="addr2" placeholder="Apartment, suite, unit, building, floor, etc">
                            </fieldset>
                        </div>
                    </div>
                    <div class="col-md-5 col-md-offset-1">
                        <div class="row">
                            <fieldset class="form-group">
                                <label for="zip">ZIP</label>
                                <input type="text" class="form-control" id="zip" name="zip" >
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="city">City</label>
                                <input readonly type="text" class="form-control city" id="city">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="phone">Phone number</label>
                                <input type="text" class="form-control" id="phone" name="phone">
                            </fieldset>
                        </div>
                        <div class="row">
                            <button type="submit" class="btn btn-success pull-right add-button">Add Address</button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </form>
            </div>
        </div>
    </div>
    <div id="form-profile" class="tab_content tab-content">
        <form action="javascript:void(0);">
            <div class="col-md-6">
                <div class="row">
                    <fieldset class="form-group">
                        <label for="nif">Nif</label>
                        <input name="nif" type="text" class="form-control" id="nif" value="{$nif}">
                    </fieldset>
                    <fieldset class="form-group">
                        <label for="email">Email</label>
                        <input name="email" type="text" class="form-control" id="email" value="{$email}">
                    </fieldset>
                </div>
            </div>
            <div class="col-md-5 col-md-offset-1">
                <div class="row">
                    <fieldset class="form-group">
                        <label for="password">Current Password</label>
                        <input name="password" type="password" class="form-control" id="password" value="">
                    </fieldset>
                    <fieldset class="form-group">
                        <label for="password1">New Password</label>
                        <input name="password1" type="password" class="form-control" id="password1" value="">
                    </fieldset>
                    <fieldset class="form-group">
                        <label for="password2">Repeat New Password</label>
                        <input name="password2" type="password" class="form-control" id="password2" value="">
                    </fieldset>
                </div>
            </div>
            <div class="clearfix"></div>
            <button type="submit" class="btn btn-success btn-save">Save Changes</button>
        </form>
    </div>


    <!--edit-->
    <!-- Modal Edit -->
    <div class="modal fade" id="edit" role="dialog">
        <div class="modal-dialog modal-sm modal-edit">
            <form class="modal-content" action="javascript:void(0);">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Address</h4>
                </div>
                <div class="modal-body row">
                    <div class="col-md-6">
                        <div class="row">
                            <fieldset class="form-group">
                                <label for="name">Name</label>
                                <input type="text" class="form-control" id="name-edit" name="name">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="addr1">Address line 1</label>
                                <input type="text" class="form-control" id="addr1-edit" name="addr1" placeholder="Street address, P.O. box, company name">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="addr2">Address line 2</label>
                                <input type="text" class="form-control" id="addr2-edit" name="addr2" placeholder="Apartment, suite, unit, building, floor, etc">
                            </fieldset>
                        </div>
                    </div>
                    <div class="col-md-5 col-md-offset-1">
                        <div class="row">
                            <fieldset class="form-group">
                                <label for="zip">ZIP</label>
                                <input type="text" class="form-control" id="zip-edit" name="zip" >
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="city">City</label>
                                <input readonly type="text" class="form-control city" id="city-edit">
                            </fieldset>
                            <fieldset class="form-group">
                                <label for="phone">Phone number</label>
                                <input type="text" class="form-control" id="phone-edit" name="phone">
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">Save Changes</button>
                </div>
                <input type="hidden" name="id">
            </form>
        </div>
    </div>


</div>

{include file='common/footer.tpl'}
