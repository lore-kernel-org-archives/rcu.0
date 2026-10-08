Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A5236B938;
	Thu,  8 Oct 2026 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474683; cv=none; b=JWHK/oLXLBQTNi907Ng3ijN3GDByQhRFP0PvSYYjRxjzsdqBtn2lur6IX8Vbq/fIAm8TcbC/SL8ofVjUvRz7gUIdi4VimPUagwds4ZsQ+7A/0ajef9T5viyjtZQK2BQGOFdZ4T9OrbmzwjS1SoBNi3nRHtzxabApLEIy6v0IAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474683; c=relaxed/simple;
	bh=8KDzC076QLU3HE+nY3ifc9+jYSQZA68QyRR5/GdnGD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpEsTH0DDkpI3q/0tmpDhEkWUljj0Ek9jxYAikhglQYNYTJTQfv772VCPntMCPoaCMbk9bB6q20JVSpz1YbFx1e+RshmpmA1Gw6r0tfVcmRcq45VFgSDTkeDjbgNXPgSZ5BM8Xu/HS/+uQcliCt7YI/J/r72pPfRu73iPki/0uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctleo2P4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctleo2P4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9CA1F000FF;
	Thu,  8 Oct 2026 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791474681;
	bh=smbO8foErAa3pebhzMz4aUq/J0eaYwmOB6LnRkr0EYc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ctleo2P4piHa63K2/SIX5b9djbLRw96wnJCx8cdUH1YHyuRjt++rkLaO0lyQvSReZ
	 wKpHkBZ6+dKBw9QufQs9LqhmkaeS2xLMWjm2ZPsMfs5MapEnos7b0dnjwfA7pA9Asa
	 8mP/vSA0kNAkI3Hxk8ziP4949O1NHrKaRcJeHp54BUVKQlgxEg4ua8vvBj8nf7hXyo
	 PYzYKo/BKZqq/SbdkYYUOdowx8OW5YpPSdg57VgroVTyJ5w7Hs+acnT1Ex4zPRIZ2F
	 hVZe5CQP68d5nAbnHFhgQYuf6h1cUaHRAJ1UwxzlRl8WnUrQdjR/ZmPWWkKMF5uwak
	 Bifkw5zyXWB6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 76C0CCE3996; Thu,  8 Oct 2026 08:51:21 -0700 (PDT)
Date: Thu, 8 Oct 2026 08:51:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 04/21] srcutree: Add an atomic Tree SRCU
Message-ID: <d1539cc5-0ff3-400e-a487-eedd942cf6f5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
 <20261007205924.1983367-4-paulmck@kernel.org>
 <729dfdb236e4daaf2438b74d4d921993a156ec34.camel@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <729dfdb236e4daaf2438b74d4d921993a156ec34.camel@infradead.org>

On Thu, Oct 08, 2026 at 09:39:29AM +0200, David Woodhouse wrote:
> On Wed, 2026-10-07 at 13:59 -0700, Paul E. McKenney wrote:
> > Some dedicated srcu_struct users have read-side critical sections
> > which are short, never sleep, and never block on anything which may
> > itself depend on memory allocation — because they were, until
> > recently, spinlock or rwlock critical sections. For such a domain the
> > update side can safely wait for readers by spinning, from contexts
> > where sleeping is undesirable or the grace-period machinery's
> > latency (workqueue scheduling, jiffy-paced retries) dominates the
> > actual reader drain time.
> > 
> > But that is only safe if every reader keeps the promise. Make the
> > promise explicit and machine-checkable:
> > 
> >  - srcu_read_lock_atomic() / srcu_read_unlock_atomic() enter the
> >    usual (smp_mb-based) read-side critical section with preemption
> >    disabled and (except in hardirq, where it is redundant)
> >    non_block_start() armed, recording SRCU_READ_FLAVOR_ATOMIC in the
> >    per-CPU reader flavor. Disabling preemption enforces the
> >    no-sleeping promise on every configuration and bounds the section,
> >    so it is always running on some CPU; non_block_start() extends the
> >    enforcement to even potentially-sleeping calls on paths which
> >    happen not to block. The existing reader-flavor consistency checks
> >    complain about any mixing with other flavors.
> > 
> >  - synchronize_srcu_atomic() waits for all pre-existing readers by
> >    repeating the try_synchronize_srcu() both-epoch counter proof with
> >    cpu_relax() until it succeeds: no sleeping, no index flip, no
> >    grace-period sequence update, and therefore no interaction with
> >    concurrent call_srcu(), synchronize_srcu() or srcu_barrier(). It
> >    always provides the full grace-period guarantee: if the domain
> >    turns out to have had readers of any other flavor — a caller bug,
> >    since such a reader may be asleep and spinning on it would be
> >    unbounded — it complains and falls back to a real (sleeping) grace
> >    period internally, that being the only correct wait for a
> >    possibly-sleeping reader. The flavor mask is rechecked on every
> >    iteration so a first non-atomic reader appearing mid-spin takes
> >    the same path.
> > 
> > The immediate motivation is the proposed conversion of KVM's
> > gfn_to_pfn_cache to SRCU¹, whose mmu_notifier invalidation path drains
> > readers before the primary MMU zaps a page. With the readers declared
> > atomic, that drain becomes spin-only: no sleeping at all in the
> > notifier, bounded by the longest reader section, satisfying even the
> > strictest reading of the OOM-reaper non-blocking requirement without
> > needing to touch the non_block_start() annotation².
> > 
> > This commit also adds atomic-SRCU-specific initializers:
> > init_srcu_struct_atomic(), DEFINE_SRCU_ATOMIC(), and
> > DEFINE_STATIC_SRCU_ATOMIC().
> > 
> > This commit implements only Tree SRCU.  Tiny SRCU will follow.
> > 
> > ¹ https://lore.kernel.org/all/20260811132237.102400-1-dwmw2@infradead.org/
> > ² https://lore.kernel.org/all/20260812134934.GC662699@ziepe.ca/
> > 
> > [ paulmck: Apply Kunwu Chan feedback. ]
> > 
> > Co-developed-by: David Woodhouse <dwmw2@infradead.org>
> > Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> > Assisted-by: Claude:claude-mythos-5
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Thank you for seeing this concept through to completion.
> 
> If it isn't already too late (i.e. if it hasn't already made it to a
> tree where changing commit-ids is painful), please could you change my
> attribution to use the dwmw@amazon.co.uk email address for both Co-
> developed-by: and Signed-off-by: tags? I'm fairly sure you made up that
> Signed-off-by: with the infradead address, which is naughty of you :)

Indeed, I would have grabbed the first email I could find from you and
applied the From: field from that email, as opposed to finding the exact
email containing your prototype of the patch and then locating and copying
out the Signed-off-by.  And if I were to happen to find the email that
I am now replying to, I would once again get infradead rather than amazon.

Apologies, but life was flowing fast, and it probably will be from time
to time in the future.  So thank you for checking and please continue
to do so.

> I tell people you should only ever cut-and-paste SoB lines, because
> that way the magic is intact. So here are the two you need for patches
> 4 and 5 of this series:
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Thank you again, and I have this note to myself for my next rebase:

a5130cf7b27f ("srcutree: Add an atomic Tree SRCU")
85d5f89bdc42 ("srcutiny: Add an atomic Tiny SRCU")
	Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
	Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Does that cover it?

And while we are discussing, how goes the use case?

							Thanx, Paul
