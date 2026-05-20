Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51BA3BE644;
	Wed, 20 May 2026 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316114; cv=none; b=naRFl/a2Ekta2RnQsfjHchLNwTEIEI8ljRQlvdgc/zZg6S4fBVLo7gmErHIRjUh6smd+ygfvTG0QSWdoWUJbBUAmta/J8Nw5ZePnVcOdG4gEzyeQfyt3Rvb2TZPAuWt83XRq3Sy5x3HoEjNtFrn0UGYzAH81HZjY476lAkKRf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316114; c=relaxed/simple;
	bh=9r8g1P0KRezeixlLel8tuhLDSWaIysfnEaTUGqfAvHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACx/c+jR93SHSOUuyaW+3yux3UzNVsm6IWy2RJIrvThv17dPgzmVGOLQJDYy8DFDGooh3vNYglovVi6rKwpf/OIupbjeQ+VUw84noc/z+2/AXmXNPL2/4G3WFduDjVArdGO3QHUkgkuVxOnamkBage3CTVf1TEcPHTpjx5C4T+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLldBstO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLldBstO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C6B1F000E9;
	Wed, 20 May 2026 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779316112;
	bh=lG8SZvCLEpVwfSFRnLM/GKNN3U5RKrWB551Z0pGi/zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jLldBstOqWUT2LsJkvh4wETqh0FbWHIiggmLyC8S0FvW2FYZ26IwRTTE7DUmzrnB5
	 yAdhkT+qMEbmzH8n9IFGic0Ohek3MWIssZ56tYARmjrMxzkmWbUF0gFxN1pKxf6ZHF
	 qLx77GqPmoXuZh8ls3sWMaJgR0TnNZmp5+Yq2ca8+ss3CJD5G7MpjuAEuweS4kAaDG
	 Pg0wRxhKbGpyQOIf/FTSKRbvKfx1q09+HbTcWL408gE1yayU1IG45kxnX/GVysSWhj
	 XPvOzZ8LFU47R57aAwLpwhEVGdG618dNhFNaiQZvgekiJhPMRM1el7vva2JzaR613o
	 Bqr5m5y/ZR1pw==
Date: Thu, 21 May 2026 00:28:28 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Samir M <samir@linux.ibm.com>
Subject: Re: [PATCH -next v2 10/11] rcu: Latch normal synchronize_rcu() path
 on flood
Message-ID: <ag41jLKrDsKGCS_H@localhost.localdomain>
References: <20260519194524.158515-1-urezki@gmail.com>
 <20260519194524.158515-11-urezki@gmail.com>
 <ag3IhirNF-wlDE1W@localhost.localdomain>
 <ag3QQ7zWGMDx4MbV@milan>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag3QQ7zWGMDx4MbV@milan>

