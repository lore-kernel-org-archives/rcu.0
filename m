Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5EC396B6F;
	Tue, 21 Jul 2026 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644518; cv=none; b=ki4JXjhoXlo0MQROPXwLajywfXmqDiPVMXHn3WGbwevNNaTq8DmyvlkzJ7VXsTJ7ltjfLAz3DfM/aZr2/PpXTVtijAYOxXpZ9la/SFoOYWmeRogx7TW1sQ/L/MjAaAxaaS8DiOAJ/SSUqwAi27L7wYTTDdqyIfITFg1BTabPBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644518; c=relaxed/simple;
	bh=+EbnvXue7CbBd2BN+rg1H+M+Qpp1Umx2DtYD4LyHI20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddEhQR3H6BrEKsZlT5Fojp6LM0xHn1I8ZyDeLs2ocVbB+rxJxktGIcDHocB9XV/0D1TMgSHGqJlmdfZQjWivr+PaPg325WsPj31rQyLhsrk1vfFulwi/ae19oWFtkroWKCicRibj60rGs3zKNmHA7JVE9LQwDzPhV8n+aTY2RFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBnr/P0W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBnr/P0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E241A1F00A3A;
	Tue, 21 Jul 2026 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784644517;
	bh=yUrPUElkD+Gkni4oXwbYATze7jFOuU0BsBy01lbW6dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YBnr/P0W0IUyaVFI1obO1AQ6ql2+2T0EnDoG/ZXQLhDuTkFQr6mbDR1bgbyJl1pyt
	 owBjPfjEqreRJXulCPv9L8b0swihAPgveTp3PfNiin4cdpXbTq/xybxUFOE81eTygn
	 UeDMs2tgv2liOikJovgTHk298BBOqilhvkbpTc7aiIdPTKYcvwbQATHVcMxaD0JEZY
	 X9ler/jSi2I/7Osp0e+QMJ4K0JQROtN6BXGCFwK4EM8tXCApTmt+G8fuV6V6lRsFQr
	 agB74P7giXGr0EPnaropbW5cUfou3MXdmekKei2ACwbZe6x2BET/bIL4az8ylmnc1C
	 AoaQFBI77PmYQ==
Date: Tue, 21 Jul 2026 16:35:14 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 10/11] rcu: Advance callbacks for expedited GP
 completion in rcu_core()
Message-ID: <al-DopVEIe2FvLnv@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-11-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624132356.516959-11-puranjay@kernel.org>

Le Wed, Jun 24, 2026 at 06:23:52AM -0700, Puranjay Mohan a écrit :
> Even when rcu_pending() triggers rcu_core(), the normal callback
> advancement path through note_gp_changes() -> __note_gp_changes() bails
> out when rdp->gp_seq == rnp->gp_seq (no normal GP change). Since
> expedited GPs do not update rnp->gp_seq, rcu_advance_cbs() is never
> called and callbacks remain stuck in RCU_WAIT_TAIL.
> 
> Add a direct callback advancement block in rcu_core() that checks for GP
> completion via rcu_segcblist_nextgp() combined with
> poll_state_synchronize_rcu_full(). When detected, trylock rnp and call
> rcu_advance_cbs() to move completed callbacks to RCU_DONE_TAIL. Wake the
> GP kthread if rcu_advance_cbs() requests a new grace period.
> 
> Uses trylock to avoid adding contention on rnp->lock. If the lock is
> contended, callbacks will be advanced on the next tick.
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/rcu/tree.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b01d7bf6b57b1..f42e01ef479c4 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2891,6 +2891,23 @@ static __latent_entropy void rcu_core(void)
>  	/* Update RCU state based on any recent quiescent states. */
>  	rcu_check_quiescent_state(rdp);
>  
> +	/* Advance callbacks if an expedited GP has completed. */
> +	if (!rcu_rdp_is_offloaded(rdp) && rcu_segcblist_is_enabled(&rdp->cblist)) {
> +		struct rcu_gp_seq gp_state;
> +
> +		if (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
> +		    poll_state_synchronize_rcu_full(&gp_state)) {
> +			guard(irqsave)();
> +			if (raw_spin_trylock_rcu_node(rnp)) {
> +				bool needwake = rcu_advance_cbs(rnp, rdp);
> +
> +				raw_spin_unlock_rcu_node(rnp);
> +				if (needwake)
> +					rcu_gp_kthread_wake();
> +			}
> +		}
> +	}

Should that go as an improvement to note_gp_changes() instead?

Thanks.

> +
>  	/* No grace period and unregistered callbacks? */
>  	if (!rcu_gp_in_progress() &&
>  	    rcu_segcblist_is_enabled(&rdp->cblist) && !rcu_rdp_is_offloaded(rdp)) {
> -- 
> 2.53.0-Meta
> 

-- 
Frederic Weisbecker
SUSE Labs
