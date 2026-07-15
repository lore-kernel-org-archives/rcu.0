Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2BB3546EE;
	Wed, 15 Jul 2026 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148357; cv=none; b=Da/uRS7LzHmTOpOKCJtQzIERtHNClXQdpv0j0d6nH8ToimccaH79RhC2YSRO321niII7ZhR1fXVQZnWIOJpcdlgmQwfmkbr+z0dPm8c6ayeTIGN0dK5NnxXsVSRD6st5MXX/GUZYctojqCy2+Reir0uCnIuUQw71ejq+6Mdizj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148357; c=relaxed/simple;
	bh=fUQOM+MxCmqLpQWEFaXmBoo8+7EOIfGlc+f6CH/TxiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqJTYFgmLcvzuTUewC/Mh6/XBhQ77TpVlyauVWzKpQwIeOcUI81yBxIPzl21UWkhd9eOKay+vKocgxDSOtui+rgFQGp4taZ5b0EW8BLPH3kuklgT08sPpyRmHnUPUBNWibnLaU7EOf+CDcNTvMw6Rcz+/1Rm/UVXQTbaIiKHnn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEun0i6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEun0i6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3A21F000E9;
	Wed, 15 Jul 2026 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784148356;
	bh=yzgCnbNgOgp3ki9PhjdfGSnls7hC34sI4+M20YYHN4E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=mEun0i6Mau/mAQ/Rg4BBuZ7ruUdBGqjXmzl0iBwb5COL/gQgIpO0ikMYyiUK67E/s
	 V7nyDMmQHub8+WgDCC8/Aus7Kv9bvixiD3ngM97Mu2I0qKluX+7hPOx4uMkpyrXy0U
	 DVx8pV0ULAddXRkPGEqwW/bBWpquaheh5la+eZZhrFSZAtYFmcEDF+OuimP+WjUhey
	 MnNZtmWJg4Ieo8aq2rFBdDHnLcR5uFe3SlxS4mIxBJVoVo6Vw2+86wwq9ROq/rTgYt
	 Bt/lySWuhNYsBimkt2TU8aSKTCvqIY/m86s9gmTenLkNwaH1nPyhajIQ4h3eylI1uG
	 Ct+cF0a3YMyHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F512CE0AD3; Wed, 15 Jul 2026 13:45:56 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:45:56 -0700
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
Subject: Re: [PATCH v4 2/8] rcu: clear defer_qs_pending when notifying GP
 changes
Message-ID: <b4a72949-d816-447f-9c9e-93b33ddf6aae@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-3-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626004301.1632168-3-joelagnelf@nvidia.com>

On Thu, Jun 25, 2026 at 08:42:55PM -0400, Joel Fernandes wrote:
> Prior to this commit, defer_qs_pending was an unbalanced flag:
> rcu_read_unlock_special() set it to PENDING whenever a deferred-QS
> mechanism was scheduled, but the clear paths did not cover every
> up-tree quiescent-state reporting site. In those cases the flag stays
> PENDING after the QS is reported, and rcu_read_unlock_special()'s
> pending-gate then silently rejects all future arming attempts.
> 
> A test patch confirms TREE03 can have get into the problematic stuck
> state very quickly (< 5 minutes).
> 
> Clear the flag in __note_gp_changes(), right after the nothing-to-do
> early return.  This is the natural per-CPU "GP transitioned, sync local
> state" hook, called from the GP-kthread's rcu_gp_init()/rcu_gp_cleanup()
> paths, and other GP advancement paths.
> 
> For dynticks-idle CPUs, they do not call __note_gp_changes(), but they
> also do not arm new PENDING work (no readers running), and on wake-up,
> note_gp_changes() is called before any new reader runs.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

This looks plausible, but suppose we have the following:

	rcu_read_lock();
	// expedited GP plus preemption.
	preempt_disable();
	rcu_read_unlock(); // Sets ->defer_qs_pending
	// CPU takes unrelated interrupt, softirq handled, kicks
	// scheduler, and clears ->defer_qs_pending. Note that preemption
	// is disabled, so rcu_core() does set_need_resched_current()
	local_irq_disable();
	preempt_enable(); // Cannot reschedule here.
	local_irq_enable();

When do quiescent states get reported?

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e86a8c0d7b4c..c4352d0c3876 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1281,6 +1281,8 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
>  	if (rdp->gp_seq == rnp->gp_seq)
>  		return false; /* Nothing to do. */
>  
> +	rcu_defer_qs_clear(rdp);
> +
>  	/* Handle the ends of any preceding grace periods first. */
>  	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
>  	    unlikely(rdp->gpwrap)) {
> -- 
> 2.34.1
> 
