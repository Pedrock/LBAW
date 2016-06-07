			</div>
		</div>
	</div>
	<footer>
		<div id="inside-footer" class="container">
			<a href="{$BASE_URL}pages/main/contact_us.php"><span class="glyphicon glyphicon-phone-alt"></span> Contact Us</a>
			<a href="{$BASE_URL}pages/main/about_us.php"> About Us</a>
			<a href="javascript:void(0)" class="pull-right">Load time: {round(microtime(true) - $load_start, 3)} s</a>
		</div>
	</footer>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script>
		var base_url = "{$BASE_URL}";
		window.jQuery || document.write('<script src="{$BASE_URL}javascript/vendor/jquery-1.11.2.min.js"><\/script>')
	</script>
	<script src="{$BASE_URL}javascript/logout.js"></script>
	<script src="{$BASE_URL}javascript/vendor/bootstrap.min.js"></script>
	{foreach $js as $elem}
		<script src="{$BASE_URL}javascript/{$elem}"></script>
	{/foreach}
</body>

</html>
