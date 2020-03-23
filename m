Return-Path: <SRS0=+8aq=5I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00479C4332B
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC36B206F9
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLFs93Yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgCWLgu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:36:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36588 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgCWLgk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Mar 2020 07:36:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id g12so14140898ljj.3;
        Mon, 23 Mar 2020 04:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YmBYmS63U9/15/NydakT4NOTAZC5PmBIzcV68l5d7lw=;
        b=QLFs93Yf1DjjUJrqzZMwDLEwOci8q8T5i4cWEFA2DBbQkmQsrnfHc0YE/+xyV5WuW3
         nuJhxQLdI5ZSMXxzwhjkPcW9PVq9KEOblddkc7REaWg1NO5nzYJJ/X4PAGFJhaBUEjZA
         WVDBAZU6TE9ZBfUNCiejesdVIlDvp55EOAHAwBEjwmJvMsHdB2wxuqtcfZYJ/oToeQya
         mzhLGOI7NOitEgII2EkjVTtozvRo8Ozz6JYU1VjkZFnNQX3kEiz7zCCnPPsZF5LFow3P
         KeaXWyIMvpiDIh9Iqp8TbeKsCOa8BShFrcAYR2pyuIo/EsqOqS9XAG4UTWuIdlJYnqhw
         tH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YmBYmS63U9/15/NydakT4NOTAZC5PmBIzcV68l5d7lw=;
        b=b4GXdJFuLtkdJMK4Mo9rHUylv8C0bfUt+zb/9gglL+pkha8xaomj9qE+FFaP38KnIN
         6T5N3BdFE87ISjMOBKfeiuILQo3qWZFeVXDdHcdbVfs7HMYu8dE3uMPKX1LoFqIF3xU/
         sx/m/qxFXr+EHK+vAncKaUco4Mx0h2pqg3uVBflPTXFLbKicS26EoNA34GaX0cEoH4i9
         cie8bTYCrMlfGZqS8KEEWEPNHWWXUl7iiWBWOlwsNbji1/fzCcJH44qlOHufQoP8O+FN
         t9/nhFdXexDomqsllrGDxF8E5VKx5qsSFeOg4ga7slLVMaUN7Cj2hmENpIoBr05B1iSR
         oeew==
X-Gm-Message-State: ANhLgQ2PhgGJFuA620KtP4drrIDhZ5BawjD1exhmpK+IodyHb3hpjTxO
        6j9zuz2pBQJ9vn40ASP6hUiAobRrpjs=
X-Google-Smtp-Source: ADFU+vsFZN0lVqUF6byQBltbpBV1iWBNQ3Oqg32PJNrInSuXr/J7Akr43u/1rCR/o1YD+ZoT28LAGA==
X-Received: by 2002:a2e:b302:: with SMTP id o2mr13711074lja.289.1584963397766;
        Mon, 23 Mar 2020 04:36:37 -0700 (PDT)
Received: from localhost.localdomain (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id r23sm8079268lfi.89.2020.03.23.04.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 04:36:37 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 6/7] rcu/tiny: support reclaim for head-less object
Date:   Mon, 23 Mar 2020 12:36:20 +0100
Message-Id: <20200323113621.12048-7-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323113621.12048-1-urezki@gmail.com>
References: <20200323113621.12048-1-urezki@gmail.com>
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

