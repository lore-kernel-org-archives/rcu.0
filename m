Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D472E7375;
	Fri, 31 Jul 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459718; cv=none; b=BZtbPxR+2syiCCvYY8m/EoTCOF9if/GDCjV9DzGAE8bPbqLWoLXMdyNDnegP8/erEkDgqeo5wT5MabJL5vV2xAYFCuhRToMGaouU3yO7dWnknwXkTPHY7yvGESOQSKYSCWQNdAPVhwz0iKa7ulta+ELADqSsSyqy1p88I3lt2xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459718; c=relaxed/simple;
	bh=w8G5cfYcQaM/fV8HeFYsbwcu7Zre3Ch3XgDCUA23tFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7BuvfAKLFhAJS+EddPCGFbzary2F/Sh2VjBZpH51LKs3zu/bXRn/lWpZswrrfJ9/kYjfVLdh9sOra64F+SIbSTaVwAbre6g69OwTjTtm+up7RuOBLZKptyP5f8gjTKWuv6lNl6pg4irX74I3hxkW3tlM5g4wT70QgbrCJSW3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhI6HjXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhI6HjXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402B71F00ADB;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=d90N1ezebPs22Y5VYk294ZLHVDI0r826ZopT19z5q6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QhI6HjXdV+QvPqYaUthxq3peP2Nl3I5tsbrnPTDqguHYFfs6w293ZKHeqEAiZEjUk
	 xOAmSi6RRtE1H1cBOdY0EzqM0tuVP7KfjahaOlXGhmtVdR0ReV7OPEHypx+3Sb/XKi
	 kmRCL1a5WODL1vCL6JHh8ZYyUS0HQSyneg2Fm+a2WUZg97uDGDWCwM21RJCgBdJHSO
	 fbI06HR2tzkRJS/7xAQVJA9nntfQ97h9A6ZyvUQHMKiLTk+b9nUsLXNJbkY6sigkJi
	 +EI/aN2LxTeMPiUl6IjNDNp+XrzReJHpcldak0w9b7hVNlwjJrnHSmaXJdEQCIVFUn
	 0ZOba7mVrsABg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BEC1FCE17C1; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 12/16] rcu: Mark interrupts-enabled accesses to rdp->cpu_no_qs.b.norm
Date: Thu, 30 Jul 2026 18:01:49 -0700
Message-Id: <20260731010153.3531313-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
References: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rdp->cpu_no_qs.b.norm field is accessed only by the current CPU,
but can be accessed both at task level and from interrupt handlers.
All accesses from interrupts-enabled code must therefore be marked.
This commit therefore converts from __this_cpu_read() to this_cpu_read(),
from __this_cpu_write() to this_cpu_write(), and plain C-language accesses
to READ_ONCE() and WRITE_ONCE(), but only in interrupts-enabled code.

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        | 2 +-
 kernel/rcu/tree_plugin.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c9780e7c0e2afa..377153e0d93440 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2540,7 +2540,7 @@ rcu_check_quiescent_state(struct rcu_data *rdp)
 	 * Was there a quiescent state since the beginning of the grace
 	 * period? If no, then exit and wait for the next call.
 	 */
-	if (rdp->cpu_no_qs.b.norm)
+	if (READ_ONCE(rdp->cpu_no_qs.b.norm))
 		return;
 
 	/*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c3db1ad4a2807a..353effac5a37f1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -298,11 +298,11 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 static void rcu_qs(void)
 {
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_qs() invoked with preemption enabled!!!\n");
-	if (__this_cpu_read(rcu_data.cpu_no_qs.b.norm)) {
+	if (this_cpu_read(rcu_data.cpu_no_qs.b.norm)) {
 		trace_rcu_grace_period(TPS("rcu_preempt"),
 				       __this_cpu_read(rcu_data.gp_seq),
 				       TPS("cpuqs"));
-		__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
+		this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
 		barrier(); /* Coordinate with rcu_flavor_sched_clock_irq(). */
 		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, false);
 	}
@@ -952,7 +952,7 @@ void rcu_read_unlock_strict(void)
 	 * __rcu_read_unlock().
 	 */
 	rdp = this_cpu_ptr(&rcu_data);
-	rdp->cpu_no_qs.b.norm = false;
+	WRITE_ONCE(rdp->cpu_no_qs.b.norm, false);
 	rcu_report_qs_rdp(rdp);
 	udelay(rcu_unlock_delay);
 }
@@ -980,7 +980,7 @@ static void rcu_qs(void)
 		return;
 	trace_rcu_grace_period(TPS("rcu_sched"),
 			       __this_cpu_read(rcu_data.gp_seq), TPS("cpuqs"));
-	__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
+	this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
 	if (this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 }
-- 
2.40.1

