# =================================
# Misc Configuration

envConfig = process.env
githubAuthString = "client_id=#{envConfig.GITHUB_CLIENT_ID}&client_secret=#{envConfig.GITHUB_CLIENT_SECRET}"

# =================================
# DocPad Configuration

module.exports =
	regenerateEvery: 1000*60*60  # hour

	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:
		# Site Data
		site:
			url: "http://collinforrester.com"
			title: "Collin Forrester"
			author: "Collin Forrester"
			email: "collin.forrester@gmail.com"
			description: """
				Website of Collin Forrester.  Mobile, web, and food developer. AngularJS, NodeJS, and Android enthusiast.
				"""
			keywords: """
				Collin Forrester, forrester, coffeescript, node.js, javascript, html5, docpad, nowpad, jquery, css3, angularjs, git, nosql, cson, html5 history api, ajax, html, web development, web design, nlp, git, neuro-linguistic programming, programming, hacking, hackathon, aloha editor, contenteditable, hallo, jekyll, entp, inventor, web 2.0
				"""

			text:
				heading: "Collin Forrester"
				subheading: '''
					<t render="html.coffee">
						link = @getPreparedLink.bind(@)
						text """
							#{link 'angular'}, #{link 'javascript'}, #{link 'nodejs'}  &amp; #{link 'android'} enthusiast.<br/>
							Web, mobile, and food developer.<br/>
							<br/>
							#{link 'contact'}.
							"""
					</t>
					'''
				about: '''
					<t render="html.coffee">
						link = @getPreparedLink.bind(@)
						text """
							This website was created with #{link 'bevry'}’s #{link 'docpad'} and is #{link 'source'}
							"""
					</t>
					'''
				copyright: '''
					<t render="html.md">
						Unless stated otherwise; all works are Copyright © 2013+ [Collin Forrester](http://collinforrester.com) and licensed under the [MIT License](http://creativecommons.org/licenses/MIT/)
					</t>
					'''

			services:
				twitterTweetButton: "cforrester07"
				twitterFollowButton: "cforrester07"
				githubFollowButton: "collinforrester"
				disqus: 'collinforrester'
				googleAnalytics: 'UA-36540785-1'
				facebookLike: false
				facebookFollowButton: false
				redditSubmit: false
				hackerNewsSubmit: false

			social:
				"""
				linkedin
				github
				twitter
				""".trim().split('\n')

			scripts: """
				/vendor/jquery-1.7.1.js
				/vendor/fancybox-2.0.5/jquery.fancybox.js
				/scripts/script.js
				""".trim().split('\n')

			feeds: [
					href: 'https://github.com/collinforrester.atom'
					title: 'GitHub Activity'
				,
					href: 'https://api.twitter.com/1/statuses/user_timeline.atom?screen_name=cforrester07&count=20&include_entities=true&include_rts=true'
					title: 'Tweets'
			]

			pages: [
					url: '/'
					match: '/index'
					label: 'home'
					title: 'Return home'
				,
					url: '/projects'
					label: 'projects'
					title: 'View projects'
				,
					url: '/blog'
					label: 'blog'
					title: 'View articles'
			]

			links:
				docpad:
					text: 'DocPad'
					url: 'http://docpad.org'
					title: 'Visit Website'
				android:
					text: 'Android',
					url: 'http://developer.android.com'
					title: 'Visit Website'
				hostel:
					text: 'Startup Hostel'
					url: 'http://startuphostel.org'
					title: 'Visit Website'
				angular:
					text: 'AngularJS'
					url: 'http://angularjs.org'
					title: 'Visit Website'
				backbonejs:
					text: 'Backbone.js'
					url: 'http://backbonejs.org'
					title: 'Visit Website'
				historyjs:
					text: 'History.js'
					url: 'http://historyjs.net'
					title: 'Visit Website'
				bevry:
					text: 'Bevry'
					url: 'http://bevry.me'
					title: 'Visit Website'
				services:
					text: 'Services'
					url: 'http://bevry.me/services'
					title: "View my company's services"
				opensource:
					text: 'Open-Source'
					url: 'http://en.wikipedia.org/wiki/Open-source_software'
					title: 'Visit on Wikipedia'
				html5:
					text: 'HTML5'
					url: 'http://en.wikipedia.org/wiki/HTML5'
					title: 'Visit on Wikipedia'
				javascript:
					text: 'JavaScript'
					url: 'http://en.wikipedia.org/wiki/JavaScript'
					title: 'Visit on Wikipedia'
				nodejs:
					text: 'Node.js'
					url: 'http://nodejs.org/'
					title: 'Visit Website'
				collinforrester:
					text: 'Collin Forrester'
					url: 'http://collinforrester.com'
					title: 'Visit Website'
				author:
					text: 'Collin Forrester'
					url: 'http://collinforrester.com'
					title: 'Visit Website'
				source:
					text: 'open-source'
					url: 'https://github.com/collinforrester/collinforrester.docpad'
					title: 'View Website Source'
				contact:
					text: 'Contact'
					url: 'mailto:collin.forrester@gmail.com'
					title: 'Contact me'
					cssClass: 'contact-button'

		# Link Helper
		getPreparedLink: (name) ->
			link = @site.links[name]
			renderedLink = """
				<a href="#{link.url}" title="#{link.title}" class="#{link.cssClass or ''}">#{link.text}</a>
				"""
			return renderedLink

		# Meta Helpers
		getPreparedTitle: -> if @document.title then "#{@document.title} | #{@site.title}" else @site.title
		getPreparedAuthor: -> @document.author or @site.author
		getPreparedEmail: -> @document.email or @site.email
		getPreparedDescription: -> @document.description or @site.description
		getPreparedKeywords: -> @site.keywords.concat(@document.keywords or []).join(', ')


	# =================================
	# Collections

	collections:
		pages: ->
			@getCollection('documents').findAllLive({pageOrder:$exists:true},[pageOrder:1])

		posts: ->
			@getCollection('documents').findAllLive({relativeOutDirPath:'blog'},[date:-1])


	# =================================
	# Events

	events:

		serverExtend: (opts) ->
			# Prepare
			docpadServer = opts.server

			# ---------------------------------
			# Server Configuration

			# Redirect Middleware
			docpadServer.use (req,res,next) ->
				if req.headers.host in ['www.collinforrester.com']
					res.redirect 301, 'http://collinforrester.com'+req.url
				else
					next()

			# ---------------------------------
			# Server Extensions

			# Demos
			docpadServer.get /^\/sandbox(?:\/([^\/]+).*)?$/, (req, res) ->
				project = req.params[0]
				res.redirect 301, "http://collinforrester.github.com/#{project}/demo/"
				# ^ github pages don't have https

			# Projects
			docpadServer.get /^\/projects\/(.*)$/, (req, res) ->
				project = req.params[0] or ''
				res.redirect 301, "https://github.com/collinforrester/#{project}"

			docpadServer.get /^\/(?:g|gh|github)(?:\/(.*))?$/, (req, res) ->
				project = req.params[0] or ''
				res.redirect 301, "https://github.com/collinforrester/#{project}"

			# Twitter
			docpadServer.get /^\/(?:t|twitter|tweet)(?:\/(.*))?$/, (req, res) ->
				res.redirect 301, "https://twitter.com/cforrester07"


	# =================================
	# Plugin Configuration

	plugins:
		feedr:
			feeds:
				'github-profile':
					url: "https://api.github.com/users/collinforrester?#{githubAuthString}"
				'collinforrester-projects':
					url: "https://api.github.com/users/collinforrester/repos?per_page=100&#{githubAuthString}"
				#'flattr':
				#	url: 'https://api.flattr.com/rest/v2/users/balupton/activities.atom'
				'github':
					url: "https://github.com/collinforrester.atom"
				'twitter':
					url: "https://api.twitter.com/1/statuses/user_timeline.json?screen_name=cforrester07&count=20&include_entities=true&include_rts=true"
				'vimeo':
					url: "http://vimeo.com/api/v2/balupton/videos.json"
				'youtube':
					#url: "http://gdata.youtube.com/feeds/base/users/balupton/uploads?alt=json&orderby=published&client=ytapi-youtube-profile"
					url: "http://gdata.youtube.com/feeds/api/playlists/PLYVl5EnzwqsQs0tBLO6ug6WbqAbrpVbNf?alt=json"
				#'flickr':
				#	url: "http://api.flickr.com/services/feeds/photos_public.gne?id=35776898@N00&lang=en-us&format=json"

