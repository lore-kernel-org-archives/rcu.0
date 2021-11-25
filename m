Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0379FC433EF
	for <rcu@archiver.kernel.org>; Thu, 25 Nov 2021 00:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345818AbhKYAfh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 19:35:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353254AbhKYAdh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 19:33:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08336610A1;
        Thu, 25 Nov 2021 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637800227;
        bh=K1pqvi8+0Zb+ovV0NRF5pJj40cbHS21w9/SxAzRAl9Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WNCUc7WEmj++gzQzRXABZ3hB1OT2/P7VmyJxowiDhOZPiRcS+HyHYE8l9zARUGFep
         KjNX5Wl26XjuL0tclIb9N+ZK62GZehJNsDzoyc+2fHRL30KFn4ldM9Jpp3Sk3+o8Kb
         mZ4+bcQ5c/3bMB+QA1ayuMarRGSKYwWJ9ShxwsOHgyDNd1JLDiGaueKU55ZkUpQnYL
         fTA3wDHXqgAfFhAkp2B0GyLfpMea1uIbGzvVzEhFqYktVQxHu6LTi16fzRKtpUL68a
         UlUE/ebmYgZv4dziq9GaSUGUj8jX4bTxv6DrGuy3S/euu4X44pt56wENjNaiQq4J+4
         59WzOVRU8oXHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CE1555C0A31; Wed, 24 Nov 2021 16:30:26 -0800 (PST)
Date:   Wed, 24 Nov 2021 16:30:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/6] rcu/nocb: Optimize kthreads and rdp initialization
Message-ID: <20211125003026.GT641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123003708.468409-4-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 23, 2021 at 01:37:05AM +0100, Frederic Weisbecker wrote:
> Currently cpumask_available() is used to prevent from unwanted
> NOCB initialization. However if neither "rcu_nocbs=" nor "nohz_full="
> parameters are passed but CONFIG_CPUMASK_OFFSTACK=n, the initialization
> path is still taken, running through all sorts of needless operations
> and iterations on an empty cpumask.
> 
> Fix this with relying on a real initialization state instead. This
> also optimize kthreads creation, sparing iteration over all online CPUs
> when nocb isn't initialized.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_nocb.h | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index e1cb06840454..d8ed3ee47a67 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -60,6 +60,9 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
>   * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
>   * If the list is invalid, a warning is emitted and all CPUs are offloaded.
>   */
> +
> +static bool rcu_nocb_is_setup;

I am taking this as is for now (modulo wordsmithing), but should this
variable instead be in the rcu_state structure?  The advantage of putting
it there is keeping the state together.  The corresponding disadvantage
is that the state is globally visible within RCU.

Thoughts?

							Thanx, Paul

> +
>  static int __init rcu_nocb_setup(char *str)
>  {
>  	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
> @@ -67,6 +70,7 @@ static int __init rcu_nocb_setup(char *str)
>  		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
>  		cpumask_setall(rcu_nocb_mask);
>  	}
> +	rcu_nocb_is_setup = true;
>  	return 1;
>  }
>  __setup("rcu_nocbs=", rcu_nocb_setup);
> @@ -1159,13 +1163,17 @@ void __init rcu_init_nohz(void)
>  		need_rcu_nocb_mask = true;
>  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>  
> -	if (!cpumask_available(rcu_nocb_mask) && need_rcu_nocb_mask) {
> -		if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
> -			pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
> -			return;
> +	if (need_rcu_nocb_mask) {
> +		if (!cpumask_available(rcu_nocb_mask)) {
> +			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
> +				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
> +				return;
> +			}
>  		}
> +		rcu_nocb_is_setup = true;
>  	}
> -	if (!cpumask_available(rcu_nocb_mask))
> +
> +	if (!rcu_nocb_is_setup)
>  		return;
>  
>  #if defined(CONFIG_NO_HZ_FULL)
> @@ -1267,8 +1275,10 @@ static void __init rcu_spawn_nocb_kthreads(void)
>  {
>  	int cpu;
>  
> -	for_each_online_cpu(cpu)
> -		rcu_spawn_cpu_nocb_kthread(cpu);
> +	if (rcu_nocb_is_setup) {
> +		for_each_online_cpu(cpu)
> +			rcu_spawn_cpu_nocb_kthread(cpu);
> +	}
>  }
>  
>  /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
> -- 
> 2.25.1
> 
