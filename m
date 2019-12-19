Return-Path: <SRS0=65fK=2J=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361EEC43603
	for <rcu@archiver.kernel.org>; Thu, 19 Dec 2019 21:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD8221D7D
	for <rcu@archiver.kernel.org>; Thu, 19 Dec 2019 21:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="whUB+AfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfLSVN6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:13:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43156 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLSVN6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Dec 2019 16:13:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id x6so2897444pfo.10
        for <rcu@vger.kernel.org>; Thu, 19 Dec 2019 13:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AgO/47tZIxvVJC669ttTdtG/Znfw1BmDdkytg6xCB4Y=;
        b=whUB+AfKiwN8ECIkMHp0e0YfDbAkUtQz33jBgFfW/Q827xTfxTV9F/Q5DI6bUSau6x
         BJzkRHXuHkopY+JIPQlCK9ZX2tzijX0WNjW+eZ8B1zDteVlui888czWXpidpu5RBcHGh
         IkpzhrzS/hXvgAp1+FEMAqgUFUbjQ0GtXoAuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AgO/47tZIxvVJC669ttTdtG/Znfw1BmDdkytg6xCB4Y=;
        b=kuj38KAWvFBEa3709Fv09oh/PhnwwZjAmI9SDUyGhS/KMCTUmGPOfFk1NzZbiNAsZD
         L/GgrJ/8MTQ/fYFrrESV/V/dNCfbXwFjYvQT6QQ0dsOAcFrPK4hkqVBQYw7KcqwLpq3H
         ccCQyVUOP7oisoCbATVpuKwNBdJna8P3mDwx4AeRPZOZ/84njUqvq+lt3Q/IrAU0KhU1
         ZkQbhPXA2Eaf/4DO2woCbBvnCJo/4eqivP3TJF1OVABDXwut+mrLq5/iyrhMhfRngYvX
         yzMOh/EJdOOXOXQ+UpBYHg8ugxf7MRBXgutA52tIJHRCyAQriR6bwMMNT/Tt5Sn/ynx1
         +cIw==
X-Gm-Message-State: APjAAAUQ4Tt/y9cMG08zk3TyOjLBsKJhW6zmwiidPXunFlTQaTFV/txN
        9iCbnbcdmn7emFYy5CtZAxxY6Q==
X-Google-Smtp-Source: APXvYqwuv5GC/ueDm/Dh6HQenN+iHtp83AKTiRSjtUQwuBvjJEM7Zzd8K4MrrwRa1V9K8Nhm6djmLg==
X-Received: by 2002:a62:1c95:: with SMTP id c143mr11616195pfc.219.1576790037454;
        Thu, 19 Dec 2019 13:13:57 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 73sm8616834pgc.13.2019.12.19.13.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 13:13:56 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        bristot@redhat.com, frextrite@gmail.com,
        madhuparnabhowmik04@gmail.com, urezki@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 rcu-dev] rcuperf: Measure memory footprint during kfree_rcu() test
Date:   Thu, 19 Dec 2019 16:13:49 -0500
Message-Id: <20191219211349.235877-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During changes to kfree_rcu() code, we often check the amount of free
memory.  As an alternative to checking this manually, this commit adds a
measurement in the test itself.  It measures four times during the test
for available memory, digitally filters these measurements to produce a
running average with a weight of 0.5, and compares this digitally
filtered value with the amount of available memory at the beginning of
the test.

We apply the digital filter only once we are more than 25% into the
test. At the 25% mark, we just read available memory and don't apply any
filtering. This prevents the first sample from skewing the results
as we would not consider memory readings that were before memory was
allocated.

A sample run shows something like:

Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>


---
v1->v2: Minor corrections
v1->v3: Use long long to prevent 32-bit system's overflow
	Handle case where some threads start later than others.
	Start measuring only once 25% into the test. Slightly more accurate.

Cc: bristot@redhat.com
Cc: frextrite@gmail.com
Cc: madhuparnabhowmik04@gmail.com
Cc: urezki@gmail.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

 kernel/rcu/rcuperf.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index da94b89cd531..67e0f804ea97 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/err.h>
@@ -604,6 +605,8 @@ struct kfree_obj {
 	struct rcu_head rh;
 };
 
+long long mem_begin;
+
 static int
 kfree_perf_thread(void *arg)
 {
@@ -611,6 +614,7 @@ kfree_perf_thread(void *arg)
 	long me = (long)arg;
 	struct kfree_obj *alloc_ptr;
 	u64 start_time, end_time;
+	long long mem_during = si_mem_available();
 
 	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
@@ -626,6 +630,15 @@ kfree_perf_thread(void *arg)
 	}
 
 	do {
+		// Moving average of memory availability measurements.
+		// Start measuring only from when we are at least 25% into the test.
+		if (loop && kfree_loops > 3 && (loop % (kfree_loops / 4) == 0)) {
+			if (loop == (kfree_loops / 4))
+				mem_during = si_mem_available();
+			else
+				mem_during = (mem_during + si_mem_available()) / 2;
+		}
+
 		for (i = 0; i < kfree_alloc_num; i++) {
 			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
 			if (!alloc_ptr)
@@ -645,9 +658,13 @@ kfree_perf_thread(void *arg)
 		else
 			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
 
-		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
+		// The "memory footprint" field represents how much in-flight
+		// memory is allocated during the test and waiting to be freed.
+		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
 		       (unsigned long long)(end_time - start_time), kfree_loops,
-		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
+		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
+		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
+
 		if (shutdown) {
 			smp_mb(); /* Assign before wake. */
 			wake_up(&shutdown_wq);
@@ -719,6 +736,8 @@ kfree_perf_init(void)
 		goto unwind;
 	}
 
+	mem_begin = si_mem_available();
+
 	for (i = 0; i < kfree_nrealthreads; i++) {
 		firsterr = torture_create_kthread(kfree_perf_thread, (void *)i,
 						  kfree_reader_tasks[i]);
-- 
2.24.1.735.g03f4e72817-goog
