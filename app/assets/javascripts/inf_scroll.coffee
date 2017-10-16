$(document).on('turbolinks:load', (() ->
	$('.post-container').infiniteScroll({
		# Options
		path: '.pagination .next a'
		append: '.blog-post'
		})))