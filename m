Return-Path: <SRS0=S3tF=5W=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12091C2BA17
	for <rcu@archiver.kernel.org>; Mon,  6 Apr 2020 16:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D3824930
	for <rcu@archiver.kernel.org>; Mon,  6 Apr 2020 16:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uxz3ISwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgDFQRX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:17:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39110 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgDFQRX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Apr 2020 12:17:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id m2so1047055lfo.6;
        Mon, 06 Apr 2020 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=otpCu2xa1SlpkDg0OCv5uxejpIV7SlhvlLBrUpPcp0A=;
        b=Uxz3ISwb1UAkTR5kSPQGcN5n7+QordR9D9KO4475nSnJCV0hJx/KpskOgcPsCOGZfV
         dSqeAttKuUUS92UgbpzpfOXRQDjcGFEmex007g6DpQ4LcYZlKVDEuBw/KNK9/K08fMAj
         p84E5TcU2nlClioN3SsM/YbAwhna8yvedBot5amCuEe4B5IxxmphuUXTHwTljYLqCKUe
         ScJL8c968q8GqAsPDaVN0dMcaTZWO8BR2b/xG5pn/k/bULQSf7MRteoKEgIjlYK+kXbH
         lFY8PX8dwXELCoCgSRt6NETjpfERml5AvZDvedBWd3DZ454bGRjy2d9//TuOOiNEzz95
         pJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=otpCu2xa1SlpkDg0OCv5uxejpIV7SlhvlLBrUpPcp0A=;
        b=t6KzTaTc8wV7WEtrpFa1VZZeuZ8ldvzewIrlVvX4amP9AZ0J7AhQcIsQXi+4rje/WC
         kh8i/shGL3FE3rQf6dizwXXgB1M6zN58ri28+2sn0+zOfgiEW2LU+cFMDyWBkjJv3PaN
         VoEF3tqlaNg7XNBh6YM8Rmj7/FMw1Obd/PwMvSNR7l/KXNLBSRqFFAjyAWYRZw/5Xglk
         rRYrkJFfqugkmxZWpwf7XwfK/kTORUuYKfnOKThGiSC/OxHeR3Cl5ak0BFW+BUippix5
         junz53Fs1av1V/zk1q7q1hgtaygyJPJRmoLWVXTHR9/RCwvDUNPsleq6xbSU0yTAlvTL
         UMMA==
X-Gm-Message-State: AGi0PuaWhgt4RLwxW62dbolKjnFoZhu38CyJg1MGIN4KVXzpTqA9XOuv
        O4u3H9o+vWaLXVB7wyw/8zU=
X-Google-Smtp-Source: APiQypLXdC63JbCKJ2NLUX2W3tsb6FHbW2h7v8Om1knnrof0s1+MoBAuN68lLIcEVY6eYLMD/96mOQ==
X-Received: by 2002:ac2:50d9:: with SMTP id h25mr9443249lfm.80.1586189836669;
        Mon, 06 Apr 2020 09:17:16 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id b26sm9532809lji.8.2020.04.06.09.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:17:15 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 6 Apr 2020 18:17:08 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Message-ID: <20200406161708.GA3919@pc636>
References: <20200403173051.4081-1-urezki@gmail.com>
 <20200404195129.GA83565@google.com>
 <20200405172105.GA7539@pc636>
 <20200405233028.GC83565@google.com>
 <20200406125640.GA23256@pc636>
 <20200406151851.GF83565@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406151851.GF83565@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 06, 2020 at 11:18:51AM -0400, Joel Fernandes wrote:
