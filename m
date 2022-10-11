Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16280C433FE
	for <rcu@archiver.kernel.org>; Tue, 11 Oct 2022 18:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJKSCY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJKSCR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:17 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E3C6BCFC
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:14 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id bb5so3413120qtb.11
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4JLhz2KgqJlmd46eYLVQku/dRmLJcABiBUoXKwoaiQ=;
        b=ukHiI+5JsqNog8BbuT0w4hVF9+yXLHa2VRM3D+2ippceyEM4ExrVxYQx8CxWuweHrq
         Rnjqc/TO1srxQeB9rtVR26KcZSz637VEqzQuWsiOteHKD3WK8CXL7XDdEuMb5ftUa5FI
         C0OU441z5OPxFc3zn9Lzc5XBRWzTwajUH5Dko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4JLhz2KgqJlmd46eYLVQku/dRmLJcABiBUoXKwoaiQ=;
        b=3k+B8GBMVN0XS6RCHow5HMtQQI/zcpYIRZxIUZtBgp4uCkEm/nhs69WdwT92qrgZsj
         LzH7QDokwSUxgoFZ0/8zeqT2OG6uYzSrdfZ3H977StspvuvRUQe0KnwdYS9wocCgNIln
         gJ84kB6bzJmF2wsM+9RH6cGzgDUHB7W1qeMhjvSnil9O2Itrw690uMUjeTWI+Gou1qJc
         ji12/InZGbBeorKCtkUgP9Oqg/Ai0lyJftChbGWaorFLdNosGV9WpID93d26GGBR0Bbw
         l8kXriTC5v8/HhD1q3mhlgEmgsuxvreNn0RJIeVCh7lfuaTx3ZqJs6Cu6S2EVLk1VfNU
         DckA==
X-Gm-Message-State: ACrzQf3iqZDRJswCdwJ0mp0erjLtIdp8DvsnxUMep1yzkXWW+y7gP9cw
        L02pnOV0XPR+0c1Ywj4ZnhKIsLca30DDtw==
X-Google-Smtp-Source: AMsMyM4F7wI3rC4ZDHMgdO7PtOnGu8EEcsKY8yIVhBgzwAyyNxcyqcUij7+Ogvw0w34AXrLKLArang==
X-Received: by 2002:ac8:7f48:0:b0:35b:bac4:c472 with SMTP id g8-20020ac87f48000000b0035bbac4c472mr19934504qtk.442.1665511332860;
        Tue, 11 Oct 2022 11:02:12 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:12 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 05/13] rcuscale: Add laziness and kfree tests
Date:   Tue, 11 Oct 2022 18:01:34 +0000
Message-Id: <20221011180142.2742289-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We add 2 tests to rcuscale, first one is a startup test to check whether
we are not too lazy or too hard working. Two, emulate kfree_rcu() itself
to use call_rcu() and check memory pressure. In my testing, the new
call_rcu() does well to keep memory pressure under control, similar
to kfree_rcu().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuscale.c | 68 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 3ef02d4a8108..bbdcac1804ec 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -95,6 +95,7 @@ torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
 torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
+torture_param(int, kfree_by_call_rcu, 0, "Use call_rcu() to emulate kfree_rcu()?");
 
 static char *scale_type = "rcu";
 module_param(scale_type, charp, 0444);
@@ -659,6 +660,14 @@ struct kfree_obj {
 	struct rcu_head rh;
 };
 
+/* Used if doing RCU-kfree'ing via call_rcu(). */
+static void kfree_call_rcu(struct rcu_head *rh)
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
 
+			if (kfree_by_call_rcu) {
+				call_rcu(&(alloc_ptr->rh), kfree_call_rcu);
+				continue;
+			}
+
 			// By default kfree_rcu_test_single and kfree_rcu_test_double are
 			// initialized to false. If both have the same value (false or true)
 			// both are randomly tested, otherwise only the one with value true
@@ -767,11 +781,59 @@ kfree_scale_shutdown(void *arg)
 	return -EINVAL;
 }
 
+// Used if doing RCU-kfree'ing via call_rcu().
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
-	long i;
 	int firsterr = 0;
+	long i;
+	unsigned long jif_start;
+	unsigned long orig_jif;
+
+	// Also, do a quick self-test to ensure laziness is as much as
+	// expected.
+	if (kfree_by_call_rcu && !IS_ENABLED(CONFIG_RCU_LAZY)) {
+		pr_alert("CONFIG_RCU_LAZY is disabled, falling back to kfree_rcu() "
+			 "for delayed RCU kfree'ing\n");
+		kfree_by_call_rcu = 0;
+	}
+
+	if (kfree_by_call_rcu) {
+		/* do a test to check the timeout. */
+		orig_jif = rcu_lazy_get_jiffies_till_flush();
+
+		rcu_lazy_set_jiffies_till_flush(2 * HZ);
+		rcu_barrier();
+
+		jif_start = jiffies;
+		jiffies_at_lazy_cb = 0;
+		call_rcu(&lazy_test1_rh, call_rcu_lazy_test1);
+
+		smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
+
+		rcu_lazy_set_jiffies_till_flush(orig_jif);
+
+		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
+			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
+			WARN_ON_ONCE(1);
+			return -1;
+		}
+
+		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
+			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
+			WARN_ON_ONCE(1);
+			return -1;
+		}
+	}
 
 	kfree_nrealthreads = compute_real(kfree_nthreads);
 	/* Start up the kthreads. */
@@ -784,7 +846,9 @@ kfree_scale_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
-	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
+	pr_alert("kfree object size=%zu, kfree_by_call_rcu=%d\n",
+			kfree_mult * sizeof(struct kfree_obj),
+			kfree_by_call_rcu);
 
 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
 			       GFP_KERNEL);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

