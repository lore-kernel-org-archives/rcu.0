Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B57C83007
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6DE2072A
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWL6Mhxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgD1VAC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727069AbgD1VAB (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 17:00:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DBFC03C1AC;
        Tue, 28 Apr 2020 14:00:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h4so189144ljg.12;
        Tue, 28 Apr 2020 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEunEa6ntH1HytcdQSdsY2CsdbEZEQ/S23NHaGYEDh0=;
        b=CWL6Mhxss7Hv7VG0ZlIx12jk8sHFvdJzDPhUwW40jXJ/R4y20EdTQ5Nqk1C7iyTu1A
         /NnaS20p/fcIuDjH62b+awTfCcP5fdc5Zo1ZuxyntzXrA0F7TkzLFSEPnyQQzk2x6bxU
         w/I7BKkaKWNxFO06OxepNfWb5QfIp+Sf8gJXVuVilwidIM+OorINFbKbFH5kz871t/6p
         FMX6JxEr+RNc9VK/aYO6sW9mmQQPTx2smO4BDGaqPkYIbtlYMAsOH9kNQoDbxhgNUB49
         snoL2XjyusdH6OFmnR/L0Bo1kn5nTu1xdtc4R2+siuvSwuj/zYa49CuhQK+YFIhdclY8
         jSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEunEa6ntH1HytcdQSdsY2CsdbEZEQ/S23NHaGYEDh0=;
        b=eyqnSnA+wXqLAiTx3BhBOvUVAlh5UeRc4zFGzfUou4fOLVEdbE+dZ5RW8U6SfeJkFa
         9aSgG+5qRCD19ggRW5l/uvSDfNnj8BpOibIoljUbgdMNbhzHVyf8m8YPafeMM8ifK/m/
         fzaXC8YYcl03tp3ejncNwy3ijuI7VALxyxsSF/X/rPft0NblgMbtu+QvS4MHKnSlX56l
         G2pIjHEteDgMzgVqovoWyaH4c7EEdr7DUYtL8d0XkN+Yqa2r+aNfFzZkQi0tBsga+vVt
         rn6eSWCdbwzwwgGRxZKXgxxdfYC6V1q0KHmGgwdST2wZhwNE0oEP3glZjFltCUF+2Ehc
         F7vg==
X-Gm-Message-State: AGi0PuYpAnkKfTslZWEUD5gH3qDyWzsWdFkP4wIWFEouLt8yPWvzcyhI
        hxAYZ3EEEvqAOEZDhqshcPlvcKr6sGm5ZA==
X-Google-Smtp-Source: APiQypIuEVHqAxoNEWEpH8q58I4tuk4mhXqNnaVsvdWrBoPEevlMRUF3qOaGJoFkVwIyEeRklqxn/g==
X-Received: by 2002:ac2:4426:: with SMTP id w6mr20163280lfl.8.1588107598830;
        Tue, 28 Apr 2020 13:59:58 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:58 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 22/24] rcu/tiny: support reclaim for head-less object
Date:   Tue, 28 Apr 2020 22:59:01 +0200
Message-Id: <20200428205903.61704-23-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

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
---
 kernel/rcu/tiny.c | 157 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 508c82faa45c..b1c31a935db9 100644
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
2.20.1

