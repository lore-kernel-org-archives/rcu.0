Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA632E75A;
	Wed, 15 Jul 2026 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149090; cv=none; b=HaHFRyYLLEOrV5CpYMYnq8CEu5XHA7I+oYMaqYHmKVVB0KYnkk8Wsnz+ik0tQUq7CGF8I9FZIX1WQfTyEmdemasutyfE2CXh2Ix6pppyD8Ai/OKyku+drpz/wCereqzaR4roNwo3oVO8StVeE5PNaXrSI2Bej62rV85o365+k2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149090; c=relaxed/simple;
	bh=elwm+KAmD2xi9zV5jt/AC+lvacDdcdxBmixEAwr98Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/YmT9q5nRW7rK0yDk616Z9R4gkitO+8oNomLDaGcPceDhHFpHmHWJdC6xA6v3HLEaQDdnZS2Q8+y9Jq31BT1YoTBechjL/S/3qyzMU1/ReICPFei0LkDbkpqpk6fuOq2HzN0RhRBn3SfisRyJJlJTilJT1mrJpiMRQRGUZvRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrInj52X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrInj52X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8FA1F000E9;
	Wed, 15 Jul 2026 20:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784149088;
	bh=mHmuj9g5zijr/cLn8EvSaKKycyhrUZQwDcUXVELd8I0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=WrInj52XWpubTTnCWcOhJJC+B5gWYKXeD3CRLwpkIwyG3bmlnZxGTYVpZ1FcpvQ+A
	 SfOreIpqES7jEp/etn4NP+nyev5JzRxxSWOxycclucKZU1Qvz+Ptl1BXzbmbrlz/x7
	 ezcVWttp2FbSeLAnNYSOHnCB3zDLLXfLZv9qg1Hkkp1pr52RTFAZQftL93CTYU5q1W
	 5Lf/xS6aQ/hVs170N2btMTPXvyGaS4/8hpiVZPdgWCTO7Z7Z23NBemZlwN1pihZD2j
	 h95T4TNMsooIcmk+eLDnHHfSGFo/BbYcNYNuhLLy4hGCbuEteF26MUV+DnQH9dHaVL
	 pNMZ950Ntz8sw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A20B7CE0AD3; Wed, 15 Jul 2026 13:58:08 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:58:08 -0700
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
Subject: Re: [PATCH v4 4/8] rcu: drop redundant defer_qs_pending clear in
 irqrestore handler
Message-ID: <434ccb30-64e9-47a4-bb08-621632eddadf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-5-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626004301.1632168-5-joelagnelf@nvidia.com>

On Thu, Jun 25, 2026 at 08:42:57PM -0400, Joel Fernandes wrote:
> With __note_gp_changes() now clearing defer_qs_pending at every
> per-CPU GP advance, the per-irqrestore clear is redundant.  Remove it.

Wait...

Given your patch 2/8 of this series, isn't __note_gp_changes() now
clearing ->defer_qs_pending on any new-to-this-CPU grace period start
or end?  If that was a new-to-this-CPU grace period start, is that really
a one-to-once correspondence to the need for a quiescent state?

							Thanx, Paul

> Effect: PENDING now stays set from arming until the next per-CPU GP
> advance, future arming attempts on the same CPU within the same GP are
> gated by the rcu_read_unlock_special().
> 
> This serves both as an optimization (should not need new irq_work again
> this GP - for the compounded section case, we detect and clear it there),
> and reduces risks of recursion due to clearing too aggressively.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree_plugin.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 7768a40677a4..c37d8cfeb714 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -581,8 +581,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  	union rcu_special special;
>  
>  	rdp = this_cpu_ptr(&rcu_data);
> -	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
> -		rcu_defer_qs_clear(rdp);
>  
>  	/*
>  	 * If RCU core is waiting for this CPU to exit its critical section,
> -- 
> 2.34.1
> 
