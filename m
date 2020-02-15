Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36568C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F66A2187F
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724865;
	bh=Ru3txPQlXErJ2gix0wJKGvWyy+CaIo0Xp/+EZ280OVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FNeW49znAbEAiUxsBnZntOqBX53m8txBu9XbAh4UEExVNaIFqysCErdPVKR/s+G4e
	 4TpznxRGDxgxDZ00a5sQBjQXMAA+uibtgEw+WYhzyMryJPd4fzlCiKcG87E2ZjXUaK
	 65OryEt4OvwBIrVSrmM0kwvRg9BYciJSVjkRtIQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgBOABE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:01:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbgBOABE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:01:04 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A464222314;
        Sat, 15 Feb 2020 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724864;
        bh=Ru3txPQlXErJ2gix0wJKGvWyy+CaIo0Xp/+EZ280OVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5KOqtMAjg9SedFcb6tFzc3Wfo6rhvjBVp1Wl5ve26hW5AHV4OuOMU2PfOCk/I323
         BpTwVR6q6qsCu50Im4RwqB0b0vnUk9/BCLBoW4Dqg30AuUcCNofJZoPiYT/VKP+aB8
         6oPTMkhTvof9lpE+6uHDSOQHT6s1I4ysYCFvQyxw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/2] rcu: Add a trace event for kfree_rcu() use of kfree_bulk()
Date:   Fri, 14 Feb 2020 16:00:53 -0800
Message-Id: <20200215000053.14456-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215000031.GA14315@paulmck-ThinkPad-P72>
References: <20200215000031.GA14315@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The event is given three parameters, first one is the name
of RCU flavour, second one is the number of elements in array
for free and last one is an address of the array holding
pointers to be freed by the kfree_bulk() function.

To enable the trace event your kernel has to be build with
CONFIG_RCU_TRACE=y, after that it is possible to track the
events using ftrace subsystem.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
 kernel/rcu/tree.c          |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5e49b06..49a49e6 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -624,6 +624,34 @@ TRACE_EVENT_RCU(rcu_invoke_kfree_callback,
 );
 
 /*
+ * Tracepoint for the invocation of a single RCU callback of the special
+ * kfree_bulk() form. The first argument is the RCU flavor, the second
+ * argument is a number of elements in array to free, the third is an
+ * address of the array holding nr_records entries.
+ */
+TRACE_EVENT_RCU(rcu_invoke_kfree_bulk_callback,
+
+	TP_PROTO(const char *rcuname, unsigned long nr_records, void **p),
+
+	TP_ARGS(rcuname, nr_records, p),
+
+	TP_STRUCT__entry(
+		__field(const char *, rcuname)
+		__field(unsigned long, nr_records)
+		__field(void **, p)
+	),
+
+	TP_fast_assign(
+		__entry->rcuname = rcuname;
+		__entry->nr_records = nr_records;
+		__entry->p = p;
+	),
+
+	TP_printk("%s bulk=0x%p nr_records=%lu",
+		__entry->rcuname, __entry->p, __entry->nr_records)
+);
+
+/*
  * Tracepoint for exiting rcu_do_batch after RCU callbacks have been
  * invoked.  The first argument is the name of the RCU flavor,
  * the second argument is number of callbacks actually invoked,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 51a3aa8..909f97e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2792,6 +2792,9 @@ static void kfree_rcu_work(struct work_struct *work)
 		debug_rcu_head_unqueue_bulk(bhead->head_free_debug);
 
 		rcu_lock_acquire(&rcu_callback_map);
+		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
+			bhead->nr_records, bhead->records);
+
 		kfree_bulk(bhead->nr_records, bhead->records);
 		rcu_lock_release(&rcu_callback_map);
 
-- 
2.9.5

