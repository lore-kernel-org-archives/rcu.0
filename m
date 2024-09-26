Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB681B29A8;
	Thu, 26 Sep 2024 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390985; cv=none; b=qXBpLTWZjsluDtnYzBlZJVV+s0U9DneO9hKX0uw1i2r4yCAQ1OY//Jmfhk7YYoCA83lz2fw9jMfBtheqMgMFkPTsg7pqgupM7H3N0mGF4tWGO55ZmHUU5BP7ejsDgeoAIGod9CKCBMNXys7bsWrhOhrrkbaeSj5UDWef2k8Qxtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390985; c=relaxed/simple;
	bh=OmLFF6xgwbA0hM9UsQOF4k2zgh/bcASGVcZgCAmI/wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WV2HmF3chBd5bVr9wKLAcGxp3F9mvkN9g3AoQuVucfaF5whkM7+lhPar5WBQw3Sg6YJ9l4HEZvIkMVzKZfDOZr2cZLAGbxQRO5fzXsj2eu9jz4WNYbubGCfVogSlzKwtgayWQPUh9twNECQJfUZXxme2cQahLRpGrxR8m5DHMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZybb+rL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZybb+rL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BFEC4CECE;
	Thu, 26 Sep 2024 22:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390985;
	bh=OmLFF6xgwbA0hM9UsQOF4k2zgh/bcASGVcZgCAmI/wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZybb+rLGew6y4q8nSczjj8DHRzJC7OPnSggLAYdW0ADMoiewKcozZLiLAW5sPq4b
	 z/w7b2NScoCYFn5Y/Vu1k0LnkOv267r9y6sguOW4Nv2aO4I7KXAEGOqyeRdLQChUMM
	 4cTaoClZ1K67txUjJeVPMY4Il+eDer2maAH5KqQoz0Z9Yw9rGHdsmUmNnXCXQE0T10
	 MCioZOjqH18cVl7ms8sVxuKS31EpXnLgg1Dlb0+4pwj9q3OZxhffnGHGs/ou8q3fwC
	 YN471CMyZJ3Ua5hJe27BPWBvBRj3fkTtvgx7DdcqZcLHY6H98mFfFSQVAxEosOWDlo
	 CNXTOM4e0Ln8Q==
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
Subject: [PATCH 12/20] kthread: Make sure kthread hasn't started while binding it
Date: Fri, 27 Sep 2024 00:49:00 +0200
Message-ID: <20240926224910.11106-13-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926224910.11106-1-frederic@kernel.org>
References: <20240926224910.11106-1-frederic@kernel.org>
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
index db4ceb0f503c..1527a522cdd3 100644
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

