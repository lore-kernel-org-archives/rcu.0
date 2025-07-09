Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3E28D8D6;
	Wed,  9 Jul 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057608; cv=none; b=LahkubHF/pY8o6N/NmC4Y9i/96gyl/rmwOtM18xxJKnCqPAVUx27RihVZGCCwwL9QYZQ+ZhB+wKcTnTqmCoSXyzCH4tcADZ32Y2F1okD0dY9Rbv4zR3HhrtJNJu+TPS6dAcWQIhsScidX5aszzOLtYViTSOY8ZGf/XjQZQy03hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057608; c=relaxed/simple;
	bh=Vx5swSkJc6lENCnzFmEdVW2ZusvksdSbXWKBGrAa3HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3ikV1JCvfHpKuhdUGlIPRtV25kZwZyiZe7vI6vQKQQILyBuN3vyyKO71s3Aig8heoFhaEqAjNkIZ4R9Makrjpc2kT9//RZDE/d2dJcBlGylsd4etkvaFFmMksOoiHSGmoaXttajWCOWUa87Nn7J6+Qt+NrSENs0n82y+hwWd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/nw7HwW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/nw7HwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F68BC4CEEF;
	Wed,  9 Jul 2025 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057607;
	bh=Vx5swSkJc6lENCnzFmEdVW2ZusvksdSbXWKBGrAa3HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/nw7HwWoVJrRSvzPBWsvVZEoxDFcSbVtBxT7qHlYOxIb3dgaBlj0KgE5KTaG05E8
	 wFrBKy+QSf9S86EpaVGoe+ZMCV5lKvvGgWKYy0VFJPU2DGPnD4gTInoMW9Y8g6IpPm
	 O+i9w65WNtcVc8cfYxVwWtw7w2EiH+7q8DwiUxf8DnoJKyTKsrx3cpdEjqTjHbRV5C
	 xusTg5k7u5jiZTI2ffkjLjHq/nsFXjmJUXJ8u426lJbGFG+hCHqdXMTb8FIKqTrgYN
	 MuOAcXaT1Qlz9C5v1xva38yw4ERA6jpuxwr9GOQEBpB228OI4uPPaLDjj730JdvqTJ
	 YbG3ScL/ng/Lw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 4/5] rcu/exp: Warn on QS requested on dying CPU
Date: Wed,  9 Jul 2025 16:09:08 +0530
Message-Id: <20250709103909.15498-5-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709103909.15498-1-neeraj.upadhyay@kernel.org>
References: <20250709103909.15498-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

It is not possible to send an IPI to a dying CPU that has passed the
CPUHP_TEARDOWN_CPU stage. Remaining unhandled IPIs are handled later at
CPUHP_AP_SMPCFD_DYING stage by stop machine. This is the last
opportunity for RCU exp handler to request an expedited quiescent state.
And the upcoming final context switch between stop machine and idle must
have reported the requested context switch.

Therefore, it should not be possible to observe a pending requested
expedited quiescent state when RCU finally stops watching the outgoing
CPU. Once IPIs aren't possible anymore, the QS for the target CPU will
be reported on its behalf by the RCU exp kworker.

Provide an assertion to verify those expectations.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0bda23fec690..00c182b3f978 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4356,6 +4356,12 @@ void rcutree_report_cpu_dead(void)
 	 * may introduce a new READ-side while it is actually off the QS masks.
 	 */
 	lockdep_assert_irqs_disabled();
+	/*
+	 * CPUHP_AP_SMPCFD_DYING was the last call for rcu_exp_handler() execution.
+	 * The requested QS must have been reported on the last context switch
+	 * from stop machine to idle.
+	 */
+	WARN_ON_ONCE(rdp->cpu_no_qs.b.exp);
 	// Do any dangling deferred wakeups.
 	do_nocb_deferred_wakeup(rdp);
 
-- 
2.40.1

