Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5CCEB64DC
	for <rcu@archiver.kernel.org>; Tue, 11 Jul 2023 23:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGKXid (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Jul 2023 19:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKXic (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Jul 2023 19:38:32 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BFF10E3
        for <rcu@vger.kernel.org>; Tue, 11 Jul 2023 16:38:31 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55bf5cd4e75so8385601a12.2
        for <rcu@vger.kernel.org>; Tue, 11 Jul 2023 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689118711; x=1691710711;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VlZMY7B4OQtHfVwCl2fGa87UX0dm/HNDQvgsMerbs4E=;
        b=6Ki0rULefzkrV0uqZTDhEme49t7KY8Ddvh964y9JGpH0d7zaaMcI88h9tK+e2Ab0fT
         veY/0elFR+0TnQbsPGLKw4Jmp/EnYeFI/PSjM63/7WezRDGYWEvCUsGnyE0hYonrxZCh
         hKVd2xrVwmNoXCz5hL6oiCirMv1oj6iXffQR50NxR8dIj89owViyD6Cq1q+dG0hECTvQ
         Gn9H85LU56bBM8WIwaFDgjeirp8M6EJB2ZueqDx7tDCWYbtZHHg6+WL/fE6cziK/CLIM
         9MHIOD6Pg4vMMojX+pEwY1B5ucjdNhQVR3rlKMYkiAAdKcNXGpYWjVQ1oLZ+HiqDtv/m
         dEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689118711; x=1691710711;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlZMY7B4OQtHfVwCl2fGa87UX0dm/HNDQvgsMerbs4E=;
        b=bJfxA1gHAcQfEYBsoRhyaTbsaPOYDuIyWjax9BQXX5hGPGgOqZ43F7Vs96IqUof87p
         fiHyfm4PJG0sPygl7fDkc/9aNLU0gHNarrz2Sc+M7f4n8nF7I4jiPVobAq+6r2PXyXib
         kWkR84ryIpBPHZ+1IIsL1UyhcLH0I8Io+2RXqUULDZTHNU9ualccbVg5rJwZCHi5LMcy
         PHrj8iV25ixCRuZEtBIcD2mMI07eb5tke8khQcDyYHyjuZly5lB+MOTDBEPZsM/jyeYf
         pK20Hw6ILafLyX35KbnSM4YGbnijdt5HDHeezJvgP6/2n1qcExlFLm7xj8t7kDBnyOhs
         q7aQ==
X-Gm-Message-State: ABy/qLa8WjBNgXlzufw7g0XIz4+N0BRmPrz/2SzHD5nYRovBAIokW1ZU
        nby8SB9PKBl2rVnEIg/gxDgeML0+VxX4
X-Google-Smtp-Source: APBJJlEh1KFYgX73qa7oSh36gSCXi/QGqv/5l19pZiBs2u+PQkzFrZtGOa0EdwtmAe2WF+om3uaJkkHyZ7t9
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a63:9511:0:b0:55c:2f9f:e427 with SMTP id
 p17-20020a639511000000b0055c2f9fe427mr4581555pgd.5.1689118711049; Tue, 11 Jul
 2023 16:38:31 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:38:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711233816.2187577-1-dhavale@google.com>
Subject: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
From:   Sandeep Dhavale <dhavale@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Sandeep Dhavale <dhavale@google.com>,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently if CONFIG_DEBUG_LOCK_ALLOC is not set

- rcu_read_lock_held() always returns 1
- rcu_read_lock_any_held() may return 0 with CONFIG_PREEMPT_RCU

This is inconsistent and it was discovered when trying a fix
for problem reported [1] with CONFIG_DEBUG_LOCK_ALLOC is not
set and CONFIG_PREEMPT_RCU is enabled. Gist of the problem is
that EROFS wants to detect atomic context so it can do inline
decompression whenever possible, this is important performance
optimization. It turns out that z_erofs_decompressqueue_endio()
can be called from blk_mq_flush_plug_list() with rcu lock held
and hence fix uses rcu_read_lock_any_held() to decide to use
sync/inline decompression vs async decompression.

As per documentation, we should return lock is held if we aren't
certain. But it seems we can improve the checks for if the lock
is held even if CONFIG_DEBUG_LOCK_ALLOC is not set instead of
hardcoding to always return true.

* rcu_read_lock_held()
- For CONFIG_PREEMPT_RCU using rcu_preempt_depth()
- using preemptible() (indirectly preempt_count())

* rcu_read_lock_bh_held()
- For CONFIG_PREEMPT_RT Using in_softirq() (indirectly softirq_cont())
- using preemptible() (indirectly preempt_count())

Lastly to fix the inconsistency, rcu_read_lock_any_held() is updated
to use other rcu_read_lock_*_held() checks.

Two of the improved checks are moved to kernel/rcu/update.c because
rcupdate.h is included from the very low level headers which do not know
what current (task_struct) is so the macro rcu_preempt_depth() cannot be
expanded in the rcupdate.h. See the original comment for
rcu_preempt_depth() in patch at [2] for more information.

[1]
https://lore.kernel.org/all/20230621220848.3379029-1-dhavale@google.com/
[2]
https://lore.kernel.org/all/1281392111-25060-8-git-send-email-paulmck@linux.vnet.ibm.com/

Reported-by: Will Shiu <Will.Shiu@mediatek.com>
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 include/linux/rcupdate.h | 12 +++---------
 kernel/rcu/update.c      | 21 ++++++++++++++++++++-
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e5f920ade90..0d1d1d8c2360 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -319,14 +319,11 @@ int rcu_read_lock_any_held(void);
 # define rcu_lock_acquire(a)		do { } while (0)
 # define rcu_lock_release(a)		do { } while (0)
 
-static inline int rcu_read_lock_held(void)
-{
-	return 1;
-}
+int rcu_read_lock_held(void);
 
 static inline int rcu_read_lock_bh_held(void)
 {
-	return 1;
+	return !preemptible() || in_softirq();
 }
 
 static inline int rcu_read_lock_sched_held(void)
@@ -334,10 +331,7 @@ static inline int rcu_read_lock_sched_held(void)
 	return !preemptible();
 }
 
-static inline int rcu_read_lock_any_held(void)
-{
-	return !preemptible();
-}
+int rcu_read_lock_any_held(void);
 
 static inline int debug_lockdep_rcu_enabled(void)
 {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 19bf6fa3ee6a..b34fc5bb96cf 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -390,8 +390,27 @@ int rcu_read_lock_any_held(void)
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
 
-#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
+#else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
+int rcu_read_lock_held(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
+		return rcu_preempt_depth();
+	return !preemptible();
+}
+EXPORT_SYMBOL_GPL(rcu_read_lock_held);
+
+int rcu_read_lock_any_held(void)
+{
+	if (rcu_read_lock_held() ||
+	    rcu_read_lock_bh_held() ||
+	    rcu_read_lock_sched_held())
+		return 1;
+	return !preemptible();
+}
+EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
+
+#endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 /**
  * wakeme_after_rcu() - Callback function to awaken a task after grace period
  * @head: Pointer to rcu_head member within rcu_synchronize structure
-- 
2.41.0.255.g8b1d071c50-goog

