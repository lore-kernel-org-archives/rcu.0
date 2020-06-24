Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22A9C433E3
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB0520823
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029575;
	bh=TnQiolA6D8Fm8sLu96I73u+4PGM+rRJ0dDA/VI0CGrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PuPugCcQpCJyGioTBQ+zXskrg7gcm9hICcdkUgb3QMzlaJLWcRRVLa03Lm1SunSbt
	 sSP3bvpG9DX7hxLNErMOCRtN9iQxBDIwxqNeuEKgFjtb/6FsxyF7vyqw7vbwXfYRWV
	 lCurmzsU1b/BXODH2pI23GorXIFaEn4mogcTSKRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406449AbgFXUMz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406398AbgFXUMc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 736F720857;
        Wed, 24 Jun 2020 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029551;
        bh=TnQiolA6D8Fm8sLu96I73u+4PGM+rRJ0dDA/VI0CGrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icLKrPawcATtokb2umksIhSUxFECFh0BKx/yFZqtsXZvfMAqTE/uaeNWyCUF2hyqt
         oJQlOEtr9dfobKnUMsAmh1z7panEjTcgIqFFQkBkulZ1+HwdBoGDZwMS/yNht77+4S
         mAvANqIFzobfG4ieOFdNuX4XylwwNmtboiLlBskw=
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
Subject: [PATCH tip/core/rcu 16/17] rcu: Introduce single argument kvfree_rcu() interface
Date:   Wed, 24 Jun 2020 13:12:25 -0700
Message-Id: <20200624201226.21197-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Make kvfree_rcu() capable of freeing objects that will not
embed an rcu_head within it. This saves storage overhead in
such objects. Reclaiming headless objects this way requires
only a single argument (pointer to the object).

After this patch, there are two ways to use kvfree_rcu():

a) kvfree_rcu(ptr, rhf);
    struct X {
        struct rcu_head rhf;
        unsigned char data[100];
    };

    void *ptr = kvmalloc(sizeof(struct X), GFP_KERNEL);
    if (ptr)
        kvfree_rcu(ptr, rhf);

b) kvfree_rcu(ptr);
    void *ptr = kvmalloc(some_bytes, GFP_KERNEL);
    if (ptr)
        kvfree_rcu(ptr);

Note that the headless usage (example b) can only be used in a code
that can sleep. This is enforced by the CONFIG_DEBUG_ATOMIC_SLEEP
option.

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 51b26ab..d15d46d 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -877,12 +877,42 @@ do {									\
 
 /**
  * kvfree_rcu() - kvfree an object after a grace period.
- * @ptr:	pointer to kvfree
- * @rhf:	the name of the struct rcu_head within the type of @ptr.
  *
- * Same as kfree_rcu(), just simple alias.
+ * This macro consists of one or two arguments and it is
+ * based on whether an object is head-less or not. If it
+ * has a head then a semantic stays the same as it used
+ * to be before:
+ *
+ *     kvfree_rcu(ptr, rhf);
+ *
+ * where @ptr is a pointer to kvfree(), @rhf is the name
+ * of the rcu_head structure within the type of @ptr.
+ *
+ * When it comes to head-less variant, only one argument
+ * is passed and that is just a pointer which has to be
+ * freed after a grace period. Therefore the semantic is
+ *
+ *     kvfree_rcu(ptr);
+ *
+ * where @ptr is a pointer to kvfree().
+ *
+ * Please note, head-less way of freeing is permitted to
+ * use from a context that has to follow might_sleep()
+ * annotation. Otherwise, please switch and embed the
+ * rcu_head structure within the type of @ptr.
  */
-#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
+#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
+	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
+
+#define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
+#define kvfree_rcu_arg_2(ptr, rhf) kfree_rcu(ptr, rhf)
+#define kvfree_rcu_arg_1(ptr)					\
+do {								\
+	typeof(ptr) ___p = (ptr);				\
+								\
+	if (___p)						\
+		kvfree_call_rcu(NULL, (rcu_callback_t) (___p));	\
+} while (0)
 
 /*
  * Place this after a lock-acquisition primitive to guarantee that
-- 
2.9.5

