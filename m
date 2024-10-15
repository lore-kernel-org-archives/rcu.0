Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30320311;
	Tue, 15 Oct 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000138; cv=none; b=EKf1KgZ9Oju8RS7BB/9vzTbSu6ec+L3oa8A6FiGCQvSV0zvEbD8YgBb3Qxt2hZfuuqu8bS/L/lsQR8hAfFFo8RKn2OWfjPzsIib8eWIpu5A1mvVFfAgooY6Nm8TKDqVw0ZSb2BUYoTvYDNLhYBZatVJKNv8f3rA+W0BwRl8utKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000138; c=relaxed/simple;
	bh=7lLnrDPORSbcthOwpVPnjw1Kp9GCWhUSzQPVK0cFwxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgjOFZVN59tWw0vODXraN72w2OhEfYf6hk6RzojUAlsIGqWE00Q7Vc0XTOApkTdK0S9E5PNjBeVN+2qsO7TeMItzwGcRcet3lCM8zpdlWhaUKdL6U6t5PRgXSpY1D5YSYPaWuokQd5gPwPkF9JppqzaAVaRIBUsv0U2uw97+oMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpXxWnc7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpXxWnc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4AEC4CEC6;
	Tue, 15 Oct 2024 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729000138;
	bh=7lLnrDPORSbcthOwpVPnjw1Kp9GCWhUSzQPVK0cFwxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpXxWnc7c8+Rdc4J9GRivU2/MAuSsMGy2bS+Msg6bi0x8/LOiZlsfzl/0DB0aNP9H
	 Kot+qnPp/hDAKlT8fD13Gcm6tQeF+WSR/t3Ng2G/Ac8SuI9/P7qDn9Puz1nfg9+6Ls
	 930rz+CyCSvBy5yQ2680ojWxwDK9hlm5WCcG7sy8kT7xxNYKdSjjRP3pzAiuqldz5W
	 LRy26Ff9o6chMYGip5eoS7RvaYf5uzXFkHv6jC2RGuIOXXJ1Jg1UOsyLRUdXpBFsEH
	 Sc7JeCXw4jr8ydrVHTh9eLK/CI/RyuT7qLOBuhW0HSGsGQToVrkPwocRn1xrQNyK18
	 dTAcU0CyRqSTw==
Date: Tue, 15 Oct 2024 15:48:55 +0200
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
Subject: Re: [PATCH 11/20] sched: Handle CPU isolation on last resort
 fallback rq selection
Message-ID: <Zw5yx6huZvQ5r71_@localhost.localdomain>
References: <20240926224910.11106-1-frederic@kernel.org>
 <20240926224910.11106-12-frederic@kernel.org>
 <20241008105434.GA9243@willie-the-truck>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008105434.GA9243@willie-the-truck>

Le Tue, Oct 08, 2024 at 11:54:35AM +0100, Will Deacon a écrit :
> On Fri, Sep 27, 2024 at 12:48:59AM +0200, Frederic Weisbecker wrote:
> > When a kthread or any other task has an affinity mask that is fully
> > offline or unallowed, the scheduler reaffines the task to all possible
> > CPUs as a last resort.
> > 
> > This default decision doesn't mix up very well with nohz_full CPUs that
> > are part of the possible cpumask but don't want to be disturbed by
> > unbound kthreads or even detached pinned user tasks.
> > 
> > Make the fallback affinity setting aware of nohz_full. This applies to
> > all architectures supporting nohz_full except arm32. However this
> > architecture that overrides the task possible mask is unlikely to be
> > willing to integrate new development.
> 
> I'm not sure I understand this last sentence. The possible mask is
> overridden for 32-bit tasks on an *arm64* kernel when running on an SoC
> featuring some CPUs that can execute only 64-bit tasks. Who is unwilling
> to integrate what?
> 
> Will

Will, how does the (untested) following look like? The rationale is that
we must deal with the fact that CPU supporting 32-bits el0 may appear at
any time and those may not intersect housekeeping CPUs (housekeeping CPUs
are CPUs that are not part of nohz_full=. If nohz_full= isn't used then
it's cpu_possible_mask). If there is a housekeeping CPU supporting el0 32bits
then it will be disallowed to be ever offlined. But if the first mismatching
CPU supporting el0 that pops up is not housekeeping then we may end up
with that CPU disallowed to be offlined + later if a housekeeping CPU appears
that also supports 32bits el0 will also be disallowed to be offlined. Ideally
it should turn back the previous CPU to be offlinable but there may be
other things that have forbidden that CPU to be offline so...

Oh well I made a mess.

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
index 7c09d47e09cb..30cb30438fec 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -282,6 +282,19 @@ task_cpu_possible_mask(struct task_struct *p)
 }
 #define task_cpu_possible_mask	task_cpu_possible_mask
 
