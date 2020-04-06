Return-Path: <SRS0=S3tF=5W=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F74FC2BA1E
	for <rcu@archiver.kernel.org>; Mon,  6 Apr 2020 15:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3294723730
	for <rcu@archiver.kernel.org>; Mon,  6 Apr 2020 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586187075;
	bh=wseZZDh8ZgqZPtDMMFskn0Ll5dIbXOE1v+3OeUbc6rM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jQlyUMxzxBm2e53OhIT1bpIRLt3+8UrQw78dU7yiydbRHhmHt24ztGo3CyBcbTInK
	 iAZimK177ObvEDlU/1sjdQqM+uAAw63qjwBB3y0gCyd+MCfR9sKWNuIkphW+auUb6V
	 OlROgbVFATi+eBUJLpN8JCXKwHRyifMW4cXNsCr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgDFPbM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbgDFPbM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Apr 2020 11:31:12 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 216B5248A6;
        Mon,  6 Apr 2020 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586187071;
        bh=wseZZDh8ZgqZPtDMMFskn0Ll5dIbXOE1v+3OeUbc6rM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0+Gecix8u7KbvF1Eu95k9da+J8UqUasNzDq4NqowxGXBBLZjOFYBibjpKKPU30Uam
         Fnf/9Xz1UEVMOuarJlw0UhPdCV/CeLBL9g8Qq2REDB0XoYNlvV0MVtMjDuPL/7LQzD
         GGYOZyl7N2tTRdisG49eIzfmpLphXvVt1q0kZzbo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DE5EE35230D1; Mon,  6 Apr 2020 08:31:10 -0700 (PDT)
Date:   Mon, 6 Apr 2020 08:31:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Message-ID: <20200406153110.GE19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200403173051.4081-1-urezki@gmail.com>
 <20200404195129.GA83565@google.com>
 <20200405172105.GA7539@pc636>
 <20200405233028.GC83565@google.com>
 <20200406125640.GA23256@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406125640.GA23256@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 06, 2020 at 02:56:40PM +0200, Uladzislau Rezki wrote:
> Hello, Joel.
> 
> > > > 
> > > > Hi Vlad,
> > > > 
> > > > One concern I have is this moves the problem a bit further down. My belief is
> > > > we should avoid the likelihood of even needing an rcu_head allocated for the
> > > > headless case, to begin with - than trying to do damage-control when it does
> > > > happen. The only way we would end up needing an rcu_head is if we could not
> > > > allocate an array.
> > > > 
> > > Let me share my view on all such caching. I think that now it becomes less as
> > > the issue, because of we have now https://lkml.org/lkml/2020/4/2/383 patch.
> > > I see that it does help a lot. I tried to simulate low memory condition and 
> > > apply high memory pressure with that. I did not manage to trigger the
> > > "synchronize rcu" path at all. It is because of using much more permissive
> > > parameters when we request a memory from the SLAB(direct reclaim, etc...).
> > 
> > That's a good sign that we don't hit this path in your tests.
> > 
> Just one request, of course if you have a time :) Could you please
> double check on your test environment to stress the system to check
> if you also can not hit it?
> 
> How i test it. Please apply below patch:

This is of course a double challenge.

I can assure you that even if we cannot make it happen in the comfort and
safety of our tests systems, someone somewhere will make it happen all
the time.  Because there is a very large number of Linux systems running
out there.

Which leads to the other challenge:  How do we test this code path?

							Thanx, Paul