> Hi Vlad,
> 
> On Mon, Apr 06, 2020 at 02:56:40PM +0200, Uladzislau Rezki wrote:
> > Hello, Joel.
> > 
> > > > > 
> > > > > Hi Vlad,
> > > > > 
> > > > > One concern I have is this moves the problem a bit further down. My belief is
> > > > > we should avoid the likelihood of even needing an rcu_head allocated for the
> > > > > headless case, to begin with - than trying to do damage-control when it does
> > > > > happen. The only way we would end up needing an rcu_head is if we could not
> > > > > allocate an array.
> > > > > 
> > > > Let me share my view on all such caching. I think that now it becomes less as
> > > > the issue, because of we have now https://lkml.org/lkml/2020/4/2/383 patch.
> > > > I see that it does help a lot. I tried to simulate low memory condition and 
> > > > apply high memory pressure with that. I did not manage to trigger the
> > > > "synchronize rcu" path at all. It is because of using much more permissive
> > > > parameters when we request a memory from the SLAB(direct reclaim, etc...).
> > > 
> > > That's a good sign that we don't hit this path in your tests.
> > > 
> > Just one request, of course if you have a time :)
> > Could you please double check on your test environment to stress the system
> > to check if you also can not hit it?
> 
> Sure, I am planning to do so and happy to spend time on it :) One question I
> had about the below test:
> 
> > How i test it. Please apply below patch:
> > <snip>
> > t a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 5e26145e9ead..25f7ac8583e1 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3203,6 +3203,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  
> >         if (head) {
> >                 ptr = (void *) head - (unsigned long) func;
> > +               head = NULL;
> >         } else {
> >                 /*
> >                  * Please note there is a limitation for the head-less
> > @@ -3233,16 +3234,18 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >          * Under high memory pressure GFP_NOWAIT can fail,
> >          * in that case the emergency path is maintained.
> >          */
> > -       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> > -       if (!success) {
> > +       /* success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr); */
> 
> If you drop this, then it is not realistic right? I mean it changes behavior
> of the code completely. We need to try to allocate array and then try to
> allocate the head.
> 
That just bypasses an allocation for the array, to make it more simple
and move forward toward the path we would like to test. Also head is
set to NULL to simulated headless freeing.

> > +       /* if (!success) { */
> >                 /* Is headless object? */
> >                 if (head == NULL) {
> >                         /* Drop the lock. */
> >                         krc_this_cpu_unlock(krcp, flags);
> >  
> >                         head = attach_rcu_head_to_object(ptr);
> > -                       if (head == NULL)
> > +                       if (head == NULL) {
> > +                               success = false;
> >                                 goto inline_return;
> > +                       }
> >  
> >                         /* Take it back. */
> >                         krcp = krc_this_cpu_lock(&flags);
> > @@ -3267,7 +3270,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >                  */
> >                 expedited_drain = true;
> >                 success = true;
> > -       }
> > +       /* } */
> >  
> >         WRITE_ONCE(krcp->count, krcp->count + 1);
> >  
> > @@ -3297,7 +3300,9 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >                 if (!rcu_kfree_nowarn)
> >                         WARN_ON_ONCE(1);
> >                 debug_rcu_head_unqueue(ptr);
> > -               synchronize_rcu();
> > +               /* synchronize_rcu(); */
> > +               printk(KERN_ERR "-> hit synchronize_rcu() path.\n");
> > +               trace_printk("-> hit synchronize_rcu() path.\n");
> >                 kvfree(ptr);
> >         }
> >  }
> > <snip>
> > 
> > lower the memory size and run kfree rcu tests. It would be appreciated.
> 
> I am happy to try out the diff if I can understand how the above diff is
> close enough with current code's behavior, if we are not using the array. One
> other issue with current kfree rcu tests is, the test is itself the reason
> for the pressure -- I believe we should also have some testing that shows
> that the memory pressure is caused else where (such as a real user workload
> causing OOM), and then we see how RCU behaves under OOM -- if we have too
> many synchronous latencies, does the additional caching remove such latenies
> under OOM? etc.  I also want to look into your vmalloc tests.
> 
Of course to have real tests would be good. 

