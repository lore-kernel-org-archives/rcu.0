Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9026291;
	Wed,  8 May 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176788; cv=none; b=sn7r4vLELuy/DklAmgfeV9dtJZOSZLaOzz/ZlBeRs3uOl5yxfOr9RP30RznyBe52K4G3/mhezSPOp9vAsDLD+vXDtmIr0Dg4ZWzv2lSdvIJfgKyrxWYb01+kxtfSlJ5hek4YnsRpzv0rnr79cV+vcgVGlDH+3gOgEiuTxNqng2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176788; c=relaxed/simple;
	bh=36IOkkIkOFgt0pAngbPkZeFgWlofVvMLGSKUF3PS0RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQJ8fo8nBfbdWX4Iq84NAX8yP2i0Pw0tUuzS2vNChBvRGrMnl5cZyWeobVa2uPqDcM4nLAjwxImbGF8uD42oQkyrhfle738orK1RnF/KC5jvVBVRqGpX4wkIoCj2PqjCMBN1ghWKForh9Nh54ak/HHgqYW3jxdhlFZbPbsaNrZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVhsvbY1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVhsvbY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A569C113CC;
	Wed,  8 May 2024 13:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715176787;
	bh=36IOkkIkOFgt0pAngbPkZeFgWlofVvMLGSKUF3PS0RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVhsvbY1RghHbzQ5Wr4PqqAmaow/Y9OE2IF/6mcnZgS4s1mQpeY6f0pWsUKOX+mdA
	 gswl++9q5KQ6bFao2VF40+a65mbcGZ/3VlzQZIe4yCFjG7e8pZ4zs6VHprvCeoKVPH
	 NF+XO1b33tU4aHkAMOYnvSnbkQQHuNqR/Wi4YSU/GoDWu5MS4sewnTgAAmoZe/5eY8
	 L+LiRBANX6p0yYGXlmcGUX8LNsRoAe0tJJ1Vw0gW9msbdMkXwEh/+2jds17KWZJpZd
	 kxzQnLS869/Xie1yjJs1295J6HrDXdBqGVWlHlqnP5VCW+mYlix3gETAk0iCY9p1GD
	 zS1Hmr3YlQJaQ==
Date: Wed, 8 May 2024 15:59:45 +0200
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
Subject: Re: [PATCH v2 27/27] context_tracking, rcu: Rename rcu_dyntick trace
 event into rcu_watching
