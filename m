Return-Path: <SRS0=lJWX=7Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF3BC433E2
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 02:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8956E20823
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 02:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgFLCIZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Jun 2020 22:08:25 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:52798 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbgFLCIX (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 11 Jun 2020 22:08:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U.Jo8A0_1591927699;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U.Jo8A0_1591927699)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 10:08:19 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, trivial@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 3/4] rcu: grpnum just records group number
Date:   Fri, 12 Jun 2020 10:07:54 +0800
Message-Id: <20200612020755.50526-4-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200612020755.50526-1-richard.weiyang@linux.alibaba.com>
References: <20200612020755.50526-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

grpnum in rcu_node means the position in its parent, which is not the
CPU number even in last level.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/rcu/tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index ce9ab7371706..512829eed545 100644
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
2.20.1 (Apple Git-117)

