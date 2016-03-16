<?php 
$title = "Favorites";
$css = ["favorites.css"];

function product($name, $id)
{ ?>
	<div class="row favorite">
		<div class="col-sm-8 product_title">
			<a href="#">
				<img class="fav_img" src="Images/<?=$id?>.jpg" alt="">
			</a>
			<a href="#"><span><?=$name?></span></a>
		</div>
		<div class="pull-right">
			<a class="fav-btn" href="#" data-toggle="modal" data-target="#<?=$id?>"><span class="glyphicon glyphicon-sort"></span>Move</a>
			<a class="fav-btn" href="#"><span class="glyphicon glyphicon-remove"></span>Delete</a>

			<!-- Modal -->
			<div class="modal fade" id="<?=$id?>" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Change category</h4>
						</div>
						<div class="modal-body">
							<label for="#<?=$id?>">Select new category:</label>
							<select class="form-control" id="#<?=$id?>">
								<option>None</option>
								<option>T-shirts</option>
								<option>Computers</option>
							</select>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
<?php
}

include("templates/header.php") ?>
<div id="main-title">
	<span class="title">Favorites</span>
</div>
<div id="favorites">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">Uncategorized Favorites</h3>
		</div>
		<div class="panel-body">
			<?php product("Blue Graphic T-Shirt","product-4") ?>
		</div>
	</div>
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">Categorized Favorites</h3>
		</div>
		<div class="panel-body">
			<div class="panel-group" id="favorites-accordion">
				<div class="panel panel-info">
					<div class="panel-heading">
						<h4 class="panel-title">
							<a data-toggle="collapse" data-parent="#favorites-accordion" href="#collapse1">T-shirts <span class="caret"></span></a>
						</h4>
					</div>
					<div id="collapse1" class="panel-collapse collapse">
						<div class="panel-body">
							<?php product("Age Of Wisdom Tan Graphic Tee","product-1") ?>
							<?php product("Classic Laundry Green Graphic T-Shirt","product-2") ?>
							<?php product("Classic Laundry Green Graphic T-Shirt","product-3") ?>
						</div>
					</div>
				</div>

				<div class="panel panel-info">
					<div class="panel-heading">
						<h4 class="panel-title">
							<a data-toggle="collapse" data-parent="#favorites-accordion" href="#collapse2">Computers <span class="caret"></span></a>
						</h4>
					</div>
					<div id="collapse2" class="panel-collapse collapse">
						<div class="panel-body">
							<?php product("Asus ROG 15.6' GL552VW","product-9") ?>
						</div>
					</div>
				</div>
			</div>
			<button id="new-category" type="button" class="btn btn-primary">New category</button>
		</div>
	</div>
</div>
<?php include("templates/footer.php") ?>