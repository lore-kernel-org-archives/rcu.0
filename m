Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB4155C97;
	Mon, 28 Oct 2024 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134473; cv=none; b=K/ZTJoihaiNjW9XD3cpnfuGakd9B45bHTfkVtwUJlbu9zxotlLF1tm3d4dDtCsZkM31VqWEVZMyt5u9BWjQ5CeWyjMtTMIrIDcpRESq4zzueFIqWIzhY+6ggTUX64UdsVv/QlWUQqiYZyIdtwqCguahSlHJzRHD9QuIxxZmN888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134473; c=relaxed/simple;
	bh=rrl5Cf3sGFo9Tm43JqFtYQb0O1dldmbe1HOCsSTldCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbe6Eef/7D5hYOSh/vAMv+wf/umjOCOW9nFi+tgaAH2d01XWfQ+I/h2o3wzE8B0y1Go4rwxJsiY9iw7qsx7aD/phu8QQ5Ny/7k6RkGb139DTQYtXmyw98Yb3ZXx+SgAQzX8xhKuvfAddXmzhgg7SpYGx55XYINok66OhUuPymqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ypy6v5kk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypy6v5kk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E860AC4CEC3;
	Mon, 28 Oct 2024 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730134472;
	bh=rrl5Cf3sGFo9Tm43JqFtYQb0O1dldmbe1HOCsSTldCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ypy6v5kkFvNVzT69+bPXjItjBywSMIqnvj6g/RLUjEGpC35JGejh0rCOWL0Zf0CNd
	 TOaFwNFYSdygZwLZWbmY9fXJ95LBtwYE1a9dZVa4RKiDyTD/ugweNmT8polmakZf7U
	 Tc4PJc3+EkwJ1XRtZ+Y8xR6T+AXqe7k7jrbdbrovJ6fhkAaw8fNYyP67pmV5t/BC3c
	 RZsH/SiVTpUKxZqVQ+I9p0zL3o5sK/Q7Cpj+ECTZVhaqX62Y+bZHSDFEySkiXJdSAv
	 Sc48ghX6Swa4wCSPr9biCHIZzOkXbhGuTQEWqKciWur7tQsySrD4KFwhvMN71eGSw/
	 dfMqv2juClBkw==
Date: Mon, 28 Oct 2024 17:54:29 +0100
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
Subject: [PATCH 1/2] arm64: Keep first mismatched 32bits el0 capable CPU
 online through its callbacks
Message-ID: <Zx_BxX6573kqNbhP@localhost.localdomain>
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

The first mismatched 32bits el0 capable CPU is designated as the last
resort CPU for compat 32 bits tasks. As such this CPU is forbidden to
go offline.

However this restriction is applied to the device object of the CPU,
which is not easy to revert later if needed because other components may
have forbidden the target to be offline and they are not tracked.

But the task cpu possible mask is going to be made aware of housekeeping
CPUs. In that context, a better 32 bits el0 last resort CPU may be found
later on boot. When that happens, the old fallback can be made
offlineable again.

To make this possible and more flexible, drive the offlineable decision
from the cpuhotplug callbacks themselves.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 718728a85430..53ee8ce38d5b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3591,15 +3591,15 @@ void __init setup_user_features(void)
 	minsigstksz_setup();
 }
 
-static int enable_mismatched_32bit_el0(unsigned int cpu)
-{
-	/*
-	 * The first 32-bit-capable CPU we detected and so can no longer
-	 * be offlined by userspace. -1 indicates we haven't yet onlined
-	 * a 32-bit-capable CPU.
-	 */
-	static int lucky_winner = -1;
+/*
+ * The first 32-bit-capable CPU we detected and so can no longer
+ * be offlined by userspace. -1 indicates we haven't yet onlined
+ * a 32-bit-capable CPU.
+ */
+static int cpu_32bit_unofflineable = -1;
 
+static int mismatched_32bit_el0_online(unsigned int cpu)
+{
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
 	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
 
@@ -3611,7 +3611,7 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
 		return 0;
 
-	if (lucky_winner >= 0)
+	if (cpu_32bit_unofflineable < 0)
 		return 0;
 
 	/*
@@ -3619,16 +3619,20 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 	 * 32-bit EL0 online so that is_cpu_allowed() doesn't end up rejecting
 	 * every CPU in the system for a 32-bit task.
 	 */
-	lucky_winner = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
-							 cpu_active_mask);
-	get_cpu_device(lucky_winner)->offline_disabled = true;
+	cpu_32bit_unofflineable = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
+								    cpu_active_mask);
 	setup_elf_hwcaps(compat_elf_hwcaps);
 	elf_hwcap_fixup();
 	pr_info("Asymmetric 32-bit EL0 support detected on CPU %u; CPU hot-unplug disabled on CPU %u\n",
-		cpu, lucky_winner);
+		cpu, cpu_32bit_unofflineable);
 	return 0;
 }
 
+static int mismatched_32bit_el0_offline(unsigned int cpu)
+{
+	return cpu == cpu_32bit_unofflineable ? -EBUSY : 0;
+}
+
 static int __init init_32bit_el0_mask(void)
 {
 	if (!allow_mismatched_32bit_el0)
@@ -3639,7 +3643,7 @@ static int __init init_32bit_el0_mask(void)
 
 	return cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				 "arm64/mismatched_32bit_el0:online",
-				 enable_mismatched_32bit_el0, NULL);
+				 mismatched_32bit_el0_online, mismatched_32bit_el0_offline);
 }
 subsys_initcall_sync(init_32bit_el0_mask);
 
-- 
2.46.0

