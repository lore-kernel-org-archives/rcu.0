Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D4392C48;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407051; cv=none; b=P39tuicfpu6SUi4Z0zXTziAvskEV6PDC4QKo0dBvArEIk9wAcaCP8TnitQq6ORphubjvVfqeZ4IGmioeKZn9AgOJt6cxEz9PhriAJzS+tX5E7+xisTPsrwAc9sMfRDC9b6s0gO4Uoiz+OIpvcnXtXqzaZzeLX2fI0mwpLS7N1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407051; c=relaxed/simple;
	bh=NJZZDmd5/DjRwi67pNPvxn0iG7rqWhAtG757Fftippg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbrMamfI0wEhUDyTP4WUgVVFmqyPWWIz0VTvtHiVDr0CLrldgyGFL23S8qLQwB9aOOorjVzEJ+jKZauuKWGrr2+hw6DKr7MCA1LPQxrVqZhfrDtOcmX0ATpG8RvUl2Z7DLRgY+oC7foZCUmu1FbQ+DeWsaGnceZ+9jyO1De1pqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtuJP9tu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtuJP9tu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949261F00898;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407049;
	bh=7Qa41V5u9j9ZQLrRsUE9jtEW0kajDdVSHkggXzVTAdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MtuJP9tuzKP7CyQPqEh9NNxoDEkB6eWRefOON/xSLve+MLBap73eqn5i7Ft5YA0aG
	 t95ptX/V+RP36RF28AAbz2kFqB5j7/UPFn5vH9kktBauxVUGDNX74HzHjtLHtC3SMG
	 ZPDvC8AyGcaekLv+TePYgVSzTHXzXlhTuD2Z1ZJV4oG6uT9R/mEUrvDOvW47hK80gC
	 Ou6D03tFmxaks5OmaB9ElF3plZDMQ5TgYk8uJTmyZcQxlhKBp/jk4xdMhwGCt/GvAl
	 ZGH8vxqjxMoXJ8rP1HaApI8uxqMe9ehZbyUCNVeJdES/Wv2FmA6Jbw5TyjQSVLYhDb
	 cGBvestJdk1dQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5296ACE1716; Wed,  7 Oct 2026 14:04:09 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 2/8] rcutorture: Synchronously wait for all rcu_torture_irq() callbacks to complete
Date: Wed,  7 Oct 2026 14:04:02 -0700
Message-Id: <20261007210408.1983713-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
References: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

The rcu_torture_reader() drives RCU readers from interrupt context via
smp_call_function_single(cpu, rcu_torture_irq, NULL, 0) with wait=0, to
runs rcu_torture_irq() on a remote CPU. this is async, nothing waits for
the remote handler to run.

On shutdown, torture_stop_kthread() only waits for each reader kthread to
return, and the reader's timer_delete_sync() only drains its timer. Neither
waits for a rcu_torture_irq() which still pending or executing on a remote
CPU, so it can run after all readers have exited and rcu_torture_cleanup()
has already advanced.

1. rcu_torture_irq() may issue cur_ops->call(rhp, rcu_torture_timer_cb)
   after cur_ops->cb_barrier() has been waiting for all outstanding
   callbacks complete. once the module is unloaded, fires into freed
   module text, a use-after-free happen.

2. rcu_torture_irq() may still be inside rcu_torture_one_read(), holding
   a read-side critical section, when cur_ops->cleanup() tears the flavor
   down (e.g. cleanup_srcu_struct()), triggering an active-reader warning
   or use-after-free of the torn-down structure.

This commit therefore issue a kick_all_cpus_sync() after all readers
kthread have returned and before cur_ops->cb_barrier(), synchronous IPI
round trip to every CPU guarantees that every rcu_torture_irq() which
previously issued by any reader has completed.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 79807475b6724..51ed35f5aab17 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4491,6 +4491,8 @@ rcu_torture_cleanup(void)
 		for (i = 0; i < nrealreaders; i++)
 			torture_stop_kthread(rcu_torture_reader,
 					     reader_tasks[i]);
+		if (irqreader && cur_ops->irq_capable)
+			kick_all_cpus_sync();
 		kfree(reader_tasks);
 		reader_tasks = NULL;
 	}
-- 
2.40.1