+static inline const struct cpumask *
+task_cpu_fallback_mask(struct task_struct *p)
+{
+	if (!static_branch_unlikely(&arm64_mismatched_32bit_el0))
+		return housekeeping_cpumask(HK_TYPE_TICK);
+
+	if (!is_compat_thread(task_thread_info(p)))
+		return housekeeping_cpumask(HK_TYPE_TICK);
+
+	return fallback_32bit_el0_cpumask();
+}
+#define task_cpu_fallback_mask	task_cpu_fallback_mask
+
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 718728a85430..3e4400df588f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -133,6 +133,7 @@ DEFINE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
  * Only valid if arm64_mismatched_32bit_el0 is enabled.
  */
 static cpumask_var_t cpu_32bit_el0_mask __cpumask_var_read_mostly;
+static cpumask_var_t fallback_32bit_el0_mask __cpumask_var_read_mostly;
 
 void dump_cpu_features(void)
 {
@@ -1618,6 +1619,21 @@ const struct cpumask *system_32bit_el0_cpumask(void)
 	return cpu_possible_mask;
 }
 
+const struct cpumask *fallback_32bit_el0_cpumask(void)
+{
+	if (!system_supports_32bit_el0())
+		return cpu_none_mask;
+
+	if (static_branch_unlikely(&arm64_mismatched_32bit_el0)) {
+		if (!cpumask_empty(fallback_32bit_el0_mask))
+			return fallback_32bit_el0_mask;
+		else
+			return cpu_32bit_el0_mask
+	}
+
+	return housekeeping_cpumask(HK_TYPE_TICK);
+}
+
 static int __init parse_32bit_el0_param(char *str)
 {
 	allow_mismatched_32bit_el0 = true;
@@ -3598,20 +3614,30 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 	 * be offlined by userspace. -1 indicates we haven't yet onlined
 	 * a 32-bit-capable CPU.
 	 */
-	static int lucky_winner = -1;
+	static int unofflinable = nr_cpu_ids;
+	static int unofflinable_hk = nr_cpu_ids;
 
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
 	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
 
 	if (cpu_32bit) {
 		cpumask_set_cpu(cpu, cpu_32bit_el0_mask);
+		if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+			cpumask_set_cpu(cpu, fallback_32bit_el0_mask);
 		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
 	}
 
-	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
+	if (unofflinable < nr_cpu_ids) {
+		if (unofflinable_hk >= nr_cpu_ids && cpu_32bit && housekeeping_cpu(cpu, HK_TYPE_TICK)) {
+			unofflinable_hk = cpu;
+			get_cpu_device(unofflinable_hk)->offline_disabled = true;
+			pr_info("Asymmetric 32-bit EL0 support detected on housekeeping CPU %u;"
+				"CPU hot-unplug disabled on CPU %u\n", cpu, cpu);
+		}
 		return 0;
+	}
 
-	if (lucky_winner >= 0)
+	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
 		return 0;
 
 	/*
@@ -3619,9 +3645,13 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 	 * 32-bit EL0 online so that is_cpu_allowed() doesn't end up rejecting
 	 * every CPU in the system for a 32-bit task.
 	 */
-	lucky_winner = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
-							 cpu_active_mask);
-	get_cpu_device(lucky_winner)->offline_disabled = true;
+	unofflinable_hk = cpumask_any_and(fallback_32bit_el0_mask, cpu_active_mask);
+	if (unofflinable_hk < nr_cpu_ids)
+		unofflinable = unofflinable_hk;
+	else
+		unofflinable = cpumask_any_and(cpu_32bit_el0_mask, cpu_active_mask);
+
+	get_cpu_device(unofflinable)->offline_disabled = true;
 	setup_elf_hwcaps(compat_elf_hwcaps);
 	elf_hwcap_fixup();
 	pr_info("Asymmetric 32-bit EL0 support detected on CPU %u; CPU hot-unplug disabled on CPU %u\n",
@@ -3637,6 +3667,9 @@ static int __init init_32bit_el0_mask(void)
 	if (!zalloc_cpumask_var(&cpu_32bit_el0_mask, GFP_KERNEL))
 		return -ENOMEM;
 
+	if (!zalloc_cpumask_var(&fallback_32bit_el0_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	return cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				 "arm64/mismatched_32bit_el0:online",
 				 enable_mismatched_32bit_el0, NULL);
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index bbaec80c78c5..5b8d017a17f9 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -28,6 +28,10 @@ static inline void leave_mm(void) { }
 # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
 #endif
 
+#ifndef task_cpu_fallback_mask
+# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_TICK);
+#endif
+
 #ifndef mm_untag_mask
 static inline unsigned long mm_untag_mask(struct mm_struct *mm)
 {
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

