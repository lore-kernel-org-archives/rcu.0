Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972532003DB;
	Tue, 12 Nov 2024 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421410; cv=none; b=blHpjR1FJreRGQws3gN3ZVnZP4+g4PG1RrCXJI8S09f1JwA+K6mvtk5FlU0rIFcOemcmjz/f6TARYBUiJ4JbgH3ADecowbHUJC2HB4jA00XmugjB7gfLWo//66RPF+z7h4t91qYqMPCTKOXvoFFVz7o94CjF5aIfbzShema1nWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421410; c=relaxed/simple;
	bh=1Mtlm//q48SrsPqs3+PH5LEw1zSw/x3ZR0//41DWXT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flY/InRaWfZtuzxFeMTySS8iJl+mRx7iWXTeZVudaqbpwCg975/XgvPTYU7eLIV5yavSjO5/ZCMP/566OzVW5XnIttIIfnecNA631/icB7rmNoQOnwMsWwcB/b7VXRqB4fbR2pD0M+lZ7ACyX/k+k0Io3U+ss9aLRzd0Ea9pFNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX6I+zoH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX6I+zoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BFCC4CECD;
	Tue, 12 Nov 2024 14:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421410;
	bh=1Mtlm//q48SrsPqs3+PH5LEw1zSw/x3ZR0//41DWXT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bX6I+zoHIDtpnApj8lTc4/kUq9/Avb5U6PIJXGr6R7ZH+w5tkNcKKlu21bICUDGN/
	 vayr3D5njBiqePvwXiwHyfN3kXc06v69j6prrZAqfNIOoSrm+C+z3Q4pL4M9q7C9uS
	 wuZcO0UGrrDCK82FPd8TKMDwRf9wA/+UEHiQzK67WXEbvJsJe0NzgqK9g5y85trGjw
	 1q7fRsyVwt8VkR8OxvGOhleSa7Ia/nqon3h/KDe5lg2kCq7+DLI23O2etxWOwsasvC
	 OoogZcMGZcCTjUSo3xgRwG4+kM9yXk8NPYiZZoznEPGulBno+uw9HmRgV70VCAv/Ql
	 rD/v3aloGzdYQ==
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
Subject: [PATCH 13/21] kthread: Make sure kthread hasn't started while binding it
Date: Tue, 12 Nov 2024 15:22:37 +0100
Message-ID: <20241112142248.20503-14-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112142248.20503-1-frederic@kernel.org>
References: <20241112142248.20503-1-frederic@kernel.org>
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
index 9bb36897b6c6..b9bdb21a0101 100644
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

