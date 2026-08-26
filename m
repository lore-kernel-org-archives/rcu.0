Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429218C008;
	Wed, 26 Aug 2026 03:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787716394; cv=none; b=LdFxh2F7IWTk0daX/32zqkktwmLva38v8XUGO+kVOxg22tbMNauKB+SYgTgzSVn21Csv+fMmgTrLo1iOMqMgg1PCLzTBdg0Fw10AUryiOSU/an6WPs2PuRoN+QYDEk4S5LVuicH/f+Ng3VHsD5/E1GI4S0dFaGN+9ypnz8fu8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787716394; c=relaxed/simple;
	bh=Pv9ANZXL+vC2RazPlzuLKFmwAwfWzh3Qsmwsb9W5OkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5lEQfBZCbzEdBOdjusyWMrmJrrcnB1TX+ashtvcFNsDVp2ErvptoXHPCMvLubT405luAl5F6VHUqIZ29jU+17Q4NmvxcvLSQkm+VOHn7ERSMTBKrbJJBj6O4vcuGXu4CzhPAqulQm/072QN2C8VroG7Ykx93IwQl7KYJlMtZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlRgz8u+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlRgz8u+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496941F000E9;
	Wed, 26 Aug 2026 03:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787716393;
	bh=Og6rV5jbIkaYwLshBSRBs+3afdWq+meR6WZqa2mfqZw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=nlRgz8u+PfoFt1DKk1qlZTpoyrFnAISgjEA67Wcii3GTwkVVNp0Am26yKwCgQasCZ
	 XYpieyZkyp2KfM0KKpofBe/c7fPHF3gRhjWvbgop1I9Ht3GDUFhfIaNGmoB/oNeDGh
	 96ifhTdZlNElcr8ucpj1kQlFmbsbKw56HvHbrmH/uES1XhbXOgo5LtMcjc749YrzzC
	 7PIIGp5g3ZsJKqrL577BSPWJvSUE1Qx4u4CRzh3ABSeQnD0B8FfSk47Ya021tF5zVx
	 5yKj4D5n1IWcV9H4Vgyun1kOp1YAcv32vV5Mqe6iAhSUX+zpuUdLu8o5hWq+TC20MQ
	 +yCzr1ZqFcuhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1629ECE0979; Tue, 25 Aug 2026 20:53:13 -0700 (PDT)
Date: Tue, 25 Aug 2026 20:53:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Kunwu Chan <kunwu.chan@gmail.com>,
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
Message-ID: <d2bc6a2e-37da-495b-b27a-30324f327b9d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260821032210.792451-1-kunwu.chan@linux.dev>
 <d26ec36e92e8f5aa244e2a22de5d167d14b36597.camel@infradead.org>
 <42ba6de7-3281-42c9-8d7b-f7dc62c10f62@paulmck-laptop>
 <ef7c880f59eedf0cd2f2b26842016bbbc2b68a06@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef7c880f59eedf0cd2f2b26842016bbbc2b68a06@linux.dev>

On Wed, Aug 26, 2026 at 03:26:18AM +0000, Kunwu Chan wrote:
> Hi Paul,
> 
> I'd be interested in helping with one of these. Are there any items
> that are not already being worked on and would be useful for me to
> take on? I'm particularly interested in the Tree
> `synchronize_srcu_atomic()` fastpath, if that part is still open.

Please feel free to give it a shot.  The similar fastpath in Tiny SRCU
is a partial guide.  The trick is that get_state_synchronize_srcu()
and poll_state_synchronize_srcu() need to keep working.

The commit that I just pushed to -rcu on branch "dev" seems to have a
working rcutorture.  Seems.  ;-)

							Thanx, Paul

> Thanks,
> Kunwu
> 
> 
> August 26, 2026 at 7:49 AM, "Paul E. McKenney" <paulmck@kernel.org mailto:paulmck@kernel.org?to=%22Paul%20E.%20McKenney%22%20%3Cpaulmck%40kernel.org%3E > wrote:
> 
> 
> > 
> > On Fri, Aug 21, 2026 at 12:53:22PM +0100, David Woodhouse wrote:
> > 
> > > 
> > > On Fri, 2026-08-21 at 11:22 +0800, Kunwu Chan wrote:
> > > 
> > [ . . . ]
> > 
> > > 
> > > When applying this to current rcu/dev, the patch also needs to account
> > >  for the additional bool is_atomic argument to
> > >  check_init_srcu_struct(). Please rebase accordingly.
> > >  
> > >  Ooh, shiny, I hadn't spotted that the atomic thing had landed. Maybe I
> > >  should retract my 'if we get that' above... but let's see how it
> > >  survives.
> > > 
> > It is starting to shape up. Here is what is left, that I know of, anyway:
> > 
> > o A bit more work to get rcutorture to put up with atomic SRCU.
> > 
> > o Tree synchronize_srcu_atomic() fastpath.
> > 
> > o Disable preemption.
> > 
> > o Reorganize commits to fix the Tiny hunks that got applied
> >  in Tree commits, and likely other similar issues.
> > 
> > o More work on error checking for use of banned primitives
> >  with atomic SRCU.
> > 
> > o Update documentation.
> > 
> > Not that it matters, but atomic Tiny SRCU seems to be doing quite well.
> > 
> > > 
> > > I also have more than just this patch to rebase onto rcu/dev — unlike
> > >  some, I'm not just hacking RCU for the fun of it; I get my jollies
> > >  elsewhere :)
> > >  
> > >  Btw, the current commit c68271c3f83a message says "no index flip, no
> > >  grace-period sequence update" but that isn't true of the implementation
> > >  any more, is it? In fact, it *always* does those things, and doesn't
> > >  take the try-path optimisation by counting both epochs, that I'm doing
> > >  here?
> > > 
> > The current "dev" branch is here:
> > 
> > dc5bf5c8fb26 ("fixup! srcutree: Add an atomic Tree SRCU").
> > 
> > Tree SRCU always does an index flip, though a single index flip can
> > serve multiple concurrent calls to synchronze_srcu_atomic().
> > 
> > Tiny SRCU has the fast path, but must advance the index anyway for the
> > benefit of get_state_synchronize_srcu() and friends. It just bumps it
> > in one shot.
> > 
> > Tree SRCU will also have to bump the index, but will be able to
> > do so manually, without doing all the grace-period processing.
> > 
> > > 
> > > Thanks for the careful review.
> > > 
> > What David said! ;-)
> > 
> >  Thanx, Paul
> >
