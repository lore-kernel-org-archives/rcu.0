Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DC1C4332F
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244529AbiELDFW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244586AbiELDFO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:14 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD4B200F5C
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:13 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id u35so3409694qtc.13
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krloPx/WxS98VS1vS96cNgmL7YiotWv16x5KX/rZNwk=;
        b=erC2NorT3UzdBeIUO7Tvs9XfYymqMTGkuZ665aGCZw/PFXnbYwEscWPhhJC/mnxK/s
         w3JKXgLjq0AgUbIlDC/AUpxW8yVKgCiFP5aTIvogTkVO6KRC1w2mgp6TZGWEHDrrrybG
         XFc1so/fm/wXMD1/yzvfyYjXGDU07bh8fxLx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krloPx/WxS98VS1vS96cNgmL7YiotWv16x5KX/rZNwk=;
        b=eaK3DkXKQQcb82ILMJuXSAxFQSjTvzsW8tQMkq4tSwDJe7E2LBSb3gzGyysRAQZnPo
         HNy/NXBs0qUeMYF6pusMa7yXCpU0Za6sNEy+bzvb7L1nDSpOcM0tJTFQw6+5CE3LXN/c
         7VNGuMDRzDdNo5M5tC5UAS9O2R+6HTkt4Vbb4yk04PQdVrYSn3mZHC93B97r2Riie8eQ
         tgt/qSFKLYKMMRNrGZ1DJidI4Ldy6Bf22Sqnq52f6Vv7nH2ecYFALHRoqzJOic8xuaih
         9zYRpKbR3o2u3W4v5HtPupT8jIBb0pHb1Icv6sAeYCMjLxoh5arIdtxFAvK0cMJZTum3
         TSsw==
X-Gm-Message-State: AOAM533NYnqMXT5fQ2V9z70aJ7YBFMliWTv8iBNTGHM298+REgDqh3aD
        LwPEExtlRQ27GBT5ML2VMNq2DjaeLugMog==
X-Google-Smtp-Source: ABdhPJxpFwDKzLMJIvkSUabCAm16C4Iznxq4wawVZ64fhCyJqTNvXd8da+90kv5Zp31aq4CB0h68Aw==
X-Received: by 2002:ac8:7dcf:0:b0:2f3:d53a:add2 with SMTP id c15-20020ac87dcf000000b002f3d53aadd2mr18976974qte.128.1652324712862;
        Wed, 11 May 2022 20:05:12 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:05:12 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 14/14] DEBUG: Toggle rcu_lazy and tune at runtime
Date:   Thu, 12 May 2022 03:04:42 +0000
Message-Id: <20220512030442.2530552-15-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add sysctl knobs just for easier debugging/testing, to tune the maximum
batch size, maximum time to wait before flush, and turning off the
feature entirely.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched/sysctl.h |  4 ++++
 kernel/rcu/lazy.c            | 12 ++++++++++--
 kernel/sysctl.c              | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c19dd5a2c05c..55ffc61beed1 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -16,6 +16,10 @@ enum { sysctl_hung_task_timeout_secs = 0 };
 
 extern unsigned int sysctl_sched_child_runs_first;
 
+extern unsigned int sysctl_rcu_lazy;
+extern unsigned int sysctl_rcu_lazy_batch;
+extern unsigned int sysctl_rcu_lazy_jiffies;
+
 enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_NONE,
 	SCHED_TUNABLESCALING_LOG,
diff --git a/kernel/rcu/lazy.c b/kernel/rcu/lazy.c
index 55e406cfc528..0af9fb67c92b 100644
--- a/kernel/rcu/lazy.c
+++ b/kernel/rcu/lazy.c
@@ -12,6 +12,10 @@
 // How much to wait before flushing?
 #define MAX_LAZY_JIFFIES	10000
 
+unsigned int sysctl_rcu_lazy_batch = MAX_LAZY_BATCH;
+unsigned int sysctl_rcu_lazy_jiffies = MAX_LAZY_JIFFIES;
+unsigned int sysctl_rcu_lazy = 1;
+
 // We cast lazy_rcu_head to rcu_head and back. This keeps the API simple while
 // allowing us to use lockless list node in the head. Also, we use BUILD_BUG_ON
 // later to ensure that rcu_head and lazy_rcu_head are of the same size.
@@ -49,6 +53,10 @@ void call_rcu_lazy(struct rcu_head *head_rcu, rcu_callback_t func)
 	struct lazy_rcu_head *head = (struct lazy_rcu_head *)head_rcu;
 	struct rcu_lazy_pcp *rlp;
 
+	if (!sysctl_rcu_lazy) {
+		return call_rcu(head_rcu, func);
+	}
+
 	preempt_disable();
         rlp = this_cpu_ptr(&rcu_lazy_pcp_ins);
 	preempt_enable();
@@ -67,11 +75,11 @@ void call_rcu_lazy(struct rcu_head *head_rcu, rcu_callback_t func)
 	llist_add(&head->llist_node, &rlp->head);
 
 	// Flush queue if too big
-	if (atomic_inc_return(&rlp->count) >= MAX_LAZY_BATCH) {
+	if (atomic_inc_return(&rlp->count) >= sysctl_rcu_lazy_batch) {
 		lazy_rcu_flush_cpu(rlp);
 	} else {
 		if (!delayed_work_pending(&rlp->work)) {
-			schedule_delayed_work(&rlp->work, MAX_LAZY_JIFFIES);
+			schedule_delayed_work(&rlp->work, sysctl_rcu_lazy_jiffies);
 		}
 	}
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b2882e..2ba830ca71ec 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1659,6 +1659,29 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+#ifdef CONFIG_RCU_LAZY
+	{
+		.procname	= "rcu_lazy",
+		.data		= &sysctl_rcu_lazy,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "rcu_lazy_batch",
+		.data		= &sysctl_rcu_lazy_batch,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "rcu_lazy_jiffies",
+		.data		= &sysctl_rcu_lazy_jiffies,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#endif
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",
-- 
2.36.0.550.gb090851708-goog

