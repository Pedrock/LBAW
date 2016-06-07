{assign "title" "Dashboard"}
{include file='admin/common/header.tpl'}
<div class="row">
	<div class="col-lg-12">
		<h1>Dashboard</h1>
		<p>This is the main administration page.</p>

		<canvas width="583" height="291" style="width: 583px; height: 291px;"></canvas>
	</div>
</div>
<script>
	var purchases = {$purchases|json_encode}; 
</script>
{assign var=js value=['../vendor/Chart.min.js', 'index.js']}
{include file='admin/common/footer.tpl'}