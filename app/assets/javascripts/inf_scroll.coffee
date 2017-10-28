$(document).on('turbolinks:load', (() ->
	$('.post-container').infiniteScroll({
		# Options
		path: '.pagination .next a'
		append: '.blog-post'
		history: false
		})

	aside = $("section.aside")
	if aside.length == 0
		console.log("Not Signed In")
	else
		console.log("Signed in")
		topOfAside = aside.offset().top
		height = aside.outerHeight()
		showAside = true
	
		$(window).scroll(() ->
				if $(window).scrollTop() > (topOfAside + height)
	
					if !showAside
	
					else
						$(".display-left-container").width("100%")
						$("section.aside").hide()
						showAside = false
				else
					if showAside
	
					else
						$(".display-left-container").attr("style", "")
						$("section.aside").show()
						showAside = true
			)
	))