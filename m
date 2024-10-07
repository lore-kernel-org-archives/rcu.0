Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A11D90D3;
	Mon,  7 Oct 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313623; cv=none; b=BIKPmbCDIAIJDlHak693IcJdq+yxhb8dtbQjo7SIiTwydRPUGDOI70BnIKH58JK13h8Dz3/7nMGTjwWuFGUlSPK1tzfG4N/aL6KtTdqhAVb+DlD5ufZIhuollKs8O7VEZw97rASfCHnrBxJVEQ/wcgAXFxpAIN4tajQ9Lq3YNhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313623; c=relaxed/simple;
	bh=r1rEb4BcGluwlHstvi+nWxFz5xLpAXRmZnsaTQauCkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJ7cl9r9MWv0Ly0tbjyPIyN+CnyJtPqcqhki4ftsXiixcRI9Eo998Ori6ce2YJIqQnchVrH6T/UW7uV5POSGFUUvurGmZmR8ndAovynqY/zNYDFpoB5NVRmzO+tNC6+J6624crUPp7X9v+YG8yVtShjxvUWpy9VPovZo+o41/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rWkyGSYF; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rWkyGSYF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728313619;
	bh=r1rEb4BcGluwlHstvi+nWxFz5xLpAXRmZnsaTQauCkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rWkyGSYF70MdtnVehW6FBtpNIYFy9k6IVdj66SP1lBOuIi9NBlqdoHQocQgzbC6zO
	 odM4YO9SgTV6A9OilOfrlU20IND6EiyIFW4EZjAujSZLpbGjEVcsOvzxweckFFODFL
	 kmnTFec/qoPH/yia06SSkpKrNEUj+UTuCFfizRRycoYFcRW1Kx2tHCrMupweo6bnQ/
	 mWxnppFiwX+pYJs+vR0HQbnT8DRzVPjGtbQXbjNTZzit6gXlFpBzVcAw66Zlenb/r1
	 jMKOw2k+Dp9BEsLf8ajwfr5eeSST9uFXtQO1i+TT4xTI611VcYFuk+qVoG2qmpLAtZ
	 P4a/D2KjwXnBQ==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XMjDL45V4z3rf;
	Mon,  7 Oct 2024 11:06:58 -0400 (EDT)
Message-ID: <f5c749d3-e3ec-4463-9dc2-690b9b719315@efficios.com>
Date: Mon, 7 Oct 2024 11:05:01 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/4] sched+mm: Use hazard pointers to track lazy
 active mm existence
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Nicholas Piggin
 <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, maged.michael@gmail.com,
 rcu@vger.kernel.org, lkmm@lists.linux.dev
References: <202410072229.18756716-oliver.sang@intel.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <202410072229.18756716-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-07 16:50, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:
> 
> commit: efef4da3b19cadf4beb45079a05643a77821de79 ("[RFC PATCH v2 4/4] sched+mm: Use hazard pointers to track lazy active mm existence")
> url: https://github.com/intel-lab-lkp/linux/commits/Mathieu-Desnoyers/compiler-h-Introduce-ptr_eq-to-preserve-address-dependency/20241005-023027
> base: https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git next
> patch link: https://lore.kernel.org/all/20241004182734.1761555-5-mathieu.desnoyers@efficios.com/
> patch subject: [RFC PATCH v2 4/4] sched+mm: Use hazard pointers to track lazy active mm existence
> 

This should do the trick:

-       WRITE_ONCE(this_cpu_ptr(hp_domain_sched_lazy_mm.percpu_slots)->addr, NULL);
+       this_cpu_write(hp_domain_sched_lazy_mm.percpu_slots->addr, NULL);

I'll update the patch for the next round.

Thanks,

Mathieu


