Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E322E7378;
	Fri, 31 Jul 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459718; cv=none; b=ebSr7JFyr0S2zdhnRuFHtHmPH9zirZNd7f9k2d6hIzDoOQJhLvMMwb1foqhdLL93Rg4mU4cAGRN/vMsfaw6sOpC5rcwwF9k3zdGzETOszlqH/VNxrrT/ddNlMSWYBAX3SNMSAKE/G+eJKtVH3cu6F/zo627YJs7UifeXYrEYXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459718; c=relaxed/simple;
	bh=NOD7h8A130NxjLdL1JhNvSi0xbDjOhnoKk7yWYbIHnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JeoFVIUqTsyzMOQdJ5xESlLmLQN5MdutfbwapFsiVw2B/GmwSPHvVzrhQOfV8aom/RKT0AcydoQ8aLV85JBJEcvy/pyhMQ/DRZnubjFxaBij5ZH8VyQcEjMSW/7IlSgLdPEb5Ao5b8LPnRWatdK9G+yWs+XTHIR9hb+zFLPMB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHDYK6lg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHDYK6lg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D9D1F0155B;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=+uHQqjlhA8kcMxl9eau4DVudI4JBlvQd5ZmavBxnPVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JHDYK6lg1DnQkJGZWUFxlqxD/BNWWviMarCvNfz6yuRQIjWHXuQX1J45JvGm8gwi9
	 ey5o+8RUxwE8M3nqLlYq2PwgQAuIFWJr+eAiqA/FzDU15WXjn0+oGFmAIZh5UP2sP6
	 AvQOk7PMd6kiW0DMNXml0JWEWFVZ7XB4NXOgczl2b8Yz23caC+KabC4RKdy2IlTbCY
	 zPDn6/Qle6YOqiP0YF6JFpY1TduhEpEPHzANp5DYmAAfgXOe84iKNw5PEuuqvNlpT7
	 CiCJPDuP3Z9ASSTYXKDqJCSv5aoRhygPEp2iWzaeRNWF5aewTrXusWbtvPEAcmncDQ
	 QmCeivbkQNLLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C3C5BCE1A23; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Itai Handler <itai.handler@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 14/16] rcu: Mark accesses to ->rcu_urgent_qs and ->rcu_need_heavy_qs
Date: Thu, 30 Jul 2026 18:01:51 -0700
Message-Id: <20260731010153.3531313-14-paulmck@kernel.org>
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

From: Itai Handler <itai.handler@gmail.com>

rcu_all_qs() and rcu_note_context_switch() read/clear the per-CPU
->rcu_urgent_qs and ->rcu_need_heavy_qs flags with plain raw_cpu_read()
and this_cpu_write(), while the RCU core clears them with WRITE_ONCE() in
rcu_disable_urgency_upon_qs().  KCSAN flags the resulting same-CPU race:

  BUG: KCSAN: data-race in rcu_all_qs / rcu_disable_urgency_upon_qs

It is benign -- the flags are advisory and rcu_all_qs() re-reads
->rcu_urgent_qs with smp_load_acquire() before acting on it -- but these
are the last unmarked accesses to the two flags; every other access
already uses READ_ONCE()/WRITE_ONCE()/smp_*.  Mark them to match.  No
functional change.

Reproduced on a PREEMPT_NONE, CONFIG_KCSAN_INTERRUPT_WATCHER=y kernel with
a pthreads program whose threads (two per CPU) loop reading a large file:

	for (;;) {
		int fd = open("/proc/kallsyms", O_RDONLY);
		while (read(fd, buf, sizeof(buf)) > 0)
			;
		close(fd);
	}

The read()s drive cond_resched() -> rcu_all_qs() while the busy CPUs keep
the grace period urgent, so the RCU core clears the flags concurrently.

Fixes: 2dba13f0b6c2 ("rcu: Switch urgent quiescent-state requests to rcu_data structure")
Signed-off-by: Itai Handler <itai.handler@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 353effac5a37f1..844a9ced67cc0e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -996,7 +996,7 @@ void rcu_all_qs(void)
 {
 	unsigned long flags;
 
-	if (!raw_cpu_read(rcu_data.rcu_urgent_qs))
+	if (!READ_ONCE(*raw_cpu_ptr(&rcu_data.rcu_urgent_qs)))
 		return;
 	preempt_disable();  // For CONFIG_PREEMPT_COUNT=y kernels
 	/* Load rcu_urgent_qs before other flags. */
@@ -1004,8 +1004,8 @@ void rcu_all_qs(void)
 		preempt_enable();
 		return;
 	}
-	this_cpu_write(rcu_data.rcu_urgent_qs, false);
-	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs))) {
+	WRITE_ONCE(*this_cpu_ptr(&rcu_data.rcu_urgent_qs), false);
+	if (unlikely(READ_ONCE(*this_cpu_ptr(&rcu_data.rcu_need_heavy_qs)))) {
 		local_irq_save(flags);
 		rcu_momentary_eqs();
 		local_irq_restore(flags);
@@ -1025,8 +1025,8 @@ void rcu_note_context_switch(bool preempt)
 	/* Load rcu_urgent_qs before other flags. */
 	if (!smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs)))
 		goto out;
-	this_cpu_write(rcu_data.rcu_urgent_qs, false);
-	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs)))
+	WRITE_ONCE(*this_cpu_ptr(&rcu_data.rcu_urgent_qs), false);
+	if (unlikely(READ_ONCE(*this_cpu_ptr(&rcu_data.rcu_need_heavy_qs))))
 		rcu_momentary_eqs();
 out:
 	rcu_tasks_qs(current, preempt);
-- 
2.40.1

