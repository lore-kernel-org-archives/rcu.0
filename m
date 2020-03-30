Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2C2C43331
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0633C20780
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Hkkf7fhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgC3CeH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46593 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbgC3Cdr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id u4so17489850qkj.13
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehI/mevr7oGjGlbprsNt2erBqRqo03dz0gk8qK2323I=;
        b=Hkkf7fhI9UgKMG2bmf1X4tv05OtccwFMkvjxvsFynnH81KwsXpgysqGhe0jyrTAFx8
         vtgbEk9Dq27acsmjbGZnmonsgzE0Eal+DdboJtO72c5rgwanQS6VMOhputaGm3E4H/d4
         9/eWwrgjl5zhL/Jrdd1K0fyGGeiW0rdvBddNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehI/mevr7oGjGlbprsNt2erBqRqo03dz0gk8qK2323I=;
        b=HOiupnrvaXQo4EJUw9169k5HCt/f2MhhUMxmJk8DY/M9GzoOC0z9ZMkkTl13v7zne7
         ia5AFKOcFv4qTvT8Qb+OJfsZDqVviYN6f2cGHAZ1ukeegcPGkDSiJl2l9aM06ek5FTP6
         ZBXCeDevhMfo87si9g7a/mAWuMwRKSPYiJ9rnXP1n3by4lMJwIt0NS3r2VzT7ElzAml9
         1gr/5yrtIROuHUhPL5d7HWy4k2jw8jx2mmabt1+RPBSXw3aMJ0Yj9IWcBR4/fbbO0dbf
         iN/rCKbvPl6YEIbOXc7X/LBawlgT8TuTzZ1fKmSSEIFMaDnKGWGs8evHWad79dguj8lM
         QeBA==
X-Gm-Message-State: ANhLgQ0BiVY7OfdxWwV4AHFV/XaVg5wDR+c5ff8CtJiOhpaDMu0KiQW0
        I1+mnlcM3zwBf3DjOTEFkQVeHQ==
X-Google-Smtp-Source: ADFU+vsEu6bs9H+nTRyqOkzVOqwut6t53PnZdb4J1el0BLUwgt9JHzOjhj/hAdHYb48agOxgcw9Hfw==
X-Received: by 2002:a37:2fc3:: with SMTP id v186mr9919220qkh.311.1585535625444;
        Sun, 29 Mar 2020 19:33:45 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:45 -0700 (PDT)
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
Subject: [PATCH 14/18] rcu/tiny: Support reclaim for head-less object
Date:   Sun, 29 Mar 2020 22:32:44 -0400
Message-Id: <20200330023248.164994-15-joel@joelfernandes.org>
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

Make a kvfree_call_rcu() function to support head-less
freeing. Same as for tree-RCU, for such purpose we store
pointers in array. SLAB and vmalloc ptrs. are mixed and
coexist together.

Under high memory pressure it can be that maintaining of
arrays becomes impossible. Objects with an rcu_head are
released via call_rcu(). When it comes to the head-less
variant, the kvfree() call is directly inlined, i.e. we
do the same as for tree-RCU:
    a) wait until a grace period has elapsed;
    b) direct inlining of the kvfree() call.

Thus the current context has to follow might_sleep()
annotation. Also please note that for tiny-RCU any
call of synchronize_rcu() is actually a quiescent
state, therefore (a) does nothing.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tiny.c | 157 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 508c82faa45c3..b1c31a935db93 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -40,6 +40,29 @@ static struct rcu_ctrlblk rcu_ctrlblk = {
 	.curtail	= &rcu_ctrlblk.rcucblist,
 };
 
