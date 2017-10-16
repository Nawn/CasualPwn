$(document).on('turbolinks:load', (() ->
	$('.post-container').infiniteScroll({
		# Options
		path: '.next_page'
		append: '.blog-post'
		})))