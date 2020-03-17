Return-Path: <SRS0=yil3=5C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56420C2BB1D
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 14:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2A920724
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584456894;
	bh=Gk5qf4hB4gnv1cWBDx2LF6Mu9BelQFfn604dLX08vG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rJ+FkRmXsBJlbqQjdF4jjwctu6nw2+Ka6sS8DddplGqFwMFIJPNmHW3RVJnt5IjeH
	 UrZlU729shEMLOkb6pbKUCUupmhAo2P1k2kZ1MyXta7zz4LWOKDr3+DWGRynPpMwdb
	 IcZzs+rfINXzZ6tQ6KjH9oI0Naiw5YFbs+aTO7y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCQOyt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgCQOyc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:32 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEFE620771;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456870;
        bh=Gk5qf4hB4gnv1cWBDx2LF6Mu9BelQFfn604dLX08vG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xe/z//7Tia2g/X7nNL/gT4qKAVAohBljfmtJtV/2WUI1b4xeziDf0pZGNjS3WwQag
         +lGBKv+TzbsvhwuYO1Jj1EfIoGnUOe8+J7eGr6DKIVSUN68T3O2t5DBUVRvstGahUM
         rpp3nyeBTt7Efl4D1Gbb7vEuRN0l3hLRtLeZmZfI=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbw-000AMq-Lg; Tue, 17 Mar 2020 15:54:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 09/17] rcu: update.c: get rid of some doc warnings
Date:   Tue, 17 Mar 2020 15:54:18 +0100
Message-Id: <c69a85d13717c2aec563f702bffd7cd1e3be6a88.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We need to escape *ret, as otherwise the documentation system
thinks that this is an incomplete emphasis block:

	./kernel/rcu/update.c:65: WARNING: Inline emphasis start-string without end-string.
	./kernel/rcu/update.c:65: WARNING: Inline emphasis start-string without end-string.
	./kernel/rcu/update.c:70: WARNING: Inline emphasis start-string without end-string.
	./kernel/rcu/update.c:82: WARNING: Inline emphasis start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/rcu/update.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index b1fa519e5890..16058a5e6da4 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -63,12 +63,12 @@ module_param(rcu_normal_after_boot, int, 0);
  * rcu_read_lock_held_common() - might we be in RCU-sched read-side critical section?
  * @ret:	Best guess answer if lockdep cannot be relied on
  *
- * Returns true if lockdep must be ignored, in which case *ret contains
+ * Returns true if lockdep must be ignored, in which case ``*ret`` contains
  * the best guess described below.  Otherwise returns false, in which
- * case *ret tells the caller nothing and the caller should instead
+ * case ``*ret`` tells the caller nothing and the caller should instead
  * consult lockdep.
  *
- * If CONFIG_DEBUG_LOCK_ALLOC is selected, set *ret to nonzero iff in an
+ * If CONFIG_DEBUG_LOCK_ALLOC is selected, set ``*ret`` to nonzero iff in an
  * RCU-sched read-side critical section.  In absence of
  * CONFIG_DEBUG_LOCK_ALLOC, this assumes we are in an RCU-sched read-side
  * critical section unless it can prove otherwise.  Note that disabling
@@ -82,7 +82,7 @@ module_param(rcu_normal_after_boot, int, 0);
  *
  * Note that if the CPU is in the idle loop from an RCU point of view (ie:
  * that we are in the section between rcu_idle_enter() and rcu_idle_exit())
- * then rcu_read_lock_held() sets *ret to false even if the CPU did an
+ * then rcu_read_lock_held() sets ``*ret`` to false even if the CPU did an
  * rcu_read_lock().  The reason for this is that RCU ignores CPUs that are
  * in such a section, considering these as in extended quiescent state,
  * so such a CPU is effectively never in an RCU read-side critical section
-- 
2.24.1

