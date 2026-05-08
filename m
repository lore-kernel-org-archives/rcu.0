Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4820410D34;
	Fri,  8 May 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262236; cv=none; b=ZGxSxsnmV9Xx5KsASWEJdStz4togjNVXRLjrQW3XzoI2Lvyc1xKSyKqvj5cD1Lb0TjMu26fbY+U1BVWglBTfR/MDocJMKIzcw0XMU17TdImzePZs8CCbVsfX4pkTlklLwOIDfu4hts6s9kEF6jrXdit/hP15opUjD46+TR3ALNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262236; c=relaxed/simple;
	bh=jDUIv5GSBmuhjUG+/Jy9X5I9h/1y72j84vtbUTmUpHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZldCUw12Qt6lZk8sqKm2vhAHcmfBCS+5qtjIVugGfoHLulyoZkrSaiuYeBXk5T1kw8ErudYe4X21aH4667vGojRamKhftUhe++fqKWLufx01yP13UGSZh4+bpGqF7wZXmr9Wyy3zIidwIoQI18DZzTBLnFRgBp3TGhixi6PNBHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFZx9di3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFZx9di3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885ACC2BCF5;
	Fri,  8 May 2026 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262236;
	bh=jDUIv5GSBmuhjUG+/Jy9X5I9h/1y72j84vtbUTmUpHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFZx9di3wLDvmp1C5rKrvLZJLcJ+8sK3MDJPd0lT5F8kyYHTH569IQKASvKh3YEAH
	 xVXeb7upCPcL6E5LeWKqcws2ZjGcye89yoLeauLHMrXt/6qGPtpMN3ON2fSYhISkfV
	 skhsodm+fGMpq6dD8qav5Hf00InSIDclYYur9Uat6aM30UzUSdJPfKM569aUGglyw+
	 4azmUSV9iw43/13JpmVQABrrnQTw2eyXKqaae/WGFjoI9XTJqCImSEn+EnrGJhXMhs
	 OdnvILxfySkp5cwLzNNyYmD8vP3+d2FyhAAOD8HzR35zHMmNret0BtpD7o/mt3LmYM
	 wuQupiwsZIR/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3AD99CE06FB; Fri,  8 May 2026 10:43:56 -0700 (PDT)
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
Subject: [PATCH v2 1/6] srcu: Don't queue workqueue handlers to never-online CPUs
Date: Fri,  8 May 2026 10:43:48 -0700
Message-Id: <20260508174353.905746-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <40ed4910-e20b-40a6-9598-7aa6abf006c5@paulmck-laptop>
References: <40ed4910-e20b-40a6-9598-7aa6abf006c5@paulmck-laptop>
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

