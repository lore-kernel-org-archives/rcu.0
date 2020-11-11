Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC1AC5517A
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 00:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBA621741
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 00:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xjwAOI/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbgKKAUo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Nov 2020 19:20:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732341AbgKKAUn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Nov 2020 19:20:43 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05A5F2064B;
        Wed, 11 Nov 2020 00:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605054043;
        bh=bWmdB9HiE7i+/VtqL0rtsAEkob4NycKFUDaiWI3/xbo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xjwAOI/lLIvzzCpftjpjZgjiSTFE3r7WUj934sgvDAgFI+pOeBQVw10og1UGHX2GL
         Q74aotqUgCcGFOMmBQC7nVkJ1tm0OlYjfy8IBCMhRq5fKzNvSRboW5dIisUYSmaZAS
         27LRAKRry/M8bdEQgWzRapMkhz6P6ddWQWsW1QHk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9420735226CB; Tue, 10 Nov 2020 16:20:42 -0800 (PST)
Date:   Tue, 10 Nov 2020 16:20:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 2/4] docs: Update RCU's hotplug requirements
 with a bit about design
Message-ID: <20201111002042.GY3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
 <20201105230510.18660-2-paulmck@kernel.org>
 <20201109122317.GM2594@hirez.programming.kicks-ass.net>
 <20201109162452.GK3249@paulmck-ThinkPad-P72>
 <20201109171433.GL2611@hirez.programming.kicks-ass.net>
 <20201110203328.GA694269@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110203328.GA694269@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 10, 2020 at 03:33:28PM -0500, Joel Fernandes wrote:
> On Mon, Nov 09, 2020 at 06:14:33PM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 09, 2020 at 08:24:52AM -0800, Paul E. McKenney wrote:
> > > On Mon, Nov 09, 2020 at 01:23:17PM +0100, Peter Zijlstra wrote:
> > > > On Thu, Nov 05, 2020 at 03:05:08PM -0800, paulmck@kernel.org wrote:
> > > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > > 
> > > > > The rcu_barrier() section of the "Hotplug CPU" section discusses
> > > > > deadlocks, however the description of deadlocks other than those involving
> > > > > rcu_barrier() is rather incomplete.
> > > > > 
> > > > > This commit therefore continues the section by describing how RCU's
> > > > > design handles CPU hotplug in a deadlock-free way.
> > > > > 
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > ---
> > > > >  .../RCU/Design/Requirements/Requirements.rst       | 49 +++++++++++++++++-----
> > > > >  1 file changed, 39 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> > > > > index 1ae79a1..98557fe 100644
> > > > > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > > > > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > > > > @@ -1929,16 +1929,45 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
> > > > >  to allow the various kernel subsystems (including RCU) to respond
> > > > >  appropriately to a given CPU-hotplug operation. Most RCU operations may
> > > > >  be invoked from CPU-hotplug notifiers, including even synchronous
> > > > > -grace-period operations such as ``synchronize_rcu()`` and
> > > > > -``synchronize_rcu_expedited()``.
> > > > 
> > > > I was under the impression that this rst crap now recognises func() and
> > > > you no longer need to make the text unreadable with "``".
> > > 
> > > It was there to start with, but good point.  How about the commit
> > > below?
> > 
> > Much appreciated, thanks!
> 
> Thanks for making the change, I built it and it looks good in my web browser
> ;-).
> 
> BTW, these APIs are obsolete due to consolidation. Paul could you remove them
> from the document?:
>  synchronize_rcu_bh(), synchronize_rcu_bh_expedited(), call_rcu_bh(),
>  rcu_barrier_bh().

Like this?

							Thanx, Paul

------------------------------------------------------------------------

commit ade4480b079c508923060d5f31e4f58475e8ea55
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Nov 10 16:17:42 2020 -0800

    doc: Remove obsolete RCU-bh and RCU-sched update-side API members
    
    synchronize_rcu_bh(), synchronize_rcu_bh_expedited(), call_rcu_bh(),
    rcu_barrier_bh(), synchronize_sched(), synchronize_rcu_sched_expedited(),
    call_rcu_sched(), and rcu_barrier_sched() no longer exist, so this
    commit removes mention of them.
    
    Reported-by: Joel Fernandes <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 9b23be6..1e3df77 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2438,13 +2438,13 @@ glance as if rcu_read_unlock_bh() was executing very slowly.
 
 The `RCU-bh
 API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
-includes rcu_read_lock_bh(), rcu_read_unlock_bh(),
-rcu_dereference_bh(), rcu_dereference_bh_check(),
-synchronize_rcu_bh(), synchronize_rcu_bh_expedited(),
-call_rcu_bh(), rcu_barrier_bh(), and
-rcu_read_lock_bh_held(). However, the update-side APIs are now
-simple wrappers for other RCU flavors, namely RCU-sched in
-CONFIG_PREEMPT=n kernels and RCU-preempt otherwise.
+includes rcu_read_lock_bh(), rcu_read_unlock_bh(), rcu_dereference_bh(),
+rcu_dereference_bh_check(), and rcu_read_lock_bh_held(). However, the
+old RCU-bh update-side APIs are now gone, replaced by synchronize_rcu(),
+synchronize_rcu_expedited(), call_rcu(), and rcu_barrier().  In addition,
+anything that disables bottom halves also marks an RCU-bh read-side
+critical section, including local_bh_disable() and local_bh_enable(),
+local_irq_save() and local_irq_restore(), and so on.
 
 Sched Flavor (Historical)
 ~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2481,13 +2481,13 @@ The `RCU-sched
 API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
 includes rcu_read_lock_sched(), rcu_read_unlock_sched(),
 rcu_read_lock_sched_notrace(), rcu_read_unlock_sched_notrace(),
-rcu_dereference_sched(), rcu_dereference_sched_check(),
-synchronize_sched(), synchronize_rcu_sched_expedited(),
-call_rcu_sched(), rcu_barrier_sched(), and
-rcu_read_lock_sched_held(). However, anything that disables
-preemption also marks an RCU-sched read-side critical section, including
-preempt_disable() and preempt_enable(), local_irq_save() and
-local_irq_restore(), and so on.
+rcu_dereference_sched(), rcu_dereference_sched_check(), and
+rcu_read_lock_sched_held().  However, the old RCU-sched update-side APIs
+are now gone, replaced by synchronize_rcu(), synchronize_rcu_expedited(),
+call_rcu(), and rcu_barrier().  In addition, anything that disables
+preemption also marks an RCU-sched read-side critical section,
+including preempt_disable() and preempt_enable(), local_irq_save()
+and local_irq_restore(), and so on.
 
 Sleepable RCU
 ~~~~~~~~~~~~~
