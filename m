Return-Path: <SRS0=wfWh=5X=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BD6C2BB1D
	for <rcu@archiver.kernel.org>; Tue,  7 Apr 2020 01:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72608206C0
	for <rcu@archiver.kernel.org>; Tue,  7 Apr 2020 01:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="acA8eNjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDGBrK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:47:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39871 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgDGBrJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Apr 2020 21:47:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id b62so155435qkf.6
        for <rcu@vger.kernel.org>; Mon, 06 Apr 2020 18:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=it7Sl4XJV8sr3uWUaSpf5IpDHLo3zFcDYRyOXrto1zg=;
        b=acA8eNjUgGW+WNIrrMA1PmZ9NXs+M/Z8oHZgW7gH0gPEtuSObad7rAi+AysuXk85gg
         jsCQ6bSELmnxE9E2w+st3YU4/fLQ5PqVrPu6dIONNExe2NwMwWsEEYZUUIFd5tRieZW0
         T2jtmWrJScRRJkKv4rP4bNU8v972WUsMldh5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=it7Sl4XJV8sr3uWUaSpf5IpDHLo3zFcDYRyOXrto1zg=;
        b=MK6i88bNjckKQ8cQ8l9wuI8hHlVEcocR+37qEj0byG0mtvI99q+uccBNKhnNZ6uhFK
         U1vop1TnZvAUpVgGLFXzRRcXR/AnrmbajmeJ+K8hyRt2DeMYHPGWBnB++gLA80soMCx1
         TCmEypvPh5HDSQJNadovYn7oDVHvqfhcIrtcaMx+xYneBoBFweaO0vWRxyb3Dmde8C72
         Wt7GP4mrz6m26mbL1fGlSXuxyZR7m2k30prGIIc1muGNK8WlisqyMr6c4GK+t3YcV1+l
         KQLEJ0jxFiQCvtLk2GOGnyltkZSWtX0V1OfJaOl+2rmiVUUFwyR27j+MA2uOj+FCD0uC
         VEcA==
X-Gm-Message-State: AGi0PubiGTPB7vRnOXX4ykOFFW4R8cFx9U8nOhHQGB52mIVed4yKfFcj
        hCI9T3R/pL7WI1+rpzrcgqXc3g==
X-Google-Smtp-Source: APiQypI8N5S0mC8WSQKuIn5uRNOLIXiPoFJgFirmckJmZSLBdAPlSimlMsFFfJ/7rdG427LN5MyWPQ==
X-Received: by 2002:a05:620a:81c:: with SMTP id s28mr19266022qks.147.1586224026227;
        Mon, 06 Apr 2020 18:47:06 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r34sm16701941qtk.89.2020.04.06.18.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:47:05 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:47:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Message-ID: <20200407014705.GC11326@google.com>
References: <20200403173051.4081-1-urezki@gmail.com>
 <20200404195129.GA83565@google.com>
 <20200405172105.GA7539@pc636>
 <20200405233028.GC83565@google.com>
 <20200406125640.GA23256@pc636>
 <20200406151851.GF83565@google.com>
 <20200406161708.GA3919@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406161708.GA3919@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 06, 2020 at 06:17:08PM +0200, Uladzislau Rezki wrote:
> On Mon, Apr 06, 2020 at 11:18:51AM -0400, Joel Fernandes wrote:
> > Hi Vlad,
> > 
> > On Mon, Apr 06, 2020 at 02:56:40PM +0200, Uladzislau Rezki wrote:
> > > Hello, Joel.
> > > 
> > > > > > 
> > > > > > Hi Vlad,
> > > > > > 
> > > > > > One concern I have is this moves the problem a bit further down. My belief is
> > > > > > we should avoid the likelihood of even needing an rcu_head allocated for the
> > > > > > headless case, to begin with - than trying to do damage-control when it does
> > > > > > happen. The only way we would end up needing an rcu_head is if we could not
> > > > > > allocate an array.
> > > > > > 
> > > > > Let me share my view on all such caching. I think that now it becomes less as
> > > > > the issue, because of we have now https://lkml.org/lkml/2020/4/2/383 patch.
> > > > > I see that it does help a lot. I tried to simulate low memory condition and 
> > > > > apply high memory pressure with that. I did not manage to trigger the
> > > > > "synchronize rcu" path at all. It is because of using much more permissive
> > > > > parameters when we request a memory from the SLAB(direct reclaim, etc...).
> > > > 
> > > > That's a good sign that we don't hit this path in your tests.
> > > > 
> > > Just one request, of course if you have a time :)
> > > Could you please double check on your test environment to stress the system
> > > to check if you also can not hit it?
> > 
> > Sure, I am planning to do so and happy to spend time on it :) One question I
> > had about the below test:
> > 
> > > How i test it. Please apply below patch:
> > > <snip>
> > > t a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 5e26145e9ead..25f7ac8583e1 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3203,6 +3203,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  
> > >         if (head) {
> > >                 ptr = (void *) head - (unsigned long) func;
> > > +               head = NULL;
> > >         } else {
> > >                 /*
> > >                  * Please note there is a limitation for the head-less
> > > @@ -3233,16 +3234,18 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >          * Under high memory pressure GFP_NOWAIT can fail,
> > >          * in that case the emergency path is maintained.
> > >          */
> > > -       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> > > -       if (!success) {
> > > +       /* success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr); */
> > 
> > If you drop this, then it is not realistic right? I mean it changes behavior
> > of the code completely. We need to try to allocate array and then try to
> > allocate the head.
> > 
> That just bypasses an allocation for the array, to make it more simple
> and move forward toward the path we would like to test. Also head is
> set to NULL to simulated headless freeing.

Makes sense, I know you are forcing code to invoke the bad case more often
but I was concerned the hack would change dynamics of code enough to make it
an unrealistic situation. But I see your point.

> > > +       /* if (!success) { */
> > >                 /* Is headless object? */
> > >                 if (head == NULL) {
> > >                         /* Drop the lock. */
> > >                         krc_this_cpu_unlock(krcp, flags);
> > >  
> > >                         head = attach_rcu_head_to_object(ptr);
> > > -                       if (head == NULL)
> > > +                       if (head == NULL) {
> > > +                               success = false;
> > >                                 goto inline_return;
> > > +                       }
> > >  
> > >                         /* Take it back. */
> > >                         krcp = krc_this_cpu_lock(&flags);
> > > @@ -3267,7 +3270,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >                  */
> > >                 expedited_drain = true;
> > >                 success = true;
> > > -       }
> > > +       /* } */
> > >  
> > >         WRITE_ONCE(krcp->count, krcp->count + 1);
> > >  
> > > @@ -3297,7 +3300,9 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >                 if (!rcu_kfree_nowarn)
> > >                         WARN_ON_ONCE(1);
> > >                 debug_rcu_head_unqueue(ptr);
> > > -               synchronize_rcu();
> > > +               /* synchronize_rcu(); */
> > > +               printk(KERN_ERR "-> hit synchronize_rcu() path.\n");
> > > +               trace_printk("-> hit synchronize_rcu() path.\n");
> > >                 kvfree(ptr);
> > >         }
> > >  }
> > > <snip>
> > > 
> > > lower the memory size and run kfree rcu tests. It would be appreciated.
> > 
> > I am happy to try out the diff if I can understand how the above diff is
> > close enough with current code's behavior, if we are not using the array. One
> > other issue with current kfree rcu tests is, the test is itself the reason
> > for the pressure -- I believe we should also have some testing that shows
> > that the memory pressure is caused else where (such as a real user workload
> > causing OOM), and then we see how RCU behaves under OOM -- if we have too
> > many synchronous latencies, does the additional caching remove such latenies
> > under OOM? etc.  I also want to look into your vmalloc tests.
> > 
> Of course to have real tests would be good. 

Agreed.

> > > > I guess also, with your latest patch on releasing the lock to be in a
> > > > non-atomic context, and then doing the allocation, it became even more
> > > > permissive? If you drop that patch and tried, do you still not hit the
> > > > synchronous path more often?
> > > > 
> > > Yep. If i drop the patch, i can hit it.
> > 
> > Ah, cool. So basically the direct-reclaim path does the synchronous waiting,
> > instead of synchronize_rcu(). Either way, we wait synchronously. How to chose
> > which way is better though? If direct reclaim improves the memory situation,
> > then we should enter that path. But if direct reclaim takes too much time
> > (thus hurting the kfree_rcu() latency), then perhaps it is better for
> > kfree_rcu() to just do the synchronize_rcu() and let someone else enter the
> > direct-reclaim path. We should probably quantify and see which approach works
> > better.
> > 
> I see at it like, headless variant has to be called from the sleeping context, 
> therefore it can sleep. What is better to call synchronize_rcu() or doing direct
> reclaim depends on how many CPUs in a system we have. I suspect that doing
> direct reclaim is better, at least it will free some memory for us. We
> could also extend that patch and make it a bit different, for example do
> NOWAIT then try ATOMIC and as a last step do GFP_KERNEL alloc.

Yes, that's a good idea. That way perhaps we reduce chance that kfree_rcu()
enters into direct-reclaim. Let us do it that way. At least I don't see any
drawbacks in such approach.

thanks,

 - Joel

