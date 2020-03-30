Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9037C2D0ED
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F905206DB
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DeRVgPSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgC3CeP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45769 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbgC3Cdn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id c145so17490402qke.12
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgVjjqxhrtlCFDIsHkuC1uTJ/LkUZOMYLnLhSTfKyFo=;
        b=DeRVgPSq3h4ir1leXjxInBG2h8bq9qGUaf0q/6P5vVer49r4RyYdVmEqgmRvSGQgiR
         Szt5lyIL+P4fZAYle1WQ6mbTytS2I6VlQ9plfFUPqx/C6Z/OXRGykLv5/yyq2ciXUrK3
         uQEVTGkaN4TtsK0qXWZ7uhAXhcNSwwyMN8s6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgVjjqxhrtlCFDIsHkuC1uTJ/LkUZOMYLnLhSTfKyFo=;
        b=nNXh8XpQ+CdTbA+kh6qMEfhTabvm5myZB6493mqg71V4V9Wz4JNvyEabluMeE6+3HQ
         InuHgUkg4l5k6g0CFb0BGxzNGsAQyiMJFTG8aDmL7F9w6iwNfLjMQI5ikFVRqoYZXn/y
         DQELMnpSqPW3X7rsNy9HU+GirtYtXvHi+ltrSIEQy/nZ1NYImcQArPyjkH56G5cuZ1i1
         ehJr82UdeF/NqufPNtsTmisASYUau3pe9+etJvzIsB/mt28vHQYHYwgYLxv4BA1OnPKF
         0qVwlPaUMe7LABiEqvrEcjW+RR4CNiyWjbY79PpwHDbIIQvE/+RmGCjl8WFQHng86EhQ
         lg/w==
X-Gm-Message-State: ANhLgQ3nzP7jRQ1tzJjcHp5j0DhLkhY15ro2ofXpWvks7fMDDMSqFvYC
        FXv2aXgn1sjiYikI8YrbjNxq5A==
X-Google-Smtp-Source: ADFU+vunMDIJ4H3Pq+Krsea4u9kPIh06c+HxsJd5C4qvfZCMXYJheHm4aD9CNDZFXtrDOkjDRGKzpg==
X-Received: by 2002:a05:620a:1189:: with SMTP id b9mr7758077qkk.236.1585535622481;
        Sun, 29 Mar 2020 19:33:42 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:41 -0700 (PDT)
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
Subject: [PATCH 11/18] rcu/tree: Introduce expedited_drain flag
Date:   Sun, 29 Mar 2020 22:32:41 -0400
Message-Id: <20200330023248.164994-12-joel@joelfernandes.org>
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

It is used and set to true when the bulk array can not
be maintained, it happens under low memory condition
and memory pressure.

In that case the drain work is scheduled right away and
not after KFREE_DRAIN_JIFFIES. It tends to speed up the
reclaim path. On the other hand, there is no data showing
the difference yet.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8fbc8450284db..3b94526f490cb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3128,14 +3128,16 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
  * due to memory pressure.
  *
  * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
- * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
- * be free'd in workqueue context. This allows us to: batch requests together to
- * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
+ * every KFREE_DRAIN_JIFFIES number of jiffies or can be scheduled right away if
+ * a low memory is detected. All the objects in the batch will be free'd in
+ * workqueue context. This allows us to: batch requests together to reduce the
+ * number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
  */
 void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	bool expedited_drain = false;
 	void *ptr;
 
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
@@ -3161,6 +3163,14 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
+
+		/*
+		 * There was an issue to place the pointer directly
+		 * into array, due to memory pressure. Initiate an
+		 * expedited drain to accelerate lazy invocation of
+		 * appropriate free calls.
+		 */
+		expedited_drain = true;
 	}
 
 	WRITE_ONCE(krcp->count, krcp->count + 1);
@@ -3169,7 +3179,9 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 	    !krcp->monitor_todo) {
 		krcp->monitor_todo = true;
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+
+		schedule_delayed_work(&krcp->monitor_work,
+			expedited_drain ? 0 : KFREE_DRAIN_JIFFIES);
 	}
 
 unlock_return:
-- 
2.26.0.rc2.310.g2932bb562d-goog

