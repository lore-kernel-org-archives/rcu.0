Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA873C3442;
	Fri, 29 May 2026 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065573; cv=none; b=Urx2QqjO9vYxdydLaPk2Zx8Z8UQ39Owgs3Quuj2GJ10WseBEFrOqkD4LJ4MqEphXiHzVW9tlTauVmkb4gZho8ejihPdLzpPCX6OTq0605HY7HpjGCKRMIQoF/WcGF7OdxtQ5nVWTEBWYjn6B1mEeJ94CKqAhlIqcO7TsMZJRHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065573; c=relaxed/simple;
	bh=B4v65EkSYYfc6W/AP3HtolvSHSB3ffldDfSlYvFH9bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1JZSbzDsUVplcTWbKB3RcNVi4bbpNbAq1S3FlIrOb8/OMLKEj3fQ3W0d05nrGKiigIIQiN92Gb6oESNLYGgw6/VbZJVff2MUXFWytesz6/g6CH2nN5TBBvDmv+5Vsnl2doUwWA75BPMQmIvQ9KCjaWnno8oT1qpNZ+pMYHhhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byU39WLk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byU39WLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2351F00893;
	Fri, 29 May 2026 14:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780065571;
	bh=FQ5LAZJas9VmjgRM/gA9vyyyp0frMUGasfqAhzBfzAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=byU39WLkCeF5DKW4cY0N88UAnIeavXfY8FW7l4ki2cPXjO8gX0p/wYikpMFgRI0ZY
	 NDjckxuGOIHFmRqLwizVOjTVm1d9I2VEJ5xUjf7Sc0QXLbn8OMr+ZqgfAuflXBhgE9
	 +JVwMa7nND8fsZzqioDk8oy5sfqsn6wia/RWZ/262QncnxO8fTVcHwQGJjC+PsWb+U
	 r5pfLD6pWVYtzW+uLOzaSEfnkuFOaWxXvZpTTcPT2m45ZIwvh7aiB/rnErRbf5y5af
	 KOofJFzuN/UoYGgBM5C9v5pY4fuUnHWZilnwLm8hSorQUqMS4K2uSJVEM4PIxh+bB/
	 Qqx4tETs1B5yA==
Date: Fri, 29 May 2026 16:39:28 +0200
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
Subject: Re: [RFC PATCH 05/10] rcu: Enable RCU callbacks to benefit from
 expedited grace periods
Message-ID: <ahmlILc6gJnk9vEb@pavilion.home>
References: <20260417231203.785172-1-puranjay@kernel.org>
 <20260417231203.785172-6-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417231203.785172-6-puranjay@kernel.org>

On Fri, Apr 17, 2026 at 04:11:53PM -0700, Puranjay Mohan wrote:
> Currently, RCU callbacks only track normal grace period sequence
> numbers.  This means callbacks must wait for normal grace periods to
> complete even when expedited grace periods have already elapsed.
> 
> This commit uses the full rcu_gp_oldstate structure (which tracks both
> normal and expedited GP sequences) throughout the callback
> infrastructure.
> 
> The rcu_segcblist_advance() function now checks both normal and
> expedited GP completion via poll_state_synchronize_rcu_full(), becoming
> parameterless since it reads the GP state internally.
> rcu_segcblist_accelerate() stores the full GP state (both normal and
> expedited sequences) instead of just the normal sequence.
> 
> The rcu_accelerate_cbs() and rcu_accelerate_cbs_unlocked() functions use
> get_state_synchronize_rcu_full() to capture both GP sequences. The NOCB
> code uses poll_state_synchronize_rcu_full() for advance checks instead
> of comparing only the normal GP sequence.
> 
> srcu_segcblist_advance() become standalone implementations because
> compares SRCU sequences directly (it cannot use
> poll_state_synchronize_rcu_full(), which reads RCU-specific globals).
> srcu_segcblist_accelerate() sets rgos_exp to RCU_GET_STATE_NOT_TRACKED
> so poll_state_synchronize_rcu_full() only compares the rgosp->rgos_norm
> and ignores rgos_exp.
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/rcu/rcu_segcblist.c | 30 ++++++++++++++++++++++++------
>  kernel/rcu/rcu_segcblist.h |  2 +-
>  kernel/rcu/tree.c          |  9 +++------
>  kernel/rcu/tree_nocb.h     | 33 +++++++++++++++++++++++----------
>  4 files changed, 51 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 00e164db8b74..11174e2be3c2 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  
> +#include "rcu.h"
>  #include "rcu_segcblist.h"
>  
>  /* Initialize simple callback list. */
> @@ -494,9 +495,9 @@ static void rcu_segcblist_advance_compact(struct rcu_segcblist *rsclp, int i)
>  
>  /*
>   * Advance the callbacks in the specified rcu_segcblist structure based
> - * on the current value passed in for the grace-period counter.
> + * on the current value of the grace-period counter.
>   */
> -void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *rgosp)
> +void rcu_segcblist_advance(struct rcu_segcblist *rsclp)
>  {
>  	int i;
>  
> @@ -509,7 +510,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *
>  	 * are ready to invoke, and put them into the RCU_DONE_TAIL segment.
>  	 */
>  	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
> -		if (ULONG_CMP_LT(rgosp->rgos_norm, rsclp->gp_seq_full[i].rgos_norm))
> +		if (!poll_state_synchronize_rcu_full(&rsclp->gp_seq_full[i]))

Ok that should work but it's worth noting two subtle changes:

- The sequence number to be compared against the segment snapshot one is now
  always from the root while it often used to be the one from the leaf node.
  It shouldn't matter I think especially as now the source of the segment
  snapshot is always either rcu_seq_snap() on the state or get_state_synchronize_rcu_full()
  and thus rcu_seq_snap() on the state as well.

- But poll_state_synchronize_rcu_full() does two full memory barriers. Hmm
  probably the one after reading the root state is necessary because we may not
  be holding the root node lock. But is the first smp_mb() necessary here?
  
Thanks.  

-- 
Frederic Weisbecker
SUSE Labs
