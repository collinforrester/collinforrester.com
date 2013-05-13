wait = (ms,fn) -> setTimeout(fn,ms)


###
Flash some elements really quickly
###
$.fn.flash = (options, callback) ->

	# Prepare
	$els = $(this)
	options = options or {}

	# Animate
	$els.clearQueue().stop(true, true).queue ->
		$this = $(this)
		duration = options.duration or 200
		times = options.times or 3
		opacity = options.opacity or 0.25
		transition = $this.css("-webkit-transition")
		$this.css "-webkit-transition", "none"
		i = undefined
		i = 0
		while i < times - 1
			$this.animate(
				opacity: opacity
			,
				duration: duration
			).animate
				opacity: 1
			,
				duration: duration

			++i
		$this.animate(
			opacity: opacity
		,
			duration: duration
		).animate(
			opacity: 1
		,
			duration: duration
			complete: ->
				$this.css "-webkit-transition", transition
				callback.call this	if callback
		).dequeue()


	# Chain
	this


$ ->
	$body = $(document.body)
	$backdrop = $('.modal-backdrop')
	$profiles = $('.profile')
	$nav = $('.main-nav')

	$profiles.find('.close').add($backdrop).click ->
		$profiles.removeClass('in')
		$body.removeClass('modal-open')
		$backdrop.removeClass('in').hide()
		$nav.children().removeClass('sel')

	$('.social-link').each ->
		$this = $(this)
		socialID = $this.data('socialid')
		socialSelector = '.'+socialID
		$selected = $profiles.filter(socialSelector)
		return  if $selected.length is 0

		$this.click (event) ->
			return	if event.which == 2 || event.metaKey

			event.preventDefault()

			$active = $profiles.filter('.in')
			$body.addClass('modal-open')
			$backdrop.show().addClass('in')

			$this.parent().addClass('sel').siblings('.sel').removeClass('sel')

			if $active.is(socialSelector)
				$selected.flash(times:1,opacity:0.25,duration:100)
			else
				$active.fadeOut 200, -> $active.removeClass('in').show()
				$selected.addClass('in')