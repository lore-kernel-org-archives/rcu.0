Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96346C433DB
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 21:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D29764E02
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 21:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhBVVcw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Feb 2021 16:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhBVVcl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Feb 2021 16:32:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAE1764E02;
        Mon, 22 Feb 2021 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614029520;
        bh=Eh42XbJyyXC24A1STrMBcBWCKsBVxzw5KXWISRssFgw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jIvQRbWAKTXaCs3OS46GAMEyEsHVHm3FZZ8YHfFZlN6ny1X9d7iTt+uZfQ7iQ3zhq
         WLiuK902y2pUaXwxWcRX2naFYAa9WIGYMDUWXarYCB6DWUIh9r9MmVAfKSdudPZAxC
         gF5nx4hMamhVVZJzQO18Jrxli3xAYFvrJacWVBl276KgpdCjL75BUksZpZia1lR1a1
         kkCk65p9uPLrWt2x8gQjDui3YsM0BoKt901LJws8mItigaGnWbn4nYTJwEqHb8EkED
         qfmgJR51OJIr1mhZ/PdA/D+NBspeA4FUn5QNkIeppGWpWB7+Zvl+bLxwjcY6QTwF3+
         QwoEoqLYpWMkQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 74D2B35227D5; Mon, 22 Feb 2021 13:32:00 -0800 (PST)
Date:   Mon, 22 Feb 2021 13:32:00 -0800
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
Message-ID: <20210222213200.GN2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210219112357.GA34462@pc638.lan>
 <20210219112751.GA34528@pc638.lan>
 <20210219181811.GY2743@paulmck-ThinkPad-P72>
 <20210219183336.GA23049@paulmck-ThinkPad-P72>
 <20210222102104.v3pr7t57hmpwijpi@linutronix.de>
 <20210222125431.GA41939@pc638.lan>
 <20210222150903.GH2743@paulmck-ThinkPad-P72>
 <20210222171605.GA42169@pc638.lan>
 <20210222181608.GK2743@paulmck-ThinkPad-P72>
 <20210222190703.GA19167@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222190703.GA19167@pc638.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 22, 2021 at 08:07:03PM +0100, Uladzislau Rezki wrote:
> On Mon, Feb 22, 2021 at 10:16:08AM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 22, 2021 at 06:16:05PM +0100, Uladzislau Rezki wrote:
> > > On Mon, Feb 22, 2021 at 07:09:03AM -0800, Paul E. McKenney wrote:
> > > > On Mon, Feb 22, 2021 at 01:54:31PM +0100, Uladzislau Rezki wrote:
> > > > > On Mon, Feb 22, 2021 at 11:21:04AM +0100, Sebastian Andrzej Siewior wrote:
> > > > > > On 2021-02-19 10:33:36 [-0800], Paul E. McKenney wrote:
> > > > > > > For definiteness, here is the first part of the change, posted earlier.
> > > > > > > The commit log needs to be updated.  I will post the change that keeps
> > > > > > > the tick going as a reply to this email.
> > > > > > …
> > > > > > > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > > > > > > index 9d71046..ba78e63 100644
> > > > > > > --- a/kernel/softirq.c
> > > > > > > +++ b/kernel/softirq.c
> > > > > > > @@ -209,7 +209,7 @@ static inline void invoke_softirq(void)
> > > > > > >  	if (ksoftirqd_running(local_softirq_pending()))
> > > > > > >  		return;
> > > > > > >  
> > > > > > > -	if (!force_irqthreads) {
> > > > > > > +	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
> > > > > > >  #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
> > > > > > >  		/*
> > > > > > >  		 * We can safely execute softirq on the current stack if
> > > > > > > @@ -358,8 +358,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> > > > > > >  
> > > > > > >  	pending = local_softirq_pending();
> > > > > > >  	if (pending) {
> > > > > > > -		if (time_before(jiffies, end) && !need_resched() &&
> > > > > > > -		    --max_restart)
> > > > > > > +		if (!__this_cpu_read(ksoftirqd) ||
> > > > > > > +		    (time_before(jiffies, end) && !need_resched() && --max_restart))
> > > > > > >  			goto restart;
> > > > > > 
> > > > > > This is hunk shouldn't be needed. The reason for it is probably that the
> > > > > > following wakeup_softirqd() would avoid further invoke_softirq()
> > > > > > performing the actual softirq work. It would leave early due to
> > > > > > ksoftirqd_running(). Unless I'm wrong, any raise_softirq() invocation
> > > > > > outside of an interrupt would do the same. 
> > > > 
> > > > And it does pass the rcutorture test without that hunk:
> > > > 
> > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --bootargs "threadirqs=1" --trust-make
> > > > 
> > > Yep. I have tested that patch also. It works for me as well. So
> > > technically i do not see any issues from the first glance but of
> > > course it should be reviewed by the softirq people to hear their
> > > opinion.
> > > 
> > > IRQs are enabled, so it can be handled from an IRQ tail until
> > > ksoftirqd threads are spawned.
> > 
> > And if I add "CONFIG_NO_HZ_IDLE=y CONFIG_HZ_PERIODIC=n" it still works,
> > even if I revert my changes to rcu_needs_cpu().  Should I rely on this
> > working globally?  ;-)
> > 
> There might be corner cases which we are not aware of so far. From the
> other hand what the patch does is simulating the !threadirqs behaviour
> during early boot. In that case we know that handling of SW irqs from
> real-irq tail works :)

Sold!  I keep the rcu_needs_cpu() changes, just in case.

							Thanx, Paul
