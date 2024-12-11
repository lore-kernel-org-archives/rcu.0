Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F91A4F22;
	Wed, 11 Dec 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931666; cv=none; b=tw3QUNyjSS6mKUPgSwVarH5wGwG9NUsJojm10vrvSS7Zkgs0QZ6b2R2uNBKsUMHE6pQWFGnGt4Tj3SiLdwE23ITqE1rwqxauYJ++YkKq/l4wUKO9h/j4tU08HrVQUAcO3KldyK27Blw90EQpf4gmE2PreoaAk4BianMUxvlnqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931666; c=relaxed/simple;
	bh=8TDEvuzL5OjYtFZwJosJszBBXSPQtEoTxfZP8Lv4L7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjd/lbwNqWoe1QM7W+yfjOZ/59zTMkSg4aK5Wh7eho0O0RdZPKA6Bfng+jOgMd73ijEIJS5uqr7nkGvg3WGmmTNzhbLwmmmO3/5uyySlIhUirh3+TvuIE1qJEuFJU5CuV6fqfSk4JemqE1ykden+3n1wihVBeykVtgBqR3bjPOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTtOG5d3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTtOG5d3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43250C4CED7;
	Wed, 11 Dec 2024 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931666;
	bh=8TDEvuzL5OjYtFZwJosJszBBXSPQtEoTxfZP8Lv4L7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jTtOG5d3//NYguAvmylQYmEgDZBMg/JDwNi0ycJMVajv3A+nhQH8jPojMD/39fd2I
	 tjfdd/TVjm8p7MfciFEgANLnHzx/z/rZaanSDcWR22ZySP1x6LoU0o6FKaTXMRKEhu
	 RtANBf3bTi2fbRKVVm2tTc0mERRf/nH0aKJfJVtTf86OLjuF/tQmNwT8EP1lcLRh0T
	 hvMyipL1qs2PQ+upkKmQEs7Xeqn4SWu8cfsbJy0ud8Vd8+gZNcPXStZxb0IXuAtpZK
	 dTHKc23jwZmPV1Gjar/6azSUT9O52de5FY+fsFSwsJyzsvTwXPEU9YWakqzxgyxxP4
	 md56RvqK3OLIg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 10/19] sched,arm64: Handle CPU isolation on last resort fallback rq selection
Date: Wed, 11 Dec 2024 16:40:23 +0100
Message-ID: <20241211154035.75565-11-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211154035.75565-1-frederic@kernel.org>
References: <20241211154035.75565-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a kthread or any other task has an affinity mask that is fully
offline or unallowed, the scheduler reaffines the task to all possible
CPUs as a last resort.

This default decision doesn't mix up very well with nohz_full CPUs that
are part of the possible cpumask but don't want to be disturbed by
unbound kthreads or even detached pinned user tasks.

Make the fallback affinity setting aware of nohz_full.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h  |  1 +
 arch/arm64/include/asm/mmu_context.h |  2 ++
 arch/arm64/kernel/cpufeature.c       | 11 +++++++++++
 include/linux/mmu_context.h          |  1 +
 kernel/sched/core.c                  |  2 +-
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8b4e5a3cd24c..cac5efc836c0 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -671,6 +671,7 @@ static inline bool supports_clearbhb(int scope)
 }
 
 const struct cpumask *system_32bit_el0_cpumask(void);
+const struct cpumask *fallback_32bit_el0_cpumask(void);
 DECLARE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
 
 static inline bool system_supports_32bit_el0(void)
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 48b3d9553b67..7883abd6b29a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -283,6 +283,8 @@ task_cpu_possible_mask(struct task_struct *p)
 }
 #define task_cpu_possible_mask	task_cpu_possible_mask
 
+const struct cpumask *task_cpu_fallback_mask(struct task_struct *p);
+
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7ce1b8ab417f..2b7aa32bf436 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1642,6 +1642,17 @@ const struct cpumask *system_32bit_el0_cpumask(void)
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
+	return system_32bit_el0_cpumask();
+}
+
 static int __init parse_32bit_el0_param(char *str)
 {
 	allow_mismatched_32bit_el0 = true;
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
index 95e40895a519..233b50b0e123 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3534,7 +3534,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
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

