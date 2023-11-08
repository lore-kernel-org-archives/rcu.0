Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98CAC4332F
	for <rcu@archiver.kernel.org>; Wed,  8 Nov 2023 03:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjKHDol (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Nov 2023 22:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHDol (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Nov 2023 22:44:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B81711B
        for <rcu@vger.kernel.org>; Tue,  7 Nov 2023 19:44:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB222C433C7;
        Wed,  8 Nov 2023 03:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699415078;
        bh=EXVY+vyy6pNqqXWsr2boeeF5VH7WMdQzL5DVRRoFOew=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hX1azFKqFO2HgsDK1Wcuw8Aeu8yAjlxvP9Gx4gYy3wue+mXDMVNlJQvi9Vxb6lmQm
         5+BezVgSoqMr3osAx5i6f+etmLLxw2XsQ9AVdLhOEMrUe983B7eSADbMpi7po9Ui+E
         qPZWlSdbDHguJeO9JlUzFQpVyyNyrfNB4pqVkeiY36Kxr0QkTHhdFuleYvKbLfUk/X
         jcM75y8C0Hmr6LuCk55FT3ZyaTdbzqZ6qeIzRcYAFc+Cz0NAaTESiUopQvkhUgwLxr
         VIM8lSXwbKH3FTYW6JJtvw21K30YNOf6wP1rMM7EgK3R8nMx5oHkEItSLzKLVTCl07
         lTz8016VPg0fQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5EE23CE0B6B; Tue,  7 Nov 2023 19:44:37 -0800 (PST)
Date:   Tue, 7 Nov 2023 19:44:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     rcu@vger.kernel.org
Subject: Re: [bug report] rcu: Restrict access to RCU CPU stall notifiers
Message-ID: <48a6763a-fe83-4d65-b99d-1ee79c1cb1db@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5da8a140-8988-43e6-a2c9-31534b90ec01@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5da8a140-8988-43e6-a2c9-31534b90ec01@moroto.mountain>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 07, 2023 at 06:19:37PM +0300, Dan Carpenter wrote:
> Hello Paul E. McKenney,
> 
> The patch 7939f0d7b28c: "rcu: Restrict access to RCU CPU stall
> notifiers" from Nov 1, 2023 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	kernel/rcu/rcutorture.c:2502 rcu_torture_stall()
> 	error: uninitialized symbol 'ret'.
> 
> kernel/rcu/rcutorture.c
>     2446 static int rcu_torture_stall(void *args)
>     2447 {
>     2448         int idx;
>     2449         int ret;
>     2450         unsigned long stop_at;
>     2451 
>     2452         VERBOSE_TOROUT_STRING("rcu_torture_stall task started");
>     2453         if (rcu_cpu_stall_notifiers) {
>     2454                 ret = rcu_stall_chain_notifier_register(&rcu_torture_stall_block);
>     2455                 if (ret)
>     2456                         pr_info("%s: rcu_stall_chain_notifier_register() returned %d, %sexpected.\n",
>     2457                                 __func__, ret, !IS_ENABLED(CONFIG_RCU_STALL_COMMON) ? "un" : "");
> 
> ret is only initialized if rcu_cpu_stall_notifiers is true.
> 
>     2458         }
>     2459         if (stall_cpu_holdoff > 0) {
>     2460                 VERBOSE_TOROUT_STRING("rcu_torture_stall begin holdoff");
>     2461                 schedule_timeout_interruptible(stall_cpu_holdoff * HZ);
>     2462                 VERBOSE_TOROUT_STRING("rcu_torture_stall end holdoff");
>     2463         }
>     2464         if (!kthread_should_stop() && stall_gp_kthread > 0) {
>     2465                 VERBOSE_TOROUT_STRING("rcu_torture_stall begin GP stall");
>     2466                 rcu_gp_set_torture_wait(stall_gp_kthread * HZ);
>     2467                 for (idx = 0; idx < stall_gp_kthread + 2; idx++) {
>     2468                         if (kthread_should_stop())
>     2469                                 break;
>     2470                         schedule_timeout_uninterruptible(HZ);
>     2471                 }
>     2472         }
>     2473         if (!kthread_should_stop() && stall_cpu > 0) {
>     2474                 VERBOSE_TOROUT_STRING("rcu_torture_stall begin CPU stall");
>     2475                 stop_at = ktime_get_seconds() + stall_cpu;
>     2476                 /* RCU CPU stall is expected behavior in following code. */
>     2477                 idx = cur_ops->readlock();
>     2478                 if (stall_cpu_irqsoff)
>     2479                         local_irq_disable();
>     2480                 else if (!stall_cpu_block)
>     2481                         preempt_disable();
>     2482                 pr_alert("%s start on CPU %d.\n",
>     2483                           __func__, raw_smp_processor_id());
>     2484                 while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
>     2485                                     stop_at))
>     2486                         if (stall_cpu_block) {
>     2487 #ifdef CONFIG_PREEMPTION
>     2488                                 preempt_schedule();
>     2489 #else
>     2490                                 schedule_timeout_uninterruptible(HZ);
>     2491 #endif
>     2492                         } else if (stall_no_softlockup) {
>     2493                                 touch_softlockup_watchdog();
>     2494                         }
>     2495                 if (stall_cpu_irqsoff)
>     2496                         local_irq_enable();
>     2497                 else if (!stall_cpu_block)
>     2498                         preempt_enable();
>     2499                 cur_ops->readunlock(idx);
>     2500         }
>     2501         pr_alert("%s end.\n", __func__);
> --> 2502         if (!ret) {
> 
> Uninitialized here

Good catch, thank you!!!

>     2503                 if (rcu_cpu_stall_notifiers) {
> 
> But maybe we can just reverse the tests or delete one of the conditions?
> 
>     2504                         ret = rcu_stall_chain_notifier_unregister(&rcu_torture_stall_block);
>     2505                         if (ret)
>     2506                                 pr_info("%s: rcu_stall_chain_notifier_unregister() returned %d.\n", __func__, ret);
>     2507                 }
>     2508         }
>     2509         torture_shutdown_absorb("rcu_torture_stall");
>     2510         while (!kthread_should_stop())
>     2511                 schedule_timeout_interruptible(10 * HZ);
>     2512         return 0;
>     2513 }

How does the following patch look, to be folded into the original with
attribution?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9f0e6c1cad443..50ac86a348768 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2503,12 +2503,10 @@ static int rcu_torture_stall(void *args)
 		cur_ops->readunlock(idx);
 	}
 	pr_alert("%s end.\n", __func__);
-	if (!ret) {
-		if (rcu_cpu_stall_notifiers) {
-			ret = rcu_stall_chain_notifier_unregister(&rcu_torture_stall_block);
-			if (ret)
-				pr_info("%s: rcu_stall_chain_notifier_unregister() returned %d.\n", __func__, ret);
-		}
+	if (rcu_cpu_stall_notifiers && !ret) {
+		ret = rcu_stall_chain_notifier_unregister(&rcu_torture_stall_block);
+		if (ret)
+			pr_info("%s: rcu_stall_chain_notifier_unregister() returned %d.\n", __func__, ret);
 	}
 	torture_shutdown_absorb("rcu_torture_stall");
 	while (!kthread_should_stop())
