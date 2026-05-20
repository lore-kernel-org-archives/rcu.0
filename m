Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A0E3DCD9D;
	Wed, 20 May 2026 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288203; cv=none; b=pF61YtsusUvKqg3u+lYAcfPtnsk0GMjHbLPvZRCfnAC5FmxZZKg5xhMW6y2hhYO9BQbYA/gWv3vR4rplPKy6zu0U9Tms8DilKNbIqOtLeFqkTx6jyn/ibzpvIMcaGjlPWuQjDNOZoViI8kghUXGI+5zAG8UwkDIyoGXc0JgvtLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288203; c=relaxed/simple;
	bh=D8HD8Lem4Se0C31SwTDDqZ0OCuWfqxTvRyJnkm3IVKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIUwhtLqwh9SbagfPUFCwJc24kLn+sbYMak5n2R8D2GoSLZmj0D1S63rHtokpoI8L4NQw+nK+EHyK7u3gKQVXL5vz5ddJPVDZMbbdY9/U8b+dorvutLACrIO4h2gWeipz5j3tZQqACMv/E+A9UvOzqg1YeG3yQpHJch6L7O2HiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv03CcmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv03CcmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6252A1F00894;
	Wed, 20 May 2026 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779288202;
	bh=UOTYauFVfeGw+Nb9Ia/Mgv+pKEUxmvCJBbwAkhbOWRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uv03CcmX9i5e0Eb05L/0vCojgww/YE0H++jqSH/itUbtl3YoAovTvMtcSs+1chmFD
	 J8cYObJoPzOn+20j3pr9IMrPiiNgesGUAEZb+yTW+1YuvnhmPsdMydwmUU8oJJjIjY
	 p2vhfGnrwkDlpsQku3DhkFFPzKMWXNFHvqKgOZPGovVSWWVIWyGraSsUONcoIgAjNb
	 E6ftYCAKzLRRXwTv7zfA9t9TDUmKvbC+rX0mmZesL/wi/20jstwF7Vei0teSAIZOc3
	 5Ro2BKdl/IegR23rOboXxqDcBnbGyOrIX07stSDXvLZGa/ZmQT2IO5/f5R/rHsJJ+s
	 upi0TrGewfSLQ==
Date: Wed, 20 May 2026 16:43:18 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Samir M <samir@linux.ibm.com>
Subject: Re: [PATCH -next v2 10/11] rcu: Latch normal synchronize_rcu() path
 on flood
Message-ID: <ag3IhirNF-wlDE1W@localhost.localdomain>
References: <20260519194524.158515-1-urezki@gmail.com>
 <20260519194524.158515-11-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519194524.158515-11-urezki@gmail.com>

Le Tue, May 19, 2026 at 09:45:23PM +0200, Uladzislau Rezki (Sony) a écrit :
> Currently, rcu_normal_wake_from_gp is only enabled by default
> on small systems(<= 16 CPUs) or when a user explicitly set it
> enabled.
> 
> Introduce an adaptive latching mechanism:
>  * Track the number of in-flight synchronize_rcu() requests
>    using a new rcu_sr_normal_count counter;
> 
>  * If the count reaches/exceeds RCU_SR_NORMAL_LATCH_THR(64),
>    it sets the rcu_sr_normal_latched, reverting new requests
>    onto the scaled wait_rcu_gp() path;
> 
>  * The latch is cleared only when the pending requests are fully
>    drained(nr == 0);
> 
>  * Enables rcu_normal_wake_from_gp by default for all systems,
>    relying on this dynamic throttling instead of static CPU
>    limits.
> 
> Testing(synthetic flood workload):
>   * Kernel version: 6.19.0-rc6
>   * Number of CPUs: 1536
>   * 60K concurrent synchronize_rcu() calls
> 
> Perf(cycles, system-wide):
>   total cycles: 932020263832
>   rcu_sr_normal_add_req(): 2650282811 cycles(~0.28%)
> 
> Perf report excerpt:
>   0.01%  0.01%  sync_test/...  [k] rcu_sr_normal_add_req
> 
> Measured overhead of rcu_sr_normal_add_req() remained ~0.28%
> of total CPU cycles in this synthetic stress test.
> 
> Tested-by: Samir M <samir@linux.ibm.com>
> Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 10 ++--
>  kernel/rcu/tree.c                             | 52 ++++++++++++++-----
>  2 files changed, 44 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4d0f545fb3ec..d5db2e85d551 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5862,13 +5862,13 @@ Kernel parameters
>  			use a call_rcu[_hurry]() path. Please note, this is for a
>  			normal grace period.
>  
> -			How to enable it:
> +			How to disable it:
>  
> -			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> -			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
> +			echo 0 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> +			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=0"
>  
> -			Default is 1 if num_possible_cpus() <= 16 and it is not explicitly
> -			disabled by the boot parameter passing 0.
> +			Default is 1 if it is not explicitly disabled by the boot parameter
> +			passing 0.
>  
>  	rcuscale.gp_async= [KNL]
>  			Measure performance of asynchronous
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 09f0cef5014c..94274330d1db 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1632,17 +1632,21 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
>  	atomic_set_release(&sr_wn->inuse, 0);
>  }
>  
> -/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> -#define WAKE_FROM_GP_CPU_THRESHOLD 16
> -
> -static int rcu_normal_wake_from_gp = -1;
> +static int rcu_normal_wake_from_gp = 1;
>  module_param(rcu_normal_wake_from_gp, int, 0644);
>  static struct workqueue_struct *sync_wq;
>  
> +#define RCU_SR_NORMAL_LATCH_THR 64
> +
> +/* Number of in-flight synchronize_rcu() calls queued on srs_next. */
> +static atomic_long_t rcu_sr_normal_count;
> +static int rcu_sr_normal_latched; /* 0/1 */
> +
>  static void rcu_sr_normal_complete(struct llist_node *node)
>  {
>  	struct rcu_synchronize *rs = container_of(
>  		(struct rcu_head *) node, struct rcu_synchronize, head);
> +	long nr;
>  
>  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
>  		!poll_state_synchronize_rcu_full(&rs->oldstate),
> @@ -1650,6 +1654,15 @@ static void rcu_sr_normal_complete(struct llist_node *node)
>  
>  	/* Finally. */
>  	complete(&rs->completion);
> +	nr = atomic_long_dec_return(&rcu_sr_normal_count);
> +	WARN_ON_ONCE(nr < 0);
> +
> +	/*
> +	 * Unlatch: switch back to normal path when fully
> +	 * drained and if it has been latched.
> +	 */
> +	if (nr == 0)
> +		(void)cmpxchg(&rcu_sr_normal_latched, 1, 0);

Given that it's already ordered by the llist add / del and the
atomic_long_inc/dec_return, there should be no chance for bad
things happening such as negative returned dec.

So it could be cmpxchg_relaxed(). But anyway, just an optimization.

In any case,

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
