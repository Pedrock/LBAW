$('.href_add').click(function(e) {
	e.preventDefault();
	e.stopPropagation();

	$("#add").find('.description').val('');

	$('.error').hide();
	$('#add').modal('show');
});

function showError(msg) {
	$('.error .msg').html(msg);
	$('.error').slideDown();
}

function getAndSetID(elem) {
	var meta_id = $(elem).parent().data('id');
	$('.cat_id').val(meta_id);
	var categ_name = $(elem).parent().find('.category').text();
	$("#edit").find('.description').val(categ_name);
	$('.category_name').text(categ_name);
}

$('#metadata_container').on('click', '.href_del', function(e) {
	e.preventDefault();
	e.stopPropagation();

	getAndSetID(this);

	$('.error').hide();
	$('#del').modal('show');
});

$('#metadata_container').on('click', '.href_edit', function(e) {
	e.preventDefault();
	e.stopPropagation();

	getAndSetID(this);

	$('.error').hide();
	$('#edit').modal('show');
});

$('.filter').on('input', function(e) {
	var txt = $(this).val().toLowerCase();
	var showCount = 0;

	$('.item2 .category').each(function(index) {
		if($(this).text().toLowerCase().indexOf(txt) > -1) {
			$(this).parent().show();
			showCount++;
		} else
			$(this).parent().hide();
	});
	if(showCount > 0){
		$('#empty').hide();
		$('#categories').show();
	} else {
		$('#empty').show();
		$('#categories').hide();
	}
});

function deleteMetadata(id) {
	$('#meta_' + id).slideUp(500, function() {
		$(this).remove();
		checkAnyVisible();
	});
}

function editMetadata(id, txt) {
	$('#meta_' + id).find('.category').html(txt);
}

function newMetadata(id, txt) {
	var elem = $('.template').clone();
	elem.removeClass('template');
	elem.removeClass('hidden');
	elem.addClass('item');
	elem.addClass('item2');
	elem.attr('id', 'meta_' + id);
	elem.data('id', id);
	elem.find('.category').html(txt);
	elem.hide();
	$('#metadata_container').prepend(elem);
	elem.slideDown();
	checkAnyVisible();
}

$('#form_add').submit(function(e) {
	e.preventDefault();
	e.stopPropagation();

	var txt = $(this).find('.description').val();

	sendAjax(new FormData(this), function(id) {
		newMetadata(id, txt);
		$('#add').modal('hide');
	});
});

$('#form_edit').submit(function(e) {
	e.preventDefault();
	e.stopPropagation();

	var txt = $(this).find('.description').val();

	sendAjax(new FormData(this), function(id) {
		editMetadata(id, txt);
		$('#edit').modal('hide');
	});
});

$('#form_delete').submit(function(e) {
	e.preventDefault();
	e.stopPropagation();

	sendAjax(new FormData(this), function(id) {
		deleteMetadata(id);
		$('#del').modal('hide');
	});
});

function sendAjax(fd, after) {
	$.ajax({
		url: "../../../api/admin/product/metadata_categories.php",
		type: "POST",
		data: fd,
		contentType: false,
		processData: false,
		dataType: 'json'
	}).done(function(data) {
		if(data.error)
			showError(data['error']);
		else 
			after(data['success']);
	}).fail(function(err) {
		if(err.responseJSON)
			showError(err.responseJSON['error']);
		else
			showError('There was an error');
	});
}

function checkAnyVisible() {
	var found = false;

	$('.item2').each(function(index) {
		if($(this).is(':visible')) {
			$('#empty').hide();
			found = true;
		}
	});
	
	if(!found)
		$('#empty').show();
}