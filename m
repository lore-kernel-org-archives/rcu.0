Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34832C0266
	for <rcu@vger.kernel.org>; Mon,  5 Jan 2026 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767576018; cv=none; b=jhW315KeSPFtkpi/8yY2wdj+fhIXLbX4xR1bzrN3w/elvhLNV7jCw6ScSLHVsbTTSRB/2fEo58F8OGYHGbcknaZ3yDYzGhIcWRT+jgFiZV+DYQEZZiE56HvQZmlDI7bnAD7a96OivRlb4Ola1fMDuSjfhNOTWMsBNAD1nC9+Nqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767576018; c=relaxed/simple;
	bh=b6l8a/iMJYWmldzUOgYP2j4jNyeOs7QF6piJUoO0AOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGhh0FgFepD3+olENI31FkVsYZds6DqsQeBPeU2CzLi9PMGJXP/fKOzD09AFgQxSKybllz/dxvrz4Tv0+NEKt29ZPI5l8Zd0TanOv/Di944O4jDtZi2Wp+e/z3UqmMyQyJfJEDvHU8ihkQksL4MSCc75d9nibqyBiPc0F/DglcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C2V0xzew; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C2V0xzew"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767576004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hkXbRJGyzWyTXZ/Ax20zBbaZfS6DAdE3EuRxMdkie9s=;
	b=C2V0xzewN+fzZ1+Y2QXRGHrTxMRX3wVtllxfI08yyoOPQjuE3vkZO9Z7oDGoHoprVO1GKV
	ke459M1pvUFieIsC7yZ3NvjiX6brQmtTIJ3Warl4+DK2nKHQrxOi3kv70fw5A3ovoyNJhu
	ZH/stlMCosTZEtPFeUMfsop3PPxB85M=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun.feng@gmail.com,
	urezki@gmail.com
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu-tasks: Remove unnecessary smp_store_release() in cblist_init_generic()
Date: Mon,  5 Jan 2026 09:19:51 +0800
Message-ID: <20260105011951.72850-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The cblist_init_generic() is executed during the CPU early boot
phase due to commit:30ef09635b9e ("rcu-tasks: Initialize callback
lists at rcu_init() time"), at this time, only one boot CPU is
online and the irq is disabled. this commit therefore use routine
assignment replace of smp_store_release() and WRITE_ONCE() in the
cblist_init_generic().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tasks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 76f952196a29..c736900317cd 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -290,9 +290,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	shift = ilog2(rcu_task_cpu_ids / lim);
 	if (((rcu_task_cpu_ids - 1) >> shift) >= lim)
 		shift++;
-	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
-	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
-	smp_store_release(&rtp->percpu_enqueue_lim, lim);
+	rtp->percpu_enqueue_shift = shift;
+	rtp->percpu_dequeue_lim = lim;
+	rtp->percpu_enqueue_lim = lim;
 
 	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
 			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
-- 
2.48.1

