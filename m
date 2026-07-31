Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD945286A4;
	Fri, 31 Jul 2026 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459120; cv=none; b=VL7nPOf8NUHm9pVZG6Hlw4vsVWh+WWXKHLL9ufKg/+Jbc5RccPNqnEDcCa5UwqUrOJhkwTw8fBa8VjtbgTg/YfE5mDGR7Hxjg12THOIZNgummSf4FFWEMdsekq6Z4rSLcmX2Qv3eUbGk2zqF6ECBT+FgjygL4tqbflxEoT8V0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459120; c=relaxed/simple;
	bh=ZQWPJOpmRcID11QkMDJtL+JV0uxTB31dm3AeHQZ91WY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jC+xm9JlMqZTdG0S6LIuT33mSzB4JFLJXXcy+1bnxpALUqeJvf6M1DKK439AO8zsSsFZ1vBdbc/NDrZxmB1BzH+nemsNlmphTEk3cvBpr5NYXStkW2l+Wyx6LMFJ+LN5HQjri6EErnak+VLSc1zDpqgIEoSyfqGOAl/feakjfJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW4+sN8s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW4+sN8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845E71F00A3A;
	Fri, 31 Jul 2026 00:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459119;
	bh=nvQjZfeNaWhc5NclQXX2xuYSBe+ir8o8wRnE8VvuDDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YW4+sN8sYgSRSHn5T+f48vy5Iqv9ZEQ/iP0FSTaMWycatzwHHGuxMtNkq9jmHtxfh
	 EweCLzj2Im8aBk8mnQ+dXAXeHguvBZHrZqoYsLp3gvC+z38kS/uwjprlzGqBuJSTz8
	 Pa2UUMUwsHyMhqlaCdVqb6b4JUcq57oTtKUPfewn+BSOM+X9m8NfmP6lAdI/yp/SX4
	 9e/gZAC6ejIT+l9WLXzkLt0A40KuJVtSVtS8Vnbb5cxnA5cj2rmp6nNJvkr9PsPA7P
	 Wc4lV25pyPMv6RtYuGaN/CkLkw7okkMMAH81eNxALrn1vI6yU/k+XTGlZtYt9zD21w
	 z5I5gOWja5oZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4BDC3CE0F6A; Thu, 30 Jul 2026 17:51:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 2/2] scftorture: Make invoker threads actually wait for all threads to start
Date: Thu, 30 Jul 2026 17:51:58 -0700
Message-Id: <20260731005158.3530675-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d470e612-b88a-4916-a1b9-1a6e8e6f968b@paulmck-laptop>
References: <d470e612-b88a-4916-a1b9-1a6e8e6f968b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joel Fernandes <joelagnelf@nvidia.com>

Each scftorture_invoker() thread decrements n_started, which is
initialized to the number of threads, and is then supposed to wait
until all of its siblings have also checked in before starting the
test proper.  However, the wait loop is guarded by
!atomic_dec_return(&n_started), which is true only for the final
thread to arrive, and by then n_started is already zero, so the
final thread does not wait either.  The side-effect (possibly positive)
is that no thread ever waits and the start-synchronization barrier is
dead code, with early threads beginning to hammer smp_call_function*()
while later threads are still being spawned.

Invert the test so that every thread other than the last spins until
n_started reaches zero, making the threads start testing together as
intended.  The existing torture_must_stop() check in the wait loop
continues to bound the wait during shutdown.

We can also drop the spinning entirely if the intent is to leave it as
dead code, however for the current intent, this patches fixes the code.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index ffd6c83732ee74..392df1b4d4eda2 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -497,7 +497,7 @@ static int scftorture_invoker(void *arg)
 		  "%s: Wanted CPU %d, running on %d, nr_cpu_ids = %d\n",
 		  __func__, scfp->cpu, curcpu, nr_cpu_ids);
 
-	if (!atomic_dec_return(&n_started))
+	if (atomic_dec_return(&n_started))
 		while (atomic_read_acquire(&n_started)) {
 			if (torture_must_stop()) {
 				VERBOSE_SCFTORTOUT("scftorture_invoker %d ended before starting", scfp->cpu);
-- 
2.40.1

