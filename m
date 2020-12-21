Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F64C433E6
	for <rcu@archiver.kernel.org>; Mon, 21 Dec 2020 17:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0315A22CA1
	for <rcu@archiver.kernel.org>; Mon, 21 Dec 2020 17:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgLURSr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Dec 2020 12:18:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgLURSr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Dec 2020 12:18:47 -0500
Date:   Mon, 21 Dec 2020 09:18:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608571086;
        bh=hRwqD0VhUV7p15cXHAo2g5jrugv7tZUYeRciom14PMk=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ODePjfM8X9V8+1wVOx9kMQogydBWyRw995wPS0/pi3UXMWLJktWZrwFwFS1PU6QIL
         MJMPLRH/ly0qx+dPhk80ZB/CMytMJoYx42IrzJU2ouWnIVE8nQPrfH91p2O7hU3HfW
         6WpaylgNa6zD5kscGTQBtSVUJQkxh69YKGYqWuAwQ/28/bc6h2ulyP3XDska429QOR
         Z5yQ2KMWk11pBIIQn2iImmDsgzO+YG5BzTMbNMUK5CAHPix7K9l1w4Mt9HDt9QJt+/
         JrPtPSROyE0wfh46Bgx7u3JF9YPDiQ0+dzSyIcwcSKcn2GH3eg8FwH0LatQjktNOU1
         VpjvRgEdMrAAg==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
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
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 2/2] rcu-tasks: add RCU-tasks self tests
Message-ID: <20201221171805.GW2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209202732.5896-2-urezki@gmail.com>
 <20201216154959.GA2408@pc638.lan>
 <20201216232955.GO2657@paulmck-ThinkPad-P72>
 <20201221153809.GA24756@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221153809.GA24756@pc638.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Dec 21, 2020 at 04:38:09PM +0100, Uladzislau Rezki wrote:
> On Wed, Dec 16, 2020 at 03:29:55PM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 16, 2020 at 04:49:59PM +0100, Uladzislau Rezki wrote:

[ . . . ]

> > > 2.20.1
> > 
> > Again, much improved!
> > 
> See below the v3 version. I hope i fixed all comments :)
> 
> >From 06f7adfd84cbb1994d0e2693ee9dcdfd272a9bd0 Mon Sep 17 00:00:00 2001
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Date: Wed, 9 Dec 2020 21:27:32 +0100
> Subject: [PATCH v3 1/1] rcu-tasks: Add RCU-tasks self tests
> 
> This commit adds self tests for early-boot use of RCU-tasks grace periods.
> It tests all three variants (Rude, Tasks, and Tasks Trace) and covers
> both synchronous (e.g., synchronize_rcu_tasks()) and asynchronous (e.g.,
> call_rcu_tasks()) grace-period APIs.
> 
> Self-tests are run only in kernels built with CONFIG_PROVE_RCU=y.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Much better!

I pulled this in, but made one small additional change.  Please let me
know if this is problematic.

							Thanx, Paul

------------------------------------------------------------------------

commit 93372198b5c9efdfd288aa3b3ee41c1f90866886
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Wed Dec 9 21:27:32 2020 +0100

    rcu-tasks: Add RCU-tasks self tests
    
    This commit adds self tests for early-boot use of RCU-tasks grace periods.
    It tests all three variants (Rude, Tasks, and Tasks Trace) and covers
    both synchronous (e.g., synchronize_rcu_tasks()) and asynchronous (e.g.,
    call_rcu_tasks()) grace-period APIs.
    
    Self-tests are run only in kernels built with CONFIG_PROVE_RCU=y.
    
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 3660755..35a2cd5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1224,6 +1224,40 @@ void show_rcu_tasks_gp_kthreads(void)
 }
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+struct rcu_tasks_test_desc {
+	struct rcu_head rh;
+	const char *name;
+	bool notrun;
+};
+
+static struct rcu_tasks_test_desc tests[] = {
+	{
+		.name = "call_rcu_tasks()",
+		/* If not defined, the test is skipped. */
+		.notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
+	},
+	{
+		.name = "call_rcu_tasks_rude()",
+		/* If not defined, the test is skipped. */
+		.notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
+	},
+	{
+		.name = "call_rcu_tasks_trace()",
+		/* If not defined, the test is skipped. */
+		.notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
+	}
+};
+
+static void test_rcu_tasks_callback(struct rcu_head *rhp)
+{
+	struct rcu_tasks_test_desc *rttd =
+		container_of(rhp, struct rcu_tasks_test_desc, rh);
+
+	pr_info("Callback from %s invoked.\n", rttd->name);
+
+	rttd->notrun = true;
+}
+
 void __init rcu_init_tasks_generic(void)
 {
 #ifdef CONFIG_TASKS_RCU
@@ -1237,7 +1271,45 @@ void __init rcu_init_tasks_generic(void)
 #ifdef CONFIG_TASKS_TRACE_RCU
 	rcu_spawn_tasks_trace_kthread();
 #endif
+
+	// Run the self-tests.
+	if (IS_ENABLED(CONFIG_PROVE_RCU)) {
+		pr_info("Running RCU-tasks wait API self tests\n");
+#ifdef CONFIG_TASKS_RCU
+		synchronize_rcu_tasks();
+		call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+		synchronize_rcu_tasks_rude();
+		call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
+#endif
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+		synchronize_rcu_tasks_trace();
+		call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
+#endif
+	}
+}
+
+static int rcu_tasks_verify_self_tests(void)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (!tests[i].notrun) {		// still hanging.
+			pr_err("%s has been failed.\n", tests[i].name);
+			ret = -1;
+		}
+	}
+
+	if (ret)
+		WARN_ON(1);
+
+	return ret;
 }
+late_initcall(rcu_tasks_verify_self_tests);
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
