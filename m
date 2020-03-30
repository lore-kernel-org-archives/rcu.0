Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2267DC2D0ED
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E069D20780
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="x1VGsvdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgC3Cdf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:33:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33089 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgC3Cdf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id c14so13969118qtp.0
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wx0JY2YKiW3y6xXQtIfMDOCqiN7fPBTCk6pvf651C60=;
        b=x1VGsvdOgbW/pXh3K2fqEFIrtX7CGT8Kj9GkfUuhJ8X66LsZN584UWKXUs/dyaR6Uy
         rskvRF/ZZBYw63xgUm1Ivc2mBaaKNEoUxVmZK6nYp83mdBOhL3z+bR5+bMB7SLBVqF2H
         5bdDD8rjYW1c5sAQfJh2fVXftxZB5W0S4KVZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wx0JY2YKiW3y6xXQtIfMDOCqiN7fPBTCk6pvf651C60=;
        b=CbFxoMqiDj220gHKDg8ujbF7MTttgj2mPv0mRbLkSOAvDXRT62qAt5X2okByDaq5pO
         AeLmqi+LI8bOl//VzM4Z49j7Vnyw5hrYIKgngHSzPPEAgky5Ycxf1B8XGesUsrshHukc
         DEpCn1ZJx7LLLRYIV0cEmPrWge/egikgYNjhvYJs1BnTkzE2VuYqfUvFfXE7xNqfIJfc
         OfnDONsu8HnKtL47ugW5Tmcq1r3gG22kSxrPuQH1Q8BtNc7oOqVWhffbRVYwNxhvK83W
         jxmdhZEJ8B/BZqczoVQlLUJw6RSXxz+A37TVYuJQX0dbDzACKtjJO82pfCiqe2cxdNU2
         Jp5Q==
X-Gm-Message-State: ANhLgQ2gJt70k6k90dX4dFyv5XIdNrw7xev9kygRdEs04QRNhGaHjVl/
        NhQD9FaMYpPMr5IJNPGwzB4X4Q==
X-Google-Smtp-Source: ADFU+vtq1MY/K8kiAE34+qHLDxZNEQyC7+n4jsYMeFFHn7w7o9ddSCQKGt3nomzKdenQfVtzBbc36g==
X-Received: by 2002:ac8:6f46:: with SMTP id n6mr9692172qtv.119.1585535614134;
        Sun, 29 Mar 2020 19:33:34 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:33 -0700 (PDT)
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
Subject: [PATCH 03/18] rcu: Rename rcu_invoke_kfree_callback/rcu_kfree_callback
Date:   Sun, 29 Mar 2020 22:32:33 -0400
Message-Id: <20200330023248.164994-4-joel@joelfernandes.org>
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

Rename rcu_invoke_kfree_callback to rcu_invoke_kvfree_callback.
Do the same with second trace event, that is rcu_kfree_callback,
it becomes rcu_kvfree_callback. The reason is to be aligned with
kvfree notation.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 8 ++++----
 kernel/rcu/tiny.c          | 2 +-
 kernel/rcu/tree.c          | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index f9a7811148e2a..0ee93d0b1daa8 100644
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
index 4b99f7b88beec..3dd8e6e207b09 100644
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
index 2d10c50621c38..88b744ce896c0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2744,7 +2744,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
 	if (__is_kfree_rcu_offset((unsigned long)func))
-		trace_rcu_kfree_callback(rcu_state.name, head,
+		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
 					 rcu_segcblist_n_cbs(&rdp->cblist));
 	else
@@ -2935,7 +2935,7 @@ static void kfree_rcu_work(struct work_struct *work)
 		next = head->next;
 		debug_rcu_head_unqueue(head);
 		rcu_lock_acquire(&rcu_callback_map);
-		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
+		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
 			kvfree((void *)head - offset);
-- 
2.26.0.rc2.310.g2932bb562d-goog

