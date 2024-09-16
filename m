Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C914BFBF;
	Mon, 16 Sep 2024 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726527003; cv=none; b=CjM8Asc8btaNJ6pIpp7kWGpWUy42N4ke5z71GCWH6nwUOPszczjaFE771hEry5H+Mc0lzR3gKLBRD0lP5pE2yrGCvV2xis5VAKSUYeB0mWOIKnnKmhETAxkvqivZ7J/ZhcU/xnRjlDSPFeEZEC/nYAK9QvznSrU5lD5GSxXwZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726527003; c=relaxed/simple;
	bh=sbJMoxIqu4qr1nD/+Ksno6FjhK0vmuAI9ZNJjfPGBuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krFASRKusHxneAVQXBwlqsz5HFKTk+er0HdULsTZCiTpP2v2DXnCTn3f/pTEeUTtDtxX1Nm3A3Dx0GsPg93J6WBxPMX/zdJ4zdUaalS1hn7ZIR5UcOp1VN5Dha+OSFINUzy2I433IsMr9MqDNRhzjiF7da3wT/JZlqVz75nbZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRLAXb/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRLAXb/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB21C4CECC;
	Mon, 16 Sep 2024 22:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726527002;
	bh=sbJMoxIqu4qr1nD/+Ksno6FjhK0vmuAI9ZNJjfPGBuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nRLAXb/Qy6nANXMBkUtDMV6bPI7XGa+ARiNyBck4/MFprVyaKt2CssHmWQE0gtmxt
	 qlPRfGIFG2mKyThl6aB/HQrTcLkSeZg9zwzTm+v+Mu6O8hWpCV7eE4E8xZynKD/kfP
	 bb+OHznYw6umYjFoFjztRzkc89/FWva73yWbEBLrVbnzQFJTKH/0MREoqSs6mRgu5l
	 kifMAWClluK9fMjTGYXhWwaqoLZMZIFN/6dVGbsemJacgbqtar1+tnVjPGavfWjBbQ
	 NmJ+9iSLA6lO2ZCl7l8A3RBTZ9KnPoBWRM5U32Ye3nQSFrmE3pcpLnAeX+OOKQhYQk
	 gWH/sCQ25r2Jg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org
Subject: [PATCH 11/19] kthread: Make sure kthread hasn't started while binding it
Date: Tue, 17 Sep 2024 00:49:15 +0200
Message-ID: <20240916224925.20540-12-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916224925.20540-1-frederic@kernel.org>
References: <20240916224925.20540-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure the kthread is sleeping in the schedule_preempt_disabled()
call before calling its handler when kthread_bind[_mask]() is called
on it. This provides a sanity check verifying that the task is not
randomly blocked later at some point within its function handler, in
which case it could be just concurrently awaken, leaving the call to
do_set_cpus_allowed() without any effect until the next voluntary sleep.

Rely on the wake-up ordering to ensure that the newly introduced "started"
field returns the expected value:

    TASK A                                   TASK B
    ------                                   ------
READ kthread->started
wake_up_process(B)
   rq_lock()
   ...
   rq_unlock() // RELEASE
                                           schedule()
                                              rq_lock() // ACQUIRE
                                              // schedule task B
                                              rq_unlock()
                                              WRITE kthread->started

Similarly, writing kthread->started before subsequent voluntary sleeps
will be visible after calling wait_task_inactive() in
__kthread_bind_mask(), reporting potential misuse of the API.

Upcoming patches will make further use of this facility.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index f7be976ff88a..ecb719f54f7a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -53,6 +53,7 @@ struct kthread_create_info
 struct kthread {
 	unsigned long flags;
 	unsigned int cpu;
+	int started;
 	int result;
 	int (*threadfn)(void *);
 	void *data;
@@ -382,6 +383,8 @@ static int kthread(void *_create)
 	schedule_preempt_disabled();
 	preempt_enable();
 
+	self->started = 1;
+
 	ret = -EINTR;
 	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
 		cgroup_kthread_ready();
@@ -540,7 +543,9 @@ static void __kthread_bind(struct task_struct *p, unsigned int cpu, unsigned int
 
 void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
 {
+	struct kthread *kthread = to_kthread(p);
 	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
+	WARN_ON_ONCE(kthread->started);
 }
 
 /**
@@ -554,7 +559,9 @@ void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
  */
 void kthread_bind(struct task_struct *p, unsigned int cpu)
 {
+	struct kthread *kthread = to_kthread(p);
 	__kthread_bind(p, cpu, TASK_UNINTERRUPTIBLE);
+	WARN_ON_ONCE(kthread->started);
 }
 EXPORT_SYMBOL(kthread_bind);
 
-- 
2.46.0

