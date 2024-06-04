Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46B14C5BA;
	Tue,  4 Jun 2024 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539837; cv=none; b=QscyFfmwZiliLB1ukdcFYq945D6b7xv6CSVm2ztytL+A7N8gb5kAXo3aZ6tF7UwPqBvE9P6SXdyL2yuaMPAT6ZuRmsURfEPO2FJ8QbUttGZNnLdB/fv3OJPbOKXg3/9qTrmWfbaHfi2hipruYQ4wC998/OL9DDASIUZ6eCDANE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539837; c=relaxed/simple;
	bh=Mr0jgnXrW9nLakafqNopRYzxiUW6MmdPijZgfPRpq7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmsjppLI5Mq0SQu52mleQH+AuFCpqmvKHJ0sFYewJezFrmYP+3KnW0Nw4p7lTEIMJvm3Sx2g3Xa5zokrp9TEwMaP4qEOhXBXq166hDmXfjS1YMmIMT+CNS01tWI0/1w0Qgm+Opxw/OvtQvzbM1PHb/BCk+Z3qTUkvssTc5J7o+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7EL/eN1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7EL/eN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C78C4AF0F;
	Tue,  4 Jun 2024 22:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539837;
	bh=Mr0jgnXrW9nLakafqNopRYzxiUW6MmdPijZgfPRpq7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7EL/eN1SHfNEkXECubtVnDDCJtiDSOesBLMbda4eaJenNyPOBOZW+dZ/RsThju5i
	 lmHgj0eZddck8K7R13yuNIfmjLrbD7+geOzHmyQdZFXpMD2k4zPkALiG3bPBsDUb5N
	 zJYlTCELaZTimBbStA8G9cznf/a9jllb9gwDfkwIX4opsRsVuAxKBLMLHtRt9vQ4EB
	 rrMPVBqT23skMVg+9fBlO+AfrBmdIh31tDvgCymnOE7VTXirr9cqLqOxFHQ5WURalQ
	 XNukyjTTkXivfjLnV9+4UkxycIl9rBTD15FGv5AZIsN3rRNMP5IfMminSqSzUJHRld
	 OqMZH0CWowTeg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 67235CE3F30; Tue,  4 Jun 2024 15:23:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH rcu 6/9] rcu: Add rcutree.nocb_patience_delay to reduce nohz_full OS jitter
Date: Tue,  4 Jun 2024 15:23:52 -0700
Message-Id: <20240604222355.2370768-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a CPU is running either a userspace application or a guest OS in
nohz_full mode, it is possible for a system call to occur just as an
RCU grace period is starting.  If that CPU also has the scheduling-clock
tick enabled for any reason (such as a second runnable task), and if the
system was booted with rcutree.use_softirq=0, then RCU can add insult to
injury by awakening that CPU's rcuc kthread, resulting in yet another
task and yet more OS jitter due to switching to that task, running it,
and switching back.

In addition, in the common case where that system call is not of
excessively long duration, awakening the rcuc task is pointless.
This pointlessness is due to the fact that the CPU will enter an extended
quiescent state upon returning to the userspace application or guest OS.
In this case, the rcuc kthread cannot do anything that the main RCU
grace-period kthread cannot do on its behalf, at least if it is given
a few additional milliseconds (for example, given the time duration
specified by rcutree.jiffies_till_first_fqs, give or take scheduling
delays).

This commit therefore adds a rcutree.nocb_patience_delay kernel boot
parameter that specifies the grace period age (in milliseconds)
before which RCU will refrain from awakening the rcuc kthread.
Preliminary experiementation suggests a value of 1000, that is,
one second.  Increasing rcutree.nocb_patience_delay will increase
grace-period latency and in turn increase memory footprint, so systems
with constrained memory might choose a smaller value.  Systems with
less-aggressive OS-jitter requirements might choose the default value
of zero, which keeps the traditional immediate-wakeup behavior, thus
avoiding increases in grace-period latency.

[ paulmck: Apply Leonardo Bras feedback.  ]

Link: https://lore.kernel.org/all/20240328171949.743211-1-leobras@redhat.com/

Reported-by: Leonardo Bras <leobras@redhat.com>
Suggested-by: Leonardo Bras <leobras@redhat.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Leonardo Bras <leobras@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 kernel/rcu/tree.c                               | 10 ++++++++--
 kernel/rcu/tree_plugin.h                        | 10 ++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 500cfa7762257..2d4a512cf1fc6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5018,6 +5018,14 @@
 			the ->nocb_bypass queue.  The definition of "too
 			many" is supplied by this kernel boot parameter.
 
+	rcutree.nocb_patience_delay= [KNL]
+			On callback-offloaded (rcu_nocbs) CPUs, avoid
+			disturbing RCU unless the grace period has
+			reached the specified age in milliseconds.
+			Defaults to zero.  Large values will be capped
+			at five seconds.  All values will be rounded down
+			to the nearest value representable by jiffies.
+
 	rcutree.qhimark= [KNL]
 			Set threshold of queued RCU callbacks beyond which
 			batch limiting is disabled.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35bf4a3736765..408b020c9501f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -176,6 +176,9 @@ static int gp_init_delay;
 module_param(gp_init_delay, int, 0444);
 static int gp_cleanup_delay;
 module_param(gp_cleanup_delay, int, 0444);
+static int nocb_patience_delay;
+module_param(nocb_patience_delay, int, 0444);
+static int nocb_patience_delay_jiffies;
 
 // Add delay to rcu_read_unlock() for strict grace periods.
 static int rcu_unlock_delay;
@@ -4344,11 +4347,14 @@ static int rcu_pending(int user)
 		return 1;
 
 	/* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
-	if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
+	gp_in_progress = rcu_gp_in_progress();
+	if ((user || rcu_is_cpu_rrupt_from_idle() ||
+	     (gp_in_progress &&
+	      time_before(jiffies, READ_ONCE(rcu_state.gp_start) + nocb_patience_delay_jiffies))) &&
+	    rcu_nohz_full_cpu())
 		return 0;
 
 	/* Is the RCU core waiting for a quiescent state from this CPU? */
-	gp_in_progress = rcu_gp_in_progress();
 	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm && gp_in_progress)
 		return 1;
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 340bbefe5f652..31c539f09c150 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -93,6 +93,16 @@ static void __init rcu_bootup_announce_oddness(void)
 		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
 	if (gp_cleanup_delay)
 		pr_info("\tRCU debug GP cleanup slowdown %d jiffies.\n", gp_cleanup_delay);
+	if (nocb_patience_delay < 0) {
+		pr_info("\tRCU NOCB CPU patience negative (%d), resetting to zero.\n", nocb_patience_delay);
+		nocb_patience_delay = 0;
+	} else if (nocb_patience_delay > 5 * MSEC_PER_SEC) {
+		pr_info("\tRCU NOCB CPU patience too large (%d), resetting to %ld.\n", nocb_patience_delay, 5 * MSEC_PER_SEC);
+		nocb_patience_delay = 5 * MSEC_PER_SEC;
+	} else if (nocb_patience_delay) {
+		pr_info("\tRCU NOCB CPU patience set to %d milliseconds.\n", nocb_patience_delay);
+	}
+	nocb_patience_delay_jiffies = msecs_to_jiffies(nocb_patience_delay);
 	if (!use_softirq)
 		pr_info("\tRCU_SOFTIRQ processing moved to rcuc kthreads.\n");
 	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
-- 
2.40.1

