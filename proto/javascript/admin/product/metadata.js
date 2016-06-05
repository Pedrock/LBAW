$('.href_add').click(function(e) {
	e.preventDefault();
	e.stopPropagation();

	$('.filter').val('');
	updateCatList('');

	$('.cat_radio').removeAttr('checked');

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
	var categ_desc = $(elem).parent().find('.description').text();
	$('.category_name').text(categ_name);
	$('input.description').val(categ_desc);
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

	updateCatList(txt);
});

function deleteMetadata(id) {
	$('#meta_' + id).slideUp(500, function() {
		$(this).remove();
		checkAnyVisible();
		disableAlreadyUsed();
	});
}

function editMetadata(id, description) {
	$('#meta_' + id).find('.description').html(description);
}

function newMetadata(id, title, description) {
	var elem = $('.template').clone();
	elem.removeClass('template');
	elem.removeClass('hidden');
	elem.addClass('item');
	elem.attr('id', 'meta_' + id);
	elem.data('id', id);
	elem.find('.category').html(title);
	elem.find('.description').html(description);
	elem.hide();
	$('#metadata_container').prepend(elem);
	elem.slideDown();
	checkAnyVisible();
	disableAlreadyUsed();
}

function disableAlreadyUsed() {
	$('.cat_radio').removeAttr('disabled');

	$('.item').each(function(index) {
		var id = $(this).data('id');
		$('#cat_' + id).attr('disabled', true);
	});
}

function updateCatList(txt) {
	var showCount = 0;

	$('.cat_name').each(function(index) {
		if($(this).text().toLowerCase().indexOf(txt) > -1) {
			$(this).parent().show();
			showCount++;
		} else
			$(this).parent().hide();
	});

	if(showCount > 0){
		$('#no_cats_found').hide();
		$('#categories').show();
	} else {
		$('#no_cats_found').show();
		$('#categories').hide();
	}
}

disableAlreadyUsed();

$('#form_add').submit(function(e) {
	e.preventDefault();
	e.stopPropagation();

	if (!$("input[name='cat']:checked").val()) {
		showError('You must select one category');
		return;
	}

	var txt2 = $(this).find('.description').val();

	sendAjax(new FormData(this), function(id) {
		newMetadata(id, $('#cat_' + id).next().text(), txt2);
		$('#add').modal('hide');
	});
});

$('#form_edit').submit(function(e) {
	e.preventDefault();
	e.stopPropagation();

	var id = $(this).find('.cat_id').val();
	var txt = $(this).find('.description').val();

	sendAjax(new FormData(this), function() {
		editMetadata(id, txt);
		$('#edit').modal('hide');
	});
});

$('#form_delete').submit(function(e) {
	e.preventDefault();
	e.stopPropagation();

	var id = $(this).find('.cat_id').val();

	sendAjax(new FormData(this), function() {
		deleteMetadata(id);
		$('#del').modal('hide');
	});
});

function sendAjax(fd, after) {
	$.ajax({
		url: "../../../api/admin/product/metadata.php",
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

	$('.item').each(function(index) {
		if($(this).is(':visible')) {
			$('#empty').hide();
			found = true;
		}
	});
	
	if(!found)
		$('#empty').show();
}