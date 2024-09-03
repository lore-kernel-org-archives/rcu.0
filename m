Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766871A0BD1;
	Tue,  3 Sep 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359204; cv=none; b=UNJcSY8H4xUacX2rEq5sImWeTErxxxGNSq1iYJoB8DYoLni2RwvEbqxCwBeuv7nkYwFPCCZue6iOefoVY/5M6gIuOTT3tkg4e69q/xUDeWLpveXgXKPvqM5uUD5tjf5CpCM+Du75+XC9gn51xwRNc+hhlNQmWXLfo/aRh5NKhRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359204; c=relaxed/simple;
	bh=obQnx2epItpn98r4izb+YQ8xOf2exhBRtaIRxPYyXUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LED39xii6jOvSlpsbzJbaEcJSbRjvKQHlAnoOgVMqnj/9ikr3amkzlS35sEtHfZbrhFu3kib2YYpbh11Fp2s3GstcUlLSw9N41Sp/hR87ieBZsRsh4bZ6gBN0qYIxPBI9vmIiM09LATNZadmD75xDkTnTdBAxiAM5zPXnk/hxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5140YOX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5140YOX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DE5C4CEC5;
	Tue,  3 Sep 2024 10:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725359204;
	bh=obQnx2epItpn98r4izb+YQ8xOf2exhBRtaIRxPYyXUY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=J5140YOXP/uBxrYtFNBJoCcHwiNXPDYf02MPket3kvcGg8P4/S9qs6be2/dKFeEuJ
	 asMcxEe8GZ0pq4VpmRlT6h3my5m4wQ+TeOuydhbc4RYb+QflINU1Oo3ZiWTVAHVo0H
	 bkEFTEWUPvsQ/hs7rz4n8dAq4mloxLBzQ8UkfXPfrAG+Ehy9UZGIXGvhfTlg5VFz3F
	 K5AtMtHyyQ7jOtSsbr5g4hCgoAkcf/mKeSPAcqP1aieSsXCjdDiKm2muSck9N89Ad4
	 vHieq+4lJy2Zd9kI9irdCMwvk6MzL5js68bGnU5AgSwm3jMcSwoCA5EoMmFp1GUCPB
	 7MRGNGiJ7tWmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 95FE1CE14C5; Tue,  3 Sep 2024 03:26:43 -0700 (PDT)
Date: Tue, 3 Sep 2024 03:26:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, rcu@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.08.30b] [srcu]  558049054f:
 BUG:using__this_cpu_read()in_preemptible
Message-ID: <474f6fa0-e5b5-4834-9c6c-25549eb6478f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202409031433.5ce7c1e3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409031433.5ce7c1e3-lkp@intel.com>

On Tue, Sep 03, 2024 at 02:49:48PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:using__this_cpu_read()in_preemptible" on:
> 
> commit: 558049054fe90985d650a50b6a757943a9faf646 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
> https://github.com/paulmckrcu/linux dev.2024.08.30b
> 
> in testcase: boot
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +------------------------------------------+------------+------------+
> |                                          | ddf16dbef6 | 558049054f |
> +------------------------------------------+------------+------------+
> | BUG:using__this_cpu_read()in_preemptible | 0          | 12         |
> +------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202409031433.5ce7c1e3-lkp@intel.com

Good catch, thank you for testing!  Does the incremental patch at the
end of this email fix this for you?

							Thanx, Paul

