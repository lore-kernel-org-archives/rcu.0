Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DB13D51D;
	Wed, 14 Aug 2024 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637231; cv=none; b=fuiK5iFI5tqBbNsFKVhYZX6MZRlCQDsWvGwLJ6nBSyfvl3NbFzRy6hjFwJlLou+n/VQmTA6nmz+W7B3553wqFiV0p9rslGPotXOXBrpj6UhKZwXbfTkICAn0+eKDaBwd9pyHtLTaGuzpO4KknwihFFBpb/FuZMO9cTEWE3c7dBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637231; c=relaxed/simple;
	bh=ia32pWQM/q7KG1yROuoWfq1IU8rNC89OopuCn7Z/cyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqaRoFj9nHOLOtefAOYoSJHvOPj2TzUkuazh2y/PQRXhaB4KDJOeF35PjoZP4zzOwU0dx/Nt5cXhiTZYWtLpOgxqRx+JQJwIw2hNICZNH+nzgd9IaCiTKRUHK6d+71ipWeVWDHQkuLl0mouic7GuBwEp/9UPA4dZ1x52+M1j/y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6sHUAau; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6sHUAau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6294AC32786;
	Wed, 14 Aug 2024 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723637231;
	bh=ia32pWQM/q7KG1yROuoWfq1IU8rNC89OopuCn7Z/cyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6sHUAaus4f5gwCGoEVjywd3bapaHqNRltn5uTPsX4H9NuKSG/aU4qLMu0JL6iywI
	 mvGkFD/7K+iq3nqqr2sXLRIZNTrCsMQ+QKIay1JvVbncheMTAELRZvjRzspdBXja74
	 qataFqnkj0RiIEQmNRFEmgqaA5+uGvmbcNJ+xHaXTkeZT0sQDpcAkUKXziS3eHyaAS
	 0cUGen+MjhQZKAd6ttUZZXzp2P4VecDD0zX1iTpkDl4qmmdhS+YLaHSPuaNlwQ1bff
	 KmfDfrMMcW8G7KdAc06N+U0e5q3oobZKFlsscFPVWOn9iF2ZdgVqqTlDdyJutoQXPi
	 EBBV9oBIkZB/Q==
Date: Wed, 14 Aug 2024 17:36:55 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 13/25] context_tracking, rcu: Rename
 rcu_dynticks_task*() into rcu_task*()
Message-ID: <20240814120655.GA1412760@neeraj.linux>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
 <ZqphRBrI4mlSdER4@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqphRBrI4mlSdER4@localhost.localdomain>