+/* Can be common with tree-RCU. */
+#define KVFREE_DRAIN_JIFFIES (HZ / 50)
+
+/* Can be common with tree-RCU. */
+struct kvfree_rcu_bulk_data {
+	unsigned long nr_records;
+	struct kvfree_rcu_bulk_data *next;
+	void *records[];
+};
+
+/* Can be common with tree-RCU. */
+#define KVFREE_BULK_MAX_ENTR \
+	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
+
+static struct kvfree_rcu_bulk_data *kvhead;
+static struct kvfree_rcu_bulk_data *kvhead_free;
+static struct kvfree_rcu_bulk_data *kvcache;
+
+static DEFINE_STATIC_KEY_FALSE(rcu_init_done);
+static struct delayed_work monitor_work;
+static struct rcu_work rcu_work;
+static bool monitor_todo;
+
 void rcu_barrier(void)
 {
 	wait_rcu_gp(call_rcu);
@@ -177,9 +200,137 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
+static inline bool
+kvfree_call_rcu_add_ptr_to_bulk(void *ptr)
+{
+	struct kvfree_rcu_bulk_data *bnode;
+
+	if (!kvhead || kvhead->nr_records == KVFREE_BULK_MAX_ENTR) {
+		bnode = xchg(&kvcache, NULL);
+		if (!bnode)
+			bnode = (struct kvfree_rcu_bulk_data *)
+				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+
+		if (unlikely(!bnode))
+			return false;
+
+		/* Initialize the new block. */
+		bnode->nr_records = 0;
+		bnode->next = kvhead;
+
+		/* Attach it to the bvhead. */
+		kvhead = bnode;
+	}
+
+	/* Done. */
+	kvhead->records[kvhead->nr_records++] = ptr;
+	return true;
+}
+
+static void
+kvfree_rcu_work(struct work_struct *work)
+{
+	struct kvfree_rcu_bulk_data *kvhead_tofree, *next;
+	unsigned long flags;
+	int i;
+
+	local_irq_save(flags);
+	kvhead_tofree = kvhead_free;
+	kvhead_free = NULL;
+	local_irq_restore(flags);
+
+	/* Reclaim process. */
+	for (; kvhead_tofree; kvhead_tofree = next) {
+		next = kvhead_tofree->next;
+
+		for (i = 0; i < kvhead_tofree->nr_records; i++) {
+			debug_rcu_head_unqueue((struct rcu_head *)
+				kvhead_tofree->records[i]);
+			kvfree(kvhead_tofree->records[i]);
+		}
+
+		if (cmpxchg(&kvcache, NULL, kvhead_tofree))
+			free_page((unsigned long) kvhead_tofree);
+	}
+}
+
+static inline bool
+queue_kvfree_rcu_work(void)
+{
+	/* Check if the free channel is available. */
+	if (kvhead_free)
+		return false;
+
+	kvhead_free = kvhead;
+	kvhead = NULL;
+
+	/*
+	 * Queue the job for memory reclaim after GP.
+	 */
+	queue_rcu_work(system_wq, &rcu_work);
+	return true;
+}
+
+static void kvfree_rcu_monitor(struct work_struct *work)
+{
+	unsigned long flags;
+	bool queued;
+
+	local_irq_save(flags);
+	queued = queue_kvfree_rcu_work();
+	if (queued)
+		/* Success. */
+		monitor_todo = false;
+	local_irq_restore(flags);
+
+	/*
+	 * If previous RCU reclaim process is still in progress,
+	 * schedule the work one more time to try again later.
+	 */
+	if (monitor_todo)
+		schedule_delayed_work(&monitor_work,
+			KVFREE_DRAIN_JIFFIES);
+}
+
 void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	call_rcu(head, func);
+	unsigned long flags;
+	bool success;
+	void *ptr;
+
+	if (head) {
+		ptr = (void *) head - (unsigned long) func;
+	} else {
+		might_sleep();
+		ptr = (void *) func;
+	}
+
+	if (debug_rcu_head_queue(ptr)) {
+		/* Probable double free, just leak. */
+		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
+			  __func__, head);
+		return;
+	}
+
+	local_irq_save(flags);
+	success = kvfree_call_rcu_add_ptr_to_bulk(ptr);
+	if (static_branch_likely(&rcu_init_done)) {
+		if (success && !monitor_todo) {
+			monitor_todo = true;
+			schedule_delayed_work(&monitor_work,
+				KVFREE_DRAIN_JIFFIES);
+		}
+	}
+	local_irq_restore(flags);
+
+	if (!success) {
+		if (!head) {
+			synchronize_rcu();
+			kvfree(ptr);
+		} else {
+			call_rcu(head, func);
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
@@ -188,4 +339,8 @@ void __init rcu_init(void)
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
 	rcu_early_boot_tests();
 	srcu_init();
+
+	INIT_DELAYED_WORK(&monitor_work, kvfree_rcu_monitor);
+	INIT_RCU_WORK(&rcu_work, kvfree_rcu_work);
+	static_branch_enable(&rcu_init_done);
 }
-- 
2.26.0.rc2.310.g2932bb562d-goog

