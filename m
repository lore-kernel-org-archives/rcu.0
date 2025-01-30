Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928B1BEF84;
	Thu, 30 Jan 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263202; cv=none; b=iCJV7PWkC2o+E+ZHiWcZqLekgBHeFyzq7aND/LmDcLyasdhgEXnDtXYrPsrvZGMQSlqsP47rwQhiHQSYcT4C4G9pRKkHyfXbRaOKc7VHkb/OqQubijkozRa0sBGdFP9iLBopqFm/XzPo6lqOke7Idiu9nnK9hqFQq7jWcWY4cXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263202; c=relaxed/simple;
	bh=hv+tT3Rau97o2i5iHirH4zRSdtx++OeCZ+6fHSofWJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQj5giCL//JpNaoMxnnwwsWxHoDccrsh7GkBupBO/4kGhhpqNK3qGHva+O8o0sIqy5Il79rxkjszEyw0je9OYxFMhphFY/NBZd6jTESkpdII8X37iElBwAJrbmd1OetDBoQ5L/1eJjjqUgKogJfn13SA7eh1AIkwF4UBxcB2Jwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRZ91qxg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRZ91qxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7DAC4CED3;
	Thu, 30 Jan 2025 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263202;
	bh=hv+tT3Rau97o2i5iHirH4zRSdtx++OeCZ+6fHSofWJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRZ91qxgh/vh5XJN9KmguuZiLH0GJprOO7gT6jo+rcVPj4omNPhclnz+Q6I5BUc30
	 UzCO0FyJII9bY6byYdlIwlksAm1dTvLJwis3r/vi82XJAN1FRaVBItLEeMRcviphYs
	 ORzx/IUnl/1HjcJ1Mp/iWNh2frUKRj2i79cY6FcV3YCW96FUm1Kl4U6P1VSheZH2ZH
	 0Tq+sSoQ1qnvT7g+AWzQ/que103Z2Umr30VROU2lz1nBO1tYr/VpwsCzRp/cKfxR4a
	 5Mxz/mo5GCvckcp9MeK5KZfhkJgcB0m02PE0nb57qhFI+ArTdK7km8A/tBDvRidZTw
	 DzPerxBj9NaRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CF4BACE37DA; Thu, 30 Jan 2025 10:53:21 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zilin Guan <zilinguan811@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 2/5] rcu: Remove READ_ONCE() for rdp->gpwrap access in __note_gp_changes()
Date: Thu, 30 Jan 2025 10:53:17 -0800
Message-Id: <20250130185320.1651910-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zilin Guan <zilinguan811@gmail.com>

There is one access to the per-CPU rdp->gpwrap field in the
__note_gp_changes() function that does not use READ_ONCE(), but all other
accesses do use READ_ONCE().  When using the 8*TREE03 and CONFIG_NR_CPUS=8
configuration, KCSAN found no data races at that point.  This is because
all calls to __note_gp_changes() hold rnp->lock, which excludes writes
to the rdp->gpwrap fields for all CPUs associated with that same leaf
rcu_node structure.

This commit therefore removes READ_ONCE() from rdp->gpwrap accesses
within the __note_gp_changes() function.

Signed-off-by: Zilin Guan <zilinguan811@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 229f427b8c82..e49bcb86b6d3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1275,7 +1275,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Handle the ends of any preceding grace periods first. */
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
-	    unlikely(READ_ONCE(rdp->gpwrap))) {
+	    unlikely(rdp->gpwrap)) {
 		if (!offloaded)
 			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
 		rdp->core_needs_qs = false;
@@ -1289,7 +1289,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
 	if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
-	    unlikely(READ_ONCE(rdp->gpwrap))) {
+	    unlikely(rdp->gpwrap)) {
 		/*
 		 * If the current grace period is waiting for this CPU,
 		 * set up to detect a quiescent state, otherwise don't
@@ -1304,7 +1304,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
 	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || rdp->gpwrap)
 		WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
-	if (IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(rdp->gpwrap))
+	if (IS_ENABLED(CONFIG_PROVE_RCU) && rdp->gpwrap)
 		WRITE_ONCE(rdp->last_sched_clock, jiffies);
 	WRITE_ONCE(rdp->gpwrap, false);
 	rcu_gpnum_ovf(rnp, rdp);
-- 
2.40.1

