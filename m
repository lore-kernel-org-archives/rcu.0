Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646231DED60;
	Mon, 28 Oct 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134595; cv=none; b=AazDncn6sJhitQ+bkoR9Bwom4k4WwY6vghY/jERkKj3X93E73knHgVnMKJMcLEwVY29iRMZ0N1lr/jSXQ8UqZCbdKvQULJ7jg+7pl7bsL9EEWq8L7eU2uMVI5tr6EsBTDwp55UHt8YdcCbk2hJNOpwQxx6aCz1UsWWKgTnSy8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134595; c=relaxed/simple;
	bh=7WQiJxzs/J7mK/O9sPfFrbb4pwB/jW3PPX4YHzWk7V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ai3kPjJqeli0NRszV3PMnt+lzMO2iK0KTI7lBT+RoOHNqFKxuwHS8DfchPKeVkoVfzLzJxdDAyCnScg6UqAzgPDjvdXtOXE5nYPPz0RCG9mBvpJ/CT/C8DEG8anqiJsMl4rJsk/jwyZeybMxB4z0mvfpPQd2pIdSBYLQWYBL9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOEr9aHJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOEr9aHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7ACEC4CEC3;
	Mon, 28 Oct 2024 16:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730134595;
	bh=7WQiJxzs/J7mK/O9sPfFrbb4pwB/jW3PPX4YHzWk7V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cOEr9aHJZHqM6r+LVCEF6PmmHRAZpEG74ML8vdmTATWYZrIlsO1ynlkrTBJKT9Y2v
	 WZWll9Ttd4QuUUli2sF2XGKxDFKol2JisOgsWVsqJ8Nws+BFQqu0dpIYF53FDTtbjL
	 aHAfY5hXOP8bI5Tn1J4c7n82T9RZiVV402lcHVfZTgq7O1/Z9KmxAqgsrpBxjsMSav
	 0rTZ7ztKaD+xk6xZEgks1aC7sMV5/jY5NerXLkwaf9kMYEnDkzFAakyLXEA1XO43xS
	 vXsbBVtqPQVM6DTBEcMaGcifSI8h2uqXh8CkjJXJ/LUtlKb/qUrHGQnQ7Kao0cqrgL
	 UQKvhb2yT/DkA==
Date: Mon, 28 Oct 2024 17:56:32 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 2/2] sched,arm64: Handle CPU isolation on last resort
 fallback rq selection
Message-ID: <Zx_CQEAWMj0BTtDI@localhost.localdomain>
References: <20240926224910.11106-1-frederic@kernel.org>
 <20240926224910.11106-12-frederic@kernel.org>
 <20241008105434.GA9243@willie-the-truck>
 <Zw5yx6huZvQ5r71_@localhost.localdomain>
 <20241028162514.GA2709@willie-the-truck>
 <Zx_BDLUDmL-3tLtd@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx_BDLUDmL-3tLtd@localhost.localdomain>

When a kthread or any other task has an affinity mask that is fully
offline or unallowed, the scheduler reaffines the task to all possible
CPUs as a last resort.

This default decision doesn't mix up very well with nohz_full CPUs that
are part of the possible cpumask but don't want to be disturbed by
unbound kthreads or even detached pinned user tasks.

Make the fallback affinity setting aware of nohz_full. ARM64 is a
special case and its last resort EL0 32bits capable CPU can be updated
as housekeeping CPUs appear on boot.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h  |  1 +
 arch/arm64/include/asm/mmu_context.h |  2 ++
 arch/arm64/kernel/cpufeature.c       | 47 +++++++++++++++++++++++-----
 include/linux/mmu_context.h          |  1 +
 kernel/sched/core.c                  |  2 +-
 5 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 3d261cc123c1..992d782f2899 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -663,6 +663,7 @@ static inline bool supports_clearbhb(int scope)
 }
 
 const struct cpumask *system_32bit_el0_cpumask(void);
+const struct cpumask *fallback_32bit_el0_cpumask(void);
 DECLARE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
 
 static inline bool system_supports_32bit_el0(void)
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 7c09d47e09cb..8d481e16271b 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -282,6 +282,8 @@ task_cpu_possible_mask(struct task_struct *p)
 }
 #define task_cpu_possible_mask	task_cpu_possible_mask
 
+const struct cpumask *task_cpu_fallback_mask(struct task_struct *p);
+
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 53ee8ce38d5b..4eabe0f02cc8 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -75,6 +75,7 @@
 #include <linux/cpu.h>
 #include <linux/kasan.h>
 #include <linux/percpu.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
