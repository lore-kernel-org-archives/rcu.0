Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531485;
	b=l1Jt4E7Q92Nyw0A+eIKy1/s29PpMhlnyfhMR0Np5ToB9afo0B3yDbgWnm1wfbg2F91Rc
	 54vWGTs1lxCXa6q2Mj8Az5sFVaRJ6hujCqM5z528yJzshUW7BWICTCHX9a71JMfzmX2MQ
	 sJePiofwJpAXR8w+PKYLV8onghHnnQ3rOo6GzXl2trgTankk09EhshpFqkuNwX9PgZZ19
	 +dOhv3neXwomb6icp50UI5gIy+L753QE3B0IkYyXx0z9cWMKfgpmfUmEbO9iECvprnGpz
	 zayVo/olNbT6TcNKWEBrBuyzCfuYdQu8RrCwus09tDZt2Ys+QBl11lQ0bB36pF1BbIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531485;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xyld1PXILNdOVnUWwRdNLd7N3iUxY6JRhxXwGhnH6Ow=;
	b=y3TQzDZ+vWZPqWfCVxodzFzONZNDUF26w8ZpYJbneUlau1cWES/4K03l+goPBNCxtgPL
	 tm6WvGyFiskf4Z7SJXYh4fa+LpSROUx8YnWmFMtTn+fqgGWMcTnkCDi6INrcGKgiGMZVM
	 RZ2nj1qujG/CJvc0q2AbpGubj0Uz2jTcLwJ7AsmVWzG5O7cKQsD0Ws5PU1o21vbmVc9qx
	 xJvzFI6YmglxWETvxoxWgiSJi5SZyVZ2Xfmur/O0YrOtAfteixiu1GOQ8PANGU09GNbmp
	 1vrrWT2tv4F5Xycy4kMSzkRonsQGHJ6o8F7/tZuDz/XDWo7H4BnM7XK5iHR4RnxA9Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAodJmCY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 01D0A60A2623;
	Fri, 13 Nov 2026 00:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAodJmCY
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 832B11F000C4;
	Fri, 13 Nov 2026 00:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531484;
	bh=Xyld1PXILNdOVnUWwRdNLd7N3iUxY6JRhxXwGhnH6Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dAodJmCYmm/sJUOyshNGXuXkl9/yDtrQwArfgZCJA612ol4FrxA4RZ6a1xNBPJ13/
	 bH6MjAkYPqOK8cIPmWSbQ1M65F6Sajna7OZttmW1++I+TnfS2QtZbIR3tnDNX/3j57
	 3+w+irz1HMB34WroKS7fMtjdhx5bAA6suGkgxkXJ61PZ9xVPI2P25J2L9Of3hSV5Bl
	 nsWaS6B3O37NXRxLlaqj4+eFz2UQRbdNP6HDw5pvYA0JwNWr9UxCtg1m2S68cOveqB
	 dxhJ4F+eSvPaeb6iGieDBrgul98wqrLWm8vJDbzknvHfvcf7ip4v1n4P0Ey5yLO2Ac
	 pBE7Pm0GDK9Ww==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Subject: [PATCH for-v7.5 07/14] rcutorture: Avoid create fwd_prog_tasks for tasks-rude and srcu-atomic
Date: Thu, 12 Nov 2026 19:57:34 -0500
Message-ID: <20261113005747.2977123-8-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005747.2977123-1-jfern@kernel.org>
References: <20261113005747.2977123-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

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

Therefore, creating fwd_prog_tasks kthreads is pointless, this commit adds
->call and ->cb_barrier to the forward-progress check, rejecting flavors
that lack the cbflood_max set and a positive ->stall_dur.

simple verification output:

[    3.062959][    T1] srcu-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
[    2.922323][    T1] tasks-rude-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test

Suggested-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20261023093716.25717-1-qiang.zhang@linux.dev
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/rcutorture.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index cbe38aa7ee68..924705b7759d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4007,9 +4007,8 @@ static int __init rcu_torture_fwd_prog_init(void)
 	} else if (fwd_progress < 0) {
 		fwd_progress = nr_cpu_ids;
 	}
-	if ((!cur_ops->sync && !cur_ops->call) ||
-	    (!cur_ops->cbflood_max && (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0)) ||
-	    cur_ops == &rcu_busted_ops) {
+	if (!cur_ops->sync || ((!cur_ops->call || !cur_ops->cb_barrier || !cur_ops->cbflood_max) &&
+	    (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0))) {
 		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test");
 		fwd_progress = 0;
 		return 0;
-- 
2.54.0

