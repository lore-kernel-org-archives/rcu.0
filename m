Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CED7296BBC;
	Fri, 31 Jul 2026 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460042; cv=none; b=mhLuQ7ZD0wRXTDB1F/uwW5YgFOHtDZpaQ/ipUOjdJKoNI1M6Y1/IqcwjitrKBjFq9KXEEpr6TXXAX+caQgMra2NXmwfFo3EBtStMB1E8lvSne9x1IkNeEPTH4yf45SX0uR8QrMGTAfUT6Y4jgosQmWvM9jIqFCiJb0ASclqg/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460042; c=relaxed/simple;
	bh=3R8aGYzkk/uM0PbI/o6NiYQYmtGJPCPqYbjhnWJiz9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glfcGD90BGRoET9mkV9FdRfzXQjwTN8BkHRQv4p9BddIrMN0SbCTGiMnjGRA6Fzkem5phwhylA+4s4cWA5lyN0HPQT0i6nqnXXThwdLbN5DIl2+LErOkeGrJn1A60cgdR9yA/4t8rW+0/GYQkuR6ewgXVyflIn77i5o+iTX1jWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpsZ1Dqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpsZ1Dqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1741F00A3F;
	Fri, 31 Jul 2026 01:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460040;
	bh=uqdvTmsUSEWVM9IhycVYdv31MiIfuOccNwUTeW+f2PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hpsZ1Dqil+wecMDzNVh+bYuMQCNzPNKNxwyuFC2VcXoZowF/ABKsEcDUlLYq46TjO
	 b/JAuzFjpFpntUXp6afcsboJLWMsJk+dleM9OGM7gcgqxABXl5D63ltryHFhs6PjlO
	 WBpVxINP1RUrgoH37kN2duQn90p6Vwn7baroM4tq5HUPdiLE3e1T+ZFkCDAo7P179T
	 kq7lznaJ96X0QP6Myk3SzddPSZZ5ub53dnuW+Wo7CsgJuB5A+uYTzLKTa1kVe+SZRa
	 YsiU2YXI96EMRriNiKEN8//jpHbO+LAZJJ2nEgDcYVWs50jp3v7sIY8LsYdszE/4tR
	 PZOzhIfDF7GYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8A708CE0F82; Thu, 30 Jul 2026 18:07:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 04/13] rcutorture: Use cpumask_next_wrap() in rcu_torture_preempt()
Date: Thu, 30 Jul 2026 18:07:10 -0700
Message-Id: <20260731010719.3531912-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
References: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_torture_preempt() function uses cpumask_next(), and if that
returns an out-of-bounds result, re-invokes cpumask_next() on -1.
Which is exactly what cpumask_next_wrap() does.  This commit therefore
saves a couple of lines by instead using cpumask_next_wrap().

This was reported by metacode when asked to look for opportunities
to use cpumask_next_wrap() in kernel/rcu.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 57cae3fe23fdca..afd5045263be36 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4183,9 +4183,7 @@ static int rcu_torture_preempt(void *unused)
 		// Wait for preempt_interval ms with up to 100us fuzz.
 		torture_hrtimeout_ms(preempt_interval, 100, &rand);
 		// Select online CPU.
-		cpu = cpumask_next(cpu, cpu_online_mask);
-		if (cpu >= nr_cpu_ids)
-			cpu = cpumask_next(-1, cpu_online_mask);
+		cpu = cpumask_next_wrap(cpu, cpu_online_mask);
 		WARN_ON_ONCE(cpu >= nr_cpu_ids);
 		// Move to that CPU, if can't do so, retry later.
 		if (torture_sched_setaffinity(current->pid, cpumask_of(cpu), false))
-- 
2.40.1

