<!doctype html>
<html class="no-js" lang="">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title><?= $title ?></title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="apple-touch-icon" href="apple-touch-icon.png">
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="css/main.css">
	<link rel="shortcut icon" type="image/png" href="favicon.ico"/>
	<?php
		if (isset($css))
		{
			foreach ($css as $elem)
			{
				echo '<link rel="stylesheet" href="css/'.$elem.'">';
			}
		}
	?>
</head>

<body>
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="index.php">Online Store</a>
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<div class="col-lg-8 col-md-7 col-sm-6">
					<form id="searchBar" class="navbar-form navbar-left" role="search">
						<div class="input-group">
							<input type="text" class="form-control" name="search" placeholder="Search...">
							<span class="input-group-btn">
								<button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
							</span>
						</div>
					</form>
				</div>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="cart.php"><span class="glyphicon glyphicon-shopping-cart"></span> Cart</a></li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-user"></span> My Account<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="favorites.php">Favorites</a></li>
							<li><a href="my_orders.php">My Orders</a></li>
							<li><a href="#">Profile</a></li>
							<li role="separator" class="divider"></li>
							<li><a href="#">Sign Out</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<?php if (isset($display_carousel)) include("templates/carousel.php") ?>

	<div id="wrapper" class="container-fluid">
		<div class="row">
		<?php if (isset($remove_categories) && $remove_categories)
		{ ?>
			<div id="content-wrapper" class="container">
		<?php
		}
		else
		{ ?>
			<div class="col-sm-4 col-md-3 col-lg-2">
				<div id="categories">
					<span class="title">Categories</span>
				</div>
				<div id="main-menu" class="list-group panel">
					<a href="#" id="deals" class="list-group-item">Deals</a>
					<a href="#sub1" class="list-group-item" data-toggle="collapse" data-parent="#main-menu">Clothing &amp; Shoes<span class="glyphicon glyphicon-menu-down pull-right"></span></a>
					<div class="collapse<?php if (isset($category)) echo ' in'?>" id="sub1">
						<a href="#SubMenu1" class="list-group-item" data-toggle="collapse" data-parent="#SubMenu1">Men<span class="glyphicon glyphicon-menu-down pull-right"></span></a>
						<div class="collapse<?php if (isset($category)) echo ' in'?>" id="SubMenu1">
							<a href="category.php" class="list-group-item" data-parent="#SubMenu1">
							<?php if (isset($category)) echo '<span class="glyphicon glyphicon-chevron-right"></span> '?>T-shirts</a>
							<a href="#" class="list-group-item" data-parent="#SubMenu1">Pants</a>
							<a href="#SubSubMenu1" class="list-group-item" data-toggle="collapse" data-parent="#SubSubMenu1">Underwear<span class="glyphicon glyphicon-menu-down pull-right"></span></a>
							<div class="collapse" id="SubSubMenu1">
								<a href="#" class="list-group-item" data-parent="#SubSubMenu1">Boxers</a>
								<a href="#" class="list-group-item" data-parent="#SubSubMenu1">Socks</a>
							</div>
						</div>
						<a href="#" class="list-group-item">Women</a>
						<a href="#" class="list-group-item">Boys</a>
						<a href="#" class="list-group-item">Girls</a>
						<a href="#" class="list-group-item">Baby</a>
					</div>
					<a href="#" class="list-group-item">Beauty</a>
					<a href="#" class="list-group-item">Computers</a>
					<a href="#" class="list-group-item">Software</a>
					<a href="#" class="list-group-item">Electronics</a>
					<a href="#" class="list-group-item">Home</a>
					<a href="#" class="list-group-item">Sports &amp; Outdoors</a>
					<a href="#" class="list-group-item">Home Improvement</a>
					<a href="#" class="list-group-item">Toys &amp; Games</a>
					<a href="#" class="list-group-item">Video Games</a>
				</div>
			</div>
			<div id="content-wrapper" class="col-sm-8 col-md-9 col-lg-10">
		<?php
		}
		?>
			