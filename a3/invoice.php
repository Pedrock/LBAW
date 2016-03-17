<!DOCTYPE html>
<html>
<head>
  <title>Invoice</title>
  <link rel="stylesheet" href="css/invoice.css">
</head>
<body>
  <img src="Images/logo2.png" height="40" alt="HashStore">

  <table>
    <tr>
      <td>
        <b>Order Placed: </b>17 March 2016
      </td>
    </tr>
    <tr>
      <td>
        <b>Order Number: </b>026-2796920-2042716
      </td>
    </tr>
    <tr>
      <td>
        <b>Payment Total: </b>EUR 54,53
      </td>
    </tr>
    <tr>
      <td>
        <table class="border">
          <tr>
            <th colspan="2">Dispatched on 18 March 2016</th>
          </tr>
          <tr>
            <td class="padding border" colspan="2">
              <table>
                <tr>
                  <td>
                    <div class="bold">Items Ordered</div>
                  </td>
                  <td class="align-right">
                    <div class="bold">Price</div>
                  </td>
                </tr>
                <tr id="items-ordered">
                  <td class="">
                    <div>1 of: <span class="italic">Age Of Wisdom Tan Graphic Tee</span></div>
                    <div>2 of: <span class="italic">Classic Laundry Green Graphic T-Shirt</span></div>
                  </td>
                  <td class="align-right">
                    <div>€19.99</div>
                    <div>€30.00</div>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td class="padding">
              <div class="bold">Delivery Address:</div>
              <div class="displayAddressDiv">
                <ul class="displayAddressUL">
                  <li class="displayAddressLI displayAddressFullName">John Smith</li>
                  <li class="displayAddressLI displayAddressAddressLine1">660 Sherwood Drive</li>
                  <li class="displayAddressLI displayAddressCityStateOrRegionPostalCode">Coram, NY 11727</li>
                  <li class="displayAddressLI displayAddressCountryName">United States of America</li>
                </ul>
              </div>
            </td>
            <td id="totals" class="padding">
              <table>
                <tr>
                  <td class="align-right">Item(s) Subtotal:</td>
                  <td class="align-right">EUR 49.99</td>
                </tr> 

                <tr>
                  <td class="align-right">Postage &amp; Packing:</td>
                  <td class="align-right">EUR 4.54</td>
                </tr> 

                <tr>
                  <td class="align-right">&nbsp;</td>
                  <td class="align-right">-----</td>
                </tr> 

                <tr>
                  <td class="align-right">Total before VAT:</td>
                  <td class="align-right">EUR 44.33</td>
                </tr> 

                <tr>
                  <td class="align-right">VAT:</td>
                  <td class="align-right">EUR 10.2</td>
                </tr> 

                <tr>
                  <td class="align-right">&nbsp;</td>
                  <td class="align-right">-----</td>
                </tr> 

                <tr>
                  <td class="align-right"><b>Total:</b></td>
                  <td class="align-right"><b>EUR 54,53</b></td>
                </tr> 

                <tr>
                  <td class="align-right">&nbsp;</td>
                  <td class="align-right">-----</td>
                </tr> 
              </table>
            </td>
          </tr>
        </table>
        <table class="border">
          <tr>
            <th>Payment Information</th>
          </tr>
          <tr>
            <td class="padding">
              <div class="bold">Payment Method:</div>
              <div>MasterCard/EuroCard | Last digits: 3108</div>
            </td>
          </tr>
          <tr>
            <td class="padding">
              <div class="bold">Invoice Address:</div>
              <div class="displayAddressDiv">
                <ul class="displayAddressUL">
                  <li class="displayAddressLI displayAddressFullName">John Smith</li>
                  <li class="displayAddressLI displayAddressAddressLine1">660 Sherwood Drive</li>
                  <li class="displayAddressLI displayAddressCityStateOrRegionPostalCode">Coram, NY 11727</li>
                  <li class="displayAddressLI displayAddressCountryName">United States of America</li>
                </ul>
              </div>
            </td>
          </tr>
          <tr class="footer">
            <td class="border">
              <table>
                <tr>
                  <td class="bold">Credit Card Transactions</td>
                  <td class="align-right">MasterCard/EuroCard ending in 3108: 8 January 2016: EUR 54,53</td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>