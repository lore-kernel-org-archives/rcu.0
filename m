Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4769AC433E0
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2346E20823
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029594;
	bh=WMtWKuWdgvCD4A+DhTMHuc/p48EQB1ZIjEEVdQlrlHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xqZxd/1d0m66mw/OO48QhdNwQ3Y9gELP6zgfF7ayRUTNU8Oa3rAcqYRCKpRr+BGaA
	 blJ/4xD7FjBgZGFPUMbfb9rCcKb7PmfhxXBHBjNEaOwhcZsVzQNUEFtNJf3HdkrCFO
	 /hDnwoQQp3I+RihKPpUXbMV5Q6eMCaNY4jAEaySY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406472AbgFXUNF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406395AbgFXUMb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B6021556;
        Wed, 24 Jun 2020 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029551;
        bh=WMtWKuWdgvCD4A+DhTMHuc/p48EQB1ZIjEEVdQlrlHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBYDQViezzLMyK6hA/HwSUC0gFmze990uNbrXnZVr/L0IHO4MCkj266CxHggvGVhC
         qez9aE/X6JieYVa5Dw3paUD47AVWaeHR9E2JRnsJjFka7OYhT/9O5zegdrVHc9PG3L
         31dQ0cmnSu7zp+PRyWGJpbRYE4iy+qL48JaG6Hzo=
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
Subject: [PATCH tip/core/rcu 14/17] rcu: Introduce 2 arg kvfree_rcu() interface
Date:   Wed, 24 Jun 2020 13:12:23 -0700
Message-Id: <20200624201226.21197-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

kvmalloc() can allocate two types of objects: SLAB backed
and vmalloc backed. How it behaves depends on requested
object's size and memory pressure.

Add a kvfree_rcu() interface that can free memory allocated
via kvmalloc(). It is a simple alias to kfree_rcu() which
can now handle either type of object.

<snip>
    struct test_kvfree_rcu {
        struct rcu_head rcu;
        unsigned char array[100];
    };

    struct test_kvfree_rcu *p;

    p = kvmalloc(10 * PAGE_SIZE);
    if (p)
        kvfree_rcu(p, rcu);
<snip>

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index b344fc8..51b26ab 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -875,6 +875,15 @@ do {									\
 		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 } while (0)
 
+/**
+ * kvfree_rcu() - kvfree an object after a grace period.
+ * @ptr:	pointer to kvfree
+ * @rhf:	the name of the struct rcu_head within the type of @ptr.
+ *
+ * Same as kfree_rcu(), just simple alias.
+ */
+#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
+
 /*
  * Place this after a lock-acquisition primitive to guarantee that
  * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
-- 
2.9.5

