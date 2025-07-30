Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA41F8BA6;
	Wed, 30 Jul 2025 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916385; cv=none; b=jiboEygHX8g+YSYlI6qVXLmlvi/nJdNq1daurxu10Ee8Vjek03kTzpWjq5UTyHwaXrfRsBou4AFqF9zNcu0gTEpzXTpzEny9XJ6GzrhIlfNCawgZv6+2h+0jw9eYE5TPuxCq4M+Jh4Zf27V5CwQD+O9OJFxr1xODBiO5fn4tyT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916385; c=relaxed/simple;
	bh=sw1TAVhbjjieMP2pEg2JVm8qjXF311nK+4IsPc7U84w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaveOXn9DwC7E4uCXNu7jydg2xLFETn7/uv9anoVyPRpAnPnNu5HnDUxaQhYlJSguvh6YoUK1EYED9xUBU/BjGdEboHXhxtU8EeocfhVfQxzBbYOKyLlyvbLH5E3h+3b5y3jmH+pNnJfQx9GUNSQKB8CP/e3ne8DUNo4F9GOrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMJCjgzz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMJCjgzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C1DC4CEEB;
	Wed, 30 Jul 2025 22:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753916383;
	bh=sw1TAVhbjjieMP2pEg2JVm8qjXF311nK+4IsPc7U84w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TMJCjgzzAUr8q9/dsf479hY7eQ91cNvSkF16mhBeOJah6hMXWaGRj8El0mDE1p+YR
	 sFR8d6LDFL1nAKlkN+pLXxUVJzY68hAF2oeyIzGaTF2/oOlvfjuPH/t3PcQbVDlQbP
	 GrAZxoeNq+M35poz2DH5t/LImaL29wR/ZB4tgTwfAGFyV/ZCmY5MIkAK51qS0IGNi4
	 uS0mWJEOuQLj1EdjCbcA7YZjO+tdWof/8I41PBlIshR6/M/RlcOMg65UwcXib7B6K8
	 W9MbZEDtz/jjAoKJk0u61JupMlR/D+xo3FRJxRcZX1XwqoEMpr7H+J4SrW4jAgLyKU
	 CKgvdvbYGsV2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2089BCE0B1C; Wed, 30 Jul 2025 15:59:43 -0700 (PDT)
Date: Wed, 30 Jul 2025 15:59:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>, joelagnelf@nvidia.com,
	frederic@kernel.org, boqun.feng@gmail.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rcu@vger.kernel.org, Tze-nan.Wu@mediatek.com,
	a.sadovnikov@ispras.ru
Subject: Re: [GIT PULL] RCU changes for v6.17
Message-ID: <b5cb2b64-483c-4c38-b7ff-de045a420ef4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250726024605.GA17131@neeraj.linux>
 <CAHk-=wh1Cjqv08fdm3T3ZSBGN2vhMm00Ud+JjbWthK0RygMF0Q@mail.gmail.com>
 <ba898d9d-021b-40f5-9627-dce11e403fdc@paulmck-laptop>
 <CAHk-=wgWstOqx6Cbn_axAE-o=8-vcf5z_ZKDtytRw_osHLMGdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgWstOqx6Cbn_axAE-o=8-vcf5z_ZKDtytRw_osHLMGdA@mail.gmail.com>

