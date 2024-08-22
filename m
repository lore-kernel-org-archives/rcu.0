Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F11CD02;
	Thu, 22 Aug 2024 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297038; cv=none; b=DLMj5nq6GqFQNmgSYOOQFyHGkscjbOH01HRbrewZYj8oxsB7riYTv9rb6BqEEfLPXKXBaZOOpkQhY2/jOzw0cQG+MfFDpHf7ChoboDpj3T/U80lo73n97wt+yAu0eIIYPtkUKlKSP8UtHYMyGXVpgvrDlaXvJ+2feRnlhaXRNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297038; c=relaxed/simple;
	bh=BI5IowHA1+SPQY5ckWLGb8StG0HoueWFKuQ7tESPbDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lMIiM5vKztXBrNSPNpg6dEpVqkO6a6VCY0hn678IClkJ+9BnviiVQi+QPK+gA7EH5SQP3FtiaPuq8992RW8098HQYEibFi2ZMV+bKJChyrsmgvQbv6anXUESL9WF369v/p5xG1yu1tNDNxE8/WXmbiVc8au8RChkzj/epyOiDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wq7pF22x6z2Cn6m;
	Thu, 22 Aug 2024 11:23:49 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B9391401E9;
	Thu, 22 Aug 2024 11:23:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Aug 2024 11:23:51 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E . McKenney"
	<paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt
	<rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	<rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] srcu: Replace WARN_ON_ONCE() with BUILD_BUG_ON() if possible
Date: Thu, 22 Aug 2024 11:21:28 +0800
Message-ID: <20240822032128.1970-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)

The value of ARRAY_SIZE() can be determined at compile time, so if both
sides of the equation are ARRAY_SIZE(), using BUILD_BUG_ON() can help us
catch the problem earlier.

While there are cases where unequal array sizes will work, there is no
point in allowing them, so it makes more sense to force them to be equal
using BUILD_BUG_ON().

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b24db425f16d850..a9c7795bb77d650 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -128,7 +128,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
 	 * Initialize the per-CPU srcu_data array, which feeds into the
 	 * leaves of the srcu_node tree.
 	 */
-	WARN_ON_ONCE(ARRAY_SIZE(sdp->srcu_lock_count) !=
+	BUILD_BUG_ON(ARRAY_SIZE(sdp->srcu_lock_count) !=
 		     ARRAY_SIZE(sdp->srcu_unlock_count));
 	for_each_possible_cpu(cpu) {
 		sdp = per_cpu_ptr(ssp->sda, cpu);
@@ -186,7 +186,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 	/* Each pass through this loop initializes one srcu_node structure. */
 	srcu_for_each_node_breadth_first(ssp, snp) {
 		spin_lock_init(&ACCESS_PRIVATE(snp, lock));
-		WARN_ON_ONCE(ARRAY_SIZE(snp->srcu_have_cbs) !=
+		BUILD_BUG_ON(ARRAY_SIZE(snp->srcu_have_cbs) !=
 			     ARRAY_SIZE(snp->srcu_data_have_cbs));
 		for (i = 0; i < ARRAY_SIZE(snp->srcu_have_cbs); i++) {
 			snp->srcu_have_cbs[i] = SRCU_SNP_INIT_SEQ;
-- 
2.34.1

