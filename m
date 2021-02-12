Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80024C433DB
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 19:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC7164DEC
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 19:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhBLTVs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Feb 2021 14:21:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47740 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhBLTVo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Feb 2021 14:21:44 -0500
Date:   Fri, 12 Feb 2021 20:20:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613157661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0JCXs/B0BMCLMONMJZsI/4OSW8BmqkP+eivfeWEvrI=;
        b=MJJLbl4pbGpuR7AQKoL5lLF49U/YR63l7OA9+f8eIp06P+4AP7vcjmxFbfFhTy4c4kKE1i
        u8ANmQDMn8m182ANkNf10da7JTK23c2/z8qmk/M/xzK1KHJzins7nqBVAwHhKEXxdKywLL
        vJftlsRHDw1Dmr40xUwTp8M25ODfWvtQ6qpAf89OIPpGpilptISq3+TPeCngQDXaa8aba1
        MNLPDBFuU/nlbbwId1xl5h/+FtQBkou9ezUpVSap3Xeg75CPFDrOcFwMHa672ZSmT+nELJ
        rZaHQzpgDDSTsCzPVLD8+r+wG1yxFzXaESVZsYbMfytF36e+NNyeyZ5uiiEaFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613157661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0JCXs/B0BMCLMONMJZsI/4OSW8BmqkP+eivfeWEvrI=;
        b=yl7V4vAQdUrnNnHanGNMMClbihhzNOlS3TmIKCJgKXNy9CerasY3CvqVqroCOkEKrjidAW
        Ro5BSnGShnqUzjBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 2/2] rcu-tasks: add RCU-tasks self tests
Message-ID: <20210212192059.wytqwdf4qm4rnq3d@linutronix.de>
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209202732.5896-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209202732.5896-2-urezki@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-12-09 21:27:32 [+0100], Uladzislau Rezki (Sony) wrote:
> Add self tests for checking of RCU-tasks API functionality.
> It covers:
>     - wait API functions;
>     - invoking/completion call_rcu_tasks*().
> 
> Self-tests are run when CONFIG_PROVE_RCU kernel parameter is set.

I just bisected to this commit. By booting with `threadirqs' I end up
with:
[    0.176533] Running RCU-tasks wait API self tests

No stall warning or so.
It boots again with:

diff --git a/init/main.c b/init/main.c
--- a/init/main.c
+++ b/init/main.c
@@ -1489,6 +1489,7 @@ void __init console_on_rootfs(void)
 	fput(file);
 }
 
+void rcu_tasks_initiate_self_tests(void);
 static noinline void __init kernel_init_freeable(void)
 {
 	/*
@@ -1514,6 +1515,7 @@ static noinline void __init kernel_init_freeable(void)
 
 	rcu_init_tasks_generic();
 	do_pre_smp_initcalls();
+	rcu_tasks_initiate_self_tests();
 	lockup_detector_init();
 
 	smp_init();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1266,7 +1266,7 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
 	rttd->notrun = true;
 }
 
-static void rcu_tasks_initiate_self_tests(void)
+void rcu_tasks_initiate_self_tests(void)
 {
 	pr_info("Running RCU-tasks wait API self tests\n");
 #ifdef CONFIG_TASKS_RCU
@@ -1322,7 +1322,6 @@ void __init rcu_init_tasks_generic(void)
 #endif
 
 	// Run the self-tests.
-	rcu_tasks_initiate_self_tests();
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */

> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Sebastian
