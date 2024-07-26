Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668DD14D2BD;
	Fri, 26 Jul 2024 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031054; cv=none; b=kniBiYlzvlHUq7IOdPVAHbkAq14Sa2rKlJHVt9nQHsJS8uv8DfW+p3dkxAjV6lIpegh+oWk4CirXVPs/PtK77YDje2nuAzCyeeeU5A6L8JLHK8LH7z4zjV6FFcQpL9R0mRFceNICcTeqbZNA5VsSLPhD0eN/sflfYcxj3zmkmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031054; c=relaxed/simple;
	bh=MUWUbgWSkKV4GLdom7VkftM4X5LXDstggWbHIa2p29w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaDKGwUfCBNHlSV20+AUzOmUVZpwRHY8pV+D4myE+REKDc3pvJqaXBhthyamNNSHdUGzBT47Lhl7YXWTFJPw0C8SGNu4vjOKxjVAAaHMa7+cxbuc3r7kWCEZC/zxYR/+Z2Zz41uqg88Z1zvvr0cgJeVneD/aw7YQXZkVDTMMbBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWmrsooC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWmrsooC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FDDC4AF09;
	Fri, 26 Jul 2024 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031053;
	bh=MUWUbgWSkKV4GLdom7VkftM4X5LXDstggWbHIa2p29w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWmrsooCdYxUdk/aCUzDpll4gueCMQsfkinYrKzAWc1v/GAaIsHjE3rm8GWfqufpy
	 gKRyDSNOjiXVu5BGliAyGQJhFUrk1RQuDB0kNKtBzDasPdPZvrIqiCgBy2WKWw0dXy
	 zwLgigU+SitEoGE7TrTGk6i+9RF0xdScyWgbLzJH5VQihFensb8LOZ/Astq125xDGo
	 bUggEcJQVzgvcNRlDFR4LEap94c9Tg6FMyRYZqG70PLQLhhXB7cvyZa2XUx1ECWnPF
	 KMrNN2lDQKT3EJi/PW5+2xQjAbSKxLd7az60jjUo0uD2e8O5hDCpQPdjuMG827Vb1O
	 aQ0djG1ROPjcg==
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
Subject: [RFC PATCH 11/20] kthread: Make sure kthread hasn't started while binding it
Date: Fri, 26 Jul 2024 23:56:47 +0200
Message-ID: <20240726215701.19459-12-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726215701.19459-1-frederic@kernel.org>
References: <20240726215701.19459-1-frederic@kernel.org>
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
2.45.2

