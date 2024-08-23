Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6778149002
	for <rcu@vger.kernel.org>; Fri, 23 Aug 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404468; cv=none; b=h+rhLGyLb42MKU5D96sTrvZYIG+xrqrL/s4dMWvlfk+pXFRR4HUv1+4C+wI41yIGpZl2MOgANj/Q0Xzsne9Xl5y/yLSv7JZcnlHuLxXzEhbQlb/jWbK4aUTdEpjpQKKJBTXuofqbQWLl7IVxRsWfKQJHhEi2h5OuDVOh6mreze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404468; c=relaxed/simple;
	bh=TvAfeodW3k3mZRMy1AMrgLaTxMqsI2eofsJ53uLwKVE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Of0JsZpHdy5DafWfjSiqbJREI6ioqyycJaHLfohJGvpVPAQRsSzqdXtNSeHI8odKwErmvNFBnLS5qLyJH2LNqMwVhox2qgvljoaLWD6XPr4Lo6+u0CaWCS4ZkCfPh2zTmlB3l34MKEf5lzDmHIUnFrGtPufkHw1y+VK4/ATdNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WqvXB0l0Gz2CnHH;
	Fri, 23 Aug 2024 17:14:18 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E12751402C7;
	Fri, 23 Aug 2024 17:14:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 17:14:22 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <paulmck@kernel.org>, <frederic@kernel.org>, <neeraj.upadhyay@kernel.org>,
	<joel@joelfernandes.org>, <josh@joshtriplett.org>, <boqun.feng@gmail.com>,
	<urezki@gmail.com>, <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
	<jiangshanlai@gmail.com>, <qiang.zhang1211@gmail.com>
CC: <rcu@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] rcu: Use bitwise instead of arithmetic operator for flags
Date: Fri, 23 Aug 2024 17:21:58 +0800
Message-ID: <20240823092158.3173241-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

This silences the following coccinelle warning:
  WARNING: sum of probable bitmasks, consider |

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 kernel/rcu/tree_plugin.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1c7cbd145d5e..3927ea5f7955 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -183,9 +183,9 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	switch (blkd_state) {
 	case 0:
 	case                RCU_EXP_TASKS:
-	case                RCU_EXP_TASKS + RCU_GP_BLKD:
+	case                RCU_EXP_TASKS | RCU_GP_BLKD:
 	case RCU_GP_TASKS:
-	case RCU_GP_TASKS + RCU_EXP_TASKS:
+	case RCU_GP_TASKS | RCU_EXP_TASKS:
 
 		/*
 		 * Blocking neither GP, or first task blocking the normal
@@ -198,10 +198,10 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	case                                              RCU_EXP_BLKD:
 	case                                RCU_GP_BLKD:
-	case                                RCU_GP_BLKD + RCU_EXP_BLKD:
-	case RCU_GP_TASKS +                               RCU_EXP_BLKD:
-	case RCU_GP_TASKS +                 RCU_GP_BLKD + RCU_EXP_BLKD:
-	case RCU_GP_TASKS + RCU_EXP_TASKS + RCU_GP_BLKD + RCU_EXP_BLKD:
+	case                                RCU_GP_BLKD | RCU_EXP_BLKD:
+	case RCU_GP_TASKS |                               RCU_EXP_BLKD:
+	case RCU_GP_TASKS |                 RCU_GP_BLKD | RCU_EXP_BLKD:
+	case RCU_GP_TASKS | RCU_EXP_TASKS | RCU_GP_BLKD | RCU_EXP_BLKD:
 
 		/*
 		 * First task arriving that blocks either GP, or first task
@@ -214,9 +214,9 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 		list_add_tail(&t->rcu_node_entry, &rnp->blkd_tasks);
 		break;
 
-	case                RCU_EXP_TASKS +               RCU_EXP_BLKD:
-	case                RCU_EXP_TASKS + RCU_GP_BLKD + RCU_EXP_BLKD:
-	case RCU_GP_TASKS + RCU_EXP_TASKS +               RCU_EXP_BLKD:
+	case                RCU_EXP_TASKS |               RCU_EXP_BLKD:
+	case                RCU_EXP_TASKS | RCU_GP_BLKD | RCU_EXP_BLKD:
+	case RCU_GP_TASKS | RCU_EXP_TASKS |               RCU_EXP_BLKD:
 
 		/*
 		 * Second or subsequent task blocking the expedited GP.
@@ -227,8 +227,8 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 		list_add(&t->rcu_node_entry, rnp->exp_tasks);
 		break;
 
-	case RCU_GP_TASKS +                 RCU_GP_BLKD:
-	case RCU_GP_TASKS + RCU_EXP_TASKS + RCU_GP_BLKD:
+	case RCU_GP_TASKS |                 RCU_GP_BLKD:
+	case RCU_GP_TASKS | RCU_EXP_TASKS | RCU_GP_BLKD:
 
 		/*
 		 * Second or subsequent task blocking the normal GP.
-- 
2.34.1

