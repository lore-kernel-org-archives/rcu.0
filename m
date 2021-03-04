Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CA0C4332D
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF9464F53
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhCDBAz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1391222AbhCDAMk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:12:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2808E64EFD;
        Thu,  4 Mar 2021 00:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816697;
        bh=TKqsDjx/j8OKoVI1MdZNosI+1XeHU5vViJP4279S/KM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wfmv3/n9Bl7Q69I9zn45aIZ8SGqjZAbhav9F+NttvQmOGdCE7ZF/SL77VUzwYiwA7
         FsRL6UZLJXVeT8tAmdCETSAQeWeFIw2O9nsMB0Q752b5+iysbLKWVj/PeN0ccyVIeS
         CKVUjuwi047Cnl0H7IJRresRpMlNTnXaQ4/1qdlgHPSCXUmTAmJM6a2MI4JGTxmZI4
         tYyX5iPUzLQPWNEg4ylaFhBW3/W40dfQg2E7AOZyIFdjIRQ5x/Ua31rpozUt/j2cwt
         xlda0ats/a9IZnumcZZbRVYoXmoLtI4o4ZmNpYt07qY+XSwgkp7Zuw6cgYv6C7URLo
         vJ9e4Cl8I18ng==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 6/6] rcuscale: Add kfree_rcu() single-argument scale test
Date:   Wed,  3 Mar 2021 16:11:34 -0800
Message-Id: <20210304001134.22977-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304001044.GA22871@paulmck-ThinkPad-P72>
References: <20210304001044.GA22871@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The single-argument variant of kfree_rcu() is currently not
tested by any member of the rcutoture test suite.  This
commit therefore adds rcuscale code to test it.  This
testing is controlled by two new boolean module parameters,
kfree_rcu_test_single and kfree_rcu_test_double.  If one
is set and the other not, only the corresponding variant
is tested, otherwise both are tested, with the variant to
be tested determined randomly on each invocation.

Both of these module parameters are initialized to false,
so setting either to true will test only that variant.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 kernel/rcu/rcuscale.c                           | 15 ++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0454572..84fce41 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4259,6 +4259,18 @@
 	rcuscale.kfree_rcu_test= [KNL]
 			Set to measure performance of kfree_rcu() flooding.
 
+	rcuscale.kfree_rcu_test_double= [KNL]
+			Test the double-argument variant of kfree_rcu().
+			If this parameter has the same value as
+			rcuscale.kfree_rcu_test_single, both the single-
+			and double-argument variants are tested.
+
+	rcuscale.kfree_rcu_test_single= [KNL]
+			Test the single-argument variant of kfree_rcu().
+			If this parameter has the same value as
+			rcuscale.kfree_rcu_test_double, both the single-
+			and double-argument variants are tested.
+
 	rcuscale.kfree_nthreads= [KNL]
 			The number of threads running loops of kfree_rcu().
 
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 06491d5..dca51fe 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -625,6 +625,8 @@ rcu_scale_shutdown(void *arg)
 torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
 torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
 torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
+torture_param(bool, kfree_rcu_test_double, false, "Do we run a kfree_rcu() double-argument scale test?");
+torture_param(bool, kfree_rcu_test_single, false, "Do we run a kfree_rcu() single-argument scale test?");
 
 static struct task_struct **kfree_reader_tasks;
 static int kfree_nrealthreads;
@@ -644,10 +646,13 @@ kfree_scale_thread(void *arg)
 	struct kfree_obj *alloc_ptr;
 	u64 start_time, end_time;
 	long long mem_begin, mem_during = 0;
+	bool kfree_rcu_test_both;
+	DEFINE_TORTURE_RANDOM(tr);
 
 	VERBOSE_SCALEOUT_STRING("kfree_scale_thread task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
+	kfree_rcu_test_both = (kfree_rcu_test_single == kfree_rcu_test_double);
 
 	start_time = ktime_get_mono_fast_ns();
 
@@ -670,7 +675,15 @@ kfree_scale_thread(void *arg)
 			if (!alloc_ptr)
 				return -ENOMEM;
 
-			kfree_rcu(alloc_ptr, rh);
+			// By default kfree_rcu_test_single and kfree_rcu_test_double are
+			// initialized to false. If both have the same value (false or true)
+			// both are randomly tested, otherwise only the one with value true
+			// is tested.
+			if ((kfree_rcu_test_single && !kfree_rcu_test_double) ||
+					(kfree_rcu_test_both && torture_random(&tr) & 0x800))
+				kfree_rcu(alloc_ptr);
+			else
+				kfree_rcu(alloc_ptr, rh);
 		}
 
 		cond_resched();
-- 
2.9.5

