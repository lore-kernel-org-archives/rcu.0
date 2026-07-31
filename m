Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1692E0B5C;
	Fri, 31 Jul 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459718; cv=none; b=hF48qh48motKNtOmmEZi22pggABzYDnSHvl/Re3uT+vhXkkRAOToxj2A2rKj+j82b86EJpfZSly0aa8SvkbdJtrbiTzPOuhDyKpDfCbXLIUtKutKFGdjQGWXQidk8Z3WP7es7mbPgCJ801BQJNfAfiEGP01QVZXAXKYrpi92ZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459718; c=relaxed/simple;
	bh=8dRscm5WjZJJ6gnnEC3G11Y1b0fADU3e4aeIuAkhUq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CR30uQ30DO0xLszf8ZRf36KokySUeNJ9rcgROYdpxDmv93JHWAWtazT/0WTJscacOOT+F8Xy9cUuNrCItvizjYj1RCiRe3WdyQoU5Gac/WLfZ5+qFwftlIGoy/H8P6MG/VSHa+6Er3qscVF21Dxp9ENgl9UQvRtkkHvDzdUgBko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSFsLVjG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSFsLVjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0761F0155A;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=i35NiPZ9XyqWbZPDmlJF5mksq725ThYC0oGPQKHrPlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SSFsLVjGgOl1O1mBihfcGn7Cdm4JztNmHkSJtGMCKk6h++SDJ9qIF90fGWrQrgFQF
	 o4j6dLzOyz8J9PzzO27l/azCYPN2WKF8kiU9+0tEG0s2VaBE+0PfAqg4iMKx2yE/oI
	 v2Bul0qLVNbjTYUXpAO9FrW0OLuvE8v2MsKqLa5/N9T2AnA77x6PxGlwTJF1HYPKns
	 +fQhTxV+hxA1v7i2Y2RnrCeED6QbioMg/2u4nus2MjY/beuwZLIriEMbly0ptBtUvN
	 Sog7bkhO2uwPxVefB/TKXbp3MrOxvKcLHcqbKRreH2JfbujTBQNHFLk8NmBr5X+2tJ
	 YdwVKcPZcuzBQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BC6E4CE1716; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 11/16] rcu: Mark accesses to rdp->rcu_cpu_has_work
Date: Thu, 30 Jul 2026 18:01:48 -0700
Message-Id: <20260731010153.3531313-11-paulmck@kernel.org>
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

Although the rdp->rcu_cpu_has_work field is accessed only by the
corresponding CPU, it can be accessed by both interrupt handlers via
invoke_rcu_core_kthread() and at task level via rcu_cpu_kthread().
This means that we need this_cpu_read() rather than __this_cpu_read(),
this_cpu_write() rather than __this_cpu_write(), and READ_ONCE()
rather than plain C-language loads.  The exception is the boot-time
rcu_spawn_core_kthreads(), which cannot race with kthreads that have
not yet been spawned.

This commit therefore makes it so.

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 390dad82675db5..c9780e7c0e2afa 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2671,7 +2671,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			// reporting, so check time limits for them.
 			if (rdp->rcu_cpu_kthread_status == RCU_KTHREAD_RUNNING &&
 			    rcu_do_batch_check_time(count, tlimit, jlimit_check, jlimit)) {
-				rdp->rcu_cpu_has_work = 1;
+				WRITE_ONCE(rdp->rcu_cpu_has_work, 1);
 				break;
 			}
 		}
@@ -2931,7 +2931,7 @@ static void invoke_rcu_core_kthread(void)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
+	this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
 	t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
 	if (t != NULL && t != current)
 		rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
@@ -2958,7 +2958,7 @@ static void rcu_cpu_kthread_park(unsigned int cpu)
 
 static int rcu_cpu_kthread_should_run(unsigned int cpu)
 {
-	return __this_cpu_read(rcu_data.rcu_cpu_has_work);
+	return this_cpu_read(rcu_data.rcu_cpu_has_work);
 }
 
 /*
@@ -2979,7 +2979,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
 		local_bh_disable();
 		*statusp = RCU_KTHREAD_RUNNING;
 		local_irq_disable();
-		work = *workp;
+		work = READ_ONCE(*workp);
 		WRITE_ONCE(*workp, 0);
 		local_irq_enable();
 		if (work)
-- 
2.40.1