Message-ID: <ZjuFUZXk4rYO4L2v@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-28-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-28-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:31AM +0200, Valentin Schneider a écrit :
> The "rcu_dyntick" naming convention has been turned into "rcu_watching" for
> all helpers now, align the trace event to that.
> 
> To add to the confusion, the strings passed to the trace event are now
> reversed: when RCU "starts" the dyntick / EQS state, it "stops" watching.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  include/trace/events/rcu.h | 16 ++++++++--------
>  kernel/context_tracking.c  | 10 +++++-----
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 4066b6d51e46a..e51ef658437f0 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -466,40 +466,40 @@ TRACE_EVENT(rcu_stall_warning,
>  /*
>   * Tracepoint for dyntick-idle entry/exit events.  These take 2 strings
>   * as argument:
> - * polarity: "Start", "End", "StillNonIdle" for entering, exiting or still not
> + * polarity: "Start", "End", "StillWatching" for entering, exiting or still not

I can't find StillWathing used below.

>   *            being in dyntick-idle mode.

s/dyntick-idle/eqs

>   * context: "USER" or "IDLE" or "IRQ".
>   * NMIs nested in IRQs are inferred with nesting > 1 in IRQ context.
>   *
>   * These events also take a pair of numbers, which indicate the nesting
>   * depth before and after the event of interest, and a third number that is
> - * the ->dynticks counter.  Note that task-related and interrupt-related
> + * the RCU_WATCHING counter.  Note that task-related and interrupt-related
>   * events use two separate counters, and that the "++=" and "--=" events
>   * for irq/NMI will change the counter by two, otherwise by one.
>   */
> -TRACE_EVENT_RCU(rcu_dyntick,
> +TRACE_EVENT_RCU(rcu_watching,
>  
> -	TP_PROTO(const char *polarity, long oldnesting, long newnesting, int dynticks),
> +	TP_PROTO(const char *polarity, long oldnesting, long newnesting, int counter),
>  
> -	TP_ARGS(polarity, oldnesting, newnesting, dynticks),
> +	TP_ARGS(polarity, oldnesting, newnesting, counter),
>  
>  	TP_STRUCT__entry(
>  		__field(const char *, polarity)
>  		__field(long, oldnesting)
>  		__field(long, newnesting)
> -		__field(int, dynticks)
> +		__field(int, counter)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->polarity = polarity;
>  		__entry->oldnesting = oldnesting;
>  		__entry->newnesting = newnesting;
> -		__entry->dynticks = dynticks;
> +		__entry->counter = counter;
>  	),
>  
>  	TP_printk("%s %lx %lx %#3x", __entry->polarity,
>  		  __entry->oldnesting, __entry->newnesting,
> -		  __entry->dynticks & 0xfff)
> +		  __entry->counter & 0xfff)
>  );
>  
>  /*
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index dfa64f21d900d..fdbb584b8e797 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -137,7 +137,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
>  
>  	instrumentation_begin();
>  	lockdep_assert_irqs_disabled();
> -	trace_rcu_dyntick(TPS("Start"), ct_nesting(), 0, ct_rcu_watching());
> +	trace_rcu_watching(TPS("End"), ct_nesting(), 0, ct_rcu_watching());
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	rcu_preempt_deferred_qs(current);
>  
> @@ -182,7 +182,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
>  	// instrumentation for the noinstr ct_kernel_enter_state()
>  	instrument_atomic_write(&ct->state, sizeof(ct->state));
>  
> -	trace_rcu_dyntick(TPS("End"), ct_nesting(), 1, ct_rcu_watching());
> +	trace_rcu_watching(TPS("Start"), ct_nesting(), 1, ct_rcu_watching());
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	WRITE_ONCE(ct->nesting, 1);
>  	WARN_ON_ONCE(ct_nmi_nesting());
> @@ -219,7 +219,7 @@ void noinstr ct_nmi_exit(void)
>  	 * leave it in non-RCU-idle state.
>  	 */
>  	if (ct_nmi_nesting() != 1) {
> -		trace_rcu_dyntick(TPS("--="), ct_nmi_nesting(), ct_nmi_nesting() - 2,
> +		trace_rcu_watching(TPS("--="), ct_nmi_nesting(), ct_nmi_nesting() - 2,
>  				  ct_rcu_watching());
>  		WRITE_ONCE(ct->nmi_nesting, /* No store tearing. */
>  			   ct_nmi_nesting() - 2);
> @@ -228,7 +228,7 @@ void noinstr ct_nmi_exit(void)
>  	}
>  
>  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> -	trace_rcu_dyntick(TPS("Startirq"), ct_nmi_nesting(), 0, ct_rcu_watching());
> +	trace_rcu_watching(TPS("Endirq"), ct_nmi_nesting(), 0, ct_rcu_watching());

Ah the initial string was wrong and you're fixing it, right?

Should be a seperate patch?

>  	WRITE_ONCE(ct->nmi_nesting, 0); /* Avoid store tearing. */
>  
>  	// instrumentation for the noinstr ct_kernel_exit_state()
> @@ -294,7 +294,7 @@ void noinstr ct_nmi_enter(void)
>  		instrumentation_begin();
>  	}
>  
> -	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> +	trace_rcu_watching(incby == 1 ? TPS("Startirq") : TPS("++="),

Ditto?

Thanks.

>  			  ct_nmi_nesting(),
>  			  ct_nmi_nesting() + incby, ct_rcu_watching());
>  	instrumentation_end();
> -- 
> 2.43.0
> 
