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
		window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')
	</script>
	<script src="js/vendor/bootstrap.min.js"></script>
	<?php
		if (isset($js)) {
			foreach ($js as $elem) { ?>
				<script src="js/<?=$elem?>"></script>
			<?php }
		}
	?>
</body>

</html>
