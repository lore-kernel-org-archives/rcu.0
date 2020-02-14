Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91A7C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CA22187F
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581723556;
	bh=IeHghjm/GPQUWVJI03nW87JpfgAdU2CFoSp8X5t9BkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N+ssNpPebyozky+q+5uPCP+WngL/YBzD7+cR9/k4cP8o5j5qmWo409G2BioBnLhO/
	 xdZpC8SNebvjMXwriurrWa+fP9tnbGto77TCG/BbMvKlVBANmE9a03qyFSWbrJvn5N
	 3lmildwupD7z1mHwfwNUigbFXxxQvfRiyk5dIXvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgBNXjQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:39:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgBNXjP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:39:15 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C4E824670;
        Fri, 14 Feb 2020 23:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581723555;
        bh=IeHghjm/GPQUWVJI03nW87JpfgAdU2CFoSp8X5t9BkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mOAd8Y3kNAPTCpJifzIFypIobDkWBlJcUmrskkNmiYdj4bM2XJ+qh2s7iWkAif/hl
         DpNDBi1xlkx6hLyrMuk2akhrsImo1UDfkEiMlLe8GBMwAfvstdSsFqbIA3dDtxGTbp
         zw8+xJo9IK3NaueyQSN51PvbU7hSQ+qo4kltdJDE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        SeongJae Park <sjpark@amazon.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/9] doc/RCU/Design: Remove remaining HTML tags in ReST files
Date:   Fri, 14 Feb 2020 15:38:56 -0800
Message-Id: <20200214233903.12916-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <@@@>
References: <@@@>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit ccc9971e2147 ("docs: rcu: convert some articles from html to
ReST") has converted a few of html RCU docs into ReST files, but a few
of html tags which not supported on rst is remaining.  This commit
converts those to ReST appropriate alternatives.

Reviewed-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst       | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 1a8b129..83ae3b7 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -4,7 +4,7 @@ A Tour Through TREE_RCU's Grace-Period Memory Ordering
 
 August 8, 2017
 
-This article was contributed by Paul E.&nbsp;McKenney
+This article was contributed by Paul E. McKenney
 
 Introduction
 ============
@@ -48,7 +48,7 @@ Tree RCU Grace Period Memory Ordering Building Blocks
 
 The workhorse for RCU's grace-period memory ordering is the
 critical section for the ``rcu_node`` structure's
-``-&gt;lock``. These critical sections use helper functions for lock
+``->lock``. These critical sections use helper functions for lock
 acquisition, including ``raw_spin_lock_rcu_node()``,
 ``raw_spin_lock_irq_rcu_node()``, and ``raw_spin_lock_irqsave_rcu_node()``.
 Their lock-release counterparts are ``raw_spin_unlock_rcu_node()``,
@@ -102,9 +102,9 @@ lock-acquisition and lock-release functions::
    23   r3 = READ_ONCE(x);
    24 }
    25
-   26 WARN_ON(r1 == 0 &amp;&amp; r2 == 0 &amp;&amp; r3 == 0);
+   26 WARN_ON(r1 == 0 && r2 == 0 && r3 == 0);
 
-The ``WARN_ON()`` is evaluated at &ldquo;the end of time&rdquo;,
+The ``WARN_ON()`` is evaluated at "the end of time",
 after all changes have propagated throughout the system.
 Without the ``smp_mb__after_unlock_lock()`` provided by the
 acquisition functions, this ``WARN_ON()`` could trigger, for example
-- 
2.9.5

