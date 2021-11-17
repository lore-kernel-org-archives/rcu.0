Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B997C433F5
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE95761B73
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 18:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhKQS4l (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 13:56:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230399AbhKQS4k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 13:56:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B896061465;
        Wed, 17 Nov 2021 18:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637175221;
        bh=hHg2mvvZWgKOJIbLi4SOlEfaOk8yvWOaga7XEOvqvsg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RlD2pQdpnlErvuZK//1W6jUh1Jopwfm8fe33r2GW9det2gMRw57mVLAUeGd6MBCSj
         gSJxKmU/g90qWelkPzTvA9/3qBVeg0NjGH8oP/Rw/18/IiftF4R/RD8KA0XkgT7XH0
         ZHk6YYPhvL2IHhjYISD9ctERHqoD3Y3So7f3/UjHUaBCCZc9XiKGMCFMc7ScpxkErm
         Nhz+0ryGEKIe8RqBTU9s0pMbp0HsyZ1aXHlWUevwpeaPOCprjCIKaqSo5c/uMy67pH
         kHIRcELWgVkY+nn86zc4hZfzZ5TUF6pBLLaqE8Hr6MiZ80eoDU5SwadtxsVyM1RNYQ
         GXVwCt9x7vtDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 879835C04B0; Wed, 17 Nov 2021 10:53:41 -0800 (PST)
Date:   Wed, 17 Nov 2021 10:53:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 1/6] rcu/nocb: Remove rdp from nocb list when de-offloaded
Message-ID: <20211117185341.GJ641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211117155637.363706-1-frederic@kernel.org>
 <20211117155637.363706-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117155637.363706-2-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 17, 2021 at 04:56:32PM +0100, Frederic Weisbecker wrote:
