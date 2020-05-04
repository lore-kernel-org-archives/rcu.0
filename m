Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4438C47257
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A0E20757
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588595707;
	bh=dDLEOvyKoHOMHIcBER4xV+RELHodXwc/B7OQkeROsgM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WaEQzSH74xdv/WO+8Tkpzl3/wqR1XnaVU6mUNc15o4o7IE6auWCTqbeYb2hXDi6Ma
	 8dEkxpL4Hlh2oOMC1G7ygyASxxI9RIBaX8KtHnQ/f5b7FbthKu2AFlC11F2nDntPXR
	 BAtuvUCHumzdp6Ba4ydSU6HAG2KA2d3z/nW4CkAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgEDMfH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 08:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgEDMfH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 May 2020 08:35:07 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56FEF206B9;
        Mon,  4 May 2020 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588595706;
        bh=dDLEOvyKoHOMHIcBER4xV+RELHodXwc/B7OQkeROsgM=;
        h=From:To:Cc:Subject:Date:From;
        b=RA5N5IcKqaYe2FZFJs0zjb1HzvIaZwmutxdcg7iHrh0ymNptZWn7xvjjpSDnjDxKD
         YL8KoJdfGKsu7JNO1i0muQLc148zpytAZgWcPzWAhjshyHnkbP/056h8lgQS3LDgBq
         6/r8brPpVBmxB1c4UUAJ2IRAJYsV+5VF5oqFF3tQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jVaJM-000Mvh-96; Mon, 04 May 2020 14:35:04 +0200
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
Subject: [PATCH] rcu: fix some kernel-doc warnings
Date:   Mon,  4 May 2020 14:35:00 +0200
Message-Id: <de9528975d99606936d4c5f7d1ab29ded03e8ade.1588595698.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There are some kernel-doc warnings:

	./kernel/rcu/tree.c:2915: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'
	./include/linux/rculist.h:517: warning: bad line:                           [@right ][node2 ... ]
	./include/linux/rculist.h:2: WARNING: Unexpected indentation.

Move the comment for "count" to the kernel-doc markup and add
a missing "*" on one kernel-doc continuation line.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/rculist.h | 2 +-
 kernel/rcu/tree.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 2ebd112f86f7..7a6fc9956510 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -514,7 +514,7 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
  * @right: The hlist head on the right
  *
  * The lists start out as [@left  ][node1 ... ] and
-                          [@right ][node2 ... ]
+ *                        [@right ][node2 ... ]
  * The lists end up as    [@left  ][node2 ... ]
  *                        [@right ][node1 ... ]
  */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8ed0fe57d5fb..ada4f914fa60 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2895,6 +2895,7 @@ struct kfree_rcu_cpu_work {
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
  * @initialized: The @lock and @rcu_work fields have been initialized
+ * @count: Number of objects for which GP not started
  *
  * This is a per-CPU structure.  The reason that it is not included in
  * the rcu_data structure is to permit this code to be extracted from
@@ -2910,7 +2911,6 @@ struct kfree_rcu_cpu {
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
-	// Number of objects for which GP not started
 	int count;
 };
 
-- 
2.25.4

