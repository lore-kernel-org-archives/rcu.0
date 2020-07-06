Return-Path: <SRS0=BsRz=AR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39D5C433DF
	for <rcu@archiver.kernel.org>; Mon,  6 Jul 2020 19:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC37620675
	for <rcu@archiver.kernel.org>; Mon,  6 Jul 2020 19:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="k/hskU/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgGFTmg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgGFTmf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Jul 2020 15:42:35 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C52C061794
        for <rcu@vger.kernel.org>; Mon,  6 Jul 2020 12:42:34 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c30so32131099qka.10
        for <rcu@vger.kernel.org>; Mon, 06 Jul 2020 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZmuO55kwkgZc0hY5jQ8BMDzA5Y+HA//IRHqjrSjg2/w=;
        b=k/hskU/rVY0C4Hp5PfldJI0muMX5Egojm7NIUV0B80Hea5t2F6KMhVmw2dd0l1fEcx
         oHHYTmt2Jyw0WGnrPLgmyaiCisSrw66aYOwNgz2mnTl4o5sT7CHj6l9Ve364PSmozHUk
         v+BkuRkeGMIjnAqM6QHdIQnnLaxbuXSq0p9PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZmuO55kwkgZc0hY5jQ8BMDzA5Y+HA//IRHqjrSjg2/w=;
        b=UNNAjwRhYkpXNfviMvRCjQcEnkkxbpa1292KgEC8oUvGsqGizelaVWxdXFzJIFO8ts
         wwKndWb6UcTHhXMtwtmb9U1JjbLZNYms88jmYRL7ieRVYBvcvshICRWAu4P56v96BQiU
         1kO63VllfPz1CKLw2zn8Th47dZCiVcZqmO7nSq2oqTJH1GRsXw0Ub00PnMa21Xao2+L4
         BDNLHYYpVPhtX9tOvUyy9ogOCa0Fc32onbV8bjS8za9L1NR+16I43VGiw6YNMNdmf4ff
         ZHj9KdXc9f6tLdQ1xvkzByf2Ykt0l7Co63NCUuf5tvjY3t+U1bckvfqSWuDRi6b6o3cA
         ZUHA==
X-Gm-Message-State: AOAM530zD6LUy/4awtfbuBtP1MGbN6vKsKFISxUtiQeI/AFKqJd0j2x+
        7GGn4hZ9Ca8nzDoAAmdbtucpNQ==
X-Google-Smtp-Source: ABdhPJxhweKx41M36beeymAe5lh5mNJBKqCsdX/ON/MUBzPiDv2UE5tgdF1Vv/ib5rD3PrVQnUG23w==
X-Received: by 2002:a37:51c6:: with SMTP id f189mr49108019qkb.339.1594064553894;
        Mon, 06 Jul 2020 12:42:33 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n28sm24379069qtf.8.2020.07.06.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 12:42:33 -0700 (PDT)
Date:   Mon, 6 Jul 2020 15:42:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200706194232.GA233429@google.com>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
 <20200702194506.GA31478@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702194506.GA31478@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 02, 2020 at 09:45:06PM +0200, Uladzislau Rezki wrote:
> On Thu, Jul 02, 2020 at 04:12:16PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-06-30 11:35:34 [-0700], Paul E. McKenney wrote:
> > > > This is not going to work together with the "wait context validator"
> > > > (CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
> > > > printk() which is why it is still disabled by default.
> > > 
> > > Fixing that should be "interesting".  In particular, RCU CPU stall
> > > warnings rely on the raw spin lock to reduce false positives due
> > > to race conditions.  Some thought will be required here.
> > 
> > I don't get this part. Can you explain/give me an example where to look
> > at?
> > 
> > > > So assume that this is fixed and enabled then on !PREEMPT_RT it will
> > > > complain that you have a raw_spinlock_t acquired (the one from patch
> > > > 02/17) and attempt to acquire a spinlock_t in the memory allocator.
> > > 
> > > Given that the slab allocator doesn't acquire any locks until it gets
> > > a fair way in, wouldn't it make sense to allow a "shallow" allocation
> > > while a raw spinlock is held?  This would require yet another GFP_ flag,
> > > but that won't make all that much of a difference in the total.  ;-)
> > 
> > That would be one way of dealing with. But we could go back to
> > spinlock_t and keep the memory allocation even for RT as is. I don't see
> > a downside of this. And we would worry about kfree_rcu() from real
> > IRQ-off region once we get to it.
> > 

Sorry for my late reply as the day job and family demanded a lot last week...

> Another way of fixing it is just dropping the lock letting the page
> allocator to do an allocation without our "upper/local" lock. I did a
> proposal like that once upon a time, so maybe it is a time to highlight
> it again:
> <snip>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 21c2fa5bd8c3..249f10a89bb9 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3278,9 +3278,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  }
> 
>  static inline bool
> -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> +kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> +       void *ptr, unsigned long *flags)
>  {
>         struct kvfree_rcu_bulk_data *bnode;
> +       struct kfree_rcu_cpu *tmp;
>         int idx;
> 
>         if (unlikely(!krcp->initialized))
> @@ -3306,6 +3308,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>                         if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                                 return false;
> 
> +                       migrate_disable();
> +                       krc_this_cpu_unlock(krcp, *flags);

If I remember, the issue here is that migrate_disable is not implemented on a
non-RT kernel due to issues with starvation.

What about using the mempools. If we can allocate from that without entry
into the page allocator, then that would be one way. Not sure if there are
other issues such as the mempool allocation itself acquiring regular spinlocks.

We could also just do what Sebastian is suggesting, which is revert to
regular spinlocks and allow this code to sleep while worrying about
atomic callers later. For RT, could such atomic callers perhaps do their
allocations differently such as allocating in advance or later on in process
context?

thanks,

 - Joel


> +
>                         /*
>                          * NOTE: For one argument of kvfree_rcu() we can
>                          * drop the lock and get the page in sleepable
> @@ -3315,6 +3320,12 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>                          */
>                         bnode = (struct kvfree_rcu_bulk_data *)
>                                 __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +
> +                       tmp = krc_this_cpu_lock(flags);
> +                       migrate_enable();
> +
> +                       /* Sanity check, just in case. */
> +                       WARN_ON(tmp != krcp);
>                 }
>  
>                 /* Switch to emergency path. */
> @@ -3386,7 +3397,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>          * Under high memory pressure GFP_NOWAIT can fail,
>          * in that case the emergency path is maintained.
>          */
> -       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> +       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr, &flags);
>         if (!success) {
>                 if (head == NULL)
>                         // Inline if kvfree_rcu(one_arg) call.
> <snip>
> 
> --
> Vlad Rezki
