Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3FF2BE04C
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848614; cv=none; b=o0ey4Q5790zBSyD7ZCF8hMcTNsyaLV249NJ8KQiz7Z5VfycN6K36cL+2PJNyyusLpgG6nbQWUsRp4zK31ydSOSwbl+BQ+oHFmnmDQ13YFSnThJlC+cLvsMsBej2gzHgq0PNvE8j7IAgc5Ep+pEQ+fm/mwMOagfacEZqyK6dyNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848614; c=relaxed/simple;
	bh=yC4la/UOIYbfVe6Wj7jwgKNOo276mi29LNpOrFG4S0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srmBPj6r6ngr/XNT4hEuwfLIgCFjO38BWOsqNPEXIvGdwOup4qx5jQOy89LEgVs/m4VTmnXofAwkZVDOUNPiLrjQL4uAifDeaegzXd9eZs4yVZVqc0FkX+CLtJO/nHtzEZcgZJxki2i8VGkYPFHRskbwan44fICagcSi1RuPQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGfJSWFI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGfJSWFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE12C19421;
	Wed, 18 Mar 2026 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773848614;
	bh=yC4la/UOIYbfVe6Wj7jwgKNOo276mi29LNpOrFG4S0Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LGfJSWFI4yJPS/+jaRBR2+W7AekqTdse/mONTKP9d0C4svC2hGpa9fys3k6JJkPOy
	 5XqUlnYL6h82hHZDe3nWdwV41/BIMSDLKcko1kztG5ZkvA4wlzo3EQNXt/+lzU2iRX
	 UmWAwPUPTbZzchdYVon3koxUFMVRkteSo0U85T0Ngw8HWRsnIqIbJVt11+Y/rc6t7/
	 h89prr5AFOhD1BVvEr3GghheVvFGeRmuyrPR67NRhZC/08y+Dfo2azHptQbUVtiQak
	 q6aRyqHTAcaoyqB1WgBXlivjJSCgtPs66ZYbyK0tmCEB7R7ylZVvT30YBKK3W7wQR1
	 btZKEaZF2Dn8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2F812CE0846; Wed, 18 Mar 2026 08:43:32 -0700 (PDT)
Date: Wed, 18 Mar 2026 08:43:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <76ef9a5e-7343-4b8e-bf3c-cabd8753ecdb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318144305.xI6RDtzk@linutronix.de>

On Wed, Mar 18, 2026 at 03:43:05PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-03-18 04:49:52 [-0700], Paul E. McKenney wrote:
> > > > Back to the actual bug, that call_srcu() now needs to tolerate being called
> > > > with scheduler rq/pi locks held...
> > > 
> > > This is because it is called from sched_ext BPF callbacks?
> > 
> > You got it!  We are re-implementing Tasks Trace RCU in terms of SRCU-fast,
> > and I missed this requirement the first time around.  I *did* make readers
> > able to deal with BPF being invoked from everywhere, so two out of three?
> 
> right ;)
> 
> > > > The straightforward (but perhaps broken) way to resolve this is to make
> > > > srcu_gp_start_if_needed() defer invoking the scheduler, similar to the
> > > 
> > > Quick question. If srcu_gp_start_if_needed() can be invoked from a
> > > preempt-disabled section (due to rq/pi lock) then 
> > > 	spin_lock_irqsave_sdp_contention(sdp, &flags);
> > > 
> > > does not work, right?
> > 
> > Agreed, which is why the patch at the end of this email converts this to:
> > 
> > 	raw_spin_lock_irqsave_sdp_contention(sdp, &flags)
> 
> I've seen that now. So the spinlock_t usage in SRCU was short.

Almost ten years.  ;-)

> > > > way that vanilla RCU's call_rcu_core() function takes an early exit if
> > > > interrupts are disabled.  Of course, vanilla RCU can rely on things like
> > > > the scheduling-clock interrupt to start any needed grace periods [1],
> > > > but SRCU will instead need to manually defer this work, perhaps using
> > > > workqueues or IRQ work.
> > > > 
> > > > In addition, rcutorture needs to be upgraded to sometimes invoke
> > > > ->call() with the scheduler pi lock held, but this change is not fixing
> > > > a regression, so could be deferred.  (There is already code in rcutorture
> > > > that invokes the readers while holding a scheduler pi lock.)
> > > > 
> > > > Given that RCU for this week through the end of March belongs to you guys,
> > > > if one of you can get this done by end of day Thursday, London time,
> > > > very good!  Otherwise, I can put something together.
> > > > 
> > > > Please let me know!
> > > 
> > > Given that the current locking does allow it and lockdep should have
> > > complained, I am curious if we could rule that out ;)
> 
> Your patch just s/spinlock_t/raw_spinlock_t so we get the locking/
> nesting right. The wakeup problem remains, right?
> But looking at the code, there is just srcu_funnel_gp_start(). If its
> srcu_schedule_cbs_sdp() / queue_delayed_work() usage is always delayed
> then there will be always a timer and never a direct wake up of the
> worker. Wouldn't that work?

Right, that patch fixes one lockdep problem, but another remains.

> > It would be nice, but your point about needing to worry about spinlocks
> > is compelling.
> > 
> > But couldn't lockdep scan the current task's list of held locks and see
> > whether only raw spinlocks are held (including when no spinlocks of any
> > type are held), and complain in that case?  Or would that scanning be
> > too high of overhead?  (But we need that scan anyway to check deadlock,
> > don't we?)
> 
> PeterZ didn't like it and the nesting thing identified most of the
> problem cases. It should also catch _this_ one.
> 
> Thinking about it further, you don't need to worry about
> local_bh_disable() but RCU will becomes another corner case. You would
> have to exclude "rcu_read_lock(); spin_lock();" on a !preempt kernel
> which would otherwise lead to false positives.
> But as I said, this case as explained is a nesting problem and should be
> reported by lockdep with its current features.

With a raw spinlock held, agreed.

Not a big deal, just working out what to put in rcutorture to avoid
regressions that would otherwise result in being unable to invoke
call_srcu() from non-preemptible contexts.

> > > > 						Thanx, Paul [2]
> > > > 
> > > > [1] The exceptions to this rule being handled by the call to
> > > >     invoke_rcu_core() when rcu_is_watching() returns false.
> > > > 
> > > > [2] Ah, and should vanilla RCU's call_rcu() be invokable from NMI
> > > >     handlers?  Or should there be a call_rcu_nmi() for this purpose?
> > > >     Or should we continue to have its callers check in_nmi() when needed?
> > > 
> > > Did someone ask for this?
> > 
> > Yes.  The BPF guys need to invoke call_srcu() from interrupts-disabled
> > regions of code.  I am way to old and lazy to do this sort of thing
> > spontaneously.  ;-)
> 
> IRQ disabled should work but you asked about call_rcu_nmi() and NMI is
> already complicated because "most" other things don't work and you would
> need irq_work to let the remaining kernel know that you did something in
> NMI and this needs to be integrated now. I don't think regular RCU has
> call_rcu() from NMI. But I guess wrapping it via irq_work would be one
> way of dealing with it.

Agreed, and as long as there is only a few call_rcu() call sites within
NMI handlers, it is best to let the caller deal with it.  But if this
becomes popular enough, it would be better to have a call_rcu_nmi() or
some such.

							Thanx, Paul
