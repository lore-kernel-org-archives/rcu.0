Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6983DB641
	for <rcu@vger.kernel.org>; Thu, 23 Jul 2026 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792508; cv=none; b=Pmyj3Pqe+QBtZ+X7cgRS2JbrFOyr1N8msnzQGuO8XjcM09X0cVXdFYQcmEpMUx1FCw9yogp6m4eyfPjr2tfbEtOT6rpI1RoAs80q35bp34xZ8HcaEyFyANU1gKZdHZ4AMyWL7fNpg8419w0hXww6xG3YenE1TxAvbHyyqQwgUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792508; c=relaxed/simple;
	bh=IfcPC0aDlF2Xtmo/+VIz8TnwsUX1zREWR8TZtffPVCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nP+mm4jgjYnuFW+ZjJseFLyLK5ArkFbFCEy8Bu403wPQ+JwGrsaVUTL4uXNHLe4ENZ5dvwTssntbrqrNBt7EWOanQSPAdVR3GUwQx5Q0sw0CMWrOMcJ4sPbEtQVXFUu3+L+ck/YPet3w6tATdMv98v/7IbQ2V4HCGwMl3mTz3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swdqO/Yv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swdqO/Yv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954c08a7c8so651435e9.3
        for <rcu@vger.kernel.org>; Thu, 23 Jul 2026 00:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784792505; x=1785397305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=trauJ58V/CwSy4UI+BD+U8m2Qt0PFL98kKag7U3rqUU=;
        b=swdqO/YvkNaNsIR1vAX6zP1KUwyLn0tsRwofXKp7bcNWrUR8LgY3qFDD5z+Ttu4W/q
         B+vBQ38fLYoIrFKKmYLnf0h4Go6jczfUkbx1ehsfpQphRqi0RjRCwoAZEjhQM3lnDew3
         lZmRblFc//da0JseCoeHLuTCl/4FGJ6x1uDfZl1VQ+ribq/LyvO0f2oDPwhO2y01DSop
         Bm5Ofz++GUF18QVIlBKUsSBcl5Wf1ecQv/bGpT1eK6p5xsLZmxvj8CRqaWqSaplOXtVc
         faQNbJTMCLWIP+viPOFsxVKz3ZCotrEDni2t1itPOrmZJdYzVQiq2pGY+d0xo+kuxiC0
         ap5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784792505; x=1785397305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=trauJ58V/CwSy4UI+BD+U8m2Qt0PFL98kKag7U3rqUU=;
        b=ZhYDUA48JqyOFrA+6kPRdJxlIA0l8PocbOpKVQYwEodqvh5ib+reDH8Af4HvOJAHNr
         uI9YYmEeGFeeTd8oCNiqLMlS8D2VaKmwGE9GqW4A1JFryChURbwPhTNYHdu7IFlxq9Hj
         +y5OB8KhPU/B71eQqMKFrT7Gv+Bn+XwAJcBDi3rJlH0QNsYpr4uTAQCesCo5gEUPmlN1
         pIbrAC2aK/xa6ZqHKB7pQ8od5yr6XdcJC6Rb8CQ6MWNlAzZXMINTWbsB1swVs4Q+XLYY
         2OPVBrwOMSegGYY+hsx+ZTZvJHB0Dg3ID3soOodg4W0ry3vYuO6tlJsRZMZjMIPjVGHG
         hzmA==
X-Forwarded-Encrypted: i=1; AHgh+RrS0g13gwnGGJRigm9x2zsfZ2rOiSLyWU8W37yA7GI6VpRZoS1FXI2CS1HXht3jiQPJlkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVpEd4f3e54TozUn9S/0atNndaROVXrwzv3EccvYguKHIiESbK
	ekDXNO+DR1Qr4qcvzduL0jEscOAKWJXK/w9kAa85QTvdBzGhE3tfehm3
X-Gm-Gg: AR+sD11smNQIMEWz841ufO+ehbHHl0nUwAIC6JJYhyUI3zXGOuWDlc6LwDSqUnoSl5S
	tVBhEwr1++vFEwzi8sXKNYofgXzPIx+3ft26GmNvHTb4KWGxAIDlr7IFKjktadWY/Bu6c+TG1TP
	sQXES1BT9JoLe6csUjOh0wT/n5H7nBUNec2xBU4wiSS3QD41vHscQnsUlBqKrbAq+LL6SES/QQL
	ElxJMdgpT1KM5eistwaf21y55MUGhy5f2tDw3+Ia0ExXZ80TsOb/0d2OI5GZopCEAid8k2BGAee
	9sENqtB7P0B3dQTWJ/DbwDuMcRVSKzAobSwjO8q7jx4pLboGwTg1CtDwoGbemQLQuaAhNGFanbb
	xXci7m44uu6B89qDJW7cQyAhGjIwBtSdBORH7OGkvuLMo1BxLh6fO53KDoruh7jig8poy7waqz0
	gT0dQp3Utsh2yjkmaGpeBZPfl8CRxCHMXp
X-Received: by 2002:a05:600c:1992:b0:495:6713:9ae2 with SMTP id 5b1f17b1804b1-49573c8b96bmr13733805e9.1.1784792504605;
        Thu, 23 Jul 2026 00:41:44 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b5c2108sm195870355e9.2.2026.07.23.00.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 00:41:44 -0700 (PDT)
From: Itai Handler <itai.handler@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Itai Handler <itai.handler@gmail.com>
Subject: [PATCH] rcu: Mark accesses to ->rcu_urgent_qs and ->rcu_need_heavy_qs
Date: Thu, 23 Jul 2026 10:41:38 +0300
Message-Id: <20260723074138.3093927-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/rcu/tree_plugin.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 95ad967adcf3..608f73286647 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -970,7 +970,7 @@ void rcu_all_qs(void)
 {
 	unsigned long flags;
 
-	if (!raw_cpu_read(rcu_data.rcu_urgent_qs))
+	if (!READ_ONCE(*raw_cpu_ptr(&rcu_data.rcu_urgent_qs)))
 		return;
 	preempt_disable();  // For CONFIG_PREEMPT_COUNT=y kernels
 	/* Load rcu_urgent_qs before other flags. */
@@ -978,8 +978,8 @@ void rcu_all_qs(void)
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
@@ -999,8 +999,8 @@ void rcu_note_context_switch(bool preempt)
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
2.34.1

