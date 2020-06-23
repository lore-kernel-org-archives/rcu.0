Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6EEC433E2
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601D2206C3
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871031;
	bh=a705t2xKelrZFVsI6cYwRPReVMZUv3FZLBYCJ/JIWTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mcw2BuVVz8h2bYqmc6+yanDRCOml1VCmotcD30Qjh+95iB7B0lc7VdmAE+A6qHB2A
	 4pQ5bEltVbE6lHSxDgtTMKZrTvaeVLZNB1kghH31D3H7i8eKhd6peavaS8pvq2AKYV
	 ZnSVHspKxvr8/RU3EJ/5vPF1GWI9yA59qEfSdZWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgFWAKb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731494AbgFWAJu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:09:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E787420809;
        Tue, 23 Jun 2020 00:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592870990;
        bh=a705t2xKelrZFVsI6cYwRPReVMZUv3FZLBYCJ/JIWTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CF76rkbDZsZptH/zz+Kuu6DOF6Ltya9wK2MYd1Vg8tk3jD4fpjM3vMTE89TmO5/k2
         N8BLusinJCQZ6B1JVCMX/4t8VG61k3C7OXDh8nkSeSJTfc8UAUKFDBaArUbnAH6GYs
         JnsPxWAgvG0MpIZUjv6DWkEAcr5BOyGltTD7jjt4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/10] docs: RCU: Convert lockdep.txt to ReST
Date:   Mon, 22 Jun 2020 17:09:40 -0700
Message-Id: <20200623000947.25222-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623000923.GA25047@paulmck-ThinkPad-P72>
References: <20200623000923.GA25047@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

- Add a SPDX header;
- Adjust document title;
- Mark literal blocks as such;
- Add it to RCU/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/index.rst                    |  1 +
 Documentation/RCU/{lockdep.txt => lockdep.rst} | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)
 rename Documentation/RCU/{lockdep.txt => lockdep.rst} (96%)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 430a371..fa7a2a8 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -11,6 +11,7 @@ RCU concepts
 
    arrayRCU
    checklist
+   lockdep
    lockdep-splat
    rcubarrier
    rcu_dereference
diff --git a/Documentation/RCU/lockdep.txt b/Documentation/RCU/lockdep.rst
similarity index 96%
rename from Documentation/RCU/lockdep.txt
rename to Documentation/RCU/lockdep.rst
index 89db949e..f1fc8ae 100644
--- a/Documentation/RCU/lockdep.txt
+++ b/Documentation/RCU/lockdep.rst
@@ -1,4 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
 RCU and lockdep checking
+========================
 
 All flavors of RCU have lockdep checking available, so that lockdep is
 aware of when each task enters and leaves any flavor of RCU read-side
@@ -8,7 +12,7 @@ tracking to include RCU state, which can sometimes help when debugging
 deadlocks and the like.
 
 In addition, RCU provides the following primitives that check lockdep's
-state:
+state::
 
 	rcu_read_lock_held() for normal RCU.
 	rcu_read_lock_bh_held() for RCU-bh.
@@ -63,7 +67,7 @@ checking of rcu_dereference() primitives:
 The rcu_dereference_check() check expression can be any boolean
 expression, but would normally include a lockdep expression.  However,
 any boolean expression can be used.  For a moderately ornate example,
-consider the following:
+consider the following::
 
 	file = rcu_dereference_check(fdt->fd[fd],
 				     lockdep_is_held(&files->file_lock) ||
@@ -82,7 +86,7 @@ RCU read-side critical sections, in case (2) the ->file_lock prevents
 any change from taking place, and finally, in case (3) the current task
 is the only task accessing the file_struct, again preventing any change
 from taking place.  If the above statement was invoked only from updater
-code, it could instead be written as follows:
+code, it could instead be written as follows::
 
 	file = rcu_dereference_protected(fdt->fd[fd],
 					 lockdep_is_held(&files->file_lock) ||
@@ -105,7 +109,7 @@ false and they are called from outside any RCU read-side critical section.
 
 For example, the workqueue for_each_pwq() macro is intended to be used
 either within an RCU read-side critical section or with wq->mutex held.
-It is thus implemented as follows:
+It is thus implemented as follows::
 
 	#define for_each_pwq(pwq, wq)
 		list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,
-- 
2.9.5

