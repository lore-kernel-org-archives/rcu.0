Return-Path: <SRS0=wCpI=5A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8C5C18E5B
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196C1206B1
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSsrRNBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgCOSS6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:18:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34406 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgCOSSy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Mar 2020 14:18:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id s13so16066901ljm.1;
        Sun, 15 Mar 2020 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hEOsRnfdaxErC8P/6goPXi+p+z2Kdea7bx67OSB0mN0=;
        b=BSsrRNBtCTm9wOLf/Xh89a+6+qMYgylPjBRsgM7hphau2xV8mnjkpRmOhAJdeL0VHP
         eBFv8Zyt7LouCIAYcTTEI2eQUiCJulgr7SbIsr0idD+wXJr0QMq56e5pExWmhpiOiM6o
         /qipu0+B9JxBIyvVZ3w402fjXVr2IwiUCXxcMpeodlIWe/sB4Y/wJ4UBQ1ghPpcn30KE
         UjCVAIpV1QEbSBq03aFbNHUT4a6poc78XuYRJAu+y/M5EWQpmlefQsKu4unYxND+tkYc
         WPxbIgJLr5Y4SvKCJrffjhK5Yuo6KvpZMmzxR2dk6n3xzhBn6xIfCmnmoxFqONiYriXl
         j07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hEOsRnfdaxErC8P/6goPXi+p+z2Kdea7bx67OSB0mN0=;
        b=qVAD3NtZBse6gYzhJ7rqr7VD8bf+wd3GcNNjMPyPWaz8Ct4k34eNvcHQWD2JU3VQjF
         qE4zFdG4ZNsIyawrgyM4eAoGdOge8lwSDlHQFYPLYg3WmTHlxtbu8bW4ZpJDAy8vixmT
         Hp6slkJjEQB05bdsnKATQni5c9dm4mJfPtyvbniLbXQXdkttMWxmGvDhjMMEbA5ZDtLb
         lhMQZORRZM+Ba26arxh5i7bahoT0O+iC1VgO+1rJ85058Bv73hjzDISM3NkPdCLgVdYE
         z0YI2m+bn3eLxU7t/CKM851Vq1tI5INPXHJaIOH4pRQEiNzQCi5qDc9I7crD85raVhBv
         0IlQ==
X-Gm-Message-State: ANhLgQ2vg4fbLU0Hw4rJ6B1j35PqfDqDhgly4rjPRe67HfAHXANOVFnq
        fx1oy7Vv9mI9ztNJhZ5BGQvS0+8Pug8Nyw==
X-Google-Smtp-Source: ADFU+vut7oDvRRU+v36G7J8MNcFLIXiEk40P6AuJVFVo4Jga21NrF1T69Isgu5sU/kiq5EZyEK9MQQ==
X-Received: by 2002:a2e:8811:: with SMTP id x17mr10060312ljh.37.1584296331669;
        Sun, 15 Mar 2020 11:18:51 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o15sm3040629ljj.55.2020.03.15.11.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 11:18:51 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v1 3/6] rcu: rename rcu_invoke_kfree_callback/rcu_kfree_callback
Date:   Sun, 15 Mar 2020 19:18:37 +0100
Message-Id: <20200315181840.6966-4-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315181840.6966-1-urezki@gmail.com>
References: <20200315181840.6966-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Rename rcu_invoke_kfree_callback to rcu_invoke_kvfree_callback.
Do the same with second trace event, that is rcu_kfree_callback,
it becomes rcu_kvfree_callback. The reason is to be aligned with
kvfree notation.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/trace/events/rcu.h | 8 ++++----
 kernel/rcu/tiny.c          | 2 +-
 kernel/rcu/tree.c          | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index f9a7811148e2..0ee93d0b1daa 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -506,13 +506,13 @@ TRACE_EVENT_RCU(rcu_callback,
 
 /*
  * Tracepoint for the registration of a single RCU callback of the special
- * kfree() form.  The first argument is the RCU type, the second argument
+ * kvfree() form.  The first argument is the RCU type, the second argument
  * is a pointer to the RCU callback, the third argument is the offset
  * of the callback within the enclosing RCU-protected data structure,
  * the fourth argument is the number of lazy callbacks queued, and the
  * fifth argument is the total number of callbacks queued.
  */
-TRACE_EVENT_RCU(rcu_kfree_callback,
+TRACE_EVENT_RCU(rcu_kvfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset,
 		 long qlen),
@@ -596,12 +596,12 @@ TRACE_EVENT_RCU(rcu_invoke_callback,
 
 /*
  * Tracepoint for the invocation of a single RCU callback of the special
- * kfree() form.  The first argument is the RCU flavor, the second
+ * kvfree() form.  The first argument is the RCU flavor, the second
  * argument is a pointer to the RCU callback, and the third argument
  * is the offset of the callback within the enclosing RCU-protected
  * data structure.
  */
-TRACE_EVENT_RCU(rcu_invoke_kfree_callback,
+TRACE_EVENT_RCU(rcu_invoke_kvfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset),
 
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 4b99f7b88bee..3dd8e6e207b0 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -86,7 +86,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 
 	rcu_lock_acquire(&rcu_callback_map);
 	if (__is_kfree_rcu_offset(offset)) {
-		trace_rcu_invoke_kfree_callback("", head, offset);
+		trace_rcu_invoke_kvfree_callback("", head, offset);
 		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
 		return true;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1c0a73616872..eef75cd210fd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2720,7 +2720,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
 	if (__is_kfree_rcu_offset((unsigned long)func))
-		trace_rcu_kfree_callback(rcu_state.name, head,
+		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
 					 rcu_segcblist_n_cbs(&rdp->cblist));
 	else
@@ -2909,7 +2909,7 @@ static void kfree_rcu_work(struct work_struct *work)
 		next = head->next;
 		debug_rcu_head_unqueue(head);
 		rcu_lock_acquire(&rcu_callback_map);
-		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
+		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
 			kvfree((void *)head - offset);
-- 
2.20.1

