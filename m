Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3C279DB4
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851530; cv=none; b=ijqjhnuOYxjFpqcarRDJZ85nPj7AbUrjIhWI+RWcRftQ/FK7lGKl0BCOeUctrA8utcMh3bbrJx7Iwucb5MFy07xNX6PlFOwjNYJhMEh4NSz8bEzHdj+85FATul02Uje2dOG5YVR1Li8NJmJsUfGz/vZqoPCEH+GVbeNJ1E1h+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851530; c=relaxed/simple;
	bh=o9yozjj7KVVc27kVL4jFdE7CU1RS718WeRgAUoKACZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKWqnaI2IWmZ4vXxIpiqUBAWQjnRK56TkBp9HXbuq4bSt/EkRptRNneDjV29FirnBwg1mRhMYcgZCKH1VzHZxbuxMhIYcC5sP5Ra8fdHsQdSPSPiCTsItBz0oyKh/sVJqQWMCAgQit6XQytmrG5Z/lHUL/RsybFEmdo+QcLclQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeBMceb/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeBMceb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3405BC19421;
	Wed, 18 Mar 2026 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773851529;
	bh=o9yozjj7KVVc27kVL4jFdE7CU1RS718WeRgAUoKACZI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XeBMceb/ljNfozladgu7a+XeNy91l3ZMhByJNIye5y4x93Vezo5P8JQ+tUPL+3Rhi
	 eugeeav6TYHKOGimCmTAp2zcZ8PRYrmatfmEL1pWW4EDgEzX0MN/V/Ia+wtCOt94Ns
	 FhDkiBMIFqyGakMatyThQjz4LAADbs/WVQNfCfyYdsLIVMQoRymwhGJjEU3F74E8e7
	 0nuS9bRqwF6pN7CXRuLtVEeb4+6oI7kgfQMItISfvUKSqrwZCOxptsi9i924xDHMG7
	 mqkcOkpqvsYCoavWQGJgut6IOqD7+MNQmYBHiWokGyWCAdyWcryadT3+1iN6LwZXaS
	 31sL/3ugh9nOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 15FACCE098B; Wed, 18 Mar 2026 09:32:07 -0700 (PDT)
Date: Wed, 18 Mar 2026 09:32:07 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <06a0cb91-1737-4691-a810-8340e1acf1d6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <76ef9a5e-7343-4b8e-bf3c-cabd8753ecdb@paulmck-laptop>
 <20260318160445.IyUiWV0T@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318160445.IyUiWV0T@linutronix.de>

On Wed, Mar 18, 2026 at 05:04:45PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-03-18 08:43:32 [-0700], Paul E. McKenney wrote:
> > > Your patch just s/spinlock_t/raw_spinlock_t so we get the locking/
> > > nesting right. The wakeup problem remains, right?
> > > But looking at the code, there is just srcu_funnel_gp_start(). If its
> > > srcu_schedule_cbs_sdp() / queue_delayed_work() usage is always delayed
> > > then there will be always a timer and never a direct wake up of the
> > > worker. Wouldn't that work?
> > 
> > Right, that patch fixes one lockdep problem, but another remains.
> 
> What remains?

With that patch, we no longer have call_srcu() directly acquiring a
non-raw spinlock, but as you say, we still have the wakeup problem.

> > > > It would be nice, but your point about needing to worry about spinlocks
> > > > is compelling.
> > > > 
> > > > But couldn't lockdep scan the current task's list of held locks and see
> > > > whether only raw spinlocks are held (including when no spinlocks of any
> > > > type are held), and complain in that case?  Or would that scanning be
> > > > too high of overhead?  (But we need that scan anyway to check deadlock,
> > > > don't we?)
> > > 
> > > PeterZ didn't like it and the nesting thing identified most of the
> > > problem cases. It should also catch _this_ one.
> > > 
> > > Thinking about it further, you don't need to worry about
> > > local_bh_disable() but RCU will becomes another corner case. You would
> > > have to exclude "rcu_read_lock(); spin_lock();" on a !preempt kernel
> > > which would otherwise lead to false positives.
> > > But as I said, this case as explained is a nesting problem and should be
> > > reported by lockdep with its current features.
> > 
> > With a raw spinlock held, agreed.
> > 
> > Not a big deal, just working out what to put in rcutorture to avoid
> > regressions that would otherwise result in being unable to invoke
> > call_srcu() from non-preemptible contexts.
> 
> Okay. So take this as _no_ more work items ;)

I agree that the rcutorture can wait until the next merge window.

> > > > > > 						Thanx, Paul [2]
> > > > > > 
> > > > > > [1] The exceptions to this rule being handled by the call to
> > > > > >     invoke_rcu_core() when rcu_is_watching() returns false.
> > > > > > 
> > > > > > [2] Ah, and should vanilla RCU's call_rcu() be invokable from NMI
> > > > > >     handlers?  Or should there be a call_rcu_nmi() for this purpose?
> > > > > >     Or should we continue to have its callers check in_nmi() when needed?
> > > > > 
> > > > > Did someone ask for this?
> > > > 
> > > > Yes.  The BPF guys need to invoke call_srcu() from interrupts-disabled
> > > > regions of code.  I am way to old and lazy to do this sort of thing
> > > > spontaneously.  ;-)
> > > 
> > > IRQ disabled should work but you asked about call_rcu_nmi() and NMI is
> > > already complicated because "most" other things don't work and you would
> > > need irq_work to let the remaining kernel know that you did something in
> > > NMI and this needs to be integrated now. I don't think regular RCU has
> > > call_rcu() from NMI. But I guess wrapping it via irq_work would be one
> > > way of dealing with it.
> > 
> > Agreed, and as long as there is only a few call_rcu() call sites within
> > NMI handlers, it is best to let the caller deal with it.  But if this
> > becomes popular enough, it would be better to have a call_rcu_nmi() or
> > some such.
> 
> Popular? Okay. Keep me posted, please.

Will do.  Just out of curiosity, what are your concerns?

							Thanx, Paul
