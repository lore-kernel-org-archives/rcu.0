Received: from mta0.migadu.com (out-79.mta0.migadu.com [91.218.175.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78850B42D
	for <rcu@vger.kernel.org>; Thu, 15 Oct 2026 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057594; cv=none; b=hR4gNlvSUFMeOJ29kp1iMuQjSxzpdJhEnm+ZSzYvw1iCh9t4J0ESmZJqw5PT398NGA2RdiQ1vsJ1FEYNYoWg67CKu68heLYOzNgJI41Ihm5s+kCcbF+NF4O90/xWVIm6dsYIVJ2zvBRIw/vBpDugk1FXjWb4/xcXcC3JciSU+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057594; c=relaxed/simple;
	bh=CdZ25W0JkL0583o4C/tX1C3fgoRAmsQ55nS5t4gIwpk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Y/QnqKx+iyD/W7IDzXCHsDpfEad6vBfHN6N4H8CtJ+FWH79arSzGDtvOackJDOJPdBR2oMM0sZ/1uZah0rm/SQ4potuzMi6xHLkDArAfT+/Zh3ccckWuEVKXdZl+M3/DisKMWggb8YdfPMfuLcyhMV4sZLEurn4kLyHTV4FWvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s+rXmdvg; arc=none smtp.client-ip=91.218.175.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s+rXmdvg"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CdZ25W0JkL0583o4C/tX1C3fgoRAmsQ55nS5t4gIwpk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792057587; v=1; x=1792662387;
 b=s+rXmdvg4lbHA7+8GgQUTDQDSgE5WN2q2NwFxuhr6MXkkSULHgN2K6C/RxIJK0XvhgztiRdT
 tv7YzXqJ21upe6jVx9x2xR74MhnKummCxV3vRu9wsUCS35SR2H+GgUOq38jo0rhkj802C3nli1h
 bXaHo/ZqMBJPezPS4CWv30pI=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 769301db374fa570;
	Thu, 15 Oct 2026 09:46:27 +0000
X-Mizu-Trace-ID: 769301db374fa570
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
Subject: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
Date: Thu, 15 Oct 2026 17:46:19 +0800
Message-Id: <20261015094619.8773-1-qiang.zhang@linux.dev>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The RCU Tasks Rude grace period is implemented by invoking the
schedule_on_each_cpu() with an empty work function, which forces
a context switch on every online CPU and guarantees that all
rude-tasks read-side critical sections have completed. However,
schedule_on_each_cpu() can fail (via alloc_percpu() returning
-ENOMEM) and returns immediately, in which case those context
switches never happen, too-short grace period happen.

This commit therefore wraps the schedule_on_each_cpu() call in
WARN_ONCE() so that this failure is reported as a "Too-short
grace period" warning.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tasks.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fcac7361ec51..91c25717402e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1361,7 +1361,8 @@ static void rcu_tasks_be_rude(struct work_struct *work)
 static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 {
 	rtp->n_ipis += cpumask_weight(cpu_online_mask);
-	schedule_on_each_cpu(rcu_tasks_be_rude);
+	WARN_ONCE(schedule_on_each_cpu(rcu_tasks_be_rude),
+		  "%s: Too-short grace period, OOM is now expected behavior!!!\n", rtp->name);
 }
 
 static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
-- 
2.17.1

