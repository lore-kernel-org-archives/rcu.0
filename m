Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C13314DE;
	Sat, 19 Sep 2026 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778153; cv=none; b=MdLKn2NV5Ep7ZBUAtJoqwAZvCtsXHkdvF3SgU+Wf3jp4zM7Q0BoP/188K3GCWFpn0Bq5OZu7nUCtlFn61Ly6ImJnyvo1ZufN5rPmpmQLT7YZ4f+RyxBm/iQYYWeG3pD9J/vRVETe/6xZvVmN+DajnORndJt0vlUdzmpwrPpRK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778153; c=relaxed/simple;
	bh=aJYWfRSy/NUVtGdVhme/KTv53wTCn+one3vRc4xjogg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ndjQ3Y1bMtCNLGGXSglu+tBlE6+CVWrNKvULumde/k7MjK9GcAMnrBzUpPAeaP7tPdBLt2recqS6xGkmFe65TJptlzmosv2FPdtgqczixqapOMSC1lumhfkkE9sx+3wZ/AP22OcTAon82D3C7NjVacMFyaZVtEVBCg0t7CFXNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgraV3mj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgraV3mj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C701F008BF;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=xIPHqN/G+Mi8IG9vs/cZ+W8abYmjux4zldBuPhBLEgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bgraV3mjWelfEiA+0nwhbGQH0bixwU9fKbXGE2ckuXhDm18q1FVt4jywLgdD9ucns
	 N8GmI2PKf45VUeths8SbxyUiL3qE/fDsN32RxXE+cD5+OQbBeYbyfwG4EfDuelpLrO
	 5TKww4ECIfmuklDMxLn37gqfRdv1dAd02RyfnQWawcFTL5Kt1BaoqkLf3kjlVEBHeM
	 p4blgH1HNxWQlnSJ4muNANaR5taMVGAwQppqHRP1Bix838SGHCtuGr6JuL3qohP2gF
	 i++H9eFPQ44YuMckVNdsdmetcFqIhqYdUtLKum0OUMSmsfGcF3VcL/QiFWl7z2CGcS
	 d6IH4QTKcG88w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B5489CE1978; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 14/19] srcutree: Skip callback scheduling for atomic SRCU grace periods
Date: Fri, 18 Sep 2026 17:35:16 -0700
Message-Id: <20260919003521.3134552-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

call_srcu() is forbidden on atomic srcu_struct, so srcu_gp_end() never
has callbacks to invoke for them.  Yet it schedules callback invocation,
which for atomic SRCU's SRCU_SIZE_SMALL state arms the boot CPU's
->delay_work timer every grace period, only for srcu_invoke_callbacks()
to find nothing to do.

Skip this for atomic SRCU.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 93b8d1088abe..0954486880c7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1016,10 +1016,10 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 
 	/* Initiate callback invocation as needed. */
 	ss_state = smp_load_acquire(&sup->srcu_size_state);
-	if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
+	if (!is_atomic && ss_state < SRCU_SIZE_WAIT_BARRIER) {
 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, get_boot_cpu_id()),
 					cbdelay);
-	} else {
+	} else if (!is_atomic) {
 		idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
 		srcu_for_each_node_breadth_first(ssp, snp) {
 			raw_spin_lock_irq_rcu_node(snp);
-- 
2.40.1

