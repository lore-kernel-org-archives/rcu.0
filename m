Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644978F26;
	Fri, 10 Jul 2026 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691944; cv=none; b=HWEQkioptKLzT0El2HHWAfJx49HWwMPdjNHhgic1ykti5ObeMbKQ1PAfpakLn4I1s2GF0FmK2LRQI1ONelkm5Fy1Pk7vEjVPLy/pthKjctByQ1lvC56kckWsyDovZUxzLM9SCs4YgR+Yx3HIAIK8973w32kPEN9Nw07aaYBdeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691944; c=relaxed/simple;
	bh=j332/j8tKfoxv3fPmO7nfj5mNDas+GvJBd+2IqFSuCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOLTPQXx9O4D9UkJWImiue9UK2gjOj581FjCq4InKg+8ib8E4JN2JxvvjpwIbYC7LPISOuHhstuMfsCq5dNS+9M6e+5h48tTqzluvSZ+brjIAZIPytvY2KQKodX3tW67mChFCIDq96tLQFaOYNOVj2QG5SBKN66KBJBlFJwtMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7FGB0Y9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7FGB0Y9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357411F000E9;
	Fri, 10 Jul 2026 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691942;
	bh=zWK0Aahhqe+pxV53i0Yr8er3EBs9ds6FiyH9QErpn7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L7FGB0Y9gx5cceVRPkQhH8RGN6CSMLsdg3qQX0uxA+kJU+czojdljZVglkYg3lrXM
	 3+ZF+pyM9IwUMd3E+W6qr/OCoZzxAKFGi3LCrn4+Do+Xuo/dKvWJMcFdlkzALz1XJG
	 fqGXREshPQGNxTClx9fLSlebqT2uV6zRArvpHR/0bW1gSx3CIp5oR+sihwJho9ZdD6
	 gG/7UsWlYyR4B70YCE3DE04qNLbAXRTuSjLeePqW1QHZuXo2cM6F2Fd5Elg7NANI1A
	 45kea7+e4twVnsBDgoN+LC/xo7xciA2sKeWwOXW/+rwEGKV/PUnjPPHtagbT8ENVYl
	 Es5E/htdU/NTQ==
Date: Fri, 10 Jul 2026 15:58:59 +0200
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
Subject: Re: [PATCH v1 06/11] rcu: Enable RCU callbacks to benefit from
 expedited grace periods
Message-ID: <alD6o01ukyliCS37@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-7-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624132356.516959-7-puranjay@kernel.org>

Le Wed, Jun 24, 2026 at 06:23:48AM -0700, Puranjay Mohan a écrit :
> Currently, RCU callbacks only track normal grace-period sequence
> numbers.  This means callbacks must wait for normal grace periods to
> complete even when expedited grace periods have already elapsed.
> 
> Use the full struct rcu_gp_seq (which tracks both the normal and
> expedited grace-period sequences) throughout the callback
> infrastructure.
> 
> rcu_segcblist_advance() now checks both normal and expedited GP
> completion via poll_state_synchronize_rcu_full(), and becomes
> parameterless since it reads the grace-period state internally.
> rcu_segcblist_accelerate() stores the full state (both sequences)
> instead of just the normal one.  rcu_accelerate_cbs() and
> rcu_accelerate_cbs_unlocked() use get_state_synchronize_rcu_full() to
> capture both sequences, and the NOCB advance checks use
> poll_state_synchronize_rcu_full() instead of comparing only the normal
> sequence.
> 
> srcu_segcblist_advance() becomes a standalone implementation because it
> compares SRCU sequences directly and cannot use
> poll_state_synchronize_rcu_full(), which reads RCU-specific globals.
> srcu_segcblist_accelerate() sets the ->exp field to
> RCU_GET_STATE_NOT_TRACKED so that poll_state_synchronize_rcu_full()
> compares only ->norm and ignores ->exp.
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/rcu/rcu_segcblist.c | 30 +++++++++++++++++++++++-------
>  kernel/rcu/rcu_segcblist.h |  2 +-
>  kernel/rcu/tree.c          |  9 +++------
>  kernel/rcu/tree_nocb.h     | 33 +++++++++++++++++++++++----------
>  4 files changed, 50 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 4e3dfe42bc097..cf8951d33e767 100644
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
> -void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp)
> +void rcu_segcblist_advance(struct rcu_segcblist *rsclp)
>  {
>  	int i;
>  
> @@ -509,7 +510,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp)
>  	 * are ready to invoke, and put them into the RCU_DONE_TAIL segment.
>  	 */
>  	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
> -		if (ULONG_CMP_LT(gsp->norm, rsclp->gp_seq[i].norm))
> +		if (!poll_state_synchronize_rcu_full(&rsclp->gp_seq[i]))

So after more careful review, the smp_mb() at the end of a successful
poll_state_synchronize_rcu_full() is necessary here because the current locking
is not enough to make sure we synchronize against the end of the grace period.

But what about the smp_mb() at the beginning? Paul what is the point of this one
already? It advertizes to pair with the smp_mb() on root cleanup but what
exactly is to be ordered here? Why does gp cleanup need to synchronize with
failing poll_state_synchronize_rcu_full() ? The smp_mb() before rcu_seq_snap()
in get_state_synchronize_rcu_full() should already synchronize the accesses
before that call against the beginning of the grace period.

If we keep all these barriers around and both RCU_WAIT_TAIL and RCU_NEXT_READY
need to be advanced, that makes 4 smp_mb() calls.

> @@ -637,14 +638,29 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
>  
>  void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>  {
> -	struct rcu_gp_seq gs = { .norm = seq };
> +	int i;
> +
> +	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
> +	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
> +		return;
> +
> +	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
> +		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i].norm))
> +			break;

Why not use the same API here and consolidate the code? ->exp is RCU_GET_STATE_NOT_TRACKED so it's
harmless?

> @@ -1164,7 +1164,7 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>  	 * accelerating callback invocation to an earlier grace-period
>  	 * number.
>  	 */
> -	gs.norm = rcu_seq_snap(&rcu_state.gp_seq);
> +	get_state_synchronize_rcu_full(&gs);

I have similar concerns about the three smp_mb() in
get_state_synchronize_rcu_full(). It could be just two (rcu_seq_snap()
has a barrier that could be just one). Not sure if that matters but,
just wanted to point that.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
