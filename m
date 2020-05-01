Return-Path: <SRS0=yzHE=6P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E583CC47256
	for <rcu@archiver.kernel.org>; Fri,  1 May 2020 23:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28A4216FD
	for <rcu@archiver.kernel.org>; Fri,  1 May 2020 23:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588374399;
	bh=51VIsOTdM0PdBDNSoLJd82mfxacRk0S0IGR+l3AtF/w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OwAx112TeYsv9qTWzJ+pSbo6xFGEOvEFCQyXZdK4JV4CtHOWg1qLisyvsYQHmRubX
	 wbeihqMMvk0EDn2zhvr/IHH7RBbAtmvMkj/OzIcbDs0OKuEpEeP0CxDlxoxLXIYwMV
	 3nisK/rohMgiphc+bh9Ic5De+OoQV40P9ZX5ZDTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgEAXGj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 May 2020 19:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAXGj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 1 May 2020 19:06:39 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C13E208DB;
        Fri,  1 May 2020 23:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588374398;
        bh=51VIsOTdM0PdBDNSoLJd82mfxacRk0S0IGR+l3AtF/w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KhKdEokm+gypLvWuObTgAScwTZEGv5n8ZWJLZA/nP4Ku1pfdQKEoHmRnF+GkVljUZ
         J93gJzIl7R9qCYYCFxj6u5H73/yXcmJRFDiWhX0QEgSXxuoFrAsiUJ+r/tYXshflbm
         udPHuvNFkO1vEDCqP+bZt8gHTCo0Zo54WK1adLhc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5173C3522B72; Fri,  1 May 2020 16:06:38 -0700 (PDT)
Date:   Fri, 1 May 2020 16:06:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 22/24] rcu/tiny: support reclaim for head-less object
Message-ID: <20200501230638.GI7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-23-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428205903.61704-23-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 28, 2020 at 10:59:01PM +0200, Uladzislau Rezki (Sony) wrote:
> Make a kvfree_call_rcu() function to support head-less
> freeing. Same as for tree-RCU, for such purpose we store
> pointers in array. SLAB and vmalloc ptrs. are mixed and
> coexist together.
> 
> Under high memory pressure it can be that maintaining of
> arrays becomes impossible. Objects with an rcu_head are
> released via call_rcu(). When it comes to the head-less
> variant, the kvfree() call is directly inlined, i.e. we
> do the same as for tree-RCU:
>     a) wait until a grace period has elapsed;
>     b) direct inlining of the kvfree() call.
> 
> Thus the current context has to follow might_sleep()
> annotation. Also please note that for tiny-RCU any
> call of synchronize_rcu() is actually a quiescent
> state, therefore (a) does nothing.

Please, please, please just do synchronize_rcu() followed by kvfree()
for single-argument kfree_rcu() and friends in Tiny RCU.

Way simpler and probably way faster as well.  And given that Tiny RCU
runs only on uniprocessor systems, the complexity probably is buying
you very little, if anything.

							Thanx, Paul

> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tiny.c | 157 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 156 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index 508c82faa45c..b1c31a935db9 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -40,6 +40,29 @@ static struct rcu_ctrlblk rcu_ctrlblk = {
>  	.curtail	= &rcu_ctrlblk.rcucblist,
>  };
>  
> +/* Can be common with tree-RCU. */
> +#define KVFREE_DRAIN_JIFFIES (HZ / 50)
> +
> +/* Can be common with tree-RCU. */
> +struct kvfree_rcu_bulk_data {
> +	unsigned long nr_records;
> +	struct kvfree_rcu_bulk_data *next;
> +	void *records[];
> +};
> +
> +/* Can be common with tree-RCU. */
> +#define KVFREE_BULK_MAX_ENTR \
> +	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
> +
> +static struct kvfree_rcu_bulk_data *kvhead;
> +static struct kvfree_rcu_bulk_data *kvhead_free;
> +static struct kvfree_rcu_bulk_data *kvcache;
> +
> +static DEFINE_STATIC_KEY_FALSE(rcu_init_done);
> +static struct delayed_work monitor_work;
> +static struct rcu_work rcu_work;
> +static bool monitor_todo;
> +
>  void rcu_barrier(void)
>  {
>  	wait_rcu_gp(call_rcu);
> @@ -177,9 +200,137 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  }
>  EXPORT_SYMBOL_GPL(call_rcu);
>  
> +static inline bool
> +kvfree_call_rcu_add_ptr_to_bulk(void *ptr)
> +{
> +	struct kvfree_rcu_bulk_data *bnode;
> +
> +	if (!kvhead || kvhead->nr_records == KVFREE_BULK_MAX_ENTR) {
> +		bnode = xchg(&kvcache, NULL);
> +		if (!bnode)
> +			bnode = (struct kvfree_rcu_bulk_data *)
> +				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +
> +		if (unlikely(!bnode))
> +			return false;
> +
> +		/* Initialize the new block. */
> +		bnode->nr_records = 0;
> +		bnode->next = kvhead;
> +
> +		/* Attach it to the bvhead. */
> +		kvhead = bnode;
> +	}
> +
> +	/* Done. */
> +	kvhead->records[kvhead->nr_records++] = ptr;
> +	return true;
> +}
> +
> +static void
> +kvfree_rcu_work(struct work_struct *work)
> +{
> +	struct kvfree_rcu_bulk_data *kvhead_tofree, *next;
> +	unsigned long flags;
> +	int i;
> +
> +	local_irq_save(flags);
> +	kvhead_tofree = kvhead_free;
> +	kvhead_free = NULL;
> +	local_irq_restore(flags);
> +
> +	/* Reclaim process. */
> +	for (; kvhead_tofree; kvhead_tofree = next) {
> +		next = kvhead_tofree->next;
> +
> +		for (i = 0; i < kvhead_tofree->nr_records; i++) {
> +			debug_rcu_head_unqueue((struct rcu_head *)
> +				kvhead_tofree->records[i]);
> +			kvfree(kvhead_tofree->records[i]);
> +		}
> +
> +		if (cmpxchg(&kvcache, NULL, kvhead_tofree))
> +			free_page((unsigned long) kvhead_tofree);
> +	}
> +}
> +
> +static inline bool
> +queue_kvfree_rcu_work(void)
> +{
> +	/* Check if the free channel is available. */
> +	if (kvhead_free)
> +		return false;
> +
> +	kvhead_free = kvhead;
> +	kvhead = NULL;
> +
> +	/*
> +	 * Queue the job for memory reclaim after GP.
> +	 */
> +	queue_rcu_work(system_wq, &rcu_work);
> +	return true;
> +}
> +
> +static void kvfree_rcu_monitor(struct work_struct *work)
> +{
> +	unsigned long flags;
> +	bool queued;
> +
> +	local_irq_save(flags);
> +	queued = queue_kvfree_rcu_work();
> +	if (queued)
> +		/* Success. */
> +		monitor_todo = false;
> +	local_irq_restore(flags);
> +
> +	/*
> +	 * If previous RCU reclaim process is still in progress,
> +	 * schedule the work one more time to try again later.
> +	 */
> +	if (monitor_todo)
> +		schedule_delayed_work(&monitor_work,
> +			KVFREE_DRAIN_JIFFIES);
> +}
> +
>  void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> -	call_rcu(head, func);
> +	unsigned long flags;
> +	bool success;
> +	void *ptr;
> +
> +	if (head) {
> +		ptr = (void *) head - (unsigned long) func;
> +	} else {
> +		might_sleep();
> +		ptr = (void *) func;
> +	}
> +
> +	if (debug_rcu_head_queue(ptr)) {
> +		/* Probable double free, just leak. */
> +		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> +			  __func__, head);
> +		return;
> +	}
> +
> +	local_irq_save(flags);
> +	success = kvfree_call_rcu_add_ptr_to_bulk(ptr);
> +	if (static_branch_likely(&rcu_init_done)) {
> +		if (success && !monitor_todo) {
> +			monitor_todo = true;
> +			schedule_delayed_work(&monitor_work,
> +				KVFREE_DRAIN_JIFFIES);
> +		}
> +	}
> +	local_irq_restore(flags);
> +
> +	if (!success) {
> +		if (!head) {
> +			synchronize_rcu();
> +			kvfree(ptr);
> +		} else {
> +			call_rcu(head, func);
> +		}
> +	}
>  }
>  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
>  
> @@ -188,4 +339,8 @@ void __init rcu_init(void)
>  	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
>  	rcu_early_boot_tests();
>  	srcu_init();
> +
> +	INIT_DELAYED_WORK(&monitor_work, kvfree_rcu_monitor);
> +	INIT_RCU_WORK(&rcu_work, kvfree_rcu_work);
> +	static_branch_enable(&rcu_init_done);
>  }
> -- 
> 2.20.1
> 
