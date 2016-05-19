$(".other-photos a").click(function(event) {
	event.preventDefault();
	event.stopPropagation();

	var img_src = $(this).children('img').attr('src');
	var img = $('#product-main-img img');
	var transition_delay = 100;

	if(img.attr('src') == img_src)
		return;

	img.animate({ opacity: 0 }, transition_delay, 
		function () { img.attr('src', img_src); });
    img.animate({ opacity: 1 }, transition_delay);
});

$("#product-main-img").click(function(event) {
	event.preventDefault();
	event.stopPropagation();

	var fullImage = $(this).children('img').attr('src').replace('thumb_', '');

	$('#photo_large').attr('src', fullImage);
	$("#popup_photo").fadeIn("fast");
});

$("#popup_photo").click(function(event) {
	$("#popup_photo").fadeOut("fast");
});

$("#photo_large").click(function(event) {
	$("#popup_photo").fadeOut("fast");
});