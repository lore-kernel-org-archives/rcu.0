Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F38C433E6
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 18:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4A664DF2
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 18:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhBVSnS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231569AbhBVSmg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Feb 2021 13:42:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BEF264F44;
        Mon, 22 Feb 2021 18:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017768;
        bh=Hjf816WA/+lRyr0PoVVMaBNdOkCdcL7XT7zVlSLoU8g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mlsB6asw56Og4rf/ku+ySjRWZHw4LMBFe8EFSwyIeMLQRhsXNlczGgiFrYWeYqZGZ
         jyEcDOHCFLTcS4FSo0uaHHZVF5ckDfNCRAMQDdfjsZzLCDklpc0OIGsriI2vS7hEbJ
         T5wikt+epe5AOHP/q1k8rNFbeUevAmNiJ2zScnfEgXdoIqCWc3pzvttmQWjUESD5XD
         8i1Av0B1Juc+OKew5JQ+nZQfgd4Dv92QW1ffiHGeAPAax9IWigUCMvwydL3TpHwU6b
         aBRcpK5e/DAgVrTS+4lQH/e9YbxVLR6zRK3aQ+MRhAfmFVmd+4o0+WE3x0l1Ns83kL
         cePg3G3T9EINg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 16ADB35227D5; Mon, 22 Feb 2021 10:16:08 -0800 (PST)
Date:   Mon, 22 Feb 2021 10:16:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-ID: <20210222181608.GK2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210219111301.GA34441@pc638.lan>
 <20210219111738.go6i2fdzvavpotxd@linutronix.de>
 <20210219112357.GA34462@pc638.lan>
 <20210219112751.GA34528@pc638.lan>
 <20210219181811.GY2743@paulmck-ThinkPad-P72>
 <20210219183336.GA23049@paulmck-ThinkPad-P72>
 <20210222102104.v3pr7t57hmpwijpi@linutronix.de>
 <20210222125431.GA41939@pc638.lan>
 <20210222150903.GH2743@paulmck-ThinkPad-P72>
 <20210222171605.GA42169@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222171605.GA42169@pc638.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 22, 2021 at 06:16:05PM +0100, Uladzislau Rezki wrote:
> On Mon, Feb 22, 2021 at 07:09:03AM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 22, 2021 at 01:54:31PM +0100, Uladzislau Rezki wrote:
> > > On Mon, Feb 22, 2021 at 11:21:04AM +0100, Sebastian Andrzej Siewior wrote:
> > > > On 2021-02-19 10:33:36 [-0800], Paul E. McKenney wrote:
> > > > > For definiteness, here is the first part of the change, posted earlier.
> > > > > The commit log needs to be updated.  I will post the change that keeps
> > > > > the tick going as a reply to this email.
> > > > …
> > > > > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > > > > index 9d71046..ba78e63 100644
> > > > > --- a/kernel/softirq.c
> > > > > +++ b/kernel/softirq.c
> > > > > @@ -209,7 +209,7 @@ static inline void invoke_softirq(void)
> > > > >  	if (ksoftirqd_running(local_softirq_pending()))
> > > > >  		return;
> > > > >  
> > > > > -	if (!force_irqthreads) {
> > > > > +	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
> > > > >  #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
> > > > >  		/*
> > > > >  		 * We can safely execute softirq on the current stack if
> > > > > @@ -358,8 +358,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> > > > >  
> > > > >  	pending = local_softirq_pending();
> > > > >  	if (pending) {
> > > > > -		if (time_before(jiffies, end) && !need_resched() &&
> > > > > -		    --max_restart)
> > > > > +		if (!__this_cpu_read(ksoftirqd) ||
> > > > > +		    (time_before(jiffies, end) && !need_resched() && --max_restart))
> > > > >  			goto restart;
> > > > 
> > > > This is hunk shouldn't be needed. The reason for it is probably that the
> > > > following wakeup_softirqd() would avoid further invoke_softirq()
> > > > performing the actual softirq work. It would leave early due to
> > > > ksoftirqd_running(). Unless I'm wrong, any raise_softirq() invocation
> > > > outside of an interrupt would do the same. 
> > 
> > And it does pass the rcutorture test without that hunk:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --bootargs "threadirqs=1" --trust-make
> > 
> Yep. I have tested that patch also. It works for me as well. So
> technically i do not see any issues from the first glance but of
> course it should be reviewed by the softirq people to hear their
> opinion.
> 
> IRQs are enabled, so it can be handled from an IRQ tail until
> ksoftirqd threads are spawned.

And if I add "CONFIG_NO_HZ_IDLE=y CONFIG_HZ_PERIODIC=n" it still works,
even if I revert my changes to rcu_needs_cpu().  Should I rely on this
working globally?  ;-)

							Thanx, Paul

> > > > I would like PeterZ / tglx to comment on this one. Basically I'm not
> > > > sure if it is okay to expect softirqs beeing served and waited on that
> > > > early in the boot.
> > 
> > It would be good to get other eyes on this.
> > 
> > I do agree that "don't wait on softirq handlers until after completion
> > of all early_initcall() handlers" is a nice simple rule, but debugging
> > violations of it is not so simple.  Adding warnings to ease debugging
> > of violations of this rule is quite a bit more complex than is either of
> > the methods of making the rule unnecessary, at least from what I can see
> > at this point.  The complexity of the warnings is exactly what Sebastian
> > pointed out earlier, that it is currently legal to raise_softirq() but
> > not to wait on the resulting handlers.  But even waiting is OK if that
> > waiting does not delay the boot sequence.  But if the boot kthread waits
> > on the kthread that does the waiting, it is once again not OK.
> > 
> > So am I missing something subtle here?
> >
> I agree here. Seems like we are on the same page in understanding :)
> 
> > > The ksoftirqd threads get spawned during early_initcall() phase. Why not
> > > just spawn them one step earlier what is totally safe? I mean before
> > > do_pre_smp_initcalls() that calls early callbacks.
> > > 
> > > +       spawn_ksoftirqd();
> > >         rcu_init_tasks_generic();
> > >         do_pre_smp_initcalls();
> > > 
> > > With such change the spawning will not be depended on linker/compiler
> > > i.e. when and in which order an early_initcall(spawn_ksoftirqd) callback
> > > is executed.
> > 
> > We both posted patches similar to this, so I am not opposed.  One caveat,
> > though, namely that this narrows the window quite a bit but does not
> > entirely close it.  But it does allow the early_initcall()s to wait on
> > softirq handlers.
> > 
> Yep, that was an intention. At least to provide such functionality for early
> callbacks. What happens before it(init/main.c) is pretty controllable.
> 
> --
> Vlad Rezki
