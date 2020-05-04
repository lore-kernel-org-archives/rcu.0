Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF2EC47257
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC53620735
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="F67GIaPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgEDA1D (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 3 May 2020 20:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgEDA1C (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 3 May 2020 20:27:02 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6B3C061A0F
        for <rcu@vger.kernel.org>; Sun,  3 May 2020 17:27:02 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w29so12751387qtv.3
        for <rcu@vger.kernel.org>; Sun, 03 May 2020 17:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4wEg2ltoP54NXUs7l2Cl+KJD9hLImKWLNBt+8wdwdzY=;
        b=F67GIaPwHD44Ld0pcSNYFg/YgE44gczF2X1jnMcVxGWaOuQAJjIQgx1zcpFBxlQHlv
         Ob9e6DCF/7sBY7+HOp+eQZ2ZdwAX/u68RGOFA0YN6+UykyTsM3/aQMbqTy53Di3sqDuA
         zx2zOebBgI/RNmTUfm2icL1jz0UmOxYaJerOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4wEg2ltoP54NXUs7l2Cl+KJD9hLImKWLNBt+8wdwdzY=;
        b=ViXH6wcyNfktjVc1bzd5jPm06dL2RRlhQZLr+5TtoAVekp3c5D0ngwhKxSWoGcA3Fh
         PuaJ5m5N2u78pAfktsKXuNzeRaEqgaYYjb0p8nkKvHxcJ/Ya0sFYzDlGkr9MKoWO8mam
         0ZnMPF4cOCvVPSi0cUjKw63K0gfYBxg3ib6XOR2TAJzNli7j2xJrEIzJQM3SNMTWQKC9
         P5idePH/UaRS5I+7vPOE39PlPVWlqcp6OtnAg6t6pEX7gBGAMCsVoYFiqXUDBgldp7A0
         ft33UjEEliugWJTmqcyDE8A5aYCCmwIQm+IYkrBZ6KuGbCl6caspfm9VkUKZZjk1zdI9
         ONAQ==
X-Gm-Message-State: AGi0Pubac3B8QO92bge3KQR0vC84vwiofVzsnvetHbiC+rO73dtIu/N4
        FL28/BAmPV9Y4e/XhQE/3X9bQQ==
X-Google-Smtp-Source: APiQypJf3oXpkY2PS18eYNUR0jzkKSxVG3OHrDTFIywP4r+o2/5ycAMkaKmT4xe1QmWVpZr19OlBBA==
X-Received: by 2002:ac8:359d:: with SMTP id k29mr15025980qtb.106.1588552021889;
        Sun, 03 May 2020 17:27:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y6sm8461545qky.133.2020.05.03.17.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 17:27:01 -0700 (PDT)
Date:   Sun, 3 May 2020 20:27:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 22/24] rcu/tiny: support reclaim for head-less object
Message-ID: <20200504002700.GB212435@google.com>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-23-urezki@gmail.com>
 <20200501230638.GI7560@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501230638.GI7560@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 01, 2020 at 04:06:38PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 28, 2020 at 10:59:01PM +0200, Uladzislau Rezki (Sony) wrote:
> > Make a kvfree_call_rcu() function to support head-less
> > freeing. Same as for tree-RCU, for such purpose we store
> > pointers in array. SLAB and vmalloc ptrs. are mixed and
> > coexist together.
> > 
> > Under high memory pressure it can be that maintaining of
> > arrays becomes impossible. Objects with an rcu_head are
> > released via call_rcu(). When it comes to the head-less
> > variant, the kvfree() call is directly inlined, i.e. we
> > do the same as for tree-RCU:
> >     a) wait until a grace period has elapsed;
> >     b) direct inlining of the kvfree() call.
> > 
> > Thus the current context has to follow might_sleep()
> > annotation. Also please note that for tiny-RCU any
> > call of synchronize_rcu() is actually a quiescent
> > state, therefore (a) does nothing.
> 
> Please, please, please just do synchronize_rcu() followed by kvfree()
> for single-argument kfree_rcu() and friends in Tiny RCU.
> 
> Way simpler and probably way faster as well.  And given that Tiny RCU
> runs only on uniprocessor systems, the complexity probably is buying
> you very little, if anything.

Agreed.

thanks,

 - Joel

