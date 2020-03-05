Return-Path: <SRS0=zrtj=4W=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ECCC3F2D7
	for <rcu@archiver.kernel.org>; Thu,  5 Mar 2020 22:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC8620801
	for <rcu@archiver.kernel.org>; Thu,  5 Mar 2020 22:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="JGMmfoL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEWNk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:13:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38785 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCEWNk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Mar 2020 17:13:40 -0500
Received: by mail-qt1-f194.google.com with SMTP id e20so315064qto.5
        for <rcu@vger.kernel.org>; Thu, 05 Mar 2020 14:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rv3YbInNF6o6Vv0DcE4gmr7uq+LUpUVYyrjz9X11Bgs=;
        b=JGMmfoL1BCXUCe9OwoHBRAOyb05vDTYl9PJ/FTSm0JwMPh8tH88ZBuVJt+GU0+9SjO
         iBejeX/6q/R4jPnuz3bMDlWJRWDti91/ld4lY7wATZmebDl7TBYebnwe7qAHKbH5VEpp
         WpuhUToRW9G0/P5lPiHja2vyjPF0aJxcOtMUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rv3YbInNF6o6Vv0DcE4gmr7uq+LUpUVYyrjz9X11Bgs=;
        b=FaO7ek0RjNvcji7Y3AoAI7L2J8u4DBFr1B9EFY14P6SgB6NGY3qe02cUP8idkDpWOc
         SvPbqdRJSKVrmWFeYAhvqTsmbt8oAEsdjBrPVKpCn4YWYxnDTyrSyBcSXMuLaVKKt5+H
         Vo44/B1E2JClV3LfPA7FmGWsIVEUlyPfNwyafa5qeg8uoRvTdmxVswrjcu/W1Hw6jaay
         cHQaQjD5oTa09mkAtfxyYDIzzIEEw6pie1qd3Xyzh98nWjCrKm2iqGgNeAdObAM6dJ0J
         uxlKocA9OZtFusFNaJynVr1ajqvyovXdyzUC41fYQ6PkoGPkFWGS2zq9LC9lMRss/mAI
         VXBg==
X-Gm-Message-State: ANhLgQ2jeLQ8avWAXj+S1cHiiGF/it6XSspOfW3pqABYZ+hmqM/zVS0n
        muOBhTLtIbdIY/qCzN6Ql/JLEQ==
X-Google-Smtp-Source: ADFU+vvHDTVvG0JXy0wWXZAkVPgdu1mZ7QPrAvuUwgzYrpW7h/4O7tNln9OOl9ESKFh/8W7q311tDg==
X-Received: by 2002:ac8:39c2:: with SMTP id v60mr314235qte.211.1583446418920;
        Thu, 05 Mar 2020 14:13:38 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n8sm16366198qke.37.2020.03.05.14.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:13:38 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH linus/master 2/2] rcu/tree: Add a shrinker to prevent OOM due to kfree_rcu() batching
Date:   Thu,  5 Mar 2020 17:13:23 -0500
Message-Id: <20200305221323.66051-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200305221323.66051-1-joel@joelfernandes.org>
References: <20200305221323.66051-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

To reduce grace periods and improve kfree() performance, we have done
batching recently dramatically bringing down the number of grace periods
while giving us the ability to use kfree_bulk() for efficient kfree'ing.

However, this has increased the likelihood of OOM condition under heavy
kfree_rcu() flood on small memory systems. This patch introduces a
shrinker which starts grace periods right away if the system is under
memory pressure due to existence of objects that have still not started
a grace period.

With this patch, I do not observe an OOM anymore on a system with 512MB
RAM and 8 CPUs, with the following rcuperf options:

rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000
rcuperf.kfree_rcu_test=1 rcuperf.kfree_mult=2

NOTE:
On systems with no memory pressure, the patch has no effect as intended.

Cc: urezki@gmail.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/rcu/tree.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d91c9156fab2e..28ec35e15529d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2723,6 +2723,8 @@ struct kfree_rcu_cpu {
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
+	// Number of objects for which GP not started
+	int count;
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
@@ -2791,6 +2793,7 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 
 	krwp->head_free = krcp->head;
 	krcp->head = NULL;
+	krcp->count = 0;
 	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
 	queue_rcu_work(system_wq, &krwp->rcu_work);
 	return true;
@@ -2864,6 +2867,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	head->func = func;
 	head->next = krcp->head;
 	krcp->head = head;
+	krcp->count++;
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
@@ -2879,6 +2883,58 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
+static unsigned long
+kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long flags, count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_online_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		spin_lock_irqsave(&krcp->lock, flags);
+		count += krcp->count;
+		spin_unlock_irqrestore(&krcp->lock, flags);
+	}
+
+	return count;
+}
+
+static unsigned long
+kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu, freed = 0;
+	unsigned long flags;
+
+	for_each_online_cpu(cpu) {
+		int count;
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		count = krcp->count;
+		spin_lock_irqsave(&krcp->lock, flags);
+		if (krcp->monitor_todo)
+			kfree_rcu_drain_unlock(krcp, flags);
+		else
+			spin_unlock_irqrestore(&krcp->lock, flags);
+
+		sc->nr_to_scan -= count;
+		freed += count;
+
+		if (sc->nr_to_scan <= 0)
+			break;
+	}
+
+	return freed;
+}
+
+static struct shrinker kfree_rcu_shrinker = {
+	.count_objects = kfree_rcu_shrink_count,
+	.scan_objects = kfree_rcu_shrink_scan,
+	.batch = 0,
+	.seeks = DEFAULT_SEEKS,
+};
+
 void __init kfree_rcu_scheduler_running(void)
 {
 	int cpu;
@@ -3774,6 +3830,8 @@ static void __init kfree_rcu_batch_init(void)
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
+	if (register_shrinker(&kfree_rcu_shrinker))
+		pr_err("Failed to register kfree_rcu() shrinker!\n");
 }
 
 void __init rcu_init(void)
-- 
2.25.0.265.gbab2e86ba0-goog

