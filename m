Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69286C433EF
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 19:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503E961BB6
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 19:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbhKQTaK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhKQTaJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 14:30:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C72261BCF;
        Wed, 17 Nov 2021 19:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637177230;
        bh=LusFKQEXH9iY71gVcbD7MmvlsxPhY9nqA9hAXRWvv7E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KfkuSvA4ZIuPAA+HJzc0NJhitCYtVHlDogAED+HCE4CNCFPWsVFEfLjoCGyeq/soj
         FlOJfWy78ifKdGjYgw08pMkUBZ3wmwZPEPMs0lWg02ocat24XLyZTUWgNqVXP1eV0z
         qpe+5iEtg6jGRNZd0XPW2lrg6K5j1xxzDYKM3ooEqc731gU7bpbm4PNamYK2u8K2mX
         SQAfCeSLQyRB2Yvo88jwDKWEkgv4QFm07VrHEFmLTjfXXhoBFhi+66olGq1vGsVk+y
         FyKs3ZYpaT/xr0MTRmVofKJzLX+e5VXo7+lu+mNrUMKVwakbI16x5GDPqkQI4+jNEK
         vGFvmkK4Bs07A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4564F5C06BA; Wed, 17 Nov 2021 11:27:10 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:27:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 4/6] rcu/nocb: Create nocb kthreads on all CPUs as long
 as the "rcu_nocb=" is passed
Message-ID: <20211117192710.GK641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211117155637.363706-1-frederic@kernel.org>
 <20211117155637.363706-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117155637.363706-5-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 17, 2021 at 04:56:35PM +0100, Frederic Weisbecker wrote:
> In order to be able to (de-)offload any CPU using cpuset in the future,
> create a NOCB kthread for all possible CPUs. For now this is done only
> as long as the "rcu_nocb=" kernel parameter is passed to avoid
> the unnecessary overhead for most users.

The "nohz_full=" kernel parameter would also cause these kthreads to
be created, correct?  (Yeah, a nit, but...)

And some fallout of my forgetfulness below.  :-/

							Thanx, Paul

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_nocb.h | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 9fe4be10fde7..1871f15b8472 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1221,11 +1221,8 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
>  	struct rcu_data *rdp_gp;
>  	struct task_struct *t;
>  
> -	/*
> -	 * If this isn't a no-CBs CPU or if it already has an rcuo kthread,
> -	 * then nothing to do.
> -	 */
> -	if (!rcu_is_nocb_cpu(cpu) || rdp->nocb_cb_kthread)
> +	/* If it already has an rcuo kthread, then nothing to do. */
> +	if (rdp->nocb_cb_kthread)
>  		return;
>  
>  	/* If we didn't spawn the GP kthread first, reorganize! */
> @@ -1253,7 +1250,7 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
>   */
>  static void rcu_spawn_cpu_nocb_kthread(int cpu)
>  {
> -	if (rcu_scheduler_fully_active)
> +	if (rcu_scheduler_fully_active && rcu_nocb_is_setup)
>  		rcu_spawn_one_nocb_kthread(cpu);
>  }
>  
> @@ -1268,7 +1265,7 @@ static void __init rcu_spawn_nocb_kthreads(void)
>  	int cpu;
>  
>  	if (rcu_nocb_is_setup) {
> -		for_each_online_cpu(cpu)
> +		for_each_possible_cpu(cpu)

Gah...  I had forgotten.  :-/

Some firmware lies about the OS instance's age.  Other firmware lies
about the number of CPUs, sometimes claiming large multiples of the
actual number of CPUs.

So this needs to stay "for_each_online_cpu".  Otherwise, Paul Gortmaker
will once again be afflicted with hundreds of unnecessary rcuo kthreads.

The later calls to rcutree_prepare_cpu() from rcutree_prepare_cpu()
will take care of any CPUs that first come online later.

Apologies for my earlier forgetfulness!!!

>  			rcu_spawn_cpu_nocb_kthread(cpu);
>  	}
>  }
> @@ -1303,7 +1300,7 @@ static void __init rcu_organize_nocb_kthreads(void)
>  	 * Should the corresponding CPU come online in the future, then
>  	 * we will spawn the needed set of rcu_nocb_kthread() kthreads.
>  	 */
> -	for_each_cpu(cpu, rcu_nocb_mask) {
> +	for_each_possible_cpu(cpu) {

This needs to change, but to for_each_online_cpu() instead of
for_each_possible_cpu().  That handles the case where the boot CPU is
not initially offloaded, but where the sysadm later needs to offload it.

>  		rdp = per_cpu_ptr(&rcu_data, cpu);
>  		if (rdp->cpu >= nl) {
>  			/* New GP kthread, set up for CBs & next GP. */
> @@ -1327,7 +1324,8 @@ static void __init rcu_organize_nocb_kthreads(void)
>  				pr_cont(" %d", cpu);
>  		}
>  		rdp->nocb_gp_rdp = rdp_gp;
> -		list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
> +		if (cpumask_test_cpu(cpu, rcu_nocb_mask))
> +			list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
>  	}
>  	if (gotnocbs && dump_tree)
>  		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
> -- 
> 2.25.1
> 