On Wed, Jul 30, 2025 at 03:34:55PM -0700, Linus Torvalds wrote:
> On Wed, 30 Jul 2025 at 12:24, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > As it happens, I will be sending the pull request for the v6.18 merge
> > window, so I will stop doing my usual octopus merges (hey, they *were*
> > cool!) and instead merge each branch separately, with each merge's commit
> > log giving a synopsis of the commits in the branch being merged.
> 
> Note that octopus merges aren't a no-no per se. Sometimes they make
> perfect sense, particularly if there's a handful of really trivial
> branches with just a commit or two each.
> 
> Then an octopus merge can be a really convenient way to avoid having
> as many merges as you have "real" commits.
> 
> So don't take my comment as a "never use octopus merges".
> 
> Take it more as "octopus merges have some downsides, and making _any_
> merge without an explanation for it in the commit message is bad".
> 
> The main downside of octopus merges really is just bisectability:
> because even if the problem doesn't end up being the merge itself, an
> octopus merge can make it fundamentally hard to do the "cut the
> history in two roughly equal points for testing".
> 
> But again, that's not a problem if you have just a fairly small
> handful of purely trivial commits.
> 
> So people just need to balance the "octopus merges are cool, and can
> avoid pointless repeated silly small merges" with "octopus merges can
> make for bisectability issues and should be avoided for anything even
> halfway comples".
> 
> (Also, try *very* hard to avoid octopus merges when any conflicts
> exist - even trivial ones. Octopus merges with conflict resolution
> take "that's hard to follow" to a whole other level, to the point
> where you really shouldn't even try).

Thank you!

So octopus merges of documentation, torture testing, and other things that
are very unlikely to matter for bisection should be fine.  Branches that
are not going to interact should be fine, give or take any uncertainty in
"not going to interact".  No merge conflicts are permitted in octopus
merges.

On the other hand, given that there are cases where octopus merges are
not fine, it might be more straightforward to merge one branch at a time.
The main loss is that remerging after applying fises is a bit easier
with octopus merges, but that isn't a big deal.

So it might be time to say "goodbye" to octopus merges.  I will try
that for v6.18.

> > If you have a best-practice series of merges example in mind, could you
> > please point me at it?
> 
> It's hard to give a good "typical" example, because I don't think
> "typical" exists.
> 
> Sometimes a simple one-line merge message just stating "Misc fixes for
> subsystem Xyz" really might be the "proper" merge message.
> 
> Because maybe that branch really had all just tiny uninteresting
> fixes, and git shortlog entirely describes it all to the point that
> writing anything more would just be wasting everybody's time.
> 
> Honestly, the merge messages you guys send me for *my* RCU merge are
> fine - the only thing I ask for is that instead of describing the
> branches with an esoteric branch name, you write them out for humans.
> 
> So having the header read "Improvements expedited RCU grace periods"
> or something is just _soo_ much more understandable than
> "rcu-exp.23.07.2025", wouldn't you agree?

Fair point!

> As to the merge messages for *your* own merges, where you just put
> several branches together in order to send the result to me: knowing
> that there will be a more complete message in the upstream merge, I
> think the main issue is to think about people who hit that merge
> because they have some issue.
> 
> So again, it might be because somebody ends up hitting that merge
> during bisection, or has some other reason why they are looking at
> that merge in particular, rather than the "bigger picture" upstream
> merge.

And that argues for putting the material that we currently put into the
pull request into the merge commit logs.

> In other words, please write merge messages with the intended audience
> in mind. They don't necessarily need to be the same kind of
> full-fledged explanation that I want to explain why I'm merging (and
> for people who follow the development process: people most definitely
> look at the pull requests that come upstream, and it's informative to
> not just me, but you find tech press etc looking at them too).
> 
> But you should at a minimum think about "what if somebody hits this
> during a bisection". Give those random developers a clue about what is
> going on. Don't just make it be that "Merge branch XYZ", because that
> tells _outsiders_ so little.
> 
> Does that make sense as an answer?

Very much so, and again thank you.

> Anyway, I'm happy to say that if you are looking for _examples_ of
> merges, we have tons of them. I'm proud of the fact that I think
> kernel commit messages in general are very good, and when I compare
> them to other projects I feel like we tend to do a stellar job. And
> I'm not just patting myself on the back, we have tons of good
> examples.
> 
> So you can do a
> 
>     git log --merges
> 
> in general, and while you'll find some that just list branches, I
> think most of them tend to be very good these days. Look at the
> networking and bpf merges, for example (so typically Jakub and
> Alexei). Or the SoC merges (Arnd), or the VFS merges (Christian
> Brauner).
> 
> Or really most of them. I started looking for more names (the ones I
> mentioned were people I already knew wrote good merge messages), and
> really my reaction was that "most of them are great".
> 
> Good on us.

Thank you, and as you say, lots of examples.  ;-)

							Thanx, Paul
