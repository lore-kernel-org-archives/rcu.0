Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA87C2D0EF
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959E02078B
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vate42J2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgC3Cdl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:33:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39498 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgC3Cdl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id b62so17560598qkf.6
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1STg3B4NFmryGFsVQ39Fqcyyw2zeIxUup+slIF9OxYI=;
        b=vate42J2T1d4IR+p4SKAXzO/ZNqN9vu8zAMaADAJJq3jsp+Q3qXkRYHGB9gcbDfR5X
         yby/F2W/Z8EsSL7vC7Y/dMjfPVzClbZ7BbzFi3Jo2sSZZhn4N2rwuGJ3JSjqGl3MUieF
         p1dapi543VOjfTBXmPigUXE+aC4dPwbPpTuwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1STg3B4NFmryGFsVQ39Fqcyyw2zeIxUup+slIF9OxYI=;
        b=e9Ks/rW6wuDsl0Y07zN326on00fzuLPSaj9n8OeJ1kqY1lgU2EAKkhucMUTInpAdjW
         XMVHNiiPltrEUlfnEU6FdcyXJlF+Gl0gm/cZqu0boRqUawzCgDV6TN8Q+cLF9QPj2NEp
         0oOyNWGpKsXwCi7+sub9onRcI1ivZ37tMi2x9g3/tPh0SblArB/P7VLfFnRMW6J7kS00
         813Inwl7q8oqkosME2FgBPRhKzGZ5mgIt36GkXjljdU+0tRSnCB3Vx2th002OW9tcu9f
         NqtujsKAvOXX3Wd5eGGIJUW2nb3+IkAd7raF32QxSaPZepyDQJg7F9GxNJwFtY9HOgs5
         OA5Q==
X-Gm-Message-State: ANhLgQ3SKReZf2YciU9NvjfRRGtLni+Gt0Vq+YImLs7HfiqWG8OGxxw6
        tNrvYBw2jbXiMXXuNzdv2sC4gQ==
X-Google-Smtp-Source: ADFU+vsb7u7onAWM6SNZg0kNXedSUyJKJP7iWxDcLoGW/pjia1x5QLz+6JZM6GIVlbH8uur2r+xlOA==
X-Received: by 2002:a37:6357:: with SMTP id x84mr10162791qkb.490.1585535619962;
        Sun, 29 Mar 2020 19:33:39 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:39 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 09/18] rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro
Date:   Sun, 29 Mar 2020 22:32:39 -0400
Message-Id: <20200330023248.164994-10-joel@joelfernandes.org>
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

We can simplify KFREE_BULK_MAX_ENTR macro and get rid of
magic numbers which were used to make the structure to be
exactly one page.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8dfa4b32e4d00..cfe456e68c644 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2807,13 +2807,6 @@ EXPORT_SYMBOL_GPL(call_rcu);
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
 #define KFREE_N_BATCHES 2
 
-/*
- * This macro defines how many entries the "records" array
- * will contain. It is based on the fact that the size of
- * kfree_rcu_bulk_data structure becomes exactly one page.
- */
-#define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 3)
-
 /**
  * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
  * @nr_records: Number of active pointers in the array
@@ -2827,6 +2820,14 @@ struct kfree_rcu_bulk_data {
 	struct kfree_rcu_bulk_data *next;
 };
 
+/*
+ * This macro defines how many entries the "records" array
+ * will contain. It is based on the fact that the size of
+ * kfree_rcu_bulk_data structure becomes exactly one page.
+ */
+#define KFREE_BULK_MAX_ENTR \
+	((PAGE_SIZE - sizeof(struct kfree_rcu_bulk_data)) / sizeof(void *))
+
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
-- 
2.26.0.rc2.310.g2932bb562d-goog

