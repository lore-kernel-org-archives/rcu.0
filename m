Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE331231C91;
	Tue, 25 Aug 2026 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787701770; cv=none; b=hh2KatWgSm4XP6P2h+VtgZ6TMi5eryTFmJ4bPSe+BfDaGSNCwNz1O3lAfdF9MMR6LTghmXSYAoKm9uyzonL8wtWwSD81cjM5n2IwnBq76lpC2ni4eTZOm4D7qHh0BVDzwHcokj/5hfehGk96bpbND09fhExAYLa5vJEGaZgX/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787701770; c=relaxed/simple;
	bh=l5pyd2WM2wQYKcrMr4ihk4QSifGaotxBoPz4iFY41Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcgU9vMpSwNbvZzxgmxBKg840WQtg0micEqDdSLOz/kP0ik9bKj0MCcNNyIB/RUns+BzCDm0KS0JdlgfSzrLDZwyRCO77sH8DQ1CDbdsQKjQnhTz9WhkHYfLnB6KQYg0VTQV19s6gKoKw/pr2qksva9tFtWA2OqtGOsLNze0HtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYHdG4E5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYHdG4E5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F8F1F000E9;
	Tue, 25 Aug 2026 23:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787701769;
	bh=z86ZOjMz7pOn+iFtN8uyoy3pCBq4SSsx+L3WdFQMPmQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=nYHdG4E5I8+6zzv0Y6U9Km8srefuTt0WLpI3TmOoIbWwBcQt+IOzUE2NdMHXS8ULY
	 93Rhpz0sG9JJ36sqDaEOYidROBca6gcG8vSTGvGAg3TOV4zZVggE/JC7JJclfNQln4
	 XNe/4t2i17kfIc4EDwY2rqnY0zoiW5mwiaOeM47b+Oqy199m/grRPZ9Szbnk2BoHzf
	 /OcdgScBSqd7aGLFdD+wZ1m31lFMGbifbmThLBIHD1Crpjb8VnpsN+3PhaVAjPxzF3
	 GOxUA/J1S5eaJIg4yBMQUT/Vzru7120NpzENhwHcigB9iJGBEkdPKwlVfGlZNEx6VK
	 aoo61X/tOhCog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 36586CE1DA2; Tue, 25 Aug 2026 16:49:29 -0700 (PDT)
Date: Tue, 25 Aug 2026 16:49:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>, Kunwu Chan <kunwu.chan@linux.dev>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, rcu@vger.kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Add try_synchronize_srcu() for callers which can
 prove readers absent
Message-ID: <42ba6de7-3281-42c9-8d7b-f7dc62c10f62@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260821032210.792451-1-kunwu.chan@linux.dev>
 <d26ec36e92e8f5aa244e2a22de5d167d14b36597.camel@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d26ec36e92e8f5aa244e2a22de5d167d14b36597.camel@infradead.org>

On Fri, Aug 21, 2026 at 12:53:22PM +0100, David Woodhouse wrote:
> On Fri, 2026-08-21 at 11:22 +0800, Kunwu Chan wrote:

[ . . . ]

> > When applying this to current rcu/dev, the patch also needs to account
> > for the additional bool is_atomic argument to
> > check_init_srcu_struct(). Please rebase accordingly.
> 
> Ooh, shiny, I hadn't spotted that the atomic thing had landed. Maybe I
> should retract my 'if we get that' above... but let's see how it
> survives.

It is starting to shape up.  Here is what is left, that I know of, anyway:

o	A bit more work to get rcutorture to put up with atomic SRCU.

o	Tree synchronize_srcu_atomic() fastpath.

o	Disable preemption.

o	Reorganize commits to fix the Tiny hunks that got applied
	in Tree commits, and likely other similar issues.

o	More work on error checking for use of banned primitives
	with atomic SRCU.

o	Update documentation.

Not that it matters, but atomic Tiny SRCU seems to be doing quite well.

> I also have more than just this patch to rebase onto rcu/dev — unlike
> some, I'm not just hacking RCU for the fun of it; I get my jollies
> elsewhere :)
> 
> Btw, the current commit c68271c3f83a message says "no index flip, no
> grace-period sequence update" but that isn't true of the implementation
> any more, is it? In fact, it *always* does those things, and doesn't
> take the try-path optimisation by counting both epochs, that I'm doing
> here?

The current "dev" branch is here:

dc5bf5c8fb26 ("fixup! srcutree: Add an atomic Tree SRCU").

Tree SRCU always does an index flip, though a single index flip can
serve multiple concurrent calls to synchronze_srcu_atomic().

Tiny SRCU has the fast path, but must advance the index anyway for the
benefit of get_state_synchronize_srcu() and friends.  It just bumps it
in one shot.

Tree SRCU will also have to bump the index, but will be able to
do so manually, without doing all the grace-period processing.

> Thanks for the careful review.

What David said!  ;-)

							Thanx, Paul
