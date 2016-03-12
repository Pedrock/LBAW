<?php 
$title = "Favorites";
$css = ["favorites.css"];
include("templates/header.php") ?>
<div id="favorites">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">Uncategorized Favorites</h3>
		</div>
		<div class="panel-body">
			...
		</div>
	</div>
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">Categorized Favorites</h3>
		</div>
		<div class="panel-body">
			<div class="panel panel-info">
				<div class="panel-heading">
					<h3 class="panel-title">Computers</h3>
				</div>
				<div class="panel-body">
					...
				</div>
			</div>
			<div class="panel panel-info">
				<div class="panel-heading">
					<h3 class="panel-title">Books</h3>
				</div>
				<div class="panel-body">
					...
				</div>
			</div>
		</div>
	</div>
</div>
<?php include("templates/footer.php") ?>