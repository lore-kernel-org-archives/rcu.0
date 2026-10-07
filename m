Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DE3EFFC9;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405915; cv=none; b=EogTvanod+xVDjH0bkOduG9WeFsMvUTuY5sMWDRC3VWRrkq9XVedM0Bek7YDG6yPoWzkgwpjafsDBw43tEEgmrS6Lq7GsXZAHj6j6b+NH0ge86Cplk2H+E58baQPX1JkueJthSIXdIoHitnSjONJ/Zamz7nnqfHCsXsW6jzPm4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405915; c=relaxed/simple;
	bh=BYZMJyO/+mj3bePILNqEL4iPB++fzFXIP/7p8MXrsns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QoHBh/Rn/oEo0RLXJAXDxkXdnKTQbqHCKSXW0nM3DY84Y36FHJzU+6FKPmzBHLVf0O1wFKd+5TOBqOwnCr4vgpis3k4KFEpppb+P5brfezfjKEzA7YJQazjzo8eafiIG0YMZJzFSVuxPQ6ga5NbgtTytteNYELnGqsT5F8Tc8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqnJbMxd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqnJbMxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824971F00898;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405913;
	bh=JU5z0TM0EOoGd+7UOEnpGgtmwUn17x1HpqFrPRnvV4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eqnJbMxdZIDSm4SlUyl2i3P3CPQYQBJWn+3SbEAyXVbw6dreC1aSz/PlF6/n5HoAA
	 LHt1/08a2VWa9H/LeuYSbLF4Umsogj1lyp0qSFTV9RX4A0BT7dPg38ENos8MtakNeT
	 ptF6p7zYg/U6DplTuGN1cHhgxYv0N78TjCq934Wn+yZBCF6uZ2b8ZSWpLOKmVohJbN
	 DTCCAjvR9gpgl4r0sMG0fodHDTnjWL+kbUliAqhlgsZBeoyPJBiuc+W/8/q+qLiOyo
	 +cmu/xhTC5ewKkB5jXg4ZVL8PfgKlMQou+0hJ/J5Z7BDL7CWCTGNXLvd7lVRYjmBlU
	 yP+yc5JLkNSfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2946ECE1735; Wed,  7 Oct 2026 13:45:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 03/10] rcu: Don't panic on already-ended RCU CPU stalls
Date: Wed,  7 Oct 2026 13:45:04 -0700
Message-Id: <20261007204511.1982646-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
References: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current RCU CPU stall-warning code can say "INFO: Stall ended before
state dump start" but then panic the system anyway.  This commit therefore
avoids panicking the system if the stall has already ended.

However, the sched_ext scheduler will still be ejected, as it might have
been the cause of the almost stall.  This can easily be changed if needed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h   |  2 +-
 kernel/rcu/tree_stall.h | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 81d42b6e2e312..01bdbd7e28cca 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -678,7 +678,7 @@ static void synchronize_rcu_expedited_wait(void)
 
 		nbcon_cpu_emergency_exit();
 
-		panic_on_rcu_stall(&rcu_exp_stall_cpumask);
+		panic_on_rcu_stall(&rcu_exp_stall_cpumask, NULL, 0);
 	}
 }
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 091e7850ab6ec..93ba31a619b67 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -159,7 +159,8 @@ static int __init check_cpu_stall_init(void)
 early_initcall(check_cpu_stall_init);
 
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
-static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
+static void panic_on_rcu_stall(const struct cpumask *stalled_mask,
+			       unsigned long *gsp, unsigned long gp_seq)
 {
 	static int cpu_stall;
 
@@ -170,6 +171,11 @@ static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
 	if (scx_rcu_cpu_stall(stalled_mask))
 		return;
 
+	if (gsp && rcu_seq_current(gsp) != gp_seq) {
+		pr_err("INFO: Stall ended before panic check.\n");
+		return;
+	}
+
 	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
 		return;
 
@@ -703,7 +709,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	nbcon_cpu_emergency_exit();
 
-	panic_on_rcu_stall(&rcu_stall_cpumask);
+	panic_on_rcu_stall(&rcu_stall_cpumask, &rcu_state.gp_seq, gp_seq);
 
 	rcu_force_quiescent_state();  /* Kick them all. */
 }
@@ -758,7 +764,7 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	cpumask_clear(&rcu_stall_cpumask);
 	cpumask_set_cpu(smp_processor_id(), &rcu_stall_cpumask);
-	panic_on_rcu_stall(&rcu_stall_cpumask);
+	panic_on_rcu_stall(&rcu_stall_cpumask, &rcu_state.gp_seq, gp_seq);
 
 	/*
 	 * Attempt to revive the RCU machinery by forcing a context switch.
-- 
2.40.1