@@ -133,6 +134,7 @@ DEFINE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
  * Only valid if arm64_mismatched_32bit_el0 is enabled.
  */
 static cpumask_var_t cpu_32bit_el0_mask __cpumask_var_read_mostly;
+static cpumask_var_t fallback_32bit_el0_mask __cpumask_var_read_mostly;
 
 void dump_cpu_features(void)
 {
@@ -1618,6 +1620,23 @@ const struct cpumask *system_32bit_el0_cpumask(void)
 	return cpu_possible_mask;
 }
 
+const struct cpumask *task_cpu_fallback_mask(struct task_struct *p)
+{
+	if (!static_branch_unlikely(&arm64_mismatched_32bit_el0))
+		return housekeeping_cpumask(HK_TYPE_TICK);
+
+	if (!is_compat_thread(task_thread_info(p)))
+		return housekeeping_cpumask(HK_TYPE_TICK);
+
+	if (!system_supports_32bit_el0())
+		return cpu_none_mask;
+
+	if (!cpumask_empty(fallback_32bit_el0_mask))
+		return fallback_32bit_el0_mask;
+	else
+		return cpu_32bit_el0_mask;
+}
+
 static int __init parse_32bit_el0_param(char *str)
 {
 	allow_mismatched_32bit_el0 = true;
@@ -3605,22 +3624,33 @@ static int mismatched_32bit_el0_online(unsigned int cpu)
 
 	if (cpu_32bit) {
 		cpumask_set_cpu(cpu, cpu_32bit_el0_mask);
+		if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+			cpumask_set_cpu(cpu, fallback_32bit_el0_mask);
 		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
 	}
 
-	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
+	if (cpu_32bit_unofflineable >= 0) {
+		if (!housekeeping_cpu(cpu_32bit_unofflineable, HK_TYPE_TICK) &&
+		    cpu_32bit && housekeeping_cpu(cpu, HK_TYPE_TICK)) {
+			cpu_32bit_unofflineable = cpu;
+			pr_info("Asymmetric 32-bit EL0 support detected on housekeeping CPU %u;"
+				"CPU hot-unplug disabled on CPU %u\n", cpu, cpu);
+		}
 		return 0;
+	}
 
-	if (cpu_32bit_unofflineable < 0)
+	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
 		return 0;
 
 	/*
-	 * We've detected a mismatch. We need to keep one of our CPUs with
-	 * 32-bit EL0 online so that is_cpu_allowed() doesn't end up rejecting
-	 * every CPU in the system for a 32-bit task.
+	 * We've detected a mismatch. We need to keep one of our CPUs, preferrably
+	 * housekeeping, with 32-bit EL0 online so that is_cpu_allowed() doesn't end up
+	 * rejecting every CPU in the system for a 32-bit task.
 	 */
-	cpu_32bit_unofflineable = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
-								    cpu_active_mask);
+	cpu_32bit_unofflineable = cpumask_any_and(fallback_32bit_el0_mask, cpu_active_mask);
+	if (cpu_32bit_unofflineable >= nr_cpu_ids)
+		cpu_32bit_unofflineable = cpumask_any_and(cpu_32bit_el0_mask, cpu_active_mask);
+
 	setup_elf_hwcaps(compat_elf_hwcaps);
 	elf_hwcap_fixup();
 	pr_info("Asymmetric 32-bit EL0 support detected on CPU %u; CPU hot-unplug disabled on CPU %u\n",
@@ -3641,6 +3671,9 @@ static int __init init_32bit_el0_mask(void)
 	if (!zalloc_cpumask_var(&cpu_32bit_el0_mask, GFP_KERNEL))
 		return -ENOMEM;
 
+	if (!zalloc_cpumask_var(&fallback_32bit_el0_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	return cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				 "arm64/mismatched_32bit_el0:online",
 				 mismatched_32bit_el0_online, mismatched_32bit_el0_offline);
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index bbaec80c78c5..ac01dc4eb2ce 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -24,6 +24,7 @@ static inline void leave_mm(void) { }
 #ifndef task_cpu_possible_mask
 # define task_cpu_possible_mask(p)	cpu_possible_mask
 # define task_cpu_possible(cpu, p)	true
+# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_TICK)
 #else
 # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aeb595514461..1edce360f1a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3489,7 +3489,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 			 *
 			 * More yuck to audit.
 			 */
-			do_set_cpus_allowed(p, task_cpu_possible_mask(p));
+			do_set_cpus_allowed(p, task_cpu_fallback_mask(p));
 			state = fail;
 			break;
 		case fail:
-- 
2.46.0

