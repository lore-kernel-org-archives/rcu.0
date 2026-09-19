Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0702C0F7F;
	Sat, 19 Sep 2026 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776065; cv=none; b=MyiC/pBlrFkUWo3Pvrs2+7aD+//enYlsrY0XW5thO3CFtylU8kPJnlMhpuXLEjbqM/WcCkk/xkaYL0kEfmCHzsI1FPeaKoHOqdwR/7pn5kB+mOZG6BTzpiGPvxf4Jy7xfDC+lbuWejsvoE7cmqhMpg+u6swTJ5GkvncgZdwQYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776065; c=relaxed/simple;
	bh=9l9o5OTk9SXVhndCs90FIUSlXLEaEL75F93Ek23r9vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRRukQ7w5/w8bZBUN3509SjysAlM5KK5i98ay2Rmg2DJafB4Gt1KF+Mrnswt6PRVqQIvWdg0oNv+h02l40sX0C7Q+t0A9jbhnXBx12NAZBnv1q8mFo7+gGYaPP9FfFd6YZMRHonAbwr9u6QxSw0eG03Z4dIEZJbgq9NaIMHFZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp0Brm/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp0Brm/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4C01F008BE;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=zHw73w++Fi4O/idjdFzFYVPTFOEmmVCczO+XxEjj8qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jp0Brm/MuB85W38LTCoOKGrAgrXeZ7FaXPNGrasKBRWy06dM6ZaxO6wWFu+lMsSF3
	 kl1ImNyP92LzqrILA70zPAegh6+u+/bY6itP7PeHA0FIe3pFzylAaq5aUY7nXFNyAJ
	 NfKt96iUzfABjtNpoi8xB7AuwGQlYvfj+ODeJ6XnxIgacTmUvmp3HIL7bVEljcjvnP
	 FyqeLN+4uKfO4VrgdYcHqgY6WB4642bHgeVFcuhrkjqs+FQNNSM4qUH4Yw4/w4iLZ+
	 B3WuQn9eYwnyVikdAqrU7+7uJGxRTXhv2Y7VE00FifeT1ens66emKZpegjN+Uk8inM
	 uzVMBWxbkFlgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8384DCE0EE0; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
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
Subject: [PATCH 20/28] hazptrtorture: Detach deferred and IPIed hazard pointers
Date: Fri, 18 Sep 2026 17:00:48 -0700
Message-Id: <20260919000056.3132131-20-paulmck@kernel.org>
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

Pass to hazptr_detach() those hazard pointers that are to be released
in some other task or within the context of an IPI handler.

[ paulmck: s/hazptr_detach_from_task/hazptr_detach/ per Mathieu. ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index a72375cb3221..e21c5ce3d4dc 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -411,6 +411,7 @@ hazptr_torture_reader_tail(struct hazptr_pending *hppp, struct torture_random_st
 	preempt_enable();
 	if (irq_release && !(torture_random(trsp) % irq_release)) {
 		guard(preempt)();
+		hazptr_detach(&hppp->hpp_hc);
 		cpu = cpumask_next_wrap(smp_processor_id(), cpu_online_mask);
 		smp_call_function_single(cpu, hazptr_torture_release, hppp, 1);
 	} else {
@@ -428,6 +429,7 @@ static void hazptr_torture_defer(struct hazptr_pending *hppp, struct torture_ran
 	struct llist_head *llhp;
 
 	guard(preempt)();
+	hazptr_detach(&hppp->hpp_hc);
 	cpu = cpumask_next_wrap(cpu, cpu_online_mask);
 	llhp = per_cpu_ptr(&hazptr_pending, cpu);
 	llist_add(&hppp->hpp_node, llhp);
-- 
2.40.1

