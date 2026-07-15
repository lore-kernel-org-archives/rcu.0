Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745CF36A033;
	Wed, 15 Jul 2026 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149272; cv=none; b=dFFWFLu+pxvbBiJF9kF25dwikhXfeM/k7K+WgzUbYuBuYAZ7OEyKtjd0IbhZ+ns13vM+xQ/i6fQDTWOKsl8/qw2eMdStpo/VGPXtTKI16gTlZettHyT6SRNp+YzRuCmYoEKwzW8mzsGUz7GVpcrS0hfchV+SIUYU2rQNH/+vSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149272; c=relaxed/simple;
	bh=5DZzQ67R7N2/lxiMq13H2hPMFkVmeCmTs+50t3M+99U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfnxaJLUsVGgznEDBsrvhwRfygA5qset8AXg94jB0SpDk7X+Togx7g4FwuD8hu1nVwZEcetQU5EsAYUmuYF323YVYvGXv9t2qsDlfMZFvJ578P2zgiShTtjQVuknshqVripL+YfqSDDkNZjEOAKP3QM5WdcEZrEpY0s+TNU/mtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu6dg28Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu6dg28Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76681F000E9;
	Wed, 15 Jul 2026 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784149271;
	bh=IIR45VU3eew8hZ9R33jPpgh7XHjrJMf5pVKc/teKRcM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=cu6dg28ZX+hdSsnNaQm28eXycrLhX57ybjAl0/RGYjTqI8QqZexWd4vU06xKZFdTu
	 Ori+F16cfWvbt64c/pGiY56cFDlzlRGqKPJHobOZOpyAnMucLkEGWprrDbe/onLvso
	 EaT/A9/kebXIO+V7GLWGirAFRGoOSnFKGzqpM/20rXoIZgF2FE7eAg02exsZ2CTzQp
	 13AL902z1t3gEDDRmE8ni4gxgucjkNoRz273mgmcCLikFIfMzfsM69PZ4tVgHIX/cZ
	 sJrCyJnygUMnLKNAiprasz2EG0Y8cDcf7pF7BoWj1IubJu8MnimF+HW2fl5XHXkqb1
	 i19RtZVp2IFuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B1AECCE0AD3; Wed, 15 Jul 2026 14:01:10 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:01:10 -0700
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
Subject: Re: [PATCH v4 5/8] rcu: clear defer_qs_pending at expedited IPI entry
Message-ID: <fc902af8-4e2f-4e23-834e-6d00fa85c06c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-6-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626004301.1632168-6-joelagnelf@nvidia.com>

On Thu, Jun 25, 2026 at 08:42:58PM -0400, Joel Fernandes wrote:
> The per-CPU clear in __note_gp_changes() (from an earlier commit)
> runs only when the local CPU notices a normal-GP advance.  When an
> expedited GP arrives at a CPU whose defer_qs_pending is already
> PENDING, rcu_read_unlock_special() may skip irq_work queuing due to the
> pending gate.
> 
> Clear defer_qs_pending on the IPI target right in rcu_exp_handler().
> This makes it possible for any arming attempt that follows
> the IPI within the current GP to be able to queue irq_work again,
> allowing completion expedited GPs quickly than waiting for one scheduler
> tick.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree_exp.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index a43469da3926..5be80d255d6a 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -763,6 +763,12 @@ static void rcu_exp_handler(void *unused)
>  			 READ_ONCE(rdp->cpu_no_qs.b.exp)))
>  		return;
>  
> +	/*
> +	 * Clear defer_qs_pending so arming attempts following this IPI
> +	 * within the current GP can queue irq_work again.
> +	 */
> +	rcu_defer_qs_clear(rdp);

Suppose that there is also a normal grace period pending.  Will clearing
this cause extra unnecessary activity with respect to that normal
grace period?  If so, why is that OK?  If not, what prevents it?

							Thanx, Paul

> +
>  	/*
>  	 * Second, the common case of not being in an RCU read-side
>  	 * critical section.  If also enabled or idle, immediately
> -- 
> 2.34.1
> 
