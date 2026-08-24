Received: from mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41839F184
	for <rcu@vger.kernel.org>; Mon, 24 Aug 2026 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563478; cv=none; b=Q3TNp35VqMcvmbCO1BHyZbIBFnKpkAaTRN4KqbO+pxZl/r9TvI1okU96Goerern/FHJ4WIk4FdB9V6UCNaakMIVuOPyomQ6kcgU6INlK8bicX1UPx94DUa8ltaVKyBYzoI0s09bLomIc/t6VDhJZBq36un60cfvctN+6isFiYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563478; c=relaxed/simple;
	bh=gN0OPYtRwq4PppeYRaGySw2xF295lMVGHlCHp3sUmps=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JtW2QjeUCBZWNOAIE85HM9UO94UWsheqQfM3oRFHYHBnd08j8Gbo8nme1jlBq1l4QclMUZbahvvIeq4NxMlDVbeCtlforwkT2gop0xmTNrgK810QpiSOh6aQuk7WfBwqF4oXurrYWemJXYBokXhaxLRapJgy3wqx5UsPI/ejpbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aMCp5NDI; arc=none smtp.client-ip=91.218.175.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aMCp5NDI"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gN0OPYtRwq4PppeYRaGySw2xF295lMVGHlCHp3sUmps=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787563474; v=1; x=1788168274;
 b=aMCp5NDI5s1AewTYqnGfrHSA6lACufo4eo7rJ9W+VT9rpAfdir6bdzIncWH2B58vi/fJdZB2
 pDk/xGCuCfeWkjeCbzf+FvAYpBv8ou7XQYsd3gPA1/dnD/Sa/OuvcgYvFfsOTeSjNFB7q2Pg5SM
 tTJ0qqNvFZvfz/f7nQYCwQXQ=
X-Envelope-To: rcu@vger.kernel.org
Received: from MSCND1355B05.fareast.nevint.com (117.128.58.94)
	by smtp.migadu.com with ESMTPS id 4840c9236047bcdf;
	Mon, 24 Aug 2026 09:24:34 +0000
X-Mizu-Trace-ID: 4840c9236047bcdf
X-Migadu-Flow: FLOW_OUT
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	urezki@gmail.com,
	boqun@kernel.org
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Synchronously wait for all rcu_torture_irq() callbacks to complete
Date: Mon, 24 Aug 2026 17:24:27 +0800
Message-Id: <20260824092427.31303-1-qiang.zhang@linux.dev>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

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
---
 kernel/rcu/rcutorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4b4d9c70e827..f177ba9cb604 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4476,6 +4476,8 @@ rcu_torture_cleanup(void)
 		for (i = 0; i < nrealreaders; i++)
 			torture_stop_kthread(rcu_torture_reader,
 					     reader_tasks[i]);
+		if (irqreader && cur_ops->irq_capable)
+			kick_all_cpus_sync();
 		kfree(reader_tasks);
 		reader_tasks = NULL;
 	}
-- 
2.17.1

