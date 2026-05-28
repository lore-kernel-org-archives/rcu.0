Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31DD1F5847;
	Thu, 28 May 2026 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974132; cv=none; b=EaJi5fphttSGwYVpnSehCVEiEQ1QcgPQQtj0CIxUyxWMZ1iOnLr+W9bMKfRAScQqCvZSMpY+x6QxdHc0Gr/1cSmP9YOnVuitQCQdGOzAeA5xwY3HCqu3Zoq7v8TpEIpYFw9AWRu1psbERqcNPVMqWUk0bId1ql3W7QFwAIaGyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974132; c=relaxed/simple;
	bh=hpXDyGw8ZfyiJF6ePzatPmkbxaSUHYgrYAEkoUyBUU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdnjv1dKqA1ZlK9CnziHORV5qdPtXCYdRkebccwBq8eoDiAWe1FTisfpC9NSsg7kNCTJG1Fl5oMTeHNawbPNCdCKoYROwZOezuuCgP0T/cdldF3yzunB1zXJ2vkIqbxlHgnGAd09Zw7H8cWbhqs12TOG66MEHq2ThXITGz8R5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfO3rcAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfO3rcAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B591F000E9;
	Thu, 28 May 2026 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779974130;
	bh=+jPdvSYpk/9HjEVPjXiZDWUUpNzNGZDnylzW2hmcYUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DfO3rcAI/jRtaEMgrN9pzQuPvPSRAaf5Xeq5drMIe1hXJf+PHSFlRVIPCXleKjPve
	 cARJb0FPlSS9qGPgsfhKy8oxq6gddImbvv9MabuW2rG+QVOTjgn8qZRrQnNHMxkmIN
	 oeYylUnUk3c0PIsnlC9PCy/BFOMr3vw6qg9MrJJJxRcc6FIHdW0IYYU5fdZ/A3ghYS
	 Eed2lRLFbLyHXhfjS4YS6KM6Jp/WpX7aj+MtiqBM2/aSiKNlHUBAVmhWsxThWZPbrD
	 7SKFH0omACL5dMyznaBg2wjAEQuZa0zlWYmbao8so+8JbeXvDnvbgrzTG6C65iPlF4
	 9RdVlcjcnaTaA==
Date: Thu, 28 May 2026 15:15:27 +0200
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
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC PATCH 03/10] rcu/segcblist: Change gp_seq to struct
 rcu_gp_oldstate gp_seq_full
Message-ID: <ahg_7wEDrgMd_5fs@localhost.localdomain>
References: <20260417231203.785172-1-puranjay@kernel.org>
 <20260417231203.785172-4-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417231203.785172-4-puranjay@kernel.org>

