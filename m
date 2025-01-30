Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2FC1F191D;
	Thu, 30 Jan 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263886; cv=none; b=NO/cokSjUYUDUMKdsb2yUj7Svuh5nIqcatI8J0BvgZ36vBSLk464b/muMk6lQp6jJE1GKPXN8IGIiOgysOJJF7wjipILRWM7wzWyulToCwRMr8moBSZ61krtYV12exRdxLiIjF6sutMTCD+jlE1lMSCNK0FICzGVH9pTyKG2Qqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263886; c=relaxed/simple;
	bh=UNQk2ATolkqpeiqVZVbCqxJE/hAAQKMoYHelpeesn2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ffJPq+JUrl//NiiMWgG0AvlgnCC3PeVkc8+EE8/bxppsCVuVCNH0rt0wKkW2nYKRGB94H9AwTlqQRYFs7KrkFozQEoFGSPWnmXnvRICjz0rD/e6Z8iAOxe0zd1SZKlPTZGACkwgkSWKlifZi7sk72NPLGmr2eGjC7n2RfDZqzgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/yDa/sc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/yDa/sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116FAC4CEE7;
	Thu, 30 Jan 2025 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263886;
	bh=UNQk2ATolkqpeiqVZVbCqxJE/hAAQKMoYHelpeesn2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/yDa/sc6BgovWpVbBRqRZJl+QFgFL/rnMAm8Sm2C8Dpp7X6LFXkhYuaImdpZFc0V
	 Ds2GrMGfQnw3AXkutiAzIZLvMoVCm6EEfAlDC/ePvx3SNnR6EedzONwPKVozZYq1kl
	 kEqLDUuTlh1bniLkLLfdgvHvrwhV1Uy0k9DSOfBaYJogJWvcmX3N+svywZeEiVphA3
	 x81s5Qas4e6Czgpthmo8ltL/22AFUUlsVhiuI3+rccFAw0FEU2lCf86daDNf7aXRU8
	 tRWDglivqR5EQmxy7pR3ASD15ZRTpnEomMxkGPncFTu9jM1FyhVZSjH8uiqh1JU/RL
	 RTFE3X0TPXkjA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 844E4CE37E0; Thu, 30 Jan 2025 11:04:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 06/11] rcutorture: Add ftrace-compatible timestamp to GP# failure/close-call output
Date: Thu, 30 Jan 2025 11:04:39 -0800
Message-Id: <20250130190444.1652700-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
References: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds an ftrace-compatible microsecond-scale timestamp
to the failure/close-call output, but only in kernels built with
CONFIG_RCU_TORTURE_TEST_LOG_GP=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5b0510c79fde..0f5a94542719 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -275,6 +275,7 @@ struct rt_read_seg {
 	int rt_end_cpu;
 	unsigned long long rt_gp_seq;
 	unsigned long long rt_gp_seq_end;
+	u64 rt_ts;
 };
 static int err_segs_recorded;
 static struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
@@ -2000,6 +2001,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 	// Sample grace-period sequence number, as good a place as any.
 	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP) && cur_ops->gather_gp_seqs) {
 		rtrsp->rt_gp_seq = cur_ops->gather_gp_seqs();
+		rtrsp->rt_ts = ktime_get_mono_fast_ns();
 		if (!first)
 			rtrsp[-1].rt_gp_seq_end = rtrsp->rt_gp_seq;
 	}
@@ -3674,7 +3676,11 @@ rcu_torture_cleanup(void)
 			pr_alert("\t: No segments recorded!!!\n");
 		firsttime = 1;
 		for (i = 0; i < rt_read_nsegs; i++) {
-			pr_alert("\t%d: %#4x", i, err_segs[i].rt_readstate);
+			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP))
+				pr_alert("\t%lluus ", div64_u64(err_segs[i].rt_ts, 1000ULL));
+			else
+				pr_alert("\t");
+			pr_cont("%d: %#4x", i, err_segs[i].rt_readstate);
 			if (err_segs[i].rt_delay_jiffies != 0) {
 				pr_cont("%s%ldjiffies", firsttime ? "" : "+",
 					err_segs[i].rt_delay_jiffies);
-- 
2.40.1

