Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1A3C54EE9
	for <rcu@archiver.kernel.org>; Fri, 16 Sep 2022 13:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiIPNnE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Sep 2022 09:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIPNnD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Sep 2022 09:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED6AD987
        for <rcu@vger.kernel.org>; Fri, 16 Sep 2022 06:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF4B162BB7
        for <rcu@vger.kernel.org>; Fri, 16 Sep 2022 13:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A5AC433D6;
        Fri, 16 Sep 2022 13:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663335781;
        bh=CNdxcz5B1TyP8vHzOR7NNvl+ozER8xSgz1G3FKironw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AezXXRKa8XY/eYxUsIxB+8UuA70FJyebl1xG06kTpKmp13PknTnGh/Gt2q3G24oHI
         m2jZhcgij5ScN4PaUFZ+UjFxLxW2+dl55idtNe9XGz37+onIejNh7gKTq++qA0y0Vx
         Uv9IKqStdxuHkZacme0vmOk21afQSgY/8zkqVXtD8KOqCYyxGYZw3eWkMlg3M0dhxw
         v9O4jLOJFZKIuA7ACG1QKMqNhKtZ8uGGhuBTuwDBDJSy7nbI8+lt8HqhPfzNsazRCZ
         B+zctPvAbfx9f6Gl6cEMKfNdp5dA7xs7F0J9WJFXqh+sjh4LH+AUbRaXrOjuETHMul
         HklczEdLKzrDg==
Date:   Fri, 16 Sep 2022 15:42:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <20220916134258.GB25891@lothringen>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-4-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915055825.21525-4-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 15, 2022 at 01:58:25PM +0800, Pingfan Liu wrote:
> As Paul pointed out  "The tick_dep_clear() is SMP-safe because it uses
> atomic operations, but the problem is that if there are multiple
> nohz_full CPUs going offline concurrently, the first CPU to invoke
> rcutree_dead_cpu() will turn the tick off.  This might require an
> atomically manipulated counter to mediate the calls to
> rcutree_dead_cpu(). "
> 
> This patch introduces a new member ->dying to rcu_node, which reflects
> the number of concurrent offlining cpu. TICK_DEP_BIT_RCU is set by
> the first entrance and cleared by the last.
> 
> Note: now, tick_dep_set() is put under the rnp->lock, but since it takes
> no lock, no extra locking order is introduced.
> 
> Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> To: rcu@vger.kernel.org
> ---
>  kernel/rcu/tree.c | 19 ++++++++++++++-----
>  kernel/rcu/tree.h |  1 +
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8a829b64f5b2..f8bd0fc5fd2f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2164,13 +2164,19 @@ int rcutree_dead_cpu(unsigned int cpu)
>  {
>  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> +	unsigned long flags;
> +	u8 dying;
>  
>  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
>  		return 0;
>  
>  	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> -	// Stop-machine done, so allow nohz_full to disable tick.
> -	tick_dep_clear(TICK_DEP_BIT_RCU);
> +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> +	dying = --rnp->dying;
> +	if (!dying)
> +		// Stop-machine done, so allow nohz_full to disable tick.
> +		tick_dep_clear(TICK_DEP_BIT_RCU);
> +	raw_spin_lock_irqsave_rcu_node(rnp, flags);

Note this is only locking the rdp's node, not the root node.
Therefore if CPU 0 and CPU 256 are going off at the same time and they
don't belong to the same node, the above won't protect against concurrent
TICK_DEP_BIT_RCU set/clear.

My suspicion is that we don't need this TICK_DEP_BIT_RCU tick dependency
anymore. I believe it was there because of issues that were fixed with:

	53e87e3cdc15 (timers/nohz: Last resort update jiffies on nohz_full IRQ entry)
and:

	a1ff03cd6fb9 (tick: Detect and fix jiffies update stall)

It's unfortunately just suspicion because the reason for that tick dependency
is unclear but I believe it should be safe to remove now.

Thanks.
