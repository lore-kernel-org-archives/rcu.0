Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861981F3B85;
	Thu, 16 Jul 2026 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161097; cv=none; b=AeK5m2XOW0tUNjS4t8OgVnCmKLAnjTg3ER+0bmkFhNtQFhHTRZMJP+jU+5/oFwRJ93VllAQhFjoCEzuIx2N21DwTY7/QnKX/g9pyps3cxFvN6+QOjJcYgEhCTDc0a3hZIQVXb15tR9ziz1xaYfh0cj3p2/SIgddnjoEcGwXoFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161097; c=relaxed/simple;
	bh=6oVzcSBj6kE8wjYY1W4nlz+iO87tEMu2odbs3kQBbUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+k/bOUUA4kacZkOSaQeHyMYzCIn8osd97NwYSRvUIW6Q+UvWt+9GlOZ1tej3Man4kDBSOm3o6Pdf1SnMVGtOLn53ENMrs30yE7nIMjPNkx5/QUQeATQ8gTi6b2f0T0rFXfClNzb7LvY375x7+RznIcV6ZQGFl/Ijewb9MvDsdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU2b58TX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU2b58TX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92D91F01566;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=BR7mqeQqi1nfzRNjsh6eZW1e50dQgGiaIf2ARC6PPoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CU2b58TXF3wKbn72zP+YgK/WYxyJeWjA8P/XrK+diKJk1Vv/0wWvBTS2glUKxStp8
	 ATeIpX/Kgd/LFm5WwHdBKXe1wh/vO9ecmldlAobiaISD3Yf5sydug30ZrwxDMND9Q/
	 eiZEBBfEetCFyw2e/qZU6nuus9P8ktsoKX8TozUzJjLjbSgurl50y8pZB/dwBZEim2
	 JxjODgnYVIykbyUq4ZWRJTq+/JVLERyVxGbqW9vPdGxEa+6b4nLFznc2bIl/cfHKLi
	 5pLOURWMVsDUsxbmxprd+IuG03Rgn99q2UI5TiT4x9+ub4QVaexmV7T3Ek6+McA4Tc
	 txjRrqavZKqzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 59F4BCE0F85; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 22/24] hazptrtorture: Fix hazptr ownership issue
Date: Wed, 15 Jul 2026 17:18:07 -0700
Message-Id: <20260716001809.11084-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

hazptr_torture_acquire is invoked from IPI on remote CPUs. It needs to
immediately detach the hazptr from its local task so it can be released
from other tasks.

Without this fix, the hazptrtorture test fails loudly with a OOPS. It
passes with the fix applied.

[ This applies on top of linux-rcu dev branch at
  commit e5ee2ea2d00ae5a0ca53ccf9c9100f2357e1bd08 ]

[ paulmck: s/hazptr_detach_from_task/hazptr_detach/ per Mathieu. ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index ac0cb5b9f4f0f6..b2999f577af8b1 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -370,6 +370,11 @@ static void hazptr_torture_acquire(void *hppp_in)
 	struct hazptr_pending *hppp = hppp_in;
 
 	hppp->hpp_htp = cur_ops->readlock(&hppp->hpp_hc);
+	/*
+	 * Acquiring a hazard pointer from a remote CPU.
+	 * Detach hazptr from its task so it can be released by another task.
+	 */
+	hazptr_detach(&hppp->hpp_hc);
 	atomic_long_inc(per_cpu_ptr(&hazptr_torture_acquires_irq, raw_smp_processor_id()));
 }
 
@@ -411,6 +416,10 @@ hazptr_torture_reader_tail(struct hazptr_pending *hppp, struct torture_random_st
 	preempt_enable();
 	if (irq_release && !(torture_random(trsp) % irq_release)) {
 		guard(preempt)();
+		/*
+		 * Handling release from a remote CPU.
+		 * Detach hazptr from its task so it can be released by another task.
+		 */
 		hazptr_detach(&hppp->hpp_hc);
 		cpu = cpumask_next_wrap(smp_processor_id(), cpu_online_mask);
 		smp_call_function_single(cpu, hazptr_torture_release, hppp, 1);
@@ -429,6 +438,10 @@ static void hazptr_torture_defer(struct hazptr_pending *hppp, struct torture_ran
 	struct llist_head *llhp;
 
 	guard(preempt)();
+	/*
+	 * Handling release from a remote CPU.
+	 * Detach hazptr from its task so it can be released by another task.
+	 */
 	hazptr_detach(&hppp->hpp_hc);
 	cpu = cpumask_next_wrap(cpu, cpu_online_mask);
 	llhp = per_cpu_ptr(&hazptr_pending, cpu);
-- 
2.40.1

