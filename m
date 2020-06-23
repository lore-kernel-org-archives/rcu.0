Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB0AC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D3220720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871744;
	bh=feeXUL4kCN4WeY6HYamgBrByXLXjv+/PBNopWg6XohM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bQPv8yaQPaxjmEeVjFhvQ6p5YVbDdvRwfO/Ewz7zVB8nUyHWTPvirxRyWGvOlYjrJ
	 6DzbIFhotIndVk/dM6KPEC2AHpjCGj0e9gf3VpMfyvmPEmzhdk/a0mXy4QaWRiStaH
	 xq9AClY37L3rLjehJ9SYdAwOKBIAw7GM/LuETyso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgFWAWX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731575AbgFWAVy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8198D2098B;
        Tue, 23 Jun 2020 00:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871713;
        bh=feeXUL4kCN4WeY6HYamgBrByXLXjv+/PBNopWg6XohM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1RSvWKcFX9Jfz0nraiZbVcoFv15iVvG4G5jWgfHw0xjHKCAr7nEaLaFpHoQRpB/F
         vIbuPL4NPVvGZw6wF+vUZAI+IjdA2UbhJYRUx4OFhwy/8UcDSqOgCvJ3SNj8Yp1zjn
         jnhMnnlGvaxqRCD953azwg+6SV2YzTiT6Hr9YAVw=
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
Subject: [PATCH tip/core/rcu 21/26] rcu: grplo/grphi just records CPU number
Date:   Mon, 22 Jun 2020 17:21:42 -0700
Message-Id: <20200623002147.25750-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

We store lowest and highest CPU number belongs to a rcu_node, which is
not the group number.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 09ec93b..9f903f5 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -73,8 +73,8 @@ struct rcu_node {
 	unsigned long ffmask;	/* Fully functional CPUs. */
 	unsigned long grpmask;	/* Mask to apply to parent qsmask. */
 				/*  Only one bit will be set in this mask. */
-	int	grplo;		/* lowest-numbered CPU or group here. */
-	int	grphi;		/* highest-numbered CPU or group here. */
+	int	grplo;		/* lowest-numbered CPU here. */
+	int	grphi;		/* highest-numbered CPU here. */
 	u8	grpnum;		/* CPU/group number for next level up. */
 	u8	level;		/* root is at level 0. */
 	bool	wait_blkd_tasks;/* Necessary to wait for blocked tasks to */
-- 
2.9.5

