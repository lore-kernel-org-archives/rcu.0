Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDFEC4338F
	for <rcu@archiver.kernel.org>; Fri,  6 Aug 2021 12:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C1761163
	for <rcu@archiver.kernel.org>; Fri,  6 Aug 2021 12:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbhHFMeI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:34:08 -0400
Received: from foss.arm.com ([217.140.110.172]:60020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238794AbhHFMeH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Aug 2021 08:34:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4617E31B;
        Fri,  6 Aug 2021 05:33:51 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13C7A3F40C;
        Fri,  6 Aug 2021 05:33:48 -0700 (PDT)
Date:   Fri, 6 Aug 2021 13:33:46 +0100
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
Message-ID: <20210806123346.qkddi4kqi4z4666e@e107158-lin.cambridge.arm.com>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-2-paulmck@kernel.org>
 <20210806095730.tw3bgnjtsytrqqfq@e107158-lin.cambridge.arm.com>
 <20210806114327.GP4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210806114327.GP4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 08/06/21 04:43, Paul E. McKenney wrote:
> On Fri, Aug 06, 2021 at 10:57:30AM +0100, Qais Yousef wrote:
> > On 07/21/21 13:21, Paul E. McKenney wrote:
> > > From: Yanfei Xu <yanfei.xu@windriver.com>
> > > 
> > > If rcu_print_task_stall() is invoked on an rcu_node structure that does
> > > not contain any tasks blocking the current grace period, it takes an
> > > early exit that fails to release that rcu_node structure's lock.  This
> > > results in a self-deadlock, which is detected by lockdep.
> > > 
> > > To reproduce this bug:
> > > 
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --trust-make --configs "TREE03" --kconfig "CONFIG_PROVE_LOCKING=y" --bootargs "rcutorture.stall_cpu=30 rcutorture.stall_cpu_block=1 rcutorture.fwd_progress=0 rcutorture.test_boost=0"
> > > 
> > > This will also result in other complaints, including RCU's scheduler
> > > hook complaining about blocking rather than preemption and an rcutorture
> > > writer stall.
> > > 
> > > Only a partial RCU CPU stall warning message will be printed because of
> > > the self-deadlock.
> > > 
> > > This commit therefore releases the lock on the rcu_print_task_stall()
> > > function's early exit path.
> > > 
> > > Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
> > > Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > 
> > We were seeing similar issue on Android 5.10. Applying patches 1 and 2 did fix
> > the deadlock problem and we get proper RCU stall splat now.
> > 
> > For patches 1 and 2:
> > 
> > Tested-by: Qais Yousef <qais.yousef@arm.com>
> 
> Thank you, and I will apply this on the next rebase.
> 
> > They have Fixes tags, so should end up in 5.10 stable I presume.
> 
> Here is hoping!  ;-)

Leave it with me, I've got a todo to make sure this happens ;-)

Thanks!

--
Qais Yousef
