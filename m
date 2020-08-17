Return-Path: <SRS0=6ydw=B3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48467C433E3
	for <rcu@archiver.kernel.org>; Mon, 17 Aug 2020 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31496207DF
	for <rcu@archiver.kernel.org>; Mon, 17 Aug 2020 08:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgHQIr7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:47:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgHQIrW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Aug 2020 04:47:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E9B4AE8C;
        Mon, 17 Aug 2020 08:47:45 +0000 (UTC)
Date:   Mon, 17 Aug 2020 10:47:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20200817084719.GB28270@dhcp22.suse.cz>
References: <20200814180141.GP4295@paulmck-ThinkPad-P72>
 <87tux4kefm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tux4kefm.fsf@nanos.tec.linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat 15-08-20 01:14:53, Thomas Gleixner wrote:
[...]
> For normal operations a couple of pages which can be preallocated are
> enough. What you are concerned of is the case where you run out of
> pointer storage space.
> 
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
> 
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
>
> Allocating from softirq context obviously without holding the raw lock
> which is used inside call_rcu() is safe on all configurations.
> 
> If call_rcu() is forced to use the fallback for a few calls until this
> happens then that's not the end of the world. It is not going to be a
> problem ever for the most obvious issue #1, user space madness, because
> that case cannot delay the softirq processing unless there is a kernel
> bug which makes again RCU free performance irrelevant.

Yes, this makes perfect sense to me! I really do not think we want to
optimize for a userspace abuse to allow complete pcp allocator memory
depletion (or a control in a worse case).

Thanks!
-- 
Michal Hocko
SUSE Labs
