Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EA6C4338F
	for <rcu@archiver.kernel.org>; Tue,  3 Aug 2021 16:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E7D60F8F
	for <rcu@archiver.kernel.org>; Tue,  3 Aug 2021 16:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhHCQeP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Aug 2021 12:34:15 -0400
Received: from foss.arm.com ([217.140.110.172]:52136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233816AbhHCQeK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Aug 2021 12:34:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1CFF139F;
        Tue,  3 Aug 2021 09:33:58 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 702013F66F;
        Tue,  3 Aug 2021 09:33:56 -0700 (PDT)
Date:   Tue, 3 Aug 2021 17:33:54 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Yanfei Xu <yanfei.xu@windriver.com>
Subject: Re: [PATCH rcu 02/18] rcu: Fix stall-warning deadlock due to
 non-release of rcu_node ->lock
Message-ID: <20210803163354.smx5dvferfebcvzi@e107158-lin.cambridge.arm.com>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-2-paulmck@kernel.org>
 <20210803142458.teveyn6t2gwifdcp@e107158-lin.cambridge.arm.com>
 <20210803155226.GQ4397@paulmck-ThinkPad-P17-Gen-1>
 <20210803161221.igae6y6xa6mlzltn@e107158-lin.cambridge.arm.com>
 <20210803162855.GT4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210803162855.GT4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 08/03/21 09:28, Paul E. McKenney wrote:
> On Tue, Aug 03, 2021 at 05:12:21PM +0100, Qais Yousef wrote:
> > On 08/03/21 08:52, Paul E. McKenney wrote:
> > > On Tue, Aug 03, 2021 at 03:24:58PM +0100, Qais Yousef wrote:
> > > > Hi
> > > > 
> > > > On 07/21/21 13:21, Paul E. McKenney wrote:
> > > > > From: Yanfei Xu <yanfei.xu@windriver.com>
> > > > > 
> > > > > If rcu_print_task_stall() is invoked on an rcu_node structure that does
> > > > > not contain any tasks blocking the current grace period, it takes an
> > > > > early exit that fails to release that rcu_node structure's lock.  This
> > > > > results in a self-deadlock, which is detected by lockdep.
> > > > > 
> > > > > To reproduce this bug:
> > > > > 
> > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --trust-make --configs "TREE03" --kconfig "CONFIG_PROVE_LOCKING=y" --bootargs "rcutorture.stall_cpu=30 rcutorture.stall_cpu_block=1 rcutorture.fwd_progress=0 rcutorture.test_boost=0"
> > > > > 
> > > > > This will also result in other complaints, including RCU's scheduler
> > > > > hook complaining about blocking rather than preemption and an rcutorture
> > > > > writer stall.
> > > > > 
> > > > > Only a partial RCU CPU stall warning message will be printed because of
> > > > > the self-deadlock.
> > > > > 
> > > > > This commit therefore releases the lock on the rcu_print_task_stall()
> > > > > function's early exit path.
> > > > > 
> > > > > Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
> > > > > Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > ---
> > > > 
> > > > We are seeing similar stall/deadlock issue on android 5.10 kernel, is the fix
> > > > relevant here? Trying to apply the patches and test, but the problem is tricky
> > > > to reproduce so thought worth asking first.
> > > 
> > > Looks like the relevant symptoms to me, so I suggest trying this series
> > > from -rcu:
> > > 
> > > 8baded711edc ("rcu: Fix to include first blocked task in stall warning")
> > > f6b3995a8b56 ("rcu: Fix stall-warning deadlock due to non-release of rcu_node ->lock")
> > 
> > Great thanks. These are the ones we picked as the rest was a bit tricky to
> > apply on 5.10.
> > 
> > While at it, we see these errors too though they look harmless. They happen
> > all the time
> > 
> > 	[  595.292685] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!"}
> > 	[  595.301467] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"}
> > 	[  595.389353] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"}
> > 	[  595.397454] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"}
> > 	[  595.417112] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"}
> > 	[  595.425215] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"}
> > 	[  595.438807] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"}
> > 
> > I used to see them on mainline a while back but seem to have been fixed.
> > Something didn't get backported to 5.10 perhaps?
> 
> I believe that you need at least this one:
> 
> 47c218dcae65 ("tick/sched: Prevent false positive softirq pending warnings on RT")

Thanks! Shall try that.

Cheers

--
Qais Yousef
