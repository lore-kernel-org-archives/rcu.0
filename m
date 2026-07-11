Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA876026;
	Sat, 11 Jul 2026 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783738091; cv=none; b=l+taLh8Ek52RJbwCxjqiDNhtBWEPbFWvOSqo58MoUER0LcLQlGYDU6pMaUE1Aqt4KXggTMv8Ny3rmraIbbEez/dx9jgkzzTtPY6ITBoNNYjgOIWHfnpaqzjH3MrdiIXx8kiahamcp0YIs1qTrArLW8o732BPulxIsw5dQHqyZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783738091; c=relaxed/simple;
	bh=cF02rmYBRYaHKBLacPIRzzZSCNi67hz/95aRGmeE5jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwIkWHI9PIJsRTXVZKv4zUPOrm6d+BbVamLf3h22BAocpziAF7gxOacIATzQIEyuBgw68skyrJ92OeuL9yvN6MikDHpgC6KPEgat8uL3bgNmkaYJ7QRx7FPoGmLlGRbbtrGQ9OS2ZPnErZvOl3EDAMce3nN50t1tqTDLISOkHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+ZYeOn5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+ZYeOn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4CF1F000E9;
	Sat, 11 Jul 2026 02:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783738090;
	bh=qE7lApS90Pjyu8cjuJKCmgtUFJVaBTfRK7Myj0neT50=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=J+ZYeOn5Z9frPRKvMjy26gMkrk/uwbyCD2aLSB11hzB2vwVL1fvpCQUs7eKhI0Ku2
	 6rj1GJtzX9HuG5oAQszgteE0kgvpNOBBWx46XPAmdyRxwZNKREkrJq5Z/lzQ3Lzpv6
	 w7AorwByzMl2Lmz8kTXoFVRWoqzCdAFTqGErPQYke8CCgoRM5pJhFUfKBaB8AIOViv
	 +VrMhPm1Lcj51c3Ag1Oxt/JY5qG1Uz9RES/bAE9i9Lw3tv5yK6JMgDWNNvkNDNtqdG
	 81p6XeBGFgDyIdm2vQHWyLhcNY60kZGFy8o38P9S9evQoQQtd9FbKC6g8CvfPNB6Er
	 HUviv0zEJGjTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 02C95CE0A6F; Fri, 10 Jul 2026 19:48:10 -0700 (PDT)
Date: Fri, 10 Jul 2026 19:48:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Remove smp_mb() in
 rcu_spawn_tasks_kthread_generic()
Message-ID: <37aa565d-d03e-48d1-9522-0bca99f829d2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260710115028.30303-1-qiang.zhang@linux.dev>
 <8e1b325f-f26a-4c2b-b36f-c13a0335d95a@paulmck-laptop>
 <78d89fd4ddfa030bf77a225c16ad8038bc71c6d0@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78d89fd4ddfa030bf77a225c16ad8038bc71c6d0@linux.dev>

On Fri, Jul 10, 2026 at 11:18:05PM +0000, Zqiang wrote:
> > 
> > On Fri, Jul 10, 2026 at 07:50:28PM +0800, Zqiang wrote:
> > 
> > > 
> > > The smp_mb() after kthread_run() in rcu_spawn_tasks_kthread_generic()
> > >  from early 'commit eacd6f04a133 ("rcu-tasks: Move Tasks RCU to its
> > >  own file")' and 'commit 84a8f446ffd7 ("rcu: Defer rcu_tasks_kthread()
> > >  creation till first call_rcu_tasks()")', the pairing as follows:
> > >  
> > >  rcu_spawn_tasks_kthread()
> > >  ->t = kthread_run(rcu_tasks_kthread, ...);
> > >  ->smp_mb(); /* Ensure others see full kthread. */
> > >  ->WRITE_ONCE(rcu_tasks_kthread_ptr, t);
> > >  
> > >  call_rcu_tasks()
> > >  ->if (READ_ONCE(rcu_tasks_kthread_ptr))
> > >  ->wake_up(&rcu_tasks_cbs_wq)
> > >  ->try_to_wake_up()
> > >  lock pi_lock
> > >  ->smp_mb__after_spinlock()
> > >  //see full kthread
> > >  
> > >  Currently, the 'commit d119357d0743 ("rcu-tasks: Treat only synchronous
> > >  grace periods urgently")' moved kthread_ptr assignment into the
> > >  rcu_tasks_kthread(), the following pairings are sufficient:
> > >  
> > >  The rq->lock/unlock from wake_up_process() in kthread_run() and
> > >  __schedule() provides a memory barrier when the kthread is first
> > >  scheduled, this ensures the kthread itself observes all of the
> > >  kthread's initialization.
> > >  
> > >  The kthread's smp_store_release(&rtp->kthread_ptr, ...) in
> > >  rcu_tasks_kthread() and smp_load_acquire(&rtp->kthread_ptr) in
> > >  call_rcu_tasks_generic() compose release/acquire pairing, the
> > >  cumulativity of smp_store_release() propagates visibility of the
> > >  kthread's initialization through the scheduler chain.
> > >  
> > >  This commit therefore remove smp_mb() in rcu_spawn_tasks_kthread_generic().
> > >  
> > >  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > > 
> > Very good, a removal of an smp_mb() that also simplifies analysis!
> > 
> > One question...
> > 
> > > 
> > > ---
> > >  kernel/rcu/tasks.h | 2 --
> > >  1 file changed, 2 deletions(-)
> > >  
> > >  diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > >  index 5a8db89135eb..18ab335665e3 100644
> > >  --- a/kernel/rcu/tasks.h
> > >  +++ b/kernel/rcu/tasks.h
> > >  @@ -395,7 +395,6 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> > >  raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> > >  }
> > >  rcu_read_unlock();
> > >  - /* We can't create the thread unless interrupts are enabled. */
> > > 
> > Why remove this comment? People reading this code might wonder why we
> > are not just invoking rcu_spawn_tasks_kthread_generic() to create the
> > task here.
> > 
> > Now, if you say that the current comment is confusing because if that
> > kthread already exists, we also defer the wakeup, fair enough. But in
> > that case, could you please propose a replacement comment, perhaps as
> > a separate patch?
> 
> How about the following comment:
> 
> /* Use irq_work do deferred wakeup to avoid potential lockdep splat */
> 
> If directly use rcuwait_wake_up() to wakup, the lockdep will possible spalt，
> (for example we hook trace_sched_wakeup() tracepoint, and in our hook
> func inovke call_rcu_tasks())

Fair enough.  But the reason for the READ_ONCE(rtp->kthread_ptr) part of
the condition of that "if" statement is that we cannot create a kthread
with interrupts disabled, either because it is too early in boot or
because one of the scheduler locks might be held.

Maybe that is obvious?  But we did add that comment at some point.

Thoughts?

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> > 
> >  Thanx, Paul
> > 
> > > 
> > > if (needwake && READ_ONCE(rtp->kthread_ptr))
> > >  irq_work_queue(&rtpcp->rtp_irq_work);
> > >  }
> > >  @@ -681,7 +680,6 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
> > >  t = kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
> > >  if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthread, OOM is now expected behavior\n", __func__, rtp->name))
> > >  return;
> > >  - smp_mb(); /* Ensure others see full kthread. */
> > >  }
> > >  
> > >  #ifndef CONFIG_TINY_RCU
> > >  -- 
> > >  2.17.1
> > >
> >
