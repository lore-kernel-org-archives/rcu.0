Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31CAC433EF
	for <rcu@archiver.kernel.org>; Fri, 13 May 2022 00:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbiEMAQZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 20:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359172AbiEMAQY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 20:16:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA3A4FC76
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 17:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1847362097
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 00:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AB1C385B8;
        Fri, 13 May 2022 00:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652400982;
        bh=4KJTmceKNZnl2JDVf0Yp2kcvX0hp3uXG+h7t2UXi47g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FZc8Mqjl9bzWMqe3o9pHZUmMC/tdDlDuNGUG527WE2RrTSeR1zDcaOcPP/qKCkitv
         qmp8jH2Wog5l43kcMhptcF0eJqZF1ugM7Hor83dwttXsqG5V6XglYG2DGXab56A8Cl
         8e2Ady26qbVKvxvKYDpcqN0j67MsfKuuIsPtWs3xIIbHO9K62kYwKjrxMqSHEqlMcQ
         O82e3+uezj0A+F4WX5peS3IyO8tsqK3NqhlQ1plmNdKSIyU/GphxyacDQMoizmlG3D
         FcnPlM83dId+iD04HkuKqUE4GLNQ2/dwwnMNbGnIr9djT15JRhkPbhdI+W1PevT24J
         3jH+3pfX8gaZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0FDEC5C051B; Thu, 12 May 2022 17:16:22 -0700 (PDT)
Date:   Thu, 12 May 2022 17:16:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 14/14] DEBUG: Toggle rcu_lazy and tune at runtime
Message-ID: <20220513001622.GA1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-15-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512030442.2530552-15-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 03:04:42AM +0000, Joel Fernandes (Google) wrote:
> Add sysctl knobs just for easier debugging/testing, to tune the maximum
> batch size, maximum time to wait before flush, and turning off the
> feature entirely.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

This is good, and might also be needed longer term.

One thought below.

							Thanx, Paul

> ---
>  include/linux/sched/sysctl.h |  4 ++++
>  kernel/rcu/lazy.c            | 12 ++++++++++--
>  kernel/sysctl.c              | 23 +++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index c19dd5a2c05c..55ffc61beed1 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -16,6 +16,10 @@ enum { sysctl_hung_task_timeout_secs = 0 };
>  
>  extern unsigned int sysctl_sched_child_runs_first;
>  
> +extern unsigned int sysctl_rcu_lazy;
> +extern unsigned int sysctl_rcu_lazy_batch;
> +extern unsigned int sysctl_rcu_lazy_jiffies;
> +
>  enum sched_tunable_scaling {
>  	SCHED_TUNABLESCALING_NONE,
>  	SCHED_TUNABLESCALING_LOG,
> diff --git a/kernel/rcu/lazy.c b/kernel/rcu/lazy.c
> index 55e406cfc528..0af9fb67c92b 100644
> --- a/kernel/rcu/lazy.c
> +++ b/kernel/rcu/lazy.c
> @@ -12,6 +12,10 @@
>  // How much to wait before flushing?
>  #define MAX_LAZY_JIFFIES	10000
>  
> +unsigned int sysctl_rcu_lazy_batch = MAX_LAZY_BATCH;
> +unsigned int sysctl_rcu_lazy_jiffies = MAX_LAZY_JIFFIES;
> +unsigned int sysctl_rcu_lazy = 1;
> +
>  // We cast lazy_rcu_head to rcu_head and back. This keeps the API simple while
>  // allowing us to use lockless list node in the head. Also, we use BUILD_BUG_ON
>  // later to ensure that rcu_head and lazy_rcu_head are of the same size.
> @@ -49,6 +53,10 @@ void call_rcu_lazy(struct rcu_head *head_rcu, rcu_callback_t func)
>  	struct lazy_rcu_head *head = (struct lazy_rcu_head *)head_rcu;
>  	struct rcu_lazy_pcp *rlp;
>  
> +	if (!sysctl_rcu_lazy) {

This is the place to check for early boot use.  Or, alternatively,
initialize sysctl_rcu_lazy to zero and set it to one once boot is far
enough along to allow all the pieces to work reasonably.

> +		return call_rcu(head_rcu, func);
> +	}
> +
>  	preempt_disable();
>          rlp = this_cpu_ptr(&rcu_lazy_pcp_ins);
>  	preempt_enable();
> @@ -67,11 +75,11 @@ void call_rcu_lazy(struct rcu_head *head_rcu, rcu_callback_t func)
>  	llist_add(&head->llist_node, &rlp->head);
>  
>  	// Flush queue if too big
> -	if (atomic_inc_return(&rlp->count) >= MAX_LAZY_BATCH) {
> +	if (atomic_inc_return(&rlp->count) >= sysctl_rcu_lazy_batch) {
>  		lazy_rcu_flush_cpu(rlp);
>  	} else {
>  		if (!delayed_work_pending(&rlp->work)) {
> -			schedule_delayed_work(&rlp->work, MAX_LAZY_JIFFIES);
> +			schedule_delayed_work(&rlp->work, sysctl_rcu_lazy_jiffies);
>  		}
>  	}
>  }
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 5ae443b2882e..2ba830ca71ec 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1659,6 +1659,29 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> +#ifdef CONFIG_RCU_LAZY
> +	{
> +		.procname	= "rcu_lazy",
> +		.data		= &sysctl_rcu_lazy,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +	{
> +		.procname	= "rcu_lazy_batch",
> +		.data		= &sysctl_rcu_lazy_batch,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +	{
> +		.procname	= "rcu_lazy_jiffies",
> +		.data		= &sysctl_rcu_lazy_jiffies,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +#endif
>  #ifdef CONFIG_SCHEDSTATS
>  	{
>  		.procname	= "sched_schedstats",
> -- 
> 2.36.0.550.gb090851708-goog
> 