> 
> 							Thanx, Paul
> 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/tiny.c | 157 +++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 156 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > index 508c82faa45c..b1c31a935db9 100644
> > --- a/kernel/rcu/tiny.c
> > +++ b/kernel/rcu/tiny.c
> > @@ -40,6 +40,29 @@ static struct rcu_ctrlblk rcu_ctrlblk = {
> >  	.curtail	= &rcu_ctrlblk.rcucblist,
> >  };
> >  
> > +/* Can be common with tree-RCU. */
> > +#define KVFREE_DRAIN_JIFFIES (HZ / 50)
> > +
> > +/* Can be common with tree-RCU. */
> > +struct kvfree_rcu_bulk_data {
> > +	unsigned long nr_records;
> > +	struct kvfree_rcu_bulk_data *next;
> > +	void *records[];
> > +};
> > +
> > +/* Can be common with tree-RCU. */
> > +#define KVFREE_BULK_MAX_ENTR \
> > +	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
> > +
> > +static struct kvfree_rcu_bulk_data *kvhead;
> > +static struct kvfree_rcu_bulk_data *kvhead_free;
> > +static struct kvfree_rcu_bulk_data *kvcache;
> > +
> > +static DEFINE_STATIC_KEY_FALSE(rcu_init_done);
> > +static struct delayed_work monitor_work;
> > +static struct rcu_work rcu_work;
> > +static bool monitor_todo;
> > +
> >  void rcu_barrier(void)
> >  {
> >  	wait_rcu_gp(call_rcu);
> > @@ -177,9 +200,137 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  }
> >  EXPORT_SYMBOL_GPL(call_rcu);
> >  
> > +static inline bool
> > +kvfree_call_rcu_add_ptr_to_bulk(void *ptr)
> > +{
> > +	struct kvfree_rcu_bulk_data *bnode;
> > +
> > +	if (!kvhead || kvhead->nr_records == KVFREE_BULK_MAX_ENTR) {
> > +		bnode = xchg(&kvcache, NULL);
> > +		if (!bnode)
> > +			bnode = (struct kvfree_rcu_bulk_data *)
> > +				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > +
> > +		if (unlikely(!bnode))
> > +			return false;
> > +
> > +		/* Initialize the new block. */
> > +		bnode->nr_records = 0;
> > +		bnode->next = kvhead;
> > +
> > +		/* Attach it to the bvhead. */
> > +		kvhead = bnode;
> > +	}
> > +
> > +	/* Done. */
> > +	kvhead->records[kvhead->nr_records++] = ptr;
> > +	return true;
> > +}
> > +
> > +static void
> > +kvfree_rcu_work(struct work_struct *work)
> > +{
> > +	struct kvfree_rcu_bulk_data *kvhead_tofree, *next;
> > +	unsigned long flags;
> > +	int i;
> > +
> > +	local_irq_save(flags);
> > +	kvhead_tofree = kvhead_free;
> > +	kvhead_free = NULL;
> > +	local_irq_restore(flags);
> > +
> > +	/* Reclaim process. */
> > +	for (; kvhead_tofree; kvhead_tofree = next) {
> > +		next = kvhead_tofree->next;
> > +
> > +		for (i = 0; i < kvhead_tofree->nr_records; i++) {
> > +			debug_rcu_head_unqueue((struct rcu_head *)
> > +				kvhead_tofree->records[i]);
> > +			kvfree(kvhead_tofree->records[i]);
> > +		}
> > +
> > +		if (cmpxchg(&kvcache, NULL, kvhead_tofree))
> > +			free_page((unsigned long) kvhead_tofree);
> > +	}
> > +}
> > +
> > +static inline bool
> > +queue_kvfree_rcu_work(void)
> > +{
> > +	/* Check if the free channel is available. */
> > +	if (kvhead_free)
> > +		return false;
> > +
> > +	kvhead_free = kvhead;
> > +	kvhead = NULL;
> > +
> > +	/*
> > +	 * Queue the job for memory reclaim after GP.
> > +	 */
> > +	queue_rcu_work(system_wq, &rcu_work);
> > +	return true;
> > +}
> > +
> > +static void kvfree_rcu_monitor(struct work_struct *work)
> > +{
> > +	unsigned long flags;
> > +	bool queued;
> > +
> > +	local_irq_save(flags);
> > +	queued = queue_kvfree_rcu_work();
> > +	if (queued)
> > +		/* Success. */
> > +		monitor_todo = false;
> > +	local_irq_restore(flags);
> > +
> > +	/*
> > +	 * If previous RCU reclaim process is still in progress,
> > +	 * schedule the work one more time to try again later.
> > +	 */
> > +	if (monitor_todo)
> > +		schedule_delayed_work(&monitor_work,
> > +			KVFREE_DRAIN_JIFFIES);
> > +}
> > +
> >  void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  {
> > -	call_rcu(head, func);
> > +	unsigned long flags;
> > +	bool success;
> > +	void *ptr;
> > +
> > +	if (head) {
> > +		ptr = (void *) head - (unsigned long) func;
> > +	} else {
> > +		might_sleep();
> > +		ptr = (void *) func;
> > +	}
> > +
> > +	if (debug_rcu_head_queue(ptr)) {
> > +		/* Probable double free, just leak. */
> > +		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> > +			  __func__, head);
> > +		return;
> > +	}
> > +
> > +	local_irq_save(flags);
> > +	success = kvfree_call_rcu_add_ptr_to_bulk(ptr);
> > +	if (static_branch_likely(&rcu_init_done)) {
> > +		if (success && !monitor_todo) {
> > +			monitor_todo = true;
> > +			schedule_delayed_work(&monitor_work,
> > +				KVFREE_DRAIN_JIFFIES);
> > +		}
> > +	}
> > +	local_irq_restore(flags);
> > +
> > +	if (!success) {
> > +		if (!head) {
> > +			synchronize_rcu();
> > +			kvfree(ptr);
> > +		} else {
> > +			call_rcu(head, func);
> > +		}
> > +	}
> >  }
> >  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> >  
> > @@ -188,4 +339,8 @@ void __init rcu_init(void)
> >  	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
> >  	rcu_early_boot_tests();
> >  	srcu_init();
> > +
> > +	INIT_DELAYED_WORK(&monitor_work, kvfree_rcu_monitor);
> > +	INIT_RCU_WORK(&rcu_work, kvfree_rcu_work);
> > +	static_branch_enable(&rcu_init_done);
> >  }
> > -- 
> > 2.20.1
> > 
