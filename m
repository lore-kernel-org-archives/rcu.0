Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4524501D;
	Thu, 16 Jul 2026 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161097; cv=none; b=A23abbjKIwNQIuux8DTiPVhkrEdsfbeeEuC3F6UDRXtA1CrIS2aqzL+OtvRsVZA4QATXl+YfZkg0fJtmd7/qmYtLfop8+MR7w6mWO7R6bqfx15dxDTiyQE0w1XcMynprTHT3TWp5tDx+IDWUSxG1cYFUH9oS9/hpgmzwhis9wIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161097; c=relaxed/simple;
	bh=/B+fi8ukPwEgpj/yLUn0uXe7/WHkFf7Da4S66mrAOyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lgWN095CUBUW535SQqcdF8px4cZar8I7fYtsaSBVm2ZPIFrbbMZSSvhIeo4ZRw9/qDA/YB7UDf7dV3/2P+o8Vq6qo4F4/yRryRkZl++RxSP3RrWQHgXCM6WqLu+OHXQk5sXo1gmcceKHIwKfuCyLjLmdPuFdvRA6P+M0Yae5Ktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKHffkn7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKHffkn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52F21F01563;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=rk8Zt8AGXLeYFlr5hpQ5Pkkm2AOavSzFFbJr+gqcPSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LKHffkn7/QRXKJ3vO62b4DAiSRv9QaoG2KL+ozWC8MS7u4xHSJcGS/4o7rQcoL0B3
	 iMCS8mXC95W9XVQdbjsc19lQENm+PTGR3ByuYKP003idp2hnpqXwkGUBaBU+4SdI23
	 d7rHBxbtfPHs4n20U+FxTHH2zVeEldibOJ3k1Z6FXAKrr8A6JFwMGHjCPE5hjzKUQA
	 TCW3dPl6vamVpEtInSN1icffsKx5AdZbXkf+Kw5rTfNp4GgKVNVeaEVARVSHdvX675
	 Hn2DxyoTLYiEzHG5zC6Zh/Fg0gkx1T4Wh1Ak562uIQ+GNhP2vamb8A7mpUZDeS1vuO
	 /dI+z0eIjVSrQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 53CB7CE0F7B; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 20/24] hazptrtorture: Detach deferred and IPIed hazard pointers
Date: Wed, 15 Jul 2026 17:18:05 -0700
Message-Id: <20260716001809.11084-20-paulmck@kernel.org>
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

Pass to hazptr_detach() those hazard pointers that are to be released
in some other task or within the context of an IPI handler.

[ paulmck: s/hazptr_detach_from_task/hazptr_detach/ per Mathieu. ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 311b387d6ae755..ac0cb5b9f4f0f6 100644
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

