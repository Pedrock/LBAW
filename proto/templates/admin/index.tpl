{assign "title" "Dashboard"}
{include file='admin/common/header.tpl'}
<div class="row">
	<div class="col-lg-12 text-center">
		<h1>Dashboard</h1>
		<canvas style="max-width:1000px"></canvas>
	</div>
</div>
<script>
	var purchases = {$purchases|json_encode}; 
</script>
{assign var=js value=['../vendor/Chart.min.js', 'index.js']}
{include file='admin/common/footer.tpl'}