Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6621A95D
	for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765680566; cv=none; b=gDTBaKInisL6Tv0wks5d4hUoz8CQr2BG5R+Vefss0o4kD13tqADlRCRXHAR95MQ4BUZDadoYSFvnYC0MLhA0VKVDLCqIvrF/WqnycWW0AFHPK3svi8dMu5s5Y2BiRTWOYvYg3F84NUtrO92MED97nMrfjXfYXRqAZC1vMs8K6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765680566; c=relaxed/simple;
	bh=+UwIofhmHL1RAft0v3Y9bVCRINE8k6LLJVLO4irIZ+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yp/+at3JgF11LRUhf4CKc4CuTj8eTEsB55isFHV+mI3qZo75KNBs+pV8tBaXYrP2F0ORpVJF0o1gCzR96Gf1teK+pryv0UJFuaZNffb4LMcZgZzuklocg6UDlC7S/C1P1PQUeox7ogL1Qn+Zi7762Z/yyS3IPq+V6CVGOJHcmHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QEGt8PaN; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QEGt8PaN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765680552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CwNw39WHVZ+GJ9tDzkergSUTwBcBVdRSA9NWvySAY7I=;
	b=QEGt8PaNU01P2R5eRWUXiFlTLB12ZsAUOEbMfWq0wjl/7rxGqxKxq0Ke0fTR+Sin4a6mp0
	wVkIdAmC85CcyBf3FbCyfmJgAU0FxEJFG8PfL5kObWax3MykVN8iSzMmnhRnbiXbjGy7f0
	pJ3i9JJwVZxGlAswW55QmPS/u8Aa2Vo=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] rcu-tasks: Remove unnecessary smp_store operations in the cblist_init_generic()
Date: Sun, 14 Dec 2025 10:49:04 +0800
Message-ID: <20251214024904.121128-1-qiang.zhang@linux.dev>
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
online. this commit therefore use WRITE_ONCE() to replace the
smp_store_release() to assigning rtp->percpu_enqueue_lim in the
cblist_init_generic().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 76f952196a29..f763f60d5e50 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -292,7 +292,7 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		shift++;
 	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
 	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
-	smp_store_release(&rtp->percpu_enqueue_lim, lim);
+	WRITE_ONCE(rtp->percpu_enqueue_lim, lim);
 
 	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
 			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
-- 
2.48.1

