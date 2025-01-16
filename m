Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3612442F4;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059076; cv=none; b=IT504komDN+MCdeAV6n9nagrnqjuund2lsHOw+c0M9N0p7ptw7pmzW4Zez2QX5uBVb7qALpzC06iE+4izCYPEsNTjgEL9D+II5SI4a+Kwbc+UCBmQxzj8XnZAtIaS3l8ikEfg04YvoKaR3QbPgY3N3JYEuHlEF9sAx+67E+nCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059076; c=relaxed/simple;
	bh=CjJgBFtsok54/lEjpFkXjT3UevRr3ESUhr7/3ZJSEJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tPAKv+yA8BzfB/1ea55pCZiVPnGcYUloJcn6wiwYTc1sIEciD2fVDifSB010u0khnfXtpVTrwZ2JRgMRBcqfPjcWSzj98TQV4TP2nLT2odkKujUaVq1SDRsONUZv/C43BB9QclaC8JfYfF3CdoUCnalnY1UTOd8NgWi9EY59/qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lvye994o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lvye994o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E51C4CEEA;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737059076;
	bh=CjJgBFtsok54/lEjpFkXjT3UevRr3ESUhr7/3ZJSEJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lvye994oZbVVRkcJjzlOguMV/ZlWXqMgRh0ZJXOtRkPuTA80hEMbyrCuqmwJWs3YF
	 MuhFHPv/FLMqDnpfOhOfGlUqPNlqIUYgnEDBxVYX18msz9Za+BUD7VZPb3908OMc9r
	 ZYV77e3/lzkEPiPbd3bXQuxPkTMHMlHlo2uCYdXxjfxeGqcEafJHKcqQns/3Wauyqc
	 mGQ7dFleTxu1o20qRFjUQlOOLehSYEnJsQmdxO72mfWR1KDZHq1VVD/3g8PQ2RGGE1
	 gsmdFhiILf8o+zAThze2yxIzVVv/dxQFvqbc9Oy3PT/ihOkakLbCPq9oVcM3AOjJO2
	 RMV6et8iK3+kQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AC814CE37C4; Thu, 16 Jan 2025 12:24:35 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/11] rcutorture: Add ftrace-compatible timestamp to GP# failure/close-call output
Date: Thu, 16 Jan 2025 12:24:29 -0800
Message-Id: <20250116202434.3783613-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
References: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
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
index 5b0510c79fde7..0f5a945427190 100644
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

