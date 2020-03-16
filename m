Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BB8C4CECE
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 16:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F0B2071C
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 16:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yRrupE0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbgCPQcm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:32:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41735 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbgCPQci (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 12:32:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id i26so4964497qtq.8
        for <rcu@vger.kernel.org>; Mon, 16 Mar 2020 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WnVlBAntxMU0MXZ+RmdU8L+mrOyKQNUKTy7ZQi+XdC8=;
        b=yRrupE0w4MSh9gGyHF9e1ziDGwNrGhLF/dLaUnvrWu11MtqF4IxFB4BWiIfH57h59M
         6xYdwrzmqFWONkPJ3KDHCqKTvhDY1v6xpCIosPc1Z2krUhFFl+Zu6Y8T2FA6C6LS8fsd
         JHxM6Ma3AC4GWgmyuSvIFJqUakGi7RTMEUYU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnVlBAntxMU0MXZ+RmdU8L+mrOyKQNUKTy7ZQi+XdC8=;
        b=RigFPxrqW2PgI2Xifi6ZD2hp5M7+4UOshCIxsKvCE2D49VpKJWHTj7Ss4+h+egBYhv
         tCaACChWIUbOxwUez8wexL5NHaY2Jt3LcEC6kxaRw4WD1Es3TTDOSGW7DwF4OHdHSXfE
         p6jlectwBhrjRFdwPFGN/VTeXkImlnpc7Tko9BYguhiBq0d4wZ4scHNDUnjnHMqiDdrn
         dNjyvwUe4yJmQSFK9bCG6Lb08BcPbDhjxj2mORvtxe/cUYsVtv3P1V7V48QfEOKsnKyw
         CEHUIFR4TQx0Z5u0ciiKVH/Qbr4r37dTkbsAWqZVuiA37BnrKkUUGUMl4c70WKks15kE
         wPPQ==
X-Gm-Message-State: ANhLgQ3DaqzpbOknX9vmGudEpRD3Mx4LMW9jjJ35MdgvT81haf3L0ucE
        XjQnni/0pCJLPrUJdmLFgnmXww==
X-Google-Smtp-Source: ADFU+vtq0G5LtEJV/OjmUmq2TfxhUJeV8n+Ipq9JkxFR+qkcD+BHlYPmFz6RMjpq0mTjjM0s+BBsHQ==
X-Received: by 2002:ac8:1194:: with SMTP id d20mr903885qtj.243.1584376354881;
        Mon, 16 Mar 2020 09:32:34 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y127sm84139qkb.76.2020.03.16.09.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 09:32:34 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 rcu-dev 2/3] rcu/tree: Add a shrinker to prevent OOM due to kfree_rcu() batching
Date:   Mon, 16 Mar 2020 12:32:27 -0400
Message-Id: <20200316163228.62068-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200316163228.62068-1-joel@joelfernandes.org>
References: <20200316163228.62068-1-joel@joelfernandes.org>
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

Otherwise it easily OOMs with the above parameters.

NOTE:
1. On systems with no memory pressure, the patch has no effect as intended.
2. In the future, we can use this same mechanism to prevent grace periods
   from happening even more, by relying on shrinkers carefully.

Cc: urezki@gmail.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4a885af2ff73e..dc570dff68d7b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2801,6 +2801,8 @@ struct kfree_rcu_cpu {
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
+	// Number of objects for which GP not started
+	int count;
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
@@ -2914,6 +2916,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 				krcp->head = NULL;
 			}
 
+			krcp->count = 0;
+
 			/*
 			 * One work is per one batch, so there are two "free channels",
 			 * "bhead_free" and "head_free" the batch can handle. It can be
@@ -3050,6 +3054,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		krcp->head = head;
 	}
 
+	krcp->count++;
+
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 	    !krcp->monitor_todo) {
@@ -3064,6 +3070,58 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
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
@@ -3981,6 +4039,8 @@ static void __init kfree_rcu_batch_init(void)
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
+	if (register_shrinker(&kfree_rcu_shrinker))
+		pr_err("Failed to register kfree_rcu() shrinker!\n");
 }
 
 void __init rcu_init(void)
-- 
2.25.1.481.gfbce0eb801-goog

