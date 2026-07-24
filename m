Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A975229B12;
	Fri, 24 Jul 2026 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784853107; cv=none; b=cUyDt8vVuJyMlDFGPQS79MlDk2rImrska85nAyBVVAV8H3LiYklsoHWyjLI2WurGVyVnLnWCCdzLgJSW7ZX8Xww9oC3iEg+cdd4J+Z88YGkILqnAig75r5hUqzAVUjIbtk/eU57VweSWxR3565KtbSt6WxZo0O7BrkpZN2L4ybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784853107; c=relaxed/simple;
	bh=1XMyPB165ZCGHQAQ422juAs34O66lay3hQeohbcHBOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsgGDG36O3Db1xGAl5nYNtEH7+HqkV8KIaAtW8rvyQfS5tD9Kx9VjZcvA32VnzuZgvfv63Z5h8cI+G52imPKrE6LQGde/jYIeao7duEEvxpPYgkcLCxH+zD0pYjcMD8Pua/l7z5CYdHLQQIFoiTYemZE49Ap7bU90H/stcdPkNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO5ewZNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO5ewZNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994971F000E9;
	Fri, 24 Jul 2026 00:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784853077;
	bh=n87SobLHRFr5KKPOIga4LsS211hVH8ph84UZQ/abE5Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=NO5ewZNLaiifz4HmMmQDIcCKxCTskuMit5cvZNUpQM1kys55XLg+XnSyiHVVMjfjK
	 sqpllPQ58EAOjKuG0yeCEw3DeiA+uav2mYVsmkCLuABPGwUMyl+V5l+DN+eKaddUv5
	 h936yH4n5OC8FL21+I7XHGgzNEulKfP4sNVCkvD2RTXp3bVszq2KySpDOqWlGRd+7I
	 50si9wM8DVRgo1jyujC8Z/nU1fqivBBlEZOU/k2cptlX0sTpNXarGdoLRMeb5etZG8
	 dQogscMDTbuLBenyq1iCX8ESQ8aVqamV7AePdOfNuJSut3kUe0SepH2NtYuFf+YSeY
	 b3byRhMvhTIZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5184FCE1B46; Thu, 23 Jul 2026 17:31:17 -0700 (PDT)
Date: Thu, 23 Jul 2026 17:31:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 00/11] RCU: Enable callbacks to benefit from expedited
 grace periods
Message-ID: <062ddbcd-dac1-4ee1-9d3f-ef115a667d6a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260624132356.516959-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RSoRuixPRx6UJHg0"
Content-Disposition: inline
In-Reply-To: <20260624132356.516959-1-puranjay@kernel.org>


--RSoRuixPRx6UJHg0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2026 at 06:23:42AM -0700, Puranjay Mohan wrote:
> This series lets call_rcu() callbacks be reclaimed as soon as either a
> normal or an expedited grace period that covers them has elapsed, rather
> than always waiting for a normal grace period.
> 
> Motivation
> ==========
> Today there is an asymmetry: synchronize_rcu_expedited() callers get fast
> reclaim, but call_rcu() callers never benefit from those same expedited
> grace periods, even though an expedited GP proves exactly the same thing
> as a normal one -- all pre-existing readers are done.  When expedited GPs
> are running on the system (driven by other subsystems), call_rcu()
> callbacks that could already be freed instead sit in RCU_WAIT_TAIL until
> the next normal GP.  This series treats a grace period as a grace period
> regardless of how it was driven, so memory is reclaimed sooner.
> 
> Design
> ======
> Callback segments now record both the normal and expedited grace-period
> sequence in struct rcu_gp_seq, and rcu_segcblist_advance() releases a
> segment as soon as poll_state_synchronize_rcu_full() reports that either
> has completed.  Three notification paths are taught about expedited
> completion so the advance actually happens: the NOCB rcuog kthreads,
> the rcu_pending() tick gate, and rcu_core().
> 
> Changelog:
> RFC: https://lore.kernel.org/all/20260417231203.785172-1-puranjay@kernel.org/
> Changes in v1:
>  - New prep patch 1 renames struct rcu_gp_oldstate to struct rcu_gp_seq
>    and its fields rgos_norm/rgos_exp to norm/exp tree-wide (Frederic).
>  - The rcu_segcblist segment field stays named gp_seq; only its type
>    changes (Frederic).
>  - Patch 8 (NOCB wake) is reworked.  v1 woke the wrong waitqueue
>    (rdp_gp->nocb_gp_wq via wake_nocb_gp() rather than the leaf
>    rnp->nocb_gp_wq[] that an rcuog kthread waiting for a GP sleeps on),
>    and the wait condition only checked the normal ->gp_seq.  The rcuog
>    grace-period wait now tracks a struct rcu_gp_seq and is released via
>    poll_state_synchronize_rcu_full(); rcu_exp_wait_wake() wakes the leaf
>    node through the new rcu_nocb_exp_cleanup() (Frederic).
>  - rcu_pending() uses a new memory-ordering-free
>    poll_state_synchronize_rcu_full_unordered() to avoid memory barriers
>    on every tick, leaving the ordering duty to rcu_core() (Frederic).
> 
> Still open: Frederic asked whether the first smp_mb() in
> poll_state_synchronize_rcu_full() is needed on the callback-advance path
> (patch 6).  That path still uses the fully ordered helper; only
> rcu_pending() was switched to the unordered variant.  Happy to revisit.
> 
> Puranjay Mohan (11):
>   rcu: Rename struct rcu_gp_oldstate to rcu_gp_seq
>   rcu/segcblist: Add SRCU and Tasks RCU wrapper functions
>   rcu/segcblist: Factor out rcu_segcblist_advance_compact() helper
>   rcu/segcblist: Track segment grace periods with struct rcu_gp_seq
>   rcu: Add RCU_GET_STATE_NOT_TRACKED for subsystems without expedited
>     GPs
>   rcu: Enable RCU callbacks to benefit from expedited grace periods
>   rcu: Update comments for gp_seq and expedited GP tracking
>   rcu: Wake NOCB rcuog kthreads on expedited grace period completion
>   rcu: Detect expedited grace period completion in rcu_pending()
>   rcu: Advance callbacks for expedited GP completion in rcu_core()
>   rcuscale: Add concurrent expedited GP threads for callback scaling
>     tests

I do see the occasional failure when running TREE01, as in a failure or
four every couple hundred hours of testing.  This is the only rcutorture
scenario that exercises callback (de)offloading, which might (or might
not) be a clue.

The console log of a failing run is attached, or you can find it here:

https://drive.google.com/file/d/1EH2P4SDy2a-SJndkN3GbCTGAXxI2xevm/view?usp=sharing

This is a "??? Writer stall state" failure, where rcutorture never learns
of grace-period completion.  Possibly because no grace period completed.
But there are no RCU CPU stall warnings.  In addition, these two lines

[  631.032657] ??? Writer stall state RTWS_EXP_SYNC(4) g152813 f0x0 ->state D cpu 1
. . .
[ 3610.863114] ??? Writer stall state RTWS_EXP_SYNC(4) g736160 f0x0 ->state D cpu 1

show that the grace-period sequence number advanced from 152813 to
736160 in about 50 minutes.  So grace periods really are completing,
lots of them.

This rcutorture scenario has rcu_nocbs CPUs, and CPU 5 is in trouble:

[  631.066109] rcu:    CB 5^4->4 KblSW F21044 L21044 C116 .W120(148380/168068).N295B101 q516 S CPU 16
. . .
[ 3610.869914] rcu:    CB 5^4->4 KblSW F3000848 L3000848 C116 .W120(148380/168068).N295B101 q516 S CPU 16

There are 120 callbacks on the WAIT segment, which are waiting on
grace-period sequence number 148380, which was long gone even back at
631.032657 seconds in (g152813).  There are 295 more callbacks in the NEXT
segment, which long ago should have been assigned a grace period and moved
into the currently empty NEXT_READY segment (which is the "." right before
the "N295").  There are yet another 101 callbacks on the bypass list.

This suggests that the rcuog kthread isn't being awakened when it
should be.  And that something is failing to advance callbacks out of
NEXT in a timely fashion.

Thoughts?

							Thanx, Paul

--RSoRuixPRx6UJHg0
Content-Type: text/plain; charset=us-ascii
Content-Description: console.log
Content-Disposition: attachment; filename="console.log"

[    0.000000] Linux version 7.2.0-rc3-00091-g7f2aa19f28bc (paulmckrcu@devbig031.atn3.facebook.com) (gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-14), GNU ld version 2.35.2-72.el9) #868 SMP PREEMPT_DYNAMIC Thu Jul 23 11:55:37 PDT 2026
[    0.000000] Command line: debug_boot_weak_hash panic=-1 selinux=0 initcall_debug debug console=ttyS0 rcutorture.onoff_interval=1000 rcutorture.onoff_holdoff=30 rcutorture.n_barrier_cbs=4 rcutorture.stat_interval=15 rcutorture.shutdown_secs=3600 rcutorture.test_no_idle_hz=1 rcutorture.verbose=1 maxcpus=8 nr_cpus=17 rcutree.gp_preinit_delay=3 rcutree.gp_init_delay=3 rcutree.gp_cleanup_delay=3 rcu_nocbs=0-1,3-7 rcutorture.nocbs_nthreads=8 rcutorture.nocbs_toggle=1000 rcutorture.fwd_progress=0
[    0.000000] x86/CPU: Model not found in latest microcode list
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff]  System RAM
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff]  device reserved
[    0.000000] BIOS-e820: [gap 0x00000000000a0000-0x00000000000effff]
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001ffdefff]  System RAM
[    0.000000] BIOS-e820: [mem 0x000000001ffdf000-0x000000001fffffff]  device reserved
[    0.000000] BIOS-e820: [gap 0x0000000020000000-0x00000000afffffff]
[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff]  device reserved
[    0.000000] BIOS-e820: [gap 0x00000000c0000000-0x00000000fed1bfff]
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff]  device reserved
[    0.000000] BIOS-e820: [gap 0x00000000fed20000-0x00000000feffbfff]
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff]  device reserved
[    0.000000] BIOS-e820: [gap 0x00000000ff000000-0x00000000fffbffff]
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff]  device reserved
[    0.000000] debug_boot_weak_hash enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] DMI: SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    0.000000] DMI: Memory slots populated: 1/1
[    0.000000] Hypervisor detected: KVM
[    0.000000] last_pfn = 0x1ffdf max_arch_pfn = 0x400000000
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000001] kvm-clock: using sched offset of 376987571 cycles
[    0.000004] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000009] tsc: Detected 1995.312 MHz processor
[    0.000890] e820: update [mem 0x00000000-0x00000fff] System RAM ==> device reserved
[    0.000893] e820: remove [mem 0x000a0000-0x000fffff] System RAM
[    0.000899] last_pfn = 0x1ffdf max_arch_pfn = 0x400000000
[    0.000934] MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
[    0.000938] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.006733] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
[    0.006834] ACPI: Early table checksum verification disabled
[    0.006838] ACPI: RSDP 0x00000000000F59D0 000014 (v00 BOCHS )
[    0.006842] ACPI: RSDT 0x000000001FFE2878 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006849] ACPI: FACP 0x000000001FFE25F0 0000F4 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006854] ACPI: DSDT 0x000000001FFE0040 0025B0 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006858] ACPI: FACS 0x000000001FFE0000 000040
[    0.006861] ACPI: APIC 0x000000001FFE26E4 0000F8 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006864] ACPI: HPET 0x000000001FFE27DC 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006867] ACPI: MCFG 0x000000001FFE2814 00003C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006870] ACPI: WAET 0x000000001FFE2850 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006872] ACPI: Reserving FACP table memory at [mem 0x1ffe25f0-0x1ffe26e3]
[    0.006874] ACPI: Reserving DSDT table memory at [mem 0x1ffe0040-0x1ffe25ef]
[    0.006875] ACPI: Reserving FACS table memory at [mem 0x1ffe0000-0x1ffe003f]
[    0.006876] ACPI: Reserving APIC table memory at [mem 0x1ffe26e4-0x1ffe27db]
[    0.006877] ACPI: Reserving HPET table memory at [mem 0x1ffe27dc-0x1ffe2813]
[    0.006878] ACPI: Reserving MCFG table memory at [mem 0x1ffe2814-0x1ffe284f]
[    0.006879] ACPI: Reserving WAET table memory at [mem 0x1ffe2850-0x1ffe2877]
[    0.007114] No NUMA configuration found
[    0.007115] Faking a node at [mem 0x0000000000000000-0x000000001ffdefff]
[    0.007119] NODE_DATA(0) allocated [mem 0x1ffdb680-0x1ffdefff]
[    0.007364] ACPI: PM-Timer IO Port: 0x608
[    0.007376] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.007401] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.007405] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.007407] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.007408] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.007410] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.007411] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.007416] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.007417] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.007422] CPU topo: Max. logical packages:   1
[    0.007424] CPU topo: Max. logical nodes:      1
[    0.007424] CPU topo: Num. nodes per package:  1
[    0.007428] CPU topo: Max. logical dies:       1
[    0.007428] CPU topo: Max. dies per package:   1
[    0.007434] CPU topo: Max. threads per core:   1
[    0.007435] CPU topo: Num. cores per package:    17
[    0.007436] CPU topo: Num. threads per package:  17
[    0.007436] CPU topo: Allowing 17 present CPUs plus 0 hotplug CPUs
[    0.007450] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
[    0.007464] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.007466] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.007468] [gap 0x20000000-0xafffffff] available for PCI devices
[    0.007470] Booting paravirtualized kernel on KVM
[    0.007472] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.016962] Zone ranges:
[    0.016964]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.016966]   DMA32    [mem 0x0000000001000000-0x000000001ffdefff]
[    0.016968]   Normal   empty
[    0.016970] Movable zone start for each node
[    0.016971] Early memory node ranges
[    0.016971]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.016973]   node   0: [mem 0x0000000000100000-0x000000001ffdefff]
[    0.016975] Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffdefff]
[    0.017295] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.017320] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.019014] On node 0, zone DMA32: 33 pages in unavailable ranges
[    0.019021] setup_percpu: NR_CPUS:64 nr_cpumask_bits:17 nr_cpu_ids:17 nr_node_ids:1
[    0.023850] percpu: Embedded 54 pages/cpu s183384 r8192 d29608 u524288
[    0.023860] pcpu-alloc: s183384 r8192 d29608 u524288 alloc=1*2097152
[    0.023863] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.023869] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    0.023874] pcpu-alloc: [0] 16 -- -- -- 
[    0.023905] Kernel command line: debug_boot_weak_hash panic=-1 selinux=0 initcall_debug debug console=ttyS0 rcutorture.onoff_interval=1000 rcutorture.onoff_holdoff=30 rcutorture.n_barrier_cbs=4 rcutorture.stat_interval=15 rcutorture.shutdown_secs=3600 rcutorture.test_no_idle_hz=1 rcutorture.verbose=1 maxcpus=8 nr_cpus=17 rcutree.gp_preinit_delay=3 rcutree.gp_init_delay=3 rcutree.gp_cleanup_delay=3 rcu_nocbs=0-1,3-7 rcutorture.nocbs_nthreads=8 rcutorture.nocbs_toggle=1000 rcutorture.fwd_progress=0
[    0.024029] printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes
[    0.024092] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.024124] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.024379] Fallback order for Node 0: 0 
[    0.024384] Built 1 zonelists, mobility grouping on.  Total pages: 130941
[    0.024386] Policy zone: DMA32
[    0.024387] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.026340] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=17, Nodes=1
[    0.026382] Kernel/User page tables isolation: enabled
[    0.026536] Dynamic Preempt: full
[    0.027034] rcu: Preemptible hierarchical RCU implementation.
[    0.027036] rcu: 	RCU event tracing is enabled.
[    0.027037] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=17.
[    0.027039] rcu: 	RCU debug GP pre-init slowdown 3 jiffies.
[    0.027041] rcu: 	RCU debug GP init slowdown 3 jiffies.
[    0.027042] rcu: 	RCU debug GP cleanup slowdown 3 jiffies.
[    0.027044] 	Trampoline variant of Tasks RCU enabled.
[    0.027045] 	Tracing variant of Tasks RCU enabled.
[    0.027046] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.027047] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=17
[    0.027072] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=17.
[    0.033597] NR_IRQS: 4352, nr_irqs: 560, preallocated irqs: 16
[    0.033851] rcu: 	Offload RCU callbacks from CPUs: 0-1,3-7.
[    0.033857] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.033868] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.033951] entering initcall level: console
[    0.033953] calling  con_init+0x0/0x260 @ 0
[    0.039665] Console: colour VGA+ 80x25
[    0.039668] initcall con_init+0x0/0x260 returned 0 after 0 usecs
[    0.039674] calling  hvc_console_init+0x0/0x20 @ 0
[    0.039679] initcall hvc_console_init+0x0/0x20 returned 0 after 0 usecs
[    0.039682] calling  univ8250_console_init+0x0/0x30 @ 0
[    0.039716] printk: legacy console [ttyS0] enabled
[    0.254838] initcall univ8250_console_init+0x0/0x30 returned 0 after 0 usecs
[    0.256690] ACPI: Core revision 20260408
[    0.258192] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.260616] APIC: Switch to symmetric I/O mode setup
[    0.262139] x2apic enabled
[    0.263136] APIC: Switched APIC routing to: physical x2apic
[    0.266411] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.268353] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3985c314e25, max_idle_ns: 881590612270 ns
[    0.271304] Calibrating delay loop (skipped) preset value.. 3990.62 BogoMIPS (lpj=1995312)
[    0.272448] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.273299] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.274304] mitigations: Enabled attack vectors: user_kernel, user_user, SMT mitigations: auto
[    0.275300] Speculative Store Bypass: Vulnerable
[    0.276300] Spectre V2 : Mitigation: Retpolines
[    0.277299] ITS: Mitigation: Aligned branch/return thunks
[    0.278299] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.279299] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.280299] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT
[    0.281301] active return thunk: its_return_thunk
[    0.282301] x86/fpu: x87 FPU will use FXSAVE
[    0.316222] pid_max: default: 32768 minimum: 301
[    0.316480] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.317300] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.318420] VFS: Finished mounting rootfs on nullfs
[    0.422043] smpboot: CPU0: Intel Common KVM processor (family: 0xf, model: 0x6, stepping: 0x1)
[    0.422634] entering initcall level: early
[    0.423300] calling  init_hw_perf_events+0x0/0x770 @ 1
[    0.423972] Performance Events: unsupported Netburst CPU model 6 no PMU driver, software events only.
[    0.424299] initcall init_hw_perf_events+0x0/0x770 returned 0 after 1000 usecs
[    0.425299] calling  bts_init+0x0/0x110 @ 1
[    0.426298] initcall bts_init+0x0/0x110 returned -19 after 0 usecs
[    0.427299] calling  do_init_real_mode+0x0/0x20 @ 1
[    0.428313] initcall do_init_real_mode+0x0/0x20 returned 0 after 1000 usecs
[    0.429255] calling  init_sigframe_size+0x0/0x40 @ 1
[    0.429299] signal: max sigframe size: 1440
[    0.430298] initcall init_sigframe_size+0x0/0x40 returned 0 after 1000 usecs
[    0.431299] calling  trace_init_perf_perm_irq_work_exit+0x0/0x20 @ 1
[    0.432299] initcall trace_init_perf_perm_irq_work_exit+0x0/0x20 returned 0 after 0 usecs
[    0.433300] calling  cache_ap_register+0x0/0x50 @ 1
[    0.434299] initcall cache_ap_register+0x0/0x50 returned 0 after 0 usecs
[    0.435299] calling  bp_init_aperfmperf+0x0/0x3d0 @ 1
[    0.436299] initcall bp_init_aperfmperf+0x0/0x3d0 returned 0 after 0 usecs
[    0.437300] calling  save_builtin_microcode+0x0/0xd0 @ 1
[    0.438301] initcall save_builtin_microcode+0x0/0xd0 returned 0 after 0 usecs
[    0.439311] calling  save_microcode_in_initrd+0x0/0x1b0 @ 1
[    0.440301] initcall save_microcode_in_initrd+0x0/0x1b0 returned 0 after 0 usecs
[    0.441301] calling  register_nmi_cpu_backtrace_handler+0x0/0x20 @ 1
[    0.442302] initcall register_nmi_cpu_backtrace_handler+0x0/0x20 returned 0 after 0 usecs
[    0.443302] calling  kvm_setup_vsyscall_timeinfo+0x0/0x100 @ 1
[    0.445298] initcall kvm_setup_vsyscall_timeinfo+0x0/0x100 returned 0 after 0 usecs
[    0.446302] calling  spawn_ksoftirqd+0x0/0x60 @ 1
[    0.447375] initcall spawn_ksoftirqd+0x0/0x60 returned 0 after 0 usecs
[    0.448301] calling  init_signal_sysctls+0x0/0x50 @ 1
[    0.449307] initcall init_signal_sysctls+0x0/0x50 returned 0 after 0 usecs
[    0.450301] calling  init_umh_sysctls+0x0/0x30 @ 1
[    0.451305] initcall init_umh_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.452302] calling  kthreads_init+0x0/0x30 @ 1
[    0.453303] initcall kthreads_init+0x0/0x30 returned 0 after 0 usecs
[    0.454302] calling  migration_init+0x0/0x40 @ 1
[    0.455302] initcall migration_init+0x0/0x40 returned 0 after 0 usecs
[    0.456301] calling  printk_set_kthreads_ready+0x0/0x40 @ 1
[    0.457302] initcall printk_set_kthreads_ready+0x0/0x40 returned 0 after 0 usecs
[    0.458301] calling  srcu_bootup_announce+0x0/0x80 @ 1
[    0.459301] rcu: Hierarchical SRCU implementation.
[    0.460301] rcu: 	Max phase no-delay instances is 400.
[    0.461301] initcall srcu_bootup_announce+0x0/0x80 returned 0 after 2000 usecs
[    0.462301] calling  rcu_spawn_gp_kthread+0x0/0x260 @ 1
[    0.463484] initcall rcu_spawn_gp_kthread+0x0/0x260 returned 0 after 0 usecs
[    0.464301] calling  check_cpu_stall_init+0x0/0x20 @ 1
[    0.465300] initcall check_cpu_stall_init+0x0/0x20 returned 0 after 0 usecs
[    0.466299] calling  rcu_sysrq_init+0x0/0x30 @ 1
[    0.467298] initcall rcu_sysrq_init+0x0/0x30 returned 0 after 0 usecs
[    0.468299] calling  trace_init_flags_sys_enter+0x0/0x20 @ 1
[    0.469299] initcall trace_init_flags_sys_enter+0x0/0x20 returned 0 after 0 usecs
[    0.470299] calling  trace_init_flags_sys_exit+0x0/0x20 @ 1
[    0.471299] initcall trace_init_flags_sys_exit+0x0/0x20 returned 0 after 0 usecs
[    0.472298] calling  tmigr_init+0x0/0x130 @ 1
[    0.473299] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.474303] initcall tmigr_init+0x0/0x130 returned 0 after 1000 usecs
[    0.475299] calling  cpu_stop_init+0x0/0xc0 @ 1
[    0.476348] initcall cpu_stop_init+0x0/0xc0 returned 0 after 0 usecs
[    0.477299] calling  init_kprobes+0x0/0x210 @ 1
[    0.478449] initcall init_kprobes+0x0/0x210 returned 0 after 0 usecs
[    0.479299] calling  init_trace_printk+0x0/0x10 @ 1
[    0.480299] initcall init_trace_printk+0x0/0x10 returned 0 after 0 usecs
[    0.481299] calling  event_trace_enable_again+0x0/0x80 @ 1
[    0.482299] initcall event_trace_enable_again+0x0/0x80 returned 0 after 0 usecs
[    0.483299] calling  irq_work_init_threads+0x0/0x10 @ 1
[    0.484299] initcall irq_work_init_threads+0x0/0x10 returned 0 after 0 usecs
[    0.485299] calling  static_call_init+0x0/0xd0 @ 1
[    0.494530] initcall static_call_init+0x0/0xd0 returned 0 after 8000 usecs
[    0.495299] calling  jump_label_init_module+0x0/0x10 @ 1
[    0.496299] initcall jump_label_init_module+0x0/0x10 returned 0 after 0 usecs
[    0.497299] calling  init_fs_inode_sysctls+0x0/0x30 @ 1
[    0.498301] initcall init_fs_inode_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.499299] calling  init_fs_locks_sysctls+0x0/0x30 @ 1
[    0.500300] initcall init_fs_locks_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.501299] calling  init_fs_sysctls+0x0/0x30 @ 1
[    0.502300] initcall init_fs_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.503298] calling  init_security_keys_sysctls+0x0/0x30 @ 1
[    0.504301] initcall init_security_keys_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.505299] calling  security_initcall_early+0x0/0xd0 @ 1
[    0.506299] initcall security_initcall_early+0x0/0xd0 returned 0 after 0 usecs
[    0.507298] calling  efi_memreserve_root_init+0x0/0x30 @ 1
[    0.508299] initcall efi_memreserve_root_init+0x0/0x30 returned 0 after 0 usecs
[    0.509298] calling  efi_earlycon_remap_fb+0x0/0x70 @ 1
[    0.510299] initcall efi_earlycon_remap_fb+0x0/0x70 returned 0 after 0 usecs
[    0.511564] smp: Bringing up secondary CPUs ...
[    0.512475] smpboot: x86: Booting SMP configuration:
[    0.513317] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.524341] smp: Brought up 1 node, 8 CPUs
[    0.526302] smpboot: Total of 8 processors activated (31924.99 BogoMIPS)
[    0.528676] Memory: 463088K/523764K available (19180K kernel code, 3010K rwdata, 8080K rodata, 2992K init, 608K bss, 54996K reserved, 0K cma-reserved)
[    0.529416] devtmpfs: initialized
[    0.531346] entering initcall level: pure
[    0.531934] calling  setup_split_lock_delayed_work+0x0/0xc0 @ 1
[    0.532302] initcall setup_split_lock_delayed_work+0x0/0xc0 returned 0 after 0 usecs
[    0.533299] calling  param_sysfs_init+0x0/0x50 @ 1
[    0.534301] initcall param_sysfs_init+0x0/0x50 returned 0 after 0 usecs
[    0.535299] calling  ipc_ns_init+0x0/0x70 @ 1
[    0.536306] initcall ipc_ns_init+0x0/0x70 returned 0 after 0 usecs
[    0.537300] calling  mmap_min_addr_init+0x0/0x50 @ 1
[    0.538311] initcall mmap_min_addr_init+0x0/0x50 returned 0 after 0 usecs
[    0.539304] calling  security_initcall_pure+0x0/0xd0 @ 1
[    0.540302] initcall security_initcall_pure+0x0/0xd0 returned 0 after 0 usecs
[    0.541302] calling  pci_realloc_setup_params+0x0/0x80 @ 1
[    0.542302] initcall pci_realloc_setup_params+0x0/0x80 returned 0 after 0 usecs
[    0.543302] calling  inet_frag_wq_init+0x0/0x40 @ 1
[    0.544338] initcall inet_frag_wq_init+0x0/0x40 returned 0 after 0 usecs
[    0.545370] entering initcall level: core
[    0.546302] calling  e820__register_nvs_regions+0x0/0x60 @ 1
[    0.548301] initcall e820__register_nvs_regions+0x0/0x60 returned 0 after 0 usecs
[    0.549302] calling  cpufreq_register_tsc_scaling+0x0/0x40 @ 1
[    0.550302] initcall cpufreq_register_tsc_scaling+0x0/0x40 returned 0 after 0 usecs
[    0.551302] calling  reboot_init+0x0/0x50 @ 1
[    0.552305] initcall reboot_init+0x0/0x50 returned 0 after 0 usecs
[    0.553302] calling  init_lapic_sysfs+0x0/0x30 @ 1
[    0.554302] initcall init_lapic_sysfs+0x0/0x30 returned 0 after 0 usecs
[    0.555301] calling  alloc_frozen_cpus+0x0/0x10 @ 1
[    0.556302] initcall alloc_frozen_cpus+0x0/0x10 returned 0 after 0 usecs
[    0.557301] calling  cpu_hotplug_pm_sync_init+0x0/0x20 @ 1
[    0.558300] initcall cpu_hotplug_pm_sync_init+0x0/0x20 returned 0 after 0 usecs
[    0.559299] calling  wq_sysfs_init+0x0/0x20 @ 1
[    0.560338] initcall wq_sysfs_init+0x0/0x20 returned 0 after 0 usecs
[    0.561300] calling  schedutil_gov_init+0x0/0x10 @ 1
[    0.562300] initcall schedutil_gov_init+0x0/0x10 returned 0 after 0 usecs
[    0.563299] calling  membarrier_init+0x0/0x80 @ 1
[    0.564302] initcall membarrier_init+0x0/0x80 returned 0 after 0 usecs
[    0.565299] calling  pm_init+0x0/0xb0 @ 1
[    0.566347] initcall pm_init+0x0/0xb0 returned 0 after 0 usecs
[    0.567299] calling  pm_disk_init+0x0/0x20 @ 1
[    0.568302] initcall pm_disk_init+0x0/0x20 returned 0 after 0 usecs
[    0.569299] calling  swsusp_header_init+0x0/0x60 @ 1
[    0.570300] initcall swsusp_header_init+0x0/0x60 returned 0 after 0 usecs
[    0.571299] calling  rcu_set_runtime_mode+0x0/0x20 @ 1
[    0.572300] initcall rcu_set_runtime_mode+0x0/0x20 returned 0 after 0 usecs
[    0.573299] calling  rcu_init_tasks_generic+0x0/0xd0 @ 1
[    0.574343] initcall rcu_init_tasks_generic+0x0/0xd0 returned 0 after 0 usecs
[    0.575301] calling  posixtimer_init+0x0/0x110 @ 1
[    0.576306] posixtimers hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.577332] initcall posixtimer_init+0x0/0x110 returned 0 after 1000 usecs
[    0.578299] calling  futex_init+0x0/0x1c0 @ 1
[    0.580328] futex hash table entries: 8192 (524288 bytes on 1 NUMA nodes, total 512 KiB, linear).
[    0.581299] initcall futex_init+0x0/0x1c0 returned 0 after 2000 usecs
[    0.582299] calling  cgroup_wq_init+0x0/0x80 @ 1
[    0.583332] initcall cgroup_wq_init+0x0/0x80 returned 0 after 0 usecs
[    0.584299] calling  cgroup1_wq_init+0x0/0x30 @ 1
[    0.585310] initcall cgroup1_wq_init+0x0/0x30 returned 0 after 0 usecs
[    0.586299] calling  trace_events_eprobe_init_early+0x0/0x40 @ 1
[    0.587299] initcall trace_events_eprobe_init_early+0x0/0x40 returned 0 after 0 usecs
[    0.589299] calling  init_kprobe_trace_early+0x0/0x40 @ 1
[    0.590300] initcall init_kprobe_trace_early+0x0/0x40 returned 0 after 0 usecs
[    0.591299] calling  init_events_core_sysctls+0x0/0x30 @ 1
[    0.592304] initcall init_events_core_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.593301] calling  init_callchain_sysctls+0x0/0x30 @ 1
[    0.594301] initcall init_callchain_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.595299] calling  fsnotify_init+0x0/0x30 @ 1
[    0.596328] initcall fsnotify_init+0x0/0x30 returned 0 after 0 usecs
[    0.597299] calling  filelock_init+0x0/0x1a0 @ 1
[    0.598312] initcall filelock_init+0x0/0x1a0 returned 0 after 0 usecs
[    0.599299] calling  init_misc_binfmt+0x0/0x50 @ 1
[    0.600301] initcall init_misc_binfmt+0x0/0x50 returned 0 after 0 usecs
[    0.601299] calling  init_script_binfmt+0x0/0x20 @ 1
[    0.602299] initcall init_script_binfmt+0x0/0x20 returned 0 after 0 usecs
[    0.603299] calling  init_elf_binfmt+0x0/0x20 @ 1
[    0.604299] initcall init_elf_binfmt+0x0/0x20 returned 0 after 0 usecs
[    0.605298] calling  init_compat_elf_binfmt+0x0/0x20 @ 1
[    0.606298] initcall init_compat_elf_binfmt+0x0/0x20 returned 0 after 0 usecs
[    0.607299] calling  debugfs_init+0x0/0x120 @ 1
[    0.608311] initcall debugfs_init+0x0/0x120 returned 0 after 0 usecs
[    0.609300] calling  tracefs_init+0x0/0xd0 @ 1
[    0.610308] initcall tracefs_init+0x0/0xd0 returned 0 after 0 usecs
[    0.611299] calling  security_initcall_core+0x0/0xd0 @ 1
[    0.612300] initcall security_initcall_core+0x0/0xd0 returned 0 after 0 usecs
[    0.613299] calling  virtio_init+0x0/0x30 @ 1
[    0.614315] initcall virtio_init+0x0/0x30 returned 0 after 0 usecs
[    0.615299] calling  iommu_init+0x0/0x30 @ 1
[    0.616301] initcall iommu_init+0x0/0x30 returned 0 after 0 usecs
[    0.617299] calling  component_debug_init+0x0/0x20 @ 1
[    0.618336] initcall component_debug_init+0x0/0x20 returned 0 after 0 usecs
[    0.619299] calling  early_resume_init+0x0/0xe0 @ 1
[    0.620351] PM: RTC time: 19:01:19, date: 2026-07-23
[    0.621300] initcall early_resume_init+0x0/0xe0 returned 0 after 1000 usecs
[    0.622299] calling  cpufreq_core_init+0x0/0xa0 @ 1
[    0.623303] initcall cpufreq_core_init+0x0/0xa0 returned 0 after 0 usecs
[    0.624299] calling  cpufreq_gov_performance_init+0x0/0x10 @ 1
[    0.625300] initcall cpufreq_gov_performance_init+0x0/0x10 returned 0 after 0 usecs
[    0.626300] calling  cpufreq_gov_userspace_init+0x0/0x10 @ 1
[    0.627299] initcall cpufreq_gov_userspace_init+0x0/0x10 returned 0 after 0 usecs
[    0.628299] calling  CPU_FREQ_GOV_ONDEMAND_init+0x0/0x10 @ 1
[    0.629301] initcall CPU_FREQ_GOV_ONDEMAND_init+0x0/0x10 returned 0 after 0 usecs
[    0.630299] calling  cpuidle_init+0x0/0x20 @ 1
[    0.631306] initcall cpuidle_init+0x0/0x20 returned 0 after 0 usecs
[    0.632299] calling  sock_init+0x0/0x110 @ 1
[    0.633540] initcall sock_init+0x0/0x110 returned 0 after 0 usecs
[    0.634302] calling  net_inuse_init+0x0/0x30 @ 1
[    0.635309] initcall net_inuse_init+0x0/0x30 returned 0 after 0 usecs
[    0.636302] calling  sock_struct_check+0x0/0x10 @ 1
[    0.637302] initcall sock_struct_check+0x0/0x10 returned 0 after 0 usecs
[    0.638302] calling  init_default_flow_dissectors+0x0/0x60 @ 1
[    0.639302] initcall init_default_flow_dissectors+0x0/0x60 returned 0 after 0 usecs
[    0.640302] calling  netlink_proto_init+0x0/0x190 @ 1
[    0.641409] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.642325] initcall netlink_proto_init+0x0/0x190 returned 0 after 1000 usecs
[    0.643303] calling  genl_init+0x0/0x50 @ 1
[    0.645305] initcall genl_init+0x0/0x50 returned 0 after 1000 usecs
[    0.646302] calling  bsp_pm_check_init+0x0/0x20 @ 1
[    0.647302] initcall bsp_pm_check_init+0x0/0x20 returned 0 after 0 usecs
[    0.648361] entering initcall level: postcore
[    0.649302] calling  alloc_taint_buf+0x0/0x70 @ 1
[    0.650304] initcall alloc_taint_buf+0x0/0x70 returned 0 after 0 usecs
[    0.651302] calling  init_overflow_sysctl+0x0/0x30 @ 1
[    0.652307] initcall init_overflow_sysctl+0x0/0x30 returned 0 after 0 usecs
[    0.653302] calling  irq_sysfs_init+0x0/0xe0 @ 1
[    0.655456] initcall irq_sysfs_init+0x0/0xe0 returned 0 after 1000 usecs
[    0.656302] calling  audit_init+0x0/0x1d0 @ 1
[    0.657305] audit: initializing netlink subsys (disabled)
[    0.658356] initcall audit_init+0x0/0x1d0 returned 0 after 1000 usecs
[    0.658356] audit: type=2000 audit(1784833279.575:1): state=initialized audit_enabled=0 res=1
[    0.660302] calling  bdi_class_init+0x0/0x40 @ 1
[    0.661325] initcall bdi_class_init+0x0/0x40 returned 0 after 0 usecs
[    0.662301] calling  mm_sysfs_init+0x0/0x30 @ 1
[    0.663306] initcall mm_sysfs_init+0x0/0x30 returned 0 after 0 usecs
[    0.664302] calling  init_per_zone_wmark_min+0x0/0x30 @ 1
[    0.665311] initcall init_per_zone_wmark_min+0x0/0x30 returned 0 after 0 usecs
[    0.666302] calling  pcibus_class_init+0x0/0x10 @ 1
[    0.667312] initcall pcibus_class_init+0x0/0x10 returned 0 after 0 usecs
[    0.668302] calling  pci_driver_init+0x0/0x50 @ 1
[    0.669356] initcall pci_driver_init+0x0/0x50 returned 0 after 0 usecs
[    0.670302] calling  backlight_class_init+0x0/0x60 @ 1
[    0.671312] initcall backlight_class_init+0x0/0x60 returned 0 after 0 usecs
[    0.672302] calling  tty_class_init+0x0/0x10 @ 1
[    0.673310] initcall tty_class_init+0x0/0x10 returned 0 after 0 usecs
[    0.674304] calling  vtconsole_class_init+0x0/0xc0 @ 1
[    0.675348] initcall vtconsole_class_init+0x0/0xc0 returned 0 after 0 usecs
[    0.676302] calling  iommu_dev_init+0x0/0x10 @ 1
[    0.677309] initcall iommu_dev_init+0x0/0x10 returned 0 after 0 usecs
[    0.678302] calling  mipi_dsi_bus_init+0x0/0x10 @ 1
[    0.679322] initcall mipi_dsi_bus_init+0x0/0x10 returned 0 after 0 usecs
[    0.680302] calling  devlink_class_init+0x0/0x50 @ 1
[    0.681311] initcall devlink_class_init+0x0/0x50 returned 0 after 0 usecs
[    0.682302] calling  wakeup_sources_init+0x0/0x30 @ 1
[    0.683311] initcall wakeup_sources_init+0x0/0x30 returned 0 after 0 usecs
[    0.684302] calling  wakeup_sources_sysfs_init+0x0/0x30 @ 1
[    0.685325] initcall wakeup_sources_sysfs_init+0x0/0x30 returned 0 after 0 usecs
[    0.686302] calling  regmap_initcall+0x0/0x10 @ 1
[    0.687310] initcall regmap_initcall+0x0/0x10 returned 0 after 0 usecs
[    0.688302] calling  i2c_init+0x0/0xb0 @ 1
[    0.689337] initcall i2c_init+0x0/0xb0 returned 0 after 0 usecs
[    0.690304] calling  thermal_init+0x0/0x270 @ 1
[    0.691354] thermal_sys: Registered thermal governor 'step_wise'
[    0.691364] initcall thermal_init+0x0/0x270 returned 0 after 0 usecs
[    0.693300] calling  init_menu+0x0/0x10 @ 1
[    0.694319] cpuidle: using governor menu
[    0.695300] initcall init_menu+0x0/0x10 returned 0 after 1000 usecs
[    0.696299] calling  init_haltpoll+0x0/0x20 @ 1
[    0.697299] initcall init_haltpoll+0x0/0x20 returned 0 after 0 usecs
[    0.698299] calling  efipostcore_init+0x0/0x70 @ 1
[    0.699299] initcall efipostcore_init+0x0/0x70 returned 0 after 0 usecs
[    0.700299] calling  pcc_init+0x0/0x70 @ 1
[    0.701301] initcall pcc_init+0x0/0x70 returned -19 after 0 usecs
[    0.702299] calling  amd_postcore_init+0x0/0x130 @ 1
[    0.703299] initcall amd_postcore_init+0x0/0x130 returned 0 after 0 usecs
[    0.704299] calling  kobject_uevent_init+0x0/0x10 @ 1
[    0.705307] initcall kobject_uevent_init+0x0/0x10 returned 0 after 0 usecs
[    0.706336] entering initcall level: arch
[    0.707299] calling  pt_init+0x0/0x3f0 @ 1
[    0.708299] initcall pt_init+0x0/0x3f0 returned -19 after 0 usecs
[    0.709301] calling  init_x86_sysctl+0x0/0x30 @ 1
[    0.710307] initcall init_x86_sysctl+0x0/0x30 returned 0 after 0 usecs
[    0.711299] calling  boot_params_ksysfs_init+0x0/0x330 @ 1
[    0.712306] initcall boot_params_ksysfs_init+0x0/0x330 returned 0 after 0 usecs
[    0.713299] calling  sbf_init+0x0/0xf0 @ 1
[    0.714299] initcall sbf_init+0x0/0xf0 returned 0 after 0 usecs
[    0.715299] calling  arch_kdebugfs_init+0x0/0x220 @ 1
[    0.716310] initcall arch_kdebugfs_init+0x0/0x220 returned 0 after 0 usecs
[    0.717299] calling  free_smp_locks+0x0/0x40 @ 1
[    0.718402] Freeing SMP alternatives memory: 56K
[    0.719299] initcall free_smp_locks+0x0/0x40 returned 0 after 1000 usecs
[    0.720299] calling  xfd_update_static_branch+0x0/0x30 @ 1
[    0.721299] initcall xfd_update_static_branch+0x0/0x30 returned 0 after 0 usecs
[    0.722299] calling  mtrr_if_init+0x0/0x70 @ 1
[    0.723303] initcall mtrr_if_init+0x0/0x70 returned 0 after 0 usecs
[    0.724299] calling  activate_jump_labels+0x0/0x40 @ 1
[    0.725304] initcall activate_jump_labels+0x0/0x40 returned 0 after 0 usecs
[    0.726303] calling  init_s4_sigcheck+0x0/0x30 @ 1
[    0.727299] initcall init_s4_sigcheck+0x0/0x30 returned 0 after 0 usecs
[    0.728299] calling  ffh_cstate_init+0x0/0x50 @ 1
[    0.729305] initcall ffh_cstate_init+0x0/0x50 returned 0 after 0 usecs
[    0.730301] calling  kvm_alloc_cpumask+0x0/0xf0 @ 1
[    0.731302] initcall kvm_alloc_cpumask+0x0/0xf0 returned 0 after 0 usecs
[    0.732299] calling  activate_jump_labels+0x0/0x40 @ 1
[    0.733397] initcall activate_jump_labels+0x0/0x40 returned 0 after 0 usecs
[    0.734299] calling  efi_free_boot_services+0x0/0xa0 @ 1
[    0.735299] initcall efi_free_boot_services+0x0/0xa0 returned 0 after 0 usecs
[    0.736299] calling  kcmp_cookies_init+0x0/0x40 @ 1
[    0.737303] initcall kcmp_cookies_init+0x0/0x40 returned 0 after 0 usecs
[    0.738299] calling  acpi_pci_init+0x0/0x50 @ 1
[    0.739299] initcall acpi_pci_init+0x0/0x50 returned 0 after 0 usecs
[    0.740299] calling  dma_channel_table_init+0x0/0x120 @ 1
[    0.741318] initcall dma_channel_table_init+0x0/0x120 returned 0 after 0 usecs
[    0.742299] calling  dma_bus_init+0x0/0x160 @ 1
[    0.743323] initcall dma_bus_init+0x0/0x160 returned 0 after 0 usecs
[    0.744299] calling  serial_base_init+0x0/0x70 @ 1
[    0.745320] initcall serial_base_init+0x0/0x70 returned 0 after 0 usecs
[    0.746299] calling  iommu_dma_init+0x0/0x20 @ 1
[    0.747301] initcall iommu_dma_init+0x0/0x20 returned 0 after 0 usecs
[    0.748299] calling  dmi_id_init+0x0/0x3e0 @ 1
[    0.749348] initcall dmi_id_init+0x0/0x3e0 returned 0 after 0 usecs
[    0.750299] calling  pci_arch_init+0x0/0x90 @ 1
[    0.751348] PCI: ECAM [mem 0xb0000000-0xbfffffff] (base 0xb0000000) for domain 0000 [bus 00-ff]
[    0.752302] PCI: ECAM [mem 0xb0000000-0xbfffffff] reserved as E820 entry
[    0.753313] PCI: Using configuration type 1 for base access
[    0.754302] initcall pci_arch_init+0x0/0x90 returned 0 after 3000 usecs
[    0.755338] entering initcall level: subsys
[    0.756299] calling  init_vdso64_image+0x0/0x10 @ 1
[    0.757306] initcall init_vdso64_image+0x0/0x10 returned 0 after 0 usecs
[    0.758300] calling  init_vdso32_image+0x0/0x10 @ 1
[    0.759309] initcall init_vdso32_image+0x0/0x10 returned 0 after 0 usecs
[    0.760299] calling  fixup_ht_bug+0x0/0x140 @ 1
[    0.761299] initcall fixup_ht_bug+0x0/0x140 returned 0 after 0 usecs
[    0.762299] calling  mtrr_init_finalize+0x0/0x40 @ 1
[    0.763300] initcall mtrr_init_finalize+0x0/0x40 returned 0 after 0 usecs
[    0.764306] calling  init_fork_sysctl+0x0/0x30 @ 1
[    0.765306] initcall init_fork_sysctl+0x0/0x30 returned 0 after 0 usecs
[    0.766300] calling  uid_cache_init+0x0/0x110 @ 1
[    0.767308] initcall uid_cache_init+0x0/0x110 returned 0 after 0 usecs
[    0.768300] calling  pid_namespace_sysctl_init+0x0/0x20 @ 1
[    0.769306] initcall pid_namespace_sysctl_init+0x0/0x20 returned 0 after 0 usecs
[    0.770301] calling  user_namespace_sysctl_init+0x0/0xf0 @ 1
[    0.771315] initcall user_namespace_sysctl_init+0x0/0xf0 returned 0 after 0 usecs
[    0.772303] calling  proc_schedstat_init+0x0/0x30 @ 1
[    0.773307] initcall proc_schedstat_init+0x0/0x30 returned 0 after 0 usecs
[    0.774304] calling  init_rtmutex_sysctl+0x0/0x30 @ 1
[    0.775305] initcall init_rtmutex_sysctl+0x0/0x30 returned 0 after 0 usecs
[    0.776303] calling  pm_sysrq_init+0x0/0x20 @ 1
[    0.777318] initcall pm_sysrq_init+0x0/0x20 returned 0 after 0 usecs
[    0.778306] calling  init_rcu_stall_sysctl+0x0/0x30 @ 1
[    0.779305] initcall init_rcu_stall_sysctl+0x0/0x30 returned 0 after 0 usecs
[    0.780301] calling  init_module_sysctl+0x0/0x30 @ 1
[    0.781301] initcall init_module_sysctl+0x0/0x30 returned 0 after 0 usecs
[    0.782300] calling  create_proc_profile+0x0/0x60 @ 1
[    0.783299] initcall create_proc_profile+0x0/0x60 returned 0 after 0 usecs
[    0.784300] calling  crash_save_vmcoreinfo_init+0x0/0x690 @ 1
[    0.785345] initcall crash_save_vmcoreinfo_init+0x0/0x690 returned 0 after 0 usecs
[    0.786300] calling  init_kexec_sysctl+0x0/0xe0 @ 1
[    0.787317] initcall init_kexec_sysctl+0x0/0xe0 returned 0 after 0 usecs
[    0.788299] calling  crash_notes_memory_init+0x0/0x50 @ 1
[    0.789306] initcall crash_notes_memory_init+0x0/0x50 returned 0 after 0 usecs
[    0.790301] calling  crash_hotplug_init+0x0/0x30 @ 1
[    0.791301] initcall crash_hotplug_init+0x0/0x30 returned 63 after 0 usecs
[    0.792299] calling  cgroup_sysfs_init+0x0/0x20 @ 1
[    0.793303] initcall cgroup_sysfs_init+0x0/0x20 returned 0 after 0 usecs
[    0.794299] calling  init_optprobes+0x0/0x60 @ 1
[    0.795301] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.796300] initcall init_optprobes+0x0/0x60 returned 0 after 1000 usecs
[    0.797300] calling  init_trace_sysctls+0x0/0x30 @ 1
[    0.798306] initcall init_trace_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.799300] calling  trace_eval_init+0x0/0xc0 @ 1
[    0.800356] initcall trace_eval_init+0x0/0xc0 returned 0 after 0 usecs
[    0.801301] calling  oom_init+0x0/0x60 @ 1
[    0.802332] initcall oom_init+0x0/0x60 returned 0 after 0 usecs
[    0.803301] calling  init_user_buckets+0x0/0x30 @ 1
[    0.804300] initcall init_user_buckets+0x0/0x30 returned 0 after 0 usecs
[    0.805299] calling  init_vm_util_sysctls+0x0/0x30 @ 1
[    0.806305] initcall init_vm_util_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.807299] calling  default_bdi_init+0x0/0x30 @ 1
[    0.809333] initcall default_bdi_init+0x0/0x30 returned 0 after 1000 usecs
[    0.810300] calling  percpu_enable_async+0x0/0x20 @ 1
[    0.811300] initcall percpu_enable_async+0x0/0x20 returned 0 after 0 usecs
[    0.812299] calling  kcompactd_init+0x0/0x100 @ 1
[    0.813338] initcall kcompactd_init+0x0/0x100 returned 0 after 0 usecs
[    0.814301] calling  init_mm_sysctl+0x0/0x30 @ 1
[    0.815302] initcall init_mm_sysctl+0x0/0x30 returned 0 after 0 usecs
[    0.816300] calling  init_user_reserve+0x0/0x40 @ 1
[    0.817299] initcall init_user_reserve+0x0/0x40 returned 0 after 0 usecs
[    0.818300] calling  init_admin_reserve+0x0/0x40 @ 1
[    0.819299] initcall init_admin_reserve+0x0/0x40 returned 0 after 0 usecs
[    0.820299] calling  init_reserve_notifier+0x0/0x10 @ 1
[    0.821299] initcall init_reserve_notifier+0x0/0x10 returned 0 after 0 usecs
[    0.822299] calling  swap_init+0x0/0x80 @ 1
[    0.823304] initcall swap_init+0x0/0x80 returned 0 after 0 usecs
[    0.824299] calling  swapfile_init+0x0/0xc0 @ 1
[    0.825310] initcall swapfile_init+0x0/0xc0 returned 0 after 0 usecs
[    0.826300] calling  hugetlb_init+0x0/0x510 @ 1
[    0.827329] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.828299] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.829331] initcall hugetlb_init+0x0/0x510 returned 0 after 2000 usecs
[    0.830302] calling  memory_tier_init+0x0/0xc0 @ 1
[    0.831335] initcall memory_tier_init+0x0/0xc0 returned 0 after 0 usecs
[    0.832299] calling  numa_init_sysfs+0x0/0x80 @ 1
[    0.833301] initcall numa_init_sysfs+0x0/0x80 returned 0 after 0 usecs
[    0.834299] calling  init_msg_buckets+0x0/0x30 @ 1
[    0.835300] initcall init_msg_buckets+0x0/0x30 returned 0 after 0 usecs
[    0.836299] calling  security_initcall_subsys+0x0/0xd0 @ 1
[    0.837300] initcall security_initcall_subsys+0x0/0xd0 returned 0 after 0 usecs
[    0.838299] calling  init_bio+0x0/0xe0 @ 1
[    0.839322] initcall init_bio+0x0/0xe0 returned 0 after 0 usecs
[    0.840302] calling  blk_ioc_init+0x0/0x90 @ 1
[    0.841300] initcall blk_ioc_init+0x0/0x90 returned 0 after 0 usecs
[    0.842299] calling  blk_mq_init+0x0/0x170 @ 1
[    0.843300] initcall blk_mq_init+0x0/0x170 returned 0 after 0 usecs
[    0.844299] calling  genhd_device_init+0x0/0x50 @ 1
[    0.845345] initcall genhd_device_init+0x0/0x50 returned 0 after 0 usecs
[    0.846301] calling  io_wq_init+0x0/0x40 @ 1
[    0.847300] initcall io_wq_init+0x0/0x40 returned 0 after 0 usecs
[    0.848299] calling  crc32_mod_init+0x0/0x100 @ 1
[    0.849302] initcall crc32_mod_init+0x0/0x100 returned 0 after 0 usecs
[    0.850302] calling  aes_mod_init+0x0/0x30 @ 1
[    0.851302] initcall aes_mod_init+0x0/0x30 returned 0 after 0 usecs
[    0.852302] calling  blake2s_mod_init+0x0/0x80 @ 1
[    0.853302] initcall blake2s_mod_init+0x0/0x80 returned 0 after 0 usecs
[    0.854302] calling  gf128hash_mod_init+0x0/0x50 @ 1
[    0.856300] initcall gf128hash_mod_init+0x0/0x50 returned 0 after 0 usecs
[    0.857302] calling  sha1_mod_init+0x0/0xf0 @ 1
[    0.858302] initcall sha1_mod_init+0x0/0xf0 returned 0 after 0 usecs
[    0.859302] calling  sha256_mod_init+0x0/0x140 @ 1
[    0.860302] initcall sha256_mod_init+0x0/0x140 returned 0 after 0 usecs
[    0.861304] calling  sha512_mod_init+0x0/0xc0 @ 1
[    0.862302] initcall sha512_mod_init+0x0/0xc0 returned 0 after 0 usecs
[    0.863302] calling  sg_pool_init+0x0/0x120 @ 1
[    0.865308] initcall sg_pool_init+0x0/0x120 returned 0 after 0 usecs
[    0.866302] calling  leds_init+0x0/0x50 @ 1
[    0.868320] initcall leds_init+0x0/0x50 returned 0 after 1000 usecs
[    0.869302] calling  pci_slot_init+0x0/0x50 @ 1
[    0.870310] initcall pci_slot_init+0x0/0x50 returned 0 after 0 usecs
[    0.871302] calling  acpi_init+0x0/0x450 @ 1
[    0.872358] ACPI: Added _OSI(Module Device)
[    0.873302] ACPI: Added _OSI(Processor Device)
[    0.874303] ACPI: Added _OSI(Processor Aggregator Device)
[    0.878613] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.881325] ACPI: \_SB_: platform _OSC: OS support mask [002a7eee]
[    0.882696] ACPI: Interpreter enabled
[    0.883330] ACPI: PM: (supports S0 S3 S4 S5)
[    0.884305] ACPI: Using IOAPIC for interrupt routing
[    0.885360] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.886301] PCI: Using E820 reservations for host bridge windows
[    0.888358] ACPI: Enabled 2 GPEs in block 00 to 3F
[    0.893906] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.894305] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.895370] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    0.896394] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability]
[    0.897385] PCI host bridge to bus 0000:00
[    0.898305] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.899301] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.900300] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.901300] pci_bus 0000:00: root bus resource [mem 0x20000000-0xafffffff window]
[    0.902301] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    0.903301] pci_bus 0000:00: root bus resource [mem 0x100000000-0x8ffffffff window]
[    0.904301] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.905360] pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    0.906301] pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    0.907302] pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000 conventional PCI endpoint
[    0.908564] pci 0000:00:00.0: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
[    0.909302] pci 0000:00:00.0: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
[    0.911435] pci 0000:00:01.0: [1234:1111] type 00 class 0x030000 conventional PCI endpoint
[    0.914318] pci 0000:00:01.0: BAR 0 [mem 0xfd000000-0xfdffffff pref]
[    0.915313] pci 0000:00:01.0: BAR 2 [mem 0xfebf0000-0xfebf0fff]
[    0.916322] pci 0000:00:01.0: ROM [mem 0xfebe0000-0xfebeffff pref]
[    0.918329] pci 0000:00:01.0: calling  screen_info_fixup_lfb+0x0/0x190 @ 1
[    0.919300] pci 0000:00:01.0: screen_info_fixup_lfb+0x0/0x190 took 0 usecs
[    0.920300] pci 0000:00:01.0: calling  pci_fixup_video+0x0/0x110 @ 1
[    0.921318] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.922300] pci 0000:00:01.0: pci_fixup_video+0x0/0x110 took 976 usecs
[    0.923657] pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100 conventional PCI endpoint
[    0.924561] pci 0000:00:1f.0: calling  quirk_ich7_lpc+0x0/0x180 @ 1
[    0.925313] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by ICH6 ACPI/GPIO/TCO
[    0.926326] pci 0000:00:1f.0: quirk_ich7_lpc+0x0/0x180 took 976 usecs
[    0.927301] pci 0000:00:1f.0: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
[    0.928300] pci 0000:00:1f.0: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
[    0.929497] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601 conventional PCI endpoint
[    0.931739] pci 0000:00:1f.2: BAR 4 [io  0xc040-0xc05f]
[    0.932308] pci 0000:00:1f.2: BAR 5 [mem 0xfebf1000-0xfebf1fff]
[    0.934306] pci 0000:00:1f.2: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
[    0.935300] pci 0000:00:1f.2: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
[    0.936555] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500 conventional PCI endpoint
[    0.938688] pci 0000:00:1f.3: BAR 4 [io  0x0700-0x073f]
[    0.939330] pci 0000:00:1f.3: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
[    0.940300] pci 0000:00:1f.3: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
[    0.943189] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.943483] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.944478] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.945459] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.947320] ACPI: PCI: Interrupt link LNKE configured for IRQ 10
[    0.949454] ACPI: PCI: Interrupt link LNKF configured for IRQ 10
[    0.950448] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    0.951452] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    0.952361] ACPI: PCI: Interrupt link GSIA configured for IRQ 16
[    0.953329] ACPI: PCI: Interrupt link GSIB configured for IRQ 17
[    0.954328] ACPI: PCI: Interrupt link GSIC configured for IRQ 18
[    0.955328] ACPI: PCI: Interrupt link GSID configured for IRQ 19
[    0.956327] ACPI: PCI: Interrupt link GSIE configured for IRQ 20
[    0.957329] ACPI: PCI: Interrupt link GSIF configured for IRQ 21
[    0.958328] ACPI: PCI: Interrupt link GSIG configured for IRQ 22
[    0.959328] ACPI: PCI: Interrupt link GSIH configured for IRQ 23
[    0.962060] initcall acpi_init+0x0/0x450 returned 0 after 89000 usecs
[    0.962303] calling  pnp_init+0x0/0x10 @ 1
[    0.963319] initcall pnp_init+0x0/0x10 returned 0 after 0 usecs
[    0.964302] calling  init_sysrq_sysctl+0x0/0x30 @ 1
[    0.965308] initcall init_sysrq_sysctl+0x0/0x30 returned 0 after 0 usecs
[    0.966302] calling  misc_init+0x0/0xb0 @ 1
[    0.967315] initcall misc_init+0x0/0xb0 returned 0 after 0 usecs
[    0.968302] calling  iommu_subsys_init+0x0/0x170 @ 1
[    0.969301] iommu: Default domain type: Translated
[    0.970301] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.971304] initcall iommu_subsys_init+0x0/0x170 returned 0 after 2000 usecs
[    0.972301] calling  cn_init+0x0/0xf0 @ 1
[    0.973309] initcall cn_init+0x0/0xf0 returned 0 after 0 usecs
[    0.974299] calling  register_cpu_capacity_sysctl+0x0/0x40 @ 1
[    0.977321] initcall register_cpu_capacity_sysctl+0x0/0x40 returned 0 after 2000 usecs
[    0.978299] calling  dma_buf_init+0x0/0x90 @ 1
[    0.979332] initcall dma_buf_init+0x0/0x90 returned 0 after 0 usecs
[    0.981301] calling  dma_fence_init_stub+0x0/0x40 @ 1
[    0.982301] initcall dma_fence_init_stub+0x0/0x40 returned 0 after 0 usecs
[    0.983299] calling  init_scsi+0x0/0x90 @ 1
[    0.984357] SCSI subsystem initialized
[    0.985299] initcall init_scsi+0x0/0x90 returned 0 after 1000 usecs
[    0.986299] calling  ata_init+0x0/0x4e0 @ 1
[    0.987360] libata version 3.00 loaded.
[    0.988300] initcall ata_init+0x0/0x4e0 returned 0 after 1000 usecs
[    0.989299] calling  phy_init+0x0/0x2b0 @ 1
[    0.990326] initcall phy_init+0x0/0x2b0 returned 0 after 0 usecs
[    0.991300] calling  init_pcmcia_cs+0x0/0x40 @ 1
[    0.992304] initcall init_pcmcia_cs+0x0/0x40 returned 0 after 0 usecs
[    0.993299] calling  usb_common_init+0x0/0x20 @ 1
[    0.994305] initcall usb_common_init+0x0/0x20 returned 0 after 0 usecs
[    0.995299] calling  usb_init+0x0/0x180 @ 1
[    0.996302] ACPI: bus type USB registered
[    0.997327] usbcore: registered new interface driver usbfs
[    0.998309] usbcore: registered new interface driver hub
[    0.999316] usbcore: registered new device driver usb
[    1.000299] initcall usb_init+0x0/0x180 returned 0 after 4000 usecs
[    1.001299] calling  serio_init+0x0/0x40 @ 1
[    1.002308] initcall serio_init+0x0/0x40 returned 0 after 0 usecs
[    1.003299] calling  input_init+0x0/0x150 @ 1
[    1.004313] initcall input_init+0x0/0x150 returned 0 after 0 usecs
[    1.005299] calling  rtc_init+0x0/0x30 @ 1
[    1.006303] initcall rtc_init+0x0/0x30 returned 0 after 0 usecs
[    1.007301] calling  pps_init+0x0/0xb0 @ 1
[    1.008305] pps_core: LinuxPPS API ver. 1 registered
[    1.009299] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.010299] initcall pps_init+0x0/0xb0 returned 0 after 2000 usecs
[    1.011299] calling  ptp_init+0x0/0x90 @ 1
[    1.012303] PTP clock support registered
[    1.013299] initcall ptp_init+0x0/0x90 returned 0 after 1000 usecs
[    1.014299] calling  power_supply_class_init+0x0/0x20 @ 1
[    1.015306] initcall power_supply_class_init+0x0/0x20 returned 0 after 0 usecs
[    1.016299] calling  hwmon_init+0x0/0x110 @ 1
[    1.017305] initcall hwmon_init+0x0/0x110 returned 0 after 0 usecs
[    1.018299] calling  intel_tcc_init+0x0/0x40 @ 1
[    1.019300] initcall intel_tcc_init+0x0/0x40 returned 0 after 0 usecs
[    1.020299] calling  md_init+0x0/0x110 @ 1
[    1.021356] initcall md_init+0x0/0x110 returned 0 after 0 usecs
[    1.022300] calling  dmi_init+0x0/0x140 @ 1
[    1.023312] initcall dmi_init+0x0/0x140 returned 0 after 0 usecs
[    1.024299] calling  efisubsys_init+0x0/0x610 @ 1
[    1.025299] initcall efisubsys_init+0x0/0x610 returned 0 after 0 usecs
[    1.026299] calling  mbox_init+0x0/0x40 @ 1
[    1.027305] initcall mbox_init+0x0/0x40 returned 0 after 0 usecs
[    1.028299] calling  nvmem_init+0x0/0x10 @ 1
[    1.029311] initcall nvmem_init+0x0/0x10 returned 0 after 0 usecs
[    1.030299] calling  init_soundcore+0x0/0x10 @ 1
[    1.031303] initcall init_soundcore+0x0/0x10 returned 0 after 0 usecs
[    1.032300] calling  alsa_sound_init+0x0/0xa0 @ 1
[    1.033307] Advanced Linux Sound Architecture Driver Initialized.
[    1.034299] initcall alsa_sound_init+0x0/0xa0 returned 0 after 1000 usecs
[    1.035299] calling  alsa_seq_device_init+0x0/0x80 @ 1
[    1.036308] initcall alsa_seq_device_init+0x0/0x80 returned 0 after 0 usecs
[    1.037300] calling  hda_bus_init+0x0/0x10 @ 1
[    1.038308] initcall hda_bus_init+0x0/0x10 returned 0 after 0 usecs
[    1.039300] calling  proto_init+0x0/0x10 @ 1
[    1.040302] initcall proto_init+0x0/0x10 returned 0 after 0 usecs
[    1.041299] calling  net_dev_init+0x0/0x400 @ 1
[    1.042453] initcall net_dev_init+0x0/0x400 returned 0 after 0 usecs
[    1.043299] calling  neigh_init+0x0/0x20 @ 1
[    1.044301] initcall neigh_init+0x0/0x20 returned 0 after 0 usecs
[    1.045299] calling  fib_notifier_init+0x0/0x10 @ 1
[    1.046300] initcall fib_notifier_init+0x0/0x10 returned 0 after 0 usecs
[    1.047299] calling  netdev_genl_init+0x0/0x50 @ 1
[    1.048315] initcall netdev_genl_init+0x0/0x50 returned 0 after 0 usecs
[    1.049299] calling  page_pool_user_init+0x0/0x10 @ 1
[    1.050299] initcall page_pool_user_init+0x0/0x10 returned 0 after 0 usecs
[    1.051299] calling  fib_rules_init+0x0/0x80 @ 1
[    1.052300] initcall fib_rules_init+0x0/0x80 returned 0 after 0 usecs
[    1.053299] calling  init_cgroup_netprio+0x0/0x20 @ 1
[    1.054299] initcall init_cgroup_netprio+0x0/0x20 returned 0 after 0 usecs
[    1.055299] calling  pktsched_init+0x0/0xa0 @ 1
[    1.056305] initcall pktsched_init+0x0/0xa0 returned 0 after 0 usecs
[    1.057299] calling  tc_filter_init+0x0/0x80 @ 1
[    1.058308] initcall tc_filter_init+0x0/0x80 returned 0 after 0 usecs
[    1.059299] calling  tc_action_init+0x0/0x20 @ 1
[    1.060300] initcall tc_action_init+0x0/0x20 returned 0 after 0 usecs
[    1.061299] calling  ethnl_init+0x0/0x70 @ 1
[    1.062339] initcall ethnl_init+0x0/0x70 returned 0 after 0 usecs
[    1.063299] calling  nexthop_init+0x0/0x40 @ 1
[    1.064309] initcall nexthop_init+0x0/0x40 returned 0 after 0 usecs
[    1.065299] calling  cipso_v4_init+0x0/0x70 @ 1
[    1.066178] initcall cipso_v4_init+0x0/0x70 returned 0 after 0 usecs
[    1.066299] calling  ieee80211_init+0x0/0x60 @ 1
[    1.067148] initcall ieee80211_init+0x0/0x60 returned 0 after 0 usecs
[    1.067300] calling  netlbl_init+0x0/0x80 @ 1
[    1.068034] NetLabel: Initializing
[    1.068299] NetLabel:  domain hash size = 128
[    1.069299] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.070316] NetLabel:  unlabeled traffic allowed by default
[    1.071299] initcall netlbl_init+0x0/0x80 returned 0 after 4000 usecs
[    1.072299] calling  rfkill_init+0x0/0x150 @ 1
[    1.073346] initcall rfkill_init+0x0/0x150 returned 0 after 0 usecs
[    1.074301] calling  pci_subsys_init+0x0/0x90 @ 1
[    1.075300] PCI: Using ACPI for IRQ routing
[    1.118035] PCI: pci_cache_line_size set to 64 bytes
[    1.119341] e820: register RAM buffer resource [mem 0x0009fc00-0x0009ffff]
[    1.120300] e820: register RAM buffer resource [mem 0x1ffdf000-0x1fffffff]
[    1.121301] initcall pci_subsys_init+0x0/0x90 returned 0 after 46000 usecs
[    1.122300] calling  sys_info_sysctl_init+0x0/0x30 @ 1
[    1.123304] initcall sys_info_sysctl_init+0x0/0x30 returned 0 after 0 usecs
[    1.124299] calling  vsprintf_init_hashval+0x0/0x20 @ 1
[    1.125299] initcall vsprintf_init_hashval+0x0/0x20 returned 0 after 0 usecs
[    1.126299] calling  efi_runtime_map_init+0x0/0x240 @ 1
[    1.127299] initcall efi_runtime_map_init+0x0/0x240 returned 0 after 0 usecs
[    1.128300] calling  vga_arb_device_init+0x0/0xa0 @ 1
[    1.129345] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    1.130297] pci 0000:00:01.0: vgaarb: bridge control possible
[    1.130297] pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.130302] vgaarb: loaded
[    1.130917] initcall vga_arb_device_init+0x0/0xa0 returned 0 after 1000 usecs
[    1.131301] calling  acpi_wmi_init+0x0/0xa0 @ 1
[    1.132335] initcall acpi_wmi_init+0x0/0xa0 returned 0 after 0 usecs
[    1.133338] entering initcall level: fs
[    1.134301] calling  nmi_warning_debugfs+0x0/0x30 @ 1
[    1.135306] initcall nmi_warning_debugfs+0x0/0x30 returned 0 after 0 usecs
[    1.136299] calling  hpet_late_init+0x0/0x410 @ 1
[    1.137306] hpet: 3 channels of 0 reserved for per-cpu timers
[    1.138313] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.139299] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.145299] initcall hpet_late_init+0x0/0x410 returned 0 after 8000 usecs
[    1.146300] calling  init_amd_nbs+0x0/0x330 @ 1
[    1.147300] initcall init_amd_nbs+0x0/0x330 returned 0 after 0 usecs
[    1.149299] calling  amd_smn_init+0x0/0x230 @ 1
[    1.150299] initcall amd_smn_init+0x0/0x230 returned 0 after 0 usecs
[    1.151299] calling  iomem_init_inode+0x0/0xa0 @ 1
[    1.152330] initcall iomem_init_inode+0x0/0xa0 returned 0 after 0 usecs
[    1.153299] calling  irq_proc_init+0x0/0x30 @ 1
[    1.154302] initcall irq_proc_init+0x0/0x30 returned 0 after 0 usecs
[    1.155299] calling  clocksource_done_booting+0x0/0x50 @ 1
[    1.156368] clocksource: Switched to clocksource kvm-clock
[    1.157558] initcall clocksource_done_booting+0x0/0x50 returned 0 after 1260 usecs
[    1.159598] calling  tracer_init_tracefs+0x0/0xe0 @ 1
[    1.161082] initcall tracer_init_tracefs+0x0/0xe0 returned 0 after 13 usecs
[    1.163137] calling  init_trace_printk_function_export+0x0/0x30 @ 1
[    1.164898] initcall init_trace_printk_function_export+0x0/0x30 returned 0 after 15 usecs
[    1.167198] calling  init_kprobe_trace+0x0/0x1e0 @ 1
[    1.168637] initcall init_kprobe_trace+0x0/0x1e0 returned 0 after 3 usecs
[    1.170602] calling  init_dynamic_event+0x0/0x30 @ 1
[    1.172008] initcall init_dynamic_event+0x0/0x30 returned 0 after 1 usecs
[    1.173859] calling  init_uprobe_trace+0x0/0x70 @ 1
[    1.175257] initcall init_uprobe_trace+0x0/0x70 returned 0 after 3 usecs
[    1.177179] calling  secretmem_init+0x0/0x40 @ 1
[    1.178454] initcall secretmem_init+0x0/0x40 returned 0 after 20 usecs
[    1.180243] calling  init_fs_stat_sysctls+0x0/0x40 @ 1
[    1.181632] initcall init_fs_stat_sysctls+0x0/0x40 returned 0 after 7 usecs
[    1.183540] calling  init_fs_exec_sysctls+0x0/0x30 @ 1
[    1.184935] initcall init_fs_exec_sysctls+0x0/0x30 returned 0 after 1 usecs
[    1.186809] calling  init_pipe_fs+0x0/0x70 @ 1
[    1.188053] initcall init_pipe_fs+0x0/0x70 returned 0 after 15 usecs
[    1.189786] calling  init_fs_namei_sysctls+0x0/0x30 @ 1
[    1.191160] initcall init_fs_namei_sysctls+0x0/0x30 returned 0 after 3 usecs
[    1.192992] calling  init_fs_dcache_sysctls+0x0/0x50 @ 1
[    1.194435] initcall init_fs_dcache_sysctls+0x0/0x50 returned 0 after 13 usecs
[    1.196333] calling  init_fs_namespace_sysctls+0x0/0x30 @ 1
[    1.197835] initcall init_fs_namespace_sysctls+0x0/0x30 returned 0 after 1 usecs
[    1.199707] calling  fserror_init+0x0/0x30 @ 1
[    1.200865] initcall fserror_init+0x0/0x30 returned 0 after 2 usecs
[    1.202506] calling  inotify_user_setup+0x0/0x130 @ 1
[    1.203840] initcall inotify_user_setup+0x0/0x130 returned 0 after 7 usecs
[    1.205385] calling  eventpoll_init+0x0/0x1a0 @ 1
[    1.206391] initcall eventpoll_init+0x0/0x1a0 returned 0 after 2 usecs
[    1.208010] calling  anon_inode_init+0x0/0x70 @ 1
[    1.209247] initcall anon_inode_init+0x0/0x70 returned 0 after 16 usecs
[    1.210705] calling  proc_locks_init+0x0/0x30 @ 1
[    1.211839] initcall proc_locks_init+0x0/0x30 returned 0 after 3 usecs
[    1.213518] calling  init_fs_coredump_sysctls+0x0/0x30 @ 1
[    1.214834] initcall init_fs_coredump_sysctls+0x0/0x30 returned 0 after 7 usecs
[    1.216590] calling  init_vm_drop_caches_sysctls+0x0/0x30 @ 1
[    1.218018] initcall init_vm_drop_caches_sysctls+0x0/0x30 returned 0 after 2 usecs
[    1.219778] calling  iomap_ioend_init+0x0/0x20 @ 1
[    1.220942] initcall iomap_ioend_init+0x0/0x20 returned 0 after 36 usecs
[    1.222565] calling  dquot_init+0x0/0x1e0 @ 1
[    1.223725] VFS: Disk quotas dquot_6.6.0
[    1.224757] VFS: Dquot-cache hash table entries: 512 (4096 bytes)
[    1.226545] initcall dquot_init+0x0/0x1e0 returned 0 after 2820 usecs
[    1.228282] calling  quota_init+0x0/0x30 @ 1
[    1.229456] initcall quota_init+0x0/0x30 returned 0 after 11 usecs
[    1.230887] calling  proc_cmdline_init+0x0/0x40 @ 1
[    1.232089] initcall proc_cmdline_init+0x0/0x40 returned 0 after 2 usecs
[    1.233944] calling  proc_consoles_init+0x0/0x30 @ 1
[    1.235193] initcall proc_consoles_init+0x0/0x30 returned 0 after 1 usecs
[    1.236960] calling  proc_cpuinfo_init+0x0/0x30 @ 1
[    1.238303] initcall proc_cpuinfo_init+0x0/0x30 returned 0 after 1 usecs
[    1.239956] calling  proc_devices_init+0x0/0x30 @ 1
[    1.241096] initcall proc_devices_init+0x0/0x30 returned 0 after 0 usecs
[    1.242865] calling  proc_loadavg_init+0x0/0x30 @ 1
[    1.244162] initcall proc_loadavg_init+0x0/0x30 returned 0 after 0 usecs
[    1.245941] calling  proc_meminfo_init+0x0/0x30 @ 1
[    1.247278] initcall proc_meminfo_init+0x0/0x30 returned 0 after 0 usecs
[    1.249090] calling  proc_stat_init+0x0/0x30 @ 1
[    1.250337] initcall proc_stat_init+0x0/0x30 returned 0 after 1 usecs
[    1.252034] calling  proc_uptime_init+0x0/0x30 @ 1
[    1.253316] initcall proc_uptime_init+0x0/0x30 returned 0 after 1 usecs
[    1.254835] calling  proc_version_init+0x0/0x30 @ 1
[    1.255967] initcall proc_version_init+0x0/0x30 returned 0 after 1 usecs
[    1.257638] calling  proc_softirqs_init+0x0/0x30 @ 1
[    1.258826] initcall proc_softirqs_init+0x0/0x30 returned 0 after 0 usecs
[    1.260415] calling  proc_kcore_init+0x0/0x190 @ 1
[    1.261629] initcall proc_kcore_init+0x0/0x190 returned 0 after 62 usecs
[    1.263360] calling  vmcore_init+0x0/0x5e0 @ 1
[    1.264564] initcall vmcore_init+0x0/0x5e0 returned 0 after 0 usecs
[    1.266229] calling  proc_kmsg_init+0x0/0x30 @ 1
[    1.267475] initcall proc_kmsg_init+0x0/0x30 returned 0 after 1 usecs
[    1.269320] calling  proc_page_init+0x0/0x40 @ 1
[    1.270530] initcall proc_page_init+0x0/0x40 returned 0 after 1 usecs
[    1.272247] calling  netfs_init+0x0/0x1c0 @ 1
[    1.273503] initcall netfs_init+0x0/0x1c0 returned 0 after 88 usecs
[    1.275066] calling  init_ramfs_fs+0x0/0x10 @ 1
[    1.275109] kwatchdog (83) used greatest stack depth: 15096 bytes left
[    1.276221] initcall init_ramfs_fs+0x0/0x10 returned 0 after 3 usecs
[    1.279524] calling  init_hugetlbfs_fs+0x0/0x1a0 @ 1
[    1.280890] initcall init_hugetlbfs_fs+0x0/0x1a0 returned 0 after 50 usecs
[    1.282771] calling  security_initcall_fs+0x0/0xd0 @ 1
[    1.284176] initcall security_initcall_fs+0x0/0xd0 returned 0 after 0 usecs
[    1.286014] calling  acpi_reserve_motherboard_resources+0x0/0x260 @ 1
[    1.287737] acpi PNP0C01:00: Reserved [mem 0xb0000000-0xbfffffff]
[    1.289329] initcall acpi_reserve_motherboard_resources+0x0/0x260 returned 0 after 1619 usecs
[    1.291518] calling  acpi_event_init+0x0/0x40 @ 1
[    1.292751] initcall acpi_event_init+0x0/0x40 returned 0 after 13 usecs
[    1.294405] calling  pnp_system_init+0x0/0x10 @ 1
[    1.295606] initcall pnp_system_init+0x0/0x10 returned 0 after 28 usecs
[    1.297639] calling  pnpacpi_init+0x0/0x80 @ 1
[    1.298800] pnp: PnP ACPI init
[    1.299914] pnp: PnP ACPI: found 4 devices
[    1.300764] initcall pnpacpi_init+0x0/0x80 returned 0 after 1963 usecs
[    1.302088] calling  chr_dev_init+0x0/0xa0 @ 1
[    1.305766] initcall chr_dev_init+0x0/0xa0 returned 0 after 2576 usecs
[    1.307591] calling  hwrng_modinit+0x0/0xb0 @ 1
[    1.308803] initcall hwrng_modinit+0x0/0xb0 returned 0 after 56 usecs
[    1.310417] calling  firmware_class_init+0x0/0x100 @ 1
[    1.311802] initcall firmware_class_init+0x0/0x100 returned 0 after 2 usecs
[    1.313500] calling  init_pcmcia_bus+0x0/0x80 @ 1
[    1.314496] initcall init_pcmcia_bus+0x0/0x80 returned 0 after 16 usecs
[    1.315698] calling  init_acpi_pm_clocksource+0x0/0x100 @ 1
[    1.321365] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.323761] initcall init_acpi_pm_clocksource+0x0/0x100 returned 0 after 6966 usecs
[    1.325795] calling  sysctl_core_init+0x0/0x30 @ 1
[    1.327101] initcall sysctl_core_init+0x0/0x30 returned 0 after 28 usecs
[    1.328884] calling  eth_offload_init+0x0/0x20 @ 1
[    1.330167] initcall eth_offload_init+0x0/0x20 returned 0 after 0 usecs
[    1.331813] calling  ipv4_offload_init+0x0/0xe0 @ 1
[    1.333084] initcall ipv4_offload_init+0x0/0xe0 returned 0 after 1 usecs
[    1.334827] calling  inet_init+0x0/0x330 @ 1
[    1.335923] NET: Registered PF_INET protocol family
[    1.337320] IP idents hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    1.339370] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 bytes, linear)
[    1.341453] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    1.343479] TCP established hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    1.345442] TCP bind hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    1.347156] TCP: Hash tables configured (established 4096 bind 4096)
[    1.348692] UDP hash table entries: 256 (order: 2, 16384 bytes, linear)
[    1.350364] initcall inet_init+0x0/0x330 returned 0 after 14491 usecs
[    1.352097] calling  af_unix_init+0x0/0xd0 @ 1
[    1.353254] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.354691] initcall af_unix_init+0x0/0xd0 returned 0 after 1440 usecs
[    1.356371] calling  ipv6_offload_init+0x0/0x120 @ 1
[    1.357625] initcall ipv6_offload_init+0x0/0x120 returned 0 after 1 usecs
[    1.359326] calling  init_sunrpc+0x0/0xb0 @ 1
[    1.360622] RPC: Registered named UNIX socket transport module.
[    1.362114] RPC: Registered udp transport module.
[    1.363294] RPC: Registered tcp transport module.
[    1.364420] RPC: Registered tcp-with-tls transport module.
[    1.365773] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.367496] initcall init_sunrpc+0x0/0xb0 returned 0 after 7156 usecs
[    1.369200] calling  cfg80211_init+0x0/0xe0 @ 1
[    1.370704] probe of regulatory returned 0 after 5 usecs
[    1.372318] initcall cfg80211_init+0x0/0xe0 returned 0 after 1930 usecs
[    1.374129] calling  pcibios_assign_resources+0x0/0xd0 @ 1
[    1.375621] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.377318] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.379034] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.380953] pci_bus 0000:00: resource 7 [mem 0x20000000-0xafffffff window]
[    1.382990] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xfebfffff window]
[    1.384935] pci_bus 0000:00: resource 9 [mem 0x100000000-0x8ffffffff window]
[    1.386982] initcall pcibios_assign_resources+0x0/0xd0 returned 0 after 11367 usecs
[    1.389273] calling  pci_apply_final_quirks+0x0/0x160 @ 1
[    1.391088] PCI: CLS 0 bytes, default 64
[    1.392333] initcall pci_apply_final_quirks+0x0/0x160 returned 0 after 1315 usecs
[    1.394786] calling  acpi_reserve_resources+0x0/0x110 @ 1
[    1.396617] initcall acpi_reserve_resources+0x0/0x110 returned 0 after 4 usecs
[    1.399026] calling  p2sb_fs_init+0x0/0x160 @ 1
[    1.400516] initcall p2sb_fs_init+0x0/0x160 returned -2 after 43 usecs
[    1.402727] calling  populate_rootfs+0x0/0x50 @ 1
[    1.404373] initcall populate_rootfs+0x0/0x50 returned 0 after 10 usecs
[    1.406625] calling  pci_iommu_init+0x0/0x40 @ 1
[    1.408226] initcall pci_iommu_init+0x0/0x40 returned 0 after 1 usecs
[    1.410497] calling  ir_dev_scope_init+0x0/0x40 @ 1
[    1.412227] initcall ir_dev_scope_init+0x0/0x40 returned 0 after 0 usecs
[    1.414612] entering initcall level: device
[    1.416070] calling  ia32_binfmt_init+0x0/0x30 @ 1
[    1.417695] initcall ia32_binfmt_init+0x0/0x30 returned 0 after 5 usecs
[    1.419954] calling  rapl_pmu_init+0x0/0x370 @ 1
[    1.421645] initcall rapl_pmu_init+0x0/0x370 returned -19 after 1 usecs
[    1.423929] calling  amd_ibs_init+0x0/0x400 @ 1
[    1.425544] initcall amd_ibs_init+0x0/0x400 returned -19 after 0 usecs
[    1.427873] calling  amd_uncore_init+0x0/0x1b0 @ 1
[    1.429543] initcall amd_uncore_init+0x0/0x1b0 returned -19 after 0 usecs
[    1.432025] calling  amd_iommu_pc_init+0x0/0x260 @ 1
[    1.433749] initcall amd_iommu_pc_init+0x0/0x260 returned -19 after 0 usecs
[    1.436118] calling  msr_init+0x0/0x60 @ 1
[    1.437510] initcall msr_init+0x0/0x60 returned 0 after 26 usecs
[    1.439214] calling  intel_uncore_init+0x0/0x630 @ 1
[    1.440600] initcall intel_uncore_init+0x0/0x630 returned -19 after 0 usecs
[    1.442519] calling  cstate_pmu_init+0x0/0x280 @ 1
[    1.443723] initcall cstate_pmu_init+0x0/0x280 returned -19 after 0 usecs
[    1.445554] calling  register_kernel_offset_dumper+0x0/0x20 @ 1
[    1.447225] initcall register_kernel_offset_dumper+0x0/0x20 returned 0 after 0 usecs
[    1.449098] calling  i8259A_init_ops+0x0/0x30 @ 1
[    1.450423] initcall i8259A_init_ops+0x0/0x30 returned 0 after 0 usecs
[    1.452206] calling  init_tsc_clocksource+0x0/0xd0 @ 1
[    1.453599] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x3985c314e25, max_idle_ns: 881590612270 ns
[    1.456363] initcall init_tsc_clocksource+0x0/0xd0 returned 0 after 2765 usecs
[    1.458232] calling  add_rtc_cmos+0x0/0x50 @ 1
[    1.459312] initcall add_rtc_cmos+0x0/0x50 returned 0 after 0 usecs
[    1.461020] calling  i8237A_init_ops+0x0/0x40 @ 1
[    1.462298] initcall i8237A_init_ops+0x0/0x40 returned 0 after 6 usecs
[    1.464151] calling  umwait_init+0x0/0xc0 @ 1
[    1.465365] initcall umwait_init+0x0/0xc0 returned -19 after 0 usecs
[    1.467095] calling  msr_init+0x0/0xe0 @ 1
[    1.469015] initcall msr_init+0x0/0xe0 returned 0 after 812 usecs
[    1.470754] calling  cpuid_init+0x0/0xe0 @ 1
[    1.472438] initcall cpuid_init+0x0/0xe0 returned 0 after 495 usecs
[    1.474128] calling  ioapic_init_ops+0x0/0x20 @ 1
[    1.475413] initcall ioapic_init_ops+0x0/0x20 returned 0 after 0 usecs
[    1.477243] calling  add_pcspkr+0x0/0x70 @ 1
[    1.478465] initcall add_pcspkr+0x0/0x70 returned 0 after 21 usecs
[    1.480224] calling  start_periodic_check_for_corruption+0x0/0x50 @ 1
[    1.482010] initcall start_periodic_check_for_corruption+0x0/0x50 returned 0 after 0 usecs
[    1.484299] calling  audit_classes_init+0x0/0xc0 @ 1
[    1.485727] initcall audit_classes_init+0x0/0xc0 returned 0 after 2 usecs
[    1.487635] calling  pt_dump_init+0x0/0x50 @ 1
[    1.488804] initcall pt_dump_init+0x0/0x50 returned 0 after 0 usecs
[    1.490491] calling  iosf_mbi_init+0x0/0x30 @ 1
[    1.491753] initcall iosf_mbi_init+0x0/0x30 returned 0 after 23 usecs
[    1.493491] calling  proc_execdomains_init+0x0/0x30 @ 1
[    1.494944] initcall proc_execdomains_init+0x0/0x30 returned 0 after 4 usecs
[    1.496968] calling  register_warn_debugfs+0x0/0x30 @ 1
[    1.498503] initcall register_warn_debugfs+0x0/0x30 returned 0 after 6 usecs
[    1.500530] calling  cpuhp_sysfs_init+0x0/0x110 @ 1
[    1.501983] initcall cpuhp_sysfs_init+0x0/0x110 returned 0 after 53 usecs
[    1.503742] calling  ioresources_init+0x0/0x50 @ 1
[    1.505031] initcall ioresources_init+0x0/0x50 returned 0 after 3 usecs
[    1.506844] calling  snapshot_device_init+0x0/0x10 @ 1
[    1.508338] initcall snapshot_device_init+0x0/0x10 returned 0 after 86 usecs
[    1.510334] calling  irq_pm_init_ops+0x0/0x20 @ 1
[    1.511607] initcall irq_pm_init_ops+0x0/0x20 returned 0 after 0 usecs
[    1.513358] calling  rcu_torture_init+0x0/0x1f10 @ 1
[    1.514712] torture module --- rcu:  disable_onoff_at_boot=0 ftrace_dump_at_shutdown=0 verbose_sleep_frequency=0 verbose_sleep_duration=1 random_shuffle=0 still booting
[    1.518820] rcu-torture:--- Start of test: nreaders=7 nwriters=1 nfakewriters=4 stat_interval=15 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 test_boost_holdoff=0 shutdown_secs=3600 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 stall_cpu_repeat=0 n_barrier_cbs=4 onoff_interval=1000 onoff_holdoff=30 read_exit_delay=13 read_exit_burst=16 reader_flavor=1 nocbs_nthreads=8 nocbs_toggle=1000 test_nmis=0 preempt_duration=0 preempt_interval=1000 n_up_down=32
[    1.533223] rcu:  Start-test grace-period state: g-1136 f0x0
[    1.534820] rcu_torture_write_types: Testing conditional GPs.
[    1.536425] rcu_torture_write_types: Testing conditional expedited GPs.
[    1.538321] rcu_torture_write_types: Testing conditional full-state GPs.
[    1.540127] rcu_torture_write_types: Testing conditional full-state expedited GPs.
[    1.541958] rcu_torture_write_types: Testing expedited GPs.
[    1.543543] rcu_torture_write_types: Testing asynchronous GPs.
[    1.545080] rcu_torture_write_types: Testing polling GPs.
[    1.546512] rcu_torture_write_types: Testing polling full-state GPs.
[    1.548261] rcu_torture_write_types: Testing polling expedited GPs.
[    1.550073] rcu_torture_write_types: Testing polling full-state expedited GPs.
[    1.552102] rcu_torture_write_types: Testing normal GPs.
[    1.553567] rcu_torture_write_types: Testing 11 update types.
[    1.555182] rcu_torture_write_types: gp_cond_wi 16000 gp_cond_wi_exp 128 gp_poll_wi 16000 gp_poll_wi_exp 128
[    1.557843] rcu-torture: Creating rcu_torture_fakewriter task
[    1.559617] rcu-torture: Creating rcu_torture_fakewriter task
[    1.559624] rcu-torture: rcu_torture_fakewriter task started
[    1.561369] rcu-torture: Creating rcu_torture_fakewriter task
[    1.561380] rcu-torture: rcu_torture_fakewriter task started
[    1.566664] rcu-torture: Creating rcu_torture_fakewriter task
[    1.566679] rcu-torture: rcu_torture_fakewriter task started
[    1.568739] rcu-torture: Creating rcu_torture_reader task
[    1.568752] rcu-torture: rcu_torture_fakewriter task started
[    1.572957] rcu-torture: Creating rcu_torture_reader task
[    1.572963] rcu-torture: rcu_torture_reader task started
[    1.574762] rcu-torture: Creating rcu_torture_reader task
[    1.574766] rcu-torture: rcu_torture_reader task started
[    1.579144] rcu-torture: Creating rcu_torture_reader task
[    1.579154] rcu-torture: rcu_torture_reader task started
[    1.580875] rcu-torture: Creating rcu_torture_reader task
[    1.580888] rcu-torture: rcu_torture_reader task started
[    1.585952] rcu-torture: Creating rcu_torture_reader task
[    1.585960] rcu-torture: rcu_torture_reader task started
[    1.587524] rcu-torture: Creating rcu_torture_reader task
[    1.587541] rcu-torture: rcu_torture_reader task started
[    1.592608] rcu-torture: Creating rcu_torture_writer task
[    1.592618] rcu-torture: rcu_torture_reader task started
[    1.594027] rcu-torture: rcu_torture_updown_init: Disabling up/down reader tests due to lack of primitives
[    1.594035] rcu-torture: rcu_torture_writer task started
[    1.594038] rcu-torture: GP expediting controlled from boot/sysfs for rcu.
[    1.601634] rcu-torture: Creating rcu_nocb_toggle task
[    1.603156] rcu-torture: Creating rcu_nocb_toggle task
[    1.603166] rcu-torture: rcu_nocb_toggle task started
[    1.604710] rcu-torture: Creating rcu_nocb_toggle task
[    1.604720] rcu-torture: rcu_nocb_toggle task started
[    1.609605] rcu-torture: Creating rcu_nocb_toggle task
[    1.609620] rcu-torture: rcu_nocb_toggle task started
[    1.611408] rcu-torture: Creating rcu_nocb_toggle task
[    1.611424] rcu-torture: rcu_nocb_toggle task started
[    1.616202] rcu-torture: Creating rcu_nocb_toggle task
[    1.616209] rcu-torture: rcu_nocb_toggle task started
[    1.618011] rcu-torture: Creating rcu_nocb_toggle task
[    1.618024] rcu-torture: rcu_nocb_toggle task started
[    1.622833] rcu-torture: Creating rcu_nocb_toggle task
[    1.622839] rcu-torture: rcu_nocb_toggle task started
[    1.624603] rcu-torture: Creating rcu_torture_stats task
[    1.624606] rcu-torture: rcu_nocb_toggle task started
[    1.629393] rcu-torture: Creating torture_shuffle task
[    1.629397] rcu-torture: rcu_torture_stats task started
[    1.631071] rcu-torture: Creating torture_stutter task
[    1.631081] rcu-torture: torture_shuffle task started
[    1.635805] rcu-torture: Creating torture_shutdown task
[    1.635811] rcu-torture: torture_stutter task started
[    1.637375] rcu-torture: Creating torture_onoff task
[    1.637379] rcu-torture: torture_shutdown task started
[    1.637382] rcu-torture:torture_shutdown task: 3599998 ms remaining
[    1.644123] rcu-torture: Creating rcu_torture_barrier_cbs task
[    1.644128] rcu-torture: torture_onoff task started
[    1.646144] rcu-torture: Creating rcu_torture_barrier_cbs task
[    1.646157] rcu-torture: rcu_torture_barrier_cbs task started
[    1.651501] rcu-torture: Creating rcu_torture_barrier_cbs task
[    1.651516] rcu-torture: rcu_torture_barrier_cbs task started
[    1.653576] rcu-torture: Creating rcu_torture_barrier_cbs task
[    1.653580] rcu-torture: rcu_torture_barrier_cbs task started
[    1.661732] rcu-torture: Creating rcu_torture_barrier task
[    1.661747] rcu-torture: rcu_torture_barrier_cbs task started
[    1.663603] rcu-torture: Creating rcu_torture_read_exit task
[    1.663614] rcu-torture: rcu_torture_barrier task starting
[    1.665084]   #8
[    1.666744] initcall rcu_torture_init+0x0/0x1f10 returned 0 after 152033 usecs
[    1.666754] rcu-torture: rcu_torture_read_exit: Start of test
[    1.666761] calling  proc_modules_init+0x0/0x30 @ 1
[    1.666769] initcall proc_modules_init+0x0/0x30 returned 0 after 3 usecs
[    1.666772] calling  timer_sysctl_init+0x0/0x30 @ 1
[    1.666781] initcall timer_sysctl_init+0x0/0x30 returned 0 after 5 usecs
[    1.666783] calling  timekeeping_init_ops+0x0/0x20 @ 1
[    1.666786] initcall timekeeping_init_ops+0x0/0x20 returned 0 after 0 usecs
[    1.666789] calling  init_clocksource_sysfs+0x0/0x30 @ 1
[    1.666842] initcall init_clocksource_sysfs+0x0/0x30 returned 0 after 49 usecs
[    1.666845] calling  init_timer_list_procfs+0x0/0x40 @ 1
[    1.666854] initcall init_timer_list_procfs+0x0/0x40 returned 0 after 5 usecs
[    1.666857] calling  alarmtimer_init+0x0/0xf0 @ 1
[    1.666880] initcall alarmtimer_init+0x0/0xf0 returned 0 after 20 usecs
[    1.666883] calling  clockevents_init_sysfs+0x0/0x100 @ 1
[    1.667049] initcall clockevents_init_sysfs+0x0/0x100 returned 0 after 162 usecs
[    1.667052] calling  proc_dma_init+0x0/0x30 @ 1
[    1.667058] initcall proc_dma_init+0x0/0x30 returned 0 after 1 usecs
[    1.667060] calling  kallsyms_init+0x0/0x30 @ 1
[    1.667064] initcall kallsyms_init+0x0/0x30 returned 0 after 1 usecs
[    1.667068] calling  pid_namespaces_init+0x0/0xd0 @ 1
[    1.667092] initcall pid_namespaces_init+0x0/0xd0 returned 0 after 20 usecs
[    1.667096] calling  audit_watch_init+0x0/0x50 @ 1
[    1.667100] initcall audit_watch_init+0x0/0x50 returned 0 after 0 usecs
[    1.667104] calling  audit_fsnotify_init+0x0/0x50 @ 1
[    1.667108] initcall audit_fsnotify_init+0x0/0x50 returned 0 after 0 usecs
[    1.667111] calling  audit_tree_init+0x0/0xd0 @ 1
[    1.667116] initcall audit_tree_init+0x0/0xd0 returned 0 after 1 usecs
[    1.667121] calling  seccomp_sysctl_init+0x0/0x30 @ 1
[    1.667129] initcall seccomp_sysctl_init+0x0/0x30 returned 0 after 3 usecs
[    1.667133] calling  utsname_sysctl_init+0x0/0x30 @ 1
[    1.667143] initcall utsname_sysctl_init+0x0/0x30 returned 0 after 6 usecs
[    1.667148] calling  init_tracepoints+0x0/0x40 @ 1
[    1.667154] initcall init_tracepoints+0x0/0x40 returned 0 after 1 usecs
[    1.667158] calling  init_blk_tracer+0x0/0xc0 @ 1
[    1.667168] initcall init_blk_tracer+0x0/0xc0 returned 0 after 4 usecs
[    1.667172] calling  perf_event_sysfs_init+0x0/0xa0 @ 1
[    1.667246] initcall perf_event_sysfs_init+0x0/0xa0 returned 0 after 69 usecs
[    1.667248] calling  rseq_debugfs_init+0x0/0x40 @ 1
[    1.667258] initcall rseq_debugfs_init+0x0/0x40 returned 0 after 6 usecs
[    1.667262] calling  system_trusted_keyring_init+0x0/0x70 @ 1
[    1.667265] Initialise system trusted keyrings
[    1.667276] initcall system_trusted_keyring_init+0x0/0x70 returned 0 after 10 usecs
[    1.667280] calling  kswapd_init+0x0/0x110 @ 1
[    1.667352] initcall kswapd_init+0x0/0x110 returned 0 after 68 usecs
[    1.667355] calling  extfrag_debug_init+0x0/0x60 @ 1
[    1.667366] initcall extfrag_debug_init+0x0/0x60 returned 0 after 8 usecs
[    1.667369] calling  mm_compute_batch_init+0x0/0x20 @ 1
[    1.667374] initcall mm_compute_batch_init+0x0/0x20 returned 0 after 0 usecs
[    1.667377] calling  slab_proc_init+0x0/0x30 @ 1
[    1.667383] initcall slab_proc_init+0x0/0x30 returned 0 after 1 usecs
[    1.667387] calling  workingset_init+0x0/0xf0 @ 1
[    1.667392] workingset: timestamp_bits=56 (anon: 51) max_order=17 bucket_order=0 (anon: 0)
[    1.667395] initcall workingset_init+0x0/0xf0 returned 0 after 3 usecs
[    1.667400] calling  proc_vmalloc_init+0x0/0x30 @ 1
[    1.667406] initcall proc_vmalloc_init+0x0/0x30 returned 0 after 1 usecs
[    1.667410] calling  memblock_init_debugfs+0x0/0x60 @ 1
[    1.667414] initcall memblock_init_debugfs+0x0/0x60 returned 0 after 0 usecs
[    1.667416] calling  slab_debugfs_init+0x0/0x70 @ 1
[    1.667422] initcall slab_debugfs_init+0x0/0x70 returned 0 after 1 usecs
[    1.667425] calling  procswaps_init+0x0/0x30 @ 1
[    1.667447] initcall procswaps_init+0x0/0x30 returned 0 after 1 usecs
[    1.667452] calling  ptdump_debugfs_init+0x0/0x30 @ 1
[    1.667462] initcall ptdump_debugfs_init+0x0/0x30 returned 0 after 1 usecs
[    1.667467] calling  fcntl_init+0x0/0x90 @ 1
[    1.667473] initcall fcntl_init+0x0/0x90 returned 0 after 1 usecs
[    1.667476] calling  proc_filesystems_init+0x0/0x40 @ 1
[    1.667480] initcall proc_filesystems_init+0x0/0x40 returned 0 after 1 usecs
[    1.667484] calling  start_dirtytime_writeback+0x0/0x60 @ 1
[    1.667492] initcall start_dirtytime_writeback+0x0/0x60 returned 0 after 4 usecs
[    1.667496] calling  dio_init+0x0/0x90 @ 1
[    1.667501] initcall dio_init+0x0/0x90 returned 0 after 1 usecs
[    1.667504] calling  dnotify_init+0x0/0x130 @ 1
[    1.667513] initcall dnotify_init+0x0/0x130 returned 0 after 4 usecs
[    1.667516] calling  aio_setup+0x0/0x140 @ 1
[    1.667562] initcall aio_setup+0x0/0x140 returned 0 after 41 usecs
[    1.667566] calling  mbcache_init+0x0/0x90 @ 1
[    1.667583] initcall mbcache_init+0x0/0x90 returned 0 after 13 usecs
[    1.667587] calling  init_grace+0x0/0x10 @ 1
[    1.667593] initcall init_grace+0x0/0x10 returned 0 after 1 usecs
[    1.667596] calling  init_v2_quota_format+0x0/0x30 @ 1
[    1.667601] initcall init_v2_quota_format+0x0/0x30 returned 0 after 0 usecs
[    1.667605] calling  init_devpts_fs+0x0/0x50 @ 1
[    1.667614] initcall init_devpts_fs+0x0/0x50 returned 0 after 5 usecs
[    1.667616] calling  ext4_init_fs+0x0/0x210 @ 1
[    1.667696] initcall ext4_init_fs+0x0/0x210 returned 0 after 76 usecs
[    1.667698] calling  journal_init+0x0/0x260 @ 1
[    1.667709] initcall journal_init+0x0/0x260 returned 0 after 7 usecs
[    1.667712] calling  init_fat_fs+0x0/0xb0 @ 1
[    1.667722] initcall init_fat_fs+0x0/0xb0 returned 0 after 8 usecs
[    1.667725] calling  init_vfat_fs+0x0/0x10 @ 1
[    1.667729] initcall init_vfat_fs+0x0/0x10 returned 0 after 0 usecs
[    1.667732] calling  init_msdos_fs+0x0/0x10 @ 1
[    1.667735] initcall init_msdos_fs+0x0/0x10 returned 0 after 0 usecs
[    1.667738] calling  init_iso9660_fs+0x0/0xd0 @ 1
[    1.667753] initcall init_iso9660_fs+0x0/0xd0 returned 0 after 12 usecs
[    1.667756] calling  init_nfs_fs+0x0/0x1f0 @ 1
[    1.667890] initcall init_nfs_fs+0x0/0x1f0 returned 0 after 131 usecs
[    1.667894] calling  init_nfs_v3+0x0/0x20 @ 1
[    1.667897] initcall init_nfs_v3+0x0/0x20 returned 0 after 0 usecs
[    1.667901] calling  init_nfs_v4+0x0/0x60 @ 1
[    1.667904] NFS: Registering the id_resolver key type
[    1.667924] Key type id_resolver registered
[    1.667926] Key type id_legacy registered
[    1.667929] initcall init_nfs_v4+0x0/0x60 returned 0 after 25 usecs
[    1.667932] calling  nfs4filelayout_init+0x0/0x30 @ 1
[    1.667935] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.667938] initcall nfs4filelayout_init+0x0/0x30 returned 0 after 2 usecs
[    1.667941] calling  nfs4blocklayout_init+0x0/0x70 @ 1
[    1.667945] initcall nfs4blocklayout_init+0x0/0x70 returned 0 after 1 usecs
[    1.667949] calling  nfs4flexfilelayout_init+0x0/0x30 @ 1
[    1.667952] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    1.667954] initcall nfs4flexfilelayout_init+0x0/0x30 returned 0 after 2 usecs
[    1.667957] calling  init_nlm+0x0/0xa0 @ 1
[    1.667974] initcall init_nlm+0x0/0xa0 returned 0 after 13 usecs
[    1.667977] calling  init_nls_cp437+0x0/0x20 @ 1
[    1.667980] initcall init_nls_cp437+0x0/0x20 returned 0 after 0 usecs
[    1.667983] calling  init_nls_ascii+0x0/0x20 @ 1
[    1.667987] initcall init_nls_ascii+0x0/0x20 returned 0 after 0 usecs
[    1.667989] calling  init_nls_iso8859_1+0x0/0x20 @ 1
[    1.667993] initcall init_nls_iso8859_1+0x0/0x20 returned 0 after 0 usecs
[    1.667997] calling  init_nls_utf8+0x0/0x30 @ 1
[    1.668000] initcall init_nls_utf8+0x0/0x30 returned 0 after 0 usecs
[    1.668004] calling  init_autofs_fs+0x0/0x40 @ 1
[    1.668064] initcall init_autofs_fs+0x0/0x40 returned 0 after 57 usecs
[    1.668068] calling  init_v9fs+0x0/0x170 @ 1
[    1.668071] 9p: Installing v9fs 9p2000 file system support
[    1.668076] initcall init_v9fs+0x0/0x170 returned 0 after 5 usecs
[    1.668079] calling  ipc_init+0x0/0x30 @ 1
[    1.668095] initcall ipc_init+0x0/0x30 returned 0 after 12 usecs
[    1.668099] calling  ipc_sysctl_init+0x0/0x40 @ 1
[    1.668116] initcall ipc_sysctl_init+0x0/0x40 returned 0 after 13 usecs
[    1.668120] calling  init_mqueue_fs+0x0/0x120 @ 1
[    1.668152] initcall init_mqueue_fs+0x0/0x120 returned 0 after 29 usecs
[    1.668156] calling  key_proc_init+0x0/0x70 @ 1
[    1.668161] initcall key_proc_init+0x0/0x70 returned 0 after 1 usecs
[    1.668165] calling  security_initcall_device+0x0/0xd0 @ 1
[    1.668170] initcall security_initcall_device+0x0/0xd0 returned 0 after 0 usecs
[    1.668174] calling  seqiv_module_init+0x0/0x10 @ 1
[    1.668180] initcall seqiv_module_init+0x0/0x10 returned 0 after 0 usecs
[    1.668184] calling  echainiv_module_init+0x0/0x10 @ 1
[    1.668189] initcall echainiv_module_init+0x0/0x10 returned 0 after 0 usecs
[    1.668193] calling  rsa_init+0x0/0x80 @ 1
[    1.668199] initcall rsa_init+0x0/0x80 returned 0 after 1 usecs
[    1.668203] calling  cryptomgr_init+0x0/0x10 @ 1
[    1.668208] initcall cryptomgr_init+0x0/0x10 returned 0 after 0 usecs
[    1.668212] calling  crypto_cmac_module_init+0x0/0x10 @ 1
[    1.668216] initcall crypto_cmac_module_init+0x0/0x10 returned 0 after 0 usecs
[    1.668221] calling  hmac_module_init+0x0/0x20 @ 1
[    1.668225] initcall hmac_module_init+0x0/0x20 returned 0 after 0 usecs
[    1.668229] calling  crypto_sha1_mod_init+0x0/0x20 @ 1
[    1.668235] initcall crypto_sha1_mod_init+0x0/0x20 returned 0 after 1 usecs
[    1.668239] calling  crypto_sha256_mod_init+0x0/0x20 @ 1
[    1.668245] initcall crypto_sha256_mod_init+0x0/0x20 returned 0 after 2 usecs
[    1.668249] calling  crypto_sha512_mod_init+0x0/0x20 @ 1
[    1.668255] initcall crypto_sha512_mod_init+0x0/0x20 returned 0 after 2 usecs
[    1.668260] calling  crypto_ecb_module_init+0x0/0x10 @ 1
[    1.668264] initcall crypto_ecb_module_init+0x0/0x10 returned 0 after 0 usecs
[    1.668269] calling  crypto_cbc_module_init+0x0/0x10 @ 1
[    1.668273] initcall crypto_cbc_module_init+0x0/0x10 returned 0 after 0 usecs
[    1.668277] calling  crypto_cts_module_init+0x0/0x10 @ 1
[    1.668280] initcall crypto_cts_module_init+0x0/0x10 returned 0 after 0 usecs
[    1.668283] calling  crypto_ctr_module_init+0x0/0x20 @ 1
[    1.668285] initcall crypto_ctr_module_init+0x0/0x20 returned 0 after 0 usecs
[    1.668287] calling  crypto_gcm_module_init+0x0/0x20 @ 1
[    1.668290] initcall crypto_gcm_module_init+0x0/0x20 returned 0 after 0 usecs
[    1.668291] calling  crypto_ccm_module_init+0x0/0x20 @ 1
[    1.668294] initcall crypto_ccm_module_init+0x0/0x20 returned 0 after 0 usecs
[    1.668297] calling  crypto_aes_mod_init+0x0/0x50 @ 1
[    1.668301] initcall crypto_aes_mod_init+0x0/0x50 returned 0 after 1 usecs
[    1.668303] calling  camellia_init+0x0/0x10 @ 1
[    1.668306] initcall camellia_init+0x0/0x10 returned 0 after 0 usecs
[    1.668308] calling  crypto_authenc_module_init+0x0/0x10 @ 1
[    1.668310] initcall crypto_authenc_module_init+0x0/0x10 returned 0 after 0 usecs
[    1.668313] calling  crypto_authenc_esn_module_init+0x0/0x10 @ 1
[    1.668316] initcall crypto_authenc_esn_module_init+0x0/0x10 returned 0 after 0 usecs
[    1.668318] calling  crypto_krb5enc_module_init+0x0/0x10 @ 1
[    1.668322] initcall crypto_krb5enc_module_init+0x0/0x10 returned 0 after 0 usecs
[    1.668324] calling  lzo_mod_init+0x0/0x10 @ 1
[    1.668327] initcall lzo_mod_init+0x0/0x10 returned 0 after 0 usecs
[    1.668329] calling  lzorle_mod_init+0x0/0x10 @ 1
[    1.963120] rcu-torture: rcu_torture_read_exit: Start of episode
[    1.965086] initcall lzorle_mod_init+0x0/0x10 returned 0 after 4 usecs
[    1.966663]   #9
[    1.967148] calling  lz4_mod_init+0x0/0x10 @ 1
[    1.969248] initcall lz4_mod_init+0x0/0x10 returned 0 after 3 usecs
[    1.971115] calling  asymmetric_key_init+0x0/0x10 @ 1
[    1.972512]  #10
[    1.972684] Key type asymmetric registered
[    1.974748] initcall asymmetric_key_init+0x0/0x10 returned 0 after 2067 usecs
[    1.977066] calling  x509_key_init+0x0/0x10 @ 1
[    1.977573]  #11
[    1.978538] Asymmetric key parser 'x509' registered
[    1.983574] initcall x509_key_init+0x0/0x10 returned 0 after 5035 usecs
[    1.985594] calling  crypto_krb5_init+0x0/0x10 @ 1
[    1.986405]  #12
[    1.987089] initcall crypto_krb5_init+0x0/0x10 returned 0 after 0 usecs
[    1.989722] calling  blkdev_init+0x0/0x20 @ 1
[    1.992182] initcall blkdev_init+0x0/0x20 returned 0 after 1077 usecs
[    1.992661]  #13
[    1.993654] calling  proc_genhd_init+0x0/0x50 @ 1
[    1.995317] initcall proc_genhd_init+0x0/0x50 returned 0 after 10 usecs
[    1.996906] calling  bsg_init+0x0/0xa0 @ 1
[    1.997895] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.998516]  #14
[    1.999548] initcall bsg_init+0x0/0xa0 returned 0 after 1665 usecs
[    2.005539] calling  ioprio_init+0x0/0x10 @ 1
[    2.006592] initcall ioprio_init+0x0/0x10 returned 0 after 6 usecs
[    2.008015] calling  iolatency_init+0x0/0x10 @ 1
[    2.009087] initcall iolatency_init+0x0/0x10 returned 0 after 1 usecs
[    2.009706]  #15
[    2.010562] calling  ioc_init+0x0/0x10 @ 1
[    2.010570] initcall ioc_init+0x0/0x10 returned 0 after 4 usecs
[    2.013756] calling  deadline_init+0x0/0x10 @ 1
[    2.014853] io scheduler mq-deadline registered
[    2.015919] initcall deadline_init+0x0/0x10 returned 0 after 1067 usecs
[    2.016907]  #16
[    2.017468] calling  kyber_init+0x0/0x10 @ 1
[    2.017472] io scheduler kyber registered
[    2.020814] initcall kyber_init+0x0/0x10 returned 0 after 3342 usecs
[    2.022710] calling  io_uring_init+0x0/0xe0 @ 1
[    2.024050] initcall io_uring_init+0x0/0xe0 returned 0 after 33 usecs
[    2.025957] rcu-torture: torture_onoff begin holdoff
[    2.025955] calling  percpu_counter_startup+0x0/0x70 @ 1
[    2.030836] initcall percpu_counter_startup+0x0/0x70 returned 0 after 1877 usecs
[    2.033066] calling  pcie_portdrv_init+0x0/0x50 @ 1
[    2.034623] initcall pcie_portdrv_init+0x0/0x50 returned 0 after 45 usecs
[    2.036655] calling  pci_proc_init+0x0/0xa0 @ 1
[    2.038029] initcall pci_proc_init+0x0/0xa0 returned 0 after 17 usecs
[    2.040014] calling  pci_hotplug_init+0x0/0x10 @ 1
[    2.041501] initcall pci_hotplug_init+0x0/0x10 returned 0 after 0 usecs
[    2.043492] calling  ged_driver_init+0x0/0x20 @ 1
[    2.044987] initcall ged_driver_init+0x0/0x20 returned 0 after 26 usecs
[    2.047014] calling  mrrm_init+0x0/0x190 @ 1
[    2.048262] initcall mrrm_init+0x0/0x190 returned -19 after 2 usecs
[    2.050169] calling  acpi_ac_init+0x0/0x60 @ 1
[    2.051651] initcall acpi_ac_init+0x0/0x60 returned 0 after 62 usecs
[    2.053591] calling  acpi_button_init+0x0/0x70 @ 1
[    2.055188] input: Power Button as /devices/platform/LNXPWRBN:00/input/input0
[    2.057471] ACPI: button: Power Button [PWRF]
[    2.058677] probe of LNXPWRBN:00 returned 0 after 3561 usecs
[    2.060461] initcall acpi_button_init+0x0/0x70 returned 0 after 5359 usecs
[    2.062458] calling  acpi_fan_driver_init+0x0/0x20 @ 1
[    2.064076] initcall acpi_fan_driver_init+0x0/0x20 returned 0 after 24 usecs
[    2.066295] calling  acpi_video_init+0x0/0xe0 @ 1
[    2.067648] initcall acpi_video_init+0x0/0xe0 returned 0 after 21 usecs
[    2.069249] calling  acpi_processor_driver_init+0x0/0xf0 @ 1
[    2.070635] probe of cpu0 returned 0 after 17 usecs
[    2.071823] probe of cpu1 returned 0 after 13 usecs
[    2.072985] probe of cpu2 returned 0 after 12 usecs
[    2.074143] probe of cpu3 returned 0 after 12 usecs
[    2.075535] probe of cpu4 returned 0 after 23 usecs
[    2.077103] probe of cpu5 returned 0 after 27 usecs
[    2.078509] probe of cpu6 returned 0 after 24 usecs
[    2.080006] probe of cpu7 returned 0 after 25 usecs
[    2.081222] probe of cpu8 returned 0 after 16 usecs
[    2.082357] probe of cpu9 returned 0 after 12 usecs
[    2.083509] probe of cpu10 returned 0 after 13 usecs
[    2.084688] probe of cpu11 returned 0 after 12 usecs
[    2.085857] probe of cpu12 returned 0 after 12 usecs
[    2.086909] probe of cpu13 returned 0 after 12 usecs
[    2.090246] probe of cpu14 returned 0 after 22 usecs
[    2.091412] probe of cpu15 returned 0 after 13 usecs
[    2.094891] probe of cpu16 returned 0 after 17 usecs
[    2.097174] initcall acpi_processor_driver_init+0x0/0xf0 returned 0 after 26585 usecs
[    2.098761] calling  acpi_thermal_init+0x0/0x90 @ 1
[    2.100001] initcall acpi_thermal_init+0x0/0x90 returned 0 after 127 usecs
[    2.101565] calling  platform_profile_init+0x0/0x70 @ 1
[    2.102603] initcall platform_profile_init+0x0/0x70 returned 0 after 10 usecs
[    2.104229] calling  acpi_battery_init+0x0/0x50 @ 1
[    2.105442] initcall acpi_battery_init+0x0/0x50 returned 0 after 36 usecs
[    2.107129] calling  bgrt_init+0x0/0xe0 @ 1
[    2.108126] initcall bgrt_init+0x0/0xe0 returned -19 after 0 usecs
[    2.109596] calling  virtio_pci_driver_init+0x0/0x20 @ 1
[    2.110897] initcall virtio_pci_driver_init+0x0/0x20 returned 0 after 14 usecs
[    2.112556] calling  virtio_input_driver_init+0x0/0x20 @ 1
[    2.113872] initcall virtio_input_driver_init+0x0/0x20 returned 0 after 5 usecs
[    2.115617] calling  n_null_init+0x0/0x20 @ 1
[    2.116611] initcall n_null_init+0x0/0x20 returned 0 after 0 usecs
[    2.118006] calling  pty_init+0x0/0x240 @ 1
[    2.119107] initcall pty_init+0x0/0x240 returned 0 after 90 usecs
[    2.120574] calling  sysrq_init+0x0/0x80 @ 1
[    2.121562] initcall sysrq_init+0x0/0x80 returned 0 after 4 usecs
[    2.122997] calling  serial8250_init+0x0/0x130 @ 1
[    2.124109] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.125690] probe of 00:03:0 returned 0 after 11 usecs
[    2.126863] probe of 00:03:0.0 returned 0 after 4 usecs
[    2.128113] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.129876] probe of 00:03 returned 0 after 4234 usecs
[    2.131072] probe of serial8250:0 returned 0 after 3 usecs
[    2.132303] probe of serial8250:0.1 returned 0 after 3 usecs
[    2.133769] probe of serial8250:0.2 returned 0 after 3 usecs
[    2.135222] probe of serial8250:0.3 returned 0 after 3 usecs
[    2.136571] probe of serial8250 returned 0 after 5 usecs
[    2.137717] initcall serial8250_init+0x0/0x130 returned 0 after 13608 usecs
[    2.139185] calling  exar_pci_driver_init+0x0/0x20 @ 1
[    2.140291] initcall exar_pci_driver_init+0x0/0x20 returned 0 after 14 usecs
[    2.141811] calling  lpss8250_pci_driver_init+0x0/0x20 @ 1
[    2.143084] initcall lpss8250_pci_driver_init+0x0/0x20 returned 0 after 13 usecs
[    2.144816] calling  mid8250_pci_driver_init+0x0/0x20 @ 1
[    2.146104] initcall mid8250_pci_driver_init+0x0/0x20 returned 0 after 9 usecs
[    2.147720] calling  serial_pci_driver_init+0x0/0x20 @ 1
[    2.148899] initcall serial_pci_driver_init+0x0/0x20 returned 0 after 14 usecs
[    2.150595] calling  pericom8250_pci_driver_init+0x0/0x20 @ 1
[    2.151917] initcall pericom8250_pci_driver_init+0x0/0x20 returned 0 after 12 usecs
[    2.153601] calling  random_sysctls_init+0x0/0x30 @ 1
[    2.154756] initcall random_sysctls_init+0x0/0x30 returned 0 after 6 usecs
[    2.156340] calling  virtio_console_init+0x0/0xf0 @ 1
[    2.157509] initcall virtio_console_init+0x0/0xf0 returned 0 after 29 usecs
[    2.159211] calling  hpet_init+0x0/0x90 @ 1
[    2.163546] probe of PNP0103:00 returned 19 after 3228 usecs
[    2.164656] initcall hpet_init+0x0/0x90 returned 0 after 4488 usecs
[    2.165916] calling  nvram_module_init+0x0/0xa0 @ 1
[    2.167104] Non-volatile memory driver v1.3
[    2.167891] initcall nvram_module_init+0x0/0xa0 returned 0 after 861 usecs
[    2.169247] calling  via_rng_mod_init+0x0/0x60 @ 1
[    2.170437] initcall via_rng_mod_init+0x0/0x60 returned -19 after 0 usecs
[    2.172024] calling  agp_amd64_mod_init+0x0/0x10 @ 1
[    2.173117] initcall agp_amd64_mod_init+0x0/0x10 returned -19 after 30 usecs
[    2.174680] calling  agp_intel_init+0x0/0x30 @ 1
[    2.175798] probe of 0000:00:00.0 returned 19 after 36 usecs
[    2.177188] initcall agp_intel_init+0x0/0x30 returned 0 after 1432 usecs
[    2.178711] calling  gpu_buddy_module_init+0x0/0x90 @ 1
[    2.179965] initcall gpu_buddy_module_init+0x0/0x90 returned 0 after 16 usecs
[    2.181625] calling  drm_core_init+0x0/0xd0 @ 1
[    2.182718] ACPI: bus type drm_connector registered
[    2.183921] initcall drm_core_init+0x0/0xd0 returned 0 after 1213 usecs
[    2.185440] calling  drm_display_helper_module_init+0x0/0x10 @ 1
[    2.186906] initcall drm_display_helper_module_init+0x0/0x10 returned 0 after 0 usecs
[    2.188731] calling  i915_init+0x0/0xd0 @ 1
[    2.189724] initcall i915_init+0x0/0xd0 returned 0 after 68 usecs
[    2.191083] calling  virtio_gpu_driver_init+0x0/0xc0 @ 1
[    2.192195] initcall virtio_gpu_driver_init+0x0/0xc0 returned 0 after 7 usecs
[    2.193688] calling  cn_proc_init+0x0/0x50 @ 1
[    2.194744] initcall cn_proc_init+0x0/0x50 returned 0 after 0 usecs
[    2.196221] calling  topology_sysfs_init+0x0/0x30 @ 1
[    2.197584] initcall topology_sysfs_init+0x0/0x30 returned 0 after 141 usecs
[    2.199252] calling  cacheinfo_sysfs_init+0x0/0x30 @ 1
[    2.201829] initcall cacheinfo_sysfs_init+0x0/0x30 returned 0 after 1483 usecs
[    2.203440] calling  loop_init+0x0/0x100 @ 1
[    2.206474] loop: module loaded
[    2.207247] initcall loop_init+0x0/0x100 returned 0 after 2869 usecs
[    2.208584] calling  virtio_blk_init+0x0/0xa0 @ 1
[    2.209559] initcall virtio_blk_init+0x0/0xa0 returned 0 after 14 usecs
[    2.211028] calling  mei_init+0x0/0xa0 @ 1
[    2.211982] initcall mei_init+0x0/0xa0 returned 0 after 19 usecs
[    2.213441] calling  mei_me_driver_init+0x0/0x20 @ 1
[    2.214652] initcall mei_me_driver_init+0x0/0x20 returned 0 after 16 usecs
[    2.216281] calling  mac_hid_init+0x0/0x40 @ 1
[    2.217327] initcall mac_hid_init+0x0/0x40 returned 0 after 4 usecs
[    2.218766] calling  spi_transport_init+0x0/0x90 @ 1
[    2.219944] initcall spi_transport_init+0x0/0x90 returned 0 after 8 usecs
[    2.221505] calling  virtio_scsi_init+0x0/0x140 @ 1
[    2.222640] initcall virtio_scsi_init+0x0/0x140 returned 0 after 15 usecs
[    2.224292] calling  init_sd+0x0/0x120 @ 1
[    2.225246] initcall init_sd+0x0/0x120 returned 0 after 12 usecs
[    2.226630] calling  init_sr+0x0/0x60 @ 1
[    2.227564] initcall init_sr+0x0/0x60 returned 0 after 6 usecs
[    2.228953] calling  init_sg+0x0/0x1a0 @ 1
[    2.229955] initcall init_sg+0x0/0x1a0 returned 0 after 12 usecs
[    2.231345] calling  ahci_pci_driver_init+0x0/0x20 @ 1
[    2.232899] ACPI: \_SB_.GSIA: Enabled at IRQ 16
[    2.234556] ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
[    2.236462] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
[    2.237971] ahci 0000:00:1f.2: flags: 64bit ncq only 
[    2.240358] scsi host0: ahci
[    2.241296] scsi host1: ahci
[    2.242261] scsi host2: ahci
[    2.243145] scsi host3: ahci
[    2.243993] scsi host4: ahci
[    2.244762] scsi host5: ahci
[    2.245495] ata1: SATA max UDMA/133 abar m4096@0xfebf1000 port 0xfebf1100 irq 24 lpm-pol 1
[    2.247419] ata2: SATA max UDMA/133 abar m4096@0xfebf1000 port 0xfebf1180 irq 24 lpm-pol 1
[    2.249246] ata3: SATA max UDMA/133 abar m4096@0xfebf1000 port 0xfebf1200 irq 24 lpm-pol 1
[    2.251188] ata4: SATA max UDMA/133 abar m4096@0xfebf1000 port 0xfebf1280 irq 24 lpm-pol 1
[    2.253192] ata5: SATA max UDMA/133 abar m4096@0xfebf1000 port 0xfebf1300 irq 24 lpm-pol 1
[    2.255155] ata6: SATA max UDMA/133 abar m4096@0xfebf1000 port 0xfebf1380 irq 24 lpm-pol 1
[    2.257164] probe of 0000:00:1f.2 returned 0 after 24561 usecs
[    2.258716] initcall ahci_pci_driver_init+0x0/0x20 returned 0 after 26123 usecs
[    2.260461] calling  piix_init+0x0/0x30 @ 1
[    2.261484] initcall piix_init+0x0/0x30 returned 0 after 15 usecs
[    2.262910] calling  amd_pci_driver_init+0x0/0x20 @ 1
[    2.264095] initcall amd_pci_driver_init+0x0/0x20 returned 0 after 11 usecs
[    2.265742] calling  oldpiix_pci_driver_init+0x0/0x20 @ 1
[    2.267036] initcall oldpiix_pci_driver_init+0x0/0x20 returned 0 after 12 usecs
[    2.268705] calling  sch_pci_driver_init+0x0/0x20 @ 1
[    2.269873] initcall sch_pci_driver_init+0x0/0x20 returned 0 after 13 usecs
[    2.271468] calling  blackhole_netdev_init+0x0/0x80 @ 1
[    2.272713] initcall blackhole_netdev_init+0x0/0x80 returned 0 after 7 usecs
[    2.274307] calling  phy_module_init+0x0/0x20 @ 1
[    2.275512] initcall phy_module_init+0x0/0x20 returned 0 after 104 usecs
[    2.277111] calling  virtio_net_driver_init+0x0/0xb0 @ 1
[    2.278368] initcall virtio_net_driver_init+0x0/0xb0 returned 0 after 6 usecs
[    2.280094] calling  tg3_driver_init+0x0/0x20 @ 1
[    2.281182] initcall tg3_driver_init+0x0/0x20 returned 0 after 15 usecs
[    2.282860] calling  e100_init_module+0x0/0x60 @ 1
[    2.284006] e100: Intel(R) PRO/100 Network Driver
[    2.285196] e100: Copyright(c) 1999-2006 Intel Corporation
[    2.286611] initcall e100_init_module+0x0/0x60 returned 0 after 2605 usecs
[    2.288361] calling  e1000_init_module+0x0/0x90 @ 1
[    2.289572] e1000: Intel(R) PRO/1000 Network Driver
[    2.290717] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.292181] initcall e1000_init_module+0x0/0x90 returned 0 after 2609 usecs
[    2.293927] calling  e1000_init_module+0x0/0x40 @ 1
[    2.295102] e1000e: Intel(R) PRO/1000 Network Driver
[    2.296312] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.297826] initcall e1000_init_module+0x0/0x40 returned 0 after 2724 usecs
[    2.299612] calling  sky2_init_module+0x0/0x30 @ 1
[    2.300843] sky2: driver version 1.30
[    2.301808] initcall sky2_init_module+0x0/0x30 returned 0 after 965 usecs
[    2.303554] calling  forcedeth_pci_driver_init+0x0/0x20 @ 1
[    2.305008] initcall forcedeth_pci_driver_init+0x0/0x20 returned 0 after 12 usecs
[    2.306980] calling  rtl8139_pci_driver_init+0x0/0x20 @ 1
[    2.308459] initcall rtl8139_pci_driver_init+0x0/0x20 returned 0 after 20 usecs
[    2.310379] calling  rtl8169_pci_driver_init+0x0/0x20 @ 1
[    2.311785] initcall rtl8169_pci_driver_init+0x0/0x20 returned 0 after 13 usecs
[    2.313648] calling  cdrom_init+0x0/0x10 @ 1
[    2.314784] initcall cdrom_init+0x0/0x10 returned 0 after 5 usecs
[    2.316348] calling  nonstatic_sysfs_init+0x0/0x10 @ 1
[    2.317530] initcall nonstatic_sysfs_init+0x0/0x10 returned 0 after 3 usecs
[    2.319274] calling  yenta_cardbus_driver_init+0x0/0x20 @ 1
[    2.320749] initcall yenta_cardbus_driver_init+0x0/0x20 returned 0 after 13 usecs
[    2.322618] calling  mon_init+0x0/0x140 @ 1
[    2.323823] initcall mon_init+0x0/0x140 returned 0 after 100 usecs
[    2.325468] calling  ehci_hcd_init+0x0/0x40 @ 1
[    2.326689] initcall ehci_hcd_init+0x0/0x40 returned 0 after 0 usecs
[    2.328586] calling  ehci_pci_init+0x0/0x60 @ 1
[    2.330007] initcall ehci_pci_init+0x0/0x60 returned 0 after 25 usecs
[    2.331947] calling  ohci_hcd_mod_init+0x0/0x40 @ 1
[    2.333508] initcall ohci_hcd_mod_init+0x0/0x40 returned 0 after 4 usecs
[    2.335557] calling  ohci_pci_init+0x0/0x60 @ 1
[    2.336876] initcall ohci_pci_init+0x0/0x60 returned 0 after 23 usecs
[    2.338591] calling  uhci_hcd_init+0x0/0xe0 @ 1
[    2.339822] initcall uhci_hcd_init+0x0/0xe0 returned 0 after 14 usecs
[    2.341525] calling  xhci_hcd_init+0x0/0x30 @ 1
[    2.342735] initcall xhci_hcd_init+0x0/0x30 returned 0 after 2 usecs
[    2.344408] calling  xhci_pci_init+0x0/0x70 @ 1
[    2.345565] initcall xhci_pci_init+0x0/0x70 returned 0 after 12 usecs
[    2.347229] calling  usblp_driver_init+0x0/0x20 @ 1
[    2.348488] usbcore: registered new interface driver usblp
[    2.349823] initcall usblp_driver_init+0x0/0x20 returned 0 after 1348 usecs
[    2.351659] calling  usb_storage_driver_init+0x0/0x30 @ 1
[    2.353070] usbcore: registered new interface driver usb-storage
[    2.354600] initcall usb_storage_driver_init+0x0/0x30 returned 0 after 1542 usecs
[    2.356496] calling  i8042_init+0x0/0x650 @ 1
[    2.357692] probe of 00:00 returned 0 after 18 usecs
[    2.358996] probe of 00:01 returned 0 after 7 usecs
[    2.360221] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    2.362867] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.364224] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.365559] probe of i8042 returned 0 after 3244 usecs
[    2.366881] initcall i8042_init+0x0/0x650 returned 0 after 9229 usecs
[    2.368377] calling  serport_init+0x0/0x40 @ 1
[    2.369392] initcall serport_init+0x0/0x40 returned 0 after 0 usecs
[    2.370830] calling  input_leds_init+0x0/0x10 @ 1
[    2.371844] initcall input_leds_init+0x0/0x10 returned 0 after 1 usecs
[    2.373398] calling  evdev_init+0x0/0x10 @ 1
[    2.374557] initcall evdev_init+0x0/0x10 returned 0 after 157 usecs
[    2.376151] calling  atkbd_init+0x0/0x30 @ 1
[    2.377222] initcall atkbd_init+0x0/0x30 returned 0 after 21 usecs
[    2.378808] calling  psmouse_init+0x0/0x50 @ 1
[    2.380014] initcall psmouse_init+0x0/0x50 returned 0 after 86 usecs
[    2.381583] calling  cmos_init+0x0/0x50 @ 1
[    2.384955] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    2.385494] rtc_cmos PNP0B00:00: RTC can wake from S4
[    2.391457] probe of serio0 returned 0 after 12670 usecs
[    2.391773] probe of alarmtimer.0.auto returned 0 after 5 usecs
[    2.393289] probe of serio1 returned 19 after 443 usecs
[    2.394416] rtc_cmos PNP0B00:00: registered as rtc0
[    2.397254] rtc_cmos PNP0B00:00: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    2.399590] probe of PNP0B00:00 returned 0 after 14135 usecs
[    2.401242] initcall cmos_init+0x0/0x50 returned 0 after 15796 usecs
[    2.403234] calling  smbalert_driver_init+0x0/0x20 @ 1
[    2.404516] initcall smbalert_driver_init+0x0/0x20 returned 0 after 7 usecs
[    2.406225] calling  i801_driver_init+0x0/0xd0 @ 1
[    2.407557] initcall i801_driver_init+0x0/0xd0 returned 0 after 32 usecs
[    2.408252] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    2.409362] calling  ptp_kvm_init+0x0/0xe0 @ 1
[    2.410998] i2c i2c-0: Memory type 0x07 not supported yet, not instantiating SPD
[    2.412105] initcall ptp_kvm_init+0x0/0xe0 returned 0 after 159 usecs
[    2.414042] probe of 0000:00:1f.3 returned 0 after 6367 usecs
[    2.415759] calling  vmclock_platform_driver_init+0x0/0x20 @ 1
[    2.418800] initcall vmclock_platform_driver_init+0x0/0x20 returned 0 after 19 usecs
[    2.420804] calling  thermal_throttle_init_device+0x0/0x50 @ 1
[    2.422253] initcall thermal_throttle_init_device+0x0/0x50 returned 0 after 0 usecs
[    2.424439] calling  dm_init+0x0/0x80 @ 1
[    2.425642] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    2.427904] initcall dm_init+0x0/0x80 returned 0 after 2384 usecs
[    2.429468] calling  dm_mirror_init+0x0/0x80 @ 1
[    2.430717] initcall dm_mirror_init+0x0/0x80 returned 0 after 10 usecs
[    2.432451] calling  dm_dirty_log_init+0x0/0xf0 @ 1
[    2.433783] initcall dm_dirty_log_init+0x0/0xf0 returned 0 after 0 usecs
[    2.435557] calling  dm_zero_init+0x0/0x10 @ 1
[    2.436702] initcall dm_zero_init+0x0/0x10 returned 0 after 0 usecs
[    2.438400] calling  amd_pstate_init+0x0/0x340 @ 1
[    2.439689] initcall amd_pstate_init+0x0/0x340 returned -19 after 0 usecs
[    2.441536] calling  intel_pstate_init+0x0/0x950 @ 1
[    2.442886] intel_pstate: CPU model not supported
[    2.444158] initcall intel_pstate_init+0x0/0x950 returned -19 after 1274 usecs
[    2.446065] calling  haltpoll_init+0x0/0x140 @ 1
[    2.447326] initcall haltpoll_init+0x0/0x140 returned -19 after 1 usecs
[    2.448980] calling  esrt_sysfs_init+0x0/0x2e0 @ 1
[    2.450233] initcall esrt_sysfs_init+0x0/0x2e0 returned -38 after 0 usecs
[    2.452034] calling  hid_init+0x0/0x60 @ 1
[    2.453214] hid: raw HID events driver (C) Jiri Kosina
[    2.454575] initcall hid_init+0x0/0x60 returned 0 after 1384 usecs
[    2.456239] calling  hid_generic_init+0x0/0x20 @ 1
[    2.457518] initcall hid_generic_init+0x0/0x20 returned 0 after 20 usecs
[    2.459270] calling  gyration_driver_init+0x0/0x20 @ 1
[    2.460679] initcall gyration_driver_init+0x0/0x20 returned 0 after 18 usecs
[    2.462516] calling  ntrig_driver_init+0x0/0x20 @ 1
[    2.463772] initcall ntrig_driver_init+0x0/0x20 returned 0 after 14 usecs
[    2.465478] calling  pl_driver_init+0x0/0x20 @ 1
[    2.466804] initcall pl_driver_init+0x0/0x20 returned 0 after 14 usecs
[    2.468447] calling  pl_driver_init+0x0/0x20 @ 1
[    2.469640] initcall pl_driver_init+0x0/0x20 returned 0 after 12 usecs
[    2.471248] calling  samsung_driver_init+0x0/0x20 @ 1
[    2.472499] initcall samsung_driver_init+0x0/0x20 returned 0 after 13 usecs
[    2.474226] calling  sony_init+0x0/0x20 @ 1
[    2.475321] initcall sony_init+0x0/0x20 returned 0 after 11 usecs
[    2.476894] calling  sp_driver_init+0x0/0x20 @ 1
[    2.478116] initcall sp_driver_init+0x0/0x20 returned 0 after 12 usecs
[    2.479805] calling  ts_driver_init+0x0/0x20 @ 1
[    2.481108] initcall ts_driver_init+0x0/0x20 returned 0 after 16 usecs
[    2.482820] calling  hid_init+0x0/0x80 @ 1
[    2.483880] usbcore: registered new interface driver usbhid
[    2.485326] usbhid: USB HID core driver
[    2.486323] initcall hid_init+0x0/0x80 returned 0 after 2457 usecs
[    2.487952] calling  wmi_bmof_driver_init+0x0/0x20 @ 1
[    2.489280] initcall wmi_bmof_driver_init+0x0/0x20 returned 0 after 8 usecs
[    2.491052] calling  eeepc_laptop_init+0x0/0x80 @ 1
[    2.492393] initcall eeepc_laptop_init+0x0/0x80 returned -19 after 40 usecs
[    2.494253] calling  alsa_hwdep_init+0x0/0x70 @ 1
[    2.495508] initcall alsa_hwdep_init+0x0/0x70 returned 0 after 4 usecs
[    2.497307] calling  alsa_timer_init+0x0/0x2c0 @ 1
[    2.498675] initcall alsa_timer_init+0x0/0x2c0 returned 0 after 101 usecs
[    2.500515] calling  snd_hrtimer_init+0x0/0x130 @ 1
[    2.501814] initcall snd_hrtimer_init+0x0/0x130 returned 0 after 1 usecs
[    2.503532] calling  alsa_pcm_init+0x0/0x80 @ 1
[    2.504783] initcall alsa_pcm_init+0x0/0x80 returned 0 after 2 usecs
[    2.506477] calling  alsa_seq_init+0x0/0x60 @ 1
[    2.507772] initcall alsa_seq_init+0x0/0x60 returned 0 after 63 usecs
[    2.509400] calling  alsa_seq_dummy_init+0x0/0xc0 @ 1
[    2.510733] initcall alsa_seq_dummy_init+0x0/0xc0 returned 0 after 1 usecs
[    2.512548] calling  azx_driver_init+0x0/0x20 @ 1
[    2.513793] initcall azx_driver_init+0x0/0x20 returned 0 after 26 usecs
[    2.515560] calling  sock_diag_init+0x0/0x40 @ 1
[    2.516809] initcall sock_diag_init+0x0/0x40 returned 0 after 31 usecs
[    2.518433] calling  failover_init+0x0/0x20 @ 1
[    2.519598] initcall failover_init+0x0/0x20 returned 0 after 4 usecs
[    2.521255] calling  blackhole_init+0x0/0x10 @ 1
[    2.522479] initcall blackhole_init+0x0/0x10 returned 0 after 1 usecs
[    2.524198] calling  init_cgroup_cls+0x0/0x10 @ 1
[    2.525493] initcall init_cgroup_cls+0x0/0x10 returned 0 after 0 usecs
[    2.527199] calling  nfnetlink_init+0x0/0x50 @ 1
[    2.528376] initcall nfnetlink_init+0x0/0x50 returned 0 after 4 usecs
[    2.530042] calling  nfnetlink_log_init+0x0/0xc0 @ 1
[    2.531259] initcall nfnetlink_log_init+0x0/0xc0 returned 0 after 3 usecs
[    2.533083] calling  nf_conntrack_standalone_init+0x0/0xb0 @ 1
[    2.534625] initcall nf_conntrack_standalone_init+0x0/0xb0 returned 0 after 63 usecs
[    2.536648] calling  ctnetlink_init+0x0/0xa0 @ 1
[    2.537921] initcall ctnetlink_init+0x0/0xa0 returned 0 after 0 usecs
[    2.539576] calling  nf_conntrack_ftp_init+0x0/0x130 @ 1
[    2.540945] initcall nf_conntrack_ftp_init+0x0/0x130 returned 0 after 3 usecs
[    2.542854] calling  nf_conntrack_irc_init+0x0/0x190 @ 1
[    2.544317] nf_conntrack_irc: The irc conntrack helper is scheduled for removal.
[    2.544317] Please contact the netfilter-devel mailing list if you still need this.
[    2.548178] initcall nf_conntrack_irc_init+0x0/0x190 returned 0 after 3860 usecs
[    2.550091] calling  nf_conntrack_sip_init+0x0/0x1a0 @ 1
[    2.551560] initcall nf_conntrack_sip_init+0x0/0x1a0 returned 0 after 5 usecs
[    2.553475] calling  nf_nat_init+0x0/0xc0 @ 1
[    2.554691] initcall nf_nat_init+0x0/0xc0 returned 0 after 8 usecs
[    2.556281] calling  nf_nat_ftp_init+0x0/0x30 @ 1
[    2.557496] initcall nf_nat_ftp_init+0x0/0x30 returned 0 after 0 usecs
[    2.559200] calling  nf_nat_irc_init+0x0/0x30 @ 1
[    2.560457] initcall nf_nat_irc_init+0x0/0x30 returned 0 after 0 usecs
[    2.562122] calling  nf_nat_sip_init+0x0/0x40 @ 1
[    2.563379] initcall nf_nat_sip_init+0x0/0x40 returned 0 after 0 usecs
[    2.565071] calling  xt_init+0x0/0xc0 @ 1
[    2.566089] initcall xt_init+0x0/0xc0 returned 0 after 2 usecs
[    2.567586] calling  tcpudp_mt_init+0x0/0x20 @ 1
[    2.568128] ata1: SATA link down (SStatus 0 SControl 300)
[    2.568882] initcall tcpudp_mt_init+0x0/0x20 returned 0 after 0 usecs
[    2.568886] calling  connsecmark_tg_init+0x0/0x20 @ 1
[    2.568890] initcall connsecmark_tg_init+0x0/0x20 returned 0 after 0 usecs
[    2.571016] ata2: SATA link down (SStatus 0 SControl 300)
[    2.572230] calling  nflog_tg_init+0x0/0x20 @ 1
[    2.574266] ata4: SATA link down (SStatus 0 SControl 300)
[    2.575657] initcall nflog_tg_init+0x0/0x20 returned 0 after 0 usecs
[    2.577997] ata5: SATA link down (SStatus 0 SControl 300)
[    2.578517] calling  secmark_tg_init+0x0/0x20 @ 1
[    2.580674] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.581825] initcall secmark_tg_init+0x0/0x20 returned 0 after 0 usecs
[    2.583977] ata6: SATA link down (SStatus 0 SControl 300)
[    2.584765] calling  tcpmss_tg_init+0x0/0x20 @ 1
[    2.586451] ata3.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    2.587963] initcall tcpmss_tg_init+0x0/0x20 returned 0 after 0 usecs
[    2.589423] ata3.00: applying bridge limits
[    2.590652] calling  conntrack_mt_init+0x0/0x20 @ 1
[    2.592463] ata3.00: configured for UDMA/100
[    2.594144] initcall conntrack_mt_init+0x0/0x20 returned 0 after 0 usecs
[    2.595924] scsi 2:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    2.596613] calling  policy_mt_init+0x0/0x20 @ 1
[    2.596619] initcall policy_mt_init+0x0/0x20 returned 0 after 0 usecs
[    2.599387] sr 2:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    2.599887] calling  state_mt_init+0x0/0x10 @ 1
[    2.602477] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.603405] initcall state_mt_init+0x0/0x10 returned 0 after 1 usecs
[    2.605586] sr 2:0:0:0: [sr0] Hmm, seems the drive doesn't support multisession CD's
[    2.606623] calling  gre_offload_init+0x0/0x60 @ 1
[    2.614486] initcall gre_offload_init+0x0/0x60 returned 0 after 0 usecs
[    2.614571] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    2.616028] calling  sysctl_ipv4_init+0x0/0x80 @ 1
[    2.617103] probe of 2:0:0:0 returned 0 after 18412 usecs
[    2.618322] initcall sysctl_ipv4_init+0x0/0x80 returned 0 after 73 usecs
[    2.619718] sr 2:0:0:0: Attached scsi generic sg0 type 5
[    2.621203] calling  nf_defrag_init+0x0/0x30 @ 1
[    2.621208] initcall nf_defrag_init+0x0/0x30 returned 0 after 0 usecs
[    2.621211] calling  cubictcp_register+0x0/0x70 @ 1
[    2.626473] initcall cubictcp_register+0x0/0x70 returned 0 after 0 usecs
[    2.628248] calling  xfrm_user_init+0x0/0x40 @ 1
[    2.629440] Initializing XFRM netlink socket
[    2.630596] initcall xfrm_user_init+0x0/0x40 returned 0 after 1156 usecs
[    2.632353] calling  inet6_init+0x0/0x350 @ 1
[    2.633519] NET: Registered PF_INET6 protocol family
[    2.635314] Segment Routing with IPv6
[    2.636339] In-situ OAM (IOAM) with IPv6
[    2.637428] initcall inet6_init+0x0/0x350 returned 0 after 3949 usecs
[    2.639112] calling  ah6_init+0x0/0x80 @ 1
[    2.640251] initcall ah6_init+0x0/0x80 returned 0 after 0 usecs
[    2.641861] calling  esp6_init+0x0/0x80 @ 1
[    2.642943] initcall esp6_init+0x0/0x80 returned 0 after 0 usecs
[    2.644490] calling  nf_defrag_init+0x0/0x70 @ 1
[    2.645592] initcall nf_defrag_init+0x0/0x70 returned 0 after 12 usecs
[    2.647378] calling  ipv6header_mt6_init+0x0/0x10 @ 1
[    2.648702] initcall ipv6header_mt6_init+0x0/0x10 returned 0 after 0 usecs
[    2.650383] calling  packet_init+0x0/0x90 @ 1
[    2.651506] NET: Registered PF_PACKET protocol family
[    2.652857] initcall packet_init+0x0/0x90 returned 0 after 1353 usecs
[    2.654689] calling  init_rpcsec_gss+0x0/0x80 @ 1
[    2.655961] initcall init_rpcsec_gss+0x0/0x80 returned 0 after 9 usecs
[    2.657700] calling  init_kerberos_module+0x0/0xf0 @ 1
[    2.659070] initcall init_kerberos_module+0x0/0xf0 returned 0 after 4 usecs
[    2.660996] calling  init_p9+0x0/0x30 @ 1
[    2.662108] 9pnet: Installing 9P2000 support
[    2.663243] initcall init_p9+0x0/0x30 returned 0 after 1151 usecs
[    2.664771] calling  p9_trans_fd_init+0x0/0x30 @ 1
[    2.666069] initcall p9_trans_fd_init+0x0/0x30 returned 0 after 0 usecs
[    2.667843] calling  p9_virtio_init+0x0/0x70 @ 1
[    2.668959] initcall p9_virtio_init+0x0/0x70 returned 0 after 13 usecs
[    2.670536] calling  init_dns_resolver+0x0/0xf0 @ 1
[    2.671711] Key type dns_resolver registered
[    2.672802] initcall init_dns_resolver+0x0/0xf0 returned 0 after 1101 usecs
[    2.674654] calling  handshake_init+0x0/0xa0 @ 1
[    2.675924] initcall handshake_init+0x0/0xa0 returned 0 after 12 usecs
[    2.677696] calling  pm_check_save_msr+0x0/0xd0 @ 1
[    2.678869] initcall pm_check_save_msr+0x0/0xd0 returned 0 after 6 usecs
[    2.680280] calling  mcheck_init_device+0x0/0x140 @ 1
[    2.682966] initcall mcheck_init_device+0x0/0x140 returned 0 after 1500 usecs
[    2.684885] entering initcall level: late
[    2.685913] calling  random_kstack_init+0x0/0x20 @ 1
[    2.687200] initcall random_kstack_init+0x0/0x20 returned 0 after 32 usecs
[    2.688905] calling  irq_init_stats+0x0/0x80 @ 1
[    2.690115] initcall irq_init_stats+0x0/0x80 returned 0 after 0 usecs
[    2.691816] calling  cpu_finalize_pre_userspace+0x0/0x40 @ 1
[    2.693249] initcall cpu_finalize_pre_userspace+0x0/0x40 returned 0 after 0 usecs
[    2.695131] calling  intel_epb_init+0x0/0xa0 @ 1
[    2.696344] initcall intel_epb_init+0x0/0xa0 returned -19 after 0 usecs
[    2.698033] calling  print_s5_reset_status_mmio+0x0/0xa0 @ 1
[    2.699490] initcall print_s5_reset_status_mmio+0x0/0xa0 returned 0 after 0 usecs
[    2.701369] calling  print_dmi_agesa+0x0/0x20 @ 1
[    2.702531] initcall print_dmi_agesa+0x0/0x20 returned 0 after 17 usecs
[    2.704186] calling  mcheck_late_init+0x0/0x90 @ 1
[    2.705437] initcall mcheck_late_init+0x0/0x90 returned 0 after 14 usecs
[    2.707136] calling  severities_debugfs_init+0x0/0x30 @ 1
[    2.708489] initcall severities_debugfs_init+0x0/0x30 returned 0 after 1 usecs
[    2.710264] calling  microcode_init+0x0/0x1a0 @ 1
[    2.711379] initcall microcode_init+0x0/0x1a0 returned -22 after 0 usecs
[    2.712894] calling  cpu_init_debugfs+0x0/0x100 @ 1
[    2.714027] initcall cpu_init_debugfs+0x0/0x100 returned 0 after 14 usecs
[    2.715612] calling  sld_mitigate_sysctl_init+0x0/0x30 @ 1
[    2.716880] initcall sld_mitigate_sysctl_init+0x0/0x30 returned 0 after 5 usecs
[    2.718733] calling  hpet_insert_resource+0x0/0x30 @ 1
[    2.719974] initcall hpet_insert_resource+0x0/0x30 returned 0 after 0 usecs
[    2.721708] calling  start_sync_check_timer+0x0/0x60 @ 1
[    2.723085] initcall start_sync_check_timer+0x0/0x60 returned 0 after 0 usecs
[    2.724892] calling  update_mp_table+0x0/0x670 @ 1
[    2.726134] initcall update_mp_table+0x0/0x670 returned 0 after 0 usecs
[    2.727826] calling  lapic_insert_resource+0x0/0x50 @ 1
[    2.729205] initcall lapic_insert_resource+0x0/0x50 returned 0 after 0 usecs
[    2.730996] calling  print_ipi_mode+0x0/0x40 @ 1
[    2.732243] IPI shorthand broadcast: enabled
[    2.733370] initcall print_ipi_mode+0x0/0x40 returned 0 after 1127 usecs
[    2.735128] calling  print_ICs+0x0/0x130 @ 1
[    2.736196] initcall print_ICs+0x0/0x130 returned 0 after 0 usecs
[    2.737754] calling  setup_efi_kvm_sev_migration+0x0/0x10 @ 1
[    2.739201] initcall setup_efi_kvm_sev_migration+0x0/0x10 returned 0 after 0 usecs
[    2.741167] calling  arch_uprobes_init+0x0/0x50 @ 1
[    2.742478] initcall arch_uprobes_init+0x0/0x50 returned 0 after 0 usecs
[    2.744222] calling  create_tlb_single_page_flush_ceiling+0x0/0x30 @ 1
[    2.745932] initcall create_tlb_single_page_flush_ceiling+0x0/0x30 returned 0 after 3 usecs
[    2.748096] calling  pat_memtype_list_init+0x0/0x40 @ 1
[    2.749477] initcall pat_memtype_list_init+0x0/0x40 returned 0 after 1 usecs
[    2.751319] calling  create_init_pkru_value+0x0/0x40 @ 1
[    2.752737] initcall create_init_pkru_value+0x0/0x40 returned 0 after 0 usecs
[    2.754581] calling  kernel_panic_sysctls_init+0x0/0x30 @ 1
[    2.756003] initcall kernel_panic_sysctls_init+0x0/0x30 returned 0 after 10 usecs
[    2.757815] calling  kernel_panic_sysfs_init+0x0/0x20 @ 1
[    2.759106] initcall kernel_panic_sysfs_init+0x0/0x20 returned 0 after 4 usecs
[    2.760899] calling  panic_force_cpu_late_init+0x0/0x40 @ 1
[    2.762254] initcall panic_force_cpu_late_init+0x0/0x40 returned 0 after 0 usecs
[    2.764035] calling  kernel_exit_sysctls_init+0x0/0x30 @ 1
[    2.765456] initcall kernel_exit_sysctls_init+0x0/0x30 returned 0 after 2 usecs
[    2.767327] calling  kernel_exit_sysfs_init+0x0/0x20 @ 1
[    2.768685] initcall kernel_exit_sysfs_init+0x0/0x20 returned 0 after 2 usecs
[    2.770346] calling  param_sysfs_builtin_init+0x0/0x1f0 @ 1
[    2.777576] initcall param_sysfs_builtin_init+0x0/0x1f0 returned 0 after 5876 usecs
[    2.779265] calling  reboot_ksysfs_init+0x0/0x80 @ 1
[    2.780322] initcall reboot_ksysfs_init+0x0/0x80 returned 0 after 9 usecs
[    2.781744] calling  sched_core_sysctl_init+0x0/0x30 @ 1
[    2.783090] initcall sched_core_sysctl_init+0x0/0x30 returned 0 after 2 usecs
[    2.784834] calling  sched_fair_sysctl_init+0x0/0x30 @ 1
[    2.786197] initcall sched_fair_sysctl_init+0x0/0x30 returned 0 after 0 usecs
[    2.788061] calling  sched_rt_sysctl_init+0x0/0x30 @ 1
[    2.789599] initcall sched_rt_sysctl_init+0x0/0x30 returned 0 after 2 usecs
[    2.791454] calling  sched_dl_sysctl_init+0x0/0x30 @ 1
[    2.793290] initcall sched_dl_sysctl_init+0x0/0x30 returned 0 after 5 usecs
[    2.795380] calling  sched_clock_init_late+0x0/0x90 @ 1
[    2.796914] sched_clock: Marking stable (2564473906, 232429596)->(3152155673, -355252171)
[    2.799730] initcall sched_clock_init_late+0x0/0x90 returned 0 after 2817 usecs
[    2.802060] calling  sched_init_debug+0x0/0x360 @ 1
[    2.803703] initcall sched_init_debug+0x0/0x360 returned 0 after 93 usecs
[    2.805744] calling  cpu_latency_qos_init+0x0/0x50 @ 1
[    2.807487] initcall cpu_latency_qos_init+0x0/0x50 returned 0 after 97 usecs
[    2.809645] calling  pm_debugfs_init+0x0/0x30 @ 1
[    2.811113] initcall pm_debugfs_init+0x0/0x30 returned 0 after 4 usecs
[    2.813093] calling  printk_late_init+0x0/0x160 @ 1
[    2.814620] initcall printk_late_init+0x0/0x160 returned 0 after 15 usecs
[    2.816789] calling  init_srcu_module_notifier+0x0/0x40 @ 1
[    2.818574] initcall init_srcu_module_notifier+0x0/0x40 returned 0 after 1 usecs
[    2.821483] calling  kernel_rcu_stall_sysfs_init+0x0/0x20 @ 1
[    2.821557] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
[    2.823331] initcall kernel_rcu_stall_sysfs_init+0x0/0x20 returned 0 after 4 usecs
[    2.825760] probe of serio1 returned 0 after 430053 usecs
[    2.827979] calling  swiotlb_create_default_debugfs+0x0/0xa0 @ 1
[    2.831407] initcall swiotlb_create_default_debugfs+0x0/0xa0 returned 0 after 4 usecs
[    2.833866] calling  tmigr_init_isolation+0x0/0x80 @ 1
[    2.835718] initcall tmigr_init_isolation+0x0/0x80 returned 0 after 238 usecs
[    2.838023] calling  tk_debug_sleep_time_init+0x0/0x30 @ 1
[    2.839788] initcall tk_debug_sleep_time_init+0x0/0x30 returned 0 after 4 usecs
[    2.842167] calling  kernel_acct_sysctls_init+0x0/0x30 @ 1
[    2.843908] initcall kernel_acct_sysctls_init+0x0/0x30 returned 0 after 4 usecs
[    2.845762] calling  kexec_core_sysctl_init+0x0/0x30 @ 1
[    2.847095] initcall kexec_core_sysctl_init+0x0/0x30 returned 0 after 4 usecs
[    2.848949] calling  bpf_rstat_kfunc_init+0x0/0x10 @ 1
[    2.850249] initcall bpf_rstat_kfunc_init+0x0/0x10 returned 0 after 0 usecs
[    2.852041] calling  debugfs_kprobe_init+0x0/0x80 @ 1
[    2.853335] initcall debugfs_kprobe_init+0x0/0x80 returned 0 after 6 usecs
[    2.855094] calling  kernel_delayacct_sysctls_init+0x0/0x30 @ 1
[    2.856528] initcall kernel_delayacct_sysctls_init+0x0/0x30 returned 0 after 2 usecs
[    2.858375] calling  taskstats_init+0x0/0x40 @ 1
[    2.859477] registered taskstats version 1
[    2.860483] initcall taskstats_init+0x0/0x40 returned 0 after 1014 usecs
[    2.862200] calling  trigger_data_free_init+0x0/0xd0 @ 1
[    2.863578] initcall trigger_data_free_init+0x0/0xd0 returned 0 after 0 usecs
[    2.865407] calling  load_system_certificate_list+0x0/0x40 @ 1
[    2.866894] Loading compiled-in X.509 certificates
[    2.868158] initcall load_system_certificate_list+0x0/0x40 returned 0 after 1263 usecs
[    2.870198] calling  mempool_faul_inject_init+0x0/0x10 @ 1
[    2.871401] initcall mempool_faul_inject_init+0x0/0x10 returned -19 after 0 usecs
[    2.873255] calling  vmstat_late_init+0x0/0x20 @ 1
[    2.874506] initcall vmstat_late_init+0x0/0x20 returned 0 after 4 usecs
[    2.876202] calling  fault_around_debugfs+0x0/0x30 @ 1
[    2.877557] initcall fault_around_debugfs+0x0/0x30 returned 0 after 2 usecs
[    2.879288] calling  slab_sysfs_init+0x0/0x100 @ 1
[    2.882049] initcall slab_sysfs_init+0x0/0x100 returned 0 after 1770 usecs
[    2.883872] calling  max_swapfiles_check+0x0/0x10 @ 1
[    2.885247] initcall max_swapfiles_check+0x0/0x10 returned 0 after 0 usecs
[    2.887000] calling  hugetlb_vmemmap_init+0x0/0x190 @ 1
[    2.888330] initcall hugetlb_vmemmap_init+0x0/0x190 returned 0 after 4 usecs
[    2.890171] calling  mempolicy_sysfs_init+0x0/0x3b0 @ 1
[    2.891564] initcall mempolicy_sysfs_init+0x0/0x3b0 returned 0 after 6 usecs
[    2.893315] calling  memory_tier_late_init+0x0/0x7b0 @ 1
[    2.894837] Demotion targets for Node 0: null
[    2.895965] initcall memory_tier_late_init+0x0/0x7b0 returned 0 after 1256 usecs
[    2.897878] calling  check_early_ioremap_leak+0x0/0x50 @ 1
[    2.899196] initcall check_early_ioremap_leak+0x0/0x50 returned 0 after 0 usecs
[    2.901003] calling  mg_debugfs_init+0x0/0x30 @ 1
[    2.902168] initcall mg_debugfs_init+0x0/0x30 returned 0 after 3 usecs
[    2.903636] calling  init_root_keyring+0x0/0x10 @ 1
[    2.904819] initcall init_root_keyring+0x0/0x10 returned 0 after 20 usecs
[    2.906374] calling  security_initcall_late+0x0/0xf0 @ 1
[    2.907658] initcall security_initcall_late+0x0/0xf0 returned 0 after 0 usecs
[    2.909352] calling  crypto_algapi_init+0x0/0x10 @ 1
[    2.910566] initcall crypto_algapi_init+0x0/0x10 returned 0 after 3 usecs
[    2.912212] calling  blk_timeout_init+0x0/0x20 @ 1
[    2.913285] initcall blk_timeout_init+0x0/0x20 returned 0 after 0 usecs
[    2.914759] calling  depot_debugfs_init+0x0/0x50 @ 1
[    2.915932] initcall depot_debugfs_init+0x0/0x50 returned 0 after 3 usecs
[    2.917475] calling  pci_resource_alignment_sysfs_init+0x0/0x20 @ 1
[    2.918792] initcall pci_resource_alignment_sysfs_init+0x0/0x20 returned 0 after 5 usecs
[    2.920542] calling  dmar_free_unused_resources+0x0/0xc0 @ 1
[    2.921823] initcall dmar_free_unused_resources+0x0/0xc0 returned 0 after 0 usecs
[    2.923396] calling  sync_state_resume_initcall+0x0/0x10 @ 1
[    2.924592] initcall sync_state_resume_initcall+0x0/0x10 returned 0 after 0 usecs
[    2.926237] calling  deferred_probe_initcall+0x0/0x90 @ 1
[    2.927398] initcall deferred_probe_initcall+0x0/0x90 returned 0 after 49 usecs
[    2.928946] calling  late_resume_init+0x0/0x190 @ 1
[    2.929999] PM:   Magic number: 2:712:41
[    2.930814] bdi 7:6: hash matches
[    2.931557] initcall late_resume_init+0x0/0x190 returned 0 after 1558 usecs
[    2.933025] calling  init_netconsole+0x0/0x6d0 @ 1
[    2.934033] netconsole: network logging started
[    2.934933] initcall init_netconsole+0x0/0x6d0 returned 0 after 917 usecs
[    2.936310] calling  acpi_cpufreq_init+0x0/0x20 @ 1
[    2.937326] initcall acpi_cpufreq_init+0x0/0x20 returned -19 after 35 usecs
[    2.938899] calling  firmware_memmap_init+0x0/0x40 @ 1
[    2.940054] initcall firmware_memmap_init+0x0/0x40 returned 0 after 20 usecs
[    2.941556] calling  register_update_efi_random_seed+0x0/0x30 @ 1
[    2.942945] initcall register_update_efi_random_seed+0x0/0x30 returned 0 after 0 usecs
[    2.944729] calling  efi_shutdown_init+0x0/0x50 @ 1
[    2.945823] initcall efi_shutdown_init+0x0/0x50 returned -19 after 0 usecs
[    2.947322] calling  efi_earlycon_unmap_fb+0x0/0x50 @ 1
[    2.948501] initcall efi_earlycon_unmap_fb+0x0/0x50 returned 0 after 0 usecs
[    2.950013] calling  bpf_kfunc_init+0x0/0x10 @ 1
[    2.950981] initcall bpf_kfunc_init+0x0/0x10 returned 0 after 0 usecs
[    2.952380] calling  init_subsystem+0x0/0x10 @ 1
[    2.953347] initcall init_subsystem+0x0/0x10 returned 0 after 0 usecs
[    2.954608] calling  xdp_metadata_init+0x0/0x10 @ 1
[    2.955624] initcall xdp_metadata_init+0x0/0x10 returned 0 after 0 usecs
[    2.957035] calling  tcp_congestion_default+0x0/0x20 @ 1
[    2.958184] initcall tcp_congestion_default+0x0/0x20 returned 0 after 1 usecs
[    2.959737] calling  inet_blackhole_dev_init+0x0/0x30 @ 1
[    2.960853] initcall inet_blackhole_dev_init+0x0/0x30 returned 0 after 5 usecs
[    2.962390] calling  ip_auto_config+0x0/0x14c0 @ 1
[    2.963381] initcall ip_auto_config+0x0/0x14c0 returned 0 after 12 usecs
[    2.964796] calling  regulatory_init_db+0x0/0x130 @ 1
[    2.965833] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    2.967697] kworker/u70:0 (211) used greatest stack depth: 14024 bytes left
[    2.968202] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    2.970675] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    2.972224] faux_driver regulatory: Direct firmware load for regulatory.db failed with error -2
[    2.974023] cfg80211: failed to load regulatory.db
[    2.974054] initcall regulatory_init_db+0x0/0x130 returned 0 after 8225 usecs
[    2.976894] calling  pci_mmcfg_late_insert_resources+0x0/0x70 @ 1
[    2.978400] initcall pci_mmcfg_late_insert_resources+0x0/0x70 returned 0 after 1 usecs
[    2.980154] calling  software_resume_initcall+0x0/0x120 @ 1
[    2.981376] initcall software_resume_initcall+0x0/0x120 returned -2 after 0 usecs
[    2.982882] calling  trace_eval_sync+0x0/0x20 @ 1
[    2.983945] initcall trace_eval_sync+0x0/0x20 returned 0 after 11 usecs
[    2.985397] calling  late_trace_init+0x0/0xf0 @ 1
[    2.986298] initcall late_trace_init+0x0/0xf0 returned 0 after 0 usecs
[    2.987786] calling  alsa_sound_last_init+0x0/0x80 @ 1
[    2.988889] ALSA device list:
[    2.989545]   No soundcards found.
[    2.990230] initcall alsa_sound_last_init+0x0/0x80 returned 0 after 1340 usecs
[    2.991670] Warning: unable to open an initial console.
[    2.993930] Freeing unused kernel image (initmem) memory: 2992K
[    2.995177] Write protecting the kernel read-only data: 28672k
[    2.997199] Freeing unused kernel image (text/rodata gap) memory: 1296K
[    2.998767] Freeing unused kernel image (rodata/data gap) memory: 112K
[    3.071088] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.072388] x86/mm: Checking user space page tables
[    3.144339] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.145110] Run /init as init process
[    3.145626]   with arguments:
[    3.146025]     /init
[    3.146321]   with environment:
[    3.146741]     HOME=/
[    3.147025]     TERM=linux
[    3.209531] rcu: NOCB: Cannot CB-deoffload online CPU 1
[    3.210206] rcu: NOCB: Cannot CB-offload online CPU 8
[    3.212101] rcu: NOCB: Cannot CB-offload online CPU 16
[    3.212723] rcu: NOCB: Cannot CB-deoffload online CPU 4
[    3.625467] rcu-torture: Waited 2032 jiffies for boot to complete.
[    6.638791] rcu: NOCB: Cannot CB-offload online CPU 11
[    6.639591] rcu: NOCB: Cannot CB-deoffload online CPU 4
[    6.642030] rcu: NOCB: Cannot CB-deoffload online CPU 7
[    6.642327] rcu-torture: rcu_torture_read_exit: End of episode
[    7.681680] rcu: NOCB: Cannot CB-offload online CPU 13
[    7.732202] rcu: NOCB: Cannot CB-offload online CPU 12
[    8.281460] clocksource: Watchdog remote CPU 14 read timed out
[    8.700529] rcu: NOCB: Cannot CB-offload online CPU 12
[    8.745420] rcu: NOCB: Cannot CB-deoffload online CPU 1
[    8.772828] rcu: NOCB: Cannot CB-offload online CPU 11
[    8.801577] rcu: NOCB: Cannot CB-offload online CPU 11
[    9.801359] rcu: NOCB: Cannot CB-offload online CPU 9
[    9.830664] rcu: NOCB: Cannot CB-offload online CPU 13
[   10.838567] rcu: NOCB: Cannot CB-deoffload online CPU 7
[   10.914166] rcu: NOCB: Cannot CB-offload online CPU 16
[   10.922541] rcu: NOCB: Cannot CB-offload online CPU 10
[   10.958656] rcu: NOCB: Cannot CB-offload online CPU 11
[   11.953762] rcu: NOCB: Cannot CB-offload online CPU 13
[   12.965379] rcu: NOCB: Cannot CB-offload online CPU 9
[   13.120238] rcu: NOCB: Cannot CB-offload online CPU 14
[   14.004252] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   14.092849] rcu: NOCB: Cannot CB-offload online CPU 14
[   14.102051] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   14.127673] rcu: NOCB: Cannot CB-deoffload online CPU 1
[   14.153695] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   15.118852] rcu: NOCB: Cannot CB-deoffload online CPU 3
[   15.172786] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   15.267132] rcu: NOCB: Cannot CB-offload online CPU 15
[   16.135609] rcu: NOCB: Cannot CB-offload online CPU 8
[   16.168673] rcu: NOCB: Cannot CB-offload online CPU 16
[   16.269773] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   16.274385] rcu: NOCB: Cannot CB-offload online CPU 14
[   17.094634] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   17.130382] rcu-torture: rtc: 000000000c01283a ver: 467 tfle: 0 rta: 468 rtaf: 0 rtf: 457 rtmbe: 0 rtmbkf: 0/462 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 26964 ni: 478 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 81/81:0 read-exits: 16 nocb-toggles: 44:45 gpwraps: 0
[   17.138356] rcu-torture: Reader Pipe:  27743366 2073 0 0 0 0 0 0 0 0 0
[   17.139344] rcu-torture: Reader Batch:  27741325 4114 0 0 0 0 0 0 0 0 0
[   17.141935] rcu-torture: Free-Block Circulation:  467 466 465 463 462 461 460 459 458 457 0
[   17.166027] rcu: NOCB: Cannot CB-offload online CPU 14
[   17.221090] rcu: NOCB: Cannot CB-offload online CPU 12
[   17.222856] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   17.333738] rcu: NOCB: Cannot CB-offload online CPU 9
[   17.353839] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   18.240664] rcu: NOCB: Cannot CB-offload online CPU 2
[   18.315737] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   19.264127] rcu: NOCB: Cannot CB-offload online CPU 2
[   19.268651] rcu: NOCB: Cannot CB-offload online CPU 10
[   19.290549] rcu: NOCB: Cannot CB-offload online CPU 10
[   19.481984] rcu: NOCB: Cannot CB-deoffload online CPU 1
[   19.524779] rcu: NOCB: Cannot CB-offload online CPU 14
[   19.946572] rcu-torture: rcu_torture_read_exit: Start of episode
[   19.956805] rcu-torture: rcu_torture_read_exit: End of episode
[   20.565797] rcu: NOCB: Cannot CB-offload online CPU 10
[   21.360572] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   21.399633] rcu: NOCB: Cannot CB-offload online CPU 11
[   21.530291] rcu: NOCB: Cannot CB-offload online CPU 14
[   21.596557] rcu: NOCB: Cannot CB-offload online CPU 15
[   21.710945] rcu: NOCB: Cannot CB-deoffload online CPU 1
[   22.369045] rcu: NOCB: Cannot CB-deoffload online CPU 7
[   22.465821] rcu: NOCB: Cannot CB-offload online CPU 8
[   22.506930] rcu: NOCB: Cannot CB-offload online CPU 12
[   22.509478] rcu: NOCB: Cannot CB-deoffload online CPU 3
[   22.525596] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   22.545013] rcu: NOCB: Cannot CB-offload online CPU 15
[   22.712733] rcu: NOCB: Cannot CB-offload online CPU 10
[   22.767446] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   23.415204] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   23.474484] rcu: NOCB: Cannot CB-offload online CPU 10
[   23.538443] rcu: NOCB: Cannot CB-offload online CPU 13
[   23.610826] rcu: NOCB: Cannot CB-offload online CPU 11
[   23.620367] rcu: NOCB: Cannot CB-offload online CPU 9
[   23.818620] rcu: NOCB: Cannot CB-offload online CPU 10
[   24.612060] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   24.663731] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   24.706663] rcu: NOCB: Cannot CB-offload online CPU 2
[   24.735415] rcu: NOCB: Cannot CB-offload online CPU 2
[   25.655771] rcu: NOCB: Cannot CB-offload online CPU 12
[   25.811558] rcu: NOCB: Cannot CB-offload online CPU 13
[   25.892297] rcu: NOCB: Cannot CB-offload online CPU 12
[   25.921233] rcu: NOCB: Cannot CB-offload online CPU 16
[   26.588631] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   26.681981] rcu: NOCB: Cannot CB-offload online CPU 8
[   26.741460] rcu: NOCB: Cannot CB-offload online CPU 8
[   26.935626] rcu: NOCB: Cannot CB-deoffload online CPU 3
[   26.949423] rcu: NOCB: Cannot CB-offload online CPU 8
[   32.028152] rcu-torture: torture_onoff end holdoff
[   32.043517] smpboot: CPU 2 is now offline
[   32.145543] rcu-torture: rtc: 00000000b0cbedc4 ver: 1202 tfle: 0 rta: 1202 rtaf: 0 rtf: 1193 rtmbe: 0 rtmbkf: 0/1182 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 54999 ni: 969 onoff: 0/0:1/1 -1,0:15,15 0:15 (HZ=1000) barrier: 180/180:0 read-exits: 32 nocb-toggles: 88:81 gpwraps: 0
[   32.148217] rcu-torture: Reader Pipe:  56827759 5280 0 0 0 0 0 0 0 0 0
[   32.148959] rcu-torture: Reader Batch:  56822413 10626 0 0 0 0 0 0 0 0 0
[   32.149710] rcu-torture: Free-Block Circulation:  1201 1201 1200 1199 1198 1197 1196 1195 1194 1193 0
[   32.637868] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   32.638918] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   32.639805] rcu: NOCB: Cannot CB-deoffload online CPU 7
[   33.324085] rcu-torture: rcu_torture_read_exit: Start of episode
[   33.329584] rcu-torture: rcu_torture_read_exit: End of episode
[   33.353471] smpboot: CPU 5 is now offline
[   33.673181] rcu: NOCB: Cannot CB-offload online CPU 8
[   33.713224] rcu: Offloading 2
[   33.727832] rcu: NOCB: Cannot CB-offload online CPU 11
[   33.747286] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   34.363656] smpboot: Booting Node 0 Processor 5 APIC 0x5
[   34.726446] rcu: De-offloading 2
[   34.760600] rcu: NOCB: Cannot CB-offload online CPU 11
[   34.778653] rcu: NOCB: Cannot CB-offload online CPU 16
[   34.789737] rcu: NOCB: Cannot CB-offload online CPU 12
[   34.822027] rcu: NOCB: Cannot CB-offload online CPU 15
[   35.408421] smpboot: CPU 1 is now offline
[   35.793845] rcu: NOCB: Cannot CB-offload online CPU 16
[   35.827003] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   35.884534] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   35.893542] rcu: NOCB: Cannot CB-offload online CPU 13
[   36.504589] smpboot: CPU 3 is now offline
[   36.868791] rcu: NOCB: Cannot CB-offload online CPU 16
[   36.870564] rcu: NOCB: Cannot CB-offload online CPU 9
[   36.916915] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   37.603077] smpboot: Booting Node 0 Processor 2 APIC 0x2
[   37.913798] rcu: De-offloading 1
[   37.969083] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   38.641690] smpboot: CPU 7 is now offline
[   38.967910] rcu: NOCB: Cannot CB-offload online CPU 15
[   39.017686] rcu: NOCB: Cannot CB-offload online CPU 2
[   39.060506] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   39.075286] rcu: NOCB: Cannot CB-offload online CPU 8
[   39.112574] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   39.126274] rcu: NOCB: Cannot CB-offload online CPU 14
[   39.963357] rcu: Offloading 1
[   39.998116] rcu: NOCB: Cannot CB-offload online CPU 15
[   40.065586] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   40.089713] rcu: NOCB: Cannot CB-offload online CPU 8
[   40.117926] rcu: NOCB: Cannot CB-offload online CPU 13
[   40.181215] rcu: NOCB: Cannot CB-offload online CPU 2
[   40.753652] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   41.074469] rcu: NOCB: Cannot CB-offload online CPU 13
[   41.077284] rcu: NOCB: Cannot CB-offload online CPU 9
[   41.126581] rcu: NOCB: Cannot CB-offload online CPU 14
[   41.361594] rcu: NOCB: Cannot CB-deoffload online CPU 7
[   41.827658] smpboot: CPU 2 is now offline
[   42.135942] rcu: De-offloading 3
[   42.145902] rcu: NOCB: Cannot CB-offload online CPU 15
[   42.149062] rcu: NOCB: Cannot CB-offload online CPU 10
[   42.170175] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   42.364246] rcu: NOCB: Cannot CB-deoffload online CPU 7
[   42.400269] rcu: Offloading 3
[   42.979680] smpboot: Booting Node 0 Processor 3 APIC 0x3
[   43.134457] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   43.275555] rcu: NOCB: Cannot CB-offload online CPU 13
[   43.392907] rcu: NOCB: Cannot CB-offload online CPU 13
[   43.468678] rcu: NOCB: Cannot CB-offload online CPU 9
[   44.187202] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   44.204434] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   44.248908] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   44.256354] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   44.297548] rcu: NOCB: Cannot CB-offload online CPU 13
[   44.475087] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   44.590376] rcu: NOCB: Cannot CB-offload online CPU 11
[   45.219627] smpboot: CPU 4 is now offline
[   45.252756] rcu: NOCB: Cannot CB-offload online CPU 14
[   45.274773] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   45.590581] rcu: Offloading 2
[   46.276548] rcu: NOCB: Cannot CB-offload online CPU 14
[   46.310626] rcu: NOCB: Cannot CB-offload online CPU 8
[   46.363567] rcu: NOCB: Cannot CB-offload online CPU 8
[   46.372322] rcu: NOCB: Cannot CB-offload online CPU 14
[   46.383209] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   46.392946] rcu: NOCB: Cannot CB-deoffload online CPU 3
[   46.596591] smpboot: Booting Node 0 Processor 4 APIC 0x4
[   46.697459] rcu-torture: rcu_torture_read_exit: Start of episode
[   46.706658] rcu-torture: rcu_torture_read_exit: End of episode
[   46.729598] rcu: NOCB: Cannot CB-offload online CPU 14
[   46.800936] rcu: NOCB: Cannot CB-offload online CPU 10
[   47.337512] rcu-torture: rtc: 0000000087ad15bf ver: 2100 tfle: 0 rta: 2101 rtaf: 0 rtf: 2091 rtmbe: 0 rtmbkf: 0/2069 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 93602 ni: 1652 onoff: 6/6:7/7 16,397:15,311 1013:568 (HZ=1000) barrier: 258/258:0 read-exits: 64 nocb-toggles: 152:130 gpwraps: 0
[   47.342606] rcu-torture: Reader Pipe:  97391300 9220 0 0 0 0 0 0 0 0 0
[   47.343697] rcu-torture: Reader Batch:  97381683 18837 0 0 0 0 0 0 0 0 0
[   47.344687] rcu-torture: Free-Block Circulation:  2102 2101 2100 2099 2098 2097 2096 2095 2094 2093 0
[   47.364918] rcu: NOCB: Cannot CB-deoffload online CPU 1
[   47.404648] rcu: NOCB: Cannot CB-offload online CPU 14
[   47.420680] rcu: NOCB: Cannot CB-offload online CPU 14
[   47.902286] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   48.023507] smpboot: Booting Node 0 Processor 2 APIC 0x2
[   48.478849] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   48.550559] rcu: NOCB: Cannot CB-offload online CPU 13
[   48.926315] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   49.374032] smpboot: CPU 4 is now offline
[   49.437683] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   49.482592] rcu: NOCB: Cannot CB-deoffload online CPU 7
[   49.586292] rcu: NOCB: Cannot CB-offload online CPU 8
[   49.633955] rcu: NOCB: Cannot CB-offload online CPU 12
[   49.920131] rcu: NOCB: Cannot CB-offload online CPU 11
[   50.384550] smpboot: Booting Node 0 Processor 4 APIC 0x4
[   50.492012] rcu: NOCB: Cannot CB-offload online CPU 9
[   50.512645] rcu: NOCB: Cannot CB-offload online CPU 14
[   50.530530] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   50.702103] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   51.001997] rcu: NOCB: Cannot CB-offload online CPU 12
[   51.424483] smpboot: CPU 1 is now offline
[   51.578766] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   51.611474] rcu: NOCB: Cannot CB-offload online CPU 16
[   51.793019] rcu: NOCB: Cannot CB-offload online CPU 11
[   51.797470] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   52.071049] rcu: NOCB: Cannot CB-offload online CPU 16
[   52.602883] rcu: NOCB: Cannot CB-offload online CPU 13
[   52.672680] smpboot: CPU 3 is now offline
[   52.673584] rcu: NOCB: Cannot CB-offload online CPU 11
[   52.863163] rcu: NOCB: Cannot CB-offload online CPU 14
[   53.106466] rcu: De-offloading 1
[   53.151454] rcu: NOCB: Cannot CB-offload online CPU 9
[   53.684425] smpboot: CPU 2 is now offline
[   54.695315] smpboot: CPU 6 is now offline
[   55.707396] smpboot: CPU 7 is now offline
[   56.712643] smpboot: Booting Node 0 Processor 6 APIC 0x6
[   57.720611] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   58.636963] rcu: NOCB: Cannot CB-offload online CPU 12
[   58.637721] rcu: NOCB: Cannot CB-offload online CPU 15
[   58.638649] rcu: De-offloading 7
[   58.652504] rcu: NOCB: Cannot CB-offload online CPU 11
[   58.653380] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   59.000545] smpboot: Booting Node 0 Processor 2 APIC 0x2
[   59.665968] rcu: NOCB: Cannot CB-offload online CPU 8
[   59.666788] rcu: NOCB: Cannot CB-offload online CPU 12
[   59.716465] rcu: NOCB: Cannot CB-offload online CPU 13
[   59.758490] rcu: NOCB: Cannot CB-offload online CPU 1
[   60.009489] rcu-torture: rcu_torture_read_exit: Start of episode
[   60.026450] rcu-torture: rcu_torture_read_exit: End of episode
[   60.686718] rcu: NOCB: Cannot CB-offload online CPU 14
[   60.694997] rcu: NOCB: Cannot CB-offload online CPU 13
[   60.696252] rcu: NOCB: Cannot CB-offload online CPU 1
[   60.756739] rcu: NOCB: Cannot CB-offload online CPU 15
[   60.787946] rcu: NOCB: Cannot CB-offload online CPU 14
[   60.823457] rcu: De-offloading 3
[   61.022120] smpboot: Booting Node 0 Processor 3 APIC 0x3
[   61.739758] rcu: NOCB: Cannot CB-offload online CPU 3
[   61.800452] rcu: NOCB: Cannot CB-offload online CPU 3
[   61.801227] rcu: NOCB: Cannot CB-offload online CPU 1
[   61.883547] rcu: NOCB: Cannot CB-offload online CPU 9
[   61.927210] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   62.064563] smpboot: CPU 3 is now offline
[   62.697478] rcu-torture: rtc: 00000000568441e0 ver: 2680 tfle: 0 rta: 2681 rtaf: 0 rtf: 2671 rtmbe: 0 rtmbkf: 0/2627 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 120488 ni: 2131 onoff: 12/12:14/14 7,414:10,342 1769:1245 (HZ=1000) barrier: 350/351:0 read-exits: 80 nocb-toggles: 191:171 gpwraps: 0
[   62.701710] rcu-torture: Reader Pipe:  126144780 11747 0 0 0 0 0 0 0 0 0
[   62.702605] rcu-torture: Reader Batch:  126132509 24018 0 0 0 0 0 0 0 0 0
[   62.703511] rcu-torture: Free-Block Circulation:  2680 2679 2678 2677 2676 2675 2674 2673 2672 2671 0
[   62.960762] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   63.714795] smpboot: CPU 1 is now offline
[   63.885480] rcu: NOCB: Cannot CB-offload online CPU 10
[   63.886631] rcu: NOCB: Cannot CB-deoffload online CPU 2
[   63.944455] rcu: NOCB: Cannot CB-offload online CPU 14
[   64.018901] rcu: NOCB: Cannot CB-offload online CPU 8
[   64.050687] rcu: NOCB: Cannot CB-offload online CPU 10
[   64.061373] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   64.907638] smpboot: Booting Node 0 Processor 3 APIC 0x3
[   65.062758] rcu: NOCB: Cannot CB-offload online CPU 11
[   65.063752] rcu: NOCB: Cannot CB-offload online CPU 10
[   65.130016] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   65.149774] rcu: Offloading 7
[   65.999004] rcu: NOCB: Cannot CB-deoffload online CPU 6
[   66.055356] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   66.076569] rcu: Offloading 1
[   66.157450] rcu: NOCB: Cannot CB-offload online CPU 12
[   66.179011] rcu: NOCB: Cannot CB-offload online CPU 3
[   66.184112] rcu: NOCB: Cannot CB-offload online CPU 12
[   66.272325] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   66.439621] smpboot: CPU 3 is now offline
[   67.065979] rcu: NOCB: Cannot CB-offload online CPU 12
[   67.138558] rcu: Offloading 3
[   67.139380] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   67.221589] rcu: NOCB: Cannot CB-offload online CPU 15
[   67.241464] rcu: NOCB: Cannot CB-offload online CPU 10
[   67.259775] rcu: NOCB: Cannot CB-offload online CPU 13
[   67.350053] rcu: NOCB: Cannot CB-offload online CPU 10
[   68.150362] rcu: NOCB: Cannot CB-offload online CPU 12
[   68.298680] rcu: De-offloading 1
[   68.573694] rcu: De-offloading 7
[   68.594549] rcu: NOCB: Cannot CB-offload online CPU 13
[   68.908245] smpboot: CPU 2 is now offline
[   69.227512] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   69.646771] rcu: NOCB: Cannot CB-offload online CPU 15
[   69.658470] rcu: NOCB: Cannot CB-offload online CPU 12
[   70.024744] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   70.329166] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   70.465832] rcu: De-offloading 3
[   70.752644] rcu: De-offloading 2
[   70.758339] rcu: NOCB: Cannot CB-offload online CPU 9
[   70.759483] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   71.099330] smpboot: CPU 5 is now offline
[   71.839526] rcu: NOCB: Cannot CB-offload online CPU 9
[   71.874120] rcu: NOCB: Cannot CB-offload online CPU 1
[   72.129496] smpboot: CPU 6 is now offline
[   72.367362] rcu: NOCB: Cannot CB-offload online CPU 10
[   72.385039] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   72.412962] rcu: Offloading 3
[   72.817537] rcu: De-offloading 6
[   73.549774] rcu: NOCB: Cannot CB-offload online CPU 10
[   73.550704] rcu: NOCB: Cannot CB-offload online CPU 13
[   73.551532] rcu: NOCB: Cannot CB-offload online CPU 9
[   73.552188] rcu: NOCB: Cannot CB-offload online CPU 16
[   73.553196] smpboot: Booting Node 0 Processor 5 APIC 0x5
[   73.770460] rcu-torture: rcu_torture_read_exit: Start of episode
[   73.782641] rcu-torture: rcu_torture_read_exit: End of episode
[   74.567817] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   74.586179] rcu: Offloading 7
[   74.646560] rcu: NOCB: Cannot CB-offload online CPU 8
[   74.651373] rcu: De-offloading 3
[   75.188967] rcu: NOCB: Cannot CB-offload online CPU 1
[   75.585891] smpboot: CPU 1 is now offline
[   75.586743] rcu: NOCB: Cannot CB-offload online CPU 8
[   76.710902] rcu: Offloading 6
[   76.888214] rcu: NOCB: Cannot CB-offload online CPU 9
[   76.889151] rcu: NOCB: Cannot CB-offload online CPU 8
[   76.890475] rcu: Offloading 3
[   76.908736] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   77.252805] rcu: NOCB: Cannot CB-offload online CPU 9
[   77.298755] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   77.345402] rcu: NOCB: Cannot CB-offload online CPU 14
[   77.778350] rcu: NOCB: Cannot CB-offload online CPU 9
[   77.904020] rcu: NOCB: Cannot CB-offload online CPU 8
[   78.057467] rcu-torture: rtc: 000000001191ddd5 ver: 3286 tfle: 0 rta: 3287 rtaf: 0 rtf: 3277 rtmbe: 0 rtmbkf: 0/3152 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 158796 ni: 2814 onoff: 16/17:20/20 7,429:10,650 2875:2992 (HZ=1000) barrier: 407/408:0 read-exits: 96 nocb-toggles: 241:233 gpwraps: 0
[   78.064310] rcu-torture: Reader Pipe:  166219015 14439 0 0 0 0 0 0 0 0 0
[   78.066339] rcu-torture: Reader Batch:  166203578 29876 0 0 0 0 0 0 0 0 0
[   78.068370] rcu-torture: Free-Block Circulation:  3286 3285 3284 3283 3282 3281 3280 3279 3278 3277 0
[   78.360667] smpboot: Booting Node 0 Processor 2 APIC 0x2
[   78.372394] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   78.373362] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   78.790832] rcu: NOCB: Cannot CB-offload online CPU 14
[   79.003427] rcu: NOCB: Cannot CB-offload online CPU 12
[   79.020390] rcu: NOCB: Cannot CB-offload online CPU 8
[   79.397546] smpboot: CPU 2 is now offline
[   79.398293] rcu: NOCB: Cannot CB-offload online CPU 10
[   79.409468] rcu: Offloading 2
[   80.409143] smpboot: CPU 7 is now offline
[   81.413540] smpboot: Booting Node 0 Processor 2 APIC 0x2
[   82.421629] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   83.429571] smpboot: Booting Node 0 Processor 6 APIC 0x6
[   84.636015] rcu: NOCB: Cannot CB-offload online CPU 16
[   84.638689] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   84.639835] rcu: De-offloading 7
[   85.597911] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   85.656763] rcu: NOCB: Cannot CB-offload online CPU 14
[   85.680456] rcu: NOCB: Cannot CB-deoffload online CPU 2
[   85.719561] rcu: NOCB: Cannot CB-offload online CPU 15
[   86.691929] smpboot: Booting Node 0 Processor 3 APIC 0x3
[   86.709330] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   86.761936] rcu: NOCB: Cannot CB-deoffload online CPU 4
[   86.773206] rcu: NOCB: Cannot CB-offload online CPU 7
[   86.775943] rcu: NOCB: Cannot CB-deoffload online CPU 3
[   86.778815] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   87.145787] rcu-torture: rcu_torture_read_exit: Start of episode
[   87.165822] rcu-torture: rcu_torture_read_exit: End of episode
[   87.741457] smpboot: CPU 4 is now offline
[   87.742270] rcu: NOCB: Cannot CB-offload online CPU 15
[   87.853353] rcu: NOCB: Cannot CB-offload online CPU 9
[   87.873158] rcu: NOCB: Cannot CB-deoffload online CPU 3
[   87.911332] rcu: NOCB: Cannot CB-offload online CPU 8
[   88.773996] smpboot: CPU 3 is now offline
[   88.807524] rcu: De-offloading 4
[   88.858251] rcu: NOCB: Cannot CB-offload online CPU 7
[   88.861957] rcu: NOCB: Cannot CB-offload online CPU 9
[   88.913404] rcu: NOCB: Cannot CB-offload online CPU 10
[   88.915485] rcu: Offloading 4
[   88.931851] rcu: NOCB: Cannot CB-offload online CPU 9
[   88.971189] rcu: NOCB: Cannot CB-offload online CPU 14
[   89.852969] smpboot: CPU 6 is now offline
[   89.870334] rcu: NOCB: Cannot CB-offload online CPU 7
[   89.873487] rcu: NOCB: Cannot CB-offload online CPU 12
[   89.921327] rcu: NOCB: Cannot CB-offload online CPU 8
[   89.952712] rcu: NOCB: Cannot CB-offload online CPU 8
[   89.990904] rcu: NOCB: Cannot CB-offload online CPU 12
[   90.935540] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   91.057101] rcu: NOCB: Cannot CB-offload online CPU 7
[   91.111416] smpboot: CPU 7 is now offline
[   92.026090] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   92.109193] rcu: De-offloading 4
[   92.139210] smpboot: CPU 5 is now offline
[   92.141302] rcu: NOCB: Cannot CB-offload online CPU 8
[   93.044750] rcu: NOCB: Cannot CB-offload online CPU 10
[   93.173464] rcu: De-offloading 6
[   93.199656] rcu: NOCB: Cannot CB-offload online CPU 12
[   93.419469] rcu-torture: rtc: 000000005f2c66d6 ver: 3810 tfle: 0 rta: 3811 rtaf: 0 rtf: 3800 rtmbe: 0 rtmbkf: 0/3603 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 185847 ni: 3291 onoff: 22/22:27/27 7,443:10,650 3616:3453 (HZ=1000) barrier: 497/498:0 read-exits: 112 nocb-toggles: 283:274 gpwraps: 0
[   93.423197] rcu-torture: Reader Pipe:  194527339 16697 0 0 0 0 0 0 0 0 0
[   93.424213] rcu-torture: Reader Batch:  194509357 34679 0 0 0 0 0 0 0 0 0
[   93.425158] rcu-torture: Free-Block Circulation:  3810 3809 3808 3807 3806 3805 3803 3802 3801 3800 0
[   94.076547] rcu: NOCB: Cannot CB-offload online CPU 8
[   94.282353] rcu: NOCB: Cannot CB-offload online CPU 10
[   94.357764] rcu: Offloading 7
[   95.128317] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   95.149036] smpboot: Booting Node 0 Processor 5 APIC 0x5
[   95.232784] rcu: NOCB: Cannot CB-offload online CPU 12
[   96.202379] rcu: NOCB: Cannot CB-offload online CPU 15
[   96.237313] rcu: NOCB: Cannot CB-offload online CPU 11
[   96.244289] rcu: De-offloading 3
[   96.361997] rcu: Offloading 3
[   96.456367] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   96.517000] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   97.173101] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   97.478926] rcu: NOCB: Cannot CB-deoffload online CPU 0
[   98.491366] smpboot: Booting Node 0 Processor 4 APIC 0x4
[   98.513080] rcu: NOCB: Cannot CB-offload online CPU 14
[   98.513947] rcu: NOCB: Cannot CB-deoffload online CPU 5
[   98.570630] rcu: NOCB: Cannot CB-offload online CPU 1
[   98.572635] rcu: Offloading 6
[   98.581423] rcu: NOCB: Cannot CB-offload online CPU 11
[   98.612368] rcu: NOCB: Cannot CB-offload online CPU 12
[   98.738079] rcu: De-offloading 6
[   99.529496] smpboot: Booting Node 0 Processor 6 APIC 0x6
[   99.686418] rcu: NOCB: Cannot CB-offload online CPU 16
[  100.588042] rcu-torture: rcu_torture_read_exit: Start of episode
[  100.588391] smpboot: CPU 5 is now offline
[  100.608858] rcu-torture: rcu_torture_read_exit: End of episode
[  100.618195] rcu: NOCB: Cannot CB-offload online CPU 13
[  100.690546] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  100.735930] rcu: NOCB: Cannot CB-offload online CPU 12
[  100.972383] rcu: De-offloading 3
[  101.735001] rcu: NOCB: Cannot CB-offload online CPU 15
[  101.778522] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  102.165361] smpboot: CPU 1 is now offline
[  102.273839] rcu: De-offloading 5
[  102.731590] rcu: Offloading 5
[  102.823043] rcu: NOCB: Cannot CB-offload online CPU 16
[  102.849368] rcu: NOCB: Cannot CB-offload online CPU 14
[  103.257753] smpboot: CPU 2 is now offline
[  103.789023] rcu: NOCB: Cannot CB-offload online CPU 9
[  103.827549] rcu: NOCB: Cannot CB-offload online CPU 4
[  104.451461] rcu: NOCB: Cannot CB-offload online CPU 12
[  104.711496] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  104.892234] rcu: Offloading 3
[  104.971962] rcu: NOCB: Cannot CB-offload online CPU 1
[  104.979742] rcu: NOCB: Cannot CB-offload online CPU 13
[  104.990234] rcu: De-offloading 2
[  105.578638] rcu: NOCB: Cannot CB-offload online CPU 13
[  105.729541] smpboot: CPU 4 is now offline
[  106.737529] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  107.745546] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  108.759418] smpboot: CPU 6 is now offline
[  108.777496] rcu-torture: rtc: 0000000050f38c45 ver: 4462 tfle: 0 rta: 4462 rtaf: 0 rtf: 4453 rtmbe: 0 rtmbkf: 0/4164 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 215694 ni: 3824 onoff: 29/29:32/32 7,460:10,650 4504:4172 (HZ=1000) barrier: 580/580:0 read-exits: 128 nocb-toggles: 324:321 gpwraps: 0
[  108.780206] rcu-torture: Reader Pipe:  225556409 19592 0 0 0 0 0 0 0 0 0
[  108.780932] rcu-torture: Reader Batch:  225535771 40230 0 0 0 0 0 0 0 0 0
[  108.781666] rcu-torture: Free-Block Circulation:  4461 4461 4460 4459 4458 4457 4456 4455 4454 4453 0
[  109.764556] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  110.635102] rcu: NOCB: Cannot CB-offload online CPU 6
[  110.637034] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  110.639424] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  110.797528] smpboot: CPU 3 is now offline
[  111.678351] rcu: NOCB: Cannot CB-offload online CPU 6
[  111.681079] rcu: NOCB: Cannot CB-offload online CPU 14
[  111.724331] rcu: NOCB: Cannot CB-offload online CPU 8
[  111.754776] rcu: NOCB: Cannot CB-offload online CPU 15
[  112.114780] smpboot: CPU 6 is now offline
[  112.718900] rcu: De-offloading 3
[  112.729026] rcu: NOCB: Cannot CB-offload online CPU 8
[  112.763022] rcu: Offloading 6
[  112.790612] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  112.844791] rcu: NOCB: Cannot CB-offload online CPU 10
[  113.126319] smpboot: CPU 5 is now offline
[  113.743714] rcu: Offloading 2
[  113.771395] rcu: NOCB: Cannot CB-offload online CPU 16
[  113.804636] rcu: NOCB: Cannot CB-offload online CPU 10
[  113.848097] rcu: Offloading 4
[  113.862462] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  113.962450] rcu-torture: rcu_torture_read_exit: Start of episode
[  113.973462] rcu-torture: rcu_torture_read_exit: End of episode
[  114.138510] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  114.817054] rcu: De-offloading 6
[  114.830784] rcu: Offloading 3
[  114.839186] rcu: Offloading 6
[  114.853484] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  115.157882] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  115.892853] rcu: NOCB: Cannot CB-offload online CPU 15
[  115.907501] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  115.949320] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  115.950147] rcu: NOCB: Cannot CB-offload online CPU 11
[  116.002324] rcu: De-offloading 6
[  116.179582] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  116.922021] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  116.940312] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  116.966467] rcu: NOCB: Cannot CB-offload online CPU 11
[  116.970596] rcu: De-offloading 5
[  117.517326] smpboot: CPU 7 is now offline
[  117.990201] rcu: NOCB: Cannot CB-offload online CPU 8
[  118.047062] rcu: NOCB: Cannot CB-offload online CPU 10
[  118.064957] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  118.098338] rcu: NOCB: Cannot CB-offload online CPU 8
[  118.109703] rcu: De-offloading 7
[  119.032780] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  119.069566] rcu: NOCB: Cannot CB-offload online CPU 13
[  119.171305] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  119.202448] rcu: NOCB: Cannot CB-offload online CPU 15
[  119.726375] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  120.039304] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  120.136869] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  120.287937] rcu: NOCB: Cannot CB-offload online CPU 11
[  120.444008] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  120.763490] smpboot: CPU 2 is now offline
[  121.112004] rcu: NOCB: Cannot CB-offload online CPU 16
[  121.239923] rcu: NOCB: Cannot CB-offload online CPU 12
[  121.879588] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  122.226655] rcu: NOCB: Cannot CB-offload online CPU 14
[  122.321199] rcu: NOCB: Cannot CB-offload online CPU 13
[  122.361319] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  122.363687] rcu: NOCB: Cannot CB-offload online CPU 16
[  122.388844] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  122.389701] rcu: Offloading 5
[  123.250630] rcu: NOCB: Cannot CB-offload online CPU 13
[  123.395054] rcu: Offloading 7
[  123.469791] rcu: NOCB: Cannot CB-offload online CPU 6
[  123.476874] rcu: NOCB: Cannot CB-offload online CPU 13
[  124.138460] rcu-torture: rtc: 0000000045d2210f ver: 5221 tfle: 0 rta: 5222 rtaf: 0 rtf: 5211 rtmbe: 0 rtmbkf: 0/4822 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 249953 ni: 4439 onoff: 35/35:37/38 7,460:10,650 4918:4879 (HZ=1000) barrier: 657/658:0 read-exits: 144 nocb-toggles: 366:383 gpwraps: 0
[  124.145927] rcu-torture: Reader Pipe:  262435707 22956 0 0 0 0 0 0 0 0 0
[  124.147044] rcu-torture: Reader Batch:  262411852 46811 0 0 0 0 0 0 0 0 0
[  124.151313] rcu-torture: Free-Block Circulation:  5221 5219 5218 5217 5216 5215 5214 5213 5212 5211 0
[  124.420608] smpboot: CPU 3 is now offline
[  124.421284] rcu: NOCB: Cannot CB-offload online CPU 16
[  124.438415] rcu: NOCB: Cannot CB-offload online CPU 12
[  124.459197] rcu: De-offloading 3
[  125.431643] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  125.472346] rcu: NOCB: Cannot CB-offload online CPU 8
[  125.651290] rcu: NOCB: Cannot CB-offload online CPU 6
[  125.701493] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  126.477246] rcu: NOCB: Cannot CB-offload online CPU 12
[  126.546507] rcu: De-offloading 5
[  126.840565] rcu: NOCB: Cannot CB-offload online CPU 12
[  126.844397] rcu: NOCB: Cannot CB-offload online CPU 11
[  127.402468] rcu-torture: rcu_torture_read_exit: Start of episode
[  127.410475] rcu-torture: rcu_torture_read_exit: End of episode
[  127.486521] smpboot: CPU 3 is now offline
[  127.606964] rcu: NOCB: Cannot CB-offload online CPU 15
[  127.897829] rcu: NOCB: Cannot CB-offload online CPU 9
[  127.952934] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  128.531470] smpboot: CPU 2 is now offline
[  128.678358] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  128.908546] rcu: NOCB: Cannot CB-offload online CPU 8
[  129.029129] rcu: NOCB: Cannot CB-offload online CPU 1
[  129.574550] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  129.665753] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  129.920106] rcu: NOCB: Cannot CB-offload online CPU 15
[  129.975286] rcu: NOCB: Cannot CB-offload online CPU 15
[  130.028727] rcu: Offloading 3
[  130.269332] rcu: NOCB: Cannot CB-offload online CPU 11
[  130.700526] smpboot: CPU 1 is now offline
[  130.711319] rcu: NOCB: Cannot CB-offload online CPU 9
[  130.839493] rcu: De-offloading 2
[  131.611756] rcu: De-offloading 3
[  131.626539] rcu: NOCB: Cannot CB-offload online CPU 12
[  132.739401] smpboot: CPU 4 is now offline
[  133.744544] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  134.752593] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  135.766454] smpboot: CPU 7 is now offline
[  136.634168] rcu: NOCB: Cannot CB-offload online CPU 9
[  136.635034] rcu: Offloading 2
[  136.637299] rcu: NOCB: Cannot CB-offload online CPU 5
[  136.638277] rcu: De-offloading 4
[  136.785412] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  137.650377] rcu: NOCB: Cannot CB-offload online CPU 6
[  137.763508] rcu: NOCB: Cannot CB-offload online CPU 16
[  138.068716] smpboot: CPU 5 is now offline
[  138.729873] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  138.733233] rcu: NOCB: Cannot CB-offload online CPU 6
[  138.811895] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  138.847517] rcu: NOCB: Cannot CB-offload online CPU 3
[  139.498516] rcu-torture: rtc: 000000008ac4851a ver: 5818 tfle: 0 rta: 5819 rtaf: 0 rtf: 5809 rtmbe: 0 rtmbkf: 0/5327 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 276759 ni: 4918 onoff: 40/40:44/44 7,460:10,650 5030:5932 (HZ=1000) barrier: 749/749:0 read-exits: 160 nocb-toggles: 399:430 gpwraps: 0
[  139.506630] rcu-torture: Reader Pipe:  290846766 25564 0 0 0 0 0 0 0 0 0
[  139.507703] rcu-torture: Reader Batch:  290820096 52234 0 0 0 0 0 0 0 0 0
[  139.510969] rcu-torture: Free-Block Circulation:  5818 5817 5816 5815 5814 5813 5812 5811 5810 5809 0
[  139.734779] rcu: Offloading 5
[  139.875398] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  139.906520] rcu: NOCB: Cannot CB-offload online CPU 11
[  140.713453] rcu-torture: rcu_torture_read_exit: Start of episode
[  140.721895] rcu-torture: rcu_torture_read_exit: End of episode
[  140.760289] rcu: De-offloading 2
[  141.133320] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  141.134054] rcu: De-offloading 5
[  141.146623] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  142.161381] rcu: NOCB: Cannot CB-offload online CPU 11
[  142.199588] rcu: NOCB: Cannot CB-offload online CPU 3
[  143.156764] rcu: NOCB: Cannot CB-offload online CPU 14
[  143.172237] rcu: NOCB: Cannot CB-offload online CPU 13
[  143.222190] rcu: Offloading 4
[  143.270087] rcu: NOCB: Cannot CB-offload online CPU 6
[  143.325570] rcu: NOCB: Cannot CB-offload online CPU 16
[  143.469994] smpboot: CPU 7 is now offline
[  144.224761] rcu: De-offloading 4
[  144.589396] rcu: NOCB: Cannot CB-offload online CPU 13
[  144.590174] rcu: Offloading 2
[  144.590697] rcu: NOCB: Cannot CB-offload online CPU 16
[  144.591601] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  145.647735] smpboot: CPU 5 is now offline
[  145.677587] rcu: NOCB: Cannot CB-offload online CPU 10
[  146.602581] rcu: De-offloading 2
[  146.699753] rcu: De-offloading 7
[  147.022215] smpboot: CPU 4 is now offline
[  147.658650] rcu: NOCB: Cannot CB-offload online CPU 10
[  147.716892] rcu: NOCB: Cannot CB-offload online CPU 13
[  148.768259] rcu: Offloading 4
[  149.190516] rcu: NOCB: Cannot CB-offload online CPU 14
[  149.223744] rcu: NOCB: Cannot CB-offload online CPU 10
[  149.226969] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  149.690044] rcu: NOCB: Cannot CB-offload online CPU 13
[  149.758107] rcu: NOCB: Cannot CB-offload online CPU 3
[  150.763885] rcu: NOCB: Cannot CB-offload online CPU 11
[  150.826219] rcu: NOCB: Cannot CB-offload online CPU 8
[  150.987866] rcu: NOCB: Cannot CB-offload online CPU 3
[  151.277464] smpboot: CPU 3 is now offline
[  151.301907] rcu: NOCB: Cannot CB-offload online CPU 12
[  151.338040] rcu: NOCB: Cannot CB-offload online CPU 1
[  152.339065] rcu: NOCB: Cannot CB-offload online CPU 13
[  152.498823] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  152.777458] rcu: NOCB: Cannot CB-offload online CPU 13
[  153.026833] rcu: NOCB: Cannot CB-offload online CPU 6
[  153.156258] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  153.405883] rcu: Offloading 7
[  153.467615] rcu: NOCB: Cannot CB-offload online CPU 9
[  153.824636] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  153.836104] rcu: NOCB: Cannot CB-offload online CPU 2
[  153.840312] rcu: NOCB: Cannot CB-offload online CPU 12
[  154.127194] rcu: NOCB: Cannot CB-offload online CPU 10
[  154.157870] rcu: NOCB: Cannot CB-offload online CPU 14
[  154.428315] rcu: NOCB: Cannot CB-offload online CPU 14
[  154.474454] rcu-torture: rcu_torture_read_exit: Start of episode
[  154.477096] rcu-torture: rcu_torture_read_exit: End of episode
[  154.511154] rcu: NOCB: Cannot CB-offload online CPU 12
[  154.566079] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  154.850184] rcu: NOCB: Cannot CB-offload online CPU 1
[  154.858470] rcu-torture: rtc: 000000001a3a02cb ver: 6520 tfle: 0 rta: 6521 rtaf: 0 rtf: 6506 rtmbe: 0 rtmbkf: 0/5923 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 316384 ni: 5610 onoff: 45/45:48/49 7,460:10,650 6006:6703 (HZ=1000) barrier: 811/812:0 read-exits: 192 nocb-toggles: 444:499 gpwraps: 0
[  154.862747] rcu-torture: Reader Pipe:  332519935 28652 0 0 0 0 0 0 0 0 0
[  154.863795] rcu-torture: Reader Batch:  332490096 58491 0 0 0 0 0 0 0 0 0
[  154.864819] rcu-torture: Free-Block Circulation:  6520 6517 6516 6515 6513 6512 6510 6508 6507 6506 0
[  155.255710] smpboot: CPU 4 is now offline
[  155.595066] rcu: NOCB: Cannot CB-offload online CPU 11
[  155.936535] rcu: NOCB: Cannot CB-offload online CPU 1
[  156.291045] rcu: NOCB: Cannot CB-offload online CPU 13
[  156.430589] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  156.536077] rcu: NOCB: Cannot CB-offload online CPU 13
[  156.768251] rcu: NOCB: Cannot CB-offload online CPU 8
[  156.943661] rcu: NOCB: Cannot CB-offload online CPU 16
[  156.974738] rcu: Offloading 5
[  157.309695] rcu: NOCB: Cannot CB-offload online CPU 12
[  157.465316] smpboot: CPU 2 is now offline
[  157.591741] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  158.475474] smpboot: CPU 4 is now offline
[  159.481537] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  161.489581] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  162.503590] smpboot: CPU 1 is now offline
[  162.633315] rcu: NOCB: Cannot CB-offload online CPU 13
[  162.638659] rcu: Offloading 1
[  162.640454] rcu: NOCB: Cannot CB-offload online CPU 10
[  163.522722] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  163.644605] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  163.645597] rcu: NOCB: Cannot CB-offload online CPU 13
[  163.697473] rcu: NOCB: Cannot CB-offload online CPU 13
[  163.700773] rcu: NOCB: Cannot CB-offload online CPU 6
[  163.709503] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  163.725131] rcu: NOCB: Cannot CB-offload online CPU 12
[  163.756842] rcu: NOCB: Cannot CB-offload online CPU 16
[  164.565745] smpboot: CPU 6 is now offline
[  164.717496] rcu: De-offloading 4
[  164.737750] rcu: Offloading 4
[  164.816987] rcu: Offloading 6
[  164.869588] rcu: NOCB: Cannot CB-offload online CPU 15
[  165.600598] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  165.840261] rcu: NOCB: Cannot CB-offload online CPU 8
[  165.951398] rcu: NOCB: Cannot CB-offload online CPU 11
[  166.627511] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  166.828458] rcu: NOCB: Cannot CB-offload online CPU 10
[  166.845814] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  166.863221] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  167.921469] rcu: NOCB: Cannot CB-offload online CPU 3
[  168.027467] rcu: NOCB: Cannot CB-offload online CPU 3
[  168.083629] rcu: NOCB: Cannot CB-offload online CPU 2
[  168.553527] rcu-torture: rcu_torture_read_exit: Start of episode
[  168.569375] rcu-torture: rcu_torture_read_exit: End of episode
[  168.958653] rcu: NOCB: Cannot CB-offload online CPU 16
[  168.992113] rcu: NOCB: Cannot CB-offload online CPU 10
[  168.997975] rcu: NOCB: Cannot CB-offload online CPU 3
[  169.104567] rcu: NOCB: Cannot CB-offload online CPU 11
[  169.115127] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  170.053363] rcu: De-offloading 1
[  170.218009] rcu-torture: rtc: 00000000580ff98d ver: 7128 tfle: 0 rta: 7129 rtaf: 0 rtf: 7118 rtmbe: 0 rtmbkf: 0/6460 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 343587 ni: 6092 onoff: 52/52:53/53 7,481:10,650 6785:7200 (HZ=1000) barrier: 907/907:0 read-exits: 208 nocb-toggles: 493:528 gpwraps: 0
[  170.222070] rcu-torture: Reader Pipe:  361100250 31314 0 0 0 0 0 0 0 0 0
[  170.223085] rcu-torture: Reader Batch:  361067519 64045 0 0 0 0 0 0 0 0 0
[  170.224115] rcu-torture: Free-Block Circulation:  7128 7127 7126 7125 7124 7123 7122 7121 7120 7118 0
[  170.428087] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  170.429070] rcu: NOCB: Cannot CB-offload online CPU 15
[  170.962492] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  171.101168] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  171.466370] rcu: NOCB: Cannot CB-offload online CPU 16
[  171.497797] rcu: NOCB: Cannot CB-offload online CPU 9
[  171.502321] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  172.456205] smpboot: CPU 6 is now offline
[  172.511935] rcu: NOCB: Cannot CB-offload online CPU 2
[  172.554922] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  172.557349] rcu: NOCB: Cannot CB-offload online CPU 15
[  172.586544] rcu: NOCB: Cannot CB-offload online CPU 12
[  173.594320] rcu: NOCB: Cannot CB-offload online CPU 15
[  173.618184] rcu: NOCB: Cannot CB-offload online CPU 13
[  173.650153] rcu: NOCB: Cannot CB-offload online CPU 12
[  173.673299] rcu: NOCB: Cannot CB-offload online CPU 9
[  174.118030] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  174.341041] rcu: NOCB: Cannot CB-offload online CPU 2
[  174.492168] smpboot: CPU 7 is now offline
[  174.626817] rcu: NOCB: Cannot CB-offload online CPU 14
[  174.675644] rcu: De-offloading 7
[  174.987443] rcu: NOCB: Cannot CB-offload online CPU 14
[  175.224019] rcu: NOCB: Cannot CB-offload online CPU 13
[  175.439165] rcu: NOCB: Cannot CB-offload online CPU 13
[  175.602787] smpboot: CPU 4 is now offline
[  175.640420] rcu: NOCB: Cannot CB-offload online CPU 15
[  176.094454] rcu: NOCB: Cannot CB-offload online CPU 11
[  176.775909] smpboot: CPU 5 is now offline
[  177.093320] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  177.539771] rcu: NOCB: Cannot CB-offload online CPU 14
[  178.235628] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  179.267956] rcu: NOCB: Cannot CB-offload online CPU 8
[  179.314085] rcu: NOCB: Cannot CB-offload online CPU 11
[  180.221742] rcu: NOCB: Cannot CB-offload online CPU 3
[  180.275163] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  180.349592] rcu: NOCB: Cannot CB-offload online CPU 9
[  180.366581] rcu: De-offloading 5
[  180.409761] rcu: NOCB: Cannot CB-offload online CPU 16
[  180.638341] rcu: NOCB: Cannot CB-offload online CPU 11
[  181.128357] rcu: NOCB: Cannot CB-offload online CPU 8
[  181.257447] rcu: NOCB: Cannot CB-offload online CPU 3
[  181.409967] rcu: NOCB: Cannot CB-offload online CPU 10
[  181.434997] rcu: NOCB: Cannot CB-offload online CPU 16
[  181.738695] rcu: NOCB: Cannot CB-offload online CPU 3
[  182.224820] rcu: NOCB: Cannot CB-offload online CPU 9
[  182.307613] rcu: NOCB: Cannot CB-offload online CPU 15
[  182.437305] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  182.443463] rcu-torture: rcu_torture_read_exit: Start of episode
[  182.451734] rcu-torture: rcu_torture_read_exit: End of episode
[  182.542533] smpboot: CPU 3 is now offline
[  182.595486] rcu: NOCB: Cannot CB-offload online CPU 14
[  183.261630] rcu: NOCB: Cannot CB-offload online CPU 14
[  183.350247] rcu: NOCB: Cannot CB-offload online CPU 9
[  183.566661] smpboot: CPU 4 is now offline
[  184.577392] smpboot: CPU 1 is now offline
[  185.577546] rcu-torture: rtc: 000000005c14f77a ver: 7802 tfle: 0 rta: 7802 rtaf: 0 rtf: 7793 rtmbe: 0 rtmbkf: 0/7059 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 377577 ni: 6692 onoff: 54/54:60/60 7,481:10,650 7291:8139 (HZ=1000) barrier: 979/979:0 read-exits: 224 nocb-toggles: 541:581 gpwraps: 0
[  185.580273] rcu-torture: Reader Pipe:  396738062 34264 0 0 0 0 0 0 0 0 0
[  185.581007] rcu-torture: Reader Batch:  396702309 70017 0 0 0 0 0 0 0 0 0
[  185.581746] rcu-torture: Free-Block Circulation:  7801 7801 7800 7799 7798 7797 7796 7795 7794 7793 0
[  185.582758] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  186.596218] smpboot: CPU 4 is now offline
[  187.600551] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  188.608585] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  188.632284] rcu: NOCB: Cannot CB-offload online CPU 16
[  188.633723] rcu: NOCB: Cannot CB-offload online CPU 14
[  188.634577] rcu: NOCB: Cannot CB-offload online CPU 3
[  188.635356] rcu: NOCB: Cannot CB-offload online CPU 1
[  188.637244] rcu: NOCB: Cannot CB-offload online CPU 15
[  188.638066] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  188.638948] rcu: NOCB: Cannot CB-offload online CPU 13
[  189.716106] rcu: NOCB: Cannot CB-offload online CPU 11
[  189.764211] rcu: NOCB: Cannot CB-offload online CPU 16
[  189.862877] smpboot: CPU 3 is now offline
[  190.723093] rcu: NOCB: Cannot CB-offload online CPU 11
[  190.744898] rcu: Offloading 3
[  190.804383] rcu: NOCB: Cannot CB-offload online CPU 9
[  190.870075] rcu: NOCB: Cannot CB-offload online CPU 12
[  191.039539] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  191.800679] rcu: NOCB: Cannot CB-offload online CPU 10
[  191.830737] rcu: Offloading 5
[  191.855827] rcu: De-offloading 6
[  192.415221] smpboot: CPU 1 is now offline
[  192.777113] rcu: NOCB: Cannot CB-offload online CPU 2
[  192.882594] rcu: NOCB: Cannot CB-offload online CPU 9
[  192.883921] rcu: Offloading 1
[  192.885774] rcu: NOCB: Cannot CB-offload online CPU 9
[  193.039667] rcu: NOCB: Cannot CB-offload online CPU 8
[  193.096474] rcu: De-offloading 1
[  193.104676] rcu: De-offloading 3
[  193.927687] rcu: NOCB: Cannot CB-offload online CPU 8
[  194.046477] rcu: De-offloading 4
[  194.429763] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  194.892687] rcu: De-offloading 5
[  195.222183] rcu: NOCB: Cannot CB-offload online CPU 14
[  195.223455] rcu: NOCB: Cannot CB-offload online CPU 16
[  195.224384] rcu: NOCB: Cannot CB-offload online CPU 12
[  195.355372] rcu: Offloading 5
[  195.407377] rcu: NOCB: Cannot CB-offload online CPU 8
[  195.613979] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  195.882176] rcu-torture: rcu_torture_read_exit: Start of episode
[  195.888498] rcu-torture: rcu_torture_read_exit: End of episode
[  196.240681] rcu: Offloading 3
[  196.278609] rcu: NOCB: Cannot CB-offload online CPU 15
[  196.401982] rcu: NOCB: Cannot CB-offload online CPU 11
[  196.415764] rcu: NOCB: Cannot CB-offload online CPU 10
[  196.455508] rcu: NOCB: Cannot CB-offload online CPU 4
[  197.047143] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  197.332587] rcu: NOCB: Cannot CB-offload online CPU 14
[  197.334581] rcu: NOCB: Cannot CB-offload online CPU 2
[  198.241622] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  198.380853] rcu: NOCB: Cannot CB-offload online CPU 9
[  198.566237] rcu: NOCB: Cannot CB-offload online CPU 14
[  199.388074] rcu: NOCB: Cannot CB-offload online CPU 7
[  199.464421] smpboot: CPU 7 is now offline
[  199.538485] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  199.549443] rcu: NOCB: Cannot CB-offload online CPU 9
[  199.583855] rcu: NOCB: Cannot CB-offload online CPU 12
[  200.557128] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  200.620027] rcu: NOCB: Cannot CB-offload online CPU 14
[  200.673860] rcu: NOCB: Cannot CB-offload online CPU 15
[  200.740143] smpboot: CPU 4 is now offline
[  200.937470] rcu-torture: rtc: 000000008ac4851a ver: 8222 tfle: 0 rta: 8223 rtaf: 0 rtf: 8210 rtmbe: 0 rtmbkf: 0/7432 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 407614 ni: 7233 onoff: 62/62:65/65 7,481:10,650 8150:9242 (HZ=1000) barrier: 1048/1048:0 read-exits: 240 nocb-toggles: 591:627 gpwraps: 0
[  200.943257] rcu-torture: Reader Pipe:  428260748 36207 0 0 0 0 0 0 0 0 0
[  200.944158] rcu-torture: Reader Batch:  428222790 74165 0 0 0 0 0 0 0 0 0
[  200.945067] rcu-torture: Free-Block Circulation:  8222 8221 8219 8218 8217 8216 8215 8214 8212 8210 0
[  201.620640] rcu: NOCB: Cannot CB-offload online CPU 13
[  201.653970] rcu: NOCB: Cannot CB-offload online CPU 16
[  201.681398] rcu: Offloading 7
[  201.780038] rcu: NOCB: Cannot CB-offload online CPU 12
[  201.897785] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  202.590928] rcu: NOCB: Cannot CB-offload online CPU 15
[  202.663993] rcu: NOCB: Cannot CB-offload online CPU 13
[  202.692229] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  202.704393] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  202.777661] rcu: NOCB: Cannot CB-offload online CPU 11
[  202.890498] rcu: NOCB: Cannot CB-offload online CPU 6
[  203.375410] smpboot: CPU 7 is now offline
[  203.696756] rcu: NOCB: Cannot CB-offload online CPU 12
[  203.708787] rcu: NOCB: Cannot CB-offload online CPU 9
[  203.777029] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  203.802314] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  203.974887] rcu: NOCB: Cannot CB-offload online CPU 14
[  203.987491] rcu: De-offloading 7
[  204.466473] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  204.897450] rcu: NOCB: Cannot CB-offload online CPU 10
[  204.921679] rcu: NOCB: Cannot CB-offload online CPU 8
[  204.960324] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  205.692558] smpboot: CPU 6 is now offline
[  205.878024] rcu: NOCB: Cannot CB-offload online CPU 14
[  205.879542] rcu: NOCB: Cannot CB-offload online CPU 4
[  205.949750] rcu: NOCB: Cannot CB-offload online CPU 16
[  206.057786] rcu: NOCB: Cannot CB-offload online CPU 15
[  206.090611] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  206.180977] rcu: NOCB: Cannot CB-offload online CPU 10
[  206.710495] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  206.860054] rcu: Offloading 1
[  206.931704] rcu: NOCB: Cannot CB-offload online CPU 14
[  207.173022] rcu: Offloading 7
[  207.183726] rcu: NOCB: Cannot CB-offload online CPU 4
[  208.009490] smpboot: CPU 2 is now offline
[  208.052145] rcu: NOCB: Cannot CB-offload online CPU 6
[  208.148295] rcu: NOCB: Cannot CB-offload online CPU 15
[  208.283817] rcu: NOCB: Cannot CB-offload online CPU 14
[  208.938679] rcu: NOCB: Cannot CB-offload online CPU 8
[  209.043946] smpboot: CPU 4 is now offline
[  209.105787] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  209.257716] rcu-torture: rcu_torture_read_exit: Start of episode
[  209.262710] rcu-torture: rcu_torture_read_exit: End of episode
[  209.267720] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  210.057834] smpboot: CPU 3 is now offline
[  211.068339] smpboot: CPU 6 is now offline
[  213.073613] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  214.081616] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  214.631911] rcu: NOCB: Cannot CB-offload online CPU 11
[  214.633881] rcu: NOCB: Cannot CB-offload online CPU 9
[  214.635052] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  215.314573] smpboot: CPU 1 is now offline
[  215.680998] rcu: NOCB: Cannot CB-offload online CPU 10
[  215.683964] rcu: Offloading 4
[  215.752276] rcu: De-offloading 7
[  215.768682] rcu: Offloading 7
[  216.297494] rcu-torture: rtc: 00000000527f43f2 ver: 8715 tfle: 0 rta: 8716 rtaf: 0 rtf: 8706 rtmbe: 0 rtmbkf: 0/7868 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 434581 ni: 7707 onoff: 67/67:72/72 7,481:10,650 8474:10482 (HZ=1000) barrier: 1134/1135:0 read-exits: 256 nocb-toggles: 630:668 gpwraps: 0
[  216.301809] rcu-torture: Reader Pipe:  456426470 38364 0 0 0 0 0 0 0 0 0
[  216.302874] rcu-torture: Reader Batch:  456386143 78691 0 0 0 0 0 0 0 0 0
[  216.303930] rcu-torture: Free-Block Circulation:  8715 8714 8713 8712 8711 8710 8709 8708 8707 8706 0
[  216.744487] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  216.754799] rcu: NOCB: Cannot CB-offload online CPU 6
[  216.790282] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  216.812584] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  216.821157] rcu: De-offloading 4
[  216.835639] rcu: NOCB: Cannot CB-offload online CPU 13
[  216.842538] rcu: NOCB: Cannot CB-offload online CPU 16
[  217.770994] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  217.781064] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  217.812625] rcu: De-offloading 3
[  217.871190] rcu: NOCB: Cannot CB-offload online CPU 11
[  218.815845] smpboot: CPU 2 is now offline
[  218.945571] rcu: NOCB: Cannot CB-offload online CPU 6
[  218.950207] rcu: NOCB: Cannot CB-offload online CPU 10
[  218.960143] rcu: Offloading 4
[  218.986330] rcu: NOCB: Cannot CB-offload online CPU 8
[  219.830886] rcu: NOCB: Cannot CB-offload online CPU 12
[  219.949356] rcu: NOCB: Cannot CB-offload online CPU 12
[  219.975754] rcu: Offloading 2
[  220.010512] rcu: De-offloading 4
[  220.477996] rcu: NOCB: Cannot CB-offload online CPU 13
[  220.793447] smpboot: CPU 7 is now offline
[  220.893415] rcu: De-offloading 7
[  221.277579] rcu: NOCB: Cannot CB-offload online CPU 6
[  221.279153] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  221.281446] rcu: NOCB: Cannot CB-offload online CPU 13
[  221.282250] rcu: NOCB: Cannot CB-offload online CPU 10
[  221.900945] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  222.307166] rcu: NOCB: Cannot CB-offload online CPU 12
[  222.324368] rcu: NOCB: Cannot CB-offload online CPU 16
[  222.335838] rcu: Offloading 4
[  222.360715] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  222.531929] rcu: NOCB: Cannot CB-offload online CPU 13
[  222.633452] rcu-torture: rcu_torture_read_exit: Start of episode
[  222.639744] rcu-torture: rcu_torture_read_exit: End of episode
[  223.388445] rcu: NOCB: Cannot CB-offload online CPU 6
[  223.396135] rcu: Offloading 7
[  223.396706] rcu: NOCB: Cannot CB-offload online CPU 14
[  223.500489] rcu: NOCB: Cannot CB-offload online CPU 9
[  223.624878] rcu: NOCB: Cannot CB-offload online CPU 12
[  223.784998] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  223.947328] smpboot: CPU 5 is now offline
[  224.449467] rcu: NOCB: Cannot CB-offload online CPU 12
[  224.649630] rcu: NOCB: Cannot CB-offload online CPU 12
[  224.858655] rcu: NOCB: Cannot CB-offload online CPU 14
[  224.954619] smpboot: CPU 6 is now offline
[  225.477362] rcu: De-offloading 2
[  225.523557] rcu: NOCB: Cannot CB-offload online CPU 9
[  225.524315] rcu: De-offloading 7
[  225.549241] rcu: NOCB: Cannot CB-offload online CPU 10
[  225.590107] rcu: Offloading 3
[  225.963217] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  225.974800] rcu: NOCB: Cannot CB-offload online CPU 15
[  226.562652] rcu: NOCB: Cannot CB-offload online CPU 9
[  226.702555] rcu: NOCB: Cannot CB-offload online CPU 14
[  226.788799] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  227.162309] smpboot: CPU 1 is now offline
[  227.671131] rcu: Offloading 2
[  227.683655] rcu: Offloading 7
[  227.802533] rcu: NOCB: Cannot CB-offload online CPU 10
[  228.501294] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  228.661047] rcu: NOCB: Cannot CB-offload online CPU 15
[  228.775148] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  229.127692] rcu: NOCB: Cannot CB-offload online CPU 16
[  229.733462] rcu: NOCB: Cannot CB-offload online CPU 16
[  229.752946] rcu: De-offloading 4
[  229.900634] rcu: NOCB: Cannot CB-offload online CPU 14
[  229.959356] rcu: NOCB: Cannot CB-offload online CPU 14
[  230.530628] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  230.974965] rcu: De-offloading 1
[  231.235813] rcu: NOCB: Cannot CB-offload online CPU 15
[  231.565938] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  231.660795] rcu-torture: rtc: 000000007c8baa89 ver: 9464 tfle: 0 rta: 9465 rtaf: 0 rtf: 9455 rtmbe: 0 rtmbkf: 0/8536 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 474470 ni: 8412 onoff: 74/74:77/77 7,481:8,976 9493:11721 (HZ=1000) barrier: 1205/1205:0 read-exits: 272 nocb-toggles: 686:724 gpwraps: 0
[  231.664642] rcu-torture: Reader Pipe:  499076406 41681 0 0 0 0 0 0 0 0 0
[  231.665678] rcu-torture: Reader Batch:  499032150 85937 0 0 0 0 0 0 0 0 0
[  231.666773] rcu-torture: Free-Block Circulation:  9464 9463 9462 9461 9460 9459 9458 9457 9456 9455 0
[  231.788039] rcu: NOCB: Cannot CB-offload online CPU 12
[  231.819780] rcu: NOCB: Cannot CB-offload online CPU 10
[  231.914525] rcu: NOCB: Cannot CB-offload online CPU 16
[  232.117584] rcu: De-offloading 7
[  232.732934] rcu: NOCB: Cannot CB-offload online CPU 9
[  232.734179] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  232.838216] rcu: NOCB: Cannot CB-offload online CPU 12
[  233.761037] rcu: NOCB: Cannot CB-offload online CPU 11
[  233.776528] rcu: NOCB: Cannot CB-offload online CPU 16
[  233.987873] smpboot: CPU 4 is now offline
[  234.046932] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  234.123778] rcu: NOCB: Cannot CB-offload online CPU 9
[  234.134173] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  234.901636] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  235.002943] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  235.170040] rcu: NOCB: Cannot CB-offload online CPU 14
[  235.186373] rcu: NOCB: Cannot CB-offload online CPU 13
[  235.209723] rcu: NOCB: Cannot CB-offload online CPU 13
[  235.945474] rcu-torture: rcu_torture_read_exit: Start of episode
[  236.023218] smpboot: CPU 1 is now offline
[  237.034524] smpboot: CPU 3 is now offline
[  238.045301] smpboot: CPU 2 is now offline
[  239.053531] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  240.630422] rcu: Offloading 6
[  240.632168] rcu: Offloading 1
[  240.633863] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  240.634694] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  240.635550] rcu: NOCB: Cannot CB-offload online CPU 16
[  240.637710] rcu-torture: rcu_torture_read_exit: End of episode
[  241.104223] smpboot: CPU 7 is now offline
[  241.691767] rcu: NOCB: Cannot CB-offload online CPU 13
[  241.705598] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  242.265054] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  242.671097] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  242.784049] rcu: De-offloading 1
[  242.789657] rcu: De-offloading 6
[  242.810716] rcu: NOCB: Cannot CB-offload online CPU 9
[  242.849618] rcu: NOCB: Cannot CB-offload online CPU 10
[  243.302809] smpboot: CPU 4 is now offline
[  243.754513] rcu: NOCB: Cannot CB-offload online CPU 10
[  243.763506] rcu: Offloading 7
[  243.860927] rcu: De-offloading 7
[  244.757600] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  244.797996] rcu: NOCB: Cannot CB-offload online CPU 15
[  244.857224] rcu: NOCB: Cannot CB-offload online CPU 10
[  244.992468] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  245.794814] smpboot: CPU 5 is now offline
[  245.888152] rcu: NOCB: Cannot CB-offload online CPU 15
[  245.921339] rcu: Offloading 1
[  245.930835] rcu: Offloading 6
[  245.940053] rcu: NOCB: Cannot CB-offload online CPU 14
[  246.026665] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  246.043768] rcu: NOCB: Cannot CB-offload online CPU 10
[  246.810477] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  246.935269] rcu: Offloading 4
[  247.017463] rcu-torture: rtc: 00000000bbed58f9 ver: 10130 tfle: 0 rta: 10131 rtaf: 0 rtf: 10121 rtmbe: 0 rtmbkf: 0/9117 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 501252 ni: 8891 onoff: 80/80:84/84 7,481:8,976 10350:12092 (HZ=1000) barrier: 1303/1303:0 read-exits: 288 nocb-toggles: 723:769 gpwraps: 0
[  247.025454] rcu-torture: Reader Pipe:  527567722 44558 0 0 0 0 0 0 0 0 0
[  247.026527] rcu-torture: Reader Batch:  527520374 91906 0 0 0 0 0 0 0 0 0
[  247.027553] rcu-torture: Free-Block Circulation:  10131 10130 10129 10128 10127 10126 10125 10124 10123 10122 0
[  247.133842] rcu: Offloading 7
[  247.960543] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  248.045271] rcu: NOCB: Cannot CB-offload online CPU 13
[  248.114927] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  248.129811] rcu: NOCB: Cannot CB-offload online CPU 14
[  248.149455] smpboot: CPU 3 is now offline
[  248.250894] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  249.082253] rcu: NOCB: Cannot CB-offload online CPU 12
[  249.100940] rcu: NOCB: Cannot CB-offload online CPU 9
[  249.130953] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  249.179195] smpboot: CPU 6 is now offline
[  249.179928] rcu: NOCB: Cannot CB-offload online CPU 16
[  249.216948] rcu: NOCB: Cannot CB-offload online CPU 14
[  249.358811] rcu: NOCB: Cannot CB-offload online CPU 8
[  250.140001] rcu: NOCB: Cannot CB-offload online CPU 14
[  250.219901] rcu: De-offloading 5
[  250.272594] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  250.282901] rcu: NOCB: Cannot CB-offload online CPU 11
[  250.284568] rcu: De-offloading 4
[  250.480459] rcu: Offloading 4
[  251.294552] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  251.365355] rcu: De-offloading 4
[  251.375655] rcu: NOCB: Cannot CB-offload online CPU 12
[  251.381617] rcu: De-offloading 1
[  252.203946] rcu: NOCB: Cannot CB-offload online CPU 13
[  252.315394] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  252.366603] rcu: NOCB: Cannot CB-offload online CPU 14
[  252.469717] rcu: NOCB: Cannot CB-offload online CPU 9
[  253.318619] rcu: NOCB: Cannot CB-offload online CPU 11
[  253.380512] rcu: NOCB: Cannot CB-offload online CPU 12
[  253.388617] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  253.414392] rcu: NOCB: Cannot CB-offload online CPU 11
[  253.538527] rcu: NOCB: Cannot CB-offload online CPU 5
[  253.551738] rcu: NOCB: Cannot CB-offload online CPU 8
[  253.995335] rcu-torture: rcu_torture_read_exit: Start of episode
[  254.005192] rcu-torture: rcu_torture_read_exit: End of episode
[  254.382054] rcu: NOCB: Cannot CB-offload online CPU 4
[  254.505405] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  254.685927] rcu: NOCB: Cannot CB-offload online CPU 4
[  254.799743] rcu: NOCB: Cannot CB-offload online CPU 14
[  255.336373] rcu: NOCB: Cannot CB-offload online CPU 5
[  255.432744] smpboot: CPU 2 is now offline
[  255.436304] rcu: Offloading 1
[  255.573505] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  255.702485] rcu: NOCB: Cannot CB-offload online CPU 14
[  255.719731] rcu: NOCB: Cannot CB-offload online CPU 14
[  255.862358] rcu: NOCB: Cannot CB-offload online CPU 16
[  256.449536] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  256.489062] rcu: NOCB: Cannot CB-offload online CPU 4
[  256.737388] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  256.760350] rcu: NOCB: Cannot CB-offload online CPU 9
[  256.810526] rcu: De-offloading 2
[  257.517250] rcu: NOCB: Cannot CB-offload online CPU 5
[  257.536143] rcu: NOCB: Cannot CB-offload online CPU 4
[  257.647115] rcu: De-offloading 7
[  258.174445] rcu: NOCB: Cannot CB-offload online CPU 8
[  258.192622] smpboot: CPU 4 is now offline
[  258.193621] rcu: NOCB: Cannot CB-offload online CPU 12
[  259.229177] smpboot: CPU 5 is now offline
[  259.229965] rcu: NOCB: Cannot CB-offload online CPU 14
[  259.230832] rcu: Offloading 7
[  259.270299] rcu: NOCB: Cannot CB-offload online CPU 13
[  259.305599] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  259.685248] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  260.237539] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  260.259761] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  260.356364] rcu: NOCB: Cannot CB-offload online CPU 12
[  260.750253] rcu: NOCB: Cannot CB-offload online CPU 9
[  261.272680] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  261.327962] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  261.444415] rcu: NOCB: Cannot CB-offload online CPU 14
[  262.292372] smpboot: CPU 7 is now offline
[  262.377503] rcu-torture: rtc: 00000000821c6024 ver: 11080 tfle: 0 rta: 11080 rtaf: 0 rtf: 11071 rtmbe: 0 rtmbkf: 0/9919 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 540224 ni: 9570 onoff: 87/87:90/90 7,481:8,976 10635:13263 (HZ=1000) barrier: 1391/1391:0 read-exits: 304 nocb-toggles: 779:820 gpwraps: 0
[  262.380325] rcu-torture: Reader Pipe:  567507363 48726 0 0 0 0 0 0 0 0 0
[  262.381082] rcu-torture: Reader Batch:  567455418 100671 0 0 0 0 0 0 0 0 0
[  262.381825] rcu-torture: Free-Block Circulation:  11079 11079 11078 11077 11076 11075 11074 11073 11072 11071 0
[  263.297591] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  264.305563] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  265.320594] smpboot: CPU 7 is now offline
[  266.331320] smpboot: CPU 4 is now offline
[  266.629528] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  266.631207] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  266.635247] rcu: NOCB: Cannot CB-offload online CPU 5
[  266.637290] rcu: NOCB: Cannot CB-offload online CPU 5
[  267.561832] rcu-torture: rcu_torture_read_exit: Start of episode
[  267.567345] rcu-torture: rcu_torture_read_exit: End of episode
[  267.597502] smpboot: CPU 6 is now offline
[  267.663677] rcu: Offloading 2
[  267.666532] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  267.688577] rcu: NOCB: Cannot CB-offload online CPU 13
[  267.705483] rcu: NOCB: Cannot CB-offload online CPU 14
[  268.940951] smpboot: CPU 5 is now offline
[  268.941773] rcu: De-offloading 7
[  268.961574] rcu: NOCB: Cannot CB-offload online CPU 13
[  268.962214] rcu: Offloading 5
[  268.962662] rcu: NOCB: Cannot CB-offload online CPU 13
[  268.963259] rcu: NOCB: Cannot CB-offload online CPU 8
[  268.963856] rcu: NOCB: Cannot CB-offload online CPU 14
[  269.981818] rcu: NOCB: Cannot CB-offload online CPU 11
[  269.987410] rcu: De-offloading 6
[  270.232647] rcu: Offloading 6
[  270.238740] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  271.280566] smpboot: CPU 3 is now offline
[  271.281408] rcu: Offloading 4
[  271.282302] rcu: NOCB: Cannot CB-offload online CPU 15
[  271.307830] rcu: NOCB: Cannot CB-offload online CPU 10
[  271.333426] rcu: De-offloading 5
[  272.175095] rcu: NOCB: Cannot CB-offload online CPU 16
[  272.308835] rcu: NOCB: Cannot CB-offload online CPU 11
[  272.362392] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  272.424290] rcu: NOCB: Cannot CB-offload online CPU 15
[  272.468601] smpboot: CPU 2 is now offline
[  272.469440] rcu: NOCB: Cannot CB-offload online CPU 10
[  273.052458] rcu: NOCB: Cannot CB-offload online CPU 9
[  273.318841] rcu: NOCB: Cannot CB-offload online CPU 13
[  273.327153] rcu: NOCB: Cannot CB-offload online CPU 12
[  273.480599] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  274.232971] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  274.485748] rcu: NOCB: Cannot CB-offload online CPU 15
[  274.503799] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  274.604517] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  275.337813] rcu: NOCB: Cannot CB-offload online CPU 10
[  275.726500] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  276.267874] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  276.526588] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  276.625597] rcu: De-offloading 2
[  276.887686] rcu: NOCB: Cannot CB-offload online CPU 9
[  276.888507] rcu: NOCB: Cannot CB-offload online CPU 16
[  277.582125] rcu: NOCB: Cannot CB-offload online CPU 12
[  277.737671] rcu-torture: rtc: 000000005f2c66d6 ver: 11607 tfle: 0 rta: 11608 rtaf: 0 rtf: 11597 rtmbe: 0 rtmbkf: 0/10378 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 567448 ni: 10062 onoff: 93/93:96/96 7,481:8,976 11228:13965 (HZ=1000) barrier: 1472/1472:0 read-exits: 320 nocb-toggles: 820:863 gpwraps: 0
[  277.745226] rcu-torture: Reader Pipe:  596521828 51030 0 0 0 0 0 0 0 0 0
[  277.746623] rcu-torture: Reader Batch:  596467335 105522 0 0 0 0 0 0 0 0 0
[  277.750548] rcu-torture: Free-Block Circulation:  11607 11606 11605 11604 11603 11602 11601 11600 11599 11597 0
[  277.978006] rcu: NOCB: Cannot CB-offload online CPU 9
[  278.616123] rcu: NOCB: Cannot CB-offload online CPU 14
[  279.006403] rcu: NOCB: Cannot CB-offload online CPU 15
[  279.047229] rcu: De-offloading 4
[  279.113124] smpboot: CPU 6 is now offline
[  280.090159] rcu: NOCB: Cannot CB-offload online CPU 10
[  280.149266] rcu: NOCB: Cannot CB-offload online CPU 11
[  280.174564] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  280.607840] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  281.166825] rcu: NOCB: Cannot CB-offload online CPU 9
[  281.187061] rcu: NOCB: Cannot CB-offload online CPU 9
[  281.258454] rcu-torture: rcu_torture_read_exit: Start of episode
[  281.260748] rcu-torture: rcu_torture_read_exit: End of episode
[  281.693672] rcu: NOCB: Cannot CB-offload online CPU 9
[  281.699626] rcu: NOCB: Cannot CB-offload online CPU 7
[  282.280788] rcu: De-offloading 3
[  282.333917] rcu: NOCB: Cannot CB-offload online CPU 14
[  282.395713] smpboot: CPU 5 is now offline
[  282.648007] rcu: NOCB: Cannot CB-offload online CPU 12
[  282.726453] rcu: NOCB: Cannot CB-offload online CPU 7
[  282.803373] rcu: NOCB: Cannot CB-offload online CPU 16
[  283.400450] rcu: NOCB: Cannot CB-offload online CPU 14
[  284.125150] smpboot: CPU 7 is now offline
[  284.404604] rcu: NOCB: Cannot CB-offload online CPU 16
[  284.470071] rcu: Offloading 4
[  284.482026] rcu: NOCB: Cannot CB-offload online CPU 15
[  285.148450] rcu: De-offloading 4
[  285.796627] rcu: NOCB: Cannot CB-offload online CPU 9
[  285.797486] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  285.798458] rcu: Offloading 4
[  285.799900] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  286.252529] rcu: NOCB: Cannot CB-offload online CPU 13
[  286.812894] rcu: Offloading 7
[  286.813633] rcu: De-offloading 7
[  286.831503] rcu: NOCB: Cannot CB-offload online CPU 9
[  286.834805] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  286.845904] rcu: Offloading 5
[  286.846530] rcu: NOCB: Cannot CB-offload online CPU 14
[  286.899055] rcu: NOCB: Cannot CB-offload online CPU 14
[  287.304010] rcu: Offloading 7
[  287.850656] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  288.858539] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  289.873688] smpboot: CPU 6 is now offline
[  290.878583] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  291.886578] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  292.628531] rcu: NOCB: Cannot CB-offload online CPU 16
[  292.632037] rcu: NOCB: Cannot CB-offload online CPU 15
[  292.635449] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  292.637387] rcu: NOCB: Cannot CB-offload online CPU 8
[  292.638231] rcu: NOCB: Cannot CB-offload online CPU 15
[  293.098627] rcu-torture: rtc: 000000006a4dd20b ver: 12156 tfle: 0 rta: 12157 rtaf: 0 rtf: 12146 rtmbe: 0 rtmbkf: 0/10845 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 593844 ni: 10535 onoff: 99/99:100/100 7,681:8,976 11979:15357 (HZ=1000) barrier: 1561/1561:0 read-exits: 336 nocb-toggles: 860:900 gpwraps: 0
[  293.102447] rcu-torture: Reader Pipe:  624524663 53449 0 0 0 0 0 0 0 0 0
[  293.103429] rcu-torture: Reader Batch:  624467865 110247 0 0 0 0 0 0 0 0 0
[  293.104507] rcu-torture: Free-Block Circulation:  12156 12155 12154 12153 12152 12151 12149 12148 12147 12146 0
[  293.752632] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  293.913619] smpboot: CPU 1 is now offline
[  294.569452] rcu-torture: rcu_torture_read_exit: Start of episode
[  294.575639] rcu-torture: rcu_torture_read_exit: End of episode
[  294.709289] rcu: De-offloading 6
[  294.760968] rcu: NOCB: Cannot CB-offload online CPU 8
[  294.799749] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  294.834869] rcu: De-offloading 1
[  294.955806] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  295.767659] rcu: NOCB: Cannot CB-offload online CPU 2
[  295.795494] rcu: NOCB: Cannot CB-offload online CPU 9
[  295.803487] rcu: NOCB: Cannot CB-offload online CPU 11
[  295.851474] rcu: NOCB: Cannot CB-offload online CPU 16
[  295.854141] rcu: NOCB: Cannot CB-offload online CPU 6
[  295.978659] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  296.863076] rcu: NOCB: Cannot CB-offload online CPU 10
[  296.905451] rcu: NOCB: Cannot CB-offload online CPU 10
[  296.924038] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  296.967290] rcu: NOCB: Cannot CB-offload online CPU 8
[  297.899460] rcu: NOCB: Cannot CB-offload online CPU 16
[  298.003979] rcu: NOCB: Cannot CB-offload online CPU 12
[  298.049817] smpboot: CPU 5 is now offline
[  299.079509] rcu: NOCB: Cannot CB-offload online CPU 1
[  299.109531] smpboot: CPU 7 is now offline
[  299.111611] rcu: NOCB: Cannot CB-offload online CPU 14
[  299.999349] rcu: NOCB: Cannot CB-offload online CPU 3
[  300.003123] rcu: NOCB: Cannot CB-offload online CPU 12
[  300.021448] rcu: NOCB: Cannot CB-offload online CPU 12
[  300.121732] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  300.127502] rcu: NOCB: Cannot CB-offload online CPU 10
[  300.141450] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  300.224727] rcu: NOCB: Cannot CB-offload online CPU 16
[  300.233002] rcu: NOCB: Cannot CB-offload online CPU 15
[  301.035015] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  301.067453] rcu: NOCB: Cannot CB-offload online CPU 9
[  301.075632] rcu: NOCB: Cannot CB-offload online CPU 9
[  301.158914] rcu: NOCB: Cannot CB-offload online CPU 14
[  301.547781] smpboot: CPU 3 is now offline
[  301.548616] rcu: NOCB: Cannot CB-offload online CPU 10
[  302.181548] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  302.185777] rcu: De-offloading 5
[  302.203125] rcu: NOCB: Cannot CB-offload online CPU 11
[  302.234365] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  302.878545] smpboot: CPU 4 is now offline
[  303.203332] rcu: NOCB: Cannot CB-offload online CPU 11
[  303.231680] rcu: Offloading 5
[  303.618701] rcu: NOCB: Cannot CB-offload online CPU 12
[  303.889473] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  304.280684] rcu: NOCB: Cannot CB-offload online CPU 11
[  304.281765] rcu: De-offloading 4
[  304.686026] rcu: NOCB: Cannot CB-offload online CPU 10
[  304.959408] smpboot: CPU 7 is now offline
[  305.338726] rcu: De-offloading 7
[  305.413368] rcu: NOCB: Cannot CB-offload online CPU 2
[  305.457946] rcu: NOCB: Cannot CB-offload online CPU 14
[  305.784351] rcu: NOCB: Cannot CB-offload online CPU 14
[  306.280510] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  306.341621] rcu: NOCB: Cannot CB-offload online CPU 16
[  306.507483] rcu: NOCB: Cannot CB-offload online CPU 9
[  306.807775] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  306.837565] rcu: NOCB: Cannot CB-offload online CPU 6
[  307.393003] rcu: NOCB: Cannot CB-offload online CPU 8
[  307.515193] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  307.580292] rcu: NOCB: Cannot CB-offload online CPU 16
[  307.591444] rcu: NOCB: Cannot CB-offload online CPU 16
[  307.882480] rcu-torture: rcu_torture_read_exit: Start of episode
[  307.885788] rcu: NOCB: Cannot CB-offload online CPU 7
[  307.887688] rcu-torture: rcu_torture_read_exit: End of episode
[  307.917673] rcu: NOCB: Cannot CB-offload online CPU 12
[  308.458313] rcu-torture: rtc: 00000000e5f9bf90 ver: 13184 tfle: 0 rta: 13185 rtaf: 0 rtf: 13175 rtmbe: 0 rtmbkf: 0/11739 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 634548 ni: 11246 onoff: 105/105:106/106 7,681:8,976 12669:16303 (HZ=1000) barrier: 1647/1648:0 read-exits: 368 nocb-toggles: 907:965 gpwraps: 0
[  308.463854] rcu-torture: Reader Pipe:  667155936 57915 0 0 0 0 0 0 0 0 0
[  308.466065] rcu-torture: Reader Batch:  667094586 119265 0 0 0 0 0 0 0 0 0
[  308.467034] rcu-torture: Free-Block Circulation:  13184 13183 13182 13181 13180 13179 13178 13177 13176 13175 0
[  308.527056] rcu: NOCB: Cannot CB-offload online CPU 3
[  308.644208] rcu: Offloading 4
[  308.656345] rcu: NOCB: Cannot CB-offload online CPU 13
[  308.865598] smpboot: CPU 1 is now offline
[  308.970640] rcu: NOCB: Cannot CB-offload online CPU 11
[  309.012786] rcu: NOCB: Cannot CB-offload online CPU 14
[  309.691535] rcu: NOCB: Cannot CB-offload online CPU 16
[  309.717363] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  309.880385] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  310.027576] rcu: NOCB: Cannot CB-offload online CPU 9
[  310.072375] rcu: NOCB: Cannot CB-offload online CPU 14
[  310.591035] rcu: NOCB: Cannot CB-offload online CPU 8
[  310.604485] rcu: NOCB: Cannot CB-offload online CPU 9
[  310.831137] rcu: NOCB: Cannot CB-offload online CPU 3
[  310.937751] smpboot: CPU 6 is now offline
[  311.068240] rcu: NOCB: Cannot CB-offload online CPU 1
[  311.122510] rcu: NOCB: Cannot CB-offload online CPU 2
[  311.614043] rcu: NOCB: Cannot CB-offload online CPU 7
[  311.850954] rcu: De-offloading 4
[  311.964647] smpboot: CPU 1 is now offline
[  312.146213] rcu: NOCB: Cannot CB-offload online CPU 13
[  312.651144] rcu: NOCB: Cannot CB-offload online CPU 9
[  312.999784] rcu: NOCB: Cannot CB-offload online CPU 10
[  313.129532] rcu: NOCB: Cannot CB-offload online CPU 16
[  313.213366] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  314.259171] smpboot: CPU 5 is now offline
[  315.269521] smpboot: CPU 7 is now offline
[  316.274523] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  317.288331] smpboot: CPU 3 is now offline
[  318.293592] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  318.627629] rcu: NOCB: Cannot CB-offload online CPU 6
[  318.628381] rcu: De-offloading 5
[  318.640678] rcu: Offloading 5
[  318.641360] rcu: NOCB: Cannot CB-offload online CPU 4
[  318.642341] rcu: NOCB: Cannot CB-offload online CPU 9
[  319.324692] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  319.701537] rcu: NOCB: Cannot CB-offload online CPU 11
[  319.702275] rcu: De-offloading 5
[  319.927652] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  320.708569] smpboot: CPU 6 is now offline
[  320.711778] rcu: NOCB: Cannot CB-offload online CPU 16
[  320.712685] rcu: NOCB: Cannot CB-offload online CPU 2
[  320.754991] rcu: NOCB: Cannot CB-offload online CPU 8
[  320.794561] rcu: NOCB: Cannot CB-offload online CPU 13
[  321.034745] rcu: NOCB: Cannot CB-offload online CPU 10
[  321.257457] rcu-torture: rcu_torture_read_exit: Start of episode
[  321.260667] rcu-torture: rcu_torture_read_exit: End of episode
[  321.727630] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  321.769831] rcu: Offloading 6
[  321.799647] rcu: NOCB: Cannot CB-offload online CPU 10
[  321.839581] rcu: NOCB: Cannot CB-offload online CPU 12
[  321.990053] rcu: NOCB: Cannot CB-offload online CPU 11
[  322.026482] rcu: De-offloading 6
[  322.160376] rcu: NOCB: Cannot CB-offload online CPU 13
[  322.794817] rcu: NOCB: Cannot CB-offload online CPU 11
[  322.823453] rcu: NOCB: Cannot CB-offload online CPU 11
[  322.883476] rcu: NOCB: Cannot CB-offload online CPU 3
[  322.936250] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  323.038099] rcu: NOCB: Cannot CB-offload online CPU 8
[  323.818473] rcu-torture: rtc: 00000000b4d0ebb1 ver: 13744 tfle: 0 rta: 13745 rtaf: 0 rtf: 13735 rtmbe: 0 rtmbkf: 0/12226 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 661523 ni: 11728 onoff: 112/112:113/113 7,681:8,976 13250:17120 (HZ=1000) barrier: 1738/1738:0 read-exits: 384 nocb-toggles: 947:1005 gpwraps: 0
[  323.819406] rcu: NOCB: Cannot CB-offload online CPU 4
[  323.822678] rcu-torture: Reader Pipe:  695924722 60279 0 0 0 0 0 0 0 0 0
[  323.824447] rcu-torture: Reader Batch:  695860794 124207 0 0 0 0 0 0 0 0 0
[  323.825486] rcu-torture: Free-Block Circulation:  13744 13743 13742 13741 13740 13739 13738 13737 13736 13735 0
[  323.906304] rcu: NOCB: Cannot CB-offload online CPU 16
[  323.907754] rcu: NOCB: Cannot CB-offload online CPU 12
[  323.915263] rcu: NOCB: Cannot CB-offload online CPU 10
[  323.970100] rcu: NOCB: Cannot CB-offload online CPU 7
[  324.932686] rcu: NOCB: Cannot CB-offload online CPU 1
[  325.011657] smpboot: CPU 1 is now offline
[  325.012773] rcu: NOCB: Cannot CB-offload online CPU 4
[  325.031178] rcu: NOCB: Cannot CB-offload online CPU 4
[  325.978126] rcu: NOCB: Cannot CB-offload online CPU 10
[  326.028303] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  326.047619] rcu: NOCB: Cannot CB-offload online CPU 10
[  327.043789] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  327.168162] rcu: NOCB: Cannot CB-offload online CPU 12
[  327.300000] rcu: NOCB: Cannot CB-offload online CPU 6
[  327.998953] rcu: NOCB: Cannot CB-offload online CPU 4
[  328.073147] rcu: NOCB: Cannot CB-offload online CPU 15
[  328.224520] rcu: NOCB: Cannot CB-offload online CPU 3
[  328.563155] rcu: NOCB: Cannot CB-offload online CPU 9
[  329.108370] rcu: NOCB: Cannot CB-offload online CPU 13
[  329.130738] smpboot: CPU 5 is now offline
[  329.131611] rcu: NOCB: Cannot CB-offload online CPU 14
[  329.231361] rcu: NOCB: Cannot CB-offload online CPU 6
[  329.333058] rcu: NOCB: Cannot CB-offload online CPU 14
[  329.477257] rcu: NOCB: Cannot CB-offload online CPU 9
[  329.503786] rcu: Offloading 5
[  329.650988] rcu: NOCB: Cannot CB-offload online CPU 8
[  330.163476] smpboot: CPU 7 is now offline
[  330.216451] rcu: NOCB: Cannot CB-offload online CPU 2
[  330.230098] rcu: NOCB: Cannot CB-offload online CPU 12
[  330.295177] rcu: De-offloading 5
[  330.751569] rcu: Offloading 7
[  331.222699] rcu: NOCB: Cannot CB-offload online CPU 9
[  331.302624] rcu: NOCB: Cannot CB-offload online CPU 10
[  331.354665] smpboot: CPU 6 is now offline
[  331.770956] rcu: Offloading 5
[  331.850385] rcu: NOCB: Cannot CB-offload online CPU 8
[  331.859339] rcu: De-offloading 7
[  332.346225] rcu: Offloading 7
[  332.899299] smpboot: CPU 2 is now offline
[  332.901619] rcu: NOCB: Cannot CB-offload online CPU 14
[  333.034715] kworker/u69:2 (196) used greatest stack depth: 12384 bytes left
[  333.306778] rcu: NOCB: Cannot CB-offload online CPU 12
[  333.449109] rcu: NOCB: Cannot CB-offload online CPU 14
[  333.451664] rcu: NOCB: Cannot CB-offload online CPU 14
[  333.958441] smpboot: CPU 4 is now offline
[  333.988815] rcu: Offloading 4
[  334.073054] rcu: NOCB: Cannot CB-offload online CPU 15
[  334.469705] rcu: NOCB: Cannot CB-offload online CPU 9
[  334.551030] rcu: NOCB: Cannot CB-offload online CPU 16
[  334.633455] rcu-torture: rcu_torture_read_exit: Start of episode
[  334.638614] rcu-torture: rcu_torture_read_exit: End of episode
[  334.995822] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  335.041531] rcu: Offloading 6
[  335.092275] rcu: NOCB: Cannot CB-offload online CPU 2
[  335.154853] rcu: NOCB: Cannot CB-offload online CPU 9
[  335.510956] rcu: Offloading 1
[  335.668765] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  336.013681] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  336.209304] rcu: NOCB: Cannot CB-offload online CPU 13
[  336.214388] rcu: NOCB: Cannot CB-offload online CPU 16
[  336.268054] rcu: De-offloading 7
[  336.612147] rcu: NOCB: Cannot CB-offload online CPU 11
[  336.633535] rcu: NOCB: Cannot CB-offload online CPU 11
[  336.740284] rcu: NOCB: Cannot CB-offload online CPU 8
[  337.034003] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  337.270051] rcu: NOCB: Cannot CB-offload online CPU 3
[  337.607462] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  337.735018] rcu: NOCB: Cannot CB-offload online CPU 9
[  338.255328] rcu: NOCB: Cannot CB-offload online CPU 10
[  338.280872] rcu: NOCB: Cannot CB-offload online CPU 10
[  338.347668] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  338.642181] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  338.705834] rcu: NOCB: Cannot CB-offload online CPU 9
[  338.749888] rcu: NOCB: Cannot CB-offload online CPU 7
[  338.780492] rcu: NOCB: Cannot CB-offload online CPU 14
[  339.177476] rcu-torture: rtc: 00000000dc640c08 ver: 14704 tfle: 0 rta: 14705 rtaf: 0 rtf: 14695 rtmbe: 0 rtmbkf: 0/13056 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 701346 ni: 12425 onoff: 117/117:119/119 7,681:8,976 13676:18095 (HZ=1000) barrier: 1815/1816:0 read-exits: 400 nocb-toggles: 1008:1059 gpwraps: 0
[  339.182131] rcu-torture: Reader Pipe:  737437627 64449 0 0 0 0 0 0 0 0 0
[  339.183255] rcu-torture: Reader Batch:  737369151 132925 0 0 0 0 0 0 0 0 0
[  339.184334] rcu-torture: Free-Block Circulation:  14704 14703 14702 14701 14700 14699 14698 14697 14696 14695 0
[  339.337339] rcu: NOCB: Cannot CB-offload online CPU 2
[  339.380278] rcu: NOCB: Cannot CB-offload online CPU 2
[  339.418754] rcu: NOCB: Cannot CB-offload online CPU 3
[  341.361588] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  343.385397] smpboot: CPU 7 is now offline
[  344.421199] smpboot: CPU 4 is now offline
[  344.626718] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  344.627474] rcu: De-offloading 4
[  344.631612] rcu: NOCB: Cannot CB-offload online CPU 10
[  345.448518] smpboot: CPU 6 is now offline
[  345.642582] rcu: NOCB: Cannot CB-offload online CPU 12
[  345.654891] rcu: NOCB: Cannot CB-offload online CPU 15
[  345.678038] rcu: Offloading 4
[  345.680838] rcu: NOCB: Cannot CB-offload online CPU 8
[  345.693233] rcu: NOCB: Cannot CB-offload online CPU 10
[  345.701891] rcu: De-offloading 4
[  345.748693] rcu: NOCB: Cannot CB-offload online CPU 12
[  346.583536] smpboot: CPU 5 is now offline
[  346.659232] rcu: NOCB: Cannot CB-offload online CPU 13
[  346.697887] rcu: NOCB: Cannot CB-offload online CPU 15
[  346.700350] rcu: NOCB: Cannot CB-offload online CPU 11
[  347.591450] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  347.742926] rcu: NOCB: Cannot CB-offload online CPU 11
[  347.751758] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  347.774252] rcu: NOCB: Cannot CB-offload online CPU 10
[  347.815423] rcu: NOCB: Cannot CB-offload online CPU 11
[  348.329454] rcu-torture: rcu_torture_read_exit: Start of episode
[  348.332622] rcu-torture: rcu_torture_read_exit: End of episode
[  348.631648] smpboot: CPU 3 is now offline
[  348.830675] rcu: NOCB: Cannot CB-offload online CPU 2
[  348.840455] rcu: NOCB: Cannot CB-offload online CPU 2
[  348.845406] rcu: Offloading 7
[  348.863415] rcu: NOCB: Cannot CB-offload online CPU 16
[  348.949158] rcu: NOCB: Cannot CB-offload online CPU 12
[  349.856349] smpboot: CPU 1 is now offline
[  349.857148] rcu: Offloading 3
[  349.880024] rcu: NOCB: Cannot CB-offload online CPU 11
[  349.883064] rcu: NOCB: Cannot CB-offload online CPU 8
[  350.019822] rcu: De-offloading 7
[  350.938712] rcu: Offloading 4
[  351.022699] rcu: De-offloading 1
[  351.105219] rcu: NOCB: Cannot CB-offload online CPU 2
[  351.109790] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  352.068419] rcu: NOCB: Cannot CB-offload online CPU 12
[  352.148614] smpboot: CPU 5 is now offline
[  352.166136] rcu: NOCB: Cannot CB-offload online CPU 8
[  353.073672] rcu: NOCB: Cannot CB-offload online CPU 12
[  353.233540] rcu: NOCB: Cannot CB-offload online CPU 13
[  353.260395] rcu: NOCB: Cannot CB-offload online CPU 8
[  353.429486] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  354.237546] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  354.239664] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  354.538741] rcu-torture: rtc: 00000000307cd936 ver: 15293 tfle: 0 rta: 15294 rtaf: 0 rtf: 15284 rtmbe: 0 rtmbkf: 0/13573 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 727632 ni: 12900 onoff: 121/121:126/126 7,681:8,976 14483:18587 (HZ=1000) barrier: 1907/1907:0 read-exits: 416 nocb-toggles: 1056:1095 gpwraps: 0
[  354.543552] rcu-torture: Reader Pipe:  765315187 67036 0 0 0 0 0 0 0 0 0
[  354.544620] rcu-torture: Reader Batch:  765243792 138431 0 0 0 0 0 0 0 0 0
[  354.545779] rcu-torture: Free-Block Circulation:  15293 15292 15291 15290 15289 15288 15287 15286 15285 15284 0
[  354.688619] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  355.175554] rcu: NOCB: Cannot CB-offload online CPU 11
[  355.176806] rcu: NOCB: Cannot CB-offload online CPU 2
[  355.299360] rcu: NOCB: Cannot CB-offload online CPU 14
[  355.334540] rcu: Offloading 1
[  355.528257] rcu: NOCB: Cannot CB-offload online CPU 16
[  355.713495] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  356.267657] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  356.279472] rcu: NOCB: Cannot CB-offload online CPU 8
[  356.281805] rcu: De-offloading 4
[  356.560876] rcu: NOCB: Cannot CB-offload online CPU 7
[  356.742584] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  357.325379] rcu: NOCB: Cannot CB-offload online CPU 11
[  357.604900] rcu: NOCB: Cannot CB-offload online CPU 7
[  357.788516] smpboot: CPU 6 is now offline
[  358.439516] rcu: NOCB: Cannot CB-offload online CPU 8
[  358.458807] rcu: NOCB: Cannot CB-offload online CPU 10
[  358.527698] rcu: NOCB: Cannot CB-offload online CPU 7
[  358.624545] rcu: De-offloading 1
[  358.801577] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  359.412867] rcu: Offloading 1
[  359.490963] rcu: NOCB: Cannot CB-offload online CPU 14
[  359.537148] rcu: NOCB: Cannot CB-offload online CPU 11
[  359.718940] rcu: De-offloading 5
[  359.868365] smpboot: CPU 3 is now offline
[  360.481041] rcu: NOCB: Cannot CB-offload online CPU 13
[  360.538472] rcu: NOCB: Cannot CB-offload online CPU 13
[  360.668140] rcu: NOCB: Cannot CB-offload online CPU 4
[  360.884597] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  361.579450] rcu: NOCB: Cannot CB-offload online CPU 16
[  361.614609] rcu: NOCB: Cannot CB-offload online CPU 15
[  361.688373] rcu: NOCB: Cannot CB-offload online CPU 5
[  361.833451] rcu-torture: rcu_torture_read_exit: Start of episode
[  361.842811] rcu-torture: rcu_torture_read_exit: End of episode
[  361.873991] rcu: NOCB: Cannot CB-offload online CPU 16
[  361.922499] smpboot: CPU 4 is now offline
[  362.740271] rcu: NOCB: Cannot CB-offload online CPU 15
[  362.879104] rcu: NOCB: Cannot CB-offload online CPU 9
[  362.963684] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  363.781827] rcu: NOCB: Cannot CB-offload online CPU 12
[  363.798582] rcu: NOCB: Cannot CB-offload online CPU 8
[  363.893367] rcu: NOCB: Cannot CB-offload online CPU 5
[  363.972652] rcu: NOCB: Cannot CB-offload online CPU 2
[  364.001752] rcu: NOCB: Cannot CB-offload online CPU 10
[  364.097207] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  364.758878] rcu: NOCB: Cannot CB-offload online CPU 7
[  364.799144] rcu: De-offloading 3
[  365.029545] rcu: NOCB: Cannot CB-offload online CPU 10
[  366.114644] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  367.123624] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  368.138643] smpboot: CPU 2 is now offline
[  369.155721] smpboot: CPU 5 is now offline
[  369.897562] rcu-torture: rtc: 00000000dad8545b ver: 16163 tfle: 0 rta: 16163 rtaf: 0 rtf: 16154 rtmbe: 0 rtmbkf: 0/14328 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 758283 ni: 13427 onoff: 129/129:131/131 7,681:8,976 14817:18728 (HZ=1000) barrier: 2016/2016:0 read-exits: 432 nocb-toggles: 1098:1133 gpwraps: 0
[  369.900415] rcu-torture: Reader Pipe:  797247101 70878 0 0 0 0 0 0 0 0 0
[  369.901179] rcu-torture: Reader Batch:  797171662 146317 0 0 0 0 0 0 0 0 0
[  369.901919] rcu-torture: Free-Block Circulation:  16162 16162 16161 16160 16159 16158 16157 16156 16155 16154 0
[  370.161613] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  370.625712] rcu: NOCB: Cannot CB-offload online CPU 5
[  370.626779] rcu: NOCB: Cannot CB-offload online CPU 10
[  370.627607] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  370.628894] rcu: NOCB: Cannot CB-offload online CPU 11
[  370.629790] rcu: NOCB: Cannot CB-offload online CPU 3
[  371.179792] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  371.655609] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  371.672033] rcu: NOCB: Cannot CB-offload online CPU 2
[  371.698621] rcu: NOCB: Cannot CB-offload online CPU 16
[  371.707532] rcu: NOCB: Cannot CB-offload online CPU 11
[  371.727793] rcu: NOCB: Cannot CB-offload online CPU 12
[  372.220542] smpboot: CPU 5 is now offline
[  372.679977] rcu: NOCB: Cannot CB-offload online CPU 10
[  372.731828] rcu: NOCB: Cannot CB-offload online CPU 15
[  372.822179] rcu: NOCB: Cannot CB-offload online CPU 16
[  373.703810] smpboot: CPU 4 is now offline
[  373.748921] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  373.790082] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  373.800383] rcu: NOCB: Cannot CB-offload online CPU 13
[  374.753426] smpboot: CPU 1 is now offline
[  374.771220] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  374.808293] rcu: NOCB: Cannot CB-offload online CPU 7
[  374.925946] rcu: Offloading 4
[  375.129943] rcu-torture: rcu_torture_read_exit: Start of episode
[  375.140467] rcu-torture: rcu_torture_read_exit: End of episode
[  375.808382] rcu: NOCB: Cannot CB-offload online CPU 2
[  375.865383] smpboot: CPU 3 is now offline
[  375.903123] rcu: NOCB: Cannot CB-offload online CPU 14
[  375.932570] rcu: NOCB: Cannot CB-offload online CPU 13
[  375.973493] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  375.997388] rcu: NOCB: Cannot CB-offload online CPU 16
[  376.926657] smpboot: CPU 2 is now offline
[  376.927629] rcu: NOCB: Cannot CB-offload online CPU 15
[  376.928513] rcu: NOCB: Cannot CB-offload online CPU 11
[  376.952993] rcu: NOCB: Cannot CB-offload online CPU 14
[  376.992468] rcu: NOCB: Cannot CB-offload online CPU 10
[  377.072464] rcu: NOCB: Cannot CB-offload online CPU 15
[  377.098984] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  377.964343] rcu: NOCB: Cannot CB-offload online CPU 10
[  377.990660] smpboot: CPU 6 is now offline
[  377.991676] rcu: NOCB: Cannot CB-offload online CPU 11
[  378.106647] rcu: Offloading 2
[  379.033181] smpboot: CPU 7 is now offline
[  379.064022] rcu: Offloading 7
[  379.066990] rcu: NOCB: Cannot CB-offload online CPU 16
[  379.105537] rcu: NOCB: Cannot CB-offload online CPU 8
[  379.188400] rcu: NOCB: Cannot CB-offload online CPU 12
[  380.046487] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  380.060187] rcu: Offloading 3
[  380.168567] rcu: NOCB: Cannot CB-offload online CPU 15
[  380.183105] rcu: NOCB: Cannot CB-offload online CPU 16
[  380.262729] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  380.290591] rcu: De-offloading 7
[  381.092592] rcu: NOCB: Cannot CB-offload online CPU 16
[  381.168394] rcu: NOCB: Cannot CB-offload online CPU 14
[  381.195058] rcu: NOCB: Cannot CB-offload online CPU 13
[  381.205354] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  381.475705] rcu: NOCB: Cannot CB-offload online CPU 13
[  381.476510] rcu: Offloading 5
[  381.477414] rcu: Offloading 7
[  382.206658] rcu: NOCB: Cannot CB-offload online CPU 15
[  382.481573] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  382.498782] rcu: NOCB: Cannot CB-offload online CPU 13
[  382.521267] rcu: NOCB: Cannot CB-offload online CPU 15
[  382.574534] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  383.322145] rcu: NOCB: Cannot CB-offload online CPU 15
[  383.662726] rcu: NOCB: Cannot CB-offload online CPU 9
[  383.673220] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  384.237712] rcu: De-offloading 5
[  384.529633] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  384.588603] rcu: NOCB: Cannot CB-offload online CPU 12
[  385.260402] rcu-torture: rtc: 0000000007fc2a4d ver: 17207 tfle: 0 rta: 17208 rtaf: 0 rtf: 17197 rtmbe: 0 rtmbkf: 0/15223 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 797253 ni: 14112 onoff: 135/135:138/138 7,681:8,976 15353:19561 (HZ=1000) barrier: 2108/2108:0 read-exits: 448 nocb-toggles: 1161:1182 gpwraps: 0
[  385.264050] rcu-torture: Reader Pipe:  838272067 75419 0 0 0 0 0 0 0 0 0
[  385.264950] rcu-torture: Reader Batch:  838191507 155979 0 0 0 0 0 0 0 0 0
[  385.265870] rcu-torture: Free-Block Circulation:  17207 17206 17204 17203 17202 17201 17200 17199 17198 17197 0
[  385.440598] rcu: De-offloading 4
[  385.474905] rcu: NOCB: Cannot CB-offload online CPU 15
[  385.564822] smpboot: CPU 3 is now offline
[  385.720123] rcu: NOCB: Cannot CB-offload online CPU 12
[  385.729348] rcu: NOCB: Cannot CB-offload online CPU 15
[  385.818274] rcu: NOCB: Cannot CB-offload online CPU 10
[  386.713015] rcu: De-offloading 7
[  386.819172] rcu: NOCB: Cannot CB-offload online CPU 14
[  386.837691] rcu: NOCB: Cannot CB-offload online CPU 15
[  387.419697] rcu: Offloading 5
[  387.572159] rcu: NOCB: Cannot CB-offload online CPU 14
[  387.582591] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  387.887760] rcu: De-offloading 5
[  387.903874] rcu: Offloading 7
[  388.455621] rcu: De-offloading 7
[  388.649459] rcu-torture: rcu_torture_read_exit: Start of episode
[  388.652963] rcu-torture: rcu_torture_read_exit: End of episode
[  389.068694] rcu: NOCB: Cannot CB-offload online CPU 14
[  389.069597] rcu: NOCB: Cannot CB-offload online CPU 8
[  389.090455] smpboot: CPU 2 is now offline
[  390.078023] rcu: NOCB: Cannot CB-offload online CPU 16
[  390.094749] rcu: NOCB: Cannot CB-offload online CPU 13
[  390.134440] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  390.165117] rcu: Offloading 4
[  390.209293] rcu: De-offloading 2
[  390.309874] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  391.171948] rcu: NOCB: Cannot CB-offload online CPU 12
[  391.194776] rcu: NOCB: Cannot CB-offload online CPU 7
[  391.233337] rcu: NOCB: Cannot CB-offload online CPU 13
[  391.248831] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  391.656071] smpboot: CPU 1 is now offline
[  393.661557] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  394.669566] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  395.683580] smpboot: CPU 3 is now offline
[  396.656131] rcu: NOCB: Cannot CB-offload online CPU 9
[  396.657051] rcu: NOCB: Cannot CB-offload online CPU 16
[  396.658515] rcu: Offloading 2
[  396.659811] rcu: De-offloading 3
[  396.680571] rcu: NOCB: Cannot CB-offload online CPU 5
[  396.709462] smpboot: CPU 7 is now offline
[  397.692487] rcu: NOCB: Cannot CB-offload online CPU 16
[  397.716056] rcu: NOCB: Cannot CB-offload online CPU 16
[  397.719197] rcu: NOCB: Cannot CB-offload online CPU 16
[  397.734198] rcu: NOCB: Cannot CB-offload online CPU 12
[  397.787528] rcu: NOCB: Cannot CB-offload online CPU 12
[  398.717147] rcu: Offloading 3
[  398.736316] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  398.781816] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  398.808778] smpboot: CPU 5 is now offline
[  399.873963] rcu: NOCB: Cannot CB-offload online CPU 12
[  399.948201] rcu: NOCB: Cannot CB-offload online CPU 15
[  400.618925] rcu-torture: rtc: 0000000014a94d30 ver: 17902 tfle: 0 rta: 17903 rtaf: 0 rtf: 17892 rtmbe: 0 rtmbkf: 0/15829 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 823232 ni: 14575 onoff: 139/139:144/144 7,681:8,976 15612:20567 (HZ=1000) barrier: 2205/2205:0 read-exits: 464 nocb-toggles: 1201:1221 gpwraps: 0
[  400.625457] rcu-torture: Reader Pipe:  866148864 78535 0 0 0 0 0 0 0 0 0
[  400.629196] rcu-torture: Reader Batch:  866065211 162188 0 0 0 0 0 0 0 0 0
[  400.630121] rcu-torture: Free-Block Circulation:  17902 17901 17900 17899 17898 17897 17895 17894 17893 17892 0
[  400.843956] rcu: NOCB: Cannot CB-offload online CPU 12
[  400.886750] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  400.901439] rcu: NOCB: Cannot CB-offload online CPU 12
[  400.952206] rcu: De-offloading 2
[  400.960779] rcu: De-offloading 3
[  401.862554] smpboot: CPU 6 is now offline
[  402.030347] rcu: NOCB: Cannot CB-offload online CPU 9
[  402.043528] rcu: Offloading 3
[  402.074824] rcu: De-offloading 3
[  402.409453] rcu-torture: rcu_torture_read_exit: Start of episode
[  402.425694] rcu-torture: rcu_torture_read_exit: End of episode
[  402.886581] rcu: Offloading 5
[  403.024374] rcu: NOCB: Cannot CB-offload online CPU 14
[  403.050707] rcu: Offloading 7
[  403.125246] rcu: NOCB: Cannot CB-offload online CPU 8
[  403.148381] rcu: Offloading 2
[  404.004807] rcu: NOCB: Cannot CB-offload online CPU 16
[  404.114847] rcu: NOCB: Cannot CB-offload online CPU 9
[  404.174514] rcu: NOCB: Cannot CB-offload online CPU 13
[  404.949663] smpboot: CPU 4 is now offline
[  405.070891] rcu: De-offloading 4
[  405.185371] rcu: NOCB: Cannot CB-offload online CPU 9
[  405.186181] rcu: De-offloading 5
[  405.957625] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  406.139715] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  406.162301] rcu: Offloading 3
[  406.266713] rcu: NOCB: Cannot CB-offload online CPU 8
[  406.270543] rcu: NOCB: Cannot CB-offload online CPU 16
[  406.292775] rcu: NOCB: Cannot CB-offload online CPU 15
[  406.995633] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  407.187468] rcu: De-offloading 7
[  407.713444] rcu: De-offloading 2
[  407.726661] rcu: NOCB: Cannot CB-offload online CPU 5
[  407.727662] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  408.048622] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  408.742198] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  408.754800] rcu: Offloading 2
[  409.131599] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  409.295983] rcu: De-offloading 3
[  409.803384] rcu: NOCB: Cannot CB-offload online CPU 13
[  409.828248] rcu: Offloading 3
[  409.831984] rcu: NOCB: Cannot CB-offload online CPU 5
[  409.840355] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  409.871164] rcu: NOCB: Cannot CB-offload online CPU 11
[  410.209678] smpboot: CPU 1 is now offline
[  410.379461] rcu: De-offloading 3
[  410.860506] rcu: NOCB: Cannot CB-offload online CPU 11
[  410.896349] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  410.936860] rcu: Offloading 3
[  410.952092] rcu: NOCB: Cannot CB-offload online CPU 16
[  411.230733] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  411.885438] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  411.944346] rcu: NOCB: Cannot CB-offload online CPU 10
[  411.967793] rcu: NOCB: Cannot CB-offload online CPU 16
[  412.048907] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  412.274937] smpboot: CPU 5 is now offline
[  412.527824] rcu: NOCB: Cannot CB-offload online CPU 16
[  413.006494] rcu: De-offloading 3
[  413.311597] rcu: NOCB: Cannot CB-offload online CPU 13
[  413.312546] rcu: Offloading 7
[  413.325413] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  413.536113] rcu: NOCB: Cannot CB-offload online CPU 3
[  413.989578] rcu: NOCB: Cannot CB-offload online CPU 14
[  414.328762] rcu: NOCB: Cannot CB-offload online CPU 3
[  414.356908] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  414.378768] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  414.437725] rcu: NOCB: Cannot CB-offload online CPU 10
[  414.544542] rcu: NOCB: Cannot CB-offload online CPU 16
[  415.028814] rcu: NOCB: Cannot CB-offload online CPU 11
[  415.368294] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  415.421450] smpboot: CPU 5 is now offline
[  415.441326] rcu: NOCB: Cannot CB-offload online CPU 15
[  415.490150] rcu: De-offloading 7
[  415.977464] rcu-torture: 
[  415.977468] rcu-torture: rcu_torture_read_exit: Start of episode
[  415.977470] rtc: 0000000068c21a5e ver: 19201 tfle: 0 rta: 19202 rtaf: 0 rtf: 19192 rtmbe: 0 rtmbkf: 0/16967 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 865524 ni: 15313 onoff: 146/146:149/149 7,681:8,976 15925:20856 (HZ=1000) barrier: 2306/2306:0 read-exits: 487 nocb-toggles: 1259:1276 gpwraps: 0
[  415.983221] rcu-torture: rcu_torture_read_exit: End of episode
[  415.987092] rcu-torture: Reader Pipe:  910801453 84277 0 0 0 0 0 0 0 0 0
[  415.987107] rcu-torture: Reader Batch:  910711868 173861 0 0 0 0 0 0 0 0 0
[  415.990211] rcu-torture: Free-Block Circulation:  19202 19201 19200 19199 19198 19197 19196 19195 19194 19193 0
[  416.102845] rcu: NOCB: Cannot CB-offload online CPU 10
[  416.410183] rcu: NOCB: Cannot CB-offload online CPU 8
[  416.477485] rcu: Offloading 7
[  416.495893] rcu: NOCB: Cannot CB-offload online CPU 4
[  416.548248] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  416.780894] smpboot: CPU 3 is now offline
[  417.148709] rcu: NOCB: Cannot CB-offload online CPU 16
[  417.521864] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  417.567957] rcu: NOCB: Cannot CB-offload online CPU 16
[  417.609465] rcu: NOCB: Cannot CB-offload online CPU 10
[  417.887565] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  418.929495] smpboot: CPU 5 is now offline
[  419.934590] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  420.942605] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  421.956483] smpboot: CPU 2 is now offline
[  422.655146] rcu: NOCB: Cannot CB-offload online CPU 3
[  422.655895] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  422.658355] rcu: NOCB: Cannot CB-offload online CPU 11
[  422.975513] smpboot: CPU 6 is now offline
[  423.670320] rcu: NOCB: Cannot CB-offload online CPU 4
[  423.691741] rcu: NOCB: Cannot CB-offload online CPU 11
[  423.774948] rcu: NOCB: Cannot CB-offload online CPU 11
[  424.049637] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  424.734270] rcu: NOCB: Cannot CB-offload online CPU 14
[  424.785276] rcu: Offloading 5
[  424.801847] rcu: NOCB: Cannot CB-offload online CPU 12
[  424.804765] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  424.823994] rcu: NOCB: Cannot CB-offload online CPU 10
[  424.880270] rcu: NOCB: Cannot CB-offload online CPU 14
[  425.268690] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  425.769116] rcu: NOCB: Cannot CB-offload online CPU 14
[  425.817641] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  425.901220] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  425.908479] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  426.317872] smpboot: CPU 1 is now offline
[  426.772836] rcu: NOCB: Cannot CB-offload online CPU 16
[  426.982369] rcu: NOCB: Cannot CB-offload online CPU 16
[  427.007886] rcu: NOCB: Cannot CB-offload online CPU 14
[  427.332303] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  427.849250] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  427.869663] rcu: NOCB: Cannot CB-offload online CPU 10
[  427.956904] rcu: NOCB: Cannot CB-offload online CPU 9
[  427.972985] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  427.979943] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  428.043899] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  428.101079] rcu: NOCB: Cannot CB-offload online CPU 11
[  428.376572] smpboot: CPU 7 is now offline
[  428.852437] rcu: NOCB: Cannot CB-offload online CPU 12
[  429.008666] rcu: NOCB: Cannot CB-offload online CPU 9
[  429.036675] rcu: NOCB: Cannot CB-offload online CPU 11
[  429.152896] rcu: NOCB: Cannot CB-offload online CPU 3
[  429.289866] rcu-torture: rcu_torture_read_exit: Start of episode
[  429.298456] rcu-torture: rcu_torture_read_exit: End of episode
[  429.449497] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  430.063646] rcu: De-offloading 6
[  430.098459] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  430.182400] rcu: Offloading 6
[  430.213940] rcu: NOCB: Cannot CB-offload online CPU 3
[  430.219239] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  430.938876] smpboot: CPU 2 is now offline
[  431.108191] rcu: NOCB: Cannot CB-offload online CPU 10
[  431.145252] rcu: NOCB: Cannot CB-offload online CPU 15
[  431.166660] rcu: De-offloading 6
[  431.191112] rcu: NOCB: Cannot CB-offload online CPU 16
[  431.329683] rcu: NOCB: Cannot CB-offload online CPU 15
[  431.338317] rcu-torture: rtc: 000000005c14f77a ver: 19791 tfle: 0 rta: 19792 rtaf: 0 rtf: 19782 rtmbe: 0 rtmbkf: 0/17479 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 892182 ni: 15791 onoff: 153/153:156/156 7,681:8,976 16469:21819 (HZ=1000) barrier: 2396/2396:0 read-exits: 512 nocb-toggles: 1304:1318 gpwraps: 0
[  431.342250] rcu-torture: Reader Pipe:  939004923 86795 0 0 0 0 0 0 0 0 0
[  431.343313] rcu-torture: Reader Batch:  938912632 179086 0 0 0 0 0 0 0 0 0
[  431.344398] rcu-torture: Free-Block Circulation:  19791 19790 19789 19788 19787 19786 19785 19784 19783 19782 0
[  432.123601] rcu: NOCB: Cannot CB-offload online CPU 13
[  432.164280] rcu: NOCB: Cannot CB-offload online CPU 14
[  432.202738] rcu: NOCB: Cannot CB-offload online CPU 14
[  432.428390] rcu: Offloading 6
[  432.535968] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  433.144969] rcu: NOCB: Cannot CB-offload online CPU 14
[  433.187035] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  433.918667] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  434.296319] rcu: De-offloading 6
[  434.555656] rcu: NOCB: Cannot CB-offload online CPU 8
[  434.975819] smpboot: CPU 1 is now offline
[  435.393140] rcu: NOCB: Cannot CB-offload online CPU 11
[  435.401274] rcu: Offloading 6
[  435.624160] rcu: NOCB: Cannot CB-offload online CPU 11
[  435.628740] rcu: NOCB: Cannot CB-offload online CPU 8
[  435.992407] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  436.632016] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  437.055724] smpboot: CPU 7 is now offline
[  437.352707] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  437.373634] rcu: NOCB: Cannot CB-offload online CPU 9
[  437.427337] rcu: NOCB: Cannot CB-offload online CPU 12
[  437.563816] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  437.628176] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  437.690195] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  437.829692] rcu: De-offloading 1
[  438.458732] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  438.478562] smpboot: CPU 6 is now offline
[  438.719865] rcu: NOCB: Cannot CB-offload online CPU 10
[  439.517502] smpboot: CPU 2 is now offline
[  439.518370] rcu: NOCB: Cannot CB-offload online CPU 10
[  439.574142] rcu: De-offloading 6
[  439.660799] rcu: NOCB: Cannot CB-offload online CPU 8
[  439.716167] rcu: NOCB: Cannot CB-offload online CPU 11
[  439.800521] rcu: NOCB: Cannot CB-offload online CPU 9
[  439.843475] rcu: NOCB: Cannot CB-offload online CPU 16
[  440.742500] rcu: NOCB: Cannot CB-offload online CPU 9
[  440.813544] smpboot: CPU 3 is now offline
[  440.858957] rcu: De-offloading 2
[  441.638252] rcu: NOCB: Cannot CB-offload online CPU 13
[  441.742004] rcu: NOCB: Cannot CB-offload online CPU 12
[  441.777087] rcu: NOCB: Cannot CB-offload online CPU 4
[  441.845510] rcu: Offloading 1
[  442.132708] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  442.794203] rcu-torture: rcu_torture_read_exit: Start of episode
[  442.801332] rcu-torture: rcu_torture_read_exit: End of episode
[  442.867278] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  443.021931] rcu: De-offloading 7
[  443.177691] smpboot: CPU 5 is now offline
[  444.187540] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  445.221558] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  446.239424] smpboot: CPU 6 is now offline
[  446.697512] rcu-torture: rtc: 000000007c8baa89 ver: 20353 tfle: 0 rta: 20353 rtaf: 0 rtf: 20344 rtmbe: 0 rtmbkf: 0/17972 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 924116 ni: 16349 onoff: 159/159:163/163 7,681:8,976 17862:22713 (HZ=1000) barrier: 2475/2475:0 read-exits: 528 nocb-toggles: 1344:1365 gpwraps: 0
[  446.701637] rcu-torture: Reader Pipe:  972099849 89250 0 0 0 0 0 0 0 0 0
[  446.702639] rcu-torture: Reader Batch:  972004889 184210 0 0 0 0 0 0 0 0 0
[  446.703652] rcu-torture: Free-Block Circulation:  20352 20352 20351 20350 20349 20348 20347 20346 20345 20344 0
[  447.243545] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  448.257303] smpboot: CPU 3 is now offline
[  448.654237] rcu: NOCB: Cannot CB-offload online CPU 4
[  448.656389] rcu: NOCB: Cannot CB-offload online CPU 9
[  448.666451] rcu: NOCB: Cannot CB-offload online CPU 8
[  448.671575] rcu: De-offloading 1
[  448.683733] rcu: NOCB: Cannot CB-offload online CPU 11
[  448.684818] rcu: NOCB: Cannot CB-offload online CPU 6
[  449.306485] smpboot: CPU 6 is now offline
[  449.683758] rcu: NOCB: Cannot CB-offload online CPU 10
[  449.758580] rcu: Offloading 6
[  450.316610] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  450.751468] rcu: NOCB: Cannot CB-offload online CPU 14
[  450.792192] rcu: NOCB: Cannot CB-offload online CPU 12
[  450.804627] rcu: NOCB: Cannot CB-offload online CPU 14
[  450.807465] rcu: NOCB: Cannot CB-offload online CPU 2
[  450.835308] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  450.857369] rcu: NOCB: Cannot CB-offload online CPU 12
[  451.353425] smpboot: CPU 2 is now offline
[  451.839930] rcu: Offloading 2
[  451.848180] rcu: NOCB: Cannot CB-offload online CPU 16
[  452.134338] rcu: De-offloading 6
[  452.374865] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  452.934152] rcu: De-offloading 2
[  452.970676] rcu: NOCB: Cannot CB-offload online CPU 15
[  453.532561] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  453.952219] rcu: NOCB: Cannot CB-offload online CPU 16
[  454.006229] rcu: NOCB: Cannot CB-offload online CPU 4
[  454.064071] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  454.190477] rcu: Offloading 7
[  454.557753] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  455.068998] rcu: NOCB: Cannot CB-offload online CPU 12
[  455.151087] rcu: NOCB: Cannot CB-offload online CPU 3
[  455.175270] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  455.256075] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  455.750673] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  456.103204] rcu: NOCB: Cannot CB-offload online CPU 14
[  456.489463] rcu-torture: rcu_torture_read_exit: Start of episode
[  456.494990] rcu-torture: rcu_torture_read_exit: End of episode
[  456.798199] smpboot: CPU 6 is now offline
[  457.166395] rcu: NOCB: Cannot CB-offload online CPU 16
[  457.207331] rcu: Offloading 1
[  457.278643] rcu: NOCB: Cannot CB-offload online CPU 2
[  457.390204] rcu: NOCB: Cannot CB-offload online CPU 14
[  457.419833] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  457.804612] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  458.246208] rcu: NOCB: Cannot CB-offload online CPU 14
[  458.291655] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  458.294877] rcu: NOCB: Cannot CB-offload online CPU 13
[  458.403262] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  458.849405] smpboot: CPU 2 is now offline
[  459.225445] rcu: NOCB: Cannot CB-offload online CPU 16
[  459.325978] rcu: NOCB: Cannot CB-offload online CPU 10
[  459.340796] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  459.494276] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  459.873239] smpboot: CPU 7 is now offline
[  460.290494] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  460.387021] rcu: Offloading 2
[  460.497846] rcu: Offloading 6
[  460.559514] rcu: De-offloading 2
[  460.982876] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  461.316678] rcu: NOCB: Cannot CB-offload online CPU 11
[  461.373491] rcu: NOCB: Cannot CB-offload online CPU 14
[  461.444921] rcu: De-offloading 7
[  461.458091] rcu: De-offloading 6
[  461.668796] rcu: NOCB: Cannot CB-offload online CPU 9
[  461.727853] rcu: NOCB: Cannot CB-offload online CPU 9
[  462.037454] smpboot: CPU 2 is now offline
[  462.057549] rcu-torture: rtc: 00000000ff540557 ver: 21272 tfle: 0 rta: 21273 rtaf: 0 rtf: 21261 rtmbe: 0 rtmbkf: 0/18771 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 959648 ni: 16977 onoff: 167/167:170/170 7,681:8,976 18424:22934 (HZ=1000) barrier: 2567/2567:0 read-exits: 544 nocb-toggles: 1388:1425 gpwraps: 0
[  462.066552] rcu-torture: Reader Pipe:  1009682756 93360 0 0 0 0 0 0 0 0 0
[  462.068076] rcu-torture: Reader Batch:  1009583627 192489 0 0 0 0 0 0 0 0 0
[  462.071991] rcu-torture: Free-Block Circulation:  21272 21271 21270 21269 21268 21267 21264 21263 21262 21261 0
[  462.458779] rcu: Offloading 7
[  462.473249] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  462.594828] rcu: NOCB: Cannot CB-offload online CPU 3
[  463.093209] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  463.367248] rcu: Offloading 6
[  463.490520] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  463.555580] rcu: NOCB: Cannot CB-offload online CPU 4
[  463.636196] rcu: De-offloading 6
[  464.131455] smpboot: CPU 1 is now offline
[  464.472495] rcu: NOCB: Cannot CB-offload online CPU 3
[  464.609468] rcu: NOCB: Cannot CB-offload online CPU 12
[  465.098048] rcu: De-offloading 1
[  465.112987] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  465.190395] rcu: NOCB: Cannot CB-offload online CPU 8
[  465.480175] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  465.568617] rcu: NOCB: Cannot CB-offload online CPU 4
[  465.728845] rcu: NOCB: Cannot CB-offload online CPU 13
[  466.211174] rcu: NOCB: Cannot CB-offload online CPU 8
[  466.573579] smpboot: CPU 5 is now offline
[  466.665293] rcu: NOCB: Cannot CB-offload online CPU 16
[  466.737090] rcu: NOCB: Cannot CB-offload online CPU 13
[  466.782677] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  467.326167] rcu: NOCB: Cannot CB-offload online CPU 9
[  467.625194] smpboot: CPU 7 is now offline
[  467.736076] rcu: NOCB: Cannot CB-offload online CPU 13
[  468.062029] rcu: NOCB: Cannot CB-offload online CPU 15
[  468.365181] rcu: NOCB: Cannot CB-offload online CPU 11
[  468.697534] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  469.181491] rcu: NOCB: Cannot CB-offload online CPU 11
[  469.330795] rcu: NOCB: Cannot CB-offload online CPU 4
[  469.445499] rcu: NOCB: Cannot CB-offload online CPU 4
[  469.719561] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  470.121464] rcu-torture: rcu_torture_read_exit: Start of episode
[  470.735240] smpboot: CPU 3 is now offline
[  471.745329] smpboot: CPU 1 is now offline
[  472.756385] smpboot: CPU 4 is now offline
[  473.761625] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  474.653275] rcu: NOCB: Cannot CB-offload online CPU 6
[  474.654173] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  474.660368] rcu: NOCB: Cannot CB-offload online CPU 13
[  474.666239] rcu: De-offloading 7
[  474.666796] rcu-torture: rcu_torture_read_exit: End of episode
[  474.685194] rcu: NOCB: Cannot CB-offload online CPU 15
[  474.686059] rcu: Offloading 3
[  474.775887] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  475.704618] rcu: NOCB: Cannot CB-offload online CPU 10
[  475.725166] rcu: Offloading 4
[  475.782272] rcu: NOCB: Cannot CB-offload online CPU 9
[  475.936780] smpboot: CPU 5 is now offline
[  476.721405] rcu: NOCB: Cannot CB-offload online CPU 6
[  476.797930] rcu: NOCB: Cannot CB-offload online CPU 15
[  476.983959] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  477.417468] rcu-torture: rtc: 00000000580ff98d ver: 21823 tfle: 0 rta: 21824 rtaf: 0 rtf: 21814 rtmbe: 0 rtmbkf: 0/19262 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 986476 ni: 17453 onoff: 174/174:177/177 7,681:8,976 19074:23233 (HZ=1000) barrier: 2656/2656:0 read-exits: 560 nocb-toggles: 1416:1477 gpwraps: 0
[  477.428139] rcu-torture: Reader Pipe:  1038100634 95767 0 0 0 0 0 0 0 0 0
[  477.429276] rcu-torture: Reader Batch:  1037999126 197274 0 0 0 0 0 0 0 0 0
[  477.430483] rcu-torture: Free-Block Circulation:  21823 21823 21822 21821 21820 21819 21818 21817 21816 21815 0
[  477.773465] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  477.815946] rcu: NOCB: Cannot CB-offload online CPU 12
[  477.837683] rcu: Offloading 7
[  477.862502] rcu: NOCB: Cannot CB-offload online CPU 12
[  477.970807] rcu: NOCB: Cannot CB-offload online CPU 11
[  478.029082] smpboot: CPU 2 is now offline
[  478.836677] rcu: NOCB: Cannot CB-offload online CPU 15
[  478.890847] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  478.957211] rcu: NOCB: Cannot CB-offload online CPU 9
[  478.960440] rcu: NOCB: Cannot CB-offload online CPU 9
[  478.976460] rcu: NOCB: Cannot CB-offload online CPU 13
[  479.060403] smpboot: CPU 5 is now offline
[  479.079911] rcu: NOCB: Cannot CB-offload online CPU 9
[  479.992719] rcu: NOCB: Cannot CB-offload online CPU 10
[  480.214007] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  481.020452] rcu: Offloading 2
[  481.060360] rcu: NOCB: Cannot CB-offload online CPU 15
[  481.077221] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  481.186193] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  481.447143] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  482.165928] rcu: NOCB: Cannot CB-offload online CPU 16
[  482.175682] rcu: NOCB: Cannot CB-offload online CPU 11
[  482.468552] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  483.156969] rcu: NOCB: Cannot CB-offload online CPU 1
[  483.260801] rcu: De-offloading 5
[  483.393727] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  483.394653] rcu: NOCB: Cannot CB-offload online CPU 8
[  483.511151] smpboot: CPU 1 is now offline
[  484.305335] rcu: De-offloading 7
[  484.474420] rcu: NOCB: Cannot CB-offload online CPU 10
[  484.475381] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  484.500379] rcu: NOCB: Cannot CB-offload online CPU 15
[  484.841642] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  485.172893] rcu: NOCB: Cannot CB-offload online CPU 11
[  485.313568] rcu: Offloading 7
[  485.568817] rcu: NOCB: Cannot CB-offload online CPU 12
[  485.895881] smpboot: CPU 6 is now offline
[  486.568850] rcu: NOCB: Cannot CB-offload online CPU 9
[  486.575116] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  486.668375] rcu: Offloading 1
[  486.960291] smpboot: CPU 4 is now offline
[  487.483222] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  487.622745] rcu: NOCB: Cannot CB-offload online CPU 9
[  487.651331] rcu: NOCB: Cannot CB-offload online CPU 15
[  487.705317] rcu: NOCB: Cannot CB-offload online CPU 14
[  487.709931] rcu: NOCB: Cannot CB-offload online CPU 8
[  487.777459] rcu: De-offloading 4
[  487.980294] rcu-torture: rcu_torture_read_exit: Start of episode
[  487.984834] rcu-torture: rcu_torture_read_exit: End of episode
[  488.002485] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  488.591071] rcu: Offloading 4
[  488.727477] rcu: NOCB: Cannot CB-offload online CPU 5
[  488.746848] rcu: NOCB: Cannot CB-offload online CPU 14
[  488.814835] rcu: NOCB: Cannot CB-offload online CPU 14
[  488.987404] rcu: NOCB: Cannot CB-offload online CPU 13
[  489.749466] rcu: NOCB: Cannot CB-offload online CPU 11
[  489.794892] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  489.865409] rcu: NOCB: Cannot CB-offload online CPU 16
[  489.937761] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  490.032468] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  490.051983] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  490.466811] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  490.891389] rcu: NOCB: Cannot CB-offload online CPU 15
[  491.165059] rcu: NOCB: Cannot CB-offload online CPU 12
[  491.527076] rcu: NOCB: Cannot CB-offload online CPU 15
[  491.978386] rcu: NOCB: Cannot CB-offload online CPU 12
[  491.987311] rcu: NOCB: Cannot CB-offload online CPU 5
[  492.052740] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  492.260490] rcu: NOCB: Cannot CB-offload online CPU 6
[  492.643388] rcu: NOCB: Cannot CB-offload online CPU 9
[  492.780700] rcu-torture: rtc: 000000002aec239b ver: 22774 tfle: 0 rta: 22775 rtaf: 0 rtf: 22765 rtmbe: 0 rtmbkf: 0/20087 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1025992 ni: 18154 onoff: 180/180:182/182 7,681:8,976 19911:23426 (HZ=1000) barrier: 2732/2733:0 read-exits: 576 nocb-toggles: 1473:1534 gpwraps: 0
[  492.789741] rcu-torture: Reader Pipe:  1079882496 99957 0 0 0 0 0 0 0 0 0
[  492.791241] rcu-torture: Reader Batch:  1079776759 205694 0 0 0 0 0 0 0 0 0
[  492.796266] rcu-torture: Free-Block Circulation:  22774 22773 22772 22771 22770 22769 22768 22767 22766 22765 0
[  492.956518] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  492.990707] rcu: NOCB: Cannot CB-offload online CPU 10
[  493.060342] rcu: NOCB: Cannot CB-offload online CPU 10
[  493.129077] rcu: NOCB: Cannot CB-offload online CPU 6
[  494.175970] smpboot: CPU 5 is now offline
[  494.176865] rcu: Offloading 5
[  494.177409] rcu: De-offloading 4
[  494.200807] rcu: NOCB: Cannot CB-offload online CPU 13
[  494.201822] rcu: NOCB: Cannot CB-offload online CPU 11
[  495.178151] rcu: De-offloading 1
[  495.204852] smpboot: CPU 7 is now offline
[  495.233550] rcu: NOCB: Cannot CB-offload online CPU 15
[  495.250996] rcu: De-offloading 5
[  495.322499] rcu: NOCB: Cannot CB-offload online CPU 10
[  495.408480] rcu: NOCB: Cannot CB-offload online CPU 10
[  496.209595] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  497.251678] smpboot: CPU 3 is now offline
[  498.256620] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  499.264547] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  500.652324] rcu: NOCB: Cannot CB-offload online CPU 5
[  500.654491] rcu: NOCB: Cannot CB-offload online CPU 5
[  500.660135] rcu: NOCB: Cannot CB-offload online CPU 13
[  500.663573] rcu: Offloading 1
[  501.297745] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  501.353483] rcu-torture: rcu_torture_read_exit: Start of episode
[  501.362774] rcu-torture: rcu_torture_read_exit: End of episode
[  501.660239] rcu: NOCB: Cannot CB-offload online CPU 10
[  501.684355] rcu: NOCB: Cannot CB-offload online CPU 14
[  501.718995] rcu: De-offloading 3
[  502.342262] smpboot: CPU 7 is now offline
[  502.698622] rcu: NOCB: Cannot CB-offload online CPU 6
[  502.750097] rcu: NOCB: Cannot CB-offload online CPU 10
[  502.772515] rcu: NOCB: Cannot CB-offload online CPU 6
[  502.785713] rcu: NOCB: Cannot CB-offload online CPU 5
[  502.796117] rcu: NOCB: Cannot CB-offload online CPU 14
[  502.822905] rcu: NOCB: Cannot CB-offload online CPU 13
[  503.404265] smpboot: CPU 2 is now offline
[  503.740546] rcu: NOCB: Cannot CB-offload online CPU 11
[  503.767043] rcu: NOCB: Cannot CB-offload online CPU 16
[  503.777345] rcu: NOCB: Cannot CB-offload online CPU 13
[  503.844747] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  503.868187] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  504.419922] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  504.743920] rcu: NOCB: Cannot CB-offload online CPU 5
[  504.798062] rcu: NOCB: Cannot CB-offload online CPU 6
[  504.814532] rcu: NOCB: Cannot CB-offload online CPU 15
[  504.852373] rcu: NOCB: Cannot CB-offload online CPU 13
[  504.921082] rcu: De-offloading 7
[  504.942152] rcu: Offloading 3
[  504.985471] rcu: NOCB: Cannot CB-offload online CPU 15
[  505.837684] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  505.884492] rcu: NOCB: Cannot CB-offload online CPU 13
[  505.985831] rcu: NOCB: Cannot CB-offload online CPU 9
[  506.028943] rcu: NOCB: Cannot CB-offload online CPU 10
[  506.444681] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  506.835817] rcu: NOCB: Cannot CB-offload online CPU 9
[  506.883400] rcu: NOCB: Cannot CB-offload online CPU 8
[  506.954149] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  506.957286] rcu: NOCB: Cannot CB-offload online CPU 4
[  507.103150] rcu: NOCB: Cannot CB-offload online CPU 14
[  507.486412] smpboot: CPU 3 is now offline
[  507.949684] rcu: NOCB: Cannot CB-offload online CPU 14
[  508.070364] rcu: NOCB: Cannot CB-offload online CPU 13
[  508.137594] rcu-torture: rtc: 00000000a1075b85 ver: 23292 tfle: 0 rta: 23293 rtaf: 0 rtf: 23281 rtmbe: 0 rtmbkf: 0/20537 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1052032 ni: 18616 onoff: 186/186:188/188 7,681:8,1127 20024:24744 (HZ=1000) barrier: 2823/2824:0 read-exits: 592 nocb-toggles: 1519:1572 gpwraps: 0
[  508.145279] rcu-torture: 
[  508.145307] rcu: NOCB: Cannot CB-offload online CPU 6
[  508.146517] Reader Pipe:  1106948751 102225 0 0 0 0 0 0 0 0 0
[  508.147348] rcu-torture: Reader Batch:  1106840515 210461 0 0 0 0 0 0 0 0 0
[  508.148283] rcu-torture: Free-Block Circulation:  23292 23291 23289 23288 23287 23286 23285 23284 23283 23281 0
[  508.973821] rcu: NOCB: Cannot CB-offload online CPU 6
[  508.979584] rcu: NOCB: Cannot CB-offload online CPU 11
[  509.003467] rcu: NOCB: Cannot CB-offload online CPU 9
[  509.091478] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  509.151041] rcu: NOCB: Cannot CB-deoffload online CPU 1
[  509.172115] rcu: NOCB: Cannot CB-offload online CPU 6
[  509.260461] rcu: NOCB: Cannot CB-offload online CPU 8
[  509.675396] smpboot: CPU 2 is now offline
[  510.075929] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  510.121039] rcu: De-offloading 3
[  510.340561] rcu: NOCB: Cannot CB-offload online CPU 5
[  510.341474] rcu: NOCB: Cannot CB-offload online CPU 16
[  510.342450] rcu: NOCB: Cannot CB-offload online CPU 4
[  510.711914] smpboot: CPU 1 is now offline
[  511.094685] rcu: NOCB: Cannot CB-offload online CPU 12
[  511.115249] rcu: NOCB: Cannot CB-offload online CPU 12
[  511.134204] rcu: NOCB: Cannot CB-offload online CPU 12
[  511.395073] rcu: De-offloading 1
[  511.795747] smpboot: CPU 6 is now offline
[  512.121703] rcu: NOCB: Cannot CB-offload online CPU 13
[  512.396856] rcu: Offloading 3
[  512.505097] rcu: NOCB: Cannot CB-offload online CPU 9
[  512.550370] rcu: NOCB: Cannot CB-offload online CPU 15
[  512.984604] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  513.239235] rcu: De-offloading 3
[  513.415984] rcu: NOCB: Cannot CB-offload online CPU 16
[  513.467451] rcu: NOCB: Cannot CB-offload online CPU 13
[  513.616892] rcu: Offloading 6
[  513.644016] rcu: NOCB: Cannot CB-offload online CPU 14
[  514.007051] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  514.235351] rcu: NOCB: Cannot CB-offload online CPU 7
[  514.344791] rcu: NOCB: Cannot CB-offload online CPU 13
[  514.469198] rcu: NOCB: Cannot CB-offload online CPU 16
[  514.472450] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  514.580931] rcu: NOCB: Cannot CB-offload online CPU 11
[  514.627372] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  514.729460] rcu-torture: rcu_torture_read_exit: Start of episode
[  514.734398] rcu-torture: rcu_torture_read_exit: End of episode
[  515.066774] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  515.474097] rcu: Offloading 3
[  515.682830] rcu: NOCB: Cannot CB-offload online CPU 4
[  516.330338] rcu: NOCB: Cannot CB-offload online CPU 9
[  516.398443] rcu: NOCB: Cannot CB-offload online CPU 12
[  516.510302] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  516.795019] rcu: NOCB: Cannot CB-offload online CPU 16
[  516.813601] rcu: NOCB: Cannot CB-offload online CPU 15
[  516.833950] rcu: NOCB: Cannot CB-offload online CPU 14
[  517.711560] rcu: NOCB: Cannot CB-offload online CPU 5
[  517.745590] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  517.823924] rcu: NOCB: Cannot CB-offload online CPU 13
[  517.859782] rcu: NOCB: Cannot CB-offload online CPU 15
[  517.882364] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  517.910428] rcu: NOCB: Cannot CB-offload online CPU 9
[  517.921852] rcu: NOCB: Cannot CB-offload online CPU 11
[  518.778415] smpboot: CPU 4 is now offline
[  518.821659] rcu: NOCB: Cannot CB-offload online CPU 12
[  518.923712] rcu: NOCB: Cannot CB-offload online CPU 16
[  518.988401] rcu: NOCB: Cannot CB-offload online CPU 1
[  519.844412] smpboot: CPU 5 is now offline
[  519.882753] rcu: Offloading 4
[  519.939123] rcu: NOCB: Cannot CB-offload online CPU 10
[  520.024996] rcu: Offloading 5
[  520.876979] smpboot: CPU 2 is now offline
[  520.994364] rcu: NOCB: Cannot CB-offload online CPU 1
[  521.098563] rcu: NOCB: Cannot CB-offload online CPU 15
[  521.884555] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  522.933107] smpboot: CPU 5 is now offline
[  523.497545] rcu-torture: rtc: 00000000716a3f54 ver: 23939 tfle: 0 rta: 23939 rtaf: 0 rtf: 23930 rtmbe: 0 rtmbkf: 0/21110 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1086836 ni: 19235 onoff: 192/192:195/195 7,681:8,1127 20983:25221 (HZ=1000) barrier: 2899/2899:0 read-exits: 608 nocb-toggles: 1577:1612 gpwraps: 0
[  523.501723] rcu-torture: Reader Pipe:  1143762014 105094 0 0 0 0 0 0 0 0 0
[  523.502695] rcu-torture: Reader Batch:  1143650517 216591 0 0 0 0 0 0 0 0 0
[  523.503472] rcu-torture: Free-Block Circulation:  23938 23938 23937 23936 23935 23934 23933 23932 23931 23930 0
[  523.938712] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  524.947701] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  525.961613] smpboot: CPU 3 is now offline
[  526.651412] rcu: De-offloading 3
[  526.679570] rcu: De-offloading 5
[  526.709759] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  527.316796] smpboot: CPU 7 is now offline
[  527.702506] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  527.730393] rcu: NOCB: Cannot CB-offload online CPU 12
[  527.734922] rcu: NOCB: Cannot CB-offload online CPU 14
[  528.042922] rcu-torture: rcu_torture_read_exit: Start of episode
[  528.054675] rcu-torture: rcu_torture_read_exit: End of episode
[  528.350824] smpboot: CPU 1 is now offline
[  528.741618] rcu: Offloading 5
[  528.778471] rcu: NOCB: Cannot CB-offload online CPU 15
[  528.789359] rcu: NOCB: Cannot CB-offload online CPU 16
[  528.890999] rcu: De-offloading 5
[  529.830839] rcu: Offloading 7
[  529.832376] rcu: NOCB: Cannot CB-offload online CPU 13
[  529.863552] rcu: NOCB: Cannot CB-offload online CPU 11
[  529.878564] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  529.880673] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  530.026314] rcu: De-offloading 7
[  530.922661] smpboot: CPU 4 is now offline
[  530.923632] rcu: NOCB: Cannot CB-offload online CPU 12
[  530.924467] rcu: NOCB: Cannot CB-offload online CPU 13
[  530.926016] rcu: NOCB: Cannot CB-offload online CPU 11
[  530.938615] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  531.982658] rcu: Offloading 3
[  532.171308] rcu: De-offloading 4
[  532.189776] rcu: NOCB: Cannot CB-offload online CPU 9
[  532.190948] rcu: Offloading 5
[  532.194437] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  533.201503] rcu: NOCB: Cannot CB-offload online CPU 9
[  533.216852] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  533.244528] rcu: Offloading 1
[  533.266443] rcu: NOCB: Cannot CB-offload online CPU 12
[  534.240595] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  534.306451] smpboot: CPU 6 is now offline
[  534.307634] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  534.346378] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  534.370379] rcu: NOCB: Cannot CB-offload online CPU 12
[  534.385472] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  535.310416] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  535.463058] rcu: Offloading 4
[  536.017857] rcu: NOCB: Cannot CB-offload online CPU 14
[  536.090729] rcu: NOCB: Cannot CB-offload online CPU 9
[  536.369438] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  536.487697] rcu: NOCB: Cannot CB-offload online CPU 9
[  536.585582] rcu: NOCB: Cannot CB-offload online CPU 14
[  537.373266] rcu: NOCB: Cannot CB-deoffload online CPU 3
[  537.411487] smpboot: CPU 6 is now offline
[  538.157771] rcu: Offloading 7
[  538.428496] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  538.444570] rcu: NOCB: Cannot CB-offload online CPU 15
[  538.557977] rcu: NOCB: Cannot CB-offload online CPU 12
[  538.637628] rcu: NOCB: Cannot CB-offload online CPU 10
[  538.774304] rcu: De-offloading 7
[  538.857455] rcu-torture: rtc: 000000002aec239b ver: 24673 tfle: 0 rta: 24674 rtaf: 0 rtf: 24663 rtmbe: 0 rtmbkf: 0/21730 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1118946 ni: 19807 onoff: 199/199:201/201 7,681:8,1127 21399:26302 (HZ=1000) barrier: 2986/2986:0 read-exits: 624 nocb-toggles: 1618:1666 gpwraps: 0
[  538.861439] rcu-torture: Reader Pipe:  1177217180 108371 0 0 0 0 0 0 0 0 0
[  538.862541] rcu-torture: Reader Batch:  1177102570 222981 0 0 0 0 0 0 0 0 0
[  538.863640] rcu-torture: Free-Block Circulation:  24674 24673 24672 24670 24669 24668 24667 24666 24665 24664 0
[  539.293640] rcu: NOCB: Cannot CB-offload online CPU 14
[  539.661508] smpboot: CPU 3 is now offline
[  539.662448] rcu: NOCB: Cannot CB-offload online CPU 15
[  539.673253] rcu: NOCB: Cannot CB-offload online CPU 9
[  539.722425] rcu: Offloading 7
[  539.828936] rcu: NOCB: Cannot CB-offload online CPU 16
[  540.708792] rcu: NOCB: Cannot CB-offload online CPU 15
[  540.737603] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  540.768444] rcu: NOCB: Cannot CB-offload online CPU 11
[  540.811982] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  541.417468] rcu-torture: rcu_torture_read_exit: Start of episode
[  541.426718] rcu-torture: rcu_torture_read_exit: End of episode
[  541.433166] smpboot: CPU 5 is now offline
[  541.434608] rcu: NOCB: Cannot CB-offload online CPU 8
[  541.437937] rcu: NOCB: Cannot CB-offload online CPU 16
[  541.860858] rcu: De-offloading 7
[  542.020996] rcu: NOCB: Cannot CB-offload online CPU 9
[  542.489161] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  542.531440] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  542.726409] rcu: De-offloading 1
[  542.776692] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  542.924889] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  543.102855] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  543.726236] rcu: Offloading 7
[  543.814640] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  543.831329] rcu: NOCB: Cannot CB-offload online CPU 13
[  544.001479] rcu: De-offloading 7
[  544.415804] rcu: NOCB: Cannot CB-offload online CPU 9
[  544.835071] rcu: NOCB: Cannot CB-offload online CPU 9
[  544.862152] smpboot: CPU 2 is now offline
[  544.864447] rcu: NOCB: Cannot CB-offload online CPU 9
[  545.047127] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  545.517525] rcu: De-offloading 2
[  545.643655] rcu: NOCB: Cannot CB-offload online CPU 12
[  546.117413] rcu: NOCB: Cannot CB-offload online CPU 11
[  546.199885] smpboot: CPU 1 is now offline
[  546.506046] rcu: Offloading 2
[  546.552961] rcu: NOCB: Cannot CB-offload online CPU 8
[  546.607910] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  546.763870] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  546.929322] rcu: NOCB: Cannot CB-offload online CPU 13
[  546.970744] rcu: NOCB: Cannot CB-offload online CPU 16
[  547.121759] rcu: De-offloading 2
[  547.230508] smpboot: CPU 5 is now offline
[  548.243185] smpboot: CPU 6 is now offline
[  549.254219] smpboot: CPU 4 is now offline
[  550.259593] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  551.280259] smpboot: CPU 7 is now offline
[  552.284533] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  552.650560] rcu: NOCB: Cannot CB-offload online CPU 15
[  552.652728] rcu: NOCB: Cannot CB-offload online CPU 8
[  553.691609] rcu: NOCB: Cannot CB-offload online CPU 13
[  553.695415] rcu: Offloading 1
[  553.710879] rcu: NOCB: Cannot CB-offload online CPU 12
[  553.712878] rcu: NOCB: Cannot CB-offload online CPU 13
[  553.726448] rcu: NOCB: Cannot CB-offload online CPU 11
[  553.758031] rcu: NOCB: Cannot CB-offload online CPU 14
[  554.217644] rcu-torture: rtc: 00000000307cd936 ver: 25198 tfle: 0 rta: 25199 rtaf: 0 rtf: 25188 rtmbe: 0 rtmbkf: 0/22169 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1145636 ni: 20283 onoff: 203/203:209/209 7,681:8,1127 21808:27728 (HZ=1000) barrier: 3074/3074:0 read-exits: 640 nocb-toggles: 1655:1708 gpwraps: 0
[  554.222219] rcu-torture: Reader Pipe:  1204918527 110705 0 0 0 0 0 0 0 0 0
[  554.223356] rcu-torture: Reader Batch:  1204801445 227787 0 0 0 0 0 0 0 0 0
[  554.224553] rcu-torture: Free-Block Circulation:  25200 25197 25196 25195 25194 25193 25191 25190 25189 25188 0
[  554.584724] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  554.732131] rcu: NOCB: Cannot CB-offload online CPU 8
[  554.767589] rcu: Offloading 2
[  554.795792] rcu-torture: rcu_torture_read_exit: Start of episode
[  554.800684] rcu-torture: rcu_torture_read_exit: End of episode
[  554.809637] rcu: NOCB: Cannot CB-offload online CPU 15
[  555.737635] rcu: NOCB: Cannot CB-offload online CPU 10
[  555.771901] rcu: De-offloading 1
[  555.811497] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  555.895879] rcu: NOCB: Cannot CB-offload online CPU 13
[  555.900873] rcu: Offloading 1
[  555.907231] rcu: NOCB: Cannot CB-offload online CPU 11
[  556.840120] rcu: NOCB: Cannot CB-offload online CPU 13
[  556.891739] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  556.926588] rcu: NOCB: Cannot CB-offload online CPU 12
[  556.942536] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  556.969942] rcu: De-offloading 3
[  557.838218] rcu: NOCB: Cannot CB-offload online CPU 16
[  557.859569] rcu: NOCB: Cannot CB-offload online CPU 12
[  557.918776] rcu: NOCB: Cannot CB-offload online CPU 10
[  557.936728] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  557.989046] rcu: NOCB: Cannot CB-offload online CPU 15
[  558.192896] smpboot: CPU 6 is now offline
[  558.953412] rcu: NOCB: Cannot CB-offload online CPU 12
[  559.009660] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  559.030881] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  559.087201] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  559.215972] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  559.936292] rcu: NOCB: Cannot CB-offload online CPU 7
[  560.081625] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  560.086085] rcu: NOCB: Cannot CB-offload online CPU 13
[  560.142874] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  560.241690] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  560.944068] rcu: NOCB: Cannot CB-offload online CPU 14
[  561.037262] rcu: NOCB: Cannot CB-offload online CPU 9
[  561.050686] rcu: NOCB: Cannot CB-offload online CPU 8
[  561.097293] rcu: NOCB: Cannot CB-offload online CPU 12
[  561.292646] smpboot: CPU 2 is now offline
[  562.048466] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  562.063164] rcu: NOCB: Cannot CB-offload online CPU 16
[  562.111414] rcu: NOCB: Cannot CB-offload online CPU 12
[  562.126850] rcu: NOCB: Cannot CB-offload online CPU 7
[  562.303383] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  562.366229] rcu: NOCB: Cannot CB-offload online CPU 9
[  563.130827] rcu: De-offloading 1
[  563.413711] rcu: NOCB: Cannot CB-offload online CPU 16
[  563.458231] smpboot: CPU 7 is now offline
[  563.459123] rcu: NOCB: Cannot CB-offload online CPU 12
[  564.435371] rcu: NOCB: Cannot CB-offload online CPU 13
[  564.446472] rcu: NOCB: Cannot CB-offload online CPU 8
[  564.493210] smpboot: CPU 5 is now offline
[  564.508246] rcu: NOCB: Cannot CB-offload online CPU 16
[  564.518948] rcu: NOCB: Cannot CB-offload online CPU 13
[  564.523850] rcu: NOCB: Cannot CB-offload online CPU 14
[  565.228807] rcu: NOCB: Cannot CB-offload online CPU 16
[  565.460412] rcu: De-offloading 2
[  565.510135] rcu: Offloading 2
[  565.564675] rcu: NOCB: Cannot CB-offload online CPU 11
[  565.614889] rcu: NOCB: Cannot CB-offload online CPU 14
[  566.523319] rcu: NOCB: Cannot CB-offload online CPU 15
[  566.530380] rcu: NOCB: Cannot CB-offload online CPU 8
[  566.633377] rcu: NOCB: Cannot CB-offload online CPU 12
[  566.694330] rcu: Offloading 7
[  567.519783] smpboot: CPU 6 is now offline
[  567.527372] rcu: De-offloading 7
[  567.645643] rcu: NOCB: Cannot CB-offload online CPU 13
[  567.647235] rcu: NOCB: Cannot CB-offload online CPU 13
[  567.692630] rcu: De-offloading 5
[  568.105509] rcu-torture: rcu_torture_read_exit: Start of episode
[  568.111944] rcu-torture: rcu_torture_read_exit: End of episode
[  568.634481] rcu: NOCB: Cannot CB-offload online CPU 11
[  568.760608] rcu: NOCB: Cannot CB-offload online CPU 10
[  569.451843] rcu: Offloading 7
[  569.577551] rcu-torture: rtc: 0000000083a817d2 ver: 25935 tfle: 0 rta: 25936 rtaf: 0 rtf: 25924 rtmbe: 0 rtmbkf: 0/22812 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1184552 ni: 20980 onoff: 209/209:214/214 7,681:8,1127 22553:28198 (HZ=1000) barrier: 3143/3143:0 read-exits: 672 nocb-toggles: 1721:1755 gpwraps: 0
[  569.581751] rcu-torture: Reader Pipe:  1245591405 113982 0 0 0 0 0 0 0 0 0
[  569.582772] rcu-torture: Reader Batch:  1245470896 234491 0 0 0 0 0 0 0 0 0
[  569.583772] rcu-torture: Free-Block Circulation:  25935 25934 25933 25932 25931 25929 25928 25927 25926 25924 0
[  569.813118] rcu: De-offloading 7
[  569.855875] rcu: NOCB: Cannot CB-offload online CPU 9
[  570.480494] rcu: NOCB: Cannot CB-offload online CPU 9
[  570.789422] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  570.979060] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  571.496601] rcu: Offloading 7
[  571.840626] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  571.982489] rcu: NOCB: Cannot CB-offload online CPU 9
[  572.604133] rcu: NOCB: Cannot CB-offload online CPU 12
[  572.736449] rcu: NOCB: Cannot CB-deoffload online CPU 4
[  572.883427] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  573.012980] rcu: NOCB: Cannot CB-offload online CPU 10
[  573.098529] rcu: NOCB: Cannot CB-offload online CPU 11
[  573.137935] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  573.611639] rcu: NOCB: Cannot CB-offload online CPU 10
[  574.149523] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  575.163211] smpboot: CPU 4 is now offline
[  576.174258] smpboot: CPU 3 is now offline
[  577.185528] smpboot: CPU 6 is now offline
[  578.228262] smpboot: CPU 7 is now offline
[  579.263166] smpboot: CPU 5 is now offline
[  579.651826] rcu: Offloading 3
[  579.699404] rcu: NOCB: Cannot CB-offload online CPU 13
[  579.726092] rcu: NOCB: Cannot CB-deoffload online CPU 2
[  579.773769] rcu: NOCB: Cannot CB-offload online CPU 10
[  580.734886] rcu: De-offloading 4
[  580.805597] rcu: NOCB: Cannot CB-offload online CPU 16
[  580.806501] rcu: Offloading 5
[  580.810504] rcu: NOCB: Cannot CB-offload online CPU 16
[  580.811212] rcu: De-offloading 6
[  581.399609] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  581.418632] rcu-torture: rcu_torture_read_exit: Start of episode
[  581.425036] rcu-torture: rcu_torture_read_exit: End of episode
[  581.827208] rcu: NOCB: Cannot CB-offload online CPU 13
[  581.911028] rcu: Offloading 6
[  581.917957] rcu: De-offloading 5
[  582.411631] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  582.432601] rcu: NOCB: Cannot CB-offload online CPU 8
[  582.772141] rcu: NOCB: Cannot CB-deoffload online CPU 0
[  582.875462] rcu: NOCB: Cannot CB-offload online CPU 8
[  583.017798] rcu: NOCB: Cannot CB-offload online CPU 12
[  583.050042] rcu: NOCB: Cannot CB-offload online CPU 11
[  583.480867] smpboot: CPU 1 is now offline
[  583.531451] rcu: NOCB: Cannot CB-offload online CPU 10
[  583.826788] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  584.015777] rcu: NOCB: Cannot CB-offload online CPU 8
[  584.108111] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  584.917589] rcu: NOCB: Cannot CB-offload online CPU 9
[  584.939525] rcu-torture: rtc: 0000000064bd1c70 ver: 26549 tfle: 0 rta: 26550 rtaf: 0 rtf: 26538 rtmbe: 0 rtmbkf: 0/23344 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1211203 ni: 21459 onoff: 215/215:220/220 7,681:8,1127 23345:28356 (HZ=1000) barrier: 3237/3238:0 read-exits: 688 nocb-toggles: 1755:1802 gpwraps: 0
[  584.943599] rcu-torture: Reader Pipe:  1273890561 116668 0 0 0 0 0 0 0 0 0
[  584.944625] rcu-torture: Reader Batch:  1273767140 240089 0 0 0 0 0 0 0 0 0
[  584.945696] rcu-torture: Free-Block Circulation:  26550 26549 26548 26547 26546 26545 26544 26542 26540 26539 0
[  585.196788] rcu: Offloading 4
[  585.731889] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  586.065901] rcu: NOCB: Cannot CB-offload online CPU 9
[  586.169666] rcu: NOCB: Cannot CB-offload online CPU 11
[  586.227444] rcu: NOCB: Cannot CB-offload online CPU 5
[  586.293220] rcu: NOCB: Cannot CB-offload online CPU 13
[  586.697307] rcu: NOCB: Cannot CB-offload online CPU 16
[  586.769848] rcu: De-offloading 4
[  587.169887] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  587.179339] rcu: NOCB: Cannot CB-deoffload online CPU 7
[  587.265064] rcu: NOCB: Cannot CB-offload online CPU 11
[  587.376917] rcu: NOCB: Cannot CB-offload online CPU 13
[  587.759509] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  588.209680] rcu: NOCB: Cannot CB-offload online CPU 8
[  588.239183] rcu: NOCB: Cannot CB-offload online CPU 8
[  588.260377] rcu: NOCB: Cannot CB-deoffload online CPU 6
[  588.357805] rcu: De-offloading 3
[  588.424833] smpboot: CPU 6 is now offline
[  588.819181] rcu: NOCB: Cannot CB-offload online CPU 5
[  589.248275] rcu: Offloading 4
[  589.271628] rcu: De-offloading 4
[  589.313568] rcu: De-offloading 6
[  589.354397] rcu: NOCB: Cannot CB-offload online CPU 14
[  589.454219] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  589.483124] rcu: NOCB: Cannot CB-offload online CPU 9
[  589.493922] rcu: NOCB: Cannot CB-offload online CPU 16
[  589.585494] rcu: Offloading 1
[  590.362564] rcu: NOCB: Cannot CB-offload online CPU 16
[  590.436251] rcu: NOCB: Cannot CB-offload online CPU 13
[  590.534704] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  590.568524] rcu: De-offloading 1
[  590.939313] rcu: NOCB: Cannot CB-offload online CPU 12
[  591.455702] rcu: NOCB: Cannot CB-offload online CPU 5
[  591.532896] rcu: NOCB: Cannot CB-offload online CPU 8
[  591.579710] smpboot: CPU 3 is now offline
[  591.614570] rcu: NOCB: Cannot CB-offload online CPU 14
[  591.704444] rcu: NOCB: Cannot CB-offload online CPU 15
[  592.038463] rcu: NOCB: Cannot CB-offload online CPU 10
[  592.371091] rcu: Offloading 1
[  592.576347] rcu: NOCB: Cannot CB-offload online CPU 4
[  592.660812] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  592.691525] rcu: De-offloading 1
[  593.051211] rcu: Offloading 1
[  593.418882] rcu: NOCB: Cannot CB-offload online CPU 4
[  593.552013] rcu: NOCB: Cannot CB-offload online CPU 16
[  593.626368] rcu: NOCB: Cannot CB-offload online CPU 6
[  593.701246] smpboot: CPU 7 is now offline
[  593.819745] rcu: NOCB: Cannot CB-offload online CPU 9
[  593.833223] rcu: NOCB: Cannot CB-offload online CPU 12
[  594.707409] rcu: De-offloading 1
[  594.793484] rcu-torture: rcu_torture_read_exit: Start of episode
[  594.808548] rcu-torture: rcu_torture_read_exit: End of episode
[  594.933529] smpboot: CPU 5 is now offline
[  594.934905] rcu: NOCB: Cannot CB-offload online CPU 9
[  594.943876] rcu: NOCB: Cannot CB-offload online CPU 4
[  595.604722] rcu: NOCB: Cannot CB-offload online CPU 9
[  595.982843] rcu: NOCB: Cannot CB-offload online CPU 4
[  596.027209] rcu: NOCB: Cannot CB-offload online CPU 12
[  596.046138] rcu: NOCB: Cannot CB-offload online CPU 14
[  596.397862] rcu: NOCB: Cannot CB-offload online CPU 14
[  596.536265] rcu: NOCB: Cannot CB-offload online CPU 15
[  596.624110] rcu: NOCB: Cannot CB-offload online CPU 14
[  596.954654] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  597.041705] rcu: NOCB: Cannot CB-offload online CPU 6
[  597.043610] rcu: NOCB: Cannot CB-offload online CPU 16
[  597.084234] rcu: NOCB: Cannot CB-offload online CPU 16
[  597.089945] rcu: NOCB: Cannot CB-offload online CPU 16
[  597.517444] rcu: NOCB: Cannot CB-offload online CPU 15
[  597.601851] rcu: Offloading 5
[  598.115731] rcu: NOCB: Cannot CB-offload online CPU 9
[  598.179754] rcu: NOCB: Cannot CB-offload online CPU 6
[  598.208914] rcu: De-offloading 7
[  598.269883] smpboot: CPU 6 is now offline
[  598.635987] rcu: NOCB: Cannot CB-offload online CPU 14
[  599.140372] rcu: NOCB: Cannot CB-offload online CPU 4
[  599.261179] rcu: NOCB: Cannot CB-offload online CPU 8
[  599.269309] rcu: Offloading 3
[  599.617069] rcu: NOCB: Cannot CB-offload online CPU 11
[  600.297531] rcu-torture: rtc: 00000000e5f9bf90 ver: 27284 tfle: 0 rta: 27284 rtaf: 0 rtf: 27275 rtmbe: 0 rtmbkf: 0/23978 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1247961 ni: 22127 onoff: 221/221:225/225 7,681:8,1127 24271:29196 (HZ=1000) barrier: 3306/3306:0 read-exits: 704 nocb-toggles: 1818:1849 gpwraps: 0
[  600.300416] rcu-torture: Reader Pipe:  1312829634 119860 0 0 0 0 0 0 0 0 0
[  600.301159] rcu-torture: Reader Batch:  1312702872 246622 0 0 0 0 0 0 0 0 0
[  600.301906] rcu-torture: Free-Block Circulation:  27283 27283 27282 27281 27280 27279 27278 27277 27276 27275 0
[  601.275535] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  602.283592] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  603.320561] smpboot: Booting Node 0 Processor 6 APIC 0x6
[  604.335501] smpboot: CPU 2 is now offline
[  604.648627] rcu: NOCB: Cannot CB-offload online CPU 15
[  604.649630] rcu: NOCB: Cannot CB-offload online CPU 4
[  604.654469] rcu: NOCB: Cannot CB-offload online CPU 4
[  604.655148] rcu: NOCB: Cannot CB-offload online CPU 9
[  604.656413] rcu: NOCB: Cannot CB-offload online CPU 15
[  605.369625] smpboot: CPU 4 is now offline
[  605.671667] rcu: De-offloading 3
[  605.707189] rcu: NOCB: Cannot CB-offload online CPU 16
[  605.711769] rcu: NOCB: Cannot CB-offload online CPU 1
[  605.755521] rcu: NOCB: Cannot CB-offload online CPU 14
[  605.760656] rcu: NOCB: Cannot CB-offload online CPU 15
[  606.378775] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  606.727000] rcu: Offloading 3
[  606.798402] rcu: NOCB: Cannot CB-deoffload online CPU 5
[  606.818367] rcu: De-offloading 3
[  606.830626] rcu: NOCB: Cannot CB-offload online CPU 15
[  606.839973] rcu: NOCB: Cannot CB-offload online CPU 10
[  607.749790] rcu: Offloading 4
[  607.908766] smpboot: CPU 6 is now offline
[  607.911304] rcu: NOCB: Cannot CB-offload online CPU 9
[  608.234548] rcu-torture: rcu_torture_read_exit: Start of episode
[  608.237135] rcu-torture: rcu_torture_read_exit: End of episode
[  608.832985] rcu: NOCB: Cannot CB-offload online CPU 13
[  608.856691] rcu: NOCB: Cannot CB-offload online CPU 8
[  608.912611] rcu: NOCB: Cannot CB-offload online CPU 13
[  608.983530] smpboot: CPU 7 is now offline
[  609.004022] rcu: Offloading 7
[  609.871702] rcu: NOCB: Cannot CB-offload online CPU 12
[  610.024547] smpboot: CPU 5 is now offline
[  610.067363] rcu: NOCB: Cannot CB-offload online CPU 11
[  610.848852] rcu: De-offloading 7
[  615.657472] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1276515 ni: 22643 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 720 nocb-toggles: 1841:1874 gpwraps: 0
[  615.660591] rcu-torture: Reader Pipe:  1342650078 122018 0 0 0 0 0 0 0 0 0
[  615.661357] rcu-torture: Reader Batch:  1342519873 252223 0 0 0 0 0 0 0 0 0
[  615.662211] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  621.678520] rcu-torture: rcu_torture_read_exit: Start of episode
[  621.691937] rcu-torture: rcu_torture_read_exit: End of episode
[  631.017463] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1303490 ni: 23125 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  631.025763] rcu-torture: Reader Pipe:  1370958281 122018 0 0 0 0 0 0 0 0 0
[  631.029186] rcu-torture: Reader Batch:  1370824452 255847 0 0 0 0 0 0 0 0 0
[  631.031098] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  631.032657] ??? Writer stall state RTWS_EXP_SYNC(4) g152813 f0x0 ->state D cpu 1
[  631.033804] task:rcu_torture_wri state:D stack:14472 pid:99    tgid:99    ppid:2      task_flags:0x208040 flags:0x00080000
[  631.035527] Call Trace:
[  631.035929]  <TASK>
[  631.036226]  __schedule+0x56d/0xf70
[  631.036784]  schedule+0x22/0xa0
[  631.037259]  percpu_rwsem_wait+0x145/0x190
[  631.037900]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[  631.038734]  __percpu_down_read+0x71/0x110
[  631.039297]  ? __pfx_synchronize_rcu_expedited+0x10/0x10
[  631.040060]  cpus_read_lock+0x4c/0x50
[  631.040594]  do_rtws_sync.constprop.0+0x1f3/0x210
[  631.041214]  ? torture_hrtimeout_ns+0x4a/0xe0
[  631.041895]  rcu_torture_writer+0x5d0/0xfd0
[  631.042533]  ? __pfx_rcu_torture_writer+0x10/0x10
[  631.043231]  kthread+0xe5/0x120
[  631.043741]  ? __pfx_kthread+0x10/0x10
[  631.044287]  ret_from_fork+0x1bd/0x220
[  631.044879]  ? __pfx_kthread+0x10/0x10
[  631.045422]  ret_from_fork_asm+0x1a/0x30
[  631.046052]  </TASK>
[  631.046394] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 0 ->gp_activity 0 ->gp_req_activity 0 ->gp_wake_time 0 ->gp_wake_seq 152813 ->gp_seq 152817 ->gp_seq_needed 152816 ->gp_max 381 ->gp_flags 0x0
[  631.049573] rcu: 	rcu_node 0:16 ->gp_seq 152817 ->gp_seq_needed 152816 ->qsmask 0x3 .... ->n_boosts 0
[  631.050943] rcu: 	rcu_node 0:8 ->gp_seq 152817 ->gp_seq_needed 152824 ->qsmask 0x100 .... ->n_boosts 0
[  631.052328] rcu: 	cpu 1 ->gp_seq_needed 152824
[  631.052952] rcu: 	cpu 2 ->gp_seq_needed 152824
[  631.053589] rcu: 	cpu 8 ->gp_seq_needed 152824
[  631.054269] rcu: 	rcu_node 9:16 ->gp_seq 152817 ->gp_seq_needed 152824 ->qsmask 0x0 .... ->n_boosts 0
[  631.055607] rcu: 	cpu 9 ->gp_seq_needed 152824
[  631.056261] rcu: 	cpu 10 ->gp_seq_needed 152824
[  631.056938] rcu: 	cpu 11 ->gp_seq_needed 152824
[  631.057604] rcu: 	cpu 12 ->gp_seq_needed 152824
[  631.058300] rcu: 	cpu 13 ->gp_seq_needed 152824
[  631.058957] rcu: 	cpu 14 ->gp_seq_needed 152824
[  631.059642] rcu: 	cpu 15 ->gp_seq_needed 152820
[  631.060329] rcu: 	cpu 16 ->gp_seq_needed 152824
[  631.061004] rcu: nocb GP 0 KldtS .[W.] .G:152824/169040 rnp 0:8 34169 S CPU 12
[  631.062108] rcu:    CB 0^0->2 KblSW F414 L414 C0 ..... q0 S CPU 8
[  631.062960] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W11(152824/169040).N5. q16 S CPU 1
[  631.064104] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  631.065121] rcu:    CB 4^4->7 KblSW F55894 L55903 C119 ..... q0 S CPU 2
[  631.066109] rcu:    CB 5^4->4 KblSW F21044 L21044 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  631.067411] rcu:    CB 7^4->-1 KblSW F37363 L37369 C16 ..... q0 S CPU 13
[  631.068421] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[  631.069303] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  631.070156] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  631.071009] rcu: RCU callbacks invoked since boot: 1452248
[  631.071723] rcu_tasks: RTGS_WAIT_CBS(11) since 630498 g:0 i:0 k.u.. l:250 
[  631.072729] Dumping ftrace buffer:
[  631.073256]    (ftrace buffer empty)
[  646.377463] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1342563 ni: 23827 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  646.382090] rcu-torture: Reader Pipe:  1412549601 122018 0 0 0 0 0 0 0 0 0
[  646.383089] rcu-torture: Reader Batch:  1412410077 261542 0 0 0 0 0 0 0 0 0
[  646.389904] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  646.391341] ??? Writer stall state RTWS_EXP_SYNC(4) g156493 f0x0 ->state D cpu 1
[  646.392379] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 44 ->gp_activity 5 ->gp_req_activity 44 ->gp_wake_time 61 ->gp_wake_seq 156481 ->gp_seq 156493 ->gp_seq_needed 156500 ->gp_max 381 ->gp_flags 0x0
[  646.399145] rcu: 	rcu_node 0:16 ->gp_seq 156493 ->gp_seq_needed 156500 ->qsmask 0x2 .... ->n_boosts 0
[  646.404016] rcu: 	rcu_node 0:8 ->gp_seq 156493 ->gp_seq_needed 156500 ->qsmask 0x0 .... ->n_boosts 0
[  646.405247] rcu: 	cpu 1 ->gp_seq_needed 156496
[  646.407698] rcu: 	cpu 2 ->gp_seq_needed 156496
[  646.408375] rcu: 	cpu 8 ->gp_seq_needed 156500
[  646.408893] rcu: 	rcu_node 9:16 ->gp_seq 156493 ->gp_seq_needed 156500 ->qsmask 0x1 .... ->n_boosts 0
[  646.412869] rcu: 	cpu 9 ->gp_seq_needed 156500
[  646.414653] rcu: 	cpu 10 ->gp_seq_needed 156500
[  646.415776] rcu: 	cpu 11 ->gp_seq_needed 156500
[  646.418539] rcu: 	cpu 12 ->gp_seq_needed 156500
[  646.419262] rcu: 	cpu 13 ->gp_seq_needed 156500
[  646.419847] rcu: 	cpu 14 ->gp_seq_needed 156500
[  646.421053] rcu: 	cpu 15 ->gp_seq_needed 156500
[  646.423872] rcu: 	cpu 16 ->gp_seq_needed 156500
[  646.424571] rcu: nocb GP 0 Kldts .[W.] .G:156496/169040 rnp 0:8 34645 S CPU 12
[  646.426425] rcu:    CB 0^0->2 KblSW F79 L79 C0 ...N1. q1 S CPU 8
[  646.428177] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W8(156496/169040).N33. q41 S CPU 1
[  646.429285] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  646.430228] rcu:    CB 4^4->7 KblSW F71259 L71268 C119 ..... q0 S CPU 2
[  646.431248] rcu:    CB 5^4->4 KblSW F36409 L36409 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  646.432424] rcu:    CB 7^4->-1 KblSW F52728 L52734 C16 ..... q0 S CPU 13
[  646.433471] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[  646.434379] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  646.435288] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  646.436251] rcu: RCU callbacks invoked since boot: 1491911
[  646.437100] rcu_tasks: RTGS_WAIT_CBS(11) since 645863 g:0 i:0 k.u.. l:250 
[  661.737469] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1369827 ni: 24315 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  661.742965] rcu-torture: Reader Pipe:  1441482734 122018 0 0 0 0 0 0 0 0 0
[  661.743934] rcu-torture: Reader Batch:  1441338772 265980 0 0 0 0 0 0 0 0 0
[  661.744879] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  661.746222] ??? Writer stall state RTWS_EXP_SYNC(4) g159341 f0x0 ->state D cpu 1
[  661.747230] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 69 ->gp_activity 3 ->gp_req_activity 69 ->gp_wake_time 69 ->gp_wake_seq 159337 ->gp_seq 159341 ->gp_seq_needed 159340 ->gp_max 381 ->gp_flags 0x0
[  661.750248] rcu: 	rcu_node 0:16 ->gp_seq 159341 ->gp_seq_needed 159340 ->qsmask 0x2 .... ->n_boosts 0
[  661.751583] rcu: 	rcu_node 0:8 ->gp_seq 159341 ->gp_seq_needed 159348 ->qsmask 0x0 .... ->n_boosts 0
[  661.752853] rcu: 	cpu 0 ->gp_seq_needed 159348
[  661.753503] rcu: 	cpu 1 ->gp_seq_needed 159348
[  661.754243] rcu: 	cpu 2 ->gp_seq_needed 159348
[  661.754972] rcu: 	cpu 8 ->gp_seq_needed 159348
[  661.755660] rcu: 	rcu_node 9:16 ->gp_seq 159341 ->gp_seq_needed 159348 ->qsmask 0x2 .... ->n_boosts 0
[  661.756941] rcu: 	cpu 9 ->gp_seq_needed 159348
[  661.757546] rcu: 	cpu 10 ->gp_seq_needed 159348
[  661.758151] rcu: 	cpu 11 ->gp_seq_needed 159348
[  661.758831] rcu: 	cpu 12 ->gp_seq_needed 159348
[  661.759523] rcu: 	cpu 13 ->gp_seq_needed 159344
[  661.760253] rcu: 	cpu 14 ->gp_seq_needed 159348
[  661.760976] rcu: 	cpu 15 ->gp_seq_needed 159348
[  661.761730] rcu: 	cpu 16 ->gp_seq_needed 159348
[  661.762428] rcu: nocb GP 0 KldtS .[.W] .G:159348/169040 rnp 0:8 35017 S CPU 0
[  661.763389] rcu:    CB 0^0->2 KblSW F85 L85 C0 .W3(159348/169040)... q3 S CPU 8
[  661.764366] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W122(159348/169040).N33. q155 S CPU 1
[  661.765421] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  661.766175] rcu:    CB 4^4->7 KblSW F86595 L86604 C119 ..... q0 S CPU 2
[  661.767132] rcu:    CB 5^4->4 KblSW F51745 L51745 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  661.768556] rcu:    CB 7^4->-1 KblSW F68065 L68071 C16 ..... q0 S CPU 13
[  661.769426] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[  661.770123] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  661.770809] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  661.771588] rcu: RCU callbacks invoked since boot: 1518934
[  661.772205] rcu_tasks: RTGS_WAIT_CBS(11) since 661198 g:0 i:0 k.u.. l:250 
[  677.101454] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1408850 ni: 25003 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  677.108180] rcu-torture: Reader Pipe:  1481591068 122018 0 0 0 0 0 0 0 0 0
[  677.109247] rcu-torture: Reader Batch:  1481442581 270505 0 0 0 0 0 0 0 0 0
[  677.112763] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  677.114335] ??? Writer stall state RTWS_EXP_SYNC(4) g162329 f0x0 ->state D cpu 1
[  677.117051] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 212 ->gp_activity 3 ->gp_req_activity 212 ->gp_wake_time 224 ->gp_wake_seq 162325 ->gp_seq 162329 ->gp_seq_needed 162332 ->gp_max 381 ->gp_flags 0x0
[  677.121812] rcu: 	rcu_node 0:16 ->gp_seq 162329 ->gp_seq_needed 162332 ->qsmask 0x1 .... ->n_boosts 0
[  677.123191] rcu: 	rcu_node 0:8 ->gp_seq 162329 ->gp_seq_needed 162332 ->qsmask 0x100 .... ->n_boosts 0
[  677.124586] rcu: 	cpu 0 ->gp_seq_needed 162332
[  677.125270] rcu: 	cpu 1 ->gp_seq_needed 162332
[  677.125933] rcu: 	cpu 2 ->gp_seq_needed 162332
[  677.126589] rcu: 	cpu 8 ->gp_seq_needed 162332
[  677.127109] rcu: 	rcu_node 9:16 ->gp_seq 162329 ->gp_seq_needed 162336 ->qsmask 0x0 .... ->n_boosts 0
[  677.128532] rcu: 	cpu 9 ->gp_seq_needed 162336
[  677.129215] rcu: 	cpu 10 ->gp_seq_needed 162336
[  677.129985] rcu: 	cpu 11 ->gp_seq_needed 162336
[  677.130672] rcu: 	cpu 12 ->gp_seq_needed 162332
[  677.131352] rcu: 	cpu 13 ->gp_seq_needed 162332
[  677.132062] rcu: 	cpu 14 ->gp_seq_needed 162336
[  677.132746] rcu: 	cpu 15 ->gp_seq_needed 162336
[  677.133455] rcu: 	cpu 16 ->gp_seq_needed 162336
[  677.134132] rcu: nocb GP 0 KldtS .[.W] .G:162332/169040 rnp 0:8 35404 S CPU 0
[  677.135267] rcu:    CB 0^0->2 KblSW F328 L328 C0 .W1(162332/169040)... q1 S CPU 12
[  677.136410] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W134(162332/169040).N106. q240 S CPU 9
[  677.137593] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  677.138574] rcu:    CB 4^4->7 KblSW F101968 L101977 C119 ..... q0 S CPU 2
[  677.139626] rcu:    CB 5^4->4 KblSW F67118 L67118 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  677.141002] rcu:    CB 7^4->-1 KblSW F83437 L83443 C16 ..... q0 S CPU 13
[  677.142012] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[  677.142950] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  677.143934] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  677.144910] rcu: RCU callbacks invoked since boot: 1558227
[  677.145762] rcu_tasks: RTGS_WAIT_CBS(11) since 676572 g:0 i:0 k.u.. l:250 
[  692.457463] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1435868 ni: 25482 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  692.461572] rcu-torture: Reader Pipe:  1510200477 122018 0 0 0 0 0 0 0 0 0
[  692.462590] rcu-torture: Reader Batch:  1510047998 274497 0 0 0 0 0 0 0 0 0
[  692.463592] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  692.465026] ??? Writer stall state RTWS_EXP_SYNC(4) g164917 f0x0 ->state D cpu 1
[  692.466160] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 292 ->gp_activity 1 ->gp_req_activity 292 ->gp_wake_time 296 ->gp_wake_seq 164909 ->gp_seq 164917 ->gp_seq_needed 164924 ->gp_max 381 ->gp_flags 0x0
[  692.469467] rcu: 	rcu_node 0:16 ->gp_seq 164917 ->gp_seq_needed 164924 ->qsmask 0x2 .... ->n_boosts 0
[  692.470834] rcu: 	rcu_node 0:8 ->gp_seq 164917 ->gp_seq_needed 164924 ->qsmask 0x0 .... ->n_boosts 0
[  692.472143] rcu: 	cpu 0 ->gp_seq_needed 164924
[  692.472837] rcu: 	cpu 1 ->gp_seq_needed 164924
[  692.473476] rcu: 	cpu 2 ->gp_seq_needed 164920
[  692.474151] rcu: 	cpu 8 ->gp_seq_needed 164924
[  692.474699] rcu: 	rcu_node 9:16 ->gp_seq 164917 ->gp_seq_needed 164924 ->qsmask 0x4 .... ->n_boosts 0
[  692.476043] rcu: 	cpu 9 ->gp_seq_needed 164924
[  692.476737] rcu: 	cpu 10 ->gp_seq_needed 164924
[  692.477396] rcu: 	cpu 11 ->gp_seq_needed 164924
[  692.478068] rcu: 	cpu 12 ->gp_seq_needed 164924
[  692.478745] rcu: 	cpu 13 ->gp_seq_needed 164924
[  692.479449] rcu: 	cpu 14 ->gp_seq_needed 164924
[  692.480105] rcu: 	cpu 15 ->gp_seq_needed 164924
[  692.480807] rcu: 	cpu 16 ->gp_seq_needed 164924
[  692.481511] rcu: nocb GP 0 KldtS .[W.] .G:164920/169040 rnp 0:8 35740 S CPU 0
[  692.482639] rcu:    CB 0^0->2 KblSW F844 L844 C0 ..... q0 S CPU 8
[  692.483597] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W130(164924/169040).N1. q131 S CPU 1
[  692.484739] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  692.485624] rcu:    CB 4^4->7 KblSW F117315 L117324 C119 ..... q0 S CPU 2
[  692.486568] rcu:    CB 5^4->4 KblSW F82465 L82465 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  692.487937] rcu:    CB 7^4->-1 KblSW F98784 L98790 C16 ..... q0 S CPU 13
[  692.488936] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[  692.489840] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  692.490776] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  692.491742] rcu: RCU callbacks invoked since boot: 1586400
[  692.492560] rcu_tasks: RTGS_WAIT_CBS(11) since 691919 g:0 i:0 k.u.. l:250 
[  707.817542] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1464200 ni: 25986 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  707.820437] rcu-torture: Reader Pipe:  1540428477 122018 0 0 0 0 0 0 0 0 0
[  707.821185] rcu-torture: Reader Batch:  1540272337 278158 0 0 0 0 0 0 0 0 0
[  707.821958] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  707.823035] ??? Writer stall state RTWS_EXP_SYNC(4) g167300 f0x0 ->state D cpu 1
[  707.823826] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 3899 ->gp_activity 3895 ->gp_req_activity 3899 ->gp_wake_time 3911 ->gp_wake_seq 167293 ->gp_seq 167300 ->gp_seq_needed 167300 ->gp_max 381 ->gp_flags 0x0
[  707.826232] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 36050 S CPU 0
[  707.826927] rcu:    CB 0^0->2 KblSW F4227 L4227 C0 ..... q0 S CPU 8
[  707.827603] rcu:    CB 2^0->-1 KblSW F4181 L4181 C0 ..... q0 S CPU 1
[  707.828276] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  707.828976] rcu:    CB 4^4->7 KblSW F132658 L132667 C119 ..... q0 S CPU 2
[  707.829708] rcu:    CB 5^4->4 KblSW F97808 L97808 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  707.830659] rcu:    CB 7^4->-1 KblSW F114127 L114133 C16 ..... q0 S CPU 13
[  707.831392] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[  707.832042] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  707.832716] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  707.833385] rcu: RCU callbacks invoked since boot: 1615893
[  707.833971] rcu_tasks: RTGS_WAIT_CBS(11) since 707260 g:0 i:0 k.u.. l:250 
[  723.177462] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1500981 ni: 26645 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  723.181572] rcu-torture: Reader Pipe:  1580012022 122018 0 0 0 0 0 0 0 0 0
[  723.182550] rcu-torture: Reader Batch:  1579850859 283181 0 0 0 0 0 0 0 0 0
[  723.183545] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  723.184944] ??? Writer stall state RTWS_EXP_SYNC(4) g170521 f0x0 ->state D cpu 1
[  723.185934] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 5 ->gp_activity 1 ->gp_req_activity 5 ->gp_wake_time 6 ->gp_wake_seq 170517 ->gp_seq 170521 ->gp_seq_needed 170520 ->gp_max 381 ->gp_flags 0x0
[  723.188606] rcu: 	rcu_node 0:16 ->gp_seq 170525 ->gp_seq_needed 170524 ->qsmask 0x3 .... ->n_boosts 0
[  723.189739] rcu: 	rcu_node 0:8 ->gp_seq 170525 ->gp_seq_needed 170528 ->qsmask 0x107 .... ->n_boosts 0
[  723.190880] rcu: 	cpu 0 ->gp_seq_needed 170528
[  723.191441] rcu: 	cpu 1 ->gp_seq_needed 170528
[  723.191988] rcu: 	cpu 2 ->gp_seq_needed 170528
[  723.192558] rcu: 	cpu 8 ->gp_seq_needed 170528
[  723.193105] rcu: 	rcu_node 9:16 ->gp_seq 170525 ->gp_seq_needed 170532 ->qsmask 0x0 .... ->n_boosts 0
[  723.194238] rcu: 	cpu 9 ->gp_seq_needed 170532
[  723.194796] rcu: 	cpu 10 ->gp_seq_needed 170532
[  723.195361] rcu: 	cpu 11 ->gp_seq_needed 170532
[  723.195920] rcu: 	cpu 12 ->gp_seq_needed 170532
[  723.196491] rcu: 	cpu 13 ->gp_seq_needed 170532
[  723.197046] rcu: 	cpu 14 ->gp_seq_needed 170532
[  723.197617] rcu: 	cpu 15 ->gp_seq_needed 170532
[  723.198172] rcu: 	cpu 16 ->gp_seq_needed 170528
[  723.198742] rcu: nocb GP 0 KldtS .[W.] .G:170528/169040 rnp 0:8 36468 S CPU 1
[  723.199630] rcu:    CB 0^0->2 KblSW F217 L217 C0 ..... q0 S CPU 8
[  723.200384] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W6(170528/169040).N7. q13 S CPU 8
[  723.201291] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  723.202103] rcu:    CB 4^4->7 KblSW F148031 L148040 C119 ..... q0 S CPU 2
[  723.202948] rcu:    CB 5^4->4 KblSW F113181 L113181 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  723.204072] rcu:    CB 7^4->-1 KblSW F129500 L129506 C16 ..... q0 S CPU 13
[  723.204921] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[  723.205680] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  723.206464] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  723.207231] rcu: RCU callbacks invoked since boot: 1653321
[  723.207943] rcu_tasks: RTGS_WAIT_CBS(11) since 722634 g:0 i:0 k.u.. l:250 
[  738.538732] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1528198 ni: 27131 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  738.543620] rcu-torture: Reader Pipe:  1609152716 122018 0 0 0 0 0 0 0 0 0
[  738.544671] rcu-torture: Reader Batch:  1608986790 287944 0 0 0 0 0 0 0 0 0
[  738.548228] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  738.551868] ??? Writer stall state RTWS_EXP_SYNC(4) g173573 f0x0 ->state D cpu 1
[  738.553770] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 18 ->gp_activity 3 ->gp_req_activity 18 ->gp_wake_time 18 ->gp_wake_seq 173569 ->gp_seq 173573 ->gp_seq_needed 173572 ->gp_max 381 ->gp_flags 0x0
[  738.560017] rcu: 	rcu_node 0:16 ->gp_seq 173573 ->gp_seq_needed 173572 ->qsmask 0x1 .... ->n_boosts 0
[  738.561600] rcu: 	rcu_node 0:8 ->gp_seq 173573 ->gp_seq_needed 173580 ->qsmask 0x1 .... ->n_boosts 0
[  738.562997] rcu: 	cpu 0 ->gp_seq_needed 173580
[  738.563699] rcu: 	cpu 1 ->gp_seq_needed 173580
[  738.564403] rcu: 	cpu 2 ->gp_seq_needed 173580
[  738.564889] rcu: 	rcu_node 9:16 ->gp_seq 173573 ->gp_seq_needed 173580 ->qsmask 0x0 .... ->n_boosts 0
[  738.566308] rcu: 	cpu 9 ->gp_seq_needed 173580
[  738.566995] rcu: 	cpu 10 ->gp_seq_needed 173580
[  738.567690] rcu: 	cpu 11 ->gp_seq_needed 173580
[  738.568410] rcu: 	cpu 12 ->gp_seq_needed 173580
[  738.569333] rcu: 	cpu 13 ->gp_seq_needed 173580
[  738.569988] rcu: 	cpu 14 ->gp_seq_needed 173580
[  738.570670] rcu: 	cpu 15 ->gp_seq_needed 173580
[  738.571371] rcu: 	cpu 16 ->gp_seq_needed 173576
[  738.572043] rcu: nocb GP 0 KldtS .[.W] .G:173580/169040 rnp 0:8 36864 S CPU 1
[  738.573109] rcu:    CB 0^0->2 KblSW F527 L527 C0 ..... q0 S CPU 8
[  738.574047] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W5(173580/169040).N16. q21 S CPU 13
[  738.575176] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  738.575989] rcu:    CB 4^4->7 KblSW F163405 L163414 C119 ..... q0 S CPU 2
[  738.577790] rcu:    CB 5^4->4 KblSW F128555 L128555 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  738.581144] rcu:    CB 7^4->-1 KblSW F144876 L144882 C16 ..... q0 S CPU 13
[  738.582158] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[  738.584231] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  738.585205] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  738.586900] rcu: RCU callbacks invoked since boot: 1680994
[  738.588323] rcu_tasks: RTGS_WAIT_CBS(11) since 738014 g:0 i:0 k.u.. l:250 
[  753.897651] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1568141 ni: 27840 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  753.903677] rcu-torture: Reader Pipe:  1652293975 122018 0 0 0 0 0 0 0 0 0
[  753.904907] rcu-torture: Reader Batch:  1652121798 294195 0 0 0 0 0 0 0 0 0
[  753.906090] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  753.907785] ??? Writer stall state RTWS_EXP_SYNC(4) g177557 f0x0 ->state D cpu 1
[  753.908965] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 14 ->gp_activity 1 ->gp_req_activity 14 ->gp_wake_time 26 ->gp_wake_seq 177553 ->gp_seq 177557 ->gp_seq_needed 177560 ->gp_max 381 ->gp_flags 0x0
[  753.912573] rcu: 	rcu_node 0:16 ->gp_seq 177557 ->gp_seq_needed 177560 ->qsmask 0x1 .... ->n_boosts 0
[  753.914074] rcu: 	rcu_node 0:8 ->gp_seq 177557 ->gp_seq_needed 177564 ->qsmask 0x1 .... ->n_boosts 0
[  753.915453] rcu: 	cpu 0 ->gp_seq_needed 177564
[  753.916068] rcu: 	cpu 1 ->gp_seq_needed 177560
[  753.916808] rcu: 	cpu 8 ->gp_seq_needed 177564
[  753.917518] rcu: 	rcu_node 9:16 ->gp_seq 177557 ->gp_seq_needed 177564 ->qsmask 0x0 .... ->n_boosts 0
[  753.918915] rcu: 	cpu 9 ->gp_seq_needed 177564
[  753.920378] rcu: 	cpu 10 ->gp_seq_needed 177564
[  753.921083] rcu: 	cpu 11 ->gp_seq_needed 177564
[  753.921733] rcu: 	cpu 12 ->gp_seq_needed 177564
[  753.922468] rcu: 	cpu 14 ->gp_seq_needed 177564
[  753.923182] rcu: 	cpu 15 ->gp_seq_needed 177564
[  753.924669] rcu: 	cpu 16 ->gp_seq_needed 177560
[  753.925288] rcu: nocb GP 0 KldtS .[W.] .G:177560/169040 rnp 0:8 37122 S CPU 1
[  753.926246] rcu:    CB 0^0->2 KblSW F769 L769 C0 ..... q0 S CPU 2
[  753.927060] rcu:    CB 2^0->-1 KblSW F61 L61 C0 .W1(177560/169040)... q1 S CPU 13
[  753.928062] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  753.928942] rcu:    CB 4^4->7 KblSW F178758 L178767 C119 ..... q0 S CPU 2
[  753.929852] rcu:    CB 5^4->4 KblSW F143908 L143908 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  753.931065] rcu:    CB 7^4->-1 KblSW F160227 L160233 C16 ..... q0 S CPU 13
[  753.931983] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[  753.932804] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  753.933647] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  753.934489] rcu: RCU callbacks invoked since boot: 1721563
[  753.935278] rcu_tasks: RTGS_WAIT_CBS(11) since 753361 g:0 i:0 k.u.. l:250 
[  769.257472] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1594525 ni: 28314 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  769.265368] rcu-torture: Reader Pipe:  1680849903 122018 0 0 0 0 0 0 0 0 0
[  769.266426] rcu-torture: Reader Batch:  1680674026 297894 0 0 0 0 0 0 0 0 0
[  769.267523] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  769.269007] ??? Writer stall state RTWS_EXP_SYNC(4) g179945 f0x0 ->state D cpu 1
[  769.270059] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 9 ->gp_activity 1 ->gp_req_activity 9 ->gp_wake_time 11 ->gp_wake_seq 179941 ->gp_seq 179945 ->gp_seq_needed 179944 ->gp_max 381 ->gp_flags 0x0
[  769.273227] rcu: 	rcu_node 0:16 ->gp_seq 179945 ->gp_seq_needed 179944 ->qsmask 0x1 .... ->n_boosts 0
[  769.274611] rcu: 	rcu_node 0:8 ->gp_seq 179945 ->gp_seq_needed 179952 ->qsmask 0x1 .... ->n_boosts 0
[  769.275821] rcu: 	cpu 0 ->gp_seq_needed 179952
[  769.276509] rcu: 	cpu 1 ->gp_seq_needed 179952
[  769.277163] rcu: 	cpu 8 ->gp_seq_needed 179952
[  769.277839] rcu: 	rcu_node 9:16 ->gp_seq 179945 ->gp_seq_needed 179952 ->qsmask 0x0 .... ->n_boosts 0
[  769.279218] rcu: 	cpu 9 ->gp_seq_needed 179952
[  769.279880] rcu: 	cpu 10 ->gp_seq_needed 179952
[  769.280553] rcu: 	cpu 11 ->gp_seq_needed 179952
[  769.281240] rcu: 	cpu 12 ->gp_seq_needed 179952
[  769.281907] rcu: 	cpu 13 ->gp_seq_needed 179952
[  769.282580] rcu: 	cpu 14 ->gp_seq_needed 179952
[  769.283272] rcu: 	cpu 16 ->gp_seq_needed 179948
[  769.283953] rcu: nocb GP 0 Kldts .[..] ..:-1/-1 rnp 0:8 37205 R CPU 1
[  769.284876] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W1(179952/169040)... q1 S CPU 2
[  769.285934] rcu:    CB 2^0->-1 KblSW F103 L103 C0 ..... q0 S CPU 2
[  769.286688] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  769.287653] rcu:    CB 4^4->7 KblSW F194116 L194125 C119 ..... q0 S CPU 2
[  769.288701] rcu:    CB 5^4->4 KblSW F159267 L159267 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  769.290057] rcu:    CB 7^4->-1 KblSW F175586 L175592 C16 ..... q0 S CPU 13
[  769.291100] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[  769.291964] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  769.292919] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  769.293879] rcu: RCU callbacks invoked since boot: 1748536
[  769.294722] rcu_tasks: RTGS_WAIT_CBS(11) since 768721 g:0 i:0 k.u.. l:250 
[  784.617534] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1626995 ni: 28886 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  784.620579] rcu-torture: Reader Pipe:  1715627451 122018 0 0 0 0 0 0 0 0 0
[  784.621319] rcu-torture: Reader Batch:  1715446887 302582 0 0 0 0 0 0 0 0 0
[  784.622065] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  784.623147] ??? Writer stall state RTWS_EXP_SYNC(4) g182944 f0x0 ->state D cpu 1
[  784.623930] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 2744 ->gp_activity 2740 ->gp_req_activity 2744 ->gp_wake_time 2744 ->gp_wake_seq 182937 ->gp_seq 182944 ->gp_seq_needed 182944 ->gp_max 381 ->gp_flags 0x0
[  784.626337] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 37306 S CPU 1
[  784.627024] rcu:    CB 0^0->2 KblSW F3343 L3343 C0 ..... q0 S CPU 2
[  784.627701] rcu:    CB 2^0->-1 KblSW F3486 L3486 C0 ..... q0 S CPU 2
[  784.628377] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  784.629069] rcu:    CB 4^4->7 KblSW F209458 L209467 C119 ..... q0 S CPU 2
[  784.629797] rcu:    CB 5^4->4 KblSW F174608 L174608 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  784.630765] rcu:    CB 7^4->-1 KblSW F190927 L190933 C16 ..... q0 S CPU 13
[  784.631503] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[  784.632156] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  784.632822] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  784.633495] rcu: RCU callbacks invoked since boot: 1781599
[  784.634078] rcu_tasks: RTGS_WAIT_CBS(11) since 784060 g:0 i:0 k.u.. l:250 
[  799.977474] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1661275 ni: 29500 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  799.981992] rcu-torture: Reader Pipe:  1752202476 122018 0 0 0 0 0 0 0 0 0
[  799.983190] rcu-torture: Reader Batch:  1752017006 307488 0 0 0 0 0 0 0 0 0
[  799.984444] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  799.985960] ??? Writer stall state RTWS_EXP_SYNC(4) g186085 f0x0 ->state D cpu 1
[  799.987124] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 26 ->gp_activity 1 ->gp_req_activity 26 ->gp_wake_time 26 ->gp_wake_seq 186081 ->gp_seq 186085 ->gp_seq_needed 186092 ->gp_max 381 ->gp_flags 0x0
[  799.990409] rcu: 	rcu_node 0:16 ->gp_seq 186085 ->gp_seq_needed 186092 ->qsmask 0x1 .... ->n_boosts 0
[  799.991737] rcu: 	rcu_node 0:8 ->gp_seq 186085 ->gp_seq_needed 186092 ->qsmask 0x1 .... ->n_boosts 0
[  799.993016] rcu: 	cpu 0 ->gp_seq_needed 186092
[  799.993664] rcu: 	cpu 1 ->gp_seq_needed 186092
[  799.994266] rcu: 	cpu 2 ->gp_seq_needed 186092
[  799.994865] rcu: 	rcu_node 9:16 ->gp_seq 186085 ->gp_seq_needed 186092 ->qsmask 0x0 .... ->n_boosts 0
[  799.996090] rcu: 	cpu 9 ->gp_seq_needed 186092
[  799.996744] rcu: 	cpu 10 ->gp_seq_needed 186092
[  799.997417] rcu: 	cpu 11 ->gp_seq_needed 186092
[  799.998154] rcu: 	cpu 12 ->gp_seq_needed 186092
[  799.998864] rcu: 	cpu 13 ->gp_seq_needed 186092
[  799.999539] rcu: 	cpu 14 ->gp_seq_needed 186092
[  800.000104] rcu: 	cpu 15 ->gp_seq_needed 186092
[  800.000800] rcu: 	cpu 16 ->gp_seq_needed 186092
[  800.001441] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 37441 S CPU 0
[  800.002386] rcu:    CB 0^0->2 KblSW F159 L159 C0 ..... q0 S CPU 2
[  800.003318] rcu:    CB 2^0->-1 KblSW F52 L52 C0 ..... q0 S CPU 2
[  800.004240] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  800.005229] rcu:    CB 4^4->7 KblSW F224834 L224843 C119 ..... q0 S CPU 2
[  800.006184] rcu:    CB 5^4->4 KblSW F189984 L189984 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  800.007511] rcu:    CB 7^4->-1 KblSW F206304 L206310 C16 ..... q0 S CPU 13
[  800.008544] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[  800.009488] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  800.010445] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  800.011186] rcu: RCU callbacks invoked since boot: 1816408
[  800.012020] rcu_tasks: RTGS_WAIT_CBS(11) since 799438 g:0 i:0 k.u.. l:250 
[  815.337464] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1688229 ni: 29975 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  815.344308] rcu-torture: Reader Pipe:  1781091433 122018 0 0 0 0 0 0 0 0 0
[  815.345384] rcu-torture: Reader Batch:  1780902325 311126 0 0 0 0 0 0 0 0 0
[  815.348362] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  815.349879] ??? Writer stall state RTWS_EXP_SYNC(4) g188385 f0x0 ->state D cpu 1
[  815.352937] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 35 ->gp_activity 2 ->gp_req_activity 35 ->gp_wake_time 35 ->gp_wake_seq 188381 ->gp_seq 188385 ->gp_seq_needed 188384 ->gp_max 381 ->gp_flags 0x0
[  815.360419] rcu: 	rcu_node 0:16 ->gp_seq 188385 ->gp_seq_needed 188384 ->qsmask 0x2 .... ->n_boosts 0
[  815.361792] rcu: 	rcu_node 0:8 ->gp_seq 188385 ->gp_seq_needed 188392 ->qsmask 0x0 .... ->n_boosts 0
[  815.364944] rcu: 	cpu 0 ->gp_seq_needed 188392
[  815.368405] rcu: 	cpu 1 ->gp_seq_needed 188392
[  815.368913] rcu: 	cpu 2 ->gp_seq_needed 188392
[  815.369558] rcu: 	cpu 8 ->gp_seq_needed 188392
[  815.370215] rcu: 	rcu_node 9:16 ->gp_seq 188385 ->gp_seq_needed 188392 ->qsmask 0x20 .... ->n_boosts 0
[  815.371628] rcu: 	cpu 9 ->gp_seq_needed 188392
[  815.372301] rcu: 	cpu 10 ->gp_seq_needed 188392
[  815.372976] rcu: 	cpu 11 ->gp_seq_needed 188392
[  815.373685] rcu: 	cpu 12 ->gp_seq_needed 188392
[  815.374402] rcu: 	cpu 13 ->gp_seq_needed 188392
[  815.375091] rcu: 	cpu 14 ->gp_seq_needed 188392
[  815.375763] rcu: 	cpu 15 ->gp_seq_needed 188392
[  815.376458] rcu: 	cpu 16 ->gp_seq_needed 188388
[  815.377156] rcu: nocb GP 0 Kldts .[W.] .G:188392/169040 rnp 0:8 37534 S CPU 1
[  815.378253] rcu:    CB 0^0->2 KblSW F33 L33 C0 .W1(188392/169040)... q1 S CPU 2
[  815.379362] rcu:    CB 2^0->-1 KblSW F2 L2 C0 ...N12. q12 S CPU 8
[  815.380124] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  815.381118] rcu:    CB 4^4->7 KblSW F240210 L240219 C119 ..... q0 S CPU 2
[  815.382137] rcu:    CB 5^4->4 KblSW F205360 L205360 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  815.383473] rcu:    CB 7^4->-1 KblSW F221680 L221686 C16 ..... q0 S CPU 13
[  815.384506] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[  815.385459] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  815.386478] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  815.387454] rcu: RCU callbacks invoked since boot: 1843836
[  815.388306] rcu_tasks: RTGS_WAIT_CBS(11) since 814814 g:0 i:0 k.u.. l:250 
[  830.697487] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1727893 ni: 30678 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  830.704958] rcu-torture: Reader Pipe:  1823182611 122018 0 0 0 0 0 0 0 0 0
[  830.706902] rcu-torture: Reader Batch:  1822988239 316390 0 0 0 0 0 0 0 0 0
[  830.708634] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  830.711612] ??? Writer stall state RTWS_EXP_SYNC(4) g191789 f0x0 ->state D cpu 1
[  830.713682] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 237 ->gp_activity 3 ->gp_req_activity 237 ->gp_wake_time 237 ->gp_wake_seq 191785 ->gp_seq 191789 ->gp_seq_needed 191788 ->gp_max 381 ->gp_flags 0x0
[  830.719721] rcu: 	rcu_node 0:16 ->gp_seq 191789 ->gp_seq_needed 191788 ->qsmask 0x2 .... ->n_boosts 0
[  830.722790] rcu: 	rcu_node 0:8 ->gp_seq 191789 ->gp_seq_needed 191796 ->qsmask 0x0 .... ->n_boosts 0
[  830.724004] rcu: 	cpu 0 ->gp_seq_needed 191796
[  830.724632] rcu: 	cpu 1 ->gp_seq_needed 191796
[  830.725896] rcu: 	cpu 2 ->gp_seq_needed 191796
[  830.726574] rcu: 	cpu 8 ->gp_seq_needed 191796
[  830.727266] rcu: 	rcu_node 9:16 ->gp_seq 191789 ->gp_seq_needed 191796 ->qsmask 0x0 ...G ->n_boosts 0
[  830.731504] rcu: 	cpu 9 ->gp_seq_needed 191796
[  830.732193] rcu: 	cpu 10 ->gp_seq_needed 191796
[  830.732824] rcu: 	cpu 11 ->gp_seq_needed 191796
[  830.733479] rcu: 	cpu 12 ->gp_seq_needed 191796
[  830.734182] rcu: 	cpu 13 ->gp_seq_needed 191796
[  830.734882] rcu: 	cpu 14 ->gp_seq_needed 191796
[  830.735593] rcu: 	cpu 15 ->gp_seq_needed 191796
[  830.736293] rcu: 	cpu 16 ->gp_seq_needed 191792
[  830.736999] rcu: nocb GP 0 KldtS .[.W] .G:191796/169040 rnp 0:8 37975 S CPU 1
[  830.738076] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W6(191796/169040).N108. q114 S CPU 8
[  830.739019] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W6(191796/169040).N106. q112 S CPU 9
[  830.740202] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  830.741155] rcu:    CB 4^4->7 KblSW F255570 L255579 C119 ..... q0 S CPU 2
[  830.742178] rcu:    CB 5^4->4 KblSW F220720 L220720 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  830.743581] rcu:    CB 7^4->-1 KblSW F237040 L237046 C16 ..... q0 S CPU 13
[  830.744613] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[  830.745531] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  830.746474] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  830.747446] rcu: RCU callbacks invoked since boot: 1883689
[  830.748264] rcu_tasks: RTGS_WAIT_CBS(11) since 830174 g:0 i:0 k.u.. l:250 
[  846.057658] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1755293 ni: 31165 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  846.061802] rcu-torture: Reader Pipe:  1852687132 122018 0 0 0 0 0 0 0 0 0
[  846.063015] rcu-torture: Reader Batch:  1852488217 320933 0 0 0 0 0 0 0 0 0
[  846.064177] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  846.065742] ??? Writer stall state RTWS_EXP_SYNC(4) g194737 f0x0 ->state D cpu 1
[  846.066835] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 136 ->gp_activity 2 ->gp_req_activity 136 ->gp_wake_time 136 ->gp_wake_seq 194733 ->gp_seq 194737 ->gp_seq_needed 194736 ->gp_max 381 ->gp_flags 0x0
[  846.070360] rcu: 	rcu_node 0:16 ->gp_seq 194737 ->gp_seq_needed 194736 ->qsmask 0x2 .... ->n_boosts 0
[  846.071882] rcu: 	rcu_node 0:8 ->gp_seq 194737 ->gp_seq_needed 194740 ->qsmask 0x0 .... ->n_boosts 0
[  846.073344] rcu: 	cpu 0 ->gp_seq_needed 194740
[  846.074028] rcu: 	cpu 1 ->gp_seq_needed 194740
[  846.074683] rcu: 	cpu 2 ->gp_seq_needed 194740
[  846.075336] rcu: 	cpu 8 ->gp_seq_needed 194740
[  846.076034] rcu: 	rcu_node 9:16 ->gp_seq 194737 ->gp_seq_needed 194744 ->qsmask 0x0 ...G ->n_boosts 0
[  846.077265] rcu: 	cpu 9 ->gp_seq_needed 194740
[  846.077993] rcu: 	cpu 10 ->gp_seq_needed 194744
[  846.078694] rcu: 	cpu 11 ->gp_seq_needed 194744
[  846.079418] rcu: 	cpu 12 ->gp_seq_needed 194744
[  846.080099] rcu: 	cpu 13 ->gp_seq_needed 194744
[  846.080773] rcu: 	cpu 14 ->gp_seq_needed 194744
[  846.081480] rcu: 	cpu 15 ->gp_seq_needed 194744
[  846.082164] rcu: 	cpu 16 ->gp_seq_needed 194740
[  846.082906] rcu: nocb GP 0 KldtS .[.W] .G:194740/169040 rnp 0:8 38358 S CPU 1
[  846.083991] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W7(194740/169040).N63. q70 S CPU 9
[  846.086603] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W6(194740/169040).N70. q76 S CPU 10
[  846.087688] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  846.088601] rcu:    CB 4^4->7 KblSW F270918 L270927 C119 ..... q0 S CPU 2
[  846.092937] rcu:    CB 5^4->4 KblSW F236071 L236071 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  846.096191] rcu:    CB 7^4->-1 KblSW F252392 L252398 C16 ..... q0 S CPU 13
[  846.097220] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[  846.098051] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  846.098927] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  846.099766] rcu: RCU callbacks invoked since boot: 1911853
[  846.100512] rcu_tasks: RTGS_WAIT_CBS(11) since 845527 g:0 i:0 k.u.. l:250 
[  861.417534] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1789477 ni: 31770 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  861.420537] rcu-torture: Reader Pipe:  1888692901 122018 0 0 0 0 0 0 0 0 0
[  861.421275] rcu-torture: Reader Batch:  1888489937 324982 0 0 0 0 0 0 0 0 0
[  861.422018] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  861.423083] ??? Writer stall state RTWS_EXP_SYNC(4) g197380 f0x0 ->state D cpu 1
[  861.423876] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 1712 ->gp_activity 1708 ->gp_req_activity 1712 ->gp_wake_time 1717 ->gp_wake_seq 197369 ->gp_seq 197380 ->gp_seq_needed 197380 ->gp_max 381 ->gp_flags 0x0
[  861.426262] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 38701 S CPU 8
[  861.426955] rcu:    CB 0^0->2 KblSW F1787 L1787 C0 ..... q0 S CPU 9
[  861.427630] rcu:    CB 2^0->-1 KblSW F2030 L2030 C0 ..... q0 S CPU 10
[  861.428314] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  861.429003] rcu:    CB 4^4->7 KblSW F286258 L286267 C119 ..... q0 S CPU 2
[  861.429723] rcu:    CB 5^4->4 KblSW F251408 L251408 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  861.430687] rcu:    CB 7^4->-1 KblSW F267727 L267733 C16 ..... q0 S CPU 13
[  861.431415] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[  861.432063] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  861.432724] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  861.433387] rcu: RCU callbacks invoked since boot: 1946965
[  861.433973] rcu_tasks: RTGS_WAIT_CBS(11) since 860860 g:0 i:0 k.u.. l:250 
[  876.777460] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1821359 ni: 32335 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  876.781895] rcu-torture: Reader Pipe:  1922451682 122018 0 0 0 0 0 0 0 0 0
[  876.783060] rcu-torture: Reader Batch:  1922243705 329995 0 0 0 0 0 0 0 0 0
[  876.783873] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  876.785331] ??? Writer stall state RTWS_EXP_SYNC(4) g200597 f0x0 ->state D cpu 1
[  876.786202] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 181 ->gp_activity 3 ->gp_req_activity 181 ->gp_wake_time 181 ->gp_wake_seq 200593 ->gp_seq 200597 ->gp_seq_needed 200596 ->gp_max 381 ->gp_flags 0x0
[  876.788922] rcu: 	rcu_node 0:16 ->gp_seq 200597 ->gp_seq_needed 200596 ->qsmask 0x2 .... ->n_boosts 0
[  876.790125] rcu: 	rcu_node 0:8 ->gp_seq 200597 ->gp_seq_needed 200604 ->qsmask 0x0 .... ->n_boosts 0
[  876.791490] rcu: 	cpu 0 ->gp_seq_needed 200604
[  876.792155] rcu: 	cpu 2 ->gp_seq_needed 200604
[  876.792752] rcu: 	cpu 8 ->gp_seq_needed 200604
[  876.793396] rcu: 	rcu_node 9:16 ->gp_seq 200597 ->gp_seq_needed 200604 ->qsmask 0x8 .... ->n_boosts 0
[  876.794737] rcu: 	cpu 9 ->gp_seq_needed 200604
[  876.795415] rcu: 	cpu 10 ->gp_seq_needed 200604
[  876.796083] rcu: 	cpu 11 ->gp_seq_needed 200604
[  876.798000] rcu: 	cpu 12 ->gp_seq_needed 200604
[  876.798748] rcu: 	cpu 13 ->gp_seq_needed 200604
[  876.799391] rcu: 	cpu 14 ->gp_seq_needed 200604
[  876.800114] rcu: 	cpu 15 ->gp_seq_needed 200604
[  876.800795] rcu: 	cpu 16 ->gp_seq_needed 200604
[  876.801503] rcu: nocb GP 0 KldtS .[.W] .G:200604/169040 rnp 0:8 39119 S CPU 9
[  876.802590] rcu:    CB 0^0->2 KblSW F0 L0 C0 .W6(200604/169040).N78. q84 S CPU 10
[  876.803671] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W6(200604/169040).N80. q86 S CPU 15
[  876.804706] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  876.805730] rcu:    CB 4^4->7 KblSW F301635 L301644 C119 ..... q0 S CPU 2
[  876.806799] rcu:    CB 5^4->4 KblSW F266785 L266785 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  876.808189] rcu:    CB 7^4->-1 KblSW F283104 L283110 C16 ..... q0 S CPU 13
[  876.809197] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[  876.810132] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  876.811132] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  876.812102] rcu: RCU callbacks invoked since boot: 1978954
[  876.812979] rcu_tasks: RTGS_WAIT_CBS(11) since 876239 g:0 i:0 k.u.. l:250 
[  892.137461] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1848457 ni: 32820 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  892.141872] rcu-torture: Reader Pipe:  1951600895 122018 0 0 0 0 0 0 0 0 0
[  892.142817] rcu-torture: Reader Batch:  1951388978 333935 0 0 0 0 0 0 0 0 0
[  892.143898] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  892.145456] ??? Writer stall state RTWS_EXP_SYNC(4) g203081 f0x0 ->state D cpu 1
[  892.146647] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 26 ->gp_activity 1 ->gp_req_activity 26 ->gp_wake_time 26 ->gp_wake_seq 203077 ->gp_seq 203081 ->gp_seq_needed 203080 ->gp_max 381 ->gp_flags 0x0
[  892.150461] rcu: 	rcu_node 0:16 ->gp_seq 203081 ->gp_seq_needed 203080 ->qsmask 0x2 .... ->n_boosts 0
[  892.151917] rcu: 	rcu_node 0:8 ->gp_seq 203081 ->gp_seq_needed 203088 ->qsmask 0x0 .... ->n_boosts 0
[  892.153366] rcu: 	cpu 0 ->gp_seq_needed 203088
[  892.153918] rcu: 	cpu 1 ->gp_seq_needed 203088
[  892.154575] rcu: 	cpu 2 ->gp_seq_needed 203088
[  892.155288] rcu: 	rcu_node 9:16 ->gp_seq 203081 ->gp_seq_needed 203088 ->qsmask 0x4 .... ->n_boosts 0
[  892.156713] rcu: 	cpu 9 ->gp_seq_needed 203088
[  892.157356] rcu: 	cpu 10 ->gp_seq_needed 203088
[  892.158011] rcu: 	cpu 11 ->gp_seq_needed 203088
[  892.159486] rcu: 	cpu 12 ->gp_seq_needed 203088
[  892.161640] rcu: 	cpu 13 ->gp_seq_needed 203088
[  892.162313] rcu: 	cpu 14 ->gp_seq_needed 203088
[  892.162990] rcu: 	cpu 15 ->gp_seq_needed 203088
[  892.163684] rcu: 	cpu 16 ->gp_seq_needed 203088
[  892.165035] rcu: nocb GP 0 KldtS .[W.] .G:203088/169040 rnp 0:8 39455 S CPU 9
[  892.166137] rcu:    CB 0^0->2 KblSW F0 L0 C0 .W7(203088/169040).N14. q21 S CPU 10
[  892.167296] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W7(203088/169040).N17. q24 S CPU 15
[  892.168465] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  892.169480] rcu:    CB 4^4->7 KblSW F316999 L317008 C119 ..... q0 S CPU 2
[  892.170557] rcu:    CB 5^4->4 KblSW F282149 L282149 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  892.171956] rcu:    CB 7^4->-1 KblSW F298468 L298474 C16 ..... q0 S CPU 13
[  892.173013] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[  892.173880] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  892.174565] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  892.175246] rcu: RCU callbacks invoked since boot: 2006911
[  892.175983] rcu_tasks: RTGS_WAIT_CBS(11) since 891602 g:0 i:0 k.u.. l:250 
[  907.497459] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1887859 ni: 33520 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  907.502127] rcu-torture: Reader Pipe:  1994044730 122018 0 0 0 0 0 0 0 0 0
[  907.503312] rcu-torture: Reader Batch:  1993827298 339450 0 0 0 0 0 0 0 0 0
[  907.504448] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  907.505806] ??? Writer stall state RTWS_EXP_SYNC(4) g206549 f0x0 ->state D cpu 1
[  907.506914] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 189 ->gp_activity 1 ->gp_req_activity 189 ->gp_wake_time 191 ->gp_wake_seq 206545 ->gp_seq 206549 ->gp_seq_needed 206548 ->gp_max 381 ->gp_flags 0x0
[  907.509946] rcu: 	rcu_node 0:16 ->gp_seq 206549 ->gp_seq_needed 206548 ->qsmask 0x1 .... ->n_boosts 0
[  907.511267] rcu: 	rcu_node 0:8 ->gp_seq 206549 ->gp_seq_needed 206556 ->qsmask 0x0 ...G ->n_boosts 0
[  907.512598] rcu: 	cpu 0 ->gp_seq_needed 206552
[  907.513223] rcu: 	cpu 1 ->gp_seq_needed 206556
[  907.513906] rcu: 	cpu 2 ->gp_seq_needed 206552
[  907.514559] rcu: 	cpu 8 ->gp_seq_needed 206552
[  907.515219] rcu: 	rcu_node 9:16 ->gp_seq 206549 ->gp_seq_needed 206556 ->qsmask 0x0 .... ->n_boosts 0
[  907.516460] rcu: 	cpu 9 ->gp_seq_needed 206552
[  907.517154] rcu: 	cpu 10 ->gp_seq_needed 206556
[  907.517834] rcu: 	cpu 11 ->gp_seq_needed 206556
[  907.518706] rcu: 	cpu 12 ->gp_seq_needed 206556
[  907.519473] rcu: 	cpu 13 ->gp_seq_needed 206556
[  907.520156] rcu: 	cpu 14 ->gp_seq_needed 206556
[  907.520904] rcu: 	cpu 15 ->gp_seq_needed 206556
[  907.523678] rcu: 	cpu 16 ->gp_seq_needed 206556
[  907.524378] rcu: nocb GP 0 KldtS .[W.] .G:206552/169040 rnp 0:8 39909 S CPU 9
[  907.525929] rcu:    CB 0^0->2 KblSW F46 L46 C0 .W10(206552/169040).N3. q13 S CPU 10
[  907.527989] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W8(206552/169040).N77. q85 S CPU 15
[  907.529037] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  907.529998] rcu:    CB 4^4->7 KblSW F332359 L332368 C119 ..... q0 S CPU 2
[  907.533862] rcu:    CB 5^4->4 KblSW F297512 L297512 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  907.535270] rcu:    CB 7^4->-1 KblSW F313831 L313837 C16 ..... q0 S CPU 13
[  907.536323] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[  907.537232] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  907.538076] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  907.538942] rcu: RCU callbacks invoked since boot: 2046597
[  907.539793] rcu_tasks: RTGS_WAIT_CBS(11) since 906966 g:0 i:0 k.u.. l:250 
[  922.857459] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1914323 ni: 33994 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  922.864089] rcu-torture: Reader Pipe:  2022210249 122018 0 0 0 0 0 0 0 0 0
[  922.865121] rcu-torture: Reader Batch:  2021989320 342947 0 0 0 0 0 0 0 0 0
[  922.866186] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  922.867692] ??? Writer stall state RTWS_EXP_SYNC(4) g208885 f0x0 ->state D cpu 1
[  922.868791] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 11 ->gp_activity 3 ->gp_req_activity 11 ->gp_wake_time 14 ->gp_wake_seq 208881 ->gp_seq 208885 ->gp_seq_needed 208884 ->gp_max 381 ->gp_flags 0x0
[  922.872034] rcu: 	rcu_node 0:16 ->gp_seq 208885 ->gp_seq_needed 208884 ->qsmask 0x1 .... ->n_boosts 0
[  922.873425] rcu: 	rcu_node 0:8 ->gp_seq 208885 ->gp_seq_needed 208892 ->qsmask 0x100 .... ->n_boosts 0
[  922.874910] rcu: 	cpu 0 ->gp_seq_needed 208888
[  922.875555] rcu: 	cpu 1 ->gp_seq_needed 208892
[  922.876121] rcu: 	cpu 2 ->gp_seq_needed 208892
[  922.876786] rcu: 	cpu 8 ->gp_seq_needed 208896
[  922.877438] rcu: 	rcu_node 9:16 ->gp_seq 208889 ->gp_seq_needed 208896 ->qsmask 0xb7 .... ->n_boosts 0
[  922.878822] rcu: 	cpu 9 ->gp_seq_needed 208896
[  922.879474] rcu: 	cpu 11 ->gp_seq_needed 208896
[  922.880109] rcu: 	cpu 12 ->gp_seq_needed 208896
[  922.880787] rcu: 	cpu 13 ->gp_seq_needed 208896
[  922.881466] rcu: 	cpu 14 ->gp_seq_needed 208896
[  922.882148] rcu: 	cpu 15 ->gp_seq_needed 208896
[  922.882835] rcu: 	cpu 16 ->gp_seq_needed 208896
[  922.883523] rcu: nocb GP 0 KldtS .[W.] .G:208896/169040 rnp 0:8 40214 S CPU 9
[  922.884630] rcu:    CB 0^0->2 KblSW F211 L211 C0 ..... q0 S CPU 10
[  922.885572] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W12(208896/169040).N5. q17 S CPU 15
[  922.886706] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  922.887729] rcu:    CB 4^4->7 KblSW F347717 L347726 C119 ..... q0 S CPU 2
[  922.888931] rcu:    CB 5^4->4 KblSW F312867 L312867 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  922.890425] rcu:    CB 7^4->-1 KblSW F329186 L329192 C16 ..... q0 S CPU 13
[  922.891499] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[  922.892463] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  922.893411] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  922.894375] rcu: RCU callbacks invoked since boot: 2074038
[  922.895214] rcu_tasks: RTGS_WAIT_CBS(11) since 922321 g:0 i:0 k.u.. l:250 
[  938.217508] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1952967 ni: 34675 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  938.220413] rcu-torture: Reader Pipe:  2063439571 122018 0 0 0 0 0 0 0 0 0
[  938.221164] rcu-torture: Reader Batch:  2063213229 348360 0 0 0 0 0 0 0 0 0
[  938.221920] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  938.223006] ??? Writer stall state RTWS_EXP_SYNC(4) g212444 f0x0 ->state D cpu 1
[  938.223801] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 284 ->gp_activity 279 ->gp_req_activity 284 ->gp_wake_time 279 ->gp_wake_seq 212441 ->gp_seq 212444 ->gp_seq_needed 212444 ->gp_max 381 ->gp_flags 0x0
[  938.226178] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 40675 S CPU 9
[  938.226877] rcu:    CB 0^0->2 KblSW F828 L828 C0 ..... q0 S CPU 10
[  938.227547] rcu:    CB 2^0->-1 KblSW F590 L590 C0 ..... q0 S CPU 15
[  938.228214] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  938.228916] rcu:    CB 4^4->7 KblSW F363058 L363067 C119 ..... q0 S CPU 2
[  938.229649] rcu:    CB 5^4->4 KblSW F328208 L328208 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  938.230628] rcu:    CB 7^4->-1 KblSW F344527 L344533 C16 ..... q0 S CPU 13
[  938.231357] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[  938.232008] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  938.232686] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  938.233350] rcu: RCU callbacks invoked since boot: 2113360
[  938.233943] rcu_tasks: RTGS_WAIT_CBS(11) since 937660 g:0 i:0 k.u.. l:250 
[  953.580513] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1980295 ni: 35163 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  953.584438] rcu-torture: Reader Pipe:  2092385804 122018 0 0 0 0 0 0 0 0 0
[  953.585498] rcu-torture: Reader Batch:  2092156699 351123 0 0 0 0 0 0 0 0 0
[  953.586549] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  953.588030] ??? Writer stall state RTWS_EXP_SYNC(4) g214261 f0x0 ->state D cpu 1
[  953.589150] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 6 ->gp_activity 2 ->gp_req_activity 6 ->gp_wake_time 6 ->gp_wake_seq 214257 ->gp_seq 214261 ->gp_seq_needed 214260 ->gp_max 381 ->gp_flags 0x0
[  953.592375] rcu: 	rcu_node 0:16 ->gp_seq 214265 ->gp_seq_needed 214264 ->qsmask 0x3 .... ->n_boosts 0
[  953.593768] rcu: 	rcu_node 0:8 ->gp_seq 214265 ->gp_seq_needed 214272 ->qsmask 0x100 .... ->n_boosts 0
[  953.595282] rcu: 	cpu 0 ->gp_seq_needed 214268
[  953.595942] rcu: 	cpu 1 ->gp_seq_needed 214272
[  953.596677] rcu: 	cpu 2 ->gp_seq_needed 214268
[  953.597353] rcu: 	cpu 8 ->gp_seq_needed 214268
[  953.598031] rcu: 	rcu_node 9:16 ->gp_seq 214265 ->gp_seq_needed 214272 ->qsmask 0x4 .... ->n_boosts 0
[  953.599516] rcu: 	cpu 9 ->gp_seq_needed 214272
[  953.600192] rcu: 	cpu 10 ->gp_seq_needed 214268
[  953.600878] rcu: 	cpu 11 ->gp_seq_needed 214272
[  953.601546] rcu: 	cpu 12 ->gp_seq_needed 214272
[  953.602235] rcu: 	cpu 13 ->gp_seq_needed 214272
[  953.602884] rcu: 	cpu 14 ->gp_seq_needed 214268
[  953.603579] rcu: 	cpu 15 ->gp_seq_needed 214268
[  953.604214] rcu: 	cpu 16 ->gp_seq_needed 214272
[  953.604917] rcu: nocb GP 0 KldtS .[.W] .G:214268/169040 rnp 0:8 40911 S CPU 10
[  953.606030] rcu:    CB 0^0->2 KblSW F45 L45 C0 ..... q0 S CPU 14
[  953.606950] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W5(214268/169040).N8. q13 S CPU 15
[  953.608138] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  953.609134] rcu:    CB 4^4->7 KblSW F378438 L378447 C119 ..... q0 S CPU 2
[  953.610161] rcu:    CB 5^4->4 KblSW F343588 L343588 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  953.611545] rcu:    CB 7^4->-1 KblSW F359908 L359914 C16 ..... q0 S CPU 13
[  953.612618] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[  953.613539] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  953.614516] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  953.615492] rcu: RCU callbacks invoked since boot: 2141170
[  953.616331] rcu_tasks: RTGS_WAIT_CBS(11) since 953042 g:0 i:0 k.u.. l:250 
[  968.937682] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2006571 ni: 35639 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  968.944816] rcu-torture: Reader Pipe:  2121000409 122018 0 0 0 0 0 0 0 0 0
[  968.945850] rcu-torture: Reader Batch:  2120767564 354863 0 0 0 0 0 0 0 0 0
[  968.946879] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  968.948407] ??? Writer stall state RTWS_EXP_SYNC(4) g216689 f0x0 ->state D cpu 1
[  968.949520] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 4 ->gp_activity 0 ->gp_req_activity 4 ->gp_wake_time 5 ->gp_wake_seq 216685 ->gp_seq 216689 ->gp_seq_needed 216688 ->gp_max 381 ->gp_flags 0x0
[  968.952716] rcu: 	rcu_node 0:16 ->gp_seq 216689 ->gp_seq_needed 216688 ->qsmask 0x3 .... ->n_boosts 0
[  968.954126] rcu: 	rcu_node 0:8 ->gp_seq 216689 ->gp_seq_needed 216696 ->qsmask 0x100 .... ->n_boosts 0
[  968.955517] rcu: 	cpu 0 ->gp_seq_needed 216692
[  968.956186] rcu: 	cpu 1 ->gp_seq_needed 216696
[  968.956881] rcu: 	cpu 2 ->gp_seq_needed 216696
[  968.957534] rcu: 	cpu 8 ->gp_seq_needed 216692
[  968.958200] rcu: 	rcu_node 9:16 ->gp_seq 216689 ->gp_seq_needed 216696 ->qsmask 0x0 .... ->n_boosts 0
[  968.959618] rcu: 	cpu 9 ->gp_seq_needed 216696
[  968.960301] rcu: 	cpu 10 ->gp_seq_needed 216696
[  968.961016] rcu: 	cpu 11 ->gp_seq_needed 216696
[  968.961694] rcu: 	cpu 12 ->gp_seq_needed 216696
[  968.962397] rcu: 	cpu 13 ->gp_seq_needed 216696
[  968.963063] rcu: 	cpu 14 ->gp_seq_needed 216692
[  968.963740] rcu: 	cpu 15 ->gp_seq_needed 216696
[  968.964420] rcu: 	cpu 16 ->gp_seq_needed 216696
[  968.965116] rcu: nocb GP 0 KldtS .[W.] .G:216696/169040 rnp 0:8 41227 S CPU 10
[  968.966331] rcu:    CB 0^0->2 KblSW F48 L48 C0 ..... q0 S CPU 14
[  968.967113] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W5(216696/169040).N8. q13 S CPU 15
[  968.968239] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  968.969258] rcu:    CB 4^4->7 KblSW F393798 L393807 C119 ..... q0 S CPU 2
[  968.970302] rcu:    CB 5^4->4 KblSW F358948 L358948 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  968.971663] rcu:    CB 7^4->-1 KblSW F375268 L375274 C16 ..... q0 S CPU 13
[  968.972693] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[  968.973589] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  968.974514] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  968.975489] rcu: RCU callbacks invoked since boot: 2167917
[  968.976302] rcu_tasks: RTGS_WAIT_CBS(11) since 968402 g:0 i:0 k.u.. l:250 
[  984.297457] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2046897 ni: 36345 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  984.301542] rcu-torture: Reader Pipe:  2164123808 122018 0 0 0 0 0 0 0 0 0
[  984.302588] rcu-torture: Reader Batch:  2163884312 361514 0 0 0 0 0 0 0 0 0
[  984.303592] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  984.304993] ??? Writer stall state RTWS_EXP_SYNC(4) g220977 f0x0 ->state D cpu 1
[  984.306134] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 175 ->gp_activity 0 ->gp_req_activity 175 ->gp_wake_time 176 ->gp_wake_seq 220973 ->gp_seq 220977 ->gp_seq_needed 220976 ->gp_max 381 ->gp_flags 0x0
[  984.309441] rcu: 	rcu_node 0:16 ->gp_seq 220977 ->gp_seq_needed 220976 ->qsmask 0x2 .... ->n_boosts 0
[  984.310789] rcu: 	rcu_node 0:8 ->gp_seq 220977 ->gp_seq_needed 220984 ->qsmask 0x0 .... ->n_boosts 0
[  984.312866] rcu: 	cpu 0 ->gp_seq_needed 220980
[  984.313581] rcu: 	cpu 1 ->gp_seq_needed 220984
[  984.314294] rcu: 	cpu 2 ->gp_seq_needed 220984
[  984.315007] rcu: 	cpu 8 ->gp_seq_needed 220984
[  984.315720] rcu: 	rcu_node 9:16 ->gp_seq 220977 ->gp_seq_needed 220984 ->qsmask 0x80 .... ->n_boosts 0
[  984.317550] rcu: 	cpu 9 ->gp_seq_needed 220984
[  984.318224] rcu: 	cpu 10 ->gp_seq_needed 220984
[  984.318954] rcu: 	cpu 11 ->gp_seq_needed 220984
[  984.319615] rcu: 	cpu 12 ->gp_seq_needed 220984
[  984.320298] rcu: 	cpu 14 ->gp_seq_needed 220984
[  984.321033] rcu: 	cpu 15 ->gp_seq_needed 220980
[  984.321713] rcu: 	cpu 16 ->gp_seq_needed 220980
[  984.322398] rcu: nocb GP 0 KldtS .[W.] .G:220984/169040 rnp 0:8 41783 S CPU 9
[  984.323492] rcu:    CB 0^0->2 KblSW F1084 L1084 C0 ..... q0 S CPU 13
[  984.324447] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W85(220984/169040).N74. q159 S CPU 0
[  984.325587] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  984.326533] rcu:    CB 4^4->7 KblSW F409156 L409165 C119 ..... q0 S CPU 2
[  984.327443] rcu:    CB 5^4->4 KblSW F374306 L374306 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  984.328852] rcu:    CB 7^4->-1 KblSW F390625 L390631 C16 ..... q0 S CPU 13
[  984.329878] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[  984.330796] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  984.331771] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  984.332681] rcu: RCU callbacks invoked since boot: 2207916
[  984.333507] rcu_tasks: RTGS_WAIT_CBS(11) since 983760 g:0 i:0 k.u.. l:250 
[  999.657456] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2074250 ni: 36828 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[  999.661304] rcu-torture: Reader Pipe:  2193397696 122018 0 0 0 0 0 0 0 0 0
[  999.662279] rcu-torture: Reader Batch:  2193154053 365661 0 0 0 0 0 0 0 0 0
[  999.663252] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[  999.664639] ??? Writer stall state RTWS_EXP_SYNC(4) g223681 f0x0 ->state D cpu 1
[  999.665663] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 222 ->gp_activity 1 ->gp_req_activity 222 ->gp_wake_time 222 ->gp_wake_seq 223677 ->gp_seq 223681 ->gp_seq_needed 223680 ->gp_max 381 ->gp_flags 0x0
[  999.668640] rcu: 	rcu_node 0:16 ->gp_seq 223681 ->gp_seq_needed 223680 ->qsmask 0x2 .... ->n_boosts 0
[  999.669870] rcu: 	rcu_node 0:8 ->gp_seq 223681 ->gp_seq_needed 223688 ->qsmask 0x0 .... ->n_boosts 0
[  999.671085] rcu: 	cpu 0 ->gp_seq_needed 223684
[  999.671689] rcu: 	cpu 1 ->gp_seq_needed 223688
[  999.672287] rcu: 	cpu 2 ->gp_seq_needed 223684
[  999.672885] rcu: 	cpu 8 ->gp_seq_needed 223688
[  999.673488] rcu: 	rcu_node 9:16 ->gp_seq 223681 ->gp_seq_needed 223688 ->qsmask 0x8 .... ->n_boosts 0
[  999.674717] rcu: 	cpu 9 ->gp_seq_needed 223684
[  999.675319] rcu: 	cpu 10 ->gp_seq_needed 223688
[  999.675925] rcu: 	cpu 11 ->gp_seq_needed 223688
[  999.676543] rcu: 	cpu 12 ->gp_seq_needed 223684
[  999.677149] rcu: 	cpu 14 ->gp_seq_needed 223688
[  999.677767] rcu: 	cpu 15 ->gp_seq_needed 223688
[  999.678378] rcu: 	cpu 16 ->gp_seq_needed 223688
[  999.678987] rcu: nocb GP 0 KldtS .[.W] .G:223684/169040 rnp 0:8 42133 S CPU 9
[  999.679951] rcu:    CB 0^0->2 KblSW F1042 L1042 C0 ..... q0 S CPU 13
[  999.680811] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W9(223684/169040).N98. q107 S CPU 15
[  999.681838] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[  999.682721] rcu:    CB 4^4->7 KblSW F424512 L424521 C119 ..... q0 S CPU 2
[  999.683635] rcu:    CB 5^4->4 KblSW F389662 L389662 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[  999.684858] rcu:    CB 7^4->-1 KblSW F405981 L405987 C16 ..... q0 S CPU 13
[  999.685784] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[  999.686609] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[  999.687454] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[  999.688295] rcu: RCU callbacks invoked since boot: 2236211
[  999.689032] rcu_tasks: RTGS_WAIT_CBS(11) since 999115 g:0 i:0 k.u.. l:250 
[ 1015.017749] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2113273 ni: 37521 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1015.024662] rcu-torture: Reader Pipe:  2235880324 122018 0 0 0 0 0 0 0 0 0
[ 1015.027133] rcu-torture: Reader Batch:  2235631055 371287 0 0 0 0 0 0 0 0 0
[ 1015.029199] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1015.032437] ??? Writer stall state RTWS_EXP_SYNC(4) g227337 f0x0 ->state D cpu 1
[ 1015.033591] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 15 ->gp_activity 2 ->gp_req_activity 15 ->gp_wake_time 17 ->gp_wake_seq 227333 ->gp_seq 227337 ->gp_seq_needed 227336 ->gp_max 381 ->gp_flags 0x0
[ 1015.039635] rcu: 	rcu_node 0:16 ->gp_seq 227337 ->gp_seq_needed 227336 ->qsmask 0x1 .... ->n_boosts 0
[ 1015.041329] rcu: 	rcu_node 0:8 ->gp_seq 227337 ->gp_seq_needed 227344 ->qsmask 0x100 .... ->n_boosts 0
[ 1015.043530] rcu: 	cpu 0 ->gp_seq_needed 227340
[ 1015.044220] rcu: 	cpu 1 ->gp_seq_needed 227344
[ 1015.044886] rcu: 	cpu 2 ->gp_seq_needed 227344
[ 1015.045384] rcu: 	cpu 8 ->gp_seq_needed 227344
[ 1015.046051] rcu: 	rcu_node 9:16 ->gp_seq 227337 ->gp_seq_needed 227344 ->qsmask 0x0 .... ->n_boosts 0
[ 1015.047464] rcu: 	cpu 9 ->gp_seq_needed 227344
[ 1015.048118] rcu: 	cpu 10 ->gp_seq_needed 227344
[ 1015.048795] rcu: 	cpu 11 ->gp_seq_needed 227344
[ 1015.049475] rcu: 	cpu 12 ->gp_seq_needed 227344
[ 1015.050171] rcu: 	cpu 13 ->gp_seq_needed 227344
[ 1015.050850] rcu: 	cpu 14 ->gp_seq_needed 227344
[ 1015.051535] rcu: 	cpu 15 ->gp_seq_needed 227344
[ 1015.052199] rcu: 	cpu 16 ->gp_seq_needed 227344
[ 1015.052921] rcu: nocb GP 0 KldtS .[W.] .G:227344/169040 rnp 0:8 42607 S CPU 13
[ 1015.054058] rcu:    CB 0^0->2 KblSW F432 L432 C0 ..... q0 S CPU 14
[ 1015.055023] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W5(227344/169040).N15. q20 S CPU 15
[ 1015.056118] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1015.057147] rcu:    CB 4^4->7 KblSW F439886 L439895 C119 ..... q0 S CPU 2
[ 1015.058196] rcu:    CB 5^4->4 KblSW F405036 L405036 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1015.059512] rcu:    CB 7^4->-1 KblSW F421356 L421362 C16 ..... q0 S CPU 13
[ 1015.060532] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1015.061455] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1015.062426] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1015.063442] rcu: RCU callbacks invoked since boot: 2276492
[ 1015.064267] rcu_tasks: RTGS_WAIT_CBS(11) since 1014490 g:0 i:0 k.u.. l:250 
[ 1030.377456] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2140028 ni: 38000 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1030.383825] rcu-torture: Reader Pipe:  2264677301 122018 0 0 0 0 0 0 0 0 0
[ 1030.385272] rcu-torture: Reader Batch:  2264424017 375302 0 0 0 0 0 0 0 0 0
[ 1030.386363] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1030.390717] ??? Writer stall state RTWS_EXP_SYNC(4) g229937 f0x0 ->state D cpu 1
[ 1030.391827] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 28 ->gp_activity 0 ->gp_req_activity 28 ->gp_wake_time 40 ->gp_wake_seq 229933 ->gp_seq 229937 ->gp_seq_needed 229940 ->gp_max 381 ->gp_flags 0x0
[ 1030.394907] rcu: 	rcu_node 0:16 ->gp_seq 229937 ->gp_seq_needed 229940 ->qsmask 0x2 .... ->n_boosts 0
[ 1030.396300] rcu: 	rcu_node 0:8 ->gp_seq 229937 ->gp_seq_needed 229940 ->qsmask 0x0 .... ->n_boosts 0
[ 1030.397652] rcu: 	cpu 0 ->gp_seq_needed 229940
[ 1030.398338] rcu: 	cpu 1 ->gp_seq_needed 229940
[ 1030.399025] rcu: 	cpu 2 ->gp_seq_needed 229940
[ 1030.399703] rcu: 	cpu 8 ->gp_seq_needed 229940
[ 1030.400341] rcu: 	rcu_node 9:16 ->gp_seq 229937 ->gp_seq_needed 229944 ->qsmask 0x1 .... ->n_boosts 0
[ 1030.401718] rcu: 	cpu 9 ->gp_seq_needed 229944
[ 1030.402388] rcu: 	cpu 10 ->gp_seq_needed 229944
[ 1030.403070] rcu: 	cpu 11 ->gp_seq_needed 229944
[ 1030.403742] rcu: 	cpu 12 ->gp_seq_needed 229944
[ 1030.404447] rcu: 	cpu 13 ->gp_seq_needed 229944
[ 1030.404940] rcu: 	cpu 14 ->gp_seq_needed 229944
[ 1030.405648] rcu: 	cpu 15 ->gp_seq_needed 229940
[ 1030.406348] rcu: 	cpu 16 ->gp_seq_needed 229944
[ 1030.407050] rcu: nocb GP 0 KldtS .[.W] .G:229940/169040 rnp 0:8 42945 S CPU 8
[ 1030.408151] rcu:    CB 0^0->2 KblSW F503 L503 C0 ..... q0 S CPU 15
[ 1030.409113] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W134(229940/169040).N19. q153 S CPU 0
[ 1030.410316] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1030.411330] rcu:    CB 4^4->7 KblSW F455240 L455249 C119 ..... q0 S CPU 2
[ 1030.412350] rcu:    CB 5^4->4 KblSW F420390 L420390 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1030.413747] rcu:    CB 7^4->-1 KblSW F436710 L436716 C16 ..... q0 S CPU 13
[ 1030.414782] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1030.415597] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1030.416419] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1030.417319] rcu: RCU callbacks invoked since boot: 2302850
[ 1030.418133] rcu_tasks: RTGS_WAIT_CBS(11) since 1029844 g:0 i:0 k.u.. l:250 
[ 1045.737491] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2168775 ni: 38507 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1045.740428] rcu-torture: Reader Pipe:  2295238628 122018 0 0 0 0 0 0 0 0 0
[ 1045.741177] rcu-torture: Reader Batch:  2294981660 378986 0 0 0 0 0 0 0 0 0
[ 1045.741923] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1045.743014] ??? Writer stall state RTWS_EXP_SYNC(4) g232304 f0x0 ->state D cpu 1
[ 1045.743829] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 3830 ->gp_activity 3826 ->gp_req_activity 3830 ->gp_wake_time 3834 ->gp_wake_seq 232293 ->gp_seq 232304 ->gp_seq_needed 232304 ->gp_max 381 ->gp_flags 0x0
[ 1045.746255] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 43252 S CPU 8
[ 1045.746951] rcu:    CB 0^0->2 KblSW F4328 L4328 C0 ..... q0 S CPU 15
[ 1045.747645] rcu:    CB 2^0->-1 KblSW F4113 L4113 C0 ..... q0 S CPU 0
[ 1045.748364] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1045.749080] rcu:    CB 4^4->7 KblSW F470578 L470587 C119 ..... q0 S CPU 2
[ 1045.749819] rcu:    CB 5^4->4 KblSW F435728 L435728 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1045.750799] rcu:    CB 7^4->-1 KblSW F452047 L452053 C16 ..... q0 S CPU 13
[ 1045.751546] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1045.752236] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1045.752909] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1045.753587] rcu: RCU callbacks invoked since boot: 2333010
[ 1045.754179] rcu_tasks: RTGS_WAIT_CBS(11) since 1045180 g:0 i:0 k.u.. l:250 
[ 1061.097462] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2206260 ni: 39172 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1061.103711] rcu-torture: Reader Pipe:  2334891542 122018 0 0 0 0 0 0 0 0 0
[ 1061.105382] rcu-torture: Reader Batch:  2334628852 384708 0 0 0 0 0 0 0 0 0
[ 1061.107850] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1061.119264] ??? Writer stall state RTWS_EXP_SYNC(4) g235937 f0x0 ->state D cpu 1
[ 1061.121683] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 22 ->gp_activity 2 ->gp_req_activity 22 ->gp_wake_time 22 ->gp_wake_seq 235933 ->gp_seq 235937 ->gp_seq_needed 235940 ->gp_max 381 ->gp_flags 0x0
[ 1061.125050] rcu: 	rcu_node 0:16 ->gp_seq 235937 ->gp_seq_needed 235940 ->qsmask 0x3 .... ->n_boosts 0
[ 1061.132198] rcu: 	rcu_node 0:8 ->gp_seq 235937 ->gp_seq_needed 235944 ->qsmask 0x100 .... ->n_boosts 0
[ 1061.133672] rcu: 	cpu 0 ->gp_seq_needed 235944
[ 1061.134330] rcu: 	cpu 1 ->gp_seq_needed 235940
[ 1061.135009] rcu: 	cpu 2 ->gp_seq_needed 235944
[ 1061.135694] rcu: 	cpu 8 ->gp_seq_needed 235944
[ 1061.136396] rcu: 	rcu_node 9:16 ->gp_seq 235937 ->gp_seq_needed 235944 ->qsmask 0x8 .... ->n_boosts 0
[ 1061.137859] rcu: 	cpu 9 ->gp_seq_needed 235944
[ 1061.138572] rcu: 	cpu 10 ->gp_seq_needed 235944
[ 1061.139278] rcu: 	cpu 11 ->gp_seq_needed 235944
[ 1061.139943] rcu: 	cpu 12 ->gp_seq_needed 235944
[ 1061.140630] rcu: 	cpu 13 ->gp_seq_needed 235944
[ 1061.141313] rcu: 	cpu 14 ->gp_seq_needed 235944
[ 1061.141861] rcu: 	cpu 15 ->gp_seq_needed 235944
[ 1061.142558] rcu: nocb GP 0 KldtS .[W.] .G:235944/169040 rnp 0:8 43724 S CPU 11
[ 1061.143641] rcu:    CB 0^0->2 KblSW F367 L367 C0 ..... q0 S CPU 15
[ 1061.144598] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W128(235944/169040).N21. q149 S CPU 0
[ 1061.145773] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1061.146817] rcu:    CB 4^4->7 KblSW F485976 L485985 C119 ..... q0 S CPU 2
[ 1061.147896] rcu:    CB 5^4->4 KblSW F451126 L451126 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1061.149326] rcu:    CB 7^4->-1 KblSW F467445 L467451 C16 ..... q0 S CPU 13
[ 1061.150416] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1061.151385] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1061.152294] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1061.153043] rcu: RCU callbacks invoked since boot: 2370568
[ 1061.153897] rcu_tasks: RTGS_WAIT_CBS(11) since 1060580 g:0 i:0 k.u.. l:250 
[ 1076.457456] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2232957 ni: 39648 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1076.461400] rcu-torture: Reader Pipe:  2363585660 122018 0 0 0 0 0 0 0 0 0
[ 1076.462403] rcu-torture: Reader Batch:  2363319319 388359 0 0 0 0 0 0 0 0 0
[ 1076.463450] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1076.464961] ??? Writer stall state RTWS_EXP_SYNC(4) g238253 f0x0 ->state D cpu 1
[ 1076.466065] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 101 ->gp_activity 2 ->gp_req_activity 101 ->gp_wake_time 114 ->gp_wake_seq 238249 ->gp_seq 238253 ->gp_seq_needed 238256 ->gp_max 381 ->gp_flags 0x0
[ 1076.469354] rcu: 	rcu_node 0:16 ->gp_seq 238253 ->gp_seq_needed 238256 ->qsmask 0x1 .... ->n_boosts 0
[ 1076.470725] rcu: 	rcu_node 0:8 ->gp_seq 238253 ->gp_seq_needed 238260 ->qsmask 0x0 ...G ->n_boosts 0
[ 1076.472077] rcu: 	cpu 0 ->gp_seq_needed 238256
[ 1076.472745] rcu: 	cpu 1 ->gp_seq_needed 238260
[ 1076.473414] rcu: 	cpu 8 ->gp_seq_needed 238260
[ 1076.474082] rcu: 	rcu_node 9:16 ->gp_seq 238253 ->gp_seq_needed 238260 ->qsmask 0x0 .... ->n_boosts 0
[ 1076.475427] rcu: 	cpu 9 ->gp_seq_needed 238260
[ 1076.476119] rcu: 	cpu 10 ->gp_seq_needed 238260
[ 1076.476794] rcu: 	cpu 11 ->gp_seq_needed 238260
[ 1076.477466] rcu: 	cpu 12 ->gp_seq_needed 238260
[ 1076.478156] rcu: 	cpu 13 ->gp_seq_needed 238260
[ 1076.478782] rcu: 	cpu 14 ->gp_seq_needed 238260
[ 1076.479457] rcu: 	cpu 15 ->gp_seq_needed 238260
[ 1076.480127] rcu: 	cpu 16 ->gp_seq_needed 238260
[ 1076.480826] rcu: nocb GP 0 Kldts .[W.] .G:238256/169040 rnp 0:8 44002 S CPU 8
[ 1076.482051] rcu:    CB 0^0->2 KblSW F50 L50 C0 ...N1. q1 S CPU 15
[ 1076.482970] rcu:    CB 2^0->-1 KblSW F158 L158 C0 .W1(238256/169040).N1. q2 S CPU 0
[ 1076.484129] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1076.485131] rcu:    CB 4^4->7 KblSW F501314 L501323 C119 ..... q0 S CPU 2
[ 1076.486171] rcu:    CB 5^4->4 KblSW F466464 L466464 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1076.487564] rcu:    CB 7^4->-1 KblSW F482784 L482790 C16 ..... q0 S CPU 13
[ 1076.488626] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1076.489548] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1076.490357] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1076.491324] rcu: RCU callbacks invoked since boot: 2397259
[ 1076.492135] rcu_tasks: RTGS_WAIT_CBS(11) since 1075918 g:0 i:0 k.u.. l:250 
[ 1091.817460] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2274056 ni: 40372 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1091.823679] rcu-torture: Reader Pipe:  2407475534 122018 0 0 0 0 0 0 0 0 0
[ 1091.824699] rcu-torture: Reader Batch:  2407201831 395721 0 0 0 0 0 0 0 0 0
[ 1091.825719] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1091.829307] ??? Writer stall state RTWS_EXP_SYNC(4) g243021 f0x0 ->state D cpu 1
[ 1091.830392] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 5 ->gp_activity 1 ->gp_req_activity 5 ->gp_wake_time 16 ->gp_wake_seq 243013 ->gp_seq 243021 ->gp_seq_needed 243020 ->gp_max 381 ->gp_flags 0x0
[ 1091.834425] rcu: 	rcu_node 0:16 ->gp_seq 243021 ->gp_seq_needed 243020 ->qsmask 0x1 .... ->n_boosts 0
[ 1091.838475] rcu: 	rcu_node 0:8 ->gp_seq 243025 ->gp_seq_needed 243032 ->qsmask 0x106 .... ->n_boosts 0
[ 1091.839876] rcu: 	cpu 0 ->gp_seq_needed 243028
[ 1091.840579] rcu: 	cpu 1 ->gp_seq_needed 243032
[ 1091.841255] rcu: 	cpu 2 ->gp_seq_needed 243028
[ 1091.841912] rcu: 	cpu 8 ->gp_seq_needed 243032
[ 1091.842634] rcu: 	rcu_node 9:16 ->gp_seq 243025 ->gp_seq_needed 243032 ->qsmask 0x0 .... ->n_boosts 0
[ 1091.844019] rcu: 	cpu 9 ->gp_seq_needed 243032
[ 1091.844667] rcu: 	cpu 10 ->gp_seq_needed 243032
[ 1091.845340] rcu: 	cpu 11 ->gp_seq_needed 243032
[ 1091.846044] rcu: 	cpu 12 ->gp_seq_needed 243032
[ 1091.846737] rcu: 	cpu 13 ->gp_seq_needed 243032
[ 1091.847443] rcu: 	cpu 14 ->gp_seq_needed 243032
[ 1091.847968] rcu: 	cpu 15 ->gp_seq_needed 243028
[ 1091.848639] rcu: nocb GP 0 KldtS .[.W] .G:243028/169040 rnp 0:8 44162 S CPU 2
[ 1091.849746] rcu:    CB 0^0->2 KblSW F21 L21 C0 .W1(243028/169040)... q1 S CPU 15
[ 1091.850873] rcu:    CB 2^0->-1 KblSW F79 L79 C0 ..... q0 S CPU 0
[ 1091.851756] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1091.852733] rcu:    CB 4^4->7 KblSW F516682 L516691 C119 ..... q0 S CPU 2
[ 1091.853780] rcu:    CB 5^4->4 KblSW F481832 L481832 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1091.855163] rcu:    CB 7^4->-1 KblSW F498151 L498157 C16 ..... q0 S CPU 13
[ 1091.856221] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1091.857164] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1091.858097] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1091.858852] rcu: RCU callbacks invoked since boot: 2440158
[ 1091.859705] rcu_tasks: RTGS_WAIT_CBS(11) since 1091286 g:0 i:0 k.u.. l:250 
[ 1107.177471] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2300731 ni: 40848 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1107.182083] rcu-torture: Reader Pipe:  2435748128 122018 0 0 0 0 0 0 0 0 0
[ 1107.183178] rcu-torture: Reader Batch:  2435470401 399745 0 0 0 0 0 0 0 0 0
[ 1107.184202] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1107.185665] ??? Writer stall state RTWS_EXP_SYNC(4) g245649 f0x0 ->state D cpu 1
[ 1107.186675] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 42 ->gp_activity 1 ->gp_req_activity 42 ->gp_wake_time 50 ->gp_wake_seq 245641 ->gp_seq 245649 ->gp_seq_needed 245648 ->gp_max 381 ->gp_flags 0x0
[ 1107.191141] rcu: 	rcu_node 0:16 ->gp_seq 245649 ->gp_seq_needed 245648 ->qsmask 0x2 .... ->n_boosts 0
[ 1107.192621] rcu: 	rcu_node 0:8 ->gp_seq 245649 ->gp_seq_needed 245656 ->qsmask 0x0 .... ->n_boosts 0
[ 1107.194020] rcu: 	cpu 2 ->gp_seq_needed 245656
[ 1107.194676] rcu: 	cpu 8 ->gp_seq_needed 245656
[ 1107.195365] rcu: 	rcu_node 9:16 ->gp_seq 245649 ->gp_seq_needed 245656 ->qsmask 0x4 .... ->n_boosts 0
[ 1107.196707] rcu: 	cpu 9 ->gp_seq_needed 245656
[ 1107.197375] rcu: 	cpu 10 ->gp_seq_needed 245656
[ 1107.198048] rcu: 	cpu 11 ->gp_seq_needed 245656
[ 1107.198728] rcu: 	cpu 12 ->gp_seq_needed 245656
[ 1107.199418] rcu: 	cpu 13 ->gp_seq_needed 245656
[ 1107.200122] rcu: 	cpu 14 ->gp_seq_needed 245656
[ 1107.200778] rcu: 	cpu 15 ->gp_seq_needed 245656
[ 1107.201466] rcu: 	cpu 16 ->gp_seq_needed 245652
[ 1107.202249] rcu: nocb GP 0 KldtS .[W.] .G:245656/169040 rnp 0:8 44242 S CPU 2
[ 1107.203440] rcu:    CB 0^0->2 KblSW F119 L119 C0 ..... q0 S CPU 8
[ 1107.205603] rcu:    CB 2^0->-1 KblSW F49 L49 C0 .W1(245656/169040)... q1 S CPU 0
[ 1107.206739] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1107.207642] rcu:    CB 4^4->7 KblSW F532037 L532046 C119 ..... q0 S CPU 2
[ 1107.208609] rcu:    CB 5^4->4 KblSW F497187 L497187 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1107.209991] rcu:    CB 7^4->-1 KblSW F513506 L513512 C16 ..... q0 S CPU 13
[ 1107.211041] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1107.211980] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1107.212921] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1107.213893] rcu: RCU callbacks invoked since boot: 2467200
[ 1107.214770] rcu_tasks: RTGS_WAIT_CBS(11) since 1106641 g:0 i:0 k.u.. l:250 
[ 1122.537541] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2331883 ni: 41404 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1122.540484] rcu-torture: Reader Pipe:  2469075666 122018 0 0 0 0 0 0 0 0 0
[ 1122.541232] rcu-torture: Reader Batch:  2468793889 403795 0 0 0 0 0 0 0 0 0
[ 1122.541988] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1122.543071] ??? Writer stall state RTWS_EXP_SYNC(4) g248272 f0x0 ->state D cpu 1
[ 1122.543866] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 2721 ->gp_activity 2716 ->gp_req_activity 2721 ->gp_wake_time 2725 ->gp_wake_seq 248261 ->gp_seq 248272 ->gp_seq_needed 248272 ->gp_max 381 ->gp_flags 0x0
[ 1122.546282] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 44357 S CPU 2
[ 1122.546979] rcu:    CB 0^0->2 KblSW F3112 L3112 C0 ..... q0 S CPU 8
[ 1122.547653] rcu:    CB 2^0->-1 KblSW F3075 L3075 C0 ..... q0 S CPU 0
[ 1122.548333] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1122.549036] rcu:    CB 4^4->7 KblSW F547378 L547387 C119 ..... q0 S CPU 2
[ 1122.549763] rcu:    CB 5^4->4 KblSW F512528 L512528 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1122.550740] rcu:    CB 7^4->-1 KblSW F528847 L528853 C16 ..... q0 S CPU 13
[ 1122.551479] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1122.552131] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1122.552801] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1122.553477] rcu: RCU callbacks invoked since boot: 2499015
[ 1122.554066] rcu_tasks: RTGS_WAIT_CBS(11) since 1121980 g:0 i:0 k.u.. l:250 
[ 1137.897459] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2365319 ni: 42008 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1137.905482] rcu-torture: Reader Pipe:  2505190085 122018 0 0 0 0 0 0 0 0 0
[ 1137.906499] rcu-torture: Reader Batch:  2504903710 408393 0 0 0 0 0 0 0 0 0
[ 1137.907519] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1137.910894] ??? Writer stall state RTWS_EXP_SYNC(4) g251289 f0x0 ->state D cpu 1
[ 1137.912534] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 182 ->gp_activity 182 ->gp_req_activity 182 ->gp_wake_time 186 ->gp_wake_seq 251281 ->gp_seq 251289 ->gp_seq_needed 251288 ->gp_max 381 ->gp_flags 0x0
[ 1137.918637] rcu: 	rcu_node 0:16 ->gp_seq 251289 ->gp_seq_needed 251288 ->qsmask 0x3 .... ->n_boosts 0
[ 1137.922823] rcu: 	rcu_node 0:8 ->gp_seq 251289 ->gp_seq_needed 251296 ->qsmask 0x5 .... ->n_boosts 0
[ 1137.924145] rcu: 	cpu 0 ->gp_seq_needed 251296
[ 1137.924834] rcu: 	cpu 1 ->gp_seq_needed 251292
[ 1137.928334] rcu: 	cpu 2 ->gp_seq_needed 251296
[ 1137.928992] rcu: 	cpu 8 ->gp_seq_needed 251296
[ 1137.929645] rcu: 	rcu_node 9:16 ->gp_seq 251289 ->gp_seq_needed 251296 ->qsmask 0xc0 .... ->n_boosts 0
[ 1137.933848] rcu: 	cpu 9 ->gp_seq_needed 251296
[ 1137.934501] rcu: 	cpu 10 ->gp_seq_needed 251296
[ 1137.935168] rcu: 	cpu 11 ->gp_seq_needed 251296
[ 1137.935838] rcu: 	cpu 12 ->gp_seq_needed 251292
[ 1137.936554] rcu: 	cpu 13 ->gp_seq_needed 251296
[ 1137.940065] rcu: 	cpu 14 ->gp_seq_needed 251296
[ 1137.940723] rcu: 	cpu 15 ->gp_seq_needed 251296
[ 1137.941395] rcu: 	cpu 16 ->gp_seq_needed 251296
[ 1137.942072] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 44491 S CPU 2
[ 1137.945863] rcu:    CB 0^0->2 KblSW F426 L426 C0 ..... q0 S CPU 8
[ 1137.946763] rcu:    CB 2^0->-1 KblSW F390 L390 C0 ..... q0 S CPU 0
[ 1137.947673] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1137.948628] rcu:    CB 4^4->7 KblSW F562778 L562787 C119 ..... q0 S CPU 2
[ 1137.952515] rcu:    CB 5^4->4 KblSW F527928 L527928 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1137.953941] rcu:    CB 7^4->-1 KblSW F544250 L544256 C16 ..... q0 S CPU 13
[ 1137.955040] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1137.956013] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1137.956978] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1137.957947] rcu: RCU callbacks invoked since boot: 2532643
[ 1137.958774] rcu_tasks: RTGS_WAIT_CBS(11) since 1137385 g:0 i:0 k.u.. l:250 
[ 1153.257457] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2391826 ni: 42482 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1153.262658] rcu-torture: Reader Pipe:  2533428540 122018 0 0 0 0 0 0 0 0 0
[ 1153.263592] rcu-torture: Reader Batch:  2533138209 412349 0 0 0 0 0 0 0 0 0
[ 1153.264527] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1153.269525] ??? Writer stall state RTWS_EXP_SYNC(4) g253869 f0x0 ->state D cpu 1
[ 1153.270723] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 227 ->gp_activity 3 ->gp_req_activity 227 ->gp_wake_time 227 ->gp_wake_seq 253865 ->gp_seq 253869 ->gp_seq_needed 253872 ->gp_max 381 ->gp_flags 0x0
[ 1153.280335] rcu: 	rcu_node 0:16 ->gp_seq 253869 ->gp_seq_needed 253872 ->qsmask 0x2 .... ->n_boosts 0
[ 1153.286267] rcu: 	rcu_node 0:8 ->gp_seq 253869 ->gp_seq_needed 253876 ->qsmask 0x0 .... ->n_boosts 0
[ 1153.288881] rcu: 	cpu 0 ->gp_seq_needed 253876
[ 1153.290920] rcu: 	cpu 1 ->gp_seq_needed 253876
[ 1153.293028] rcu: 	cpu 8 ->gp_seq_needed 253876
[ 1153.293624] rcu: 	rcu_node 9:16 ->gp_seq 253869 ->gp_seq_needed 253876 ->qsmask 0x0 ...G ->n_boosts 0
[ 1153.298998] rcu: 	cpu 9 ->gp_seq_needed 253876
[ 1153.300300] rcu: 	cpu 10 ->gp_seq_needed 253876
[ 1153.302875] rcu: 	cpu 11 ->gp_seq_needed 253876
[ 1153.303486] rcu: 	cpu 12 ->gp_seq_needed 253872
[ 1153.306126] rcu: 	cpu 13 ->gp_seq_needed 253876
[ 1153.307605] rcu: 	cpu 14 ->gp_seq_needed 253876
[ 1153.308242] rcu: 	cpu 15 ->gp_seq_needed 253876
[ 1153.310055] rcu: nocb GP 0 Kldts .[W.] .G:253872/169040 rnp 0:8 44580 S CPU 2
[ 1153.312001] rcu:    CB 0^0->2 KblSW F131 L131 C0 .W1(253872/169040).N1. q2 S CPU 8
[ 1153.314495] rcu:    CB 2^0->-1 KblSW F131 L131 C0 ...N1. q1 S CPU 0
[ 1153.317295] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1153.318903] rcu:    CB 4^4->7 KblSW F578148 L578157 C119 ..... q0 S CPU 2
[ 1153.322332] rcu:    CB 5^4->4 KblSW F543300 L543300 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1153.324513] rcu:    CB 7^4->-1 KblSW F559619 L559625 C16 ..... q0 S CPU 13
[ 1153.327243] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1153.329542] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1153.331329] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1153.333000] rcu: RCU callbacks invoked since boot: 2559485
[ 1153.334794] rcu_tasks: RTGS_WAIT_CBS(11) since 1152761 g:0 i:0 k.u.. l:250 
[ 1168.617474] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2431849 ni: 43192 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1168.621456] rcu-torture: Reader Pipe:  2576290138 122018 0 0 0 0 0 0 0 0 0
[ 1168.622482] rcu-torture: Reader Batch:  2575993965 418191 0 0 0 0 0 0 0 0 0
[ 1168.623445] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1168.624970] ??? Writer stall state RTWS_EXP_SYNC(4) g257589 f0x0 ->state D cpu 1
[ 1168.626073] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 5 ->gp_activity 5 ->gp_req_activity 5 ->gp_wake_time 5 ->gp_wake_seq 257585 ->gp_seq 257589 ->gp_seq_needed 257588 ->gp_max 381 ->gp_flags 0x0
[ 1168.629288] rcu: 	rcu_node 0:16 ->gp_seq 257589 ->gp_seq_needed 257588 ->qsmask 0x1 .... ->n_boosts 0
[ 1168.630671] rcu: 	rcu_node 0:8 ->gp_seq 257589 ->gp_seq_needed 257596 ->qsmask 0x102 .... ->n_boosts 0
[ 1168.632038] rcu: 	cpu 1 ->gp_seq_needed 257592
[ 1168.632689] rcu: 	cpu 2 ->gp_seq_needed 257592
[ 1168.633351] rcu: 	cpu 8 ->gp_seq_needed 257592
[ 1168.633882] rcu: 	rcu_node 9:16 ->gp_seq 257589 ->gp_seq_needed 257596 ->qsmask 0x0 .... ->n_boosts 0
[ 1168.635210] rcu: 	cpu 9 ->gp_seq_needed 257596
[ 1168.635884] rcu: 	cpu 10 ->gp_seq_needed 257596
[ 1168.636550] rcu: 	cpu 11 ->gp_seq_needed 257596
[ 1168.637239] rcu: 	cpu 12 ->gp_seq_needed 257592
[ 1168.637905] rcu: 	cpu 13 ->gp_seq_needed 257596
[ 1168.638590] rcu: 	cpu 14 ->gp_seq_needed 257596
[ 1168.639290] rcu: 	cpu 15 ->gp_seq_needed 257596
[ 1168.639951] rcu: 	cpu 16 ->gp_seq_needed 257596
[ 1168.640642] rcu: nocb GP 0 KldtS .[.W] .G:257596/169040 rnp 0:8 44723 S CPU 2
[ 1168.641741] rcu:    CB 0^0->2 KblSW F71 L71 C0 ..... q0 S CPU 9
[ 1168.642589] rcu:    CB 2^0->-1 KblSW F15 L15 C0 .W1(257596/169040)... q1 S CPU 0
[ 1168.643714] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1168.644639] rcu:    CB 4^4->7 KblSW F593474 L593483 C119 ..... q0 S CPU 2
[ 1168.645695] rcu:    CB 5^4->4 KblSW F558624 L558624 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1168.647026] rcu:    CB 7^4->-1 KblSW F574943 L574949 C16 ..... q0 S CPU 13
[ 1168.647847] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1168.648535] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1168.649355] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1168.650065] rcu: RCU callbacks invoked since boot: 2600738
[ 1168.650735] rcu_tasks: RTGS_WAIT_CBS(11) since 1168077 g:0 i:0 k.u.. l:250 
[ 1183.978911] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2457924 ni: 43663 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1183.982855] rcu-torture: Reader Pipe:  2604551634 122018 0 0 0 0 0 0 0 0 0
[ 1183.983934] rcu-torture: Reader Batch:  2604251711 421941 0 0 0 0 0 0 0 0 0
[ 1183.985017] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1183.986599] ??? Writer stall state RTWS_EXP_SYNC(4) g259997 f0x0 ->state D cpu 1
[ 1183.989835] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 193 ->gp_activity 2 ->gp_req_activity 193 ->gp_wake_time 194 ->gp_wake_seq 259993 ->gp_seq 259997 ->gp_seq_needed 259996 ->gp_max 381 ->gp_flags 0x0
[ 1183.993750] rcu: 	rcu_node 0:16 ->gp_seq 259997 ->gp_seq_needed 259996 ->qsmask 0x1 .... ->n_boosts 0
[ 1183.995078] rcu: 	rcu_node 0:8 ->gp_seq 259997 ->gp_seq_needed 260004 ->qsmask 0x100 .... ->n_boosts 0
[ 1183.996423] rcu: 	cpu 0 ->gp_seq_needed 260004
[ 1183.997104] rcu: 	cpu 1 ->gp_seq_needed 260000
[ 1183.997756] rcu: 	cpu 2 ->gp_seq_needed 260004
[ 1183.998385] rcu: 	cpu 8 ->gp_seq_needed 260004
[ 1183.999012] rcu: 	rcu_node 9:16 ->gp_seq 259997 ->gp_seq_needed 260004 ->qsmask 0x0 .... ->n_boosts 0
[ 1184.000413] rcu: 	cpu 9 ->gp_seq_needed 260004
[ 1184.003796] rcu: 	cpu 10 ->gp_seq_needed 260004
[ 1184.004526] rcu: 	cpu 11 ->gp_seq_needed 260004
[ 1184.005224] rcu: 	cpu 12 ->gp_seq_needed 260000
[ 1184.005895] rcu: 	cpu 13 ->gp_seq_needed 260004
[ 1184.006586] rcu: 	cpu 14 ->gp_seq_needed 260004
[ 1184.007259] rcu: 	cpu 15 ->gp_seq_needed 260004
[ 1184.007924] rcu: 	cpu 16 ->gp_seq_needed 260004
[ 1184.008623] rcu: nocb GP 0 Kldts .[.W] .G:260004/169040 rnp 0:8 44817 S CPU 2
[ 1184.009646] rcu:    CB 0^0->2 KblSW F172 L172 C0 .W1(260004/169040)... q1 S CPU 9
[ 1184.010744] rcu:    CB 2^0->-1 KblSW F14 L14 C0 ...N1. q1 S CPU 0
[ 1184.011679] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1184.012648] rcu:    CB 4^4->7 KblSW F608842 L608851 C119 ..... q0 S CPU 2
[ 1184.013660] rcu:    CB 5^4->4 KblSW F573992 L573992 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1184.014991] rcu:    CB 7^4->-1 KblSW F590311 L590317 C16 ..... q0 S CPU 13
[ 1184.016030] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1184.016938] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1184.017891] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1184.018933] rcu: RCU callbacks invoked since boot: 2626807
[ 1184.019734] rcu_tasks: RTGS_WAIT_CBS(11) since 1183446 g:0 i:0 k.u.. l:250 
[ 1199.337490] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2491786 ni: 44274 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1199.340608] rcu-torture: Reader Pipe:  2641228693 122018 0 0 0 0 0 0 0 0 0
[ 1199.341371] rcu-torture: Reader Batch:  2640924179 426532 0 0 0 0 0 0 0 0 0
[ 1199.342157] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1199.343289] ??? Writer stall state RTWS_EXP_SYNC(4) g262896 f0x0 ->state D cpu 1
[ 1199.344108] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 1706 ->gp_activity 1702 ->gp_req_activity 1706 ->gp_wake_time 1715 ->gp_wake_seq 262881 ->gp_seq 262896 ->gp_seq_needed 262896 ->gp_max 381 ->gp_flags 0x0
[ 1199.346639] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 44986 S CPU 0
[ 1199.347369] rcu:    CB 0^0->2 KblSW F1973 L1973 C0 ..... q0 S CPU 9
[ 1199.348082] rcu:    CB 2^0->-1 KblSW F1718 L1718 C0 ..... q0 S CPU 15
[ 1199.348795] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1199.349510] rcu:    CB 4^4->7 KblSW F624179 L624188 C119 ..... q0 S CPU 2
[ 1199.350274] rcu:    CB 5^4->4 KblSW F589328 L589328 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1199.351272] rcu:    CB 7^4->-1 KblSW F605647 L605653 C16 ..... q0 S CPU 13
[ 1199.352046] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1199.352732] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1199.353418] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1199.354115] rcu: RCU callbacks invoked since boot: 2661788
[ 1199.354743] rcu_tasks: RTGS_WAIT_CBS(11) since 1198781 g:0 i:0 k.u.. l:250 
[ 1214.697479] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2523004 ni: 44822 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1214.701155] rcu-torture: Reader Pipe:  2674108981 122018 0 0 0 0 0 0 0 0 0
[ 1214.702096] rcu-torture: Reader Batch:  2673799482 431517 0 0 0 0 0 0 0 0 0
[ 1214.703045] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1214.704393] ??? Writer stall state RTWS_EXP_SYNC(4) g266165 f0x0 ->state D cpu 1
[ 1214.705485] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 230 ->gp_activity 1 ->gp_req_activity 230 ->gp_wake_time 236 ->gp_wake_seq 266157 ->gp_seq 266165 ->gp_seq_needed 266164 ->gp_max 413 ->gp_flags 0x0
[ 1214.709928] rcu: 	rcu_node 0:16 ->gp_seq 266165 ->gp_seq_needed 266164 ->qsmask 0x1 .... ->n_boosts 0
[ 1214.713127] rcu: 	rcu_node 0:8 ->gp_seq 266165 ->gp_seq_needed 266172 ->qsmask 0x100 .... ->n_boosts 0
[ 1214.714376] rcu: 	cpu 0 ->gp_seq_needed 266168
[ 1214.715181] rcu: 	cpu 1 ->gp_seq_needed 266168
[ 1214.716234] rcu: 	cpu 2 ->gp_seq_needed 266168
[ 1214.716882] rcu: 	cpu 8 ->gp_seq_needed 266168
[ 1214.717504] rcu: 	rcu_node 9:16 ->gp_seq 266165 ->gp_seq_needed 266172 ->qsmask 0x0 .... ->n_boosts 0
[ 1214.718737] rcu: 	cpu 9 ->gp_seq_needed 266168
[ 1214.719322] rcu: 	cpu 10 ->gp_seq_needed 266172
[ 1214.719945] rcu: 	cpu 11 ->gp_seq_needed 266172
[ 1214.720573] rcu: 	cpu 12 ->gp_seq_needed 266172
[ 1214.721171] rcu: 	cpu 13 ->gp_seq_needed 266172
[ 1214.722837] rcu: 	cpu 14 ->gp_seq_needed 266172
[ 1214.723440] rcu: 	cpu 16 ->gp_seq_needed 266172
[ 1214.724044] rcu: nocb GP 0 KldtS .[W.] .G:266168/169040 rnp 0:8 45410 S CPU 9
[ 1214.727193] rcu:    CB 0^0->2 KblSW F496 L496 C0 ..... q0 S CPU 15
[ 1214.729043] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W5(266168/169040).N108. q113 S CPU 0
[ 1214.731197] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1214.732240] rcu:    CB 4^4->7 KblSW F639561 L639570 C119 ..... q0 S CPU 2
[ 1214.733269] rcu:    CB 5^4->4 KblSW F604711 L604711 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1214.734618] rcu:    CB 7^4->-1 KblSW F621031 L621037 C16 ..... q0 S CPU 13
[ 1214.735682] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1214.736563] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1214.737557] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1214.738357] rcu: RCU callbacks invoked since boot: 2692999
[ 1214.739215] rcu_tasks: RTGS_WAIT_CBS(11) since 1214165 g:0 i:0 k.u.. l:250 
[ 1230.059482] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2549171 ni: 45304 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1230.066348] rcu-torture: Reader Pipe:  2702381180 122018 0 0 0 0 0 0 0 0 0
[ 1230.067295] rcu-torture: Reader Batch:  2702067787 435411 0 0 0 0 0 0 0 0 0
[ 1230.068236] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1230.069639] ??? Writer stall state RTWS_EXP_SYNC(4) g268661 f0x0 ->state D cpu 1
[ 1230.070659] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 103 ->gp_activity 1 ->gp_req_activity 103 ->gp_wake_time 103 ->gp_wake_seq 268657 ->gp_seq 268661 ->gp_seq_needed 268660 ->gp_max 413 ->gp_flags 0x0
[ 1230.073646] rcu: 	rcu_node 0:16 ->gp_seq 268661 ->gp_seq_needed 268660 ->qsmask 0x1 .... ->n_boosts 0
[ 1230.074907] rcu: 	rcu_node 0:8 ->gp_seq 268661 ->gp_seq_needed 268668 ->qsmask 0x4 .... ->n_boosts 0
[ 1230.076118] rcu: 	cpu 0 ->gp_seq_needed 268668
[ 1230.076721] rcu: 	cpu 1 ->gp_seq_needed 268664
[ 1230.077308] rcu: 	cpu 2 ->gp_seq_needed 268668
[ 1230.077904] rcu: 	cpu 8 ->gp_seq_needed 268668
[ 1230.078547] rcu: 	rcu_node 9:16 ->gp_seq 268661 ->gp_seq_needed 268668 ->qsmask 0x0 .... ->n_boosts 0
[ 1230.079778] rcu: 	cpu 9 ->gp_seq_needed 268668
[ 1230.080363] rcu: 	cpu 10 ->gp_seq_needed 268668
[ 1230.080975] rcu: 	cpu 11 ->gp_seq_needed 268668
[ 1230.081589] rcu: 	cpu 12 ->gp_seq_needed 268668
[ 1230.082186] rcu: 	cpu 13 ->gp_seq_needed 268668
[ 1230.082821] rcu: 	cpu 14 ->gp_seq_needed 268668
[ 1230.083419] rcu: 	cpu 16 ->gp_seq_needed 268668
[ 1230.084046] rcu: nocb GP 0 Kldts .[.W] .G:268668/169040 rnp 0:8 45735 S CPU 9
[ 1230.085014] rcu:    CB 0^0->2 KblSW F39 L39 C0 ...N1. q1 S CPU 15
[ 1230.085829] rcu:    CB 2^0->-1 KblSW F121 L121 C0 .W4(268668/169040)... q4 S CPU 0
[ 1230.086831] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1230.087728] rcu:    CB 4^4->7 KblSW F654917 L654926 C119 ..... q0 S CPU 2
[ 1230.088672] rcu:    CB 5^4->4 KblSW F620067 L620067 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1230.089881] rcu:    CB 7^4->-1 KblSW F636386 L636392 C16 ..... q0 S CPU 13
[ 1230.090797] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1230.091613] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1230.092482] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1230.093310] rcu: RCU callbacks invoked since boot: 2719955
[ 1230.094061] rcu_tasks: RTGS_WAIT_CBS(11) since 1229520 g:0 i:0 k.u.. l:250 
[ 1245.418099] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2589037 ni: 46002 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1245.427694] rcu-torture: Reader Pipe:  2745248156 122018 0 0 0 0 0 0 0 0 0
[ 1245.428567] rcu-torture: Reader Batch:  2744929348 440826 0 0 0 0 0 0 0 0 0
[ 1245.433861] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1245.435426] ??? Writer stall state RTWS_EXP_SYNC(4) g272089 f0x0 ->state D cpu 1
[ 1245.438549] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 295 ->gp_activity 3 ->gp_req_activity 295 ->gp_wake_time 307 ->gp_wake_seq 272077 ->gp_seq 272089 ->gp_seq_needed 272088 ->gp_max 413 ->gp_flags 0x0
[ 1245.443592] rcu: 	rcu_node 0:16 ->gp_seq 272089 ->gp_seq_needed 272088 ->qsmask 0x2 .... ->n_boosts 0
[ 1245.444830] rcu: 	rcu_node 0:8 ->gp_seq 272089 ->gp_seq_needed 272096 ->qsmask 0x0 .... ->n_boosts 0
[ 1245.446075] rcu: 	cpu 0 ->gp_seq_needed 272092
[ 1245.446686] rcu: 	cpu 1 ->gp_seq_needed 272096
[ 1245.447300] rcu: 	cpu 2 ->gp_seq_needed 272096
[ 1245.447957] rcu: 	cpu 8 ->gp_seq_needed 272096
[ 1245.448651] rcu: 	rcu_node 9:16 ->gp_seq 272089 ->gp_seq_needed 272096 ->qsmask 0x0 ...G ->n_boosts 0
[ 1245.449976] rcu: 	cpu 9 ->gp_seq_needed 272096
[ 1245.450638] rcu: 	cpu 10 ->gp_seq_needed 272096
[ 1245.451330] rcu: 	cpu 11 ->gp_seq_needed 272096
[ 1245.451983] rcu: 	cpu 12 ->gp_seq_needed 272096
[ 1245.452662] rcu: 	cpu 13 ->gp_seq_needed 272096
[ 1245.453353] rcu: 	cpu 14 ->gp_seq_needed 272096
[ 1245.454029] rcu: 	cpu 15 ->gp_seq_needed 272096
[ 1245.454683] rcu: nocb GP 0 KldtS .[W.] .G:272096/169040 rnp 0:8 46102 S CPU 9
[ 1245.455672] rcu:    CB 0^0->2 KblSW F538 L538 C0 ..... q0 S CPU 15
[ 1245.456529] rcu:    CB 2^0->-1 KblSW F115 L115 C0 .W1(272096/169040).N1. q2 S CPU 0
[ 1245.457626] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1245.458550] rcu:    CB 4^4->7 KblSW F670288 L670297 C119 ..... q0 S CPU 2
[ 1245.459568] rcu:    CB 5^4->4 KblSW F635438 L635438 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1245.460983] rcu:    CB 7^4->-1 KblSW F651757 L651763 C16 ..... q0 S CPU 13
[ 1245.461964] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1245.462793] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1245.463670] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1245.464568] rcu: RCU callbacks invoked since boot: 2760065
[ 1245.465374] rcu_tasks: RTGS_WAIT_CBS(11) since 1244891 g:0 i:0 k.u.. l:250 
[ 1260.777484] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2615721 ni: 46480 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1260.782000] rcu-torture: Reader Pipe:  2774293237 122018 0 0 0 0 0 0 0 0 0
[ 1260.783020] rcu-torture: Reader Batch:  2773970137 445118 0 0 0 0 0 0 0 0 0
[ 1260.784115] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1260.785677] ??? Writer stall state RTWS_EXP_SYNC(4) g274869 f0x0 ->state D cpu 1
[ 1260.786784] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 5 ->gp_activity 1 ->gp_req_activity 5 ->gp_wake_time 5 ->gp_wake_seq 274865 ->gp_seq 274869 ->gp_seq_needed 274868 ->gp_max 413 ->gp_flags 0x0
[ 1260.790076] rcu: 	rcu_node 0:16 ->gp_seq 274869 ->gp_seq_needed 274868 ->qsmask 0x1 .... ->n_boosts 0
[ 1260.791500] rcu: 	rcu_node 0:8 ->gp_seq 274869 ->gp_seq_needed 274876 ->qsmask 0x1 .... ->n_boosts 0
[ 1260.792973] rcu: 	cpu 0 ->gp_seq_needed 274876
[ 1260.793590] rcu: 	cpu 1 ->gp_seq_needed 274876
[ 1260.794158] rcu: 	cpu 2 ->gp_seq_needed 274872
[ 1260.794877] rcu: 	cpu 8 ->gp_seq_needed 274872
[ 1260.795594] rcu: 	rcu_node 9:16 ->gp_seq 274869 ->gp_seq_needed 274876 ->qsmask 0x0 .... ->n_boosts 0
[ 1260.796971] rcu: 	cpu 9 ->gp_seq_needed 274876
[ 1260.797665] rcu: 	cpu 10 ->gp_seq_needed 274876
[ 1260.798336] rcu: 	cpu 11 ->gp_seq_needed 274876
[ 1260.799059] rcu: 	cpu 12 ->gp_seq_needed 274876
[ 1260.799763] rcu: 	cpu 13 ->gp_seq_needed 274876
[ 1260.800437] rcu: 	cpu 14 ->gp_seq_needed 274876
[ 1260.801096] rcu: 	cpu 15 ->gp_seq_needed 274876
[ 1260.801919] rcu: nocb GP 0 KldtS .[.W] .G:274876/169040 rnp 0:8 46189 S CPU 9
[ 1260.803039] rcu:    CB 0^0->2 KblSW F16 L16 C0 .W1(274876/169040)... q1 S CPU 15
[ 1260.804122] rcu:    CB 2^0->-1 KblSW F392 L392 C0 ..... q0 S CPU 0
[ 1260.804881] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1260.805870] rcu:    CB 4^4->7 KblSW F685635 L685644 C119 ..... q0 S CPU 2
[ 1260.806833] rcu:    CB 5^4->4 KblSW F650785 L650785 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1260.808270] rcu:    CB 7^4->-1 KblSW F667104 L667110 C16 ..... q0 S CPU 13
[ 1260.809354] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1260.810300] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1260.811222] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1260.812152] rcu: RCU callbacks invoked since boot: 2787905
[ 1260.813006] rcu_tasks: RTGS_WAIT_CBS(11) since 1260239 g:0 i:0 k.u.. l:250 
[ 1276.137529] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2654793 ni: 47173 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1276.140393] rcu-torture: Reader Pipe:  2815536720 122018 0 0 0 0 0 0 0 0 0
[ 1276.141126] rcu-torture: Reader Batch:  2815207139 451599 0 0 0 0 0 0 0 0 0
[ 1276.141872] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1276.142940] ??? Writer stall state RTWS_EXP_SYNC(4) g279076 f0x0 ->state D cpu 1
[ 1276.143725] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 391 ->gp_activity 363 ->gp_req_activity 391 ->gp_wake_time 400 ->gp_wake_seq 279061 ->gp_seq 279076 ->gp_seq_needed 279076 ->gp_max 413 ->gp_flags 0x0
[ 1276.146065] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 46586 S CPU 14
[ 1276.146762] rcu:    CB 0^0->2 KblSW F1111 L1111 C0 ..... q0 S CPU 15
[ 1276.147441] rcu:    CB 2^0->-1 KblSW F521 L521 C0 ..... q0 S CPU 0
[ 1276.148091] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1276.148786] rcu:    CB 4^4->7 KblSW F700978 L700987 C119 ..... q0 S CPU 2
[ 1276.149506] rcu:    CB 5^4->4 KblSW F666128 L666128 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1276.150474] rcu:    CB 7^4->-1 KblSW F682447 L682453 C16 ..... q0 S CPU 13
[ 1276.151195] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1276.151846] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1276.152518] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1276.153175] rcu: RCU callbacks invoked since boot: 2827694
[ 1276.153763] rcu_tasks: RTGS_WAIT_CBS(11) since 1275580 g:0 i:0 k.u.. l:250 
[ 1291.497466] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2682340 ni: 47667 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1291.503576] rcu-torture: Reader Pipe:  2845224243 122018 0 0 0 0 0 0 0 0 0
[ 1291.504625] rcu-torture: Reader Batch:  2844890977 455284 0 0 0 0 0 0 0 0 0
[ 1291.505690] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1291.507284] ??? Writer stall state RTWS_EXP_SYNC(4) g281461 f0x0 ->state D cpu 1
[ 1291.508413] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 175 ->gp_activity 2 ->gp_req_activity 175 ->gp_wake_time 175 ->gp_wake_seq 281457 ->gp_seq 281461 ->gp_seq_needed 281460 ->gp_max 413 ->gp_flags 0x0
[ 1291.511567] rcu: 	rcu_node 0:16 ->gp_seq 281461 ->gp_seq_needed 281460 ->qsmask 0x2 .... ->n_boosts 0
[ 1291.512949] rcu: 	rcu_node 0:8 ->gp_seq 281461 ->gp_seq_needed 281468 ->qsmask 0x0 .... ->n_boosts 0
[ 1291.514291] rcu: 	cpu 0 ->gp_seq_needed 281464
[ 1291.515027] rcu: 	cpu 1 ->gp_seq_needed 281468
[ 1291.515753] rcu: 	cpu 2 ->gp_seq_needed 281468
[ 1291.516425] rcu: 	cpu 8 ->gp_seq_needed 281468
[ 1291.517073] rcu: 	rcu_node 9:16 ->gp_seq 281461 ->gp_seq_needed 281468 ->qsmask 0x10 .... ->n_boosts 0
[ 1291.518447] rcu: 	cpu 9 ->gp_seq_needed 281468
[ 1291.519099] rcu: 	cpu 10 ->gp_seq_needed 281468
[ 1291.519704] rcu: 	cpu 11 ->gp_seq_needed 281468
[ 1291.520335] rcu: 	cpu 12 ->gp_seq_needed 281468
[ 1291.521002] rcu: 	cpu 13 ->gp_seq_needed 281468
[ 1291.521679] rcu: 	cpu 14 ->gp_seq_needed 281468
[ 1291.522333] rcu: 	cpu 15 ->gp_seq_needed 281468
[ 1291.523020] rcu: 	cpu 16 ->gp_seq_needed 281468
[ 1291.523698] rcu: nocb GP 0 KldtS .[W.] .G:281464/169040 rnp 0:8 46895 S CPU 15
[ 1291.524794] rcu:    CB 0^0->2 KblSW F234 L234 C0 ..... q0 S CPU 16
[ 1291.525707] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W7(281464/169040).N85. q92 S CPU 0
[ 1291.526890] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1291.527903] rcu:    CB 4^4->7 KblSW F716357 L716366 C119 ..... q0 S CPU 2
[ 1291.528924] rcu:    CB 5^4->4 KblSW F681507 L681507 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1291.530265] rcu:    CB 7^4->-1 KblSW F697826 L697832 C16 ..... q0 S CPU 13
[ 1291.531085] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1291.532008] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1291.532970] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1291.533925] rcu: RCU callbacks invoked since boot: 2855281
[ 1291.534745] rcu_tasks: RTGS_WAIT_CBS(11) since 1290961 g:0 i:0 k.u.. l:250 
[ 1306.857479] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2708878 ni: 48136 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1306.861698] rcu-torture: Reader Pipe:  2873827769 122018 0 0 0 0 0 0 0 0 0
[ 1306.862745] rcu-torture: Reader Batch:  2873491309 458478 0 0 0 0 0 0 0 0 0
[ 1306.863801] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1306.865366] ??? Writer stall state RTWS_EXP_SYNC(4) g283541 f0x0 ->state D cpu 1
[ 1306.866477] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 5 ->gp_activity 5 ->gp_req_activity 5 ->gp_wake_time 13 ->gp_wake_seq 283533 ->gp_seq 283541 ->gp_seq_needed 283540 ->gp_max 413 ->gp_flags 0x0
[ 1306.869480] rcu: 	rcu_node 0:16 ->gp_seq 283541 ->gp_seq_needed 283540 ->qsmask 0x1 .... ->n_boosts 0
[ 1306.870853] rcu: 	rcu_node 0:8 ->gp_seq 283541 ->gp_seq_needed 283548 ->qsmask 0x1 .... ->n_boosts 0
[ 1306.872218] rcu: 	cpu 0 ->gp_seq_needed 283548
[ 1306.872896] rcu: 	cpu 1 ->gp_seq_needed 283544
[ 1306.873552] rcu: 	cpu 8 ->gp_seq_needed 283548
[ 1306.874352] rcu: 	rcu_node 9:16 ->gp_seq 283541 ->gp_seq_needed 283548 ->qsmask 0x0 .... ->n_boosts 0
[ 1306.875737] rcu: 	cpu 9 ->gp_seq_needed 283548
[ 1306.876395] rcu: 	cpu 10 ->gp_seq_needed 283548
[ 1306.877051] rcu: 	cpu 11 ->gp_seq_needed 283548
[ 1306.877733] rcu: 	cpu 12 ->gp_seq_needed 283548
[ 1306.878410] rcu: 	cpu 14 ->gp_seq_needed 283548
[ 1306.878914] rcu: 	cpu 15 ->gp_seq_needed 283548
[ 1306.879615] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 47072 S CPU 16
[ 1306.880599] rcu:    CB 0^0->2 KblSW F115 L115 C0 ..... q0 S CPU 0
[ 1306.881545] rcu:    CB 2^0->-1 KblSW F257 L257 C0 ..... q0 S CPU 1
[ 1306.882501] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1306.883512] rcu:    CB 4^4->7 KblSW F731713 L731722 C119 ..... q0 S CPU 2
[ 1306.884529] rcu:    CB 5^4->4 KblSW F696863 L696863 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1306.885883] rcu:    CB 7^4->-1 KblSW F713182 L713188 C16 ..... q0 S CPU 13
[ 1306.886904] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1306.887813] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1306.888777] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1306.889607] rcu: RCU callbacks invoked since boot: 2882720
[ 1306.890310] rcu_tasks: RTGS_WAIT_CBS(11) since 1306316 g:0 i:0 k.u.. l:250 
[ 1322.217456] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2747029 ni: 48816 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1322.226520] rcu-torture: Reader Pipe:  2914791476 122018 0 0 0 0 0 0 0 0 0
[ 1322.227570] rcu-torture: Reader Batch:  2914450451 463043 0 0 0 0 0 0 0 0 0
[ 1322.228678] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1322.230227] ??? Writer stall state RTWS_EXP_SYNC(4) g286501 f0x0 ->state D cpu 1
[ 1322.231191] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 58 ->gp_activity 3 ->gp_req_activity 58 ->gp_wake_time 58 ->gp_wake_seq 286497 ->gp_seq 286501 ->gp_seq_needed 286500 ->gp_max 413 ->gp_flags 0x0
[ 1322.234507] rcu: 	rcu_node 0:16 ->gp_seq 286501 ->gp_seq_needed 286500 ->qsmask 0x2 .... ->n_boosts 0
[ 1322.235843] rcu: 	rcu_node 0:8 ->gp_seq 286501 ->gp_seq_needed 286508 ->qsmask 0x0 .... ->n_boosts 0
[ 1322.237229] rcu: 	cpu 0 ->gp_seq_needed 286504
[ 1322.237911] rcu: 	cpu 1 ->gp_seq_needed 286504
[ 1322.238615] rcu: 	cpu 8 ->gp_seq_needed 286504
[ 1322.239295] rcu: 	rcu_node 9:16 ->gp_seq 286501 ->gp_seq_needed 286508 ->qsmask 0x4 .... ->n_boosts 0
[ 1322.240649] rcu: 	cpu 9 ->gp_seq_needed 286508
[ 1322.241302] rcu: 	cpu 10 ->gp_seq_needed 286508
[ 1322.241850] rcu: 	cpu 11 ->gp_seq_needed 286508
[ 1322.242531] rcu: 	cpu 12 ->gp_seq_needed 286508
[ 1322.243231] rcu: 	cpu 14 ->gp_seq_needed 286508
[ 1322.243903] rcu: 	cpu 15 ->gp_seq_needed 286508
[ 1322.244607] rcu: 	cpu 16 ->gp_seq_needed 286504
[ 1322.245314] rcu: nocb GP 0 KldtS .[W.] .G:286504/169040 rnp 0:8 47186 S CPU 16
[ 1322.246443] rcu:    CB 0^0->2 KblSW F192 L192 C0 .W1(286504/169040).N1. q2 S CPU 0
[ 1322.247570] rcu:    CB 2^0->-1 KblSW F557 L557 C0 ..... q0 S CPU 1
[ 1322.248497] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1322.249515] rcu:    CB 4^4->7 KblSW F747079 L747088 C119 ..... q0 S CPU 2
[ 1322.250566] rcu:    CB 5^4->4 KblSW F712229 L712229 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1322.251912] rcu:    CB 7^4->-1 KblSW F728548 L728554 C16 ..... q0 S CPU 13
[ 1322.252949] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1322.253892] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1322.254802] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1322.255751] rcu: RCU callbacks invoked since boot: 2920795
[ 1322.256577] rcu_tasks: RTGS_WAIT_CBS(11) since 1321683 g:0 i:0 k.u.. l:250 
[ 1337.577476] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2774520 ni: 49301 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1337.583865] rcu-torture: Reader Pipe:  2944173093 122018 0 0 0 0 0 0 0 0 0
[ 1337.584928] rcu-torture: Reader Batch:  2943827818 467293 0 0 0 0 0 0 0 0 0
[ 1337.585964] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1337.587644] ??? Writer stall state RTWS_EXP_SYNC(4) g289281 f0x0 ->state D cpu 1
[ 1337.588703] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 288 ->gp_activity 1 ->gp_req_activity 288 ->gp_wake_time 288 ->gp_wake_seq 289277 ->gp_seq 289281 ->gp_seq_needed 289280 ->gp_max 413 ->gp_flags 0x0
[ 1337.592138] rcu: 	rcu_node 0:16 ->gp_seq 289281 ->gp_seq_needed 289280 ->qsmask 0x2 .... ->n_boosts 0
[ 1337.593894] rcu: 	rcu_node 0:8 ->gp_seq 289281 ->gp_seq_needed 289288 ->qsmask 0x0 .... ->n_boosts 0
[ 1337.595328] rcu: 	cpu 0 ->gp_seq_needed 289284
[ 1337.596037] rcu: 	cpu 1 ->gp_seq_needed 289288
[ 1337.596757] rcu: 	cpu 2 ->gp_seq_needed 289288
[ 1337.597511] rcu: 	cpu 8 ->gp_seq_needed 289288
[ 1337.598192] rcu: 	rcu_node 9:16 ->gp_seq 289281 ->gp_seq_needed 289288 ->qsmask 0x0 ...G ->n_boosts 0
[ 1337.599649] rcu: 	cpu 9 ->gp_seq_needed 289288
[ 1337.600194] rcu: 	cpu 10 ->gp_seq_needed 289288
[ 1337.600924] rcu: 	cpu 11 ->gp_seq_needed 289288
[ 1337.601703] rcu: 	cpu 12 ->gp_seq_needed 289288
[ 1337.602474] rcu: 	cpu 13 ->gp_seq_needed 289288
[ 1337.603128] rcu: 	cpu 14 ->gp_seq_needed 289288
[ 1337.603838] rcu: 	cpu 15 ->gp_seq_needed 289288
[ 1337.604577] rcu: 	cpu 16 ->gp_seq_needed 289288
[ 1337.605244] rcu: nocb GP 0 KldtS .[W.] .G:289288/169040 rnp 0:8 47277 S CPU 16
[ 1337.606414] rcu:    CB 0^0->2 KblSW F107 L107 C0 .W3(289288/169040).N2. q5 S CPU 0
[ 1337.607614] rcu:    CB 2^0->-1 KblSW F11 L11 C0 .W3(289288/169040).N1. q4 S CPU 2
[ 1337.608775] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1337.609803] rcu:    CB 4^4->7 KblSW F762439 L762448 C119 ..... q0 S CPU 2
[ 1337.610754] rcu:    CB 5^4->4 KblSW F727589 L727589 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1337.612717] rcu:    CB 7^4->-1 KblSW F743909 L743915 C16 ..... q0 S CPU 13
[ 1337.613795] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1337.614742] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1337.615702] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1337.616633] rcu: RCU callbacks invoked since boot: 2948043
[ 1337.617459] rcu_tasks: RTGS_WAIT_CBS(11) since 1337044 g:0 i:0 k.u.. l:250 
[ 1352.938038] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2814223 ni: 50002 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1352.945103] rcu-torture: Reader Pipe:  2986636838 122018 0 0 0 0 0 0 0 0 0
[ 1352.946191] rcu-torture: Reader Batch:  2986285811 473045 0 0 0 0 0 0 0 0 0
[ 1352.948941] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1352.951519] ??? Writer stall state RTWS_EXP_SYNC(4) g293009 f0x0 ->state D cpu 1
[ 1352.952845] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 15 ->gp_activity 2 ->gp_req_activity 15 ->gp_wake_time 32 ->gp_wake_seq 293005 ->gp_seq 293009 ->gp_seq_needed 293012 ->gp_max 413 ->gp_flags 0x0
[ 1352.956266] rcu: 	rcu_node 0:16 ->gp_seq 293009 ->gp_seq_needed 293012 ->qsmask 0x1 .... ->n_boosts 0
[ 1352.957693] rcu: 	rcu_node 0:8 ->gp_seq 293009 ->gp_seq_needed 293016 ->qsmask 0x4 .... ->n_boosts 0
[ 1352.959086] rcu: 	cpu 0 ->gp_seq_needed 293012
[ 1352.959756] rcu: 	cpu 1 ->gp_seq_needed 293016
[ 1352.960404] rcu: 	cpu 2 ->gp_seq_needed 293016
[ 1352.961119] rcu: 	cpu 8 ->gp_seq_needed 293016
[ 1352.961813] rcu: 	rcu_node 9:16 ->gp_seq 293009 ->gp_seq_needed 293016 ->qsmask 0x0 .... ->n_boosts 0
[ 1352.963214] rcu: 	cpu 9 ->gp_seq_needed 293016
[ 1352.963906] rcu: 	cpu 10 ->gp_seq_needed 293016
[ 1352.964652] rcu: 	cpu 11 ->gp_seq_needed 293016
[ 1352.965370] rcu: 	cpu 12 ->gp_seq_needed 293016
[ 1352.966087] rcu: 	cpu 13 ->gp_seq_needed 293016
[ 1352.966781] rcu: 	cpu 15 ->gp_seq_needed 293016
[ 1352.967514] rcu: 	cpu 16 ->gp_seq_needed 293016
[ 1352.968196] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 47432 S CPU 2
[ 1352.969196] rcu:    CB 0^0->2 KblSW F109 L109 C0 ..... q0 S CPU 0
[ 1352.970103] rcu:    CB 2^0->-1 KblSW F123 L123 C0 ..... q0 S CPU 12
[ 1352.971090] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1352.972111] rcu:    CB 4^4->7 KblSW F777801 L777810 C119 ..... q0 S CPU 2
[ 1352.973185] rcu:    CB 5^4->4 KblSW F742951 L742951 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1352.974573] rcu:    CB 7^4->-1 KblSW F759271 L759277 C16 ..... q0 S CPU 13
[ 1352.975586] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1352.976518] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1352.977462] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1352.978369] rcu: RCU callbacks invoked since boot: 2989820
[ 1352.979226] rcu_tasks: RTGS_WAIT_CBS(11) since 1352405 g:0 i:0 k.u.. l:250 
[ 1368.297471] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2840594 ni: 50481 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1368.301294] rcu-torture: Reader Pipe:  3015341023 122018 0 0 0 0 0 0 0 0 0
[ 1368.302320] rcu-torture: Reader Batch:  3014986253 476788 0 0 0 0 0 0 0 0 0
[ 1368.303325] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1368.304847] ??? Writer stall state RTWS_EXP_SYNC(4) g295381 f0x0 ->state D cpu 1
[ 1368.305933] rcu: rcu_preempt: wait state: RCU_GP_INIT(4) ->state: I ->rt_priority 0 delta ->gp_start 10 ->gp_activity 2 ->gp_req_activity 10 ->gp_wake_time 10 ->gp_wake_seq 295377 ->gp_seq 295381 ->gp_seq_needed 295388 ->gp_max 413 ->gp_flags 0x0
[ 1368.309075] rcu: 	rcu_node 0:16 ->gp_seq 295381 ->gp_seq_needed 295388 ->qsmask 0x3 .... ->n_boosts 0
[ 1368.310457] rcu: 	rcu_node 0:8 ->gp_seq 295381 ->gp_seq_needed 295388 ->qsmask 0x5 .... ->n_boosts 0
[ 1368.311766] rcu: 	cpu 0 ->gp_seq_needed 295388
[ 1368.312441] rcu: 	cpu 1 ->gp_seq_needed 295388
[ 1368.313098] rcu: 	cpu 2 ->gp_seq_needed 295388
[ 1368.313687] rcu: 	cpu 8 ->gp_seq_needed 295388
[ 1368.314294] rcu: 	rcu_node 9:16 ->gp_seq 295381 ->gp_seq_needed 295388 ->qsmask 0xf7 .... ->n_boosts 0
[ 1368.315660] rcu: 	cpu 9 ->gp_seq_needed 295388
[ 1368.316331] rcu: 	cpu 10 ->gp_seq_needed 295388
[ 1368.317015] rcu: 	cpu 11 ->gp_seq_needed 295388
[ 1368.317695] rcu: 	cpu 12 ->gp_seq_needed 295388
[ 1368.318383] rcu: 	cpu 16 ->gp_seq_needed 295388
[ 1368.319081] rcu: nocb GP 0 KldtS .[W.] .G:295384/169040 rnp 0:8 47711 S CPU 2
[ 1368.320196] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W9(295384/169040).N14. q23 S CPU 12
[ 1368.321292] rcu:    CB 2^0->-1 KblSW F179 L179 C0 ..... q0 S CPU 13
[ 1368.322220] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1368.323143] rcu:    CB 4^4->7 KblSW F793152 L793161 C119 ..... q0 S CPU 2
[ 1368.324150] rcu:    CB 5^4->4 KblSW F758302 L758302 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1368.325327] rcu:    CB 7^4->-1 KblSW F774621 L774627 C16 ..... q0 S CPU 13
[ 1368.326362] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1368.327261] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1368.328181] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1368.329075] rcu: RCU callbacks invoked since boot: 3016739
[ 1368.329874] rcu_tasks: RTGS_WAIT_CBS(11) since 1367756 g:0 i:0 k.u.. l:250 
[ 1383.657508] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2868426 ni: 50983 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1383.660442] rcu-torture: Reader Pipe:  3045030575 122018 0 0 0 0 0 0 0 0 0
[ 1383.661197] rcu-torture: Reader Batch:  3044672940 479653 0 0 0 0 0 0 0 0 0
[ 1383.661954] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1383.663041] ??? Writer stall state RTWS_EXP_SYNC(4) g297256 f0x0 ->state D cpu 1
[ 1383.663852] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 3842 ->gp_activity 3837 ->gp_req_activity 3842 ->gp_wake_time 3837 ->gp_wake_seq 297253 ->gp_seq 297256 ->gp_seq_needed 297256 ->gp_max 413 ->gp_flags 0x0
[ 1383.666285] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 47955 S CPU 12
[ 1383.666987] rcu:    CB 0^0->2 KblSW F4044 L4044 C0 ..... q0 S CPU 2
[ 1383.667656] rcu:    CB 2^0->-1 KblSW F4331 L4331 C0 ..... q0 S CPU 13
[ 1383.668346] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1383.669057] rcu:    CB 4^4->7 KblSW F808498 L808507 C119 ..... q0 S CPU 2
[ 1383.669779] rcu:    CB 5^4->4 KblSW F773648 L773648 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1383.670754] rcu:    CB 7^4->-1 KblSW F789967 L789973 C16 ..... q0 S CPU 13
[ 1383.671512] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1383.672165] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1383.672832] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1383.673510] rcu: RCU callbacks invoked since boot: 3045137
[ 1383.674107] rcu_tasks: RTGS_WAIT_CBS(11) since 1383100 g:0 i:0 k.u.. l:250 
[ 1399.019275] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2906755 ni: 51657 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1399.025732] rcu-torture: Reader Pipe:  3085016749 122018 0 0 0 0 0 0 0 0 0
[ 1399.029527] rcu-torture: Reader Batch:  3084652814 485953 0 0 0 0 0 0 0 0 0
[ 1399.030496] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1399.031892] ??? Writer stall state RTWS_EXP_SYNC(4) g301337 f0x0 ->state D cpu 1
[ 1399.032909] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 177 ->gp_activity 0 ->gp_req_activity 177 ->gp_wake_time 177 ->gp_wake_seq 301333 ->gp_seq 301337 ->gp_seq_needed 301336 ->gp_max 453 ->gp_flags 0x0
[ 1399.035907] rcu: 	rcu_node 0:16 ->gp_seq 301337 ->gp_seq_needed 301336 ->qsmask 0x2 .... ->n_boosts 0
[ 1399.037144] rcu: 	rcu_node 0:8 ->gp_seq 301337 ->gp_seq_needed 301344 ->qsmask 0x0 .... ->n_boosts 0
[ 1399.038397] rcu: 	cpu 0 ->gp_seq_needed 301344
[ 1399.039012] rcu: 	cpu 1 ->gp_seq_needed 301344
[ 1399.039628] rcu: 	cpu 2 ->gp_seq_needed 301344
[ 1399.040226] rcu: 	cpu 8 ->gp_seq_needed 301344
[ 1399.040825] rcu: 	rcu_node 9:16 ->gp_seq 301337 ->gp_seq_needed 301344 ->qsmask 0x0 ...G ->n_boosts 0
[ 1399.042048] rcu: 	cpu 9 ->gp_seq_needed 301344
[ 1399.042648] rcu: 	cpu 10 ->gp_seq_needed 301344
[ 1399.043256] rcu: 	cpu 11 ->gp_seq_needed 301340
[ 1399.043860] rcu: 	cpu 12 ->gp_seq_needed 301344
[ 1399.044468] rcu: 	cpu 13 ->gp_seq_needed 301344
[ 1399.045068] rcu: 	cpu 14 ->gp_seq_needed 301344
[ 1399.045678] rcu: 	cpu 16 ->gp_seq_needed 301344
[ 1399.046286] rcu: nocb GP 0 Kldts .[W.] .G:301344/169040 rnp 0:8 48486 S CPU 8
[ 1399.047237] rcu:    CB 0^0->2 KblSW F0 L0 C0 .W6(301344/169040).N74. q80 S CPU 13
[ 1399.048238] rcu:    CB 2^0->-1 KblSW F109 L109 C0 ...N2. q2 S CPU 2
[ 1399.049069] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1399.049948] rcu:    CB 4^4->7 KblSW F823879 L823888 C119 ..... q0 S CPU 2
[ 1399.050856] rcu:    CB 5^4->4 KblSW F789029 L789029 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1399.052068] rcu:    CB 7^4->-1 KblSW F805347 L805353 C16 ..... q0 S CPU 13
[ 1399.052984] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1399.053798] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1399.054677] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1399.055602] rcu: RCU callbacks invoked since boot: 3083705
[ 1399.056381] rcu_tasks: RTGS_WAIT_CBS(11) since 1398482 g:0 i:0 k.u.. l:250 
[ 1414.377837] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2933067 ni: 52133 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1414.384062] rcu-torture: Reader Pipe:  3113054351 122018 0 0 0 0 0 0 0 0 0
[ 1414.385139] rcu-torture: Reader Batch:  3112687384 488985 0 0 0 0 0 0 0 0 0
[ 1414.386165] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1414.387621] ??? Writer stall state RTWS_EXP_SYNC(4) g303293 f0x0 ->state D cpu 1
[ 1414.388587] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 11 ->gp_activity 1 ->gp_req_activity 11 ->gp_wake_time 11 ->gp_wake_seq 303289 ->gp_seq 303293 ->gp_seq_needed 303292 ->gp_max 453 ->gp_flags 0x0
[ 1414.391871] rcu: 	rcu_node 0:16 ->gp_seq 303293 ->gp_seq_needed 303292 ->qsmask 0x1 .... ->n_boosts 0
[ 1414.393310] rcu: 	rcu_node 0:8 ->gp_seq 303293 ->gp_seq_needed 303300 ->qsmask 0x4 .... ->n_boosts 0
[ 1414.394627] rcu: 	cpu 0 ->gp_seq_needed 303296
[ 1414.395321] rcu: 	cpu 1 ->gp_seq_needed 303296
[ 1414.396021] rcu: 	cpu 2 ->gp_seq_needed 303300
[ 1414.396716] rcu: 	rcu_node 9:16 ->gp_seq 303293 ->gp_seq_needed 303300 ->qsmask 0x0 .... ->n_boosts 0
[ 1414.398114] rcu: 	cpu 9 ->gp_seq_needed 303300
[ 1414.398739] rcu: 	cpu 10 ->gp_seq_needed 303300
[ 1414.399449] rcu: 	cpu 11 ->gp_seq_needed 303296
[ 1414.400158] rcu: 	cpu 12 ->gp_seq_needed 303300
[ 1414.400865] rcu: 	cpu 13 ->gp_seq_needed 303296
[ 1414.401569] rcu: 	cpu 14 ->gp_seq_needed 303300
[ 1414.402232] rcu: 	cpu 16 ->gp_seq_needed 303300
[ 1414.402916] rcu: nocb GP 0 KldtS .[W.] .G:303296/169040 rnp 0:8 48740 S CPU 2
[ 1414.404012] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W10(303296/169040).N13. q23 S CPU 13
[ 1414.405163] rcu:    CB 2^0->-1 KblSW F82 L82 C0 ..... q0 S CPU 8
[ 1414.406100] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1414.407109] rcu:    CB 4^4->7 KblSW F839236 L839245 C119 ..... q0 S CPU 2
[ 1414.408125] rcu:    CB 5^4->4 KblSW F804386 L804386 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1414.409496] rcu:    CB 7^4->-1 KblSW F820705 L820711 C16 ..... q0 S CPU 13
[ 1414.410563] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1414.411298] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1414.412269] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1414.413195] rcu: RCU callbacks invoked since boot: 3110866
[ 1414.413999] rcu_tasks: RTGS_WAIT_CBS(11) since 1413840 g:0 i:0 k.u.. l:250 
[ 1429.738517] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2971404 ni: 52821 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1429.744461] rcu-torture: Reader Pipe:  3152998076 122018 0 0 0 0 0 0 0 0 0
[ 1429.745335] rcu-torture: Reader Batch:  3152626735 493359 0 0 0 0 0 0 0 0 0
[ 1429.746109] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1429.747515] ??? Writer stall state RTWS_EXP_SYNC(4) g306161 f0x0 ->state D cpu 1
[ 1429.748377] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 8 ->gp_activity 3 ->gp_req_activity 8 ->gp_wake_time 8 ->gp_wake_seq 306157 ->gp_seq 306161 ->gp_seq_needed 306160 ->gp_max 453 ->gp_flags 0x0
[ 1429.750720] rcu: 	rcu_node 0:16 ->gp_seq 306161 ->gp_seq_needed 306160 ->qsmask 0x1 .... ->n_boosts 0
[ 1429.751709] rcu: 	rcu_node 0:8 ->gp_seq 306161 ->gp_seq_needed 306168 ->qsmask 0x4 .... ->n_boosts 0
[ 1429.753196] rcu: 	cpu 0 ->gp_seq_needed 306168
[ 1429.753887] rcu: 	cpu 1 ->gp_seq_needed 306168
[ 1429.754553] rcu: 	cpu 2 ->gp_seq_needed 306168
[ 1429.755149] rcu: 	cpu 8 ->gp_seq_needed 306168
[ 1429.755649] rcu: 	rcu_node 9:16 ->gp_seq 306161 ->gp_seq_needed 306168 ->qsmask 0x0 .... ->n_boosts 0
[ 1429.756717] rcu: 	cpu 9 ->gp_seq_needed 306168
[ 1429.757325] rcu: 	cpu 11 ->gp_seq_needed 306168
[ 1429.757834] rcu: 	cpu 12 ->gp_seq_needed 306168
[ 1429.758392] rcu: 	cpu 13 ->gp_seq_needed 306168
[ 1429.759001] rcu: 	cpu 14 ->gp_seq_needed 306168
[ 1429.759485] rcu: 	cpu 15 ->gp_seq_needed 306164
[ 1429.759984] rcu: 	cpu 16 ->gp_seq_needed 306168
[ 1429.760522] rcu: nocb GP 0 KldtS .[W.] .G:306168/169040 rnp 0:8 49112 S CPU 8
[ 1429.761594] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W6(306168/169040).N8. q14 S CPU 13
[ 1429.762650] rcu:    CB 2^0->-1 KblSW F205 L205 C0 ..... q0 S CPU 10
[ 1429.763609] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1429.764617] rcu:    CB 4^4->7 KblSW F854594 L854603 C119 ..... q0 S CPU 2
[ 1429.765667] rcu:    CB 5^4->4 KblSW F819744 L819744 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1429.767034] rcu:    CB 7^4->-1 KblSW F836063 L836069 C16 ..... q0 S CPU 13
[ 1429.768109] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1429.769082] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1429.770062] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1429.771772] rcu: RCU callbacks invoked since boot: 3149917
[ 1429.772663] rcu_tasks: RTGS_WAIT_CBS(11) since 1429199 g:0 i:0 k.u.. l:250 
[ 1445.098485] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2998116 ni: 53308 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1445.102137] rcu-torture: Reader Pipe:  3181494282 122018 0 0 0 0 0 0 0 0 0
[ 1445.103066] rcu-torture: Reader Batch:  3181118805 497495 0 0 0 0 0 0 0 0 0
[ 1445.104004] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1445.105346] ??? Writer stall state RTWS_EXP_SYNC(4) g308881 f0x0 ->state D cpu 1
[ 1445.106329] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 22 ->gp_activity 3 ->gp_req_activity 22 ->gp_wake_time 37 ->gp_wake_seq 308873 ->gp_seq 308881 ->gp_seq_needed 308888 ->gp_max 453 ->gp_flags 0x0
[ 1445.109226] rcu: 	rcu_node 0:16 ->gp_seq 308881 ->gp_seq_needed 308888 ->qsmask 0x1 .... ->n_boosts 0
[ 1445.110440] rcu: 	rcu_node 0:8 ->gp_seq 308881 ->gp_seq_needed 308888 ->qsmask 0x4 .... ->n_boosts 0
[ 1445.111644] rcu: 	cpu 0 ->gp_seq_needed 308888
[ 1445.112238] rcu: 	cpu 1 ->gp_seq_needed 308888
[ 1445.112840] rcu: 	cpu 2 ->gp_seq_needed 308888
[ 1445.113428] rcu: 	cpu 8 ->gp_seq_needed 308888
[ 1445.114036] rcu: 	rcu_node 9:16 ->gp_seq 308881 ->gp_seq_needed 308888 ->qsmask 0x0 .... ->n_boosts 0
[ 1445.115274] rcu: 	cpu 9 ->gp_seq_needed 308888
[ 1445.115873] rcu: 	cpu 10 ->gp_seq_needed 308888
[ 1445.116475] rcu: 	cpu 11 ->gp_seq_needed 308888
[ 1445.117080] rcu: 	cpu 12 ->gp_seq_needed 308888
[ 1445.117687] rcu: 	cpu 13 ->gp_seq_needed 308884
[ 1445.118283] rcu: 	cpu 14 ->gp_seq_needed 308888
[ 1445.118890] rcu: 	cpu 15 ->gp_seq_needed 308888
[ 1445.119489] rcu: 	cpu 16 ->gp_seq_needed 308888
[ 1445.120094] rcu: nocb GP 0 KldtS .[W.] .G:308888/169040 rnp 0:8 49466 S CPU 8
[ 1445.121041] rcu:    CB 0^0->2 KblSW F3 L3 C0 .W16(308888/169040)... q16 S CPU 13
[ 1445.122023] rcu:    CB 2^0->-1 KblSW F184 L184 C0 ..... q0 S CPU 10
[ 1445.122860] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1445.123730] rcu:    CB 4^4->7 KblSW F869953 L869962 C119 ..... q0 S CPU 2
[ 1445.124624] rcu:    CB 5^4->4 KblSW F835103 L835103 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1445.125830] rcu:    CB 7^4->-1 KblSW F851422 L851428 C16 ..... q0 S CPU 13
[ 1445.126746] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1445.127554] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1445.128383] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1445.129217] rcu: RCU callbacks invoked since boot: 3177090
[ 1445.129953] rcu_tasks: RTGS_WAIT_CBS(11) since 1444556 g:0 i:0 k.u.. l:250 
[ 1460.457496] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3030159 ni: 53882 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1460.460394] rcu-torture: Reader Pipe:  3215467787 122018 0 0 0 0 0 0 0 0 0
[ 1460.461138] rcu-torture: Reader Batch:  3215087560 502245 0 0 0 0 0 0 0 0 0
[ 1460.461888] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1460.462967] ??? Writer stall state RTWS_EXP_SYNC(4) g311988 f0x0 ->state D cpu 1
[ 1460.463759] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 2836 ->gp_activity 2832 ->gp_req_activity 2836 ->gp_wake_time 2844 ->gp_wake_seq 311973 ->gp_seq 311988 ->gp_seq_needed 311988 ->gp_max 453 ->gp_flags 0x0
[ 1460.466233] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 49868 S CPU 8
[ 1460.466940] rcu:    CB 0^0->2 KblSW F2847 L2847 C0 ..... q0 S CPU 13
[ 1460.467629] rcu:    CB 2^0->-1 KblSW F2902 L2902 C0 ..... q0 S CPU 10
[ 1460.468317] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1460.469024] rcu:    CB 4^4->7 KblSW F885298 L885307 C119 ..... q0 S CPU 2
[ 1460.469760] rcu:    CB 5^4->4 KblSW F850448 L850448 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1460.470741] rcu:    CB 7^4->-1 KblSW F866767 L866773 C16 ..... q0 S CPU 13
[ 1460.471477] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1460.472135] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1460.472876] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1460.473664] rcu: RCU callbacks invoked since boot: 3209769
[ 1460.474253] rcu_tasks: RTGS_WAIT_CBS(11) since 1459900 g:0 i:0 k.u.. l:250 
[ 1475.817470] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3063894 ni: 54500 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1475.821116] rcu-torture: Reader Pipe:  3252101764 122018 0 0 0 0 0 0 0 0 0
[ 1475.822062] rcu-torture: Reader Batch:  3251716436 507346 0 0 0 0 0 0 0 0 0
[ 1475.823013] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1475.824377] ??? Writer stall state RTWS_EXP_SYNC(4) g315273 f0x0 ->state D cpu 1
[ 1475.825371] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 184 ->gp_activity 1 ->gp_req_activity 184 ->gp_wake_time 184 ->gp_wake_seq 315269 ->gp_seq 315273 ->gp_seq_needed 315272 ->gp_max 453 ->gp_flags 0x0
[ 1475.828357] rcu: 	rcu_node 0:16 ->gp_seq 315273 ->gp_seq_needed 315272 ->qsmask 0x2 .... ->n_boosts 0
[ 1475.829617] rcu: 	rcu_node 0:8 ->gp_seq 315273 ->gp_seq_needed 315280 ->qsmask 0x0 .... ->n_boosts 0
[ 1475.830841] rcu: 	cpu 0 ->gp_seq_needed 315280
[ 1475.831459] rcu: 	cpu 1 ->gp_seq_needed 315280
[ 1475.832054] rcu: 	cpu 2 ->gp_seq_needed 315280
[ 1475.832671] rcu: 	cpu 8 ->gp_seq_needed 315280
[ 1475.833261] rcu: 	rcu_node 9:16 ->gp_seq 315273 ->gp_seq_needed 315280 ->qsmask 0x20 .... ->n_boosts 0
[ 1475.834517] rcu: 	cpu 9 ->gp_seq_needed 315280
[ 1475.835111] rcu: 	cpu 11 ->gp_seq_needed 315280
[ 1475.835743] rcu: 	cpu 12 ->gp_seq_needed 315280
[ 1475.836345] rcu: 	cpu 13 ->gp_seq_needed 315280
[ 1475.836978] rcu: 	cpu 14 ->gp_seq_needed 315280
[ 1475.837612] rcu: 	cpu 15 ->gp_seq_needed 315276
[ 1475.838213] rcu: 	cpu 16 ->gp_seq_needed 315280
[ 1475.838837] rcu: nocb GP 0 KldtS .[.W] .G:315276/169040 rnp 0:8 50294 S CPU 8
[ 1475.839815] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W122(315276/169040).N75. q197 S CPU 13
[ 1475.840864] rcu:    CB 2^0->-1 KblSW F514 L514 C0 .W1(315276/169040)... q1 S CPU 10
[ 1475.841888] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1475.842762] rcu:    CB 4^4->7 KblSW F900672 L900681 C119 ..... q0 S CPU 2
[ 1475.843671] rcu:    CB 5^4->4 KblSW F865822 L865822 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1475.844880] rcu:    CB 7^4->-1 KblSW F882141 L882147 C16 ..... q0 S CPU 13
[ 1475.845795] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1475.846608] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1475.847449] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1475.848281] rcu: RCU callbacks invoked since boot: 3242922
[ 1475.849018] rcu_tasks: RTGS_WAIT_CBS(11) since 1475275 g:0 i:0 k.u.. l:250 
[ 1491.177459] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3090751 ni: 54979 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 0
[ 1491.181338] rcu-torture: Reader Pipe:  3281049616 122018 0 0 0 0 0 0 0 0 0
[ 1491.183231] rcu-torture: Reader Batch:  3280660222 511412 0 0 0 0 0 0 0 0 0
[ 1491.184178] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1491.185536] ??? Writer stall state RTWS_EXP_SYNC(4) g317917 f0x0 ->state D cpu 1
[ 1491.186527] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 302 ->gp_activity 1 ->gp_req_activity 302 ->gp_wake_time 302 ->gp_wake_seq 317913 ->gp_seq 317917 ->gp_seq_needed 317916 ->gp_max 453 ->gp_flags 0x0
[ 1491.189495] rcu: 	rcu_node 0:16 ->gp_seq 317921 ->gp_seq_needed 317920 ->qsmask 0x3 .... ->n_boosts 0
[ 1491.190731] rcu: 	rcu_node 0:8 ->gp_seq 317921 ->gp_seq_needed 317928 ->qsmask 0x106 .... ->n_boosts 0
[ 1491.191971] rcu: 	cpu 0 ->gp_seq_needed 317924
[ 1491.192575] rcu: 	cpu 1 ->gp_seq_needed 317928
[ 1491.193167] rcu: 	cpu 2 ->gp_seq_needed 317928
[ 1491.193772] rcu: 	cpu 8 ->gp_seq_needed 317928
[ 1491.194366] rcu: 	rcu_node 9:16 ->gp_seq 317921 ->gp_seq_needed 317928 ->qsmask 0x8 .... ->n_boosts 0
[ 1491.195602] rcu: 	cpu 9 ->gp_seq_needed 317928
[ 1491.196194] rcu: 	cpu 10 ->gp_seq_needed 317924
[ 1491.196807] rcu: 	cpu 11 ->gp_seq_needed 317928
[ 1491.197409] rcu: 	cpu 12 ->gp_seq_needed 317928
[ 1491.198023] rcu: 	cpu 13 ->gp_seq_needed 317928
[ 1491.198636] rcu: 	cpu 14 ->gp_seq_needed 317928
[ 1491.199238] rcu: 	cpu 15 ->gp_seq_needed 317924
[ 1491.199851] rcu: 	cpu 16 ->gp_seq_needed 317928
[ 1491.200461] rcu: nocb GP 0 KldtS .[.W] .G:317924/169040 rnp 0:8 50638 S CPU 8
[ 1491.201414] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W6(317924/169040).N114. q120 S CPU 10
[ 1491.202438] rcu:    CB 2^0->-1 KblSW F877 L877 C0 ..... q0 S CPU 8
[ 1491.203274] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1491.204150] rcu:    CB 4^4->7 KblSW F916033 L916042 C119 ..... q0 S CPU 2
[ 1491.205058] rcu:    CB 5^4->4 KblSW F881183 L881183 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1491.206270] rcu:    CB 7^4->-1 KblSW F897502 L897508 C16 ..... q0 S CPU 13
[ 1491.207189] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1491.208014] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1491.210797] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1491.211649] rcu: RCU callbacks invoked since boot: 3270768
[ 1491.212386] rcu_tasks: RTGS_WAIT_CBS(11) since 1490638 g:0 i:0 k.u.. l:250 
[ 1501.667516] rcu-torture: Enabling gpwrap lag (value=8)
[ 1506.537477] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3129535 ni: 55674 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 286
[ 1506.545656] rcu-torture: Reader Pipe:  3322267685 122018 0 0 0 0 0 0 0 0 0
[ 1506.546709] rcu-torture: Reader Batch:  3321873202 516501 0 0 0 0 0 0 0 0 0
[ 1506.547764] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1506.549257] ??? Writer stall state RTWS_EXP_SYNC(4) g321213 f0x0 ->state D cpu 1
[ 1506.550384] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 4 ->gp_activity 4 ->gp_req_activity 4 ->gp_wake_time 4 ->gp_wake_seq 321209 ->gp_seq 321213 ->gp_seq_needed 321212 ->gp_max 453 ->gp_flags 0x0
[ 1506.554045] rcu: 	rcu_node 0:16 ->gp_seq 321213 ->gp_seq_needed 321212 ->qsmask 0x1 .... ->n_boosts 0
[ 1506.555426] rcu: 	rcu_node 0:8 ->gp_seq 321213 ->gp_seq_needed 321220 ->qsmask 0x4 .... ->n_boosts 0
[ 1506.556805] rcu: 	cpu 1 ->gp_seq_needed 321220
[ 1506.557469] rcu: 	cpu 2 ->gp_seq_needed 321220
[ 1506.558120] rcu: 	cpu 8 ->gp_seq_needed 321224
[ 1506.558782] rcu: 	rcu_node 9:16 ->gp_seq 321217 ->gp_seq_needed 321224 ->qsmask 0x2f .... ->n_boosts 0
[ 1506.560176] rcu: 	cpu 9 ->gp_seq_needed 321224
[ 1506.560837] rcu: 	cpu 10 ->gp_seq_needed 321224
[ 1506.561546] rcu: 	cpu 11 ->gp_seq_needed 321224
[ 1506.562211] rcu: 	cpu 13 ->gp_seq_needed 321224
[ 1506.563223] rcu: 	cpu 14 ->gp_seq_needed 321224
[ 1506.563928] rcu: 	cpu 15 ->gp_seq_needed 321220
[ 1506.564628] rcu: 	cpu 16 ->gp_seq_needed 321224
[ 1506.565192] rcu: nocb GP 0 KldtS .[W.] .G:321224/169040 rnp 0:8 51066 S CPU 8
[ 1506.566276] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W7(321224/169040).N4. q11 S CPU 10
[ 1506.567398] rcu:    CB 2^0->-1 KblSW F45 L45 C0 ..... q0 S CPU 15
[ 1506.568828] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1506.569823] rcu:    CB 4^4->7 KblSW F931399 L931408 C119 ..... q0 S CPU 2
[ 1506.570830] rcu:    CB 5^4->4 KblSW F896549 L896549 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1506.572243] rcu:    CB 7^4->-1 KblSW F912868 L912874 C16 ..... q0 S CPU 13
[ 1506.573246] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1506.574159] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1506.575450] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1506.576396] rcu: RCU callbacks invoked since boot: 3310943
[ 1506.577231] rcu_tasks: RTGS_WAIT_CBS(11) since 1506002 g:0 i:0 k.u.. l:250 
[ 1521.897478] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3157070 ni: 56159 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 1036
[ 1521.901514] rcu-torture: Reader Pipe:  3351116113 122018 0 0 0 0 0 0 0 0 0
[ 1521.903606] rcu-torture: Reader Batch:  3350716858 521273 0 0 0 0 0 0 0 0 0
[ 1521.907303] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1521.908823] ??? Writer stall state RTWS_EXP_SYNC(4) g324261 f0x0 ->state D cpu 1
[ 1521.911034] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 322 ->gp_activity 1 ->gp_req_activity 322 ->gp_wake_time 322 ->gp_wake_seq 324257 ->gp_seq 324261 ->gp_seq_needed 324260 ->gp_max 453 ->gp_flags 0x0
[ 1521.914349] rcu: 	rcu_node 0:16 ->gp_seq 324261 ->gp_seq_needed 324260 ->qsmask 0x2 .... ->n_boosts 0
[ 1521.915841] rcu: 	rcu_node 0:8 ->gp_seq 324261 ->gp_seq_needed 324268 ->qsmask 0x0 .... ->n_boosts 0
[ 1521.917228] rcu: 	cpu 0 ->gp_seq_needed 324268
[ 1521.917895] rcu: 	cpu 1 ->gp_seq_needed 324268
[ 1521.918573] rcu: 	cpu 2 ->gp_seq_needed 324268
[ 1521.919345] rcu: 	cpu 8 ->gp_seq_needed 324268
[ 1521.920039] rcu: 	rcu_node 9:16 ->gp_seq 324261 ->gp_seq_needed 324268 ->qsmask 0x0 ...G ->n_boosts 0
[ 1521.921376] rcu: 	cpu 9 ->gp_seq_needed 324268
[ 1521.922058] rcu: 	cpu 10 ->gp_seq_needed 324268
[ 1521.922762] rcu: 	cpu 11 ->gp_seq_needed 324272
[ 1521.923474] rcu: 	cpu 12 ->gp_seq_needed 324272
[ 1521.924151] rcu: 	cpu 13 ->gp_seq_needed 324272
[ 1521.924835] rcu: 	cpu 14 ->gp_seq_needed 324272
[ 1521.925517] rcu: 	cpu 15 ->gp_seq_needed 324268
[ 1521.926187] rcu: 	cpu 16 ->gp_seq_needed 324272
[ 1521.926893] rcu: nocb GP 0 KldtS .[W.] .G:324272/169040 rnp 0:8 51462 S CPU 8
[ 1521.927741] rcu:    CB 0^0->2 KblSW F27 L27 C0 .W134(324272/169040)... q134 S CPU 10
[ 1521.928563] rcu:    CB 2^0->-1 KblSW F502 L502 C0 ..... q0 S CPU 15
[ 1521.929218] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1521.929925] rcu:    CB 4^4->7 KblSW F946759 L946768 C119 ..... q0 S CPU 2
[ 1521.930651] rcu:    CB 5^4->4 KblSW F911909 L911909 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1521.931628] rcu:    CB 7^4->-1 KblSW F928227 L928233 C16 ..... q0 S CPU 13
[ 1521.932344] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1521.933060] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1521.933888] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1521.934712] rcu: RCU callbacks invoked since boot: 3338170
[ 1521.935437] rcu_tasks: RTGS_WAIT_CBS(11) since 1521362 g:0 i:0 k.u.. l:250 
[ 1537.257518] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3192730 ni: 56785 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 2479
[ 1537.260519] rcu-torture: Reader Pipe:  3388410120 122018 0 0 0 0 0 0 0 0 0
[ 1537.261254] rcu-torture: Reader Batch:  3388006122 526016 0 0 0 0 0 0 0 0 0
[ 1537.262006] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1537.263086] ??? Writer stall state RTWS_EXP_SYNC(4) g327256 f0x0 ->state D cpu 1
[ 1537.263914] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 1536 ->gp_activity 1532 ->gp_req_activity 1536 ->gp_wake_time 1541 ->gp_wake_seq 327245 ->gp_seq 327256 ->gp_seq_needed 327256 ->gp_max 453 ->gp_flags 0x0
[ 1537.266326] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 51574 S CPU 2
[ 1537.267020] rcu:    CB 0^0->2 KblSW F1704 L1704 C0 ..... q0 S CPU 10
[ 1537.267703] rcu:    CB 2^0->-1 KblSW F1894 L1894 C0 ..... q0 S CPU 15
[ 1537.268391] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1537.269084] rcu:    CB 4^4->7 KblSW F962098 L962107 C119 ..... q0 S CPU 2
[ 1537.269833] rcu:    CB 5^4->4 KblSW F927248 L927248 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1537.270808] rcu:    CB 7^4->-1 KblSW F943567 L943573 C16 ..... q0 S CPU 13
[ 1537.271548] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1537.272193] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1537.272909] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1537.273594] rcu: RCU callbacks invoked since boot: 3375243
[ 1537.274176] rcu_tasks: RTGS_WAIT_CBS(11) since 1536700 g:0 i:0 k.u.. l:250 
[ 1552.618514] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3223550 ni: 57341 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 3825
[ 1552.622438] rcu-torture: Reader Pipe:  3421214990 122018 0 0 0 0 0 0 0 0 0
[ 1552.623438] rcu-torture: Reader Batch:  3420806023 530985 0 0 0 0 0 0 0 0 0
[ 1552.624457] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1552.625952] ??? Writer stall state RTWS_EXP_SYNC(4) g330393 f0x0 ->state D cpu 1
[ 1552.627004] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 116 ->gp_activity 3 ->gp_req_activity 116 ->gp_wake_time 116 ->gp_wake_seq 330389 ->gp_seq 330393 ->gp_seq_needed 330392 ->gp_max 453 ->gp_flags 0x0
[ 1552.630159] rcu: 	rcu_node 0:16 ->gp_seq 330393 ->gp_seq_needed 330392 ->qsmask 0x2 .... ->n_boosts 0
[ 1552.631511] rcu: 	rcu_node 0:8 ->gp_seq 330393 ->gp_seq_needed 330400 ->qsmask 0x0 .... ->n_boosts 0
[ 1552.632929] rcu: 	cpu 1 ->gp_seq_needed 330400
[ 1552.633576] rcu: 	cpu 2 ->gp_seq_needed 330400
[ 1552.634238] rcu: 	cpu 8 ->gp_seq_needed 330400
[ 1552.634901] rcu: 	rcu_node 9:16 ->gp_seq 330393 ->gp_seq_needed 330400 ->qsmask 0x0 ...G ->n_boosts 0
[ 1552.636217] rcu: 	cpu 9 ->gp_seq_needed 330400
[ 1552.636882] rcu: 	cpu 11 ->gp_seq_needed 330400
[ 1552.637539] rcu: 	cpu 12 ->gp_seq_needed 330400
[ 1552.638181] rcu: 	cpu 13 ->gp_seq_needed 330400
[ 1552.638837] rcu: 	cpu 14 ->gp_seq_needed 330400
[ 1552.639497] rcu: 	cpu 15 ->gp_seq_needed 330396
[ 1552.640168] rcu: 	cpu 16 ->gp_seq_needed 330400
[ 1552.640828] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 51687 S CPU 2
[ 1552.641748] rcu:    CB 0^0->2 KblSW F234 L234 C0 ..... q0 S CPU 10
[ 1552.642641] rcu:    CB 2^0->-1 KblSW F241 L241 C0 ..... q0 S CPU 15
[ 1552.643539] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1552.644478] rcu:    CB 4^4->7 KblSW F977474 L977483 C119 ..... q0 S CPU 2
[ 1552.645458] rcu:    CB 5^4->4 KblSW F942624 L942624 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1552.646813] rcu:    CB 7^4->-1 KblSW F958943 L958949 C16 ..... q0 S CPU 13
[ 1552.647797] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1552.648673] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1552.649578] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1552.650504] rcu: RCU callbacks invoked since boot: 3406340
[ 1552.651290] rcu_tasks: RTGS_WAIT_CBS(11) since 1552077 g:0 i:0 k.u.. l:250 
[ 1567.981295] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3250273 ni: 57815 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 4843
[ 1567.990904] rcu-torture: Reader Pipe:  3449636657 122018 0 0 0 0 0 0 0 0 0
[ 1567.991937] rcu-torture: Reader Batch:  3449223849 534826 0 0 0 0 0 0 0 0 0
[ 1567.992972] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1567.997364] ??? Writer stall state RTWS_EXP_SYNC(4) g332841 f0x0 ->state D cpu 1
[ 1567.998364] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 18 ->gp_activity 4 ->gp_req_activity 18 ->gp_wake_time 18 ->gp_wake_seq 332837 ->gp_seq 332841 ->gp_seq_needed 332840 ->gp_max 453 ->gp_flags 0x0
[ 1568.005600] rcu: 	rcu_node 0:16 ->gp_seq 332841 ->gp_seq_needed 332840 ->qsmask 0x1 .... ->n_boosts 0
[ 1568.006947] rcu: 	rcu_node 0:8 ->gp_seq 332841 ->gp_seq_needed 332848 ->qsmask 0x4 .... ->n_boosts 0
[ 1568.008362] rcu: 	cpu 0 ->gp_seq_needed 332848
[ 1568.009032] rcu: 	cpu 1 ->gp_seq_needed 332848
[ 1568.009739] rcu: 	cpu 2 ->gp_seq_needed 332848
[ 1568.010401] rcu: 	rcu_node 9:16 ->gp_seq 332841 ->gp_seq_needed 332848 ->qsmask 0x0 .... ->n_boosts 0
[ 1568.011749] rcu: 	cpu 9 ->gp_seq_needed 332848
[ 1568.012470] rcu: 	cpu 11 ->gp_seq_needed 332848
[ 1568.013148] rcu: 	cpu 12 ->gp_seq_needed 332848
[ 1568.013851] rcu: 	cpu 13 ->gp_seq_needed 332848
[ 1568.014523] rcu: 	cpu 14 ->gp_seq_needed 332848
[ 1568.015148] rcu: 	cpu 15 ->gp_seq_needed 332844
[ 1568.015816] rcu: 	cpu 16 ->gp_seq_needed 332848
[ 1568.016518] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 51776 S CPU 2
[ 1568.017518] rcu:    CB 0^0->2 KblSW F264 L264 C0 ..... q0 S CPU 10
[ 1568.018330] rcu:    CB 2^0->-1 KblSW F834 L834 C0 ..... q0 S CPU 15
[ 1568.019278] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1568.020273] rcu:    CB 4^4->7 KblSW F992849 L992858 C119 ..... q0 S CPU 2
[ 1568.021217] rcu:    CB 5^4->4 KblSW F957999 L957999 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1568.022562] rcu:    CB 7^4->-1 KblSW F974319 L974325 C16 ..... q0 S CPU 13
[ 1568.023609] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1568.024536] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1568.025493] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1568.026406] rcu: RCU callbacks invoked since boot: 3433774
[ 1568.027217] rcu_tasks: RTGS_WAIT_CBS(11) since 1567453 g:0 i:0 k.u.. l:250 
[ 1583.338490] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3290458 ni: 58529 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 6411
[ 1583.342175] rcu-torture: Reader Pipe:  3492345642 122018 0 0 0 0 0 0 0 0 0
[ 1583.343180] rcu-torture: Reader Batch:  3491926617 541043 0 0 0 0 0 0 0 0 0
[ 1583.344114] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1583.345474] ??? Writer stall state RTWS_EXP_SYNC(4) g336789 f0x0 ->state D cpu 1
[ 1583.346456] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 11 ->gp_activity 3 ->gp_req_activity 11 ->gp_wake_time 12 ->gp_wake_seq 336785 ->gp_seq 336789 ->gp_seq_needed 336788 ->gp_max 453 ->gp_flags 0x0
[ 1583.349372] rcu: 	rcu_node 0:16 ->gp_seq 336789 ->gp_seq_needed 336788 ->qsmask 0x1 .... ->n_boosts 0
[ 1583.350583] rcu: 	rcu_node 0:8 ->gp_seq 336789 ->gp_seq_needed 336796 ->qsmask 0x4 .... ->n_boosts 0
[ 1583.351788] rcu: 	cpu 1 ->gp_seq_needed 336796
[ 1583.352380] rcu: 	cpu 2 ->gp_seq_needed 336796
[ 1583.352985] rcu: 	cpu 8 ->gp_seq_needed 336796
[ 1583.353587] rcu: 	rcu_node 9:16 ->gp_seq 336789 ->gp_seq_needed 336796 ->qsmask 0x0 .... ->n_boosts 0
[ 1583.354926] rcu: 	cpu 9 ->gp_seq_needed 336796
[ 1583.355533] rcu: 	cpu 11 ->gp_seq_needed 336796
[ 1583.356134] rcu: 	cpu 12 ->gp_seq_needed 336796
[ 1583.356761] rcu: 	cpu 13 ->gp_seq_needed 336796
[ 1583.357378] rcu: 	cpu 14 ->gp_seq_needed 336796
[ 1583.357988] rcu: 	cpu 15 ->gp_seq_needed 336792
[ 1583.358615] rcu: 	cpu 16 ->gp_seq_needed 336796
[ 1583.359255] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 51927 S CPU 2
[ 1583.360116] rcu:    CB 0^0->2 KblSW F324 L324 C0 ..... q0 S CPU 10
[ 1583.360950] rcu:    CB 2^0->-1 KblSW F171 L171 C0 ..... q0 S CPU 15
[ 1583.361791] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1583.362669] rcu:    CB 4^4->7 KblSW F1008192 L1008201 C119 ..... q0 S CPU 2
[ 1583.363604] rcu:    CB 5^4->4 KblSW F973342 L973342 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1583.364810] rcu:    CB 7^4->-1 KblSW F989661 L989667 C16 ..... q0 S CPU 13
[ 1583.365724] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1583.366543] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1583.367376] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1583.368207] rcu: RCU callbacks invoked since boot: 3474674
[ 1583.368933] rcu_tasks: RTGS_WAIT_CBS(11) since 1582795 g:0 i:0 k.u.. l:250 
[ 1598.702079] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3317293 ni: 59007 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 7448
[ 1598.706201] rcu-torture: Reader Pipe:  3521123521 122018 0 0 0 0 0 0 0 0 0
[ 1598.707280] rcu-torture: Reader Batch:  3520700632 544907 0 0 0 0 0 0 0 0 0
[ 1598.708382] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1598.709869] ??? Writer stall state RTWS_EXP_SYNC(4) g339273 f0x0 ->state D cpu 1
[ 1598.711014] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 151 ->gp_activity 4 ->gp_req_activity 151 ->gp_wake_time 151 ->gp_wake_seq 339269 ->gp_seq 339273 ->gp_seq_needed 339272 ->gp_max 453 ->gp_flags 0x0
[ 1598.714221] rcu: 	rcu_node 0:16 ->gp_seq 339273 ->gp_seq_needed 339272 ->qsmask 0x2 .... ->n_boosts 0
[ 1598.715437] rcu: 	rcu_node 0:8 ->gp_seq 339273 ->gp_seq_needed 339280 ->qsmask 0x0 .... ->n_boosts 0
[ 1598.716726] rcu: 	cpu 1 ->gp_seq_needed 339280
[ 1598.717386] rcu: 	cpu 2 ->gp_seq_needed 339280
[ 1598.718073] rcu: 	cpu 8 ->gp_seq_needed 339280
[ 1598.718749] rcu: 	rcu_node 9:16 ->gp_seq 339273 ->gp_seq_needed 339280 ->qsmask 0x10 .... ->n_boosts 0
[ 1598.719999] rcu: 	cpu 9 ->gp_seq_needed 339280
[ 1598.720669] rcu: 	cpu 11 ->gp_seq_needed 339280
[ 1598.721360] rcu: 	cpu 12 ->gp_seq_needed 339280
[ 1598.722046] rcu: 	cpu 13 ->gp_seq_needed 339280
[ 1598.722755] rcu: 	cpu 14 ->gp_seq_needed 339280
[ 1598.723496] rcu: 	cpu 15 ->gp_seq_needed 339276
[ 1598.724196] rcu: 	cpu 16 ->gp_seq_needed 339280
[ 1598.724890] rcu: nocb GP 0 KldtS .[W.] .G:339280/169040 rnp 0:8 52013 S CPU 2
[ 1598.725910] rcu:    CB 0^0->2 KblSW F596 L596 C0 ..... q0 S CPU 10
[ 1598.726862] rcu:    CB 2^0->-1 KblSW F42 L42 C0 .W1(339280/169040)... q1 S CPU 15
[ 1598.727838] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1598.728825] rcu:    CB 4^4->7 KblSW F1023558 L1023567 C119 ..... q0 S CPU 2
[ 1598.729907] rcu:    CB 5^4->4 KblSW F988708 L988708 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1598.731322] rcu:    CB 7^4->-1 KblSW F1005027 L1005033 C16 ..... q0 S CPU 13
[ 1598.732411] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1598.733357] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1598.734334] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1598.735277] rcu: RCU callbacks invoked since boot: 3501645
[ 1598.736128] rcu_tasks: RTGS_WAIT_CBS(11) since 1598162 g:0 i:0 k.u.. l:250 
[ 1614.057528] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3355686 ni: 59691 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 9291
[ 1614.060490] rcu-torture: Reader Pipe:  3561923775 122018 0 0 0 0 0 0 0 0 0
[ 1614.061241] rcu-torture: Reader Batch:  3561494545 551248 0 0 0 0 0 0 0 0 0
[ 1614.061993] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1614.063075] ??? Writer stall state RTWS_EXP_SYNC(4) g343340 f0x0 ->state D cpu 1
[ 1614.063941] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 439 ->gp_activity 435 ->gp_req_activity 439 ->gp_wake_time 472 ->gp_wake_seq 343329 ->gp_seq 343340 ->gp_seq_needed 343340 ->gp_max 453 ->gp_flags 0x0
[ 1614.066334] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 52139 S CPU 2
[ 1614.067029] rcu:    CB 0^0->2 KblSW F2355 L2355 C0 ..... q0 S CPU 10
[ 1614.067721] rcu:    CB 2^0->-1 KblSW F660 L660 C1 ..... q0 S CPU 8
[ 1614.068388] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1614.069094] rcu:    CB 4^4->7 KblSW F1038898 L1038907 C119 ..... q0 S CPU 2
[ 1614.069838] rcu:    CB 5^4->4 KblSW F1004048 L1004048 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1614.070853] rcu:    CB 7^4->-1 KblSW F1020367 L1020373 C16 ..... q0 S CPU 13
[ 1614.071612] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1614.072270] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1614.072938] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1614.073633] rcu: RCU callbacks invoked since boot: 3541105
[ 1614.074226] rcu_tasks: RTGS_WAIT_CBS(11) since 1613500 g:0 i:0 k.u.. l:250 
[ 1629.418408] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3383586 ni: 60186 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 10066
[ 1629.422538] rcu-torture: Reader Pipe:  3590911694 122018 0 0 0 0 0 0 0 0 0
[ 1629.423651] rcu-torture: Reader Batch:  3590478905 554807 0 0 0 0 0 0 0 0 0
[ 1629.424772] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1629.426097] ??? Writer stall state RTWS_EXP_SYNC(4) g345637 f0x0 ->state D cpu 1
[ 1629.427184] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 197 ->gp_activity 3 ->gp_req_activity 197 ->gp_wake_time 215 ->gp_wake_seq 345625 ->gp_seq 345637 ->gp_seq_needed 345636 ->gp_max 453 ->gp_flags 0x0
[ 1629.430646] rcu: 	rcu_node 0:16 ->gp_seq 345637 ->gp_seq_needed 345636 ->qsmask 0x2 .... ->n_boosts 0
[ 1629.432050] rcu: 	rcu_node 0:8 ->gp_seq 345637 ->gp_seq_needed 345644 ->qsmask 0x0 .... ->n_boosts 0
[ 1629.433475] rcu: 	cpu 0 ->gp_seq_needed 345640
[ 1629.434170] rcu: 	cpu 1 ->gp_seq_needed 345644
[ 1629.434862] rcu: 	cpu 2 ->gp_seq_needed 345644
[ 1629.435568] rcu: 	cpu 8 ->gp_seq_needed 345644
[ 1629.436246] rcu: 	rcu_node 9:16 ->gp_seq 345637 ->gp_seq_needed 345644 ->qsmask 0x10 .... ->n_boosts 0
[ 1629.437424] rcu: 	cpu 9 ->gp_seq_needed 345644
[ 1629.438108] rcu: 	cpu 11 ->gp_seq_needed 345644
[ 1629.438769] rcu: 	cpu 12 ->gp_seq_needed 345644
[ 1629.439486] rcu: 	cpu 13 ->gp_seq_needed 345640
[ 1629.440130] rcu: 	cpu 14 ->gp_seq_needed 345644
[ 1629.440831] rcu: 	cpu 15 ->gp_seq_needed 345644
[ 1629.441514] rcu: 	cpu 16 ->gp_seq_needed 345644
[ 1629.442222] rcu: nocb GP 0 Kldts .[.W] .G:345644/169040 rnp 0:8 52236 S CPU 2
[ 1629.443279] rcu:    CB 0^0->2 KblSW F53 L53 C0 .W1(345644/169040)... q1 S CPU 10
[ 1629.444394] rcu:    CB 2^0->-1 KblSW F39 L39 C0 ...N1. q1 S CPU 8
[ 1629.445329] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1629.446330] rcu:    CB 4^4->7 KblSW F1054275 L1054284 C119 ..... q0 S CPU 2
[ 1629.447375] rcu:    CB 5^4->4 KblSW F1019425 L1019425 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1629.448609] rcu:    CB 7^4->-1 KblSW F1035745 L1035751 C16 ..... q0 S CPU 13
[ 1629.449710] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1629.450632] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1629.451596] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1629.452582] rcu: RCU callbacks invoked since boot: 3568970
[ 1629.453406] rcu_tasks: RTGS_WAIT_CBS(11) since 1628879 g:0 i:0 k.u.. l:250 
[ 1644.777523] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3410700 ni: 60672 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 11392
[ 1644.781608] rcu-torture: Reader Pipe:  3619571825 122018 0 0 0 0 0 0 0 0 0
[ 1644.782688] rcu-torture: Reader Batch:  3619134411 559432 0 0 0 0 0 0 0 0 0
[ 1644.783693] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1644.785207] ??? Writer stall state RTWS_EXP_SYNC(4) g348669 f0x0 ->state D cpu 1
[ 1644.786337] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 12 ->gp_activity 3 ->gp_req_activity 12 ->gp_wake_time 12 ->gp_wake_seq 348665 ->gp_seq 348669 ->gp_seq_needed 348668 ->gp_max 453 ->gp_flags 0x0
[ 1644.789417] rcu: 	rcu_node 0:16 ->gp_seq 348669 ->gp_seq_needed 348668 ->qsmask 0x1 .... ->n_boosts 0
[ 1644.790804] rcu: 	rcu_node 0:8 ->gp_seq 348669 ->gp_seq_needed 348672 ->qsmask 0x4 .... ->n_boosts 0
[ 1644.792151] rcu: 	cpu 0 ->gp_seq_needed 348672
[ 1644.792839] rcu: 	cpu 1 ->gp_seq_needed 348672
[ 1644.793515] rcu: 	cpu 2 ->gp_seq_needed 348672
[ 1644.794198] rcu: 	cpu 8 ->gp_seq_needed 348672
[ 1644.794854] rcu: 	rcu_node 9:16 ->gp_seq 348669 ->gp_seq_needed 348676 ->qsmask 0x0 .... ->n_boosts 0
[ 1644.796283] rcu: 	cpu 9 ->gp_seq_needed 348676
[ 1644.796940] rcu: 	cpu 11 ->gp_seq_needed 348676
[ 1644.797655] rcu: 	cpu 12 ->gp_seq_needed 348676
[ 1644.798364] rcu: 	cpu 13 ->gp_seq_needed 348676
[ 1644.799078] rcu: 	cpu 14 ->gp_seq_needed 348676
[ 1644.799705] rcu: 	cpu 15 ->gp_seq_needed 348676
[ 1644.800250] rcu: 	cpu 16 ->gp_seq_needed 348676
[ 1644.800954] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 52321 S CPU 2
[ 1644.801930] rcu:    CB 0^0->2 KblSW F189 L189 C0 ..... q0 S CPU 10
[ 1644.802896] rcu:    CB 2^0->-1 KblSW F5679 L5679 C0 ..... q0 S CPU 8
[ 1644.803855] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1644.804869] rcu:    CB 4^4->7 KblSW F1069634 L1069643 C119 ..... q0 S CPU 2
[ 1644.805918] rcu:    CB 5^4->4 KblSW F1034784 L1034784 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1644.807341] rcu:    CB 7^4->-1 KblSW F1051103 L1051109 C16 ..... q0 S CPU 13
[ 1644.808391] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1644.809299] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1644.810242] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1644.811010] rcu: RCU callbacks invoked since boot: 3597051
[ 1644.811812] rcu_tasks: RTGS_WAIT_CBS(11) since 1644238 g:0 i:0 k.u.. l:250 
[ 1660.137465] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3450949 ni: 61385 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 13280
[ 1660.141205] rcu-torture: Reader Pipe:  3662564414 122018 0 0 0 0 0 0 0 0 0
[ 1660.142161] rcu-torture: Reader Batch:  3662120401 566031 0 0 0 0 0 0 0 0 0
[ 1660.143104] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1660.144449] ??? Writer stall state RTWS_EXP_SYNC(4) g352961 f0x0 ->state D cpu 1
[ 1660.145438] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 2 ->gp_activity 2 ->gp_req_activity 2 ->gp_wake_time 3 ->gp_wake_seq 352957 ->gp_seq 352961 ->gp_seq_needed 352960 ->gp_max 453 ->gp_flags 0x0
[ 1660.148332] rcu: 	rcu_node 0:16 ->gp_seq 352961 ->gp_seq_needed 352960 ->qsmask 0x3 .... ->n_boosts 0
[ 1660.149562] rcu: 	rcu_node 0:8 ->gp_seq 352961 ->gp_seq_needed 352968 ->qsmask 0x1 .... ->n_boosts 0
[ 1660.150811] rcu: 	cpu 0 ->gp_seq_needed 352968
[ 1660.151412] rcu: 	cpu 1 ->gp_seq_needed 352968
[ 1660.152014] rcu: 	cpu 2 ->gp_seq_needed 352964
[ 1660.152613] rcu: 	cpu 8 ->gp_seq_needed 352968
[ 1660.153212] rcu: 	rcu_node 9:16 ->gp_seq 352961 ->gp_seq_needed 352968 ->qsmask 0x0 .... ->n_boosts 0
[ 1660.154438] rcu: 	cpu 9 ->gp_seq_needed 352968
[ 1660.155038] rcu: 	cpu 11 ->gp_seq_needed 352968
[ 1660.155649] rcu: 	cpu 13 ->gp_seq_needed 352968
[ 1660.156259] rcu: 	cpu 14 ->gp_seq_needed 352968
[ 1660.156867] rcu: 	cpu 15 ->gp_seq_needed 352968
[ 1660.157489] rcu: 	cpu 16 ->gp_seq_needed 352964
[ 1660.158098] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 52449 S CPU 2
[ 1660.158968] rcu:    CB 0^0->2 KblSW F330 L330 C0 ..... q0 S CPU 10
[ 1660.159798] rcu:    CB 2^0->-1 KblSW F29 L29 C0 ..... q0 S CPU 16
[ 1660.160620] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1660.161503] rcu:    CB 4^4->7 KblSW F1084991 L1085000 C119 ..... q0 S CPU 2
[ 1660.162448] rcu:    CB 5^4->4 KblSW F1050140 L1050140 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1660.163693] rcu:    CB 7^4->-1 KblSW F1066460 L1066466 C16 ..... q0 S CPU 13
[ 1660.164641] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1660.165462] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1660.166300] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1660.167144] rcu: RCU callbacks invoked since boot: 3638057
[ 1660.167883] rcu_tasks: RTGS_WAIT_CBS(11) since 1659593 g:0 i:0 k.u.. l:250 
[ 1675.497525] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3477905 ni: 61866 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 14368
[ 1675.501717] rcu-torture: Reader Pipe:  3691515810 122018 0 0 0 0 0 0 0 0 0
[ 1675.502812] rcu-torture: Reader Batch:  3691067967 569861 0 0 0 0 0 0 0 0 0
[ 1675.503890] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1675.505395] ??? Writer stall state RTWS_EXP_SYNC(4) g355433 f0x0 ->state D cpu 1
[ 1675.506521] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 5 ->gp_activity 1 ->gp_req_activity 5 ->gp_wake_time 42 ->gp_wake_seq 355425 ->gp_seq 355433 ->gp_seq_needed 355436 ->gp_max 453 ->gp_flags 0x0
[ 1675.509729] rcu: 	rcu_node 0:16 ->gp_seq 355433 ->gp_seq_needed 355436 ->qsmask 0x1 .... ->n_boosts 0
[ 1675.511163] rcu: 	rcu_node 0:8 ->gp_seq 355433 ->gp_seq_needed 355440 ->qsmask 0x104 .... ->n_boosts 0
[ 1675.512589] rcu: 	cpu 0 ->gp_seq_needed 355436
[ 1675.513314] rcu: 	cpu 1 ->gp_seq_needed 355440
[ 1675.513980] rcu: 	cpu 2 ->gp_seq_needed 355436
[ 1675.514633] rcu: 	cpu 8 ->gp_seq_needed 355440
[ 1675.515286] rcu: 	rcu_node 9:16 ->gp_seq 355433 ->gp_seq_needed 355440 ->qsmask 0x0 .... ->n_boosts 0
[ 1675.516654] rcu: 	cpu 9 ->gp_seq_needed 355440
[ 1675.517341] rcu: 	cpu 11 ->gp_seq_needed 355440
[ 1675.518034] rcu: 	cpu 13 ->gp_seq_needed 355440
[ 1675.518701] rcu: 	cpu 14 ->gp_seq_needed 355440
[ 1675.519366] rcu: 	cpu 15 ->gp_seq_needed 355440
[ 1675.520039] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 52533 S CPU 2
[ 1675.520996] rcu:    CB 0^0->2 KblSW F275 L275 C0 ..... q0 S CPU 10
[ 1675.521919] rcu:    CB 2^0->-1 KblSW F566 L566 C0 ..... q0 S CPU 16
[ 1675.522877] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1675.523883] rcu:    CB 4^4->7 KblSW F1100353 L1100362 C119 ..... q0 S CPU 2
[ 1675.525052] rcu:    CB 5^4->4 KblSW F1065503 L1065503 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1675.526476] rcu:    CB 7^4->-1 KblSW F1081823 L1081829 C16 ..... q0 S CPU 13
[ 1675.527594] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1675.528564] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1675.529515] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1675.530464] rcu: RCU callbacks invoked since boot: 3665384
[ 1675.531318] rcu_tasks: RTGS_WAIT_CBS(11) since 1674957 g:0 i:0 k.u.. l:250 
[ 1690.858294] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3517522 ni: 62564 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 15784
[ 1690.865777] rcu-torture: Reader Pipe:  3733403162 122018 0 0 0 0 0 0 0 0 0
[ 1690.866860] rcu-torture: Reader Batch:  3732949390 575790 0 0 0 0 0 0 0 0 0
[ 1690.867942] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1690.869486] ??? Writer stall state RTWS_EXP_SYNC(4) g359285 f0x0 ->state D cpu 1
[ 1690.870605] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 100 ->gp_activity 2 ->gp_req_activity 100 ->gp_wake_time 100 ->gp_wake_seq 359281 ->gp_seq 359285 ->gp_seq_needed 359284 ->gp_max 453 ->gp_flags 0x0
[ 1690.873968] rcu: 	rcu_node 0:16 ->gp_seq 359285 ->gp_seq_needed 359284 ->qsmask 0x2 .... ->n_boosts 0
[ 1690.875368] rcu: 	rcu_node 0:8 ->gp_seq 359285 ->gp_seq_needed 359292 ->qsmask 0x0 .... ->n_boosts 0
[ 1690.876813] rcu: 	cpu 0 ->gp_seq_needed 359292
[ 1690.877505] rcu: 	cpu 1 ->gp_seq_needed 359288
[ 1690.878200] rcu: 	cpu 2 ->gp_seq_needed 359288
[ 1690.878904] rcu: 	cpu 8 ->gp_seq_needed 359292
[ 1690.879597] rcu: 	rcu_node 9:16 ->gp_seq 359285 ->gp_seq_needed 359292 ->qsmask 0x0 ...G ->n_boosts 0
[ 1690.881061] rcu: 	cpu 9 ->gp_seq_needed 359292
[ 1690.881753] rcu: 	cpu 10 ->gp_seq_needed 359288
[ 1690.882440] rcu: 	cpu 11 ->gp_seq_needed 359292
[ 1690.883120] rcu: 	cpu 13 ->gp_seq_needed 359292
[ 1690.883836] rcu: 	cpu 14 ->gp_seq_needed 359292
[ 1690.884580] rcu: 	cpu 15 ->gp_seq_needed 359292
[ 1690.885287] rcu: 	cpu 16 ->gp_seq_needed 359288
[ 1690.885991] rcu: nocb GP 0 KldtS .[W.] .G:359288/169040 rnp 0:8 52868 S CPU 10
[ 1690.887109] rcu:    CB 0^0->2 KblSW F1479 L1479 C0 ..... q0 S CPU 12
[ 1690.888083] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W6(359288/169040).N54. q60 S CPU 16
[ 1690.889286] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1690.890253] rcu:    CB 4^4->7 KblSW F1115719 L1115728 C119 ..... q0 S CPU 2
[ 1690.891301] rcu:    CB 5^4->4 KblSW F1080869 L1080869 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1690.892700] rcu:    CB 7^4->-1 KblSW F1097189 L1097195 C16 ..... q0 S CPU 13
[ 1690.893742] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1690.894690] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1690.895697] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1690.896618] rcu: RCU callbacks invoked since boot: 3705574
[ 1690.897417] rcu_tasks: RTGS_WAIT_CBS(11) since 1690323 g:0 i:0 k.u.. l:250 
[ 1706.217475] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3543813 ni: 63032 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 16406
[ 1706.222078] rcu-torture: Reader Pipe:  3761217927 122018 0 0 0 0 0 0 0 0 0
[ 1706.223006] rcu-torture: Reader Batch:  3760760865 579080 0 0 0 0 0 0 0 0 0
[ 1706.223942] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1706.225279] ??? Writer stall state RTWS_EXP_SYNC(4) g361425 f0x0 ->state D cpu 1
[ 1706.226265] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 75 ->gp_activity 5 ->gp_req_activity 75 ->gp_wake_time 75 ->gp_wake_seq 361421 ->gp_seq 361425 ->gp_seq_needed 361424 ->gp_max 453 ->gp_flags 0x0
[ 1706.229159] rcu: 	rcu_node 0:16 ->gp_seq 361425 ->gp_seq_needed 361424 ->qsmask 0x2 .... ->n_boosts 0
[ 1706.230457] rcu: 	rcu_node 0:8 ->gp_seq 361425 ->gp_seq_needed 361432 ->qsmask 0x0 .... ->n_boosts 0
[ 1706.231677] rcu: 	cpu 0 ->gp_seq_needed 361432
[ 1706.232277] rcu: 	cpu 1 ->gp_seq_needed 361428
[ 1706.232912] rcu: 	cpu 2 ->gp_seq_needed 361432
[ 1706.233546] rcu: 	cpu 8 ->gp_seq_needed 361432
[ 1706.234145] rcu: 	rcu_node 9:16 ->gp_seq 361425 ->gp_seq_needed 361432 ->qsmask 0x4 .... ->n_boosts 0
[ 1706.235366] rcu: 	cpu 9 ->gp_seq_needed 361432
[ 1706.235988] rcu: 	cpu 10 ->gp_seq_needed 361432
[ 1706.236626] rcu: 	cpu 11 ->gp_seq_needed 361432
[ 1706.237235] rcu: 	cpu 12 ->gp_seq_needed 361432
[ 1706.237889] rcu: 	cpu 13 ->gp_seq_needed 361432
[ 1706.238495] rcu: 	cpu 14 ->gp_seq_needed 361432
[ 1706.239150] rcu: 	cpu 15 ->gp_seq_needed 361432
[ 1706.239763] rcu: 	cpu 16 ->gp_seq_needed 361432
[ 1706.240366] rcu: nocb GP 0 KldtS .[W.] .G:361432/169040 rnp 0:8 53147 S CPU 10
[ 1706.241347] rcu:    CB 0^0->2 KblSW F442 L442 C0 .W1(361432/169040)... q1 S CPU 12
[ 1706.242401] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W111(361432/169040).N35. q146 S CPU 16
[ 1706.243473] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1706.244345] rcu:    CB 4^4->7 KblSW F1131073 L1131082 C119 ..... q0 S CPU 2
[ 1706.245290] rcu:    CB 5^4->4 KblSW F1096223 L1096223 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1706.246556] rcu:    CB 7^4->-1 KblSW F1112543 L1112549 C16 ..... q0 S CPU 13
[ 1706.247504] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1706.248319] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1706.249159] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1706.250002] rcu: RCU callbacks invoked since boot: 3730990
[ 1706.250736] rcu_tasks: RTGS_WAIT_CBS(11) since 1705677 g:0 i:0 k.u.. l:250 
[ 1721.577487] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3572511 ni: 63549 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 17163
[ 1721.580479] rcu-torture: Reader Pipe:  3792368811 122018 0 0 0 0 0 0 0 0 0
[ 1721.581230] rcu-torture: Reader Batch:  3791907543 583286 0 0 0 0 0 0 0 0 0
[ 1721.581994] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1721.583213] ??? Writer stall state RTWS_EXP_SYNC(4) g364140 f0x0 ->state D cpu 1
[ 1721.584349] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 3858 ->gp_activity 3854 ->gp_req_activity 3858 ->gp_wake_time 3871 ->gp_wake_seq 364125 ->gp_seq 364140 ->gp_seq_needed 364140 ->gp_max 453 ->gp_flags 0x0
[ 1721.587766] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 53499 S CPU 12
[ 1721.588777] rcu:    CB 0^0->2 KblSW F4186 L4186 C0 ..... q0 S CPU 10
[ 1721.589578] rcu:    CB 2^0->-1 KblSW F3978 L3978 C0 ..... q0 S CPU 16
[ 1721.590330] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1721.591046] rcu:    CB 4^4->7 KblSW F1146420 L1146429 C119 ..... q0 S CPU 2
[ 1721.591803] rcu:    CB 5^4->4 KblSW F1111570 L1111570 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1721.592803] rcu:    CB 7^4->-1 KblSW F1127889 L1127895 C16 ..... q0 S CPU 13
[ 1721.593558] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1721.594218] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1721.594903] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1721.595575] rcu: RCU callbacks invoked since boot: 3761788
[ 1721.596185] rcu_tasks: RTGS_WAIT_CBS(11) since 1721022 g:0 i:0 k.u.. l:250 
[ 1736.937516] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3608875 ni: 64201 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 17877
[ 1736.945155] rcu-torture: Reader Pipe:  3831557491 122018 0 0 0 0 0 0 0 0 0
[ 1736.948473] rcu-torture: Reader Batch:  3831091216 588293 0 0 0 0 0 0 0 0 0
[ 1736.950150] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1736.953686] ??? Writer stall state RTWS_EXP_SYNC(4) g367313 f0x0 ->state D cpu 1
[ 1736.954886] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 243 ->gp_activity 3 ->gp_req_activity 243 ->gp_wake_time 260 ->gp_wake_seq 367309 ->gp_seq 367313 ->gp_seq_needed 367316 ->gp_max 453 ->gp_flags 0x0
[ 1736.962585] rcu: 	rcu_node 0:16 ->gp_seq 367313 ->gp_seq_needed 367316 ->qsmask 0x2 .... ->n_boosts 0
[ 1736.964817] rcu: 	rcu_node 0:8 ->gp_seq 367313 ->gp_seq_needed 367320 ->qsmask 0x0 .... ->n_boosts 0
[ 1736.966375] rcu: 	cpu 0 ->gp_seq_needed 367320
[ 1736.967077] rcu: 	cpu 1 ->gp_seq_needed 367316
[ 1736.967749] rcu: 	cpu 2 ->gp_seq_needed 367320
[ 1736.968482] rcu: 	cpu 8 ->gp_seq_needed 367320
[ 1736.970027] rcu: 	rcu_node 9:16 ->gp_seq 367313 ->gp_seq_needed 367320 ->qsmask 0x0 ...G ->n_boosts 0
[ 1736.973493] rcu: 	cpu 9 ->gp_seq_needed 367320
[ 1736.974164] rcu: 	cpu 10 ->gp_seq_needed 367320
[ 1736.975777] rcu: 	cpu 11 ->gp_seq_needed 367320
[ 1736.976529] rcu: 	cpu 12 ->gp_seq_needed 367316
[ 1736.977706] rcu: 	cpu 13 ->gp_seq_needed 367320
[ 1736.978397] rcu: 	cpu 14 ->gp_seq_needed 367320
[ 1736.980670] rcu: 	cpu 15 ->gp_seq_needed 367320
[ 1736.982319] rcu: 	cpu 16 ->gp_seq_needed 367316
[ 1736.983893] rcu: nocb GP 0 Kldts .[.W] .G:367316/169040 rnp 0:8 53912 S CPU 12
[ 1736.985945] rcu:    CB 0^0->2 KblSW F23 L23 C0 ...N2. q2 S CPU 10
[ 1736.986892] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W17(367316/169040).N116. q133 S CPU 16
[ 1736.988640] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1736.990561] rcu:    CB 4^4->7 KblSW F1161819 L1161828 C119 ..... q0 S CPU 2
[ 1736.992663] rcu:    CB 5^4->4 KblSW F1126971 L1126971 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1736.995929] rcu:    CB 7^4->-1 KblSW F1143291 L1143297 C16 ..... q0 S CPU 13
[ 1736.998085] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1736.999555] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1737.001089] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1737.002585] rcu: RCU callbacks invoked since boot: 3798080
[ 1737.003442] rcu_tasks: RTGS_WAIT_CBS(11) since 1736430 g:0 i:0 k.u.. l:250 
[ 1752.299756] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3636229 ni: 64692 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 18528
[ 1752.304383] rcu-torture: Reader Pipe:  3860954818 122018 0 0 0 0 0 0 0 0 0
[ 1752.305462] rcu-torture: Reader Batch:  3860484150 592686 0 0 0 0 0 0 0 0 0
[ 1752.306503] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1752.308043] ??? Writer stall state RTWS_EXP_SYNC(4) g370117 f0x2 ->state D cpu 1
[ 1752.309170] rcu: rcu_preempt: wait state: RCU_GP_CLEANUP(7) ->state: I ->rt_priority 0 delta ->gp_start 47 ->gp_activity 3 ->gp_req_activity 47 ->gp_wake_time 12 ->gp_wake_seq 370117 ->gp_seq 370117 ->gp_seq_needed 370124 ->gp_max 453 ->gp_flags 0x2
[ 1752.312472] rcu: 	rcu_node 0:16 ->gp_seq 370121 ->gp_seq_needed 370124 ->qsmask 0x3 .... ->n_boosts 0
[ 1752.313870] rcu: 	rcu_node 0:8 ->gp_seq 370121 ->gp_seq_needed 370128 ->qsmask 0x1 .... ->n_boosts 0
[ 1752.315158] rcu: 	cpu 0 ->gp_seq_needed 370128
[ 1752.315819] rcu: 	cpu 1 ->gp_seq_needed 370124
[ 1752.316513] rcu: 	cpu 2 ->gp_seq_needed 370128
[ 1752.317130] rcu: 	cpu 8 ->gp_seq_needed 370128
[ 1752.317784] rcu: 	rcu_node 9:16 ->gp_seq 370121 ->gp_seq_needed 370128 ->qsmask 0x0 .... ->n_boosts 0
[ 1752.319168] rcu: 	cpu 9 ->gp_seq_needed 370128
[ 1752.319833] rcu: 	cpu 10 ->gp_seq_needed 370128
[ 1752.320505] rcu: 	cpu 11 ->gp_seq_needed 370128
[ 1752.321224] rcu: 	cpu 12 ->gp_seq_needed 370124
[ 1752.321957] rcu: 	cpu 13 ->gp_seq_needed 370128
[ 1752.322639] rcu: 	cpu 14 ->gp_seq_needed 370128
[ 1752.323304] rcu: 	cpu 15 ->gp_seq_needed 370128
[ 1752.324015] rcu: 	cpu 16 ->gp_seq_needed 370124
[ 1752.324624] rcu: nocb GP 0 KldtS .[.W] .G:370124/169040 rnp 0:8 54276 S CPU 12
[ 1752.325610] rcu:    CB 0^0->2 KblSW F313 L313 C0 ..... q0 S CPU 10
[ 1752.326507] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W14(370124/169040).N8. q22 S CPU 16
[ 1752.327688] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1752.328675] rcu:    CB 4^4->7 KblSW F1177158 L1177167 C119 ..... q0 S CPU 2
[ 1752.329777] rcu:    CB 5^4->4 KblSW F1142308 L1142308 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1752.331206] rcu:    CB 7^4->-1 KblSW F1158627 L1158633 C16 ..... q0 S CPU 13
[ 1752.332267] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1752.333210] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1752.334158] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1752.335071] rcu: RCU callbacks invoked since boot: 3826543
[ 1752.335790] rcu_tasks: RTGS_WAIT_CBS(11) since 1751762 g:0 i:0 k.u.. l:250 
[ 1767.657460] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3675533 ni: 65402 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 20000
[ 1767.661437] rcu-torture: Reader Pipe:  3903839229 122018 0 0 0 0 0 0 0 0 0
[ 1767.662529] rcu-torture: Reader Batch:  3903362603 598644 0 0 0 0 0 0 0 0 0
[ 1767.663602] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1767.665116] ??? Writer stall state RTWS_EXP_SYNC(4) g373977 f0x0 ->state D cpu 1
[ 1767.666196] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 5 ->gp_activity 1 ->gp_req_activity 5 ->gp_wake_time 5 ->gp_wake_seq 373973 ->gp_seq 373977 ->gp_seq_needed 373976 ->gp_max 453 ->gp_flags 0x0
[ 1767.669374] rcu: 	rcu_node 0:16 ->gp_seq 373977 ->gp_seq_needed 373976 ->qsmask 0x3 .... ->n_boosts 0
[ 1767.670694] rcu: 	rcu_node 0:8 ->gp_seq 373977 ->gp_seq_needed 373980 ->qsmask 0x1 .... ->n_boosts 0
[ 1767.671974] rcu: 	cpu 0 ->gp_seq_needed 373980
[ 1767.672688] rcu: 	cpu 1 ->gp_seq_needed 373980
[ 1767.673374] rcu: 	cpu 8 ->gp_seq_needed 373980
[ 1767.674051] rcu: 	rcu_node 9:16 ->gp_seq 373977 ->gp_seq_needed 373984 ->qsmask 0x0 .... ->n_boosts 0
[ 1767.675382] rcu: 	cpu 9 ->gp_seq_needed 373984
[ 1767.676074] rcu: 	cpu 10 ->gp_seq_needed 373984
[ 1767.676744] rcu: 	cpu 11 ->gp_seq_needed 373984
[ 1767.677368] rcu: 	cpu 13 ->gp_seq_needed 373984
[ 1767.678007] rcu: 	cpu 14 ->gp_seq_needed 373984
[ 1767.678696] rcu: 	cpu 15 ->gp_seq_needed 373984
[ 1767.679373] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 54598 S CPU 12
[ 1767.680395] rcu:    CB 0^0->2 KblSW F142 L142 C0 ..... q0 S CPU 16
[ 1767.681334] rcu:    CB 2^0->-1 KblSW F175 L175 C0 ..... q0 S CPU 0
[ 1767.682294] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1767.683288] rcu:    CB 4^4->7 KblSW F1192512 L1192521 C119 ..... q0 S CPU 2
[ 1767.684305] rcu:    CB 5^4->4 KblSW F1157662 L1157662 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1767.685738] rcu:    CB 7^4->-1 KblSW F1173982 L1173988 C16 ..... q0 S CPU 13
[ 1767.686777] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1767.687713] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1767.688703] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1767.689663] rcu: RCU callbacks invoked since boot: 3866636
[ 1767.690510] rcu_tasks: RTGS_WAIT_CBS(11) since 1767117 g:0 i:0 k.u.. l:250 
[ 1783.017460] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3701822 ni: 65873 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 20944
[ 1783.023382] rcu-torture: Reader Pipe:  3932350381 122018 0 0 0 0 0 0 0 0 0
[ 1783.024310] rcu-torture: Reader Batch:  3931870444 601955 0 0 0 0 0 0 0 0 0
[ 1783.025241] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1783.029444] ??? Writer stall state RTWS_EXP_SYNC(4) g376085 f0x0 ->state D cpu 1
[ 1783.031672] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 11 ->gp_activity 2 ->gp_req_activity 11 ->gp_wake_time 11 ->gp_wake_seq 376081 ->gp_seq 376085 ->gp_seq_needed 376084 ->gp_max 453 ->gp_flags 0x0
[ 1783.035829] rcu: 	rcu_node 0:16 ->gp_seq 376085 ->gp_seq_needed 376084 ->qsmask 0x1 .... ->n_boosts 0
[ 1783.038934] rcu: 	rcu_node 0:8 ->gp_seq 376085 ->gp_seq_needed 376092 ->qsmask 0x1 .... ->n_boosts 0
[ 1783.043141] rcu: 	cpu 0 ->gp_seq_needed 376092
[ 1783.043810] rcu: 	cpu 1 ->gp_seq_needed 376088
[ 1783.044399] rcu: 	cpu 8 ->gp_seq_needed 376092
[ 1783.045000] rcu: 	rcu_node 9:16 ->gp_seq 376085 ->gp_seq_needed 376092 ->qsmask 0x0 .... ->n_boosts 0
[ 1783.046214] rcu: 	cpu 9 ->gp_seq_needed 376092
[ 1783.046864] rcu: 	cpu 10 ->gp_seq_needed 376092
[ 1783.047464] rcu: 	cpu 11 ->gp_seq_needed 376092
[ 1783.048067] rcu: 	cpu 14 ->gp_seq_needed 376092
[ 1783.048675] rcu: 	cpu 15 ->gp_seq_needed 376092
[ 1783.049271] rcu: 	cpu 16 ->gp_seq_needed 376092
[ 1783.049881] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 54691 S CPU 12
[ 1783.050749] rcu:    CB 0^0->2 KblSW F539 L539 C0 ..... q0 S CPU 13
[ 1783.051576] rcu:    CB 2^0->-1 KblSW F86 L86 C0 ..... q0 S CPU 0
[ 1783.052368] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1783.053239] rcu:    CB 4^4->7 KblSW F1207882 L1207891 C119 ..... q0 S CPU 2
[ 1783.057030] rcu:    CB 5^4->4 KblSW F1173035 L1173035 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1783.058273] rcu:    CB 7^4->-1 KblSW F1189354 L1189360 C16 ..... q0 S CPU 13
[ 1783.059238] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1783.060098] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1783.060996] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1783.061829] rcu: RCU callbacks invoked since boot: 3893393
[ 1783.065413] rcu_tasks: RTGS_WAIT_CBS(11) since 1782491 g:0 i:0 k.u.. l:250 
[ 1798.377515] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3735016 ni: 66463 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 22821
[ 1798.380463] rcu-torture: Reader Pipe:  3968462287 122018 0 0 0 0 0 0 0 0 0
[ 1798.381198] rcu-torture: Reader Batch:  3967976897 607408 0 0 0 0 0 0 0 0 0
[ 1798.381955] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1798.383035] ??? Writer stall state RTWS_EXP_SYNC(4) g379600 f0x0 ->state D cpu 1
[ 1798.383828] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 2637 ->gp_activity 2632 ->gp_req_activity 2637 ->gp_wake_time 2646 ->gp_wake_seq 379589 ->gp_seq 379600 ->gp_seq_needed 379600 ->gp_max 453 ->gp_flags 0x0
[ 1798.386245] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 54820 S CPU 12
[ 1798.386980] rcu:    CB 0^0->2 KblSW F3270 L3270 C0 ..... q0 S CPU 13
[ 1798.387672] rcu:    CB 2^0->-1 KblSW F2955 L2955 C0 ..... q0 S CPU 0
[ 1798.388348] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1798.389055] rcu:    CB 4^4->7 KblSW F1223218 L1223227 C119 ..... q0 S CPU 2
[ 1798.389807] rcu:    CB 5^4->4 KblSW F1188368 L1188368 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1798.390801] rcu:    CB 7^4->-1 KblSW F1204687 L1204693 C16 ..... q0 S CPU 13
[ 1798.391560] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1798.392209] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1798.392886] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1798.393561] rcu: RCU callbacks invoked since boot: 3927207
[ 1798.394158] rcu_tasks: RTGS_WAIT_CBS(11) since 1797820 g:0 i:0 k.u.. l:250 
[ 1801.666756] rcu-torture: Disabling gpwrap lag (value=0)
[ 1813.738471] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3768676 ni: 67072 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1813.742437] rcu-torture: Reader Pipe:  4004716374 122018 0 0 0 0 0 0 0 0 0
[ 1813.743520] rcu-torture: Reader Batch:  4004225892 612500 0 0 0 0 0 0 0 0 0
[ 1813.744615] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1813.746181] ??? Writer stall state RTWS_EXP_SYNC(4) g382877 f0x0 ->state D cpu 1
[ 1813.747302] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 6 ->gp_activity 6 ->gp_req_activity 6 ->gp_wake_time 6 ->gp_wake_seq 382873 ->gp_seq 382877 ->gp_seq_needed 382876 ->gp_max 453 ->gp_flags 0x0
[ 1813.750512] rcu: 	rcu_node 0:16 ->gp_seq 382877 ->gp_seq_needed 382876 ->qsmask 0x3 .... ->n_boosts 0
[ 1813.751760] rcu: 	rcu_node 0:8 ->gp_seq 382877 ->gp_seq_needed 382884 ->qsmask 0x1 .... ->n_boosts 0
[ 1813.753138] rcu: 	cpu 0 ->gp_seq_needed 382884
[ 1813.753837] rcu: 	cpu 1 ->gp_seq_needed 382880
[ 1813.754508] rcu: 	cpu 2 ->gp_seq_needed 382884
[ 1813.755195] rcu: 	cpu 8 ->gp_seq_needed 382884
[ 1813.755896] rcu: 	rcu_node 9:16 ->gp_seq 382877 ->gp_seq_needed 382884 ->qsmask 0x0 .... ->n_boosts 0
[ 1813.757318] rcu: 	cpu 9 ->gp_seq_needed 382884
[ 1813.758021] rcu: 	cpu 10 ->gp_seq_needed 382884
[ 1813.758707] rcu: 	cpu 11 ->gp_seq_needed 382884
[ 1813.759421] rcu: 	cpu 12 ->gp_seq_needed 382884
[ 1813.760100] rcu: 	cpu 13 ->gp_seq_needed 382884
[ 1813.761906] rcu: 	cpu 14 ->gp_seq_needed 382880
[ 1813.762652] rcu: 	cpu 16 ->gp_seq_needed 382884
[ 1813.766244] rcu: nocb GP 0 KldtS .[.W] .G:382884/169040 rnp 0:8 55168 S CPU 12
[ 1813.767087] rcu:    CB 0^0->2 KblSW F461 L461 C0 ..... q0 S CPU 13
[ 1813.767761] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W5(382884/169040).N9. q14 S CPU 13
[ 1813.768594] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1813.769306] rcu:    CB 4^4->7 KblSW F1238598 L1238607 C119 ..... q0 S CPU 2
[ 1813.770153] rcu:    CB 5^4->4 KblSW F1203748 L1203748 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1813.771215] rcu:    CB 7^4->-1 KblSW F1220067 L1220073 C16 ..... q0 S CPU 13
[ 1813.772044] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1813.772925] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1813.773918] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1813.774798] rcu: RCU callbacks invoked since boot: 3961455
[ 1813.775654] rcu_tasks: RTGS_WAIT_CBS(11) since 1813202 g:0 i:0 k.u.. l:250 
[ 1829.097469] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3794642 ni: 67536 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1829.101122] rcu-torture: Reader Pipe:  4032544231 122018 0 0 0 0 0 0 0 0 0
[ 1829.102051] rcu-torture: Reader Batch:  4032049906 616343 0 0 0 0 0 0 0 0 0
[ 1829.102986] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1829.104333] ??? Writer stall state RTWS_EXP_SYNC(4) g385337 f0x0 ->state D cpu 1
[ 1829.105308] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 32 ->gp_activity 0 ->gp_req_activity 32 ->gp_wake_time 32 ->gp_wake_seq 385333 ->gp_seq 385337 ->gp_seq_needed 385336 ->gp_max 453 ->gp_flags 0x0
[ 1829.108216] rcu: 	rcu_node 0:16 ->gp_seq 385337 ->gp_seq_needed 385336 ->qsmask 0x2 .... ->n_boosts 0
[ 1829.109445] rcu: 	rcu_node 0:8 ->gp_seq 385337 ->gp_seq_needed 385344 ->qsmask 0x0 .... ->n_boosts 0
[ 1829.110652] rcu: 	cpu 0 ->gp_seq_needed 385340
[ 1829.111241] rcu: 	cpu 1 ->gp_seq_needed 385344
[ 1829.111864] rcu: 	cpu 2 ->gp_seq_needed 385344
[ 1829.112469] rcu: 	cpu 8 ->gp_seq_needed 385344
[ 1829.113061] rcu: 	rcu_node 9:16 ->gp_seq 385337 ->gp_seq_needed 385344 ->qsmask 0x4 .... ->n_boosts 0
[ 1829.114285] rcu: 	cpu 9 ->gp_seq_needed 385344
[ 1829.114890] rcu: 	cpu 10 ->gp_seq_needed 385340
[ 1829.115507] rcu: 	cpu 11 ->gp_seq_needed 385344
[ 1829.116109] rcu: 	cpu 12 ->gp_seq_needed 385344
[ 1829.116721] rcu: 	cpu 13 ->gp_seq_needed 385344
[ 1829.117331] rcu: 	cpu 14 ->gp_seq_needed 385344
[ 1829.117940] rcu: 	cpu 15 ->gp_seq_needed 385344
[ 1829.118552] rcu: 	cpu 16 ->gp_seq_needed 385344
[ 1829.119155] rcu: nocb GP 0 KldtS .[.W] .G:385340/169040 rnp 0:8 55487 S CPU 12
[ 1829.120121] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W11(385340/169040).N179. q190 S CPU 13
[ 1829.121151] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W8(385340/169040).N20. q28 S CPU 15
[ 1829.122161] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1829.123039] rcu:    CB 4^4->7 KblSW F1253952 L1253961 C119 ..... q0 S CPU 2
[ 1829.123972] rcu:    CB 5^4->4 KblSW F1219102 L1219102 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1829.125209] rcu:    CB 7^4->-1 KblSW F1235421 L1235427 C16 ..... q0 S CPU 13
[ 1829.126150] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1829.126970] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1829.127814] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1829.128656] rcu: RCU callbacks invoked since boot: 3987131
[ 1829.129392] rcu_tasks: RTGS_WAIT_CBS(11) since 1828555 g:0 i:0 k.u.. l:250 
[ 1844.458467] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3834338 ni: 68238 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1844.462651] rcu-torture: Reader Pipe:  4075165778 122018 0 0 0 0 0 0 0 0 0
[ 1844.463736] rcu-torture: Reader Batch:  4074665718 622078 0 0 0 0 0 0 0 0 0
[ 1844.464787] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1844.466315] ??? Writer stall state RTWS_EXP_SYNC(4) g389009 f0x0 ->state D cpu 1
[ 1844.467288] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 14 ->gp_activity 0 ->gp_req_activity 14 ->gp_wake_time 18 ->gp_wake_seq 389001 ->gp_seq 389009 ->gp_seq_needed 389008 ->gp_max 453 ->gp_flags 0x0
[ 1844.470495] rcu: 	rcu_node 0:16 ->gp_seq 389009 ->gp_seq_needed 389008 ->qsmask 0x1 .... ->n_boosts 0
[ 1844.471881] rcu: 	rcu_node 0:8 ->gp_seq 389009 ->gp_seq_needed 389012 ->qsmask 0x2 .... ->n_boosts 0
[ 1844.473204] rcu: 	cpu 0 ->gp_seq_needed 389012
[ 1844.473871] rcu: 	cpu 1 ->gp_seq_needed 389012
[ 1844.474541] rcu: 	cpu 2 ->gp_seq_needed 389012
[ 1844.475228] rcu: 	cpu 8 ->gp_seq_needed 389012
[ 1844.475929] rcu: 	rcu_node 9:16 ->gp_seq 389009 ->gp_seq_needed 389016 ->qsmask 0x0 .... ->n_boosts 0
[ 1844.477294] rcu: 	cpu 9 ->gp_seq_needed 389016
[ 1844.477959] rcu: 	cpu 10 ->gp_seq_needed 389012
[ 1844.478480] rcu: 	cpu 11 ->gp_seq_needed 389016
[ 1844.479180] rcu: 	cpu 13 ->gp_seq_needed 389012
[ 1844.479893] rcu: 	cpu 14 ->gp_seq_needed 389016
[ 1844.480576] rcu: 	cpu 15 ->gp_seq_needed 389016
[ 1844.481283] rcu: 	cpu 16 ->gp_seq_needed 389016
[ 1844.481957] rcu: nocb GP 0 KldtS .[.W] .G:389012/169040 rnp 0:8 55984 S CPU 13
[ 1844.483025] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W8(389012/169040).N12. q20 S CPU 1
[ 1844.484143] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W6(389012/169040).N14. q20 S CPU 8
[ 1844.485309] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1844.486258] rcu:    CB 4^4->7 KblSW F1269315 L1269324 C119 ..... q0 S CPU 2
[ 1844.487352] rcu:    CB 5^4->4 KblSW F1234465 L1234465 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1844.488759] rcu:    CB 7^4->-1 KblSW F1250785 L1250791 C16 ..... q0 S CPU 13
[ 1844.489742] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1844.490651] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1844.491632] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1844.492576] rcu: RCU callbacks invoked since boot: 4028252
[ 1844.493368] rcu_tasks: RTGS_WAIT_CBS(11) since 1843919 g:0 i:0 k.u.. l:250 
[ 1859.817468] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3860915 ni: 68716 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1859.821552] rcu-torture: Reader Pipe:  4103979327 122018 0 0 0 0 0 0 0 0 0
[ 1859.822626] rcu-torture: Reader Batch:  4103475429 625916 0 0 0 0 0 0 0 0 0
[ 1859.823664] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1859.825177] ??? Writer stall state RTWS_EXP_SYNC(4) g391465 f0x0 ->state D cpu 1
[ 1859.826325] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 6 ->gp_activity 2 ->gp_req_activity 6 ->gp_wake_time 6 ->gp_wake_seq 391461 ->gp_seq 391465 ->gp_seq_needed 391464 ->gp_max 453 ->gp_flags 0x0
[ 1859.829613] rcu: 	rcu_node 0:16 ->gp_seq 391465 ->gp_seq_needed 391464 ->qsmask 0x1 .... ->n_boosts 0
[ 1859.830999] rcu: 	rcu_node 0:8 ->gp_seq 391465 ->gp_seq_needed 391472 ->qsmask 0x1 .... ->n_boosts 0
[ 1859.832397] rcu: 	cpu 0 ->gp_seq_needed 391472
[ 1859.833068] rcu: 	cpu 1 ->gp_seq_needed 391472
[ 1859.833750] rcu: 	cpu 2 ->gp_seq_needed 391468
[ 1859.834445] rcu: 	cpu 8 ->gp_seq_needed 391472
[ 1859.835063] rcu: 	rcu_node 9:16 ->gp_seq 391465 ->gp_seq_needed 391472 ->qsmask 0x0 .... ->n_boosts 0
[ 1859.836405] rcu: 	cpu 10 ->gp_seq_needed 391468
[ 1859.837087] rcu: 	cpu 11 ->gp_seq_needed 391472
[ 1859.837776] rcu: 	cpu 12 ->gp_seq_needed 391472
[ 1859.838471] rcu: 	cpu 13 ->gp_seq_needed 391472
[ 1859.839155] rcu: 	cpu 14 ->gp_seq_needed 391472
[ 1859.839854] rcu: 	cpu 15 ->gp_seq_needed 391472
[ 1859.840563] rcu: 	cpu 16 ->gp_seq_needed 391472
[ 1859.841267] rcu: nocb GP 0 KldtS .[W.] .G:391472/169040 rnp 0:8 56305 S CPU 13
[ 1859.842353] rcu:    CB 0^0->2 KblSW F399 L399 C0 ..... q0 S CPU 0
[ 1859.843297] rcu:    CB 2^0->-1 KblSW F0 L0 C1 .W7(391472/169040).N9. q16 S CPU 8
[ 1859.844436] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1859.845451] rcu:    CB 4^4->7 KblSW F1284675 L1284684 C119 ..... q0 S CPU 2
[ 1859.846498] rcu:    CB 5^4->4 KblSW F1249825 L1249825 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1859.847894] rcu:    CB 7^4->-1 KblSW F1266144 L1266150 C16 ..... q0 S CPU 13
[ 1859.848946] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1859.849762] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1859.850633] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1859.851566] rcu: RCU callbacks invoked since boot: 4055329
[ 1859.852375] rcu_tasks: RTGS_WAIT_CBS(11) since 1859278 g:0 i:0 k.u.. l:250 
[ 1875.177495] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3896888 ni: 69349 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1875.180451] rcu-torture: Reader Pipe:  4142183530 122018 0 0 0 0 0 0 0 0 0
[ 1875.181214] rcu-torture: Reader Batch:  4141674544 631004 0 0 0 0 0 0 0 0 0
[ 1875.181965] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1875.183045] ??? Writer stall state RTWS_EXP_SYNC(4) g394692 f0x0 ->state D cpu 1
[ 1875.183840] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 1569 ->gp_activity 1565 ->gp_req_activity 1569 ->gp_wake_time 1578 ->gp_wake_seq 394677 ->gp_seq 394692 ->gp_seq_needed 394692 ->gp_max 453 ->gp_flags 0x0
[ 1875.186271] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 56723 S CPU 13
[ 1875.186973] rcu:    CB 0^0->2 KblSW F1905 L1905 C0 ..... q0 S CPU 0
[ 1875.187691] rcu:    CB 2^0->-1 KblSW F1582 L1582 C0 ..... q0 S CPU 8
[ 1875.188401] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1875.189104] rcu:    CB 4^4->7 KblSW F1300018 L1300027 C119 ..... q0 S CPU 2
[ 1875.189860] rcu:    CB 5^4->4 KblSW F1265168 L1265168 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1875.190862] rcu:    CB 7^4->-1 KblSW F1281487 L1281493 C16 ..... q0 S CPU 13
[ 1875.191630] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1875.192290] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1875.192961] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1875.193648] rcu: RCU callbacks invoked since boot: 4091965
[ 1875.194242] rcu_tasks: RTGS_WAIT_CBS(11) since 1874620 g:0 i:0 k.u.. l:250 
[ 1890.539390] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3928017 ni: 69902 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1890.543337] rcu-torture: Reader Pipe:  4175710619 122018 0 0 0 0 0 0 0 0 0
[ 1890.544354] rcu-torture: Reader Batch:  4175196779 635858 0 0 0 0 0 0 0 0 0
[ 1890.546205] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1890.547746] ??? Writer stall state RTWS_EXP_SYNC(4) g397785 f0x0 ->state D cpu 1
[ 1890.548900] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 153 ->gp_activity 6 ->gp_req_activity 153 ->gp_wake_time 153 ->gp_wake_seq 397781 ->gp_seq 397785 ->gp_seq_needed 397784 ->gp_max 453 ->gp_flags 0x0
[ 1890.552026] rcu: 	rcu_node 0:16 ->gp_seq 397785 ->gp_seq_needed 397784 ->qsmask 0x2 .... ->n_boosts 0
[ 1890.554108] rcu: 	rcu_node 0:8 ->gp_seq 397785 ->gp_seq_needed 397792 ->qsmask 0x0 .... ->n_boosts 0
[ 1890.555500] rcu: 	cpu 0 ->gp_seq_needed 397792
[ 1890.556196] rcu: 	cpu 1 ->gp_seq_needed 397788
[ 1890.556834] rcu: 	cpu 2 ->gp_seq_needed 397788
[ 1890.557501] rcu: 	cpu 8 ->gp_seq_needed 397788
[ 1890.558159] rcu: 	rcu_node 9:16 ->gp_seq 397785 ->gp_seq_needed 397792 ->qsmask 0x8 .... ->n_boosts 0
[ 1890.559544] rcu: 	cpu 9 ->gp_seq_needed 397792
[ 1890.560239] rcu: 	cpu 10 ->gp_seq_needed 397788
[ 1890.560911] rcu: 	cpu 11 ->gp_seq_needed 397792
[ 1890.561575] rcu: 	cpu 12 ->gp_seq_needed 397788
[ 1890.562110] rcu: 	cpu 13 ->gp_seq_needed 397792
[ 1890.562798] rcu: 	cpu 14 ->gp_seq_needed 397792
[ 1890.563527] rcu: 	cpu 15 ->gp_seq_needed 397792
[ 1890.564178] rcu: 	cpu 16 ->gp_seq_needed 397792
[ 1890.564881] rcu: nocb GP 0 KldtS .[.W] .G:397788/169040 rnp 0:8 57127 S CPU 13
[ 1890.565990] rcu:    CB 0^0->2 KblSW F210 L210 C0 ..... q0 S CPU 1
[ 1890.566950] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W9(397788/169040).N68. q77 S CPU 8
[ 1890.568055] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1890.569016] rcu:    CB 4^4->7 KblSW F1315398 L1315407 C119 ..... q0 S CPU 2
[ 1890.570106] rcu:    CB 5^4->4 KblSW F1280548 L1280548 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1890.571452] rcu:    CB 7^4->-1 KblSW F1296868 L1296874 C16 ..... q0 S CPU 13
[ 1890.572503] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1890.573277] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1890.574254] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1890.575196] rcu: RCU callbacks invoked since boot: 4123257
[ 1890.575987] rcu_tasks: RTGS_WAIT_CBS(11) since 1890002 g:0 i:0 k.u.. l:250 
[ 1905.897488] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3954836 ni: 70381 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1905.901697] rcu-torture: Reader Pipe:  4204286527 122018 0 0 0 0 0 0 0 0 0
[ 1905.902776] rcu-torture: Reader Batch:  4203768642 639903 0 0 0 0 0 0 0 0 0
[ 1905.903837] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1905.905398] ??? Writer stall state RTWS_EXP_SYNC(4) g400409 f0x0 ->state D cpu 1
[ 1905.906494] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 8 ->gp_activity 0 ->gp_req_activity 8 ->gp_wake_time 8 ->gp_wake_seq 400405 ->gp_seq 400409 ->gp_seq_needed 400408 ->gp_max 453 ->gp_flags 0x0
[ 1905.909653] rcu: 	rcu_node 0:16 ->gp_seq 400409 ->gp_seq_needed 400408 ->qsmask 0x1 .... ->n_boosts 0
[ 1905.911017] rcu: 	rcu_node 0:8 ->gp_seq 400409 ->gp_seq_needed 400416 ->qsmask 0x1 .... ->n_boosts 0
[ 1905.912366] rcu: 	cpu 0 ->gp_seq_needed 400416
[ 1905.913035] rcu: 	cpu 1 ->gp_seq_needed 400412
[ 1905.913693] rcu: 	cpu 2 ->gp_seq_needed 400416
[ 1905.914352] rcu: 	cpu 8 ->gp_seq_needed 400416
[ 1905.914991] rcu: 	rcu_node 9:16 ->gp_seq 400409 ->gp_seq_needed 400416 ->qsmask 0x0 .... ->n_boosts 0
[ 1905.916390] rcu: 	cpu 9 ->gp_seq_needed 400416
[ 1905.917084] rcu: 	cpu 10 ->gp_seq_needed 400412
[ 1905.917659] rcu: 	cpu 12 ->gp_seq_needed 400416
[ 1905.918282] rcu: 	cpu 13 ->gp_seq_needed 400412
[ 1905.918929] rcu: 	cpu 14 ->gp_seq_needed 400412
[ 1905.919600] rcu: 	cpu 15 ->gp_seq_needed 400416
[ 1905.920289] rcu: 	cpu 16 ->gp_seq_needed 400416
[ 1905.920956] rcu: nocb GP 0 KldtS .[.W] .G:400412/169040 rnp 0:8 57468 S CPU 13
[ 1905.922183] rcu:    CB 0^0->2 KblSW F406 L406 C0 ..... q0 S CPU 1
[ 1905.923136] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W7(400412/169040).N13. q20 S CPU 10
[ 1905.924308] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1905.925246] rcu:    CB 4^4->7 KblSW F1330754 L1330763 C119 ..... q0 S CPU 2
[ 1905.926290] rcu:    CB 5^4->4 KblSW F1295904 L1295904 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1905.927698] rcu:    CB 7^4->-1 KblSW F1312224 L1312230 C16 ..... q0 S CPU 13
[ 1905.928667] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1905.929574] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1905.930588] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1905.931555] rcu: RCU callbacks invoked since boot: 4150893
[ 1905.932373] rcu_tasks: RTGS_WAIT_CBS(11) since 1905358 g:0 i:0 k.u.. l:250 
[ 1921.258017] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3994534 ni: 71083 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1921.262178] rcu-torture: Reader Pipe:  4247110821 122018 0 0 0 0 0 0 0 0 0
[ 1921.263240] rcu-torture: Reader Batch:  4246587254 645585 0 0 0 0 0 0 0 0 0
[ 1921.264313] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1921.265799] ??? Writer stall state RTWS_EXP_SYNC(4) g404025 f0x0 ->state D cpu 1
[ 1921.266911] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 38 ->gp_activity 0 ->gp_req_activity 38 ->gp_wake_time 39 ->gp_wake_seq 404021 ->gp_seq 404025 ->gp_seq_needed 404024 ->gp_max 453 ->gp_flags 0x0
[ 1921.271371] rcu: 	rcu_node 0:16 ->gp_seq 404025 ->gp_seq_needed 404024 ->qsmask 0x2 .... ->n_boosts 0
[ 1921.272826] rcu: 	rcu_node 0:8 ->gp_seq 404025 ->gp_seq_needed 404032 ->qsmask 0x0 .... ->n_boosts 0
[ 1921.274233] rcu: 	cpu 0 ->gp_seq_needed 404032
[ 1921.274917] rcu: 	cpu 1 ->gp_seq_needed 404028
[ 1921.275623] rcu: 	cpu 2 ->gp_seq_needed 404032
[ 1921.276242] rcu: 	cpu 8 ->gp_seq_needed 404032
[ 1921.276894] rcu: 	rcu_node 9:16 ->gp_seq 404025 ->gp_seq_needed 404032 ->qsmask 0x40 .... ->n_boosts 0
[ 1921.278663] rcu: 	cpu 9 ->gp_seq_needed 404032
[ 1921.279383] rcu: 	cpu 10 ->gp_seq_needed 404032
[ 1921.280078] rcu: 	cpu 12 ->gp_seq_needed 404032
[ 1921.280773] rcu: 	cpu 13 ->gp_seq_needed 404032
[ 1921.281476] rcu: 	cpu 14 ->gp_seq_needed 404032
[ 1921.282143] rcu: 	cpu 15 ->gp_seq_needed 404032
[ 1921.282836] rcu: 	cpu 16 ->gp_seq_needed 404032
[ 1921.283535] rcu: nocb GP 0 KldtS .[W.] .G:404032/169040 rnp 0:8 57937 S CPU 13
[ 1921.284545] rcu:    CB 0^0->2 KblSW F539 L539 C0 ..... q0 S CPU 1
[ 1921.285383] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W8(404032/169040).N23. q31 S CPU 0
[ 1921.286345] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1921.287352] rcu:    CB 4^4->7 KblSW F1346116 L1346125 C119 ..... q0 S CPU 2
[ 1921.288345] rcu:    CB 5^4->4 KblSW F1311266 L1311266 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1921.289712] rcu:    CB 7^4->-1 KblSW F1327586 L1327592 C16 ..... q0 S CPU 13
[ 1921.290767] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1921.291681] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1921.292630] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1921.293601] rcu: RCU callbacks invoked since boot: 4191221
[ 1921.294451] rcu_tasks: RTGS_WAIT_CBS(11) since 1920721 g:0 i:0 k.u.. l:250 
[ 1936.618471] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4021392 ni: 71564 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1936.626969] rcu-torture: Reader Pipe:  4275668769 122018 0 0 0 0 0 0 0 0 0
[ 1936.628057] rcu-torture: Reader Batch:  4275140798 649989 0 0 0 0 0 0 0 0 0
[ 1936.628957] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1936.630482] ??? Writer stall state RTWS_EXP_SYNC(4) g406837 f0x0 ->state D cpu 1
[ 1936.631594] rcu: rcu_preempt: wait state: RCU_GP_INIT(4) ->state: I ->rt_priority 0 delta ->gp_start 17 ->gp_activity 3 ->gp_req_activity 17 ->gp_wake_time 17 ->gp_wake_seq 406833 ->gp_seq 406837 ->gp_seq_needed 406844 ->gp_max 453 ->gp_flags 0x0
[ 1936.634862] rcu: 	rcu_node 0:16 ->gp_seq 406837 ->gp_seq_needed 406844 ->qsmask 0x3 .... ->n_boosts 0
[ 1936.636245] rcu: 	rcu_node 0:8 ->gp_seq 406837 ->gp_seq_needed 406844 ->qsmask 0x107 .... ->n_boosts 0
[ 1936.637610] rcu: 	cpu 0 ->gp_seq_needed 406844
[ 1936.638260] rcu: 	cpu 1 ->gp_seq_needed 406844
[ 1936.638917] rcu: 	cpu 2 ->gp_seq_needed 406844
[ 1936.639548] rcu: 	cpu 8 ->gp_seq_needed 406844
[ 1936.640112] rcu: 	rcu_node 9:16 ->gp_seq 406837 ->gp_seq_needed 406844 ->qsmask 0xfe .... ->n_boosts 0
[ 1936.641515] rcu: 	cpu 9 ->gp_seq_needed 406844
[ 1936.642179] rcu: 	cpu 10 ->gp_seq_needed 406844
[ 1936.642856] rcu: 	cpu 13 ->gp_seq_needed 406840
[ 1936.643568] rcu: 	cpu 14 ->gp_seq_needed 406844
[ 1936.644250] rcu: 	cpu 15 ->gp_seq_needed 406844
[ 1936.644928] rcu: 	cpu 16 ->gp_seq_needed 406844
[ 1936.645670] rcu: nocb GP 0 KldtS .[W.] .G:406840/169040 rnp 0:8 58302 S CPU 13
[ 1936.646798] rcu:    CB 0^0->2 KblSW F0 L0 C0 .W7(406840/169040).N15. q22 S CPU 1
[ 1936.647891] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W5(406840/169040).N15. q20 S CPU 9
[ 1936.649035] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1936.650053] rcu:    CB 4^4->7 KblSW F1361479 L1361488 C119 ..... q0 S CPU 2
[ 1936.650921] rcu:    CB 5^4->4 KblSW F1326629 L1326629 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1936.652304] rcu:    CB 7^4->-1 KblSW F1342948 L1342954 C16 ..... q0 S CPU 13
[ 1936.653336] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1936.654294] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1936.655276] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1936.656203] rcu: RCU callbacks invoked since boot: 4218628
[ 1936.657052] rcu_tasks: RTGS_WAIT_CBS(11) since 1936083 g:0 i:0 k.u.. l:250 
[ 1951.977510] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4060893 ni: 72264 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1951.980531] rcu-torture: Reader Pipe:  4318048841 122018 0 0 0 0 0 0 0 0 0
[ 1951.981289] rcu-torture: Reader Batch:  4317514253 656606 0 0 0 0 0 0 0 0 0
[ 1951.982070] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1951.983162] ??? Writer stall state RTWS_EXP_SYNC(4) g411136 f0x0 ->state D cpu 1
[ 1951.983966] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 371 ->gp_activity 367 ->gp_req_activity 371 ->gp_wake_time 383 ->gp_wake_seq 411117 ->gp_seq 411136 ->gp_seq_needed 411136 ->gp_max 453 ->gp_flags 0x0
[ 1951.986405] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 58860 S CPU 12
[ 1951.987120] rcu:    CB 0^0->2 KblSW F383 L383 C0 ..... q0 S CPU 1
[ 1951.987779] rcu:    CB 2^0->-1 KblSW F385 L385 C0 ..... q0 S CPU 9
[ 1951.988456] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1951.989169] rcu:    CB 4^4->7 KblSW F1376818 L1376827 C119 ..... q0 S CPU 2
[ 1951.989926] rcu:    CB 5^4->4 KblSW F1341968 L1341968 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1951.990931] rcu:    CB 7^4->-1 KblSW F1358287 L1358293 C16 ..... q0 S CPU 13
[ 1951.991689] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1951.992349] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1951.993064] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1951.993760] rcu: RCU callbacks invoked since boot: 4258885
[ 1951.994370] rcu_tasks: RTGS_WAIT_CBS(11) since 1951420 g:0 i:0 k.u.. l:250 
[ 1967.337462] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4088536 ni: 72757 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1967.344993] rcu-torture: Reader Pipe:  4347831276 122018 0 0 0 0 0 0 0 0 0
[ 1967.347452] rcu-torture: Reader Batch:  4347291989 661305 0 0 0 0 0 0 0 0 0
[ 1967.348941] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1967.350697] ??? Writer stall state RTWS_EXP_SYNC(4) g414181 f0x0 ->state D cpu 1
[ 1967.351911] rcu: rcu_preempt: wait state: RCU_GP_CLEANUP(7) ->state: I ->rt_priority 0 delta ->gp_start 40 ->gp_activity 3 ->gp_req_activity 40 ->gp_wake_time 40 ->gp_wake_seq 414177 ->gp_seq 414181 ->gp_seq_needed 414188 ->gp_max 453 ->gp_flags 0x0
[ 1967.355487] rcu: 	rcu_node 0:16 ->gp_seq 414185 ->gp_seq_needed 414188 ->qsmask 0x3 .... ->n_boosts 0
[ 1967.357158] rcu: 	rcu_node 0:8 ->gp_seq 414185 ->gp_seq_needed 414188 ->qsmask 0x2 .... ->n_boosts 0
[ 1967.358646] rcu: 	cpu 0 ->gp_seq_needed 414188
[ 1967.359336] rcu: 	cpu 1 ->gp_seq_needed 414188
[ 1967.360037] rcu: 	cpu 2 ->gp_seq_needed 414188
[ 1967.360715] rcu: 	cpu 8 ->gp_seq_needed 414188
[ 1967.361403] rcu: 	rcu_node 9:16 ->gp_seq 414185 ->gp_seq_needed 414192 ->qsmask 0x0 .... ->n_boosts 0
[ 1967.362956] rcu: 	cpu 9 ->gp_seq_needed 414188
[ 1967.363636] rcu: 	cpu 10 ->gp_seq_needed 414192
[ 1967.364403] rcu: 	cpu 11 ->gp_seq_needed 414192
[ 1967.365104] rcu: 	cpu 12 ->gp_seq_needed 414188
[ 1967.365803] rcu: 	cpu 13 ->gp_seq_needed 414192
[ 1967.366497] rcu: 	cpu 14 ->gp_seq_needed 414192
[ 1967.367172] rcu: 	cpu 15 ->gp_seq_needed 414192
[ 1967.367949] rcu: 	cpu 16 ->gp_seq_needed 414192
[ 1967.368763] rcu: nocb GP 0 KldtS .[.W] .G:414188/169040 rnp 0:8 59256 S CPU 12
[ 1967.369957] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W17(414188/169040).N12. q29 S CPU 12
[ 1967.371133] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W16(414188/169040).N9. q25 S CPU 9
[ 1967.372293] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1967.373307] rcu:    CB 4^4->7 KblSW F1392202 L1392211 C119 ..... q0 S CPU 2
[ 1967.374442] rcu:    CB 5^4->4 KblSW F1357353 L1357353 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1967.375947] rcu:    CB 7^4->-1 KblSW F1373672 L1373678 C16 ..... q0 S CPU 13
[ 1967.377191] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1967.378193] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1967.379057] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1967.380046] rcu: RCU callbacks invoked since boot: 4286938
[ 1967.381148] rcu_tasks: RTGS_WAIT_CBS(11) since 1966807 g:0 i:0 k.u.. l:250 
[ 1982.697472] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4115159 ni: 73233 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1982.701627] rcu-torture: Reader Pipe:  4376460011 122018 0 0 0 0 0 0 0 0 0
[ 1982.702562] rcu-torture: Reader Batch:  4375916491 665538 0 0 0 0 0 0 0 0 0
[ 1982.703642] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1982.705153] ??? Writer stall state RTWS_EXP_SYNC(4) g416913 f0x0 ->state D cpu 1
[ 1982.706271] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 76 ->gp_activity 0 ->gp_req_activity 76 ->gp_wake_time 76 ->gp_wake_seq 416909 ->gp_seq 416913 ->gp_seq_needed 416912 ->gp_max 453 ->gp_flags 0x0
[ 1982.709590] rcu: 	rcu_node 0:16 ->gp_seq 416913 ->gp_seq_needed 416912 ->qsmask 0x2 .... ->n_boosts 0
[ 1982.711042] rcu: 	rcu_node 0:8 ->gp_seq 416913 ->gp_seq_needed 416916 ->qsmask 0x0 .... ->n_boosts 0
[ 1982.712366] rcu: 	cpu 0 ->gp_seq_needed 416916
[ 1982.712883] rcu: 	cpu 1 ->gp_seq_needed 416916
[ 1982.713551] rcu: 	cpu 2 ->gp_seq_needed 416916
[ 1982.714226] rcu: 	rcu_node 9:16 ->gp_seq 416913 ->gp_seq_needed 416920 ->qsmask 0x80 .... ->n_boosts 0
[ 1982.715581] rcu: 	cpu 9 ->gp_seq_needed 416916
[ 1982.716248] rcu: 	cpu 10 ->gp_seq_needed 416920
[ 1982.716906] rcu: 	cpu 12 ->gp_seq_needed 416916
[ 1982.717617] rcu: 	cpu 13 ->gp_seq_needed 416920
[ 1982.718323] rcu: 	cpu 14 ->gp_seq_needed 416920
[ 1982.719006] rcu: 	cpu 15 ->gp_seq_needed 416920
[ 1982.719712] rcu: 	cpu 16 ->gp_seq_needed 416916
[ 1982.720380] rcu: nocb GP 0 KldtS .[.W] .G:416916/169040 rnp 0:8 59611 S CPU 12
[ 1982.721456] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W6(416916/169040).N36. q42 S CPU 1
[ 1982.722543] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W7(416916/169040).N41. q48 S CPU 9
[ 1982.723637] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1982.724511] rcu:    CB 4^4->7 KblSW F1407554 L1407563 C119 ..... q0 S CPU 2
[ 1982.725564] rcu:    CB 5^4->4 KblSW F1372704 L1372704 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1982.726998] rcu:    CB 7^4->-1 KblSW F1389023 L1389029 C16 ..... q0 S CPU 13
[ 1982.728063] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1982.728987] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1982.729906] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1982.730884] rcu: RCU callbacks invoked since boot: 4313915
[ 1982.731706] rcu_tasks: RTGS_WAIT_CBS(11) since 1982158 g:0 i:0 k.u.. l:250 
[ 1998.057484] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4154945 ni: 73943 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 1998.061512] rcu-torture: Reader Pipe:  4418223863 122018 0 0 0 0 0 0 0 0 0
[ 1998.063213] rcu-torture: Reader Batch:  4417674679 671201 0 0 0 0 0 0 0 0 0
[ 1998.065753] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 1998.067263] ??? Writer stall state RTWS_EXP_SYNC(4) g420601 f0x0 ->state D cpu 1
[ 1998.068396] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 86 ->gp_activity 3 ->gp_req_activity 86 ->gp_wake_time 88 ->gp_wake_seq 420597 ->gp_seq 420601 ->gp_seq_needed 420600 ->gp_max 453 ->gp_flags 0x0
[ 1998.071688] rcu: 	rcu_node 0:16 ->gp_seq 420601 ->gp_seq_needed 420600 ->qsmask 0x2 .... ->n_boosts 0
[ 1998.072915] rcu: 	rcu_node 0:8 ->gp_seq 420601 ->gp_seq_needed 420608 ->qsmask 0x0 .... ->n_boosts 0
[ 1998.074275] rcu: 	cpu 0 ->gp_seq_needed 420608
[ 1998.074919] rcu: 	cpu 1 ->gp_seq_needed 420608
[ 1998.075589] rcu: 	cpu 2 ->gp_seq_needed 420608
[ 1998.076294] rcu: 	rcu_node 9:16 ->gp_seq 420601 ->gp_seq_needed 420608 ->qsmask 0x1 .... ->n_boosts 0
[ 1998.077705] rcu: 	cpu 9 ->gp_seq_needed 420608
[ 1998.078392] rcu: 	cpu 10 ->gp_seq_needed 420608
[ 1998.079104] rcu: 	cpu 12 ->gp_seq_needed 420608
[ 1998.079760] rcu: 	cpu 13 ->gp_seq_needed 420608
[ 1998.080412] rcu: 	cpu 14 ->gp_seq_needed 420608
[ 1998.081115] rcu: 	cpu 15 ->gp_seq_needed 420608
[ 1998.081785] rcu: 	cpu 16 ->gp_seq_needed 420608
[ 1998.082497] rcu: nocb GP 0 KldtS .[W.] .G:420608/169040 rnp 0:8 60089 S CPU 12
[ 1998.083570] rcu:    CB 0^0->2 KblSW F452 L452 C0 ..... q0 S CPU 1
[ 1998.084358] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W4(420608/169040).N41. q45 S CPU 0
[ 1998.085513] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 1998.086496] rcu:    CB 4^4->7 KblSW F1422915 L1422924 C119 ..... q0 S CPU 2
[ 1998.087566] rcu:    CB 5^4->4 KblSW F1388066 L1388066 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 1998.088996] rcu:    CB 7^4->-1 KblSW F1404385 L1404391 C16 ..... q0 S CPU 13
[ 1998.090088] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 1998.090952] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 1998.091984] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 1998.092978] rcu: RCU callbacks invoked since boot: 4354398
[ 1998.093843] rcu_tasks: RTGS_WAIT_CBS(11) since 1997520 g:0 i:0 k.u.. l:250 
[ 2013.420470] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4181484 ni: 74421 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2013.425475] rcu-torture: Reader Pipe:  4447183421 122018 0 0 0 0 0 0 0 0 0
[ 2013.426395] rcu-torture: Reader Batch:  4446630569 674870 0 0 0 0 0 0 0 0 0
[ 2013.427328] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2013.428675] ??? Writer stall state RTWS_EXP_SYNC(4) g422981 f0x0 ->state D cpu 1
[ 2013.429676] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 9 ->gp_activity 9 ->gp_req_activity 9 ->gp_wake_time 36 ->gp_wake_seq 422961 ->gp_seq 422981 ->gp_seq_needed 422980 ->gp_max 453 ->gp_flags 0x0
[ 2013.432611] rcu: 	rcu_node 0:16 ->gp_seq 422981 ->gp_seq_needed 422980 ->qsmask 0x1 .... ->n_boosts 0
[ 2013.434016] rcu: 	rcu_node 0:8 ->gp_seq 422981 ->gp_seq_needed 422988 ->qsmask 0x1 .... ->n_boosts 0
[ 2013.435664] rcu: 	cpu 0 ->gp_seq_needed 422988
[ 2013.436313] rcu: 	cpu 1 ->gp_seq_needed 422988
[ 2013.437006] rcu: 	cpu 2 ->gp_seq_needed 422988
[ 2013.437665] rcu: 	cpu 8 ->gp_seq_needed 422984
[ 2013.440620] rcu: 	rcu_node 9:16 ->gp_seq 422981 ->gp_seq_needed 422988 ->qsmask 0x0 .... ->n_boosts 0
[ 2013.442009] rcu: 	cpu 9 ->gp_seq_needed 422988
[ 2013.442702] rcu: 	cpu 10 ->gp_seq_needed 422988
[ 2013.444350] rcu: 	cpu 11 ->gp_seq_needed 422988
[ 2013.444934] rcu: 	cpu 12 ->gp_seq_needed 422984
[ 2013.445635] rcu: 	cpu 13 ->gp_seq_needed 422988
[ 2013.446308] rcu: 	cpu 16 ->gp_seq_needed 422988
[ 2013.446979] rcu: nocb GP 0 KldtS .[W.] .G:422984/169040 rnp 0:8 60399 S CPU 12
[ 2013.448098] rcu:    CB 0^0->2 KblSW F1148 L1148 C0 ..... q0 S CPU 14
[ 2013.449073] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W7(422984/169040).N12. q19 S CPU 0
[ 2013.450198] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2013.451238] rcu:    CB 4^4->7 KblSW F1438280 L1438289 C119 ..... q0 S CPU 2
[ 2013.452281] rcu:    CB 5^4->4 KblSW F1403430 L1403430 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2013.453671] rcu:    CB 7^4->-1 KblSW F1419750 L1419756 C16 ..... q0 S CPU 13
[ 2013.454723] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2013.455652] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2013.456587] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2013.457466] rcu: RCU callbacks invoked since boot: 4381599
[ 2013.458120] rcu_tasks: RTGS_WAIT_CBS(11) since 2012884 g:0 i:0 k.u.. l:250 
[ 2028.777477] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4221702 ni: 75129 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2028.783027] rcu-torture: Reader Pipe:  4489887468 122018 0 0 0 0 0 0 0 0 0
[ 2028.784085] rcu-torture: Reader Batch:  4489328130 681356 0 0 0 0 0 0 0 0 0
[ 2028.785136] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2028.786627] ??? Writer stall state RTWS_EXP_SYNC(4) g427137 f0x0 ->state D cpu 1
[ 2028.787684] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 193 ->gp_activity 1 ->gp_req_activity 193 ->gp_wake_time 199 ->gp_wake_seq 427129 ->gp_seq 427137 ->gp_seq_needed 427136 ->gp_max 453 ->gp_flags 0x0
[ 2028.791012] rcu: 	rcu_node 0:16 ->gp_seq 427137 ->gp_seq_needed 427136 ->qsmask 0x2 .... ->n_boosts 0
[ 2028.792411] rcu: 	rcu_node 0:8 ->gp_seq 427137 ->gp_seq_needed 427144 ->qsmask 0x0 .... ->n_boosts 0
[ 2028.793840] rcu: 	cpu 0 ->gp_seq_needed 427144
[ 2028.794488] rcu: 	cpu 1 ->gp_seq_needed 427144
[ 2028.795129] rcu: 	cpu 2 ->gp_seq_needed 427144
[ 2028.795818] rcu: 	cpu 8 ->gp_seq_needed 427144
[ 2028.796483] rcu: 	rcu_node 9:16 ->gp_seq 427137 ->gp_seq_needed 427144 ->qsmask 0x0 ...G ->n_boosts 0
[ 2028.797836] rcu: 	cpu 9 ->gp_seq_needed 427144
[ 2028.798534] rcu: 	cpu 10 ->gp_seq_needed 427144
[ 2028.799245] rcu: 	cpu 11 ->gp_seq_needed 427144
[ 2028.800925] rcu: 	cpu 12 ->gp_seq_needed 427144
[ 2028.801620] rcu: 	cpu 13 ->gp_seq_needed 427140
[ 2028.802268] rcu: 	cpu 14 ->gp_seq_needed 427144
[ 2028.802987] rcu: 	cpu 15 ->gp_seq_needed 427144
[ 2028.804114] rcu: 	cpu 16 ->gp_seq_needed 427144
[ 2028.804920] rcu: nocb GP 0 KldtS .[W.] .G:427144/169040 rnp 0:8 60938 S CPU 15
[ 2028.806072] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W4(427144/169040).N3. q7 S CPU 0
[ 2028.807242] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W125(427144/169040).N89. q214 S CPU 1
[ 2028.808467] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2028.809502] rcu:    CB 4^4->7 KblSW F1453639 L1453648 C119 ..... q0 S CPU 2
[ 2028.810404] rcu:    CB 5^4->4 KblSW F1418788 L1418788 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2028.811942] rcu:    CB 7^4->-1 KblSW F1435108 L1435114 C16 ..... q0 S CPU 13
[ 2028.813063] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2028.814039] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2028.815043] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2028.816063] rcu: RCU callbacks invoked since boot: 4421427
[ 2028.816996] rcu_tasks: RTGS_WAIT_CBS(11) since 2028243 g:0 i:0 k.u.. l:250 
[ 2044.137486] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4247223 ni: 75591 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2044.142541] rcu-torture: Reader Pipe:  4517702415 122018 0 0 0 0 0 0 0 0 0
[ 2044.143538] rcu-torture: Reader Batch:  4517140396 684037 0 0 0 0 0 0 0 0 0
[ 2044.144558] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2044.145973] ??? Writer stall state RTWS_EXP_SYNC(4) g428873 f0x0 ->state D cpu 1
[ 2044.146961] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 4 ->gp_activity 4 ->gp_req_activity 4 ->gp_wake_time 323 ->gp_wake_seq 428865 ->gp_seq 428873 ->gp_seq_needed 428876 ->gp_max 453 ->gp_flags 0x0
[ 2044.150600] rcu: 	rcu_node 0:16 ->gp_seq 428873 ->gp_seq_needed 428876 ->qsmask 0x3 .... ->n_boosts 0
[ 2044.151866] rcu: 	rcu_node 0:8 ->gp_seq 428873 ->gp_seq_needed 428880 ->qsmask 0x5 .... ->n_boosts 0
[ 2044.153198] rcu: 	cpu 0 ->gp_seq_needed 428880
[ 2044.153848] rcu: 	cpu 1 ->gp_seq_needed 428876
[ 2044.154479] rcu: 	cpu 2 ->gp_seq_needed 428880
[ 2044.155097] rcu: 	cpu 8 ->gp_seq_needed 428880
[ 2044.155809] rcu: 	rcu_node 9:16 ->gp_seq 428873 ->gp_seq_needed 428880 ->qsmask 0x10 .... ->n_boosts 0
[ 2044.157190] rcu: 	cpu 9 ->gp_seq_needed 428880
[ 2044.158112] rcu: 	cpu 10 ->gp_seq_needed 428880
[ 2044.158731] rcu: 	cpu 11 ->gp_seq_needed 428880
[ 2044.159487] rcu: 	cpu 12 ->gp_seq_needed 428876
[ 2044.160200] rcu: 	cpu 13 ->gp_seq_needed 428876
[ 2044.160870] rcu: 	cpu 14 ->gp_seq_needed 428880
[ 2044.161504] rcu: 	cpu 15 ->gp_seq_needed 428880
[ 2044.162114] rcu: 	cpu 16 ->gp_seq_needed 428880
[ 2044.162747] rcu: nocb GP 0 KldtS .[.W] .G:428876/169040 rnp 0:8 61164 S CPU 15
[ 2044.163825] rcu:    CB 0^0->2 KblSW F170 L170 C0 .W1(428876/169040)... q1 S CPU 0
[ 2044.164862] rcu:    CB 2^0->-1 KblSW F195 L195 C0 .W55(428876/169040)... q55 S CPU 1
[ 2044.165962] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2044.166968] rcu:    CB 4^4->7 KblSW F1468996 L1469005 C119 ..... q0 S CPU 2
[ 2044.167930] rcu:    CB 5^4->4 KblSW F1434146 L1434146 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2044.169233] rcu:    CB 7^4->-1 KblSW F1450465 L1450471 C16 ..... q0 S CPU 13
[ 2044.170217] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2044.171089] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2044.172003] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2044.172863] rcu: RCU callbacks invoked since boot: 4447840
[ 2044.173623] rcu_tasks: RTGS_WAIT_CBS(11) since 2043600 g:0 i:0 k.u.. l:250 
[ 2059.497514] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4276133 ni: 76110 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2059.500500] rcu-torture: Reader Pipe:  4548542462 122018 0 0 0 0 0 0 0 0 0
[ 2059.501249] rcu-torture: Reader Batch:  4547976578 687902 0 0 0 0 0 0 0 0 0
[ 2059.502015] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2059.503103] ??? Writer stall state RTWS_EXP_SYNC(4) g431348 f0x0 ->state D cpu 1
[ 2059.503903] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 3614 ->gp_activity 3610 ->gp_req_activity 3614 ->gp_wake_time 3618 ->gp_wake_seq 431337 ->gp_seq 431348 ->gp_seq_needed 431348 ->gp_max 453 ->gp_flags 0x0
[ 2059.506341] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 61485 S CPU 0
[ 2059.507042] rcu:    CB 0^0->2 KblSW F3942 L3942 C0 ..... q0 S CPU 15
[ 2059.507733] rcu:    CB 2^0->-1 KblSW F3918 L3918 C0 ..... q0 S CPU 1
[ 2059.508413] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2059.509128] rcu:    CB 4^4->7 KblSW F1484338 L1484347 C119 ..... q0 S CPU 2
[ 2059.509885] rcu:    CB 5^4->4 KblSW F1449488 L1449488 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2059.510889] rcu:    CB 7^4->-1 KblSW F1465807 L1465813 C16 ..... q0 S CPU 13
[ 2059.511654] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2059.512307] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2059.512985] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2059.513663] rcu: RCU callbacks invoked since boot: 4477971
[ 2059.514252] rcu_tasks: RTGS_WAIT_CBS(11) since 2058940 g:0 i:0 k.u.. l:250 
[ 2074.858662] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4313570 ni: 76774 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2074.863139] rcu-torture: Reader Pipe:  4588410101 122018 0 0 0 0 0 0 0 0 0
[ 2074.864157] rcu-torture: Reader Batch:  4587838307 693812 0 0 0 0 0 0 0 0 0
[ 2074.865198] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2074.866693] ??? Writer stall state RTWS_EXP_SYNC(4) g435193 f0x0 ->state D cpu 1
[ 2074.867858] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 56 ->gp_activity 4 ->gp_req_activity 56 ->gp_wake_time 59 ->gp_wake_seq 435189 ->gp_seq 435193 ->gp_seq_needed 435192 ->gp_max 453 ->gp_flags 0x0
[ 2074.871041] rcu: 	rcu_node 0:16 ->gp_seq 435193 ->gp_seq_needed 435192 ->qsmask 0x1 .... ->n_boosts 0
[ 2074.872419] rcu: 	rcu_node 0:8 ->gp_seq 435193 ->gp_seq_needed 435200 ->qsmask 0x4 .... ->n_boosts 0
[ 2074.873754] rcu: 	cpu 0 ->gp_seq_needed 435200
[ 2074.874412] rcu: 	cpu 1 ->gp_seq_needed 435200
[ 2074.875072] rcu: 	cpu 2 ->gp_seq_needed 435200
[ 2074.875758] rcu: 	cpu 8 ->gp_seq_needed 435200
[ 2074.876424] rcu: 	rcu_node 9:16 ->gp_seq 435193 ->gp_seq_needed 435200 ->qsmask 0x0 .... ->n_boosts 0
[ 2074.877813] rcu: 	cpu 9 ->gp_seq_needed 435196
[ 2074.878509] rcu: 	cpu 11 ->gp_seq_needed 435200
[ 2074.879173] rcu: 	cpu 12 ->gp_seq_needed 435196
[ 2074.879847] rcu: 	cpu 13 ->gp_seq_needed 435200
[ 2074.880543] rcu: 	cpu 14 ->gp_seq_needed 435200
[ 2074.881239] rcu: 	cpu 15 ->gp_seq_needed 435196
[ 2074.881921] rcu: 	cpu 16 ->gp_seq_needed 435200
[ 2074.882624] rcu: nocb GP 0 Kldts .[.W] .G:435196/169040 rnp 0:8 61984 S CPU 0
[ 2074.883690] rcu:    CB 0^0->2 KblSW F47 L47 C0 ...N1. q1 S CPU 15
[ 2074.884637] rcu:    CB 2^0->-1 KblSW F52 L52 C0 .W6(435196/169040).N5. q11 S CPU 9
[ 2074.885780] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2074.886785] rcu:    CB 4^4->7 KblSW F1499716 L1499725 C119 ..... q0 S CPU 2
[ 2074.887850] rcu:    CB 5^4->4 KblSW F1464866 L1464866 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2074.889178] rcu:    CB 7^4->-1 KblSW F1481184 L1481190 C16 ..... q0 S CPU 13
[ 2074.890232] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2074.891184] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2074.892135] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2074.893111] rcu: RCU callbacks invoked since boot: 4515900
[ 2074.893989] rcu_tasks: RTGS_WAIT_CBS(11) since 2074320 g:0 i:0 k.u.. l:250 
[ 2090.218458] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4340407 ni: 77248 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2090.222656] rcu-torture: Reader Pipe:  4617266378 122018 0 0 0 0 0 0 0 0 0
[ 2090.223695] rcu-torture: Reader Batch:  4616690544 697852 0 0 0 0 0 0 0 0 0
[ 2090.224782] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2090.226356] ??? Writer stall state RTWS_EXP_SYNC(4) g437777 f0x0 ->state D cpu 1
[ 2090.227517] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 140 ->gp_activity 1 ->gp_req_activity 140 ->gp_wake_time 437 ->gp_wake_seq 437769 ->gp_seq 437777 ->gp_seq_needed 437780 ->gp_max 453 ->gp_flags 0x0
[ 2090.230652] rcu: 	rcu_node 0:16 ->gp_seq 437777 ->gp_seq_needed 437780 ->qsmask 0x2 .... ->n_boosts 0
[ 2090.232019] rcu: 	rcu_node 0:8 ->gp_seq 437777 ->gp_seq_needed 437784 ->qsmask 0x0 .... ->n_boosts 0
[ 2090.233371] rcu: 	cpu 0 ->gp_seq_needed 437784
[ 2090.234032] rcu: 	cpu 1 ->gp_seq_needed 437784
[ 2090.234726] rcu: 	cpu 2 ->gp_seq_needed 437784
[ 2090.235416] rcu: 	cpu 8 ->gp_seq_needed 437784
[ 2090.236098] rcu: 	rcu_node 9:16 ->gp_seq 437777 ->gp_seq_needed 437784 ->qsmask 0x20 .... ->n_boosts 0
[ 2090.237506] rcu: 	cpu 9 ->gp_seq_needed 437784
[ 2090.238185] rcu: 	cpu 10 ->gp_seq_needed 437780
[ 2090.238890] rcu: 	cpu 11 ->gp_seq_needed 437784
[ 2090.239548] rcu: 	cpu 12 ->gp_seq_needed 437780
[ 2090.240097] rcu: 	cpu 13 ->gp_seq_needed 437784
[ 2090.240828] rcu: 	cpu 14 ->gp_seq_needed 437780
[ 2090.241541] rcu: 	cpu 15 ->gp_seq_needed 437784
[ 2090.242209] rcu: 	cpu 16 ->gp_seq_needed 437784
[ 2090.242904] rcu: nocb GP 0 KldtS .[.W] .G:437780/169040 rnp 0:8 62320 S CPU 15
[ 2090.243992] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W4(437780/169040).N37. q41 S CPU 9
[ 2090.245156] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W4(437780/169040).N154. q158 S CPU 10
[ 2090.246349] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2090.247333] rcu:    CB 4^4->7 KblSW F1515076 L1515085 C119 ..... q0 S CPU 2
[ 2090.248365] rcu:    CB 5^4->4 KblSW F1480226 L1480226 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2090.249721] rcu:    CB 7^4->-1 KblSW F1496546 L1496552 C16 ..... q0 S CPU 13
[ 2090.250691] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2090.251542] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2090.252488] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2090.253466] rcu: RCU callbacks invoked since boot: 4542459
[ 2090.254303] rcu_tasks: RTGS_WAIT_CBS(11) since 2089680 g:0 i:0 k.u.. l:250 
[ 2105.577459] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4379749 ni: 77944 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2105.582278] rcu-torture: Reader Pipe:  4658963332 122018 0 0 0 0 0 0 0 0 0
[ 2105.583207] rcu-torture: Reader Batch:  4658381708 703642 0 0 0 0 0 0 0 0 0
[ 2105.584141] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2105.588843] ??? Writer stall state RTWS_EXP_SYNC(4) g441509 f0x0 ->state D cpu 1
[ 2105.589830] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 42 ->gp_activity 1 ->gp_req_activity 42 ->gp_wake_time 54 ->gp_wake_seq 441505 ->gp_seq 441509 ->gp_seq_needed 441512 ->gp_max 453 ->gp_flags 0x0
[ 2105.592882] rcu: 	rcu_node 0:16 ->gp_seq 441509 ->gp_seq_needed 441512 ->qsmask 0x2 .... ->n_boosts 0
[ 2105.594160] rcu: 	rcu_node 0:8 ->gp_seq 441509 ->gp_seq_needed 441516 ->qsmask 0x0 .... ->n_boosts 0
[ 2105.595376] rcu: 	cpu 0 ->gp_seq_needed 441516
[ 2105.595970] rcu: 	cpu 1 ->gp_seq_needed 441516
[ 2105.596571] rcu: 	cpu 2 ->gp_seq_needed 441512
[ 2105.597157] rcu: 	cpu 8 ->gp_seq_needed 441516
[ 2105.597768] rcu: 	rcu_node 9:16 ->gp_seq 441509 ->gp_seq_needed 441516 ->qsmask 0xa0 .... ->n_boosts 0
[ 2105.599137] rcu: 	cpu 9 ->gp_seq_needed 441516
[ 2105.599814] rcu: 	cpu 10 ->gp_seq_needed 441512
[ 2105.600422] rcu: 	cpu 11 ->gp_seq_needed 441512
[ 2105.601027] rcu: 	cpu 12 ->gp_seq_needed 441512
[ 2105.601638] rcu: 	cpu 13 ->gp_seq_needed 441512
[ 2105.602235] rcu: 	cpu 14 ->gp_seq_needed 441516
[ 2105.602848] rcu: 	cpu 15 ->gp_seq_needed 441516
[ 2105.603462] rcu: 	cpu 16 ->gp_seq_needed 441512
[ 2105.604060] rcu: nocb GP 0 KldtS .[W.] .G:441512/169040 rnp 0:8 62804 S CPU 13
[ 2105.605026] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W114(441512/169040).N23. q137 S CPU 10
[ 2105.606072] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W6(441512/169040).N28. q34 S CPU 11
[ 2105.607080] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2105.607957] rcu:    CB 4^4->7 KblSW F1530437 L1530446 C119 ..... q0 S CPU 2
[ 2105.608890] rcu:    CB 5^4->4 KblSW F1495587 L1495587 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2105.610124] rcu:    CB 7^4->-1 KblSW F1511906 L1511912 C16 ..... q0 S CPU 13
[ 2105.611065] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2105.611881] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2105.612746] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2105.613585] rcu: RCU callbacks invoked since boot: 4582740
[ 2105.614310] rcu_tasks: RTGS_WAIT_CBS(11) since 2105040 g:0 i:0 k.u.. l:250 
[ 2120.937656] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4406744 ni: 78432 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2120.941819] rcu-torture: Reader Pipe:  4688107034 122018 0 0 0 0 0 0 0 0 0
[ 2120.942872] rcu-torture: Reader Batch:  4687520881 708171 0 0 0 0 0 0 0 0 0
[ 2120.943963] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2120.945556] ??? Writer stall state RTWS_EXP_SYNC(4) g444397 f0x0 ->state D cpu 1
[ 2120.946707] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 277 ->gp_activity 3 ->gp_req_activity 277 ->gp_wake_time 281 ->gp_wake_seq 444389 ->gp_seq 444397 ->gp_seq_needed 444396 ->gp_max 453 ->gp_flags 0x0
[ 2120.950045] rcu: 	rcu_node 0:16 ->gp_seq 444397 ->gp_seq_needed 444396 ->qsmask 0x2 .... ->n_boosts 0
[ 2120.951493] rcu: 	rcu_node 0:8 ->gp_seq 444397 ->gp_seq_needed 444404 ->qsmask 0x0 .... ->n_boosts 0
[ 2120.952951] rcu: 	cpu 0 ->gp_seq_needed 444400
[ 2120.953643] rcu: 	cpu 1 ->gp_seq_needed 444404
[ 2120.954334] rcu: 	cpu 2 ->gp_seq_needed 444400
[ 2120.955041] rcu: 	cpu 8 ->gp_seq_needed 444404
[ 2120.955762] rcu: 	rcu_node 9:16 ->gp_seq 444397 ->gp_seq_needed 444404 ->qsmask 0x0 ...G ->n_boosts 0
[ 2120.957210] rcu: 	cpu 9 ->gp_seq_needed 444404
[ 2120.957870] rcu: 	cpu 10 ->gp_seq_needed 444404
[ 2120.958517] rcu: 	cpu 11 ->gp_seq_needed 444404
[ 2120.959196] rcu: 	cpu 12 ->gp_seq_needed 444400
[ 2120.959892] rcu: 	cpu 13 ->gp_seq_needed 444400
[ 2120.960604] rcu: 	cpu 14 ->gp_seq_needed 444404
[ 2120.961315] rcu: 	cpu 15 ->gp_seq_needed 444404
[ 2120.961992] rcu: 	cpu 16 ->gp_seq_needed 444404
[ 2120.962707] rcu: nocb GP 0 KldtS .[W.] .G:444400/169040 rnp 0:8 63180 S CPU 13
[ 2120.963838] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W9(444400/169040).N125. q134 S CPU 9
[ 2120.965019] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W9(444400/169040).N119. q128 S CPU 11
[ 2120.966200] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2120.967194] rcu:    CB 4^4->7 KblSW F1545796 L1545805 C119 ..... q0 S CPU 2
[ 2120.968251] rcu:    CB 5^4->4 KblSW F1510946 L1510946 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2120.969648] rcu:    CB 7^4->-1 KblSW F1527266 L1527272 C16 ..... q0 S CPU 13
[ 2120.970728] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2120.971693] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2120.972668] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2120.973639] rcu: RCU callbacks invoked since boot: 4610176
[ 2120.974459] rcu_tasks: RTGS_WAIT_CBS(11) since 2120401 g:0 i:0 k.u.. l:250 
[ 2136.297503] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4439100 ni: 79007 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2136.301605] rcu-torture: Reader Pipe:  4723093824 122018 0 0 0 0 0 0 0 0 0
[ 2136.302661] rcu-torture: Reader Batch:  4722503134 712708 0 0 0 0 0 0 0 0 0
[ 2136.303769] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2136.305358] ??? Writer stall state RTWS_EXP_SYNC(4) g447300 f0x0 ->state D cpu 1
[ 2136.306460] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 2424 ->gp_activity 2420 ->gp_req_activity 2424 ->gp_wake_time 2433 ->gp_wake_seq 447285 ->gp_seq 447300 ->gp_seq_needed 447300 ->gp_max 453 ->gp_flags 0x0
[ 2136.309869] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 63557 S CPU 13
[ 2136.310853] rcu:    CB 0^0->2 KblSW F2714 L2714 C0 ..... q0 S CPU 9
[ 2136.311830] rcu:    CB 2^0->-1 KblSW F2716 L2716 C0 ..... q0 S CPU 11
[ 2136.312810] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2136.313816] rcu:    CB 4^4->7 KblSW F1561143 L1561152 C119 ..... q0 S CPU 2
[ 2136.314919] rcu:    CB 5^4->4 KblSW F1526293 L1526293 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2136.316339] rcu:    CB 7^4->-1 KblSW F1542612 L1542618 C16 ..... q0 S CPU 13
[ 2136.317442] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2136.318363] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2136.319309] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2136.320257] rcu: RCU callbacks invoked since boot: 4643835
[ 2136.321130] rcu_tasks: RTGS_WAIT_CBS(11) since 2135747 g:0 i:0 k.u.. l:250 
[ 2151.657719] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4474131 ni: 79620 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2151.663792] rcu-torture: Reader Pipe:  4760485166 122018 0 0 0 0 0 0 0 0 0
[ 2151.664892] rcu-torture: Reader Batch:  4759888105 719079 0 0 0 0 0 0 0 0 0
[ 2151.666610] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2151.669938] ??? Writer stall state RTWS_EXP_SYNC(4) g451329 f0x0 ->state D cpu 1
[ 2151.671700] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 138 ->gp_activity 0 ->gp_req_activity 138 ->gp_wake_time 139 ->gp_wake_seq 451325 ->gp_seq 451329 ->gp_seq_needed 451332 ->gp_max 453 ->gp_flags 0x0
[ 2151.677875] rcu: 	rcu_node 0:16 ->gp_seq 451329 ->gp_seq_needed 451332 ->qsmask 0x2 .... ->n_boosts 0
[ 2151.679133] rcu: 	rcu_node 0:8 ->gp_seq 451329 ->gp_seq_needed 451336 ->qsmask 0x0 .... ->n_boosts 0
[ 2151.680514] rcu: 	cpu 0 ->gp_seq_needed 451336
[ 2151.681260] rcu: 	cpu 1 ->gp_seq_needed 451336
[ 2151.681954] rcu: 	cpu 2 ->gp_seq_needed 451336
[ 2151.682655] rcu: 	cpu 8 ->gp_seq_needed 451336
[ 2151.683323] rcu: 	rcu_node 9:16 ->gp_seq 451329 ->gp_seq_needed 451336 ->qsmask 0x0 ...G ->n_boosts 0
[ 2151.684746] rcu: 	cpu 9 ->gp_seq_needed 451336
[ 2151.685453] rcu: 	cpu 10 ->gp_seq_needed 451336
[ 2151.686125] rcu: 	cpu 11 ->gp_seq_needed 451336
[ 2151.686837] rcu: 	cpu 12 ->gp_seq_needed 451336
[ 2151.687519] rcu: 	cpu 13 ->gp_seq_needed 451332
[ 2151.688227] rcu: 	cpu 14 ->gp_seq_needed 451336
[ 2151.688872] rcu: 	cpu 15 ->gp_seq_needed 451336
[ 2151.689596] rcu: 	cpu 16 ->gp_seq_needed 451336
[ 2151.690175] rcu: nocb GP 0 KldtS .[W.] .G:451336/169040 rnp 0:8 64080 S CPU 8
[ 2151.691225] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W136(451336/169040).N71. q207 S CPU 9
[ 2151.692367] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W15(451336/169040).N63. q78 S CPU 11
[ 2151.693476] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2151.694451] rcu:    CB 4^4->7 KblSW F1576524 L1576533 C119 ..... q0 S CPU 2
[ 2151.695508] rcu:    CB 5^4->4 KblSW F1541674 L1541674 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2151.696873] rcu:    CB 7^4->-1 KblSW F1557993 L1557999 C16 ..... q0 S CPU 13
[ 2151.697954] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2151.698879] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2151.699863] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2151.700825] rcu: RCU callbacks invoked since boot: 4678395
[ 2151.701473] rcu_tasks: RTGS_WAIT_CBS(11) since 2151128 g:0 i:0 k.u.. l:250 
[ 2167.017468] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4501419 ni: 80101 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2167.024067] rcu-torture: Reader Pipe:  4789326571 122018 0 0 0 0 0 0 0 0 0
[ 2167.026023] rcu-torture: Reader Batch:  4788725883 722706 0 0 0 0 0 0 0 0 0
[ 2167.028140] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2167.030964] ??? Writer stall state RTWS_EXP_SYNC(4) g453625 f0x0 ->state D cpu 1
[ 2167.033812] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 15 ->gp_activity 3 ->gp_req_activity 15 ->gp_wake_time 15 ->gp_wake_seq 453621 ->gp_seq 453625 ->gp_seq_needed 453628 ->gp_max 453 ->gp_flags 0x0
[ 2167.040745] rcu: 	rcu_node 0:16 ->gp_seq 453625 ->gp_seq_needed 453628 ->qsmask 0x2 .... ->n_boosts 0
[ 2167.043963] rcu: 	rcu_node 0:8 ->gp_seq 453625 ->gp_seq_needed 453632 ->qsmask 0x0 .... ->n_boosts 0
[ 2167.047310] rcu: 	cpu 0 ->gp_seq_needed 453632
[ 2167.047993] rcu: 	cpu 1 ->gp_seq_needed 453632
[ 2167.048688] rcu: 	cpu 2 ->gp_seq_needed 453632
[ 2167.051657] rcu: 	cpu 8 ->gp_seq_needed 453632
[ 2167.052317] rcu: 	rcu_node 9:16 ->gp_seq 453625 ->gp_seq_needed 453632 ->qsmask 0x1 .... ->n_boosts 0
[ 2167.053704] rcu: 	cpu 9 ->gp_seq_needed 453632
[ 2167.056339] rcu: 	cpu 10 ->gp_seq_needed 453632
[ 2167.056996] rcu: 	cpu 11 ->gp_seq_needed 453632
[ 2167.057737] rcu: 	cpu 13 ->gp_seq_needed 453628
[ 2167.058384] rcu: 	cpu 14 ->gp_seq_needed 453632
[ 2167.061562] rcu: 	cpu 15 ->gp_seq_needed 453632
[ 2167.062459] rcu: 	cpu 16 ->gp_seq_needed 453632
[ 2167.065421] rcu: nocb GP 0 KldtS .[W.] .G:453632/169040 rnp 0:8 64379 S CPU 14
[ 2167.066528] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W7(453632/169040).N17. q24 S CPU 14
[ 2167.068996] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W6(453632/169040).N19. q25 S CPU 11
[ 2167.070182] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2167.071755] rcu:    CB 4^4->7 KblSW F1591901 L1591910 C119 ..... q0 S CPU 2
[ 2167.073460] rcu:    CB 5^4->4 KblSW F1557051 L1557051 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2167.074838] rcu:    CB 7^4->-1 KblSW F1573369 L1573375 C16 ..... q0 S CPU 13
[ 2167.079975] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2167.081747] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2167.083832] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2167.085774] rcu: RCU callbacks invoked since boot: 4707221
[ 2167.086972] rcu_tasks: RTGS_WAIT_CBS(11) since 2166513 g:0 i:0 k.u.. l:250 
[ 2182.377644] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4541499 ni: 80808 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2182.385224] rcu-torture: Reader Pipe:  4832028237 122018 0 0 0 0 0 0 0 0 0
[ 2182.386237] rcu-torture: Reader Batch:  4831421361 728894 0 0 0 0 0 0 0 0 0
[ 2182.387291] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2182.388782] ??? Writer stall state RTWS_EXP_SYNC(4) g457597 f0x0 ->state D cpu 1
[ 2182.389796] rcu: rcu_preempt: wait state: RCU_GP_INIT(4) ->state: R ->rt_priority 0 delta ->gp_start 16 ->gp_activity 6 ->gp_req_activity 16 ->gp_wake_time 22 ->gp_wake_seq 457593 ->gp_seq 457597 ->gp_seq_needed 457604 ->gp_max 453 ->gp_flags 0x0
[ 2182.392840] rcu: 	rcu_node 0:16 ->gp_seq 457597 ->gp_seq_needed 457604 ->qsmask 0x3 .... ->n_boosts 0
[ 2182.394241] rcu: 	rcu_node 0:8 ->gp_seq 457597 ->gp_seq_needed 457604 ->qsmask 0x106 .... ->n_boosts 0
[ 2182.395585] rcu: 	cpu 0 ->gp_seq_needed 457604
[ 2182.396199] rcu: 	cpu 1 ->gp_seq_needed 457604
[ 2182.396808] rcu: 	cpu 2 ->gp_seq_needed 457604
[ 2182.397358] rcu: 	cpu 8 ->gp_seq_needed 457604
[ 2182.397985] rcu: 	rcu_node 9:16 ->gp_seq 457597 ->gp_seq_needed 457604 ->qsmask 0xef .... ->n_boosts 0
[ 2182.399352] rcu: 	cpu 9 ->gp_seq_needed 457604
[ 2182.400033] rcu: 	cpu 10 ->gp_seq_needed 457604
[ 2182.400692] rcu: 	cpu 11 ->gp_seq_needed 457604
[ 2182.401360] rcu: 	cpu 12 ->gp_seq_needed 457604
[ 2182.402049] rcu: 	cpu 13 ->gp_seq_needed 457604
[ 2182.402728] rcu: 	cpu 14 ->gp_seq_needed 457600
[ 2182.403418] rcu: 	cpu 15 ->gp_seq_needed 457604
[ 2182.404113] rcu: 	cpu 16 ->gp_seq_needed 457604
[ 2182.404757] rcu: nocb GP 0 KldtS .[W.] .G:457600/169040 rnp 0:8 64893 S CPU 14
[ 2182.405715] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W8(457600/169040).N17. q25 S CPU 11
[ 2182.406655] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W9(457600/169040).N19. q28 S CPU 12
[ 2182.407496] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2182.408293] rcu:    CB 4^4->7 KblSW F1607237 L1607246 C119 ..... q0 S CPU 2
[ 2182.409077] rcu:    CB 5^4->4 KblSW F1572387 L1572387 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2182.410334] rcu:    CB 7^4->-1 KblSW F1588706 L1588712 C16 ..... q0 S CPU 13
[ 2182.411187] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2182.411881] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2182.412653] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2182.413338] rcu: RCU callbacks invoked since boot: 4747955
[ 2182.413962] rcu_tasks: RTGS_WAIT_CBS(11) since 2181840 g:0 i:0 k.u.. l:250 
[ 2197.737467] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4568695 ni: 81292 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2197.741437] rcu-torture: Reader Pipe:  4861051180 122018 0 0 0 0 0 0 0 0 0
[ 2197.742489] rcu-torture: Reader Batch:  4860440024 733174 0 0 0 0 0 0 0 0 0
[ 2197.743580] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2197.745121] ??? Writer stall state RTWS_EXP_SYNC(4) g460349 f0x0 ->state D cpu 1
[ 2197.746226] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 2 ->gp_activity 2 ->gp_req_activity 2 ->gp_wake_time 2 ->gp_wake_seq 460345 ->gp_seq 460349 ->gp_seq_needed 460348 ->gp_max 453 ->gp_flags 0x0
[ 2197.749399] rcu: 	rcu_node 0:16 ->gp_seq 460349 ->gp_seq_needed 460348 ->qsmask 0x2 .... ->n_boosts 0
[ 2197.750800] rcu: 	rcu_node 0:8 ->gp_seq 460349 ->gp_seq_needed 460356 ->qsmask 0x0 .... ->n_boosts 0
[ 2197.752164] rcu: 	cpu 0 ->gp_seq_needed 460352
[ 2197.752841] rcu: 	cpu 1 ->gp_seq_needed 460356
[ 2197.753505] rcu: 	cpu 2 ->gp_seq_needed 460352
[ 2197.754193] rcu: 	cpu 8 ->gp_seq_needed 460356
[ 2197.754851] rcu: 	rcu_node 9:16 ->gp_seq 460349 ->gp_seq_needed 460356 ->qsmask 0x1 .... ->n_boosts 0
[ 2197.756238] rcu: 	cpu 9 ->gp_seq_needed 460356
[ 2197.756910] rcu: 	cpu 10 ->gp_seq_needed 460356
[ 2197.757607] rcu: 	cpu 11 ->gp_seq_needed 460356
[ 2197.758313] rcu: 	cpu 12 ->gp_seq_needed 460352
[ 2197.758995] rcu: 	cpu 13 ->gp_seq_needed 460352
[ 2197.759675] rcu: 	cpu 14 ->gp_seq_needed 460356
[ 2197.760381] rcu: 	cpu 15 ->gp_seq_needed 460356
[ 2197.761084] rcu: 	cpu 16 ->gp_seq_needed 460356
[ 2197.761761] rcu: nocb GP 0 KldtS .[W.] .G:460352/169040 rnp 0:8 65251 S CPU 14
[ 2197.762824] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W5(460352/169040).N130. q135 S CPU 11
[ 2197.763982] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W6(460352/169040).N127. q133 S CPU 12
[ 2197.765098] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2197.766109] rcu:    CB 4^4->7 KblSW F1622595 L1622604 C119 ..... q0 S CPU 2
[ 2197.767137] rcu:    CB 5^4->4 KblSW F1587745 L1587745 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2197.768497] rcu:    CB 7^4->-1 KblSW F1604065 L1604071 C16 ..... q0 S CPU 13
[ 2197.769551] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2197.770481] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2197.771424] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2197.772462] rcu: RCU callbacks invoked since boot: 4774966
[ 2197.773389] rcu_tasks: RTGS_WAIT_CBS(11) since 2197199 g:0 i:0 k.u.. l:250 
[ 2213.097499] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4603287 ni: 81915 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2213.100466] rcu-torture: Reader Pipe:  4898087695 122018 0 0 0 0 0 0 0 0 0
[ 2213.101216] rcu-torture: Reader Batch:  4897472379 737334 0 0 0 0 0 0 0 0 0
[ 2213.101972] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2213.103091] ??? Writer stall state RTWS_EXP_SYNC(4) g462992 f0x0 ->state D cpu 1
[ 2213.103886] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 1501 ->gp_activity 1497 ->gp_req_activity 1501 ->gp_wake_time 1510 ->gp_wake_seq 462977 ->gp_seq 462992 ->gp_seq_needed 462992 ->gp_max 453 ->gp_flags 0x0
[ 2213.106341] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 65594 S CPU 8
[ 2213.107044] rcu:    CB 0^0->2 KblSW F1513 L1513 C0 ..... q0 S CPU 11
[ 2213.107734] rcu:    CB 2^0->-1 KblSW F1513 L1513 C0 ..... q0 S CPU 12
[ 2213.108438] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2213.109142] rcu:    CB 4^4->7 KblSW F1637938 L1637947 C119 ..... q0 S CPU 2
[ 2213.109895] rcu:    CB 5^4->4 KblSW F1603088 L1603088 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2213.110897] rcu:    CB 7^4->-1 KblSW F1619407 L1619413 C16 ..... q0 S CPU 13
[ 2213.111665] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2213.112360] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2213.113046] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2213.113723] rcu: RCU callbacks invoked since boot: 4810930
[ 2213.114317] rcu_tasks: RTGS_WAIT_CBS(11) since 2212540 g:0 i:0 k.u.. l:250 
[ 2228.458630] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4634870 ni: 82474 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2228.465409] rcu-torture: Reader Pipe:  4931569236 122018 0 0 0 0 0 0 0 0 0
[ 2228.468274] rcu-torture: Reader Batch:  4930948321 742933 0 0 0 0 0 0 0 0 0
[ 2228.470287] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2228.474576] ??? Writer stall state RTWS_EXP_SYNC(4) g466589 f0x0 ->state D cpu 1
[ 2228.475628] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 34 ->gp_activity 3 ->gp_req_activity 34 ->gp_wake_time 34 ->gp_wake_seq 466585 ->gp_seq 466589 ->gp_seq_needed 466588 ->gp_max 453 ->gp_flags 0x0
[ 2228.481621] rcu: 	rcu_node 0:16 ->gp_seq 466589 ->gp_seq_needed 466588 ->qsmask 0x2 .... ->n_boosts 0
[ 2228.486098] rcu: 	rcu_node 0:8 ->gp_seq 466589 ->gp_seq_needed 466596 ->qsmask 0x0 .... ->n_boosts 0
[ 2228.488294] rcu: 	cpu 0 ->gp_seq_needed 466592
[ 2228.489978] rcu: 	cpu 1 ->gp_seq_needed 466596
[ 2228.491233] rcu: 	cpu 2 ->gp_seq_needed 466596
[ 2228.494708] rcu: 	cpu 8 ->gp_seq_needed 466596
[ 2228.495369] rcu: 	rcu_node 9:16 ->gp_seq 466589 ->gp_seq_needed 466596 ->qsmask 0x40 .... ->n_boosts 0
[ 2228.496856] rcu: 	cpu 9 ->gp_seq_needed 466596
[ 2228.498159] rcu: 	cpu 10 ->gp_seq_needed 466596
[ 2228.498880] rcu: 	cpu 11 ->gp_seq_needed 466592
[ 2228.500404] rcu: 	cpu 12 ->gp_seq_needed 466592
[ 2228.503159] rcu: 	cpu 13 ->gp_seq_needed 466596
[ 2228.503862] rcu: 	cpu 14 ->gp_seq_needed 466596
[ 2228.504570] rcu: 	cpu 15 ->gp_seq_needed 466596
[ 2228.508107] rcu: 	cpu 16 ->gp_seq_needed 466596
[ 2228.508806] rcu: nocb GP 0 KldtS .[W.] .G:466592/169040 rnp 0:8 66061 S CPU 11
[ 2228.509935] rcu:    CB 0^0->2 KblSW F174 L174 C0 ..... q0 S CPU 12
[ 2228.510853] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W8(466592/169040).N27. q35 S CPU 0
[ 2228.511977] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2228.512952] rcu:    CB 4^4->7 KblSW F1653342 L1653351 C119 ..... q0 S CPU 2
[ 2228.513948] rcu:    CB 5^4->4 KblSW F1618492 L1618492 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2228.515302] rcu:    CB 7^4->-1 KblSW F1634810 L1634816 C16 ..... q0 S CPU 13
[ 2228.516360] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2228.517267] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2228.518203] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2228.519135] rcu: RCU callbacks invoked since boot: 4842986
[ 2228.519980] rcu_tasks: RTGS_WAIT_CBS(11) since 2227946 g:0 i:0 k.u.. l:250 
[ 2243.817645] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4662725 ni: 82967 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2243.824799] rcu-torture: Reader Pipe:  4960923378 122018 0 0 0 0 0 0 0 0 0
[ 2243.826006] rcu-torture: Reader Batch:  4960297376 748020 0 0 0 0 0 0 0 0 0
[ 2243.830000] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2243.831579] ??? Writer stall state RTWS_EXP_SYNC(4) g469929 f0x0 ->state D cpu 1
[ 2243.836367] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 21 ->gp_activity 3 ->gp_req_activity 21 ->gp_wake_time 21 ->gp_wake_seq 469925 ->gp_seq 469929 ->gp_seq_needed 469928 ->gp_max 453 ->gp_flags 0x0
[ 2243.844265] rcu: 	rcu_node 0:16 ->gp_seq 469929 ->gp_seq_needed 469928 ->qsmask 0x2 .... ->n_boosts 0
[ 2243.845661] rcu: 	rcu_node 0:8 ->gp_seq 469929 ->gp_seq_needed 469936 ->qsmask 0x0 .... ->n_boosts 0
[ 2243.847040] rcu: 	cpu 0 ->gp_seq_needed 469932
[ 2243.847712] rcu: 	cpu 1 ->gp_seq_needed 469936
[ 2243.848475] rcu: 	cpu 2 ->gp_seq_needed 469936
[ 2243.849183] rcu: 	rcu_node 9:16 ->gp_seq 469929 ->gp_seq_needed 469936 ->qsmask 0x1 .... ->n_boosts 0
[ 2243.850546] rcu: 	cpu 9 ->gp_seq_needed 469936
[ 2243.851239] rcu: 	cpu 10 ->gp_seq_needed 469936
[ 2243.852001] rcu: 	cpu 11 ->gp_seq_needed 469932
[ 2243.852712] rcu: 	cpu 12 ->gp_seq_needed 469932
[ 2243.853471] rcu: 	cpu 13 ->gp_seq_needed 469936
[ 2243.854212] rcu: 	cpu 14 ->gp_seq_needed 469936
[ 2243.854933] rcu: 	cpu 15 ->gp_seq_needed 469936
[ 2243.855604] rcu: 	cpu 16 ->gp_seq_needed 469936
[ 2243.856546] rcu: nocb GP 0 KldtS .[.W] .G:469932/169040 rnp 0:8 66495 S CPU 11
[ 2243.857816] rcu:    CB 0^0->2 KblSW F701 L701 C0 ..... q0 S CPU 12
[ 2243.858717] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W4(469932/169040).N17. q21 S CPU 0
[ 2243.859798] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2243.861020] rcu:    CB 4^4->7 KblSW F1668690 L1668699 C119 ..... q0 S CPU 2
[ 2243.862088] rcu:    CB 5^4->4 KblSW F1633840 L1633840 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2243.863387] rcu:    CB 7^4->-1 KblSW F1650159 L1650165 C16 ..... q0 S CPU 13
[ 2243.864708] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2243.865668] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2243.866768] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2243.867743] rcu: RCU callbacks invoked since boot: 4871384
[ 2243.868660] rcu_tasks: RTGS_WAIT_CBS(11) since 2243295 g:0 i:0 k.u.. l:250 
[ 2259.177498] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4701815 ni: 83665 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2259.181677] rcu-torture: Reader Pipe:  5002479158 122018 0 0 0 0 0 0 0 0 0
[ 2259.182743] rcu-torture: Reader Batch:  5001847747 753429 0 0 0 0 0 0 0 0 0
[ 2259.183792] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2259.185218] ??? Writer stall state RTWS_EXP_SYNC(4) g473449 f0x0 ->state D cpu 1
[ 2259.186219] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 198 ->gp_activity 0 ->gp_req_activity 198 ->gp_wake_time 198 ->gp_wake_seq 473445 ->gp_seq 473449 ->gp_seq_needed 473448 ->gp_max 453 ->gp_flags 0x0
[ 2259.189523] rcu: 	rcu_node 0:16 ->gp_seq 473449 ->gp_seq_needed 473448 ->qsmask 0x2 .... ->n_boosts 0
[ 2259.190913] rcu: 	rcu_node 0:8 ->gp_seq 473449 ->gp_seq_needed 473456 ->qsmask 0x0 .... ->n_boosts 0
[ 2259.192214] rcu: 	cpu 0 ->gp_seq_needed 473452
[ 2259.192861] rcu: 	cpu 1 ->gp_seq_needed 473456
[ 2259.193507] rcu: 	cpu 2 ->gp_seq_needed 473456
[ 2259.194169] rcu: 	cpu 8 ->gp_seq_needed 473452
[ 2259.194822] rcu: 	rcu_node 9:16 ->gp_seq 473449 ->gp_seq_needed 473456 ->qsmask 0x0 ...G ->n_boosts 0
[ 2259.196158] rcu: 	cpu 9 ->gp_seq_needed 473456
[ 2259.196799] rcu: 	cpu 10 ->gp_seq_needed 473456
[ 2259.197472] rcu: 	cpu 11 ->gp_seq_needed 473456
[ 2259.198131] rcu: 	cpu 12 ->gp_seq_needed 473452
[ 2259.198728] rcu: 	cpu 13 ->gp_seq_needed 473452
[ 2259.199387] rcu: 	cpu 14 ->gp_seq_needed 473456
[ 2259.200077] rcu: 	cpu 15 ->gp_seq_needed 473456
[ 2259.200757] rcu: 	cpu 16 ->gp_seq_needed 473456
[ 2259.201426] rcu: nocb GP 0 Kldts .[.W] .G:473452/169040 rnp 0:8 66951 S CPU 13
[ 2259.202565] rcu:    CB 0^0->2 KblSW F112 L112 C0 ...N1. q1 S CPU 9
[ 2259.203473] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W7(473452/169040).N88. q95 S CPU 0
[ 2259.204596] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2259.205582] rcu:    CB 4^4->7 KblSW F1684035 L1684044 C119 ..... q0 S CPU 2
[ 2259.206653] rcu:    CB 5^4->4 KblSW F1649185 L1649185 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2259.208065] rcu:    CB 7^4->-1 KblSW F1665504 L1665510 C16 ..... q0 S CPU 13
[ 2259.209116] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2259.209863] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2259.210832] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2259.211770] rcu: RCU callbacks invoked since boot: 4910675
[ 2259.212627] rcu_tasks: RTGS_WAIT_CBS(11) since 2258639 g:0 i:0 k.u.. l:250 
[ 2274.538535] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4728679 ni: 84146 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2274.544436] rcu-torture: Reader Pipe:  5031698291 122018 0 0 0 0 0 0 0 0 0
[ 2274.545487] rcu-torture: Reader Batch:  5031062585 757724 0 0 0 0 0 0 0 0 0
[ 2274.547098] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2274.550302] ??? Writer stall state RTWS_EXP_SYNC(4) g476257 f0x0 ->state D cpu 1
[ 2274.551440] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 7 ->gp_activity 3 ->gp_req_activity 7 ->gp_wake_time 18 ->gp_wake_seq 476245 ->gp_seq 476257 ->gp_seq_needed 476256 ->gp_max 453 ->gp_flags 0x0
[ 2274.554693] rcu: 	rcu_node 0:16 ->gp_seq 476257 ->gp_seq_needed 476256 ->qsmask 0x3 .... ->n_boosts 0
[ 2274.555937] rcu: 	rcu_node 0:8 ->gp_seq 476257 ->gp_seq_needed 476264 ->qsmask 0x0 .... ->n_boosts 0
[ 2274.557576] rcu: 	cpu 0 ->gp_seq_needed 476260
[ 2274.560220] rcu: 	cpu 1 ->gp_seq_needed 476264
[ 2274.560915] rcu: 	cpu 2 ->gp_seq_needed 476260
[ 2274.561598] rcu: 	rcu_node 9:16 ->gp_seq 476257 ->gp_seq_needed 476264 ->qsmask 0x1 .... ->n_boosts 0
[ 2274.563815] rcu: 	cpu 9 ->gp_seq_needed 476264
[ 2274.564471] rcu: 	cpu 10 ->gp_seq_needed 476264
[ 2274.566534] rcu: 	cpu 11 ->gp_seq_needed 476264
[ 2274.567156] rcu: 	cpu 12 ->gp_seq_needed 476264
[ 2274.567839] rcu: 	cpu 13 ->gp_seq_needed 476260
[ 2274.568547] rcu: 	cpu 14 ->gp_seq_needed 476264
[ 2274.569241] rcu: 	cpu 16 ->gp_seq_needed 476264
[ 2274.569925] rcu: nocb GP 0 KldtS .[.W] .G:476260/169040 rnp 0:8 67316 S CPU 13
[ 2274.570985] rcu:    CB 0^0->2 KblSW F114 L114 C0 ..... q0 S CPU 15
[ 2274.571917] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W7(476260/169040).N11. q18 S CPU 0
[ 2274.573058] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2274.574069] rcu:    CB 4^4->7 KblSW F1699403 L1699412 C119 ..... q0 S CPU 2
[ 2274.575063] rcu:    CB 5^4->4 KblSW F1664553 L1664553 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2274.576417] rcu:    CB 7^4->-1 KblSW F1680872 L1680878 C16 ..... q0 S CPU 13
[ 2274.577476] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2274.578365] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2274.579400] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2274.580355] rcu: RCU callbacks invoked since boot: 4938546
[ 2274.581201] rcu_tasks: RTGS_WAIT_CBS(11) since 2274007 g:0 i:0 k.u.. l:250 
[ 2289.897508] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4767903 ni: 84841 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2289.900466] rcu-torture: Reader Pipe:  5073676840 122018 0 0 0 0 0 0 0 0 0
[ 2289.901209] rcu-torture: Reader Batch:  5073034861 763997 0 0 0 0 0 0 0 0 0
[ 2289.901963] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2289.903039] ??? Writer stall state RTWS_EXP_SYNC(4) g480340 f0x0 ->state D cpu 1
[ 2289.903833] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 307 ->gp_activity 302 ->gp_req_activity 307 ->gp_wake_time 316 ->gp_wake_seq 480325 ->gp_seq 480340 ->gp_seq_needed 480340 ->gp_max 453 ->gp_flags 0x0
[ 2289.906206] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 67846 S CPU 13
[ 2289.906924] rcu:    CB 0^0->2 KblSW F1540 L1540 C0 ..... q0 S CPU 15
[ 2289.907602] rcu:    CB 2^0->-1 KblSW F316 L316 C0 ..... q0 S CPU 0
[ 2289.908266] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2289.908972] rcu:    CB 4^4->7 KblSW F1714738 L1714747 C119 ..... q0 S CPU 2
[ 2289.909735] rcu:    CB 5^4->4 KblSW F1679888 L1679888 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2289.910727] rcu:    CB 7^4->-1 KblSW F1696207 L1696213 C16 ..... q0 S CPU 13
[ 2289.911478] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2289.912130] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2289.912804] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2289.913468] rcu: RCU callbacks invoked since boot: 4978472
[ 2289.914069] rcu_tasks: RTGS_WAIT_CBS(11) since 2289340 g:0 i:0 k.u.. l:250 
[ 2305.260605] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4795580 ni: 85338 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2305.264307] rcu-torture: Reader Pipe:  5102798796 122018 0 0 0 0 0 0 0 0 0
[ 2305.265248] rcu-torture: Reader Batch:  5102153135 767679 0 0 0 0 0 0 0 0 0
[ 2305.266193] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2305.267560] ??? Writer stall state RTWS_EXP_SYNC(4) g482721 f0x0 ->state D cpu 1
[ 2305.268568] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 4 ->gp_activity 0 ->gp_req_activity 4 ->gp_wake_time 6 ->gp_wake_seq 482717 ->gp_seq 482721 ->gp_seq_needed 482720 ->gp_max 453 ->gp_flags 0x0
[ 2305.271473] rcu: 	rcu_node 0:16 ->gp_seq 482721 ->gp_seq_needed 482720 ->qsmask 0x2 .... ->n_boosts 0
[ 2305.272830] rcu: 	rcu_node 0:8 ->gp_seq 482721 ->gp_seq_needed 482728 ->qsmask 0x0 .... ->n_boosts 0
[ 2305.274059] rcu: 	cpu 0 ->gp_seq_needed 482724
[ 2305.274669] rcu: 	cpu 1 ->gp_seq_needed 482728
[ 2305.275265] rcu: 	cpu 2 ->gp_seq_needed 482724
[ 2305.277867] rcu: 	cpu 8 ->gp_seq_needed 482724
[ 2305.279538] rcu: 	rcu_node 9:16 ->gp_seq 482721 ->gp_seq_needed 482728 ->qsmask 0x41 .... ->n_boosts 0
[ 2305.281582] rcu: 	cpu 9 ->gp_seq_needed 482724
[ 2305.282186] rcu: 	cpu 11 ->gp_seq_needed 482728
[ 2305.282806] rcu: 	cpu 12 ->gp_seq_needed 482728
[ 2305.285087] rcu: 	cpu 13 ->gp_seq_needed 482728
[ 2305.286795] rcu: 	cpu 14 ->gp_seq_needed 482728
[ 2305.287403] rcu: 	cpu 15 ->gp_seq_needed 482728
[ 2305.288024] rcu: 	cpu 16 ->gp_seq_needed 482728
[ 2305.288645] rcu: nocb GP 0 Kldts .[.W] .G:482724/169040 rnp 0:8 68155 S CPU 13
[ 2305.292122] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W5(482724/169040).N14. q19 S CPU 9
[ 2305.295008] rcu:    CB 2^0->-1 KblSW F22 L22 C0 ...N1. q1 S CPU 2
[ 2305.295837] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2305.297578] rcu:    CB 4^4->7 KblSW F1730127 L1730136 C119 ..... q0 S CPU 2
[ 2305.298520] rcu:    CB 5^4->4 KblSW F1695277 L1695277 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2305.299775] rcu:    CB 7^4->-1 KblSW F1711596 L1711602 C16 ..... q0 S CPU 13
[ 2305.301809] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2305.305466] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2305.306311] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2305.310010] rcu: RCU callbacks invoked since boot: 5006610
[ 2305.310760] rcu_tasks: RTGS_WAIT_CBS(11) since 2304737 g:0 i:0 k.u.. l:250 
[ 2320.617473] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4822698 ni: 85824 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2320.620435] rcu-torture: Reader Pipe:  5131778648 122018 0 0 0 0 0 0 0 0 0
[ 2320.621194] rcu-torture: Reader Batch:  5131128624 772042 0 0 0 0 0 0 0 0 0
[ 2320.621965] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2320.623064] ??? Writer stall state RTWS_EXP_SYNC(4) g485633 f0x0 ->state D cpu 1
[ 2320.623981] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 0 ->gp_activity 0 ->gp_req_activity 0 ->gp_wake_time 0 ->gp_wake_seq 485633 ->gp_seq 485637 ->gp_seq_needed 485636 ->gp_max 453 ->gp_flags 0x0
[ 2320.626354] rcu: 	rcu_node 0:16 ->gp_seq 485637 ->gp_seq_needed 485636 ->qsmask 0x3 .... ->n_boosts 0
[ 2320.627340] rcu: 	rcu_node 0:8 ->gp_seq 485637 ->gp_seq_needed 485644 ->qsmask 0x101 .... ->n_boosts 0
[ 2320.628454] rcu: 	cpu 0 ->gp_seq_needed 485644
[ 2320.628989] rcu: 	cpu 1 ->gp_seq_needed 485644
[ 2320.629570] rcu: 	cpu 2 ->gp_seq_needed 485640
[ 2320.630110] rcu: 	rcu_node 9:16 ->gp_seq 485637 ->gp_seq_needed 485644 ->qsmask 0x1 .... ->n_boosts 0
[ 2320.631237] rcu: 	cpu 9 ->gp_seq_needed 485640
[ 2320.631839] rcu: 	cpu 11 ->gp_seq_needed 485644
[ 2320.632325] rcu: 	cpu 12 ->gp_seq_needed 485644
[ 2320.632876] rcu: 	cpu 13 ->gp_seq_needed 485644
[ 2320.633381] rcu: 	cpu 14 ->gp_seq_needed 485644
[ 2320.633942] rcu: 	cpu 15 ->gp_seq_needed 485644
[ 2320.634441] rcu: 	cpu 16 ->gp_seq_needed 485644
[ 2320.634954] rcu: nocb GP 0 KldtS .[.W] .G:485644/169040 rnp 0:8 68535 S CPU 15
[ 2320.635769] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W6(485644/169040).N4. q10 S CPU 0
[ 2320.636594] rcu:    CB 2^0->-1 KblSW F48 L48 C1 ..... q0 S CPU 2
[ 2320.637238] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2320.637981] rcu:    CB 4^4->7 KblSW F1745467 L1745476 C119 ..... q0 S CPU 2
[ 2320.638757] rcu:    CB 5^4->4 KblSW F1710617 L1710617 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2320.639797] rcu:    CB 7^4->-1 KblSW F1726936 L1726942 C16 ..... q0 S CPU 13
[ 2320.640594] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2320.641256] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2320.642040] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2320.642755] rcu: RCU callbacks invoked since boot: 5034231
[ 2320.643345] rcu_tasks: RTGS_WAIT_CBS(11) since 2320069 g:0 i:0 k.u.. l:250 
[ 2335.977467] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4862536 ni: 86532 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2335.986939] rcu-torture: Reader Pipe:  5173857072 122018 0 0 0 0 0 0 0 0 0
[ 2335.988153] rcu-torture: Reader Batch:  5173200778 778312 0 0 0 0 0 0 0 0 0
[ 2335.989182] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2335.990746] ??? Writer stall state RTWS_EXP_SYNC(4) g489745 f0x0 ->state D cpu 1
[ 2335.991885] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 237 ->gp_activity 4 ->gp_req_activity 237 ->gp_wake_time 237 ->gp_wake_seq 489741 ->gp_seq 489745 ->gp_seq_needed 489744 ->gp_max 453 ->gp_flags 0x0
[ 2335.995342] rcu: 	rcu_node 0:16 ->gp_seq 489745 ->gp_seq_needed 489744 ->qsmask 0x2 .... ->n_boosts 0
[ 2335.996760] rcu: 	rcu_node 0:8 ->gp_seq 489745 ->gp_seq_needed 489752 ->qsmask 0x0 .... ->n_boosts 0
[ 2335.998171] rcu: 	cpu 0 ->gp_seq_needed 489752
[ 2335.998893] rcu: 	cpu 1 ->gp_seq_needed 489752
[ 2335.999588] rcu: 	cpu 2 ->gp_seq_needed 489748
[ 2336.000273] rcu: 	cpu 8 ->gp_seq_needed 489752
[ 2336.000949] rcu: 	rcu_node 9:16 ->gp_seq 489745 ->gp_seq_needed 489752 ->qsmask 0x8 .... ->n_boosts 0
[ 2336.002258] rcu: 	cpu 9 ->gp_seq_needed 489752
[ 2336.002985] rcu: 	cpu 10 ->gp_seq_needed 489752
[ 2336.003696] rcu: 	cpu 11 ->gp_seq_needed 489752
[ 2336.004372] rcu: 	cpu 12 ->gp_seq_needed 489748
[ 2336.005119] rcu: 	cpu 13 ->gp_seq_needed 489752
[ 2336.005814] rcu: 	cpu 14 ->gp_seq_needed 489752
[ 2336.006520] rcu: 	cpu 15 ->gp_seq_needed 489752
[ 2336.007221] rcu: 	cpu 16 ->gp_seq_needed 489752
[ 2336.007911] rcu: nocb GP 0 Kldts .[W.] .G:489752/169040 rnp 0:8 69067 S CPU 15
[ 2336.009486] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W6(489752/169040).N100. q106 S CPU 1
[ 2336.010615] rcu:    CB 2^0->-1 KblSW F87 L87 C0 ...N3. q3 S CPU 2
[ 2336.011740] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2336.012648] rcu:    CB 4^4->7 KblSW F1760842 L1760851 C119 ..... q0 S CPU 2
[ 2336.013652] rcu:    CB 5^4->4 KblSW F1725992 L1725992 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2336.015045] rcu:    CB 7^4->-1 KblSW F1742311 L1742317 C16 ..... q0 S CPU 13
[ 2336.016120] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2336.017074] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2336.018020] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2336.018956] rcu: RCU callbacks invoked since boot: 5074201
[ 2336.019777] rcu_tasks: RTGS_WAIT_CBS(11) since 2335446 g:0 i:0 k.u.. l:250 
[ 2351.339383] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4889066 ni: 87006 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2351.343037] rcu-torture: Reader Pipe:  5202127034 122018 0 0 0 0 0 0 0 0 0
[ 2351.343966] rcu-torture: Reader Batch:  5201466918 782134 0 0 0 0 0 0 0 0 0
[ 2351.345468] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2351.348053] ??? Writer stall state RTWS_EXP_SYNC(4) g492217 f0x0 ->state D cpu 1
[ 2351.349065] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 13 ->gp_activity 1 ->gp_req_activity 13 ->gp_wake_time 596 ->gp_wake_seq 492201 ->gp_seq 492217 ->gp_seq_needed 492220 ->gp_max 453 ->gp_flags 0x0
[ 2351.351987] rcu: 	rcu_node 0:16 ->gp_seq 492217 ->gp_seq_needed 492220 ->qsmask 0x2 .... ->n_boosts 0
[ 2351.353203] rcu: 	rcu_node 0:8 ->gp_seq 492217 ->gp_seq_needed 492224 ->qsmask 0x0 .... ->n_boosts 0
[ 2351.354406] rcu: 	cpu 0 ->gp_seq_needed 492224
[ 2351.355001] rcu: 	cpu 1 ->gp_seq_needed 492220
[ 2351.355603] rcu: 	cpu 2 ->gp_seq_needed 492220
[ 2351.356190] rcu: 	cpu 8 ->gp_seq_needed 492224
[ 2351.356790] rcu: 	rcu_node 9:16 ->gp_seq 492217 ->gp_seq_needed 492224 ->qsmask 0x80 .... ->n_boosts 0
[ 2351.358017] rcu: 	cpu 9 ->gp_seq_needed 492224
[ 2351.358647] rcu: 	cpu 10 ->gp_seq_needed 492224
[ 2351.359243] rcu: 	cpu 11 ->gp_seq_needed 492224
[ 2351.359880] rcu: 	cpu 12 ->gp_seq_needed 492224
[ 2351.360492] rcu: 	cpu 13 ->gp_seq_needed 492224
[ 2351.361091] rcu: 	cpu 14 ->gp_seq_needed 492224
[ 2351.361700] rcu: 	cpu 15 ->gp_seq_needed 492224
[ 2351.364555] rcu: 	cpu 16 ->gp_seq_needed 492224
[ 2351.365165] rcu: nocb GP 0 KldtS .[.W] .G:492220/169040 rnp 0:8 69391 S CPU 15
[ 2351.366130] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W132(492220/169040).N120. q252 S CPU 9
[ 2351.367166] rcu:    CB 2^0->-1 KblSW F3 L3 C0 .W125(492220/169040).N125. q250 S CPU 10
[ 2351.368233] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2351.369106] rcu:    CB 4^4->7 KblSW F1776198 L1776207 C119 ..... q0 S CPU 2
[ 2351.370033] rcu:    CB 5^4->4 KblSW F1741348 L1741348 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2351.371258] rcu:    CB 7^4->-1 KblSW F1757667 L1757673 C16 ..... q0 S CPU 13
[ 2351.372196] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2351.373034] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2351.373874] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2351.374714] rcu: RCU callbacks invoked since boot: 5100361
[ 2351.375446] rcu_tasks: RTGS_WAIT_CBS(11) since 2350802 g:0 i:0 k.u.. l:250 
[ 2366.702921] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4928422 ni: 87697 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2366.707118] rcu-torture: Reader Pipe:  5243547120 122018 0 0 0 0 0 0 0 0 0
[ 2366.708176] rcu-torture: Reader Batch:  5242881387 787751 0 0 0 0 0 0 0 0 0
[ 2366.709558] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2366.711146] ??? Writer stall state RTWS_EXP_SYNC(4) g495833 f0x0 ->state D cpu 1
[ 2366.712335] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 26 ->gp_activity 2 ->gp_req_activity 26 ->gp_wake_time 80 ->gp_wake_seq 495825 ->gp_seq 495833 ->gp_seq_needed 495836 ->gp_max 453 ->gp_flags 0x0
[ 2366.715782] rcu: 	rcu_node 0:16 ->gp_seq 495833 ->gp_seq_needed 495836 ->qsmask 0x2 .... ->n_boosts 0
[ 2366.717235] rcu: 	rcu_node 0:8 ->gp_seq 495833 ->gp_seq_needed 495840 ->qsmask 0x0 .... ->n_boosts 0
[ 2366.718631] rcu: 	cpu 0 ->gp_seq_needed 495840
[ 2366.719324] rcu: 	cpu 1 ->gp_seq_needed 495836
[ 2366.719979] rcu: 	cpu 2 ->gp_seq_needed 495836
[ 2366.720669] rcu: 	cpu 8 ->gp_seq_needed 495840
[ 2366.721340] rcu: 	rcu_node 9:16 ->gp_seq 495833 ->gp_seq_needed 495840 ->qsmask 0x4 .... ->n_boosts 0
[ 2366.723987] rcu: 	cpu 9 ->gp_seq_needed 495840
[ 2366.724717] rcu: 	cpu 10 ->gp_seq_needed 495840
[ 2366.727149] rcu: 	cpu 11 ->gp_seq_needed 495836
[ 2366.730721] rcu: 	cpu 12 ->gp_seq_needed 495840
[ 2366.731422] rcu: 	cpu 14 ->gp_seq_needed 495840
[ 2366.732124] rcu: 	cpu 15 ->gp_seq_needed 495836
[ 2366.732829] rcu: 	cpu 16 ->gp_seq_needed 495840
[ 2366.733750] rcu: nocb GP 0 Kldts .[.W] .G:495836/169040 rnp 0:8 69860 S CPU 15
[ 2366.737227] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W17(495836/169040).N25. q42 S CPU 1
[ 2366.738360] rcu:    CB 2^0->-1 KblSW F14 L14 C0 ...N1. q1 S CPU 10
[ 2366.740683] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2366.743598] rcu:    CB 4^4->7 KblSW F1791573 L1791582 C119 ..... q0 S CPU 2
[ 2366.744648] rcu:    CB 5^4->4 KblSW F1756723 L1756723 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2366.749017] rcu:    CB 7^4->-1 KblSW F1773045 L1773051 C16 ..... q0 S CPU 13
[ 2366.750098] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2366.751031] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2366.751972] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2366.752929] rcu: RCU callbacks invoked since boot: 5141627
[ 2366.753769] rcu_tasks: RTGS_WAIT_CBS(11) since 2366180 g:0 i:0 k.u.. l:250 
[ 2382.058592] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4955381 ni: 88178 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2382.062626] rcu-torture: Reader Pipe:  5272251241 122018 0 0 0 0 0 0 0 0 0
[ 2382.063716] rcu-torture: Reader Batch:  5271581238 792021 0 0 0 0 0 0 0 0 0
[ 2382.064762] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2382.066279] ??? Writer stall state RTWS_EXP_SYNC(4) g498617 f0x0 ->state D cpu 1
[ 2382.067387] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 10 ->gp_activity 2 ->gp_req_activity 10 ->gp_wake_time 10 ->gp_wake_seq 498613 ->gp_seq 498617 ->gp_seq_needed 498616 ->gp_max 453 ->gp_flags 0x0
[ 2382.070596] rcu: 	rcu_node 0:16 ->gp_seq 498617 ->gp_seq_needed 498616 ->qsmask 0x2 .... ->n_boosts 0
[ 2382.072000] rcu: 	rcu_node 0:8 ->gp_seq 498617 ->gp_seq_needed 498624 ->qsmask 0x0 .... ->n_boosts 0
[ 2382.073358] rcu: 	cpu 0 ->gp_seq_needed 498624
[ 2382.074033] rcu: 	cpu 1 ->gp_seq_needed 498624
[ 2382.074726] rcu: 	cpu 2 ->gp_seq_needed 498620
[ 2382.075414] rcu: 	cpu 8 ->gp_seq_needed 498624
[ 2382.076102] rcu: 	rcu_node 9:16 ->gp_seq 498617 ->gp_seq_needed 498624 ->qsmask 0x2 .... ->n_boosts 0
[ 2382.077499] rcu: 	cpu 9 ->gp_seq_needed 498624
[ 2382.078179] rcu: 	cpu 10 ->gp_seq_needed 498624
[ 2382.078883] rcu: 	cpu 11 ->gp_seq_needed 498624
[ 2382.079568] rcu: 	cpu 12 ->gp_seq_needed 498624
[ 2382.080226] rcu: 	cpu 14 ->gp_seq_needed 498624
[ 2382.080903] rcu: 	cpu 15 ->gp_seq_needed 498624
[ 2382.081630] rcu: 	cpu 16 ->gp_seq_needed 498624
[ 2382.082314] rcu: nocb GP 0 KldtS .[W.] .G:498624/169040 rnp 0:8 70222 S CPU 15
[ 2382.083437] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W8(498624/169040).N9. q17 S CPU 1
[ 2382.084564] rcu:    CB 2^0->-1 KblSW F34 L34 C0 .W1(498624/169040)... q1 S CPU 10
[ 2382.085662] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2382.086645] rcu:    CB 4^4->7 KblSW F1806913 L1806922 C119 ..... q0 S CPU 2
[ 2382.087803] rcu:    CB 5^4->4 KblSW F1772066 L1772066 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2382.089234] rcu:    CB 7^4->-1 KblSW F1788385 L1788391 C16 ..... q0 S CPU 13
[ 2382.090278] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2382.091185] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2382.092086] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2382.093018] rcu: RCU callbacks invoked since boot: 5169237
[ 2382.093810] rcu_tasks: RTGS_WAIT_CBS(11) since 2381520 g:0 i:0 k.u.. l:250 
[ 2397.417513] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4984677 ni: 88702 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2397.421763] rcu-torture: Reader Pipe:  5303856683 122018 0 0 0 0 0 0 0 0 0
[ 2397.422875] rcu-torture: Reader Batch:  5303182530 796171 0 0 0 0 0 0 0 0 0
[ 2397.423980] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2397.425606] ??? Writer stall state RTWS_EXP_SYNC(4) g501308 f0x0 ->state D cpu 1
[ 2397.426725] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 3560 ->gp_activity 3556 ->gp_req_activity 3560 ->gp_wake_time 3570 ->gp_wake_seq 501293 ->gp_seq 501308 ->gp_seq_needed 501308 ->gp_max 453 ->gp_flags 0x0
[ 2397.430370] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 70571 S CPU 13
[ 2397.431358] rcu:    CB 0^0->2 KblSW F3843 L3843 C0 ..... q0 S CPU 1
[ 2397.432331] rcu:    CB 2^0->-1 KblSW F3878 L3878 C0 ..... q0 S CPU 10
[ 2397.433149] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2397.433879] rcu:    CB 4^4->7 KblSW F1822263 L1822272 C119 ..... q0 S CPU 2
[ 2397.434631] rcu:    CB 5^4->4 KblSW F1787413 L1787413 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2397.435632] rcu:    CB 7^4->-1 KblSW F1803732 L1803738 C16 ..... q0 S CPU 13
[ 2397.436407] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2397.437057] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2397.437734] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2397.438405] rcu: RCU callbacks invoked since boot: 5199107
[ 2397.438994] rcu_tasks: RTGS_WAIT_CBS(11) since 2396865 g:0 i:0 k.u.. l:250 
[ 2412.777456] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5021105 ni: 89357 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2412.785967] rcu-torture: Reader Pipe:  5342914921 122018 0 0 0 0 0 0 0 0 0
[ 2412.788037] rcu-torture: Reader Batch:  5342235218 801721 0 0 0 0 0 0 0 0 0
[ 2412.792370] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2412.793925] ??? Writer stall state RTWS_EXP_SYNC(4) g504917 f0x0 ->state D cpu 1
[ 2412.795543] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 6 ->gp_activity 6 ->gp_req_activity 6 ->gp_wake_time 10 ->gp_wake_seq 504913 ->gp_seq 504917 ->gp_seq_needed 504916 ->gp_max 453 ->gp_flags 0x0
[ 2412.804903] rcu: 	rcu_node 0:16 ->gp_seq 504917 ->gp_seq_needed 504916 ->qsmask 0x2 .... ->n_boosts 0
[ 2412.806189] rcu: 	rcu_node 0:8 ->gp_seq 504917 ->gp_seq_needed 504924 ->qsmask 0x0 .... ->n_boosts 0
[ 2412.807673] rcu: 	cpu 0 ->gp_seq_needed 504924
[ 2412.808399] rcu: 	cpu 1 ->gp_seq_needed 504924
[ 2412.809102] rcu: 	cpu 2 ->gp_seq_needed 504920
[ 2412.809855] rcu: 	cpu 8 ->gp_seq_needed 504924
[ 2412.810559] rcu: 	rcu_node 9:16 ->gp_seq 504917 ->gp_seq_needed 504924 ->qsmask 0x2 .... ->n_boosts 0
[ 2412.811945] rcu: 	cpu 9 ->gp_seq_needed 504924
[ 2412.812674] rcu: 	cpu 10 ->gp_seq_needed 504924
[ 2412.813317] rcu: 	cpu 11 ->gp_seq_needed 504924
[ 2412.814036] rcu: 	cpu 12 ->gp_seq_needed 504924
[ 2412.814728] rcu: 	cpu 13 ->gp_seq_needed 504924
[ 2412.815407] rcu: 	cpu 14 ->gp_seq_needed 504924
[ 2412.816044] rcu: 	cpu 15 ->gp_seq_needed 504924
[ 2412.816675] rcu: 	cpu 16 ->gp_seq_needed 504924
[ 2412.817380] rcu: nocb GP 0 KldtS .[.W] .G:504924/169040 rnp 0:8 71040 S CPU 13
[ 2412.818479] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W131(504924/169040).N10. q141 S CPU 1
[ 2412.819665] rcu:    CB 2^0->-1 KblSW F82 L82 C0 .W3(504924/169040)... q3 S CPU 10
[ 2412.820841] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2412.821889] rcu:    CB 4^4->7 KblSW F1837651 L1837660 C119 ..... q0 S CPU 2
[ 2412.822972] rcu:    CB 5^4->4 KblSW F1802801 L1802801 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2412.824464] rcu:    CB 7^4->-1 KblSW F1819121 L1819127 C16 ..... q0 S CPU 13
[ 2412.825617] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2412.826581] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2412.827612] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2412.828632] rcu: RCU callbacks invoked since boot: 5235394
[ 2412.829514] rcu_tasks: RTGS_WAIT_CBS(11) since 2412256 g:0 i:0 k.u.. l:250 
[ 2428.137465] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5047578 ni: 89834 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2428.142364] rcu-torture: Reader Pipe:  5370954452 122018 0 0 0 0 0 0 0 0 0
[ 2428.143383] rcu-torture: Reader Batch:  5370270921 805549 0 0 0 0 0 0 0 0 0
[ 2428.144481] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2428.145909] ??? Writer stall state RTWS_EXP_SYNC(4) g507401 f0x0 ->state D cpu 1
[ 2428.146994] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 46 ->gp_activity 46 ->gp_req_activity 46 ->gp_wake_time 46 ->gp_wake_seq 507397 ->gp_seq 507401 ->gp_seq_needed 507400 ->gp_max 453 ->gp_flags 0x0
[ 2428.150319] rcu: 	rcu_node 0:16 ->gp_seq 507401 ->gp_seq_needed 507400 ->qsmask 0x3 .... ->n_boosts 0
[ 2428.151768] rcu: 	rcu_node 0:8 ->gp_seq 507401 ->gp_seq_needed 507408 ->qsmask 0x3 .... ->n_boosts 0
[ 2428.153168] rcu: 	cpu 1 ->gp_seq_needed 507408
[ 2428.153858] rcu: 	cpu 2 ->gp_seq_needed 507404
[ 2428.154564] rcu: 	cpu 8 ->gp_seq_needed 507408
[ 2428.155222] rcu: 	rcu_node 9:16 ->gp_seq 507401 ->gp_seq_needed 507408 ->qsmask 0x11 .... ->n_boosts 0
[ 2428.156579] rcu: 	cpu 9 ->gp_seq_needed 507408
[ 2428.157222] rcu: 	cpu 10 ->gp_seq_needed 507408
[ 2428.157927] rcu: 	cpu 11 ->gp_seq_needed 507408
[ 2428.158651] rcu: 	cpu 12 ->gp_seq_needed 507408
[ 2428.159336] rcu: 	cpu 13 ->gp_seq_needed 507408
[ 2428.160039] rcu: 	cpu 14 ->gp_seq_needed 507404
[ 2428.160754] rcu: 	cpu 15 ->gp_seq_needed 507408
[ 2428.161484] rcu: 	cpu 16 ->gp_seq_needed 507408
[ 2428.162153] rcu: nocb GP 0 KldtS .[W.] .G:507408/169040 rnp 0:8 71363 S CPU 13
[ 2428.163275] rcu:    CB 0^0->2 KblSW F69 L69 C0 .W194(507408/169040)... q194 S CPU 1
[ 2428.164448] rcu:    CB 2^0->-1 KblSW F188 L188 C0 .W2(507408/169040)... q2 S CPU 10
[ 2428.165637] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2428.166629] rcu:    CB 4^4->7 KblSW F1852996 L1853005 C119 ..... q0 S CPU 2
[ 2428.167622] rcu:    CB 5^4->4 KblSW F1818146 L1818146 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2428.168925] rcu:    CB 7^4->-1 KblSW F1834465 L1834471 C16 ..... q0 S CPU 13
[ 2428.170014] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2428.170936] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2428.171902] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2428.172874] rcu: RCU callbacks invoked since boot: 5261820
[ 2428.173698] rcu_tasks: RTGS_WAIT_CBS(11) since 2427600 g:0 i:0 k.u.. l:250 
[ 2443.500372] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5087896 ni: 90541 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2443.504451] rcu-torture: Reader Pipe:  5413530978 122018 0 0 0 0 0 0 0 0 0
[ 2443.505478] rcu-torture: Reader Batch:  5412840972 812024 0 0 0 0 0 0 0 0 0
[ 2443.506446] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2443.507868] ??? Writer stall state RTWS_EXP_SYNC(4) g511589 f0x0 ->state D cpu 1
[ 2443.508989] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 7 ->gp_activity 7 ->gp_req_activity 7 ->gp_wake_time 7 ->gp_wake_seq 511585 ->gp_seq 511589 ->gp_seq_needed 511588 ->gp_max 453 ->gp_flags 0x0
[ 2443.512294] rcu: 	rcu_node 0:16 ->gp_seq 511589 ->gp_seq_needed 511588 ->qsmask 0x3 .... ->n_boosts 0
[ 2443.513657] rcu: 	rcu_node 0:8 ->gp_seq 511589 ->gp_seq_needed 511596 ->qsmask 0x100 .... ->n_boosts 0
[ 2443.515031] rcu: 	cpu 1 ->gp_seq_needed 511592
[ 2443.515717] rcu: 	cpu 2 ->gp_seq_needed 511596
[ 2443.516367] rcu: 	cpu 8 ->gp_seq_needed 511596
[ 2443.517045] rcu: 	rcu_node 9:16 ->gp_seq 511589 ->gp_seq_needed 511596 ->qsmask 0x2 .... ->n_boosts 0
[ 2443.518463] rcu: 	cpu 9 ->gp_seq_needed 511596
[ 2443.519107] rcu: 	cpu 10 ->gp_seq_needed 511596
[ 2443.519829] rcu: 	cpu 11 ->gp_seq_needed 511596
[ 2443.520530] rcu: 	cpu 12 ->gp_seq_needed 511596
[ 2443.521233] rcu: 	cpu 13 ->gp_seq_needed 511592
[ 2443.521930] rcu: 	cpu 14 ->gp_seq_needed 511596
[ 2443.522627] rcu: 	cpu 15 ->gp_seq_needed 511596
[ 2443.523327] rcu: 	cpu 16 ->gp_seq_needed 511596
[ 2443.524057] rcu: nocb GP 0 KldtS .[W.] .G:511592/169040 rnp 0:8 71905 S CPU 13
[ 2443.525161] rcu:    CB 0^0->2 KblSW F47 L47 C0 ..... q0 S CPU 1
[ 2443.526113] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W6(511592/169040).N11. q17 S CPU 10
[ 2443.527313] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2443.528284] rcu:    CB 4^4->7 KblSW F1868357 L1868366 C119 ..... q0 S CPU 2
[ 2443.529361] rcu:    CB 5^4->4 KblSW F1833507 L1833507 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2443.530800] rcu:    CB 7^4->-1 KblSW F1849827 L1849833 C16 ..... q0 S CPU 13
[ 2443.531869] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2443.532798] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2443.533788] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2443.534771] rcu: RCU callbacks invoked since boot: 5304133
[ 2443.535609] rcu_tasks: RTGS_WAIT_CBS(11) since 2442962 g:0 i:0 k.u.. l:250 
[ 2458.857840] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5114246 ni: 91010 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2458.861490] rcu-torture: Reader Pipe:  5441255163 122018 0 0 0 0 0 0 0 0 0
[ 2458.862461] rcu-torture: Reader Batch:  5440561842 815339 0 0 0 0 0 0 0 0 0
[ 2458.863408] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2458.864753] ??? Writer stall state RTWS_EXP_SYNC(4) g513737 f0x0 ->state D cpu 1
[ 2458.865752] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 297 ->gp_activity 1 ->gp_req_activity 297 ->gp_wake_time 297 ->gp_wake_seq 513733 ->gp_seq 513737 ->gp_seq_needed 513736 ->gp_max 453 ->gp_flags 0x0
[ 2458.868713] rcu: 	rcu_node 0:16 ->gp_seq 513737 ->gp_seq_needed 513736 ->qsmask 0x2 .... ->n_boosts 0
[ 2458.869941] rcu: 	rcu_node 0:8 ->gp_seq 513737 ->gp_seq_needed 513744 ->qsmask 0x0 .... ->n_boosts 0
[ 2458.871157] rcu: 	cpu 0 ->gp_seq_needed 513744
[ 2458.871752] rcu: 	cpu 1 ->gp_seq_needed 513740
[ 2458.872346] rcu: 	cpu 2 ->gp_seq_needed 513744
[ 2458.872940] rcu: 	cpu 8 ->gp_seq_needed 513744
[ 2458.873544] rcu: 	rcu_node 9:16 ->gp_seq 513737 ->gp_seq_needed 513744 ->qsmask 0x1 .... ->n_boosts 0
[ 2458.874771] rcu: 	cpu 9 ->gp_seq_needed 513744
[ 2458.875384] rcu: 	cpu 10 ->gp_seq_needed 513744
[ 2458.875993] rcu: 	cpu 11 ->gp_seq_needed 513744
[ 2458.876614] rcu: 	cpu 12 ->gp_seq_needed 513744
[ 2458.877222] rcu: 	cpu 13 ->gp_seq_needed 513744
[ 2458.877830] rcu: 	cpu 14 ->gp_seq_needed 513748
[ 2458.878445] rcu: 	cpu 15 ->gp_seq_needed 513748
[ 2458.879046] rcu: 	cpu 16 ->gp_seq_needed 513744
[ 2458.879659] rcu: nocb GP 0 Kldts .[W.] .G:513744/169040 rnp 0:8 72185 S CPU 13
[ 2458.880634] rcu:    CB 0^0->2 KblSW F204 L204 C0 ...N1. q1 S CPU 1
[ 2458.881469] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W5(513744/169040).N131. q136 S CPU 10
[ 2458.882504] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2458.883377] rcu:    CB 4^4->7 KblSW F1883712 L1883721 C119 ..... q0 S CPU 2
[ 2458.884315] rcu:    CB 5^4->4 KblSW F1848862 L1848862 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2458.885558] rcu:    CB 7^4->-1 KblSW F1865182 L1865188 C16 ..... q0 S CPU 13
[ 2458.886501] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2458.887320] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2458.888165] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2458.889000] rcu: RCU callbacks invoked since boot: 5330228
[ 2458.889749] rcu_tasks: RTGS_WAIT_CBS(11) since 2458316 g:0 i:0 k.u.. l:250 
[ 2474.217555] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5146891 ni: 91594 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2474.220480] rcu-torture: Reader Pipe:  5475505826 122018 0 0 0 0 0 0 0 0 0
[ 2474.221310] rcu-torture: Reader Batch:  5474807596 820248 0 0 0 0 0 0 0 0 0
[ 2474.222063] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2474.223135] ??? Writer stall state RTWS_EXP_SYNC(4) g516896 f0x0 ->state D cpu 1
[ 2474.223915] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 2463 ->gp_activity 2458 ->gp_req_activity 2463 ->gp_wake_time 2478 ->gp_wake_seq 516889 ->gp_seq 516896 ->gp_seq_needed 516896 ->gp_max 453 ->gp_flags 0x0
[ 2474.226323] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 72595 S CPU 13
[ 2474.227023] rcu:    CB 0^0->2 KblSW F3304 L3304 C0 ..... q0 S CPU 1
[ 2474.227690] rcu:    CB 2^0->-1 KblSW F2643 L2643 C0 ..... q0 S CPU 12
[ 2474.228376] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2474.229074] rcu:    CB 4^4->7 KblSW F1899058 L1899067 C119 ..... q0 S CPU 2
[ 2474.229811] rcu:    CB 5^4->4 KblSW F1864208 L1864208 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2474.230796] rcu:    CB 7^4->-1 KblSW F1880527 L1880533 C16 ..... q0 S CPU 13
[ 2474.231547] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2474.232194] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2474.232879] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2474.233550] rcu: RCU callbacks invoked since boot: 5364213
[ 2474.234140] rcu_tasks: RTGS_WAIT_CBS(11) since 2473660 g:0 i:0 k.u.. l:250 
[ 2489.577472] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5180866 ni: 92198 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2489.581541] rcu-torture: Reader Pipe:  5512187895 122018 0 0 0 0 0 0 0 0 0
[ 2489.582640] rcu-torture: Reader Batch:  5511484379 825534 0 0 0 0 0 0 0 0 0
[ 2489.583746] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2489.585349] ??? Writer stall state RTWS_EXP_SYNC(4) g520253 f0x0 ->state D cpu 1
[ 2489.586460] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 10 ->gp_activity 5 ->gp_req_activity 10 ->gp_wake_time 11 ->gp_wake_seq 520249 ->gp_seq 520253 ->gp_seq_needed 520252 ->gp_max 453 ->gp_flags 0x0
[ 2489.589907] rcu: 	rcu_node 0:16 ->gp_seq 520253 ->gp_seq_needed 520252 ->qsmask 0x2 .... ->n_boosts 0
[ 2489.591442] rcu: 	rcu_node 0:8 ->gp_seq 520253 ->gp_seq_needed 520260 ->qsmask 0x0 .... ->n_boosts 0
[ 2489.592763] rcu: 	cpu 0 ->gp_seq_needed 520260
[ 2489.593463] rcu: 	cpu 2 ->gp_seq_needed 520260
[ 2489.594262] rcu: 	rcu_node 9:16 ->gp_seq 520253 ->gp_seq_needed 520260 ->qsmask 0x8 .... ->n_boosts 0
[ 2489.595754] rcu: 	cpu 9 ->gp_seq_needed 520260
[ 2489.596522] rcu: 	cpu 10 ->gp_seq_needed 520260
[ 2489.597253] rcu: 	cpu 11 ->gp_seq_needed 520260
[ 2489.597997] rcu: 	cpu 12 ->gp_seq_needed 520260
[ 2489.598696] rcu: 	cpu 13 ->gp_seq_needed 520260
[ 2489.599466] rcu: 	cpu 14 ->gp_seq_needed 520260
[ 2489.600199] rcu: 	cpu 15 ->gp_seq_needed 520260
[ 2489.600918] rcu: 	cpu 16 ->gp_seq_needed 520260
[ 2489.601607] rcu: nocb GP 0 KldtS .[.W] .G:520260/169040 rnp 0:8 73031 S CPU 15
[ 2489.602751] rcu:    CB 0^0->2 KblSW F372 L372 C0 ..... q0 S CPU 1
[ 2489.603562] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W8(520260/169040).N9. q17 S CPU 0
[ 2489.604378] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2489.605118] rcu:    CB 4^4->7 KblSW F1914434 L1914443 C119 ..... q0 S CPU 2
[ 2489.605891] rcu:    CB 5^4->4 KblSW F1879584 L1879584 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2489.606956] rcu:    CB 7^4->-1 KblSW F1895903 L1895909 C16 ..... q0 S CPU 13
[ 2489.607763] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2489.608446] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2489.609146] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2489.609854] rcu: RCU callbacks invoked since boot: 5398736
[ 2489.610459] rcu_tasks: RTGS_WAIT_CBS(11) since 2489037 g:0 i:0 k.u.. l:250 
[ 2504.937470] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5208589 ni: 92687 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2504.942046] rcu-torture: Reader Pipe:  5541751664 122018 0 0 0 0 0 0 0 0 0
[ 2504.943185] rcu-torture: Reader Batch:  5541043333 830349 0 0 0 0 0 0 0 0 0
[ 2504.944329] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2504.945930] ??? Writer stall state RTWS_EXP_SYNC(4) g523341 f0x0 ->state D cpu 1
[ 2504.947027] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 203 ->gp_activity 2 ->gp_req_activity 203 ->gp_wake_time 203 ->gp_wake_seq 523337 ->gp_seq 523341 ->gp_seq_needed 523340 ->gp_max 453 ->gp_flags 0x0
[ 2504.950682] rcu: 	rcu_node 0:16 ->gp_seq 523341 ->gp_seq_needed 523340 ->qsmask 0x2 .... ->n_boosts 0
[ 2504.952160] rcu: 	rcu_node 0:8 ->gp_seq 523341 ->gp_seq_needed 523348 ->qsmask 0x0 .... ->n_boosts 0
[ 2504.953665] rcu: 	cpu 0 ->gp_seq_needed 523348
[ 2504.954318] rcu: 	cpu 1 ->gp_seq_needed 523344
[ 2504.955035] rcu: 	cpu 2 ->gp_seq_needed 523348
[ 2504.955897] rcu: 	cpu 8 ->gp_seq_needed 523348
[ 2504.956851] rcu: 	rcu_node 9:16 ->gp_seq 523341 ->gp_seq_needed 523348 ->qsmask 0x0 ...G ->n_boosts 0
[ 2504.958501] rcu: 	cpu 9 ->gp_seq_needed 523348
[ 2504.959192] rcu: 	cpu 10 ->gp_seq_needed 523348
[ 2504.960004] rcu: 	cpu 11 ->gp_seq_needed 523348
[ 2504.960975] rcu: 	cpu 12 ->gp_seq_needed 523348
[ 2504.962008] rcu: 	cpu 13 ->gp_seq_needed 523348
[ 2504.962886] rcu: 	cpu 14 ->gp_seq_needed 523348
[ 2504.963637] rcu: 	cpu 15 ->gp_seq_needed 523344
[ 2504.964314] rcu: 	cpu 16 ->gp_seq_needed 523348
[ 2504.965062] rcu: nocb GP 0 KldtS .[.W] .G:523348/169040 rnp 0:8 73432 S CPU 15
[ 2504.966217] rcu:    CB 0^0->2 KblSW F407 L407 C0 .W1(523348/169040)... q1 S CPU 1
[ 2504.967332] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W114(523348/169040).N92. q206 S CPU 0
[ 2504.968534] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2504.969388] rcu:    CB 4^4->7 KblSW F1929798 L1929807 C119 ..... q0 S CPU 2
[ 2504.970452] rcu:    CB 5^4->4 KblSW F1894949 L1894949 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2504.971804] rcu:    CB 7^4->-1 KblSW F1911268 L1911274 C16 ..... q0 S CPU 13
[ 2504.972863] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2504.973781] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2504.974712] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2504.975657] rcu: RCU callbacks invoked since boot: 5425853
[ 2504.976474] rcu_tasks: RTGS_WAIT_CBS(11) since 2504403 g:0 i:0 k.u.. l:250 
[ 2520.297485] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5247225 ni: 93376 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2520.303176] rcu-torture: Reader Pipe:  5583026778 122018 0 0 0 0 0 0 0 0 0
[ 2520.306510] rcu-torture: Reader Batch:  5582313516 835280 0 0 0 0 0 0 0 0 0
[ 2520.307570] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2520.309112] ??? Writer stall state RTWS_EXP_SYNC(4) g526501 f0x2 ->state D cpu 1
[ 2520.310224] rcu: rcu_preempt: wait state: RCU_GP_CLEANUP(7) ->state: I ->rt_priority 0 delta ->gp_start 306 ->gp_activity 3 ->gp_req_activity 306 ->gp_wake_time 3 ->gp_wake_seq 526501 ->gp_seq 526501 ->gp_seq_needed 526508 ->gp_max 453 ->gp_flags 0x2
[ 2520.313921] rcu: 	rcu_node 0:16 ->gp_seq 526504 ->gp_seq_needed 526508 ->qsmask 0x0 .... ->n_boosts 0
[ 2520.315359] rcu: 	rcu_node 0:8 ->gp_seq 526504 ->gp_seq_needed 526508 ->qsmask 0x0 .... ->n_boosts 0
[ 2520.316735] rcu: 	cpu 0 ->gp_seq_needed 526508
[ 2520.317400] rcu: 	cpu 1 ->gp_seq_needed 526508
[ 2520.318099] rcu: 	cpu 2 ->gp_seq_needed 526508
[ 2520.318783] rcu: 	cpu 8 ->gp_seq_needed 526508
[ 2520.319733] rcu: 	rcu_node 9:16 ->gp_seq 526505 ->gp_seq_needed 526512 ->qsmask 0x7f .... ->n_boosts 0
[ 2520.321190] rcu: 	cpu 9 ->gp_seq_needed 526512
[ 2520.321889] rcu: 	cpu 10 ->gp_seq_needed 526512
[ 2520.322560] rcu: 	cpu 11 ->gp_seq_needed 526512
[ 2520.323265] rcu: 	cpu 12 ->gp_seq_needed 526512
[ 2520.323946] rcu: 	cpu 13 ->gp_seq_needed 526512
[ 2520.324619] rcu: 	cpu 14 ->gp_seq_needed 526512
[ 2520.325304] rcu: 	cpu 15 ->gp_seq_needed 526508
[ 2520.326013] rcu: 	cpu 16 ->gp_seq_needed 526512
[ 2520.326694] rcu: nocb GP 0 KldtS .[.W] .G:526508/169040 rnp 0:8 73842 S CPU 15
[ 2520.327826] rcu:    CB 0^0->2 KblSW F638 L638 C0 ..... q0 S CPU 0
[ 2520.328741] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W122(526508/169040).N9. q131 S CPU 0
[ 2520.330113] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2520.331160] rcu:    CB 4^4->7 KblSW F1945160 L1945169 C119 ..... q0 S CPU 2
[ 2520.332272] rcu:    CB 5^4->4 KblSW F1910310 L1910310 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2520.333679] rcu:    CB 7^4->-1 KblSW F1926630 L1926636 C16 ..... q0 S CPU 13
[ 2520.334751] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2520.335664] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2520.336603] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2520.337714] rcu: RCU callbacks invoked since boot: 5465694
[ 2520.338596] rcu_tasks: RTGS_WAIT_CBS(11) since 2519765 g:0 i:0 k.u.. l:250 
[ 2535.657476] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5273798 ni: 93855 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2535.667517] rcu-torture: Reader Pipe:  5611081611 122018 0 0 0 0 0 0 0 0 0
[ 2535.668608] rcu-torture: Reader Batch:  5610364521 839108 0 0 0 0 0 0 0 0 0
[ 2535.669659] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2535.671332] ??? Writer stall state RTWS_EXP_SYNC(4) g528977 f0x0 ->state D cpu 1
[ 2535.672417] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 17 ->gp_activity 1 ->gp_req_activity 17 ->gp_wake_time 17 ->gp_wake_seq 528973 ->gp_seq 528977 ->gp_seq_needed 528976 ->gp_max 453 ->gp_flags 0x0
[ 2535.675670] rcu: 	rcu_node 0:16 ->gp_seq 528977 ->gp_seq_needed 528976 ->qsmask 0x2 .... ->n_boosts 0
[ 2535.677059] rcu: 	rcu_node 0:8 ->gp_seq 528977 ->gp_seq_needed 528984 ->qsmask 0x0 .... ->n_boosts 0
[ 2535.678413] rcu: 	cpu 1 ->gp_seq_needed 528980
[ 2535.679102] rcu: 	cpu 2 ->gp_seq_needed 528980
[ 2535.679779] rcu: 	cpu 8 ->gp_seq_needed 528984
[ 2535.680484] rcu: 	rcu_node 9:16 ->gp_seq 528977 ->gp_seq_needed 528984 ->qsmask 0x8 .... ->n_boosts 0
[ 2535.681881] rcu: 	cpu 9 ->gp_seq_needed 528984
[ 2535.682531] rcu: 	cpu 10 ->gp_seq_needed 528984
[ 2535.683190] rcu: 	cpu 11 ->gp_seq_needed 528984
[ 2535.683759] rcu: 	cpu 12 ->gp_seq_needed 528984
[ 2535.684379] rcu: 	cpu 13 ->gp_seq_needed 528980
[ 2535.685047] rcu: 	cpu 14 ->gp_seq_needed 528984
[ 2535.685732] rcu: 	cpu 15 ->gp_seq_needed 528984
[ 2535.686403] rcu: 	cpu 16 ->gp_seq_needed 528980
[ 2535.687146] rcu: nocb GP 0 KldtS .[.W] .G:528980/169040 rnp 0:8 74163 S CPU 13
[ 2535.688233] rcu:    CB 0^0->2 KblSW F199 L199 C0 ..... q0 S CPU 0
[ 2535.689138] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W7(528980/169040).N17. q24 S CPU 12
[ 2535.690291] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2535.691225] rcu:    CB 4^4->7 KblSW F1960520 L1960529 C119 ..... q0 S CPU 2
[ 2535.692259] rcu:    CB 5^4->4 KblSW F1925670 L1925670 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2535.693640] rcu:    CB 7^4->-1 KblSW F1941990 L1941996 C16 ..... q0 S CPU 13
[ 2535.694641] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2535.695470] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2535.696363] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2535.697292] rcu: RCU callbacks invoked since boot: 5493329
[ 2535.698110] rcu_tasks: RTGS_WAIT_CBS(11) since 2535124 g:0 i:0 k.u.. l:250 
[ 2551.017499] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5309093 ni: 94489 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2551.020486] rcu-torture: Reader Pipe:  5649053702 122018 0 0 0 0 0 0 0 0 0
[ 2551.021237] rcu-torture: Reader Batch:  5648331740 843980 0 0 0 0 0 0 0 0 0
[ 2551.021998] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2551.023085] ??? Writer stall state RTWS_EXP_SYNC(4) g532156 f0x0 ->state D cpu 1
[ 2551.023884] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 1433 ->gp_activity 1429 ->gp_req_activity 1433 ->gp_wake_time 1443 ->gp_wake_seq 532141 ->gp_seq 532156 ->gp_seq_needed 532156 ->gp_max 453 ->gp_flags 0x0
[ 2551.026317] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 74576 S CPU 13
[ 2551.027051] rcu:    CB 0^0->2 KblSW F1710 L1710 C0 ..... q0 S CPU 0
[ 2551.027729] rcu:    CB 2^0->-1 KblSW F1447 L1447 C0 ..... q0 S CPU 12
[ 2551.028422] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2551.029143] rcu:    CB 4^4->7 KblSW F1975858 L1975867 C119 ..... q0 S CPU 2
[ 2551.029897] rcu:    CB 5^4->4 KblSW F1941008 L1941008 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2551.030895] rcu:    CB 7^4->-1 KblSW F1957327 L1957333 C16 ..... q0 S CPU 13
[ 2551.031651] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2551.032309] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2551.032987] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2551.033659] rcu: RCU callbacks invoked since boot: 5529310
[ 2551.034252] rcu_tasks: RTGS_WAIT_CBS(11) since 2550460 g:0 i:0 k.u.. l:250 
[ 2566.377455] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5338576 ni: 95025 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2566.383633] rcu-torture: Reader Pipe:  5680563178 122018 0 0 0 0 0 0 0 0 0
[ 2566.384810] rcu-torture: Reader Batch:  5679837471 847725 0 0 0 0 0 0 0 0 0
[ 2566.387508] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2566.388868] ??? Writer stall state RTWS_EXP_SYNC(4) g534569 f0x0 ->state D cpu 1
[ 2566.389864] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 109 ->gp_activity 0 ->gp_req_activity 109 ->gp_wake_time 133 ->gp_wake_seq 534553 ->gp_seq 534569 ->gp_seq_needed 534568 ->gp_max 453 ->gp_flags 0x0
[ 2566.392813] rcu: 	rcu_node 0:16 ->gp_seq 534569 ->gp_seq_needed 534568 ->qsmask 0x1 .... ->n_boosts 0
[ 2566.394068] rcu: 	rcu_node 0:8 ->gp_seq 534569 ->gp_seq_needed 534576 ->qsmask 0x0 ...G ->n_boosts 0
[ 2566.395269] rcu: 	cpu 0 ->gp_seq_needed 534572
[ 2566.395869] rcu: 	cpu 1 ->gp_seq_needed 534576
[ 2566.396467] rcu: 	cpu 2 ->gp_seq_needed 534576
[ 2566.397057] rcu: 	cpu 8 ->gp_seq_needed 534576
[ 2566.397646] rcu: 	rcu_node 9:16 ->gp_seq 534569 ->gp_seq_needed 534576 ->qsmask 0x0 .... ->n_boosts 0
[ 2566.398870] rcu: 	cpu 9 ->gp_seq_needed 534576
[ 2566.399462] rcu: 	cpu 10 ->gp_seq_needed 534576
[ 2566.400069] rcu: 	cpu 11 ->gp_seq_needed 534576
[ 2566.400672] rcu: 	cpu 12 ->gp_seq_needed 534576
[ 2566.401272] rcu: 	cpu 13 ->gp_seq_needed 534572
[ 2566.401908] rcu: 	cpu 14 ->gp_seq_needed 534576
[ 2566.402510] rcu: 	cpu 15 ->gp_seq_needed 534572
[ 2566.403114] rcu: nocb GP 0 Kldts .[.W] .G:534572/169040 rnp 0:8 74890 S CPU 13
[ 2566.404070] rcu:    CB 0^0->2 KblSW F92 L92 C0 ...N1. q1 S CPU 0
[ 2566.404875] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W6(534572/169040).N54. q60 S CPU 12
[ 2566.405874] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2566.406741] rcu:    CB 4^4->7 KblSW F1991236 L1991245 C119 ..... q0 S CPU 2
[ 2566.407658] rcu:    CB 5^4->4 KblSW F1956386 L1956386 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2566.408891] rcu:    CB 7^4->-1 KblSW F1972705 L1972711 C16 ..... q0 S CPU 13
[ 2566.409826] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2566.410632] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2566.411465] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2566.412289] rcu: RCU callbacks invoked since boot: 5559045
[ 2566.413017] rcu_tasks: RTGS_WAIT_CBS(11) since 2565839 g:0 i:0 k.u.. l:250 
[ 2581.737457] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5364405 ni: 95496 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2581.742920] rcu-torture: Reader Pipe:  5708517540 122018 0 0 0 0 0 0 0 0 0
[ 2581.744005] rcu-torture: Reader Batch:  5707788167 851391 0 0 0 0 0 0 0 0 0
[ 2581.745054] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2581.746598] ??? Writer stall state RTWS_EXP_SYNC(4) g536993 f0x0 ->state D cpu 1
[ 2581.747767] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 5 ->gp_activity 1 ->gp_req_activity 5 ->gp_wake_time 5 ->gp_wake_seq 536989 ->gp_seq 536993 ->gp_seq_needed 536992 ->gp_max 453 ->gp_flags 0x0
[ 2581.750924] rcu: 	rcu_node 0:16 ->gp_seq 536993 ->gp_seq_needed 536992 ->qsmask 0x3 .... ->n_boosts 0
[ 2581.752355] rcu: 	rcu_node 0:8 ->gp_seq 536993 ->gp_seq_needed 537000 ->qsmask 0x0 .... ->n_boosts 0
[ 2581.753740] rcu: 	cpu 0 ->gp_seq_needed 537000
[ 2581.754399] rcu: 	cpu 1 ->gp_seq_needed 537000
[ 2581.755064] rcu: 	cpu 2 ->gp_seq_needed 537000
[ 2581.755712] rcu: 	cpu 8 ->gp_seq_needed 537000
[ 2581.756398] rcu: 	rcu_node 9:16 ->gp_seq 536993 ->gp_seq_needed 537000 ->qsmask 0x8 .... ->n_boosts 0
[ 2581.757767] rcu: 	cpu 9 ->gp_seq_needed 537000
[ 2581.758424] rcu: 	cpu 10 ->gp_seq_needed 537000
[ 2581.759140] rcu: 	cpu 11 ->gp_seq_needed 537000
[ 2581.759719] rcu: 	cpu 12 ->gp_seq_needed 537000
[ 2581.760328] rcu: 	cpu 13 ->gp_seq_needed 537000
[ 2581.761041] rcu: 	cpu 14 ->gp_seq_needed 537000
[ 2581.761753] rcu: 	cpu 15 ->gp_seq_needed 536996
[ 2581.762460] rcu: 	cpu 16 ->gp_seq_needed 536996
[ 2581.763170] rcu: nocb GP 0 KldtS .[W.] .G:537000/169040 rnp 0:8 75206 S CPU 13
[ 2581.764278] rcu:    CB 0^0->2 KblSW F44 L44 C0 .W2(537000/169040)... q2 S CPU 0
[ 2581.765339] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W81(537000/169040).N10. q91 S CPU 12
[ 2581.766464] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2581.767481] rcu:    CB 4^4->7 KblSW F2006597 L2006606 C119 ..... q0 S CPU 2
[ 2581.768561] rcu:    CB 5^4->4 KblSW F1971747 L1971747 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2581.769957] rcu:    CB 7^4->-1 KblSW F1988066 L1988072 C16 ..... q0 S CPU 13
[ 2581.770851] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2581.771795] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2581.772765] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2581.773710] rcu: RCU callbacks invoked since boot: 5585149
[ 2581.774559] rcu_tasks: RTGS_WAIT_CBS(11) since 2581201 g:0 i:0 k.u.. l:250 
[ 2597.097604] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5404337 ni: 96209 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2597.101718] rcu-torture: Reader Pipe:  5751085951 122018 0 0 0 0 0 0 0 0 0
[ 2597.102717] rcu-torture: Reader Batch:  5750350476 857493 0 0 0 0 0 0 0 0 0
[ 2597.103782] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2597.105303] ??? Writer stall state RTWS_EXP_SYNC(4) g540977 f0x0 ->state D cpu 1
[ 2597.106233] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 3 ->gp_activity 3 ->gp_req_activity 3 ->gp_wake_time 16 ->gp_wake_seq 540973 ->gp_seq 540977 ->gp_seq_needed 540980 ->gp_max 453 ->gp_flags 0x0
[ 2597.109446] rcu: 	rcu_node 0:16 ->gp_seq 540977 ->gp_seq_needed 540980 ->qsmask 0x2 .... ->n_boosts 0
[ 2597.110812] rcu: 	rcu_node 0:8 ->gp_seq 540977 ->gp_seq_needed 540984 ->qsmask 0x0 .... ->n_boosts 0
[ 2597.112190] rcu: 	cpu 1 ->gp_seq_needed 540984
[ 2597.112893] rcu: 	cpu 2 ->gp_seq_needed 540984
[ 2597.113566] rcu: 	cpu 8 ->gp_seq_needed 540984
[ 2597.114257] rcu: 	rcu_node 9:16 ->gp_seq 540977 ->gp_seq_needed 540984 ->qsmask 0x8 .... ->n_boosts 0
[ 2597.115691] rcu: 	cpu 9 ->gp_seq_needed 540984
[ 2597.116355] rcu: 	cpu 10 ->gp_seq_needed 540984
[ 2597.117032] rcu: 	cpu 11 ->gp_seq_needed 540984
[ 2597.117721] rcu: 	cpu 12 ->gp_seq_needed 540980
[ 2597.118405] rcu: 	cpu 13 ->gp_seq_needed 540980
[ 2597.119115] rcu: 	cpu 14 ->gp_seq_needed 540984
[ 2597.119787] rcu: 	cpu 15 ->gp_seq_needed 540980
[ 2597.120511] rcu: nocb GP 0 KldtS .[.W] .G:540980/169040 rnp 0:8 75722 S CPU 13
[ 2597.121631] rcu:    CB 0^0->2 KblSW F107 L107 C0 ..... q0 S CPU 0
[ 2597.122557] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W19(540980/169040).N10. q29 S CPU 12
[ 2597.123757] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2597.124760] rcu:    CB 4^4->7 KblSW F2021954 L2021963 C119 ..... q0 S CPU 2
[ 2597.125808] rcu:    CB 5^4->4 KblSW F1987104 L1987104 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2597.127173] rcu:    CB 7^4->-1 KblSW F2003423 L2003429 C16 ..... q0 S CPU 13
[ 2597.128226] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2597.129188] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2597.130157] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2597.131125] rcu: RCU callbacks invoked since boot: 5626152
[ 2597.131968] rcu_tasks: RTGS_WAIT_CBS(11) since 2596558 g:0 i:0 k.u.. l:250 
[ 2612.457482] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5431295 ni: 96691 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2612.467477] rcu-torture: Reader Pipe:  5780201257 122018 0 0 0 0 0 0 0 0 0
[ 2612.468537] rcu-torture: Reader Batch:  5779461454 861821 0 0 0 0 0 0 0 0 0
[ 2612.469492] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2612.471134] ??? Writer stall state RTWS_EXP_SYNC(4) g543757 f0x0 ->state D cpu 1
[ 2612.472281] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 287 ->gp_activity 4 ->gp_req_activity 287 ->gp_wake_time 287 ->gp_wake_seq 543753 ->gp_seq 543757 ->gp_seq_needed 543756 ->gp_max 453 ->gp_flags 0x0
[ 2612.475731] rcu: 	rcu_node 0:16 ->gp_seq 543757 ->gp_seq_needed 543756 ->qsmask 0x3 .... ->n_boosts 0
[ 2612.477054] rcu: 	rcu_node 0:8 ->gp_seq 543757 ->gp_seq_needed 543764 ->qsmask 0x0 ...G ->n_boosts 0
[ 2612.478354] rcu: 	cpu 0 ->gp_seq_needed 543764
[ 2612.479006] rcu: 	cpu 1 ->gp_seq_needed 543764
[ 2612.479612] rcu: 	cpu 2 ->gp_seq_needed 543760
[ 2612.480168] rcu: 	cpu 8 ->gp_seq_needed 543764
[ 2612.481438] rcu: 	rcu_node 9:16 ->gp_seq 543757 ->gp_seq_needed 543764 ->qsmask 0x40 .... ->n_boosts 0
[ 2612.483541] rcu: 	cpu 9 ->gp_seq_needed 543764
[ 2612.484231] rcu: 	cpu 10 ->gp_seq_needed 543764
[ 2612.484917] rcu: 	cpu 11 ->gp_seq_needed 543764
[ 2612.485686] rcu: 	cpu 12 ->gp_seq_needed 543760
[ 2612.486353] rcu: 	cpu 13 ->gp_seq_needed 543764
[ 2612.487066] rcu: 	cpu 14 ->gp_seq_needed 543764
[ 2612.487752] rcu: 	cpu 15 ->gp_seq_needed 543764
[ 2612.488436] rcu: 	cpu 16 ->gp_seq_needed 543764
[ 2612.489115] rcu: nocb GP 0 Kldts .[W.] .G:543768/169040 rnp 0:8 76084 S CPU 16
[ 2612.490240] rcu:    CB 0^0->2 KblSW F2 L2 C0 ...N1. q1 S CPU 0
[ 2612.490965] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W4(543768/169040).N1. q5 S CPU 0
[ 2612.492112] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2612.493112] rcu:    CB 4^4->7 KblSW F2037322 L2037331 C119 ..... q0 S CPU 2
[ 2612.494173] rcu:    CB 5^4->4 KblSW F2002472 L2002472 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2612.495615] rcu:    CB 7^4->-1 KblSW F2018792 L2018798 C16 ..... q0 S CPU 13
[ 2612.496711] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2612.497665] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2612.498624] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2612.499543] rcu: RCU callbacks invoked since boot: 5653161
[ 2612.500391] rcu_tasks: RTGS_WAIT_CBS(11) since 2611926 g:0 i:0 k.u.. l:250 
[ 2627.817507] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5472117 ni: 97408 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2627.820474] rcu-torture: Reader Pipe:  5823743602 122018 0 0 0 0 0 0 0 0 0
[ 2627.821217] rcu-torture: Reader Batch:  5822995982 869638 0 0 0 0 0 0 0 0 0
[ 2627.821975] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2627.823059] ??? Writer stall state RTWS_EXP_SYNC(4) g548836 f0x0 ->state D cpu 1
[ 2627.823862] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 237 ->gp_activity 233 ->gp_req_activity 237 ->gp_wake_time 245 ->gp_wake_seq 548821 ->gp_seq 548836 ->gp_seq_needed 548836 ->gp_max 453 ->gp_flags 0x0
[ 2627.826249] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 76742 S CPU 16
[ 2627.826960] rcu:    CB 0^0->2 KblSW F492 L492 C0 ..... q0 S CPU 0
[ 2627.827621] rcu:    CB 2^0->-1 KblSW F248 L248 C0 ..... q0 S CPU 12
[ 2627.828289] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2627.828990] rcu:    CB 4^4->7 KblSW F2052658 L2052667 C119 ..... q0 S CPU 2
[ 2627.829743] rcu:    CB 5^4->4 KblSW F2017808 L2017808 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2627.830738] rcu:    CB 7^4->-1 KblSW F2034127 L2034133 C16 ..... q0 S CPU 13
[ 2627.831499] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2627.832149] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2627.832825] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2627.833503] rcu: RCU callbacks invoked since boot: 5695253
[ 2627.834089] rcu_tasks: RTGS_WAIT_CBS(11) since 2627260 g:0 i:0 k.u.. l:250 
[ 2643.177494] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5500029 ni: 97902 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2643.184675] rcu-torture: Reader Pipe:  5853929164 122018 0 0 0 0 0 0 0 0 0
[ 2643.185677] rcu-torture: Reader Batch:  5853177019 874163 0 0 0 0 0 0 0 0 0
[ 2643.189255] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2643.193190] ??? Writer stall state RTWS_EXP_SYNC(4) g551729 f0x0 ->state D cpu 1
[ 2643.194207] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 16 ->gp_activity 2 ->gp_req_activity 16 ->gp_wake_time 16 ->gp_wake_seq 551725 ->gp_seq 551729 ->gp_seq_needed 551728 ->gp_max 453 ->gp_flags 0x0
[ 2643.197545] rcu: 	rcu_node 0:16 ->gp_seq 551729 ->gp_seq_needed 551728 ->qsmask 0x2 .... ->n_boosts 0
[ 2643.198986] rcu: 	rcu_node 0:8 ->gp_seq 551729 ->gp_seq_needed 551736 ->qsmask 0x0 .... ->n_boosts 0
[ 2643.200401] rcu: 	cpu 0 ->gp_seq_needed 551736
[ 2643.201094] rcu: 	cpu 1 ->gp_seq_needed 551736
[ 2643.201794] rcu: 	cpu 2 ->gp_seq_needed 551736
[ 2643.202485] rcu: 	cpu 8 ->gp_seq_needed 551736
[ 2643.203186] rcu: 	rcu_node 9:16 ->gp_seq 551729 ->gp_seq_needed 551736 ->qsmask 0x8 .... ->n_boosts 0
[ 2643.204565] rcu: 	cpu 9 ->gp_seq_needed 551736
[ 2643.205136] rcu: 	cpu 10 ->gp_seq_needed 551736
[ 2643.205815] rcu: 	cpu 11 ->gp_seq_needed 551736
[ 2643.206520] rcu: 	cpu 12 ->gp_seq_needed 551736
[ 2643.207185] rcu: 	cpu 13 ->gp_seq_needed 551732
[ 2643.208042] rcu: 	cpu 14 ->gp_seq_needed 551736
[ 2643.208762] rcu: 	cpu 15 ->gp_seq_needed 551736
[ 2643.209471] rcu: 	cpu 16 ->gp_seq_needed 551736
[ 2643.210144] rcu: nocb GP 0 Kldts .[W.] .G:551736/169040 rnp 0:8 77118 S CPU 16
[ 2643.211405] rcu:    CB 0^0->2 KblSW F23 L23 C0 ...N1. q1 S CPU 0
[ 2643.212308] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W6(551736/169040).N13. q19 S CPU 0
[ 2643.213408] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2643.214504] rcu:    CB 4^4->7 KblSW F2068044 L2068053 C119 ..... q0 S CPU 2
[ 2643.215537] rcu:    CB 5^4->4 KblSW F2033194 L2033194 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2643.216953] rcu:    CB 7^4->-1 KblSW F2049513 L2049519 C16 ..... q0 S CPU 13
[ 2643.218045] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2643.219008] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2643.220023] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2643.221175] rcu: RCU callbacks invoked since boot: 5723642
[ 2643.222004] rcu_tasks: RTGS_WAIT_CBS(11) since 2642648 g:0 i:0 k.u.. l:250 
[ 2658.537533] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5526901 ni: 98378 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2658.540791] rcu-torture: Reader Pipe:  5882469631 122018 0 0 0 0 0 0 0 0 0
[ 2658.541536] rcu-torture: Reader Batch:  5881713877 877772 0 0 0 0 0 0 0 0 0
[ 2658.542272] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2658.543414] ??? Writer stall state RTWS_EXP_SYNC(4) g554048 f0x0 ->state D cpu 1
[ 2658.544192] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 4944 ->gp_activity 4940 ->gp_req_activity 4944 ->gp_wake_time 4976 ->gp_wake_seq 554037 ->gp_seq 554048 ->gp_seq_needed 554048 ->gp_max 453 ->gp_flags 0x0
[ 2658.546730] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 77421 S CPU 16
[ 2658.547427] rcu:    CB 0^0->2 KblSW F5186 L5186 C0 ..... q0 S CPU 0
[ 2658.548097] rcu:    CB 2^0->-1 KblSW F4969 L4969 C0 ..... q0 S CPU 12
[ 2658.548852] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2658.549578] rcu:    CB 4^4->7 KblSW F2083379 L2083388 C119 ..... q0 S CPU 2
[ 2658.550311] rcu:    CB 5^4->4 KblSW F2048528 L2048528 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2658.551314] rcu:    CB 7^4->-1 KblSW F2064847 L2064853 C16 ..... q0 S CPU 13
[ 2658.552073] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2658.552791] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2658.553477] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2658.554134] rcu: RCU callbacks invoked since boot: 5751007
[ 2658.554743] rcu_tasks: RTGS_WAIT_CBS(11) since 2657981 g:0 i:0 k.u.. l:250 
[ 2673.899354] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5566151 ni: 99078 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2673.905122] rcu-torture: Reader Pipe:  5924247921 122018 0 0 0 0 0 0 0 0 0
[ 2673.906159] rcu-torture: Reader Batch:  5923486962 882977 0 0 0 0 0 0 0 0 0
[ 2673.910172] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2673.911740] ??? Writer stall state RTWS_EXP_SYNC(4) g557381 f0x0 ->state D cpu 1
[ 2673.915071] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 15 ->gp_activity 1 ->gp_req_activity 15 ->gp_wake_time 15 ->gp_wake_seq 557377 ->gp_seq 557381 ->gp_seq_needed 557380 ->gp_max 453 ->gp_flags 0x0
[ 2673.920210] rcu: 	rcu_node 0:16 ->gp_seq 557381 ->gp_seq_needed 557380 ->qsmask 0x2 .... ->n_boosts 0
[ 2673.923951] rcu: 	rcu_node 0:8 ->gp_seq 557381 ->gp_seq_needed 557388 ->qsmask 0x0 .... ->n_boosts 0
[ 2673.925934] rcu: 	cpu 0 ->gp_seq_needed 557388
[ 2673.926597] rcu: 	cpu 1 ->gp_seq_needed 557388
[ 2673.927260] rcu: 	cpu 2 ->gp_seq_needed 557384
[ 2673.930476] rcu: 	cpu 8 ->gp_seq_needed 557384
[ 2673.931134] rcu: 	rcu_node 9:16 ->gp_seq 557381 ->gp_seq_needed 557388 ->qsmask 0x8 .... ->n_boosts 0
[ 2673.932490] rcu: 	cpu 9 ->gp_seq_needed 557388
[ 2673.933174] rcu: 	cpu 10 ->gp_seq_needed 557388
[ 2673.933824] rcu: 	cpu 12 ->gp_seq_needed 557388
[ 2673.934511] rcu: 	cpu 13 ->gp_seq_needed 557384
[ 2673.935169] rcu: 	cpu 14 ->gp_seq_needed 557388
[ 2673.935874] rcu: 	cpu 15 ->gp_seq_needed 557388
[ 2673.936552] rcu: 	cpu 16 ->gp_seq_needed 557384
[ 2673.937214] rcu: nocb GP 0 KldtS .[W.] .G:557384/169040 rnp 0:8 77853 S CPU 16
[ 2673.938232] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W7(557384/169040).N17. q24 S CPU 8
[ 2673.939393] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W7(557384/169040).N17. q24 S CPU 13
[ 2673.940558] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2673.941552] rcu:    CB 4^4->7 KblSW F2098771 L2098780 C119 ..... q0 S CPU 2
[ 2673.942609] rcu:    CB 5^4->4 KblSW F2063921 L2063921 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2673.944019] rcu:    CB 7^4->-1 KblSW F2080240 L2080246 C16 ..... q0 S CPU 13
[ 2673.945103] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2673.946041] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2673.947020] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2673.947951] rcu: RCU callbacks invoked since boot: 5790913
[ 2673.948793] rcu_tasks: RTGS_WAIT_CBS(11) since 2673375 g:0 i:0 k.u.. l:250 
[ 2689.257504] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5593168 ni: 99560 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2689.261771] rcu-torture: Reader Pipe:  5953740273 122018 0 0 0 0 0 0 0 0 0
[ 2689.262861] rcu-torture: Reader Batch:  5952975013 887278 0 0 0 0 0 0 0 0 0
[ 2689.263814] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2689.265306] ??? Writer stall state RTWS_EXP_SYNC(4) g560189 f0x0 ->state D cpu 1
[ 2689.266497] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 146 ->gp_activity 5 ->gp_req_activity 146 ->gp_wake_time 146 ->gp_wake_seq 560185 ->gp_seq 560189 ->gp_seq_needed 560188 ->gp_max 453 ->gp_flags 0x0
[ 2689.269785] rcu: 	rcu_node 0:16 ->gp_seq 560189 ->gp_seq_needed 560188 ->qsmask 0x2 .... ->n_boosts 0
[ 2689.271185] rcu: 	rcu_node 0:8 ->gp_seq 560189 ->gp_seq_needed 560196 ->qsmask 0x0 .... ->n_boosts 0
[ 2689.272540] rcu: 	cpu 0 ->gp_seq_needed 560196
[ 2689.273176] rcu: 	cpu 1 ->gp_seq_needed 560196
[ 2689.273853] rcu: 	cpu 2 ->gp_seq_needed 560196
[ 2689.274521] rcu: 	cpu 8 ->gp_seq_needed 560196
[ 2689.275106] rcu: 	rcu_node 9:16 ->gp_seq 560189 ->gp_seq_needed 560196 ->qsmask 0x40 .... ->n_boosts 0
[ 2689.276542] rcu: 	cpu 9 ->gp_seq_needed 560196
[ 2689.277135] rcu: 	cpu 10 ->gp_seq_needed 560196
[ 2689.277830] rcu: 	cpu 11 ->gp_seq_needed 560196
[ 2689.278547] rcu: 	cpu 12 ->gp_seq_needed 560196
[ 2689.279224] rcu: 	cpu 13 ->gp_seq_needed 560192
[ 2689.279825] rcu: 	cpu 14 ->gp_seq_needed 560196
[ 2689.280344] rcu: 	cpu 15 ->gp_seq_needed 560196
[ 2689.280869] rcu: 	cpu 16 ->gp_seq_needed 560196
[ 2689.281368] rcu: nocb GP 0 KldtS .[W.] .G:560192/169040 rnp 0:8 78218 S CPU 16
[ 2689.282253] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W10(560192/169040).N73. q83 S CPU 8
[ 2689.283114] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W9(560192/169040).N68. q77 S CPU 13
[ 2689.283995] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2689.284865] rcu:    CB 4^4->7 KblSW F2114114 L2114123 C119 ..... q0 S CPU 2
[ 2689.285665] rcu:    CB 5^4->4 KblSW F2079264 L2079264 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2689.286693] rcu:    CB 7^4->-1 KblSW F2095583 L2095589 C16 ..... q0 S CPU 13
[ 2689.287606] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2689.288501] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2689.289491] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2689.290548] rcu: RCU callbacks invoked since boot: 5818042
[ 2689.291345] rcu_tasks: RTGS_WAIT_CBS(11) since 2688717 g:0 i:0 k.u.. l:250 
[ 2704.617487] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5633505 ni: 100269 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2704.626356] rcu-torture: Reader Pipe:  5996504110 122018 0 0 0 0 0 0 0 0 0
[ 2704.628694] rcu-torture: Reader Batch:  5995732245 893883 0 0 0 0 0 0 0 0 0
[ 2704.630653] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2704.634897] ??? Writer stall state RTWS_EXP_SYNC(4) g564445 f0x0 ->state D cpu 1
[ 2704.635822] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 32 ->gp_activity 4 ->gp_req_activity 32 ->gp_wake_time 53 ->gp_wake_seq 564433 ->gp_seq 564445 ->gp_seq_needed 564444 ->gp_max 453 ->gp_flags 0x0
[ 2704.640417] rcu: 	rcu_node 0:16 ->gp_seq 564445 ->gp_seq_needed 564444 ->qsmask 0x2 .... ->n_boosts 0
[ 2704.644616] rcu: 	rcu_node 0:8 ->gp_seq 564445 ->gp_seq_needed 564452 ->qsmask 0x0 .... ->n_boosts 0
[ 2704.645873] rcu: 	cpu 0 ->gp_seq_needed 564448
[ 2704.647465] rcu: 	cpu 1 ->gp_seq_needed 564452
[ 2704.648153] rcu: 	cpu 2 ->gp_seq_needed 564448
[ 2704.649426] rcu: 	cpu 8 ->gp_seq_needed 564448
[ 2704.650077] rcu: 	rcu_node 9:16 ->gp_seq 564445 ->gp_seq_needed 564452 ->qsmask 0x1 .... ->n_boosts 0
[ 2704.651437] rcu: 	cpu 9 ->gp_seq_needed 564452
[ 2704.652076] rcu: 	cpu 10 ->gp_seq_needed 564452
[ 2704.652734] rcu: 	cpu 11 ->gp_seq_needed 564448
[ 2704.653351] rcu: 	cpu 12 ->gp_seq_needed 564452
[ 2704.653967] rcu: 	cpu 13 ->gp_seq_needed 564448
[ 2704.654588] rcu: 	cpu 14 ->gp_seq_needed 564452
[ 2704.655205] rcu: 	cpu 15 ->gp_seq_needed 564452
[ 2704.655900] rcu: 	cpu 16 ->gp_seq_needed 564452
[ 2704.656581] rcu: nocb GP 0 KldtS .[W.] .G:564448/169040 rnp 0:8 78770 S CPU 16
[ 2704.657703] rcu:    CB 0^0->2 KblSW F3 L3 C0 .W41(564448/169040).N22. q63 S CPU 8
[ 2704.658829] rcu:    CB 2^0->-1 KblSW F26 L26 C0 .W39(564448/169040).N16. q55 S CPU 13
[ 2704.660026] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2704.661009] rcu:    CB 4^4->7 KblSW F2129490 L2129499 C119 ..... q0 S CPU 2
[ 2704.662034] rcu:    CB 5^4->4 KblSW F2094640 L2094640 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2704.663437] rcu:    CB 7^4->-1 KblSW F2110960 L2110966 C16 ..... q0 S CPU 13
[ 2704.664512] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2704.665453] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2704.666410] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2704.667367] rcu: RCU callbacks invoked since boot: 5859346
[ 2704.668224] rcu_tasks: RTGS_WAIT_CBS(11) since 2704094 g:0 i:0 k.u.. l:250 
[ 2719.977470] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5659465 ni: 100736 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2719.985576] rcu-torture: Reader Pipe:  6024040327 122018 0 0 0 0 0 0 0 0 0
[ 2719.986623] rcu-torture: Reader Batch:  6023265218 897127 0 0 0 0 0 0 0 0 0
[ 2719.987699] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2719.989219] ??? Writer stall state RTWS_EXP_SYNC(4) g566505 f0x0 ->state D cpu 1
[ 2719.990330] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 199 ->gp_activity 2 ->gp_req_activity 199 ->gp_wake_time 199 ->gp_wake_seq 566501 ->gp_seq 566505 ->gp_seq_needed 566504 ->gp_max 453 ->gp_flags 0x0
[ 2719.993689] rcu: 	rcu_node 0:16 ->gp_seq 566505 ->gp_seq_needed 566504 ->qsmask 0x1 .... ->n_boosts 0
[ 2719.995150] rcu: 	rcu_node 0:8 ->gp_seq 566505 ->gp_seq_needed 566512 ->qsmask 0x0 ...G ->n_boosts 0
[ 2719.996558] rcu: 	cpu 0 ->gp_seq_needed 566508
[ 2719.997243] rcu: 	cpu 1 ->gp_seq_needed 566512
[ 2719.997940] rcu: 	cpu 2 ->gp_seq_needed 566508
[ 2719.998623] rcu: 	cpu 8 ->gp_seq_needed 566512
[ 2719.999299] rcu: 	rcu_node 9:16 ->gp_seq 566505 ->gp_seq_needed 566512 ->qsmask 0x0 .... ->n_boosts 0
[ 2720.000731] rcu: 	cpu 9 ->gp_seq_needed 566512
[ 2720.001414] rcu: 	cpu 10 ->gp_seq_needed 566508
[ 2720.002112] rcu: 	cpu 11 ->gp_seq_needed 566512
[ 2720.002834] rcu: 	cpu 12 ->gp_seq_needed 566512
[ 2720.003542] rcu: 	cpu 13 ->gp_seq_needed 566512
[ 2720.004239] rcu: 	cpu 14 ->gp_seq_needed 566512
[ 2720.004990] rcu: 	cpu 15 ->gp_seq_needed 566512
[ 2720.005701] rcu: 	cpu 16 ->gp_seq_needed 566508
[ 2720.006402] rcu: nocb GP 0 KldtS .[.W] .G:566508/169040 rnp 0:8 79038 S CPU 8
[ 2720.007536] rcu:    CB 0^0->2 KblSW F217 L217 C0 .W8(566508/169040).N4. q12 S CPU 10
[ 2720.008754] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W6(566508/169040).N100. q106 S CPU 12
[ 2720.010427] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2720.011489] rcu:    CB 4^4->7 KblSW F2144841 L2144850 C119 ..... q0 S CPU 2
[ 2720.012615] rcu:    CB 5^4->4 KblSW F2109991 L2109991 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2720.014003] rcu:    CB 7^4->-1 KblSW F2126310 L2126316 C16 ..... q0 S CPU 13
[ 2720.015094] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2720.016008] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2720.016991] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2720.017893] rcu: RCU callbacks invoked since boot: 5885419
[ 2720.018708] rcu_tasks: RTGS_WAIT_CBS(11) since 2719445 g:0 i:0 k.u.. l:250 
[ 2735.337504] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5690241 ni: 101274 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2735.340493] rcu-torture: Reader Pipe:  6056821976 122018 0 0 0 0 0 0 0 0 0
[ 2735.341255] rcu-torture: Reader Batch:  6056042134 901860 0 0 0 0 0 0 0 0 0
[ 2735.342024] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2735.343149] ??? Writer stall state RTWS_EXP_SYNC(4) g569532 f0x0 ->state D cpu 1
[ 2735.343955] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 3559 ->gp_activity 3555 ->gp_req_activity 3559 ->gp_wake_time 3564 ->gp_wake_seq 569521 ->gp_seq 569532 ->gp_seq_needed 569532 ->gp_max 453 ->gp_flags 0x0
[ 2735.346514] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 79431 S CPU 8
[ 2735.347228] rcu:    CB 0^0->2 KblSW F3568 L3568 C1 ..... q0 S CPU 10
[ 2735.347923] rcu:    CB 2^0->-1 KblSW F3773 L3773 C0 ..... q0 S CPU 12
[ 2735.348625] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2735.349341] rcu:    CB 4^4->7 KblSW F2160178 L2160187 C119 ..... q0 S CPU 2
[ 2735.350107] rcu:    CB 5^4->4 KblSW F2125328 L2125328 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2735.351121] rcu:    CB 7^4->-1 KblSW F2141647 L2141653 C16 ..... q0 S CPU 13
[ 2735.351876] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2735.352540] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2735.353215] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2735.353884] rcu: RCU callbacks invoked since boot: 5917243
[ 2735.354484] rcu_tasks: RTGS_WAIT_CBS(11) since 2734781 g:0 i:0 k.u.. l:250 
[ 2750.697496] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5726087 ni: 101910 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2750.701718] rcu-torture: Reader Pipe:  6094899272 122018 0 0 0 0 0 0 0 0 0
[ 2750.702787] rcu-torture: Reader Batch:  6094114782 906508 0 0 0 0 0 0 0 0 0
[ 2750.703852] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2750.705437] ??? Writer stall state RTWS_EXP_SYNC(4) g572497 f0x0 ->state D cpu 1
[ 2750.706375] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 171 ->gp_activity 1 ->gp_req_activity 171 ->gp_wake_time 172 ->gp_wake_seq 572493 ->gp_seq 572497 ->gp_seq_needed 572496 ->gp_max 453 ->gp_flags 0x0
[ 2750.709654] rcu: 	rcu_node 0:16 ->gp_seq 572497 ->gp_seq_needed 572496 ->qsmask 0x1 .... ->n_boosts 0
[ 2750.711035] rcu: 	rcu_node 0:8 ->gp_seq 572497 ->gp_seq_needed 572504 ->qsmask 0x1 .... ->n_boosts 0
[ 2750.712435] rcu: 	cpu 0 ->gp_seq_needed 572504
[ 2750.713147] rcu: 	cpu 1 ->gp_seq_needed 572504
[ 2750.713833] rcu: 	cpu 2 ->gp_seq_needed 572504
[ 2750.714540] rcu: 	cpu 8 ->gp_seq_needed 572504
[ 2750.715226] rcu: 	rcu_node 9:16 ->gp_seq 572497 ->gp_seq_needed 572504 ->qsmask 0x0 .... ->n_boosts 0
[ 2750.716609] rcu: 	cpu 9 ->gp_seq_needed 572504
[ 2750.717223] rcu: 	cpu 10 ->gp_seq_needed 572504
[ 2750.717869] rcu: 	cpu 12 ->gp_seq_needed 572504
[ 2750.718564] rcu: 	cpu 13 ->gp_seq_needed 572504
[ 2750.719223] rcu: 	cpu 14 ->gp_seq_needed 572504
[ 2750.719921] rcu: 	cpu 15 ->gp_seq_needed 572504
[ 2750.720601] rcu: 	cpu 16 ->gp_seq_needed 572500
[ 2750.721253] rcu: nocb GP 0 KldtS .[W.] .G:572504/169040 rnp 0:8 79816 S CPU 10
[ 2750.722352] rcu:    CB 0^0->2 KblSW F191 L191 C0 .W7(572504/169040)... q7 S CPU 8
[ 2750.723565] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W8(572504/169040).N72. q80 S CPU 12
[ 2750.724734] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2750.725745] rcu:    CB 4^4->7 KblSW F2175555 L2175564 C119 ..... q0 S CPU 2
[ 2750.726818] rcu:    CB 5^4->4 KblSW F2140705 L2140705 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2750.728090] rcu:    CB 7^4->-1 KblSW F2157024 L2157030 C16 ..... q0 S CPU 13
[ 2750.729205] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2750.730129] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2750.731062] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2750.732009] rcu: RCU callbacks invoked since boot: 5953343
[ 2750.732826] rcu_tasks: RTGS_WAIT_CBS(11) since 2750159 g:0 i:0 k.u.. l:250 
[ 2766.058505] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5752935 ni: 102382 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2766.062894] rcu-torture: Reader Pipe:  6123601387 122018 0 0 0 0 0 0 0 0 0
[ 2766.063948] rcu-torture: Reader Batch:  6122812774 910631 0 0 0 0 0 0 0 0 0
[ 2766.065043] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2766.066491] ??? Writer stall state RTWS_EXP_SYNC(4) g575153 f0x0 ->state D cpu 1
[ 2766.067685] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 14 ->gp_activity 1 ->gp_req_activity 14 ->gp_wake_time 14 ->gp_wake_seq 575149 ->gp_seq 575153 ->gp_seq_needed 575152 ->gp_max 453 ->gp_flags 0x0
[ 2766.070982] rcu: 	rcu_node 0:16 ->gp_seq 575153 ->gp_seq_needed 575152 ->qsmask 0x2 .... ->n_boosts 0
[ 2766.072300] rcu: 	rcu_node 0:8 ->gp_seq 575153 ->gp_seq_needed 575160 ->qsmask 0x0 .... ->n_boosts 0
[ 2766.073679] rcu: 	cpu 0 ->gp_seq_needed 575156
[ 2766.074371] rcu: 	cpu 1 ->gp_seq_needed 575160
[ 2766.075035] rcu: 	cpu 2 ->gp_seq_needed 575156
[ 2766.075667] rcu: 	cpu 8 ->gp_seq_needed 575156
[ 2766.076277] rcu: 	rcu_node 9:16 ->gp_seq 575153 ->gp_seq_needed 575160 ->qsmask 0x8 .... ->n_boosts 0
[ 2766.077631] rcu: 	cpu 9 ->gp_seq_needed 575160
[ 2766.078178] rcu: 	cpu 10 ->gp_seq_needed 575156
[ 2766.079096] rcu: 	cpu 12 ->gp_seq_needed 575160
[ 2766.079807] rcu: 	cpu 13 ->gp_seq_needed 575160
[ 2766.080488] rcu: 	cpu 14 ->gp_seq_needed 575160
[ 2766.081168] rcu: 	cpu 15 ->gp_seq_needed 575160
[ 2766.081822] rcu: 	cpu 16 ->gp_seq_needed 575156
[ 2766.082453] rcu: nocb GP 0 KldtS .[.W] .G:575156/169040 rnp 0:8 80161 S CPU 10
[ 2766.083726] rcu:    CB 0^0->2 KblSW F0 L0 C0 .W5(575156/169040).N15. q20 S CPU 8
[ 2766.084799] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W4(575156/169040).N17. q21 S CPU 12
[ 2766.085941] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2766.086894] rcu:    CB 4^4->7 KblSW F2190916 L2190925 C119 ..... q0 S CPU 2
[ 2766.087947] rcu:    CB 5^4->4 KblSW F2156066 L2156066 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2766.089184] rcu:    CB 7^4->-1 KblSW F2172385 L2172391 C16 ..... q0 S CPU 13
[ 2766.090488] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2766.091321] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2766.092208] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2766.093101] rcu: RCU callbacks invoked since boot: 5980990
[ 2766.093926] rcu_tasks: RTGS_WAIT_CBS(11) since 2765520 g:0 i:0 k.u.. l:250 
[ 2781.417841] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5794086 ni: 103101 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2781.421927] rcu-torture: Reader Pipe:  6166446215 122018 0 0 0 0 0 0 0 0 0
[ 2781.422991] rcu-torture: Reader Batch:  6165651073 917160 0 0 0 0 0 0 0 0 0
[ 2781.424036] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2781.425540] ??? Writer stall state RTWS_EXP_SYNC(4) g579329 f0x0 ->state D cpu 1
[ 2781.426668] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 9 ->gp_activity 5 ->gp_req_activity 9 ->gp_wake_time 9 ->gp_wake_seq 579325 ->gp_seq 579329 ->gp_seq_needed 579328 ->gp_max 453 ->gp_flags 0x0
[ 2781.429835] rcu: 	rcu_node 0:16 ->gp_seq 579329 ->gp_seq_needed 579328 ->qsmask 0x2 .... ->n_boosts 0
[ 2781.431153] rcu: 	rcu_node 0:8 ->gp_seq 579329 ->gp_seq_needed 579336 ->qsmask 0x0 .... ->n_boosts 0
[ 2781.432524] rcu: 	cpu 0 ->gp_seq_needed 579336
[ 2781.433202] rcu: 	cpu 1 ->gp_seq_needed 579336
[ 2781.433881] rcu: 	cpu 2 ->gp_seq_needed 579336
[ 2781.434537] rcu: 	cpu 8 ->gp_seq_needed 579336
[ 2781.435217] rcu: 	rcu_node 9:16 ->gp_seq 579329 ->gp_seq_needed 579336 ->qsmask 0x2 .... ->n_boosts 0
[ 2781.436573] rcu: 	cpu 9 ->gp_seq_needed 579336
[ 2781.437252] rcu: 	cpu 10 ->gp_seq_needed 579336
[ 2781.437909] rcu: 	cpu 11 ->gp_seq_needed 579336
[ 2781.438609] rcu: 	cpu 12 ->gp_seq_needed 579336
[ 2781.439300] rcu: 	cpu 13 ->gp_seq_needed 579332
[ 2781.440001] rcu: 	cpu 14 ->gp_seq_needed 579336
[ 2781.440661] rcu: 	cpu 15 ->gp_seq_needed 579336
[ 2781.441293] rcu: 	cpu 16 ->gp_seq_needed 579336
[ 2781.441995] rcu: nocb GP 0 KldtS .[W.] .G:579336/169040 rnp 0:8 80703 S CPU 8
[ 2781.443020] rcu:    CB 0^0->2 KblSW F0 L0 C0 .W7(579336/169040).N11. q18 S CPU 11
[ 2781.444127] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W6(579336/169040).N8. q14 S CPU 14
[ 2781.445231] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2781.446196] rcu:    CB 4^4->7 KblSW F2206275 L2206284 C119 ..... q0 S CPU 2
[ 2781.447235] rcu:    CB 5^4->4 KblSW F2171425 L2171425 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2781.448575] rcu:    CB 7^4->-1 KblSW F2187745 L2187751 C16 ..... q0 S CPU 13
[ 2781.449531] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2781.450288] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2781.451217] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2781.452097] rcu: RCU callbacks invoked since boot: 6022881
[ 2781.452899] rcu_tasks: RTGS_WAIT_CBS(11) since 2780879 g:0 i:0 k.u.. l:250 
[ 2796.778581] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5821636 ni: 103589 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2796.785335] rcu-torture: Reader Pipe:  6195851719 122018 0 0 0 0 0 0 0 0 0
[ 2796.786375] rcu-torture: Reader Batch:  6195051978 921759 0 0 0 0 0 0 0 0 0
[ 2796.787439] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2796.788939] ??? Writer stall state RTWS_EXP_SYNC(4) g582309 f0x0 ->state D cpu 1
[ 2796.790207] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 11 ->gp_activity 1 ->gp_req_activity 11 ->gp_wake_time 11 ->gp_wake_seq 582305 ->gp_seq 582309 ->gp_seq_needed 582308 ->gp_max 453 ->gp_flags 0x0
[ 2796.793437] rcu: 	rcu_node 0:16 ->gp_seq 582309 ->gp_seq_needed 582308 ->qsmask 0x2 .... ->n_boosts 0
[ 2796.794699] rcu: 	rcu_node 0:8 ->gp_seq 582309 ->gp_seq_needed 582316 ->qsmask 0x0 .... ->n_boosts 0
[ 2796.796121] rcu: 	cpu 0 ->gp_seq_needed 582316
[ 2796.796807] rcu: 	cpu 1 ->gp_seq_needed 582316
[ 2796.797493] rcu: 	cpu 2 ->gp_seq_needed 582316
[ 2796.798189] rcu: 	cpu 8 ->gp_seq_needed 582316
[ 2796.798890] rcu: 	rcu_node 9:16 ->gp_seq 582309 ->gp_seq_needed 582316 ->qsmask 0x2 .... ->n_boosts 0
[ 2796.800306] rcu: 	cpu 9 ->gp_seq_needed 582316
[ 2796.800980] rcu: 	cpu 10 ->gp_seq_needed 582312
[ 2796.801663] rcu: 	cpu 11 ->gp_seq_needed 582316
[ 2796.802373] rcu: 	cpu 12 ->gp_seq_needed 582316
[ 2796.803035] rcu: 	cpu 13 ->gp_seq_needed 582312
[ 2796.803732] rcu: 	cpu 14 ->gp_seq_needed 582316
[ 2796.804448] rcu: 	cpu 15 ->gp_seq_needed 582316
[ 2796.805155] rcu: 	cpu 16 ->gp_seq_needed 582316
[ 2796.805710] rcu: nocb GP 0 KldtS .[.W] .G:582316/169040 rnp 0:8 81090 S CPU 8
[ 2796.806825] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W4(582316/169040).N12. q16 S CPU 11
[ 2796.807973] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W5(582316/169040).N13. q18 S CPU 14
[ 2796.809122] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2796.810129] rcu:    CB 4^4->7 KblSW F2221639 L2221648 C119 ..... q0 S CPU 2
[ 2796.811163] rcu:    CB 5^4->4 KblSW F2186789 L2186789 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2796.812530] rcu:    CB 7^4->-1 KblSW F2203109 L2203115 C16 ..... q0 S CPU 13
[ 2796.813594] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2796.814524] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2796.815467] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2796.816388] rcu: RCU callbacks invoked since boot: 6050922
[ 2796.817104] rcu_tasks: RTGS_WAIT_CBS(11) since 2796243 g:0 i:0 k.u.. l:250 
[ 2812.137484] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5854976 ni: 104180 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2812.140441] rcu-torture: Reader Pipe:  6231196502 122018 0 0 0 0 0 0 0 0 0
[ 2812.141200] rcu-torture: Reader Batch:  6230391746 926774 0 0 0 0 0 0 0 0 0
[ 2812.141961] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2812.143043] ??? Writer stall state RTWS_EXP_SYNC(4) g585564 f0x0 ->state D cpu 1
[ 2812.143837] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 2368 ->gp_activity 2364 ->gp_req_activity 2368 ->gp_wake_time 2372 ->gp_wake_seq 585553 ->gp_seq 585564 ->gp_seq_needed 585564 ->gp_max 453 ->gp_flags 0x0
[ 2812.146257] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 81512 S CPU 8
[ 2812.146953] rcu:    CB 0^0->2 KblSW F2575 L2575 C0 ..... q0 S CPU 11
[ 2812.147631] rcu:    CB 2^0->-1 KblSW F2575 L2575 C0 ..... q0 S CPU 14
[ 2812.148321] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2812.149023] rcu:    CB 4^4->7 KblSW F2236978 L2236987 C119 ..... q0 S CPU 2
[ 2812.149764] rcu:    CB 5^4->4 KblSW F2202128 L2202128 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2812.150758] rcu:    CB 7^4->-1 KblSW F2218447 L2218453 C16 ..... q0 S CPU 13
[ 2812.151516] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2812.152169] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2812.152843] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2812.153511] rcu: RCU callbacks invoked since boot: 6084884
[ 2812.154104] rcu_tasks: RTGS_WAIT_CBS(11) since 2811580 g:0 i:0 k.u.. l:250 
[ 2827.498114] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5889537 ni: 104793 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2827.504927] rcu-torture: Reader Pipe:  6268342724 122018 0 0 0 0 0 0 0 0 0
[ 2827.505865] rcu-torture: Reader Batch:  6267531834 932908 0 0 0 0 0 0 0 0 0
[ 2827.508061] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2827.509410] ??? Writer stall state RTWS_EXP_SYNC(4) g589465 f0x0 ->state D cpu 1
[ 2827.510400] rcu: rcu_preempt: wait state: RCU_GP_CLEANUP(7) ->state: I ->rt_priority 0 delta ->gp_start 41 ->gp_activity 3 ->gp_req_activity 41 ->gp_wake_time 48 ->gp_wake_seq 589457 ->gp_seq 589465 ->gp_seq_needed 589472 ->gp_max 453 ->gp_flags 0x0
[ 2827.515438] rcu: 	rcu_node 0:16 ->gp_seq 589469 ->gp_seq_needed 589472 ->qsmask 0x2 .... ->n_boosts 0
[ 2827.519822] rcu: 	rcu_node 0:8 ->gp_seq 589469 ->gp_seq_needed 589476 ->qsmask 0x0 .... ->n_boosts 0
[ 2827.523114] rcu: 	cpu 1 ->gp_seq_needed 589476
[ 2827.524578] rcu: 	cpu 2 ->gp_seq_needed 589472
[ 2827.525181] rcu: 	cpu 8 ->gp_seq_needed 589476
[ 2827.526857] rcu: 	rcu_node 9:16 ->gp_seq 589469 ->gp_seq_needed 589476 ->qsmask 0x20 .... ->n_boosts 0
[ 2827.531233] rcu: 	cpu 9 ->gp_seq_needed 589476
[ 2827.533094] rcu: 	cpu 10 ->gp_seq_needed 589476
[ 2827.534837] rcu: 	cpu 11 ->gp_seq_needed 589476
[ 2827.535532] rcu: 	cpu 12 ->gp_seq_needed 589476
[ 2827.536230] rcu: 	cpu 13 ->gp_seq_needed 589472
[ 2827.539816] rcu: 	cpu 14 ->gp_seq_needed 589476
[ 2827.540543] rcu: 	cpu 16 ->gp_seq_needed 589476
[ 2827.541254] rcu: nocb GP 0 KldtS .[W.] .G:589472/169040 rnp 0:8 82019 S CPU 8
[ 2827.542387] rcu:    CB 0^0->2 KblSW F717 L717 C0 ..... q0 S CPU 13
[ 2827.543332] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W14(589472/169040).N18. q32 S CPU 13
[ 2827.544535] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2827.545567] rcu:    CB 4^4->7 KblSW F2252375 L2252384 C119 ..... q0 S CPU 2
[ 2827.546673] rcu:    CB 5^4->4 KblSW F2217525 L2217525 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2827.548127] rcu:    CB 7^4->-1 KblSW F2233844 L2233850 C16 ..... q0 S CPU 13
[ 2827.549240] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2827.550202] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2827.551190] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2827.552182] rcu: RCU callbacks invoked since boot: 6119967
[ 2827.553052] rcu_tasks: RTGS_WAIT_CBS(11) since 2826979 g:0 i:0 k.u.. l:250 
[ 2842.857728] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5916766 ni: 105282 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2842.865804] rcu-torture: Reader Pipe:  6297525990 122018 0 0 0 0 0 0 0 0 0
[ 2842.867383] rcu-torture: Reader Batch:  6296710449 937559 0 0 0 0 0 0 0 0 0
[ 2842.868519] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2842.870032] ??? Writer stall state RTWS_EXP_SYNC(4) g592493 f0x0 ->state D cpu 1
[ 2842.871304] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 9 ->gp_activity 1 ->gp_req_activity 9 ->gp_wake_time 49 ->gp_wake_seq 592485 ->gp_seq 592493 ->gp_seq_needed 592496 ->gp_max 453 ->gp_flags 0x0
[ 2842.874744] rcu: 	rcu_node 0:16 ->gp_seq 592493 ->gp_seq_needed 592496 ->qsmask 0x2 .... ->n_boosts 0
[ 2842.876131] rcu: 	rcu_node 0:8 ->gp_seq 592493 ->gp_seq_needed 592500 ->qsmask 0x0 .... ->n_boosts 0
[ 2842.877648] rcu: 	cpu 1 ->gp_seq_needed 592500
[ 2842.878328] rcu: 	cpu 2 ->gp_seq_needed 592496
[ 2842.879048] rcu: 	cpu 8 ->gp_seq_needed 592500
[ 2842.879739] rcu: 	rcu_node 9:16 ->gp_seq 592493 ->gp_seq_needed 592500 ->qsmask 0x20 .... ->n_boosts 0
[ 2842.881128] rcu: 	cpu 9 ->gp_seq_needed 592500
[ 2842.881856] rcu: 	cpu 10 ->gp_seq_needed 592500
[ 2842.882617] rcu: 	cpu 11 ->gp_seq_needed 592500
[ 2842.883298] rcu: 	cpu 12 ->gp_seq_needed 592500
[ 2842.884022] rcu: 	cpu 13 ->gp_seq_needed 592496
[ 2842.884715] rcu: 	cpu 14 ->gp_seq_needed 592500
[ 2842.885463] rcu: 	cpu 16 ->gp_seq_needed 592500
[ 2842.886166] rcu: nocb GP 0 KldtS .[W.] .G:592496/169040 rnp 0:8 82411 S CPU 8
[ 2842.887362] rcu:    CB 0^0->2 KblSW F329 L329 C0 ..... q0 S CPU 13
[ 2842.888491] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W18(592496/169040).N17. q35 S CPU 14
[ 2842.889712] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2842.890771] rcu:    CB 4^4->7 KblSW F2267720 L2267729 C119 ..... q0 S CPU 2
[ 2842.891849] rcu:    CB 5^4->4 KblSW F2232870 L2232870 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2842.893262] rcu:    CB 7^4->-1 KblSW F2249189 L2249195 C16 ..... q0 S CPU 13
[ 2842.894324] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2842.895247] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2842.896152] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2842.897096] rcu: RCU callbacks invoked since boot: 6147650
[ 2842.897928] rcu_tasks: RTGS_WAIT_CBS(11) since 2842324 g:0 i:0 k.u.. l:250 
[ 2858.217458] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5955826 ni: 105975 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2858.223134] rcu-torture: Reader Pipe:  6339490608 122018 0 0 0 0 0 0 0 0 0
[ 2858.224211] rcu-torture: Reader Batch:  6338670070 942556 0 0 0 0 0 0 0 0 0
[ 2858.227349] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2858.228898] ??? Writer stall state RTWS_EXP_SYNC(4) g595625 f0x0 ->state D cpu 1
[ 2858.229984] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 224 ->gp_activity 4 ->gp_req_activity 224 ->gp_wake_time 236 ->gp_wake_seq 595621 ->gp_seq 595625 ->gp_seq_needed 595628 ->gp_max 453 ->gp_flags 0x0
[ 2858.233250] rcu: 	rcu_node 0:16 ->gp_seq 595625 ->gp_seq_needed 595628 ->qsmask 0x1 .... ->n_boosts 0
[ 2858.234660] rcu: 	rcu_node 0:8 ->gp_seq 595625 ->gp_seq_needed 595628 ->qsmask 0x2 .... ->n_boosts 0
[ 2858.235973] rcu: 	cpu 0 ->gp_seq_needed 595628
[ 2858.236608] rcu: 	cpu 1 ->gp_seq_needed 595628
[ 2858.237160] rcu: 	cpu 2 ->gp_seq_needed 595628
[ 2858.237854] rcu: 	cpu 8 ->gp_seq_needed 595628
[ 2858.238536] rcu: 	rcu_node 9:16 ->gp_seq 595625 ->gp_seq_needed 595632 ->qsmask 0x0 .... ->n_boosts 0
[ 2858.239885] rcu: 	cpu 9 ->gp_seq_needed 595632
[ 2858.240539] rcu: 	cpu 10 ->gp_seq_needed 595632
[ 2858.241220] rcu: 	cpu 11 ->gp_seq_needed 595632
[ 2858.241886] rcu: 	cpu 12 ->gp_seq_needed 595632
[ 2858.242561] rcu: 	cpu 13 ->gp_seq_needed 595628
[ 2858.243282] rcu: 	cpu 14 ->gp_seq_needed 595632
[ 2858.243982] rcu: 	cpu 16 ->gp_seq_needed 595632
[ 2858.244688] rcu: nocb GP 0 KldtS .[.W] .G:595628/169040 rnp 0:8 82817 S CPU 8
[ 2858.245764] rcu:    CB 0^0->2 KblSW F226 L226 C0 .W2(595628/169040).N1. q3 S CPU 13
[ 2858.246911] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W10(595628/169040).N104. q114 S CPU 14
[ 2858.247924] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2858.248901] rcu:    CB 4^4->7 KblSW F2283078 L2283087 C119 ..... q0 S CPU 2
[ 2858.249917] rcu:    CB 5^4->4 KblSW F2248228 L2248228 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2858.251348] rcu:    CB 7^4->-1 KblSW F2264547 L2264553 C16 ..... q0 S CPU 13
[ 2858.252405] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2858.253343] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2858.254293] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2858.255209] rcu: RCU callbacks invoked since boot: 6186309
[ 2858.256032] rcu_tasks: RTGS_WAIT_CBS(11) since 2857682 g:0 i:0 k.u.. l:250 
[ 2873.578823] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5982493 ni: 106451 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2873.582885] rcu-torture: Reader Pipe:  6367766991 122018 0 0 0 0 0 0 0 0 0
[ 2873.583913] rcu-torture: Reader Batch:  6366942770 946239 0 0 0 0 0 0 0 0 0
[ 2873.585009] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2873.586492] ??? Writer stall state RTWS_EXP_SYNC(4) g598025 f0x0 ->state D cpu 1
[ 2873.587634] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 5 ->gp_activity 1 ->gp_req_activity 5 ->gp_wake_time 5 ->gp_wake_seq 598021 ->gp_seq 598025 ->gp_seq_needed 598024 ->gp_max 453 ->gp_flags 0x0
[ 2873.590829] rcu: 	rcu_node 0:16 ->gp_seq 598025 ->gp_seq_needed 598024 ->qsmask 0x2 .... ->n_boosts 0
[ 2873.592195] rcu: 	rcu_node 0:8 ->gp_seq 598025 ->gp_seq_needed 598032 ->qsmask 0x0 .... ->n_boosts 0
[ 2873.593482] rcu: 	cpu 0 ->gp_seq_needed 598032
[ 2873.594177] rcu: 	cpu 1 ->gp_seq_needed 598032
[ 2873.596064] rcu: 	cpu 2 ->gp_seq_needed 598028
[ 2873.596730] rcu: 	cpu 8 ->gp_seq_needed 598028
[ 2873.597353] rcu: 	rcu_node 9:16 ->gp_seq 598025 ->gp_seq_needed 598032 ->qsmask 0x20 .... ->n_boosts 0
[ 2873.599719] rcu: 	cpu 9 ->gp_seq_needed 598032
[ 2873.600372] rcu: 	cpu 11 ->gp_seq_needed 598032
[ 2873.601115] rcu: 	cpu 12 ->gp_seq_needed 598032
[ 2873.601820] rcu: 	cpu 13 ->gp_seq_needed 598028
[ 2873.602484] rcu: 	cpu 14 ->gp_seq_needed 598028
[ 2873.603174] rcu: 	cpu 16 ->gp_seq_needed 598032
[ 2873.603777] rcu: nocb GP 0 KldtS .[.W] .G:598028/169040 rnp 0:8 83129 S CPU 8
[ 2873.604863] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W4(598028/169040).N11. q15 S CPU 13
[ 2873.606005] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W3(598028/169040).N12. q15 S CPU 14
[ 2873.607135] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2873.608397] rcu:    CB 4^4->7 KblSW F2298437 L2298446 C119 ..... q0 S CPU 2
[ 2873.609507] rcu:    CB 5^4->4 KblSW F2263588 L2263588 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2873.611198] rcu:    CB 7^4->-1 KblSW F2279907 L2279913 C16 ..... q0 S CPU 13
[ 2873.612292] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2873.613544] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2873.614487] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2873.615298] rcu: RCU callbacks invoked since boot: 6214643
[ 2873.617926] rcu_tasks: RTGS_WAIT_CBS(11) since 2873044 g:0 i:0 k.u.. l:250 
[ 2888.937552] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6018246 ni: 107083 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2888.940557] rcu-torture: Reader Pipe:  6405629138 122018 0 0 0 0 0 0 0 0 0
[ 2888.941298] rcu-torture: Reader Batch:  6404800525 950631 0 0 0 0 0 0 0 0 0
[ 2888.942055] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2888.943157] ??? Writer stall state RTWS_EXP_SYNC(4) g600844 f0x0 ->state D cpu 1
[ 2888.943954] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 1368 ->gp_activity 1364 ->gp_req_activity 1368 ->gp_wake_time 1376 ->gp_wake_seq 600829 ->gp_seq 600844 ->gp_seq_needed 600844 ->gp_max 453 ->gp_flags 0x0
[ 2888.946396] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 83495 S CPU 9
[ 2888.947095] rcu:    CB 0^0->2 KblSW F1377 L1377 C0 ..... q0 S CPU 13
[ 2888.947785] rcu:    CB 2^0->-1 KblSW F1378 L1378 C0 ..... q0 S CPU 14
[ 2888.948477] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2888.949182] rcu:    CB 4^4->7 KblSW F2313778 L2313787 C119 ..... q0 S CPU 2
[ 2888.949933] rcu:    CB 5^4->4 KblSW F2278928 L2278928 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2888.950935] rcu:    CB 7^4->-1 KblSW F2295247 L2295253 C16 ..... q0 S CPU 13
[ 2888.951694] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2888.952345] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2888.953019] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2888.953694] rcu: RCU callbacks invoked since boot: 6251057
[ 2888.954281] rcu_tasks: RTGS_WAIT_CBS(11) since 2888380 g:0 i:0 k.u.. l:250 
[ 2904.297473] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6049310 ni: 107631 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2904.301523] rcu-torture: Reader Pipe:  6438669530 122018 0 0 0 0 0 0 0 0 0
[ 2904.302593] rcu-torture: Reader Batch:  6437835824 955724 0 0 0 0 0 0 0 0 0
[ 2904.303647] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2904.305221] ??? Writer stall state RTWS_EXP_SYNC(4) g604105 f0x0 ->state D cpu 1
[ 2904.306396] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 9 ->gp_activity 5 ->gp_req_activity 9 ->gp_wake_time 22 ->gp_wake_seq 604093 ->gp_seq 604105 ->gp_seq_needed 604104 ->gp_max 453 ->gp_flags 0x0
[ 2904.309595] rcu: 	rcu_node 0:16 ->gp_seq 604105 ->gp_seq_needed 604104 ->qsmask 0x2 .... ->n_boosts 0
[ 2904.311005] rcu: 	rcu_node 0:8 ->gp_seq 604105 ->gp_seq_needed 604112 ->qsmask 0x0 .... ->n_boosts 0
[ 2904.312406] rcu: 	cpu 0 ->gp_seq_needed 604112
[ 2904.313129] rcu: 	cpu 1 ->gp_seq_needed 604112
[ 2904.313815] rcu: 	cpu 2 ->gp_seq_needed 604112
[ 2904.314496] rcu: 	rcu_node 9:16 ->gp_seq 604105 ->gp_seq_needed 604112 ->qsmask 0x20 .... ->n_boosts 0
[ 2904.315931] rcu: 	cpu 9 ->gp_seq_needed 604112
[ 2904.316648] rcu: 	cpu 10 ->gp_seq_needed 604112
[ 2904.317304] rcu: 	cpu 11 ->gp_seq_needed 604112
[ 2904.317972] rcu: 	cpu 12 ->gp_seq_needed 604112
[ 2904.318675] rcu: 	cpu 13 ->gp_seq_needed 604108
[ 2904.319364] rcu: 	cpu 14 ->gp_seq_needed 604112
[ 2904.320093] rcu: 	cpu 15 ->gp_seq_needed 604108
[ 2904.320800] rcu: 	cpu 16 ->gp_seq_needed 604112
[ 2904.321507] rcu: nocb GP 0 KldtS .[.W] .G:604108/169040 rnp 0:8 83920 S CPU 10
[ 2904.322651] rcu:    CB 0^0->2 KblSW F0 L0 C0 .W5(604108/169040).N12. q17 S CPU 14
[ 2904.323828] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W5(604108/169040).N12. q17 S CPU 15
[ 2904.324989] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2904.325970] rcu:    CB 4^4->7 KblSW F2329155 L2329164 C119 ..... q0 S CPU 2
[ 2904.327040] rcu:    CB 5^4->4 KblSW F2294305 L2294305 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2904.328528] rcu:    CB 7^4->-1 KblSW F2310625 L2310631 C16 ..... q0 S CPU 13
[ 2904.329716] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2904.330521] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2904.331517] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2904.332473] rcu: RCU callbacks invoked since boot: 6282632
[ 2904.333259] rcu_tasks: RTGS_WAIT_CBS(11) since 2903759 g:0 i:0 k.u.. l:250 
[ 2919.657457] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6075684 ni: 108103 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2919.666649] rcu-torture: Reader Pipe:  6467118068 122018 0 0 0 0 0 0 0 0 0
[ 2919.667732] rcu-torture: Reader Batch:  6466281025 959061 0 0 0 0 0 0 0 0 0
[ 2919.668797] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2919.670324] ??? Writer stall state RTWS_EXP_SYNC(4) g606265 f0x0 ->state D cpu 1
[ 2919.671443] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 173 ->gp_activity 6 ->gp_req_activity 173 ->gp_wake_time 173 ->gp_wake_seq 606261 ->gp_seq 606265 ->gp_seq_needed 606264 ->gp_max 453 ->gp_flags 0x0
[ 2919.674659] rcu: 	rcu_node 0:16 ->gp_seq 606265 ->gp_seq_needed 606264 ->qsmask 0x2 .... ->n_boosts 0
[ 2919.676034] rcu: 	rcu_node 0:8 ->gp_seq 606265 ->gp_seq_needed 606272 ->qsmask 0x0 .... ->n_boosts 0
[ 2919.677400] rcu: 	cpu 0 ->gp_seq_needed 606272
[ 2919.678043] rcu: 	cpu 1 ->gp_seq_needed 606272
[ 2919.678666] rcu: 	cpu 2 ->gp_seq_needed 606268
[ 2919.679356] rcu: 	cpu 8 ->gp_seq_needed 606272
[ 2919.680056] rcu: 	rcu_node 9:16 ->gp_seq 606265 ->gp_seq_needed 606272 ->qsmask 0x80 .... ->n_boosts 0
[ 2919.681497] rcu: 	cpu 9 ->gp_seq_needed 606272
[ 2919.682119] rcu: 	cpu 10 ->gp_seq_needed 606272
[ 2919.682826] rcu: 	cpu 11 ->gp_seq_needed 606272
[ 2919.683564] rcu: 	cpu 12 ->gp_seq_needed 606272
[ 2919.684309] rcu: 	cpu 13 ->gp_seq_needed 606268
[ 2919.684908] rcu: 	cpu 14 ->gp_seq_needed 606272
[ 2919.685637] rcu: 	cpu 15 ->gp_seq_needed 606272
[ 2919.686321] rcu: 	cpu 16 ->gp_seq_needed 606272
[ 2919.687005] rcu: nocb GP 0 KldtS .[.W] .G:606268/169040 rnp 0:8 84214 S CPU 10
[ 2919.688124] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W6(606268/169040).N84. q90 S CPU 14
[ 2919.689282] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W5(606268/169040).N194. q199 S CPU 15
[ 2919.690473] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2919.691485] rcu:    CB 4^4->7 KblSW F2344521 L2344530 C119 ..... q0 S CPU 2
[ 2919.692535] rcu:    CB 5^4->4 KblSW F2309671 L2309671 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2919.693944] rcu:    CB 7^4->-1 KblSW F2325990 L2325996 C16 ..... q0 S CPU 13
[ 2919.695103] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2919.695890] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2919.696836] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2919.697755] rcu: RCU callbacks invoked since boot: 6308426
[ 2919.698580] rcu_tasks: RTGS_WAIT_CBS(11) since 2919125 g:0 i:0 k.u.. l:250 
[ 2935.019107] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6115132 ni: 108810 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2935.025323] rcu-torture: Reader Pipe:  6509947418 122018 0 0 0 0 0 0 0 0 0
[ 2935.026363] rcu-torture: Reader Batch:  6509104971 964465 0 0 0 0 0 0 0 0 0
[ 2935.027398] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2935.031315] ??? Writer stall state RTWS_EXP_SYNC(4) g609709 f0x0 ->state D cpu 1
[ 2935.032547] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 106 ->gp_activity 6 ->gp_req_activity 106 ->gp_wake_time 106 ->gp_wake_seq 609705 ->gp_seq 609709 ->gp_seq_needed 609708 ->gp_max 453 ->gp_flags 0x0
[ 2935.035906] rcu: 	rcu_node 0:16 ->gp_seq 609709 ->gp_seq_needed 609708 ->qsmask 0x1 .... ->n_boosts 0
[ 2935.037296] rcu: 	rcu_node 0:8 ->gp_seq 609709 ->gp_seq_needed 609716 ->qsmask 0x1 .... ->n_boosts 0
[ 2935.038815] rcu: 	cpu 0 ->gp_seq_needed 609716
[ 2935.039476] rcu: 	cpu 1 ->gp_seq_needed 609716
[ 2935.040175] rcu: 	cpu 2 ->gp_seq_needed 609716
[ 2935.040846] rcu: 	cpu 8 ->gp_seq_needed 609716
[ 2935.041590] rcu: 	rcu_node 9:16 ->gp_seq 609709 ->gp_seq_needed 609716 ->qsmask 0x0 .... ->n_boosts 0
[ 2935.043094] rcu: 	cpu 9 ->gp_seq_needed 609716
[ 2935.043841] rcu: 	cpu 10 ->gp_seq_needed 609716
[ 2935.044602] rcu: 	cpu 11 ->gp_seq_needed 609716
[ 2935.045529] rcu: 	cpu 12 ->gp_seq_needed 609716
[ 2935.046220] rcu: 	cpu 13 ->gp_seq_needed 609716
[ 2935.046869] rcu: 	cpu 14 ->gp_seq_needed 609716
[ 2935.047492] rcu: 	cpu 15 ->gp_seq_needed 609712
[ 2935.048132] rcu: 	cpu 16 ->gp_seq_needed 609712
[ 2935.048807] rcu: nocb GP 0 KldtS .[.W] .G:609716/169040 rnp 0:8 84661 S CPU 10
[ 2935.050172] rcu:    CB 0^0->2 KblSW F126 L126 C0 .W3(609716/169040)... q3 S CPU 13
[ 2935.052946] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W4(609716/169040).N52. q56 S CPU 16
[ 2935.054481] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2935.055455] rcu:    CB 4^4->7 KblSW F2359885 L2359894 C119 ..... q0 S CPU 2
[ 2935.056331] rcu:    CB 5^4->4 KblSW F2325034 L2325034 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2935.058773] rcu:    CB 7^4->-1 KblSW F2341355 L2341361 C16 ..... q0 S CPU 13
[ 2935.059800] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2935.064399] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2935.065553] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2935.066512] rcu: RCU callbacks invoked since boot: 6349423
[ 2935.067517] rcu_tasks: RTGS_WAIT_CBS(11) since 2934494 g:0 i:0 k.u.. l:250 
[ 2950.377506] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6141948 ni: 109287 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2950.385305] rcu-torture: Reader Pipe:  6538495695 122018 0 0 0 0 0 0 0 0 0
[ 2950.386241] rcu-torture: Reader Batch:  6537649118 968595 0 0 0 0 0 0 0 0 0
[ 2950.387181] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2950.390791] ??? Writer stall state RTWS_EXP_SYNC(4) g612361 f0x0 ->state D cpu 1
[ 2950.391787] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 106 ->gp_activity 1 ->gp_req_activity 106 ->gp_wake_time 106 ->gp_wake_seq 612357 ->gp_seq 612361 ->gp_seq_needed 612368 ->gp_max 453 ->gp_flags 0x0
[ 2950.395172] rcu: 	rcu_node 0:16 ->gp_seq 612361 ->gp_seq_needed 612368 ->qsmask 0x1 .... ->n_boosts 0
[ 2950.396412] rcu: 	rcu_node 0:8 ->gp_seq 612361 ->gp_seq_needed 612368 ->qsmask 0x4 .... ->n_boosts 0
[ 2950.397623] rcu: 	cpu 0 ->gp_seq_needed 612364
[ 2950.398217] rcu: 	cpu 2 ->gp_seq_needed 612364
[ 2950.398823] rcu: 	cpu 8 ->gp_seq_needed 612364
[ 2950.399421] rcu: 	rcu_node 9:16 ->gp_seq 612361 ->gp_seq_needed 612368 ->qsmask 0x0 .... ->n_boosts 0
[ 2950.400733] rcu: 	cpu 9 ->gp_seq_needed 612368
[ 2950.401369] rcu: 	cpu 10 ->gp_seq_needed 612368
[ 2950.401980] rcu: 	cpu 11 ->gp_seq_needed 612368
[ 2950.402597] rcu: 	cpu 12 ->gp_seq_needed 612368
[ 2950.403200] rcu: 	cpu 13 ->gp_seq_needed 612368
[ 2950.403818] rcu: 	cpu 14 ->gp_seq_needed 612368
[ 2950.404435] rcu: 	cpu 15 ->gp_seq_needed 612368
[ 2950.405039] rcu: 	cpu 16 ->gp_seq_needed 612364
[ 2950.405657] rcu: nocb GP 0 KldtS .[.W] .G:612364/169040 rnp 0:8 85013 S CPU 10
[ 2950.406647] rcu:    CB 0^0->2 KblSW F1 L1 C0 .W9(612364/169040).N50. q59 S CPU 13
[ 2950.407649] rcu:    CB 2^0->-1 KblSW F123 L123 C0 .W8(612364/169040).N1. q9 S CPU 16
[ 2950.408689] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2950.409587] rcu:    CB 4^4->7 KblSW F2375239 L2375248 C119 ..... q0 S CPU 2
[ 2950.410524] rcu:    CB 5^4->4 KblSW F2340389 L2340389 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2950.411766] rcu:    CB 7^4->-1 KblSW F2356708 L2356714 C16 ..... q0 S CPU 13
[ 2950.412712] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2950.413534] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2950.414372] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2950.415210] rcu: RCU callbacks invoked since boot: 6376688
[ 2950.415954] rcu_tasks: RTGS_WAIT_CBS(11) since 2949842 g:0 i:0 k.u.. l:250 
[ 2965.737547] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6179765 ni: 109962 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2965.740607] rcu-torture: Reader Pipe:  6578830752 122018 0 0 0 0 0 0 0 0 0
[ 2965.741386] rcu-torture: Reader Batch:  6577980388 972382 0 0 0 0 0 0 0 0 0
[ 2965.742159] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2965.743271] ??? Writer stall state RTWS_EXP_SYNC(4) g614840 f0x0 ->state D cpu 1
[ 2965.744104] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 35 ->gp_activity 31 ->gp_req_activity 35 ->gp_wake_time 44 ->gp_wake_seq 614825 ->gp_seq 614840 ->gp_seq_needed 614840 ->gp_max 453 ->gp_flags 0x0
[ 2965.746528] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 85245 S CPU 8
[ 2965.747249] rcu:    CB 0^0->2 KblSW F283 L283 C0 ..... q0 S CPU 16
[ 2965.747977] rcu:    CB 2^0->-1 KblSW F440 L440 C0 ..... q0 S CPU 16
[ 2965.748678] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2965.749415] rcu:    CB 4^4->7 KblSW F2390578 L2390587 C119 ..... q0 S CPU 2
[ 2965.750197] rcu:    CB 5^4->4 KblSW F2355728 L2355728 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2965.751222] rcu:    CB 7^4->-1 KblSW F2372047 L2372053 C16 ..... q0 S CPU 13
[ 2965.752040] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2965.752731] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2965.753419] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2965.754101] rcu: RCU callbacks invoked since boot: 6415455
[ 2965.754730] rcu_tasks: RTGS_WAIT_CBS(11) since 2965181 g:0 i:0 k.u.. l:250 
[ 2981.097466] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6206858 ni: 110443 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2981.101370] rcu-torture: Reader Pipe:  6607898054 122018 0 0 0 0 0 0 0 0 0
[ 2981.102411] rcu-torture: Reader Batch:  6607043200 976872 0 0 0 0 0 0 0 0 0
[ 2981.103435] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2981.104971] ??? Writer stall state RTWS_EXP_SYNC(4) g617693 f0x0 ->state D cpu 1
[ 2981.106082] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 131 ->gp_activity 1 ->gp_req_activity 131 ->gp_wake_time 131 ->gp_wake_seq 617689 ->gp_seq 617693 ->gp_seq_needed 617692 ->gp_max 453 ->gp_flags 0x0
[ 2981.109368] rcu: 	rcu_node 0:16 ->gp_seq 617693 ->gp_seq_needed 617692 ->qsmask 0x2 .... ->n_boosts 0
[ 2981.110684] rcu: 	rcu_node 0:8 ->gp_seq 617693 ->gp_seq_needed 617700 ->qsmask 0x0 .... ->n_boosts 0
[ 2981.111859] rcu: 	cpu 0 ->gp_seq_needed 617700
[ 2981.112556] rcu: 	cpu 8 ->gp_seq_needed 617700
[ 2981.113247] rcu: 	rcu_node 9:16 ->gp_seq 617693 ->gp_seq_needed 617700 ->qsmask 0x0 ...G ->n_boosts 0
[ 2981.114620] rcu: 	cpu 9 ->gp_seq_needed 617700
[ 2981.115295] rcu: 	cpu 10 ->gp_seq_needed 617700
[ 2981.115985] rcu: 	cpu 11 ->gp_seq_needed 617700
[ 2981.116654] rcu: 	cpu 12 ->gp_seq_needed 617700
[ 2981.117344] rcu: 	cpu 13 ->gp_seq_needed 617700
[ 2981.118006] rcu: 	cpu 14 ->gp_seq_needed 617700
[ 2981.118696] rcu: 	cpu 15 ->gp_seq_needed 617700
[ 2981.119355] rcu: 	cpu 16 ->gp_seq_needed 617696
[ 2981.120012] rcu: nocb GP 0 KldtS .[.W] .G:617700/169040 rnp 0:8 85343 S CPU 8
[ 2981.121066] rcu:    CB 0^0->2 KblSW F238 L238 C0 ..... q0 S CPU 16
[ 2981.121955] rcu:    CB 2^0->-1 KblSW F8 L8 C0 .W1(617700/169040)... q1 S CPU 8
[ 2981.122847] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2981.123840] rcu:    CB 4^4->7 KblSW F2405953 L2405962 C119 ..... q0 S CPU 2
[ 2981.124847] rcu:    CB 5^4->4 KblSW F2371103 L2371103 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2981.126247] rcu:    CB 7^4->-1 KblSW F2387422 L2387428 C16 ..... q0 S CPU 13
[ 2981.127298] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2981.128239] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2981.129161] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2981.130137] rcu: RCU callbacks invoked since boot: 6442659
[ 2981.130988] rcu_tasks: RTGS_WAIT_CBS(11) since 2980557 g:0 i:0 k.u.. l:250 
[ 2996.457555] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6234410 ni: 110932 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 2996.460466] rcu-torture: Reader Pipe:  6637486590 122018 0 0 0 0 0 0 0 0 0
[ 2996.461199] rcu-torture: Reader Batch:  6636627356 981252 0 0 0 0 0 0 0 0 0
[ 2996.461938] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 2996.463006] ??? Writer stall state RTWS_EXP_SYNC(4) g620552 f0x0 ->state D cpu 1
[ 2996.463816] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 4732 ->gp_activity 4728 ->gp_req_activity 4732 ->gp_wake_time 4736 ->gp_wake_seq 620541 ->gp_seq 620552 ->gp_seq_needed 620552 ->gp_max 453 ->gp_flags 0x0
[ 2996.466223] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 85431 S CPU 8
[ 2996.466907] rcu:    CB 0^0->2 KblSW F5079 L5079 C0 ..... q0 S CPU 16
[ 2996.467591] rcu:    CB 2^0->-1 KblSW F5366 L5366 C0 ..... q0 S CPU 0
[ 2996.468268] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 2996.468960] rcu:    CB 4^4->7 KblSW F2421298 L2421307 C119 ..... q0 S CPU 2
[ 2996.469707] rcu:    CB 5^4->4 KblSW F2386448 L2386448 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 2996.470692] rcu:    CB 7^4->-1 KblSW F2402767 L2402773 C16 ..... q0 S CPU 13
[ 2996.471449] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 2996.472093] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 2996.472765] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 2996.473468] rcu: RCU callbacks invoked since boot: 6471070
[ 2996.474126] rcu_tasks: RTGS_WAIT_CBS(11) since 2995900 g:0 i:0 k.u.. l:250 
[ 3011.817506] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6273420 ni: 111636 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3011.824640] rcu-torture: Reader Pipe:  6679296973 122018 0 0 0 0 0 0 0 0 0
[ 3011.827338] rcu-torture: Reader Batch:  6678432618 986373 0 0 0 0 0 0 0 0 0
[ 3011.829713] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3011.832190] ??? Writer stall state RTWS_EXP_SYNC(4) g623849 f0x0 ->state D cpu 1
[ 3011.835357] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 57 ->gp_activity 0 ->gp_req_activity 57 ->gp_wake_time 57 ->gp_wake_seq 623845 ->gp_seq 623849 ->gp_seq_needed 623848 ->gp_max 453 ->gp_flags 0x0
[ 3011.841599] rcu: 	rcu_node 0:16 ->gp_seq 623849 ->gp_seq_needed 623848 ->qsmask 0x2 .... ->n_boosts 0
[ 3011.842996] rcu: 	rcu_node 0:8 ->gp_seq 623849 ->gp_seq_needed 623856 ->qsmask 0x0 .... ->n_boosts 0
[ 3011.846281] rcu: 	cpu 0 ->gp_seq_needed 623852
[ 3011.846929] rcu: 	cpu 8 ->gp_seq_needed 623852
[ 3011.847619] rcu: 	rcu_node 9:16 ->gp_seq 623849 ->gp_seq_needed 623856 ->qsmask 0x10 .... ->n_boosts 0
[ 3011.851147] rcu: 	cpu 9 ->gp_seq_needed 623856
[ 3011.853533] rcu: 	cpu 10 ->gp_seq_needed 623856
[ 3011.854233] rcu: 	cpu 11 ->gp_seq_needed 623856
[ 3011.854971] rcu: 	cpu 12 ->gp_seq_needed 623856
[ 3011.858530] rcu: 	cpu 13 ->gp_seq_needed 623856
[ 3011.859209] rcu: 	cpu 14 ->gp_seq_needed 623856
[ 3011.859924] rcu: 	cpu 15 ->gp_seq_needed 623856
[ 3011.860672] rcu: 	cpu 16 ->gp_seq_needed 623852
[ 3011.861349] rcu: nocb GP 0 KldtS .[W.] .G:623856/169040 rnp 0:8 85548 S CPU 8
[ 3011.862437] rcu:    CB 0^0->2 KblSW F783 L783 C0 ..... q0 S CPU 16
[ 3011.863371] rcu:    CB 2^0->-1 KblSW F32 L32 C0 .W1(623856/169040)... q1 S CPU 0
[ 3011.864575] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3011.865563] rcu:    CB 4^4->7 KblSW F2436695 L2436704 C119 ..... q0 S CPU 2
[ 3011.866608] rcu:    CB 5^4->4 KblSW F2401845 L2401845 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3011.868084] rcu:    CB 7^4->-1 KblSW F2418164 L2418170 C16 ..... q0 S CPU 13
[ 3011.869182] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3011.870106] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3011.871012] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3011.872011] rcu: RCU callbacks invoked since boot: 6510661
[ 3011.872867] rcu_tasks: RTGS_WAIT_CBS(11) since 3011299 g:0 i:0 k.u.. l:250 
[ 3027.178071] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6299327 ni: 112102 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3027.183607] rcu-torture: Reader Pipe:  6707172217 122018 0 0 0 0 0 0 0 0 0
[ 3027.184608] rcu-torture: Reader Batch:  6706304625 989610 0 0 0 0 0 0 0 0 0
[ 3027.185650] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3027.187157] ??? Writer stall state RTWS_EXP_SYNC(4) g625953 f0x0 ->state D cpu 1
[ 3027.188115] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 102 ->gp_activity 0 ->gp_req_activity 102 ->gp_wake_time 102 ->gp_wake_seq 625949 ->gp_seq 625953 ->gp_seq_needed 625952 ->gp_max 453 ->gp_flags 0x0
[ 3027.191355] rcu: 	rcu_node 0:16 ->gp_seq 625953 ->gp_seq_needed 625952 ->qsmask 0x2 .... ->n_boosts 0
[ 3027.192720] rcu: 	rcu_node 0:8 ->gp_seq 625953 ->gp_seq_needed 625960 ->qsmask 0x0 .... ->n_boosts 0
[ 3027.194004] rcu: 	cpu 0 ->gp_seq_needed 625960
[ 3027.194680] rcu: 	cpu 1 ->gp_seq_needed 625960
[ 3027.195350] rcu: 	cpu 8 ->gp_seq_needed 625960
[ 3027.195990] rcu: 	rcu_node 9:16 ->gp_seq 625953 ->gp_seq_needed 625960 ->qsmask 0x8 .... ->n_boosts 0
[ 3027.197351] rcu: 	cpu 9 ->gp_seq_needed 625960
[ 3027.197988] rcu: 	cpu 10 ->gp_seq_needed 625960
[ 3027.198563] rcu: 	cpu 11 ->gp_seq_needed 625960
[ 3027.199185] rcu: 	cpu 12 ->gp_seq_needed 625960
[ 3027.199868] rcu: 	cpu 13 ->gp_seq_needed 625960
[ 3027.200562] rcu: 	cpu 14 ->gp_seq_needed 625960
[ 3027.201239] rcu: 	cpu 15 ->gp_seq_needed 625960
[ 3027.201880] rcu: 	cpu 16 ->gp_seq_needed 625956
[ 3027.202555] rcu: nocb GP 0 Kldts .[W.] .G:625960/169040 rnp 0:8 85633 S CPU 8
[ 3027.203603] rcu:    CB 0^0->2 KblSW F88 L88 C0 .W1(625960/169040)... q1 S CPU 16
[ 3027.204744] rcu:    CB 2^0->-1 KblSW F81 L81 C0 ...N1. q1 S CPU 0
[ 3027.205643] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3027.206576] rcu:    CB 4^4->7 KblSW F2452036 L2452045 C119 ..... q0 S CPU 2
[ 3027.207614] rcu:    CB 5^4->4 KblSW F2417186 L2417186 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3027.208977] rcu:    CB 7^4->-1 KblSW F2433505 L2433511 C16 ..... q0 S CPU 13
[ 3027.209863] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3027.210745] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3027.211685] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3027.212647] rcu: RCU callbacks invoked since boot: 6536887
[ 3027.213507] rcu_tasks: RTGS_WAIT_CBS(11) since 3026640 g:0 i:0 k.u.. l:250 
[ 3042.538465] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6339040 ni: 112800 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3042.542620] rcu-torture: Reader Pipe:  6749157594 122018 0 0 0 0 0 0 0 0 0
[ 3042.543769] rcu-torture: Reader Batch:  6748284925 994686 0 0 0 0 0 0 0 0 0
[ 3042.544863] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3042.546554] ??? Writer stall state RTWS_EXP_SYNC(4) g629217 f0x0 ->state D cpu 1
[ 3042.547687] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 10 ->gp_activity 5 ->gp_req_activity 10 ->gp_wake_time 10 ->gp_wake_seq 629213 ->gp_seq 629217 ->gp_seq_needed 629216 ->gp_max 453 ->gp_flags 0x0
[ 3042.553279] rcu: 	rcu_node 0:16 ->gp_seq 629221 ->gp_seq_needed 629220 ->qsmask 0x3 .... ->n_boosts 0
[ 3042.554692] rcu: 	rcu_node 0:8 ->gp_seq 629221 ->gp_seq_needed 629220 ->qsmask 0x105 .... ->n_boosts 0
[ 3042.557922] rcu: 	rcu_node 9:16 ->gp_seq 629221 ->gp_seq_needed 629228 ->qsmask 0x80 .... ->n_boosts 0
[ 3042.559314] rcu: 	cpu 9 ->gp_seq_needed 629228
[ 3042.559960] rcu: 	cpu 10 ->gp_seq_needed 629228
[ 3042.562619] rcu: 	cpu 11 ->gp_seq_needed 629228
[ 3042.563311] rcu: 	cpu 12 ->gp_seq_needed 629228
[ 3042.563979] rcu: 	cpu 13 ->gp_seq_needed 629228
[ 3042.564697] rcu: 	cpu 14 ->gp_seq_needed 629228
[ 3042.565394] rcu: 	cpu 15 ->gp_seq_needed 629228
[ 3042.566138] rcu: 	cpu 16 ->gp_seq_needed 629228
[ 3042.566841] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 85753 S CPU 8
[ 3042.567822] rcu:    CB 0^0->2 KblSW F66 L66 C0 ..... q0 S CPU 16
[ 3042.568751] rcu:    CB 2^0->-1 KblSW F306 L306 C0 ..... q0 S CPU 0
[ 3042.569664] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3042.570696] rcu:    CB 4^4->7 KblSW F2467400 L2467409 C119 ..... q0 S CPU 2
[ 3042.571761] rcu:    CB 5^4->4 KblSW F2432550 L2432550 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3042.573219] rcu:    CB 7^4->-1 KblSW F2448869 L2448875 C16 ..... q0 S CPU 13
[ 3042.574295] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3042.575226] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3042.576143] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3042.577077] rcu: RCU callbacks invoked since boot: 6577553
[ 3042.577873] rcu_tasks: RTGS_WAIT_CBS(11) since 3042004 g:0 i:0 k.u.. l:250 
[ 3057.897453] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6365333 ni: 113274 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3057.903991] rcu-torture: Reader Pipe:  6777907168 122018 0 0 0 0 0 0 0 0 0
[ 3057.905034] rcu-torture: Reader Batch:  6777030821 998365 0 0 0 0 0 0 0 0 0
[ 3057.906152] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3057.907738] ??? Writer stall state RTWS_EXP_SYNC(4) g631565 f0x0 ->state D cpu 1
[ 3057.911146] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 10 ->gp_activity 3 ->gp_req_activity 10 ->gp_wake_time 10 ->gp_wake_seq 631561 ->gp_seq 631565 ->gp_seq_needed 631564 ->gp_max 453 ->gp_flags 0x0
[ 3057.918087] rcu: 	rcu_node 0:16 ->gp_seq 631565 ->gp_seq_needed 631564 ->qsmask 0x2 .... ->n_boosts 0
[ 3057.919534] rcu: 	rcu_node 0:8 ->gp_seq 631565 ->gp_seq_needed 631572 ->qsmask 0x0 .... ->n_boosts 0
[ 3057.924733] rcu: 	cpu 8 ->gp_seq_needed 631572
[ 3057.925441] rcu: 	rcu_node 9:16 ->gp_seq 631565 ->gp_seq_needed 631572 ->qsmask 0x80 .... ->n_boosts 0
[ 3057.926881] rcu: 	cpu 9 ->gp_seq_needed 631572
[ 3057.929153] rcu: 	cpu 10 ->gp_seq_needed 631572
[ 3057.932289] rcu: 	cpu 11 ->gp_seq_needed 631572
[ 3057.933005] rcu: 	cpu 12 ->gp_seq_needed 631572
[ 3057.933728] rcu: 	cpu 13 ->gp_seq_needed 631572
[ 3057.934453] rcu: 	cpu 14 ->gp_seq_needed 631572
[ 3057.935161] rcu: 	cpu 15 ->gp_seq_needed 631568
[ 3057.935868] rcu: 	cpu 16 ->gp_seq_needed 631572
[ 3057.936585] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 85857 S CPU 8
[ 3057.937594] rcu:    CB 0^0->2 KblSW F72 L72 C0 ..... q0 S CPU 16
[ 3057.938540] rcu:    CB 2^0->-1 KblSW F70 L70 C0 ..... q0 S CPU 0
[ 3057.939477] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3057.940499] rcu:    CB 4^4->7 KblSW F2482770 L2482779 C119 ..... q0 S CPU 2
[ 3057.941582] rcu:    CB 5^4->4 KblSW F2447920 L2447920 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3057.943032] rcu:    CB 7^4->-1 KblSW F2464239 L2464245 C16 ..... q0 S CPU 13
[ 3057.944133] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3057.945088] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3057.946113] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3057.947093] rcu: RCU callbacks invoked since boot: 6604307
[ 3057.947910] rcu_tasks: RTGS_WAIT_CBS(11) since 3057374 g:0 i:0 k.u.. l:250 
[ 3073.257501] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6395679 ni: 113814 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3073.260472] rcu-torture: Reader Pipe:  6810440747 122018 0 0 0 0 0 0 0 0 0
[ 3073.261236] rcu-torture: Reader Batch:  6809559270 1003495 0 0 0 0 0 0 0 0 0
[ 3073.262002] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3073.263085] ??? Writer stall state RTWS_EXP_SYNC(4) g634832 f0x0 ->state D cpu 1
[ 3073.263875] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 3616 ->gp_activity 3608 ->gp_req_activity 3616 ->gp_wake_time 3628 ->gp_wake_seq 634825 ->gp_seq 634832 ->gp_seq_needed 634832 ->gp_max 453 ->gp_flags 0x0
[ 3073.266309] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 85947 S CPU 8
[ 3073.267010] rcu:    CB 0^0->2 KblSW F3820 L3820 C0 ..... q0 S CPU 14
[ 3073.267693] rcu:    CB 2^0->-1 KblSW F3977 L3977 C0 ..... q0 S CPU 1
[ 3073.268378] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3073.269084] rcu:    CB 4^4->7 KblSW F2498098 L2498107 C119 ..... q0 S CPU 2
[ 3073.269831] rcu:    CB 5^4->4 KblSW F2463248 L2463248 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3073.270829] rcu:    CB 7^4->-1 KblSW F2479567 L2479573 C16 ..... q0 S CPU 13
[ 3073.271593] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3073.272252] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3073.272931] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3073.273604] rcu: RCU callbacks invoked since boot: 6635221
[ 3073.274195] rcu_tasks: RTGS_WAIT_CBS(11) since 3072700 g:0 i:0 k.u.. l:250 
[ 3088.617790] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6430544 ni: 114444 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3088.624276] rcu-torture: Reader Pipe:  6847697365 122018 0 0 0 0 0 0 0 0 0
[ 3088.625203] rcu-torture: Reader Batch:  6846811607 1007776 0 0 0 0 0 0 0 0 0
[ 3088.626143] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3088.627572] ??? Writer stall state RTWS_EXP_SYNC(4) g637569 f0x0 ->state D cpu 1
[ 3088.628626] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 10 ->gp_activity 1 ->gp_req_activity 10 ->gp_wake_time 10 ->gp_wake_seq 637565 ->gp_seq 637569 ->gp_seq_needed 637568 ->gp_max 453 ->gp_flags 0x0
[ 3088.631856] rcu: 	rcu_node 0:16 ->gp_seq 637569 ->gp_seq_needed 637568 ->qsmask 0x1 .... ->n_boosts 0
[ 3088.633183] rcu: 	rcu_node 0:8 ->gp_seq 637569 ->gp_seq_needed 637576 ->qsmask 0x1 .... ->n_boosts 0
[ 3088.634547] rcu: 	cpu 0 ->gp_seq_needed 637576
[ 3088.635144] rcu: 	cpu 1 ->gp_seq_needed 637576
[ 3088.636031] rcu: 	cpu 2 ->gp_seq_needed 637576
[ 3088.636699] rcu: 	cpu 8 ->gp_seq_needed 637576
[ 3088.637368] rcu: 	rcu_node 9:16 ->gp_seq 637569 ->gp_seq_needed 637576 ->qsmask 0x0 .... ->n_boosts 0
[ 3088.638608] rcu: 	cpu 9 ->gp_seq_needed 637572
[ 3088.639199] rcu: 	cpu 10 ->gp_seq_needed 637576
[ 3088.642492] rcu: 	cpu 11 ->gp_seq_needed 637576
[ 3088.643101] rcu: 	cpu 12 ->gp_seq_needed 637576
[ 3088.644720] rcu: 	cpu 13 ->gp_seq_needed 637576
[ 3088.645324] rcu: 	cpu 14 ->gp_seq_needed 637572
[ 3088.646021] rcu: 	cpu 15 ->gp_seq_needed 637576
[ 3088.647546] rcu: 	cpu 16 ->gp_seq_needed 637576
[ 3088.648237] rcu: nocb GP 0 KldtS .[.W] .G:637572/169040 rnp 0:8 86107 S CPU 14
[ 3088.649135] rcu:    CB 0^0->2 KblSW F366 L366 C0 ..... q0 S CPU 15
[ 3088.650077] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W7(637572/169040).N13. q20 S CPU 0
[ 3088.651647] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3088.652468] rcu:    CB 4^4->7 KblSW F2513482 L2513491 C119 ..... q0 S CPU 2
[ 3088.653334] rcu:    CB 5^4->4 KblSW F2478631 L2478631 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3088.660159] rcu:    CB 7^4->-1 KblSW F2494956 L2494962 C16 ..... q0 S CPU 13
[ 3088.661053] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3088.661809] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3088.662602] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3088.663419] rcu: RCU callbacks invoked since boot: 6670680
[ 3088.664111] rcu_tasks: RTGS_WAIT_CBS(11) since 3088090 g:0 i:0 k.u.. l:250 
[ 3103.977475] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6458173 ni: 114939 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3103.981275] rcu-torture: Reader Pipe:  6877297271 122018 0 0 0 0 0 0 0 0 0
[ 3103.984697] rcu-torture: Reader Batch:  6876406766 1012522 0 0 0 0 0 0 0 0 0
[ 3103.987327] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3103.988674] ??? Writer stall state RTWS_EXP_SYNC(4) g640641 f0x0 ->state D cpu 1
[ 3103.989660] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 13 ->gp_activity 4 ->gp_req_activity 13 ->gp_wake_time 13 ->gp_wake_seq 640637 ->gp_seq 640641 ->gp_seq_needed 640640 ->gp_max 453 ->gp_flags 0x0
[ 3103.994498] rcu: 	rcu_node 0:16 ->gp_seq 640641 ->gp_seq_needed 640640 ->qsmask 0x1 .... ->n_boosts 0
[ 3103.999679] rcu: 	rcu_node 0:8 ->gp_seq 640641 ->gp_seq_needed 640648 ->qsmask 0x1 .... ->n_boosts 0
[ 3104.000935] rcu: 	cpu 0 ->gp_seq_needed 640648
[ 3104.006509] rcu: 	cpu 1 ->gp_seq_needed 640648
[ 3104.007206] rcu: 	cpu 2 ->gp_seq_needed 640644
[ 3104.007860] rcu: 	cpu 8 ->gp_seq_needed 640644
[ 3104.008536] rcu: 	rcu_node 9:16 ->gp_seq 640641 ->gp_seq_needed 640648 ->qsmask 0x0 .... ->n_boosts 0
[ 3104.009972] rcu: 	cpu 9 ->gp_seq_needed 640644
[ 3104.010715] rcu: 	cpu 10 ->gp_seq_needed 640648
[ 3104.011360] rcu: 	cpu 11 ->gp_seq_needed 640648
[ 3104.012078] rcu: 	cpu 12 ->gp_seq_needed 640648
[ 3104.012827] rcu: 	cpu 13 ->gp_seq_needed 640648
[ 3104.013612] rcu: 	cpu 14 ->gp_seq_needed 640644
[ 3104.014300] rcu: 	cpu 15 ->gp_seq_needed 640648
[ 3104.015071] rcu: 	cpu 16 ->gp_seq_needed 640644
[ 3104.015765] rcu: nocb GP 0 KldtS .[.W] .G:640644/169040 rnp 0:8 86506 S CPU 14
[ 3104.016700] rcu:    CB 0^0->2 KblSW F53 L53 C0 .W1(640644/169040)... q1 S CPU 15
[ 3104.017875] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W6(640644/169040).N22. q28 S CPU 0
[ 3104.019041] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3104.020023] rcu:    CB 4^4->7 KblSW F2528849 L2528858 C119 ..... q0 S CPU 2
[ 3104.021126] rcu:    CB 5^4->4 KblSW F2493999 L2493999 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3104.022537] rcu:    CB 7^4->-1 KblSW F2510319 L2510325 C16 ..... q0 S CPU 13
[ 3104.023587] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3104.024532] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3104.025463] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3104.026402] rcu: RCU callbacks invoked since boot: 6698779
[ 3104.027280] rcu_tasks: RTGS_WAIT_CBS(11) since 3103453 g:0 i:0 k.u.. l:250 
[ 3119.337469] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6498406 ni: 115651 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3119.340815] rcu-torture: Reader Pipe:  6920137043 122018 0 0 0 0 0 0 0 0 0
[ 3119.341703] rcu-torture: Reader Batch:  6919240323 1018738 0 0 0 0 0 0 0 0 0
[ 3119.342633] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3119.344030] ??? Writer stall state RTWS_EXP_SYNC(4) g644657 f0x0 ->state D cpu 1
[ 3119.345004] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 4 ->gp_activity 0 ->gp_req_activity 4 ->gp_wake_time 18 ->gp_wake_seq 644653 ->gp_seq 644657 ->gp_seq_needed 644660 ->gp_max 453 ->gp_flags 0x0
[ 3119.347617] rcu: 	rcu_node 0:16 ->gp_seq 644657 ->gp_seq_needed 644660 ->qsmask 0x1 .... ->n_boosts 0
[ 3119.348914] rcu: 	rcu_node 0:8 ->gp_seq 644657 ->gp_seq_needed 644664 ->qsmask 0x1 .... ->n_boosts 0
[ 3119.350346] rcu: 	cpu 0 ->gp_seq_needed 644660
[ 3119.351016] rcu: 	cpu 1 ->gp_seq_needed 644664
[ 3119.351706] rcu: 	cpu 2 ->gp_seq_needed 644664
[ 3119.352348] rcu: 	cpu 8 ->gp_seq_needed 644664
[ 3119.352957] rcu: 	rcu_node 9:16 ->gp_seq 644657 ->gp_seq_needed 644664 ->qsmask 0x0 .... ->n_boosts 0
[ 3119.354173] rcu: 	cpu 9 ->gp_seq_needed 644660
[ 3119.354859] rcu: 	cpu 10 ->gp_seq_needed 644664
[ 3119.355552] rcu: 	cpu 11 ->gp_seq_needed 644660
[ 3119.356221] rcu: 	cpu 12 ->gp_seq_needed 644664
[ 3119.356927] rcu: 	cpu 13 ->gp_seq_needed 644664
[ 3119.357624] rcu: 	cpu 14 ->gp_seq_needed 644664
[ 3119.358320] rcu: 	cpu 16 ->gp_seq_needed 644664
[ 3119.358996] rcu: nocb GP 0 KldtS .[.W] .G:644660/169040 rnp 0:8 87027 S CPU 11
[ 3119.360095] rcu:    CB 0^0->2 KblSW F106 L106 C0 ..... q0 S CPU 15
[ 3119.361007] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W13(644660/169040).N13. q26 S CPU 8
[ 3119.362133] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3119.363122] rcu:    CB 4^4->7 KblSW F2544192 L2544201 C119 ..... q0 S CPU 2
[ 3119.364111] rcu:    CB 5^4->4 KblSW F2509342 L2509342 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3119.365490] rcu:    CB 7^4->-1 KblSW F2525662 L2525668 C16 ..... q0 S CPU 13
[ 3119.366533] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3119.367506] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3119.368470] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3119.369425] rcu: RCU callbacks invoked since boot: 6739674
[ 3119.370317] rcu_tasks: RTGS_WAIT_CBS(11) since 3118796 g:0 i:0 k.u.. l:250 
[ 3134.699752] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6525395 ni: 116136 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3134.703412] rcu-torture: Reader Pipe:  6949277918 122018 0 0 0 0 0 0 0 0 0
[ 3134.704348] rcu-torture: Reader Batch:  6948377284 1022652 0 0 0 0 0 0 0 0 0
[ 3134.705298] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3134.706641] ??? Writer stall state RTWS_EXP_SYNC(4) g647141 f0x0 ->state D cpu 1
[ 3134.707622] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 204 ->gp_activity 1 ->gp_req_activity 204 ->gp_wake_time 216 ->gp_wake_seq 647137 ->gp_seq 647141 ->gp_seq_needed 647144 ->gp_max 453 ->gp_flags 0x0
[ 3134.710572] rcu: 	rcu_node 0:16 ->gp_seq 647141 ->gp_seq_needed 647144 ->qsmask 0x2 .... ->n_boosts 0
[ 3134.711803] rcu: 	rcu_node 0:8 ->gp_seq 647141 ->gp_seq_needed 647144 ->qsmask 0x0 .... ->n_boosts 0
[ 3134.713010] rcu: 	cpu 0 ->gp_seq_needed 647144
[ 3134.713604] rcu: 	cpu 2 ->gp_seq_needed 647144
[ 3134.714198] rcu: 	cpu 8 ->gp_seq_needed 647144
[ 3134.714797] rcu: 	rcu_node 9:16 ->gp_seq 647141 ->gp_seq_needed 647148 ->qsmask 0x1 .... ->n_boosts 0
[ 3134.716016] rcu: 	cpu 9 ->gp_seq_needed 647148
[ 3134.716610] rcu: 	cpu 10 ->gp_seq_needed 647148
[ 3134.717214] rcu: 	cpu 11 ->gp_seq_needed 647144
[ 3134.717825] rcu: 	cpu 12 ->gp_seq_needed 647148
[ 3134.718424] rcu: 	cpu 13 ->gp_seq_needed 647148
[ 3134.719042] rcu: 	cpu 14 ->gp_seq_needed 647148
[ 3134.719647] rcu: 	cpu 15 ->gp_seq_needed 647148
[ 3134.720256] rcu: 	cpu 16 ->gp_seq_needed 647148
[ 3134.720874] rcu: nocb GP 0 Kldts .[W.] .G:647144/169040 rnp 0:8 87350 S CPU 15
[ 3134.721843] rcu:    CB 0^0->2 KblSW F11 L11 C0 ...N1. q1 S CPU 0
[ 3134.722643] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W133(647144/169040).N88. q221 S CPU 8
[ 3134.723681] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3134.724549] rcu:    CB 4^4->7 KblSW F2559554 L2559563 C119 ..... q0 S CPU 2
[ 3134.725481] rcu:    CB 5^4->4 KblSW F2524704 L2524704 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3134.726724] rcu:    CB 7^4->-1 KblSW F2541023 L2541029 C16 ..... q0 S CPU 13
[ 3134.727825] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3134.728765] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3134.729684] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3134.730627] rcu: RCU callbacks invoked since boot: 6766497
[ 3134.731450] rcu_tasks: RTGS_WAIT_CBS(11) since 3134158 g:0 i:0 k.u.. l:250 
[ 3150.057524] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6559081 ni: 116731 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3150.060537] rcu-torture: Reader Pipe:  6985148603 122018 0 0 0 0 0 0 0 0 0
[ 3150.061284] rcu-torture: Reader Batch:  6984242803 1027818 0 0 0 0 0 0 0 0 0
[ 3150.062051] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3150.063137] ??? Writer stall state RTWS_EXP_SYNC(4) g650548 f0x0 ->state D cpu 1
[ 3150.063933] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 2490 ->gp_activity 2486 ->gp_req_activity 2490 ->gp_wake_time 2504 ->gp_wake_seq 650529 ->gp_seq 650548 ->gp_seq_needed 650548 ->gp_max 453 ->gp_flags 0x0
[ 3150.066354] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 87792 S CPU 0
[ 3150.067050] rcu:    CB 0^0->2 KblSW F2772 L2772 C0 ..... q0 S CPU 1
[ 3150.067790] rcu:    CB 2^0->-1 KblSW F2507 L2507 C0 ..... q0 S CPU 8
[ 3150.068470] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3150.069170] rcu:    CB 4^4->7 KblSW F2574898 L2574907 C119 ..... q0 S CPU 2
[ 3150.069920] rcu:    CB 5^4->4 KblSW F2540048 L2540048 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3150.070915] rcu:    CB 7^4->-1 KblSW F2556367 L2556373 C16 ..... q0 S CPU 13
[ 3150.071671] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3150.072318] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3150.072996] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3150.073669] rcu: RCU callbacks invoked since boot: 6801540
[ 3150.074252] rcu_tasks: RTGS_WAIT_CBS(11) since 3149500 g:0 i:0 k.u.. l:250 
[ 3165.417503] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6592151 ni: 117323 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3165.421600] rcu-torture: Reader Pipe:  7020409257 122018 0 0 0 0 0 0 0 0 0
[ 3165.422620] rcu-torture: Reader Batch:  7019498838 1032436 0 0 0 0 0 0 0 0 0
[ 3165.423704] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3165.425217] ??? Writer stall state RTWS_EXP_SYNC(4) g653509 f0x0 ->state D cpu 1
[ 3165.426317] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 22 ->gp_activity 0 ->gp_req_activity 22 ->gp_wake_time 32 ->gp_wake_seq 653501 ->gp_seq 653509 ->gp_seq_needed 653516 ->gp_max 453 ->gp_flags 0x0
[ 3165.429360] rcu: 	rcu_node 0:16 ->gp_seq 653512 ->gp_seq_needed 653516 ->qsmask 0x0 .... ->n_boosts 0
[ 3165.430738] rcu: 	rcu_node 0:8 ->gp_seq 653509 ->gp_seq_needed 653512 ->qsmask 0x0 .... ->n_boosts 0
[ 3165.432134] rcu: 	cpu 0 ->gp_seq_needed 653512
[ 3165.432799] rcu: 	cpu 1 ->gp_seq_needed 653512
[ 3165.433455] rcu: 	cpu 2 ->gp_seq_needed 653516
[ 3165.434144] rcu: 	cpu 8 ->gp_seq_needed 653512
[ 3165.434804] rcu: 	rcu_node 9:16 ->gp_seq 653509 ->gp_seq_needed 653516 ->qsmask 0x0 .... ->n_boosts 0
[ 3165.436174] rcu: 	cpu 9 ->gp_seq_needed 653516
[ 3165.436837] rcu: 	cpu 10 ->gp_seq_needed 653516
[ 3165.437518] rcu: 	cpu 11 ->gp_seq_needed 653516
[ 3165.438207] rcu: 	cpu 13 ->gp_seq_needed 653516
[ 3165.438777] rcu: 	cpu 14 ->gp_seq_needed 653516
[ 3165.439397] rcu: 	cpu 15 ->gp_seq_needed 653516
[ 3165.440107] rcu: 	cpu 16 ->gp_seq_needed 653516
[ 3165.440812] rcu: nocb GP 0 KldtS .[.W] .G:653516/169040 rnp 0:8 88177 S CPU 1
[ 3165.441903] rcu:    CB 0^0->2 KblSW F848 L848 C0 ..... q0 S CPU 8
[ 3165.442872] rcu:    CB 2^0->-1 KblSW F0 L0 C0 .W13(653516/169040).N4. q17 S CPU 10
[ 3165.444039] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3165.445053] rcu:    CB 4^4->7 KblSW F2590274 L2590283 C119 ..... q0 S CPU 2
[ 3165.446122] rcu:    CB 5^4->4 KblSW F2555424 L2555424 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3165.447468] rcu:    CB 7^4->-1 KblSW F2571744 L2571750 C16 ..... q0 S CPU 13
[ 3165.448532] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3165.449449] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3165.450185] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3165.451120] rcu: RCU callbacks invoked since boot: 6835145
[ 3165.451948] rcu_tasks: RTGS_WAIT_CBS(11) since 3164878 g:0 i:0 k.u.. l:250 
[ 3180.777777] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6618919 ni: 117799 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3180.781945] rcu-torture: Reader Pipe:  7049330050 122018 0 0 0 0 0 0 0 0 0
[ 3180.782916] rcu-torture: Reader Batch:  7048416164 1035904 0 0 0 0 0 0 0 0 0
[ 3180.784018] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3180.785575] ??? Writer stall state RTWS_EXP_SYNC(4) g655765 f0x0 ->state D cpu 1
[ 3180.786710] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 140 ->gp_activity 0 ->gp_req_activity 140 ->gp_wake_time 140 ->gp_wake_seq 655761 ->gp_seq 655765 ->gp_seq_needed 655764 ->gp_max 453 ->gp_flags 0x0
[ 3180.790114] rcu: 	rcu_node 0:16 ->gp_seq 655765 ->gp_seq_needed 655764 ->qsmask 0x2 .... ->n_boosts 0
[ 3180.791572] rcu: 	rcu_node 0:8 ->gp_seq 655765 ->gp_seq_needed 655772 ->qsmask 0x0 .... ->n_boosts 0
[ 3180.793018] rcu: 	cpu 0 ->gp_seq_needed 655772
[ 3180.793677] rcu: 	cpu 2 ->gp_seq_needed 655772
[ 3180.794350] rcu: 	rcu_node 9:16 ->gp_seq 655765 ->gp_seq_needed 655772 ->qsmask 0x0 ...G ->n_boosts 0
[ 3180.795770] rcu: 	cpu 9 ->gp_seq_needed 655772
[ 3180.796455] rcu: 	cpu 10 ->gp_seq_needed 655772
[ 3180.797126] rcu: 	cpu 11 ->gp_seq_needed 655772
[ 3180.797849] rcu: 	cpu 12 ->gp_seq_needed 655772
[ 3180.798579] rcu: 	cpu 13 ->gp_seq_needed 655772
[ 3180.799269] rcu: 	cpu 14 ->gp_seq_needed 655772
[ 3180.799972] rcu: 	cpu 15 ->gp_seq_needed 655772
[ 3180.800680] rcu: 	cpu 16 ->gp_seq_needed 655772
[ 3180.801348] rcu: nocb GP 0 KldtS .[.W] .G:655772/169040 rnp 0:8 88470 S CPU 0
[ 3180.802504] rcu:    CB 0^0->2 KblSW F255 L255 C0 ..... q0 S CPU 8
[ 3180.803423] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W8(655772/169040).N59. q67 S CPU 10
[ 3180.804651] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3180.805682] rcu:    CB 4^4->7 KblSW F2605635 L2605644 C119 ..... q0 S CPU 2
[ 3180.806735] rcu:    CB 5^4->4 KblSW F2570785 L2570785 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3180.808140] rcu:    CB 7^4->-1 KblSW F2587104 L2587110 C16 ..... q0 S CPU 13
[ 3180.809214] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3180.810129] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3180.811088] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3180.812054] rcu: RCU callbacks invoked since boot: 6862070
[ 3180.812887] rcu_tasks: RTGS_WAIT_CBS(11) since 3180239 g:0 i:0 k.u.. l:250 
[ 3196.137510] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6658174 ni: 118500 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3196.141585] rcu-torture: Reader Pipe:  7091944261 122018 0 0 0 0 0 0 0 0 0
[ 3196.142661] rcu-torture: Reader Batch:  7091025253 1041026 0 0 0 0 0 0 0 0 0
[ 3196.143759] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3196.145328] ??? Writer stall state RTWS_EXP_SYNC(4) g658989 f0x0 ->state D cpu 1
[ 3196.146474] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 145 ->gp_activity 3 ->gp_req_activity 145 ->gp_wake_time 149 ->gp_wake_seq 658981 ->gp_seq 658989 ->gp_seq_needed 658992 ->gp_max 453 ->gp_flags 0x0
[ 3196.149814] rcu: 	rcu_node 0:16 ->gp_seq 658989 ->gp_seq_needed 658992 ->qsmask 0x2 .... ->n_boosts 0
[ 3196.151200] rcu: 	rcu_node 0:8 ->gp_seq 658989 ->gp_seq_needed 658996 ->qsmask 0x0 .... ->n_boosts 0
[ 3196.152563] rcu: 	cpu 0 ->gp_seq_needed 658996
[ 3196.153246] rcu: 	cpu 1 ->gp_seq_needed 658996
[ 3196.153927] rcu: 	cpu 2 ->gp_seq_needed 658996
[ 3196.154630] rcu: 	cpu 8 ->gp_seq_needed 658992
[ 3196.155311] rcu: 	rcu_node 9:16 ->gp_seq 658989 ->gp_seq_needed 658996 ->qsmask 0x1 .... ->n_boosts 0
[ 3196.156718] rcu: 	cpu 9 ->gp_seq_needed 658992
[ 3196.157393] rcu: 	cpu 10 ->gp_seq_needed 658996
[ 3196.158086] rcu: 	cpu 11 ->gp_seq_needed 658996
[ 3196.158766] rcu: 	cpu 12 ->gp_seq_needed 658996
[ 3196.159469] rcu: 	cpu 13 ->gp_seq_needed 658996
[ 3196.160172] rcu: 	cpu 14 ->gp_seq_needed 658996
[ 3196.160888] rcu: 	cpu 15 ->gp_seq_needed 658996
[ 3196.161604] rcu: 	cpu 16 ->gp_seq_needed 658996
[ 3196.162289] rcu: nocb GP 0 Kldts .[.W] .G:658996/169040 rnp 0:8 88888 S CPU 0
[ 3196.163389] rcu:    CB 0^0->2 KblSW F151 L151 C0 ...N1. q1 S CPU 1
[ 3196.164324] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W3(658996/169040).N60. q63 S CPU 10
[ 3196.165482] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3196.166420] rcu:    CB 4^4->7 KblSW F2620995 L2621004 C119 ..... q0 S CPU 2
[ 3196.167523] rcu:    CB 5^4->4 KblSW F2586146 L2586146 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3196.168961] rcu:    CB 7^4->-1 KblSW F2602465 L2602471 C16 ..... q0 S CPU 13
[ 3196.170057] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3196.171009] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3196.171969] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3196.172937] rcu: RCU callbacks invoked since boot: 6902077
[ 3196.173747] rcu_tasks: RTGS_WAIT_CBS(11) since 3195600 g:0 i:0 k.u.. l:250 
[ 3211.497473] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6686010 ni: 118991 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3211.504358] rcu-torture: Reader Pipe:  7121658267 122018 0 0 0 0 0 0 0 0 0
[ 3211.505438] rcu-torture: Reader Batch:  7120733946 1046339 0 0 0 0 0 0 0 0 0
[ 3211.507510] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3211.509314] ??? Writer stall state RTWS_EXP_SYNC(4) g662345 f0x0 ->state D cpu 1
[ 3211.510324] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 148 ->gp_activity 2 ->gp_req_activity 148 ->gp_wake_time 148 ->gp_wake_seq 662341 ->gp_seq 662345 ->gp_seq_needed 662348 ->gp_max 453 ->gp_flags 0x0
[ 3211.515158] rcu: 	rcu_node 0:16 ->gp_seq 662345 ->gp_seq_needed 662348 ->qsmask 0x1 .... ->n_boosts 0
[ 3211.516702] rcu: 	rcu_node 0:8 ->gp_seq 662345 ->gp_seq_needed 662352 ->qsmask 0x0 ...G ->n_boosts 0
[ 3211.518067] rcu: 	cpu 0 ->gp_seq_needed 662352
[ 3211.518772] rcu: 	cpu 1 ->gp_seq_needed 662352
[ 3211.519506] rcu: 	cpu 2 ->gp_seq_needed 662352
[ 3211.520156] rcu: 	cpu 8 ->gp_seq_needed 662348
[ 3211.520916] rcu: 	rcu_node 9:16 ->gp_seq 662345 ->gp_seq_needed 662352 ->qsmask 0x0 .... ->n_boosts 0
[ 3211.523494] rcu: 	cpu 9 ->gp_seq_needed 662352
[ 3211.524185] rcu: 	cpu 10 ->gp_seq_needed 662352
[ 3211.526950] rcu: 	cpu 11 ->gp_seq_needed 662352
[ 3211.528044] rcu: 	cpu 13 ->gp_seq_needed 662352
[ 3211.531998] rcu: 	cpu 14 ->gp_seq_needed 662352
[ 3211.532712] rcu: 	cpu 15 ->gp_seq_needed 662352
[ 3211.533423] rcu: 	cpu 16 ->gp_seq_needed 662352
[ 3211.534141] rcu: nocb GP 0 KldtS .[W.] .G:662352/169040 rnp 0:8 89323 S CPU 0
[ 3211.536305] rcu:    CB 0^0->2 KblSW F177 L177 C0 .W3(662352/169040)... q3 S CPU 1
[ 3211.537472] rcu:    CB 2^0->-1 KblSW F298 L298 C0 .W73(662352/169040)... q73 S CPU 10
[ 3211.541471] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3211.544383] rcu:    CB 4^4->7 KblSW F2636373 L2636382 C119 ..... q0 S CPU 2
[ 3211.545477] rcu:    CB 5^4->4 KblSW F2601524 L2601524 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3211.549244] rcu:    CB 7^4->-1 KblSW F2617845 L2617851 C16 ..... q0 S CPU 13
[ 3211.550368] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3211.551332] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3211.552288] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3211.553250] rcu: RCU callbacks invoked since boot: 6929704
[ 3211.554114] rcu_tasks: RTGS_WAIT_CBS(11) since 3210980 g:0 i:0 k.u.. l:250 
[ 3226.857503] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6722430 ni: 119637 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3226.860592] rcu-torture: Reader Pipe:  7160141901 122018 0 0 0 0 0 0 0 0 0
[ 3226.861379] rcu-torture: Reader Batch:  7159211667 1052252 0 0 0 0 0 0 0 0 0
[ 3226.862189] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3226.863353] ??? Writer stall state RTWS_EXP_SYNC(4) g666192 f0x0 ->state D cpu 1
[ 3226.864184] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 1298 ->gp_activity 1294 ->gp_req_activity 1298 ->gp_wake_time 1318 ->gp_wake_seq 666169 ->gp_seq 666192 ->gp_seq_needed 666192 ->gp_max 453 ->gp_flags 0x0
[ 3226.866789] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 89822 S CPU 0
[ 3226.867546] rcu:    CB 0^0->2 KblSW F1419 L1419 C0 ..... q0 S CPU 11
[ 3226.868288] rcu:    CB 2^0->-1 KblSW F1310 L1310 C0 ..... q0 S CPU 12
[ 3226.869043] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3226.869839] rcu:    CB 4^4->7 KblSW F2651699 L2651708 C119 ..... q0 S CPU 2
[ 3226.870663] rcu:    CB 5^4->4 KblSW F2616849 L2616849 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3226.871729] rcu:    CB 7^4->-1 KblSW F2633168 L2633174 C16 ..... q0 S CPU 13
[ 3226.872580] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3226.873273] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3226.873990] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3226.874711] rcu: RCU callbacks invoked since boot: 6967795
[ 3226.875362] rcu_tasks: RTGS_WAIT_CBS(11) since 3226301 g:0 i:0 k.u.. l:250 
[ 3242.217457] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6751700 ni: 120164 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3242.224345] rcu-torture: Reader Pipe:  7191226556 122018 0 0 0 0 0 0 0 0 0
[ 3242.225392] rcu-torture: Reader Batch:  7190292898 1055676 0 0 0 0 0 0 0 0 0
[ 3242.229298] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3242.230859] ??? Writer stall state RTWS_EXP_SYNC(4) g668341 f0x0 ->state D cpu 1
[ 3242.233035] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 16 ->gp_activity 4 ->gp_req_activity 16 ->gp_wake_time 21 ->gp_wake_seq 668333 ->gp_seq 668341 ->gp_seq_needed 668340 ->gp_max 453 ->gp_flags 0x0
[ 3242.237028] rcu: 	rcu_node 0:16 ->gp_seq 668341 ->gp_seq_needed 668340 ->qsmask 0x1 .... ->n_boosts 0
[ 3242.238434] rcu: 	rcu_node 0:8 ->gp_seq 668341 ->gp_seq_needed 668348 ->qsmask 0x1 .... ->n_boosts 0
[ 3242.239815] rcu: 	cpu 0 ->gp_seq_needed 668348
[ 3242.241902] rcu: 	cpu 1 ->gp_seq_needed 668348
[ 3242.242613] rcu: 	cpu 2 ->gp_seq_needed 668344
[ 3242.243450] rcu: 	rcu_node 9:16 ->gp_seq 668341 ->gp_seq_needed 668348 ->qsmask 0x0 .... ->n_boosts 0
[ 3242.245236] rcu: 	cpu 9 ->gp_seq_needed 668348
[ 3242.246150] rcu: 	cpu 10 ->gp_seq_needed 668348
[ 3242.247019] rcu: 	cpu 11 ->gp_seq_needed 668344
[ 3242.247773] rcu: 	cpu 12 ->gp_seq_needed 668348
[ 3242.248482] rcu: 	cpu 13 ->gp_seq_needed 668344
[ 3242.249171] rcu: 	cpu 14 ->gp_seq_needed 668348
[ 3242.249906] rcu: 	cpu 16 ->gp_seq_needed 668348
[ 3242.250640] rcu: nocb GP 0 KldtS .[W.] .G:668344/169040 rnp 0:8 90101 S CPU 0
[ 3242.251748] rcu:    CB 0^0->2 KblSW F84 L84 C0 ..... q0 S CPU 11
[ 3242.252666] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W5(668344/169040).N18. q23 S CPU 12
[ 3242.253952] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3242.254859] rcu:    CB 4^4->7 KblSW F2667084 L2667093 C119 ..... q0 S CPU 2
[ 3242.255808] rcu:    CB 5^4->4 KblSW F2632234 L2632234 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3242.257220] rcu:    CB 7^4->-1 KblSW F2648553 L2648559 C16 ..... q0 S CPU 13
[ 3242.258317] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3242.259221] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3242.260166] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3242.261160] rcu: RCU callbacks invoked since boot: 6997561
[ 3242.261950] rcu_tasks: RTGS_WAIT_CBS(11) since 3241688 g:0 i:0 k.u.. l:250 
[ 3257.577486] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6778833 ni: 120647 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3257.581550] rcu-torture: Reader Pipe:  7219441674 122018 0 0 0 0 0 0 0 0 0
[ 3257.582630] rcu-torture: Reader Batch:  7218504421 1059271 0 0 0 0 0 0 0 0 0
[ 3257.583846] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3257.585371] ??? Writer stall state RTWS_EXP_SYNC(4) g670725 f0x0 ->state D cpu 1
[ 3257.586463] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 77 ->gp_activity 1 ->gp_req_activity 77 ->gp_wake_time 77 ->gp_wake_seq 670721 ->gp_seq 670725 ->gp_seq_needed 670728 ->gp_max 453 ->gp_flags 0x0
[ 3257.589585] rcu: 	rcu_node 0:16 ->gp_seq 670725 ->gp_seq_needed 670728 ->qsmask 0x2 .... ->n_boosts 0
[ 3257.590946] rcu: 	rcu_node 0:8 ->gp_seq 670725 ->gp_seq_needed 670732 ->qsmask 0x0 .... ->n_boosts 0
[ 3257.592315] rcu: 	cpu 0 ->gp_seq_needed 670732
[ 3257.592998] rcu: 	cpu 1 ->gp_seq_needed 670732
[ 3257.593635] rcu: 	cpu 2 ->gp_seq_needed 670728
[ 3257.594300] rcu: 	cpu 8 ->gp_seq_needed 670732
[ 3257.594960] rcu: 	rcu_node 9:16 ->gp_seq 670725 ->gp_seq_needed 670732 ->qsmask 0x1 .... ->n_boosts 0
[ 3257.596336] rcu: 	cpu 9 ->gp_seq_needed 670732
[ 3257.597012] rcu: 	cpu 10 ->gp_seq_needed 670732
[ 3257.597695] rcu: 	cpu 11 ->gp_seq_needed 670732
[ 3257.598370] rcu: 	cpu 12 ->gp_seq_needed 670728
[ 3257.598866] rcu: 	cpu 13 ->gp_seq_needed 670732
[ 3257.599549] rcu: 	cpu 15 ->gp_seq_needed 670732
[ 3257.600201] rcu: 	cpu 16 ->gp_seq_needed 670732
[ 3257.600873] rcu: nocb GP 0 Kldts .[W.] .G:670728/169040 rnp 0:8 90411 S CPU 0
[ 3257.601917] rcu:    CB 0^0->2 KblSW F32 L32 C0 ...N3. q3 S CPU 11
[ 3257.602838] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W9(670728/169040).N40. q49 S CPU 12
[ 3257.603989] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3257.604973] rcu:    CB 4^4->7 KblSW F2682434 L2682443 C119 ..... q0 S CPU 2
[ 3257.606101] rcu:    CB 5^4->4 KblSW F2647584 L2647584 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3257.607538] rcu:    CB 7^4->-1 KblSW F2663904 L2663910 C16 ..... q0 S CPU 13
[ 3257.608631] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3257.609547] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3257.610487] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3257.611441] rcu: RCU callbacks invoked since boot: 7024244
[ 3257.612260] rcu_tasks: RTGS_WAIT_CBS(11) since 3257038 g:0 i:0 k.u.. l:250 
[ 3272.945273] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6818392 ni: 121350 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3272.948960] rcu-torture: Reader Pipe:  7262048305 122018 0 0 0 0 0 0 0 0 0
[ 3272.949809] rcu-torture: Reader Batch:  7261105023 1065299 0 0 0 0 0 0 0 0 0
[ 3272.950651] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3272.952003] ??? Writer stall state RTWS_EXP_SYNC(4) g674593 f0x0 ->state D cpu 1
[ 3272.952858] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 7 ->gp_activity 3 ->gp_req_activity 7 ->gp_wake_time 10 ->gp_wake_seq 674589 ->gp_seq 674593 ->gp_seq_needed 674592 ->gp_max 453 ->gp_flags 0x0
[ 3272.955399] rcu: 	rcu_node 0:16 ->gp_seq 674593 ->gp_seq_needed 674592 ->qsmask 0x1 .... ->n_boosts 0
[ 3272.956534] rcu: 	rcu_node 0:8 ->gp_seq 674593 ->gp_seq_needed 674600 ->qsmask 0x1 .... ->n_boosts 0
[ 3272.957537] rcu: 	cpu 0 ->gp_seq_needed 674600
[ 3272.958100] rcu: 	cpu 1 ->gp_seq_needed 674600
[ 3272.958619] rcu: 	cpu 2 ->gp_seq_needed 674596
[ 3272.959104] rcu: 	cpu 8 ->gp_seq_needed 674600
[ 3272.959592] rcu: 	rcu_node 9:16 ->gp_seq 674593 ->gp_seq_needed 674600 ->qsmask 0x0 .... ->n_boosts 0
[ 3272.960817] rcu: 	cpu 9 ->gp_seq_needed 674600
[ 3272.961332] rcu: 	cpu 10 ->gp_seq_needed 674600
[ 3272.961860] rcu: 	cpu 11 ->gp_seq_needed 674600
[ 3272.962454] rcu: 	cpu 12 ->gp_seq_needed 674600
[ 3272.962954] rcu: 	cpu 13 ->gp_seq_needed 674600
[ 3272.963471] rcu: 	cpu 14 ->gp_seq_needed 674596
[ 3272.964070] rcu: 	cpu 16 ->gp_seq_needed 674600
[ 3272.964586] rcu: nocb GP 0 KldtS .[.W] .G:674596/169040 rnp 0:8 90694 S CPU 2
[ 3272.965421] rcu:    CB 0^0->2 KblSW F279 L279 C0 .W1(674596/169040)... q1 S CPU 12
[ 3272.966519] rcu:    CB 2^0->-1 KblSW F127 L127 C0 .W5(674596/169040)... q5 S CPU 14
[ 3272.967589] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3272.968488] rcu:    CB 4^4->7 KblSW F2697797 L2697806 C119 ..... q0 S CPU 2
[ 3272.969491] rcu:    CB 5^4->4 KblSW F2662948 L2662948 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3272.970741] rcu:    CB 7^4->-1 KblSW F2679267 L2679273 C16 ..... q0 S CPU 13
[ 3272.971703] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3272.972473] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3272.973359] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3272.974300] rcu: RCU callbacks invoked since boot: 7065018
[ 3272.975157] rcu_tasks: RTGS_WAIT_CBS(11) since 3272401 g:0 i:0 k.u.. l:250 
[ 3288.297466] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6845016 ni: 121827 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23025
[ 3288.301450] rcu-torture: Reader Pipe:  7290692415 122018 0 0 0 0 0 0 0 0 0
[ 3288.302362] rcu-torture: Reader Batch:  7289745504 1068929 0 0 0 0 0 0 0 0 0
[ 3288.303437] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3288.304990] ??? Writer stall state RTWS_EXP_SYNC(4) g676917 f0x0 ->state D cpu 1
[ 3288.306101] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 111 ->gp_activity 2 ->gp_req_activity 111 ->gp_wake_time 115 ->gp_wake_seq 676909 ->gp_seq 676917 ->gp_seq_needed 676916 ->gp_max 453 ->gp_flags 0x0
[ 3288.309368] rcu: 	rcu_node 0:16 ->gp_seq 676917 ->gp_seq_needed 676916 ->qsmask 0x2 .... ->n_boosts 0
[ 3288.310784] rcu: 	rcu_node 0:8 ->gp_seq 676917 ->gp_seq_needed 676924 ->qsmask 0x0 .... ->n_boosts 0
[ 3288.312135] rcu: 	cpu 0 ->gp_seq_needed 676924
[ 3288.312793] rcu: 	cpu 1 ->gp_seq_needed 676924
[ 3288.313378] rcu: 	cpu 8 ->gp_seq_needed 676924
[ 3288.313999] rcu: 	rcu_node 9:16 ->gp_seq 676917 ->gp_seq_needed 676924 ->qsmask 0x2 .... ->n_boosts 0
[ 3288.315372] rcu: 	cpu 9 ->gp_seq_needed 676920
[ 3288.316035] rcu: 	cpu 10 ->gp_seq_needed 676924
[ 3288.316752] rcu: 	cpu 11 ->gp_seq_needed 676924
[ 3288.317446] rcu: 	cpu 13 ->gp_seq_needed 676924
[ 3288.318108] rcu: 	cpu 14 ->gp_seq_needed 676920
[ 3288.318792] rcu: 	cpu 15 ->gp_seq_needed 676924
[ 3288.319506] rcu: 	cpu 16 ->gp_seq_needed 676920
[ 3288.320218] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 90796 S CPU 2
[ 3288.321230] rcu:    CB 0^0->2 KblSW F155 L155 C0 ..... q0 S CPU 12
[ 3288.322199] rcu:    CB 2^0->-1 KblSW F399 L399 C0 ..... q0 S CPU 14
[ 3288.323181] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3288.324135] rcu:    CB 4^4->7 KblSW F2713153 L2713162 C119 ..... q0 S CPU 2
[ 3288.326027] rcu:    CB 5^4->4 KblSW F2678304 L2678304 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3288.327454] rcu:    CB 7^4->-1 KblSW F2694624 L2694630 C16 ..... q0 S CPU 13
[ 3288.329323] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3288.330261] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3288.331242] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3288.335188] rcu: RCU callbacks invoked since boot: 7092293
[ 3288.336010] rcu_tasks: RTGS_WAIT_CBS(11) since 3287762 g:0 i:0 k.u.. l:250 
[ 3301.666758] rcu-torture: Enabling gpwrap lag (value=8)
[ 3303.658537] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6883582 ni: 122518 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 23283
[ 3303.661508] rcu-torture: Reader Pipe:  7331953000 122018 0 0 0 0 0 0 0 0 0
[ 3303.662248] rcu-torture: Reader Batch:  7331000822 1074196 0 0 0 0 0 0 0 0 0
[ 3303.663012] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3303.664107] ??? Writer stall state RTWS_EXP_SYNC(4) g680313 f0x0 ->state D cpu 1
[ 3303.664897] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 147 ->gp_activity 0 ->gp_req_activity 147 ->gp_wake_time 147 ->gp_wake_seq 680309 ->gp_seq 680313 ->gp_seq_needed 680312 ->gp_max 453 ->gp_flags 0x0
[ 3303.667288] rcu: 	rcu_node 0:16 ->gp_seq 680313 ->gp_seq_needed 680312 ->qsmask 0x1 .... ->n_boosts 0
[ 3303.668286] rcu: 	rcu_node 0:8 ->gp_seq 680313 ->gp_seq_needed 680320 ->qsmask 0x0 ...G ->n_boosts 0
[ 3303.669264] rcu: 	cpu 0 ->gp_seq_needed 680320
[ 3303.669747] rcu: 	cpu 1 ->gp_seq_needed 680320
[ 3303.670226] rcu: 	cpu 2 ->gp_seq_needed 680316
[ 3303.670708] rcu: 	cpu 8 ->gp_seq_needed 680320
[ 3303.671185] rcu: 	rcu_node 9:16 ->gp_seq 680313 ->gp_seq_needed 680320 ->qsmask 0x0 .... ->n_boosts 0
[ 3303.672175] rcu: 	cpu 9 ->gp_seq_needed 680320
[ 3303.672657] rcu: 	cpu 10 ->gp_seq_needed 680320
[ 3303.673153] rcu: 	cpu 11 ->gp_seq_needed 680320
[ 3303.673646] rcu: 	cpu 12 ->gp_seq_needed 680316
[ 3303.674131] rcu: 	cpu 13 ->gp_seq_needed 680320
[ 3303.674623] rcu: 	cpu 14 ->gp_seq_needed 680316
[ 3303.675111] rcu: 	cpu 15 ->gp_seq_needed 680320
[ 3303.675609] rcu: 	cpu 16 ->gp_seq_needed 680320
[ 3303.676097] rcu: nocb GP 0 Kldts .[.W] .G:680316/169040 rnp 0:8 91076 S CPU 0
[ 3303.676861] rcu:    CB 0^0->2 KblSW F165 L165 C0 ...N3. q3 S CPU 12
[ 3303.677542] rcu:    CB 2^0->-1 KblSW F199 L199 C0 .W5(680316/169040).N99. q104 S CPU 14
[ 3303.678406] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3303.679113] rcu:    CB 4^4->7 KblSW F2728508 L2728517 C119 ..... q0 S CPU 2
[ 3303.679868] rcu:    CB 5^4->4 KblSW F2693658 L2693658 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3303.680864] rcu:    CB 7^4->-1 KblSW F2709977 L2709983 C16 ..... q0 S CPU 13
[ 3303.681635] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3303.682285] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3303.682953] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3303.683658] rcu: RCU callbacks invoked since boot: 7131081
[ 3303.684253] rcu_tasks: RTGS_WAIT_CBS(11) since 3303110 g:0 i:0 k.u.. l:250 
[ 3319.022496] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6909700 ni: 122991 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 24084
[ 3319.027065] rcu-torture: Reader Pipe:  7359884715 122018 0 0 0 0 0 0 0 0 0
[ 3319.028102] rcu-torture: Reader Batch:  7358929050 1077683 0 0 0 0 0 0 0 0 0
[ 3319.032673] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3319.034082] ??? Writer stall state RTWS_EXP_SYNC(4) g682589 f0x0 ->state D cpu 1
[ 3319.035113] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 156 ->gp_activity 156 ->gp_req_activity 156 ->gp_wake_time 157 ->gp_wake_seq 682585 ->gp_seq 682589 ->gp_seq_needed 682588 ->gp_max 453 ->gp_flags 0x0
[ 3319.038133] rcu: 	rcu_node 0:16 ->gp_seq 682589 ->gp_seq_needed 682588 ->qsmask 0x2 .... ->n_boosts 0
[ 3319.039639] rcu: 	rcu_node 0:8 ->gp_seq 682589 ->gp_seq_needed 682596 ->qsmask 0x0 .... ->n_boosts 0
[ 3319.040961] rcu: 	cpu 0 ->gp_seq_needed 682596
[ 3319.041567] rcu: 	cpu 1 ->gp_seq_needed 682596
[ 3319.042167] rcu: 	cpu 2 ->gp_seq_needed 682592
[ 3319.042766] rcu: 	cpu 8 ->gp_seq_needed 682596
[ 3319.043365] rcu: 	rcu_node 9:16 ->gp_seq 682589 ->gp_seq_needed 682596 ->qsmask 0x64 .... ->n_boosts 0
[ 3319.044699] rcu: 	cpu 9 ->gp_seq_needed 682596
[ 3319.045301] rcu: 	cpu 10 ->gp_seq_needed 682596
[ 3319.045913] rcu: 	cpu 11 ->gp_seq_needed 682592
[ 3319.046529] rcu: 	cpu 12 ->gp_seq_needed 682592
[ 3319.047147] rcu: 	cpu 13 ->gp_seq_needed 682596
[ 3319.047764] rcu: 	cpu 14 ->gp_seq_needed 682596
[ 3319.048388] rcu: 	cpu 16 ->gp_seq_needed 682596
[ 3319.049000] rcu: nocb GP 0 Kldts .[W.] .G:682592/169040 rnp 0:8 91372 S CPU 0
[ 3319.049962] rcu:    CB 0^0->2 KblSW F162 L162 C0 ...N1. q1 S CPU 12
[ 3319.050809] rcu:    CB 2^0->-1 KblSW F103 L103 C0 .W5(682592/169040).N17. q22 S CPU 14
[ 3319.051939] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3319.052825] rcu:    CB 4^4->7 KblSW F2743882 L2743891 C119 ..... q0 S CPU 2
[ 3319.053769] rcu:    CB 5^4->4 KblSW F2709032 L2709032 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3319.057066] rcu:    CB 7^4->-1 KblSW F2725353 L2725359 C16 ..... q0 S CPU 13
[ 3319.058015] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3319.059191] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3319.060116] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3319.061117] rcu: RCU callbacks invoked since boot: 7158255
[ 3319.061912] rcu_tasks: RTGS_WAIT_CBS(11) since 3318488 g:0 i:0 k.u.. l:250 
[ 3334.377496] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6935676 ni: 123466 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 25008
[ 3334.380480] rcu-torture: Reader Pipe:  7388077205 122018 0 0 0 0 0 0 0 0 0
[ 3334.381232] rcu-torture: Reader Batch:  7387117612 1081611 0 0 0 0 0 0 0 0 0
[ 3334.382012] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3334.383106] ??? Writer stall state RTWS_EXP_SYNC(4) g685168 f0x0 ->state D cpu 1
[ 3334.383910] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 4567 ->gp_activity 4563 ->gp_req_activity 4567 ->gp_wake_time 4571 ->gp_wake_seq 685157 ->gp_seq 685168 ->gp_seq_needed 685168 ->gp_max 453 ->gp_flags 0x0
[ 3334.386350] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 91707 S CPU 0
[ 3334.387042] rcu:    CB 0^0->2 KblSW F4994 L4994 C0 ..... q0 S CPU 10
[ 3334.387722] rcu:    CB 2^0->-1 KblSW F4833 L4833 C0 ..... q0 S CPU 14
[ 3334.388435] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3334.389134] rcu:    CB 4^4->7 KblSW F2759218 L2759227 C119 ..... q0 S CPU 2
[ 3334.389875] rcu:    CB 5^4->4 KblSW F2724368 L2724368 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3334.390871] rcu:    CB 7^4->-1 KblSW F2740687 L2740693 C16 ..... q0 S CPU 13
[ 3334.391637] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3334.392292] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3334.392970] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3334.393639] rcu: RCU callbacks invoked since boot: 7184870
[ 3334.394228] rcu_tasks: RTGS_WAIT_CBS(11) since 3333820 g:0 i:0 k.u.. l:250 
[ 3349.738503] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6973967 ni: 124162 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 25738
[ 3349.746623] rcu-torture: Reader Pipe:  7429262599 122018 0 0 0 0 0 0 0 0 0
[ 3349.747691] rcu-torture: Reader Batch:  7428298334 1086282 0 0 0 0 0 0 0 0 0
[ 3349.752364] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3349.753915] ??? Writer stall state RTWS_EXP_SYNC(4) g688197 f0x0 ->state D cpu 1
[ 3349.755799] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 120 ->gp_activity 3 ->gp_req_activity 120 ->gp_wake_time 120 ->gp_wake_seq 688193 ->gp_seq 688197 ->gp_seq_needed 688196 ->gp_max 453 ->gp_flags 0x0
[ 3349.760637] rcu: 	rcu_node 0:16 ->gp_seq 688197 ->gp_seq_needed 688196 ->qsmask 0x1 .... ->n_boosts 0
[ 3349.764832] rcu: 	rcu_node 0:8 ->gp_seq 688197 ->gp_seq_needed 688204 ->qsmask 0x4 .... ->n_boosts 0
[ 3349.766281] rcu: 	cpu 0 ->gp_seq_needed 688204
[ 3349.766974] rcu: 	cpu 1 ->gp_seq_needed 688204
[ 3349.767661] rcu: 	cpu 2 ->gp_seq_needed 688200
[ 3349.768353] rcu: 	cpu 8 ->gp_seq_needed 688204
[ 3349.769041] rcu: 	rcu_node 9:16 ->gp_seq 688197 ->gp_seq_needed 688204 ->qsmask 0x0 .... ->n_boosts 0
[ 3349.770406] rcu: 	cpu 9 ->gp_seq_needed 688204
[ 3349.770959] rcu: 	cpu 10 ->gp_seq_needed 688204
[ 3349.771662] rcu: 	cpu 11 ->gp_seq_needed 688204
[ 3349.772343] rcu: 	cpu 12 ->gp_seq_needed 688204
[ 3349.773041] rcu: 	cpu 14 ->gp_seq_needed 688204
[ 3349.773717] rcu: 	cpu 15 ->gp_seq_needed 688200
[ 3349.774398] rcu: 	cpu 16 ->gp_seq_needed 688204
[ 3349.775406] rcu: nocb GP 0 Kldts .[W.] .G:688200/169040 rnp 0:8 92100 S CPU 0
[ 3349.776501] rcu:    CB 0^0->2 KblSW F384 L384 C0 ...N2. q2 S CPU 11
[ 3349.777422] rcu:    CB 2^0->-1 KblSW F217 L217 C0 .W7(688200/169040).N92. q99 S CPU 14
[ 3349.778688] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3349.779676] rcu:    CB 4^4->7 KblSW F2774609 L2774618 C119 ..... q0 S CPU 2
[ 3349.782185] rcu:    CB 5^4->4 KblSW F2739760 L2739760 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3349.783613] rcu:    CB 7^4->-1 KblSW F2756080 L2756086 C16 ..... q0 S CPU 13
[ 3349.784652] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3349.785633] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3349.786575] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3349.787527] rcu: RCU callbacks invoked since boot: 7222913
[ 3349.788321] rcu_tasks: RTGS_WAIT_CBS(11) since 3349214 g:0 i:0 k.u.. l:250 
[ 3365.097536] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7000782 ni: 124640 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 26427
[ 3365.104751] rcu-torture: Reader Pipe:  7457883577 122018 0 0 0 0 0 0 0 0 0
[ 3365.105798] rcu-torture: Reader Batch:  7456915607 1089988 0 0 0 0 0 0 0 0 0
[ 3365.107438] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3365.110044] ??? Writer stall state RTWS_EXP_SYNC(4) g690597 f0x0 ->state D cpu 1
[ 3365.113980] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 117 ->gp_activity 2 ->gp_req_activity 117 ->gp_wake_time 117 ->gp_wake_seq 690593 ->gp_seq 690597 ->gp_seq_needed 690596 ->gp_max 464 ->gp_flags 0x0
[ 3365.117582] rcu: 	rcu_node 0:16 ->gp_seq 690597 ->gp_seq_needed 690596 ->qsmask 0x2 .... ->n_boosts 0
[ 3365.118965] rcu: 	rcu_node 0:8 ->gp_seq 690597 ->gp_seq_needed 690604 ->qsmask 0x0 .... ->n_boosts 0
[ 3365.122899] rcu: 	cpu 0 ->gp_seq_needed 690604
[ 3365.123611] rcu: 	cpu 1 ->gp_seq_needed 690604
[ 3365.124311] rcu: 	cpu 2 ->gp_seq_needed 690604
[ 3365.125001] rcu: 	cpu 8 ->gp_seq_needed 690604
[ 3365.125675] rcu: 	rcu_node 9:16 ->gp_seq 690597 ->gp_seq_needed 690604 ->qsmask 0x4 .... ->n_boosts 0
[ 3365.127049] rcu: 	cpu 9 ->gp_seq_needed 690604
[ 3365.127696] rcu: 	cpu 10 ->gp_seq_needed 690604
[ 3365.128402] rcu: 	cpu 11 ->gp_seq_needed 690600
[ 3365.129115] rcu: 	cpu 12 ->gp_seq_needed 690604
[ 3365.129702] rcu: 	cpu 14 ->gp_seq_needed 690604
[ 3365.130345] rcu: 	cpu 15 ->gp_seq_needed 690600
[ 3365.131057] rcu: 	cpu 16 ->gp_seq_needed 690604
[ 3365.131766] rcu: nocb GP 0 Kldts .[W.] .G:690600/169040 rnp 0:8 92412 S CPU 0
[ 3365.132875] rcu:    CB 0^0->2 KblSW F206 L206 C0 ...N1. q1 S CPU 13
[ 3365.133810] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W130(690600/169040).N163. q293 S CPU 14
[ 3365.135006] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3365.136021] rcu:    CB 4^4->7 KblSW F2789965 L2789974 C119 ..... q0 S CPU 2
[ 3365.137103] rcu:    CB 5^4->4 KblSW F2755115 L2755115 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3365.138471] rcu:    CB 7^4->-1 KblSW F2771433 L2771439 C16 ..... q0 S CPU 13
[ 3365.139590] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3365.140497] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3365.141278] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3365.142259] rcu: RCU callbacks invoked since boot: 7249477
[ 3365.143091] rcu_tasks: RTGS_WAIT_CBS(11) since 3364569 g:0 i:0 k.u.. l:250 
[ 3380.458478] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7039322 ni: 125325 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 27059
[ 3380.462752] rcu-torture: Reader Pipe:  7497897938 122018 0 0 0 0 0 0 0 0 0
[ 3380.463677] rcu-torture: Reader Batch:  7496925996 1093960 0 0 0 0 0 0 0 0 0
[ 3380.464621] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3380.469269] ??? Writer stall state RTWS_EXP_SYNC(4) g693189 f0x0 ->state D cpu 1
[ 3380.470300] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 100 ->gp_activity 0 ->gp_req_activity 100 ->gp_wake_time 100 ->gp_wake_seq 693185 ->gp_seq 693189 ->gp_seq_needed 693192 ->gp_max 464 ->gp_flags 0x0
[ 3380.477605] rcu: 	rcu_node 0:16 ->gp_seq 693189 ->gp_seq_needed 693192 ->qsmask 0x2 .... ->n_boosts 0
[ 3380.478968] rcu: 	rcu_node 0:8 ->gp_seq 693189 ->gp_seq_needed 693196 ->qsmask 0x0 .... ->n_boosts 0
[ 3380.480175] rcu: 	cpu 0 ->gp_seq_needed 693196
[ 3380.480768] rcu: 	cpu 1 ->gp_seq_needed 693196
[ 3380.481362] rcu: 	cpu 2 ->gp_seq_needed 693196
[ 3380.481961] rcu: 	cpu 8 ->gp_seq_needed 693196
[ 3380.482549] rcu: 	rcu_node 9:16 ->gp_seq 693189 ->gp_seq_needed 693196 ->qsmask 0x0 ...G ->n_boosts 0
[ 3380.483760] rcu: 	cpu 9 ->gp_seq_needed 693196
[ 3380.484353] rcu: 	cpu 10 ->gp_seq_needed 693196
[ 3380.485239] rcu: 	cpu 11 ->gp_seq_needed 693196
[ 3380.485859] rcu: 	cpu 12 ->gp_seq_needed 693196
[ 3380.486471] rcu: 	cpu 13 ->gp_seq_needed 693196
[ 3380.487081] rcu: 	cpu 14 ->gp_seq_needed 693192
[ 3380.487686] rcu: 	cpu 15 ->gp_seq_needed 693196
[ 3380.488296] rcu: 	cpu 16 ->gp_seq_needed 693192
[ 3380.488921] rcu: nocb GP 0 KldtS .[W.] .G:693192/169040 rnp 0:8 92748 S CPU 0
[ 3380.489898] rcu:    CB 0^0->2 KblSW F1014 L1014 C0 ..... q0 S CPU 13
[ 3380.490746] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W4(693192/169040).N180. q184 S CPU 14
[ 3380.491792] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3380.492669] rcu:    CB 4^4->7 KblSW F2805322 L2805331 C119 ..... q0 S CPU 2
[ 3380.493613] rcu:    CB 5^4->4 KblSW F2770472 L2770472 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3380.494876] rcu:    CB 7^4->-1 KblSW F2786791 L2786797 C16 ..... q0 S CPU 13
[ 3380.495833] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3380.496688] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3380.497825] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3380.498671] rcu: RCU callbacks invoked since boot: 7289396
[ 3380.499411] rcu_tasks: RTGS_WAIT_CBS(11) since 3379925 g:0 i:0 k.u.. l:250 
[ 3395.818496] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7065763 ni: 125797 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 27910
[ 3395.823297] rcu-torture: Reader Pipe:  7526450310 122018 0 0 0 0 0 0 0 0 0
[ 3395.824379] rcu-torture: Reader Batch:  7525473995 1098333 0 0 0 0 0 0 0 0 0
[ 3395.825477] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3395.827074] ??? Writer stall state RTWS_EXP_SYNC(4) g696065 f0x0 ->state D cpu 1
[ 3395.828198] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 179 ->gp_activity 3 ->gp_req_activity 179 ->gp_wake_time 194 ->gp_wake_seq 696061 ->gp_seq 696065 ->gp_seq_needed 696068 ->gp_max 464 ->gp_flags 0x0
[ 3395.831471] rcu: 	rcu_node 0:16 ->gp_seq 696065 ->gp_seq_needed 696068 ->qsmask 0x2 .... ->n_boosts 0
[ 3395.832875] rcu: 	rcu_node 0:8 ->gp_seq 696065 ->gp_seq_needed 696072 ->qsmask 0x0 .... ->n_boosts 0
[ 3395.834287] rcu: 	cpu 0 ->gp_seq_needed 696072
[ 3395.834991] rcu: 	cpu 1 ->gp_seq_needed 696072
[ 3395.835690] rcu: 	cpu 2 ->gp_seq_needed 696072
[ 3395.836355] rcu: 	cpu 8 ->gp_seq_needed 696072
[ 3395.837020] rcu: 	rcu_node 9:16 ->gp_seq 696065 ->gp_seq_needed 696072 ->qsmask 0x2 .... ->n_boosts 0
[ 3395.838524] rcu: 	cpu 9 ->gp_seq_needed 696072
[ 3395.839198] rcu: 	cpu 10 ->gp_seq_needed 696068
[ 3395.839911] rcu: 	cpu 11 ->gp_seq_needed 696072
[ 3395.840620] rcu: 	cpu 12 ->gp_seq_needed 696072
[ 3395.841308] rcu: 	cpu 14 ->gp_seq_needed 696072
[ 3395.841845] rcu: 	cpu 15 ->gp_seq_needed 696072
[ 3395.842598] rcu: 	cpu 16 ->gp_seq_needed 696068
[ 3395.843306] rcu: nocb GP 0 KldtS .[.W] .G:696068/169040 rnp 0:8 93122 S CPU 0
[ 3395.844413] rcu:    CB 0^0->2 KblSW F437 L437 C0 ..... q0 S CPU 13
[ 3395.845369] rcu:    CB 2^0->-1 KblSW F7 L7 C0 .W12(696068/169040).N32. q44 S CPU 14
[ 3395.846534] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3395.847526] rcu:    CB 4^4->7 KblSW F2820677 L2820686 C119 ..... q0 S CPU 2
[ 3395.848581] rcu:    CB 5^4->4 KblSW F2785827 L2785827 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3395.849968] rcu:    CB 7^4->-1 KblSW F2802146 L2802152 C16 ..... q0 S CPU 13
[ 3395.851014] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3395.851940] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3395.852783] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3395.853652] rcu: RCU callbacks invoked since boot: 7316822
[ 3395.854487] rcu_tasks: RTGS_WAIT_CBS(11) since 3395281 g:0 i:0 k.u.. l:250 
[ 3411.177523] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7096248 ni: 126341 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 28878
[ 3411.180502] rcu-torture: Reader Pipe:  7559628975 122018 0 0 0 0 0 0 0 0 0
[ 3411.181251] rcu-torture: Reader Batch:  7558647388 1103605 0 0 0 0 0 0 0 0 0
[ 3411.182041] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3411.183144] ??? Writer stall state RTWS_EXP_SYNC(4) g699416 f0x0 ->state D cpu 1
[ 3411.183953] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 3573 ->gp_activity 3568 ->gp_req_activity 3573 ->gp_wake_time 3585 ->gp_wake_seq 699409 ->gp_seq 699416 ->gp_seq_needed 699416 ->gp_max 464 ->gp_flags 0x0
[ 3411.186414] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 93557 S CPU 0
[ 3411.187127] rcu:    CB 0^0->2 KblSW F3743 L3743 C0 ..... q0 S CPU 13
[ 3411.187826] rcu:    CB 2^0->-1 KblSW F3635 L3635 C0 ..... q0 S CPU 14
[ 3411.188523] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3411.189233] rcu:    CB 4^4->7 KblSW F2836018 L2836027 C119 ..... q0 S CPU 2
[ 3411.189994] rcu:    CB 5^4->4 KblSW F2801168 L2801168 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3411.191017] rcu:    CB 7^4->-1 KblSW F2817487 L2817493 C16 ..... q0 S CPU 13
[ 3411.192080] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3411.193034] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3411.194050] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3411.195032] rcu: RCU callbacks invoked since boot: 7348317
[ 3411.195865] rcu_tasks: RTGS_WAIT_CBS(11) since 3410622 g:0 i:0 k.u.. l:250 
[ 3426.537463] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7132771 ni: 126992 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 29817
[ 3426.542700] rcu-torture: Reader Pipe:  7598862852 122018 0 0 0 0 0 0 0 0 0
[ 3426.546009] rcu-torture: Reader Batch:  7597875669 1109201 0 0 0 0 0 0 0 0 0
[ 3426.546977] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3426.551154] ??? Writer stall state RTWS_EXP_SYNC(4) g703001 f0x0 ->state D cpu 1
[ 3426.552097] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 5 ->gp_activity 5 ->gp_req_activity 5 ->gp_wake_time 10 ->gp_wake_seq 702997 ->gp_seq 703001 ->gp_seq_needed 703000 ->gp_max 464 ->gp_flags 0x0
[ 3426.556229] rcu: 	rcu_node 0:16 ->gp_seq 703001 ->gp_seq_needed 703000 ->qsmask 0x3 .... ->n_boosts 0
[ 3426.560240] rcu: 	rcu_node 0:8 ->gp_seq 703001 ->gp_seq_needed 703008 ->qsmask 0x1 .... ->n_boosts 0
[ 3426.561405] rcu: 	cpu 0 ->gp_seq_needed 703004
[ 3426.561989] rcu: 	cpu 1 ->gp_seq_needed 703008
[ 3426.562559] rcu: 	cpu 2 ->gp_seq_needed 703004
[ 3426.565984] rcu: 	cpu 8 ->gp_seq_needed 703008
[ 3426.566557] rcu: 	rcu_node 9:16 ->gp_seq 703001 ->gp_seq_needed 703008 ->qsmask 0x8 .... ->n_boosts 0
[ 3426.567739] rcu: 	cpu 10 ->gp_seq_needed 703008
[ 3426.568312] rcu: 	cpu 11 ->gp_seq_needed 703008
[ 3426.570418] rcu: 	cpu 12 ->gp_seq_needed 703008
[ 3426.571008] rcu: 	cpu 14 ->gp_seq_needed 703008
[ 3426.571588] rcu: 	cpu 15 ->gp_seq_needed 703008
[ 3426.572168] rcu: 	cpu 16 ->gp_seq_needed 703004
[ 3426.574765] rcu: nocb GP 0 KldtS .[.W] .G:703004/169040 rnp 0:8 94022 S CPU 0
[ 3426.577876] rcu:    CB 0^0->2 KblSW F578 L578 C0 ..... q0 S CPU 13
[ 3426.578672] rcu:    CB 2^0->-1 KblSW F2 L2 C0 .W6(703004/169040).N16. q22 S CPU 8
[ 3426.579612] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3426.582849] rcu:    CB 4^4->7 KblSW F2851412 L2851421 C119 ..... q0 S CPU 2
[ 3426.583745] rcu:    CB 5^4->4 KblSW F2816562 L2816562 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3426.588399] rcu:    CB 7^4->-1 KblSW F2832884 L2832890 C16 ..... q0 S CPU 13
[ 3426.589305] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3426.590086] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3426.590888] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3426.593905] rcu: RCU callbacks invoked since boot: 7385462
[ 3426.594610] rcu_tasks: RTGS_WAIT_CBS(11) since 3426021 g:0 i:0 k.u.. l:250 
[ 3441.897497] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7159476 ni: 127470 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 30537
[ 3441.905870] rcu-torture: Reader Pipe:  7627447862 122018 0 0 0 0 0 0 0 0 0
[ 3441.909838] rcu-torture: Reader Batch:  7626456760 1113120 0 0 0 0 0 0 0 0 0
[ 3441.910941] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3441.912933] ??? Writer stall state RTWS_EXP_SYNC(4) g705529 f0x0 ->state D cpu 1
[ 3441.913855] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 166 ->gp_activity 3 ->gp_req_activity 166 ->gp_wake_time 166 ->gp_wake_seq 705525 ->gp_seq 705529 ->gp_seq_needed 705528 ->gp_max 464 ->gp_flags 0x0
[ 3441.918463] rcu: 	rcu_node 0:16 ->gp_seq 705529 ->gp_seq_needed 705528 ->qsmask 0x1 .... ->n_boosts 0
[ 3441.919905] rcu: 	rcu_node 0:8 ->gp_seq 705529 ->gp_seq_needed 705536 ->qsmask 0x4 .... ->n_boosts 0
[ 3441.921249] rcu: 	cpu 0 ->gp_seq_needed 705536
[ 3441.921919] rcu: 	cpu 1 ->gp_seq_needed 705536
[ 3441.922622] rcu: 	cpu 2 ->gp_seq_needed 705536
[ 3441.923278] rcu: 	cpu 8 ->gp_seq_needed 705536
[ 3441.923947] rcu: 	rcu_node 9:16 ->gp_seq 705529 ->gp_seq_needed 705536 ->qsmask 0x0 .... ->n_boosts 0
[ 3441.925670] rcu: 	cpu 9 ->gp_seq_needed 705536
[ 3441.926296] rcu: 	cpu 10 ->gp_seq_needed 705536
[ 3441.927008] rcu: 	cpu 11 ->gp_seq_needed 705536
[ 3441.927645] rcu: 	cpu 12 ->gp_seq_needed 705536
[ 3441.928329] rcu: 	cpu 14 ->gp_seq_needed 705536
[ 3441.928979] rcu: 	cpu 15 ->gp_seq_needed 705536
[ 3441.929693] rcu: 	cpu 16 ->gp_seq_needed 705532
[ 3441.930393] rcu: nocb GP 0 Kldts .[W.] .G:705536/169040 rnp 0:8 94351 S CPU 9
[ 3441.931475] rcu:    CB 0^0->2 KblSW F77 L77 C0 ...N1. q1 S CPU 13
[ 3441.932361] rcu:    CB 2^0->-1 KblSW F179 L179 C0 .W6(705536/169040).N2. q8 S CPU 8
[ 3441.933494] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3441.934441] rcu:    CB 4^4->7 KblSW F2866764 L2866773 C119 ..... q0 S CPU 2
[ 3441.935389] rcu:    CB 5^4->4 KblSW F2831913 L2831913 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3441.936521] rcu:    CB 7^4->-1 KblSW F2848233 L2848239 C16 ..... q0 S CPU 13
[ 3441.937486] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3441.938190] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3441.938957] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3441.939697] rcu: RCU callbacks invoked since boot: 7412284
[ 3441.940414] rcu_tasks: RTGS_WAIT_CBS(11) since 3441366 g:0 i:0 k.u.. l:250 
[ 3457.258481] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7199067 ni: 128174 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 31873
[ 3457.265673] rcu-torture: Reader Pipe:  7669923963 122018 0 0 0 0 0 0 0 0 0
[ 3457.266853] rcu-torture: Reader Batch:  7668926996 1118985 0 0 0 0 0 0 0 0 0
[ 3457.267965] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3457.269488] ??? Writer stall state RTWS_EXP_SYNC(4) g709385 f0x0 ->state D cpu 1
[ 3457.270644] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 8 ->gp_activity 0 ->gp_req_activity 8 ->gp_wake_time 17 ->gp_wake_seq 709377 ->gp_seq 709385 ->gp_seq_needed 709384 ->gp_max 464 ->gp_flags 0x0
[ 3457.273571] rcu: 	rcu_node 0:16 ->gp_seq 709385 ->gp_seq_needed 709384 ->qsmask 0x1 .... ->n_boosts 0
[ 3457.274962] rcu: 	rcu_node 0:8 ->gp_seq 709385 ->gp_seq_needed 709392 ->qsmask 0x1 .... ->n_boosts 0
[ 3457.276322] rcu: 	cpu 0 ->gp_seq_needed 709392
[ 3457.277011] rcu: 	cpu 1 ->gp_seq_needed 709388
[ 3457.277697] rcu: 	cpu 2 ->gp_seq_needed 709388
[ 3457.278368] rcu: 	rcu_node 9:16 ->gp_seq 709385 ->gp_seq_needed 709392 ->qsmask 0x0 .... ->n_boosts 0
[ 3457.279757] rcu: 	cpu 9 ->gp_seq_needed 709392
[ 3457.280417] rcu: 	cpu 10 ->gp_seq_needed 709392
[ 3457.281130] rcu: 	cpu 11 ->gp_seq_needed 709392
[ 3457.281828] rcu: 	cpu 12 ->gp_seq_needed 709392
[ 3457.282530] rcu: 	cpu 14 ->gp_seq_needed 709392
[ 3457.283216] rcu: 	cpu 15 ->gp_seq_needed 709392
[ 3457.283786] rcu: 	cpu 16 ->gp_seq_needed 709392
[ 3457.284410] rcu: nocb GP 0 KldtS .[W.] .G:709392/169040 rnp 0:8 94495 S CPU 9
[ 3457.285503] rcu:    CB 0^0->2 KblSW F19 L19 C0 .W1(709392/169040)... q1 S CPU 13
[ 3457.286623] rcu:    CB 2^0->-1 KblSW F134 L134 C0 ..... q0 S CPU 8
[ 3457.287577] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3457.288559] rcu:    CB 4^4->7 KblSW F2882118 L2882127 C119 ..... q0 S CPU 2
[ 3457.289643] rcu:    CB 5^4->4 KblSW F2847268 L2847268 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3457.291031] rcu:    CB 7^4->-1 KblSW F2863587 L2863593 C16 ..... q0 S CPU 13
[ 3457.292095] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3457.292962] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3457.293914] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3457.294789] rcu: RCU callbacks invoked since boot: 7452945
[ 3457.295573] rcu_tasks: RTGS_WAIT_CBS(11) since 3456722 g:0 i:0 k.u.. l:250 
[ 3472.617483] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7225823 ni: 128653 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 32883
[ 3472.621682] rcu-torture: Reader Pipe:  7698945174 122018 0 0 0 0 0 0 0 0 0
[ 3472.622736] rcu-torture: Reader Batch:  7697944262 1122930 0 0 0 0 0 0 0 0 0
[ 3472.623850] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3472.625374] ??? Writer stall state RTWS_EXP_SYNC(4) g711965 f0x0 ->state D cpu 1
[ 3472.626490] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 11 ->gp_activity 3 ->gp_req_activity 11 ->gp_wake_time 11 ->gp_wake_seq 711961 ->gp_seq 711965 ->gp_seq_needed 711964 ->gp_max 464 ->gp_flags 0x0
[ 3472.629836] rcu: 	rcu_node 0:16 ->gp_seq 711965 ->gp_seq_needed 711964 ->qsmask 0x1 .... ->n_boosts 0
[ 3472.631256] rcu: 	rcu_node 0:8 ->gp_seq 711965 ->gp_seq_needed 711972 ->qsmask 0x1 .... ->n_boosts 0
[ 3472.632627] rcu: 	cpu 0 ->gp_seq_needed 711972
[ 3472.633292] rcu: 	cpu 1 ->gp_seq_needed 711972
[ 3472.633993] rcu: 	cpu 2 ->gp_seq_needed 711968
[ 3472.634645] rcu: 	cpu 8 ->gp_seq_needed 711972
[ 3472.635202] rcu: 	rcu_node 9:16 ->gp_seq 711965 ->gp_seq_needed 711972 ->qsmask 0x0 .... ->n_boosts 0
[ 3472.636616] rcu: 	cpu 9 ->gp_seq_needed 711972
[ 3472.637293] rcu: 	cpu 10 ->gp_seq_needed 711972
[ 3472.637997] rcu: 	cpu 11 ->gp_seq_needed 711972
[ 3472.638651] rcu: 	cpu 12 ->gp_seq_needed 711972
[ 3472.639305] rcu: 	cpu 14 ->gp_seq_needed 711972
[ 3472.639978] rcu: 	cpu 15 ->gp_seq_needed 711972
[ 3472.640687] rcu: 	cpu 16 ->gp_seq_needed 711972
[ 3472.641347] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 94577 S CPU 9
[ 3472.642341] rcu:    CB 0^0->2 KblSW F1013 L1013 C0 ..... q0 S CPU 13
[ 3472.643290] rcu:    CB 2^0->-1 KblSW F378 L378 C0 ..... q0 S CPU 8
[ 3472.644199] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3472.645205] rcu:    CB 4^4->7 KblSW F2897474 L2897483 C119 ..... q0 S CPU 2
[ 3472.646097] rcu:    CB 5^4->4 KblSW F2862624 L2862624 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3472.647444] rcu:    CB 7^4->-1 KblSW F2878944 L2878950 C16 ..... q0 S CPU 13
[ 3472.648515] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3472.649397] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3472.650352] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3472.651322] rcu: RCU callbacks invoked since boot: 7480149
[ 3472.652142] rcu_tasks: RTGS_WAIT_CBS(11) since 3472078 g:0 i:0 k.u.. l:250 
[ 3487.977502] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7259267 ni: 129245 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 33819
[ 3487.980536] rcu-torture: Reader Pipe:  7734313423 122018 0 0 0 0 0 0 0 0 0
[ 3487.981283] rcu-torture: Reader Batch:  7733307587 1127854 0 0 0 0 0 0 0 0 0
[ 3487.982057] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3487.983145] ??? Writer stall state RTWS_EXP_SYNC(4) g715164 f0x0 ->state D cpu 1
[ 3487.983951] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 2281 ->gp_activity 2276 ->gp_req_activity 2281 ->gp_wake_time 2291 ->gp_wake_seq 715153 ->gp_seq 715164 ->gp_seq_needed 715164 ->gp_max 464 ->gp_flags 0x0
[ 3487.986387] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 94830 S CPU 9
[ 3487.987088] rcu:    CB 0^0->2 KblSW F2653 L2653 C0 ..... q0 S CPU 13
[ 3487.987781] rcu:    CB 2^0->-1 KblSW F2439 L2439 C0 ..... q0 S CPU 8
[ 3487.988479] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3487.989180] rcu:    CB 4^4->7 KblSW F2912818 L2912827 C119 ..... q0 S CPU 2
[ 3487.989935] rcu:    CB 5^4->4 KblSW F2877968 L2877968 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3487.990941] rcu:    CB 7^4->-1 KblSW F2894287 L2894293 C16 ..... q0 S CPU 13
[ 3487.991707] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3487.992362] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3487.993045] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3487.993728] rcu: RCU callbacks invoked since boot: 7514240
[ 3487.994319] rcu_tasks: RTGS_WAIT_CBS(11) since 3487420 g:0 i:0 k.u.. l:250 
[ 3503.338539] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7292067 ni: 129835 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 34558
[ 3503.346532] rcu-torture: Reader Pipe:  7769513727 122018 0 0 0 0 0 0 0 0 0
[ 3503.349298] rcu-torture: Reader Batch:  7768503207 1132538 0 0 0 0 0 0 0 0 0
[ 3503.350382] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3503.351891] ??? Writer stall state RTWS_EXP_SYNC(4) g718129 f0x0 ->state D cpu 1
[ 3503.352992] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 2 ->gp_activity 2 ->gp_req_activity 2 ->gp_wake_time 2 ->gp_wake_seq 718125 ->gp_seq 718129 ->gp_seq_needed 718128 ->gp_max 464 ->gp_flags 0x0
[ 3503.356032] rcu: 	rcu_node 0:16 ->gp_seq 718129 ->gp_seq_needed 718128 ->qsmask 0x1 .... ->n_boosts 0
[ 3503.357464] rcu: 	rcu_node 0:8 ->gp_seq 718129 ->gp_seq_needed 718132 ->qsmask 0x1 .... ->n_boosts 0
[ 3503.358838] rcu: 	cpu 0 ->gp_seq_needed 718132
[ 3503.359539] rcu: 	cpu 1 ->gp_seq_needed 718132
[ 3503.360222] rcu: 	cpu 2 ->gp_seq_needed 718132
[ 3503.360917] rcu: 	cpu 8 ->gp_seq_needed 718132
[ 3503.361584] rcu: 	rcu_node 9:16 ->gp_seq 718129 ->gp_seq_needed 718136 ->qsmask 0x0 .... ->n_boosts 0
[ 3503.362943] rcu: 	cpu 9 ->gp_seq_needed 718132
[ 3503.363633] rcu: 	cpu 10 ->gp_seq_needed 718136
[ 3503.364291] rcu: 	cpu 11 ->gp_seq_needed 718136
[ 3503.364848] rcu: 	cpu 12 ->gp_seq_needed 718136
[ 3503.365546] rcu: 	cpu 14 ->gp_seq_needed 718136
[ 3503.366213] rcu: 	cpu 15 ->gp_seq_needed 718136
[ 3503.366886] rcu: 	cpu 16 ->gp_seq_needed 718136
[ 3503.367593] rcu: nocb GP 0 KldtS .[.W] .G:718132/169040 rnp 0:8 95215 S CPU 9
[ 3503.368695] rcu:    CB 0^0->2 KblSW F22 L22 C0 .W1(718132/169040).N1. q2 S CPU 13
[ 3503.369848] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W10(718132/169040).N11. q21 S CPU 8
[ 3503.370973] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3503.371967] rcu:    CB 4^4->7 KblSW F2928201 L2928210 C119 ..... q0 S CPU 2
[ 3503.373196] rcu:    CB 5^4->4 KblSW F2893351 L2893351 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3503.374771] rcu:    CB 7^4->-1 KblSW F2909671 L2909677 C16 ..... q0 S CPU 13
[ 3503.375775] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3503.376609] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3503.377526] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3503.378443] rcu: RCU callbacks invoked since boot: 7547598
[ 3503.379260] rcu_tasks: RTGS_WAIT_CBS(11) since 3502805 g:0 i:0 k.u.. l:250 
[ 3518.698328] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7318444 ni: 130309 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 35090
[ 3518.706250] rcu-torture: Reader Pipe:  7797964087 122018 0 0 0 0 0 0 0 0 0
[ 3518.707323] rcu-torture: Reader Batch:  7796950212 1135892 0 0 0 0 0 0 0 0 0
[ 3518.709189] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3518.710757] ??? Writer stall state RTWS_EXP_SYNC(4) g720281 f0x0 ->state D cpu 1
[ 3518.713225] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 11 ->gp_activity 0 ->gp_req_activity 11 ->gp_wake_time 11 ->gp_wake_seq 720277 ->gp_seq 720281 ->gp_seq_needed 720280 ->gp_max 464 ->gp_flags 0x0
[ 3518.716420] rcu: 	rcu_node 0:16 ->gp_seq 720281 ->gp_seq_needed 720280 ->qsmask 0x1 .... ->n_boosts 0
[ 3518.717822] rcu: 	rcu_node 0:8 ->gp_seq 720281 ->gp_seq_needed 720284 ->qsmask 0x1 .... ->n_boosts 0
[ 3518.719875] rcu: 	cpu 0 ->gp_seq_needed 720284
[ 3518.720617] rcu: 	cpu 2 ->gp_seq_needed 720284
[ 3518.721307] rcu: 	cpu 8 ->gp_seq_needed 720284
[ 3518.722027] rcu: 	rcu_node 9:16 ->gp_seq 720281 ->gp_seq_needed 720288 ->qsmask 0x0 .... ->n_boosts 0
[ 3518.723460] rcu: 	cpu 9 ->gp_seq_needed 720284
[ 3518.724142] rcu: 	cpu 10 ->gp_seq_needed 720288
[ 3518.724888] rcu: 	cpu 11 ->gp_seq_needed 720288
[ 3518.725666] rcu: 	cpu 12 ->gp_seq_needed 720288
[ 3518.726425] rcu: 	cpu 13 ->gp_seq_needed 720288
[ 3518.727044] rcu: 	cpu 14 ->gp_seq_needed 720288
[ 3518.727681] rcu: 	cpu 15 ->gp_seq_needed 720288
[ 3518.728413] rcu: 	cpu 16 ->gp_seq_needed 720288
[ 3518.729088] rcu: nocb GP 0 KldtS .[.W] .G:720292/169040 rnp 0:8 95495 S CPU 9
[ 3518.730164] rcu:    CB 0^0->2 KblSW F228 L228 C0 ..... q0 S CPU 13
[ 3518.731827] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W13(720292/169040).N1. q14 S CPU 8
[ 3518.732975] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3518.734031] rcu:    CB 4^4->7 KblSW F2943563 L2943572 C119 ..... q0 S CPU 2
[ 3518.735323] rcu:    CB 5^4->4 KblSW F2908713 L2908713 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3518.736773] rcu:    CB 7^4->-1 KblSW F2925033 L2925039 C16 ..... q0 S CPU 13
[ 3518.737881] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3518.738771] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3518.739787] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3518.740973] rcu: RCU callbacks invoked since boot: 7574480
[ 3518.741873] rcu_tasks: RTGS_WAIT_CBS(11) since 3518168 g:0 i:0 k.u.. l:250 
[ 3534.058459] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7357588 ni: 131004 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 36334
[ 3534.062128] rcu-torture: Reader Pipe:  7840493748 122018 0 0 0 0 0 0 0 0 0
[ 3534.063060] rcu-torture: Reader Batch:  7839473783 1141983 0 0 0 0 0 0 0 0 0
[ 3534.064120] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3534.065526] ??? Writer stall state RTWS_EXP_SYNC(4) g724133 f0x0 ->state D cpu 1
[ 3534.066513] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 245 ->gp_activity 5 ->gp_req_activity 245 ->gp_wake_time 245 ->gp_wake_seq 724129 ->gp_seq 724133 ->gp_seq_needed 724132 ->gp_max 464 ->gp_flags 0x0
[ 3534.069488] rcu: 	rcu_node 0:16 ->gp_seq 724133 ->gp_seq_needed 724132 ->qsmask 0x1 .... ->n_boosts 0
[ 3534.070714] rcu: 	rcu_node 0:8 ->gp_seq 724133 ->gp_seq_needed 724140 ->qsmask 0x4 .... ->n_boosts 0
[ 3534.071930] rcu: 	cpu 0 ->gp_seq_needed 724140
[ 3534.072537] rcu: 	cpu 1 ->gp_seq_needed 724140
[ 3534.073131] rcu: 	cpu 2 ->gp_seq_needed 724136
[ 3534.073736] rcu: 	cpu 8 ->gp_seq_needed 724140
[ 3534.074334] rcu: 	rcu_node 9:16 ->gp_seq 724133 ->gp_seq_needed 724140 ->qsmask 0x0 .... ->n_boosts 0
[ 3534.075563] rcu: 	cpu 9 ->gp_seq_needed 724136
[ 3534.076154] rcu: 	cpu 11 ->gp_seq_needed 724140
[ 3534.076771] rcu: 	cpu 12 ->gp_seq_needed 724140
[ 3534.077379] rcu: 	cpu 13 ->gp_seq_needed 724136
[ 3534.077988] rcu: 	cpu 14 ->gp_seq_needed 724140
[ 3534.078607] rcu: 	cpu 15 ->gp_seq_needed 724140
[ 3534.079212] rcu: 	cpu 16 ->gp_seq_needed 724140
[ 3534.079870] rcu: nocb GP 0 KldtS .[W.] .G:724136/169040 rnp 0:8 95993 S CPU 8
[ 3534.080872] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W8(724136/169040).N98. q106 S CPU 13
[ 3534.081922] rcu:    CB 2^0->-1 KblSW F84 L84 C0 .W8(724136/169040).N4. q12 S CPU 9
[ 3534.083057] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3534.083959] rcu:    CB 4^4->7 KblSW F2958913 L2958922 C119 ..... q0 S CPU 2
[ 3534.084938] rcu:    CB 5^4->4 KblSW F2924063 L2924063 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3534.086207] rcu:    CB 7^4->-1 KblSW F2940382 L2940388 C16 ..... q0 S CPU 13
[ 3534.087177] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3534.088022] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3534.088883] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3534.089742] rcu: RCU callbacks invoked since boot: 7613676
[ 3534.090498] rcu_tasks: RTGS_WAIT_CBS(11) since 3533517 g:0 i:0 k.u.. l:250 
[ 3549.421477] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7384535 ni: 131489 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 36824
[ 3549.429032] rcu-torture: Reader Pipe:  7869493391 122018 0 0 0 0 0 0 0 0 0
[ 3549.430118] rcu-torture: Reader Batch:  7868469465 1145944 0 0 0 0 0 0 0 0 0
[ 3549.431111] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3549.435383] ??? Writer stall state RTWS_EXP_SYNC(4) g726685 f0x0 ->state D cpu 1
[ 3549.436487] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 8 ->gp_activity 2 ->gp_req_activity 8 ->gp_wake_time 19 ->gp_wake_seq 726677 ->gp_seq 726685 ->gp_seq_needed 726684 ->gp_max 464 ->gp_flags 0x0
[ 3549.439759] rcu: 	rcu_node 0:16 ->gp_seq 726685 ->gp_seq_needed 726684 ->qsmask 0x2 .... ->n_boosts 0
[ 3549.441181] rcu: 	rcu_node 0:8 ->gp_seq 726685 ->gp_seq_needed 726692 ->qsmask 0x0 .... ->n_boosts 0
[ 3549.442610] rcu: 	cpu 0 ->gp_seq_needed 726692
[ 3549.443272] rcu: 	cpu 1 ->gp_seq_needed 726688
[ 3549.443930] rcu: 	cpu 2 ->gp_seq_needed 726692
[ 3549.444632] rcu: 	cpu 8 ->gp_seq_needed 726692
[ 3549.445327] rcu: 	rcu_node 9:16 ->gp_seq 726685 ->gp_seq_needed 726692 ->qsmask 0x2 .... ->n_boosts 0
[ 3549.446717] rcu: 	cpu 9 ->gp_seq_needed 726688
[ 3549.447407] rcu: 	cpu 10 ->gp_seq_needed 726692
[ 3549.448080] rcu: 	cpu 11 ->gp_seq_needed 726692
[ 3549.448773] rcu: 	cpu 12 ->gp_seq_needed 726688
[ 3549.449451] rcu: 	cpu 13 ->gp_seq_needed 726692
[ 3549.450119] rcu: 	cpu 14 ->gp_seq_needed 726692
[ 3549.450748] rcu: 	cpu 16 ->gp_seq_needed 726692
[ 3549.451659] rcu: nocb GP 0 KldtS .[W.] .G:726688/169040 rnp 0:8 96325 S CPU 9
[ 3549.452631] rcu:    CB 0^0->2 KblSW F2 L2 C0 .W7(726688/169040).N12. q19 S CPU 1
[ 3549.453712] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W6(726688/169040).N15. q21 S CPU 12
[ 3549.454836] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3549.455806] rcu:    CB 4^4->7 KblSW F2974285 L2974294 C119 ..... q0 S CPU 2
[ 3549.456873] rcu:    CB 5^4->4 KblSW F2939435 L2939435 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3549.458240] rcu:    CB 7^4->-1 KblSW F2955754 L2955760 C16 ..... q0 S CPU 13
[ 3549.459252] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3549.460137] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3549.461086] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3549.462007] rcu: RCU callbacks invoked since boot: 7641733
[ 3549.462869] rcu_tasks: RTGS_WAIT_CBS(11) since 3548889 g:0 i:0 k.u.. l:250 
[ 3564.777512] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7421140 ni: 132133 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 37739
[ 3564.780614] rcu-torture: Reader Pipe:  7908155512 122018 0 0 0 0 0 0 0 0 0
[ 3564.781394] rcu-torture: Reader Batch:  7907126483 1151047 0 0 0 0 0 0 0 0 0
[ 3564.782178] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3564.783293] ??? Writer stall state RTWS_EXP_SYNC(4) g729980 f0x0 ->state D cpu 1
[ 3564.784108] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 1092 ->gp_activity 977 ->gp_req_activity 1092 ->gp_wake_time 977 ->gp_wake_seq 729977 ->gp_seq 729980 ->gp_seq_needed 729980 ->gp_max 464 ->gp_flags 0x0
[ 3564.786612] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 96753 S CPU 10
[ 3564.787335] rcu:    CB 0^0->2 KblSW F1794 L1794 C0 ..... q0 S CPU 1
[ 3564.788025] rcu:    CB 2^0->-1 KblSW F1109 L1109 C0 ..... q0 S CPU 12
[ 3564.788743] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3564.789462] rcu:    CB 4^4->7 KblSW F2989619 L2989628 C119 ..... q0 S CPU 2
[ 3564.790242] rcu:    CB 5^4->4 KblSW F2954768 L2954768 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3564.791269] rcu:    CB 7^4->-1 KblSW F2971087 L2971093 C16 ..... q0 S CPU 13
[ 3564.792043] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3564.792716] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3564.793415] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3564.794091] rcu: RCU callbacks invoked since boot: 7679001
[ 3564.794719] rcu_tasks: RTGS_WAIT_CBS(11) since 3564221 g:0 i:0 k.u.. l:250 
[ 3580.137612] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7450255 ni: 132654 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 38440
[ 3580.146120] rcu-torture: Reader Pipe:  7939593352 122018 0 0 0 0 0 0 0 0 0
[ 3580.147249] rcu-torture: Reader Batch:  7938560574 1154796 0 0 0 0 0 0 0 0 0
[ 3580.148411] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3580.150071] ??? Writer stall state RTWS_EXP_SYNC(4) g732409 f0x0 ->state D cpu 1
[ 3580.151262] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: I ->rt_priority 0 delta ->gp_start 14 ->gp_activity 0 ->gp_req_activity 14 ->gp_wake_time 14 ->gp_wake_seq 732405 ->gp_seq 732409 ->gp_seq_needed 732408 ->gp_max 464 ->gp_flags 0x0
[ 3580.154594] rcu: 	rcu_node 0:16 ->gp_seq 732409 ->gp_seq_needed 732408 ->qsmask 0x2 .... ->n_boosts 0
[ 3580.156103] rcu: 	rcu_node 0:8 ->gp_seq 732409 ->gp_seq_needed 732416 ->qsmask 0x0 .... ->n_boosts 0
[ 3580.157374] rcu: 	cpu 0 ->gp_seq_needed 732412
[ 3580.157901] rcu: 	cpu 2 ->gp_seq_needed 732412
[ 3580.158571] rcu: 	cpu 8 ->gp_seq_needed 732416
[ 3580.160355] rcu: 	rcu_node 9:16 ->gp_seq 732409 ->gp_seq_needed 732416 ->qsmask 0x2 .... ->n_boosts 0
[ 3580.162203] rcu: 	cpu 9 ->gp_seq_needed 732416
[ 3580.162832] rcu: 	cpu 10 ->gp_seq_needed 732416
[ 3580.163535] rcu: 	cpu 11 ->gp_seq_needed 732416
[ 3580.164194] rcu: 	cpu 12 ->gp_seq_needed 732416
[ 3580.164922] rcu: 	cpu 13 ->gp_seq_needed 732416
[ 3580.165635] rcu: 	cpu 14 ->gp_seq_needed 732416
[ 3580.166318] rcu: 	cpu 15 ->gp_seq_needed 732416
[ 3580.166994] rcu: 	cpu 16 ->gp_seq_needed 732412
[ 3580.167710] rcu: nocb GP 0 KldtS .[.W] .G:732412/169040 rnp 0:8 97068 S CPU 10
[ 3580.168827] rcu:    CB 0^0->2 KblSW F367 L367 C0 ..... q0 S CPU 1
[ 3580.169714] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W4(732412/169040).N17. q21 S CPU 0
[ 3580.170810] rcu: nocb GP 4 KldtS W[.W] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3580.171819] rcu:    CB 4^4->7 KblSW F3005001 L3005010 C119 ..... q0 S CPU 2
[ 3580.172836] rcu:    CB 5^4->4 KblSW F2970151 L2970151 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3580.174233] rcu:    CB 7^4->-1 KblSW F2986470 L2986476 C16 ..... q0 S CPU 13
[ 3580.175423] rcu: nocb GP 8 KldtS W[.W] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3580.176336] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3580.177254] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3580.178216] rcu: RCU callbacks invoked since boot: 7708606
[ 3580.179054] rcu_tasks: RTGS_WAIT_CBS(11) since 3579605 g:0 i:0 k.u.. l:250 
[ 3595.497482] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7477179 ni: 133134 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 38981
[ 3595.501878] rcu-torture: Reader Pipe:  7968357818 122018 0 0 0 0 0 0 0 0 0
[ 3595.502930] rcu-torture: Reader Batch:  7967321613 1158223 0 0 0 0 0 0 0 0 0
[ 3595.504056] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3595.505709] ??? Writer stall state RTWS_EXP_SYNC(4) g734645 f0x0 ->state D cpu 1
[ 3595.506830] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: R ->rt_priority 0 delta ->gp_start 143 ->gp_activity 5 ->gp_req_activity 143 ->gp_wake_time 145 ->gp_wake_seq 734641 ->gp_seq 734645 ->gp_seq_needed 734644 ->gp_max 464 ->gp_flags 0x0
[ 3595.510260] rcu: 	rcu_node 0:16 ->gp_seq 734645 ->gp_seq_needed 734644 ->qsmask 0x2 .... ->n_boosts 0
[ 3595.511775] rcu: 	rcu_node 0:8 ->gp_seq 734645 ->gp_seq_needed 734652 ->qsmask 0x0 .... ->n_boosts 0
[ 3595.513204] rcu: 	cpu 0 ->gp_seq_needed 734648
[ 3595.513895] rcu: 	cpu 2 ->gp_seq_needed 734648
[ 3595.514584] rcu: 	cpu 8 ->gp_seq_needed 734652
[ 3595.515243] rcu: 	rcu_node 9:16 ->gp_seq 734645 ->gp_seq_needed 734652 ->qsmask 0x0 ...G ->n_boosts 0
[ 3595.516712] rcu: 	cpu 9 ->gp_seq_needed 734652
[ 3595.517634] rcu: 	cpu 10 ->gp_seq_needed 734652
[ 3595.518224] rcu: 	cpu 11 ->gp_seq_needed 734652
[ 3595.518932] rcu: 	cpu 12 ->gp_seq_needed 734648
[ 3595.519649] rcu: 	cpu 13 ->gp_seq_needed 734652
[ 3595.520336] rcu: 	cpu 14 ->gp_seq_needed 734652
[ 3595.520979] rcu: 	cpu 15 ->gp_seq_needed 734652
[ 3595.521669] rcu: 	cpu 16 ->gp_seq_needed 734652
[ 3595.522381] rcu: nocb GP 0 Kldts .[W.] .G:734648/169040 rnp 0:8 97358 S CPU 10
[ 3595.523474] rcu:    CB 0^0->2 KblSW F128 L128 C0 ...N1. q1 S CPU 1
[ 3595.524643] rcu:    CB 2^0->-1 KblSW F1 L1 C0 .W6(734648/169040).N70. q76 S CPU 16
[ 3595.526010] rcu: nocb GP 4 KldtS W[W.] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3595.527087] rcu:    CB 4^4->7 KblSW F3020356 L3020365 C119 ..... q0 S CPU 2
[ 3595.528218] rcu:    CB 5^4->4 KblSW F2985506 L2985506 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3595.529606] rcu:    CB 7^4->-1 KblSW F3001826 L3001832 C16 ..... q0 S CPU 13
[ 3595.530972] rcu: nocb GP 8 KldtS W[W.] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3595.531922] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3595.533141] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3595.534126] rcu: RCU callbacks invoked since boot: 7735666
[ 3595.534988] rcu_tasks: RTGS_WAIT_CBS(11) since 3594961 g:0 i:0 k.u.. l:250 
[ 3601.635837] rcu-torture: torture_shutdown task shutting down system
[ 3601.636913] rcu-torture: rcu_torture_reader is stopping
[ 3601.636914] rcu-torture: rcu_torture_reader is stopping
[ 3601.636914] rcu-torture: rcu_torture_reader is stopping
[ 3601.636915] rcu-torture: rcu_torture_reader is stopping
[ 3601.636915] rcu-torture: rcu_torture_reader is stopping
[ 3601.636915] rcu-torture: Stopping torture_shuffle task
[ 3601.636915] rcu-torture: rcu_torture_reader is stopping
[ 3601.637039] rcu-torture: rcu_torture_reader is stopping
[ 3601.666757] rcu-torture: Disabling gpwrap lag (value=0)
[ 3610.857536] rcu-torture: rtc: 00000000821c6024 ver: 27782 tfle: 0 rta: 27783 rtaf: 0 rtf: 27773 rtmbe: 0 rtmbkf: 0/24409 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 7493219 ni: 133417 onoff: 225/226:230/230 7,681:8,1127 24343:29871 (HZ=1000) barrier: 3365/3366:0 read-exits: 736 nocb-toggles: 1841:1874 gpwraps: 39257
[ 3610.860501] rcu-torture: Reader Pipe:  7986008487 122018 0 0 0 0 0 0 0 0 0
[ 3610.861256] rcu-torture: Reader Batch:  7984969957 1160548 0 0 0 0 0 0 0 0 0
[ 3610.862027] rcu-torture: Free-Block Circulation:  27782 27781 27780 27779 27778 27777 27776 27775 27774 27773 0
[ 3610.863114] ??? Writer stall state RTWS_EXP_SYNC(4) g736160 f0x0 ->state D cpu 1
[ 3610.863906] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: I ->rt_priority 0 delta ->gp_start 9220 ->gp_activity 9215 ->gp_req_activity 9220 ->gp_wake_time 9220 ->gp_wake_seq 736153 ->gp_seq 736160 ->gp_seq_needed 736160 ->gp_max 464 ->gp_flags 0x0
[ 3610.866346] rcu: nocb GP 0 KldtS W[..] ..:-1/-1 rnp 0:8 97555 S CPU 16
[ 3610.867055] rcu:    CB 0^0->2 KblSW F9444 L9444 C0 ..... q0 S CPU 1
[ 3610.867742] rcu:    CB 2^0->-1 KblSW F9231 L9231 C0 ..... q0 S CPU 0
[ 3610.868439] rcu: nocb GP 4 KldtS W[..] ..:-1/-1 rnp 0:8 23398 S CPU 14
[ 3610.869152] rcu:    CB 4^4->7 KblSW F3035698 L3035707 C119 ..... q0 S CPU 2
[ 3610.869914] rcu:    CB 5^4->4 KblSW F3000848 L3000848 C116 .W120(148380/168068).N295B101 q516 S CPU 16
[ 3610.870913] rcu:    CB 7^4->-1 KblSW F3017167 L3017173 C16 ..... q0 S CPU 13
[ 3610.871673] rcu: nocb GP 8 KldtS W[..] ..:-1/-1 rnp 0:8 2 S CPU 6
[ 3610.872326] rcu: nocb GP 12 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 4
[ 3610.873002] rcu: nocb GP 16 KldtS W[..] ..:-1/-1 rnp 9:16 2 S CPU 6
[ 3610.873672] rcu: RCU callbacks invoked since boot: 7752364
[ 3610.874263] rcu_tasks: RTGS_WAIT_CBS(11) since 3610300 g:0 i:0 k.u.. l:250 
[ 3610.875027] rcu-torture: rcu_torture_stats is stopping
[ 3615.543343] rcu-torture: torture_stutter is stopping

--RSoRuixPRx6UJHg0--
