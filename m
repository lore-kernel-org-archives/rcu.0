Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0223C2309A3;
	Tue, 12 Nov 2024 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423130; cv=none; b=NHuZAzMSEdtf5lc3zB8ckbcrMLzHZ4BAmIjL4qQg/L91TWzn3car0ibY+UV5rl3kd3SZvEcOXZXn3BjO6tFNoyAPK0ha0nYl/LtsFED0II80jUNeOX9sJeDwVSCHluMF7bi9rrJchLql/82o32zEFXUiPd4YQsNcFHKgoh/oXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423130; c=relaxed/simple;
	bh=2S9CoFvH8vbZLEEph+lBWbRkjxdGKOOkqpjrAj9RVRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peMPEFqRmqXhnR0c+EUQoE0nOXQpUKKFFxQKCRZR1xxnC9eupKWFzNPboIghX5V5+daj8USuhGcB/XgrfvoWn1E3mJirKKel1Vt2swGT8aF6+8NQ2cXiHZe+8HS1btMmRSP/6nMHkHxCeSv8bIf91x4pl0w+tHXbHW6cLxzGXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tF0fHLsr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF0fHLsr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F91C4CECD;
	Tue, 12 Nov 2024 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423129;
	bh=2S9CoFvH8vbZLEEph+lBWbRkjxdGKOOkqpjrAj9RVRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tF0fHLsraQbTEUlY2w6EjUJjdlJ5+hBIb1UPKIWTrjp87X9jnqo2HeElhjxXD3eyJ
	 0I7CPmyX3fzTDaYhkAJ+ezymDQ0cHg2TXujj8CA3MQI+ZcEFPDFyHq/5reG/MlyFjp
	 Hyx5L+YupujyOuyDW9qWmFX1PHkyEU/wFm0ho5UDLRo1fHicU4JcjLian7N2WwaeC4
	 BdL7r93mhM2drsJca+g3W8C6IdJ6rnBVvhrCxnMyq+Gp+tFIvaPMDF+4FrYtlX2zUt
	 9OD+GG1jrlY0qhu0Ra8rBopSAU9eB9qH49KOZuhFdmwzvT1hoAiRW3VmB+HEXKn9m1
	 mY5do7WtLJOcQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 01/16] srcu: Replace WARN_ON_ONCE() with BUILD_BUG_ON() if possible
Date: Tue, 12 Nov 2024 15:51:44 +0100
Message-ID: <20241112145159.23032-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112145159.23032-1-frederic@kernel.org>
References: <20241112145159.23032-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhen Lei <thunder.leizhen@huawei.com>

The value of ARRAY_SIZE() can be determined at compile time, so if both
sides of the equation are ARRAY_SIZE(), using BUILD_BUG_ON() can help us
catch the problem earlier.

While there are cases where unequal array sizes will work, there is no
point in allowing them, so it makes more sense to force them to be equal
using BUILD_BUG_ON().

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 31706e3293bc..78afaffd1b26 100644
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
@@ -187,7 +187,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 	/* Each pass through this loop initializes one srcu_node structure. */
 	srcu_for_each_node_breadth_first(ssp, snp) {
 		spin_lock_init(&ACCESS_PRIVATE(snp, lock));
-		WARN_ON_ONCE(ARRAY_SIZE(snp->srcu_have_cbs) !=
+		BUILD_BUG_ON(ARRAY_SIZE(snp->srcu_have_cbs) !=
 			     ARRAY_SIZE(snp->srcu_data_have_cbs));
 		for (i = 0; i < ARRAY_SIZE(snp->srcu_have_cbs); i++) {
 			snp->srcu_have_cbs[i] = SRCU_SNP_INIT_SEQ;
-- 
2.46.0

