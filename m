Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90770C4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 20:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E48860F5E
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 20:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhG1U2E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 16:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhG1U2E (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 16:28:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6014160EFD;
        Wed, 28 Jul 2021 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627504082;
        bh=mDANJfndp1mrqXexaXtgO0Wp0zwi8GJd4lmtmNQSCCc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VMjIKHqVtUut88Hqm46jsVwb+olIx7zBS9WUFLQZNh2yVUreOh9tIl50lXJQ6hGj/
         cPNGzLSssAuLRSrNIwuaWinayPrWWgUq70HCwfiAsldcjoDfap0xtUT83JpXlxYbh6
         lx/DV0RkP4wmTkemmaw6+JcGt9EKcw0LKzdALNPXyJN0snvFh4CNP38xUFHJCyV3iD
         pynpOGI0CNHyJk15VJCr+FfzW9ZcEwS71lglN8pnijTddFtyHQCMWSjLPCxWQh9S4C
         ow1eXz24ZdPUeb/6qs07xESFl4jHlwTSZhLIqlRQ+kIe655sGkZwLBd4QmJnzAF89a
         ZbvERmytll2aQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 281155C048D; Wed, 28 Jul 2021 13:28:02 -0700 (PDT)
Date:   Wed, 28 Jul 2021 13:28:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <20210728202802.GL4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
 <2135064974.9081.1627496585724.JavaMail.zimbra@efficios.com>
 <20210728185854.GK4397@paulmck-ThinkPad-P17-Gen-1>
 <20210728194505.GA1500024@paulmck-ThinkPad-P17-Gen-1>
 <874308613.9545.1627502582005.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874308613.9545.1627502582005.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 28, 2021 at 04:03:02PM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 28, 2021, at 3:45 PM, paulmck paulmck@kernel.org wrote:
> [...]
> > 
> > And how about like this?
> > 
> >						Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit cb8914dcc6443cca15ce48d937a93c0dfdb114d3
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Wed Jul 28 12:38:42 2021 -0700
> > 
> >    rcu: Move rcu_dynticks_eqs_online() to rcu_cpu_starting()
> >    
> >    The purpose of rcu_dynticks_eqs_online() is to adjust the ->dynticks
> >    counter of an incoming CPU if required.  It is currently is invoked
> 
> "is currently is" -> "is currently"

Good catch, fixed!

> >    from rcutree_prepare_cpu(), which runs before the incoming CPU is
> >    running, and thus on some other CPU.  This makes the per-CPU accesses in
> >    rcu_dynticks_eqs_online() iffy at best, and it all "works" only because
> >    the running CPU cannot possibly be in dyntick-idle mode, which means
> >    that rcu_dynticks_eqs_online() never has any effect.  One could argue
> >    that this means that rcu_dynticks_eqs_online() is unnecessary, however,
> >    removing it makes the CPU-online process vulnerable to slight changes
> >    in the CPU-offline process.
> 
> Why favor moving this from the prepare_cpu to the cpu_starting hotplug step,
> rather than using the target cpu's rdp from rcutree_prepare_cpu ? Maybe there
> was a good reason for having this very early in the prepare_cpu step ?

Some years back, there was a good reason. This reason was that
rcutree_prepare_cpu() marked the CPU as being online from an RCU
viewpoint.  But now rcu_cpu_starting() is the one that marks the CPU as
being online, so the ->dynticks check can be deferred to this function.

> Also, the commit message refers to this bug as having no effect because the
> running CPU cannot possibly be in dyntick-idle mode. I understand that calling
> this function was indeed effect-less, but then why is it OK for the CPU coming
> online to skip this call in the first place ? This commit message hints at
> "slight changes in the CPU-offline process" which could break it, but therer is
> no explanation of what makes this not an actual bug fix.

Because rcutorture would not have suffered in silence had this
situation ever arisen.

I have updated the commit log to answer these questions as shown
below.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 516c8c4cc6fce62539f7e0182739812db4591c1d
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jul 28 12:38:42 2021 -0700

    rcu: Move rcu_dynticks_eqs_online() to rcu_cpu_starting()
    
    The purpose of rcu_dynticks_eqs_online() is to adjust the ->dynticks
    counter of an incoming CPU when required.  It is currently invoked
    from rcutree_prepare_cpu(), which runs before the incoming CPU is
    running, and thus on some other CPU.  This makes the per-CPU accesses in
    rcu_dynticks_eqs_online() iffy at best, and it all "works" only because
    the running CPU cannot possibly be in dyntick-idle mode, which means
    that rcu_dynticks_eqs_online() never has any effect.
    
    It is currently OK for rcu_dynticks_eqs_online() to have no effect, but
    only because the CPU-offline process just happens to leave ->dynticks in
    the correct state.  After all, if ->dynticks were in the wrong state on a
    just-onlined CPU, rcutorture would complain bitterly the next time that
    CPU went idle, at least in kernels built with CONFIG_RCU_EQS_DEBUG=y,
    for example, those built by rcutorture scenario TREE04.  One could
    argue that this means that rcu_dynticks_eqs_online() is unnecessary,
    however, removing it would make the CPU-online process vulnerable to
    slight changes in the CPU-offline process.
    
    One could also ask why it is safe to move the rcu_dynticks_eqs_online()
    call so late in the CPU-online process.  Indeed, there was a time when it
    would not have been safe, which does much to explain its current location.
    However, the marking of a CPU as online from an RCU perspective has long
    since moved from rcutree_prepare_cpu() to rcu_cpu_starting(), and all
    that is required is that ->dynticks be set correctly by the time that
    the CPU is marked as online from an RCU perspective.  After all, the RCU
    grace-period kthread does not check to see if offline CPUs are also idle.
    (In case you were curious, this is one reason why there is quiescent-state
    reporting as part of the offlining process.)
    
    This commit therefore moves the call to rcu_dynticks_eqs_online() from
    rcutree_prepare_cpu() to rcu_cpu_starting(), this latter being guaranteed
    to be running on the incoming CPU.  The call to this function must of
    course be placed before this rcu_cpu_starting() announces this CPU's
    presence to RCU.
    
    Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0172a5fd6d8de..aa00babdaf544 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4129,7 +4129,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
 	rdp->blimit = blimit;
 	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
-	rcu_dynticks_eqs_online();
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
 
 	/*
@@ -4249,6 +4248,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	mask = rdp->grpmask;
 	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
 	WARN_ON_ONCE(!(rnp->ofl_seq & 0x1));
+	rcu_dynticks_eqs_online();
 	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
