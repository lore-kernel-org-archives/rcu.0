Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A53CFF4A;
	Wed, 15 Jul 2026 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149924; cv=none; b=NYmFakpDIfahagKH4EfNQI/uzR8/NiA7ReIBdoV/BnvK1b6g1gjADjHo16V4abYi/Als1fOCkFix3jxXLUHlxKacgLnmyhIRGJslhEzKEvxSqmgz9HwSDkp8B39iHnoXdLNmyiymGVJ1Dw/Fobbspo45DB7YHs/0dW5KMNNfL/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149924; c=relaxed/simple;
	bh=h4UwERi74gmwXyRIm3zK7mSncdzf02bN3BHMiNkBcJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXYwuuLPj1SW5SnHlTpsQT4k127YfdO7bnZeSkMxrcLu8ApoD9BpmBZTbgxn4S9lpDX53nGtgDHOn9RFUWNb9c6cq1HIC5khpzXlUO9EVCw3hxB9Uuj3u8Khmgg4fshXAK8JLbkF8kzm8p/BUJuOAElUel8wKu0lTMDvNc7AoYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dak+B7H4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dak+B7H4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C151F000E9;
	Wed, 15 Jul 2026 21:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784149922;
	bh=7JABPCF7W3P4433IOK4h6FCm9uKqtlsb2l8mGnCk6UI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Dak+B7H4krzL2+rG8oaX+SBbu1NSuQvtHMS8vvGWOGmUI1y+lRmK5sc49QywNIsEb
	 ZnaxpM9Qn7D1gJ63R3q+zlFNGhKv+rS+wzhGbEgZ/Rr//UyBD2/n3c0hl8MOjeiJp1
	 I1NPWwmha59vn9fvrLmgnM/Krou9I2HM49EM0XYGWITSx5UqRvH01JfOVUrzdh0UoT
	 wRYZR6SZrv0vH/dIsKjAJWYFGKgGZBiS5MOBIwB8hcxHxntsWWsxrE7OLcWh/3Pwlk
	 xpdiI3aUKmv+pmW7Q0BdZvnKQ6UBCAIzat1JInEEe1CRKT89ScSM5rqu7eciUkNjsm
	 Ltl0NBAy+lWsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6D670CE0AD3; Wed, 15 Jul 2026 14:12:02 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:12:02 -0700
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
Subject: Re: [PATCH v4 6/8] rcu: set need_resched on softirq deferred-QS
 arming path
Message-ID: <9c3fa7ae-df21-42ca-84b3-8eaea8684ceb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-7-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626004301.1632168-7-joelagnelf@nvidia.com>

On Thu, Jun 25, 2026 at 08:42:59PM -0400, Joel Fernandes wrote:
> The arming code in rcu_read_unlock_special() has two paths for
> deferring QS reporting: a softirq raise and an irq_work/set_need_resched
> combination.
> 
> The irq_work path always calls set_need_resched_current() before
> queuing irq_work. The softirq path does not, relying solely on the
> softirq firing to do the rightthing.
> 
> This results in a problem as follows:
> 
> Consider 2 rcu_read_lock/unlock segments:
> 
>         rcu_read_lock();            // segment 1 starts
>         // needs_exp becomes true
>         preempt_disable();
>         rcu_read_unlock();          // segment 1 ends; IRQs on, preempt
>                                     // off, needs_exp=true =>
>                                     //   raise_softirq(RCU_SOFTIRQ);
>                                     //   arms defer_qs_pending.
>                                     // Before this fix: no
>                                     // set_need_resched_current().
>         local_irq_disable();
>         preempt_enable();           // softirq pending but IRQs disabled
>                                     // hold it off.
>         rcu_read_lock();            // segment 2 starts
>         local_irq_enable();         // softirq fires: rcu_core runs, but
>                                     // we are inside a reader (depth>0)
>                                     // so no QS report; on softirq-exit
>                                     // preempt-check finds no
>                                     // need_resched -- still no nudge.
>         preempt_disable();
>         rcu_read_unlock();          // arming attempt suppressed
>                                     // incorrectly: defer_qs_pending
>                                     // already PENDING.  Without this
>                                     // fix, no fresh
>                                     // set_need_resched_current() on
>                                     // this path either.
>         preempt_enable();
> 
> Therefore, add set_need_resched_current() to the softirq deferral path to
> avoid long latencies in situations where GP needs to end sooner.

Hmmm...  Doesn't this make some of the prior changes unnecessary?
Also, how often is this giving us unecessary context switches?

Finally, what exactly does (->defer_qs_pending == DEFER_QS_PENDING)
mean at this point?

							Thanx, Paul

> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree_plugin.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c37d8cfeb714..f58ae29acdef 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -846,6 +846,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			// Using softirq, safe to awaken, and either the
>  			// wakeup is free or there is either an expedited
>  			// GP in flight or a potential need to deboost.
> +			set_need_resched_current();
>  			if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
>  				rdp->defer_qs_pending = DEFER_QS_PENDING;
>  				raise_softirq_irqoff(RCU_SOFTIRQ);
> -- 
> 2.34.1
> 
