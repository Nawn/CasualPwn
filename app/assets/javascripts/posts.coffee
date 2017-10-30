# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('turbolinks:load', () ->
	tinymce.remove('#post_content')
	tinymce.remove('#guild_event_description')
	tinymce.init({
		selector: '#post_content',
		branding: false,
		resize: true,
		height: 350,
		content_css: 'http://' + window.location.host + '/css/mce_content.css, https://fonts.googleapis.com/css?family=Acme|Tangerine:700',
		invalid_elements: 'script',
		plugins: [
    		"advlist autolink autosave link image lists charmap print preview hr anchor pagebreak",
    		"searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
		    "table contextmenu directionality emoticons template textcolor paste fullpage textcolor colorpicker textpattern"
  		]
		})

	tinymce.init({
		selector: '#guild_event_description',
		branding: false,
		resize: true,
		height: 350,
		content_css: 'http://' + window.location.host + '/css/mce_content.css, https://fonts.googleapis.com/css?family=Acme|Tangerine:700',
		invalid_elements: 'script',
		plugins: [
    		"advlist autolink autosave link image lists charmap print preview hr anchor pagebreak",
    		"searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
		    "table contextmenu directionality emoticons template textcolor paste fullpage textcolor colorpicker textpattern"
  		]
		})
	)