Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1D3C98BE;
	Wed, 15 Jul 2026 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148663; cv=none; b=giJS+l65PIFTtUFAmdR6iAgrpYgEksNLD59YkOqHtpKYp4KxnNn+fUuMmyX2Xr7CT02n2GgMtCiE8jWxDXEFrUWLjQACzsqpMUZzkbW9yqggC58fFBTdpsx4KQcTJStNoNlPDB74CXcBJ7G9ga08sfFtcnM59K4/kJ1Ok0X4Bt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148663; c=relaxed/simple;
	bh=DpCHGn+dYMt77GZPW0HTuvBXAMoorVVdWbIVtpTggH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUJdz5QRv7mKe4OJzXVcabU3AaVFkFKa8Yi3iuKNDNKrar1xz0eILWjOw6BeayALLLe1CApKiWYii/X1C0KUtD6eaOQTEYYf/ibxTnrXby4pNJZQUbjyiqizwUxq1tZnZSFPWafMFcVwcNZ1cLFvKaeWsTe0BvprxsUJtyB782w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7uhZoCh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7uhZoCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A241F000E9;
	Wed, 15 Jul 2026 20:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784148660;
	bh=5cdt5YsMHtPYcBzO5JtQVE7R3NLKXhyR4hZEn4Gc/O0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=h7uhZoChF7b6qsbBb4xoARsUoBrLRgqdtGj0KYfPm0EtCTwI0fxYqUUAkYKnvuHp9
	 7dT4zpfMvCEIuG3W85LJSKwxuzdycRAkR6F7s7R7r2QKIBC6gpK9Mk4bSvP318hd2Y
	 PVsMNMSZ/HK3blLIFewVU/50creJxV7WT/bYPFzsr+AcHD+32HaP+eI/OrUXbgNuI7
	 m9B7evZt1UyX0z4OOS+R7ORMaHyj/kYA35kkoIoMOMTJuZB6MCXSWYanjuPQchYG/c
	 aAjwNVspfe82SeE2sQo3p/cfy/tQ2HOgzDhv7rTTIFM2Lrp3pI+ldAyW6BTvei8voP
	 SZ79j+mSPMddQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7080CE0AD3; Wed, 15 Jul 2026 13:50:59 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:50:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org
Subject: Re: [PATCH v4 3/8] rcu: clear defer_qs_pending in handler for
 compounded sections
Message-ID: <e6aa799f-2a1d-4343-8159-715827fea64e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-4-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626004301.1632168-4-joelagnelf@nvidia.com>

On Thu, Jun 25, 2026 at 08:42:56PM -0400, Joel Fernandes wrote:
> The deferred-QS irq-work handler previously cleared defer_qs_pending
> only when the handler ran inside an active rcu_read_lock() critical
> section (rcu_preempt_depth() > 0).  Paul McKenney pointed out a common
> multi-segment compound pattern where the handler fires between
> segments and segment N+1's arming attempt is silently suppressed by
> the rcu_read_unlock_special() pending-gate:
> 
>     rcu_read_lock();           // segment 1 starts
>     // may be preempted/boosted here
>     local_irq_disable();
>     rcu_read_unlock();          // segment 1 ends; arms defer_qs_pending
>     preempt_disable();
>     local_irq_enable();         // handler MAY fire here: depth==0, but
>                                 // but preempt is disabled, so it cant
>                                 // nudge.
> 
>     rcu_read_lock();            // segment 2 starts
>     preempt_enable();
>     local_irq_disable();
>     rcu_read_unlock();     // arming attempt suppressed incorrectly -- (1)
>     local_irq_enable();
> 
> Waiting for the next __note_gp_changes() clear is too slow for the
> compound case, we need the deferred QS report sooner.
> 
> Therefore, make the irq_work handler clear defer_qs_pending whenever
> rcu_in_compounded_section() is true so that (1) can do the arming.
> 
> In addition, introduce rcu_preempt_deferred_qs_try_report(), a small
> helper that reports the deferred QS (and releases any RCU priority
> boost) directly, but only from a clean, non-reader/compound context.
> When the handler lands in such a clean context it now reports the QS
> directly instead of merely nudging the scheduler: this makes the
> irq_work robust under preempt=none / voluntary, where a
> set_need_resched() nudge would not enter __schedule() at IRQ exit and
> the QS would otherwise wait for the next tick.  When still compounded,
> the handler falls back to clearing defer_qs_pending as before.  The
> bounded-delay rescue hrtimer added in a later patch reuses this same
> helper.

The patch generally looks like an unambiguous improvement, but just to
make sure that I understand...

None of the code below is even built if CONFIG_PREEMPT_NONE=y.  So is
the text above referring to kernels built with CONFIG_PREEMPT_DYNAMIC=y
and booted with either preempt=none or preempt=voluntary?  If so, we
need to explicitly state that.

							Thanx, Paul

> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree_plugin.h | 46 ++++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 7555022bf38a..7768a40677a4 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -702,7 +702,32 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
>  }
>  
>  /*
> - * Minimal handler to give the scheduler a chance to re-evaluate.
> + * Report a deferred quiescent state but only from a safe context.
> + *
> + * Both callers (the irq_work handler and the bounded-delay rescue hrtimer)
> + * run in hardirq context, so preempt_count() always has the HARDIRQ bit set;
> + * the compound-section check below deliberately inspects only the
> + * PREEMPT_MASK | SOFTIRQ_MASK bits, which reflect the INTERRUPTED caller's
> + * state, not ours.
> + */
> +static bool rcu_preempt_deferred_qs_try_report(struct task_struct *t)
> +{
> +	unsigned long flags;
> +
> +	if (rcu_preempt_depth() > 0 ||
> +	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))
> +		return false;
> +
> +	if (rcu_preempt_need_deferred_qs(t)) {
> +		local_irq_save(flags);
> +		rcu_preempt_deferred_qs_irqrestore(t, flags);
> +	}
> +	return true;
> +}
> +
> +/*
> + * Minimal handler to give the scheduler a chance to re-evaluate, and to
> + * report the deferred QS directly when the handler lands in a clean context.
>   */
>  static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  {
> @@ -712,19 +737,14 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
>  
>  	/*
> -	 * If the IRQ work handler happens to run in the middle of RCU read-side
> -	 * critical section, it could be ineffective in getting the scheduler's
> -	 * attention to report a deferred quiescent state (the whole point of the
> -	 * IRQ work). For this reason, requeue the IRQ work.
> -	 *
> -	 * Basically, we want to avoid following situation:
> -	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
> -	 * 2. CPU enters new rcu_read_lock()
> -	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
> -	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
> -	 * 5. Deferred QS reporting does not happen.
> +	 * If the handler fired in a clean context, report the deferred QS
> +	 * directly.  This makes the irq_work robust under preempt=none /
> +	 * voluntary, where the set_need_resched() nudge would not enter
> +	 * __schedule() at IRQ exit.  Otherwise we are still inside a reader /
> +	 * compound section: just clear defer_qs_pending so the next
> +	 * rcu_read_unlock() can rearm.
>  	 */
> -	if (rcu_preempt_depth() > 0)
> +	if (!rcu_preempt_deferred_qs_try_report(current))
>  		rcu_defer_qs_clear(rdp);
>  }
>  
> -- 
> 2.34.1
> 
