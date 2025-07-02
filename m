Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4DC7482;
	Wed,  2 Jul 2025 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415815; cv=none; b=SdmGiGPs9A01lUH6eRW9qpv35oaSmrUv+iCVP/5CK+pDHwGFPJBalG8H8z3WgXPnzrNgtRpHxz4y1oDYwstDk9aDGtdbkQZFFUwzPbdbAKOytb/2pHe1mUqkuWuf8u+eWdmNSWomUkh8+HiZ9vhnGOGR6I4LwbK8lmYKDOTRXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415815; c=relaxed/simple;
	bh=EUI54hyyekscOlUf1kI6gFhpia6+94hPUVs8ZhSFkV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQE0PhEBKzbS3vNxlp+IGpigRXy9dLzHrYq3b1sVl8o5Am3pUkmaFy8hkcFg4xS3REE4rUwDtTsGaFT8vZAqlfRWgrfBoPeyFgYSs2HaAiuGdUHPgi7OxKI7xzFsDIy3YWpT81U0/t+0HJGE2ZHnUv9XrpsPzVfoBKKziNEwVJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8RAmerP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8RAmerP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9130C4CEEB;
	Wed,  2 Jul 2025 00:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751415814;
	bh=EUI54hyyekscOlUf1kI6gFhpia6+94hPUVs8ZhSFkV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G8RAmerPRzYla7Kx67NwHAizBqGltgF4pVXpU71nMmctvt+ztXxD++pfD6yXBaFuD
	 5IrwzHyYCYOaInOwlGNwo2ATo7iBlpNXD0izqhgYsKMEn1ifDMUgqz1JDZT/BHQQl6
	 R+rthcPiN+tk/banqyv2nFLhCDvf56+6mZ890XX2HLEZ2I4SilaLW+ltbf+WOx+wkk
	 laat0zpWNVk/fAt4fTtD+/gIV1+dOM86gzRovtK/f1/RM5dayLQKdCQsUtWxmokmdG
	 joQPdhepaoKYp/tzHr63mWLVYbcUH4ViqfMn4Ji3jzUCbe/RH5CEknva/ZaAxqiNGO
	 2QaqDtPiDtr+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 86FC9CE0E63; Tue,  1 Jul 2025 17:23:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 1/5] torture: Remove support for SRCU-lite
Date: Tue,  1 Jul 2025 17:23:26 -0700
Message-Id: <20250702002330.1074433-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2994ade2-bd06-4ba7-bcc9-be4d0d15ea0c@paulmck-laptop>
References: <2994ade2-bd06-4ba7-bcc9-be4d0d15ea0c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because SRCU-lite is being replaced by SRCU-fast, this commit removes
support for SRCU-lite from refscale.c.

Both SRCU-lite and SRCU-fast provide faster readers by dropping the
smp_mb() call from their lock and unlock primitives, but incur a pair
of added RCU grace periods during the SRCU grace period.  There is a
trivial mapping from the SRCU-lite API to that of SRCU-fast, so there
should be no transition issues.

[ paulmck: Apply Christoph Hellwig feedback. ]

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