> > > I guess also, with your latest patch on releasing the lock to be in a
> > > non-atomic context, and then doing the allocation, it became even more
> > > permissive? If you drop that patch and tried, do you still not hit the
> > > synchronous path more often?
> > > 
> > Yep. If i drop the patch, i can hit it.
> 
> Ah, cool. So basically the direct-reclaim path does the synchronous waiting,
> instead of synchronize_rcu(). Either way, we wait synchronously. How to chose
> which way is better though? If direct reclaim improves the memory situation,
> then we should enter that path. But if direct reclaim takes too much time
> (thus hurting the kfree_rcu() latency), then perhaps it is better for
> kfree_rcu() to just do the synchronize_rcu() and let someone else enter the
> direct-reclaim path. We should probably quantify and see which approach works
> better.
> 
I see at it like, headless variant has to be called from the sleeping context, 
therefore it can sleep. What is better to call synchronize_rcu() or doing direct
reclaim depends on how many CPUs in a system we have. I suspect that doing
direct reclaim is better, at least it will free some memory for us. We
could also extend that patch and make it a bit different, for example do
NOWAIT then try ATOMIC and as a last step do GFP_KERNEL alloc.

> > > Could you also try introducing memory pressure by reducing your system's
> > > total memory and see how it behaves?
> > > 
> > I simulated low memory condition by setting the system memory to 145MB.
> > That was the minimum amount the KVM system was capable of booting. After
> > that i used kfree rcu tests to simulate memory pressure.
> 
> Ah, ok. I do a similar thing. Thanks for sharing. It would be nice if we can
> both commit something into the tree (like modify the rcu torture KVM scripts
> to simulate this automatically (while also generating memory pressure
> external to RCU).
>
That makes sense.

> > > > > So instead of adding a pool for rcu_head allocations, how do you feel about
> > > > > pre-allocation of the per-cpu cache array instead, which has the same effect
> > > > > as you are intending?
> > > > > 
> > > > In the v2 i have a list of such objects. It is also per-CPU(it is scaled to CPUs),
> > > > but the difference is, those objects require much less memory, it is 8 + sizeof(struct
> > > > rcu_head) bytes comparing to one page. Therefore the memory footprint is lower.
> > > 
> > > Yes, true. That is one drawback is it higher memory usage. But if you have at
> > > least 1 kfree_rcu() request an each CPU, then pre-allocation does not
> > > increase memory usage any more than it already has right now. Unless, we
> > > extend my proposal to cache more than 2 pages per-cpu which I think you
> > > mentioned below.
> > > 
> > If we cache two pages per-CPU, i think that is fine. When it comes to increasing
> > it, it can be a bit wasting. For example consider 128 CPUs system.
> 
> Right, if we could we assume that the system's memory scales with number of
> CPUs, it could be reasonable.
> 
> > > > I have doubts that we would ever hit this emergency list, because of mentioned
> > > > above patch, but from the other hand i can not say and guarantee 100%. Just in
> > > > case, we may keep it. 
> > > 
> > > You really have to hit OOM in your tests to trigger it I suppose. Basically
> > > the emergency pool improves situation under OOM, but otherwise does not
> > > improve it due to the direct-reclaim that happens as you mentioned. Right?
> > >
> > See above how i simulated it. Direct reclaim is our GFP_KERNEL + other flags
> > helper. If even after reclaim process there is no memory, then emergency list
> > is supposed to be used. But we can drop this patch, i mean "emergency list"
> > if we agree on it. The good point would be if you could stress your system
> > by the i did. See above description :)
> 
> Yes I will stress it and make time to do so today :)
>  
> > > > But i think that we should allow to be used two pages as cached ones, no matter 
> > > > whether it is vmalloc ptrs. or SLAB ones. So basically, two cached pages can be
> > > > used by vmalloc path and SLAB path. And probably it makes sense because of two
> > > > phases: one is when we collect pointers, second one is memory reclaim path. Thus
> > > > one page per one phase, i.e. it would be paired.
> > > 
> > > You are saying this with regard to my proposal right?  I agree number of
> > > pages could be increased. The caching mechanism already in-place could be
> > > starting point for that extension.
> > > 
> > We already have two pages. What we need is to allow to use them in both
> > paths, vmalloc one and SLAB one, i mean reclaim path. At least that fits
> > well to the collecting/reclaim phases.
> 
> Ah yes, that's even better.
> 
Good :)

Thanks!

--
Vlad Rezki
