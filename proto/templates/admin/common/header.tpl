<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>{$title}</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="apple-touch-icon" href="apple-touch-icon.png">
	<link rel="stylesheet" href="{$BASE_URL}css/bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="{$BASE_URL}css/bootstrap/bootstrap-theme.min.css">
	<link rel="stylesheet" href="{$BASE_URL}css/admin/main.css">
	<link rel="stylesheet" href="{$BASE_URL}css/font-awesome/font-awesome.min.css">
	<link rel="shortcut icon" type="image/png" href="{$BASE_URL}images/assets/favicon.ico" />
	<link rel="stylesheet" href="{$BASE_URL}css/font-awesome/font-awesome.min.css">
	{foreach $css as $elem}
		<link rel="stylesheet" href="{$BASE_URL}css/{$elem}">
	{/foreach}
</head>

<body class="preload">
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header pull-left">
				<button id="menu-toggle" type="button" class="navbar-toggle navbar-toggle-btn">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="{$BASE_URL}pages/admin/index.php">Online Store Administration</a>

			</div>
			<ul class="nav navbar-nav navbar-right pull-right">
				<li><a href="{$BASE_URL}pages/"><span class="glyphicon glyphicon-log-out"></span><span class="hidden-xs"> Exit</span></a></li>
			</ul>
		</div>
	</nav>
	<div id="wrapper">
		<!-- Sidebar -->
		<div id="sidebar-wrapper">
			<div id="sidebar" class="list-group panel">
				<a href="{$BASE_URL}pages/admin/index.php" class="list-group-item">Dashboard</a>
				<a href="{$BASE_URL}pages/admin/orders.php" class="list-group-item">Orders</a>
				<a href="#sub3" class="list-group-item collapsed" data-toggle="collapse" data-parent="#sidebar-wrapper" aria-expanded="false">Products<span class="caret"></span></a>
				<div class="collapse" id="sub3" aria-expanded="false" role="link">
					<a href="{$BASE_URL}pages/admin/product/new.php" class="list-group-item">New Product</a>
					<a href="{$BASE_URL}pages/admin/product/list.php" class="list-group-item">Edit product</a>
				</div>
				<a href="{$BASE_URL}pages/admin/categories.php" class="list-group-item">Categories</a>
				<a href="#sub5" class="list-group-item">Users</a>
				<a href="#sub6" class="list-group-item collapsed" data-toggle="collapse" data-parent="#sidebar-wrapper" aria-expanded="false">Marketing<span class="caret"></span></a>
				<div class="collapse" id="sub6" aria-expanded="false" role="link">
					<a href="#" class="list-group-item">Coupon codes</a>
					<a href="#" class="list-group-item">Promotions</a>
				</div>
			</div>
		</div>
		<!-- /#sidebar-wrapper -->
		<!-- Page Content -->
		<div id="page-content-wrapper">
			<div class="container-fluid">