> nocb_gp_wait() iterates all CPUs within the rcuog's group even if they
> are have been de-offloaded. This is suboptimal if only few CPUs are
> offloaded within the group. And this will become even more a problem
> when a nocb kthread will be created for all possible CPUs in the future.
> 
> Therefore use a standard double linked list to link all the offloaded
> rdps and safely add/del their nodes as we (de-)offloaded them.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.h      |  7 +++++--
>  kernel/rcu/tree_nocb.h | 29 ++++++++++++++++++++++-------
>  2 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index deeaf2fee714..486fc901bd08 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -221,8 +221,11 @@ struct rcu_data {
>  	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
>  	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
>  	struct task_struct *nocb_cb_kthread;
> -	struct rcu_data *nocb_next_cb_rdp;
> -					/* Next rcu_data in wakeup chain. */
> +	struct list_head nocb_head_rdp; /*
> +					 * Head of rcu_data list in wakeup chain,
> +					 * if rdp_gp.
> +					 */
> +	struct list_head nocb_entry_rdp; /* rcu_data node in wakeup chain. */
>  
>  	/* The following fields are used by CB kthread, hence new cacheline. */
>  	struct rcu_data *nocb_gp_rdp ____cacheline_internodealigned_in_smp;
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 2461fe8d0c23..e728128be02a 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -625,7 +625,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  	 * and the global grace-period kthread are awakened if needed.
>  	 */
>  	WARN_ON_ONCE(my_rdp->nocb_gp_rdp != my_rdp);
> -	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
> +	list_for_each_entry_rcu(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp, 1) {
>  		bool needwake_state = false;
>  
>  		if (!nocb_gp_enabled_cb(rdp))
> @@ -1003,6 +1003,8 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>  	swait_event_exclusive(rdp->nocb_state_wq,
>  			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
>  							SEGCBLIST_KTHREAD_GP));
> +	/* Don't bother iterate this one anymore on nocb_gp_wait() */
> +	list_del_rcu(&rdp->nocb_entry_rdp);
>  	/*
>  	 * Lock one last time to acquire latest callback updates from kthreads
>  	 * so we can later handle callbacks locally without locking.
> @@ -1066,6 +1068,15 @@ static long rcu_nocb_rdp_offload(void *arg)
>  		return -EINVAL;
>  
>  	pr_info("Offloading %d\n", rdp->cpu);
> +
> +	/*
> +	 * Iterate this CPU on nocb_gp_wait(). We do it before locking nocb_gp_lock,
> +	 * resetting nocb_gp_sleep and waking up the related "rcuog". Since nocb_gp_wait()
> +	 * in turn locks nocb_gp_lock before setting nocb_gp_sleep again, we are guaranteed
> +	 * to iterate this new rdp before "rcuog" goes to sleep again.

Just to make sure that I understand...

The ->nocb_entry_rdp list is RCU-protected, with an odd flavor of RCU.
The list_add_tail_rcu() handles list insertion.  For list deletion,
on the one hand, the rcu_data structures are never freed, so their
lifetime never ends.  But one could be removed during an de-offloading
operation, then re-added by a later offloading operation.  It would be
bad if a reader came along for that ride because that reader would end
up skipping all the rcu_data structures that were in the list after the
initial position of the one that was removed and added back.

The trick seems to be that the de-offloading process cannot complete
until the relevant rcuog kthread has acknowledged the de-offloading,
which it cannot do until it has completed the list_for_each_entry_rcu()
loop.  And the rcuog kthread is the only thing that traverses the list,
except for the show_rcu_nocb_state() function, more on which later.

Therefore, it is not possible for the rcuog kthread to come along for
that ride.

On to show_rcu_nocb_state()...

This does not actually traverse the list, but instead looks at the ->cpu
field of the next structure.  Because the ->next pointer is never NULLed,
the worst that can happen is that a confusing ->cpu field is printed,
for example, the one that was in effect prior to the de-offloading
operation.  But that number would have been printed anyway had the
show_rcu_nocb_state() function not been delayed across the de-offloading
and offloading.

So no harm done.

Did I get it right?  If so, the comment might need help.  If not,
what am I missing?

							Thanx, Paul

> +	 */
> +	list_add_tail_rcu(&rdp->nocb_entry_rdp, &rdp->nocb_gp_rdp->nocb_head_rdp);
> +
>  	/*
>  	 * Can't use rcu_nocb_lock_irqsave() before SEGCBLIST_LOCKING
>  	 * is set.
> @@ -1268,7 +1279,6 @@ static void __init rcu_organize_nocb_kthreads(void)
>  	int nl = 0;  /* Next GP kthread. */
>  	struct rcu_data *rdp;
>  	struct rcu_data *rdp_gp = NULL;  /* Suppress misguided gcc warn. */
> -	struct rcu_data *rdp_prev = NULL;
>  
>  	if (!cpumask_available(rcu_nocb_mask))
>  		return;
> @@ -1288,8 +1298,8 @@ static void __init rcu_organize_nocb_kthreads(void)
>  			/* New GP kthread, set up for CBs & next GP. */
>  			gotnocbs = true;
>  			nl = DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
> -			rdp->nocb_gp_rdp = rdp;
>  			rdp_gp = rdp;
> +			INIT_LIST_HEAD(&rdp->nocb_head_rdp);
>  			if (dump_tree) {
>  				if (!firsttime)
>  					pr_cont("%s\n", gotnocbscbs
> @@ -1302,12 +1312,11 @@ static void __init rcu_organize_nocb_kthreads(void)
>  		} else {
>  			/* Another CB kthread, link to previous GP kthread. */
>  			gotnocbscbs = true;
> -			rdp->nocb_gp_rdp = rdp_gp;
> -			rdp_prev->nocb_next_cb_rdp = rdp;
>  			if (dump_tree)
>  				pr_cont(" %d", cpu);
>  		}
> -		rdp_prev = rdp;
> +		rdp->nocb_gp_rdp = rdp_gp;
> +		list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
>  	}
>  	if (gotnocbs && dump_tree)
>  		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
> @@ -1369,6 +1378,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
>  {
>  	char bufw[20];
>  	char bufr[20];
> +	struct rcu_data *nocb_next_rdp = NULL;
>  	struct rcu_segcblist *rsclp = &rdp->cblist;
>  	bool waslocked;
>  	bool wassleep;
> @@ -1376,11 +1386,16 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
>  	if (rdp->nocb_gp_rdp == rdp)
>  		show_rcu_nocb_gp_state(rdp);
>  
> +	nocb_next_rdp = list_next_or_null_rcu(&rdp->nocb_gp_rdp->nocb_head_rdp,
> +					      &rdp->nocb_entry_rdp,
> +					      typeof(*rdp),
> +					      nocb_entry_rdp);
> +
>  	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
>  	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
>  	pr_info("   CB %d^%d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
>  		rdp->cpu, rdp->nocb_gp_rdp->cpu,
> -		rdp->nocb_next_cb_rdp ? rdp->nocb_next_cb_rdp->cpu : -1,
> +		nocb_next_rdp ? nocb_next_rdp->cpu : -1,
>  		"kK"[!!rdp->nocb_cb_kthread],
>  		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
>  		"cC"[!!atomic_read(&rdp->nocb_lock_contended)],
> -- 
> 2.25.1
> 
