Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE3942056;
	Tue, 24 Jun 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781643; cv=none; b=H0WH/YRg4evfVlrKsd6WEr1CL4OEGBPpyTzDl007UXSncvKqEsdraT62XdkdosRURry9mlBSuhOK/2p+YZS4sRQbeVzQOSVN/Ms8dNjIug22h95ENc0b49Khj4/v3PZ9Q25d5aD1yVi2wuBgVG8Eg/qD9e5c/WI11CX+gHt82qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781643; c=relaxed/simple;
	bh=WGfcPe2zsB2QJnfR2yO4TD4YNMs3PuEVC8yqrLr7J4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ikupj/BdKvt/nGGqWdkpswWvdSGH+YnZBB0mMBe3xKwCrqbWu+35RaISbz/zWCE20YslOWdvzs/P/mvl4js8XpOaio74WAF5w7yEy+uwBGfmQuZIZeYvdLk/vieBFVljzfsz6y15kl2ICWSzhr52sW2KtkpSMrAT7p+3dD8QDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkS9KsuS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkS9KsuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E452C4AF09;
	Tue, 24 Jun 2025 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750781643;
	bh=WGfcPe2zsB2QJnfR2yO4TD4YNMs3PuEVC8yqrLr7J4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkS9KsuSsIiz471dXmVEIiJkUbh3AhNeYT9xO5JUU6+emIDBKVQiexJtPBCDu1AXZ
	 0VJP8uwz/MubTMGSgBeP1S5J4VsOlJy/BD0Zz0Q90jEHOBJth1VGRaC5TOUHSdJywL
	 h7Mi9dnflKRYLpHZApTJKDk332P4n897WjFm7hnChbNmdWATMyKX5mtKRD6tpiZkGj
	 cxm0rxiNW1rtF52I/X2cC+G91FdXgKajgrFywVUTN7nnnAsC0H0fS4/XoB8eUw1V2S
	 HpQN5iUreeXqnsb7JenxNy70EG3TRfTVie/h6yLdGx5NLg66R0S0asuhPcgDswyl/+
	 bNOAXz3hbOhuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8065BCE0B27; Tue, 24 Jun 2025 09:14:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/5] torture: Remove support for SRCU-lite
Date: Tue, 24 Jun 2025 09:13:56 -0700
Message-Id: <20250624161400.867880-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
References: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because SRCU-lite is being replaced by SRCU-fast, this commit removes
support for SRCU-lite from refscale.c.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index f11a7c2af778c..f4b2cea1cce5e 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -246,36 +246,6 @@ static const struct ref_scale_ops srcu_fast_ops = {
 	.name		= "srcu-fast"
 };
 
-static void srcu_lite_ref_scale_read_section(const int nloops)
-{
-	int i;
-	int idx;
-
-	for (i = nloops; i >= 0; i--) {
-		idx = srcu_read_lock_lite(srcu_ctlp);
-		srcu_read_unlock_lite(srcu_ctlp, idx);
-	}
-}
-
-static void srcu_lite_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
-{
-	int i;
-	int idx;
-
-	for (i = nloops; i >= 0; i--) {
-		idx = srcu_read_lock_lite(srcu_ctlp);
-		un_delay(udl, ndl);
-		srcu_read_unlock_lite(srcu_ctlp, idx);
-	}
-}
-
-static const struct ref_scale_ops srcu_lite_ops = {
-	.init		= rcu_sync_scale_init,
-	.readsection	= srcu_lite_ref_scale_read_section,
-	.delaysection	= srcu_lite_ref_scale_delay_section,
-	.name		= "srcu-lite"
-};
-
 #ifdef CONFIG_TASKS_RCU
 
 // Definitions for RCU Tasks ref scale testing: Empty read markers.
@@ -1193,7 +1163,7 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcu_fast_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
+		&rcu_ops, &srcu_ops, &srcu_fast_ops, RCU_TRACE_OPS RCU_TASKS_OPS
 		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
 		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
-- 
2.40.1