Le Wed, May 20, 2026 at 05:16:19PM +0200, Uladzislau Rezki a écrit :
> On Wed, May 20, 2026 at 04:43:18PM +0200, Frederic Weisbecker wrote:
> > Le Tue, May 19, 2026 at 09:45:23PM +0200, Uladzislau Rezki (Sony) a écrit :
> > > Currently, rcu_normal_wake_from_gp is only enabled by default
> > > on small systems(<= 16 CPUs) or when a user explicitly set it
> > > enabled.
> > > 
> > > Introduce an adaptive latching mechanism:
> > >  * Track the number of in-flight synchronize_rcu() requests
> > >    using a new rcu_sr_normal_count counter;
> > > 
> > >  * If the count reaches/exceeds RCU_SR_NORMAL_LATCH_THR(64),
> > >    it sets the rcu_sr_normal_latched, reverting new requests
> > >    onto the scaled wait_rcu_gp() path;
> > > 
> > >  * The latch is cleared only when the pending requests are fully
> > >    drained(nr == 0);
> > > 
> > >  * Enables rcu_normal_wake_from_gp by default for all systems,
> > >    relying on this dynamic throttling instead of static CPU
> > >    limits.
> > > 
> > > Testing(synthetic flood workload):
> > >   * Kernel version: 6.19.0-rc6
> > >   * Number of CPUs: 1536
> > >   * 60K concurrent synchronize_rcu() calls
> > > 
> > > Perf(cycles, system-wide):
> > >   total cycles: 932020263832
> > >   rcu_sr_normal_add_req(): 2650282811 cycles(~0.28%)
> > > 
> > > Perf report excerpt:
> > >   0.01%  0.01%  sync_test/...  [k] rcu_sr_normal_add_req
> > > 
> > > Measured overhead of rcu_sr_normal_add_req() remained ~0.28%
> > > of total CPU cycles in this synthetic stress test.
> > > 
> > > Tested-by: Samir M <samir@linux.ibm.com>
> > > Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         | 10 ++--
> > >  kernel/rcu/tree.c                             | 52 ++++++++++++++-----
> > >  2 files changed, 44 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 4d0f545fb3ec..d5db2e85d551 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -5862,13 +5862,13 @@ Kernel parameters
> > >  			use a call_rcu[_hurry]() path. Please note, this is for a
> > >  			normal grace period.
> > >  
> > > -			How to enable it:
> > > +			How to disable it:
> > >  
> > > -			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> > > -			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
> > > +			echo 0 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> > > +			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=0"
> > >  
> > > -			Default is 1 if num_possible_cpus() <= 16 and it is not explicitly
> > > -			disabled by the boot parameter passing 0.
> > > +			Default is 1 if it is not explicitly disabled by the boot parameter
> > > +			passing 0.
> > >  
> > >  	rcuscale.gp_async= [KNL]
> > >  			Measure performance of asynchronous
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 09f0cef5014c..94274330d1db 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1632,17 +1632,21 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
> > >  	atomic_set_release(&sr_wn->inuse, 0);
> > >  }
> > >  
> > > -/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> > > -#define WAKE_FROM_GP_CPU_THRESHOLD 16
> > > -
> > > -static int rcu_normal_wake_from_gp = -1;
> > > +static int rcu_normal_wake_from_gp = 1;
> > >  module_param(rcu_normal_wake_from_gp, int, 0644);
> > >  static struct workqueue_struct *sync_wq;
> > >  
> > > +#define RCU_SR_NORMAL_LATCH_THR 64
> > > +
> > > +/* Number of in-flight synchronize_rcu() calls queued on srs_next. */
> > > +static atomic_long_t rcu_sr_normal_count;
> > > +static int rcu_sr_normal_latched; /* 0/1 */
> > > +
> > >  static void rcu_sr_normal_complete(struct llist_node *node)
> > >  {
> > >  	struct rcu_synchronize *rs = container_of(
> > >  		(struct rcu_head *) node, struct rcu_synchronize, head);
> > > +	long nr;
> > >  
> > >  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> > >  		!poll_state_synchronize_rcu_full(&rs->oldstate),
> > > @@ -1650,6 +1654,15 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> > >  
> > >  	/* Finally. */
> > >  	complete(&rs->completion);
> > > +	nr = atomic_long_dec_return(&rcu_sr_normal_count);
> > > +	WARN_ON_ONCE(nr < 0);
> > > +
> > > +	/*
> > > +	 * Unlatch: switch back to normal path when fully
> > > +	 * drained and if it has been latched.
> > > +	 */
> > > +	if (nr == 0)
> > > +		(void)cmpxchg(&rcu_sr_normal_latched, 1, 0);
> > 
> > Given that it's already ordered by the llist add / del and the
> > atomic_long_inc/dec_return, there should be no chance for bad
> > things happening such as negative returned dec.
> > 
> > So it could be cmpxchg_relaxed(). But anyway, just an optimization.
> > 
> > In any case,
> > 
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> Hello, Frederic!
> 
> I change it accordingly, please check!
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 94274330d1db..2c76b59f75de 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1655,14 +1655,13 @@ static void rcu_sr_normal_complete(struct llist_node *node)
>  	/* Finally. */
>  	complete(&rs->completion);
>  	nr = atomic_long_dec_return(&rcu_sr_normal_count);
> -	WARN_ON_ONCE(nr < 0);

Why dropping this?

Otherwise yes, looks good!

Thanks!

>  
>  	/*
>  	 * Unlatch: switch back to normal path when fully
>  	 * drained and if it has been latched.
>  	 */
>  	if (nr == 0)
> -		(void)cmpxchg(&rcu_sr_normal_latched, 1, 0);
> +		(void)cmpxchg_relaxed(&rcu_sr_normal_latched, 1, 0);
>  }
>  
>  static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> @@ -1823,7 +1822,7 @@ static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
>  	 * because it only selects between the fast and fallback paths.
>  	 */
>  	if (nr == RCU_SR_NORMAL_LATCH_THR)
> -		(void)cmpxchg(&rcu_sr_normal_latched, 0, 1);
> +		(void)cmpxchg_relaxed(&rcu_sr_normal_latched, 0, 1);
>  
>  	/* Publish for the GP kthread/worker. */
>  	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> 
> Sounds good?
> 
> --
> Uladzislau Rezki
> 

-- 
Frederic Weisbecker
SUSE Labs
