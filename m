Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4E0C43331
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 00:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA17206E6
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 00:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UNdhRGys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgC3A4k (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:56:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43421 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgC3A4k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 20:56:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id a5so13772455qtw.10
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 17:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iI0jKAoAyWtfChZH75VkjoG0ZcHAQComTx8+SSOtfxY=;
        b=UNdhRGysEPwhw+OCPajgfkaDX9PGLRR5RHy5KC9Q4lKNaxeEnuJNIWvWTwaOCeH2/x
         xTqpSwA5NaovS6TGkJqFfaB31t38UfZ87CDmPed4NCAsHdi8M7QAJjkcccJLhRTAdcqt
         NZKrOu6QJpPp0pr0KfeFjRLu6SWXXvsoMVpuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iI0jKAoAyWtfChZH75VkjoG0ZcHAQComTx8+SSOtfxY=;
        b=aknja8/DDRghOH7M1iIbWlKtqoAukJYZQFwoM/d7Yu5NIpheKOcxsvCb08GyBqrwvE
         Y6q8LQRQ5qlfN/no/roOvGWAhPv2TAx7yjHIulV7yU79ximxU6inmEe2u15tUA7/nloa
         InQzC+AmIiMw8EBAIkPCT95zUhykvhv3ER8r/vGfQ5ATHRZLh67ji7fEg/aetgNijnIH
         dELQgq6jKYZtHrCHSS14ruj6JHWwrj82SZfT+kcW4uOWRrgm6OQHhHyPkPtOn7RbPMYi
         RWTIg4GbdLoFoWINCo1OBGaecGZKf7Vmbdu1945wM2WiODIo7QXt3ff6JDBascpy4t3d
         jOYA==
X-Gm-Message-State: ANhLgQ13obVut8pB9Aa5y0bBOA3sbmUJovUYGwwsRXTdJKmpjoiBAmJs
        sYqCjgHtZ5cWMszmjE0dCtqsrA==
X-Google-Smtp-Source: ADFU+vtF10fPw1Qk9sJ7/al/aoj/ekgKVODMJnVKhIQvJnR4PRFzQLhyzJgnzEGXwNe7JIX6ZK0scQ==
X-Received: by 2002:aed:2499:: with SMTP id t25mr9933397qtc.127.1585529798595;
        Sun, 29 Mar 2020 17:56:38 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 60sm9643819qtb.95.2020.03.29.17.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 17:56:38 -0700 (PDT)
Date:   Sun, 29 Mar 2020 20:56:37 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 6/7] rcu/tiny: support reclaim for head-less object
Message-ID: <20200330005637.GA138004@google.com>
References: <20200323113621.12048-1-urezki@gmail.com>
 <20200323113621.12048-7-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323113621.12048-7-urezki@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 23, 2020 at 12:36:20PM +0100, Uladzislau Rezki (Sony) wrote:
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

Hmm, Ok. So on -tiny, if there's any allocation failure ever, we immediately
revert to call_rcu(). I guess we could also create a regular (non-array)
queue for objects with an rcu_head and queue it on that (since it does not
need allocation) in case of array allocation failure, however that may not be
worth it. So this LGTM. Thanks!

For entire series:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
(I will submit a follow-up to fix the tagging, please let me submit Vlad's
entire series with some patches on top -- I also did a bit of wordsmithing in
the commit messages of this series).

Loved the might_sleep() idea btw, I suppose if atomic context wants to do
kvfree_rcu(), then we could also have kfree_rcu() defer the kvfree_rcu() to
execute from a workqueue. Thoughts? We can then allow poor insomniacs from
calling this API :)

thanks,

 - Joel


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