> [   10.417780][    T1] BUG: using __this_cpu_read() in preemptible [00000000] code: swapper/0/1
> [ 10.419771][ T1] caller is synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
> [   10.421326][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T  6.11.0-rc1-00131-g558049054fe9 #1 4f684c68116af3bbce89b0137924bdf81528bc94
> [   10.421734][    T1] Tainted: [T]=RANDSTRUCT
> [   10.421734][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   10.421734][    T1] Call Trace:
> [   10.421734][    T1]  <TASK>
> [ 10.421734][ T1] dump_stack_lvl (lib/dump_stack.c:122) 
> [ 10.421734][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 lib/smp_processor_id.c:53) 
> [ 10.421734][ T1] synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
> [ 10.421734][ T1] kmem_cache_shrink (mm/slab_common.c:612) 
> [ 10.421734][ T1] acpi_os_purge_cache (drivers/acpi/osl.c:1575) 
> [ 10.421734][ T1] acpi_purge_cached_objects (drivers/acpi/acpica/utxface.c:238) 
> [ 10.421734][ T1] acpi_initialize_objects (drivers/acpi/acpica/utxfinit.c:250) 
> [ 10.421734][ T1] acpi_bus_init (drivers/acpi/bus.c:1365) 
> [ 10.421734][ T1] ? acpi_sleep_proc_init (drivers/acpi/bus.c:1334) 
> [ 10.421734][ T1] ? kobject_add (lib/kobject.c:374 lib/kobject.c:426) 
> [ 10.421734][ T1] ? kset_create_and_add (lib/kobject.c:412) 
> [ 10.421734][ T1] ? rcu_is_watching (include/linux/context_tracking.h:126 kernel/rcu/tree.c:737) 
> [ 10.421734][ T1] acpi_init (drivers/acpi/bus.c:1450) 
> [ 10.421734][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
> [ 10.421734][ T1] ? rng_is_initialized (drivers/char/random.c:934) 
> [ 10.421734][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
> [ 10.421734][ T1] do_one_initcall (init/main.c:1267) 
> [ 10.421734][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1258) 
> [ 10.421734][ T1] ? parameq (kernel/params.c:168) 
> [ 10.421734][ T1] ? __kmalloc_noprof (include/trace/events/kmem.h:54 mm/slub.c:4159 mm/slub.c:4170) 
> [ 10.421734][ T1] do_initcalls (init/main.c:1328 init/main.c:1345) 
> [ 10.421734][ T1] ? rdinit_setup (init/main.c:1313) 
> [ 10.421734][ T1] kernel_init_freeable (init/main.c:1582) 
> [ 10.421734][ T1] ? rest_init (init/main.c:1465) 
> [ 10.421734][ T1] kernel_init (init/main.c:1469) 
> [ 10.421734][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
> [ 10.421734][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 10.421734][ T1] ? rest_init (init/main.c:1465) 
> [ 10.421734][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [   10.421734][    T1]  </TASK>
> [   10.423389][    T1] BUG: using __this_cpu_read() in preemptible [00000000] code: swapper/0/1
> [ 10.424780][ T1] caller is synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
> [   10.426769][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T  6.11.0-rc1-00131-g558049054fe9 #1 4f684c68116af3bbce89b0137924bdf81528bc94
> [   10.434768][    T1] Tainted: [T]=RANDSTRUCT
> [   10.434768][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   10.438767][    T1] Call Trace:
> [   10.438767][    T1]  <TASK>
> [ 10.440770][ T1] dump_stack_lvl (lib/dump_stack.c:122) 
> [ 10.440770][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 lib/smp_processor_id.c:53) 
> [ 10.442769][ T1] synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
> [ 10.444768][ T1] kmem_cache_shrink (mm/slab_common.c:612) 
> [ 10.444768][ T1] acpi_os_purge_cache (drivers/acpi/osl.c:1575) 
> [ 10.446766][ T1] acpi_purge_cached_objects (drivers/acpi/acpica/utxface.c:239) 
> [ 10.448764][ T1] acpi_initialize_objects (drivers/acpi/acpica/utxfinit.c:250) 
> [ 10.448764][ T1] acpi_bus_init (drivers/acpi/bus.c:1365) 
> [ 10.450765][ T1] ? acpi_sleep_proc_init (drivers/acpi/bus.c:1334) 
> [ 10.452766][ T1] ? kobject_add (lib/kobject.c:374 lib/kobject.c:426) 
> [ 10.452766][ T1] ? kset_create_and_add (lib/kobject.c:412) 
> [ 10.454764][ T1] ? rcu_is_watching (include/linux/context_tracking.h:126 kernel/rcu/tree.c:737) 
> [ 10.456780][ T1] acpi_init (drivers/acpi/bus.c:1450) 
> [ 10.456780][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
> [ 10.458770][ T1] ? rng_is_initialized (drivers/char/random.c:934) 
> [ 10.460769][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
> [ 10.460769][ T1] do_one_initcall (init/main.c:1267) 
> [ 10.462764][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1258) 
> [ 10.464766][ T1] ? parameq (kernel/params.c:168) 
> [ 10.464766][ T1] ? __kmalloc_noprof (include/trace/events/kmem.h:54 mm/slub.c:4159 mm/slub.c:4170) 
> [ 10.466765][ T1] do_initcalls (init/main.c:1328 init/main.c:1345) 
> [ 10.468763][ T1] ? rdinit_setup (init/main.c:1313) 
> [ 10.468763][ T1] kernel_init_freeable (init/main.c:1582) 
> [ 10.470762][ T1] ? rest_init (init/main.c:1465) 
> [ 10.472766][ T1] kernel_init (init/main.c:1469) 
> [ 10.472766][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
> [ 10.474764][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 10.476765][ T1] ? rest_init (init/main.c:1465) 
> [ 10.476765][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [   10.478882][    T1]  </TASK>
> [   10.481604][    T1] BUG: using __this_cpu_read() in preemptible [00000000] code: swapper/0/1
> [ 10.482582][ T1] caller is synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
> [   10.483326][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T  6.11.0-rc1-00131-g558049054fe9 #1 4f684c68116af3bbce89b0137924bdf81528bc94
> [   10.483734][    T1] Tainted: [T]=RANDSTRUCT
> [   10.483734][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   10.483734][    T1] Call Trace:
> [   10.483734][    T1]  <TASK>
> [ 10.483734][ T1] dump_stack_lvl (lib/dump_stack.c:122) 
> [ 10.483734][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 lib/smp_processor_id.c:53) 
> [ 10.483734][ T1] synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
> [ 10.483734][ T1] kmem_cache_shrink (mm/slab_common.c:612) 
> [ 10.483734][ T1] acpi_os_purge_cache (drivers/acpi/osl.c:1575) 
> [ 10.483734][ T1] acpi_purge_cached_objects (drivers/acpi/acpica/utxface.c:240) 
> [ 10.483734][ T1] acpi_initialize_objects (drivers/acpi/acpica/utxfinit.c:250) 
> [ 10.483734][ T1] acpi_bus_init (drivers/acpi/bus.c:1365) 
> [ 10.483734][ T1] ? acpi_sleep_proc_init (drivers/acpi/bus.c:1334) 
> [ 10.483734][ T1] ? kobject_add (lib/kobject.c:374 lib/kobject.c:426) 
> [ 10.483734][ T1] ? kset_create_and_add (lib/kobject.c:412) 
> [ 10.483734][ T1] ? rcu_is_watching (include/linux/context_tracking.h:126 kernel/rcu/tree.c:737) 
> [ 10.483734][ T1] acpi_init (drivers/acpi/bus.c:1450) 
> [ 10.483734][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
> [ 10.483734][ T1] ? rng_is_initialized (drivers/char/random.c:934) 
> [ 10.483734][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
> [ 10.483734][ T1] do_one_initcall (init/main.c:1267) 
> [ 10.483734][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1258) 
> [ 10.483734][ T1] ? parameq (kernel/params.c:168) 
> [ 10.483734][ T1] ? __kmalloc_noprof (include/trace/events/kmem.h:54 mm/slub.c:4159 mm/slub.c:4170) 
> [ 10.483734][ T1] do_initcalls (init/main.c:1328 init/main.c:1345) 
> [ 10.483734][ T1] ? rdinit_setup (init/main.c:1313) 
> [ 10.483734][ T1] kernel_init_freeable (init/main.c:1582) 
> [ 10.483734][ T1] ? rest_init (init/main.c:1465) 
> [ 10.483734][ T1] kernel_init (init/main.c:1469) 
> [ 10.483734][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
> [ 10.483734][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 10.483734][ T1] ? rest_init (init/main.c:1465) 
> [ 10.483734][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [   10.483734][    T1]  </TASK>
> [   10.484500][    T1] BUG: using __this_cpu_read() in preemptible [00000000] code: swapper/0/1
> [ 10.485594][ T1] caller is synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
> [   10.486311][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T  6.11.0-rc1-00131-g558049054fe9 #1 4f684c68116af3bbce89b0137924bdf81528bc94
> [   10.486734][    T1] Tainted: [T]=RANDSTRUCT
> [   10.486734][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   10.486734][    T1] Call Trace:
> [   10.486734][    T1]  <TASK>
> [ 10.486734][ T1] dump_stack_lvl (lib/dump_stack.c:122) 
> [ 10.486734][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 lib/smp_processor_id.c:53) 
> [ 10.486734][ T1] synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
> [ 10.486734][ T1] kmem_cache_shrink (mm/slab_common.c:612) 
> [ 10.486734][ T1] acpi_os_purge_cache (drivers/acpi/osl.c:1575) 
> [ 10.486734][ T1] acpi_purge_cached_objects (drivers/acpi/acpica/utxface.c:243) 
> [ 10.486734][ T1] acpi_initialize_objects (drivers/acpi/acpica/utxfinit.c:250) 
> [ 10.486734][ T1] acpi_bus_init (drivers/acpi/bus.c:1365) 
> [ 10.486734][ T1] ? acpi_sleep_proc_init (drivers/acpi/bus.c:1334) 
> [ 10.486734][ T1] ? kobject_add (lib/kobject.c:374 lib/kobject.c:426) 
> [ 10.486734][ T1] ? kset_create_and_add (lib/kobject.c:412) 
> [ 10.486734][ T1] ? rcu_is_watching (include/linux/context_tracking.h:126 kernel/rcu/tree.c:737) 
> [ 10.486734][ T1] acpi_init (drivers/acpi/bus.c:1450) 
> [ 10.486734][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
> [ 10.486734][ T1] ? rng_is_initialized (drivers/char/random.c:934) 
> [ 10.486734][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
> [ 10.486734][ T1] do_one_initcall (init/main.c:1267) 
> [ 10.486734][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1258) 
> [ 10.486734][ T1] ? parameq (kernel/params.c:168) 
> [ 10.486734][ T1] ? __kmalloc_noprof (include/trace/events/kmem.h:54 mm/slub.c:4159 mm/slub.c:4170) 
> [ 10.486734][ T1] do_initcalls (init/main.c:1328 init/main.c:1345) 
> [ 10.486734][ T1] ? rdinit_setup (init/main.c:1313) 
> [ 10.486734][ T1] kernel_init_freeable (init/main.c:1582) 
> [ 10.486734][ T1] ? rest_init (init/main.c:1465) 
> [ 10.486734][ T1] kernel_init (init/main.c:1469) 
> [ 10.486734][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
> [ 10.486734][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 10.486734][ T1] ? rest_init (init/main.c:1465) 
> [ 10.486734][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [   10.486734][    T1]  </TASK>
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240903/202409031433.5ce7c1e3-lkp@intel.com


commit 01c732e108f6ea51e1660ad6bd59fff36e653ddb
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Sep 3 03:25:27 2024 -0700

    squash! srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()
    
    [ paulmck: Apply kernel test robot feedback. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 3133646f0b258..637d366a4dc7b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1239,7 +1239,7 @@ static bool srcu_should_expedite(struct srcu_struct *ssp)
 
 	check_init_srcu_struct(ssp);
 	/* If _lite() readers, don't do unsolicited expediting. */
-	if (__this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE)
+	if (this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE)
 		return false;
 	/* If the local srcu_data structure has callbacks, not idle.  */
 	sdp = raw_cpu_ptr(ssp->sda);