On Wed, Jul 31, 2024 at 06:07:32PM +0200, Frederic Weisbecker wrote:
> Le Wed, Jul 24, 2024 at 04:43:13PM +0200, Valentin Schneider a écrit :
> > The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> > RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
> > meaning.
> > 
> > While at it, flip the suffixes of these helpers. We are not telling
> > that we are entering dynticks mode from an RCU-task perspective anymore; we
> > are telling that we are exiting RCU-tasks because we are in eqs mode.
> > 
> > Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> > ---
> >  kernel/context_tracking.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> > index 8262f57a43636..1c16a7336360f 100644
> > --- a/kernel/context_tracking.c
> > +++ b/kernel/context_tracking.c
> > @@ -38,24 +38,24 @@ EXPORT_SYMBOL_GPL(context_tracking);
> >  #ifdef CONFIG_CONTEXT_TRACKING_IDLE
> >  #define TPS(x)  tracepoint_string(x)
> >  
> > -/* Record the current task on dyntick-idle entry. */
> > -static __always_inline void rcu_dynticks_task_enter(void)
> > +/* Record the current task on exiting RCU-tasks (dyntick-idle entry). */
> > +static __always_inline void rcu_task_exit(void)
> 
> So this makes sense.
> 
> >  {
> >  #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
> >  	WRITE_ONCE(current->rcu_tasks_idle_cpu, smp_processor_id());
> >  #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
> >  }
> >  
> > -/* Record no current task on dyntick-idle exit. */
> > -static __always_inline void rcu_dynticks_task_exit(void)
> > +/* Record no current task on entering RCU-tasks (dyntick-idle exit). */
> > +static __always_inline void rcu_task_enter(void)
> 
> That too.
> 
> >  {
> >  #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
> >  	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
> >  #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
> >  }
> >  
> > -/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> > -static __always_inline void rcu_dynticks_task_trace_enter(void)
> > +/* Turn on heavyweight RCU tasks trace readers on kernel exit. */
> > +static __always_inline void rcu_task_trace_exit(void)
> 
> But that eventually doesn't, because it's not about not wathing anymore from
> an RCU-TASKS-TRACE perspective. It's actually about adding more heavyweight
> ordering to track down RCU-TASKS-TRACE read side while traditional RCU is not
> watching. Sorry for understanding it that late.
> 
> Oh well. So a more accurate name here would be rcu_task_trace_heavyweight_enter().
> 
> >  {
> >  #ifdef CONFIG_TASKS_TRACE_RCU
> >  	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
> > @@ -63,8 +63,8 @@ static __always_inline void rcu_dynticks_task_trace_enter(void)
> >  #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
> >  }
> >  
> > -/* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
> > -static __always_inline void rcu_dynticks_task_trace_exit(void)
> > +/* Turn off heavyweight RCU tasks trace readers on kernel entry. */
> > +static __always_inline void rcu_task_trace_enter(void)
> 
> And rcu_task_trace_heavyweight_exit().
> 

I have updated it here [1]. Please let me know if something looks
incorrect.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/commit/?h=next.14.08.24a&id=cfc22b9f1572b137dd9f36da831dd7b69c9fe352

- Neeraj

> Thanks!
> 
> >  {
> >  #ifdef CONFIG_TASKS_TRACE_RCU
> >  	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
> > @@ -87,7 +87,7 @@ static noinstr void ct_kernel_exit_state(int offset)
> >  	 * critical sections, and we also must force ordering with the
> >  	 * next idle sojourn.
> >  	 */
> > -	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
> > +	rcu_task_trace_exit();  // Before CT state update!
> >  	seq = ct_state_inc(offset);
> >  	// RCU is no longer watching.  Better be in extended quiescent state!
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
> > @@ -109,7 +109,7 @@ static noinstr void ct_kernel_enter_state(int offset)
> >  	 */
> >  	seq = ct_state_inc(offset);
> >  	// RCU is now watching.  Better not be in an extended quiescent state!
> > -	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
> > +	rcu_task_trace_enter();  // After CT state update!
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & CT_RCU_WATCHING));
> >  }
> >  
> > @@ -149,7 +149,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
> >  	// RCU is watching here ...
> >  	ct_kernel_exit_state(offset);
> >  	// ... but is no longer watching here.
> > -	rcu_dynticks_task_enter();
> > +	rcu_task_exit();
> >  }
> >  
> >  /*
> > @@ -173,7 +173,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
> >  		ct->nesting++;
> >  		return;
> >  	}
> > -	rcu_dynticks_task_exit();
> > +	rcu_task_enter();
> >  	// RCU is not watching here ...
> >  	ct_kernel_enter_state(offset);
> >  	// ... but is watching here.
> > @@ -240,7 +240,7 @@ void noinstr ct_nmi_exit(void)
> >  	// ... but is no longer watching here.
> >  
> >  	if (!in_nmi())
> > -		rcu_dynticks_task_enter();
> > +		rcu_task_exit();
> >  }
> >  
> >  /**
> > @@ -274,7 +274,7 @@ void noinstr ct_nmi_enter(void)
> >  	if (rcu_dynticks_curr_cpu_in_eqs()) {
> >  
> >  		if (!in_nmi())
> > -			rcu_dynticks_task_exit();
> > +			rcu_task_enter();
> >  
> >  		// RCU is not watching here ...
> >  		ct_kernel_enter_state(CT_RCU_WATCHING);
> > -- 
> > 2.43.0
> > 
