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
  <link rel="stylesheet" href="{$BASE_URL}css/main.css">
  <link rel="stylesheet" href="{$BASE_URL}css/font-awesome/font-awesome.min.css">
  <link rel="shortcut icon" type="image/png" href="{$BASE_URL}images/assets/favicon.ico" />
  {foreach $css as $elem}
        <link rel="stylesheet" href="{$BASE_URL}css/{$elem}">
  {/foreach}
</head>

<body>
  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="{$BASE_URL}pages/index.php">HashStore</a>
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
      </div>
      <div class="collapse navbar-collapse" id="myNavbar">
        <div class="col-lg-8 col-md-7 col-sm-6">
          <form id="searchBar" class="navbar-form navbar-left" role="search" action="{$BASE_URL}pages/list.php">
            <div class="input-group">
              {if $category}
                <input type="hidden" name="cat" value="{$category}">
              {/if}
              <input type="text" class="form-control" name="search" placeholder="Search..." value="{if $query}{$query}{/if}">
              <span class="input-group-btn">
                <button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></span></button>
              </span>
            </div>
          </form>
        </div>
        <ul class="nav navbar-nav navbar-right">
          <li><a href="{$BASE_URL}pages/cart.php"><span class="glyphicon glyphicon-shopping-cart"></span> Cart</a></li>
          {if $smarty.session.user}
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-user"></span> {$smarty.session.username}<span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="{$BASE_URL}pages/user/favorites.php">Favorites</a></li>
              <li><a href="{$BASE_URL}pages/user/my_orders.php">My Orders</a></li>
              <li><a href="{$BASE_URL}pages/user/profile.php">Profile</a></li>
              {if $smarty.session.admin}
                <li role="separator" class="divider"></li>
                <li><a href="{$BASE_URL}pages/admin/">Administration</a></li>
              {/if}
              <li role="separator" class="divider"></li>
              <li><a id="logout" href="#">Sign Out</a></li>
            </ul>
          </li>
          {else}
          <li><a href="{$BASE_URL}pages/login.php"><span class="glyphicon glyphicon-log-in"></span> Log In</a></li>
          {/if}
        </ul>
      </div>
    </div>
  </nav>

  {if $display_carousel}
    {include file='main/carousel.tpl'}
  {/if}

  <div id="wrapper" class="container-fluid">
    <div class="row">
    {if $categories}
      <div class="col-sm-4 col-md-3 col-lg-2">
        <div id="categories">
          <span class="title">Categories</span>
        </div>
        <div id="main-menu">
          {foreach from=$categories item=category}
          <a href="{$BASE_URL}pages/list.php?cat={$category.id}{$lnk_query}{$lnk_order}" class="list-group-item">{$category.name}</a>
          {/foreach}
        </div>
      </div>
      <div id="content-wrapper" class="col-sm-8 col-md-9 col-lg-10">
    {else}
      <div id="content-wrapper" class="container">
    {/if}
      