---
title: 'Projects'
layout: 'page'
---

# Projects
projects = (@feedr.feeds['collinforrester-projects'] or [])
	.filter((a) -> a.fork is false)
	.sort?((a,b) -> b.watchers - a.watchers)

# Check
if projects.length
	# Prepare
	forksAmount = watchersAmount = 0
	for project in projects
		forksAmount += project.forks
		watchersAmount += project.watchers

	# Non-github projects
	h3 'ZingScan (Visitchu)'
	p '''
		My most recent and very exciting endeavor would be my work with <a href="http://zingscan.com">ZingScan</a>.
		A startup based in Tampa, FL, specializing in school security via a cloud based visitor management application.
		As the product matures and I learn more things, I plan on documenting and writing about the things I learned as
		the technology stack (PhoneGap, AngularJS, Node, Express) it uses is a widely used stack and I think others could
		benefit from my struggles.
		'''

	h2 'GitHub'

	# List
	text @partial 'content/project-list.html.coffee', {
		projects: projects
	}

	# Facts
	h3 'Totals'
	ul ->
		li -> "Projects: #{projects.length}"
		li -> "Stars: #{watchersAmount}"
		li -> "Forks: #{forksAmount}"
