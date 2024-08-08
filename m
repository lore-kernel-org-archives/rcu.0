Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74500189F37;
	Thu,  8 Aug 2024 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112393; cv=none; b=s0HdMFQeHEcjxUkumtH863HegfJHCwqJDBc2Vkyl190AhqnvDt75lVsUOmT/Rew+2V4UgNJToQKL0kXtEoZ4aNOBRsOt9oqOYs9Q47tt+385ee0b7xYeWdIoodm5C0gQUp8dFzHzMrCN7pXhLsnPYU13ExoeVnTqu57teMf0dAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112393; c=relaxed/simple;
	bh=6bAfnf6c5/iHXILqD7RD8kITTLL773Gz8gUZuAp/Mb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvItxdGJ5aL176fzuNNwd9qewAciBLTapwTuZxpRz7WRkUQI/7gdigVlXjU+a1Vx6JV8YYidGP96+UtaCohtWUJD6IrJ4ETPCzNszfQ9JViPk9KmCTK7FsrRViECGPlhA+En85/pvuYPqhaHISeXPNisaVt1u8SRAFM/D2k9bX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dr++cboO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dr++cboO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=726C+QRC6Qs6UtBdbsmcHzJuYMppoxzGiaRG2rouZgI=; b=dr++cboOGpaZMNlAFrAB9Jnk58
	si42z9wP0GYJncD7sIp8bJvB1yYbuZFeFOu0QzZYqkqs+vWFAgYXsPRj1PVhWGrDO0fkkp31qpetX
	5UKYZxASYj4W9ES8PBa0t4WELvTuuknnBMVKxa4MZwct7RXyouzWZLDULYCeWd+f/WlLxU3s1g88x
	MPBGxwPZvhY2toKbez83EJML1t6GhIGcLoY7Nz08xz2l343pj6JhEeZ9vWek7YrA3D+haGezVqGD+
	wix09MzsywcHSaPkyZDibf2te3XdSc7hrSW8NldttRmuweRWFk6M/Bj+fiz4npZ15QUo/irKmMGs8
	Ow8V4Gdg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc0FA-00000008kAE-1oVU;
	Thu, 08 Aug 2024 10:19:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 590FB300392; Thu,  8 Aug 2024 12:19:39 +0200 (CEST)
Date: Thu, 8 Aug 2024 12:19:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: mingo@redhat.com, will@kernel.org, longman@redhat.com,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	paulmck@kernel.org, frederic@kernel.org, josh@joshtriplett.org,
	neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org
Subject: Re: [GIT PULL] LOCKDEP changes for v6.12
Message-ID: <20240808101939.GG31338@noisy.programming.kicks-ass.net>
References: <ZrQ97Zz27Tzmr0Zi@tardis>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrQ97Zz27Tzmr0Zi@tardis>

On Wed, Aug 07, 2024 at 08:39:25PM -0700, Boqun Feng wrote:
> Hi Peter & Ingo,
> 
> Per discussion:
> 
> 	https://lore.kernel.org/lkml/20240802151619.GN39708@noisy.programming.kicks-ass.net/
> 
> I'm sending a PR with some lockdep changes to tip.
> 
> 
> The following changes since commit d5934e76316e84eced836b6b2bafae1837d1cd58:
> 
>   cleanup: Add usage and style documentation (2024-08-05 16:54:41 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux tags/lockdep-for-tip.20240806
> 

Right, so a few things for next time, could you read
Documentation/process/maintainer-tip.rst and make sure patches more or
less adhere to the things outlined there.

Things I noticed in the few seconds I looked at things:

Subjects don't start with a capital letter after the ':'

The Changelog for the lockdep-vs-rcu thing can be much condensed by not
including full stack dumps but only the relevant information.

If you don't want to edit patches by hand, you're free to push back and
get the submitter to do things before applying them.

Anyway, since I'm about to head out to the beach, I'm pulling this. Also
I need to figure out how git works with remotes and tags... stupid
things :-)
  
