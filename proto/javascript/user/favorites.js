var elem1;
function deleteFavorite()
{
	var elem = $(this);
	var product_id = elem.closest('.favorite').attr('data-id');
	$.ajax({
		type: "POST",
		url: base_url + "api/favorites/remove.php",
		data: {product: product_id}
	}).done(function() {
		elem.closest('.favorite').slideUp();
	});
}

function deleteFavoriteList()
{
	var elem = elem1;
	var id = elem.closest('.favorite-list').attr('data-id');
	$.ajax({
		type: "POST",
		url: base_url + "api/favorites/remove_list.php",
		data: {list_id: id}
	}).done(function() {
		var ele = elem.closest('.favorite-list');
		ele.slideUp();
	});
	$('#modal_delete_list').modal('hide');
}

$('.btn-delete-favorite').on('click',deleteFavorite);

$('#modal_delete_list #confirm-delete').on('click',deleteFavoriteList);
$('#modal_delete_list #cancel-delete').on('click',function(){
	$('#modal_delete_list').modal('hide');
});
$('.btn-delete-favorite-list').on('click',function(){
	elem1 = $(this);
	$('#modal_delete_list').modal('show');
});

$('#favorites').on('click', '.btn-move-favorite', function() {
	var product_id = $(this).closest('.favorite').attr('data-id');
	var list_id = $(this).closest('.favoritelist').attr('data-id');
	$('#modal_change').attr('data-id',product_id);
	$('#modal_change').attr('data-list',list_id);
	$('#modal_change select').val(list_id);
});

function insertFavorite(parent_div, elem)
{
	elem.hide();
	var last = true;
	parent_div.children('.favorite').each(function()
	{
		if ($(this).attr('data-position') > elem.attr('data-position')) {
			$(this).before(elem);
			last = false;
			return false;
		}
	});
	if (last)
		parent_div.append(elem);
	elem.slideDown();
};

$('#modal_change form').submit(function()
{
	$('#modal_change').modal('hide');
	var product_id = $('#modal_change').attr('data-id');
	var prev_list_id = $('#modal_change').attr('data-list');
	var new_list_id = $('#modal_change select').val();

	if (prev_list_id != new_list_id)
	{
		$.ajax({
			type: "POST",
			url: base_url + "api/favorites/move.php",
			data: {product: product_id, new_list: new_list_id}
		}).done(function() {
			var clone = $('.favorite[data-id="'+product_id+'"]').clone();
			$('.favorite[data-id="'+product_id+'"]').attr('data-id','').slideUp(function() {$(this).remove();});
			insertFavorite($('.favoritelist[data-id="'+new_list_id+'"] > .panel-body'), clone);
			$('.btn-delete-favorite-list').on('click',function(){
				elem1 = $(this);
				$('#modal_delete_list').modal('show');
			});

		});
	}
});


$('#modal_new form').submit(function () {
	$('#modal_new').modal('hide');
	var name = $('#list_name').val();
	$.ajax({
		type: "POST",
		url: base_url + "api/favorites/newlist.php",
		data: {list_name: name}
	}).done(function(id) {
		var clone = $('#dummy-list').clone();
		clone.hide();
		clone.attr('id','').removeClass('hidden');
		clone.find('.name').text(name);
		clone.closest('.favorite-list').attr('data-id',id);
		clone.find('.favoritelist').attr('data-id',id).attr('id','collapse'+id);
		clone.find('.panel-title > a').attr('href','#collapse'+id);
		$('#dummy-list').before(clone);
		clone.slideDown();
		$('#categories_select').append('<option value="'+id+'">'+name+'</option>');
		$('.btn-delete-favorite-list').on('click',function(){
			elem1 = $(this);
			$('#modal_delete_list').modal('show');
		});
	});
});

$('#modal_new').on('show.bs.modal', function() {
	$('#modal_new input[type=text]').val('');
});
$('#modal_new').on('shown.bs.modal', function() {
	$('.modal input[type=text]').focus();
});