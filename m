Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA0DC4338F
	for <rcu@archiver.kernel.org>; Fri,  6 Aug 2021 11:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B152B60560
	for <rcu@archiver.kernel.org>; Fri,  6 Aug 2021 11:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbhHFLnn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245658AbhHFLnn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Aug 2021 07:43:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A67F660EBB;
        Fri,  6 Aug 2021 11:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628250207;
        bh=RdfzBal/14TQvtJAuKHwVFSH6zN0Zcpar6uZTm/4OTM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EsxVBnmmYDHQPqWJbjSeiIA2LjDoU4tOlFYKFzZW35DR6QAC9SDwZVoQJLmC8lRgn
         cQwbEwkaA8VAl/m31kTQcxZkMDtvYK3iiw9ZWRqGqWHjj7JwRX5WzQmLiaImQbs1RQ
         zkI9OSJptDiFYR0t/iKQ6DW+boeIg6IeyE30HFGY+CnyZLyDcHFofAvOd1cOK5/Bbt
         ZohdGF/MieDvN6PjNnnjA5inovUxAFrE35rRytKrPPBhfTW5+gwV2Tx6OwdG7LB7+m
         FGLT2+qHZT7K50U677uMPSHjUpqOo14LKlAle766DNzwicVxydSsWaHeN9Z5YaRi4Q
         zq9fbYrZhLekQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6FE0E5C1718; Fri,  6 Aug 2021 04:43:27 -0700 (PDT)
Date:   Fri, 6 Aug 2021 04:43:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Yanfei Xu <yanfei.xu@windriver.com>
Subject: Re: [PATCH rcu 02/18] rcu: Fix stall-warning deadlock due to
 non-release of rcu_node ->lock
Message-ID: <20210806114327.GP4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-2-paulmck@kernel.org>
 <20210806095730.tw3bgnjtsytrqqfq@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806095730.tw3bgnjtsytrqqfq@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 06, 2021 at 10:57:30AM +0100, Qais Yousef wrote:
> On 07/21/21 13:21, Paul E. McKenney wrote:
> > From: Yanfei Xu <yanfei.xu@windriver.com>
> > 
> > If rcu_print_task_stall() is invoked on an rcu_node structure that does
> > not contain any tasks blocking the current grace period, it takes an
> > early exit that fails to release that rcu_node structure's lock.  This
> > results in a self-deadlock, which is detected by lockdep.
> > 
> > To reproduce this bug:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --trust-make --configs "TREE03" --kconfig "CONFIG_PROVE_LOCKING=y" --bootargs "rcutorture.stall_cpu=30 rcutorture.stall_cpu_block=1 rcutorture.fwd_progress=0 rcutorture.test_boost=0"
> > 
> > This will also result in other complaints, including RCU's scheduler
> > hook complaining about blocking rather than preemption and an rcutorture
> > writer stall.
> > 
> > Only a partial RCU CPU stall warning message will be printed because of
> > the self-deadlock.
> > 
> > This commit therefore releases the lock on the rcu_print_task_stall()
> > function's early exit path.
> > 
> > Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
> > Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> 
> We were seeing similar issue on Android 5.10. Applying patches 1 and 2 did fix
> the deadlock problem and we get proper RCU stall splat now.
> 
> For patches 1 and 2:
> 
> Tested-by: Qais Yousef <qais.yousef@arm.com>

Thank you, and I will apply this on the next rebase.

> They have Fixes tags, so should end up in 5.10 stable I presume.

Here is hoping!  ;-)

							Thanx, Paul
