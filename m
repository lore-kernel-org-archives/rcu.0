Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336B9C433E1
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 23:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A2E20774
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 23:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597448514;
	bh=FzmKCSuvlnQSutoeFKZLpced03nZwnLQu3EFKkVtkgw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=G3OhejqMaOreeB9v/vLpDO7CTCdlbTa1Mcs6UXbD1Q7EU0uVRVF0J2kh3iY6tfHN9
	 lZsgjT/q9HhSVd8fu3ofIG9zfpxoPxSdrgqmZD1JobLoK8XPvBwDIrENspm7mzCRH/
	 SYYBd+RaeI0bwd5IZ9v9lMB/BIKhmlhgS19WiU/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHNXlx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 19:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNXlx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 19:41:53 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CDA82074D;
        Fri, 14 Aug 2020 23:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597448512;
        bh=FzmKCSuvlnQSutoeFKZLpced03nZwnLQu3EFKkVtkgw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g3xoK1Vla6+fNtyY01c6ScHQfhBD3ox9/jfqedv+53J2ImF3QqV91hqE2pNCGxS9o
         aEt1OMIZjjajSmVt+rPRT3+WDAj6lfGm/Db7Hzo2NrRq8CMaPgThU5JnUUCZe4dOxa
         PPkq5qH83GOqLsjZFHwgSm8/2eYLYQDdy1BoCrnM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 368513522B27; Fri, 14 Aug 2020 16:41:52 -0700 (PDT)
Date:   Fri, 14 Aug 2020 16:41:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200814234152.GV4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200814180141.GP4295@paulmck-ThinkPad-P72>
 <87tux4kefm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tux4kefm.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Aug 15, 2020 at 01:14:53AM +0200, Thomas Gleixner wrote:
> Paul,
> 
> On Fri, Aug 14 2020 at 11:01, Paul E. McKenney wrote:
> > On Fri, Aug 14, 2020 at 04:06:04PM +0200, Michal Hocko wrote:
> >> > > > Vlastimil raised same question earlier, i answered, but let me answer again:
> >> > > > 
> >> > > > It is hard to achieve because the logic does not stick to certain static test
> >> > > > case, i.e. it depends on how heavily kfree_rcu(single/double) are used. Based
> >> > > > on that, "how heavily" - number of pages are formed, until the drain/reclaimer
> >> > > > thread frees them.
> >> > > 
> >> > > How many pages are talking about - ball park? 100s, 1000s?
> >> > 
> >> > Under normal operation, a couple of pages per CPU, which would make
> >> > preallocation entirely reasonable.  Except that if someone does something
> >> > that floods RCU callbacks (close(open) in a tight userspace loop, for but
> >> > one example), then 2000 per CPU might not be enough, which on a 64-CPU
> >> > system comes to about 500MB.  This is beyond excessive for preallocation
> >> > on the systems I am familiar with.
> >> > 
> >> > And the flooding case is where you most want the reclamation to be
> >> > efficient, and thus where you want the pages.
> 
> As we now established that taking zone lock is impossible at all
> independent of raw/non-raw ordering and independent of RT/PREEMPT
> configs, can we just take a step back and look at the problem from
> scratch again?

Can't hurt!  (Famous last words...)

> As a matter of fact I assume^Wdeclare that removing struct rcu_head which
> provides a fallback is not an option at all. I know that you want to,
> but it wont work ever. Dream on, but as we agreed on recently there is
> this thing called reality which ruins everything.

For call_rcu(), agreed.  For kfree_rcu(), we know what the callback is
going to do, plus single-argument kfree_rcu() can only be invoked from
sleepable context.  (If you want to kfree_rcu() from non-sleepable
context, that will cost you an rcu_head in the data structure being
freed.)

So if the single-argument kfree_rcu() case gets hit with a
memory-allocation failure, it can fall back to waiting for a grace
period and doing the free.  Of course, grace-period waits have horrible
latency, but under OOM life is hard.  If this becomes a problem in
non-OOM situations due to the lockless caches becoming empty, we will
have to allocate memory if needed before acquiring the lock with the
usual backout logic.  Doing that means that we can let the allocator
acquire locks and maybe even do a little bit of blocking, so that the
inline grace-period-wait would only happen if the system was well and
truly OOMed.

> For normal operations a couple of pages which can be preallocated are
> enough. What you are concerned of is the case where you run out of
> pointer storage space.

Agreed.

> There are two reasons why that can happen:
> 
>       1) RCU call flooding
>       2) RCU not being able to run and mop up the backlog
> 
> #1 is observable by looking at the remaining storage space and the RCU
>    call frequency
> 
> #2 is uninteresting because it's caused by RCU being stalled / delayed
>    e.g. by a runaway of some sorts or a plain RCU usage bug.
>    
>    Allocating more memory in that case does not solve or improve anything.

Yes, #2 is instead RCU CPU stall warning territory.

If this becomes a problem, one approach is to skip the page-of-pointers
allocation if the grace period is more than (say) one second old.  If
the grace period never completes, OOM is unavoidable, but this is a way
of putting it off for a bit.

> So the interesting case is #1. Which means we need to look at the
> potential sources of the flooding:
> 
>     1) User space via syscalls, e.g. open/close
>     2) Kernel thread
>     3) Softirq
>     4) Device interrupt
>     5) System interrupts, deep atomic context, NMI ...
> 
> #1 trivial fix is to force switching to an high prio thread or a soft
>    interrupt which does the allocation
> 
> #2 Similar to #1 unless that thread loops with interrupts, softirqs or
>    preemption disabled. If that's the case then running out of RCU
>    storage space is the least of your worries.
> 
> #3 Similar to #2. The obvious candidates (e.g. NET) for monopolizing a
>    CPU have loop limits in place already. If there is a bug which fails
>    to care about the limit, why would RCU care and allocate more memory?
> 
> #4 Similar to #3. If the interrupt handler loops forever or if the
>    interrupt is a runaway which prevents task/softirq processing then
>    RCU free performance is the least of your worries.
> 
> #5 Clearly a bug and making RCU accomodate for that is beyond silly.
> 
> So if call_rcu() detects that the remaining storage space for pointers
> goes below the critical point or if it observes high frequency calls
> then it simply should force a soft interrupt which does the allocation.

Unless call_rcu() has been invoked with scheduler locks held.  But
eventually call_rcu() should be invoked with interrupts enabled, and at
that point it would be safe to raise_softirq(), wake_up(), or whatever.

> Allocating from softirq context obviously without holding the raw lock
> which is used inside call_rcu() is safe on all configurations.

Once we get there, agreed.

> If call_rcu() is forced to use the fallback for a few calls until this
> happens then that's not the end of the world. It is not going to be a
> problem ever for the most obvious issue #1, user space madness, because
> that case cannot delay the softirq processing unless there is a kernel
> bug which makes again RCU free performance irrelevant.
> 
> So this will cure the problem for the most interesting case #1 and
> handle all sane variants of the other possible flooding sources.
> 
> The other insane reasons do not justify any attempt to increase RCU
> performance at all.
> 
> Watching the remaining storage space is good enough IMO. It clearly
> covers #1 and for all others the occasional fallback wont hurt. If it
> really matters for any case > #1 then doing a frequency based prediction
> is a straight forward optimization.
> 
> As usual I might be missing something, but as this is the second day
> with reasonable temperatures here that would be caused by my ignorance
> and not be excusable by brain usage outside of specified temperature
> range.

It is at the very least a new approach, so either way thank you for
that!  ;-)

							Thanx, Paul
