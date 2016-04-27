			</div>
		</div>
	</div>
	<footer>
		<div id="inside-footer" class="container">
			<a href="contact_us.php"><span class="glyphicon glyphicon-phone-alt"></span> Contact Us</a>
			<a href="about_us.php"> About Us</a>
		</div>
	</footer>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script>
		window.jQuery || document.write('<script src="{$BASE_URL}javascript/vendor/jquery-1.11.2.min.js"><\/script>')
	</script>
	<script src="{$BASE_URL}javascript/logout.js"></script>
	<script src="{$BASE_URL}javascript/vendor/bootstrap.min.js"></script>
	{foreach $js as $elem}
		<script src="{$BASE_URL}javascript/{$elem}"></script>
	{/foreach}
</body>

</html>
