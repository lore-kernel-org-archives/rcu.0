Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5112FF7B;
	Fri, 16 Aug 2024 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781152; cv=none; b=ZEKm+8ssTlKILxD15rHmpbejY70VM7yzpKKUTs4/TTGxPaLv/md3zr6NWUSrWB0dQss1hJoJk9Gnw/lyoOQfhfMSmpbKQ728IBxt0gDH7uP5PHHe0gC6Mt4qnplqrD8B4N+u6KtXJE7aBcsPfPtYmHuHMy4hwbjN7b0cI97ne8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781152; c=relaxed/simple;
	bh=Z1poKp0DfIzf8G/KTV53Tc5rMLzCgOhwSFtPjx4JNGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hIU5A7cwUmHl7TZecQJHIhQ+u29MNQa5NRp7eE4H9xY6XZ71bizCkyI9f/MAHqrwzj+wpy28S8dZDW0ThXuGPJ9Dv3wuqFm0+P2e/l0hNhTUmQETJrLdBuX8ztY4GJm8uh5QMPqohEvVAr/yT70obVqqoH7GCQ9ES5S91PivUXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEONPJAe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEONPJAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866FDC32782;
	Fri, 16 Aug 2024 04:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781152;
	bh=Z1poKp0DfIzf8G/KTV53Tc5rMLzCgOhwSFtPjx4JNGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEONPJAeuBPIrRZ3alUOLqIl1FMmpUbyv7tQfuBXPOCmAihA5IiJ833gkTjgqMGQL
	 NB79kyWSBJoBGpms+3YzOHMqg7Vc8DBV1OQxXR6AowP+KWt7TUhsSJdRL1QWwmGjZ6
	 XvzRDeboc7+kGT/N9OkXbOioyTucSZZf4TqoVgLaVB+9EEgdTkS1Xf06VmFHNvaYKh
	 IftRe2irirvAbmOnreGbkmVNLOOlQe61Ckn/CywdEWsjvoyF6otNrbnB4FoAXrYs62
	 EVHwquLdKboV8gMWF3z6Se2URFis/A7063lb3Y96I0Hibghl0QgVMwTfxfV63f+4hk
	 WskZ9wwZi0rrQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 18/26] rcu: Rename rcu_dynticks_zero_in_eqs() into rcu_watching_zero_in_eqs()
Date: Fri, 16 Aug 2024 09:32:33 +0530
Message-Id: <20240816040241.17776-18-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816040030.GA16986@neeraj.linux>
References: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, reflect that change in the related helpers.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcu.h   | 4 ++--
 kernel/rcu/tasks.h | 2 +-
 kernel/rcu/tree.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 38238e595a61..5564402af4cb 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -606,7 +606,7 @@ void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 #endif
 
 #ifdef CONFIG_TINY_RCU
-static inline bool rcu_dynticks_zero_in_eqs(int cpu, int *vp) { return false; }
+static inline bool rcu_watching_zero_in_eqs(int cpu, int *vp) { return false; }
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline unsigned long
@@ -619,7 +619,7 @@ static inline void rcu_fwd_progress_check(unsigned long j) { }
 static inline void rcu_gp_slow_register(atomic_t *rgssp) { }
 static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
 #else /* #ifdef CONFIG_TINY_RCU */
-bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
+bool rcu_watching_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ba3440a45b6d..2484c1a8e051 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1613,7 +1613,7 @@ static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
 		// However, we cannot safely change its state.
 		n_heavy_reader_attempts++;
 		// Check for "running" idle tasks on offline CPUs.
-		if (!rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
+		if (!rcu_watching_zero_in_eqs(cpu, &t->trc_reader_nesting))
 			return -EINVAL; // No quiescent state, do it the hard way.
 		n_heavy_reader_updates++;
 		nesting = 0;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 93570cb5e99e..ac3577ac10bd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -341,7 +341,7 @@ static bool rcu_watching_snap_stopped_since(struct rcu_data *rdp, int snap)
  * Return true if the referenced integer is zero while the specified
  * CPU remains within a single extended quiescent state.
  */
-bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
+bool rcu_watching_zero_in_eqs(int cpu, int *vp)
 {
 	int snap;
 
-- 
2.40.1

