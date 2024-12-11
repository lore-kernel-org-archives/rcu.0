Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA81D9324;
	Wed, 11 Dec 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931670; cv=none; b=du1+jnVPEjq32iLsnHw/amG0fdh1Z9/vWfAf0M1aITM445y6KGanldD2OFwV/UiRHCGx/llSHhNXmB79+6Hh/OzfuXSd9YjgEDnCYfOayD03dTimZAW+xWBt8DtT8dfU09G3aaav3uySCNg5BJI9vvMW1Dvboo2q/leR5jDcjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931670; c=relaxed/simple;
	bh=2qfuTV6k+A8iDq1teARtVDQzBAoKchz+tMTAsMIX4+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulQ6XivRSLUaXIJ+tUvPgJ1/Y6y9/Adii24ftExPq2ZY1kmLwLOYSylX7jftN2JiB4R0LE8tlnAXL+xZ2/uxXM9qh0M6iYO4wMexYntrSyrgf670rfZPPS3wUSxGYf8Nt9peJYsBDUxb07H2JTVt2jgSlBgwbNgApLP0lee3UVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc7sYBQH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc7sYBQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DA0C4CEDD;
	Wed, 11 Dec 2024 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931669;
	bh=2qfuTV6k+A8iDq1teARtVDQzBAoKchz+tMTAsMIX4+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nc7sYBQHWsneHm+RDymrniaj4mitPN7j7ea2YdKP9niGyvkp1gXpfHct8rHMa0YrG
	 f6feb1+HULCsQIuaNNjRvMFIisKqI5UDVEynQ6L5LQorZ7Z4wG2lAGhay7NKO1y+cZ
	 aGyNBpPV21LSFM/FPM+6Itrf7nXwHXtZoCi83bikfpV03LmnrcEb+3dQhBHJ9DVuOq
	 F/EcAj7YWWA1devSxAGgVuSlW7rRIm4sjiHDLig0WcerfXUSeH/wrXyX9k3PN5c6Xb
	 +6R/3najAYR04xWmYNvgUQ6yrWiHnlSeTdr+8FYOUhYju18hmYs9M/HtOtrTv8Z8Ck
	 1kcjrlunevEMA==
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
	rcu@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 11/19] kthread: Make sure kthread hasn't started while binding it
Date: Wed, 11 Dec 2024 16:40:24 +0100
Message-ID: <20241211154035.75565-12-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211154035.75565-1-frederic@kernel.org>
References: <20241211154035.75565-1-frederic@kernel.org>
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
index a5ac612b1609..b6f9ce475a4f 100644
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

