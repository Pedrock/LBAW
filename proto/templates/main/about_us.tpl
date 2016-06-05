{assign "title" {"HashStore - About Us"}}
{assign var="css" value=['contact_about_us.css']}
{include file='common/header.tpl'}

<div id="main-title">
	<span class="title">About Us</span>
</div>
<div id="about-us">
	<div class="img-feup col-md-6">
			<img class="img-responsive" src="{$BASE_URL}images/assets/about_us.JPG" width="490" alt="Faculdade de Engenharia da Universidade do Porto">
	</div>
	<div id="text-about-us" class="col-md-6">
		<h4>Group 64 - HashStore</h4>
		<div class="row">
			<p>We are the group 64 of the course of LBAW, 2016. Our project was the website you are now visiting.</p>
			<p>This project is intended for the development of an information system available over the Web for supporting an online store. Our system allows the sale of any kind of products online and keeps information about the various products, including name, description, photos, price, weight, stock, dimensions, brand and other optional meta-information.</p>
			<p>The system maintains a history of all the previous purchases. Buyers can keep a list of favorite products which can be organized in custom lists. Users can add reviews which include a score (1 to 5 stars) and an optional comment. Each product is displayed alongside its average score. Users also have the option to use coupon codes. There can also be discounts, associated to products, with a start and expiration date. </p>
		</div>
	</div>
</div>

{include file='common/footer.tpl'}
