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

function openReviewBox(){
	$('#before-review').slideUp(400);

	$('#post-review-box').slideDown(400, function(){
		$('#body-review').focus();
	});
}

$('#leave-a-review').on('click', openReviewBox);

function closeReviewBox(){
	$('#post-review-box').slideUp(400);
	$('#before-review').slideDown(400);
	$('#alert-error').slideUp(400);
}

$('#close-review-box').on('click', closeReviewBox);

$('.rating > span').on('click',function() {
	$(this).siblings().addBack().removeClass('selected');
	$(this).nextAll().addBack().addClass('selected');
});

$('#review-form').submit(function(e) {
	e.preventDefault();

	var product_id = $('span#header-product').attr('data-id');
	var score = $('#score .selected').length;
	var body = $('#body-review').val();

	if (score === 0)
	{
		alert_error("Please enter a score.");
		return;
	}

	$.ajax({
		url: "../api/product/review.php",
		type: "POST",
		data: {product_id:product_id, score:score, body:body},
		dataType: 'json',
		complete: function(xhr){
			if (Math.floor(xhr.status/100) == 2)
			{
				$('#alert-error').slideUp();
				insertReview(score, body, xhr.responseJSON.date);
				$('span#product-score').text(xhr.responseJSON.averagescore);
				$('#score-container').removeClass('hidden');
				$('#no-reviews').slideUp();
				$('#score-container .full-stars').css('width',(xhr.responseJSON.averagescore*20)+'%');
				$('#leave-a-review').hide();
				closeReviewBox();
			}
			else if(xhr.responseJSON)
			{
				if (xhr.responseJSON.error)
				{
					alert_error(xhr.responseJSON.error);
				}
			}
			else
			{
				alert_error("An error occurred. Please try again.");
			}
		}
	});

});


function alert_error(error)
{
	$("#alert-error").remove();
	$('<div id="alert-error" class="alert alert-danger fade in"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
		+'<strong>Error!</strong> '
		+error
		+'</div>').hide().fadeIn("fast").insertBefore($(".review-row.hidden"));
}

function insertReview(score, body, date)
{
	var dummy_review = $('.review-row.hidden');
	var review = dummy_review.clone();
	review.removeClass('hidden');
	review.find('p').text(body);
	review.find('.star').slice(0,score).removeClass('glyphicon-star-empty').addClass('glyphicon-star');
	review.find('.review-date').text(date);
	dummy_review.after(review);
}
