Return-Path: <SRS0=Gqt/=DB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B430C4346E
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 08:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96CB2068D
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 08:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYDD0pdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgIXIQT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Sep 2020 04:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgIXIQT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Sep 2020 04:16:19 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDA5C0613CE;
        Thu, 24 Sep 2020 01:16:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r24so1969805ljm.3;
        Thu, 24 Sep 2020 01:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGttQUHU3VMLdG3ISn/0sLGZfIHFPGJzDYKZXK6egIA=;
        b=oYDD0pdL2Zd2qzRGqD+QK0m7JLldwjpKUnDtlKq2dUYxeTIuXMpkxtA/6jwlLHllZ8
         EdW8WupREg/d+T9BLg/DDRreeUjgCmmylPHcRCDR1HATMBfzZsADxvUPzGeGO7LCi5Na
         Q0A9d27WRc60lg0xw2gXoBpShrwQa23QtTB6YWwg2DP1KcI9dyHXwc5rZQ1sSYftRrkI
         gL/T5znpPzqtTyDchRk2xpMfETdXMxgijR+liEGJESZk2EPPaEnxtpSRMYEnu+DfUCwL
         sby89NEAYGOizr5vkhP8rFUVAcUjYAhGftZEtmFuNiKuRDNNNusVvjHzaej0Xx7CqbEH
         yNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGttQUHU3VMLdG3ISn/0sLGZfIHFPGJzDYKZXK6egIA=;
        b=Fx2hlDdx+qWLyi+yDRL8h+psEN820WUi2FpwfTF5zbqZxUktk5k4kQftuYtfijMLMp
         6j8xs4vq7TIKl4428E/rQ7PvW2cPT7BR4C9Y7ULGmIQ48vCyKrastmbq+IERALwipSQY
         VQ4BEUpqNy2ZnfJv9XKtEtcY5l0nIOgB7GjbgcJHlF66W0UL75+9rgwX0Ehk44Jkf+/l
         3apBu1UoS53goKQ7LhX2kG53zpUvllX8sVz/pN7bLAOlqM07dEomtjJX+azoMkZ7Gl21
         uCOFQ09XLMiuF1VIM8mGCx1KFiJQgJFu5QaW7SpC529hPxlcEus2IuxEsHQm9cJy9ZOH
         V75A==
X-Gm-Message-State: AOAM533I83oj9MnzFuI+LZoP0c+ZF+DGfc+g2frs6MeKQmsydoqCuVAX
        0tkHfinrKSLSUbaMEzAidnA=
X-Google-Smtp-Source: ABdhPJwiKdhvXtRf3+iQmtoTxJaIvL6+1+lQ3Uxzl5kDRP7cKmgcux7rsYxlxQfDcTfNKecgnQ3lZw==
X-Received: by 2002:a2e:87c7:: with SMTP id v7mr1314573ljj.13.1600935377074;
        Thu, 24 Sep 2020 01:16:17 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id n20sm1409361lfh.1.2020.09.24.01.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 01:16:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 24 Sep 2020 10:16:14 +0200
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200924081614.GA14819@pc636>
References: <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923232251.GK3179@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On Wed, Sep 23, 2020 at 08:41:05AM -0700, Paul E. McKenney wrote:
> > > Fundamentally, this is simply shifting the problem from RCU to the page
> > > allocator because of the locking arrangements and hazard of acquiring zone
> > > lock is a raw spinlock is held on RT. It does not even make the timing
> > > predictable as an empty PCU list (for example, a full drain in low memory
> > > situations) may mean the emergency path is hit anyway. About all it changes
> > > is the timing of when the emergency path is hit in some circumstances --
> > > it's not fixing the problem, it's simply changing the shape.
> > 
> > All good points!
> > 
> > On the other hand, duplicating a portion of the allocator functionality
> > within RCU increases the amount of reserved memory, and needlessly most
> > of the time.
> > 
> 
> But it's very similar to what mempools are for.
> 
As for dynamic caching or mempools. It requires extra logic on top of RCU
to move things forward and it might be not efficient way. As a side
effect, maintaining of the bulk arrays in the separate worker thread
will introduce other drawbacks:

 a) There is an extra latency window, a time during which a fallback
    mechanism is used until pages are obtained via the special
    worker for further pointers collecting over arrays.

 b) It is impossible to predict how many pages will be required to
    cover a demand that is controlled by different workloads on
    various systems. It would require a rough value.

 c) extra memory footprint.

Why a special worker is required. It is because non-sleeping flags, like
GFP_ATOMIC or GFP_NOWAIT apparently can be sleeping what is not supposed.
Therefore we proposed lock-less flag as a first step, and later a lock-less
function.

Other option is if we had unconditionally enabled PREEMPT_COUNT config.
It would be easy to identify a context type and invoke a page allocator
if a context is preemtale. But as of now preemptable() is "half" working.
Thomas uploaded patches to make it unconditional. But it can be blocked.

If both are not accepted, we will need to workaround it with dynamic
caching, at least for !PREEMPT kernel.

> > Is there some way that we can locklessly allocate memory, but return
> > failure instead of running down the emergency pool? A change to the loop
> > that iterates over the migration types?  Or to the loop that iterates
> > over the zones?  Something else?
> > 
> 
> Only by duplicating some of the logic in get_page_from_freelist would
> protect the reserves. Even if you had that, the contents of the pcp
> pools can easily be zero for the local CPU and you still get stuck.
> 
We have a special worker that is triggered when a lock-less alloc fails.
The worker we have, by requesting a new page will also initiate an internal
process that prefetches specified number of elements from the buddy allocator
populating the "pcplist" by new fresh pages.

