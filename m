Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531480;
	b=J8RgcBqhn/jhkAOFUKdLtdKz95rEjR4fcAN+jrUTc8XDj05zGdH6NlFX9NK96I4UNCyX
	 uSvXqrMFoZEHE5CVUsDqIt/GOL73sZuHiN32PuVCT2uFtyjTZgeVC5SSJQioDVLE02jdi
	 oppeOB/CHMe8vHvdwd+hbwOprCEhxYzFrJBJ8jczYqvu4UZKQ7BJCs1VnbUzQ4s6GYNmz
	 qf6gIlmh2noNHJP3AVd+3IpJRqk/CIjYYwY4furTl0t1tcXxvcRf1qk49YJNZZGak4FMt
	 GMNsbGKubmxBMXL3HQlCcQY8wonC49g+JYmFF9czuEmEDnRt1rJwt5j8UyC2aUujZvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bI+P9eu3oNiojT6bm9h/aMCHW0G1BPXS5GriVMNV+ic=;
	b=kqTToUaIT0ALjW2P5T83uAmD7pjjYCxT/B3Pg7nr7jtfnZmascsJmQ9whoqSF8IVnJq+
	 DOZvwdQc5TMjQ2861/MfvyCp9BOp304klIKjh6lMowKcPktc5mw0hACguRg4vYGz2fX5C
	 hiu58IhF2z2XVgVcHbZfdYcWnp/cEvCDxsPZHaX7Hzdth7YXLjDN++FBJ1fa+wzqxS2zP
	 XWEqVO7jQQoaAki70UeBE1hi1YsCSz6RooJzOcPvmdggj6GRy45AZTFwKDmLyupk0mlN7
	 Ym5hMwG72g5v9adGKuGrvg0WMBiufn+oEl7wQ1iMFb9ZPU/0iFFrl9Ya/YXsR1lLB/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSnGt324;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6A2E1606A8B9;
	Fri, 13 Nov 2026 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSnGt324
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A7E951F000CE;
	Fri, 13 Nov 2026 00:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531480;
	bh=bI+P9eu3oNiojT6bm9h/aMCHW0G1BPXS5GriVMNV+ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KSnGt324bhPaCnE/6f8LT/N6U2xPNsr7T6Fpf9rojxiRWY8kmnqIr+Tz1D1MIcxwe
	 LhLH0tb6TqmmW/c9mr2ZZUfXDk0ceCyeba4olFZNHJYK9atSynvEe+3FbAHy/oqk8l
	 OlluOXSsp/uN0JU7KweSck/rDpmAZQUfCtsToe4x6xnlYpT36NtJS4fmjNKoUmVZHn
	 sUFrYJ+HGgqizzhBB94cjsLnf1Fv6POzKkVw0hFvwC8uAW6jSTxmIn1C/blqExsUeS
	 K2yxcvQaIKlm83/Gs4vdPo61HC6R/sMSjyeqGgT1zR7LwuxPxIVeY4hRqsbcLA/ExI
	 mNY6PvXnWRksA==
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
Cc: rcu@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH for-v7.5 05/14] rcutorture: Fix suspicious rcu_dereference_check() usage for trivial-preempt
Date: Thu, 12 Nov 2026 19:57:32 -0500
Message-ID: <20261113005747.2977123-6-jfern@kernel.org>
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

Running the trivial-preempt flavor triggers a lockdep "suspicious RCU
usage" warning from rcu_torture_one_read_start():

WARNING: suspicious RCU usage
kernel/rcu/rcutorture.c:2581 suspicious rcu_dereference_check() usage!
...
lockdep_rcu_suspicious
rcu_torture_one_read_start
rcu_torture_one_read
rcu_torture_reader

The trivial-preempt flavor .readlock_held is set to torture_readlock_not_held(),
which check RCU-bh/RCU-sched critical sections. however, it's read lock
just increments current->rcu_trivial_preempt_nesting, it's not also RCU
read critical sections. the rcu_dereference_check() condition is therefore
false, and lockdep report warnings. this commit therefore drop .readlock_held
callback to avoid this lockdep warnings.

Fixes: c6f4e552e1ea ("rcutorture: Add a textbook-style trivial preemptible RCU")
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20261020094907.15781-1-qiang.zhang@linux.dev
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/rcutorture.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index e88573b9b7c6..d60d17d14f1c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1164,7 +1164,6 @@ static struct rcu_torture_ops trivial_preempt_ops = {
 	.readlock	= rcu_torture_read_lock_trivial_preempt,
 	.read_delay	= rcu_read_delay,  // just reuse rcu's version.
 	.readunlock	= rcu_torture_read_unlock_trivial_preempt,
-	.readlock_held	= torture_readlock_not_held,
 	.get_gp_seq	= rcu_no_completed,
 	.sync		= synchronize_rcu_trivial_preempt,
 	.exp_sync	= synchronize_rcu_trivial_preempt,
-- 
2.54.0

