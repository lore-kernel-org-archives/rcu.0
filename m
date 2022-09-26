Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7761FC07E9D
	for <rcu@archiver.kernel.org>; Mon, 26 Sep 2022 17:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIZRH6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiIZRHi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 26 Sep 2022 13:07:38 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C9257E13
        for <rcu@vger.kernel.org>; Mon, 26 Sep 2022 09:13:52 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i15so4600282qvp.5
        for <rcu@vger.kernel.org>; Mon, 26 Sep 2022 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/AjFX7DFxc6RANG8y4HX8sqPCzcPUj9Dv09coNHN82s=;
        b=c59E3ZEitNCXVu/giISkIeNGJd1xZ0QGmiDG7h86Sm3YXfRcLH9ykcmoDUMMsW7HHf
         GROZnfvujdhvfC+ViD865CCIEXCQq4eJ6ttME8WnLgdKdyNvAVrHQnBjT2LqnX2NTENu
         cboz0RsMMc+gVLTaLEqnzigVhrONXgwlROmUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/AjFX7DFxc6RANG8y4HX8sqPCzcPUj9Dv09coNHN82s=;
        b=KsnfxguTNS1JJb3KHTlH0eFErAbGDZwyqKaJdoPLzKSpE+YFSzvhnxA9idA4UJUA0W
         C0ta1ynq0pZyxZdMWxVg0ByP55T705BujDaoDB1JZiNAS6z3GYKCiDsN5N0SAx23/meu
         rxl3IdVfoYjEnfRf+Xi0N5deHBkSsJgN2le+Wk+83JWLdeuS4MDgM9XrPPgwUS+DEFh2
         T2GEYeGZyEHsrG1KX9GX2Wyg5miI4m8HgiLDKwsrk6bH2fIcy0HnjD4UJuJ3KxHHfcfG
         tPp77hJdJ55hsEF6J0c6dTv6N5MtdadNPD5N0URoHTKqC4hNK4oPd79XMKpxZuzVBaRT
         ucHg==
X-Gm-Message-State: ACrzQf2ul4JKFonPFSGwBwy4b1h3eEpAAZ7LDjja3Z7hF6MAlHNoCn9r
        y4hLeG3ivipMS/Kzc3E3Yx831Q==
X-Google-Smtp-Source: AMsMyM6ltMhExRWvjNLkCyapqK3Qw1bFGmH7InC1wL1hI3wxj/Blo1AhiNMMqUpGJZ+5WS3jYIOMTA==
X-Received: by 2002:ad4:5dee:0:b0:4ac:b757:ccd with SMTP id jn14-20020ad45dee000000b004acb7570ccdmr17461879qvb.76.1664208823489;
        Mon, 26 Sep 2022 09:13:43 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id bp36-20020a05620a45a400b006bb78d095c5sm11940782qkb.79.2022.09.26.09.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 09:13:43 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:13:42 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <YzHPthRZAr4xPXkq@google.com>
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
>  	return 0;
>  }
>  
> @@ -4020,17 +4026,20 @@ int rcutree_offline_cpu(unsigned int cpu)
>  	unsigned long flags;
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
> +	u8 dying;
>  
>  	rdp = per_cpu_ptr(&rcu_data, cpu);
>  	rnp = rdp->mynode;
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	rnp->ffmask &= ~rdp->grpmask;

Just to ensure the first increment sets the tick dep and the last decrement
resets it, it would be nice to add a check here:

WARN_ON_ONCE(!rnp->dying && tick_dep_test(TICK_DEP_BIT_RCU));

And correpondingly on the tick decrement:
WARN_ON_ONCE(rnp->dying > 0 && !tick_dep_test(TICK_DEP_BIT_RCU));

Of course that will require adding a new API: tick_dep_test, but might be
worth it.

(I think this should catch concurrency bugs such as involving the rnp lock
that Frederic pointed out).

thanks,

 - Joel



> +	/* Let rcutree_dead_cpu() know a new offlining. */
> +	dying = rnp->dying++;
> +	if (!dying)
> +		// nohz_full CPUs need the tick for stop-machine to work quickly
> +		tick_dep_set(TICK_DEP_BIT_RCU);



>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  
>  	rcutree_affinity_setting(cpu, cpu);
> -
> -	// nohz_full CPUs need the tick for stop-machine to work quickly
> -	tick_dep_set(TICK_DEP_BIT_RCU);
>  	return 0;
>  }
>  
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index d4a97e40ea9c..b508a12ac953 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -81,6 +81,7 @@ struct rcu_node {
>  	int	grphi;		/* highest-numbered CPU here. */
>  	u8	grpnum;		/* group number for next level up. */
>  	u8	level;		/* root is at level 0. */
> +	u8	dying;		/* num of concurrent rdp offlining */
>  	bool	wait_blkd_tasks;/* Necessary to wait for blocked tasks to */
>  				/*  exit RCU read-side critical sections */
>  				/*  before propagating offline up the */
> -- 
> 2.31.1
> 
