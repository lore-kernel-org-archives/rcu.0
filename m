Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E2DCCA47C
	for <rcu@archiver.kernel.org>; Wed,  8 Jun 2022 01:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359375AbiFHBSO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588579AbiFGXys (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Jun 2022 19:54:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2302A116C
        for <rcu@vger.kernel.org>; Tue,  7 Jun 2022 16:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D21A9B82464
        for <rcu@vger.kernel.org>; Tue,  7 Jun 2022 23:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D77C34114;
        Tue,  7 Jun 2022 23:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654645329;
        bh=PsBREP/gI1O3OdUaiuiMxHIVp7msdOrmjDFRkJE6VR4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BSzcmfMb0P9bp+jdxsPm7B/P/D5E4F7ee4ACRRTueYOOpRRJtK+iS+A8j2BBRascw
         cGT7omrR5H+QL3Ddt0c9xHVSb/xjLhz2i/9+A7LvnWuITWIV3jOcK9Fmk4ZgKEV+sM
         lX8jTnx3opejiRjdZSpSI21+puZOkDApg1OdPgoHqPA8hEsp5j0DuXKNHRIJ1sqSEB
         UkdymM3ybe2oBZzv/mQd/+TzKNAwkbB9NHol+rtZwdQdgZgNIROxoXLQ+5LjUN2xfA
         bglT6p5fqG6Aa8zHfxGyDNnuwNJhWnJx5DV9WBXNEQcnFpcWbPo5/5wK5lPN5rHx22
         vJJCbP4GYh1rA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3B6FD5C05CB; Tue,  7 Jun 2022 16:42:09 -0700 (PDT)
Date:   Tue, 7 Jun 2022 16:42:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     willy@infradead.org, urezki@gmail.com, rcu@vger.kernel.org,
        frederic@kernel.org
Subject: Re: [PATCH rcu/dev] RFC: temporarily reduce rcu tasks kthread sleep
 time for PROVE_RCU
Message-ID: <20220607234209.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220527003909.18998-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527003909.18998-1-zhouzhouyi@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 27, 2022 at 08:39:09AM +0800, Zhouyi Zhou wrote:
> Sometimes, the kernel will boot too fast for rcu_tasks_verify_self_tests
> to have all required grace periods.
> 
> Temporarily reduce rcu tasks kthread sleep time for PROVE_RCU to get all
> required grace periods.
> 
> Both this patch and her sister
> "wait extra jiffies for rcu_tasks_verify_self_tests"
> https://lore.kernel.org/rcu/20220517004522.25176-1-zhouzhouyi@gmail.com/
> have their short comings:
> 
> 1) this patch don't slow down the Linux boot time but will increase
> the energe consumption during the boot because of reduced sleep time.
> 
> 2) "wait extra jiffies for rcu_tasks_verify_self_tests" may slow the boot
> process but has not energe problems.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
> Hi Paul
> 
> I have proposed some possible solutions to fix rcu_tasks_verify_self_tests
> failure. Both of them are not perfect. Only tries to break the ice,
> hoping to arouse the attension ;-)

First, please accept my apologies for the delay, and especially thank
you for continuing to dig into this!

Your approach is not at all at all bad, but it would be good to leave
the underlying implementation alone if we can.  One way to do this is to
wait for up to a fixed period of time for the grace period to complete,
for example, as shown in the patch below.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 3e95d4b287b37ee5f7f82e5ebd749ab89fd706c2
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jun 7 15:23:52 2022 -0700

    rcu-tasks: Be more patient for RCU Tasks boot-time testing
    
    The RCU-Tasks family of grace-period primitives can take some time to
    complete, and the amount of time can depend on the exact hardware and
    software configuration.  Some configurations boot up fast enough that the
    RCU-Tasks verification process gets false-positive failures.  This commit
    therefore allows up to 30 seconds for the grace periods to complete, with
    this value adjustable downwards using the rcupdate.rcu_task_stall_timeout
    kernel boot parameter.
    
    Reported-by: Matthew Wilcox <willy@infradead.org>
    Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f1209ce621c51..1a4c3adc5c397 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -145,6 +145,7 @@ static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
 module_param(rcu_task_ipi_delay, int, 0644);
 
 /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
+#define RCU_TASK_BOOT_STALL_TIMEOUT (HZ * 30)
 #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
 static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
 module_param(rcu_task_stall_timeout, int, 0644);
@@ -1778,23 +1779,24 @@ struct rcu_tasks_test_desc {
 	struct rcu_head rh;
 	const char *name;
 	bool notrun;
+	unsigned long runstart;
 };
 
 static struct rcu_tasks_test_desc tests[] = {
 	{
 		.name = "call_rcu_tasks()",
 		/* If not defined, the test is skipped. */
-		.notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
+		.notrun = IS_ENABLED(CONFIG_TASKS_RCU),
 	},
 	{
 		.name = "call_rcu_tasks_rude()",
 		/* If not defined, the test is skipped. */
-		.notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
+		.notrun = IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
 	},
 	{
 		.name = "call_rcu_tasks_trace()",
 		/* If not defined, the test is skipped. */
-		.notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
+		.notrun = IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
 	}
 };
 
@@ -1805,23 +1807,28 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
 
 	pr_info("Callback from %s invoked.\n", rttd->name);
 
-	rttd->notrun = true;
+	rttd->notrun = false;
 }
 
 static void rcu_tasks_initiate_self_tests(void)
 {
+	unsigned long j = jiffies;
+
 	pr_info("Running RCU-tasks wait API self tests\n");
 #ifdef CONFIG_TASKS_RCU
+	tests[0].runstart = j;
 	synchronize_rcu_tasks();
 	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_RUDE_RCU
+	tests[1].runstart = j;
 	synchronize_rcu_tasks_rude();
 	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_TRACE_RCU
+	tests[2].runstart = j;
 	synchronize_rcu_tasks_trace();
 	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
 #endif
@@ -1831,11 +1838,18 @@ static int rcu_tasks_verify_self_tests(void)
 {
 	int ret = 0;
 	int i;
+	unsigned long bst = rcu_task_stall_timeout;
 
+	if (bst <= 0 || bst > RCU_TASK_BOOT_STALL_TIMEOUT)
+		bst = RCU_TASK_BOOT_STALL_TIMEOUT;
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		if (!tests[i].notrun) {		// still hanging.
-			pr_err("%s has been failed.\n", tests[i].name);
-			ret = -1;
+		while (tests[i].notrun) {		// still hanging.
+			if (time_after(jiffies, tests[i].runstart + bst)) {
+				pr_err("%s has failed boot-time tests.\n", tests[i].name);
+				ret = -1;
+				break;
+			}
+			schedule_timeout_uninterruptible(1);
 		}
 	}
 
