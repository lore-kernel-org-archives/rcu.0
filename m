Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC1FC433E1
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 23:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C9020771
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 23:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YHuXBoLt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ug8CUPyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHNXO4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 19:14:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39602 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNXO4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 19:14:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597446893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=K5QW3exzHL8KDx4u+BgSGpyR6VanL3c8Yzy1ofxD9zM=;
        b=YHuXBoLtgIAUjJafXipuiAXQpZ1pb7hK/0ek1ICliMV8kHNGNlS5inxh4pRh1BrRwHc3YF
        BALdU7KhDHkoRrhwPe7NYZn7VbDJZezUpg/Ngy2u9iHf/6g9qpKIPM8JheUSDn/6FgnYxB
        xJ+yuUAaUnKh9bMlU+kJTeH0Yzts5aoeefV/CMug/ihlRYgPp7up2miTfXV9ttYCfK9e4Q
        etPpJgJNmgi28JvG66rCkkSNewU5fSUebaBEdV/XVGqfOd5qNZKH7lR2Ar9ERiqaRIeApD
        DLb7BmbCLPanDn4/OwaXRiJ067ADf8MbI8S+VVK+iJvRGsgcINh28vDPwi1prg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597446893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=K5QW3exzHL8KDx4u+BgSGpyR6VanL3c8Yzy1ofxD9zM=;
        b=ug8CUPyXjQ1YNWjX9lBB9/qLboibnoi2Ai4G2KOgEttAyWCikIxum+PhoSbtJkGIcbDJP9
        KJczEmzkE9xxaJCg==
To:     paulmck@kernel.org, Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
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
In-Reply-To: <20200814180141.GP4295@paulmck-ThinkPad-P72>
Date:   Sat, 15 Aug 2020 01:14:53 +0200
Message-ID: <87tux4kefm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Paul,

On Fri, Aug 14 2020 at 11:01, Paul E. McKenney wrote:
> On Fri, Aug 14, 2020 at 04:06:04PM +0200, Michal Hocko wrote:
>> > > > Vlastimil raised same question earlier, i answered, but let me answer again:
>> > > > 
>> > > > It is hard to achieve because the logic does not stick to certain static test
>> > > > case, i.e. it depends on how heavily kfree_rcu(single/double) are used. Based
>> > > > on that, "how heavily" - number of pages are formed, until the drain/reclaimer
>> > > > thread frees them.
>> > > 
>> > > How many pages are talking about - ball park? 100s, 1000s?
>> > 
>> > Under normal operation, a couple of pages per CPU, which would make
>> > preallocation entirely reasonable.  Except that if someone does something
>> > that floods RCU callbacks (close(open) in a tight userspace loop, for but
>> > one example), then 2000 per CPU might not be enough, which on a 64-CPU
>> > system comes to about 500MB.  This is beyond excessive for preallocation
>> > on the systems I am familiar with.
>> > 
>> > And the flooding case is where you most want the reclamation to be
>> > efficient, and thus where you want the pages.

As we now established that taking zone lock is impossible at all
independent of raw/non-raw ordering and independent of RT/PREEMPT
configs, can we just take a step back and look at the problem from
scratch again?

As a matter of fact I assume^Wdeclare that removing struct rcu_head which
provides a fallback is not an option at all. I know that you want to,
but it wont work ever. Dream on, but as we agreed on recently there is
this thing called reality which ruins everything.

For normal operations a couple of pages which can be preallocated are
enough. What you are concerned of is the case where you run out of
pointer storage space.

There are two reasons why that can happen:

      1) RCU call flooding
      2) RCU not being able to run and mop up the backlog

#1 is observable by looking at the remaining storage space and the RCU
   call frequency

#2 is uninteresting because it's caused by RCU being stalled / delayed
   e.g. by a runaway of some sorts or a plain RCU usage bug.
   
   Allocating more memory in that case does not solve or improve anything.

So the interesting case is #1. Which means we need to look at the
potential sources of the flooding:

    1) User space via syscalls, e.g. open/close
    2) Kernel thread
    3) Softirq
    4) Device interrupt
    5) System interrupts, deep atomic context, NMI ...

#1 trivial fix is to force switching to an high prio thread or a soft
   interrupt which does the allocation

#2 Similar to #1 unless that thread loops with interrupts, softirqs or
   preemption disabled. If that's the case then running out of RCU
   storage space is the least of your worries.

#3 Similar to #2. The obvious candidates (e.g. NET) for monopolizing a
   CPU have loop limits in place already. If there is a bug which fails
   to care about the limit, why would RCU care and allocate more memory?

#4 Similar to #3. If the interrupt handler loops forever or if the
   interrupt is a runaway which prevents task/softirq processing then
   RCU free performance is the least of your worries.

#5 Clearly a bug and making RCU accomodate for that is beyond silly.

So if call_rcu() detects that the remaining storage space for pointers
goes below the critical point or if it observes high frequency calls
then it simply should force a soft interrupt which does the allocation.

Allocating from softirq context obviously without holding the raw lock
which is used inside call_rcu() is safe on all configurations.

If call_rcu() is forced to use the fallback for a few calls until this
happens then that's not the end of the world. It is not going to be a
problem ever for the most obvious issue #1, user space madness, because
that case cannot delay the softirq processing unless there is a kernel
bug which makes again RCU free performance irrelevant.

So this will cure the problem for the most interesting case #1 and
handle all sane variants of the other possible flooding sources.

The other insane reasons do not justify any attempt to increase RCU
performance at all.

Watching the remaining storage space is good enough IMO. It clearly
covers #1 and for all others the occasional fallback wont hurt. If it
really matters for any case > #1 then doing a frequency based prediction
is a straight forward optimization.

As usual I might be missing something, but as this is the second day
with reasonable temperatures here that would be caused by my ignorance
and not be excusable by brain usage outside of specified temperature
range.

Thanks,

        tglx
