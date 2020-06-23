Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0798C433E1
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10D920720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871739;
	bh=kE9Py8rwVybDv+vzB/GnCbH7JU5/N9j04xI5f9KcVlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I6/dlapnS3emSdElau2ypYS6h57ZIjmZvQ8/W1nk/0gtNOpnUywdVnsQupZfkHrbL
	 vrxZAHAxtH+KfBDRpe2EHPprFt5geNuvFgo9am9uIYa3yZ4ssJZAXP/cDK3N2QgEfZ
	 5GHKp3iBhf/K5NSEiM45jYG/Pm4+CgK/Ss5nkeRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbgFWAWT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731582AbgFWAVz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A20208D5;
        Tue, 23 Jun 2020 00:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871713;
        bh=kE9Py8rwVybDv+vzB/GnCbH7JU5/N9j04xI5f9KcVlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9kuFVMNlQBTJ0CRmekK9loSNnw8dFA9SvoLZutsnPTQypFbhA5f9uJxTXEKr+stU
         oCA1IsiCb5A6ZpwngrHx1Gq1uq7ML9tYwlzlx7HhKwq4zJlrB5W83Rsbw+GHEfsn/B
         GKZTFQXxwoRR4QqQTkKo8qHjL8F9y2Riu4wxilwY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 22/26] rcu: grpnum just records group number
Date:   Mon, 22 Jun 2020 17:21:43 -0700
Message-Id: <20200623002147.25750-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

grpnum in rcu_node means the position in its parent, which is not the
CPU number even in last level.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9f903f5..c96ae35 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -75,7 +75,7 @@ struct rcu_node {
 				/*  Only one bit will be set in this mask. */
 	int	grplo;		/* lowest-numbered CPU here. */
 	int	grphi;		/* highest-numbered CPU here. */
-	u8	grpnum;		/* CPU/group number for next level up. */
+	u8	grpnum;		/* group number for next level up. */
 	u8	level;		/* root is at level 0. */
 	bool	wait_blkd_tasks;/* Necessary to wait for blocked tasks to */
 				/*  exit RCU read-side critical sections */
-- 
2.9.5

