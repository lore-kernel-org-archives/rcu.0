Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631B2D739C;
	Fri, 31 Jul 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459718; cv=none; b=vC+xBCwLI9NvgCWLzAPV4fC5/+L7SDbX4hB5TMQiPNlPJ8JiofvV+Bqg8MFJbtL1ztcALki036UhJ+QE4TzZ11BqXdlVsLhMW9JiA2zFc8xf+497vzslq4z3SPsRuUBMvn1IU1bjB2hGFz97IglC8xXemsRsHvHQGubmR4BGQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459718; c=relaxed/simple;
	bh=H/LywIBhDN+7gS6h2t/zpJNCBkFiQp9SnPcP3462Yb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BsMeBvk8I/RTrFVTK5JNVOEwpVMoNozEFmqf3sF5hsztpSq6r+TiPZFx6atoRyeO6pYexHzXSYSmrVL4jsF4STzWSDrasHYqOklC29UciNXO4EkHFD7kvQ7ZZ3MZuJMbvOVUbJm4bPF5kDbId6C6fuaStg0dQeRpAbGZhGrmDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuNqD11L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuNqD11L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ADA1F00ADF;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=8nXrgC14QXbEPY+ClX2MuAHMfuWbHbQvcoYUAqNNUBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XuNqD11LB85ul7phFDq8hJ3kAH/FFQmc9/0vlQhnf8J2oB3i0Oiqx0It800kqr1hM
	 8V4Achgav+tG3MTMIU0D4hSEUrbBiMbFDYlVd5HYD2EJ5qHVZUWMURQLU33cGc3Ati
	 iE+qSwuL3gMfAW4OiU65d809D7YgZqMXZawMurEkI/4TQOR0DzSPHNY6/RfGuGCW3k
	 AGvwDeVis14qa/6eCorK38DE6K6ceBr1R/wiyJdqhhOS3eQF7BvNxvyR4JiYzodjyJ
	 mvihvRrwTs/LbQocFUoY9J3lcUuZGG1CJOq4QUfFbh+deOU17dyziZTajFjmgneHIz
	 7caC0oYShfaIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B27DCCE1059; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 07/16] rcu: Use this_cpu_{read,write}() for ->cpu_no_qs.b.exp
Date: Thu, 30 Jul 2026 18:01:44 -0700
Message-Id: <20260731010153.3531313-7-paulmck@kernel.org>
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

Currently __this_cpu_read() and __this_cpu_write() is used to access the
->cpu_no_qs.b.exp field of the per-CPU rcu_data structure.  However,
this can fail when the accesses can happen in interrupt handlers, as
recently started being exercised by rcutorture.  This commit therefore
upgrades the uses of __this_cpu_read() and __this_cpu_write() to their
interrupt-safe counterparts this_cpu_read() and this_cpu_write().

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h    | 4 ++--
 kernel/rcu/tree_plugin.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 82cada459e5d0c..e03cb3d447a57d 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -731,7 +731,7 @@ static void rcu_exp_need_qs(void)
 {
 	lockdep_assert_irqs_disabled();
 	ASSERT_EXCLUSIVE_WRITER_SCOPED(*this_cpu_ptr(&rcu_data.cpu_no_qs.b.exp));
-	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
+	this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
 	/* Store .exp before .rcu_urgent_qs. */
 	smp_store_release(this_cpu_ptr(&rcu_data.rcu_urgent_qs), true);
 	set_need_resched_current();
@@ -870,7 +870,7 @@ static void rcu_exp_handler(void *unused)
 
 	ASSERT_EXCLUSIVE_WRITER_SCOPED(rdp->cpu_no_qs.b.exp);
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
-	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
+	    this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		return;
 	if (rcu_is_cpu_rrupt_from_idle() ||
 	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) && preempt_bh_enabled)) {
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9ba136a4233a26..c3db1ad4a2807a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -599,7 +599,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
  */
 static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
-	return (__this_cpu_read(rcu_data.cpu_no_qs.b.exp) ||
+	return (this_cpu_read(rcu_data.cpu_no_qs.b.exp) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
 	       rcu_preempt_depth() == 0;
 }
@@ -981,7 +981,7 @@ static void rcu_qs(void)
 	trace_rcu_grace_period(TPS("rcu_sched"),
 			       __this_cpu_read(rcu_data.gp_seq), TPS("cpuqs"));
 	__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
-	if (__this_cpu_read(rcu_data.cpu_no_qs.b.exp))
+	if (this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 }
 
-- 
2.40.1

