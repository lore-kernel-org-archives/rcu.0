Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2161C43334
	for <rcu@archiver.kernel.org>; Wed, 13 Jul 2022 21:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiGMVdG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiGMVdD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 13 Jul 2022 17:33:03 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0340F33401
        for <rcu@vger.kernel.org>; Wed, 13 Jul 2022 14:33:01 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id e5so31018qts.1
        for <rcu@vger.kernel.org>; Wed, 13 Jul 2022 14:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V9uFk/2s6eRxIbaa5OSVxXzZS5Hm9O9yqKYjjF3xCcA=;
        b=i1NJ7i94LbPonDSbcp/G8Y6nDH5sUCE3HJJlxDSmvudZBd7mdQOqAT0bnknCzs+cv3
         rbO3QwlUBYgFXYiCztd4AFk21+g7NQx10nLScx+rCV6Q9Fjo36YFQa7Qo/bvKLJ1BccA
         bSlJ3vNjuHTXJYISkPv1FxRLFhTL7yuseRznk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9uFk/2s6eRxIbaa5OSVxXzZS5Hm9O9yqKYjjF3xCcA=;
        b=N+T6AGkph1w2J80cVkwovrTIK9rj7v/3OsBLM3SO6w/iooAZggQYcgRrq1QYNCuUXu
         sQaiMkTXlpBZUQ0Uj5Fh0/q7dsoxg2ZKgLYsmPXBAlPfym8m89SjAqj+3GoGnEQTgkVl
         i3FsPhpemd2RgzmRyj2h4xRsonqfeOLfa3py6LDd1z3baNMYZVxiBPh+1DD4SLvK0lKR
         kbFaKno117v0eOH3l+c9uEiCvMZUc3tzdrOoTLHBEnjbKBqWdpK2vR0Co/m06K8kPaXM
         DUkjc47cLM+B/uwcKk+DxzbdlHZlFhmPMKOuKQhfjaofyypADO/AxiXWdrBQ/3AIPcKM
         kjdQ==
X-Gm-Message-State: AJIora/xemj65iwzmwfWUGmJtAoLHBlxTVuvPwCVfzcLeU11fSvEj9wf
        GoHPHzk3U4HAnboH0LjU37jjexGPzE2ZMg==
X-Google-Smtp-Source: AGRyM1tfuDDN85ebxYftH2Um2s7lw/ph9HEYLYXLYDVyWl9PPTL9WhbXhp+R0weFeSakJUNS3x9Vcw==
X-Received: by 2002:a05:622a:11:b0:31c:6cbb:f669 with SMTP id x17-20020a05622a001100b0031c6cbbf669mr5108604qtw.614.1657747980340;
        Wed, 13 Jul 2022 14:33:00 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b006b5988b2ca8sm6791163qkn.40.2022.07.13.14.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:33:00 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 3/5] rcuscale: Add laziness and kfree tests
Date:   Wed, 13 Jul 2022 21:32:35 +0000
Message-Id: <20220713213237.1596225-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220713213237.1596225-1-joel@joelfernandes.org>
References: <20220713213237.1596225-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We had 2 tests to rcuscale, one is a startup test to check whether we
are not too lazy or too hard working. Two, emulate kfree_rcu() itself to
use call_rcu_lazy() and check memory pressure. In my testing,
call_rcu_lazy() does well to keep memory pressure under control, similar
to kfree_rcu().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuscale.c | 74 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 277a5bfb37d4..ed5544227f4d 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -95,6 +95,7 @@ torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
 torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
+torture_param(int, kfree_rcu_by_lazy, 0, "Use call_rcu_lazy() to emulate kfree_rcu()?");
 
 static char *scale_type = "rcu";
 module_param(scale_type, charp, 0444);
@@ -658,6 +659,14 @@ struct kfree_obj {
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
@@ -695,6 +704,11 @@ kfree_scale_thread(void *arg)
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
@@ -737,6 +751,9 @@ kfree_scale_cleanup(void)
 {
 	int i;
 
+	if (kfree_rcu_by_lazy)
+		rcu_force_call_rcu_to_lazy(false);
+
 	if (torture_cleanup_begin())
 		return;
 
@@ -766,11 +783,64 @@ kfree_scale_shutdown(void *arg)
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
@@ -783,7 +853,9 @@ kfree_scale_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
-	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
+	pr_alert("kfree object size=%zu, kfree_rcu_by_lazy=%d\n",
+			kfree_mult * sizeof(struct kfree_obj),
+			kfree_rcu_by_lazy);
 
 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
 			       GFP_KERNEL);
-- 
2.37.0.144.g8ac04bfd2-goog

