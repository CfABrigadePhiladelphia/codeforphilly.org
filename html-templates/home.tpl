{extends designs/site.tpl}

{block header}
	{$dwoo.parent}

	<div class="hero-unit">
		<div class="caption">
			<h1>Code for Philly</h1>
			<p>
				is an open group of citizens, working to harness the power of technology
				to modernize citizenship in Philadelphia.
			</p>
			<p>
    			<a href="{tif $.User ? '/projects' : '/register'}" class="btn btn-primary">Start Hacking</a>
    			<small>or <a href="/mission">Learn More&hellip;</a></small>
			</p>
<!--
			<p>
				We are technologists, organizers, educators, and change-makers who know that we can’t wait
				for the future to come down from the top. With our allies at <a href="http://codeforamerica.org">Code for America</a>
				and the <a href="http://phila.gov">City of Philadelphia</a>, we provide a conduit for active citizens to
				connect with each other and with Philadelphia’s open government movement.
			</p>
-->
		</div>
	</div>
{/block}

{block content-wrapper-open}<div class="container-fluid">{/block}
{block content}
	<nav class="sidebar left">

		<section class="tagsSummary projects">
			<h4><a href="/projects">Projects <span class="badge badge-info">{$projectsTotal|number_format}</span></a></h4>

			<header class="btn-group">
				<a href="#projects-by-tech" class="tagFilter active btn btn-mini" data-group="byTech">by tech</a> |
				<a href="#projects-by-topic" class="tagFilter btn btn-mini" data-group="byTopic">by topic</a>
			</header>

			<ul class="tags nav nav-tabs nav-stacked byTech">
				{foreach item=tag from=$projectsTags.byTech}
					<li>{tagLink tagData=$tag rootUrl="/projects"}</li>
				{/foreach}
			</ul>

			<ul class="tags nav nav-tabs nav-stacked byTopic" style="display: none">
				{foreach item=tag from=$projectsTags.byTopic}
					<li>{tagLink tagData=$tag rootUrl="/projects"}</li>
				{/foreach}
			</ul>
		</section>

		<section class="tagsSummary members">
			<h4><a href="/members">Members <span class="badge badge-info">{$membersTotal|number_format}</span></a></h4>

			<header class="btn-group">
				<a href="#members-by-tech" class="tagFilter active btn btn-mini" data-group="byTech">by tech</a> |
				<a href="#members-by-topic" class="tagFilter btn btn-mini" data-group="byTopic">by topic</a>
			</header>

			<ul class="tags nav nav-tabs nav-stacked byTech">
				{foreach item=tag from=$membersTags.byTech}
					<li>{tagLink tagData=$tag rootUrl="/members"}</li>
				{/foreach}
			</ul>

			<ul class="tags nav nav-tabs nav-stacked byTopic" style="display: none">
				{foreach item=tag from=$membersTags.byTopic}
					<li>{tagLink tagData=$tag rootUrl="/members"}</li>
				{/foreach}
			</ul>
		</section>

		<section class="resources">
			<a href="/resources"><h4>Civic Hacking Resources</h4></a>
			<ul class="nav nav-tabs nav-stacked">
				<li><a href="/chat">Code for Philly Chatroom</h3></a></li>
				<li><a href="http://opendataphilly.org">OpenDataPhilly</h3></a></li>
				<li><a href="http://opendata.stackexchange.com/">Open Data Stack Exchange</h3></a></li>
				<li><a href="http://commons.codeforamerica.org/">CfA Commons</h3></a></li>
			</ul>
		</section>

		{*
		<a href="#"><h5>Events (108)</h5></a>
		<ul>
			<li><a href="#">Workshops (100/3)</h3></a></li>
			<li><a href="#">Hackathons (10/4)</h3></a></li>
			<li><a href="#">Social (6/3)</h3></a></li>
		</ul>
		<h6><a href="#">event count</a> | <a href="#">next closest</a></h6>

		<a href="#"><h5>Help Wanted (10)</h5></a>
		<ul>
			<li><a href="#">PHP (1)</a></li>
			<li><a href="#">JS (2)</a></li>
			<li><a href="#">Python (100)</a></li>
			<li><a href="#">Rails (42)</a></li>
		</ul>
		<h6><a href="#">job count</a> | <a href="#">by tech</a></h6>

		<a href="#"><h5>Help Offered</h5></a>
		<ul>
			<li><a href="#">Django (2)</a></li>
			<li><a href="#">Node.js (1)</a></li>
		</ul>
		<h6><a href="#">job count</a> | <a href="#">by tech</a></h6>
		*}
	</nav>

	<aside class="sidebar right meetups">
			
		{if $currentMeetup}
			<article class="meetup meetup-current">
				<h3><strong>Current</strong> Meetup</h3>
				{meetup $currentMeetup showRsvp=false}
				<form class="checkin" action="/checkin" method="POST">
					<input type="hidden" name="MeetupID" value="{$currentMeetup.id}">
					<select name="ProjectID" class="project-picker">
						<option value="">Current Project (if any)</option>
						{foreach item=Project from=Project::getAll()}
							<option value="{$Project->ID}">{$Project->Title|escape}</option>
						{/foreach}
					</select>
					<input type="submit" value="Check In" class="btn btn-success">
				</form>
				<aside class="checkins">
					<h4>Checked-in Members</h4>
					{$lastProjectID = null}
					<h5 class="muted">No Current Project</h5>
					<ul class="nav nav-pills nav-stacked">
					{foreach item=Checkin from=$currentMeetup.checkins}
						{if $Checkin->ProjectID != $lastProjectID}
							</ul>
							<h5>{if $Checkin->Project}{projectLink $Checkin->Project}{/if}</h5>
							{$lastProjectID = $Checkin->ProjectID}
							<ul class="nav nav-pills nav-stacked">
						{/if}
						<li>{memberLink $Checkin->Member}</li>
					{/foreach}
					</ul>
				</aside>
			</article>
		{/if}

		{if $nextMeetup}
			<article class="meetup meetup-next">
				<h3><strong>Next</strong> Meetup</h3>
				{meetup $nextMeetup}
			</article>
		{/if}

		{if count($futureMeetups)}
			<h3>Future Meetups</h3>
			{foreach item=futureMeetup from=$futureMeetups}
				<article class="meetup meetup-future">
					{meetup $futureMeetup}
				</article>
			{/foreach}
		{/if}

	</aside>

	<section class="content fixed-fixed">
		<article>
			<h2>Latest Project Activity</h3>
			<div class="row-fluid">

					{foreach item=Update from=$updates}
						{projectUpdate $Update headingLevel=h3 showProject=true}
					{/foreach}
	
			</div> <!-- .row-fluid -->
			<a href="/project-updates">See More&hellip;</a>
		</article>
	</section>
{/block}
{block content-wrapper-close}</div>{/block}

{block js-bottom}
	{$dwoo.parent}
	{jsmin "sidebar-tags.js+sidebar-checkin.js"}
{/block}