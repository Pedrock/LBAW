$(document).ready(function(){
	$('.datetime').datetimepicker({
		dateFormat: "yy-mm-dd",
		timeFormat: "hh:mm"
	});
});

hideError();

if($('.coupon_row').length > 0)
	$('#no_discounts').hide();

if(create)
	$("#new").modal('show');

$("#new_coupon").click(function(e) {
	e.preventDefault();
	$("#new").modal('show');
	//else
	//	window.location = "product/list.php?coupon";
});

$("#coupons_body").on('click', '.coupon_row', function(e) {
	e.preventDefault();
	e.stopPropagation();
	hideError();
	id = $(this).data('id');
	var code = $(this).children('.code').text();
	var perc = $(this).children('.perc').children('.num').text();
	var start = $(this).children('.span').children('.start').text();
	var end = $(this).children('.span').children('.end').text();
	$('#edit').find('.code').val(code);
	$('#edit').find('.percentage').val(perc);
	$('#edit').find('.start').val(start);
	$('#edit').find('.end').val(end);
	console.log(id);
	$('#edit').find('.coupon_id').val(id);
	$("#edit").modal('show');
	$('#del').hide();
});

$("#btn_del").click(function(e) {
	hideError();
	$("#del").slideDown();
});

$('input#active_only').on('change', function() {

	if ($('input#active_only').prop('checked'))
		window.location = "coupons.php?&active";
	else
		window.location = "coupons.php?";
});

$("#btn_del_cancel").click(function(e) {
	$("#del").slideUp();
});

$("#btn_del_confirm").click(function(e) {
	$("#del").slideUp();

	hideError();

	$.ajax({
		url: "../../api/admin/coupons.php",
		type: "POST",
		data: {action: 'delete', id: id},
		dataType: 'json'
	}).done(function(data) {
		console.log(data);
		if(data.error)
			showError(data['error']);
		else {
			$("#edit").modal('hide');

			$('#disc_' + id).slideUp(400, function() { $(this).remove(); });

			if($('.coupon_row').length == 0)
				$('#no_discounts').slideDown();
		}
	}).fail(function(err) {
		console.log(err);
		if(err.responseJSON)
			showError(err.responseJSON['error']);
		else
			showError('There was an error');
	});
});

$('#form_edit').submit(function(e) {
	e.preventDefault();
	e.stopPropagation();

	hideError();

	var fd = new FormData(this);

	$.ajax({
		url: "../../api/admin/coupons.php",
		type: "POST",
		data:fd,
		contentType: false,
		processData: false,
		dataType: 'json'
	}).done(function(data) {
		if(data.error)
			showError(data['error']);
		else {
			var code = $('#edit').find('.code').val();
			var perc = $('#edit').find('.percentage').val();
			var start = $('#edit').find('.start').val();
			var end = $('#edit').find('.end').val();


			$('#disc_' + id).children('.code').text(code);
			$('#disc_' + id).children('.perc').children('.num').text(perc);
			$('#disc_' + id).children('.span').children('.start').text(start);
			$('#disc_' + id).children('.span').children('.end').text(end);
			$('#disc_' + id).data('id', data.idcoupon);
			$('#disc_' + id).attr('id', "#disc_" + data.idcoupon);
			$('#edit').modal('hide');
		}
	}).fail(function(err) {
		console.log(err);
		if(err.responseJSON)
			showError(err.responseJSON['error']);
		else
			showError('There was an error');
	});
});

$('#form_create').submit(function(e) {
	e.preventDefault();
	e.stopPropagation();

	hideError();

	var fd = new FormData(this);

	$.ajax({
		url: "../../api/admin/coupons.php",
		type: "POST",
		data:fd,
		contentType: false,
		processData: false,
		dataType: 'json'
	}).done(function(data) {
		if(data.error)
			showError(data['error']);
		else {
			window.location.reload();
		}
	}).fail(function(err) {
		console.log(err);
		if(err.responseJSON)
			showError(err.responseJSON['error']);
		else
			showError('There was an error');
	});
});

function hideError() {
	$('.error').hide();
}

function showError(msg) {
	$('.error .message').html(msg);
	$('.error').slideDown();
}