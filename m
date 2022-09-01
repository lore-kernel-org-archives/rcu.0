Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF30AECAAD2
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiIAWSJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiIAWSG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:06 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4A59263
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:18:05 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id j6so152941qvu.10
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9dE4Rk8OIOb+ihEgM/v0EEwGQjrbZnrnEwGtQG+Tokc=;
        b=hduLdeo23eUYXwfIi5kOwRTpmsQWKz5WMzdJryBENxzTtKqWyj8jKS1pkZfs7K8ix/
         433izYbBsAKpcvkSRytC/Vy95tY1M4jnMjqRDxPDnm8amlDKZui5CBFRq87fL6LuqJ/2
         5PT2xT3jsfon0zpijEzJBydZ5JMeqjs5NKQVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9dE4Rk8OIOb+ihEgM/v0EEwGQjrbZnrnEwGtQG+Tokc=;
        b=5fLsjYJgP/t3kzcZjdPUZiB0seFmn7FPTcQJkKARCPagA7nHMDS5JI8YMZDpAxsLAi
         pap/mVpDNbephGS9jA2g4mr3aWurJZTnPmQZ2LFfU79JNSpzvvSDB5keU33rc4eaWxqI
         aq4dsN5rSYaAdtB7KA5PmyuetgkDQ7/gCBllqkqk19w+XV92s+brwmIIwcZLPyAtxLuL
         MOVzHjYSWm8LLxumVWfQuqHWm+U1XAueqOt701aXr+l6jBUp6m5zJpDU65fN7Inz4V86
         gJRnpaXfMNcMeGTC+6p5FDkAGTPF+glvZ6TAA89kQQekvzDcDS6R1nDRuxsSfEJ6H315
         woLQ==
X-Gm-Message-State: ACgBeo0wvjqlS1VBOoDkt+g9dxvRrFZA2GzJiJ7vOSwt24Bqo3gf+F7/
        sXI2o4b9i6ZlXS4wgOTd3vlwK4ScHYas6A==
X-Google-Smtp-Source: AA6agR5JaoGB677mb+F1Gn0KMgIKjVq4iVwwN+1P2BSJcZKXS+rgh0glw3Qtr1+KQ96rCexOh2tcOA==
X-Received: by 2002:a05:6214:b61:b0:498:ff24:9b59 with SMTP id ey1-20020a0562140b6100b00498ff249b59mr21011911qvb.98.1662070683846;
        Thu, 01 Sep 2022 15:18:03 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:03 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 09/18] rcuscale: Add laziness and kfree tests
Date:   Thu,  1 Sep 2022 22:17:11 +0000
Message-Id: <20220901221720.1105021-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We aad 2 tests to rcuscale, first one is a startup test to check whether
we are not too lazy or too hard working. Two, emulate kfree_rcu() itself
to use call_rcu_lazy() and check memory pressure. In my testing,
call_rcu_lazy() does well to keep memory pressure under control, similar
to kfree_rcu().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuscale.c | 74 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 3ef02d4a8108..6808f2e14385 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -95,6 +95,7 @@ torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
 torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
+torture_param(int, kfree_rcu_by_lazy, 0, "Use call_rcu_lazy() to emulate kfree_rcu()?");
 
 static char *scale_type = "rcu";
 module_param(scale_type, charp, 0444);
@@ -659,6 +660,14 @@ struct kfree_obj {
 	struct rcu_head rh;
 };
 
+/* Used if doing RCU-kfree'ing via call_rcu_lazy(). */
+static void kfree_rcu_lazy(struct rcu_head *rh)
+{
+	struct kfree_obj *obj = container_of(rh, struct kfree_obj, rh);
+
+	kfree(obj);
+}
+
 static int
 kfree_scale_thread(void *arg)
 {
@@ -696,6 +705,11 @@ kfree_scale_thread(void *arg)
 			if (!alloc_ptr)
 				return -ENOMEM;
 
+			if (kfree_rcu_by_lazy) {
+				call_rcu_lazy(&(alloc_ptr->rh), kfree_rcu_lazy);
+				continue;
+			}
+
 			// By default kfree_rcu_test_single and kfree_rcu_test_double are
 			// initialized to false. If both have the same value (false or true)
 			// both are randomly tested, otherwise only the one with value true
@@ -738,6 +752,9 @@ kfree_scale_cleanup(void)
 {
 	int i;
 
+	if (kfree_rcu_by_lazy)
+		rcu_force_call_rcu_to_lazy(false);
+
 	if (torture_cleanup_begin())
 		return;
 
@@ -767,11 +784,64 @@ kfree_scale_shutdown(void *arg)
 	return -EINVAL;
 }
 
+// Used if doing RCU-kfree'ing via call_rcu_lazy().
+static unsigned long jiffies_at_lazy_cb;
+static struct rcu_head lazy_test1_rh;
+static int rcu_lazy_test1_cb_called;
+static void call_rcu_lazy_test1(struct rcu_head *rh)
+{
+	jiffies_at_lazy_cb = jiffies;
+	WRITE_ONCE(rcu_lazy_test1_cb_called, 1);
+}
+
 static int __init
 kfree_scale_init(void)
 {
 	long i;
 	int firsterr = 0;
+	unsigned long orig_jif, jif_start;
+
+	// If lazy-rcu based kfree'ing is requested, then for kernels that
+	// support it, force all call_rcu() to call_rcu_lazy() so that non-lazy
+	// CBs do not remove laziness of the lazy ones (since the test tries to
+	// stress call_rcu_lazy() for OOM).
+	//
+	// Also, do a quick self-test to ensure laziness is as much as
+	// expected.
+	if (kfree_rcu_by_lazy && !IS_ENABLED(CONFIG_RCU_LAZY)) {
+		pr_alert("CONFIG_RCU_LAZY is disabled, falling back to kfree_rcu() "
+			 "for delayed RCU kfree'ing\n");
+		kfree_rcu_by_lazy = 0;
+	}
+
+	if (kfree_rcu_by_lazy) {
+		/* do a test to check the timeout. */
+		orig_jif = rcu_lazy_get_jiffies_till_flush();
+
+		rcu_force_call_rcu_to_lazy(true);
+		rcu_lazy_set_jiffies_till_flush(2 * HZ);
+		rcu_barrier();
+
+		jif_start = jiffies;
+		jiffies_at_lazy_cb = 0;
+		call_rcu_lazy(&lazy_test1_rh, call_rcu_lazy_test1);
+
+		smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
+
+		rcu_lazy_set_jiffies_till_flush(orig_jif);
+
+		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
+			pr_alert("ERROR: Lazy CBs are not being lazy as expected!\n");
+			WARN_ON_ONCE(1);
+			return -1;
+		}
+
+		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
+			pr_alert("ERROR: Lazy CBs are being too lazy!\n");
+			WARN_ON_ONCE(1);
+			return -1;
+		}
+	}
 
 	kfree_nrealthreads = compute_real(kfree_nthreads);
 	/* Start up the kthreads. */
@@ -784,7 +854,9 @@ kfree_scale_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
-	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
+	pr_alert("kfree object size=%zu, kfree_rcu_by_lazy=%d\n",
+			kfree_mult * sizeof(struct kfree_obj),
+			kfree_rcu_by_lazy);
 
 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
 			       GFP_KERNEL);
-- 
2.37.2.789.g6183377224-goog