Le Fri, Apr 17, 2026 at 04:11:51PM -0700, Puranjay Mohan a écrit :
> This commit renames the ->gp_seq[] field in struct rcu_segcblist to
> ->gp_seq_full[] and changes its type from unsigned long to struct
> rcu_gp_oldstate. This prepares the callback tracking infrastructure to
> support both normal and expedited grace periods.
> 
> All function signatures are updated to pass struct rcu_gp_oldstate
> pointers: rcu_segcblist_nextgp(), rcu_segcblist_advance(), and
> rcu_segcblist_accelerate() now take struct rcu_gp_oldstate * instead of
> unsigned long. All callers are updated to use the .rgos_norm field for
> comparisons and assignments.
> 
> The SRCU and Tasks RCU wrappers now construct an rcu_gp_oldstate with
> just .rgos_norm set and forward to the core functions.
> 
> No functional change: only the .rgos_norm field is used in place of
> gp_seq.
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/rcu_segcblist.h |  2 +-
>  include/trace/events/rcu.h    |  5 +++--
>  kernel/rcu/rcu_segcblist.c    | 30 +++++++++++++++++-------------
>  kernel/rcu/rcu_segcblist.h    |  6 +++---
>  kernel/rcu/tree.c             | 25 ++++++++++++++-----------
>  kernel/rcu/tree_nocb.h        | 29 +++++++++++++++--------------
>  6 files changed, 53 insertions(+), 44 deletions(-)
> 
> diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> index 2fdc2208f1ca..59c68f2ba113 100644
> --- a/include/linux/rcu_segcblist.h
> +++ b/include/linux/rcu_segcblist.h
> @@ -190,7 +190,7 @@ struct rcu_cblist {
>  struct rcu_segcblist {
>  	struct rcu_head *head;
>  	struct rcu_head **tails[RCU_CBLIST_NSEGS];
> -	unsigned long gp_seq[RCU_CBLIST_NSEGS];
> +	struct rcu_gp_oldstate gp_seq_full[RCU_CBLIST_NSEGS];

That could stay as gp_seq.

>  #ifdef CONFIG_RCU_NOCB_CPU
>  	atomic_long_t len;
>  #else
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 421f1dadb5e5..00e164db8b74 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -496,7 +496,7 @@ static void rcu_segcblist_advance_compact(struct rcu_segcblist *rsclp, int i)
>   * Advance the callbacks in the specified rcu_segcblist structure based
>   * on the current value passed in for the grace-period counter.
>   */
> -void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
> +void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct
> rcu_gp_oldstate *rgosp)

I don't think we need to rename everything to rgos*, especially as it's not as
intuitive as gp_seq.

>  {
>  	int i;
>  
> @@ -1229,7 +1231,8 @@ static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>  	 * Find all callbacks whose ->gp_seq numbers indicate that they
>  	 * are ready to invoke, and put them into the RCU_DONE_TAIL sublist.
>  	 */
> -	rcu_segcblist_advance(&rdp->cblist, rnp->gp_seq);
> +	rgos.rgos_norm = rnp->gp_seq;

Can we shorten that rgos_norm field to just norm?
So the above would parse better as:

   gp_seq->norm = rnp->gp_seq

> +	rcu_segcblist_advance(&rdp->cblist, &rgos);
>  
>  	/* Classify any remaining callbacks. */
>  	return rcu_accelerate_cbs(rnp, rdp);
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 1047b30cd46b..1837eedfb8c2 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -433,7 +433,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  				bool lazy)
>  {
>  	unsigned long c;
> -	unsigned long cur_gp_seq;
> +	struct rcu_gp_oldstate cur_gp_seq_full;

This could stay as cur_gp_seq.

>  	unsigned long j = jiffies;
>  	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>  	long lazy_len = READ_ONCE(rdp->lazy_len);
> @@ -501,8 +501,8 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  			return false; // Caller must enqueue the callback.
>  		}
>  		if (j != rdp->nocb_gp_adv_time &&
> -		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> -		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
> +		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full) &&
> +		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq_full.rgos_norm)) {

Because cur_gp_seq.norm would parse much better.

>  			rcu_advance_cbs_nowake(rdp->mynode, rdp);
>  			rdp->nocb_gp_adv_time = j;
>  		}
> @@ -659,7 +659,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  {
>  	bool bypass = false;
>  	int __maybe_unused cpu = my_rdp->cpu;
> -	unsigned long cur_gp_seq;
> +	struct rcu_gp_oldstate cur_gp_seq_full;

Ditto

>  	unsigned long flags;
>  	bool gotcbs = false;
>  	unsigned long j = jiffies;
> @@ -730,8 +730,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  		needwake_gp = false;
>  		if (!rcu_segcblist_restempty(&rdp->cblist,
>  					     RCU_NEXT_READY_TAIL) ||
> -		    (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> -		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq))) {
> +		    (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full) &&
> +		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq_full.rgos_norm))) {
>  			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
>  			needwake_gp = rcu_advance_cbs(rnp, rdp);
>  			wasempty = rcu_segcblist_restempty(&rdp->cblist,
> @@ -877,7 +877,7 @@ static inline bool nocb_cb_wait_cond(struct rcu_data *rdp)
>  static void nocb_cb_wait(struct rcu_data *rdp)
>  {
>  	struct rcu_segcblist *cblist = &rdp->cblist;
> -	unsigned long cur_gp_seq;
> +	struct rcu_gp_oldstate cur_gp_seq_full;

Ditto.

>  	unsigned long flags;
>  	bool needwake_gp = false;
>  	struct rcu_node *rnp = rdp->mynode;

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
