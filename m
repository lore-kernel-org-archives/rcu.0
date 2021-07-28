Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06802C4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 19:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0A161040
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 19:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhG1TpI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230351AbhG1TpH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 15:45:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3F6660234;
        Wed, 28 Jul 2021 19:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627501505;
        bh=1drARiiciMyJkXP95ucTkRuZMQEwCcUIpdwazOoInjw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FdKmYivoE+aKg2VMFFYxwU0vILdH7pKmFdnSTGe5kF7z0/I4njIhZKtPUsPj83dWs
         8GBKiuonZjWu7M25OogQJ7qc0zQSi1rO3J1P2QE1OICmm8EIYJS0NfaJN69Xmsxllw
         mthYqWuEfYqyYUBTnmR0O3BmJ+nYzUw5UUTxP72pE62IeiiVzWUwVVlwp9r4NhUkfr
         aGr0iYKnhVwdFQ4FVAK44Dc/zIAJTELjfd3LCLNCX+yTeJLSeRMyCxZWE4Hvuampqo
         zXQ5FuLR6CutdNFhYfQG4bB8zJewd/UyFk0hhOUu56VkTWIL6Xgr1jL/ITiaSAD2q+
         eYuwB80vWnDAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A98DC5C048D; Wed, 28 Jul 2021 12:45:05 -0700 (PDT)
Date:   Wed, 28 Jul 2021 12:45:05 -0700
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
Message-ID: <20210728194505.GA1500024@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
 <2135064974.9081.1627496585724.JavaMail.zimbra@efficios.com>
 <20210728185854.GK4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728185854.GK4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 28, 2021 at 11:58:54AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 28, 2021 at 02:23:05PM -0400, Mathieu Desnoyers wrote:
> > ----- On Jul 28, 2021, at 1:37 PM, paulmck paulmck@kernel.org wrote:
> > [...]
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 42a0032dd99f7..c87b3a271d65b 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -251,6 +251,15 @@ void rcu_softirq_qs(void)
> > > 	rcu_tasks_qs(current, false);
> > > }
> > > 
> > > +/*
> > > + * Increment the current CPU's rcu_data structure's ->dynticks field
> > > + * with ordering.  Return the new value.
> > > + */
> > > +static noinstr unsigned long rcu_dynticks_inc(int incby)
> > > +{
> > > +	return arch_atomic_add_return(incby, this_cpu_ptr(&rcu_data.dynticks));
> > > +}
> > > +
> > 
> > [...]
> > 
> > > @@ -308,7 +317,7 @@ static void rcu_dynticks_eqs_online(void)
> > > 
> > > 	if (atomic_read(&rdp->dynticks) & 0x1)
> > > 		return;
> > 
> > Can the thread be migrated at this point ? If yes, then
> > the check and the increment may happen on different cpu's rdps. Is
> > that OK ?
> 
> Good point!  Actually, it can be migrated, but it does not matter.
> In fact, it so completely fails to matter that is is totally useless.  :-/
> 
> The incoming CPU is still offline, so this is run from some other
> completely-online CPU.  Because this CPU is executing in non-idle
> kernel context, that "if" condition must evaluate to true, so that the
> rcu_dynticks_inc() below is dead code.
> 
> Maybe I should move the call to rcu_dynticks_eqs_online() to
> rcu_cpu_starting(), which is pinned to the incoming CPU.  Yes, I
> could remove it completely, but then small changes in the offline
> process could cause great mischief.
> 
> Good catch, thank you!

And how about like this?

						Thanx, Paul

------------------------------------------------------------------------

commit cb8914dcc6443cca15ce48d937a93c0dfdb114d3
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jul 28 12:38:42 2021 -0700

    rcu: Move rcu_dynticks_eqs_online() to rcu_cpu_starting()
    
    The purpose of rcu_dynticks_eqs_online() is to adjust the ->dynticks
    counter of an incoming CPU if required.  It is currently is invoked
    from rcutree_prepare_cpu(), which runs before the incoming CPU is
    running, and thus on some other CPU.  This makes the per-CPU accesses in
    rcu_dynticks_eqs_online() iffy at best, and it all "works" only because
    the running CPU cannot possibly be in dyntick-idle mode, which means
    that rcu_dynticks_eqs_online() never has any effect.  One could argue
    that this means that rcu_dynticks_eqs_online() is unnecessary, however,
    removing it makes the CPU-online process vulnerable to slight changes
    in the CPU-offline process.
    
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
