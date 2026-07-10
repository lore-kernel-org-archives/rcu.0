Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D2377017;
	Fri, 10 Jul 2026 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707904; cv=none; b=Afyv2SF3D7FKMTQ6kGJwMBxY5RM/7tM2D+ViM1k/qQYImioE51w3N8g3gdI+juGForLQz9veccSuHnQCEMF5BDUD7dgWt8FjYGm0hd2R2ymlOi/iKY/ws6phMdxU1xcy8tVZr15Jp1v+8LgNBB2uuCz3cH/dF5o6HCNs4BKDLLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707904; c=relaxed/simple;
	bh=pYGv1Xp4rrfxYh2J/3fpdwwX7yz25tYz3ICBcWJHzys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuRFEInXR3oecig8LIMiKwOF3e3MPN7tHB58qebv2YUAH2p0aUb9v3/cmpABHBkzf00CVLOf3nUv09p3g/0UrzhZ7lMyb3kmr/A5z1thVKN3BJwFpzfiJ+tH9z6gIK1rtbq+UH1uj2kw6cOGANe/8VhZlAoQCE4+4cn24Ogt9bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKubxXxU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKubxXxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B5C1F000E9;
	Fri, 10 Jul 2026 18:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783707901;
	bh=hlWI+s7PTyGVVFgwyVJsVPbD/1CjYjWlMmUlYTnXzeg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=WKubxXxUZG5o7bj2sh6qqhxWsWUNvLce9qQkkw0SLaELFV9F3Z0Dh38VDCg4fOKDn
	 IOfaoTz9pswX58sRpjEE6MKDw5ymFf7YcKlRMpJ9Rb+VMleaHGwghrXbASpkWM/NCK
	 Gbd7HRpBQbrjzEUU+IjiPaDaaGgPHZMPOam1XnaVTmq1Ag8ZhNP9kJfx/WHGRrDZlp
	 FeW7hr+UEsLP7zCnDgqliYPQJsjABl5Jaoj4UnmznPtx2SajnB5udQUYs7m551WJwD
	 hfVAhNR+BZmGzHvqLAZXmDvY3w+s72Fw/M47tMa7QEBRScJAdyuHrqIALHWvMNhLGh
	 X//s2ELdPMUmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 10DB7CE084A; Fri, 10 Jul 2026 11:25:01 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:25:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Remove smp_mb() in
 rcu_spawn_tasks_kthread_generic()
Message-ID: <8e1b325f-f26a-4c2b-b36f-c13a0335d95a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260710115028.30303-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710115028.30303-1-qiang.zhang@linux.dev>

On Fri, Jul 10, 2026 at 07:50:28PM +0800, Zqiang wrote:
> The smp_mb() after kthread_run() in rcu_spawn_tasks_kthread_generic()
> from early 'commit eacd6f04a133 ("rcu-tasks: Move Tasks RCU to its
> own file")' and 'commit 84a8f446ffd7 ("rcu: Defer rcu_tasks_kthread()
> creation till first call_rcu_tasks()")', the pairing as follows:
> 
> rcu_spawn_tasks_kthread()
> ->t = kthread_run(rcu_tasks_kthread, ...);
> ->smp_mb(); /* Ensure others see full kthread. */
> ->WRITE_ONCE(rcu_tasks_kthread_ptr, t);
> 
> 							call_rcu_tasks()
> 					      		->if (READ_ONCE(rcu_tasks_kthread_ptr))
> 					         	  ->wake_up(&rcu_tasks_cbs_wq)
> 							    ->try_to_wake_up()
> 							      lock pi_lock
> 							      ->smp_mb__after_spinlock()
> 								//see full kthread
> 
> Currently, the 'commit d119357d0743 ("rcu-tasks: Treat only synchronous
> grace periods urgently")' moved kthread_ptr assignment into the
> rcu_tasks_kthread(), the following pairings are sufficient:
> 
> The rq->lock/unlock from wake_up_process() in kthread_run() and
> __schedule() provides a memory barrier when the kthread is first
> scheduled, this ensures the kthread itself observes all of the
> kthread's initialization.
> 
> The kthread's smp_store_release(&rtp->kthread_ptr, ...) in
> rcu_tasks_kthread() and smp_load_acquire(&rtp->kthread_ptr) in
> call_rcu_tasks_generic() compose release/acquire pairing, the
> cumulativity of smp_store_release() propagates visibility of the
> kthread's initialization through the scheduler chain.
> 
> This commit therefore remove smp_mb() in rcu_spawn_tasks_kthread_generic().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Very good, a removal of an smp_mb() that also simplifies analysis!

One question...

> ---
>  kernel/rcu/tasks.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 5a8db89135eb..18ab335665e3 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -395,7 +395,6 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
>  	}
>  	rcu_read_unlock();
> -	/* We can't create the thread unless interrupts are enabled. */

Why remove this comment?  People reading this code might wonder why we
are not just invoking rcu_spawn_tasks_kthread_generic() to create the
task here.

Now, if you say that the current comment is confusing because if that
kthread already exists, we also defer the wakeup, fair enough.  But in
that case, could you please propose a replacement comment, perhaps as
a separate patch?

							Thanx, Paul

>  	if (needwake && READ_ONCE(rtp->kthread_ptr))
>  		irq_work_queue(&rtpcp->rtp_irq_work);
>  }
> @@ -681,7 +680,6 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
>  	t = kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
>  	if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthread, OOM is now expected behavior\n", __func__, rtp->name))
>  		return;
> -	smp_mb(); /* Ensure others see full kthread. */
>  }
>  
>  #ifndef CONFIG_TINY_RCU
> -- 
> 2.17.1
> 
