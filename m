Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C201372686;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173793; cv=none; b=p79swHkoeLueGoffqluMsRz8HQ2Z4kk9obknLO764e1xKE1gSwu1I973Qf/WWU49rHcQK0Tw/sM69TFGzM7/u4VCCDr6nuxRDtUohZf7dyTs+6DiINdx86ZupEgVyFpxMbgGD7uqqEF1DTKC+EP41R5nXk2nvo7qU0t0xY9/6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173793; c=relaxed/simple;
	bh=jDUIv5GSBmuhjUG+/Jy9X5I9h/1y72j84vtbUTmUpHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bX/BZT0dpj6fhA7xa4+bwrxXm6UsLimZgbshPTBc8NMx4yey0N7jdOMoA7QU7nRBTGWcq4pRuasY4MLN7Umh88+cyjmmkczEobzlIH+4cbLHTcKrwdABDraYGqPpVQEG+MoTeLv9dsL0whq2BdJh7oXxDV4tlK6m8U/StqmgG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXuOrhnC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXuOrhnC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE25C2BCC4;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173793;
	bh=jDUIv5GSBmuhjUG+/Jy9X5I9h/1y72j84vtbUTmUpHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXuOrhnC++vC0uq6VVLgZfQNmhh+oYdRzrv2FI7r2xR8sfxo0u1xpCSUa0sXUWK+/
	 wPdGmCxjOJq3UobPsfdURzcMVXW8jrpLPRO5eaBu9D8TNcJPVpOYzOepVowtXa3ZG9
	 iArw96znGRdV6j57q4zedQpU/C4WiKdQH1SQp88B4lvpktnS3RonEJ+DjgrNp98vNg
	 hRYOr2qcy4zzYqC6vtKy6YKfeAOQHvog+2OonQM+CT7oZ8H0ErtyewXgAg0M1aI5Pz
	 d1nic68ULj/WtawkxwGZQDsfS6q/ONNC//FtQgmUMl/MBC5vjM4cZbkmLG4UEjGvL9
	 hufuXjC7Le0LQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A4A53CE0863; Thu,  7 May 2026 10:09:52 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Samir <samir@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/7] srcu: Don't queue workqueue handlers to never-online CPUs
Date: Thu,  7 May 2026 10:09:44 -0700
Message-Id: <20260507170950.2040199-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
References: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While an srcu_struct structure is in the midst of switching from CPU-0
to all-CPUs state, it can attempt to invoke callbacks for CPUs that
have never been online.  Worse yet, it can attempt in invoke callbacks
for CPUs that never will be online, even including imaginary CPUs not in
cpu_possible_mask.  This can cause hangs on s390, which is not set up to
deal with workqueue handlers being scheduled on such CPUs.  This commit
therefore causes Tree SRCU to refrain from queueing workqueue handlers
on CPUs that have not yet (and might never) come online.

Because callbacks are not invoked on CPUs that have not been
online, it is an error to invoke call_srcu(), synchronize_srcu(), or
synchronize_srcu_expedited() on a CPU that is not yet fully online.
However, it turns out to be less code to redirect the callbacks
from too-early invocations of call_srcu() than to warn about such
invocations.  This commit therefore also redirects callbacks queued on
not-yet-fully-online CPUs to the boot CPU.

Reported-by: Vasily Gorbik <gor@linux.ibm.com>
Fixes: 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when non-preemptible")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Samir <samir@linux.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>
---
 kernel/rcu/srcutree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0d01cd8c4b4a7b..7c2f7cc131f7ae 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -897,11 +897,9 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
 {
 	int cpu;
 
-	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
-		if (!(mask & (1UL << (cpu - snp->grplo))))
-			continue;
-		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
-	}
+	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++)
+		if ((mask & (1UL << (cpu - snp->grplo))) && rcu_cpu_beenfullyonline(cpu))
+			srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
 }
 
 /*
@@ -1322,7 +1320,9 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	 */
 	idx = __srcu_read_lock_nmisafe(ssp);
 	ss_state = smp_load_acquire(&ssp->srcu_sup->srcu_size_state);
-	if (ss_state < SRCU_SIZE_WAIT_CALL)
+	// If !rcu_cpu_beenfullyonline(), interrupts are still disabled,
+	// so no migration is possible in either direction from this CPU.
+	if (ss_state < SRCU_SIZE_WAIT_CALL || !rcu_cpu_beenfullyonline(raw_smp_processor_id()))
 		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
 	else
 		sdp = raw_cpu_ptr(ssp->sda);
-- 
2.40.1

