Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D692320A37;
	Sat, 19 Sep 2026 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776065; cv=none; b=qANoGLSoZ0Dy3xZCwiRAiRRg3rxwZ7J+6Q3gd3TvJI/x6wJYfHPNfhxOQTGGV7pWOFPp58M8Ndg3FZ6LxOXG2iCScFD/XpzRGlpls107q34i8MaMgkKRaiu9Ep1tpMhPUtiJyFd4ZhT/sedhiJBpK8yU0nXeweaaoS0tFO0k/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776065; c=relaxed/simple;
	bh=eRBlnVC3c96n4m7SJYM/hL7P4VenYVZ18wB6jEBUR+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ea8bb/j8v76F0rDldzHciFl8OMiMab3jXDDuIrOowPmbSBWydWi2kS4ILRugKfEiWnn56Wz8bRF2+fdtZCD4Avarjeax23Qcnrcu0ryM/2NgBtlyYmIFtV+n5iH5g2PWmhM+nevYkZcsHV7vbF1Wa0GXh0SPscktSymvoHQS/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C367oKe0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C367oKe0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E111F00907;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=y0emLy4cuASAllaGVXot26p93XUEiKllBnJOmZyJbkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C367oKe0tFdfqpUqV4l43esLxcv+uJ/3L8rvcj2LAyQvmYwbaRkWl5ngPyNOAX02P
	 vBpI0eXSZoyrGjkVDpOJqPergG6ivh7SIlpNSHVHTIoAPDQukD6SblmBztpQ63jBAb
	 NgeTdOtJwvyU08yCuzdHGRcbiabw8pP31YyZ41D8KY/8uVyHsHWgoKrfqqopN5xYms
	 IkiOImbr1naKV+HfRCU152kQ9PYjscDQFfHCK/oIw2sH4yY8J/r1Y3ZI/9JgVNjI8K
	 jpB/gEAfzSnqzyxuxLU95gEHTt2pUSIBKx7caiIoHXMzB4rwNZ+WXe33LHKkvjdINy
	 7bYuXDxQafNqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 89901CE0F14; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 22/28] hazptrtorture: Fix hazptr ownership issue
Date: Fri, 18 Sep 2026 17:00:50 -0700
Message-Id: <20260919000056.3132131-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
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
Cc: Boqun Feng <boqun@kernel.org>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index e21c5ce3d4dc..72aeb50668e9 100644
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

