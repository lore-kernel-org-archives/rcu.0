Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F20C433DB
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 18:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5083D64E45
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 18:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhBQSwI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhBQSwB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Feb 2021 13:52:01 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DA5C061574;
        Wed, 17 Feb 2021 10:51:21 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id q14so17630221ljp.4;
        Wed, 17 Feb 2021 10:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNl/QvFb1aBjzZT4Mef7KFY1jCmIF5ZxQfLBJXaeMTo=;
        b=JCjIPzESlzSBE9Ct9RsDb6b/07AjO1BZO9mRPFVS4JiX5Z6J9Mlof/wUAGlQMPnYlQ
         0+BmtY9vICXf07lSAIesbhwT92A//gTK9V/ZJ/1w1q/tNiAIPZWqvLMpWP00RO5T+Xq0
         Cw15+12SAJyBP87jVf9ksfIdCP42sPRwONecvMKjkWHfA/KqUS4TWDOF5BgNKgdBcxvH
         Ir6vNrZ/jpaa2gMj95zofLItVEEv12oapqlglvfxg7peGPfXAfiuGxSFweBZg5icDdxX
         Cke6FCIhEULTHxwtB4V3ZJHNctk49M8lF/7T52GTZFRaZQ63UFQelQ5oj/Po9PZINU/m
         5wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNl/QvFb1aBjzZT4Mef7KFY1jCmIF5ZxQfLBJXaeMTo=;
        b=LqZ02jW+kLH/HGwimLXVJ0h1z4DN2XPQ4JsMh+odCEBv4Y524EgA6lcksbJ625i/yT
         pmUyNs8KMIqrcCaJBklfRikiJ1Y5mgo7zHe2tuZeQHYL8XD3sQDExm9CBpFuDcZUOjhq
         RkfVl87CZQT9nDl6fE+XHIH+x1mKTKLO5UNod/mn/GF7OFtvVIwiHRP5H2sMC6i2ya8I
         /7W6J+ziyDLoDO7YY2GPEjOKBwsVdOWBu93Q04a7kXWumf91DCp9be+zaB2ahy9/FCHp
         HOK4IJi0qs4n1xp+qE2h9RxbGkMbfxdUkpvleBCcOL/MvmvM/sJzTz6meOx8Gm0Hv1yz
         eC8A==
X-Gm-Message-State: AOAM531uCI+Ea2ZtI6TpaAzF/G5wDL4YPc2auZcLJWf6g9+h9sXDT1g+
        bTApg3mE4S88JGsgf9/zs2n9uuXbv/5ddYMO
X-Google-Smtp-Source: ABdhPJz8WOXYQS5slevTx00POA0LOrSNNVvd6V9RYYEK04P2mYhT5uMDvjnaQ2E7dyaonoT7kY+bAQ==
X-Received: by 2002:a05:651c:2108:: with SMTP id a8mr343520ljq.329.1613587879804;
        Wed, 17 Feb 2021 10:51:19 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m14sm329707lfo.277.2021.02.17.10.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 10:51:19 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v3 1/1] rcuscale: add kfree_rcu() single-argument scale test
Date:   Wed, 17 Feb 2021 19:51:10 +0100
Message-Id: <20210217185110.2099-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

To stress and test a single argument of kfree_rcu() call, we
should to have a special coverage for it. We used to have it
in the test-suite related to vmalloc stressing. The reason is
the rcuscale is a correct place for RCU related things.

Therefore introduce two torture_param() variables, one is for
single-argument scale test and another one for double-argument
scale test.

By default kfree_rcu_test_single and kfree_rcu_test_double are
initialized to false. If both have the same value (false or true)
both are randomly tested, otherwise only the one with value true
is tested. The value of this is that it allows testing of both
options with one test.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcuscale.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 06491d5530db..0fb540e2b22b 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -625,6 +625,8 @@ rcu_scale_shutdown(void *arg)
 torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
 torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
 torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
+torture_param(bool, kfree_rcu_test_single, false, "Do we run a kfree_rcu() single-argument scale test?");
+torture_param(bool, kfree_rcu_test_double, false, "Do we run a kfree_rcu() double-argument scale test?");
 
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
2.20.1