> > > > > Mimicing a similar implementation shouldn't be all that hard
> > > > > and you will get your own pool which doesn't affect other page allocator
> > > > > users as much as a bonus.
> > > > > 
> > > > I see your point Michal. As i mentioned before, it is important to avoid of
> > > > having such own pools, because the aim is not to waste memory resources. A
> > > > page will be returned back to "page allocator" as soon as a scheduler place  
> > > > our reclaim thread on a CPU and grace period is passed. So, the resource
> > > > can be used for other needs. What is important.
> > > 
> > > As the emergency path and synchronising can be hit no matter what, why
> > > not increase the pool temporarily after the emergency path is hit and
> > > shrink it again later if necessary?
> > 
> > If I understand what you are suggesting, this is in fact what Uladzislau's
> > prototyped commit 8c0a1269709d ("rcu/tree: Add a work to allocate
> > pages from regular context") on the -rcu "dev" branch is intended to do.
> > The issue, as Uladislau noted above, is that scheduler delays can prevent
> > these pool-increase actions until the point at which there is no memory.
> > 
> 
> Scheduler latency would be a problem. You would have to keep an emergency
> "rescue" pool that is enough to make slow progress even if no other memory
> is available until the worker takes action. The worker that allocates
> pages from regular context would be to increase the pool size enough so
> the emergency reserve does not have to be used again in the near future.
> 
The key point is "enough". We need pages to make a) fast progress b) support
single argument of kvfree_rcu(one_arg). Not vice versa. That "enough" depends
on scheduler latency and vague pre-allocated number of pages, it might
be not enough what would require to refill it more and more or we can overshoot
that would lead to memory overhead. So we have here timing issues and
not accurate model. IMHO.

> > > > Otherwise a memory footprint is increased what is bad for low memory
> > > > conditions when OOM is involved.
> > > 
> > > OOM would only be a major factor if the size of the pools meant the
> > > machine could not even operate or at least was severely degraded. However,
> > > depleting the PCPU lists for RCU may slow kswapd making reclaim progress
> > > and cause an OOM in itself, or at least an intervention by a userspace
> > > monitor that kills non-critical applications in the background when memory
> > > pressure exists.
> > 
> > When under emergency conditions, we have one page allocated per 500
> > objects passed to kvfree_rcu().  So the increase in total allocated
> > memory load due to this emergency path is quite small.
> > 
> 
> Fair enough but any solution that depends on the PCP having even one
> page available is going to need a fallback option of some sort.
> 
We have a fallback mechanism.

> > > > > > As for memory overhead, it is important to reduce it because of
> > > > > > embedded devices like phones, where a low memory condition is a
> > > > > > big issue. In that sense pre-allocating is something that we strongly
> > > > > > would like to avoid.
> > > > > 
> > > > > How big "machines" are we talking about here? I would expect that really
> > > > > tiny machines would have hard times to really fill up thousands of pages
> > > > > with pointers to free...
> > > > > 
> > > > I mentioned above. We can not rely on static model. We would like to
> > > > have a mechanism that gives back ASAP used pages to page allocator
> > > > for other needs.
> > > 
> > > After an emergency, temporarily increase the size of the pool to avoid
> > > hitting the emergency path again in the near future.
> > 
> > By which time we might well already be in OOM territory.  The emergency
> > situations can ramp up very quickly.
> > 
> 
> And if the pcp lists are empty, this problem still exists -- pretty much
> anything that depends on the pcp lists always having pages is going to
> have a failure case.
> 
But it is enough just to trigger __get_free_page() on that CPU, so the PCP
will be populated. What we do in a separate worker.

> > > > > Would a similar scaling as the page allocator feasible. Really I mostly
> > > > > do care about shared nature of the pcp allocator list that one user can
> > > > > easily monopolize with this API.
> > > > > 
> > > > I see your concern. pcplist can be monopolized by already existing API:
> > > > 
> > > >     while (i < 100)
> > > >         __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > > 
> > > That's not the same class of abuse as it can go to the buddy lists to
> > > refill the correct PCP lists, avoid fragmentation issues, obeys watermarks
> > > and wakes kswapd if it's not awake already.
> > 
> > Good point, and we did try doing it this way.  Unfortunately, in current
> > !PREEMPT kernels, this approach can deadlock on one of the allocator
> > locks via call_rcu().  This experience caused us to look at lockless
> > allocator access.  It also inspired the unconditional PREEMPT_COUNT
> > approach, but that has its own detractors.  (Yes, we are of course still
> > persuing it as well.)
> > 
> 
> I didn't keep up to date unfortunately but pretty much anything that
> needs guaranteed access to pages has to maintain a mempool of some sort.
> Even if the page allocator had a common pool for emergency use, it would
> be subject to abuse because all it would take is one driver or subsystem
> deciding that it was special enough to deplete it. For example, the ml4
> driver decided that it should declare itself to be a "memory allocator"
> like kswapd for iSCSI (it claims swap-over-nfs, but swap-over-nfs was
> only meant to apply when a swapfile was backed by a network fs).
> 
We do not want to have many different memory allocators for sure :)

As it was noted above. GFP_ATOMIC/GFP_NOWAIT can sleep what is a problem
for atomic context. That is why we have proposed a lock-less way of getting
a page and you are not happy with that :) Other option is unconditionally
enable PREEMPT_COUNT config. That would help a lot not only for RCU but
also for others if they can use of GFP_ATOMIC/GFP_NOWAIT and similar.

Appreciate for comments.

--
Vlad Rezki
