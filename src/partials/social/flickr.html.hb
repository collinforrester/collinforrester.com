<div class="profile flickr modal fade-large" id="instagram-profile">
	{{#with user.person}}
	<div class="profile-info">
		<button class="close" data-dismiss="modal">×</button>
		<div class="profile-name">
			<h2>{{ realname }}</h2>
		</div>
		{{#if description}}<p class="profile-description">{{{ description }}}</p>{{/if}}
		<p class="profile-location-url">
			<span><a href="{{ profileurl }}">{{ profileurl }}</a></span>
		</p>
	</div>
	<ul class="profile-stats">
		{{#with photos}}
			<li><span><strong>{{ count }}</strong> pictures</span></li>
			<li><span><strong>{{ firstdatetaken }}</strong> since</span></li>
		{{/with}}
	</ul>
	{{/with}}
	<ul class="profile-shots">
		{{#each photos.items}}
		<li>
			<a href="{{ link }}" class="profile-shot">
				<img src="{{ media.m }}" alt="Flickr Picture" />
			</a>
			<span class="profile-shot-title">
				{{#if title}}
					{{ title }}
				{{else}}
					Untitled
				{{/if}}
			</span>
			<ul class="profile-shot-stats">
				<li class="profile-shot-date">{{ date_taken }}</li>
			</ul>
		</li>
		{{/each}}
	</ul>
	{{#if pagination}}
	{{#with pagination}}
	<button class="load-more-button" id="load-more-pics" data-control-next="{{ next_max_id }}">Load more...</button>
	{{/with}}
	{{/if}}
</div>

