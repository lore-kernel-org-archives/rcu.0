Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A32C83004
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839DA20775
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5+emd78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgD1U7u (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726902AbgD1U7t (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAECC03C1AD;
        Tue, 28 Apr 2020 13:59:47 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a21so203567ljb.9;
        Tue, 28 Apr 2020 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnJAtzNPQwOuN35prMWYFplXmKr7NAfEhiUXNxLclG8=;
        b=s5+emd78kekw/TXnvyA/bAOGc0SGZJAVB/4WGiYByfbpRI2x2pn3OrAbtzIvYhDPjg
         Xn63HYYc1XoBn8Jw9nvyZZH6daZ4v6723VaraNGm/RUwC5omukWIHw46Zg1xWaUcGBNZ
         oWnGge8C2RJuhXkJKzxwv5ACwD18xJChSmTWAaQuteDz8wCucOZYeCqGzU+ew0ixZ70z
         +kd1806zFpfw7lsZtANv/4OyHov/Wf/l+TUIGtjCkSIFKvQqB6vbiM8TlUb6X74bPQ1U
         WNupVjZ7RXbsPY5YXgkc8vGnbMdvna2JCxbwpfg75EvHH9ftEwW/NUBpxR8OWCNq0wzp
         //nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnJAtzNPQwOuN35prMWYFplXmKr7NAfEhiUXNxLclG8=;
        b=bvjQLw1zYKQ9icRlIbo+9/5EzBa4y7XqsDxJ4LmqGNS62SXvHxjyNJsm7BnyOOWl9G
         dWEIa8RdFnj4U0jrha6FkCYlzSxn9txfV04Bm2GWHUcF8sa4zeY6xxRErTHth5d1FtO3
         r4b3GAEnOLtMhLn9/wm+iZzvAI7yF8UPj4iV4nFP9EVrWGtMBZrbIZ329GNDNIPEYIZk
         cNJWd81lGeKYsXO68UTgGPA6eyN4/sxSZozzDNRu+tV9apJE2VJcyS16gF/CxFZcMsx2
         w07FnNL6u4hh4FJP+hukJllbvMlLZXSXvM//MFbtejjsbHUYKjX01WCebnLfBir3FTCC
         8q5Q==
X-Gm-Message-State: AGi0Puadex//G8zv9yd4C3kIt/C7xzP7jGNTkXnAObr24HyjYJp/CgHd
        qr7shAk4nyFsVK9K4l1oobiSCuuGBFRyyw==
X-Google-Smtp-Source: APiQypIVpmrbm6mASEgB0xwC50tr3MbUHiwxa5AkAqbG8qXM4FhLBQercE0GBtCprGgQO16dDjqtNQ==
X-Received: by 2002:a2e:5813:: with SMTP id m19mr10296851ljb.230.1588107585895;
        Tue, 28 Apr 2020 13:59:45 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:45 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 14/24] rcu: Rename __is_kfree_rcu_offset() macro
Date:   Tue, 28 Apr 2020 22:58:53 +0200
Message-Id: <20200428205903.61704-15-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Rename __is_kfree_rcu_offset to __is_kvfree_rcu_offset.
All RCU paths use kvfree() now instead of kfree(), thus
rename it.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h | 6 +++---
 kernel/rcu/tiny.c        | 2 +-
 kernel/rcu/tree.c        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 659cbfa7581a..1d25e6c23ebd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -828,16 +828,16 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /*
  * Does the specified offset indicate that the corresponding rcu_head
- * structure can be handled by kfree_rcu()?
+ * structure can be handled by kvfree_rcu()?
  */
-#define __is_kfree_rcu_offset(offset) ((offset) < 4096)
+#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
 
 /*
  * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
  */
 #define __kfree_rcu(head, offset) \
 	do { \
-		BUILD_BUG_ON(!__is_kfree_rcu_offset(offset)); \
+		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
 		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
 	} while (0)
 
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 3dd8e6e207b0..aa897c3f2e92 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -85,7 +85,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 	unsigned long offset = (unsigned long)head->func;
 
 	rcu_lock_acquire(&rcu_callback_map);
-	if (__is_kfree_rcu_offset(offset)) {
+	if (__is_kvfree_rcu_offset(offset)) {
 		trace_rcu_invoke_kvfree_callback("", head, offset);
 		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 821de8149928..5f53368f2554 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2793,7 +2793,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
-	if (__is_kfree_rcu_offset((unsigned long)func))
+	if (__is_kvfree_rcu_offset((unsigned long)func))
 		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
 					 rcu_segcblist_n_cbs(&rdp->cblist));
@@ -3079,7 +3079,7 @@ static void kfree_rcu_work(struct work_struct *work)
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
+		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
 			kvfree(ptr);
 
 		rcu_lock_release(&rcu_callback_map);
-- 
2.20.1