> in testcase: boot
> 
> compiler: gcc-12
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +--------------------------------------------+------------+------------+
> |                                            | 75b478bf10 | efef4da3b1 |
> +--------------------------------------------+------------+------------+
> | BUG:using_smp_processor_id()in_preemptible | 0          | 12         |
> +--------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202410072229.18756716-oliver.sang@intel.com
> 
> 
> [    6.336856][   T48] BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u10:1/48
> [ 6.338102][ T48] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [    6.338809][   T48] CPU: 0 UID: 0 PID: 48 Comm: kworker/u10:1 Not tainted 6.12.0-rc1-00004-gefef4da3b19c #5
> [    6.339929][   T48] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    6.341119][   T48] Call Trace:
> [ 6.341504][ T48] dump_stack_lvl (lib/dump_stack.c:123)
> [ 6.342057][ T48] dump_stack (lib/dump_stack.c:130)
> [ 6.342065][ T48] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 lib/smp_processor_id.c:53)
> [ 6.342065][ T48] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 6.342065][ T48] exec_mmap (include/linux/sched/mm.h:91 fs/exec.c:1017)
> [ 6.342065][ T48] ? would_dump (fs/exec.c:1409)
> [ 6.342065][ T48] begin_new_exec (fs/exec.c:1280)
> [ 6.342065][ T48] ? load_elf_phdrs (fs/binfmt_elf.c:534)
> [ 6.342065][ T48] load_elf_binary (fs/binfmt_elf.c:996)
> [ 6.342065][ T48] ? get_lock_stats (kernel/locking/lockdep.c:339)
> [ 6.342065][ T48] ? search_binary_handler (fs/exec.c:1752)
> [ 6.342065][ T48] search_binary_handler (fs/exec.c:1752)
> [ 6.342065][ T48] exec_binprm (fs/exec.c:1795)
> [ 6.342065][ T48] bprm_execve (fs/exec.c:1846 fs/exec.c:1821)
> [ 6.342065][ T48] kernel_execve (fs/exec.c:2012)
> [ 6.342065][ T48] call_usermodehelper_exec_async (kernel/umh.c:110)
> [ 6.342065][ T48] ? umh_complete (kernel/umh.c:65)
> [ 6.342065][ T48] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 6.342065][ T48] ? umh_complete (kernel/umh.c:65)
> [ 6.342065][ T48] ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
> [ 6.342065][ T48] entry_INT80_32 (arch/x86/entry/entry_32.S:944)
> [    6.352140][    T1] ppdev: user-space parallel port driver
> [    6.353841][    T1] HSI/SSI char device loaded
> [    6.354238][    T1] e1000: Intel(R) PRO/1000 Network Driver
> [    6.354673][    T1] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    6.650009][    T1] ACPI: _SB_.LNKC: Enabled at IRQ 11
> [    6.968868][    T1] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
> [    6.969500][    T1] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> [    6.970506][   T49] BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u10:1/49
> [ 6.971191][ T49] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [    6.971650][   T49] CPU: 0 UID: 0 PID: 49 Comm: kworker/u10:1 Not tainted 6.12.0-rc1-00004-gefef4da3b19c #5
> [    6.972365][   T49] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    6.973115][   T49] Call Trace:
> [ 6.973356][ T49] dump_stack_lvl (lib/dump_stack.c:123)
> [ 6.973686][ T49] dump_stack (lib/dump_stack.c:130)
> [ 6.973983][ T49] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 lib/smp_processor_id.c:53)
> [ 6.974328][ T49] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 6.974328][ T49] exec_mmap (include/linux/sched/mm.h:91 fs/exec.c:1017)
> [ 6.974328][ T49] ? would_dump (fs/exec.c:1409)
> [ 6.974328][ T49] begin_new_exec (fs/exec.c:1280)
> [ 6.974328][ T49] ? load_elf_phdrs (fs/binfmt_elf.c:534)
> [ 6.974328][ T49] load_elf_binary (fs/binfmt_elf.c:996)
> [ 6.974328][ T49] ? get_lock_stats (kernel/locking/lockdep.c:339)
> [ 6.974328][ T49] ? search_binary_handler (fs/exec.c:1752)
> [ 6.974328][ T49] search_binary_handler (fs/exec.c:1752)
> [ 6.974328][ T49] exec_binprm (fs/exec.c:1795)
> [ 6.974328][ T49] bprm_execve (fs/exec.c:1846 fs/exec.c:1821)
> [ 6.974328][ T49] kernel_execve (fs/exec.c:2012)
> [ 6.974328][ T49] call_usermodehelper_exec_async (kernel/umh.c:110)
> [ 6.974328][ T49] ? umh_complete (kernel/umh.c:65)
> [ 6.974328][ T49] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 6.974328][ T49] ? umh_complete (kernel/umh.c:65)
> [ 6.974328][ T49] ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
> [ 6.974328][ T49] entry_INT80_32 (arch/x86/entry/entry_32.S:944)
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241007/202410072229.18756716-oliver.sang@intel.com
> 
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

