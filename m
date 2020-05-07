Return-Path: <SRS0=FT7R=6V=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E77C28CBC
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 00:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3F320736
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 00:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588812938;
	bh=uM6sr/bKulgUggqODetgoJpXNbXWgWEfpWFV4GW35ww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=U2xQaj5+V7uhRqc8HqzchveZUVyTmuczXQczVRiktyMNkB16UknF9OSvmAOH17X/4
	 eYi9bA40jMb/pugu3vFiH04DIQQZ1P2Ij3VEolItQAD+OQJ/+IHF1jaimszBFRGGc9
	 iWgwmqVTen9yNf0hgALu7OhCh/r4YlXCcXBihRek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgEGAzi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 May 2020 20:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgEGAzh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 May 2020 20:55:37 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42CAC20708;
        Thu,  7 May 2020 00:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588812936;
        bh=uM6sr/bKulgUggqODetgoJpXNbXWgWEfpWFV4GW35ww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J7DIjsyLvHBZ5eSTEHsBWIEAhMZXO8kVMwLGiArFkneC72whGLjPeNYwS6NdaQBpi
         KOZ7ng1w2EAvKLDd+tOAKE1S6SF5sSceRA+L0y5y8AVBFunPSNSOFu1NCGBrBQRfv6
         5HoM2fkTFTG0/agaQl4J3b2D3DEnsTN1CTwjVGAk=
Date:   Wed, 6 May 2020 17:55:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH RFC tip/core/rcu] Add shrinker to shift to
 fast/inefficient GP mode
Message-Id: <20200506175535.d4986a4d497071a410b69765@linux-foundation.org>
In-Reply-To: <20200507004240.GA9156@paulmck-ThinkPad-P72>
References: <20200507004240.GA9156@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 6 May 2020 17:42:40 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> This commit adds a shrinker so as to inform RCU when memory is scarce.
> RCU responds by shifting into the same fast and inefficient mode that is
> used in the presence of excessive numbers of RCU callbacks.  RCU remains
> in this state for one-tenth of a second, though this time window can be
> extended by another call to the shrinker.
> 
> If it proves feasible, a later commit might add a function call directly
> indicating the end of the period of scarce memory.

(Cc David Chinner, who often has opinions on shrinkers ;))

It's a bit abusive of the intent of the slab shrinkers, but I don't
immediately see a problem with it.  Always returning 0 from
->scan_objects might cause a problem in some situations(?).

Perhaps we should have a formal "system getting low on memory, please
do something" notification API.

How significant is this?  How much memory can RCU consume?

> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2368,8 +2368,15 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
>  
> -	rcu_state.cbovld = rcu_state.cbovldnext;
> +	// Load .oomovld before .oomovldend, pairing with .oomovld set.
> +	rcu_state.cbovld = smp_load_acquire(&rcu_state.oomovld) || // ^^^
> +			   rcu_state.cbovldnext;
>  	rcu_state.cbovldnext = false;
> +	if (READ_ONCE(rcu_state.oomovld) &&
> +	    time_after(jiffies, READ_ONCE(rcu_state.oomovldend))) {
> +		WRITE_ONCE(rcu_state.oomovld, false);
> +		pr_info("%s: Ending OOM-mode grace periods.\n", __func__);
> +	}
>  	rcu_for_each_leaf_node(rnp) {
>  		cond_resched_tasks_rcu_qs();
>  		mask = 0;
> @@ -2697,6 +2704,35 @@ static void check_cb_ovld(struct rcu_data *rdp)
>  	raw_spin_unlock_rcu_node(rnp);
>  }
>  
> +/* Return a rough count of the RCU callbacks outstanding. */
> +static unsigned long rcu_oom_count(struct shrinker *unused1,
> +				   struct shrink_control *unused2)
> +{
> +	int cpu;
> +	unsigned long ncbs = 0;
> +
> +	for_each_possible_cpu(cpu)
> +		ncbs += rcu_get_n_cbs_cpu(cpu);
> +	return ncbs;
> +}
> +
> +/* Start up an interval of fast high-overhead grace periods. */
> +static unsigned long rcu_oom_scan(struct shrinker *unused1,
> +				  struct shrink_control *unused2)
> +{
> +	pr_info("%s: Starting OOM-mode grace periods.\n", __func__);
> +	WRITE_ONCE(rcu_state.oomovldend, jiffies + HZ / 10);
> +	smp_store_release(&rcu_state.oomovld, true); // After .oomovldend
> +	rcu_force_quiescent_state();  // Kick grace period
> +	return 0;  // We haven't actually reclaimed anything yet.
> +}
> +
> +static struct shrinker rcu_shrinker = {
> +	.count_objects = rcu_oom_count,
> +	.scan_objects = rcu_oom_scan,
> +	.seeks = DEFAULT_SEEKS,
> +};
> +
>  /* Helper function for call_rcu() and friends.  */
>  static void
>  __call_rcu(struct rcu_head *head, rcu_callback_t func)
> @@ -4146,6 +4182,7 @@ void __init rcu_init(void)
>  		qovld_calc = DEFAULT_RCU_QOVLD_MULT * qhimark;
>  	else
>  		qovld_calc = qovld;
> +	WARN_ON(register_shrinker(&rcu_shrinker));
>  }
>  
>  #include "tree_stall.h"
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 2d7fcb9..c4d8e96 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -326,6 +326,8 @@ struct rcu_state {
>  	int ncpus_snap;				/* # CPUs seen last time. */
>  	u8 cbovld;				/* Callback overload now? */
>  	u8 cbovldnext;				/* ^        ^  next time? */
> +	u8 oomovld;				/* OOM overload? */
> +	unsigned long oomovldend;		/* OOM ovld end, jiffies. */
>  
>  	unsigned long jiffies_force_qs;		/* Time at which to invoke */
>  						/*  force_quiescent_state(). */
