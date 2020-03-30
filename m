Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1BBC2D0ED
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5479320780
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NmZKgN+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgC3Ced (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37798 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgC3Cdg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id x3so17537290qki.4
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWGW0MR3qR5t+EjFJ/mWsxINnYeSYUXBIkqQcwzdLbg=;
        b=NmZKgN+R6zdEVE3IUCLOA6RtsN34sPbyKaa8mP1kEDPpsLSLDC2DRHp/Vjfoq2CUsJ
         3z6jqV54GVqNx79lxtwaXeg+AIQWD+hvzHrkv8VABz1eDzoUfItrMN3CwpM0LL+n+bCv
         013+kkgAk/r2Hrrd9cRQzHJsa+++wRfznqSKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWGW0MR3qR5t+EjFJ/mWsxINnYeSYUXBIkqQcwzdLbg=;
        b=dTq64H0FQuH0lwMLPLVNA8Vp3gBg+0XghJITg668JRPfBJnsYONCh9+zE1dKeWbcuu
         2TGKngyI8FHq/l7/YwDtgM2IySU158jSlqxDWaTEwBVMrygGLkyc7UVOv919K67PwX2x
         PzCWRqlHB44NcifuWgrp2eREXhb5beTwDg5s6K7cquccC6WBlnocWXgDfcuUaHN7iyE/
         JMSc9T184w+1kMOgvskTLDOKUAeekNt+oVYYqNG7hxaua0SCGa/uMw43cEP5+Q0okeYp
         MRR+Ruq1Q9sNF8eVv2fbvyxjJ7qUBBAU08W7Yt8NacUKGExBnQaEqZeqyPzcQVmB1zry
         6XSA==
X-Gm-Message-State: ANhLgQ3MS4tq6Dc6ohz2NV+DRu0tFHTEEuEWCFIw52v5gjKOmwqwZzSK
        xyREQX3Urutwb2lviXLrm1SVgg==
X-Google-Smtp-Source: ADFU+vvTztmnU9lpjasiqa10hSBSJgTl3WrD1Gxop2WglkZvO8iSitEjNNwX1ck2A7QnkhR469JcUg==
X-Received: by 2002:a37:c43:: with SMTP id 64mr9826539qkm.47.1585535615138;
        Sun, 29 Mar 2020 19:33:35 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:34 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 04/18] rcu: Rename __is_kfree_rcu_offset() macro
Date:   Sun, 29 Mar 2020 22:32:34 -0400
Message-Id: <20200330023248.164994-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Rename __is_kfree_rcu_offset to __is_kvfree_rcu_offset.
All RCU paths use kvfree() now instead of kfree(), thus
rename it.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h | 6 +++---
 kernel/rcu/tiny.c        | 2 +-
 kernel/rcu/tree.c        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 8b7128d0860e2..c6f6a195cb1cd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -823,16 +823,16 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /*
  * Does the specified offset indicate that the corresponding rcu_head
- * structure can be handled by kfree_rcu()?
+ * structure can be handled by kvfree_rcu()?
  */
-#define __is_kfree_rcu_offset(offset) ((offset) < 4096)
+#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
 
 /*
  * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
  */
 #define __kfree_rcu(head, offset) \
 	do { \
-		BUILD_BUG_ON(!__is_kfree_rcu_offset(offset)); \
+		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
 		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
 	} while (0)
 
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 3dd8e6e207b09..aa897c3f2e92c 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -85,7 +85,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 	unsigned long offset = (unsigned long)head->func;
 
 	rcu_lock_acquire(&rcu_callback_map);
-	if (__is_kfree_rcu_offset(offset)) {
+	if (__is_kvfree_rcu_offset(offset)) {
 		trace_rcu_invoke_kvfree_callback("", head, offset);
 		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 88b744ce896c0..1209945a34bfd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2743,7 +2743,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
-	if (__is_kfree_rcu_offset((unsigned long)func))
+	if (__is_kvfree_rcu_offset((unsigned long)func))
 		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
 					 rcu_segcblist_n_cbs(&rdp->cblist));
@@ -2937,7 +2937,7 @@ static void kfree_rcu_work(struct work_struct *work)
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
+		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
 			kvfree((void *)head - offset);
 
 		rcu_lock_release(&rcu_callback_map);
-- 
2.26.0.rc2.310.g2932bb562d-goog

