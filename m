Received: from mta1.migadu.com (out-18.mta1.migadu.com [95.215.58.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587D438BF89
	for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801706; cv=none; b=u9dofNFOitAwN5rKhF+3IW1IWTrDEFZMIJY1yTShqtCB3UDJZDuzc0LYTiFemTIU/KW2HkgRGPpOUQ4T1qnig1i1T5KKMfLdabYEcCLzGPSIoS9TtdQvBefL9UzM/9uJYrAfdWJV/gd3HIYWOWv0c+zYpmzA4MRWun5oYItHxOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801706; c=relaxed/simple;
	bh=o7z/TFALTSJlm+e+II+Xl9VTyQplqTg1c1dDpe0CTRQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bmlrKW5rkyns66Nat9dM6hblYqYJoNx70HmWlPtMYeinsRVvIClpx33hTTX0ZSso6r4NQD/2umLs23UNP/v6QlGRLN1XzqdyJHTChiBAjfVBxcNT4mGTG/nmNKIHk0yGFg3/LV8Lh7qbjQnkd/3z8+wo714fkE5SKFYRy9jU4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wGJqlQqM; arc=none smtp.client-ip=95.215.58.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wGJqlQqM"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=o7z/TFALTSJlm+e+II+Xl9VTyQplqTg1c1dDpe0CTRQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791801702; v=1; x=1792406502;
 b=wGJqlQqMsdZOMq56XaNmrtXIwxLEByk9RdEgwP5EhIe52Tpqp03JM+nZ7C21os3+OVoeCkN2
 Qmr0rRNgrjAtfAkqaJMWr/upSeXUjDgl+gDqmfNHgXbp14kDLvt4R887YW2rF2aZfXSAlgunUN+
 zl3gEV9GauzonXkAl89ziK6o=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7dfb80d8a1407487;
	Mon, 12 Oct 2026 10:41:42 +0000
X-Mizu-Trace-ID: 7dfb80d8a1407487
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
Subject: [PATCH] rcutorture: Clear cbflood_max for tasks-rude and srcu-atomic testing
Date: Mon, 12 Oct 2026 18:41:34 +0800
Message-Id: <20261012104134.16268-1-qiang.zhang@linux.dev>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

When running the tasks-rude and srcu-atomic tests, the fwd_prog_tasks
kthread is created because the default value of fwd_progress is 1.
however, the two RCU flavors not support ->call():

1. tasks-rude: commit b428a9de9bba ("rcutorture: Stop testing RCU Tasks
   Rude asynchronous APIs") removed .call and .cb_barrier from tasks-rude,
   but left the .cbflood_max = 50000.

2. srcu-atomic: srcu_torture_init_forbidden_apis() sets ->call to NULL
   for SRCU_READ_FLAVOR_ATOMIC runs, but leaves ->cbflood_max untouched.

In both cases, the non-zero ->cbflood_max fools the check above into
creating the fwd_prog_tasks kthreads, even though those kthreads cannot
possibly carry out any forward-progress test:

1. The rcu_torture_fwd_prog_cr() returns immediately due to cur_ops->call
   is NULL:

[   68.022674] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
[  129.462046] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
[  190.902123] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
[  252.343809] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0

2. The rcu_torture_fwd_prog_nr() is never even invoked, because its caller
   requires cur_ops->stall_dur, and neither tasks-rude nor srcu-atomic
   provide ->stall_dur (only rcu_ops does).

Therefore, creating fwd_prog_tasks kthreads is pointless, this commit
removes the .cbflood_max from tasks-rude and clears ->cbflood_max in the
srcu_torture_init_forbidden_apis().

simple verification output:

[    3.062959][    T1] srcu-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
[    2.922323][    T1] tasks-rude-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 968343be4e0d..00db87256e78 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -723,6 +723,7 @@ static void srcu_torture_init_forbidden_apis(void)
 	cur_ops->deferred_free = NULL;
 	cur_ops->exp_current = NULL;
 	cur_ops->start_gp_poll = NULL;
+	cur_ops->cbflood_max = 0;
 }
 
 static void srcu_torture_init(void)
@@ -1250,7 +1251,6 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.exp_sync	= synchronize_rcu_tasks_rude,
 	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
 	.get_gp_data	= rcu_tasks_rude_get_gp_data,
-	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.name		= "tasks-rude"
 };
-- 
2.17.1