> <snip>
> t a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5e26145e9ead..25f7ac8583e1 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3203,6 +3203,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  
>         if (head) {
>                 ptr = (void *) head - (unsigned long) func;
> +               head = NULL;
>         } else {
>                 /*
>                  * Please note there is a limitation for the head-less
> @@ -3233,16 +3234,18 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>          * Under high memory pressure GFP_NOWAIT can fail,
>          * in that case the emergency path is maintained.
>          */
> -       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> -       if (!success) {
> +       /* success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr); */
> +       /* if (!success) { */
>                 /* Is headless object? */
>                 if (head == NULL) {
>                         /* Drop the lock. */
>                         krc_this_cpu_unlock(krcp, flags);
>  
>                         head = attach_rcu_head_to_object(ptr);
> -                       if (head == NULL)
> +                       if (head == NULL) {
> +                               success = false;
>                                 goto inline_return;
> +                       }
>  
>                         /* Take it back. */
>                         krcp = krc_this_cpu_lock(&flags);
> @@ -3267,7 +3270,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>                  */
>                 expedited_drain = true;
>                 success = true;
> -       }
> +       /* } */
>  
>         WRITE_ONCE(krcp->count, krcp->count + 1);
>  
> @@ -3297,7 +3300,9 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>                 if (!rcu_kfree_nowarn)
>                         WARN_ON_ONCE(1);
>                 debug_rcu_head_unqueue(ptr);
> -               synchronize_rcu();
> +               /* synchronize_rcu(); */
> +               printk(KERN_ERR "-> hit synchronize_rcu() path.\n");
> +               trace_printk("-> hit synchronize_rcu() path.\n");
>                 kvfree(ptr);
>         }
>  }
> <snip>
> 
> lower the memory size and run kfree rcu tests. It would be appreciated.
> 
> >
> > I guess also, with your latest patch on releasing the lock to be in a
> > non-atomic context, and then doing the allocation, it became even more
> > permissive? If you drop that patch and tried, do you still not hit the
> > synchronous path more often?
> > 
> Yep. If i drop the patch, i can hit it.
> 
> >
> > Could you also try introducing memory pressure by reducing your system's
> > total memory and see how it behaves?
> > 
> I simulated low memory condition by setting the system memory to 145MB.
> That was the minimum amount the KVM system was capable of booting. After
> that i used kfree rcu tests to simulate memory pressure.
> 
> > > > So instead of adding a pool for rcu_head allocations, how do you feel about
> > > > pre-allocation of the per-cpu cache array instead, which has the same effect
> > > > as you are intending?
> > > > 
> > > In the v2 i have a list of such objects. It is also per-CPU(it is scaled to CPUs),
> > > but the difference is, those objects require much less memory, it is 8 + sizeof(struct
> > > rcu_head) bytes comparing to one page. Therefore the memory footprint is lower.
> > 
> > Yes, true. That is one drawback is it higher memory usage. But if you have at
> > least 1 kfree_rcu() request an each CPU, then pre-allocation does not
> > increase memory usage any more than it already has right now. Unless, we
> > extend my proposal to cache more than 2 pages per-cpu which I think you
> > mentioned below.
> > 
> If we cache two pages per-CPU, i think that is fine. When it comes to increasing
> it, it can be a bit wasting. For example consider 128 CPUs system.
> 
> > > I have doubts that we would ever hit this emergency list, because of mentioned
> > > above patch, but from the other hand i can not say and guarantee 100%. Just in
> > > case, we may keep it. 
> > 
> > You really have to hit OOM in your tests to trigger it I suppose. Basically
> > the emergency pool improves situation under OOM, but otherwise does not
> > improve it due to the direct-reclaim that happens as you mentioned. Right?
> >
> See above how i simulated it. Direct reclaim is our GFP_KERNEL + other flags
> helper. If even after reclaim process there is no memory, then emergency list
> is supposed to be used. But we can drop this patch, i mean "emergency list"
> if we agree on it. The good point would be if you could stress your system
> by the i did. See above description :)
> 
> > > Paul, could you please share your view and opinion? It would be appreciated :)
> > > 
> > > > This has 3 benefits:
> > > > 1. It scales with number of CPUs, no configuration needed.
> > > > 2. It makes the first kfree_rcu() faster and less dependent on an allocation
> > > >    succeeding.
> > > > 3. Much simpler code, no new structures or special handling.
> > > > 4. In the future we can extend it to allocate more than 2 pages per CPU using
> > > >    the same caching mechanism.
> > > > 
> > > > The obvious drawback being its 2 pages per CPU but at least it scales by
> > > > number of CPUs. Something like the following (just lightly tested):
> > > > 
> > > > ---8<-----------------------
> > > > 
> > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > Subject: [PATCH] rcu/tree: Preallocate the per-cpu cache for kfree_rcu()
> > > > 
> > > > In recent changes, we have made it possible to use kfree_rcu() without
> > > > embedding an rcu_head in the object being free'd. This requires dynamic
> > > > allocation. In case dynamic allocation fails due to memory pressure, we
> > > > would end up synchronously waiting for an RCU grace period thus hurting
> > > > kfree_rcu() latency.
> > > > 
> > > > To make this less probable, let us pre-allocate the per-cpu cache so we
> > > > depend less on the dynamic allocation succeeding. This also has the
> > > > effect of making kfree_rcu() slightly faster at run time.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 6172e6296dd7d..9fbdeb4048425 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -4251,6 +4251,11 @@ static void __init kfree_rcu_batch_init(void)
> > > >  			krcp->krw_arr[i].krcp = krcp;
> > > >  		}
> > > >  
> > > > +		krcp->bkvcache[0] =  (struct kvfree_rcu_bulk_data *)
> > > > +					__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > > > +		krcp->bkvcache[1] =  (struct kvfree_rcu_bulk_data *)
> > > > +					__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > > > +
> > > >  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> > > >  		krcp->initialized = true;
> > > >  	}
> > > We pre-allocate it, but differently comparing with your proposal :) I do not see
> > > how it can improve things. The difference is you do it during initializing or booting  
> > > phase. In case of current code it will pre-allocate and cache one page after first
> > > calling of the kvfree_call_rcu(), say in one second. So basically both variants are
> > > the same.
> > 
> > Well, one proposal is only 5 lines extra ;-). That has got to be at least a
> > bit appealing ;-) ;-).
> > 
> :)
> 
> > > But i think that we should allow to be used two pages as cached ones, no matter 
> > > whether it is vmalloc ptrs. or SLAB ones. So basically, two cached pages can be
> > > used by vmalloc path and SLAB path. And probably it makes sense because of two
> > > phases: one is when we collect pointers, second one is memory reclaim path. Thus
> > > one page per one phase, i.e. it would be paired.
> > 
> > You are saying this with regard to my proposal right?  I agree number of
> > pages could be increased. The caching mechanism already in-place could be
> > starting point for that extension.
> > 
> We already have two pages. What we need is to allow to use them in both
> paths, vmalloc one and SLAB one, i mean reclaim path. At least that fits
> well to the collecting/reclaim phases.
> 
> Thanks for comments!
> 
> --
> Vlad Rezki
