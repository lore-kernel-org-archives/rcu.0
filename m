Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87638C433EF
	for <rcu@archiver.kernel.org>; Mon, 25 Oct 2021 03:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BEC61029
	for <rcu@archiver.kernel.org>; Mon, 25 Oct 2021 03:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhJYDdA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 24 Oct 2021 23:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232157AbhJYDc7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 24 Oct 2021 23:32:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2427360EFF;
        Mon, 25 Oct 2021 03:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635132638;
        bh=w1lPpVCCdQJlo9jF7fizY5+EutttgqxX8wF5/HIvh0s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sQc0PTtCiqylj40xkLrL1f6lc0mgEGZhi0PFPKajtDB7YLqIXKaKbRPgczxMvOIo8
         Fzwld9k/u2QVQMu5p3prlOu79Qu/ZMk8auOyICt1a1a6BR+UjawO4eRd6SJjHRaLi1
         GnFazr1mQJETE+b6imV5Ji8iG1n5LYbK6HUwzvOt4ybXG4z4Swb5WCdIShgBWX0eWM
         I6FbccyVX4d0pVNS7axYscsrbQ4/VQpRvL/I0U+qt3sdOBCx1dPt4yeRmobNPwT88B
         3Mil7O/qJ5idIitmJSr4Yqp4g1D2kul9002zELUJSALLnbWKcePjgC5t4MOZXkmD3r
         41RtvDk9Aj6Rg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8C0FE5C0BF4; Sun, 24 Oct 2021 20:30:37 -0700 (PDT)
Date:   Sun, 24 Oct 2021 20:30:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Improve tree_plugin.h comments and add code cleanups
Message-ID: <20211025033037.GO880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211024003634.8017-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024003634.8017-1-zhouzhouyi@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Oct 24, 2021 at 08:36:34AM +0800, Zhouyi Zhou wrote:
> This commit cleans up some comments and code in kernel/rcu/tree_plugin.h.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
> Hi Paul,
> 
> I perform some comments and code cleans up in kernel/rcu/tree_plugin.h
> while learning RCU.

Good eyes, queued and pushed, thank you!

A couple of comments below.

							Thanx, Paul

> Thanks
> Zhouyi
> --
>  kernel/rcu/tree_plugin.h | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index d070059163d7..dde7fa17ae2b 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -16,7 +16,7 @@
>  static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>  {
>  	/*
> -	 * In order to read the offloaded state of an rdp is a safe
> +	 * In order to read the offloaded state of an rdp in a safe
>  	 * and stable way and prevent from its value to be changed
>  	 * under us, we must either hold the barrier mutex, the cpu
>  	 * hotplug lock (read or write) or the nocb lock. Local
> @@ -56,7 +56,7 @@ static void __init rcu_bootup_announce_oddness(void)
>  	if (IS_ENABLED(CONFIG_PROVE_RCU))
>  		pr_info("\tRCU lockdep checking is enabled.\n");
>  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> -		pr_info("\tRCU strict (and thus non-scalable) grace periods enabled.\n");
> +		pr_info("\tRCU strict (and thus non-scalable) grace periods are enabled.\n");

Although the original is a correct abbreviation by common usage (witness
"Hyperdrive module enabled!" in some science fiction movies or similar),
it certainly does not hurt to move towards standard usage.  So I took
this change.

>  	if (RCU_NUM_LVLS >= 4)
>  		pr_info("\tFour(or more)-level hierarchy is enabled.\n");
>  	if (RCU_FANOUT_LEAF != 16)
> @@ -88,13 +88,13 @@ static void __init rcu_bootup_announce_oddness(void)
>  	if (rcu_kick_kthreads)
>  		pr_info("\tKick kthreads if too-long grace period.\n");
>  	if (IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD))
> -		pr_info("\tRCU callback double-/use-after-free debug enabled.\n");
> +		pr_info("\tRCU callback double-/use-after-free debug is enabled.\n");

And same here.

>  	if (gp_preinit_delay)
>  		pr_info("\tRCU debug GP pre-init slowdown %d jiffies.\n", gp_preinit_delay);
>  	if (gp_init_delay)
>  		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
>  	if (gp_cleanup_delay)
> -		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_cleanup_delay);
> +		pr_info("\tRCU debug GP cleanup slowdown %d jiffies.\n", gp_cleanup_delay);
>  	if (!use_softirq)
>  		pr_info("\tRCU_SOFTIRQ processing moved to rcuc kthreads.\n");
>  	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
> @@ -1154,7 +1154,6 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
>  /*
>   * Create an RCU-boost kthread for the specified node if one does not
>   * already exist.  We only create this kthread for preemptible RCU.
> - * Returns zero if all is well, a negated errno otherwise.
>   */
>  static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>  {
> @@ -1456,7 +1455,7 @@ static void rcu_cleanup_after_idle(void)
>   * CPU unless the grace period has extended for too long.
>   *
>   * This code relies on the fact that all NO_HZ_FULL CPUs are also
> - * CONFIG_RCU_NOCB_CPU CPUs.
> + * RCU_NOCB_CPU CPUs.
>   */
>  static bool rcu_nohz_full_cpu(void)
>  {
> -- 
> 2.25.1
> 
