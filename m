Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD517EF06;
	Wed,  8 May 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179178; cv=none; b=uaI6QPlsz3vVLps5QZx/4Xpy3sPvR7USD6BK/bEFm3ARBspSAOJon1uHFtrUxWg5SWbVH/mo39rr0Y4V80dVXurnaU5XtuQomd+D75xZRQc/a82Gim0wylPuh7pA2q4Uml0VN+KrQ0Nh7uTvruFeS7Jc3ah0AhNIN/akwovHK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179178; c=relaxed/simple;
	bh=oZs1mT0nUxn9QsjX2dhHle5y/tz6UCxi5kLqWmnqYTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoWRdmZOUCPMUk66SUX/9Ul+43bsrVOpMCYAFlgW74uexQGjCzVfS3UDaN1k/iyoaJHoP33PkQ6n/H7118sxOfrfxEtRcD2GD8dpDFPrtIUJPBUTu1GrhrEqcRScTKgtcKP5+IzBHwp4hGaOnUtms9vL2d4MvdLNKIJHD1O2vRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgUDNx4O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgUDNx4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13F7C113CC;
	Wed,  8 May 2024 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715179178;
	bh=oZs1mT0nUxn9QsjX2dhHle5y/tz6UCxi5kLqWmnqYTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgUDNx4O3z1GQj9n9RlBM2ymuSd7Xs7KeDJazvlhtVsbjPMzfgH/pOLlRRB3uBtXM
	 pX1TAPfPIs7tDN2kmu04GZYeqF+x2vd094amwOmH2SSytp3mRPow2uJ6tSjXXmIOaD
	 8dR7eCaO1uqjclLFmMgnpe02WnH0kym52mIiN9rZkD1WkdY7kU800cs/WPTz3dEboq
	 gsvU35LrGy8szcL8s+wSuloBPFbJ/CMpmtCJkb5L+1ADtm+4wDYaYG1ofLPORQczVC
	 QT1gArQo7oqgI5JvBvTdqAGPsdfTmfHk1H8+p4Dg1JqXWFRhWz+YrCvBgutcpn//JB
	 3FMG8O6STEXNw==
Date: Wed, 8 May 2024 16:39:35 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v2 13/27] context_tracking, rcu: Rename
 rcu_dynticks_task*() into rcu_task*()
Message-ID: <ZjuOp78k9E0el_Rn@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-14-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-14-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:17AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
> meaning.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/context_tracking.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 647939b0befd9..9c8f7b9191cd4 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -39,7 +39,7 @@ EXPORT_SYMBOL_GPL(context_tracking);
>  #define TPS(x)  tracepoint_string(x)
>  
>  /* Record the current task on dyntick-idle entry. */
> -static __always_inline void rcu_dynticks_task_enter(void)
> +static __always_inline void rcu_task_enter(void)

On a second thought, this should be the reverse. We are not
telling anymore that we are entering dynticks mode from an
RCU-task perspective. We are telling that we are exiting RCU-tasks
because we are in eqs mode (even though this is mostly a concern
for nohz_full here, as idle tasks are entirely quiescent states
but anyway...).

So this should be s/rcu_dynticks_task_enter/rcu_task_exit

>  {
>  #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
>  	WRITE_ONCE(current->rcu_tasks_idle_cpu, smp_processor_id());
> @@ -47,7 +47,7 @@ static __always_inline void rcu_dynticks_task_enter(void)
>  }
>  
>  /* Record no current task on dyntick-idle exit. */
> -static __always_inline void rcu_dynticks_task_exit(void)
> +static __always_inline void rcu_task_exit(void)

And s/rcu_dynticks_task_exit/rcu_task_enter

>  {
>  #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
>  	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
> @@ -55,7 +55,7 @@ static __always_inline void rcu_dynticks_task_exit(void)
>  }
>  
>  /* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> -static __always_inline void rcu_dynticks_task_trace_enter(void)
> +static __always_inline void rcu_task_trace_enter(void)

The same reverse naming goes for task_trace (even though I can't make
sense right now of what the barrier it implies orders exactly, but that's
another story)

>  {
>  #ifdef CONFIG_TASKS_TRACE_RCU
>  	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
> @@ -64,7 +64,7 @@ static __always_inline void rcu_dynticks_task_trace_enter(void)
>  }
>  
>  /* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
> -static __always_inline void rcu_dynticks_task_trace_exit(void)
> +static __always_inline void rcu_task_trace_exit(void)
>  {
>  #ifdef CONFIG_TASKS_TRACE_RCU
>  	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
> @@ -87,7 +87,7 @@ static noinstr void ct_kernel_exit_state(int offset)
>  	 * critical sections, and we also must force ordering with the
>  	 * next idle sojourn.
>  	 */
> -	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
> +	rcu_task_trace_enter();  // Before ->dynticks update!

s/->dynticks/->state

>  	seq = ct_state_inc(offset);
>  	// RCU is no longer watching.  Better be in extended quiescent state!
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
> @@ -109,7 +109,7 @@ static noinstr void ct_kernel_enter_state(int offset)
>  	 */
>  	seq = ct_state_inc(offset);
>  	// RCU is now watching.  Better not be in an extended quiescent state!
> -	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
> +	rcu_task_trace_exit();  // After ->dynticks update!

ditto

Thanks!
