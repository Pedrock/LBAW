<!doctype html>
<html class="no-js" lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title><?= $title ?></title>
		<meta name="description" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="apple-touch-icon" href="apple-touch-icon.png">
		<link rel="stylesheet" href="../css/bootstrap.min.css">
		<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
		<link rel="stylesheet" href="css/index.css">
		<link rel="shortcut icon" type="image/png" href="favicon.ico"/>
	</head>

	<body>
		<nav class="navbar navbar-inverse">
			<div class="container-fluid">
				<div class="navbar-header">
				<button id="menu-toggle" type="button" class="navbar-toggle navbar-toggle-btn">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>                        
					</button>
					<a class="navbar-brand" href="#">Online Store Administration</a>
				</div>
			</div>
		</nav>
		 <div id="wrapper">

        <!-- Sidebar -->
        <div id="sidebar-wrapper">
        	<div id="sidebar" class="list-group panel">
        		<a href="#sub1" class="list-group-item">Dashboard</a>
        		<a href="#sub2" class="list-group-item">Orders</a>
        		<a href="#sub3" class="list-group-item collapsed" data-toggle="collapse" data-parent="#sidebar-wrapper" aria-expanded="false">Products<span class="caret"></span></a>
        		<div class="collapse" id="sub3" aria-expanded="false">
        			<a href="#" class="list-group-item">Add Product</a>
        			<a href="#" class="list-group-item">Edit product</a>
        		</div>
        		<a href="#sub3" class="list-group-item">Users</a>
        		<a href="#sub4" class="list-group-item collapsed" data-toggle="collapse" data-parent="#sidebar-wrapper" aria-expanded="false">Marketing<span class="caret"></span></a>
        		<div class="collapse" id="sub4" aria-expanded="false">
        			<a href="#" class="list-group-item">Coupon codes</a>
        			<a href="#" class="list-group-item">Promotions</a>
        		</div>
        	</div>
        </div>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper">
            <div class="container-fluid">