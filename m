Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F6CC433B4
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 22:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8B861073
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 22:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhEPXAK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 May 2021 19:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhEPXAJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 May 2021 19:00:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2513B6113C;
        Sun, 16 May 2021 22:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621205934;
        bh=fs924xrDF8amvmwj2roEalsH1PWBkImLcf788hcVKF8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hbKFJ03hDs5fZa75fAlEEuvLCoddZ/YbFFpQjwPhGN2Z4+ipdDpC1Ps4BNhAdHBet
         ROH0sGF8BBqyoj2DNHSo8bnYMiiIQ+Du4CLYKhFtxfFmWJhzsTmYbD/KIwvmLRcae+
         R5Z/nAy6ddYrp+W29KSsE19eLJR24F1vR37fBlaYtnBpW5ZEUijtBFJOPe+21rHKzR
         9aeEaDeIEideewXzQtHf440je++LTdOPSqV6vpkFquJFbW5Kw6R71rpTrxYom50pUS
         33XxG4OeE0VRfx026x8PeMtcQYFZpEZeVAqGgz9vRxHOw8F4zAIWjGlKA+5/r5tKgl
         nJr9vlIja+WlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E2DDB5C03A8; Sun, 16 May 2021 15:58:53 -0700 (PDT)
Date:   Sun, 16 May 2021 15:58:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     yanfei.xu@windriver.com
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: fix a deadlock caused by not release
 rcu_node->lock
Message-ID: <20210516225853.GD4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210516095010.3657134-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516095010.3657134-1-yanfei.xu@windriver.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 16, 2021 at 05:50:10PM +0800, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> rcu_node->lock isn't released in rcu_print_task_stall() if the rcu_node
> don't contain tasks which blocking the GP. However this rcu_node->lock
> will be used again in rcu_dump_cpu_stacks() soon while the ndetected is
> non-zero. As a result the cpu will hung by this deadlock.
> 
> Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>

Also a good catch, thank you!  Queued for further review and testing,
wordsmithed as shown below.  The rcutorture scripts have been known to
work on ARM in the past, and might still do so.  (I test on x86.)

As always, please check to make sure that I didn't mess something up.

							Thanx, Paul

------------------------------------------------------------------------

commit e0a9b77f245ae4fe1537120fd5319bf9e091618e
Author: Yanfei Xu <yanfei.xu@windriver.com>
Date:   Sun May 16 17:50:10 2021 +0800

    rcu: Fix stall-warning deadlock due to non-release of rcu_node ->lock
    
    If rcu_print_task_stall() is invoked on an rcu_node structure that does
    not contain any tasks blocking the current grace period, it takes an
    early exit that fails to release that rcu_node structure's lock.  This
    results in a self-deadlock, which is detected by lockdep.
    
    To reproduce this bug:
    
    tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --trust-make --configs "TREE03" --kconfig "CONFIG_PROVE_LOCKING=y" --bootargs "rcutorture.stall_cpu=30 rcutorture.stall_cpu_block=1 rcutorture.fwd_progress=0 rcutorture.test_boost=0"
    
    This will also result in other complaints, including RCU's scheduler
    hook complaining about blocking rather than preemption and an rcutorture
    writer stall.
    
    Only a partial RCU CPU stall warning message will be printed because of
    the self-deadlock.
    
    This commit therefore releases the lock on the rcu_print_task_stall()
    function's early exit path.
    
    Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
    Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index a10ea1f1f81f..d574e3bbd929 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -267,8 +267,10 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	struct task_struct *ts[8];
 
 	lockdep_assert_irqs_disabled();
-	if (!rcu_preempt_blocked_readers_cgp(rnp))
+	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return 0;
+	}
 	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
 	       rnp->level, rnp->grplo, rnp->grphi);
 	t = list_entry(rnp->gp_tasks->prev,
