<div id="myCarousel" class="carousel slide" data-ride="carousel">
	<ol class="carousel-indicators">
		{foreach from=$carousel item=car name=car}
		<li data-target="#myCarousel" data-slide-to="{$smarty.foreach.car.iteration - 1}" {if $smarty.foreach.car.first}class="active"{/if}></li>
		{/foreach}
	</ol>
	<div class="carousel-inner" role="listbox">
		{foreach from=$carousel item=car name=car}
			<div class="item {if $smarty.foreach.car.first}active{/if}">
				{if $car.link != null}<a href="{$car.link}">{/if}
				<img src="../images/carousel/{$car.image}" alt="">
				{if $car.link != null}</a>{/if}
			</div>
		{/foreach}
	</div>
	<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
		<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		<span class="sr-only">Previous</span>
	</a>
	<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
		<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		<span class="sr-only">Next</span>
	</a>
</div>