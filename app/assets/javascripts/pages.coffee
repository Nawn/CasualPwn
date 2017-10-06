# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = () ->
        $(".menu-btn").click(() ->
                $(".mobile-nav").toggleClass("opened"))

        $('.signin-button').click(() ->
        	$('.sign-in-container').toggle()
        	return false)

$(document).on("turbolinks:load", ready)
