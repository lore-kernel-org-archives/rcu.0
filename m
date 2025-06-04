Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5B28E575;
	Wed,  4 Jun 2025 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039989; cv=none; b=qDEbQJ3kgvd8iniASPJVigR8rq7T15nv3Ug/W8xYR0md/3kt0n0rMUrdIYACRKuVPS3dpKeilLP/0/WfC6BAWoOiwQ6LCg3iDvIB6hGQD/egdrKoh2Dcq7m3YUHeDtthtntEprKnOuLOXoagKumZNB9Cq6DEMlHyihOWDA6rAgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039989; c=relaxed/simple;
	bh=0cUEW+0kP0oJbKDTcAo3DSxdi9HA4lXhR/Gyg6MipBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMn9I03OPywXGzw7s8t2moCLMwWq4r1999X4VdU94G+MaQ7S7GUFXP7zB4ybvrk/SblDOegYkE7PIyedYHlRoIEBj5559DioRE2/MqDlDIxxs8ZBEq7+GhT0WRL5t7+1V3yDt2ooXd8TzoAbFcLG3L51RIsCAC6LPVoUL5+Dv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLoiQCw6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLoiQCw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E2CC4CEE7;
	Wed,  4 Jun 2025 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749039988;
	bh=0cUEW+0kP0oJbKDTcAo3DSxdi9HA4lXhR/Gyg6MipBI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GLoiQCw6rMzMsVAxtp+B0z1jwFZ2IoDZi8Y/WxERs/gzCSZxPtDYxjEq0srfiu9Hp
	 eBN2oaBzuxvqCif7LWz3szzAniE/xqELrDJyHWxa+KX7TnEWA23lcOqZmp6IhQkfvU
	 VX5ZWjn10NH+p9XzQJtA4yf7wR6WjIz7Zmz0EPiNLKg/nTdl49BZFQswVR2enRDg99
	 r66/j8G9gg2AmBg7V2HwHkNiI7gbTNjcWsnUG/HfF/CWTbDKadfQbFdlY2ertJI//r
	 DJqC7LI3sOiwBtYpChxydDIPz4qtQ5idHP/HY/Bf0I5b8GbH/tF+AW6muFNj7roE8W
	 Hu1knzusqo+7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 51AACCE0836; Wed,  4 Jun 2025 05:26:28 -0700 (PDT)
Date: Wed, 4 Jun 2025 05:26:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>, ankur.a.arora@oracle.com,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, neeraj.upadhyay@kernel.org,
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	xiqi2@huawei.com, "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
	Xie XiuQi <xiexiuqi@huawei.com>
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
Message-ID: <a963b475-72cd-474d-96d4-9e651fc8f857@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
 <20250603185939.GA1109523@joelnvbox>
 <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
 <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <c448118b-9f7e-4c29-d6b3-a66e70f7163f@huawei.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c448118b-9f7e-4c29-d6b3-a66e70f7163f@huawei.com>

On Wed, Jun 04, 2025 at 11:20:34AM +0800, Xiongfeng Wang wrote:
> Hi Joel,
> On 2025/6/4 3:22, Joel Fernandes wrote:
> > On 6/3/2025 3:03 PM, Joel Fernandes wrote:
> >> On 6/3/2025 2:59 PM, Joel Fernandes wrote:
> >>> On Fri, May 30, 2025 at 09:55:45AM +0800, Xiongfeng Wang wrote:
> >>>> Hi Joel,
> >>>>
> >>>> On 2025/5/29 0:30, Joel Fernandes wrote:
> >>>>> On Wed, May 21, 2025 at 5:43 AM Xiongfeng Wang
> >>>>> <wangxiongfeng2@huawei.com> wrote:
> >>>>>>
> >>>>>> Hi RCU experts,
> >>>>>>
> >>>>>> When I ran syskaller in Linux 6.6 with CONFIG_PREEMPT_RCU enabled, I got
> >>>>>> the following soft lockup. The Calltrace is too long. I put it in the end.
> >>>>>> The issue can also be reproduced in the latest kernel.
> >>>>>>
> >>>>>> The issue is as follows. CPU3 is waiting for a spin_lock, which is got by CPU1.
> >>>>>> But CPU1 stuck in the following dead loop.
> >>>>>>
> >>>>>> irq_exit()
> >>>>>>   __irq_exit_rcu()
> >>>>>>     /* in_hardirq() returns false after this */
> >>>>>>     preempt_count_sub(HARDIRQ_OFFSET)
> >>>>>>     tick_irq_exit()
> >>>>>>       tick_nohz_irq_exit()
> >>>>>>             tick_nohz_stop_sched_tick()
> >>>>>>               trace_tick_stop()  /* a bpf prog is hooked on this trace point */
> >>>>>>                    __bpf_trace_tick_stop()
> >>>>>>                       bpf_trace_run2()
> >>>>>>                             rcu_read_unlock_special()
> >>>>>>                               /* will send a IPI to itself */
> >>>>>>                               irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> >>>>>>
> >>>>>> /* after interrupt is enabled again, the irq_work is called */
> >>>>>> asm_sysvec_irq_work()
> >>>>>>   sysvec_irq_work()
> >>>>>> irq_exit() /* after handled the irq_work, we again enter into irq_exit() */
> >>>>>>   __irq_exit_rcu()
> >>>>>>     ...skip...
> >>>>>>            /* we queue a irq_work again, and enter a dead loop */
> >>>>>>            irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> >>>>>
> >>>>> This seems legitimate, Boqun and I were just talking about it. He may
> >>>>> share more thoughts but here are a few:
> >>>>>
> >>>>> Maybe we can delay subsequent clearing of the flag in
> >>>>> rcu_preempt_deferred_qs_handler() using a timer and an exponential
> >>>>> back-off? That way we are not sending too many self-IPIs.
> >>>>>
> >>>>> And reset the process at the end of a grace period.
> >>>>>
> >>>>> Or just don't send subsequent self-IPIs if we just sent one for the
> >>>>> rdp. Chances are, if we did not get the scheduler's attention during
> >>>>> the first one, we may not in subsequent ones I think. Plus we do send
> >>>>> other IPIs already if the grace period was over extended (from the FQS
> >>>>> loop), maybe we can tweak that?
> >>>>
> >>>> Thanks a lot for your reply. I think it's hard for me to fix this issue as
> >>>> above without introducing new bugs. I barely understand the RCU code. But I'm
> >>>> very glad to help test if you have any code modifiction need to. I have
> >>>> the VM and the syskaller benchmark which can reproduce the problem.
> >>>
> >>> Sure, I understand. This is already incredibly valuable so thank you again.
> >>> Will request for your testing help soon. I also have a test module now which
> >>> can sort-off reproduce this. Keep you posted!
> >>
> >> Oh sorry I meant to ask - could you provide the full kernel log and also is
> >> there a standalone reproducer syzcaller binary one can run to reproduce it in a VM?
> 
> Sorry, I communicate with the teams who maintain the syzkaller tools. He said
> I can't send the syskaller binary out of the company. Sorry, but I can help to
> reproduce. It's not complicate and not time consuming.
> 
> I found the origin log which use kernel v6.6. But it's not complete.
> Then I reprouce the problem using the latest kernel.
> Both logs are attached as attachments.

Looking at both the v6.6 version and Joel's fix, I am forced to conclude
that this bug has been there for a very long time.  Thank you for your
testing efforts and Joel for the fix!

							Thanx, Paul

> > Sorry for the noise, but please provide the full .config as well. I am curious
> > if you have CONFIG_RCU_STRICT_GRACE_PERIOD. Since that has an effect on
> > rcu_read_unlock_special().
> 
> .config is also attached. CONFIG_RCU_STRICT_GRACE_PERIOD is not set.
> 
> Thanks,
> Xiongfeng
> 
> > 
> > Thanks!
> > 
> >  - Joel
> > 
> > .
> > 

> [    0.000000][    T0] Linux version 6.15.0-rc7 (root@localhost.localdomain) (gcc (GCC) 10.3.1, GNU ld (GNU Binutils) 2.37) #9 SMP PREEMPT_DYNAMIC Wed Jun  4 18:04:00 CST 2025
> [    0.000000][    T0] Command line: console=ttyS0 root=/dev/vda rw rootfstype=ext4 nohz_full=2 earlycon=pl011,0x9000000 watchdog_thresh=50 mpam=acpi kernelcore=reliable clear_freelist hugetlb_free_vmemmap=on hugevm earlyconalloc=on cgroup1_writeback hardlockup_panic=1 softlockup_panic=1 nmi_watchdog=1 psi_v1=1 enable_dmips_measure sysctl.net.core.netdev_unregister_timeout_secs=300 watchdog_thresh=50 selinux=0 panic_on_warn
> [    0.000000][    T0] BIOS-provided physical RAM map:
> [    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
> [    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x00000000007fffff] usable
> [    0.000000][    T0] BIOS-e820: [mem 0x0000000000800000-0x0000000000807fff] ACPI NVS
> [    0.000000][    T0] BIOS-e820: [mem 0x0000000000808000-0x000000000080ffff] usable
> [    0.000000][    T0] BIOS-e820: [mem 0x0000000000810000-0x00000000008fffff] ACPI NVS
> [    0.000000][    T0] BIOS-e820: [mem 0x0000000000900000-0x00000000be8c2fff] usable
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000be8c3000-0x00000000be8c3fff] ACPI data
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000be8c4000-0x00000000be8cffff] usable
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000be8d0000-0x00000000be8d0fff] ACPI data
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000be8d1000-0x00000000be8d4fff] ACPI NVS
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000be8d5000-0x00000000be8d7fff] ACPI data
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000be8d8000-0x00000000be8dffff] ACPI NVS
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000be8e0000-0x00000000be8f8fff] reserved
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000be8f9000-0x00000000be9ecfff] usable
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000be9ed000-0x00000000beb1afff] reserved
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000beb1b000-0x00000000bfb9afff] usable
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000bfb9b000-0x00000000bfbf2fff] reserved
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000bfbf3000-0x00000000bfbfafff] ACPI data
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000bfbfb000-0x00000000bfbfefff] ACPI NVS
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000bfbff000-0x00000000bff3ffff] usable
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000bff40000-0x00000000bff5ffff] reserved
> [    0.000000][    T0] BIOS-e820: [mem 0x00000000bff60000-0x00000000bfffffff] ACPI NVS
> [    0.000000][    T0] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable
> [    0.000000][    T0] NX (Execute Disable) protection: active
> [    0.000000][    T0] APIC: Static calls initialized
> [    0.000000][    T0] efi: EFI v2.7 by EDK II
> [    0.000000][    T0] efi: SMBIOS=0xbfbce000 SMBIOS 3.0=0xbfbcc000 ACPI=0xbfbfa000 ACPI 2.0=0xbfbfa014 MEMATTR=0xbf228098 
> [    0.000000][    T0] SMBIOS 3.0.0 present.
> [    0.000000][    T0] DMI: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [    0.000000][    T0] DMI: Memory slots populated: 1/1
> [    0.000000][    T0] Hypervisor detected: KVM
> [    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
> [    0.000002][    T0] kvm-clock: using sched offset of 3369787381 cycles
> [    0.000011][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [    0.000027][    T0] tsc: Detected 2294.608 MHz processor
> [    0.000291][    T0] last_pfn = 0x140000 max_arch_pfn = 0x10000000000
> [    0.000371][    T0] MTRR map: 4 entries (2 fixed + 2 variable; max 18), built from 8 variable MTRRs
> [    0.000386][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.000478][    T0] last_pfn = 0xbff40 max_arch_pfn = 0x10000000000
> [    0.021610][    T0] Using GB pages for direct mapping
> [    0.042117][    T0] Secure boot disabled
> [    0.042124][    T0] ACPI: Early table checksum verification disabled
> [    0.042134][    T0] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )
> [    0.042155][    T0] ACPI: XSDT 0x00000000BFBF90E8 00005C (v01 BOCHS  BXPC     00000001      01000013)
> [    0.042183][    T0] ACPI: FACP 0x00000000BFBF5000 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
> [    0.042215][    T0] ACPI: DSDT 0x00000000BFBF6000 002024 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
> [    0.042249][    T0] ACPI: FACS 0x00000000BFBFD000 000040
> [    0.042268][    T0] ACPI: APIC 0x00000000BFBF4000 000090 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
> [    0.042293][    T0] ACPI: HPET 0x00000000BFBF3000 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
> [    0.042318][    T0] ACPI: SRAT 0x00000000BE8D7000 000110 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
> [    0.042343][    T0] ACPI: HMAT 0x00000000BE8D6000 000050 (v02 BOCHS  BXPC     00000001 BXPC 00000001)
> [    0.042368][    T0] ACPI: WAET 0x00000000BE8D5000 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
> [    0.042393][    T0] ACPI: BGRT 0x00000000BE8D0000 000038 (v01 INTEL  EDK2     00000002      01000013)
> [    0.042415][    T0] ACPI: Reserving FACP table memory at [mem 0xbfbf5000-0xbfbf5073]
> [    0.042425][    T0] ACPI: Reserving DSDT table memory at [mem 0xbfbf6000-0xbfbf8023]
> [    0.042434][    T0] ACPI: Reserving FACS table memory at [mem 0xbfbfd000-0xbfbfd03f]
> [    0.042442][    T0] ACPI: Reserving APIC table memory at [mem 0xbfbf4000-0xbfbf408f]
> [    0.042451][    T0] ACPI: Reserving HPET table memory at [mem 0xbfbf3000-0xbfbf3037]
> [    0.042460][    T0] ACPI: Reserving SRAT table memory at [mem 0xbe8d7000-0xbe8d710f]
> [    0.042469][    T0] ACPI: Reserving HMAT table memory at [mem 0xbe8d6000-0xbe8d604f]
> [    0.042478][    T0] ACPI: Reserving WAET table memory at [mem 0xbe8d5000-0xbe8d5027]
> [    0.042486][    T0] ACPI: Reserving BGRT table memory at [mem 0xbe8d0000-0xbe8d0037]
> [    0.042774][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
> [    0.042786][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
> [    0.042798][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x13fffffff]
> [    0.042809][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x140000000-0x11ffffffff] hotplug
> [    0.042840][    T0] NUMA: Node 0 [mem 0x00001000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00001000-0xbfffffff]
> [    0.042857][    T0] NUMA: Node 0 [mem 0x00001000-0xbfffffff] + [mem 0x100000000-0x13fffffff] -> [mem 0x00001000-0x13fffffff]
> [    0.042939][    T0] NODE_DATA(0) allocated [mem 0x13ffd5280-0x13fffffff]
> [    0.044263][    T0] Zone ranges:
> [    0.044268][    T0]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.044281][    T0]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.044291][    T0]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
> [    0.044302][    T0]   Device   empty
> [    0.044308][    T0] Movable zone start for each node
> [    0.044330][    T0] Early memory node ranges
> [    0.044334][    T0]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
> [    0.044344][    T0]   node   0: [mem 0x0000000000100000-0x00000000007fffff]
> [    0.044352][    T0]   node   0: [mem 0x0000000000808000-0x000000000080ffff]
> [    0.044361][    T0]   node   0: [mem 0x0000000000900000-0x00000000be8c2fff]
> [    0.044371][    T0]   node   0: [mem 0x00000000be8c4000-0x00000000be8cffff]
> [    0.044379][    T0]   node   0: [mem 0x00000000be8f9000-0x00000000be9ecfff]
> [    0.044388][    T0]   node   0: [mem 0x00000000beb1b000-0x00000000bfb9afff]
> [    0.044396][    T0]   node   0: [mem 0x00000000bfbff000-0x00000000bff3ffff]
> [    0.044405][    T0]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
> [    0.044415][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
> [    0.044840][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.044998][    T0] On node 0, zone DMA: 96 pages in unavailable ranges
> [    0.045009][    T0] On node 0, zone DMA: 8 pages in unavailable ranges
> [    0.045180][    T0] On node 0, zone DMA: 240 pages in unavailable ranges
> [    0.111525][    T0] On node 0, zone DMA32: 1 pages in unavailable ranges
> [    0.111563][    T0] On node 0, zone DMA32: 41 pages in unavailable ranges
> [    0.111917][    T0] On node 0, zone DMA32: 302 pages in unavailable ranges
> [    0.111999][    T0] On node 0, zone DMA32: 100 pages in unavailable ranges
> [    0.115749][    T0] On node 0, zone Normal: 192 pages in unavailable ranges
> [    0.270439][    T0] kasan: KernelAddressSanitizer initialized
> [    0.270908][    T0] ACPI: PM-Timer IO Port: 0xb008
> [    0.270956][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> [    0.271013][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
> [    0.271032][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.271043][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
> [    0.271054][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.271064][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
> [    0.271075][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
> [    0.271102][    T0] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.271108][    T0] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.271205][    T0] TSC deadline timer available
> [    0.271229][    T0] CPU topo: Max. logical packages:   1
> [    0.271235][    T0] CPU topo: Max. logical dies:       1
> [    0.271240][    T0] CPU topo: Max. dies per package:   1
> [    0.271255][    T0] CPU topo: Max. threads per core:   1
> [    0.271260][    T0] CPU topo: Num. cores per package:     4
> [    0.271266][    T0] CPU topo: Num. threads per package:   4
> [    0.271271][    T0] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
> [    0.271318][    T0] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
> [    0.271355][    T0] kvm-guest: KVM setup pv remote TLB flush
> [    0.271366][    T0] kvm-guest: setup PV sched yield
> [    0.271544][    T0] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.271562][    T0] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    0.271580][    T0] PM: hibernation: Registered nosave memory: [mem 0x00800000-0x00807fff]
> [    0.271599][    T0] PM: hibernation: Registered nosave memory: [mem 0x00810000-0x008fffff]
> [    0.271617][    T0] PM: hibernation: Registered nosave memory: [mem 0xbe8c3000-0xbe8c3fff]
> [    0.271636][    T0] PM: hibernation: Registered nosave memory: [mem 0xbe8d0000-0xbe8f8fff]
> [    0.271655][    T0] PM: hibernation: Registered nosave memory: [mem 0xbe9ed000-0xbeb1afff]
> [    0.271674][    T0] PM: hibernation: Registered nosave memory: [mem 0xbf203000-0xbf20bfff]
> [    0.271693][    T0] PM: hibernation: Registered nosave memory: [mem 0xbfb9b000-0xbfbfefff]
> [    0.271713][    T0] PM: hibernation: Registered nosave memory: [mem 0xbff40000-0xffffffff]
> [    0.271724][    T0] [mem 0xc0000000-0xffffffff] available for PCI devices
> [    0.271733][    T0] Booting paravirtualized kernel on KVM
> [    0.271739][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.342656][    T0] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
> [    0.343471][    T0] percpu: Embedded 77 pages/cpu s278528 r8192 d28672 u524288
> [    0.343796][    T0] Kernel command line: console=ttyS0 root=/dev/vda rw rootfstype=ext4 nohz_full=2 earlycon=pl011,0x9000000 watchdog_thresh=50 mpam=acpi kernelcore=reliable clear_freelist hugetlb_free_vmemmap=on hugevm earlyconalloc=on cgroup1_writeback hardlockup_panic=1 softlockup_panic=1 nmi_watchdog=1 psi_v1=1 enable_dmips_measure sysctl.net.core.netdev_unregister_timeout_secs=300 watchdog_thresh=50 selinux=0 panic_on_warn
> [    0.349175][    T0] Booting kernel: `' invalid for parameter `panic_on_warn'
> [    0.349208][    T0] Unknown kernel command line parameters "clear_freelist hugevm cgroup1_writeback enable_dmips_measure mpam=acpi earlyconalloc=on hardlockup_panic=1 psi_v1=1", will be passed to user space.
> [    0.349244][    T0] random: crng init done
> [    0.349249][    T0] printk: log buffer data + meta data: 1048576 + 3670016 = 4718592 bytes
> [    0.350455][    T0] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
> [    0.350745][    T0] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.352005][    T0] software IO TLB: area num 4.
> [    0.379482][    T0] Fallback order for Node 0: 0 
> [    0.379503][    T0] Built 1 zonelists, mobility grouping on.  Total pages: 1047595
> [    0.379512][    T0] Policy zone: Normal
> [    0.379519][    T0] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.379526][    T0] stackdepot: allocating hash table via alloc_large_system_hash
> [    0.379556][    T0] stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear)
> [    0.464645][    T0] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.550772][    T0] ftrace: allocating 155151 entries in 608 pages
> [    0.550785][    T0] ftrace: allocated 608 pages with 3 groups
> [    0.556173][    T0] Dynamic Preempt: none
> [    0.558241][    T0] rcu: Preemptible hierarchical RCU implementation.
> [    0.558247][    T0] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
> [    0.558257][    T0] 	Trampoline variant of Tasks RCU enabled.
> [    0.558262][    T0] 	Rude variant of Tasks RCU enabled.
> [    0.558265][    T0] 	Tracing variant of Tasks RCU enabled.
> [    0.558270][    T0] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.558276][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.558397][    T0] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
> [    0.558417][    T0] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
> [    0.558436][    T0] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
> [    0.706069][    T0] NR_IRQS: 524544, nr_irqs: 456, preallocated irqs: 16
> [    0.707498][    T0] NO_HZ: Full dynticks CPUs: 2.
> [    0.707517][    T0] rcu: 	Offload RCU callbacks from CPUs: 2.
> [    0.707526][    T0] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.708184][    T0] Console: colour dummy device 80x25
> [    0.708291][    T0] printk: legacy console [ttyS0] enabled
> [    0.895794][    T0] ACPI: Core revision 20240827
> [    0.897721][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
> [    0.899323][    T0] APIC: Switch to symmetric I/O mode setup
> [    0.900527][    T0] x2apic enabled
> [    0.901529][    T0] APIC: Switched APIC routing to: physical x2apic
> [    0.902553][    T0] kvm-guest: APIC: send_IPI_mask() replaced with kvm_send_ipi_mask()
> [    0.903769][    T0] kvm-guest: APIC: send_IPI_mask_allbutself() replaced with kvm_send_ipi_mask_allbutself()
> [    0.905232][    T0] kvm-guest: setup PV IPIs
> [    0.908156][    T0] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.909260][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x21134f58f0d, max_idle_ns: 440795217993 ns
> [    0.911004][    T0] Calibrating delay loop (skipped) preset value.. 4589.21 BogoMIPS (lpj=2294608)
> [    0.912249][    T0] x86/cpu: User Mode Instruction Prevention (UMIP) activated
> [    0.913224][    T0] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [    0.913999][    T0] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [    0.915039][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.916022][    T0] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [    0.917002][    T0] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on syscall and VM exit
> [    0.917998][    T0] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
> [    0.918998][    T0] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
> [    0.920016][    T0] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.921024][    T0] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> [    0.922017][    T0] TAA: Mitigation: TSX disabled
> [    0.922998][    T0] MMIO Stale Data: Mitigation: Clear CPU buffers
> [    0.924003][    T0] ITS: Mitigation: Aligned branch/return thunks
> [    0.925038][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.925998][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.926998][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.927998][    T0] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
> [    0.928998][    T0] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
> [    0.929998][    T0] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
> [    0.930998][    T0] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
> [    0.931999][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.932998][    T0] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
> [    0.933998][    T0] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
> [    0.934998][    T0] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
> [    0.935998][    T0] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
> [    0.936998][    T0] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
> [    1.185798][    T0] Freeing SMP alternatives memory: 104K
> [    1.186004][    T0] pid_max: default: 32768 minimum: 301
> [    1.191319][    T0] LSM: initializing lsm=lockdown,capability,yama,apparmor,bpf,ima,evm
> [    1.192174][    T0] Yama: becoming mindful.
> [    1.194123][    T0] AppArmor: AppArmor initialized
> [    1.195542][    T0] LSM support for eBPF active
> [    1.197205][    T0] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
> [    1.198015][    T0] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
> [    1.203532][    T1] smpboot: CPU0: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz (family: 0x6, model: 0x6a, stepping: 0x6)
> [    1.205408][    T1] Performance Events: PEBS fmt4+, Icelake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    1.206006][    T1] ... version:                2
> [    1.206699][    T1] ... bit width:              48
> [    1.207000][    T1] ... generic registers:      8
> [    1.207689][    T1] ... value mask:             0000ffffffffffff
> [    1.208000][    T1] ... max period:             00007fffffffffff
> [    1.208871][    T1] ... fixed-purpose events:   3
> [    1.209000][    T1] ... event mask:             00000007000000ff
> [    1.210344][    T1] signal: max sigframe size: 3632
> [    1.211207][    T1] rcu: Hierarchical SRCU implementation.
> [    1.212001][    T1] rcu: 	Max phase no-delay instances is 400.
> [    1.213562][    T1] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
> [    1.241131][    T1] watchdog: Disabling watchdog on nohz_full cores by default
> [    1.242539][    T9] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    1.243500][    T1] smp: Bringing up secondary CPUs ...
> [    1.245144][    T1] smpboot: x86: Booting SMP configuration:
> [    1.245988][    T1] .... node  #0, CPUs:      #1 #2 #3
> [    1.254595][    T1] smp: Brought up 1 node, 4 CPUs
> [    1.255706][    T1] smpboot: Total of 4 processors activated (18356.86 BogoMIPS)
> [    1.259077][   T45] node 0 deferred pages initialised in 0ms
> [    1.263168][    T1] Memory: 3148068K/4190380K available (152506K kernel code, 32460K rwdata, 55912K rodata, 26564K init, 10536K bss, 1024988K reserved, 0K cma-reserved)
> [    1.267119][    T1] devtmpfs: initialized
> [    1.272981][    T1] x86/mm: Memory block size: 128MB
> [    1.330158][    T1] ACPI: PM: Registering ACPI NVS region [mem 0x00800000-0x00807fff] (32768 bytes)
> [    1.331088][    T1] ACPI: PM: Registering ACPI NVS region [mem 0x00810000-0x008fffff] (983040 bytes)
> [    1.334594][    T1] ACPI: PM: Registering ACPI NVS region [mem 0xbe8d1000-0xbe8d4fff] (16384 bytes)
> [    1.336035][    T1] ACPI: PM: Registering ACPI NVS region [mem 0xbe8d8000-0xbe8dffff] (32768 bytes)
> [    1.337063][    T1] ACPI: PM: Registering ACPI NVS region [mem 0xbfbfb000-0xbfbfefff] (16384 bytes)
> [    1.339037][    T1] ACPI: PM: Registering ACPI NVS region [mem 0xbff60000-0xbfffffff] (655360 bytes)
> [    1.343126][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    1.345021][    T1] posixtimers hash table entries: 2048 (order: 3, 32768 bytes, linear)
> [    1.346055][    T1] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
> [    1.348120][    T1] pinctrl core: initialized pinctrl subsystem
> [    1.354833][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    1.363244][    T1] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
> [    1.365100][    T1] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    1.366100][    T1] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    1.368207][    T1] audit: initializing netlink subsys (disabled)
> [    1.370235][   T51] audit: type=2000 audit(1749005465.695:1): state=initialized audit_enabled=0 res=1
> [    1.371993][    T1] thermal_sys: Registered thermal governor 'fair_share'
> [    1.371993][    T1] thermal_sys: Registered thermal governor 'bang_bang'
> [    1.371993][    T1] thermal_sys: Registered thermal governor 'step_wise'
> [    1.371993][    T1] thermal_sys: Registered thermal governor 'user_space'
> [    1.375122][    T1] cpuidle: using governor menu
> [    1.382462][    T1] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    1.387225][    T1] dca service started, version 1.12.1
> [    1.389250][    T1] PCI: Using configuration type 1 for base access
> [    1.398521][    T1] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    1.404292][    T1] HugeTLB: allocation took 0ms with hugepage_allocation_threads=1
> [    1.406049][    T1] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> [    1.408008][    T1] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> [    1.410015][    T1] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> [    1.411004][    T1] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    1.428270][    T1] cryptd: max_cpu_qlen set to 1000
> [    1.449987][    T1] raid6: avx512x4 gen()  8890 MB/s
> [    1.467221][    T1] raid6: avx512x2 gen()  6086 MB/s
> [    1.486305][    T1] raid6: avx512x1 gen()  3591 MB/s
> [    1.504910][    T1] raid6: avx2x4   gen()  9335 MB/s
> [    1.521672][    T1] raid6: avx2x2   gen()  7820 MB/s
> [    1.538745][    T1] raid6: avx2x1   gen()  4428 MB/s
> [    1.539001][    T1] raid6: using algorithm avx2x4 gen() 9335 MB/s
> [    1.556983][    T1] raid6: .... xor() 6118 MB/s, rmw enabled
> [    1.557862][    T1] raid6: using avx512x2 recovery algorithm
> [    1.560097][    T1] ACPI: Added _OSI(Module Device)
> [    1.560862][    T1] ACPI: Added _OSI(Processor Device)
> [    1.562002][    T1] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    1.562834][    T1] ACPI: Added _OSI(Processor Aggregator Device)
> [    1.642663][    T1] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [    1.663784][    T1] ACPI: Interpreter enabled
> [    1.664289][    T1] ACPI: PM: (supports S0 S3 S4 S5)
> [    1.665002][    T1] ACPI: Using IOAPIC for interrupt routing
> [    1.666098][    T1] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    1.667002][    T1] PCI: Using E820 reservations for host bridge windows
> [    1.672468][    T1] ACPI: Enabled 3 GPEs in block 00 to 0F
> [    1.820574][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    1.821057][    T1] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
> [    1.823007][    T1] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
> [    1.824496][    T1] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
> [    1.839665][    T1] acpiphp: Slot [3] registered
> [    1.840424][    T1] acpiphp: Slot [4] registered
> [    1.841426][    T1] acpiphp: Slot [5] registered
> [    1.842414][    T1] acpiphp: Slot [6] registered
> [    1.843422][    T1] acpiphp: Slot [7] registered
> [    1.844417][    T1] acpiphp: Slot [8] registered
> [    1.846417][    T1] acpiphp: Slot [9] registered
> [    1.847422][    T1] acpiphp: Slot [10] registered
> [    1.848840][    T1] acpiphp: Slot [11] registered
> [    1.849435][    T1] acpiphp: Slot [12] registered
> [    1.850414][    T1] acpiphp: Slot [13] registered
> [    1.852421][    T1] acpiphp: Slot [14] registered
> [    1.853426][    T1] acpiphp: Slot [15] registered
> [    1.854428][    T1] acpiphp: Slot [16] registered
> [    1.855430][    T1] acpiphp: Slot [17] registered
> [    1.856410][    T1] acpiphp: Slot [18] registered
> [    1.857416][    T1] acpiphp: Slot [19] registered
> [    1.858413][    T1] acpiphp: Slot [20] registered
> [    1.859413][    T1] acpiphp: Slot [21] registered
> [    1.860419][    T1] acpiphp: Slot [22] registered
> [    1.861428][    T1] acpiphp: Slot [23] registered
> [    1.863420][    T1] acpiphp: Slot [24] registered
> [    1.864410][    T1] acpiphp: Slot [25] registered
> [    1.865413][    T1] acpiphp: Slot [26] registered
> [    1.866414][    T1] acpiphp: Slot [27] registered
> [    1.867413][    T1] acpiphp: Slot [28] registered
> [    1.868416][    T1] acpiphp: Slot [29] registered
> [    1.869427][    T1] acpiphp: Slot [30] registered
> [    1.870422][    T1] acpiphp: Slot [31] registered
> [    1.871235][    T1] PCI host bridge to bus 0000:00
> [    1.872189][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    1.873015][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    1.875014][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    1.876013][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
> [    1.877013][    T1] pci_bus 0000:00: root bus resource [mem 0x1800000000-0x187fffffff window]
> [    1.878015][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.879055][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint
> [    1.883199][    T1] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100 conventional PCI endpoint
> [    1.888113][    T1] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180 conventional PCI endpoint
> [    1.889809][    T1] pci 0000:00:01.1: BAR 4 [io  0xc0c0-0xc0cf]
> [    1.891045][    T1] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
> [    1.892001][    T1] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE quirk
> [    1.893001][    T1] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
> [    1.894002][    T1] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE quirk
> [    1.897828][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 conventional PCI endpoint
> [    1.899501][    T1] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
> [    1.901012][    T1] pci 0000:00:01.3: quirk: [io  0xb100-0xb10f] claimed by PIIX4 SMB
> [    1.904694][    T1] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000 conventional PCI endpoint
> [    1.907802][    T1] pci 0000:00:02.0: BAR 0 [mem 0xc0000000-0xc0ffffff pref]
> [    1.908023][    T1] pci 0000:00:02.0: BAR 2 [mem 0xc1012000-0xc1012fff]
> [    1.909035][    T1] pci 0000:00:02.0: ROM [mem 0xffff0000-0xffffffff pref]
> [    1.910242][    T1] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    1.915076][    T1] pci 0000:00:03.0: [1af4:1001] type 00 class 0x010000 conventional PCI endpoint
> [    1.918021][    T1] pci 0000:00:03.0: BAR 0 [io  0xc000-0xc07f]
> [    1.918937][    T1] pci 0000:00:03.0: BAR 1 [mem 0xc1011000-0xc1011fff]
> [    1.919036][    T1] pci 0000:00:03.0: BAR 4 [mem 0x1800000000-0x1800003fff 64bit pref]
> [    1.964682][    T1] pci 0000:00:04.0: [1af4:1009] type 00 class 0x000200 conventional PCI endpoint
> [    1.967023][    T1] pci 0000:00:04.0: BAR 0 [io  0xc080-0xc0bf]
> [    1.967923][    T1] pci 0000:00:04.0: BAR 1 [mem 0xc1010000-0xc1010fff]
> [    1.969038][    T1] pci 0000:00:04.0: BAR 4 [mem 0x1800004000-0x1800007fff 64bit pref]
> [    2.023377][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
> [    2.027728][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 11
> [    2.032596][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 10
> [    2.036629][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 10
> [    2.039469][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
> [    2.057023][    T1] acpi/hmat: Memory Flags:0001 Processor Domain:0 Memory Domain:0
> [    2.060284][    T1] iommu: Default domain type: Passthrough
> [    2.066443][    T1] SCSI subsystem initialized
> [    2.068224][    T1] ACPI: bus type USB registered
> [    2.069422][    T1] usbcore: registered new interface driver usbfs
> [    2.070191][    T1] usbcore: registered new interface driver hub
> [    2.071150][    T1] usbcore: registered new device driver usb
> [    2.072872][    T1] mc: Linux media interface: v0.10
> [    2.074219][    T1] videodev: Linux video capture interface: v2.00
> [    2.075542][    T1] pps_core: LinuxPPS API ver. 1 registered
> [    2.077001][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    2.078067][    T1] PTP clock support registered
> [    2.080191][    T1] EDAC MC: Ver: 3.0.0
> [    2.083022][    T1] efivars: Registered efivars operations
> [    2.084351][    T1] Advanced Linux Sound Architecture Driver Initialized.
> [    2.089802][    T1] NET: Registered PF_ATMPVC protocol family
> [    2.090006][    T1] NET: Registered PF_ATMSVC protocol family
> [    2.091176][    T1] NetLabel: Initializing
> [    2.091674][    T1] NetLabel:  domain hash size = 128
> [    2.093003][    T1] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    2.094292][    T1] NetLabel:  unlabeled traffic allowed by default
> [    2.096382][    T1] PCI: Using ACPI for IRQ routing
> [    2.098314][    T1] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    2.098993][    T1] pci 0000:00:02.0: vgaarb: bridge control possible
> [    2.098993][    T1] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    2.102005][    T1] vgaarb: loaded
> [    2.107784][    T1] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    2.108002][    T1] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
> [    2.118674][    T1] clocksource: Switched to clocksource kvm-clock
> [    2.469534][    T1] VFS: Disk quotas dquot_6.6.0
> [    2.469534][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    2.478506][    T1] netfs: FS-Cache loaded
> [    2.482117][    T1] CacheFiles: Loaded
> [    2.486503][    T1] AppArmor: AppArmor Filesystem Enabled
> [    2.486503][    T1] pnp: PnP ACPI init
> [    2.502515][    T1] pnp: PnP ACPI: found 6 devices
> [    2.586545][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    2.599208][    T1] NET: Registered PF_INET protocol family
> [    2.602735][    T1] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    2.854735][    T1] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
> [    2.855925][    T1] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    2.857036][    T1] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    2.858333][    T1] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
> [    2.859595][    T1] TCP: Hash tables configured (established 32768 bind 32768)
> [    2.861288][    T1] MPTCP token hash table entries: 4096 (order: 4, 98304 bytes, linear)
> [    2.862415][    T1] UDP hash table entries: 2048 (order: 5, 131072 bytes, linear)
> [    2.863411][    T1] UDP-Lite hash table entries: 2048 (order: 5, 131072 bytes, linear)
> [    2.865078][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    2.866541][    T1] NET: Registered PF_XDP protocol family
> [    2.867258][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    2.868102][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    2.868942][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    2.869874][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
> [    2.870806][    T1] pci_bus 0000:00: resource 8 [mem 0x1800000000-0x187fffffff window]
> [    2.872536][    T1] pci 0000:00:01.0: PIIX3: Enabling Passive Release
> [    2.873319][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> [    2.874269][    T1] PCI: CLS 0 bytes, default 64
> [    2.875542][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    2.876399][    T1] software IO TLB: mapped [mem 0x00000000b7ede000-0x00000000bbede000] (64MB)
> [    2.877543][    T1] ACPI: bus type thunderbolt registered
> [    2.882287][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
> [    2.883551][    T1] kvm_amd: CPU 3 isn't AMD or Hygon
> [    2.884182][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x21134f58f0d, max_idle_ns: 440795217993 ns
> [    2.885657][    T1] clocksource: Switched to clocksource tsc
> [    2.888357][    T1] mce: Machine check injector initialized
> [    2.923164][    T1] Initialise system trusted keyrings
> [    2.924594][    T1] Key type blacklist registered
> [    2.926823][    T1] workingset: timestamp_bits=36 max_order=20 bucket_order=0
> [    2.937880][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    2.940186][    T1] ntfs3: Enabled Linux POSIX ACLs support
> [    2.941585][    T1] ntfs3: Read-only LZX/Xpress compression included
> [    2.944200][    T1] fuse: init (API version 7.43)
> [    2.949569][    T1] SGI XFS with ACLs, security attributes, no debug enabled
> [    2.960163][    T1] integrity: Platform Keyring initialized
> [    3.023950][    T1] NET: Registered PF_ALG protocol family
> [    3.024893][    T1] xor: automatically using best checksumming function   avx       
> [    3.026083][    T1] async_tx: api initialized (async)
> [    3.026872][    T1] Key type asymmetric registered
> [    3.027630][    T1] Asymmetric key parser 'x509' registered
> [    3.028859][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 239)
> [    3.030775][    T1] io scheduler mq-deadline registered
> [    3.031598][    T1] io scheduler kyber registered
> [    3.032482][    T1] io scheduler bfq registered
> [    3.039425][    T1] leds_ss4200: no LED devices found
> [    3.083911][    T1] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
> [    3.086439][    T1] hv_vmbus: registering driver hyperv_fb
> [    3.087629][    T1] IPMI message handler: version 39.2
> [    3.088608][    T1] ipmi device interface
> [    3.090105][    T1] ipmi_si: IPMI System Interface driver
> [    3.094230][    T1] ipmi_si: Unable to find any System Interface(s)
> [    3.096931][    T1] ipmi_ssif: IPMI SSIF Interface driver
> [    3.099906][    T1] IPMI Watchdog: driver initialized
> [    3.101945][    T1] IPMI poweroff: Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot
> [    3.109527][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [    3.113301][    T1] ACPI: button: Power Button [PWRF]
> [    3.125046][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
> [    3.126978][    T1] idxd driver failed to load without MOVDIR64B.
> [    6.328329][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 10
> [    9.410221][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 11
> [    9.414359][    T1] N_HDLC line discipline registered with maxframe=4096
> [    9.415246][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    9.415246][    T1] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    9.429616][    T1] mmtimer: Hardware unsupported
> [    9.436438][    T1] lp: driver loaded but no devices found
> [    9.438555][    T1] Non-volatile memory driver v1.3
> [    9.440563][    T1] ppdev: user-space parallel port driver
> [    9.441448][    T1] telclk_interrupt = 0xf non-mcpbl0010 hw.
> [    9.441536][    T1] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
> [    9.446061][    T1] parport_pc 00:03: reported by Plug and Play ACPI
> [    9.446735][    T1] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
> [    9.544199][    T1] lp0: using parport0 (interrupt-driven).
> [    9.623819][    T1] brd: module loaded
> [    9.626608][    T1] loop: module loaded
> [    9.753355][    T1] virtio_blk virtio0: 4/0/0 default/read/poll queues
> [    9.753355][    T1] virtio_blk virtio0: [vda] 33554432 512-byte logical blocks (17.2 GB/16.0 GiB)
> [    9.770606][    T1] rbd: loaded (major 251)
> [    9.773539][    T1] zram: Added device: zram0
> [    9.777142][    T1] null_blk: disk nullb0 created
> [    9.777142][    T1] null_blk: module loaded
> [    9.777142][    T1] usbcore: registered new interface driver rtsx_usb
> [    9.777142][    T1] usbcore: registered new interface driver viperboard
> [    9.777142][    T1] Loading iSCSI transport class v2.0-870.
> [    9.793701][    T1] rdac: device handler registered
> [    9.794813][    T1] hp_sw: device handler registered
> [    9.795551][    T1] emc: device handler registered
> [    9.796668][    T1] alua: device handler registered
> [    9.798591][    T1] fnic: Cisco FCoE HBA Driver, ver 1.8.0.0
> [    9.799330][    T1] fnic: Successfully Initialized Trace Buffer
> [    9.799330][    T1] fnic: Successfully Initialized FC_CTLR Trace Buffer
> [    9.803612][    T1] bnx2fc: QLogic FCoE Driver bnx2fc v2.12.13 (October 15, 2015)
> [    9.806677][    T1] [0000:00:00.0]:[qedf_init:4142]: QLogic FCoE Offload Driver v8.42.3.0.
> [    9.809633][    T1] iscsi: registered transport (tcp)
> [    9.810127][    T1] Adaptec aacraid driver 1.2.1[50983]-custom
> [    9.810127][    T1] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.02.09.400-k.
> [    9.810127][    T1] iscsi: registered transport (qla4xxx)
> [    9.810127][    T1] QLogic iSCSI HBA Driver
> [    9.810127][    T1] Emulex LightPulse Fibre Channel SCSI driver 14.4.0.8
> [    9.810127][    T1] Copyright (C) 2017-2025 Broadcom. All Rights Reserved. The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
> [    9.895799][    T1] csiostor: Chelsio FCoE driver 1.0.0-ko
> [    9.896118][    T1] Microchip SmartPQI Driver (v2.1.30-031)
> [    9.896118][    T1] megasas: 07.734.00.00-rc1
> [    9.896118][    T1] mpt3sas version 52.100.00.00 loaded
> [    9.902394][    T1] libcxgbi:libcxgbi_init_module: Chelsio iSCSI driver library libcxgbi v0.9.1-ko (Apr. 2015)
> [    9.903082][    T1] Chelsio T4-T6 iSCSI Driver cxgb4i v0.9.5-ko (Apr. 2015)
> [    9.903082][    T1] iscsi: registered transport (cxgb4i)
> [    9.903082][    T1] QLogic NetXtreme II iSCSI Driver bnx2i v2.7.10.1 (Jul 16, 2014)
> [    9.903082][    T1] iscsi: registered transport (bnx2i)
> [    9.909918][    T1] iscsi: registered transport (qedi)
> [    9.912828][    T1] iscsi: registered transport (be2iscsi)
> [    9.913333][    T1] In beiscsi_module_init, tt=00000000cf5de27d
> [    9.913333][    T1] VMware PVSCSI driver - version 1.0.7.0-k
> [    9.913333][    T1] hv_vmbus: registering driver hv_storvsc
> [    9.913333][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs 256
> [    9.913333][    T1] SCSI Media Changer driver v0.25 
> [    9.925915][    T1] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
> [    9.926454][    T1] scsi host0: scsi_debug: version 0191 [20210520]
> [    9.926454][    T1]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> [    9.934830][   T12] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
> [    9.943209][    C3] scsi 0:0:0:0: Power-on or device reset occurred
> [    9.949723][    T1] scsi host1: ata_piix
> [    9.952149][   T12] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    9.953189][    T1] scsi host2: ata_piix
> [    9.953766][    T1] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0c0 irq 14 lpm-pol 0
> [    9.955612][   T53] sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
> [    9.953766][    T1] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0c8 irq 15 lpm-pol 0
> [    9.958582][    T1] Rounding down aligned max_sectors from 4294967295 to 4294967288
> [    9.960754][   T53] sd 0:0:0:0: [sda] Write Protect is off
> [    9.962424][    T1] db_root: cannot open: /etc/target
> [    9.967003][   T53] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    9.976512][   T53] sd 0:0:0:0: [sda] permanent stream count = 5
> [    9.982569][    T1] MACsec IEEE 802.1AE
> [    9.982721][   T53] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
> [    9.986251][   T53] sd 0:0:0:0: [sda] Optimal transfer size 524288 bytes
> [   10.020021][    T1] tun: Universal TUN/TAP device driver, 1.6
> [   10.022901][    T1] vcan: Virtual CAN interface driver
> [   10.024158][    T1] slcan: serial line CAN interface driver
> [   10.025231][    T1] CAN device driver interface
> [   10.026402][    T1] usbcore: registered new interface driver usb_8dev
> [   10.027474][    T1] usbcore: registered new interface driver ems_usb
> [   10.028420][    T1] usbcore: registered new interface driver kvaser_usb
> [   10.029618][    T1] usbcore: registered new interface driver peak_usb
> [   10.030497][    T1] cc770: CAN netdevice driver
> [   10.031945][   T53] sd 0:0:0:0: [sda] Attached SCSI disk
> [   10.032021][    T1] sja1000 CAN netdevice driver
> [   10.037516][    T1] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
> [   10.110974][  T158] ata2: found unknown device (class 0)
> [   10.114620][  T158] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> [   10.121735][   T68] scsi 2:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
> [   10.156373][   T68] sr 2:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> [   10.159566][   T68] cdrom: Uniform CD-ROM driver Revision: 3.20
> [   10.190788][   T68] sr 2:0:0:0: Attached scsi generic sg1 type 5
> [   11.054446][    T1] e1000: Intel(R) PRO/1000 Network Driver
> [   11.056867][    T1] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [   11.060318][    T1] e1000e: Intel(R) PRO/1000 Network Driver
> [   11.062684][    T1] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   11.066195][    T1] igb: Intel(R) Gigabit Ethernet Network Driver
> [   11.068707][    T1] igb: Copyright (c) 2007-2014 Intel Corporation.
> [   11.071052][    T1] igbvf: Intel(R) Gigabit Virtual Function Network Driver
> [   11.072977][    T1] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> [   11.075271][    T1] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
> [   11.077168][    T1] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [   11.080716][    T1] ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver
> [   11.084223][    T1] ixgbevf: Copyright (c) 2009 - 2024 Intel Corporation.
> [   11.088430][    T1] i40e: Intel(R) Ethernet Connection XL710 Network Driver
> [   11.091514][    T1] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
> [   11.094579][    T1] iavf: Intel(R) Ethernet Adaptive Virtual Function Network Driver
> [   11.096922][    T1] Copyright (c) 2013 - 2018 Intel Corporation.
> [   11.099253][    T1] Intel(R) Ethernet Switch Host Interface Driver
> [   11.101137][    T1] Copyright(c) 2013 - 2019 Intel Corporation.
> [   11.103845][    T1] ice: Intel(R) Ethernet Connection E800 Series Linux Driver
> [   11.105426][    T1] ice: Copyright (c) 2018, Intel Corporation.
> [   11.111780][    T1] myri10ge: Version 1.5.3-1.534
> [   11.113169][    T1] nfp: NFP PCIe Driver, Copyright (C) 2014-2020 Netronome Systems
> [   11.114316][    T1] nfp: NFP PCIe Driver, Copyright (C) 2021-2022 Corigine Inc.
> [   11.116066][    T1] QLogic/NetXen Network Driver v4.0.82
> [   11.117149][    T1] QLogic FastLinQ 4xxxx Core Module qed
> [   11.117946][    T1] qede init: QLogic FastLinQ 4xxxx Ethernet Driver qede
> [   11.120003][    T1] Solarflare NET driver
> [   11.122395][    T1] PPP generic driver version 2.4.2
> [   11.124090][    T1] PPP BSD Compression module registered
> [   11.124883][    T1] PPP Deflate Compression module registered
> [   11.125607][    T1] PPP MPPE Compression module registered
> [   11.126246][    T1] NET: Registered PF_PPPOX protocol family
> [   11.126966][    T1] PPTP driver version 0.8.5
> [   11.127619][    T1] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
> [   11.128533][    T1] CSLIP: code copyright 1989 Regents of the University of California.
> [   11.129447][    T1] SLIP linefill/keepalive option.
> [   11.130034][    T1] hdlc: HDLC support module revision 1.22
> [   11.130699][    T1] VMware vmxnet3 virtual NIC driver - version 1.9.0.0-k-NAPI
> [   11.131974][    T1] usbcore: registered new interface driver catc
> [   11.132872][    T1] usbcore: registered new interface driver kaweth
> [   11.133608][    T1] pegasus: Pegasus/Pegasus II USB Ethernet driver
> [   11.134502][    T1] usbcore: registered new interface driver pegasus
> [   11.135409][    T1] usbcore: registered new interface driver rtl8150
> [   11.136230][    T1] usbcore: registered new device driver r8152-cfgselector
> [   11.137226][    T1] usbcore: registered new interface driver r8152
> [   11.138172][    T1] usbcore: registered new interface driver hso
> [   11.139059][    T1] usbcore: registered new interface driver lan78xx
> [   11.140011][    T1] usbcore: registered new interface driver asix
> [   11.140899][    T1] usbcore: registered new interface driver ax88179_178a
> [   11.141864][    T1] usbcore: registered new interface driver cdc_ether
> [   11.142800][    T1] usbcore: registered new interface driver cdc_eem
> [   11.143717][    T1] usbcore: registered new interface driver dm9601
> [   11.144634][    T1] usbcore: registered new interface driver smsc75xx
> [   11.145585][    T1] usbcore: registered new interface driver smsc95xx
> [   11.146510][    T1] usbcore: registered new interface driver gl620a
> [   11.147416][    T1] usbcore: registered new interface driver net1080
> [   11.148321][    T1] usbcore: registered new interface driver plusb
> [   11.149287][    T1] usbcore: registered new interface driver rndis_host
> [   11.150237][    T1] usbcore: registered new interface driver cdc_subset
> [   11.151178][    T1] usbcore: registered new interface driver zaurus
> [   11.152082][    T1] usbcore: registered new interface driver MOSCHIP usb-ethernet driver
> [   11.153194][    T1] usbcore: registered new interface driver int51x1
> [   11.154644][    T1] usbcore: registered new interface driver kalmia
> [   11.155601][    T1] usbcore: registered new interface driver ipheth
> [   11.156479][    T1] usbcore: registered new interface driver sierra_net
> [   11.157403][    T1] usbcore: registered new interface driver cx82310_eth
> [   11.158341][    T1] usbcore: registered new interface driver cdc_ncm
> [   11.159237][    T1] usbcore: registered new interface driver huawei_cdc_ncm
> [   11.160208][    T1] usbcore: registered new interface driver lg-vl600
> [   11.161133][    T1] usbcore: registered new interface driver qmi_wwan
> [   11.162046][    T1] usbcore: registered new interface driver cdc_mbim
> [   11.162958][    T1] usbcore: registered new interface driver ch9200
> [   11.163852][    T1] usbcore: registered new interface driver r8153_ecm
> [   11.164806][    T1] hv_vmbus: registering driver hv_netvsc
> [   11.166048][    T1] Fusion MPT base driver 3.04.20
> [   11.166701][    T1] Copyright (c) 1999-2008 LSI Corporation
> [   11.167382][    T1] Fusion MPT SPI Host driver 3.04.20
> [   11.168197][    T1] Fusion MPT SAS Host driver 3.04.20
> [   11.169007][    T1] Fusion MPT misc device (ioctl) driver 3.04.20
> [   11.170221][    T1] mptctl: Registered with Fusion MPT base driver
> [   11.170966][    T1] mptctl: /dev/mptctl @ (major,minor=10,220)
> [   11.173675][    T1] hv_vmbus: registering driver uio_hv_generic
> [   11.175650][    T1] VFIO - User Level meta-driver version: 0.3
> [   11.178780][    T1] usbcore: registered new interface driver cdc_acm
> [   11.179544][    T1] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
> [   11.180727][    T1] usbcore: registered new interface driver usblp
> [   11.181614][    T1] usbcore: registered new interface driver cdc_wdm
> [   11.182525][    T1] usbcore: registered new interface driver usbtmc
> [   11.183735][    T1] usbcore: registered new interface driver uas
> [   11.184609][    T1] usbcore: registered new interface driver usb-storage
> [   11.185677][    T1] usbcore: registered new interface driver ums-alauda
> [   11.186597][    T1] usbcore: registered new interface driver ums-cypress
> [   11.187527][    T1] usbcore: registered new interface driver ums-datafab
> [   11.188471][    T1] usbcore: registered new interface driver ums_eneub6250
> [   11.189417][    T1] usbcore: registered new interface driver ums-freecom
> [   11.190312][    T1] usbcore: registered new interface driver ums-isd200
> [   11.191235][    T1] usbcore: registered new interface driver ums-jumpshot
> [   11.192166][    T1] usbcore: registered new interface driver ums-karma
> [   11.193143][    T1] usbcore: registered new interface driver ums-onetouch
> [   11.194096][    T1] usbcore: registered new interface driver ums-realtek
> [   11.195028][    T1] usbcore: registered new interface driver ums-sddr09
> [   11.195957][    T1] usbcore: registered new interface driver ums-sddr55
> [   11.196885][    T1] usbcore: registered new interface driver ums-usbat
> [   11.197872][    T1] usbcore: registered new interface driver mdc800
> [   11.198603][    T1] mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800 Digital Camera
> [   11.199738][    T1] usbcore: registered new interface driver microtekX6
> [   11.200857][    T1] usbcore: registered new interface driver usbserial_generic
> [   11.201783][    T1] usbserial: USB Serial support registered for generic
> [   11.202702][    T1] usbcore: registered new interface driver aircable
> [   11.203525][    T1] usbserial: USB Serial support registered for aircable
> [   11.204432][    T1] usbcore: registered new interface driver ark3116
> [   11.205241][    T1] usbserial: USB Serial support registered for ark3116
> [   11.206137][    T1] usbcore: registered new interface driver belkin_sa
> [   11.206969][    T1] usbserial: USB Serial support registered for Belkin / Peracom / GoHubs USB Serial Adapter
> [   11.208241][    T1] usbcore: registered new interface driver ch341
> [   11.209036][    T1] usbserial: USB Serial support registered for ch341-uart
> [   11.209969][    T1] usbcore: registered new interface driver cp210x
> [   11.210776][    T1] usbserial: USB Serial support registered for cp210x
> [   11.211673][    T1] usbcore: registered new interface driver cyberjack
> [   11.212510][    T1] usbserial: USB Serial support registered for Reiner SCT Cyberjack USB card reader
> [   11.213765][    T1] usbcore: registered new interface driver cypress_m8
> [   11.214586][    T1] usbserial: USB Serial support registered for DeLorme Earthmate USB
> [   11.215541][    T1] usbserial: USB Serial support registered for HID->COM RS232 Adapter
> [   11.216519][    T1] usbserial: USB Serial support registered for Nokia CA-42 V2 Adapter
> [   11.217571][    T1] usbcore: registered new interface driver usb_debug
> [   11.218386][    T1] usbserial: USB Serial support registered for debug
> [   11.219212][    T1] usbserial: USB Serial support registered for xhci_dbc
> [   11.220124][    T1] usbcore: registered new interface driver digi_acceleport
> [   11.221186][    T1] usbserial: USB Serial support registered for Digi 2 port USB adapter
> [   11.222206][    T1] usbserial: USB Serial support registered for Digi 4 port USB adapter
> [   11.223263][    T1] usbcore: registered new interface driver io_edgeport
> [   11.224161][    T1] usbserial: USB Serial support registered for Edgeport 2 port adapter
> [   11.225194][    T1] usbserial: USB Serial support registered for Edgeport 4 port adapter
> [   11.226233][    T1] usbserial: USB Serial support registered for Edgeport 8 port adapter
> [   11.227262][    T1] usbserial: USB Serial support registered for EPiC device
> [   11.228222][    T1] usbcore: registered new interface driver io_ti
> [   11.229031][    T1] usbserial: USB Serial support registered for Edgeport TI 1 port adapter
> [   11.230092][    T1] usbserial: USB Serial support registered for Edgeport TI 2 port adapter
> [   11.231233][    T1] usbcore: registered new interface driver empeg
> [   11.232022][    T1] usbserial: USB Serial support registered for empeg
> [   11.232912][    T1] usbcore: registered new interface driver f81534
> [   11.233714][    T1] usbserial: USB Serial support registered for Fintek F81532/F81534
> [   11.234752][    T1] usbcore: registered new interface driver ftdi_sio
> [   11.235571][    T1] usbserial: USB Serial support registered for FTDI USB Serial Device
> [   11.236629][    T1] usbcore: registered new interface driver garmin_gps
> [   11.237482][    T1] usbserial: USB Serial support registered for Garmin GPS usb/tty
> [   11.238530][    T1] usbcore: registered new interface driver ipaq
> [   11.239305][    T1] usbserial: USB Serial support registered for PocketPC PDA
> [   11.240253][    T1] usbcore: registered new interface driver ipw
> [   11.241025][    T1] usbserial: USB Serial support registered for IPWireless converter
> [   11.242056][    T1] usbcore: registered new interface driver ir_usb
> [   11.242869][    T1] usbserial: USB Serial support registered for IR Dongle
> [   11.243791][    T1] usbcore: registered new interface driver iuu_phoenix
> [   11.244646][    T1] usbserial: USB Serial support registered for iuu_phoenix
> [   11.245589][    T1] usbcore: registered new interface driver keyspan
> [   11.246380][    T1] usbserial: USB Serial support registered for Keyspan - (without firmware)
> [   11.247476][    T1] usbserial: USB Serial support registered for Keyspan 1 port adapter
> [   11.248481][    T1] usbserial: USB Serial support registered for Keyspan 2 port adapter
> [   11.249668][    T1] usbserial: USB Serial support registered for Keyspan 4 port adapter
> [   11.250723][    T1] usbcore: registered new interface driver keyspan_pda
> [   11.251582][    T1] usbserial: USB Serial support registered for Keyspan PDA
> [   11.252467][    T1] usbserial: USB Serial support registered for Keyspan PDA - (prerenumeration)
> [   11.253631][    T1] usbcore: registered new interface driver kl5kusb105
> [   11.254987][    T1] usbserial: USB Serial support registered for KL5KUSB105D / PalmConnect
> [   11.256527][    T1] usbcore: registered new interface driver kobil_sct
> [   11.257420][    T1] usbserial: USB Serial support registered for KOBIL USB smart card terminal
> [   11.258554][    T1] usbcore: registered new interface driver mct_u232
> [   11.259354][    T1] usbserial: USB Serial support registered for MCT U232
> [   11.260251][    T1] usbcore: registered new interface driver mos7720
> [   11.261063][    T1] usbserial: USB Serial support registered for Moschip 2 port adapter
> [   11.262109][    T1] usbcore: registered new interface driver mos7840
> [   11.262912][    T1] usbserial: USB Serial support registered for Moschip 7840/7820 USB Serial Driver
> [   11.264257][    T1] usbcore: registered new interface driver mxuport
> [   11.265219][    T1] usbserial: USB Serial support registered for MOXA UPort
> [   11.266167][    T1] usbcore: registered new interface driver navman
> [   11.266991][    T1] usbserial: USB Serial support registered for navman
> [   11.267907][    T1] usbcore: registered new interface driver omninet
> [   11.268744][    T1] usbserial: USB Serial support registered for ZyXEL - omni.net usb
> [   11.269816][    T1] usbcore: registered new interface driver opticon
> [   11.270643][    T1] usbserial: USB Serial support registered for opticon
> [   11.271565][    T1] usbcore: registered new interface driver option
> [   11.272380][    T1] usbserial: USB Serial support registered for GSM modem (1-port)
> [   11.273396][    T1] usbcore: registered new interface driver oti6858
> [   11.274227][    T1] usbserial: USB Serial support registered for oti6858
> [   11.275144][    T1] usbcore: registered new interface driver pl2303
> [   11.275970][    T1] usbserial: USB Serial support registered for pl2303
> [   11.276928][    T1] usbcore: registered new interface driver qcaux
> [   11.277762][    T1] usbserial: USB Serial support registered for qcaux
> [   11.279011][    T1] usbcore: registered new interface driver qcserial
> [   11.279869][    T1] usbserial: USB Serial support registered for Qualcomm USB modem
> [   11.281186][    T1] usbcore: registered new interface driver quatech2
> [   11.282197][    T1] usbserial: USB Serial support registered for Quatech 2nd gen USB to Serial Driver
> [   11.283445][    T1] usbcore: registered new interface driver safe_serial
> [   11.284329][    T1] usbserial: USB Serial support registered for safe_serial
> [   11.285331][    T1] usbcore: registered new interface driver sierra
> [   11.286147][    T1] usbserial: USB Serial support registered for Sierra USB modem
> [   11.287158][    T1] usbcore: registered new interface driver spcp8x5
> [   11.287992][    T1] usbserial: USB Serial support registered for SPCP8x5
> [   11.288915][    T1] usbcore: registered new interface driver ssu100
> [   11.289745][    T1] usbserial: USB Serial support registered for Quatech SSU-100 USB to Serial Driver
> [   11.290951][    T1] usbcore: registered new interface driver symbolserial
> [   11.291834][    T1] usbserial: USB Serial support registered for symbol
> [   11.292749][    T1] usbcore: registered new interface driver ti_usb_3410_5052
> [   11.293659][    T1] usbserial: USB Serial support registered for TI USB 3410 1 port adapter
> [   11.294733][    T1] usbserial: USB Serial support registered for TI USB 5052 2 port adapter
> [   11.295867][    T1] usbcore: registered new interface driver upd78f0730
> [   11.296722][    T1] usbserial: USB Serial support registered for upd78f0730
> [   11.297667][    T1] usbcore: registered new interface driver visor
> [   11.298889][    T1] usbserial: USB Serial support registered for Handspring Visor / Palm OS
> [   11.300146][    T1] usbserial: USB Serial support registered for Sony Clie 5.0
> [   11.301064][    T1] usbserial: USB Serial support registered for Sony Clie 3.5
> [   11.302029][    T1] usbcore: registered new interface driver whiteheat
> [   11.302890][    T1] usbserial: USB Serial support registered for Connect Tech - WhiteHEAT - (prerenumeration)
> [   11.304120][    T1] usbserial: USB Serial support registered for Connect Tech - WhiteHEAT
> [   11.305188][    T1] usbcore: registered new interface driver xsens_mt
> [   11.306009][    T1] usbserial: USB Serial support registered for xsens_mt
> [   11.306997][    T1] usbcore: registered new interface driver adutux
> [   11.307909][    T1] usbcore: registered new interface driver appledisplay
> [   11.308886][    T1] usbcore: registered new interface driver emi26 - firmware loader
> [   11.309949][    T1] usbcore: registered new interface driver emi62 - firmware loader
> [   11.311044][    T1] usbcore: registered new interface driver idmouse
> [   11.311965][    T1] usbcore: registered new interface driver iowarrior
> [   11.312904][    T1] usbcore: registered new interface driver isight_firmware
> [   11.313921][    T1] usbcore: registered new interface driver usblcd
> [   11.314859][    T1] usbcore: registered new interface driver ldusb
> [   11.315866][    T1] usbcore: registered new interface driver legousbtower
> [   11.316859][    T1] usbcore: registered new interface driver uss720
> [   11.317576][    T1] uss720: USB Parport Cable driver for Cables using the Lucent Technologies USS720 Chip
> [   11.318653][    T1] uss720: NOTE: this is a special purpose driver to allow nonstandard
> [   11.319575][    T1] uss720: protocols (eg. bitbang) over USS720 usb to parallel cables
> [   11.320844][    T1] uss720: If you just want to connect to a printer, use usblp instead
> [   11.322181][    T1] usbcore: registered new interface driver usbsevseg
> [   11.323306][    T1] usbcore: registered new interface driver sisusb
> [   11.324198][    T1] usbcore: registered new interface driver cxacru
> [   11.325093][    T1] usbcore: registered new interface driver speedtch
> [   11.326015][    T1] usbcore: registered new interface driver ueagle-atm
> [   11.326797][    T1] xusbatm: malformed module parameters
> [   11.328351][    T1] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
> [   11.330829][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
> [   11.331517][    T1] serio: i8042 AUX port at 0x60,0x64 irq 12
> [   11.332585][    T1] hv_vmbus: registering driver hyperv_keyboard
> [   11.334250][    T1] mousedev: PS/2 mouse device common for all mice
> [   11.336161][    T1] usbcore: registered new interface driver appletouch
> [   11.337110][    T1] usbcore: registered new interface driver bcm5974
> [   11.338850][    T1] usbcore: registered new interface driver synaptics_usb
> [   11.340002][    T1] usbcore: registered new interface driver usb_acecad
> [   11.340939][    T1] usbcore: registered new interface driver aiptek
> [   11.341850][    T1] usbcore: registered new interface driver kbtab
> [   11.343360][    T1] apanel: Fujitsu BIOS signature 'FJKEYINF' not found...
> [   11.344498][    T1] usbcore: registered new interface driver ati_remote2
> [   11.345430][    T1] cm109: Keymap for Komunikate KIP1000 phone loaded
> [   11.346411][    T1] usbcore: registered new interface driver cm109
> [   11.347182][    T1] cm109: CM109 phone driver: 20080805 (C) Alfred E. Heggestad
> [   11.348234][    T1] usbcore: registered new interface driver keyspan_remote
> [   11.349634][    T1] input: PC Speaker as /devices/platform/pcspkr/input/input2
> [   11.351611][   T77] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
> [   11.351979][    T1] usbcore: registered new interface driver powermate
> [   11.355969][    T1] usbcore: registered new interface driver yealink
> [   11.357996][   T77] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input5
> [   11.360318][    T1] rtc_cmos 00:05: RTC can wake from S4
> [   11.361847][   T77] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
> [   11.365957][    T1] rtc_cmos 00:05: registered as rtc0
> [   11.367013][    T1] rtc_cmos 00:05: setting system clock to 2025-06-04T02:51:15 UTC (1749005475)
> [   11.369067][    T1] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram
> [   11.375614][    T1] i2c_dev: i2c /dev entries driver
> [   11.378915][    T1] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0xb100, revision 0
> [   11.383275][    T1] i2c i2c-0: Memory type 0x07 not supported yet, not instantiating SPD
> [   11.386788][    T1] usbcore: registered new interface driver i2c-diolan-u2c
> [   11.388475][    T1] i2c-parport: adapter type unspecified
> [   11.389768][    T1] usbcore: registered new interface driver i2c-tiny-usb
> [   11.398025][    T1] ir_imon_decoder: IR iMON protocol handler initialized
> [   11.399273][    T1] IR JVC protocol handler initialized
> [   11.400206][    T1] IR MCE Keyboard/mouse protocol handler initialized
> [   11.401362][    T1] IR NEC protocol handler initialized
> [   11.402312][    T1] IR RC5(x/sz) protocol handler initialized
> [   11.403335][    T1] IR RC6 protocol handler initialized
> [   11.404272][    T1] IR SANYO protocol handler initialized
> [   11.405238][    T1] IR Sony protocol handler initialized
> [   11.406764][    T1] usbcore: registered new interface driver iguanair
> [   11.408222][    T1] usbcore: registered new interface driver imon
> [   11.409655][    T1] usbcore: registered new interface driver imon_raw
> [   11.411593][    T1] usbcore: registered new interface driver mceusb
> [   11.413157][    T1] usbcore: registered new interface driver redrat3
> [   11.415320][    T1] serial_ir serial_ir.0: port 03f8 already in use
> [   11.417208][    T1] serial_ir serial_ir.0: use 'setserial /dev/ttySX uart none'
> [   11.418494][    T1] serial_ir serial_ir.0: or compile the serial port driver as module and
> [   11.419911][    T1] serial_ir serial_ir.0: make sure this module is loaded first
> [   11.421188][    T1] serial_ir serial_ir.0: probe with driver serial_ir failed with error -16
> [   11.423165][    T1] usbcore: registered new interface driver streamzap
> [   11.424622][    T1] usbcore: registered new interface driver ttusbir
> [   11.426213][    T1] usbcore: registered new interface driver ati_remote
> [   11.428044][    T1] b2c2-flexcop: B2C2 FlexcopII/II(b)/III digital TV receiver chip loaded successfully
> [   11.429662][    T1] saa7146: register extension 'budget dvb'
> [   11.430983][    T1] saa7146: register extension 'budget_av'
> [   11.432233][    T1] saa7146: register extension 'budget_ci dvb'
> [   11.435386][    T1] ngene: nGene PCIE bridge driver, Copyright (C) 2005-2007 Micronas
> [   11.437076][    T1] ddbridge: Digital Devices PCIE bridge driver 0.9.33-integrated, Copyright (C) 2010-17 Digital Devices GmbH
> [   11.439651][    T1] bttv: driver version 0.9.19 loaded
> [   11.440570][    T1] bttv: using 8 buffers with 2080k (520 pages) each for capture
> [   11.441894][    T1] bttv: Host bridge needs ETBF enabled
> [   11.443415][    T1] bt878: AUDIO driver version 0.0.0 loaded
> [   11.444942][    T1] cx18:  Start initialization, version 1.5.1
> [   11.446322][    T1] cx18:  End initialization
> [   11.447147][    T1] cx23885: cx23885 driver version 0.0.4 loaded
> [   11.450080][    T1] cx88_blackbird: cx2388x blackbird driver version 1.0.0 loaded
> [   11.451433][    T1] cx8802: registering cx8802 driver, type: blackbird access: shared
> [   11.452870][    T1] cx88_dvb: cx2388x dvb driver version 1.0.0 loaded
> [   11.454061][    T1] cx8802: registering cx8802 driver, type: dvb access: shared
> [   11.455392][    T1] ivtv: Start initialization, version 1.4.3
> [   11.456853][    T1] ivtv: End initialization
> [   11.457641][    T1] ivtvfb: no cards found
> [   11.458366][    T1] saa7134: saa7130/34: v4l2 driver version 0, 2, 17 loaded
> [   11.460357][    T1] saa7164 driver loaded
> [   11.461417][    T1] usbcore: registered new interface driver b2c2_flexcop_usb
> [   11.462984][    T1] usbcore: registered new interface driver dvb_usb_vp7045
> [   11.464532][    T1] usbcore: registered new interface driver dvb_usb_vp702x
> [   11.466140][    T1] usbcore: registered new interface driver dvb_usb_gp8psk
> [   11.467721][    T1] usbcore: registered new interface driver dvb_usb_dtt200u
> [   11.469294][    T1] usbcore: registered new interface driver dvb_usb_a800
> [   11.470809][    T1] usbcore: registered new interface driver dvb_usb_dibusb_mb
> [   11.472388][    T1] usbcore: registered new interface driver dvb_usb_dibusb_mc
> [   11.473990][    T1] usbcore: registered new interface driver dvb_usb_nova_t_usb2
> [   11.475577][    T1] usbcore: registered new interface driver dvb_usb_umt_010
> [   11.477142][    T1] usbcore: registered new interface driver dvb_usb_m920x
> [   11.478764][    T1] usbcore: registered new interface driver dvb_usb_digitv
> [   11.480298][    T1] usbcore: registered new interface driver dvb_usb_cxusb
> [   11.481824][    T1] usbcore: registered new interface driver dvb_usb_ttusb2
> [   11.483374][    T1] usbcore: registered new interface driver dvb_usb_dib0700
> [   11.484926][    T1] usbcore: registered new interface driver opera1
> [   11.486367][    T1] usbcore: registered new interface driver dvb_usb_af9005
> [   11.487580][    T1] failing symbol_get of non-GPLONLY symbol af9005_rc_decode.
> [   11.490776][    T1] failing symbol_get of non-GPLONLY symbol af9005_rc_decode.
> [   11.491663][    T1] failing symbol_get of non-GPLONLY symbol rc_map_af9005_table.
> [   11.498118][    T1] failing symbol_get of non-GPLONLY symbol rc_map_af9005_table.
> [   11.499043][    T1] failing symbol_get of non-GPLONLY symbol rc_map_af9005_table_size.
> [   11.505707][    T1] failing symbol_get of non-GPLONLY symbol rc_map_af9005_table_size.
> [   11.506613][    T1] af9005: af9005_rc_decode function not found, disabling remote
> [   11.506613][    T1] usbcore: registered new interface driver pctv452e
> [   11.506613][    T1] usbcore: registered new interface driver dw2102
> [   11.516894][    T1] usbcore: registered new interface driver dvb_usb_dtv5100
> [   11.519039][    T1] usbcore: registered new interface driver cinergyT2
> [   11.521006][    T1] usbcore: registered new interface driver dvb_usb_az6027
> [   11.523086][    T1] usbcore: registered new interface driver dvb_usb_technisat_usb2
> [   11.525279][    T1] usbcore: registered new interface driver dvb_usb_af9015
> [   11.527325][    T1] usbcore: registered new interface driver dvb_usb_af9035
> [   11.528690][    T1] usbcore: registered new interface driver dvb_usb_anysee
> [   11.530021][    T1] usbcore: registered new interface driver dvb_usb_au6610
> [   11.531330][    T1] usbcore: registered new interface driver dvb_usb_az6007
> [   11.532667][    T1] usbcore: registered new interface driver dvb_usb_ce6230
> [   11.533989][    T1] usbcore: registered new interface driver dvb_usb_ec168
> [   11.535288][    T1] usbcore: registered new interface driver dvb_usb_lmedm04
> [   11.536629][    T1] usbcore: registered new interface driver dvb_usb_gl861
> [   11.537979][    T1] usbcore: registered new interface driver dvb_usb_mxl111sf
> [   11.539271][    T1] usbcore: registered new interface driver dvb_usb_rtl28xxu
> [   11.540581][    T1] usbcore: registered new interface driver s2255
> [   11.541757][    T1] usbcore: registered new interface driver smsusb
> [   11.542932][    T1] usbcore: registered new interface driver ttusb
> [   11.544110][    T1] usbcore: registered new interface driver ttusb-dec
> [   11.545103][    T1] gspca_main: v2.14.0 registered
> [   11.546065][    T1] usbcore: registered new interface driver benq
> [   11.547250][    T1] usbcore: registered new interface driver conex
> [   11.548413][    T1] usbcore: registered new interface driver cpia1
> [   11.549607][    T1] usbcore: registered new interface driver etoms
> [   11.550456][    T1] usbcore: registered new interface driver finepix
> [   11.550456][    T1] usbcore: registered new interface driver jeilinj
> [   11.550456][    T1] usbcore: registered new interface driver jl2005bcd
> [   11.550456][    T1] usbcore: registered new interface driver konica
> [   11.550456][    T1] usbcore: registered new interface driver mars
> [   11.550456][    T1] usbcore: registered new interface driver mr97310a
> [   11.550456][    T1] usbcore: registered new interface driver nw80x
> [   11.550456][    T1] usbcore: registered new interface driver ov519
> [   11.550456][    T1] usbcore: registered new interface driver ov534
> [   11.550456][    T1] usbcore: registered new interface driver ov534_9
> [   11.550456][    T1] usbcore: registered new interface driver pac207
> [   11.550456][    T1] usbcore: registered new interface driver gspca_pac7302
> [   11.550456][    T1] usbcore: registered new interface driver pac7311
> [   11.550456][    T1] usbcore: registered new interface driver se401
> [   11.550456][    T1] usbcore: registered new interface driver sn9c2028
> [   11.550456][    T1] usbcore: registered new interface driver gspca_sn9c20x
> [   11.550456][    T1] usbcore: registered new interface driver sonixb
> [   11.550456][    T1] usbcore: registered new interface driver sonixj
> [   11.550456][    T1] usbcore: registered new interface driver spca500
> [   11.550456][    T1] usbcore: registered new interface driver spca501
> [   11.550456][    T1] usbcore: registered new interface driver spca505
> [   11.550456][    T1] usbcore: registered new interface driver spca506
> [   11.550456][    T1] usbcore: registered new interface driver spca508
> [   11.550456][    T1] usbcore: registered new interface driver spca561
> [   11.550456][    T1] usbcore: registered new interface driver spca1528
> [   11.550456][    T1] usbcore: registered new interface driver sq905
> [   11.550456][    T1] usbcore: registered new interface driver sq905c
> [   11.550456][    T1] usbcore: registered new interface driver sq930x
> [   11.550456][    T1] usbcore: registered new interface driver sunplus
> [   11.550456][    T1] usbcore: registered new interface driver stk014
> [   11.550456][    T1] usbcore: registered new interface driver stv0680
> [   11.550456][    T1] usbcore: registered new interface driver t613
> [   11.550456][    T1] usbcore: registered new interface driver gspca_topro
> [   11.550456][    T1] usbcore: registered new interface driver tv8532
> [   11.550456][    T1] usbcore: registered new interface driver vc032x
> [   11.550456][    T1] usbcore: registered new interface driver vicam
> [   11.550456][    T1] usbcore: registered new interface driver xirlink-cit
> [   11.550456][    T1] usbcore: registered new interface driver gspca_zc3xx
> [   11.550456][    T1] usbcore: registered new interface driver ALi m5602
> [   11.550456][    T1] usbcore: registered new interface driver STV06xx
> [   11.550456][    T1] usbcore: registered new interface driver gspca_gl860
> [   11.550456][    T1] usbcore: registered new interface driver Philips webcam
> [   11.550456][    T1] usbcore: registered new interface driver uvcvideo
> [   11.550456][    T1] au0828: au0828 driver loaded
> [   11.550456][    T1] usbcore: registered new interface driver au0828
> [   11.550456][    T1] usbcore: registered new interface driver cx231xx
> [   11.550456][    T1] usbcore: registered new interface driver em28xx
> [   11.550456][    T1] em28xx: Registered (Em28xx Audio Extension) extension
> [   11.550456][    T1] em28xx: Registered (Em28xx dvb Extension) extension
> [   11.550456][    T1] em28xx: Registered (Em28xx Input Extension) extension
> [   11.550456][    T1] usbcore: registered new interface driver hdpvr
> [   11.611206][    T1] usbcore: registered new interface driver pvrusb2
> [   11.611825][    T1] pvrusb2: V4L in-tree version:Hauppauge WinTV-PVR-USB2 MPEG2 Encoder/Tuner
> [   11.611825][    T1] pvrusb2: Debug mask is 31 (0x1f)
> [   11.611825][    T1] pps_ldisc: PPS line discipline registered
> [   11.611825][    T1] parport0: cannot grant exclusive access for device pps_parport
> [   11.611825][    T1] pps_parport: couldn't register with parport0
> [   11.682173][    T1] applesmc: supported laptop not found!
> [   11.683074][    T1] applesmc: driver init failed (ret=-19)!
> [   11.858034][    T1] pc87360: PC8736x not detected, module not inserted
> [   11.901092][    T1] intel_powerclamp: CPU does not support MWAIT
> [   11.901092][    T1] usbcore: registered new interface driver pcwd_usb
> [   11.901092][    T1] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
> [   11.901092][    T1] alim7101_wdt: ALi M7101 PMU not present - WDT not set
> [   11.901092][    T1] ib700wdt: WDT driver for IB700 single board computer initialising
> [   11.921365][    T1] iTCO_vendor_support: vendor-support=0
> [   11.921385][    T1] it87_wdt: no device
> [   11.921385][    T1] nv_tco: NV TCO WatchDog Timer Driver v0.01
> [   11.921385][    T1] w83877f_wdt: I/O address 0x0443 already in use
> [   11.921385][    T1] w83977f_wdt: driver v1.00
> [   11.921385][    T1] w83977f_wdt: cannot register miscdev on minor=130 (err=-16)
> [   11.921385][    T1] machzwd: MachZ ZF-Logic Watchdog driver initializing
> [   11.921385][    T1] machzwd: no ZF-Logic found
> [   11.921385][    T1] watchdog: Software Watchdog: cannot register miscdev on minor=130 (err=-16).
> [   11.921385][    T1] watchdog: Software Watchdog: a legacy watchdog module is probably present.
> [   11.936161][    T1] softdog: initialized. soft_noboot=0 soft_margin=60 sec soft_panic=0 (nowayout=0)
> [   11.937096][    T1] softdog:              soft_reboot_cmd=<not set> soft_active_on_boot=0
> [   11.941015][    T1] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> [   11.941834][    T1] device-mapper: uevent: version 1.0.3
> [   11.944671][    T1] device-mapper: ioctl: 4.49.0-ioctl (2025-01-17) initialised: dm-devel@lists.linux.dev
> [   11.947130][    T1] device-mapper: multipath round-robin: version 1.2.0 loaded
> [   11.947974][    T1] device-mapper: multipath queue-length: version 0.2.0 loaded
> [   11.948066][    T1] device-mapper: multipath service-time: version 0.3.0 loaded
> [   11.948066][    T1] device-mapper: dm-log-userspace: version 1.3.0 loaded
> [   11.948066][    T1] Modular ISDN core version 1.1.29
> [   11.951878][    T1] NET: Registered PF_ISDN protocol family
> [   11.952521][    T1] DSP module 2.0
> [   11.952798][    T1] mISDN_dsp: DSP clocks every 64 samples. This equals 8 jiffies.
> [   11.952798][    T1] mISDN: Layer-1-over-IP driver Rev. 2.00
> [   11.952798][    T1] 0 virtual devices registered
> [   11.952798][    T1] mISDN: HFC-multi driver 2.03
> [   11.952798][    T1] usbcore: registered new interface driver HFC-S_USB
> [   11.952798][    T1] AVM Fritz PCI driver Rev. 2.3
> [   11.952798][    T1] Sedlbauer Speedfax+ Driver Rev. 2.0
> [   11.952798][    T1] Infineon ISDN Driver Rev. 1.0
> [   11.952798][    T1] Winbond W6692 PCI driver Rev. 2.0
> [   11.952798][    T1] Netjet PCI driver Rev. 2.0
> [   11.952798][    T1] mISDNipac module version 2.0
> [   11.952798][    T1] mISDN: ISAR driver Rev. 2.1
> [   11.952798][    T1] intel_pstate: CPU model not supported
> [   11.952798][    T1] sdhci: Secure Digital Host Controller Interface driver
> [   11.952798][    T1] sdhci: Copyright(c) Pierre Ossman
> [   11.952798][    T1] VUB300 Driver rom wait states = 1C irqpoll timeout = 0400
> [   11.980010][    T1] usbcore: registered new interface driver vub300
> [   11.980772][    T1] usbcore: registered new interface driver ushc
> [   11.980772][    T1] sdhci-pltfm: SDHCI platform and OF driver helper
> [   11.985526][    T1] No iBFT detected.
> [   11.985526][    T1] efifb: probing for efifb
> [   11.985526][    T1] efifb: framebuffer at 0xc0000000, using 1876k, total 1875k
> [   11.985526][    T1] efifb: mode is 800x600x32, linelength=3200, pages=1
> [   11.985526][    T1] efifb: scrolling: redraw
> [   11.985526][    T1] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [   11.994716][    T1] Console: switching to colour frame buffer device 100x37
> [   11.994716][    T1] fb0: EFI VGA frame buffer device
> [   11.994716][    T1] ccp_crypto: Cannot load: there are no available CCPs
> [   12.009936][    T1] hid: raw HID events driver (C) Jiri Kosina
> [   12.015904][    T1] hv_vmbus: registering driver hid_hyperv
> [   12.015904][    T1] usbcore: registered new interface driver usbhid
> [   12.015904][    T1] usbhid: USB HID core driver
> [   12.015904][    T1] acerhdf: Acer Aspire One Fan driver, v.0.7.0
> [   12.015904][    T1] acerhdf: unknown (unsupported) BIOS version QEMU/Ubuntu 24.04 PC (i440FX + PIIX, 1996)/0.0.0, please report, aborting!
> [   12.015904][    T1] acer_wmi: Acer Laptop ACPI-WMI Extras
> [   12.015904][    T1] acer_wmi: No or unsupported WMI interface, unable to load
> [   12.015904][    T1] asus_wmi: ASUS WMI generic driver loaded
> [   12.015904][    T1] asus_wmi: ASUS Management GUID not found
> [   12.015904][    T1] asus_wmi: ASUS Management GUID not found
> [   12.015904][    T1] fujitsu_laptop: driver 0.6.0 successfully loaded
> [   12.015904][    T1] fujitsu_tablet: Unknown (using defaults)
> [   12.015904][    T1] hdaps: supported laptop not found!
> [   12.015904][    T1] hdaps: driver init failed (ret=-19)!
> [   12.042088][    T1] intel_oaktrail: Platform not recognized (You could try the module's force-parameter)
> [   12.042088][    T1] msi_wmi: This machine doesn't have neither MSI-hotkeys nor backlight through WMI
> [   12.042088][    T1] compal_laptop: Motherboard not recognized (You could try the module's force-parameter)
> [   12.042088][    T1] topstar_laptop: ACPI extras driver loaded
> [   12.042088][    T1] hv_utils: Registering HyperV Utility Driver
> [   12.042088][    T1] hv_vmbus: registering driver hv_utils
> [   12.042088][    T1] hv_vmbus: registering driver hv_balloon
> [   12.042088][    T1] Intel(R) PCI-E Non-Transparent Bridge Driver 2.0
> [   12.042088][    T1] Software Queue-Pair Transport over NTB, version 4
> [   12.093696][    T1] snd_mtpav snd_mtpav: MTVAP port 0x378 is busy
> [   12.093696][    T1] snd_mtpav snd_mtpav: probe with driver snd_mtpav failed with error -16
> [   12.093696][    T1] Error: Driver 'pcspkr' is already registered, aborting...
> [   12.093696][    T1] ASIHPI driver 4.14.03
> [   12.093696][    T1] usbcore: registered new interface driver snd-usb-audio
> [   12.093696][    T1] usbcore: registered new interface driver snd-ua101
> [   12.093696][    T1] usbcore: registered new interface driver snd-usb-usx2y
> [   12.093696][    T1] usbcore: registered new interface driver snd-usb-us122l
> [   12.093696][    T1] usbcore: registered new interface driver snd-usb-caiaq
> [   12.093696][    T1] usbcore: registered new interface driver snd-usb-6fire
> [   12.093696][    T1] usbcore: registered new interface driver snd-usb-hiface
> [   12.093696][    T1] usbcore: registered new interface driver snd-bcd2000
> [   12.093696][    T1] usbcore: registered new interface driver snd_usb_pod
> [   12.093696][    T1] usbcore: registered new interface driver snd_usb_podhd
> [   12.093696][    T1] usbcore: registered new interface driver snd_usb_toneport
> [   12.093696][    T1] usbcore: registered new interface driver snd_usb_variax
> [   12.093696][    T1] pktgen: Packet Generator for packet performance testing. Version: 2.75
> [   12.125278][    T1] drop_monitor: Initializing network drop monitor service
> [   12.126258][    T1] GACT probability on
> [   12.126266][    T1] Mirror/redirect action on
> [   12.126266][    T1] Simple TC action Loaded
> [   12.126266][    T1] netem: version 1.3
> [   12.126266][    T1] u32 classifier
> [   12.126266][    T1]     Performance counters on
> [   12.126266][    T1]     input device check on
> [   12.126266][    T1]     Actions configured
> [   12.126266][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
> [   12.126266][    T1] IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
> [   12.126266][    T1] IPVS: ipvs loaded.
> [   12.126266][    T1] IPVS: [rr] scheduler registered.
> [   12.126266][    T1] IPVS: [wrr] scheduler registered.
> [   12.126266][    T1] IPVS: [lc] scheduler registered.
> [   12.126266][    T1] IPVS: [wlc] scheduler registered.
> [   12.126266][    T1] IPVS: [fo] scheduler registered.
> [   12.126266][    T1] IPVS: [ovf] scheduler registered.
> [   12.126266][    T1] IPVS: [lblc] scheduler registered.
> [   12.126266][    T1] IPVS: [lblcr] scheduler registered.
> [   12.126266][    T1] IPVS: [dh] scheduler registered.
> [   12.126266][    T1] IPVS: [sh] scheduler registered.
> [   12.126266][    T1] IPVS: [sed] scheduler registered.
> [   12.126266][    T1] IPVS: [nq] scheduler registered.
> [   12.126266][    T1] IPVS: [sip] pe registered.
> [   12.126266][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
> [   12.126266][    T1] gre: GRE over IPv4 demultiplexor driver
> [   12.126266][    T1] ip_gre: GRE over IPv4 tunneling driver
> [   12.153320][    T1] IPv4 over IPsec tunneling driver
> [   12.156669][    T1] Initializing XFRM netlink socket
> [   12.157319][    T1] IPsec XFRM device driver
> [   12.158213][    T1] NET: Registered PF_INET6 protocol family
> [   12.164488][    T1] Segment Routing with IPv6
> [   12.164488][    T1] In-situ OAM (IOAM) with IPv6
> [   12.164488][    T1] mip6: Mobile IPv6
> [   12.164488][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [   12.164488][    T1] ip6_gre: GRE over IPv6 tunneling driver
> [   12.164488][    T1] NET: Registered PF_PACKET protocol family
> [   12.176092][    T1] NET: Registered PF_KEY protocol family
> [   12.176897][    T1] Bridge firewalling registered
> [   12.177494][    T1] can: controller area network core
> [   12.178215][    T1] NET: Registered PF_CAN protocol family
> [   12.178854][    T1] can: raw protocol
> [   12.179282][    T1] can: broadcast manager protocol
> [   12.179869][    T1] can: netlink gateway - max_hops=1
> [   12.181032][    T1] lec:lane_module_init: lec.c: initialized
> [   12.181866][    T1] l2tp_core: L2TP core driver, V2.0
> [   12.182458][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
> [   12.182690][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
> [   12.182690][    T1] l2tp_netlink: L2TP netlink interface
> [   12.182690][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
> [   12.182690][    T1] l2tp_debugfs: L2TP debugfs support
> [   12.182690][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
> [   12.182690][    T1] 8021q: 802.1Q VLAN Support v1.8
> [   12.191820][    T1] Key type dns_resolver registered
> [   12.192448][    T1] Key type ceph registered
> [   12.193424][    T1] libceph: loaded (mon/osd proto 15/24)
> [   12.194192][    T1] openvswitch: Open vSwitch switching datapath
> [   12.195544][    T1] mpls_gso: MPLS GSO support
> [   12.211849][    T1] IPI shorthand broadcast: enabled
> [   13.141846][    T1] sched_clock: Marking stable (12946003101, 195453356)->(13187037302, -45580845)
> [   13.157173][    T1] registered taskstats version 1
> [   13.171445][    T1] Loading compiled-in X.509 certificates
> [   13.375195][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: 8bd3e4a98356365a6d82dbebcab1c0386f688aed'
> [   13.509884][    T1] Demotion targets for Node 0: null
> [   13.512905][    T1] kmemleak: Kernel memory leak detector initialized (mem pool available: 13099)
> [   13.512961][  T228] kmemleak: Automatic memory scanning thread started
> [   13.518494][    T1] Key type .fscrypt registered
> [   13.521275][    T1] Key type fscrypt-provisioning registered
> [   13.537207][    T1] Key type encrypted registered
> [   13.538131][    T1] AppArmor: AppArmor sha256 policy hashing enabled
> [   13.541112][    T1] ima: No TPM chip found, activating TPM-bypass!
> [   13.542348][    T1] Loading compiled-in module X.509 certificates
> [   13.552728][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: 8bd3e4a98356365a6d82dbebcab1c0386f688aed'
> [   13.554544][    T1] ima: Allocated hash algorithm: sha256
> [   13.555592][    T1] ima: No architecture policies found
> [   13.556948][    T1] evm: Initialising EVM extended attributes:
> [   13.557956][    T1] evm: security.selinux
> [   13.558664][    T1] evm: security.SMACK64 (disabled)
> [   13.559521][    T1] evm: security.SMACK64EXEC (disabled)
> [   13.560432][    T1] evm: security.SMACK64TRANSMUTE (disabled)
> [   13.561410][    T1] evm: security.SMACK64MMAP (disabled)
> [   13.562318][    T1] evm: security.apparmor
> [   13.563035][    T1] evm: security.ima
> [   13.563609][    T1] evm: security.capability
> [   13.564271][    T1] evm: HMAC attrs: 0x1
> [   13.704007][  T494] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
> [   13.730964][  T515] "cryptomgr_test" (515) uses obsolete ecb(arc4) skcipher
> [   13.769482][    T1] printk: legacy console [netcon0] enabled
> [   13.770896][    T1] netconsole: network logging started
> [   13.774526][    T1] saa7134_alsa: saa7134 ALSA driver for DMA sound loaded
> [   13.776195][    T1] saa7134_alsa: saa7134 ALSA: no saa7134 cards found
> [   14.010120][    T1] clk: Disabling unused clocks
> [   14.010864][    T1] ALSA device list:
> [   14.011414][    T1]   #0: Dummy 1
> [   14.011929][    T1]   #1: Loopback 1
> [   14.012479][    T1]   #2: Virtual MIDI Card 1
> [   14.015525][    T1] md: Waiting for all devices to be available before autodetect
> [   14.018553][    T1] md: If you don't use raid, use raid=noautodetect
> [   14.020746][    T1] md: Autodetecting RAID arrays.
> [   14.022514][    T1] md: autorun ...
> [   14.023713][    T1] md: ... autorun DONE.
> [   14.254405][    T1] EXT4-fs (vda): warning: mounting fs with errors, running e2fsck is recommended
> [   14.279916][    T1] EXT4-fs (vda): Errors on filesystem, clearing orphan list.
> [   14.281090][    T1] EXT4-fs (vda): recovery complete
> [   14.283948][    T1] EXT4-fs (vda): mounted filesystem e4fb7975-5ae6-4691-99af-944cd89af02d r/w with ordered data mode. Quota mode: none.
> [   14.286035][    T1] VFS: Mounted root (ext4 filesystem) on device 252:0.
> [   14.288010][    T1] devtmpfs: mounted
> [   14.289411][    T1] integrity: Unable to open file: /etc/keys/x509_ima.der (-2)
> [   14.289512][    T1] integrity: Unable to open file: /etc/keys/x509_evm.der (-2)
> [   14.408551][    T1] Freeing unused decrypted memory: 2028K
> [   14.418364][    T1] Freeing unused kernel image (initmem) memory: 26564K
> [   14.419738][    T1] Write protecting the kernel read-only data: 210944k
> [   14.425423][    T1] Freeing unused kernel image (text/rodata gap) memory: 1092K
> [   14.427556][    T1] Freeing unused kernel image (rodata/data gap) memory: 1432K
> [   14.445803][    T1] Run /sbin/init as init process
> [   14.766446][    T1] systemd[1]: systemd 245.4-4ubuntu3.18 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
> [   14.772673][    T1] systemd[1]: Detected virtualization kvm.
> [   14.774022][    T1] systemd[1]: Detected architecture x86-64.
> [   14.775258][    T1] /proc/cgroups lists only v1 controllers, use cgroup.controllers of root cgroup for v2 info
> 
> Welcome to Ubuntu 20.04.5 LTS!
> 
> [   14.809114][    T1] systemd[1]: Set hostname to <qemu>.
> [   15.567124][    T1] systemd[1]: Created slice system-getty.slice.
> [  OK  ] Created slice system-getty.slice.
> [   15.572186][    T1] systemd[1]: Created slice system-modprobe.slice.
> [  OK  ] Created slice system-modprobe.slice.
> [   15.576911][    T1] systemd[1]: Created slice system-serial\x2dgetty.slice.
> [  OK  ] Created slice system-serial\x2dgetty.slice.
> [   15.582180][    T1] systemd[1]: Created slice User and Session Slice.
> [  OK  ] Created slice User and Session Slice.
> [   15.585673][    T1] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
> [  OK  ] Started Dispatch Password ??ts to Console Directory Watch.
> [   15.589744][    T1] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [  OK  ] Started Forward Password R??uests to Wall Directory Watch.
> [   15.594988][    T1] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
> [  OK  ] Set up automount Arbitrary??s File System Automount Point.
> [   15.598631][    T1] systemd[1]: Reached target Local Encrypted Volumes.
> [  OK  ] Reached target Local Encrypted Volumes.
> [   15.601382][    T1] systemd[1]: Reached target Paths.
> [  OK  ] Reached target Paths.
> [   15.603504][    T1] systemd[1]: Reached target Remote File Systems.
> [  OK  ] Reached target Remote File Systems.
> [   15.606446][    T1] systemd[1]: Reached target Slices.
> [  OK  ] Reached target Slices.
> [   15.610820][    T1] systemd[1]: Reached target Swap.
> [  OK  ] Reached target Swap.
> [   15.617747][    T1] systemd[1]: Listening on Syslog Socket.
> [  OK  ] Listening on Syslog Socket.
> [   15.622504][    T1] systemd[1]: Listening on initctl Compatibility Named Pipe.
> [  OK  ] Listening on initctl Compatibility Named Pipe.
> [   15.630450][    T1] systemd[1]: Listening on Journal Audit Socket.
> [  OK  ] Listening on Journal Audit Socket.
> [   15.635349][    T1] systemd[1]: Listening on Journal Socket (/dev/log).
> [  OK  ] Listening on Journal Socket (/dev/log).
> [   15.640748][    T1] systemd[1]: Listening on Journal Socket.
> [  OK  ] Listening on Journal Socket.
> [   15.644627][    T1] systemd[1]: Listening on udev Control Socket.
> [  OK  ] Listening on udev Control Socket.
> [   15.648268][    T1] systemd[1]: Listening on udev Kernel Socket.
> [  OK  ] Listening on udev Kernel Socket.
> [   15.685881][    T1] systemd[1]: Mounting Huge Pages File System...
>          Mounting Huge Pages File System...
> [   15.702383][    T1] systemd[1]: Mounting POSIX Message Queue File System...
>          Mounting POSIX Message Queue File System...
> [   15.715336][    T1] systemd[1]: Mounting Kernel Debug File System...
>          Mounting Kernel Debug File System...
> [   15.730055][    T1] systemd[1]: Mounting Kernel Trace File System...
>          Mounting Kernel Trace File System...
> [   15.752433][    T1] systemd[1]: Starting Journal Service...
>          Starting Journal Service...
> [   15.756547][    T1] systemd[1]: Condition check resulted in Create list of static device nodes for the current kernel being skipped.
> [   15.765559][    T1] systemd[1]: Starting Load Kernel Module chromeos_pstore...
>          Starting Load Kernel Module chromeos_pstore...
> [   15.775040][    T1] systemd[1]: Starting Load Kernel Module drm...
>          Starting Load Kernel Module drm...
> [   15.776487][    T1] systemd[1]: Condition check resulted in Load Kernel Module efi_pstore being skipped.
> [   15.784886][    T1] systemd[1]: Starting Load Kernel Module pstore_blk...
>          Starting Load Kernel Module pstore_blk...
> [   15.806879][    T1] systemd[1]: Starting Load Kernel Module pstore_zone...
>          Starting Load Kernel Module pstore_zone...
> [   15.809682][    T1] systemd[1]: Condition check resulted in Load Kernel Module ramoops being skipped.
> [   15.812742][    T1] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
> [   15.824685][    T1] systemd[1]: Starting Load Kernel Modules...
>          Starting Load Kernel Modules...
> [   15.835283][    T1] systemd[1]: Starting Remount Root and Kernel File Systems...
>          Starting Remount Root and Kernel File Systems...
> [   15.844324][    T1] systemd[1]: Starting udev Coldplug all Devices...
>          Starting udev Coldplug all Devices...
> [   15.857207][    T1] systemd[1]: Mounted Huge Pages File System.
> [  OK  ] Mounted Huge Pages File System.
> [   15.877582][    T1] systemd[1]: Mounted POSIX Message Queue File System.
> [  OK  ] Mounted POSIX Message Queue File System.
> [   15.888037][    T1] systemd[1]: Mounted Kernel Debug File System.
> [  OK  ] Mounted Kernel Debug File System.
> [   15.894077][    T1] systemd[1]: Mounted Kernel Trace File System.
> [  OK  ] Mounted Kernel Trace File System.
> [   15.898954][    T1] systemd[1]: modprobe@chromeos_pstore.service: Succeeded.
> [   15.901197][    T1] systemd[1]: Finished Load Kernel Module chromeos_pstore.
> [  OK  ] Finished Load Kernel Module chromeos_pstore.
> [   15.906134][    T1] systemd[1]: modprobe@drm.service: Succeeded.
> [   15.908313][    T1] systemd[1]: Finished Load Kernel Module drm.
> [  OK  ] Finished Load Kernel Module drm.
> [   15.911541][    T1] systemd[1]: modprobe@pstore_blk.service: Succeeded.
> [   15.915674][    T1] systemd[1]: Finished Load Kernel Module pstore_blk.
> [  OK  ] Finished Load Kernel Module pstore_blk.
> [   15.919011][    T1] systemd[1]: modprobe@pstore_zone.service: Succeeded.
> [   15.921233][    T1] systemd[1]: Finished Load Kernel Module pstore_zone.
> [  OK  ] Finished Load Kernel Module pstore_zone.
> [   15.927635][    T1] systemd[1]: Finished Load Kernel Modules.
> [  OK  ] Finished Load Kernel Modules.
> [   15.931846][    T1] systemd[1]: Finished Remount Root and Kernel File Systems.
> [  OK  ] Finished Remount Root and Kernel File Systems.
> [   15.964500][    T1] systemd[1]: Mounting FUSE Control File System...
>          Mounting FUSE Control File System...
> [   15.976537][    T1] systemd[1]: Mounting Kernel Configuration File System...
>          Mounting Kernel Configuration File System...
> [   15.982340][    T1] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
> [   15.983325][    T1] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
> [   16.002607][    T1] systemd[1]: Starting Load/Save Random Seed...
>          Starting Load/Save Random Seed...
> [   16.014146][    T1] systemd[1]: Starting Apply Kernel Variables...
>          Starting Apply Kernel Variables...
> [   16.026579][    T1] systemd[1]: Starting Create System Users...
>          Starting Create System Users...
> [   16.035240][    T1] systemd[1]: Started Journal Service.
> [  OK  ] Started Journal Service.
> [  OK  ] Mounted FUSE Control File System.
> [  OK  ] Mounted Kernel Configuration File System.
>          Starting Flush Journal to Persistent Storage...
> [   16.117044][  T572] systemd-journald[572]: Received client request to flush runtime journal.
> [  OK  ] Finished Load/Save Random Seed.
> [  OK  ] Finished Apply Kernel Variables.
> [  OK  ] Finished Create System Users.
>          Starting Create Static Device Nodes in /dev...
> [  OK  ] Finished Create Static Device Nodes in /dev.
> [  OK  ] Reached target Local File Systems (Pre).
> [  OK  ] Reached target Local File Systems.
>          Starting udev Kernel Device Manager...
> [  OK  ] Finished Flush Journal to Persistent Storage.
>          Starting Create Volatile Files and Directories...
> [  OK  ] Started udev Kernel Device Manager.
> [  OK  ] Finished Create Volatile Files and Directories.
>          Starting Network Name Resolution...
>          Starting Network Time Synchronization...
>          Starting Update UTMP about System Boot/Shutdown...
> [  OK  ] Finished Update UTMP about System Boot/Shutdown.
> [  OK  ] Started Network Time Synchronization.
> [  OK  ] Reached target System Time Set.
> [  OK  ] Reached target System Time Synchronized.
> [  OK  ] Started Network Name Resolution.
> [  OK  ] Reached target Host and Network Name Lookups.
> [  OK  ] Finished udev Coldplug all Devices.
> [  OK  ] Reached target System Initialization.
> [  OK  ] Started Daily apt download activities.
> [  OK  ] Started Daily apt upgrade and clean activities.
> [  OK  ] Started Periodic ext4 Onli??ata Check for All Filesystems.
> [  OK  ] Started Discard unused blocks once a week.
> [  OK  ] Started Daily rotation of log files.
> [  OK  ] Started Message of the Day.
> [  OK  ] Started Daily Cleanup of Temporary Directories.
> [  OK  ] Reached target Timers.
> [  OK  ] Listening on D-Bus System Message Bus Socket.
> [  OK  ] Reached target Sockets.
> [  OK  ] Reached target Basic System.
> [  OK  ] Started Regular background program processing daemon.
> [  OK  ] Started D-Bus System Message Bus.
>          Starting Network Manager...
> [  OK  ] Started Save initial kernel messages after boot.
>          Starting Remove Stale Onli??t4 Metadata Check Snapshots...
>          Starting Helper to synchronize boot up for ifupdown...
>          Starting LSB: Execute the ??-e command to reboot system...
>          Starting Dispatcher daemon for systemd-networkd...
>          Starting Authorization Manager...
>          Starting Restore /etc/reso?? the ppp link was shut down...
>          Starting System Logging Service...
>          Starting Resets System Activity Data Collector...
>          Starting Login Service...
>          Starting WPA supplicant...
> [  OK  ] Finished Restore /etc/reso??re the ppp link was shut down.
> [  OK  ] Finished Resets System Activity Data Collector.
> [  OK  ] Started System Logging Service.
> [  OK  ] Started WPA supplicant.
> [  OK  ] Started Network Manager.
> [  OK  ] Started Authorization Manager.
>          Starting Modem Manager...
> [  OK  ] Started LSB: Execute the k??c -e command to reboot system.
>          Starting LSB: Load kernel image with kexec...
> [  OK  ] Started LSB: Load kernel image with kexec.
> [  OK  ] Started Modem Manager.
>          Starting Hostname Service...
> [  OK  ] Started Dispatcher daemon for systemd-networkd.
> [  OK  ] Finished Remove Stale Onli??ext4 Metadata Check Snapshots.
> [  OK  ] Started Login Service.
> [  OK  ] Started Hostname Service.
>          Starting Network Manager Script Dispatcher Service...
> [  OK  ] Started Network Manager Script Dispatcher Service.
> [  OK  ] Reached target Sound Card.
> [  OK  ] Reached target Printer.
> [  OK  ] Found device /dev/ttyS0.
> [  OK  ] Listening on Load/Save RF ??itch Status /dev/rfkill Watch.
> [  OK  ] Finished Helper to synchronize boot up for ifupdown.
>          Starting Raise network interfaces...
> [FAILED] Failed to start Raise network interfaces.
> See 'systemctl status networking.service' for details.
> [  OK  ] Reached target Network.
>          Starting OpenBSD Secure Shell server...
>          Starting Permit User Sessions...
> [  OK  ] Finished Permit User Sessions.
> [  OK  ] Started Getty on tty1.
> [  OK  ] Started Serial Getty on ttyS0.
> [  OK  ] Reached target Login Prompts.
> 
> Ubuntu 20.04.5 LTS qemu ttyS0
> 
> qemu login: 
> 
> 
> .... skip unrelated log .....
> 
> 
> [  172.045217][ T6378] overlay: filesystem on ./file0 not supported as upperdir
> [  172.046704][ T6378] overlay: filesystem on ./file0 not supported as upperdir
> [  172.054360][ T6378] overlay: filesystem on ./file0 not supported as upperdir
> [  172.060124][ T6378] overlay: filesystem on ./file0 not supported as upperdir
> [  172.068280][ T6378] overlay: filesystem on ./file0 not supported as upperdir
> [  172.071691][ T6378] overlay: filesystem on ./file0 not supported as upperdir
> [  172.082069][ T6378] overlay: filesystem on ./file0 not supported as upperdir
> [  172.087936][ T6378] overlay: filesystem on ./file0 not supported as upperdir
> [  172.110142][ T1281] bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
> [  172.120287][ T1281] bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
> [  172.128148][ T1281] bond0 (unregistering): Released all slaves
> [  172.130452][ T1176] netdevsim netdevsim5 eni5np2: renamed from eth1
> [  172.137979][ T3523] netdevsim netdevsim5 eni5np1: renamed from eth0
> [  172.154779][ T1281] veth1_macvtap: left promiscuous mode
> [  172.155290][ T1281] veth0_macvtap: left promiscuous mode
> [  172.155838][ T1281] veth1_vlan: left promiscuous mode
> [  172.156303][ T1281] veth0_vlan: left promiscuous mode
> [  172.178241][ T6429] netlink: 'syz.7.548': attribute type 17 has an invalid length.
> [  172.258919][ T4624] veth0_vlan: entered promiscuous mode
> [  172.268448][ T5244] netdevsim netdevsim2 netdevsim0: renamed from eth0
> [  172.274348][ T5244] netdevsim netdevsim2 netdevsim1: renamed from eth1
> [  172.310019][ T6380] : renamed from bridge_slave_1 (while UP)
> [  172.312968][ T1286] bridge0: port 1(bridge_slave_0) entered blocking state
> [  172.313629][ T1286] bridge0: port 1(bridge_slave_0) entered forwarding state
> [  172.349057][ T3989] netdevsim netdevsim5 eni5np4: renamed from eth3
> [  172.363860][ T4624] veth1_vlan: entered promiscuous mode
> [  172.373334][   T47] bridge0: port 2(bridge_slave_1) entered blocking state
> [  172.374003][   T47] bridge0: port 2(bridge_slave_1) entered forwarding state
> [  172.385261][ T5244] netdevsim netdevsim2 netdevsim2: renamed from eth2
> [  172.417330][   T53] audit: type=1326 audit(1749004377.447:59): auid=0 uid=0 gid=0 ses=1 subj=unconfined pid=6472 comm="syz.0.559" exe="/root/syzkaller/syz-executor" sig=31 arch=c000003e syscall=202 compat=0 ip=0x54d2cd code=0x0
> [  172.487402][ T5244] netdevsim netdevsim2 netdevsim3: renamed from eth3
> [  172.599719][ T5469] netdevsim netdevsim13 netdevsim0: renamed from eth0
> [  232.663579][    C1] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  232.664238][    C1] rcu: 	2-...!: (1 GPs behind) idle=e984/1/0x4000000000000000 softirq=13264/13265 fqs=1
> [  232.665080][    C1] rcu: 	(detected by 1, t=60003 jiffies, g=45681, q=6747 ncpus=4)
> [  232.665724][    C1] Sending NMI from CPU 1 to CPUs 2:
> [  232.665754][    C2] NMI backtrace for cpu 2
> [  232.665766][    C2] CPU: 2 UID: 0 PID: 1271 Comm: syz-executor Not tainted 6.15.0-rc7 #9 PREEMPT(undef) 
> [  232.665778][    C2] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [  232.665783][    C2] RIP: 0010:__irq_work_queue_local+0x41/0x2a0
> [  232.665815][    C2] Code: 48 89 ef e8 41 9b 4e 00 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 0f b6 14 02 48 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 <84> d2 0f 85 0b 02 00 00 8b 6b 08 31 ff 83 e5 04 89 ee e8 b8 01 e5
> [  232.665824][    C2] RSP: 0018:ff11000119708db0 EFLAGS: 00000006
> [  232.665832][    C2] RAX: 0000000000000003 RBX: ff11000119742170 RCX: ffffffffa2a4269f
> [  232.665838][    C2] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ff11000119742178
> [  232.665844][    C2] RBP: ff11000119742178 R08: 0000000000000000 R09: ffe21c00232e842f
> [  232.665850][    C2] R10: ff1100011974217b R11: ff11000119708ff8 R12: ff11000119742170
> [  232.665856][    C2] R13: 0000000000000002 R14: ffa00000046c6001 R15: 0000000000000000
> [  232.665862][    C2] FS:  000000002ae69500(0000) GS:ff110001659aa000(0000) knlGS:0000000000000000
> [  232.665871][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  232.665878][    C2] CR2: 00000000012c56c0 CR3: 0000000026591003 CR4: 0000000000771ef0
> [  232.665884][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  232.665889][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  232.665895][    C2] PKRU: 00000000
> [  232.665898][    C2] Call Trace:
> [  232.665903][    C2]  <IRQ>
> [  232.665910][    C2]  irq_work_queue_on+0x184/0x1b0
> [  232.665923][    C2]  bpf_trace_run2+0x1c3/0x370
> [  232.665934][    C2]  ? __pfx_tick_nohz_handler+0x10/0x10
> [  232.665945][    C2]  ? __pfx_bpf_trace_run2+0x10/0x10
> [  232.665956][    C2]  ? _raw_spin_lock_irqsave+0x8a/0xe0
> [  232.665971][    C2]  __bpf_trace_tick_stop+0xb3/0xf0
> [  232.665981][    C2]  ? __pfx___bpf_trace_tick_stop+0x10/0x10
> [  232.665991][    C2]  ? sched_clock_cpu+0x19/0x1d0
> [  232.666005][    C2]  ? rcu_report_qs_rdp+0x2e7/0x380
> [  232.666018][    C2]  ? kvm_sched_clock_read+0x16/0x30
> [  232.666028][    C2]  check_tick_dependency+0x40a/0x670
> [  232.666039][    C2]  __tick_nohz_full_update_tick+0xcc/0x210
> [  232.666050][    C2]  tick_nohz_irq_exit+0x1e6/0x240
> [  232.666062][    C2]  sysvec_irq_work+0xa4/0xb0
> [  232.666075][    C2]  </IRQ>
> [  232.666078][    C2]  <TASK>
> [  232.666081][    C2]  asm_sysvec_irq_work+0x1a/0x20
> [  232.666092][    C2] RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x80
> [  232.666104][    C2] Code: 48 89 70 18 5b 5d 41 5c 41 5d c3 cc cc cc cc 48 c7 c0 f4 ff ff ff eb 92 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 0c 24 65 48 8b 15 78 ae 4e 11 65 8b 05 89 ae 4e
> [  232.666112][    C2] RSP: 0018:ff110000023c7af0 EFLAGS: 00000202
> [  232.666119][    C2] RAX: 0000000000000000 RBX: 0000000000000010 RCX: ffffffffa256dcae
> [  232.666125][    C2] RDX: ff1100010952a180 RSI: 0000000000000000 RDI: ff11000001f42600
> [  232.666131][    C2] RBP: ff11000001f42698 R08: 0000000000000001 R09: ffe21c0000478f5b
> [  232.666137][    C2] R10: 0000000080000001 R11: 0000000000000000 R12: ff11000001f42688
> [  232.666142][    C2] R13: 0000000000000004 R14: ff11000001f42600 R15: 0000000000400000
> [  232.666150][    C2]  ? alloc_pid+0x8be/0xc20
> [  232.666169][    C2]  pidfs_add_pid+0x1b/0x340
> [  232.666183][    C2]  alloc_pid+0x8d7/0xc20
> [  232.666195][    C2]  copy_process+0x27de/0x5030
> [  232.666207][    C2]  ? __pfx_copy_process+0x10/0x10
> [  232.666215][    C2]  ? handle_pte_fault+0x46c/0x8a0
> [  232.666230][    C2]  ? __virt_addr_valid+0xf0/0x190
> [  232.666240][    C2]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [  232.666253][    C2]  kernel_clone+0xe8/0x930
> [  232.666262][    C2]  ? __pfx_kernel_clone+0x10/0x10
> [  232.666271][    C2]  ? __pfx___handle_mm_fault+0x10/0x10
> [  232.666286][    C2]  __do_sys_clone+0xce/0x120
> [  232.666296][    C2]  ? __pfx___do_sys_clone+0x10/0x10
> [  232.666308][    C2]  ? get_vtime_delta+0x11a/0x240
> [  232.666317][    C2]  ? vtime_user_exit+0x5b/0x170
> [  232.666331][    C2]  ? ct_kernel_enter.constprop.0+0x89/0xe0
> [  232.666343][    C2]  do_syscall_64+0x5f/0x170
> [  232.666353][    C2]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  232.666363][    C2] RIP: 0033:0x57d1b7
> [  232.666375][    C2] Code: 5d c3 90 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 39 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
> [  232.666384][    C2] RSP: 002b:00007ffcc87ccdc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> [  232.666392][    C2] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000057d1b7
> [  232.666398][    C2] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> [  232.666404][    C2] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> [  232.666409][    C2] R10: 000000002ae697d0 R11: 0000000000000246 R12: 0000000000000001
> [  232.666415][    C2] R13: 000000000002a17a R14: 0000000000000000 R15: 0000000000000032
> [  232.666424][    C2]  </TASK>
> [  232.666737][    C1] rcu: rcu_preempt kthread starved for 59811 jiffies! g45681 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> [  232.706098][    C1] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> [  232.706894][    C1] rcu: RCU grace-period kthread stack dump:
> [  232.707370][    C1] task:rcu_preempt     state:R  running task     stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00004000
> [  232.708446][    C1] Call Trace:
> [  232.708719][    C1]  <TASK>
> [  232.708966][    C1]  __schedule+0x80a/0x1a50
> [  232.709341][    C1]  ? __pfx___schedule+0x10/0x10
> [  232.709741][    C1]  ? __pfx___mod_timer+0x10/0x10
> [  232.710148][    C1]  ? __pfx___try_to_del_timer_sync+0x10/0x10
> [  232.710642][    C1]  ? _raw_spin_lock_irqsave+0x8a/0xe0
> [  232.711082][    C1]  schedule+0x6b/0x180
> [  232.711424][    C1]  schedule_timeout+0x116/0x240
> [  232.711830][    C1]  ? __pfx_schedule_timeout+0x10/0x10
> [  232.712277][    C1]  ? __pfx_process_timeout+0x10/0x10
> [  232.712715][    C1]  ? prepare_to_swait_event+0xb7/0x440
> [  232.713167][    C1]  rcu_gp_fqs_loop+0x193/0x780
> [  232.713564][    C1]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10
> [  232.714001][    C1]  rcu_gp_kthread+0x270/0x3a0
> [  232.714394][    C1]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [  232.714822][    C1]  ? __pfx_kthread_affine_node+0x10/0x10
> [  232.715286][    C1]  ? __kthread_parkme+0x143/0x1c0
> [  232.715698][    C1]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [  232.716125][    C1]  kthread+0x3c0/0x4e0
> [  232.716468][    C1]  ? __pfx_kthread+0x10/0x10
> [  232.716881][    C1]  ret_from_fork+0x4d/0x80
> [  232.717252][    C1]  ? __pfx_kthread+0x10/0x10
> [  232.717637][    C1]  ret_from_fork_asm+0x1a/0x30
> [  232.718033][    C1]  </TASK>
> [  232.718290][    C1] rcu: Stack dump where RCU GP kthread last ran:
> [  232.718799][    C1] CPU: 1 UID: 0 PID: 1286 Comm: kworker/u16:8 Not tainted 6.15.0-rc7 #9 PREEMPT(undef) 
> [  232.719579][    C1] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [  232.720322][    C1] Workqueue: events_unbound call_usermodehelper_exec_work
> [  232.720901][    C1] RIP: 0010:queued_spin_lock_slowpath+0x243/0xa90
> [  232.721438][    C1] Code: 02 48 89 e8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 e8 07 00 00 b8 01 00 00 00 66 89 45 00 e9 c2 fe ff ff 89 44 24 38 f3 90 <e9> 5e fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03
> [  232.722977][    C1] RSP: 0018:ff11000001baf7a8 EFLAGS: 00000202
> [  232.723474][    C1] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffffab2e0c33
> [  232.724111][    C1] RDX: fffffbfff5d81829 RSI: 0000000000000004 RDI: ffffffffaec0c140
> [  232.724753][    C1] RBP: ffffffffaec0c140 R08: 0000000000000000 R09: fffffbfff5d81828
> [  232.725394][    C1] R10: ffffffffaec0c143 R11: 0000000000000000 R12: 1fe2200000375ef6
> [  232.726033][    C1] R13: 0000000000000003 R14: fffffbfff5d81828 R15: ff11000001baf7e0
> [  232.726673][    C1] FS:  0000000000000000(0000) GS:ff1100016592a000(0000) knlGS:0000000000000000
> [  232.727389][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  232.727924][    C1] CR2: 00007f6da92d83b8 CR3: 0000000053ecc003 CR4: 0000000000771ef0
> [  232.728571][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  232.729221][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  232.729858][    C1] PKRU: 55555554
> [  232.730153][    C1] Call Trace:
> [  232.730429][    C1]  <TASK>
> [  232.730674][    C1]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
> [  232.731184][    C1]  ? kmem_cache_free+0x134/0x4f0
> [  232.731593][    C1]  ? __cleanup_sighand+0x78/0xa0
> [  232.732002][    C1]  ? __change_pid+0x2f4/0x560
> [  232.732396][    C1]  _raw_spin_lock+0xce/0xe0
> [  232.732771][    C1]  ? __pfx__raw_spin_lock+0x10/0x10
> [  232.733202][    C1]  ? blake2s_update+0x14b/0x1f0
> [  232.733608][    C1]  free_pid+0x3b/0x260
> [  232.733948][    C1]  ? __pfx_add_device_randomness+0x10/0x10
> [  232.734434][    C1]  free_pids+0x4a/0x80
> [  232.734775][    C1]  release_task+0x31e/0x670
> [  232.735152][    C1]  ? __pfx_release_task+0x10/0x10
> [  232.735570][    C1]  ? __pfx_thread_group_cputime_adjusted+0x10/0x10
> [  232.736103][    C1]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  232.736562][    C1]  wait_task_zombie+0x1527/0x20f0
> [  232.736978][    C1]  ? set_next_entity+0x309/0x610
> [  232.737390][    C1]  ? __pfx_wait_task_zombie+0x10/0x10
> [  232.737830][    C1]  ? finish_task_switch.isra.0+0x148/0x770
> [  232.738329][    C1]  wait_consider_task+0x4d7/0x690
> [  232.738774][    C1]  do_wait_pid+0x2ca/0x370
> [  232.739178][    C1]  __do_wait+0x4d8/0x5b0
> [  232.739545][    C1]  ? __pfx___do_wait+0x10/0x10
> [  232.739970][    C1]  do_wait+0x126/0x410
> [  232.740341][    C1]  kernel_wait+0xa4/0x160
> [  232.740732][    C1]  ? __pfx_kernel_wait+0x10/0x10
> [  232.741184][    C1]  ? __pfx_child_wait_callback+0x10/0x10
> [  232.741676][    C1]  ? __pfx___schedule+0x10/0x10
> [  232.742095][    C1]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  232.742587][    C1]  call_usermodehelper_exec_work+0xfe/0x190
> [  232.743114][    C1]  process_one_work+0x70b/0x11c0
> [  232.743559][    C1]  worker_thread+0x7bf/0xc30
> [  232.743967][    C1]  ? __pfx_worker_thread+0x10/0x10
> [  232.744424][    C1]  kthread+0x3c0/0x4e0
> [  232.744787][    C1]  ? __pfx_kthread+0x10/0x10
> [  232.745201][    C1]  ret_from_fork+0x4d/0x80
> [  232.745591][    C1]  ? __pfx_kthread+0x10/0x10
> [  232.746006][    C1]  ret_from_fork_asm+0x1a/0x30
> [  232.746432][    C1]  </TASK>
> [  301.380092][    C0] watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [systemd-udevd:3523]
> [  301.380107][    C0] Modules linked in:
> [  301.380116][    C0] CPU: 0 UID: 0 PID: 3523 Comm: systemd-udevd Not tainted 6.15.0-rc7 #9 PREEMPT(undef) 
> [  301.380128][    C0] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [  301.380133][    C0] RIP: 0010:queued_spin_lock_slowpath+0x243/0xa90
> [  301.380170][    C0] Code: 02 48 89 e8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 e8 07 00 00 b8 01 00 00 00 66 89 45 00 e9 c2 fe ff ff 89 44 24 38 f3 90 <e9> 5e fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03
> [  301.380180][    C0] RSP: 0018:ff1100002ebcf7b8 EFLAGS: 00000202
> [  301.380188][    C0] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffffab2e0c33
> [  301.380194][    C0] RDX: fffffbfff5d81829 RSI: 0000000000000004 RDI: ffffffffaec0c140
> [  301.380200][    C0] RBP: ffffffffaec0c140 R08: 0000000000000000 R09: fffffbfff5d81828
> [  301.380206][    C0] R10: ffffffffaec0c143 R11: 0000000000000000 R12: 1fe2200005d79ef8
> [  301.380213][    C0] R13: 0000000000000003 R14: fffffbfff5d81828 R15: ff1100002ebcf7f0
> [  301.380219][    C0] FS:  00007f316675b880(0000) GS:ff110001658aa000(0000) knlGS:0000000000000000
> [  301.380229][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  301.380236][    C0] CR2: 00007ffd2b7b2898 CR3: 0000000057de9002 CR4: 0000000000771ef0
> [  301.380242][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  301.380248][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  301.380254][    C0] PKRU: 55555554
> [  301.380258][    C0] Call Trace:
> [  301.380262][    C0]  <TASK>
> [  301.380265][    C0]  ? __pfx_evict+0x10/0x10
> [  301.380280][    C0]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
> [  301.380291][    C0]  ? __call_rcu_common.constprop.0+0x327/0x940
> [  301.380307][    C0]  ? _raw_spin_lock+0x84/0xe0
> [  301.380317][    C0]  ? __pfx__raw_spin_lock+0x10/0x10
> [  301.380328][    C0]  _raw_spin_lock+0xce/0xe0
> [  301.380338][    C0]  ? __pfx__raw_spin_lock+0x10/0x10
> [  301.380348][    C0]  ? blake2s_update+0x14b/0x1f0
> [  301.380361][    C0]  free_pid+0x3b/0x260
> [  301.380373][    C0]  ? __pfx_add_device_randomness+0x10/0x10
> [  301.380389][    C0]  free_pids+0x4a/0x80
> [  301.380400][    C0]  release_task+0x31e/0x670
> [  301.380412][    C0]  ? __pfx_release_task+0x10/0x10
> [  301.380422][    C0]  ? __pfx_thread_group_cputime_adjusted+0x10/0x10
> [  301.380439][    C0]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  301.380450][    C0]  ? __kernel_text_address+0x66/0xb0
> [  301.380464][    C0]  wait_task_zombie+0x1527/0x20f0
> [  301.380477][    C0]  ? __pfx_wait_task_zombie+0x10/0x10
> [  301.380487][    C0]  ? stack_trace_save+0x93/0xd0
> [  301.380498][    C0]  ? stack_depot_save_flags+0x6a/0x640
> [  301.380515][    C0]  wait_consider_task+0x4d7/0x690
> [  301.380526][    C0]  do_wait_pid+0x2ca/0x370
> [  301.380537][    C0]  __do_wait+0x4d8/0x5b0
> [  301.380548][    C0]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  301.380559][    C0]  ? __pfx___do_wait+0x10/0x10
> [  301.380570][    C0]  ? kernel_waitid_prepare+0x19e/0x3b0
> [  301.380582][    C0]  ? add_wait_queue+0x103/0x260
> [  301.380596][    C0]  do_wait+0x126/0x410
> [  301.380607][    C0]  kernel_waitid+0x106/0x170
> [  301.380619][    C0]  ? __pfx_kernel_waitid+0x10/0x10
> [  301.380631][    C0]  ? __pfx_child_wait_callback+0x10/0x10
> [  301.380645][    C0]  __do_sys_waitid+0x200/0x230
> [  301.380657][    C0]  ? __pfx___do_sys_waitid+0x10/0x10
> [  301.380668][    C0]  ? __seccomp_filter+0x117/0xca0
> [  301.380686][    C0]  ? __x64_sys_epoll_ctl+0x14f/0x1d0
> [  301.380703][    C0]  ? __secure_computing+0x1de/0x2e0
> [  301.380719][    C0]  do_syscall_64+0x5f/0x170
> [  301.380730][    C0]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  301.380741][    C0] RIP: 0033:0x7f31669e9ced
> [  301.380754][    C0] Code: eb c2 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 1d 45 31 c0 b8 f7 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 6b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
> [  301.380763][    C0] RSP: 002b:00007ffd2b7b38c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f7
> [  301.380772][    C0] RAX: ffffffffffffffda RBX: 00007ffd2b7b38e0 RCX: 00007f31669e9ced
> [  301.380778][    C0] RDX: 000055bf2691aeb0 RSI: 000000000000196f RDI: 0000000000000001
> [  301.380784][    C0] RBP: 000055bf2691ae40 R08: 0000000000000000 R09: 0000000000000000
> [  301.380790][    C0] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000000001
> [  301.380796][    C0] R13: 0000000000000007 R14: 000055bf2691aeb0 R15: 000055bf26727450
> [  301.380805][    C0]  </TASK>
> [  301.380809][    C0] Sending NMI from CPU 0 to CPUs 1-3:
> [  301.416087][    C2] NMI backtrace for cpu 2
> [  301.416099][    C2] CPU: 2 UID: 0 PID: 1271 Comm: syz-executor Not tainted 6.15.0-rc7 #9 PREEMPT(undef) 
> [  301.416111][    C2] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [  301.416117][    C2] RIP: 0010:asm_sysvec_irq_work+0x0/0x20
> [  301.416132][    C2] Code: 66 d2 4b 09 e9 b1 05 00 00 90 f3 0f 1e fa 0f 01 ca fc 6a ff e8 61 04 00 00 48 89 c4 48 89 e7 e8 f6 9f 4b 09 e9 91 05 00 00 90 <f3> 0f 1e fa 0f 01 ca fc 6a ff e8 41 04 00 00 48 89 c4 48 89 e7 e8
> [  301.416141][    C2] RSP: 0018:ff11000119708f48 EFLAGS: 00000086
> [  301.416149][    C2] RAX: ffe21c00212a5430 RBX: 00000000ffffffff RCX: 1fe22000232e578c
> [  301.416156][    C2] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ff1100011972bc60
> [  301.416162][    C2] RBP: ff110000023c7a48 R08: 000000362c06bb4c R09: ffe21c00232e57b9
> [  301.416174][    C2] R10: 0000000000000000 R11: 1fe220002281c207 R12: 0000000000000000
> [  301.416179][    C2] R13: 0000000000000200 R14: 0000000000000000 R15: 0000000000000000
> [  301.416185][    C2] FS:  000000002ae69500(0000) GS:ff110001659aa000(0000) knlGS:0000000000000000
> [  301.416195][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  301.416201][    C2] CR2: 00000000012c56c0 CR3: 0000000026591003 CR4: 0000000000771ef0
> [  301.416207][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  301.416213][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  301.416218][    C2] PKRU: 00000000
> [  301.416222][    C2] Call Trace:
> [  301.416226][    C2]  <IRQ>
> [  301.416229][    C2] RIP: 0010:handle_softirqs+0x127/0x590
> [  301.416245][    C2] Code: 00 00 00 fc ff df 48 c1 e8 03 c7 44 24 24 0a 00 00 00 48 01 f0 48 89 44 24 18 65 66 c7 05 e7 29 88 11 00 00 fb bb ff ff ff ff <49> c7 c2 c0 c0 c0 ae 41 0f bc dd 83 c3 01 4c 89 d5 0f 84 96 00 00
> [  301.416254][    C2] RSP: 0018:ff11000119708f78 EFLAGS: 00000286
> [  301.416263][    C2]  ? handle_softirqs+0xf6/0x590
> [  301.416280][    C2]  __irq_exit_rcu+0x158/0x1a0
> [  301.416294][    C2]  sysvec_irq_work+0xa4/0xb0
> [  301.416309][    C2]  </IRQ>
> [  301.416312][    C2]  <TASK>
> [  301.416315][    C2]  asm_sysvec_irq_work+0x1a/0x20
> [  301.416325][    C2] RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x80
> [  301.416337][    C2] Code: 48 89 70 18 5b 5d 41 5c 41 5d c3 cc cc cc cc 48 c7 c0 f4 ff ff ff eb 92 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 0c 24 65 48 8b 15 78 ae 4e 11 65 8b 05 89 ae 4e
> [  301.416346][    C2] RSP: 0018:ff110000023c7af0 EFLAGS: 00000202
> [  301.416353][    C2] RAX: 0000000000000000 RBX: 0000000000000010 RCX: ffffffffa256dcae
> [  301.416359][    C2] RDX: ff1100010952a180 RSI: 0000000000000000 RDI: ff11000001f42600
> [  301.416365][    C2] RBP: ff11000001f42698 R08: 0000000000000001 R09: ffe21c0000478f5b
> [  301.416371][    C2] R10: 0000000080000001 R11: 0000000000000000 R12: ff11000001f42688
> [  301.416376][    C2] R13: 0000000000000004 R14: ff11000001f42600 R15: 0000000000400000
> [  301.416384][    C2]  ? alloc_pid+0x8be/0xc20
> [  301.416397][    C2]  pidfs_add_pid+0x1b/0x340
> [  301.416410][    C2]  alloc_pid+0x8d7/0xc20
> [  301.416422][    C2]  copy_process+0x27de/0x5030
> [  301.416435][    C2]  ? __pfx_copy_process+0x10/0x10
> [  301.416443][    C2]  ? handle_pte_fault+0x46c/0x8a0
> [  301.416458][    C2]  ? __virt_addr_valid+0xf0/0x190
> [  301.416469][    C2]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [  301.416482][    C2]  kernel_clone+0xe8/0x930
> [  301.416491][    C2]  ? __pfx_kernel_clone+0x10/0x10
> [  301.416501][    C2]  ? __pfx___handle_mm_fault+0x10/0x10
> [  301.416516][    C2]  __do_sys_clone+0xce/0x120
> [  301.416526][    C2]  ? __pfx___do_sys_clone+0x10/0x10
> [  301.416538][    C2]  ? get_vtime_delta+0x11a/0x240
> [  301.416547][    C2]  ? vtime_user_exit+0x5b/0x170
> [  301.416561][    C2]  ? ct_kernel_enter.constprop.0+0x89/0xe0
> [  301.416573][    C2]  do_syscall_64+0x5f/0x170
> [  301.416584][    C2]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  301.416594][    C2] RIP: 0033:0x57d1b7
> [  301.416613][    C2] Code: 5d c3 90 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 39 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
> [  301.416621][    C2] RSP: 002b:00007ffcc87ccdc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> [  301.416630][    C2] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000057d1b7
> [  301.416636][    C2] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> [  301.416641][    C2] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> [  301.416647][    C2] R10: 000000002ae697d0 R11: 0000000000000246 R12: 0000000000000001
> [  301.416652][    C2] R13: 000000000002a17a R14: 0000000000000000 R15: 0000000000000032
> [  301.416661][    C2]  </TASK>
> [  301.416666][    C1] NMI backtrace for cpu 1
> [  301.416676][    C1] CPU: 1 UID: 0 PID: 1286 Comm: kworker/u16:8 Not tainted 6.15.0-rc7 #9 PREEMPT(undef) 
> [  301.416689][    C1] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [  301.416695][    C1] Workqueue: events_unbound call_usermodehelper_exec_work
> [  301.416713][    C1] RIP: 0010:queued_spin_lock_slowpath+0x243/0xa90
> [  301.416727][    C1] Code: 02 48 89 e8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 e8 07 00 00 b8 01 00 00 00 66 89 45 00 e9 c2 fe ff ff 89 44 24 38 f3 90 <e9> 5e fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03
> [  301.416736][    C1] RSP: 0018:ff11000001baf7a8 EFLAGS: 00000202
> [  301.416743][    C1] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffffab2e0c33
> [  301.416749][    C1] RDX: fffffbfff5d81829 RSI: 0000000000000004 RDI: ffffffffaec0c140
> [  301.416755][    C1] RBP: ffffffffaec0c140 R08: 0000000000000000 R09: fffffbfff5d81828
> [  301.416761][    C1] R10: ffffffffaec0c143 R11: 0000000000000000 R12: 1fe2200000375ef6
> [  301.416767][    C1] R13: 0000000000000003 R14: fffffbfff5d81828 R15: ff11000001baf7e0
> [  301.416773][    C1] FS:  0000000000000000(0000) GS:ff1100016592a000(0000) knlGS:0000000000000000
> [  301.416783][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  301.416789][    C1] CR2: 00007f6da92d83b8 CR3: 0000000053ecc003 CR4: 0000000000771ef0
> [  301.416795][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  301.416800][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  301.416806][    C1] PKRU: 55555554
> [  301.416809][    C1] Call Trace:
> [  301.416813][    C1]  <TASK>
> [  301.416817][    C1]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
> [  301.416829][    C1]  ? kmem_cache_free+0x134/0x4f0
> [  301.416841][    C1]  ? __cleanup_sighand+0x78/0xa0
> [  301.416850][    C1]  ? __change_pid+0x2f4/0x560
> [  301.416861][    C1]  _raw_spin_lock+0xce/0xe0
> [  301.416871][    C1]  ? __pfx__raw_spin_lock+0x10/0x10
> [  301.416880][    C1]  ? blake2s_update+0x14b/0x1f0
> [  301.416893][    C1]  free_pid+0x3b/0x260
> [  301.416904][    C1]  ? __pfx_add_device_randomness+0x10/0x10
> [  301.416919][    C1]  free_pids+0x4a/0x80
> [  301.416929][    C1]  release_task+0x31e/0x670
> [  301.416940][    C1]  ? __pfx_release_task+0x10/0x10
> [  301.416950][    C1]  ? __pfx_thread_group_cputime_adjusted+0x10/0x10
> [  301.416966][    C1]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  301.416977][    C1]  wait_task_zombie+0x1527/0x20f0
> [  301.416990][    C1]  ? set_next_entity+0x309/0x610
> [  301.417002][    C1]  ? __pfx_wait_task_zombie+0x10/0x10
> [  301.417013][    C1]  ? finish_task_switch.isra.0+0x148/0x770
> [  301.417029][    C1]  wait_consider_task+0x4d7/0x690
> [  301.417041][    C1]  do_wait_pid+0x2ca/0x370
> [  301.417051][    C1]  __do_wait+0x4d8/0x5b0
> [  301.417063][    C1]  ? __pfx___do_wait+0x10/0x10
> [  301.417075][    C1]  do_wait+0x126/0x410
> [  301.417086][    C1]  kernel_wait+0xa4/0x160
> [  301.417098][    C1]  ? __pfx_kernel_wait+0x10/0x10
> [  301.417111][    C1]  ? __pfx_child_wait_callback+0x10/0x10
> [  301.417122][    C1]  ? __pfx___schedule+0x10/0x10
> [  301.417132][    C1]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  301.417142][    C1]  call_usermodehelper_exec_work+0xfe/0x190
> [  301.417157][    C1]  process_one_work+0x70b/0x11c0
> [  301.417179][    C1]  worker_thread+0x7bf/0xc30
> [  301.417193][    C1]  ? __pfx_worker_thread+0x10/0x10
> [  301.417206][    C1]  kthread+0x3c0/0x4e0
> [  301.417217][    C1]  ? __pfx_kthread+0x10/0x10
> [  301.417228][    C1]  ret_from_fork+0x4d/0x80
> [  301.417238][    C1]  ? __pfx_kthread+0x10/0x10
> [  301.417249][    C1]  ret_from_fork_asm+0x1a/0x30
> [  301.417261][    C1]  </TASK>
> [  301.417266][    C3] NMI backtrace for cpu 3
> [  301.417275][    C3] CPU: 3 UID: 0 PID: 1294 Comm: kworker/u16:11 Not tainted 6.15.0-rc7 #9 PREEMPT(undef) 
> [  301.417287][    C3] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [  301.417293][    C3] Workqueue: events_unbound call_usermodehelper_exec_work
> [  301.417309][    C3] RIP: 0010:queued_spin_lock_slowpath+0x243/0xa90
> [  301.417322][    C3] Code: 02 48 89 e8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 e8 07 00 00 b8 01 00 00 00 66 89 45 00 e9 c2 fe ff ff 89 44 24 38 f3 90 <e9> 5e fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03
> [  301.417331][    C3] RSP: 0018:ff1100010b81f7a8 EFLAGS: 00000202
> [  301.417338][    C3] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffffab2e0c33
> [  301.417344][    C3] RDX: fffffbfff5d81829 RSI: 0000000000000004 RDI: ffffffffaec0c140
> [  301.417350][    C3] RBP: ffffffffaec0c140 R08: 0000000000000000 R09: fffffbfff5d81828
> [  301.417356][    C3] R10: ffffffffaec0c143 R11: 0000000000000000 R12: 1fe2200021703ef6
> [  301.417362][    C3] R13: 0000000000000003 R14: fffffbfff5d81828 R15: ff1100010b81f7e0
> [  301.417368][    C3] FS:  0000000000000000(0000) GS:ff11000165a2a000(0000) knlGS:0000000000000000
> [  301.417378][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  301.417384][    C3] CR2: 0000559c275fe6f8 CR3: 0000000053ecc005 CR4: 0000000000771ef0
> [  301.417390][    C3] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  301.417395][    C3] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  301.417401][    C3] PKRU: 55555554
> [  301.417404][    C3] Call Trace:
> [  301.417407][    C3]  <TASK>
> [  301.417412][    C3]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
> [  301.417423][    C3]  ? kmem_cache_free+0x134/0x4f0
> [  301.417435][    C3]  ? __cleanup_sighand+0x78/0xa0
> [  301.417443][    C3]  ? __change_pid+0x2f4/0x560
> [  301.417454][    C3]  _raw_spin_lock+0xce/0xe0
> [  301.417464][    C3]  ? __pfx__raw_spin_lock+0x10/0x10
> [  301.417474][    C3]  ? blake2s_update+0x14b/0x1f0
> [  301.417486][    C3]  free_pid+0x3b/0x260
> [  301.417496][    C3]  ? __pfx_add_device_randomness+0x10/0x10
> [  301.417511][    C3]  free_pids+0x4a/0x80
> [  301.417521][    C3]  release_task+0x31e/0x670
> [  301.417532][    C3]  ? __pfx_release_task+0x10/0x10
> [  301.417541][    C3]  ? __pfx_thread_group_cputime_adjusted+0x10/0x10
> [  301.417558][    C3]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  301.417569][    C3]  wait_task_zombie+0x1527/0x20f0
> [  301.417580][    C3]  ? __pfx_switch_mm_irqs_off+0x10/0x10
> [  301.417593][    C3]  ? __pfx_wait_task_zombie+0x10/0x10
> [  301.417604][    C3]  ? finish_task_switch.isra.0+0x148/0x770
> [  301.417620][    C3]  wait_consider_task+0x4d7/0x690
> [  301.417631][    C3]  do_wait_pid+0x2ca/0x370
> [  301.417642][    C3]  __do_wait+0x4d8/0x5b0
> [  301.417653][    C3]  ? __pfx___do_wait+0x10/0x10
> [  301.417666][    C3]  do_wait+0x126/0x410
> [  301.417677][    C3]  kernel_wait+0xa4/0x160
> [  301.417688][    C3]  ? __pfx_kernel_wait+0x10/0x10
> [  301.417701][    C3]  ? __pfx_child_wait_callback+0x10/0x10
> [  301.417712][    C3]  ? __pfx___schedule+0x10/0x10
> [  301.417721][    C3]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  301.417732][    C3]  call_usermodehelper_exec_work+0xfe/0x190
> [  301.417746][    C3]  process_one_work+0x70b/0x11c0
> [  301.417761][    C3]  worker_thread+0x7bf/0xc30
> [  301.417775][    C3]  ? __pfx_worker_thread+0x10/0x10
> [  301.417787][    C3]  kthread+0x3c0/0x4e0
> [  301.417798][    C3]  ? __pfx_kthread+0x10/0x10
> [  301.417809][    C3]  ret_from_fork+0x4d/0x80
> [  301.417817][    C3]  ? __pfx_kthread+0x10/0x10
> [  301.417828][    C3]  ret_from_fork_asm+0x1a/0x30
> [  301.417841][    C3]  </TASK>
> [  301.418073][    C0] Kernel panic - not syncing: softlockup: hung tasks
> [  301.418081][    C0] CPU: 0 UID: 0 PID: 3523 Comm: systemd-udevd Tainted: G             L      6.15.0-rc7 #9 PREEMPT(undef) 
> [  301.418095][    C0] Tainted: [L]=SOFTLOCKUP
> [  301.418098][    C0] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [  301.418103][    C0] Call Trace:
> [  301.418107][    C0]  <IRQ>
> [  301.418111][    C0]  dump_stack_lvl+0x3d/0xe0
> [  301.418126][    C0]  panic+0x6be/0x750
> [  301.418136][    C0]  ? __pfx_panic+0x10/0x10
> [  301.418148][    C0]  ? irq_work_queue+0xc4/0x100
> [  301.418162][    C0]  ? watchdog_timer_fn+0x42e/0x4f0
> [  301.418180][    C0]  watchdog_timer_fn+0x43f/0x4f0
> [  301.418193][    C0]  __run_hrtimer+0x147/0x6b0
> [  301.418206][    C0]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [  301.418219][    C0]  __hrtimer_run_queues+0x1a1/0x290
> [  301.418234][    C0]  ? __pfx___hrtimer_run_queues+0x10/0x10
> [  301.418247][    C0]  ? read_tsc+0x9/0x20
> [  301.418261][    C0]  hrtimer_interrupt+0x302/0x770
> [  301.418279][    C0]  __sysvec_apic_timer_interrupt+0x8a/0x260
> [  301.418293][    C0]  sysvec_apic_timer_interrupt+0x69/0x90
> [  301.418303][    C0]  </IRQ>
> [  301.418306][    C0]  <TASK>
> [  301.418310][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  301.418321][    C0] RIP: 0010:queued_spin_lock_slowpath+0x243/0xa90
> [  301.418333][    C0] Code: 02 48 89 e8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 e8 07 00 00 b8 01 00 00 00 66 89 45 00 e9 c2 fe ff ff 89 44 24 38 f3 90 <e9> 5e fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03
> [  301.418342][    C0] RSP: 0018:ff1100002ebcf7b8 EFLAGS: 00000202
> [  301.418350][    C0] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffffab2e0c33
> [  301.418356][    C0] RDX: fffffbfff5d81829 RSI: 0000000000000004 RDI: ffffffffaec0c140
> [  301.418362][    C0] RBP: ffffffffaec0c140 R08: 0000000000000000 R09: fffffbfff5d81828
> [  301.418369][    C0] R10: ffffffffaec0c143 R11: 0000000000000000 R12: 1fe2200005d79ef8
> [  301.418375][    C0] R13: 0000000000000003 R14: fffffbfff5d81828 R15: ff1100002ebcf7f0
> [  301.418382][    C0]  ? queued_spin_lock_slowpath+0xb3/0xa90
> [  301.418395][    C0]  ? queued_spin_lock_slowpath+0xb3/0xa90
> [  301.418405][    C0]  ? __pfx_evict+0x10/0x10
> [  301.418418][    C0]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
> [  301.418429][    C0]  ? __call_rcu_common.constprop.0+0x327/0x940
> [  301.418443][    C0]  ? _raw_spin_lock+0x84/0xe0
> [  301.418453][    C0]  ? __pfx__raw_spin_lock+0x10/0x10
> [  301.418463][    C0]  _raw_spin_lock+0xce/0xe0
> [  301.418473][    C0]  ? __pfx__raw_spin_lock+0x10/0x10
> [  301.418483][    C0]  ? blake2s_update+0x14b/0x1f0
> [  301.418495][    C0]  free_pid+0x3b/0x260
> [  301.418506][    C0]  ? __pfx_add_device_randomness+0x10/0x10
> [  301.418521][    C0]  free_pids+0x4a/0x80
> [  301.418531][    C0]  release_task+0x31e/0x670
> [  301.418542][    C0]  ? __pfx_release_task+0x10/0x10
> [  301.418552][    C0]  ? __pfx_thread_group_cputime_adjusted+0x10/0x10
> [  301.418568][    C0]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  301.418579][    C0]  ? __kernel_text_address+0x66/0xb0
> [  301.418592][    C0]  wait_task_zombie+0x1527/0x20f0
> [  301.535093][    C0]  ? __pfx_wait_task_zombie+0x10/0x10
> [  301.535584][    C0]  ? stack_trace_save+0x93/0xd0
> [  301.536013][    C0]  ? stack_depot_save_flags+0x6a/0x640
> [  301.536509][    C0]  wait_consider_task+0x4d7/0x690
> [  301.536950][    C0]  do_wait_pid+0x2ca/0x370
> [  301.537349][    C0]  __do_wait+0x4d8/0x5b0
> [  301.537727][    C0]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  301.538256][    C0]  ? __pfx___do_wait+0x10/0x10
> [  301.538685][    C0]  ? kernel_waitid_prepare+0x19e/0x3b0
> [  301.539176][    C0]  ? add_wait_queue+0x103/0x260
> [  301.539618][    C0]  do_wait+0x126/0x410
> [  301.539990][    C0]  kernel_waitid+0x106/0x170
> [  301.540411][    C0]  ? __pfx_kernel_waitid+0x10/0x10
> [  301.540863][    C0]  ? __pfx_child_wait_callback+0x10/0x10
> [  301.541366][    C0]  __do_sys_waitid+0x200/0x230
> [  301.541787][    C0]  ? __pfx___do_sys_waitid+0x10/0x10
> [  301.542276][    C0]  ? __seccomp_filter+0x117/0xca0
> [  301.542730][    C0]  ? __x64_sys_epoll_ctl+0x14f/0x1d0
> [  301.543204][    C0]  ? __secure_computing+0x1de/0x2e0
> [  301.543667][    C0]  do_syscall_64+0x5f/0x170
> [  301.544077][    C0]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  301.544611][    C0] RIP: 0033:0x7f31669e9ced
> [  301.545001][    C0] Code: eb c2 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 1d 45 31 c0 b8 f7 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 6b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
> [  301.546650][    C0] RSP: 002b:00007ffd2b7b38c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f7
> [  301.547376][    C0] RAX: ffffffffffffffda RBX: 00007ffd2b7b38e0 RCX: 00007f31669e9ced
> [  301.548051][    C0] RDX: 000055bf2691aeb0 RSI: 000000000000196f RDI: 0000000000000001
> [  301.548735][    C0] RBP: 000055bf2691ae40 R08: 0000000000000000 R09: 0000000000000000
> [  301.549419][    C0] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000000001
> [  301.550091][    C0] R13: 0000000000000007 R14: 000055bf2691aeb0 R15: 000055bf26727450
> [  301.550770][    C0]  </TASK>
> [  301.551521][    C0] Kernel Offset: 0x20e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  301.552517][    C0] ---[ end Kernel panic - not syncing: softlockup: hung tasks ]---

> [ 1894.636017][    C1]  madvise_pageout+0x1f4/0x400
> [ 1894.636030][    C1]  ? __pfx_madvise_pageout+0x10/0x10
> [ 1894.636043][    C1]  ? futex_wait+0x552/0x680
> [ 1894.636059][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [ 1894.636075][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [ 1894.636086][    C1]  ? mas_prev_setup.constprop.0+0xb4/0x530
> [ 1894.636102][    C1]  madvise_vma_behavior+0x8fa/0xe30
> [ 1894.636116][    C1]  ? __pfx_madvise_vma_behavior+0x10/0x10
> [ 1894.636129][    C1]  ? find_vma_prev+0xf5/0x170
> [ 1894.636139][    C1]  ? __pfx_find_vma_prev+0x10/0x10
> [ 1894.636151][    C1]  ? do_futex+0x135/0x360
> [ 1894.636165][    C1]  do_madvise+0x3af/0x650
> [ 1894.636178][    C1]  ? __pfx_do_madvise+0x10/0x10
> [ 1894.636190][    C1]  ? __se_sys_futex+0xf7/0x390
> [ 1894.636203][    C1]  ? kvm_steal_clock+0xca/0x100
> [ 1894.636220][    C1]  ? get_vtime_delta+0xd7/0x250
> [ 1894.636234][    C1]  __x64_sys_madvise+0xaf/0x120
> [ 1894.636246][    C1]  ? __ct_user_exit+0x70/0xe0
> [ 1894.636261][    C1]  do_syscall_64+0x59/0x110
> [ 1894.636276][    C1]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> [ 1894.636290][    C1] RIP: 0033:0x54d2cd
> [ 1894.636298][    C1] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> [ 1894.636306][    C1] RSP: 002b:00007f10a7955048 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> [ 1894.636315][    C1] RAX: ffffffffffffffda RBX: 0000000000795fa0 RCX: 000000000054d2cd
> [ 1894.636321][    C1] RDX: 0000000000000015 RSI: 0000000000003000 RDI: 0000000020001000
> [ 1894.636326][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [ 1894.636332][    C1] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000795fac
> [ 1894.636337][    C1] R13: 0000000000000000 R14: 0000000000795fa0 R15: 00007f10a7935000
> [ 1894.636346][    C1]  </TASK>
> [ 1901.634222][    C3] watchdog: BUG: soft lockup - CPU#3 stuck for 913s! [syz.8.781:8076]
> [ 1901.634947][    C3] Modules linked in:
> [ 1901.635261][    C3] CPU: 3 PID: 8076 Comm: syz.8.781 Tainted: G             L     6.6.0+ #1873
> [ 1901.635981][    C3] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [ 1901.636735][    C3] RIP: 0010:queued_spin_lock_slowpath+0x109/0x9c0
> [ 1901.637281][    C3] Code: 00 48 8b 44 24 60 65 48 2b 04 25 28 00 00 00 0f 85 ca 07 00 00 48 83 c4 68 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc f3 90 <eb> 85 81 fe 00 01 00 00 0f 84 dc 00 00 00 81 fe ff 00 00 00 0f 87
> [ 1901.638858][    C3] RSP: 0000:ff1100002900f8b0 EFLAGS: 00000202
> [ 1901.639364][    C3] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff961f5ecd
> [ 1901.640001][    C3] RDX: fffa7c000005f936 RSI: 0000000000000004 RDI: ffd40000002fc9a8
> [ 1901.640624][    C3] RBP: 0000000000000003 R08: 0000000000000000 R09: fffa7c000005f935
> [ 1901.641255][    C3] R10: ffd40000002fc9ab R11: 0000000000000000 R12: fffa7c000005f935
> [ 1901.641905][    C3] R13: 0000000000000001 R14: 1fe2200005201f17 R15: ffd40000002fc9a8
> [ 1901.642527][    C3] FS:  000000002316c500(0000) GS:ff11000107980000(0000) knlGS:0000000000000000
> [ 1901.643272][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1901.643818][    C3] CR2: 0000000020000000 CR3: 0000000036592004 CR4: 0000000000771ee0
> [ 1901.644469][    C3] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1901.645105][    C3] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1901.645724][    C3] PKRU: 80000000
> [ 1901.646010][    C3] Call Trace:
> [ 1901.646287][    C3]  <TASK>
> [ 1901.646526][    C3]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
> [ 1901.647053][    C3]  _raw_spin_lock+0xd0/0xe0
> [ 1901.647450][    C3]  ? __pfx__raw_spin_lock+0x10/0x10
> [ 1901.647883][    C3]  __pte_offset_map_lock+0x129/0x270
> [ 1901.648335][    C3]  ? __pfx___pte_offset_map_lock+0x10/0x10
> [ 1901.648820][    C3]  migration_entry_wait+0x85/0x270
> [ 1901.649247][    C3]  ? __pfx_migration_entry_wait+0x10/0x10
> [ 1901.649705][    C3]  ? __pfx___schedule+0x10/0x10
> [ 1901.650122][    C3]  ? __hrtimer_start_range_ns+0x355/0xd00
> [ 1901.650623][    C3]  do_swap_page+0x36d2/0x4670
> [ 1901.651016][    C3]  ? plist_del+0x24c/0x450
> [ 1901.651453][    C3]  ? __pte_offset_map+0x2b9/0x3d0
> [ 1901.651981][    C3]  ? __pfx_do_swap_page+0x10/0x10
> [ 1901.652432][    C3]  ? __pfx_default_wake_function+0x10/0x10
> [ 1901.652947][    C3]  handle_pte_fault+0x5ae/0x7b0
> [ 1901.653387][    C3]  __handle_mm_fault+0xf9e/0x17f0
> [ 1901.653839][    C3]  ? __pfx___handle_mm_fault+0x10/0x10
> [ 1901.654335][    C3]  ? lock_vma_under_rcu+0x377/0x4d0
> [ 1901.654797][    C3]  ? __pfx_lock_vma_under_rcu+0x10/0x10
> [ 1901.655294][    C3]  handle_mm_fault+0x4bf/0xa20
> [ 1901.655725][    C3]  exc_page_fault+0x20b/0x7f0
> [ 1901.656150][    C3]  asm_exc_page_fault+0x26/0x30
> [ 1901.656582][    C3] RIP: 0033:0x51d788
> [ 1901.656927][    C3] Code: 66 89 74 17 02 88 0f c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 c5 fa 7f 07 c5 fa 7f 4c 17 f0 c3 0f 1f 44 00 00 48 8b 4c 16 f8 48 8b 36 <48> 89 37 48 89 4c 17 f8 c3 62 e1 fe 28 6f 54 16 ff 62 e1 fe 28 6f
> [ 1901.658618][    C3] RSP: 002b:00007fff991f9118 EFLAGS: 00010202
> [ 1901.659157][    C3] RAX: 0000000020000000 RBX: 0000000000000004 RCX: 002367732f766564
> [ 1901.659856][    C3] RDX: 0000000000000009 RSI: 2367732f7665642f RDI: 0000000020000000
> [ 1901.660553][    C3] RBP: 0000000000797ba0 R08: 00007f10a7800000 R09: 0000000000000001
> [ 1901.661240][    C3] R10: 0000000000000001 R11: 0000000000000009 R12: 0000000000000032
> [ 1901.661906][    C3] R13: 00000000000e2c77 R14: 0000000000795fa0 R15: 0000000000795fac
> [ 1901.662589][    C3]  </TASK>
> [ 1901.662864][    C3] Sending NMI from CPU 3 to CPUs 0-2:
> [ 1901.663358][    C1] NMI backtrace for cpu 1
> [ 1901.663365][    C1] AAA2 1901441189248 1901441163169 0 0 0 1901441162197
> [ 1901.663374][    C1] AAA2 1901441197984 993372484411 993372484804 993372484875 928887973527 928887973577 928887974425 // handle_softirqs
> [ 1901.663383][    C1] softirq_handle_start:
> [ 1901.663385][    C1] 0 
> [ 1901.663387][    C1] 928330006990 
> [ 1901.663390][    C1] 924221567459 
> [ 1901.663392][    C1] 928817263100 
> [ 1901.663395][    C1] 928328744939 
> [ 1901.663397][    C1] 0 
> [ 1901.663399][    C1] 921062008817 
> [ 1901.663401][    C1] 928879010614 
> [ 1901.663403][    C1] 0 
> [ 1901.663405][    C1] 928887973635 
> [ 1901.663407][    C1] 
> [ 1901.663409][    C1] softirq_handle_end_time:
> [ 1901.663410][    C1] 0 
> [ 1901.663412][    C1] 928330009295 
> [ 1901.663415][    C1] 924221568491 
> [ 1901.663417][    C1] 928817511439 
> [ 1901.663419][    C1] 928328806233 
> [ 1901.663421][    C1] 0 
> [ 1901.663423][    C1] 921062009968 
> [ 1901.663425][    C1] 928879011708 
> [ 1901.663427][    C1] 0 
> [ 1901.663429][    C1] 928887974243 
> [ 1901.663432][    C1] 
> [ 1901.663434][    C1] CPU: 1 PID: 8079 Comm: syz.8.781 Tainted: G             L     6.6.0+ #1873
> [ 1901.663444][    C1] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [ 1901.663448][    C1] RIP: 0010:irq_work_claim+0x5c/0xa0
> [ 1901.663464][    C1] Code: 14 02 48 89 e8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 44 8b 5b 08 e8 c3 74 e7 ff 89 da 41 89 dc 89 d8 83 ca 23 f0 0f b1 55 00 <41> 0f 94 c5 31 ff 89 c3 44 89 ee e8 74 6a e7 ff 45 84 ed 74 d7 e8
> [ 1901.663473][    C1] RSP: 0018:ff11000107889c68 EFLAGS: 00000046
> [ 1901.663480][    C1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8dc11a4d
> [ 1901.663486][    C1] RDX: 0000000000000023 RSI: 0000000000000004 RDI: ff110001078c6838
> [ 1901.663491][    C1] RBP: ff110001078c6838 R08: 0000000000000001 R09: ffe21c0020f18d07
> [ 1901.663496][    C1] R10: ff110001078c683b R11: 0000000000000000 R12: 0000000000000000
> [ 1901.663502][    C1] R13: ff110001078c6bf0 R14: 0000000000000000 R15: ffffffff99f43000
> [ 1901.663507][    C1] FS:  00007f10a79556c0(0000) GS:ff11000107880000(0000) knlGS:0000000000000000
> [ 1901.663517][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1901.663523][    C1] CR2: 0000000000638300 CR3: 0000000036592002 CR4: 0000000000771ee0
> [ 1901.663529][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1901.663534][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1901.663539][    C1] PKRU: 00000000
> [ 1901.663542][    C1] Call Trace:
> [ 1901.663546][    C1]  <IRQ>
> [ 1901.663551][    C1]  irq_work_queue_on+0x59/0x130
> [ 1901.663563][    C1]  rcu_read_unlock_special+0x46a/0x530
> [ 1901.663577][    C1]  bpf_trace_run2+0xf7/0x220
> [ 1901.663588][    C1]  ? __pfx_bpf_trace_run2+0x10/0x10
> [ 1901.663599][    C1]  ? __pfx_ep_poll_callback+0x10/0x10
> [ 1901.663613][    C1]  __bpf_trace_tick_stop+0xb4/0xf0
> [ 1901.663623][    C1]  ? __pfx___bpf_trace_tick_stop+0x10/0x10
> [ 1901.663633][    C1]  ? __pfx_sched_clock_cpu+0x10/0x10
> [ 1901.663643][    C1]  ? __wake_up+0x44/0x60
> [ 1901.663657][    C1]  check_tick_dependency+0x362/0x670
> [ 1901.663673][    C1]  __tick_nohz_full_update_tick+0xd1/0x220
> [ 1901.663683][    C1]  tick_nohz_irq_exit+0x22c/0x2a0
> [ 1901.663694][    C1]  sysvec_irq_work+0x36/0x80
> [ 1901.663705][    C1]  asm_sysvec_irq_work+0x1a/0x20
> [ 1901.663720][    C1] RIP: 0010:handle_softirqs+0x230/0x8d0
> [ 1901.663734][    C1] Code: 24 f5 80 5d 84 98 e8 1f 9b 27 00 4c 89 e2 48 c1 ea 03 42 80 3c 3a 00 0f 85 d5 05 00 00 49 89 04 24 fb 65 44 8b 35 0c 2c 93 72 <4d> 63 f6 49 c7 c4 20 0c 03 00 4a 8d 3c f5 80 5d 84 98 48 89 f8 48
> [ 1901.663742][    C1] RSP: 0018:ff11000107889f68 EFLAGS: 00000246
> [ 1901.663748][    C1] RAX: 000000e7499d350b RBX: 0000000000000000 RCX: 0000000000000018
> [ 1901.663754][    C1] RDX: 1fe2200020f16185 RSI: 00000000001e2170 RDI: 0000000000000004
> [ 1901.663759][    C1] RBP: ff1100003ae422c0 R08: 0000000000000001 R09: ffe21c0020f16239
> [ 1901.663765][    C1] R10: 00000000001e2170 R11: 3030303030302052 R12: ff110001078b0c28
> [ 1901.663770][    C1] R13: 0000000000400140 R14: 0000000000000001 R15: dffffc0000000000
> [ 1901.663779][    C1]  ? handle_softirqs+0x211/0x8d0
> [ 1901.663792][    C1]  ? update_sibling_normalize_runtime+0x1a/0x410
> [ 1901.663807][    C1]  irq_exit_rcu+0x134/0x190
> [ 1901.663820][    C1]  sysvec_irq_work+0x6a/0x80
> [ 1901.663830][    C1]  </IRQ>
> [ 1901.663833][    C1]  <TASK>
> [ 1901.663835][    C1]  asm_sysvec_irq_work+0x1a/0x20
> [ 1901.663849][    C1] RIP: 0010:rcu_read_unlock_special+0x186/0x530
> [ 1901.663861][    C1] Code: 0f 85 01 01 00 00 4d 85 f6 0f 84 6a 01 00 00 40 84 ed 0f 84 61 01 00 00 bf 09 00 00 00 e8 c2 45 df ff fb 65 8b 2d 26 65 72 72 <48> 63 ed 48 c7 c3 40 1a 03 00 48 b8 00 00 00 00 00 fc ff df 48 8d
> [ 1901.663869][    C1] RSP: 0018:ff110000380b6fe8 EFLAGS: 00000283
> [ 1901.663875][    C1] RAX: 0000000000000001 RBX: ff110001078c6800 RCX: ffffffff8d7c6a90
> [ 1901.663881][    C1] RDX: 0000000000000001 RSI: 0000000000000046 RDI: ff11000100e33084
> [ 1901.663886][    C1] RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff3716ab4
> [ 1901.663891][    C1] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> [ 1901.663896][    C1] R13: dffffc0000000000 R14: 0000000000000200 R15: ffffffff99f43000
> [ 1901.663903][    C1]  ? ttwu_do_activate+0x520/0x6f0
> [ 1901.663918][    C1]  ? rcu_read_unlock_special+0x17e/0x530
> [ 1901.663930][    C1]  page_vma_mapped_walk+0x1e00/0x2b50
> [ 1901.663948][    C1]  ? __netlink_deliver_tap_skb+0x352/0x4d0
> [ 1901.663959][    C1]  ? __pfx_page_vma_mapped_walk+0x10/0x10
> [ 1901.663974][    C1]  ? netlink_ack+0x614/0xba0
> [ 1901.663986][    C1]  try_to_migrate_one+0x3f0/0x2cb0
> [ 1901.663999][    C1]  ? __sys_sendmsg+0xee/0x1b0
> [ 1901.664015][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
> [ 1901.664028][    C1]  ? __orc_find+0x109/0x140
> [ 1901.664041][    C1]  ? arch_stack_walk+0x92/0x160
> [ 1901.664058][    C1]  ? __anon_vma_interval_tree_subtree_search+0x171/0x1f0
> [ 1901.664080][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
> [ 1901.664094][    C1]  rmap_walk_anon+0x2b0/0x980
> [ 1901.664108][    C1]  try_to_migrate+0x19f/0x350
> [ 1901.664122][    C1]  ? __pfx_try_to_migrate+0x10/0x10
> [ 1901.664135][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
> [ 1901.664148][    C1]  ? __pfx_folio_not_mapped+0x10/0x10
> [ 1901.664159][    C1]  ? __pfx_folio_lock_anon_vma_read+0x10/0x10
> [ 1901.664173][    C1]  ? __pfx_invalid_migration_vma+0x10/0x10
> [ 1901.664184][    C1]  ? folio_total_mapcount+0xb4/0x210
> [ 1901.664197][    C1]  split_huge_page_to_list_to_order+0xc84/0x17f0
> [ 1901.664213][    C1]  ? __pfx_split_huge_page_to_list_to_order+0x10/0x10
> [ 1901.664226][    C1]  ? __orc_find+0x109/0x140
> [ 1901.664240][    C1]  ? __orc_find+0x109/0x140
> [ 1901.664253][    C1]  ? entry_SYSCALL_64_after_hwframe+0x77/0xe2
> [ 1901.664269][    C1]  madvise_cold_or_pageout_pte_range+0x1966/0x2450
> [ 1901.664284][    C1]  ? arch_stack_walk+0x92/0x160
> [ 1901.664298][    C1]  ? __read_once_word_nocheck+0x9/0x20
> [ 1901.664311][    C1]  ? deref_stack_reg+0x1a4/0x2b0
> [ 1901.664326][    C1]  ? entry_SYSCALL_64_after_hwframe+0x77/0xe2
> [ 1901.664340][    C1]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
> [ 1901.664354][    C1]  ? __read_once_word_nocheck+0x9/0x20
> [ 1901.664368][    C1]  ? __orc_find+0x109/0x140
> [ 1901.664381][    C1]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
> [ 1901.664395][    C1]  walk_pmd_range.isra.0+0x240/0x720
> [ 1901.664405][    C1]  ? __read_once_word_nocheck+0x9/0x20
> [ 1901.664419][    C1]  walk_pud_range.isra.0+0x3d3/0x6c0
> [ 1901.664431][    C1]  walk_p4d_range+0x2ef/0x4f0
> [ 1901.664441][    C1]  walk_pgd_range+0x27e/0x530
> [ 1901.664452][    C1]  __walk_page_range+0x4ab/0x5a0
> [ 1901.664461][    C1]  ? find_vma+0x81/0xb0
> [ 1901.664469][    C1]  ? __pfx_find_vma+0x10/0x10
> [ 1901.664477][    C1]  ? folios_put_refs+0x510/0x740
> [ 1901.664487][    C1]  ? walk_page_test+0xa0/0x190
> [ 1901.664503][    C1]  walk_page_range+0x2a0/0x530
> [ 1901.664513][    C1]  ? __pfx_walk_page_range+0x10/0x10
> [ 1901.664522][    C1]  ? vtime_task_switch_generic+0x278/0x5a0
> [ 1901.664535][    C1]  ? folio_batch_move_lru+0x2b8/0x3d0
> [ 1901.664544][    C1]  ? __pfx_lru_add_fn+0x10/0x10
> [ 1901.664554][    C1]  madvise_pageout_page_range+0x1cc/0x6d0
> [ 1901.664567][    C1]  ? __pfx_madvise_pageout_page_range+0x10/0x10
> [ 1901.664582][    C1]  madvise_pageout+0x1f4/0x400
> [ 1901.664595][    C1]  ? __pfx_madvise_pageout+0x10/0x10
> [ 1901.664608][    C1]  ? futex_wait+0x552/0x680
> [ 1901.664624][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [ 1901.664635][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [ 1901.664645][    C1]  ? mas_prev_setup.constprop.0+0xb4/0x530
> [ 1901.664661][    C1]  madvise_vma_behavior+0x8fa/0xe30
> [ 1901.664675][    C1]  ? __pfx_madvise_vma_behavior+0x10/0x10
> [ 1901.664688][    C1]  ? find_vma_prev+0xf5/0x170
> [ 1901.664698][    C1]  ? __pfx_find_vma_prev+0x10/0x10
> [ 1901.664711][    C1]  ? do_futex+0x135/0x360
> [ 1901.664724][    C1]  do_madvise+0x3af/0x650
> [ 1901.664737][    C1]  ? __pfx_do_madvise+0x10/0x10
> [ 1901.664749][    C1]  ? __se_sys_futex+0xf7/0x390
> [ 1901.664762][    C1]  ? kvm_steal_clock+0xca/0x100
> [ 1901.664778][    C1]  ? get_vtime_delta+0xd7/0x250
> [ 1901.664793][    C1]  __x64_sys_madvise+0xaf/0x120
> [ 1901.664805][    C1]  ? __ct_user_exit+0x70/0xe0
> [ 1901.664819][    C1]  do_syscall_64+0x59/0x110
> [ 1901.664834][    C1]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> [ 1901.664849][    C1] RIP: 0033:0x54d2cd
> [ 1901.664856][    C1] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> [ 1901.664864][    C1] RSP: 002b:00007f10a7955048 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> [ 1901.664873][    C1] RAX: ffffffffffffffda RBX: 0000000000795fa0 RCX: 000000000054d2cd
> [ 1901.664878][    C1] RDX: 0000000000000015 RSI: 0000000000003000 RDI: 0000000020001000
> [ 1901.664884][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [ 1901.664889][    C1] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000795fac
> [ 1901.664894][    C1] R13: 0000000000000000 R14: 0000000000795fa0 R15: 00007f10a7935000
> [ 1901.664903][    C1]  </TASK>
> [ 1901.664908][    C2] NMI backtrace for cpu 2
> [ 1901.664927][    C2] AAA2 1901442750380 928616117678 0 0 0 928616122779
> [ 1901.664955][    C2] AAA2 1901442779231 1901441042702 1901441042982 1901441043133 1901441043281 1901441043425 1901441149133
> [ 1901.664990][    C2] softirq_handle_start:
> [ 1901.664999][    C2] 0 
> [ 1901.665010][    C2] 1901441043574 
> [ 1901.665023][    C2] 927808535269 
> [ 1901.665035][    C2] 1901193600384 
> [ 1901.665047][    C2] 28776582930 
> [ 1901.665060][    C2] 0 
> [ 1901.665087][    C2] 0 
> [ 1901.665095][    C2] 1901440051177 
> [ 1901.665103][    C2] 0 
> [ 1901.665110][    C2] 928888742270 
> [ 1901.665118][    C2] 
> [ 1901.665122][    C2] softirq_handle_end_time:
> [ 1901.665128][    C2] 0 
> [ 1901.665134][    C2] 1901441148789 
> [ 1901.665142][    C2] 927808536719 
> [ 1901.665150][    C2] 1901193637121 
> [ 1901.665157][    C2] 28776591391 
> [ 1901.665165][    C2] 0 
> [ 1901.665172][    C2] 0 
> [ 1901.665178][    C2] 1901440068820 
> [ 1901.665186][    C2] 0 
> [ 1901.665192][    C2] 928888825436 
> [ 1901.665200][    C2] 
> [ 1901.665206][    C2] CPU: 2 PID: 17 Comm: rcu_preempt Tainted: G             L     6.6.0+ #1873
> [ 1901.665240][    C2] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [ 1901.665255][    C2] RIP: 0010:find_busiest_group+0x1493/0x2830
> [ 1901.665310][    C2] Code: ff 49 8d 7d 40 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0 74 08 3c 03 0f 8e 83 11 00 00 41 c7 45 40 01 00 00 00 e9 7f f4 ff ff <49> 8d 7d 38 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0 74 08 3c 03
> [ 1901.665339][    C2] RSP: 0018:ff11000100c7f4e8 EFLAGS: 00000097
> [ 1901.665363][    C2] RAX: 0000000000000001 RBX: ff11000100e51800 RCX: 0000000000000000
> [ 1901.665383][    C2] RDX: 1fe220002018fede RSI: 0000000000000000 RDI: ff11000100c7f6f0
> [ 1901.665401][    C2] RBP: ff11000100eaeb00 R08: 0000000000000075 R09: ff11000100eaea00
> [ 1901.665420][    C2] R10: 0000000000000000 R11: 0000000000000000 R12: ff11000100eaea18
> [ 1901.665437][    C2] R13: ff11000100c7f6a8 R14: dffffc0000000000 R15: ff11000100c7f848
> [ 1901.665457][    C2] FS:  0000000000000000(0000) GS:ff11000107900000(0000) knlGS:0000000000000000
> [ 1901.665489][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1901.665510][    C2] CR2: 00007f2b5a37b000 CR3: 0000000105636005 CR4: 0000000000771ee0
> [ 1901.665530][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1901.665547][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1901.665565][    C2] PKRU: 55555554
> [ 1901.665575][    C2] Call Trace:
> [ 1901.665585][    C2]  <TASK>
> [ 1901.665607][    C2]  ? __pfx_find_busiest_group+0x10/0x10
> [ 1901.665682][    C2]  ? __pfx__raw_spin_lock+0x10/0x10
> [ 1901.665726][    C2]  ? __bitmap_and+0x18e/0x210
> [ 1901.665775][    C2]  load_balance+0x212/0x1280
> [ 1901.665821][    C2]  ? __update_blocked_fair+0x227/0x2e90
> [ 1901.665874][    C2]  ? __pfx_load_balance+0x10/0x10
> [ 1901.665927][    C2]  ? __pfx__raw_spin_lock+0x10/0x10
> [ 1901.665970][    C2]  ? sched_clock_cpu+0x6d/0x4c0
> [ 1901.666015][    C2]  newidle_balance+0x51b/0xc90
> [ 1901.666108][    C2]  ? __pfx_newidle_balance+0x10/0x10
> [ 1901.666155][    C2]  ? sched_clock+0x38/0x60
> [ 1901.666193][    C2]  pick_next_task_fair+0x66d/0x23c0
> [ 1901.666249][    C2]  __schedule+0x4c5/0x1fb0
> [ 1901.666298][    C2]  ? __pfx___schedule+0x10/0x10
> [ 1901.666342][    C2]  ? _raw_spin_lock_irqsave+0x8b/0xf0
> [ 1901.666387][    C2]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [ 1901.666432][    C2]  ? __try_to_del_timer_sync+0x103/0x160
> [ 1901.666465][    C2]  ? __pfx___try_to_del_timer_sync+0x10/0x10
> [ 1901.666500][    C2]  ? housekeeping_test_cpu+0x6f/0x90
> [ 1901.666542][    C2]  ? get_nohz_timer_target+0xdf/0x5d0
> [ 1901.666587][    C2]  schedule+0x134/0x280
> [ 1901.666632][    C2]  schedule_timeout+0x4c2/0x770
> [ 1901.666673][    C2]  ? _raw_spin_lock_irqsave+0x8b/0xf0
> [ 1901.666719][    C2]  ? __pfx_schedule_timeout+0x10/0x10
> [ 1901.666762][    C2]  ? _raw_spin_lock_irqsave+0x8b/0xf0
> [ 1901.666807][    C2]  ? __pfx_process_timeout+0x10/0x10
> [ 1901.666840][    C2]  ? __pfx_rcu_implicit_dynticks_qs+0x10/0x10
> [ 1901.666888][    C2]  ? prepare_to_swait_event+0x11e/0x430
> [ 1901.666921][    C2]  rcu_gp_fqs_loop+0x1bf/0x9d0
> [ 1901.666961][    C2]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10
> [ 1901.667013][    C2]  ? finish_swait+0x9e/0x240
> [ 1901.667063][    C2]  rcu_gp_kthread+0x277/0x400
> [ 1901.667138][    C2]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [ 1901.667184][    C2]  ? __pfx_set_cpus_allowed_ptr+0x10/0x10
> [ 1901.667235][    C2]  ? __kthread_parkme+0x10d/0x190
> [ 1901.667276][    C2]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [ 1901.667320][    C2]  kthread+0x2f4/0x3f0
> [ 1901.667367][    C2]  ? __pfx_kthread+0x10/0x10
> [ 1901.667418][    C2]  ret_from_fork+0x4a/0x80
> [ 1901.667460][    C2]  ? __pfx_kthread+0x10/0x10
> [ 1901.667510][    C2]  ret_from_fork_asm+0x1b/0x30
> [ 1901.667555][    C2]  </TASK>
> [ 1901.667567][    C0] NMI backtrace for cpu 0
> [ 1901.667583][    C0] AAA2 1901445406480 928856909383 0 0 0 928856909774
> [ 1901.667608][    C0] AAA2 1901445431980 1901439056150 1901439056650 1901439056896 1901439057156 1901439057448 1901439092009
> [ 1901.667637][    C0] softirq_handle_start:
> [ 1901.667642][    C0] 0 
> [ 1901.667648][    C0] 1901437034812 
> [ 1901.667655][    C0] 928873837201 
> [ 1901.667662][    C0] 1873956031919 
> [ 1901.667669][    C0] 0 
> [ 1901.667675][    C0] 0 
> [ 1901.667681][    C0] 928609012446 
> [ 1901.667688][    C0] 1901439057689 
> [ 1901.667695][    C0] 0 
> [ 1901.667701][    C0] 928888606411 
> [ 1901.667707][    C0] 
> [ 1901.667711][    C0] softirq_handle_end_time:
> [ 1901.667716][    C0] 0 
> [ 1901.667722][    C0] 1901437060853 
> [ 1901.667729][    C0] 928873838583 
> [ 1901.667736][    C0] 1873957586746 
> [ 1901.667743][    C0] 0 
> [ 1901.667749][    C0] 0 
> [ 1901.667755][    C0] 928609013591 
> [ 1901.667762][    C0] 1901439091316 
> [ 1901.667769][    C0] 0 
> [ 1901.667774][    C0] 928888785127 
> [ 1901.667782][    C0] 
> [ 1901.667787][    C0] CPU: 0 PID: 8956 Comm: kworker/u8:1 Tainted: G             L     6.6.0+ #1873
> [ 1901.667817][    C0] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [ 1901.667833][    C0] Workqueue: events_unbound nsim_dev_trap_report_work
> [ 1901.667898][    C0] RIP: 0010:process_one_work+0x94a/0x1020
> [ 1901.667934][    C0] Code: 3c 03 0f 8e e5 03 00 00 c7 43 30 ff ff ff 7f 48 8b 74 24 48 48 83 c4 58 4c 89 e7 5b 5d 41 5c 41 5d 41 5e 41 5f e9 f6 db ff ff <e8> 41 fa 31 00 41 81 e5 88 01 00 00 31 ff 44 89 ee e8 60 f0 31 00
> [ 1901.667961][    C0] RSP: 0018:ff1100006e90fda8 EFLAGS: 00000002
> [ 1901.667982][    C0] RAX: 0000000000000000 RBX: ff11000037aa1e00 RCX: ffffffff8d769330
> [ 1901.668001][    C0] RDX: ff1100006ebea2c0 RSI: 0000000000000000 RDI: 0000000000000005
> [ 1901.668019][    C0] RBP: ff11000100071000 R08: 0000000000000001 R09: ffe21c000dd21faa
> [ 1901.668038][    C0] R10: 0000000000000080 R11: 0000000000000001 R12: ff11000100116d00
> [ 1901.668055][    C0] R13: 0000000000000080 R14: 0000000000000080 R15: ffffffff9284bec0
> [ 1901.668089][    C0] FS:  0000000000000000(0000) GS:ff11000107800000(0000) knlGS:0000000000000000
> [ 1901.668119][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1901.668139][    C0] CR2: 00007f77e1f86000 CR3: 00000000088d0002 CR4: 0000000000771ef0
> [ 1901.668156][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1901.668172][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1901.668189][    C0] PKRU: 55555554
> [ 1901.668198][    C0] Call Trace:
> [ 1901.668212][    C0]  <TASK>
> [ 1901.668240][    C0]  worker_thread+0x849/0x1090
> [ 1901.668297][    C0]  ? __kthread_parkme+0x10d/0x190
> [ 1901.668335][    C0]  ? __pfx_worker_thread+0x10/0x10
> [ 1901.668364][    C0]  kthread+0x2f4/0x3f0
> [ 1901.668403][    C0]  ? __pfx_kthread+0x10/0x10
> [ 1901.668444][    C0]  ret_from_fork+0x4a/0x80
> [ 1901.668479][    C0]  ? __pfx_kthread+0x10/0x10
> [ 1901.668519][    C0]  ret_from_fork_asm+0x1b/0x30
> [ 1901.668556][    C0]  </TASK>
> [ 2013.245598][    C3] perf: interrupt took too long (5525 > 5362), lowering kernel.perf_event_max_sample_rate to 36000
> [ 2069.210124][    C0] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [ 2069.212232][    C0] rcu: BBB 2068990137232 928856909383 0 0 0 928856909774
> [ 2069.214280][    C0] rcu: BBB 2068992185298 2068986047715 2068986048070 2068986048234 2068986048400 2068986048562 2068986245132
> [ 2069.217571][    C0] rcu: 	1-....: (1 ticks this GP) idle=a97c/1/0x4000000000000000 softirq=26480/26480 fqs=474201
> [ 2069.220202][    C0] rcu: 	(detected by 0, t=1140107 jiffies, g=99129, q=4647382 ncpus=4)
> [ 2069.222105][    C0] Sending NMI from CPU 0 to CPUs 1:
> [ 2069.223354][    C1] NMI backtrace for cpu 1
> [ 2069.223363][    C1] AAA2 2069001268135 2069001236634 0 0 0 2069001236976
> [ 2069.223372][    C1] AAA2 2069001277548 993372484411 993372484804 993372484875 928887973527 928887973577 928887974425
> [ 2069.223381][    C1] softirq_handle_start:
> [ 2069.223383][    C1] 0 
> [ 2069.223386][    C1] 928330006990 
> [ 2069.223389][    C1] 924221567459 
> [ 2069.223391][    C1] 928817263100 
> [ 2069.223393][    C1] 928328744939 
> [ 2069.223395][    C1] 0 
> [ 2069.223397][    C1] 921062008817 
> [ 2069.223400][    C1] 928879010614 
> [ 2069.223402][    C1] 0 
> [ 2069.223404][    C1] 928887973635 
> [ 2069.223406][    C1] 
> [ 2069.223408][    C1] softirq_handle_end_time:
> [ 2069.223410][    C1] 0 
> [ 2069.223412][    C1] 928330009295 
> [ 2069.223414][    C1] 924221568491 
> [ 2069.223416][    C1] 928817511439 
> [ 2069.223418][    C1] 928328806233 
> [ 2069.223421][    C1] 0 
> [ 2069.223423][    C1] 921062009968 
> [ 2069.223425][    C1] 928879011708 
> [ 2069.223427][    C1] 0 
> [ 2069.223429][    C1] 928887974243 
> [ 2069.223431][    C1] 
> [ 2069.223434][    C1] CPU: 1 PID: 8079 Comm: syz.8.781 Tainted: G             L     6.6.0+ #1873
> [ 2069.223457][    C1] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [ 2069.223462][    C1] RIP: 0010:native_apic_msr_eoi+0xf/0x20
> [ 2069.223490][    C1] Code: f6 31 d2 89 cf e9 d1 a5 e9 01 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 31 c0 b9 0b 08 00 00 89 c2 0f 30 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> [ 2069.223499][    C1] RSP: 0018:ff11000107889e78 EFLAGS: 00000046
> [ 2069.223507][    C1] RAX: 0000000000000000 RBX: ff110001078c8000 RCX: 000000000000080b
> [ 2069.223513][    C1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
> [ 2069.223519][    C1] RBP: 0000000000000000 R08: 0000000000000001 R09: ffe21c0020f19008
> [ 2069.223524][    C1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [ 2069.223529][    C1] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 2069.223535][    C1] FS:  00007f10a79556c0(0000) GS:ff11000107880000(0000) knlGS:0000000000000000
> [ 2069.223545][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2069.223551][    C1] CR2: 0000000000638300 CR3: 0000000036592002 CR4: 0000000000771ee0
> [ 2069.223557][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2069.223562][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2069.223567][    C1] PKRU: 00000000
> [ 2069.223570][    C1] Call Trace:
> [ 2069.223575][    C1]  <IRQ>
> [ 2069.223579][    C1]  kvm_guest_apic_eoi_write+0x45/0x50
> [ 2069.223592][    C1]  __sysvec_irq_work+0x14/0x210
> [ 2069.223603][    C1]  sysvec_irq_work+0x31/0x80
> [ 2069.223620][    C1]  asm_sysvec_irq_work+0x1a/0x20
> [ 2069.223636][    C1] RIP: 0010:handle_softirqs+0x230/0x8d0
> [ 2069.223650][    C1] Code: 24 f5 80 5d 84 98 e8 1f 9b 27 00 4c 89 e2 48 c1 ea 03 42 80 3c 3a 00 0f 85 d5 05 00 00 49 89 04 24 fb 65 44 8b 35 0c 2c 93 72 <4d> 63 f6 49 c7 c4 20 0c 03 00 4a 8d 3c f5 80 5d 84 98 48 89 f8 48
> [ 2069.223660][    C1] RSP: 0018:ff11000107889f68 EFLAGS: 00000246
> [ 2069.223666][    C1] RAX: 000000e7499d350b RBX: 0000000000000000 RCX: 0000000000000018
> [ 2069.223672][    C1] RDX: 1fe2200020f16185 RSI: 00000000001e2170 RDI: 0000000000000004
> [ 2069.223678][    C1] RBP: ff1100003ae422c0 R08: 0000000000000001 R09: ffe21c0020f16239
> [ 2069.223683][    C1] R10: 00000000001e2170 R11: 3030303030302052 R12: ff110001078b0c28
> [ 2069.223689][    C1] R13: 0000000000400140 R14: 0000000000000001 R15: dffffc0000000000
> [ 2069.223699][    C1]  ? handle_softirqs+0x211/0x8d0
> [ 2069.223713][    C1]  ? update_sibling_normalize_runtime+0x1a/0x410
> [ 2069.223728][    C1]  irq_exit_rcu+0x134/0x190
> [ 2069.223742][    C1]  sysvec_irq_work+0x6a/0x80
> [ 2069.223752][    C1]  </IRQ>
> [ 2069.223755][    C1]  <TASK>
> [ 2069.223758][    C1]  asm_sysvec_irq_work+0x1a/0x20
> [ 2069.223772][    C1] RIP: 0010:rcu_read_unlock_special+0x186/0x530
> [ 2069.223785][    C1] Code: 0f 85 01 01 00 00 4d 85 f6 0f 84 6a 01 00 00 40 84 ed 0f 84 61 01 00 00 bf 09 00 00 00 e8 c2 45 df ff fb 65 8b 2d 26 65 72 72 <48> 63 ed 48 c7 c3 40 1a 03 00 48 b8 00 00 00 00 00 fc ff df 48 8d
> [ 2069.223794][    C1] RSP: 0018:ff110000380b6fe8 EFLAGS: 00000283
> [ 2069.223800][    C1] RAX: 0000000000000001 RBX: ff110001078c6800 RCX: ffffffff8d7c6a90
> [ 2069.223806][    C1] RDX: 0000000000000001 RSI: 0000000000000046 RDI: ff11000100e33084
> [ 2069.223812][    C1] RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff3716ab4
> [ 2069.223817][    C1] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> [ 2069.223822][    C1] R13: dffffc0000000000 R14: 0000000000000200 R15: ffffffff99f43000
> [ 2069.223830][    C1]  ? ttwu_do_activate+0x520/0x6f0
> [ 2069.223845][    C1]  ? rcu_read_unlock_special+0x17e/0x530
> [ 2069.223857][    C1]  page_vma_mapped_walk+0x1e00/0x2b50
> [ 2069.223877][    C1]  ? __netlink_deliver_tap_skb+0x352/0x4d0
> [ 2069.223888][    C1]  ? __pfx_page_vma_mapped_walk+0x10/0x10
> [ 2069.223903][    C1]  ? netlink_ack+0x614/0xba0
> [ 2069.223916][    C1]  try_to_migrate_one+0x3f0/0x2cb0
> [ 2069.223930][    C1]  ? __sys_sendmsg+0xee/0x1b0
> [ 2069.223946][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
> [ 2069.223959][    C1]  ? __orc_find+0x109/0x140
> [ 2069.223972][    C1]  ? arch_stack_walk+0x92/0x160
> [ 2069.223989][    C1]  ? __anon_vma_interval_tree_subtree_search+0x171/0x1f0
> [ 2069.224005][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
> [ 2069.224019][    C1]  rmap_walk_anon+0x2b0/0x980
> [ 2069.224033][    C1]  try_to_migrate+0x19f/0x350
> [ 2069.224046][    C1]  ? __pfx_try_to_migrate+0x10/0x10
> [ 2069.224060][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
> [ 2069.224073][    C1]  ? __pfx_folio_not_mapped+0x10/0x10
> [ 2069.224092][    C1]  ? __pfx_folio_lock_anon_vma_read+0x10/0x10
> [ 2069.224106][    C1]  ? __pfx_invalid_migration_vma+0x10/0x10
> [ 2069.224117][    C1]  ? folio_total_mapcount+0xb4/0x210
> [ 2069.224131][    C1]  split_huge_page_to_list_to_order+0xc84/0x17f0
> [ 2069.224147][    C1]  ? __pfx_split_huge_page_to_list_to_order+0x10/0x10
> [ 2069.224160][    C1]  ? __orc_find+0x109/0x140
> [ 2069.224174][    C1]  ? __orc_find+0x109/0x140
> [ 2069.224187][    C1]  ? entry_SYSCALL_64_after_hwframe+0x77/0xe2
> [ 2069.224203][    C1]  madvise_cold_or_pageout_pte_range+0x1966/0x2450
> [ 2069.224218][    C1]  ? arch_stack_walk+0x92/0x160
> [ 2069.224232][    C1]  ? __read_once_word_nocheck+0x9/0x20
> [ 2069.224246][    C1]  ? deref_stack_reg+0x1a4/0x2b0
> [ 2069.224261][    C1]  ? entry_SYSCALL_64_after_hwframe+0x77/0xe2
> [ 2069.224276][    C1]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
> [ 2069.224290][    C1]  ? __read_once_word_nocheck+0x9/0x20
> [ 2069.224304][    C1]  ? __orc_find+0x109/0x140
> [ 2069.224317][    C1]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
> [ 2069.224331][    C1]  walk_pmd_range.isra.0+0x240/0x720
> [ 2069.224341][    C1]  ? __read_once_word_nocheck+0x9/0x20
> [ 2069.224356][    C1]  walk_pud_range.isra.0+0x3d3/0x6c0
> [ 2069.224367][    C1]  walk_p4d_range+0x2ef/0x4f0
> [ 2069.224378][    C1]  walk_pgd_range+0x27e/0x530
> [ 2069.224388][    C1]  __walk_page_range+0x4ab/0x5a0
> [ 2069.224397][    C1]  ? find_vma+0x81/0xb0
> [ 2069.224405][    C1]  ? __pfx_find_vma+0x10/0x10
> [ 2069.224413][    C1]  ? folios_put_refs+0x510/0x740
> [ 2069.224424][    C1]  ? walk_page_test+0xa0/0x190
> [ 2069.224439][    C1]  walk_page_range+0x2a0/0x530
> [ 2069.224449][    C1]  ? __pfx_walk_page_range+0x10/0x10
> [ 2069.224458][    C1]  ? vtime_task_switch_generic+0x278/0x5a0
> [ 2069.224471][    C1]  ? folio_batch_move_lru+0x2b8/0x3d0
> [ 2069.224481][    C1]  ? __pfx_lru_add_fn+0x10/0x10
> [ 2069.224490][    C1]  madvise_pageout_page_range+0x1cc/0x6d0
> [ 2069.224504][    C1]  ? __pfx_madvise_pageout_page_range+0x10/0x10
> [ 2069.224519][    C1]  madvise_pageout+0x1f4/0x400
> [ 2069.224532][    C1]  ? __pfx_madvise_pageout+0x10/0x10
> [ 2069.224545][    C1]  ? futex_wait+0x552/0x680
> [ 2069.224561][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [ 2069.224572][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [ 2069.224582][    C1]  ? mas_prev_setup.constprop.0+0xb4/0x530
> [ 2069.224599][    C1]  madvise_vma_behavior+0x8fa/0xe30
> [ 2069.224613][    C1]  ? __pfx_madvise_vma_behavior+0x10/0x10
> [ 2069.224626][    C1]  ? find_vma_prev+0xf5/0x170
> [ 2069.224637][    C1]  ? __pfx_find_vma_prev+0x10/0x10
> [ 2069.224649][    C1]  ? do_futex+0x135/0x360
> [ 2069.224662][    C1]  do_madvise+0x3af/0x650
> [ 2069.224676][    C1]  ? __pfx_do_madvise+0x10/0x10
> [ 2069.224688][    C1]  ? __se_sys_futex+0xf7/0x390
> [ 2069.224701][    C1]  ? kvm_steal_clock+0xca/0x100
> [ 2069.224717][    C1]  ? get_vtime_delta+0xd7/0x250
> [ 2069.224731][    C1]  __x64_sys_madvise+0xaf/0x120
> [ 2069.224744][    C1]  ? __ct_user_exit+0x70/0xe0
> [ 2069.224758][    C1]  do_syscall_64+0x59/0x110
> [ 2069.224774][    C1]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> [ 2069.224789][    C1] RIP: 0033:0x54d2cd
> [ 2069.224796][    C1] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> [ 2069.224805][    C1] RSP: 002b:00007f10a7955048 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> [ 2069.224813][    C1] RAX: ffffffffffffffda RBX: 0000000000795fa0 RCX: 000000000054d2cd
> [ 2069.224819][    C1] RDX: 0000000000000015 RSI: 0000000000003000 RDI: 0000000020001000
> [ 2069.224825][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [ 2069.224830][    C1] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000795fac
> [ 2069.224835][    C1] R13: 0000000000000000 R14: 0000000000795fa0 R15: 00007f10a7935000
> [ 2069.224844][    C1]  </TASK>
> [ 2074.851167][  T528] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... } 1145742 jiffies s: 14109 root: 0x2/.
> [ 2074.853320][  T528] rcu: blocking rcu_node structures (internal RCU debug):
> [ 2074.854557][  T528] Sending NMI from CPU 0 to CPUs 1:
> [ 2074.855497][    C1] NMI backtrace for cpu 1
> [ 2074.855503][    C1] AAA2 2074633411808 2074633384796 0 0 0 2074633385139
> [ 2074.855513][    C1] AAA2 2074633421487 993372484411 993372484804 993372484875 928887973527 928887973577 928887974425
> [ 2074.855523][    C1] softirq_handle_start:
> [ 2074.855525][    C1] 0 
> [ 2074.855527][    C1] 928330006990 
> [ 2074.855530][    C1] 924221567459 
> [ 2074.855532][    C1] 928817263100 
> [ 2074.855534][    C1] 928328744939 
> [ 2074.855537][    C1] 0 
> [ 2074.855539][    C1] 921062008817 
> [ 2074.855541][    C1] 928879010614 
> [ 2074.855543][    C1] 0 
> [ 2074.855545][    C1] 928887973635 
> [ 2074.855547][    C1] 
> [ 2074.855549][    C1] softirq_handle_end_time:
> [ 2074.855550][    C1] 0 
> [ 2074.855552][    C1] 928330009295 
> [ 2074.855555][    C1] 924221568491 
> [ 2074.855557][    C1] 928817511439 
> [ 2074.855559][    C1] 928328806233 
> [ 2074.855562][    C1] 0 
> [ 2074.855564][    C1] 921062009968 
> [ 2074.855566][    C1] 928879011708 
> [ 2074.855568][    C1] 0 
> [ 2074.855570][    C1] 928887974243 
> [ 2074.855572][    C1] 
> [ 2074.855575][    C1] CPU: 1 PID: 8079 Comm: syz.8.781 Tainted: G             L     6.6.0+ #1873
> [ 2074.855585][    C1] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [ 2074.855590][    C1] RIP: 0010:asm_sysvec_irq_work+0x0/0x20
> [ 2074.855611][    C1] Code: 06 14 fd ff e9 a1 05 00 00 90 f3 0f 1e fa 0f 01 ca fc 6a ff e8 51 04 00 00 48 89 c4 48 89 e7 e8 76 f4 fc ff e9 81 05 00 00 90 <f3> 0f 1e fa 0f 01 ca fc 6a ff e8 31 04 00 00 48 89 c4 48 89 e7 e8
> [ 2074.855620][    C1] RSP: 0018:ff11000107889f38 EFLAGS: 00000046
> [ 2074.855628][    C1] RAX: 000000e7499d350b RBX: 0000000000000000 RCX: 0000000000000018
> [ 2074.855634][    C1] RDX: 1fe2200020f16185 RSI: 00000000001e2170 RDI: 0000000000000004
> [ 2074.855640][    C1] RBP: ff1100003ae422c0 R08: 0000000000000001 R09: ffe21c0020f16239
> [ 2074.855645][    C1] R10: 00000000001e2170 R11: 3030303030302052 R12: ff110001078b0c28
> [ 2074.855651][    C1] R13: 0000000000400140 R14: 0000000000000001 R15: dffffc0000000000
> [ 2074.855657][    C1] FS:  00007f10a79556c0(0000) GS:ff11000107880000(0000) knlGS:0000000000000000
> [ 2074.855667][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2074.855674][    C1] CR2: 0000000000638300 CR3: 0000000036592002 CR4: 0000000000771ee0
> [ 2074.855679][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2074.855685][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2074.855690][    C1] PKRU: 00000000
> [ 2074.855693][    C1] Call Trace:
> [ 2074.855697][    C1]  <IRQ>
> [ 2074.855700][    C1] RIP: 0010:handle_softirqs+0x230/0x8d0
> [ 2074.855715][    C1] Code: 24 f5 80 5d 84 98 e8 1f 9b 27 00 4c 89 e2 48 c1 ea 03 42 80 3c 3a 00 0f 85 d5 05 00 00 49 89 04 24 fb 65 44 8b 35 0c 2c 93 72 <4d> 63 f6 49 c7 c4 20 0c 03 00 4a 8d 3c f5 80 5d 84 98 48 89 f8 48
> [ 2074.855724][    C1] RSP: 0018:ff11000107889f68 EFLAGS: 00000246
> [ 2074.855732][    C1]  ? handle_softirqs+0x211/0x8d0
> [ 2074.855746][    C1]  ? update_sibling_normalize_runtime+0x1a/0x410
> [ 2074.855761][    C1]  irq_exit_rcu+0x134/0x190
> [ 2074.855775][    C1]  sysvec_irq_work+0x6a/0x80
> [ 2074.855787][    C1]  </IRQ>
> [ 2074.855790][    C1]  <TASK>
> [ 2074.855792][    C1]  asm_sysvec_irq_work+0x1a/0x20
> [ 2074.855807][    C1] RIP: 0010:rcu_read_unlock_special+0x186/0x530
> [ 2074.855820][    C1] Code: 0f 85 01 01 00 00 4d 85 f6 0f 84 6a 01 00 00 40 84 ed 0f 84 61 01 00 00 bf 09 00 00 00 e8 c2 45 df ff fb 65 8b 2d 26 65 72 72 <48> 63 ed 48 c7 c3 40 1a 03 00 48 b8 00 00 00 00 00 fc ff df 48 8d
> [ 2074.855829][    C1] RSP: 0018:ff110000380b6fe8 EFLAGS: 00000283
> [ 2074.855835][    C1] RAX: 0000000000000001 RBX: ff110001078c6800 RCX: ffffffff8d7c6a90
> [ 2074.855841][    C1] RDX: 0000000000000001 RSI: 0000000000000046 RDI: ff11000100e33084
> [ 2074.855847][    C1] RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff3716ab4
> [ 2074.855852][    C1] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> [ 2074.855857][    C1] R13: dffffc0000000000 R14: 0000000000000200 R15: ffffffff99f43000
> [ 2074.855865][    C1]  ? ttwu_do_activate+0x520/0x6f0
> [ 2074.855881][    C1]  ? rcu_read_unlock_special+0x17e/0x530
> [ 2074.855894][    C1]  page_vma_mapped_walk+0x1e00/0x2b50
> [ 2074.855913][    C1]  ? __netlink_deliver_tap_skb+0x352/0x4d0
> [ 2074.855924][    C1]  ? __pfx_page_vma_mapped_walk+0x10/0x10
> [ 2074.855939][    C1]  ? netlink_ack+0x614/0xba0
> [ 2074.855952][    C1]  try_to_migrate_one+0x3f0/0x2cb0
> [ 2074.855967][    C1]  ? __sys_sendmsg+0xee/0x1b0
> [ 2074.855982][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
> [ 2074.855996][    C1]  ? __orc_find+0x109/0x140
> [ 2074.856010][    C1]  ? arch_stack_walk+0x92/0x160
> [ 2074.856026][    C1]  ? __anon_vma_interval_tree_subtree_search+0x171/0x1f0
> [ 2074.856043][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
> [ 2074.856056][    C1]  rmap_walk_anon+0x2b0/0x980
> [ 2074.856070][    C1]  try_to_migrate+0x19f/0x350
> [ 2074.856092][    C1]  ? __pfx_try_to_migrate+0x10/0x10
> [ 2074.856105][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
> [ 2074.856118][    C1]  ? __pfx_folio_not_mapped+0x10/0x10
> [ 2074.856129][    C1]  ? __pfx_folio_lock_anon_vma_read+0x10/0x10
> [ 2074.856143][    C1]  ? __pfx_invalid_migration_vma+0x10/0x10
> [ 2074.856154][    C1]  ? folio_total_mapcount+0xb4/0x210
> [ 2074.856168][    C1]  split_huge_page_to_list_to_order+0xc84/0x17f0
> [ 2074.856184][    C1]  ? __pfx_split_huge_page_to_list_to_order+0x10/0x10
> [ 2074.856197][    C1]  ? __orc_find+0x109/0x140
> [ 2074.856211][    C1]  ? __orc_find+0x109/0x140
> [ 2074.856224][    C1]  ? entry_SYSCALL_64_after_hwframe+0x77/0xe2
> [ 2074.856239][    C1]  madvise_cold_or_pageout_pte_range+0x1966/0x2450
> [ 2074.856254][    C1]  ? arch_stack_walk+0x92/0x160
> [ 2074.856268][    C1]  ? __read_once_word_nocheck+0x9/0x20
> [ 2074.856282][    C1]  ? deref_stack_reg+0x1a4/0x2b0
> [ 2074.856296][    C1]  ? entry_SYSCALL_64_after_hwframe+0x77/0xe2
> [ 2074.856311][    C1]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
> [ 2074.856325][    C1]  ? __read_once_word_nocheck+0x9/0x20
> [ 2074.856338][    C1]  ? __orc_find+0x109/0x140
> [ 2074.856352][    C1]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
> [ 2074.856365][    C1]  walk_pmd_range.isra.0+0x240/0x720
> [ 2074.856376][    C1]  ? __read_once_word_nocheck+0x9/0x20
> [ 2074.856391][    C1]  walk_pud_range.isra.0+0x3d3/0x6c0
> [ 2074.856402][    C1]  walk_p4d_range+0x2ef/0x4f0
> [ 2074.856412][    C1]  walk_pgd_range+0x27e/0x530
> [ 2074.856423][    C1]  __walk_page_range+0x4ab/0x5a0
> [ 2074.856432][    C1]  ? find_vma+0x81/0xb0
> [ 2074.856440][    C1]  ? __pfx_find_vma+0x10/0x10
> [ 2074.856448][    C1]  ? folios_put_refs+0x510/0x740
> [ 2074.856458][    C1]  ? walk_page_test+0xa0/0x190
> [ 2074.856473][    C1]  walk_page_range+0x2a0/0x530
> [ 2074.856483][    C1]  ? __pfx_walk_page_range+0x10/0x10
> [ 2074.856492][    C1]  ? vtime_task_switch_generic+0x278/0x5a0
> [ 2074.856505][    C1]  ? folio_batch_move_lru+0x2b8/0x3d0
> [ 2074.856514][    C1]  ? __pfx_lru_add_fn+0x10/0x10
> [ 2074.856524][    C1]  madvise_pageout_page_range+0x1cc/0x6d0
> [ 2074.856538][    C1]  ? __pfx_madvise_pageout_page_range+0x10/0x10
> [ 2074.856553][    C1]  madvise_pageout+0x1f4/0x400
> [ 2074.856566][    C1]  ? __pfx_madvise_pageout+0x10/0x10
> [ 2074.856579][    C1]  ? futex_wait+0x552/0x680
> [ 2074.856595][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [ 2074.856605][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [ 2074.856615][    C1]  ? mas_prev_setup.constprop.0+0xb4/0x530
> [ 2074.856632][    C1]  madvise_vma_behavior+0x8fa/0xe30
> [ 2074.856646][    C1]  ? __pfx_madvise_vma_behavior+0x10/0x10
> [ 2074.856660][    C1]  ? find_vma_prev+0xf5/0x170
> [ 2074.856670][    C1]  ? __pfx_find_vma_prev+0x10/0x10
> [ 2074.856682][    C1]  ? do_futex+0x135/0x360
> [ 2074.856695][    C1]  do_madvise+0x3af/0x650
> [ 2074.856708][    C1]  ? __pfx_do_madvise+0x10/0x10
> [ 2074.856720][    C1]  ? __se_sys_futex+0xf7/0x390
> [ 2074.856733][    C1]  ? kvm_steal_clock+0xca/0x100
> [ 2074.856749][    C1]  ? get_vtime_delta+0xd7/0x250
> [ 2074.856764][    C1]  __x64_sys_madvise+0xaf/0x120
> [ 2074.856776][    C1]  ? __ct_user_exit+0x70/0xe0
> [ 2074.856790][    C1]  do_syscall_64+0x59/0x110
> [ 2074.856806][    C1]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> [ 2074.856821][    C1] RIP: 0033:0x54d2cd
> [ 2074.856828][    C1] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> [ 2074.856837][    C1] RSP: 002b:00007f10a7955048 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> [ 2074.856845][    C1] RAX: ffffffffffffffda RBX: 0000000000795fa0 RCX: 000000000054d2cd
> [ 2074.856851][    C1] RDX: 0000000000000015 RSI: 0000000000003000 RDI: 0000000020001000
> [ 2074.856857][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [ 2074.856862][    C1] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000795fac
> [ 2074.856867][    C1] R13: 0000000000000000 R14: 0000000000795fa0 R15: 00007f10a7935000
> [ 2074.856876][    C1]  </TASK>
> [ 2141.634105][    C3] watchdog: BUG: soft lockup - CPU#3 stuck for 1136s! [syz.8.781:8076]
> [ 2141.634824][    C3] Modules linked in:
> [ 2141.635152][    C3] CPU: 3 PID: 8076 Comm: syz.8.781 Tainted: G             L     6.6.0+ #1873
> [ 2141.635864][    C3] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [ 2141.636602][    C3] RIP: 0010:queued_spin_lock_slowpath+0x109/0x9c0
> [ 2141.637141][    C3] Code: 00 48 8b 44 24 60 65 48 2b 04 25 28 00 00 00 0f 85 ca 07 00 00 48 83 c4 68 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc f3 90 <eb> 85 81 fe 00 01 00 00 0f 84 dc 00 00 00 81 fe ff 00 00 00 0f 87
> [ 2141.638704][    C3] RSP: 0000:ff1100002900f8b0 EFLAGS: 00000202
> [ 2141.639207][    C3] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff961f5ecd
> [ 2141.639842][    C3] RDX: fffa7c000005f936 RSI: 0000000000000004 RDI: ffd40000002fc9a8
> [ 2141.640484][    C3] RBP: 0000000000000003 R08: 0000000000000000 R09: fffa7c000005f935
> [ 2141.641127][    C3] R10: ffd40000002fc9ab R11: 0000000000000000 R12: fffa7c000005f935
> [ 2141.641764][    C3] R13: 0000000000000001 R14: 1fe2200005201f17 R15: ffd40000002fc9a8
> [ 2141.642409][    C3] FS:  000000002316c500(0000) GS:ff11000107980000(0000) knlGS:0000000000000000
> [ 2141.643139][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2141.643671][    C3] CR2: 0000000020000000 CR3: 0000000036592004 CR4: 0000000000771ee0
> [ 2141.644321][    C3] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2141.644957][    C3] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2141.645626][    C3] PKRU: 80000000
> [ 2141.645920][    C3] Call Trace:
> [ 2141.646213][    C3]  <TASK>
> [ 2141.646459][    C3]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
> [ 2141.646973][    C3]  _raw_spin_lock+0xd0/0xe0
> [ 2141.647362][    C3]  ? __pfx__raw_spin_lock+0x10/0x10
> [ 2141.647800][    C3]  __pte_offset_map_lock+0x129/0x270
> [ 2141.648251][    C3]  ? __pfx___pte_offset_map_lock+0x10/0x10
> [ 2141.648730][    C3]  migration_entry_wait+0x85/0x270
> [ 2141.649186][    C3]  ? __pfx_migration_entry_wait+0x10/0x10
> [ 2141.649657][    C3]  ? __pfx___schedule+0x10/0x10
> [ 2141.650065][    C3]  ? __hrtimer_start_range_ns+0x355/0xd00
> [ 2141.650555][    C3]  do_swap_page+0x36d2/0x4670
> [ 2141.650950][    C3]  ? plist_del+0x24c/0x450
> [ 2141.651326][    C3]  ? __pte_offset_map+0x2b9/0x3d0
> [ 2141.651743][    C3]  ? __pfx_do_swap_page+0x10/0x10
> [ 2141.652168][    C3]  ? __pfx_default_wake_function+0x10/0x10
> [ 2141.652650][    C3]  handle_pte_fault+0x5ae/0x7b0
> [ 2141.653051][    C3]  __handle_mm_fault+0xf9e/0x17f0
> [ 2141.653473][    C3]  ? __pfx___handle_mm_fault+0x10/0x10
> [ 2141.653931][    C3]  ? lock_vma_under_rcu+0x377/0x4d0
> [ 2141.654355][    C3]  ? __pfx_lock_vma_under_rcu+0x10/0x10
> [ 2141.654795][    C3]  handle_mm_fault+0x4bf/0xa20
> [ 2141.655191][    C3]  exc_page_fault+0x20b/0x7f0
> [ 2141.655573][    C3]  asm_exc_page_fault+0x26/0x30
> [ 2141.655972][    C3] RIP: 0033:0x51d788
> [ 2141.656307][    C3] Code: 66 89 74 17 02 88 0f c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 c5 fa 7f 07 c5 fa 7f 4c 17 f0 c3 0f 1f 44 00 00 48 8b 4c 16 f8 48 8b 36 <48> 89 37 48 89 4c 17 f8 c3 62 e1 fe 28 6f 54 16 ff 62 e1 fe 28 6f
> [ 2141.657882][    C3] RSP: 002b:00007fff991f9118 EFLAGS: 00010202
> [ 2141.658387][    C3] RAX: 0000000020000000 RBX: 0000000000000004 RCX: 002367732f766564
> [ 2141.659048][    C3] RDX: 0000000000000009 RSI: 2367732f7665642f RDI: 0000000020000000
> [ 2141.659691][    C3] RBP: 0000000000797ba0 R08: 00007f10a7800000 R09: 0000000000000001
> [ 2141.660351][    C3] R10: 0000000000000001 R11: 0000000000000009 R12: 0000000000000032
> [ 2141.660997][    C3] R13: 00000000000e2c77 R14: 0000000000795fa0 R15: 0000000000795fac
> [ 2141.661653][    C3]  </TASK>
> [ 2141.661914][    C3] Sending NMI from CPU 3 to CPUs 0-2:
> [ 2141.662396][    C1] NMI backtrace for cpu 1
> [ 2141.662406][    C1] AAA2 2141440346452 2141440306520 0 0 0 2141440307415
> [ 2141.662421][    C1] AAA2 2141440362180 993372484411 993372484804 993372484875 928887973527 928887973577 928887974425
> [ 2141.662439][    C1] softirq_handle_start:
> [ 2141.662442][    C1] 0 
> [ 2141.662447][    C1] 928330006990 
> [ 2141.662451][    C1] 924221567459 
> [ 2141.662456][    C1] 928817263100 
> [ 2141.662461][    C1] 928328744939 
> [ 2141.662465][    C1] 0 
> [ 2141.662470][    C1] 921062008817 
> [ 2141.662475][    C1] 928879010614 
> [ 2141.662480][    C1] 0 
> [ 2141.662484][    C1] 928887973635 
> [ 2141.662489][    C1] 
> [ 2141.662491][    C1] softirq_handle_end_time:
> [ 2141.662495][    C1] 0 
> [ 2141.662499][    C1] 928330009295 
> [ 2141.662504][    C1] 924221568491 
> [ 2141.662509][    C1] 928817511439 
> [ 2141.662514][    C1] 928328806233 
> [ 2141.662518][    C1] 0 
> [ 2141.662522][    C1] 921062009968 
> [ 2141.662527][    C1] 928879011708 
> [ 2141.662532][    C1] 0 
> [ 2141.662536][    C1] 928887974243 
> [ 2141.662541][    C1] 
> [ 2141.662545][    C1] CPU: 1 PID: 8079 Comm: syz.8.781 Tainted: G             L     6.6.0+ #1873
> [ 2141.662564][    C1] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [ 2141.662573][    C1] RIP: 0010:asm_sysvec_irq_work+0x0/0x20
> [ 2141.662608][    C1] Code: 06 14 fd ff e9 a1 05 00 00 90 f3 0f 1e fa 0f 01 ca fc 6a ff e8 51 04 00 00 48 89 c4 48 89 e7 e8 76 f4 fc ff e9 81 05 00 00 90 <f3> 0f 1e fa 0f 01 ca fc 6a ff e8 31 04 00 00 48 89 c4 48 89 e7 e8
> [ 2141.662626][    C1] RSP: 0018:ff11000107889f38 EFLAGS: 00000046
> [ 2141.662642][    C1] RAX: 000000e7499d350b RBX: 0000000000000000 RCX: 0000000000000018
> [ 2141.662655][    C1] RDX: 1fe2200020f16185 RSI: 00000000001e2170 RDI: 0000000000000004
> [ 2141.662668][    C1] RBP: ff1100003ae422c0 R08: 0000000000000001 R09: ffe21c0020f16239
> [ 2141.662681][    C1] R10: 00000000001e2170 R11: 3030303030302052 R12: ff110001078b0c28
> [ 2141.662695][    C1] R13: 0000000000400140 R14: 0000000000000001 R15: dffffc0000000000
> [ 2141.662708][    C1] FS:  00007f10a79556c0(0000) GS:ff11000107880000(0000) knlGS:0000000000000000
> [ 2141.662731][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2141.662744][    C1] CR2: 0000000000638300 CR3: 0000000036592002 CR4: 0000000000771ee0
> [ 2141.662757][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2141.662768][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2141.662779][    C1] PKRU: 00000000
> [ 2141.662785][    C1] Call Trace:
> [ 2141.662792][    C1]  <IRQ>
> [ 2141.662797][    C1] RIP: 0010:handle_softirqs+0x230/0x8d0
> [ 2141.662827][    C1] Code: 24 f5 80 5d 84 98 e8 1f 9b 27 00 4c 89 e2 48 c1 ea 03 42 80 3c 3a 00 0f 85 d5 05 00 00 49 89 04 24 fb 65 44 8b 35 0c 2c 93 72 <4d> 63 f6 49 c7 c4 20 0c 03 00 4a 8d 3c f5 80 5d 84 98 48 89 f8 48
> [ 2141.662844][    C1] RSP: 0018:ff11000107889f68 EFLAGS: 00000246
> [ 2141.662861][    C1]  ? handle_softirqs+0x211/0x8d0
> [ 2141.662890][    C1]  ? update_sibling_normalize_runtime+0x1a/0x410
> [ 2141.662921][    C1]  irq_exit_rcu+0x134/0x190
> [ 2141.662950][    C1]  sysvec_irq_work+0x6a/0x80
> [ 2141.662975][    C1]  </IRQ>
> [ 2141.662980][    C1]  <TASK>
> [ 2141.662986][    C1]  asm_sysvec_irq_work+0x1a/0x20
> [ 2141.663016][    C1] RIP: 0010:rcu_read_unlock_special+0x186/0x530
> [ 2141.663043][    C1] Code: 0f 85 01 01 00 00 4d 85 f6 0f 84 6a 01 00 00 40 84 ed 0f 84 61 01 00 00 bf 09 00 00 00 e8 c2 45 df ff fb 65 8b 2d 26 65 72 72 <48> 63 ed 48 c7 c3 40 1a 03 00 48 b8 00 00 00 00 00 fc ff df 48 8d
> [ 2141.663061][    C1] RSP: 0018:ff110000380b6fe8 EFLAGS: 00000283
> [ 2141.663076][    C1] RAX: 0000000000000001 RBX: ff110001078c6800 RCX: ffffffff8d7c6a90
> [ 2141.663099][    C1] RDX: 0000000000000001 RSI: 0000000000000046 RDI: ff11000100e33084
> [ 2141.663111][    C1] RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff3716ab4
> [ 2141.663124][    C1] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> [ 2141.663135][    C1] R13: dffffc0000000000 R14: 0000000000000200 R15: ffffffff99f43000
> [ 2141.663153][    C1]  ? ttwu_do_activate+0x520/0x6f0
> [ 2141.663186][    C1]  ? rcu_read_unlock_special+0x17e/0x530
> [ 2141.663213][    C1]  page_vma_mapped_walk+0x1e00/0x2b50
> [ 2141.663250][    C1]  ? __netlink_deliver_tap_skb+0x352/0x4d0
> [ 2141.663274][    C1]  ? __pfx_page_vma_mapped_walk+0x10/0x10
> [ 2141.663304][    C1]  ? netlink_ack+0x614/0xba0
> [ 2141.663331][    C1]  try_to_migrate_one+0x3f0/0x2cb0
> [ 2141.663361][    C1]  ? __sys_sendmsg+0xee/0x1b0
> [ 2141.663393][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
> [ 2141.663422][    C1]  ? __orc_find+0x109/0x140
> [ 2141.663450][    C1]  ? arch_stack_walk+0x92/0x160
> [ 2141.663484][    C1]  ? __anon_vma_interval_tree_subtree_search+0x171/0x1f0
> [ 2141.663517][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
> [ 2141.663545][    C1]  rmap_walk_anon+0x2b0/0x980
> [ 2141.663574][    C1]  try_to_migrate+0x19f/0x350
> [ 2141.663598][    C1]  ? __pfx_try_to_migrate+0x10/0x10
> [ 2141.663623][    C1]  ? __pfx_try_to_migrate_one+0x10/0x10
> [ 2141.663644][    C1]  ? __pfx_folio_not_mapped+0x10/0x10
> [ 2141.663665][    C1]  ? __pfx_folio_lock_anon_vma_read+0x10/0x10
> [ 2141.663690][    C1]  ? __pfx_invalid_migration_vma+0x10/0x10
> [ 2141.663711][    C1]  ? folio_total_mapcount+0xb4/0x210
> [ 2141.663738][    C1]  split_huge_page_to_list_to_order+0xc84/0x17f0
> [ 2141.663768][    C1]  ? __pfx_split_huge_page_to_list_to_order+0x10/0x10
> [ 2141.663792][    C1]  ? __orc_find+0x109/0x140
> [ 2141.663819][    C1]  ? __orc_find+0x109/0x140
> [ 2141.663843][    C1]  ? entry_SYSCALL_64_after_hwframe+0x77/0xe2
> [ 2141.663872][    C1]  madvise_cold_or_pageout_pte_range+0x1966/0x2450
> [ 2141.663899][    C1]  ? arch_stack_walk+0x92/0x160
> [ 2141.663918][    C1]  ? __read_once_word_nocheck+0x9/0x20
> [ 2141.663936][    C1]  ? deref_stack_reg+0x1a4/0x2b0
> [ 2141.663955][    C1]  ? entry_SYSCALL_64_after_hwframe+0x77/0xe2
> [ 2141.663974][    C1]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
> [ 2141.663992][    C1]  ? __read_once_word_nocheck+0x9/0x20
> [ 2141.664010][    C1]  ? __orc_find+0x109/0x140
> [ 2141.664027][    C1]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
> [ 2141.664044][    C1]  walk_pmd_range.isra.0+0x240/0x720
> [ 2141.664057][    C1]  ? __read_once_word_nocheck+0x9/0x20
> [ 2141.664076][    C1]  walk_pud_range.isra.0+0x3d3/0x6c0
> [ 2141.664102][    C1]  walk_p4d_range+0x2ef/0x4f0
> [ 2141.664116][    C1]  walk_pgd_range+0x27e/0x530
> [ 2141.664130][    C1]  __walk_page_range+0x4ab/0x5a0
> [ 2141.664141][    C1]  ? find_vma+0x81/0xb0
> [ 2141.664152][    C1]  ? __pfx_find_vma+0x10/0x10
> [ 2141.664162][    C1]  ? folios_put_refs+0x510/0x740
> [ 2141.664175][    C1]  ? walk_page_test+0xa0/0x190
> [ 2141.664195][    C1]  walk_page_range+0x2a0/0x530
> [ 2141.664208][    C1]  ? __pfx_walk_page_range+0x10/0x10
> [ 2141.664220][    C1]  ? vtime_task_switch_generic+0x278/0x5a0
> [ 2141.664237][    C1]  ? folio_batch_move_lru+0x2b8/0x3d0
> [ 2141.664248][    C1]  ? __pfx_lru_add_fn+0x10/0x10
> [ 2141.664261][    C1]  madvise_pageout_page_range+0x1cc/0x6d0
> [ 2141.664278][    C1]  ? __pfx_madvise_pageout_page_range+0x10/0x10
> [ 2141.664298][    C1]  madvise_pageout+0x1f4/0x400
> [ 2141.664314][    C1]  ? __pfx_madvise_pageout+0x10/0x10
> [ 2141.664332][    C1]  ? futex_wait+0x552/0x680
> [ 2141.664352][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [ 2141.664365][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [ 2141.664378][    C1]  ? mas_prev_setup.constprop.0+0xb4/0x530
> [ 2141.664400][    C1]  madvise_vma_behavior+0x8fa/0xe30
> [ 2141.664418][    C1]  ? __pfx_madvise_vma_behavior+0x10/0x10
> [ 2141.664435][    C1]  ? find_vma_prev+0xf5/0x170
> [ 2141.664448][    C1]  ? __pfx_find_vma_prev+0x10/0x10
> [ 2141.664463][    C1]  ? do_futex+0x135/0x360
> [ 2141.664481][    C1]  do_madvise+0x3af/0x650
> [ 2141.664498][    C1]  ? __pfx_do_madvise+0x10/0x10
> [ 2141.664514][    C1]  ? __se_sys_futex+0xf7/0x390
> [ 2141.664530][    C1]  ? kvm_steal_clock+0xca/0x100
> [ 2141.664551][    C1]  ? get_vtime_delta+0xd7/0x250
> [ 2141.664570][    C1]  __x64_sys_madvise+0xaf/0x120
> [ 2141.664586][    C1]  ? __ct_user_exit+0x70/0xe0
> [ 2141.664605][    C1]  do_syscall_64+0x59/0x110
> [ 2141.664625][    C1]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> [ 2141.664644][    C1] RIP: 0033:0x54d2cd
> [ 2141.664654][    C1] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> [ 2141.664665][    C1] RSP: 002b:00007f10a7955048 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> [ 2141.664677][    C1] RAX: ffffffffffffffda RBX: 0000000000795fa0 RCX: 000000000054d2cd
> [ 2141.664685][    C1] RDX: 0000000000000015 RSI: 0000000000003000 RDI: 0000000020001000
> [ 2141.664692][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [ 2141.664699][    C1] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000795fac
> [ 2141.664707][    C1] R13: 0000000000000000 R14: 0000000000795fa0 R15: 00007f10a7935000
> [ 2141.664718][    C1]  </TASK>
> [ 2141.664724][    C2] NMI backtrace for cpu 2
> [ 2141.664745][    C2] AAA2 2141442685830 928616117678 0 0 0 928616122779
> [ 2141.664777][    C2] AAA2 2141442717544 2141439036319 2141439036650 2141439036844 2141439037021 2141439037181 2141439040489
> [ 2141.664813][    C2] softirq_handle_start:
> [ 2141.664819][    C2] 0 
> [ 2141.664827][    C2] 2141437057916 
> [ 2141.664836][    C2] 927808535269 
> [ 2141.664845][    C2] 2140806775443 
> [ 2141.664854][    C2] 28776582930 
> [ 2141.664862][    C2] 0 
> [ 2141.664869][    C2] 0 
> [ 2141.664877][    C2] 2141439037347 
> [ 2141.664885][    C2] 0 
> [ 2141.664893][    C2] 928888742270 
> [ 2141.664901][    C2] 
> [ 2141.664906][    C2] softirq_handle_end_time:
> [ 2141.664912][    C2] 0 
> [ 2141.664920][    C2] 2141437310823 
> [ 2141.664928][    C2] 927808536719 
> [ 2141.664937][    C2] 2140806797386 
> [ 2141.664946][    C2] 28776591391 
> [ 2141.664954][    C2] 0 
> [ 2141.664962][    C2] 0 
> [ 2141.664969][    C2] 2141439040106 
> [ 2141.664978][    C2] 0 
> [ 2141.664985][    C2] 928888825436 
> [ 2141.664993][    C2] 
> [ 2141.665000][    C2] CPU: 2 PID: 8956 Comm: kworker/u8:1 Tainted: G             L     6.6.0+ #1873
> [ 2141.665039][    C2] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [ 2141.665059][    C2] Workqueue: events_unbound nsim_dev_trap_report_work
> [ 2141.665138][    C2] RIP: 0010:memset_orig+0x72/0xb0
> [ 2141.665178][    C2] Code: 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d8 0f 1f 84 00 00 00 00 00 89 d1 83 e1 38 74 14 c1 e9 03 66 0f 1f 44 00 00 ff c9 <48> 89 07 48 8d 7f 08 75 f5 83 e2 07 74 0a ff ca 88 07 48 8d 7f 01
> [ 2141.665213][    C2] RSP: 0018:ff1100006e90f9b0 EFLAGS: 00010202
> [ 2141.665240][    C2] RAX: 0000000000000000 RBX: ff11000095c06000 RCX: 0000000000000001
> [ 2141.665263][    C2] RDX: 0000000000000010 RSI: 0000000000000000 RDI: ff11000095c07000
> [ 2141.665285][    C2] RBP: ffd4000002570000 R08: 0000000000000008 R09: 0000000000000000
> [ 2141.665307][    C2] R10: ff11000095c07000 R11: 0000000000000006 R12: ff11000095c00000
> [ 2141.665330][    C2] R13: 0000000000008000 R14: 0000000000000003 R15: ff1100010003d040
> [ 2141.665353][    C2] FS:  0000000000000000(0000) GS:ff11000107900000(0000) knlGS:0000000000000000
> [ 2141.665390][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2141.665417][    C2] CR2: 00000000012c5000 CR3: 0000000105636005 CR4: 0000000000771ee0
> [ 2141.665440][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2141.665461][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2141.665483][    C2] PKRU: 55555554
> [ 2141.665495][    C2] Call Trace:
> [ 2141.665506][    C2]  <TASK>
> [ 2141.665516][    C2]  __kasan_init_slab_obj+0xd/0x20
> [ 2141.665556][    C2]  setup_object+0x17/0x90
> [ 2141.665591][    C2]  shuffle_freelist+0xb1/0x170
> [ 2141.665642][    C2]  allocate_slab+0x13e/0x320
> [ 2141.665693][    C2]  ___slab_alloc+0x570/0x8a0
> [ 2141.665742][    C2]  ? nsim_dev_trap_report_work+0x27e/0x610
> [ 2141.665785][    C2]  ? process_one_work+0x661/0x1020
> [ 2141.665821][    C2]  ? __alloc_skb+0x12b/0x330
> [ 2141.665862][    C2]  ? ret_from_fork_asm+0x1b/0x30
> [ 2141.665898][    C2]  ? kasan_set_track+0x25/0x30
> [ 2141.665954][    C2]  ? __kasan_slab_alloc+0x6e/0x70
> [ 2141.665996][    C2]  __kmem_cache_alloc_node+0x3cc/0x460
> [ 2141.666051][    C2]  ? __alloc_skb+0x12b/0x330
> [ 2141.666109][    C2]  ? __alloc_skb+0x12b/0x330
> [ 2141.666151][    C2]  __kmalloc_node_track_caller+0x53/0x140
> [ 2141.666208][    C2]  kmalloc_reserve+0xf4/0x270
> [ 2141.666255][    C2]  __alloc_skb+0x12b/0x330
> [ 2141.666297][    C2]  ? __pfx___alloc_skb+0x10/0x10
> [ 2141.666339][    C2]  ? kasan_set_track+0x25/0x30
> [ 2141.666395][    C2]  ? kasan_save_free_info+0x2b/0x50
> [ 2141.666445][    C2]  ? kmem_cache_free+0xce/0x530
> [ 2141.666496][    C2]  ? kfree_skbmem+0xf4/0x1b0
> [ 2141.666541][    C2]  nsim_dev_trap_skb_build+0x2e/0x710
> [ 2141.666588][    C2]  nsim_dev_trap_report_work+0x27e/0x610
> [ 2141.666643][    C2]  process_one_work+0x661/0x1020
> [ 2141.666689][    C2]  worker_thread+0x849/0x1090
> [ 2141.666734][    C2]  ? __kthread_parkme+0x10d/0x190
> [ 2141.666781][    C2]  ? __pfx_worker_thread+0x10/0x10
> [ 2141.666818][    C2]  kthread+0x2f4/0x3f0
> [ 2141.666868][    C2]  ? __pfx_kthread+0x10/0x10
> [ 2141.666921][    C2]  ret_from_fork+0x4a/0x80
> [ 2141.666966][    C2]  ? __pfx_kthread+0x10/0x10
> [ 2141.667018][    C2]  ret_from_fork_asm+0x1b/0x30
> [ 2141.667065][    C2]  </TASK>
> [ 2141.667077][    C0] NMI backtrace for cpu 0 skipped: idling at default_idle+0xf/0x20
> [ 2141.667141][    C0] AAA1 2141445081811 928856909383 0 0 0 928856909774
> [ 2141.667173][    C0] AAA1 2141445113956 2141440058230 2141440058591 2141440058780 2141440058946 2141440059101 2141440070327
> [ 2141.667210][    C0] softirq_handle_start:
> [ 2141.667216][    C0] 0 
> [ 2141.667224][    C0] 2141440059261 
> [ 2141.667233][    C0] 928873837201 
> [ 2141.667242][    C0] 2136080964230 
> [ 2141.667251][    C0] 0 
> [ 2141.667258][    C0] 0 
> [ 2141.667265][    C0] 928609012446 
> [ 2141.667274][    C0] 2141438064270 
> [ 2141.667283][    C0] 0 
> [ 2141.667290][    C0] 928888606411 
> [ 2141.667299][    C0] 
> [ 2141.667303][    C0] softirq_handle_end_time:
> [ 2141.667310][    C0] 0 
> [ 2141.667317][    C0] 2141440069902 
> [ 2141.667326][    C0] 928873838583 
> [ 2141.667334][    C0] 2136081297815 
> [ 2141.667343][    C0] 0 
> [ 2141.667350][    C0] 0 
> [ 2141.667358][    C0] 928609013591 
> [ 2141.667366][    C0] 2141438082237 
> [ 2141.667375][    C0] 0 
> [ 2141.667382][    C0] 928888785127 
> [ 2141.667391][    C0] 

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86 6.15.0-rc7 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc (GCC) 10.3.1"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=100301
> CONFIG_CLANG_VERSION=0
> CONFIG_AS_IS_GNU=y
> CONFIG_AS_VERSION=23700
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23700
> CONFIG_LLD_VERSION=0
> CONFIG_RUSTC_VERSION=0
> CONFIG_RUSTC_LLVM_VERSION=0
> CONFIG_CC_CAN_LINK=y
> CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_LD_CAN_USE_KEEP_IN_OVERLAY=y
> CONFIG_PAHOLE_VERSION=128
> CONFIG_CONSTRUCTORS=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=""
> # CONFIG_LOCALVERSION_AUTO is not set
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_HAVE_KERNEL_ZSTD=y
> CONFIG_KERNEL_GZIP=y
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_SYSVIPC_COMPAT=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_POSIX_MQUEUE_SYSCTL=y
> # CONFIG_WATCH_QUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=y
> # CONFIG_USELIB is not set
> CONFIG_AUDIT=y
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> CONFIG_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_GENERIC_IRQ_INJECTION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_CONTEXT_TRACKING=y
> CONFIG_CONTEXT_TRACKING_IDLE=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ_FULL=y
> CONFIG_CONTEXT_TRACKING_USER=y
> # CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
> # end of Timers subsystem
> 
> CONFIG_BPF=y
> CONFIG_HAVE_EBPF_JIT=y
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> 
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=y
> CONFIG_BPF_JIT=y
> CONFIG_BPF_JIT_ALWAYS_ON=y
> CONFIG_BPF_JIT_DEFAULT_ON=y
> # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
> # CONFIG_BPF_PRELOAD is not set
> CONFIG_BPF_LSM=y
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_BUILD=y
> CONFIG_ARCH_HAS_PREEMPT_LAZY=y
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> # CONFIG_PREEMPT_LAZY is not set
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_DYNAMIC=y
> # CONFIG_SCHED_CORE is not set
> # CONFIG_SCHED_CLASS_EXT is not set
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=y
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_SCHED_AVG_IRQ=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_TASKSTATS=y
> CONFIG_TASK_DELAY_ACCT=y
> CONFIG_TASK_XACCT=y
> CONFIG_TASK_IO_ACCOUNTING=y
> CONFIG_PSI=y
> CONFIG_PSI_DEFAULT_DISABLED=y
> # end of CPU/Task time and stats accounting
> 
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> CONFIG_PREEMPT_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_NEED_TASKS_RCU=y
> CONFIG_TASKS_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_RCU_NOCB_CPU=y
> # CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
> # CONFIG_RCU_LAZY is not set
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> # CONFIG_PRINTK_INDEX is not set
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # CONFIG_UCLAMP_TASK is not set
> # end of Scheduler features
> 
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CC_HAS_INT128=y
> CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
> CONFIG_GCC10_NO_ARRAY_BOUNDS=y
> CONFIG_CC_NO_ARRAY_BOUNDS=y
> CONFIG_GCC_NO_STRINGOP_OVERFLOW=y
> CONFIG_CC_NO_STRINGOP_OVERFLOW=y
> CONFIG_ARCH_SUPPORTS_INT128=y
> CONFIG_NUMA_BALANCING=y
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
> CONFIG_SLAB_OBJ_EXT=y
> CONFIG_CGROUPS=y
> CONFIG_PAGE_COUNTER=y
> # CONFIG_CGROUP_FAVOR_DYNMODS is not set
> CONFIG_MEMCG=y
> # CONFIG_MEMCG_V1 is not set
> CONFIG_BLK_CGROUP=y
> CONFIG_CGROUP_WRITEBACK=y
> CONFIG_CGROUP_SCHED=y
> CONFIG_GROUP_SCHED_WEIGHT=y
> CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_CFS_BANDWIDTH=y
> CONFIG_RT_GROUP_SCHED=y
> CONFIG_SCHED_MM_CID=y
> CONFIG_CGROUP_PIDS=y
> CONFIG_CGROUP_RDMA=y
> # CONFIG_CGROUP_DMEM is not set
> CONFIG_CGROUP_FREEZER=y
> CONFIG_CGROUP_HUGETLB=y
> CONFIG_CPUSETS=y
> # CONFIG_CPUSETS_V1 is not set
> CONFIG_CGROUP_DEVICE=y
> CONFIG_CGROUP_CPUACCT=y
> CONFIG_CGROUP_PERF=y
> CONFIG_CGROUP_BPF=y
> CONFIG_CGROUP_MISC=y
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_SOCK_CGROUP_DATA=y
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_TIME_NS=y
> CONFIG_IPC_NS=y
> CONFIG_USER_NS=y
> CONFIG_PID_NS=y
> CONFIG_NET_NS=y
> CONFIG_CHECKPOINT_RESTORE=y
> CONFIG_SCHED_AUTOGROUP=y
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> CONFIG_RD_ZSTD=y
> CONFIG_BOOT_CONFIG=y
> # CONFIG_BOOT_CONFIG_FORCE is not set
> # CONFIG_BOOT_CONFIG_EMBED is not set
> # CONFIG_INITRAMFS_PRESERVE_MTIME is not set
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> # CONFIG_EXPERT is not set
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_IO_URING=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KCMP=y
> CONFIG_RSEQ=y
> CONFIG_CACHESTAT_SYSCALL=y
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_SELFTEST is not set
> CONFIG_KALLSYMS_ALL=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS=y
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_GUEST_PERF_EVENTS=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
> 
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> # CONFIG_PROFILING is not set
> CONFIG_TRACEPOINTS=y
> 
> #
> # Kexec and crash features
> #
> CONFIG_CRASH_RESERVE=y
> CONFIG_VMCORE_INFO=y
> CONFIG_KEXEC_CORE=y
> CONFIG_HAVE_IMA_KEXEC=y
> CONFIG_KEXEC=y
> CONFIG_KEXEC_FILE=y
> CONFIG_KEXEC_SIG=y
> CONFIG_KEXEC_SIG_FORCE=y
> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
> CONFIG_KEXEC_JUMP=y
> CONFIG_CRASH_DUMP=y
> CONFIG_CRASH_HOTPLUG=y
> CONFIG_CRASH_MAX_MEMORY_RANGES=8192
> # end of Kexec and crash features
> # end of General setup
> 
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_CSUM=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
> CONFIG_HAVE_INTEL_TXT=y
> CONFIG_X86_64_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_DYNAMIC_PHYSICAL_MASK=y
> CONFIG_PGTABLE_LEVELS=5
> 
> #
> # Processor type and features
> #
> CONFIG_SMP=y
> CONFIG_X86_X2APIC=y
> # CONFIG_X86_POSTED_MSI is not set
> CONFIG_X86_MPPARSE=y
> CONFIG_X86_CPU_RESCTRL=y
> CONFIG_RESCTRL_FS_PSEUDO_LOCK=y
> # CONFIG_X86_FRED is not set
> CONFIG_X86_EXTENDED_PLATFORM=y
> # CONFIG_X86_NUMACHIP is not set
> # CONFIG_X86_VSMP is not set
> CONFIG_X86_UV=y
> # CONFIG_X86_INTEL_MID is not set
> # CONFIG_X86_GOLDFISH is not set
> CONFIG_X86_INTEL_LPSS=y
> CONFIG_X86_AMD_PLATFORM_DEVICE=y
> CONFIG_IOSF_MBI=y
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_SCHED_OMIT_FRAME_POINTER=y
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> # CONFIG_PARAVIRT_SPINLOCKS is not set
> CONFIG_X86_HV_CALLBACK_VECTOR=y
> CONFIG_XEN=y
> # CONFIG_XEN_PV is not set
> CONFIG_XEN_PVHVM=y
> CONFIG_XEN_PVHVM_SMP=y
> CONFIG_XEN_PVHVM_GUEST=y
> CONFIG_XEN_SAVE_RESTORE=y
> # CONFIG_XEN_DEBUG_FS is not set
> # CONFIG_XEN_PVH is not set
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> # CONFIG_PVH is not set
> CONFIG_PARAVIRT_TIME_ACCOUNTING=y
> CONFIG_PARAVIRT_CLOCK=y
> # CONFIG_JAILHOUSE_GUEST is not set
> # CONFIG_ACRN_GUEST is not set
> # CONFIG_INTEL_TDX_GUEST is not set
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_HAVE_PAE=y
> CONFIG_X86_CX8=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=64
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_BROADCAST_TLB_FLUSH=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_HYGON=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_ZHAOXIN=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_DMI=y
> # CONFIG_GART_IOMMU is not set
> CONFIG_BOOT_VESA_SUPPORT=y
> CONFIG_MAXSMP=y
> CONFIG_NR_CPUS_RANGE_BEGIN=8192
> CONFIG_NR_CPUS_RANGE_END=8192
> CONFIG_NR_CPUS_DEFAULT=8192
> CONFIG_NR_CPUS=8192
> CONFIG_SCHED_CLUSTER=y
> CONFIG_SCHED_SMT=y
> CONFIG_SCHED_MC=y
> CONFIG_SCHED_MC_PRIO=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_ACPI_MADT_WAKEUP=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCELOG_LEGACY=y
> CONFIG_X86_MCE_INTEL=y
> CONFIG_X86_MCE_AMD=y
> CONFIG_X86_MCE_THRESHOLD=y
> CONFIG_X86_MCE_INJECT=y
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> CONFIG_PERF_EVENTS_INTEL_RAPL=y
> CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> CONFIG_PERF_EVENTS_AMD_POWER=y
> CONFIG_PERF_EVENTS_AMD_UNCORE=y
> CONFIG_PERF_EVENTS_AMD_BRS=y
> # end of Performance monitoring
> 
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX64=y
> CONFIG_X86_VSYSCALL_EMULATION=y
> CONFIG_X86_IOPL_IOPERM=y
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_LATE_LOADING=y
> # CONFIG_MICROCODE_LATE_FORCE_MINREV is not set
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> CONFIG_X86_5LEVEL=y
> CONFIG_X86_DIRECT_GBPAGES=y
> # CONFIG_X86_CPA_STATISTICS is not set
> CONFIG_X86_MEM_ENCRYPT=y
> CONFIG_AMD_MEM_ENCRYPT=y
> CONFIG_NUMA=y
> CONFIG_AMD_NUMA=y
> CONFIG_X86_64_ACPI_NUMA=y
> CONFIG_NODES_SHIFT=10
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> # CONFIG_ARCH_MEMORY_PROBE is not set
> CONFIG_ARCH_PROC_KCORE_TEXT=y
> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> CONFIG_X86_PMEM_LEGACY_DEVICE=y
> CONFIG_X86_PMEM_LEGACY=y
> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_X86_UMIP=y
> CONFIG_CC_HAS_IBT=y
> CONFIG_X86_CET=y
> CONFIG_X86_KERNEL_IBT=y
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> CONFIG_ARCH_PKEY_BITS=4
> CONFIG_X86_INTEL_TSX_MODE_OFF=y
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> CONFIG_X86_SGX=y
> # CONFIG_X86_USER_SHADOW_STACK is not set
> CONFIG_EFI=y
> CONFIG_EFI_STUB=y
> CONFIG_EFI_HANDOVER_PROTOCOL=y
> CONFIG_EFI_MIXED=y
> CONFIG_EFI_RUNTIME_MAP=y
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> CONFIG_HZ_1000=y
> CONFIG_HZ=1000
> CONFIG_SCHED_HRTICK=y
> CONFIG_ARCH_SUPPORTS_KEXEC=y
> CONFIG_ARCH_SUPPORTS_KEXEC_FILE=y
> CONFIG_ARCH_SELECTS_KEXEC_FILE=y
> CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=y
> CONFIG_ARCH_SUPPORTS_KEXEC_SIG=y
> CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=y
> CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=y
> CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y
> CONFIG_ARCH_SUPPORTS_CRASH_DUMP=y
> CONFIG_ARCH_DEFAULT_CRASH_DUMP=y
> CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=y
> CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> CONFIG_RANDOMIZE_BASE=y
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> CONFIG_RANDOMIZE_MEMORY=y
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
> CONFIG_HOTPLUG_CPU=y
> # CONFIG_COMPAT_VDSO is not set
> CONFIG_LEGACY_VSYSCALL_XONLY=y
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> CONFIG_HAVE_LIVEPATCH=y
> CONFIG_LIVEPATCH=y
> CONFIG_X86_BUS_LOCK_DETECT=y
> # end of Processor type and features
> 
> CONFIG_CC_HAS_NAMED_AS=y
> CONFIG_CC_HAS_RETURN_THUNK=y
> CONFIG_CC_HAS_ENTRY_PADDING=y
> CONFIG_FUNCTION_PADDING_CFI=11
> CONFIG_FUNCTION_PADDING_BYTES=16
> CONFIG_CALL_PADDING=y
> CONFIG_HAVE_CALL_THUNKS=y
> CONFIG_CALL_THUNKS=y
> CONFIG_PREFIX_SYMBOLS=y
> CONFIG_CPU_MITIGATIONS=y
> CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=y
> CONFIG_MITIGATION_RETPOLINE=y
> CONFIG_MITIGATION_RETHUNK=y
> CONFIG_MITIGATION_UNRET_ENTRY=y
> CONFIG_MITIGATION_CALL_DEPTH_TRACKING=y
> # CONFIG_CALL_THUNKS_DEBUG is not set
> CONFIG_MITIGATION_IBPB_ENTRY=y
> CONFIG_MITIGATION_IBRS_ENTRY=y
> CONFIG_MITIGATION_SRSO=y
> CONFIG_MITIGATION_GDS=y
> CONFIG_MITIGATION_RFDS=y
> CONFIG_MITIGATION_SPECTRE_BHI=y
> CONFIG_MITIGATION_MDS=y
> CONFIG_MITIGATION_TAA=y
> CONFIG_MITIGATION_MMIO_STALE_DATA=y
> CONFIG_MITIGATION_L1TF=y
> CONFIG_MITIGATION_RETBLEED=y
> CONFIG_MITIGATION_SPECTRE_V1=y
> CONFIG_MITIGATION_SPECTRE_V2=y
> CONFIG_MITIGATION_SRBDS=y
> CONFIG_MITIGATION_SSB=y
> CONFIG_MITIGATION_ITS=y
> CONFIG_ARCH_HAS_ADD_PAGES=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=y
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> CONFIG_HIBERNATE_CALLBACKS=y
> CONFIG_HIBERNATION=y
> CONFIG_HIBERNATION_SNAPSHOT_DEV=y
> CONFIG_HIBERNATION_COMP_LZO=y
> CONFIG_HIBERNATION_DEF_COMP="lzo"
> CONFIG_PM_STD_PARTITION=""
> CONFIG_PM_SLEEP=y
> CONFIG_PM_SLEEP_SMP=y
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_USERSPACE_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> # CONFIG_PM_ADVANCED_DEBUG is not set
> # CONFIG_PM_TEST_SUSPEND is not set
> CONFIG_PM_SLEEP_DEBUG=y
> # CONFIG_PM_TRACE_RTC is not set
> CONFIG_PM_CLK=y
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> # CONFIG_ENERGY_MODEL is not set
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> CONFIG_ACPI_TABLE_LIB=y
> CONFIG_ACPI_THERMAL_LIB=y
> CONFIG_ACPI_DEBUGGER=y
> CONFIG_ACPI_DEBUGGER_USER=y
> CONFIG_ACPI_SPCR_TABLE=y
> # CONFIG_ACPI_FPDT is not set
> CONFIG_ACPI_LPIT=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_EC_DEBUGFS=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=y
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_TAD=y
> CONFIG_ACPI_DOCK=y
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_CPPC_LIB=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_IPMI=y
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
> CONFIG_ACPI_THERMAL=y
> CONFIG_ACPI_PLATFORM_PROFILE=y
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_PCI_SLOT=y
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_MEMORY=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> CONFIG_ACPI_SBS=y
> CONFIG_ACPI_HED=y
> CONFIG_ACPI_BGRT=y
> CONFIG_ACPI_NHLT=y
> CONFIG_ACPI_NFIT=y
> # CONFIG_NFIT_SECURITY_DEBUG is not set
> CONFIG_ACPI_NUMA=y
> CONFIG_ACPI_HMAT=y
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> CONFIG_ACPI_APEI=y
> CONFIG_ACPI_APEI_GHES=y
> CONFIG_ACPI_APEI_PCIEAER=y
> CONFIG_ACPI_APEI_MEMORY_FAILURE=y
> CONFIG_ACPI_APEI_EINJ=y
> CONFIG_ACPI_APEI_EINJ_CXL=y
> # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> CONFIG_ACPI_DPTF=y
> CONFIG_DPTF_POWER=y
> # CONFIG_DPTF_PCH_FIVR is not set
> CONFIG_ACPI_WATCHDOG=y
> CONFIG_ACPI_EXTLOG=y
> CONFIG_ACPI_ADXL=y
> # CONFIG_ACPI_CONFIGFS is not set
> # CONFIG_ACPI_PFRUT is not set
> CONFIG_ACPI_PCC=y
> # CONFIG_ACPI_FFH is not set
> CONFIG_PMIC_OPREGION=y
> CONFIG_ACPI_PRMT=y
> CONFIG_X86_PM_TIMER=y
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> 
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=y
> # CONFIG_X86_PCC_CPUFREQ is not set
> CONFIG_X86_AMD_PSTATE=y
> CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3
> # CONFIG_X86_AMD_PSTATE_UT is not set
> CONFIG_X86_ACPI_CPUFREQ=y
> CONFIG_X86_ACPI_CPUFREQ_CPB=y
> CONFIG_X86_POWERNOW_K8=y
> CONFIG_X86_AMD_FREQ_SENSITIVITY=y
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> CONFIG_X86_P4_CLOCKMOD=y
> 
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=y
> CONFIG_CPUFREQ_ARCH_CUR_FREQ=y
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> # CONFIG_CPU_IDLE_GOV_LADDER is not set
> CONFIG_CPU_IDLE_GOV_MENU=y
> CONFIG_CPU_IDLE_GOV_TEO=y
> CONFIG_CPU_IDLE_GOV_HALTPOLL=y
> CONFIG_HALTPOLL_CPUIDLE=y
> # end of CPU Idle
> 
> CONFIG_INTEL_IDLE=y
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_PCI_XEN=y
> CONFIG_MMCONF_FAM10H=y
> CONFIG_ISA_DMA_API=y
> CONFIG_AMD_NB=y
> CONFIG_AMD_NODE=y
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_IA32_EMULATION=y
> # CONFIG_IA32_EMULATION_DEFAULT_DISABLED is not set
> # CONFIG_X86_X32_ABI is not set
> CONFIG_COMPAT_32=y
> CONFIG_COMPAT=y
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
> # end of Binary Emulations
> 
> CONFIG_KVM_COMMON=y
> CONFIG_HAVE_KVM_PFNCACHE=y
> CONFIG_HAVE_KVM_IRQCHIP=y
> CONFIG_HAVE_KVM_IRQ_ROUTING=y
> CONFIG_HAVE_KVM_DIRTY_RING=y
> CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
> CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
> CONFIG_KVM_MMIO=y
> CONFIG_KVM_ASYNC_PF=y
> CONFIG_HAVE_KVM_MSI=y
> CONFIG_HAVE_KVM_READONLY_MEM=y
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
> CONFIG_KVM_VFIO=y
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY=y
> CONFIG_KVM_COMPAT=y
> CONFIG_HAVE_KVM_IRQ_BYPASS=y
> CONFIG_HAVE_KVM_NO_POLL=y
> CONFIG_KVM_XFER_TO_GUEST_WORK=y
> CONFIG_HAVE_KVM_PM_NOTIFIER=y
> CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
> CONFIG_KVM_GENERIC_MMU_NOTIFIER=y
> CONFIG_KVM_ELIDE_TLB_FLUSH_IF_YOUNG=y
> CONFIG_KVM_MMU_LOCKLESS_AGING=y
> CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES=y
> CONFIG_KVM_PRIVATE_MEM=y
> CONFIG_KVM_GENERIC_PRIVATE_MEM=y
> CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE=y
> CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_KVM_X86=y
> CONFIG_KVM=y
> # CONFIG_KVM_INTEL is not set
> CONFIG_KVM_AMD=y
> CONFIG_KVM_AMD_SEV=y
> CONFIG_KVM_SMM=y
> CONFIG_KVM_HYPERV=y
> # CONFIG_KVM_XEN is not set
> CONFIG_KVM_MAX_NR_VCPUS=4096
> CONFIG_X86_REQUIRED_FEATURE_ALWAYS=y
> CONFIG_X86_REQUIRED_FEATURE_NOPL=y
> CONFIG_X86_REQUIRED_FEATURE_CX8=y
> CONFIG_X86_REQUIRED_FEATURE_CMOV=y
> CONFIG_X86_REQUIRED_FEATURE_CPUID=y
> CONFIG_X86_REQUIRED_FEATURE_FPU=y
> CONFIG_X86_REQUIRED_FEATURE_PAE=y
> CONFIG_X86_REQUIRED_FEATURE_PSE=y
> CONFIG_X86_REQUIRED_FEATURE_PGE=y
> CONFIG_X86_REQUIRED_FEATURE_MSR=y
> CONFIG_X86_REQUIRED_FEATURE_FXSR=y
> CONFIG_X86_REQUIRED_FEATURE_XMM=y
> CONFIG_X86_REQUIRED_FEATURE_XMM2=y
> CONFIG_X86_REQUIRED_FEATURE_LM=y
> CONFIG_X86_DISABLED_FEATURE_VME=y
> CONFIG_X86_DISABLED_FEATURE_K6_MTRR=y
> CONFIG_X86_DISABLED_FEATURE_CYRIX_ARR=y
> CONFIG_X86_DISABLED_FEATURE_CENTAUR_MCR=y
> CONFIG_X86_DISABLED_FEATURE_LAM=y
> CONFIG_X86_DISABLED_FEATURE_XENPV=y
> CONFIG_X86_DISABLED_FEATURE_TDX_GUEST=y
> CONFIG_X86_DISABLED_FEATURE_USER_SHSTK=y
> CONFIG_X86_DISABLED_FEATURE_FRED=y
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> CONFIG_AS_TPAUSE=y
> CONFIG_AS_GFNI=y
> CONFIG_AS_VAES=y
> CONFIG_AS_VPCLMULQDQ=y
> CONFIG_AS_WRUSS=y
> CONFIG_ARCH_CONFIGURES_CPU_MITIGATIONS=y
> CONFIG_ARCH_HAS_DMA_OPS=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_HOTPLUG_SMT=y
> CONFIG_HOTPLUG_CORE_SYNC=y
> CONFIG_HOTPLUG_CORE_SYNC_DEAD=y
> CONFIG_HOTPLUG_CORE_SYNC_FULL=y
> CONFIG_HOTPLUG_SPLIT_STARTUP=y
> CONFIG_HOTPLUG_PARALLEL=y
> CONFIG_GENERIC_ENTRY=y
> CONFIG_KPROBES=y
> CONFIG_JUMP_LABEL=y
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_OPTPROBES=y
> CONFIG_KPROBES_ON_FTRACE=y
> CONFIG_UPROBES=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_KRETPROBES=y
> CONFIG_KRETPROBE_ON_RETHOOK=y
> CONFIG_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
> CONFIG_ARCH_HAS_CPU_PASID=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_ARCH_WANTS_NO_INSTR=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_RUST=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_MMU_GATHER_MERGE_VMAS=y
> CONFIG_MMU_LAZY_TLB_REFCOUNT=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_ARCH_HAVE_EXTRA_ELF_NOTES=y
> CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP=y
> CONFIG_SECCOMP_FILTER=y
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_LTO_NONE=y
> CONFIG_ARCH_SUPPORTS_AUTOFDO_CLANG=y
> CONFIG_ARCH_SUPPORTS_PROPELLER_CLANG=y
> CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_CONTEXT_TRACKING_USER=y
> CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PUD=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_ARCH_WANT_PMD_MKWRITE=y
> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_ARCH_HAS_EXECMEM_ROX=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
> CONFIG_HAVE_PAGE_SIZE_4KB=y
> CONFIG_PAGE_SIZE_4KB=y
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
> CONFIG_PAGE_SHIFT=12
> CONFIG_HAVE_OBJTOOL=y
> CONFIG_HAVE_JUMP_LABEL_HACK=y
> CONFIG_HAVE_NOINSTR_HACK=y
> CONFIG_HAVE_NOINSTR_VALIDATION=y
> CONFIG_HAVE_UACCESS_VALIDATION=y
> CONFIG_HAVE_STACK_VALIDATION=y
> CONFIG_HAVE_RELIABLE_STACKTRACE=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_COMPAT_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_ARCH_SUPPORTS_RT=y
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
> CONFIG_RANDOMIZE_KSTACK_OFFSET=y
> # CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> CONFIG_ARCH_USE_MEMREMAP_PROT=y
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_ARCH_HAS_CC_PLATFORM=y
> CONFIG_HAVE_STATIC_CALL=y
> CONFIG_HAVE_STATIC_CALL_INLINE=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
> CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
> CONFIG_DYNAMIC_SIGFRAME=y
> CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y
> CONFIG_ARCH_HAS_HW_PTE_YOUNG=y
> CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y
> CONFIG_ARCH_HAS_KERNEL_FPU_SUPPORT=y
> CONFIG_ARCH_VMLINUX_NEEDS_RELOCS=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> CONFIG_FUNCTION_ALIGNMENT_4B=y
> CONFIG_FUNCTION_ALIGNMENT_16B=y
> CONFIG_FUNCTION_ALIGNMENT=16
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_MODULE_SIG_FORMAT=y
> CONFIG_MODULES=y
> # CONFIG_MODULE_DEBUG is not set
> CONFIG_MODULE_FORCE_LOAD=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
> CONFIG_MODVERSIONS=y
> CONFIG_GENKSYMS=y
> CONFIG_ASM_MODVERSIONS=y
> # CONFIG_EXTENDED_MODVERSIONS is not set
> CONFIG_BASIC_MODVERSIONS=y
> CONFIG_MODULE_SRCVERSION_ALL=y
> CONFIG_MODULE_SIG=y
> # CONFIG_MODULE_SIG_FORCE is not set
> CONFIG_MODULE_SIG_ALL=y
> # CONFIG_MODULE_SIG_SHA1 is not set
> CONFIG_MODULE_SIG_SHA256=y
> # CONFIG_MODULE_SIG_SHA384 is not set
> # CONFIG_MODULE_SIG_SHA512 is not set
> # CONFIG_MODULE_SIG_SHA3_256 is not set
> # CONFIG_MODULE_SIG_SHA3_384 is not set
> # CONFIG_MODULE_SIG_SHA3_512 is not set
> CONFIG_MODULE_SIG_HASH="sha256"
> # CONFIG_MODULE_COMPRESS is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH="/sbin/modprobe"
> # CONFIG_TRIM_UNUSED_KSYMS is not set
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLOCK_LEGACY_AUTOLOAD=y
> CONFIG_BLK_RQ_ALLOC_TIME=y
> CONFIG_BLK_CGROUP_RWSTAT=y
> CONFIG_BLK_DEV_BSG_COMMON=y
> CONFIG_BLK_ICQ=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> CONFIG_BLK_DEV_WRITE_MOUNTED=y
> CONFIG_BLK_DEV_ZONED=y
> CONFIG_BLK_DEV_THROTTLING=y
> CONFIG_BLK_WBT=y
> CONFIG_BLK_WBT_MQ=y
> # CONFIG_BLK_CGROUP_IOLATENCY is not set
> # CONFIG_BLK_CGROUP_FC_APPID is not set
> CONFIG_BLK_CGROUP_IOCOST=y
> # CONFIG_BLK_CGROUP_IOPRIO is not set
> CONFIG_BLK_DEBUG_FS=y
> # CONFIG_BLK_SED_OPAL is not set
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_AIX_PARTITION is not set
> CONFIG_OSF_PARTITION=y
> CONFIG_AMIGA_PARTITION=y
> # CONFIG_ATARI_PARTITION is not set
> CONFIG_MAC_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_BSD_DISKLABEL=y
> CONFIG_MINIX_SUBPARTITION=y
> CONFIG_SOLARIS_X86_PARTITION=y
> CONFIG_UNIXWARE_DISKLABEL=y
> # CONFIG_LDM_PARTITION is not set
> CONFIG_SGI_PARTITION=y
> # CONFIG_ULTRIX_PARTITION is not set
> CONFIG_SUN_PARTITION=y
> CONFIG_KARMA_PARTITION=y
> CONFIG_EFI_PARTITION=y
> # CONFIG_SYSV68_PARTITION is not set
> # CONFIG_CMDLINE_PARTITION is not set
> # end of Partition Types
> 
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_PM=y
> CONFIG_BLOCK_HOLDER_DEPRECATED=y
> CONFIG_BLK_MQ_STACKING=y
> 
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=y
> CONFIG_IOSCHED_BFQ=y
> CONFIG_BFQ_GROUP_IOSCHED=y
> # CONFIG_BFQ_CGROUP_DEBUG is not set
> # end of IO Schedulers
> 
> CONFIG_PREEMPT_NOTIFIERS=y
> CONFIG_PADATA=y
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_COMPAT_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=y
> CONFIG_COREDUMP=y
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_ZPOOL=y
> CONFIG_SWAP=y
> CONFIG_ZSWAP=y
> # CONFIG_ZSWAP_DEFAULT_ON is not set
> # CONFIG_ZSWAP_SHRINKER_DEFAULT_ON is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=y
> CONFIG_ZSWAP_ZPOOL_DEFAULT="zsmalloc"
> CONFIG_ZSMALLOC=y
> CONFIG_ZSMALLOC_STAT=y
> CONFIG_ZSMALLOC_CHAIN_SIZE=8
> 
> #
> # Slab allocator options
> #
> CONFIG_SLUB=y
> CONFIG_KVFREE_RCU_BATCHED=y
> CONFIG_SLAB_MERGE_DEFAULT=y
> CONFIG_SLAB_FREELIST_RANDOM=y
> # CONFIG_SLAB_FREELIST_HARDENED is not set
> # CONFIG_SLAB_BUCKETS is not set
> # CONFIG_SLUB_STATS is not set
> CONFIG_SLUB_CPU_PARTIAL=y
> # CONFIG_RANDOM_KMALLOC_CACHES is not set
> # end of Slab allocator options
> 
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> # CONFIG_COMPAT_BRK is not set
> CONFIG_SPARSEMEM=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_SPARSEMEM_VMEMMAP_PREINIT=y
> CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=y
> CONFIG_ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP=y
> CONFIG_ARCH_WANT_HUGETLB_VMEMMAP_PREINIT=y
> CONFIG_HAVE_GUP_FAST=y
> CONFIG_NUMA_KEEP_MEMINFO=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_EXCLUSIVE_SYSTEM_RAM=y
> CONFIG_HAVE_BOOTMEM_INFO_NODE=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_MEMORY_HOTPLUG=y
> CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE=y
> # CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_AUTO is not set
> # CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_KERNEL is not set
> # CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_MOVABLE is not set
> CONFIG_MEMORY_HOTREMOVE=y
> CONFIG_MHP_MEMMAP_ON_MEMORY=y
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
> CONFIG_SPLIT_PTE_PTLOCKS=y
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_SPLIT_PMD_PTLOCKS=y
> CONFIG_MEMORY_BALLOON=y
> CONFIG_BALLOON_COMPACTION=y
> CONFIG_COMPACTION=y
> CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
> CONFIG_PAGE_REPORTING=y
> CONFIG_MIGRATION=y
> CONFIG_DEVICE_MIGRATION=y
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
> CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_PCP_BATCH_SCALE_MAX=5
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_MMU_NOTIFIER=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_MEMORY_FAILURE=y
> CONFIG_HWPOISON_INJECT=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ARCH_WANTS_THP_SWAP=y
> CONFIG_MM_ID=y
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> # CONFIG_TRANSPARENT_HUGEPAGE_NEVER is not set
> CONFIG_THP_SWAP=y
> CONFIG_READ_ONLY_THP_FOR_FS=y
> # CONFIG_NO_PAGE_MAPCOUNT is not set
> CONFIG_PAGE_MAPCOUNT=y
> CONFIG_PGTABLE_HAS_HUGE_LEAVES=y
> CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP=y
> CONFIG_ARCH_SUPPORTS_PMD_PFNMAP=y
> CONFIG_ARCH_SUPPORTS_PUD_PFNMAP=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_CMA=y
> # CONFIG_CMA_DEBUGFS is not set
> # CONFIG_CMA_SYSFS is not set
> CONFIG_CMA_AREAS=19
> CONFIG_MEM_SOFT_DIRTY=y
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
> CONFIG_PAGE_IDLE_FLAG=y
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
> CONFIG_ARCH_HAS_PTE_DEVMAP=y
> CONFIG_ZONE_DMA=y
> CONFIG_ZONE_DMA32=y
> CONFIG_ZONE_DEVICE=y
> CONFIG_GET_FREE_REGION=y
> CONFIG_DEVICE_PRIVATE=y
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> CONFIG_ARCH_HAS_PKEYS=y
> CONFIG_ARCH_USES_PG_ARCH_2=y
> CONFIG_VM_EVENT_COUNTERS=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> # CONFIG_DMAPOOL_TEST is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_MEMFD_CREATE=y
> CONFIG_SECRETMEM=y
> # CONFIG_ANON_VMA_NAME is not set
> CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
> CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
> CONFIG_USERFAULTFD=y
> CONFIG_PTE_MARKER_UFFD_WP=y
> CONFIG_LRU_GEN=y
> # CONFIG_LRU_GEN_ENABLED is not set
> # CONFIG_LRU_GEN_STATS is not set
> CONFIG_LRU_GEN_WALKS_MMU=y
> CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
> CONFIG_PER_VMA_LOCK=y
> CONFIG_LOCK_MM_AND_FIND_VMA=y
> CONFIG_IOMMU_MM_DATA=y
> CONFIG_EXECMEM=y
> CONFIG_NUMA_MEMBLKS=y
> CONFIG_NUMA_EMU=y
> CONFIG_ARCH_SUPPORTS_PT_RECLAIM=y
> CONFIG_PT_RECLAIM=y
> 
> #
> # Data Access Monitoring
> #
> CONFIG_DAMON=y
> CONFIG_DAMON_VADDR=y
> CONFIG_DAMON_PADDR=y
> CONFIG_DAMON_SYSFS=y
> CONFIG_DAMON_RECLAIM=y
> CONFIG_DAMON_LRU_SORT=y
> # end of Data Access Monitoring
> # end of Memory Management options
> 
> CONFIG_NET=y
> CONFIG_NET_INGRESS=y
> CONFIG_NET_EGRESS=y
> CONFIG_NET_XGRESS=y
> CONFIG_NET_REDIRECT=y
> CONFIG_SKB_DECRYPTED=y
> CONFIG_SKB_EXTENSIONS=y
> CONFIG_NET_DEVMEM=y
> CONFIG_NET_SHAPER=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_DIAG=y
> CONFIG_UNIX=y
> CONFIG_AF_UNIX_OOB=y
> CONFIG_UNIX_DIAG=y
> CONFIG_TLS=y
> CONFIG_TLS_DEVICE=y
> # CONFIG_TLS_TOE is not set
> CONFIG_XFRM=y
> CONFIG_XFRM_OFFLOAD=y
> CONFIG_XFRM_ALGO=y
> CONFIG_XFRM_USER=y
> # CONFIG_XFRM_USER_COMPAT is not set
> CONFIG_XFRM_INTERFACE=y
> CONFIG_XFRM_SUB_POLICY=y
> CONFIG_XFRM_MIGRATE=y
> CONFIG_XFRM_STATISTICS=y
> CONFIG_XFRM_AH=y
> CONFIG_XFRM_ESP=y
> CONFIG_XFRM_IPCOMP=y
> CONFIG_NET_KEY=y
> CONFIG_NET_KEY_MIGRATE=y
> # CONFIG_XFRM_IPTFS is not set
> CONFIG_XDP_SOCKETS=y
> CONFIG_XDP_SOCKETS_DIAG=y
> CONFIG_NET_HANDSHAKE=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_FIB_TRIE_STATS=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_VERBOSE=y
> CONFIG_IP_ROUTE_CLASSID=y
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=y
> CONFIG_NET_IPGRE_DEMUX=y
> CONFIG_NET_IP_TUNNEL=y
> CONFIG_NET_IPGRE=y
> CONFIG_NET_IPGRE_BROADCAST=y
> CONFIG_IP_MROUTE_COMMON=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> CONFIG_SYN_COOKIES=y
> CONFIG_NET_IPVTI=y
> CONFIG_NET_UDP_TUNNEL=y
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> CONFIG_INET_AH=y
> CONFIG_INET_ESP=y
> CONFIG_INET_ESP_OFFLOAD=y
> # CONFIG_INET_ESPINTCP is not set
> CONFIG_INET_IPCOMP=y
> CONFIG_INET_TABLE_PERTURB_ORDER=16
> CONFIG_INET_XFRM_TUNNEL=y
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> CONFIG_INET_UDP_DIAG=y
> CONFIG_INET_RAW_DIAG=y
> # CONFIG_INET_DIAG_DESTROY is not set
> CONFIG_TCP_CONG_ADVANCED=y
> CONFIG_TCP_CONG_BIC=y
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_TCP_CONG_WESTWOOD=y
> CONFIG_TCP_CONG_HTCP=y
> CONFIG_TCP_CONG_HSTCP=y
> CONFIG_TCP_CONG_HYBLA=y
> CONFIG_TCP_CONG_VEGAS=y
> CONFIG_TCP_CONG_NV=y
> CONFIG_TCP_CONG_SCALABLE=y
> CONFIG_TCP_CONG_LP=y
> CONFIG_TCP_CONG_VENO=y
> CONFIG_TCP_CONG_YEAH=y
> CONFIG_TCP_CONG_ILLINOIS=y
> CONFIG_TCP_CONG_DCTCP=y
> # CONFIG_TCP_CONG_CDG is not set
> CONFIG_TCP_CONG_BBR=y
> # CONFIG_DEFAULT_BIC is not set
> CONFIG_DEFAULT_CUBIC=y
> # CONFIG_DEFAULT_HTCP is not set
> # CONFIG_DEFAULT_HYBLA is not set
> # CONFIG_DEFAULT_VEGAS is not set
> # CONFIG_DEFAULT_VENO is not set
> # CONFIG_DEFAULT_WESTWOOD is not set
> # CONFIG_DEFAULT_DCTCP is not set
> # CONFIG_DEFAULT_BBR is not set
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG="cubic"
> CONFIG_TCP_SIGPOOL=y
> # CONFIG_TCP_AO is not set
> CONFIG_TCP_MD5SIG=y
> CONFIG_IPV6=y
> CONFIG_IPV6_ROUTER_PREF=y
> CONFIG_IPV6_ROUTE_INFO=y
> CONFIG_IPV6_OPTIMISTIC_DAD=y
> CONFIG_INET6_AH=y
> CONFIG_INET6_ESP=y
> CONFIG_INET6_ESP_OFFLOAD=y
> # CONFIG_INET6_ESPINTCP is not set
> CONFIG_INET6_IPCOMP=y
> CONFIG_IPV6_MIP6=y
> # CONFIG_IPV6_ILA is not set
> CONFIG_INET6_XFRM_TUNNEL=y
> CONFIG_INET6_TUNNEL=y
> CONFIG_IPV6_VTI=y
> CONFIG_IPV6_SIT=y
> CONFIG_IPV6_SIT_6RD=y
> CONFIG_IPV6_NDISC_NODETYPE=y
> CONFIG_IPV6_TUNNEL=y
> CONFIG_IPV6_GRE=y
> CONFIG_IPV6_MULTIPLE_TABLES=y
> # CONFIG_IPV6_SUBTREES is not set
> CONFIG_IPV6_MROUTE=y
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IPV6_PIMSM_V2=y
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> CONFIG_NETLABEL=y
> CONFIG_MPTCP=y
> CONFIG_INET_MPTCP_DIAG=y
> CONFIG_MPTCP_IPV6=y
> CONFIG_NETWORK_SECMARK=y
> CONFIG_NET_PTP_CLASSIFY=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_ADVANCED=y
> CONFIG_BRIDGE_NETFILTER=y
> 
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=y
> CONFIG_NETFILTER_EGRESS=y
> CONFIG_NETFILTER_SKIP_EGRESS=y
> CONFIG_NETFILTER_NETLINK=y
> CONFIG_NETFILTER_FAMILY_BRIDGE=y
> CONFIG_NETFILTER_FAMILY_ARP=y
> CONFIG_NETFILTER_BPF_LINK=y
> # CONFIG_NETFILTER_NETLINK_HOOK is not set
> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> CONFIG_NETFILTER_NETLINK_QUEUE=y
> CONFIG_NETFILTER_NETLINK_LOG=y
> CONFIG_NETFILTER_NETLINK_OSF=y
> CONFIG_NF_CONNTRACK=y
> CONFIG_NF_LOG_SYSLOG=y
> CONFIG_NETFILTER_CONNCOUNT=y
> CONFIG_NF_CONNTRACK_MARK=y
> CONFIG_NF_CONNTRACK_SECMARK=y
> CONFIG_NF_CONNTRACK_ZONES=y
> CONFIG_NF_CONNTRACK_PROCFS=y
> CONFIG_NF_CONNTRACK_EVENTS=y
> CONFIG_NF_CONNTRACK_TIMEOUT=y
> CONFIG_NF_CONNTRACK_TIMESTAMP=y
> CONFIG_NF_CONNTRACK_LABELS=y
> CONFIG_NF_CONNTRACK_OVS=y
> CONFIG_NF_CT_PROTO_DCCP=y
> CONFIG_NF_CT_PROTO_GRE=y
> CONFIG_NF_CT_PROTO_SCTP=y
> CONFIG_NF_CT_PROTO_UDPLITE=y
> CONFIG_NF_CONNTRACK_AMANDA=y
> CONFIG_NF_CONNTRACK_FTP=y
> CONFIG_NF_CONNTRACK_H323=y
> CONFIG_NF_CONNTRACK_IRC=y
> CONFIG_NF_CONNTRACK_BROADCAST=y
> CONFIG_NF_CONNTRACK_NETBIOS_NS=y
> CONFIG_NF_CONNTRACK_SNMP=y
> CONFIG_NF_CONNTRACK_PPTP=y
> CONFIG_NF_CONNTRACK_SANE=y
> CONFIG_NF_CONNTRACK_SIP=y
> CONFIG_NF_CONNTRACK_TFTP=y
> CONFIG_NF_CT_NETLINK=y
> CONFIG_NF_CT_NETLINK_TIMEOUT=y
> CONFIG_NF_CT_NETLINK_HELPER=y
> CONFIG_NETFILTER_NETLINK_GLUE_CT=y
> CONFIG_NF_NAT=y
> CONFIG_NF_NAT_AMANDA=y
> CONFIG_NF_NAT_FTP=y
> CONFIG_NF_NAT_IRC=y
> CONFIG_NF_NAT_SIP=y
> CONFIG_NF_NAT_TFTP=y
> CONFIG_NF_NAT_REDIRECT=y
> CONFIG_NF_NAT_MASQUERADE=y
> CONFIG_NF_NAT_OVS=y
> CONFIG_NETFILTER_SYNPROXY=y
> CONFIG_NF_TABLES=y
> CONFIG_NF_TABLES_INET=y
> CONFIG_NF_TABLES_NETDEV=y
> CONFIG_NFT_NUMGEN=y
> CONFIG_NFT_CT=y
> CONFIG_NFT_CONNLIMIT=y
> CONFIG_NFT_LOG=y
> CONFIG_NFT_LIMIT=y
> CONFIG_NFT_MASQ=y
> CONFIG_NFT_REDIR=y
> CONFIG_NFT_NAT=y
> # CONFIG_NFT_TUNNEL is not set
> CONFIG_NFT_QUEUE=y
> CONFIG_NFT_QUOTA=y
> CONFIG_NFT_REJECT=y
> CONFIG_NFT_REJECT_INET=y
> CONFIG_NFT_COMPAT=y
> CONFIG_NFT_HASH=y
> CONFIG_NFT_FIB=y
> CONFIG_NFT_FIB_INET=y
> # CONFIG_NFT_XFRM is not set
> # CONFIG_NFT_SOCKET is not set
> # CONFIG_NFT_OSF is not set
> # CONFIG_NFT_TPROXY is not set
> # CONFIG_NFT_SYNPROXY is not set
> CONFIG_NF_DUP_NETDEV=y
> CONFIG_NFT_DUP_NETDEV=y
> CONFIG_NFT_FWD_NETDEV=y
> CONFIG_NFT_FIB_NETDEV=y
> # CONFIG_NFT_REJECT_NETDEV is not set
> # CONFIG_NF_FLOW_TABLE is not set
> CONFIG_NETFILTER_XTABLES=y
> CONFIG_NETFILTER_XTABLES_COMPAT=y
> 
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=y
> CONFIG_NETFILTER_XT_CONNMARK=y
> CONFIG_NETFILTER_XT_SET=y
> 
> #
> # Xtables targets
> #
> CONFIG_NETFILTER_XT_TARGET_AUDIT=y
> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=y
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
> CONFIG_NETFILTER_XT_TARGET_CT=y
> CONFIG_NETFILTER_XT_TARGET_DSCP=y
> CONFIG_NETFILTER_XT_TARGET_HL=y
> CONFIG_NETFILTER_XT_TARGET_HMARK=y
> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
> # CONFIG_NETFILTER_XT_TARGET_LED is not set
> CONFIG_NETFILTER_XT_TARGET_LOG=y
> CONFIG_NETFILTER_XT_TARGET_MARK=y
> CONFIG_NETFILTER_XT_NAT=y
> CONFIG_NETFILTER_XT_TARGET_NETMAP=y
> CONFIG_NETFILTER_XT_TARGET_NFLOG=y
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
> CONFIG_NETFILTER_XT_TARGET_NOTRACK=y
> CONFIG_NETFILTER_XT_TARGET_RATEEST=y
> CONFIG_NETFILTER_XT_TARGET_REDIRECT=y
> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=y
> CONFIG_NETFILTER_XT_TARGET_TEE=y
> CONFIG_NETFILTER_XT_TARGET_TPROXY=y
> CONFIG_NETFILTER_XT_TARGET_TRACE=y
> CONFIG_NETFILTER_XT_TARGET_SECMARK=y
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=y
> 
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
> CONFIG_NETFILTER_XT_MATCH_BPF=y
> CONFIG_NETFILTER_XT_MATCH_CGROUP=y
> CONFIG_NETFILTER_XT_MATCH_CLUSTER=y
> CONFIG_NETFILTER_XT_MATCH_COMMENT=y
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=y
> CONFIG_NETFILTER_XT_MATCH_CONNLABEL=y
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=y
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
> CONFIG_NETFILTER_XT_MATCH_CPU=y
> CONFIG_NETFILTER_XT_MATCH_DCCP=y
> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=y
> CONFIG_NETFILTER_XT_MATCH_DSCP=y
> CONFIG_NETFILTER_XT_MATCH_ECN=y
> CONFIG_NETFILTER_XT_MATCH_ESP=y
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=y
> CONFIG_NETFILTER_XT_MATCH_HELPER=y
> CONFIG_NETFILTER_XT_MATCH_HL=y
> # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=y
> CONFIG_NETFILTER_XT_MATCH_IPVS=y
> # CONFIG_NETFILTER_XT_MATCH_L2TP is not set
> CONFIG_NETFILTER_XT_MATCH_LENGTH=y
> CONFIG_NETFILTER_XT_MATCH_LIMIT=y
> CONFIG_NETFILTER_XT_MATCH_MAC=y
> CONFIG_NETFILTER_XT_MATCH_MARK=y
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
> # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
> CONFIG_NETFILTER_XT_MATCH_OSF=y
> CONFIG_NETFILTER_XT_MATCH_OWNER=y
> CONFIG_NETFILTER_XT_MATCH_POLICY=y
> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=y
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
> CONFIG_NETFILTER_XT_MATCH_QUOTA=y
> CONFIG_NETFILTER_XT_MATCH_RATEEST=y
> CONFIG_NETFILTER_XT_MATCH_REALM=y
> CONFIG_NETFILTER_XT_MATCH_RECENT=y
> CONFIG_NETFILTER_XT_MATCH_SCTP=y
> CONFIG_NETFILTER_XT_MATCH_SOCKET=y
> CONFIG_NETFILTER_XT_MATCH_STATE=y
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
> CONFIG_NETFILTER_XT_MATCH_STRING=y
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=y
> # CONFIG_NETFILTER_XT_MATCH_TIME is not set
> # CONFIG_NETFILTER_XT_MATCH_U32 is not set
> # end of Core Netfilter Configuration
> 
> CONFIG_IP_SET=y
> CONFIG_IP_SET_MAX=256
> CONFIG_IP_SET_BITMAP_IP=y
> CONFIG_IP_SET_BITMAP_IPMAC=y
> CONFIG_IP_SET_BITMAP_PORT=y
> CONFIG_IP_SET_HASH_IP=y
> CONFIG_IP_SET_HASH_IPMARK=y
> CONFIG_IP_SET_HASH_IPPORT=y
> CONFIG_IP_SET_HASH_IPPORTIP=y
> CONFIG_IP_SET_HASH_IPPORTNET=y
> CONFIG_IP_SET_HASH_IPMAC=y
> CONFIG_IP_SET_HASH_MAC=y
> CONFIG_IP_SET_HASH_NETPORTNET=y
> CONFIG_IP_SET_HASH_NET=y
> CONFIG_IP_SET_HASH_NETNET=y
> CONFIG_IP_SET_HASH_NETPORT=y
> CONFIG_IP_SET_HASH_NETIFACE=y
> CONFIG_IP_SET_LIST_SET=y
> CONFIG_IP_VS=y
> CONFIG_IP_VS_IPV6=y
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=12
> 
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=y
> CONFIG_IP_VS_PROTO_UDP=y
> CONFIG_IP_VS_PROTO_AH_ESP=y
> CONFIG_IP_VS_PROTO_ESP=y
> CONFIG_IP_VS_PROTO_AH=y
> CONFIG_IP_VS_PROTO_SCTP=y
> 
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=y
> CONFIG_IP_VS_WRR=y
> CONFIG_IP_VS_LC=y
> CONFIG_IP_VS_WLC=y
> CONFIG_IP_VS_FO=y
> CONFIG_IP_VS_OVF=y
> CONFIG_IP_VS_LBLC=y
> CONFIG_IP_VS_LBLCR=y
> CONFIG_IP_VS_DH=y
> CONFIG_IP_VS_SH=y
> # CONFIG_IP_VS_MH is not set
> CONFIG_IP_VS_SED=y
> CONFIG_IP_VS_NQ=y
> # CONFIG_IP_VS_TWOS is not set
> 
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=8
> 
> #
> # IPVS MH scheduler
> #
> CONFIG_IP_VS_MH_TAB_INDEX=12
> 
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_FTP=y
> CONFIG_IP_VS_NFCT=y
> CONFIG_IP_VS_PE_SIP=y
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=y
> CONFIG_IP_NF_IPTABLES_LEGACY=y
> CONFIG_NF_SOCKET_IPV4=y
> CONFIG_NF_TPROXY_IPV4=y
> CONFIG_NF_TABLES_IPV4=y
> CONFIG_NFT_REJECT_IPV4=y
> CONFIG_NFT_DUP_IPV4=y
> CONFIG_NFT_FIB_IPV4=y
> CONFIG_NF_TABLES_ARP=y
> CONFIG_NF_DUP_IPV4=y
> CONFIG_NF_LOG_ARP=y
> CONFIG_NF_LOG_IPV4=y
> CONFIG_NF_REJECT_IPV4=y
> CONFIG_NF_NAT_SNMP_BASIC=y
> CONFIG_NF_NAT_PPTP=y
> CONFIG_NF_NAT_H323=y
> CONFIG_IP_NF_IPTABLES=y
> CONFIG_IP_NF_MATCH_AH=y
> CONFIG_IP_NF_MATCH_ECN=y
> CONFIG_IP_NF_MATCH_RPFILTER=y
> CONFIG_IP_NF_MATCH_TTL=y
> CONFIG_IP_NF_FILTER=y
> CONFIG_IP_NF_TARGET_REJECT=y
> CONFIG_IP_NF_TARGET_SYNPROXY=y
> CONFIG_IP_NF_NAT=y
> CONFIG_IP_NF_TARGET_MASQUERADE=y
> CONFIG_IP_NF_TARGET_NETMAP=y
> CONFIG_IP_NF_TARGET_REDIRECT=y
> CONFIG_IP_NF_MANGLE=y
> CONFIG_IP_NF_TARGET_ECN=y
> CONFIG_IP_NF_TARGET_TTL=y
> CONFIG_IP_NF_RAW=y
> CONFIG_IP_NF_SECURITY=y
> CONFIG_IP_NF_ARPTABLES=y
> CONFIG_NFT_COMPAT_ARP=y
> CONFIG_IP_NF_ARPFILTER=y
> CONFIG_IP_NF_ARP_MANGLE=y
> # end of IP: Netfilter Configuration
> 
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_IP6_NF_IPTABLES_LEGACY=y
> CONFIG_NF_SOCKET_IPV6=y
> CONFIG_NF_TPROXY_IPV6=y
> CONFIG_NF_TABLES_IPV6=y
> CONFIG_NFT_REJECT_IPV6=y
> CONFIG_NFT_DUP_IPV6=y
> CONFIG_NFT_FIB_IPV6=y
> CONFIG_NF_DUP_IPV6=y
> CONFIG_NF_REJECT_IPV6=y
> CONFIG_NF_LOG_IPV6=y
> CONFIG_IP6_NF_IPTABLES=y
> CONFIG_IP6_NF_MATCH_AH=y
> CONFIG_IP6_NF_MATCH_EUI64=y
> CONFIG_IP6_NF_MATCH_FRAG=y
> CONFIG_IP6_NF_MATCH_OPTS=y
> CONFIG_IP6_NF_MATCH_HL=y
> CONFIG_IP6_NF_MATCH_IPV6HEADER=y
> CONFIG_IP6_NF_MATCH_MH=y
> CONFIG_IP6_NF_MATCH_RPFILTER=y
> CONFIG_IP6_NF_MATCH_RT=y
> # CONFIG_IP6_NF_MATCH_SRH is not set
> # CONFIG_IP6_NF_TARGET_HL is not set
> CONFIG_IP6_NF_FILTER=y
> CONFIG_IP6_NF_TARGET_REJECT=y
> CONFIG_IP6_NF_TARGET_SYNPROXY=y
> CONFIG_IP6_NF_MANGLE=y
> CONFIG_IP6_NF_RAW=y
> CONFIG_IP6_NF_SECURITY=y
> CONFIG_IP6_NF_NAT=y
> CONFIG_IP6_NF_TARGET_MASQUERADE=y
> CONFIG_IP6_NF_TARGET_NPT=y
> # end of IPv6: Netfilter Configuration
> 
> CONFIG_NF_DEFRAG_IPV6=y
> CONFIG_NF_TABLES_BRIDGE=y
> # CONFIG_NFT_BRIDGE_META is not set
> CONFIG_NFT_BRIDGE_REJECT=y
> # CONFIG_NF_CONNTRACK_BRIDGE is not set
> CONFIG_BRIDGE_NF_EBTABLES_LEGACY=y
> CONFIG_BRIDGE_NF_EBTABLES=y
> CONFIG_BRIDGE_EBT_BROUTE=y
> CONFIG_BRIDGE_EBT_T_FILTER=y
> CONFIG_BRIDGE_EBT_T_NAT=y
> CONFIG_BRIDGE_EBT_802_3=y
> CONFIG_BRIDGE_EBT_AMONG=y
> CONFIG_BRIDGE_EBT_ARP=y
> CONFIG_BRIDGE_EBT_IP=y
> CONFIG_BRIDGE_EBT_IP6=y
> CONFIG_BRIDGE_EBT_LIMIT=y
> CONFIG_BRIDGE_EBT_MARK=y
> CONFIG_BRIDGE_EBT_PKTTYPE=y
> CONFIG_BRIDGE_EBT_STP=y
> CONFIG_BRIDGE_EBT_VLAN=y
> CONFIG_BRIDGE_EBT_ARPREPLY=y
> CONFIG_BRIDGE_EBT_DNAT=y
> CONFIG_BRIDGE_EBT_MARK_T=y
> CONFIG_BRIDGE_EBT_REDIRECT=y
> CONFIG_BRIDGE_EBT_SNAT=y
> CONFIG_BRIDGE_EBT_LOG=y
> CONFIG_BRIDGE_EBT_NFLOG=y
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> CONFIG_ATM=y
> CONFIG_ATM_CLIP=y
> # CONFIG_ATM_CLIP_NO_ICMP is not set
> CONFIG_ATM_LANE=y
> # CONFIG_ATM_MPOA is not set
> CONFIG_ATM_BR2684=y
> # CONFIG_ATM_BR2684_IPFILTER is not set
> CONFIG_L2TP=y
> CONFIG_L2TP_DEBUGFS=y
> CONFIG_L2TP_V3=y
> CONFIG_L2TP_IP=y
> CONFIG_L2TP_ETH=y
> CONFIG_STP=y
> CONFIG_GARP=y
> CONFIG_MRP=y
> CONFIG_BRIDGE=y
> CONFIG_BRIDGE_IGMP_SNOOPING=y
> CONFIG_BRIDGE_VLAN_FILTERING=y
> # CONFIG_BRIDGE_MRP is not set
> # CONFIG_BRIDGE_CFM is not set
> # CONFIG_NET_DSA is not set
> CONFIG_VLAN_8021Q=y
> CONFIG_VLAN_8021Q_GVRP=y
> CONFIG_VLAN_8021Q_MVRP=y
> CONFIG_LLC=y
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> CONFIG_6LOWPAN=y
> # CONFIG_6LOWPAN_DEBUGFS is not set
> # CONFIG_6LOWPAN_NHC is not set
> # CONFIG_IEEE802154 is not set
> CONFIG_NET_SCHED=y
> 
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_HTB=y
> CONFIG_NET_SCH_HFSC=y
> CONFIG_NET_SCH_PRIO=y
> CONFIG_NET_SCH_MULTIQ=y
> CONFIG_NET_SCH_RED=y
> CONFIG_NET_SCH_SFB=y
> CONFIG_NET_SCH_SFQ=y
> CONFIG_NET_SCH_TEQL=y
> CONFIG_NET_SCH_TBF=y
> # CONFIG_NET_SCH_CBS is not set
> # CONFIG_NET_SCH_ETF is not set
> CONFIG_NET_SCH_MQPRIO_LIB=y
> # CONFIG_NET_SCH_TAPRIO is not set
> CONFIG_NET_SCH_GRED=y
> CONFIG_NET_SCH_NETEM=y
> CONFIG_NET_SCH_DRR=y
> CONFIG_NET_SCH_MQPRIO=y
> # CONFIG_NET_SCH_SKBPRIO is not set
> CONFIG_NET_SCH_CHOKE=y
> CONFIG_NET_SCH_QFQ=y
> CONFIG_NET_SCH_CODEL=y
> CONFIG_NET_SCH_FQ_CODEL=y
> # CONFIG_NET_SCH_CAKE is not set
> CONFIG_NET_SCH_FQ=y
> CONFIG_NET_SCH_HHF=y
> CONFIG_NET_SCH_PIE=y
> # CONFIG_NET_SCH_FQ_PIE is not set
> CONFIG_NET_SCH_INGRESS=y
> CONFIG_NET_SCH_PLUG=y
> # CONFIG_NET_SCH_ETS is not set
> CONFIG_NET_SCH_DEFAULT=y
> # CONFIG_DEFAULT_FQ is not set
> # CONFIG_DEFAULT_CODEL is not set
> CONFIG_DEFAULT_FQ_CODEL=y
> # CONFIG_DEFAULT_SFQ is not set
> # CONFIG_DEFAULT_PFIFO_FAST is not set
> CONFIG_DEFAULT_NET_SCH="fq_codel"
> 
> #
> # Classification
> #
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_BASIC=y
> CONFIG_NET_CLS_ROUTE4=y
> CONFIG_NET_CLS_FW=y
> CONFIG_NET_CLS_U32=y
> CONFIG_CLS_U32_PERF=y
> CONFIG_CLS_U32_MARK=y
> CONFIG_NET_CLS_FLOW=y
> CONFIG_NET_CLS_CGROUP=y
> CONFIG_NET_CLS_BPF=y
> CONFIG_NET_CLS_FLOWER=y
> CONFIG_NET_CLS_MATCHALL=y
> CONFIG_NET_EMATCH=y
> CONFIG_NET_EMATCH_STACK=32
> CONFIG_NET_EMATCH_CMP=y
> CONFIG_NET_EMATCH_NBYTE=y
> CONFIG_NET_EMATCH_U32=y
> CONFIG_NET_EMATCH_META=y
> CONFIG_NET_EMATCH_TEXT=y
> # CONFIG_NET_EMATCH_CANID is not set
> CONFIG_NET_EMATCH_IPSET=y
> # CONFIG_NET_EMATCH_IPT is not set
> CONFIG_NET_CLS_ACT=y
> CONFIG_NET_ACT_POLICE=y
> CONFIG_NET_ACT_GACT=y
> CONFIG_GACT_PROB=y
> CONFIG_NET_ACT_MIRRED=y
> CONFIG_NET_ACT_SAMPLE=y
> CONFIG_NET_ACT_NAT=y
> CONFIG_NET_ACT_PEDIT=y
> CONFIG_NET_ACT_SIMP=y
> CONFIG_NET_ACT_SKBEDIT=y
> CONFIG_NET_ACT_CSUM=y
> # CONFIG_NET_ACT_MPLS is not set
> CONFIG_NET_ACT_VLAN=y
> CONFIG_NET_ACT_BPF=y
> # CONFIG_NET_ACT_CONNMARK is not set
> # CONFIG_NET_ACT_CTINFO is not set
> CONFIG_NET_ACT_SKBMOD=y
> # CONFIG_NET_ACT_IFE is not set
> CONFIG_NET_ACT_TUNNEL_KEY=y
> # CONFIG_NET_ACT_GATE is not set
> # CONFIG_NET_TC_SKB_EXT is not set
> CONFIG_NET_SCH_FIFO=y
> CONFIG_DCB=y
> CONFIG_DNS_RESOLVER=y
> # CONFIG_BATMAN_ADV is not set
> CONFIG_OPENVSWITCH=y
> CONFIG_OPENVSWITCH_GRE=y
> CONFIG_OPENVSWITCH_VXLAN=y
> CONFIG_OPENVSWITCH_GENEVE=y
> # CONFIG_VSOCKETS is not set
> CONFIG_NETLINK_DIAG=y
> CONFIG_MPLS=y
> CONFIG_NET_MPLS_GSO=y
> CONFIG_MPLS_ROUTING=y
> CONFIG_MPLS_IPTUNNEL=y
> CONFIG_NET_NSH=y
> # CONFIG_HSR is not set
> CONFIG_NET_SWITCHDEV=y
> CONFIG_NET_L3_MASTER_DEV=y
> # CONFIG_QRTR is not set
> # CONFIG_NET_NCSI is not set
> # CONFIG_PCPU_DEV_REFCNT is not set
> CONFIG_MAX_SKB_FRAGS=17
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_SOCK_RX_QUEUE_MAPPING=y
> CONFIG_XPS=y
> CONFIG_CGROUP_NET_PRIO=y
> CONFIG_CGROUP_NET_CLASSID=y
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_BPF_STREAM_PARSER=y
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=y
> CONFIG_NET_DROP_MONITOR=y
> # end of Network testing
> # end of Networking options
> 
> # CONFIG_HAMRADIO is not set
> CONFIG_CAN=y
> CONFIG_CAN_RAW=y
> CONFIG_CAN_BCM=y
> CONFIG_CAN_GW=y
> # CONFIG_CAN_J1939 is not set
> # CONFIG_CAN_ISOTP is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_STREAM_PARSER=y
> # CONFIG_MCTP is not set
> CONFIG_FIB_RULES=y
> # CONFIG_WIRELESS is not set
> CONFIG_RFKILL=y
> CONFIG_RFKILL_LEDS=y
> CONFIG_RFKILL_INPUT=y
> CONFIG_RFKILL_GPIO=y
> # CONFIG_NET_9P is not set
> # CONFIG_CAIF is not set
> CONFIG_CEPH_LIB=y
> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
> # CONFIG_NFC is not set
> CONFIG_PSAMPLE=y
> # CONFIG_NET_IFE is not set
> CONFIG_LWTUNNEL=y
> CONFIG_LWTUNNEL_BPF=y
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> CONFIG_SOCK_VALIDATE_XMIT=y
> CONFIG_NET_SELFTESTS=y
> CONFIG_NET_SOCK_MSG=y
> CONFIG_NET_DEVLINK=y
> CONFIG_PAGE_POOL=y
> CONFIG_PAGE_POOL_STATS=y
> CONFIG_FAILOVER=y
> CONFIG_ETHTOOL_NETLINK=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_PCI=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_HOTPLUG_PCI_PCIE=y
> CONFIG_PCIEAER=y
> CONFIG_PCIEAER_INJECT=y
> CONFIG_PCIEAER_CXL=y
> CONFIG_PCIE_ECRC=y
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=y
> CONFIG_PCIE_DPC=y
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCIE_EDR is not set
> CONFIG_PCI_MSI=y
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> CONFIG_PCI_STUB=y
> CONFIG_PCI_PF_STUB=y
> CONFIG_PCI_ATS=y
> CONFIG_PCI_DOE=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> CONFIG_PCI_IOV=y
> # CONFIG_PCI_NPEM is not set
> CONFIG_PCI_PRI=y
> CONFIG_PCI_PASID=y
> # CONFIG_PCIE_TPH is not set
> # CONFIG_PCI_P2PDMA is not set
> CONFIG_PCI_LABEL=y
> CONFIG_PCI_HYPERV=y
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=64
> CONFIG_HOTPLUG_PCI=y
> CONFIG_HOTPLUG_PCI_ACPI=y
> CONFIG_HOTPLUG_PCI_ACPI_IBM=y
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> # CONFIG_HOTPLUG_PCI_OCTEONEP is not set
> CONFIG_HOTPLUG_PCI_SHPC=y
> 
> #
> # PCI controller drivers
> #
> CONFIG_VMD=y
> CONFIG_PCI_HYPERV_INTERFACE=y
> 
> #
> # Cadence-based PCIe controllers
> #
> # end of Cadence-based PCIe controllers
> 
> #
> # DesignWare-based PCIe controllers
> #
> # CONFIG_PCI_MESON is not set
> # CONFIG_PCIE_DW_PLAT_HOST is not set
> # end of DesignWare-based PCIe controllers
> 
> #
> # Mobiveil-based PCIe controllers
> #
> # end of Mobiveil-based PCIe controllers
> 
> #
> # PLDA-based PCIe controllers
> #
> # end of PLDA-based PCIe controllers
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
> 
> # CONFIG_PCI_PWRCTL_SLOT is not set
> CONFIG_CXL_BUS=y
> CONFIG_CXL_PCI=y
> # CONFIG_CXL_MEM_RAW_COMMANDS is not set
> CONFIG_CXL_ACPI=y
> CONFIG_CXL_PMEM=y
> CONFIG_CXL_MEM=y
> # CONFIG_CXL_FEATURES is not set
> CONFIG_CXL_PORT=y
> CONFIG_CXL_SUSPEND=y
> CONFIG_CXL_REGION=y
> # CONFIG_CXL_REGION_INVALIDATION_TEST is not set
> CONFIG_CXL_MCE=y
> CONFIG_PCCARD=y
> # CONFIG_PCMCIA is not set
> CONFIG_CARDBUS=y
> 
> #
> # PC-card bridges
> #
> CONFIG_YENTA=y
> CONFIG_YENTA_O2=y
> CONFIG_YENTA_RICOH=y
> CONFIG_YENTA_TI=y
> CONFIG_YENTA_ENE_TUNE=y
> CONFIG_YENTA_TOSHIBA=y
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=y
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> # CONFIG_DEVTMPFS_SAFE is not set
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_DEBUG=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_FW_LOADER_SYSFS=y
> CONFIG_EXTRA_FIRMWARE=""
> # CONFIG_FW_LOADER_USER_HELPER is not set
> # CONFIG_FW_LOADER_COMPRESS is not set
> CONFIG_FW_CACHE=y
> CONFIG_FW_UPLOAD=y
> # end of Firmware loader
> 
> CONFIG_ALLOW_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_HMEM_REPORTING=y
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_SYS_HYPERVISOR=y
> CONFIG_GENERIC_CPU_DEVICES=y
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SPI=y
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> # CONFIG_MHI_BUS is not set
> # CONFIG_MHI_BUS_EP is not set
> # end of Bus devices
> 
> #
> # Cache Drivers
> #
> # end of Cache Drivers
> 
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
> 
> CONFIG_EDD=y
> # CONFIG_EDD_OFF is not set
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_DMIID=y
> CONFIG_DMI_SYSFS=y
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> CONFIG_ISCSI_IBFT_FIND=y
> CONFIG_ISCSI_IBFT=y
> CONFIG_FW_CFG_SYSFS=y
> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> CONFIG_SYSFB=y
> # CONFIG_SYSFB_SIMPLEFB is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
> 
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_ESRT=y
> CONFIG_EFI_VARS_PSTORE=y
> CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
> CONFIG_EFI_SOFT_RESERVE=y
> CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
> CONFIG_EFI_RUNTIME_WRAPPERS=y
> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> # CONFIG_EFI_CAPSULE_LOADER is not set
> # CONFIG_EFI_TEST is not set
> CONFIG_EFI_DEV_PATH_PARSER=y
> CONFIG_APPLE_PROPERTIES=y
> # CONFIG_RESET_ATTACK_MITIGATION is not set
> # CONFIG_EFI_RCI2_TABLE is not set
> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> CONFIG_EFI_EARLYCON=y
> CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
> # CONFIG_EFI_DISABLE_RUNTIME is not set
> # CONFIG_EFI_COCO_SECRET is not set
> CONFIG_UNACCEPTED_MEMORY=y
> # end of EFI (Extensible Firmware Interface) Support
> 
> CONFIG_UEFI_CPER=y
> CONFIG_UEFI_CPER_X86=y
> 
> #
> # Qualcomm firmware drivers
> #
> # end of Qualcomm firmware drivers
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> # CONFIG_FWCTL is not set
> # CONFIG_GNSS is not set
> CONFIG_MTD=y
> # CONFIG_MTD_TESTS is not set
> 
> #
> # Partition parsers
> #
> # CONFIG_MTD_CMDLINE_PARTS is not set
> # CONFIG_MTD_REDBOOT_PARTS is not set
> # end of Partition parsers
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=y
> CONFIG_MTD_BLOCK=y
> 
> #
> # Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
> #
> # CONFIG_FTL is not set
> # CONFIG_NFTL is not set
> # CONFIG_INFTL is not set
> # CONFIG_RFD_FTL is not set
> # CONFIG_SSFDC is not set
> # CONFIG_SM_FTL is not set
> # CONFIG_MTD_OOPS is not set
> # CONFIG_MTD_SWAP is not set
> # CONFIG_MTD_PARTITIONED_MASTER is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> # CONFIG_MTD_CFI is not set
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> # CONFIG_MTD_RAM is not set
> # CONFIG_MTD_ROM is not set
> # CONFIG_MTD_ABSENT is not set
> # end of RAM/ROM/Flash chip drivers
> 
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> # CONFIG_MTD_PLATRAM is not set
> # end of Mapping drivers for chip access
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_PMC551 is not set
> # CONFIG_MTD_DATAFLASH is not set
> # CONFIG_MTD_MCHP23K256 is not set
> # CONFIG_MTD_MCHP48L640 is not set
> # CONFIG_MTD_SST25L is not set
> # CONFIG_MTD_SLRAM is not set
> # CONFIG_MTD_PHRAM is not set
> # CONFIG_MTD_MTDRAM is not set
> CONFIG_MTD_BLOCK2MTD=y
> 
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOCG3 is not set
> # end of Self-contained MTD device drivers
> 
> #
> # NAND
> #
> # CONFIG_MTD_ONENAND is not set
> # CONFIG_MTD_RAW_NAND is not set
> # CONFIG_MTD_SPI_NAND is not set
> 
> #
> # ECC engine support
> #
> # CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
> # CONFIG_MTD_NAND_ECC_SW_BCH is not set
> # CONFIG_MTD_NAND_ECC_MXIC is not set
> # end of ECC engine support
> # end of NAND
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> # CONFIG_MTD_LPDDR is not set
> # end of LPDDR & LPDDR2 PCM memory drivers
> 
> CONFIG_MTD_SPI_NOR=y
> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
> # CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
> CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
> # CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
> CONFIG_MTD_UBI=y
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> # CONFIG_MTD_UBI_FASTMAP is not set
> CONFIG_MTD_UBI_GLUEBI=y
> # CONFIG_MTD_UBI_BLOCK is not set
> # CONFIG_MTD_UBI_FAULT_INJECTION is not set
> # CONFIG_MTD_UBI_NVMEM is not set
> # CONFIG_MTD_HYPERBUS is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> CONFIG_PARPORT=y
> CONFIG_PARPORT_PC=y
> CONFIG_PARPORT_SERIAL=y
> # CONFIG_PARPORT_PC_FIFO is not set
> # CONFIG_PARPORT_PC_SUPERIO is not set
> CONFIG_PARPORT_1284=y
> CONFIG_PARPORT_NOT_PC=y
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG_MESSAGES is not set
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> CONFIG_BLK_DEV_NULL_BLK=y
> # CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
> # CONFIG_BLK_DEV_FD is not set
> CONFIG_CDROM=y
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> CONFIG_ZRAM=y
> # CONFIG_ZRAM_BACKEND_LZ4 is not set
> # CONFIG_ZRAM_BACKEND_LZ4HC is not set
> # CONFIG_ZRAM_BACKEND_ZSTD is not set
> # CONFIG_ZRAM_BACKEND_DEFLATE is not set
> # CONFIG_ZRAM_BACKEND_842 is not set
> CONFIG_ZRAM_BACKEND_FORCE_LZO=y
> CONFIG_ZRAM_BACKEND_LZO=y
> CONFIG_ZRAM_DEF_COMP_LZORLE=y
> # CONFIG_ZRAM_DEF_COMP_LZO is not set
> CONFIG_ZRAM_DEF_COMP="lzo-rle"
> CONFIG_ZRAM_WRITEBACK=y
> # CONFIG_ZRAM_TRACK_ENTRY_ACTIME is not set
> # CONFIG_ZRAM_MEMORY_TRACKING is not set
> CONFIG_ZRAM_MULTI_COMP=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
> # CONFIG_BLK_DEV_DRBD is not set
> CONFIG_BLK_DEV_NBD=y
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=16384
> CONFIG_CDROM_PKTCDVD=y
> CONFIG_CDROM_PKTCDVD_BUFFERS=8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_XEN_BLKDEV_FRONTEND=y
> CONFIG_VIRTIO_BLK=y
> CONFIG_BLK_DEV_RBD=y
> # CONFIG_BLK_DEV_UBLK is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=y
> CONFIG_BLK_DEV_NVME=y
> CONFIG_NVME_MULTIPATH=y
> # CONFIG_NVME_VERBOSE_ERRORS is not set
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=y
> CONFIG_NVME_FC=y
> CONFIG_NVME_TCP=y
> # CONFIG_NVME_TCP_TLS is not set
> # CONFIG_NVME_HOST_AUTH is not set
> CONFIG_NVME_TARGET=y
> # CONFIG_NVME_TARGET_DEBUGFS is not set
> # CONFIG_NVME_TARGET_PASSTHRU is not set
> CONFIG_NVME_TARGET_LOOP=y
> CONFIG_NVME_TARGET_FC=y
> CONFIG_NVME_TARGET_FCLOOP=y
> CONFIG_NVME_TARGET_TCP=y
> # CONFIG_NVME_TARGET_TCP_TLS is not set
> # CONFIG_NVME_TARGET_AUTH is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=y
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_RPMB is not set
> CONFIG_TIFM_CORE=y
> CONFIG_TIFM_7XX1=y
> # CONFIG_ICS932S401 is not set
> CONFIG_ENCLOSURE_SERVICES=y
> CONFIG_SGI_XP=y
> CONFIG_HP_ILO=y
> CONFIG_SGI_GRU=y
> # CONFIG_SGI_GRU_DEBUG is not set
> CONFIG_APDS9802ALS=y
> CONFIG_ISL29003=y
> CONFIG_ISL29020=y
> CONFIG_SENSORS_TSL2550=y
> CONFIG_SENSORS_BH1770=y
> CONFIG_SENSORS_APDS990X=y
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> # CONFIG_SRAM is not set
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> CONFIG_MISC_RTSX=y
> # CONFIG_NTSYNC is not set
> # CONFIG_NSM is not set
> # CONFIG_C2PORT is not set
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_AT25 is not set
> CONFIG_EEPROM_MAX6875=y
> CONFIG_EEPROM_93CX6=y
> # CONFIG_EEPROM_93XX46 is not set
> # CONFIG_EEPROM_IDT_89HPESX is not set
> # CONFIG_EEPROM_EE1004 is not set
> # end of EEPROM support
> 
> CONFIG_CB710_CORE=y
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> CONFIG_SENSORS_LIS3_I2C=y
> CONFIG_ALTERA_STAPL=y
> CONFIG_INTEL_MEI=y
> CONFIG_INTEL_MEI_ME=y
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_INTEL_MEI_VSC_HW is not set
> # CONFIG_VMWARE_VMCI is not set
> # CONFIG_GENWQE is not set
> # CONFIG_ECHO is not set
> # CONFIG_BCM_VK is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> CONFIG_MISC_RTSX_PCI=y
> CONFIG_MISC_RTSX_USB=y
> CONFIG_UACCE=y
> CONFIG_PVPANIC=y
> # CONFIG_PVPANIC_MMIO is not set
> # CONFIG_PVPANIC_PCI is not set
> # CONFIG_GP_PCI1XXXX is not set
> # CONFIG_KEBA_CP500 is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> CONFIG_RAID_ATTRS=y
> CONFIG_SCSI_COMMON=y
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_NETLINK=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> CONFIG_CHR_DEV_ST=y
> CONFIG_BLK_DEV_SR=y
> CONFIG_CHR_DEV_SG=y
> CONFIG_BLK_DEV_BSG=y
> CONFIG_CHR_DEV_SCH=y
> # CONFIG_SCSI_ENCLOSURE is not set
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=y
> CONFIG_SCSI_FC_ATTRS=y
> CONFIG_SCSI_ISCSI_ATTRS=y
> CONFIG_SCSI_SAS_ATTRS=y
> CONFIG_SCSI_SAS_LIBSAS=y
> CONFIG_SCSI_SAS_ATA=y
> CONFIG_SCSI_SAS_HOST_SMP=y
> CONFIG_SCSI_SRP_ATTRS=y
> # end of SCSI Transports
> 
> CONFIG_SCSI_LOWLEVEL=y
> CONFIG_ISCSI_TCP=y
> CONFIG_ISCSI_BOOT_SYSFS=y
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> CONFIG_SCSI_CXGB4_ISCSI=y
> CONFIG_SCSI_BNX2_ISCSI=y
> CONFIG_SCSI_BNX2X_FCOE=y
> CONFIG_BE2ISCSI=y
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> CONFIG_SCSI_HPSA=y
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_3W_SAS is not set
> # CONFIG_SCSI_ACARD is not set
> CONFIG_SCSI_AACRAID=y
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> CONFIG_MEGARAID_SAS=y
> CONFIG_SCSI_MPT3SAS=y
> CONFIG_SCSI_MPT2SAS_MAX_SGE=128
> CONFIG_SCSI_MPT3SAS_MAX_SGE=128
> CONFIG_SCSI_MPT2SAS=y
> # CONFIG_SCSI_MPI3MR is not set
> CONFIG_SCSI_SMARTPQI=y
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
> CONFIG_VMWARE_PVSCSI=y
> # CONFIG_XEN_SCSI_FRONTEND is not set
> CONFIG_HYPERV_STORAGE=y
> CONFIG_LIBFC=y
> CONFIG_LIBFCOE=y
> CONFIG_FCOE=y
> CONFIG_FCOE_FNIC=y
> # CONFIG_SCSI_SNIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> # CONFIG_SCSI_ISCI is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> CONFIG_SCSI_QLA_FC=y
> # CONFIG_TCM_QLA2XXX is not set
> CONFIG_SCSI_QLA_ISCSI=y
> CONFIG_QEDI=y
> CONFIG_QEDF=y
> CONFIG_SCSI_LPFC=y
> # CONFIG_SCSI_LPFC_DEBUG_FS is not set
> # CONFIG_SCSI_EFCT is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> CONFIG_SCSI_DEBUG=y
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_BFA_FC is not set
> CONFIG_SCSI_VIRTIO=y
> CONFIG_SCSI_CHELSIO_FCOE=y
> CONFIG_SCSI_DH=y
> CONFIG_SCSI_DH_RDAC=y
> CONFIG_SCSI_DH_HP_SW=y
> CONFIG_SCSI_DH_EMC=y
> CONFIG_SCSI_DH_ALUA=y
> # end of SCSI device support
> 
> CONFIG_ATA=y
> CONFIG_SATA_HOST=y
> CONFIG_PATA_TIMINGS=y
> CONFIG_ATA_VERBOSE_ERROR=y
> CONFIG_ATA_FORCE=y
> CONFIG_ATA_ACPI=y
> # CONFIG_SATA_ZPODD is not set
> CONFIG_SATA_PMP=y
> 
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=y
> CONFIG_SATA_MOBILE_LPM_POLICY=0
> CONFIG_SATA_AHCI_PLATFORM=y
> # CONFIG_AHCI_DWC is not set
> # CONFIG_SATA_INIC162X is not set
> # CONFIG_SATA_ACARD_AHCI is not set
> # CONFIG_SATA_SIL24 is not set
> CONFIG_ATA_SFF=y
> 
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> # CONFIG_SATA_SX4 is not set
> CONFIG_ATA_BMDMA=y
> 
> #
> # SATA SFF controllers with BMDMA
> #
> CONFIG_ATA_PIIX=y
> # CONFIG_SATA_DWC is not set
> # CONFIG_SATA_MV is not set
> # CONFIG_SATA_NV is not set
> # CONFIG_SATA_PROMISE is not set
> # CONFIG_SATA_SIL is not set
> # CONFIG_SATA_SIS is not set
> # CONFIG_SATA_SVW is not set
> # CONFIG_SATA_ULI is not set
> # CONFIG_SATA_VIA is not set
> # CONFIG_SATA_VITESSE is not set
> 
> #
> # PATA SFF controllers with BMDMA
> #
> # CONFIG_PATA_ALI is not set
> # CONFIG_PATA_AMD is not set
> # CONFIG_PATA_ARTOP is not set
> # CONFIG_PATA_ATIIXP is not set
> # CONFIG_PATA_ATP867X is not set
> # CONFIG_PATA_CMD64X is not set
> # CONFIG_PATA_CYPRESS is not set
> # CONFIG_PATA_EFAR is not set
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT8213 is not set
> # CONFIG_PATA_IT821X is not set
> # CONFIG_PATA_JMICRON is not set
> # CONFIG_PATA_MARVELL is not set
> # CONFIG_PATA_NETCELL is not set
> # CONFIG_PATA_NINJA32 is not set
> # CONFIG_PATA_NS87415 is not set
> # CONFIG_PATA_OLDPIIX is not set
> # CONFIG_PATA_OPTIDMA is not set
> # CONFIG_PATA_PDC2027X is not set
> # CONFIG_PATA_PDC_OLD is not set
> # CONFIG_PATA_RADISYS is not set
> # CONFIG_PATA_RDC is not set
> # CONFIG_PATA_SCH is not set
> # CONFIG_PATA_SERVERWORKS is not set
> # CONFIG_PATA_SIL680 is not set
> # CONFIG_PATA_SIS is not set
> # CONFIG_PATA_TOSHIBA is not set
> # CONFIG_PATA_TRIFLEX is not set
> # CONFIG_PATA_VIA is not set
> # CONFIG_PATA_WINBOND is not set
> 
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_CMD640_PCI is not set
> # CONFIG_PATA_MPIIX is not set
> # CONFIG_PATA_NS87410 is not set
> # CONFIG_PATA_OPTI is not set
> # CONFIG_PATA_RZ1000 is not set
> # CONFIG_PATA_PARPORT is not set
> 
> #
> # Generic fallback / legacy drivers
> #
> # CONFIG_PATA_ACPI is not set
> CONFIG_ATA_GENERIC=y
> # CONFIG_PATA_LEGACY is not set
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_AUTODETECT=y
> CONFIG_MD_BITMAP_FILE=y
> CONFIG_MD_LINEAR=y
> CONFIG_MD_RAID0=y
> CONFIG_MD_RAID1=y
> CONFIG_MD_RAID10=y
> CONFIG_MD_RAID456=y
> CONFIG_BCACHE=y
> # CONFIG_BCACHE_DEBUG is not set
> # CONFIG_BCACHE_ASYNC_REGISTRATION is not set
> CONFIG_BLK_DEV_DM_BUILTIN=y
> CONFIG_BLK_DEV_DM=y
> CONFIG_DM_DEBUG=y
> CONFIG_DM_BUFIO=y
> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> CONFIG_DM_BIO_PRISON=y
> CONFIG_DM_PERSISTENT_DATA=y
> # CONFIG_DM_UNSTRIPED is not set
> CONFIG_DM_CRYPT=y
> CONFIG_DM_SNAPSHOT=y
> CONFIG_DM_THIN_PROVISIONING=y
> CONFIG_DM_CACHE=y
> CONFIG_DM_CACHE_SMQ=y
> CONFIG_DM_WRITECACHE=y
> # CONFIG_DM_EBS is not set
> CONFIG_DM_ERA=y
> # CONFIG_DM_CLONE is not set
> CONFIG_DM_MIRROR=y
> CONFIG_DM_LOG_USERSPACE=y
> CONFIG_DM_RAID=y
> CONFIG_DM_ZERO=y
> CONFIG_DM_MULTIPATH=y
> CONFIG_DM_MULTIPATH_QL=y
> CONFIG_DM_MULTIPATH_ST=y
> # CONFIG_DM_MULTIPATH_HST is not set
> # CONFIG_DM_MULTIPATH_IOA is not set
> CONFIG_DM_DELAY=y
> # CONFIG_DM_DUST is not set
> # CONFIG_DM_INIT is not set
> CONFIG_DM_UEVENT=y
> CONFIG_DM_FLAKEY=y
> CONFIG_DM_VERITY=y
> # CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
> # CONFIG_DM_VERITY_FEC is not set
> CONFIG_DM_SWITCH=y
> CONFIG_DM_LOG_WRITES=y
> CONFIG_DM_INTEGRITY=y
> # CONFIG_DM_ZONED is not set
> CONFIG_DM_AUDIT=y
> # CONFIG_DM_VDO is not set
> CONFIG_TARGET_CORE=y
> CONFIG_TCM_IBLOCK=y
> CONFIG_TCM_FILEIO=y
> CONFIG_TCM_PSCSI=y
> CONFIG_TCM_USER2=y
> CONFIG_LOOPBACK_TARGET=y
> # CONFIG_TCM_FC is not set
> CONFIG_ISCSI_TARGET=y
> CONFIG_ISCSI_TARGET_CXGB4=y
> # CONFIG_SBP_TARGET is not set
> # CONFIG_REMOTE_TARGET is not set
> CONFIG_FUSION=y
> CONFIG_FUSION_SPI=y
> # CONFIG_FUSION_FC is not set
> CONFIG_FUSION_SAS=y
> CONFIG_FUSION_MAX_SGE=128
> CONFIG_FUSION_CTL=y
> CONFIG_FUSION_LOGGING=y
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=y
> CONFIG_FIREWIRE_OHCI=y
> CONFIG_FIREWIRE_SBP2=y
> CONFIG_FIREWIRE_NET=y
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
> 
> CONFIG_MACINTOSH_DRIVERS=y
> CONFIG_MAC_EMUMOUSEBTN=y
> CONFIG_NETDEVICES=y
> CONFIG_MII=y
> CONFIG_NET_CORE=y
> CONFIG_BONDING=y
> CONFIG_DUMMY=y
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> CONFIG_NET_FC=y
> CONFIG_IFB=y
> # CONFIG_NET_TEAM is not set
> CONFIG_MACVLAN=y
> CONFIG_MACVTAP=y
> CONFIG_IPVLAN_L3S=y
> CONFIG_IPVLAN=y
> CONFIG_IPVTAP=y
> CONFIG_VXLAN=y
> CONFIG_GENEVE=y
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_PFCP is not set
> # CONFIG_AMT is not set
> CONFIG_MACSEC=y
> CONFIG_NETCONSOLE=y
> CONFIG_NETCONSOLE_DYNAMIC=y
> # CONFIG_NETCONSOLE_EXTENDED_LOG is not set
> CONFIG_NETPOLL=y
> CONFIG_NET_POLL_CONTROLLER=y
> CONFIG_NTB_NETDEV=y
> CONFIG_TUN=y
> CONFIG_TAP=y
> # CONFIG_TUN_VNET_CROSS_LE is not set
> CONFIG_VETH=y
> CONFIG_VIRTIO_NET=y
> CONFIG_NLMON=y
> # CONFIG_NETKIT is not set
> CONFIG_NET_VRF=y
> # CONFIG_ARCNET is not set
> # CONFIG_ATM_DRIVERS is not set
> CONFIG_ETHERNET=y
> CONFIG_MDIO=y
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_NET_VENDOR_ADAPTEC is not set
> # CONFIG_NET_VENDOR_AGERE is not set
> # CONFIG_NET_VENDOR_ALACRITECH is not set
> # CONFIG_NET_VENDOR_ALTEON is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> CONFIG_ENA_ETHERNET=y
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_PCNET32 is not set
> CONFIG_AMD_XGBE=y
> # CONFIG_AMD_XGBE_DCB is not set
> CONFIG_AMD_XGBE_HAVE_ECC=y
> # CONFIG_PDS_CORE is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> CONFIG_AQTION=y
> # CONFIG_NET_VENDOR_ARC is not set
> CONFIG_NET_VENDOR_ASIX=y
> # CONFIG_SPI_AX88796C is not set
> CONFIG_NET_VENDOR_ATHEROS=y
> CONFIG_ATL2=y
> CONFIG_ATL1=y
> CONFIG_ATL1E=y
> CONFIG_ATL1C=y
> CONFIG_ALX=y
> # CONFIG_CX_ECAT is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> CONFIG_BNX2=y
> CONFIG_CNIC=y
> CONFIG_TIGON3=y
> CONFIG_TIGON3_HWMON=y
> CONFIG_BNX2X=y
> CONFIG_BNX2X_SRIOV=y
> # CONFIG_SYSTEMPORT is not set
> CONFIG_BNXT=y
> CONFIG_BNXT_SRIOV=y
> CONFIG_BNXT_FLOWER_OFFLOAD=y
> CONFIG_BNXT_DCB=y
> CONFIG_BNXT_HWMON=y
> CONFIG_NET_VENDOR_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> # CONFIG_THUNDER_NIC_PF is not set
> # CONFIG_THUNDER_NIC_VF is not set
> # CONFIG_THUNDER_NIC_BGX is not set
> # CONFIG_THUNDER_NIC_RGX is not set
> CONFIG_CAVIUM_PTP=y
> CONFIG_LIQUIDIO_CORE=y
> CONFIG_LIQUIDIO=y
> CONFIG_LIQUIDIO_VF=y
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> CONFIG_CHELSIO_T4=y
> # CONFIG_CHELSIO_T4_DCB is not set
> CONFIG_CHELSIO_T4VF=y
> CONFIG_CHELSIO_LIB=y
> CONFIG_CHELSIO_INLINE_CRYPTO=y
> CONFIG_CHELSIO_IPSEC_INLINE=y
> # CONFIG_CHELSIO_TLS_DEVICE is not set
> CONFIG_NET_VENDOR_CISCO=y
> CONFIG_ENIC=y
> # CONFIG_NET_VENDOR_CORTINA is not set
> CONFIG_NET_VENDOR_DAVICOM=y
> # CONFIG_DM9051 is not set
> CONFIG_DNET=y
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> CONFIG_DL2K=y
> CONFIG_NET_VENDOR_EMULEX=y
> CONFIG_BE2NET=y
> CONFIG_BE2NET_HWMON=y
> # CONFIG_BE2NET_BE2 is not set
> # CONFIG_BE2NET_BE3 is not set
> CONFIG_BE2NET_LANCER=y
> CONFIG_BE2NET_SKYHAWK=y
> CONFIG_NET_VENDOR_ENGLEDER=y
> # CONFIG_TSNEP is not set
> # CONFIG_NET_VENDOR_EZCHIP is not set
> CONFIG_NET_VENDOR_FUNGIBLE=y
> # CONFIG_FUN_ETH is not set
> CONFIG_NET_VENDOR_GOOGLE=y
> # CONFIG_GVE is not set
> CONFIG_NET_VENDOR_HISILICON=y
> CONFIG_HIBMCGE=m
> CONFIG_NET_VENDOR_HUAWEI=y
> CONFIG_HINIC=y
> # CONFIG_NET_VENDOR_I825XX is not set
> CONFIG_NET_VENDOR_INTEL=y
> CONFIG_LIBETH=y
> CONFIG_LIBIE=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> CONFIG_E1000E=y
> CONFIG_E1000E_HWTS=y
> CONFIG_IGB=y
> CONFIG_IGB_HWMON=y
> CONFIG_IGB_DCA=y
> CONFIG_IGBVF=y
> CONFIG_IXGBE=y
> CONFIG_IXGBE_HWMON=y
> CONFIG_IXGBE_DCA=y
> CONFIG_IXGBE_DCB=y
> CONFIG_IXGBE_IPSEC=y
> CONFIG_IXGBEVF=y
> CONFIG_IXGBEVF_IPSEC=y
> CONFIG_I40E=y
> CONFIG_I40E_DCB=y
> CONFIG_IAVF=y
> CONFIG_I40EVF=y
> CONFIG_ICE=y
> CONFIG_ICE_HWMON=y
> CONFIG_ICE_SWITCHDEV=y
> CONFIG_FM10K=y
> # CONFIG_IGC is not set
> # CONFIG_IDPF is not set
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_ADI=y
> # CONFIG_ADIN1110 is not set
> CONFIG_NET_VENDOR_LITEX=y
> # CONFIG_NET_VENDOR_MARVELL is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> CONFIG_MLX4_EN=y
> CONFIG_MLX4_EN_DCB=y
> CONFIG_MLX4_CORE=y
> CONFIG_MLX4_DEBUG=y
> # CONFIG_MLX4_CORE_GEN2 is not set
> CONFIG_MLX5_CORE=y
> CONFIG_MLX5_FPGA=y
> CONFIG_MLX5_CORE_EN=y
> CONFIG_MLX5_EN_ARFS=y
> CONFIG_MLX5_EN_RXNFC=y
> CONFIG_MLX5_MPFS=y
> CONFIG_MLX5_ESWITCH=y
> CONFIG_MLX5_BRIDGE=y
> CONFIG_MLX5_CORE_EN_DCB=y
> CONFIG_MLX5_CORE_IPOIB=y
> # CONFIG_MLX5_MACSEC is not set
> # CONFIG_MLX5_EN_IPSEC is not set
> # CONFIG_MLX5_EN_TLS is not set
> CONFIG_MLX5_SW_STEERING=y
> CONFIG_MLX5_HW_STEERING=y
> # CONFIG_MLX5_SF is not set
> # CONFIG_MLX5_DPLL is not set
> CONFIG_MLXSW_CORE=y
> CONFIG_MLXSW_CORE_HWMON=y
> CONFIG_MLXSW_CORE_THERMAL=y
> CONFIG_MLXSW_PCI=y
> CONFIG_MLXSW_I2C=y
> CONFIG_MLXSW_SPECTRUM=y
> CONFIG_MLXSW_SPECTRUM_DCB=y
> CONFIG_MLXSW_MINIMAL=y
> CONFIG_MLXFW=y
> CONFIG_NET_VENDOR_META=y
> # CONFIG_FBNIC is not set
> # CONFIG_NET_VENDOR_MICREL is not set
> # CONFIG_NET_VENDOR_MICROCHIP is not set
> # CONFIG_NET_VENDOR_MICROSEMI is not set
> CONFIG_NET_VENDOR_MICROSOFT=y
> # CONFIG_MICROSOFT_MANA is not set
> CONFIG_NET_VENDOR_MYRI=y
> CONFIG_MYRI10GE=y
> CONFIG_MYRI10GE_DCA=y
> # CONFIG_FEALNX is not set
> # CONFIG_NET_VENDOR_NI is not set
> # CONFIG_NET_VENDOR_NATSEMI is not set
> CONFIG_NET_VENDOR_NETERION=y
> # CONFIG_S2IO is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> CONFIG_NFP=y
> CONFIG_NFP_APP_FLOWER=y
> CONFIG_NFP_APP_ABM_NIC=y
> CONFIG_NFP_NET_IPSEC=y
> # CONFIG_NFP_DEBUG is not set
> # CONFIG_NET_VENDOR_NVIDIA is not set
> CONFIG_NET_VENDOR_OKI=y
> CONFIG_ETHOC=y
> CONFIG_NET_VENDOR_PACKET_ENGINES=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> # CONFIG_IONIC is not set
> CONFIG_NET_VENDOR_QLOGIC=y
> CONFIG_QLA3XXX=y
> # CONFIG_QLCNIC is not set
> CONFIG_NETXEN_NIC=y
> CONFIG_QED=y
> CONFIG_QED_LL2=y
> CONFIG_QED_SRIOV=y
> CONFIG_QEDE=y
> CONFIG_QED_ISCSI=y
> CONFIG_QED_FCOE=y
> CONFIG_QED_OOO=y
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> # CONFIG_NET_VENDOR_QUALCOMM is not set
> # CONFIG_NET_VENDOR_RDC is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_ATP is not set
> CONFIG_8139CP=y
> CONFIG_8139TOO=y
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> CONFIG_8139TOO_8129=y
> # CONFIG_8139_OLD_RX_RESET is not set
> CONFIG_R8169=y
> # CONFIG_RTASE is not set
> # CONFIG_NET_VENDOR_RENESAS is not set
> CONFIG_NET_VENDOR_ROCKER=y
> CONFIG_ROCKER=y
> # CONFIG_NET_VENDOR_SAMSUNG is not set
> # CONFIG_NET_VENDOR_SEEQ is not set
> # CONFIG_NET_VENDOR_SILAN is not set
> # CONFIG_NET_VENDOR_SIS is not set
> CONFIG_NET_VENDOR_SOLARFLARE=y
> CONFIG_SFC=y
> CONFIG_SFC_MTD=y
> CONFIG_SFC_MCDI_MON=y
> CONFIG_SFC_SRIOV=y
> CONFIG_SFC_MCDI_LOGGING=y
> # CONFIG_SFC_FALCON is not set
> # CONFIG_SFC_SIENA is not set
> # CONFIG_NET_VENDOR_SMSC is not set
> # CONFIG_NET_VENDOR_SOCIONEXT is not set
> # CONFIG_NET_VENDOR_STMICRO is not set
> # CONFIG_NET_VENDOR_SUN is not set
> # CONFIG_NET_VENDOR_SYNOPSYS is not set
> # CONFIG_NET_VENDOR_TEHUTI is not set
> # CONFIG_NET_VENDOR_TI is not set
> CONFIG_NET_VENDOR_VERTEXCOM=y
> # CONFIG_MSE102X is not set
> # CONFIG_NET_VENDOR_VIA is not set
> CONFIG_NET_VENDOR_WANGXUN=y
> CONFIG_LIBWX=y
> CONFIG_NGBE=y
> CONFIG_TXGBE=y
> # CONFIG_NET_VENDOR_WIZNET is not set
> # CONFIG_NET_VENDOR_XILINX is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_PHYLINK=y
> CONFIG_PHYLIB=y
> CONFIG_SWPHY=y
> CONFIG_LED_TRIGGER_PHY=y
> CONFIG_FIXED_PHY=y
> CONFIG_SFP=y
> 
> #
> # MII PHY device drivers
> #
> # CONFIG_AIR_EN8811H_PHY is not set
> CONFIG_AMD_PHY=y
> # CONFIG_ADIN_PHY is not set
> # CONFIG_ADIN1100_PHY is not set
> CONFIG_AQUANTIA_PHY=y
> CONFIG_AX88796B_PHY=y
> CONFIG_BROADCOM_PHY=y
> # CONFIG_BCM54140_PHY is not set
> CONFIG_BCM7XXX_PHY=y
> # CONFIG_BCM84881_PHY is not set
> CONFIG_BCM87XX_PHY=y
> CONFIG_BCM_NET_PHYLIB=y
> CONFIG_BCM_NET_PHYPTP=y
> CONFIG_CICADA_PHY=y
> CONFIG_CORTINA_PHY=y
> CONFIG_DAVICOM_PHY=y
> CONFIG_ICPLUS_PHY=y
> CONFIG_LXT_PHY=y
> CONFIG_INTEL_XWAY_PHY=y
> CONFIG_LSI_ET1011C_PHY=y
> CONFIG_MARVELL_PHY=y
> CONFIG_MARVELL_10G_PHY=y
> # CONFIG_MARVELL_88Q2XXX_PHY is not set
> # CONFIG_MARVELL_88X2222_PHY is not set
> # CONFIG_MAXLINEAR_GPHY is not set
> # CONFIG_MEDIATEK_GE_PHY is not set
> CONFIG_MICREL_PHY=y
> # CONFIG_MICROCHIP_T1S_PHY is not set
> CONFIG_MICROCHIP_PHY=y
> CONFIG_MICROCHIP_T1_PHY=y
> CONFIG_MICROCHIP_PHY_RDS_PTP=y
> CONFIG_MICROSEMI_PHY=y
> CONFIG_MOTORCOMM_PHY=m
> CONFIG_NATIONAL_PHY=y
> # CONFIG_NXP_CBTX_PHY is not set
> # CONFIG_NXP_C45_TJA11XX_PHY is not set
> # CONFIG_NXP_TJA11XX_PHY is not set
> # CONFIG_NCN26000_PHY is not set
> # CONFIG_QCA83XX_PHY is not set
> # CONFIG_QCA808X_PHY is not set
> CONFIG_QSEMI_PHY=y
> CONFIG_REALTEK_PHY=y
> # CONFIG_REALTEK_PHY_HWMON is not set
> CONFIG_RENESAS_PHY=y
> CONFIG_ROCKCHIP_PHY=y
> CONFIG_SMSC_PHY=y
> CONFIG_STE10XP=y
> CONFIG_TERANETICS_PHY=y
> CONFIG_DP83822_PHY=y
> CONFIG_DP83TC811_PHY=y
> CONFIG_DP83848_PHY=y
> CONFIG_DP83867_PHY=y
> # CONFIG_DP83869_PHY is not set
> # CONFIG_DP83TD510_PHY is not set
> # CONFIG_DP83TG720_PHY is not set
> CONFIG_VITESSE_PHY=y
> CONFIG_XILINX_GMII2RGMII=y
> CONFIG_MICREL_KS8995MA=y
> CONFIG_CAN_DEV=y
> CONFIG_CAN_VCAN=y
> # CONFIG_CAN_VXCAN is not set
> CONFIG_CAN_NETLINK=y
> CONFIG_CAN_CALC_BITTIMING=y
> # CONFIG_CAN_CAN327 is not set
> # CONFIG_CAN_KVASER_PCIEFD is not set
> CONFIG_CAN_SLCAN=y
> CONFIG_CAN_C_CAN=y
> CONFIG_CAN_C_CAN_PLATFORM=y
> CONFIG_CAN_C_CAN_PCI=y
> CONFIG_CAN_CC770=y
> # CONFIG_CAN_CC770_ISA is not set
> CONFIG_CAN_CC770_PLATFORM=y
> # CONFIG_CAN_CTUCANFD_PCI is not set
> # CONFIG_CAN_ESD_402_PCI is not set
> # CONFIG_CAN_IFI_CANFD is not set
> # CONFIG_CAN_M_CAN is not set
> # CONFIG_CAN_PEAK_PCIEFD is not set
> CONFIG_CAN_SJA1000=y
> CONFIG_CAN_EMS_PCI=y
> # CONFIG_CAN_F81601 is not set
> CONFIG_CAN_KVASER_PCI=y
> CONFIG_CAN_PEAK_PCI=y
> CONFIG_CAN_PEAK_PCIEC=y
> CONFIG_CAN_PLX_PCI=y
> # CONFIG_CAN_SJA1000_ISA is not set
> CONFIG_CAN_SJA1000_PLATFORM=y
> CONFIG_CAN_SOFTING=y
> 
> #
> # CAN SPI interfaces
> #
> # CONFIG_CAN_HI311X is not set
> # CONFIG_CAN_MCP251X is not set
> # CONFIG_CAN_MCP251XFD is not set
> # end of CAN SPI interfaces
> 
> #
> # CAN USB interfaces
> #
> CONFIG_CAN_8DEV_USB=y
> CONFIG_CAN_EMS_USB=y
> # CONFIG_CAN_ESD_USB is not set
> # CONFIG_CAN_ETAS_ES58X is not set
> # CONFIG_CAN_F81604 is not set
> # CONFIG_CAN_GS_USB is not set
> CONFIG_CAN_KVASER_USB=y
> # CONFIG_CAN_MCBA_USB is not set
> CONFIG_CAN_PEAK_USB=y
> # CONFIG_CAN_UCAN is not set
> # end of CAN USB interfaces
> 
> # CONFIG_CAN_DEBUG_DEVICES is not set
> CONFIG_MDIO_DEVICE=y
> CONFIG_MDIO_BUS=y
> CONFIG_FWNODE_MDIO=y
> CONFIG_ACPI_MDIO=y
> CONFIG_MDIO_DEVRES=y
> CONFIG_MDIO_BITBANG=y
> # CONFIG_MDIO_BCM_UNIMAC is not set
> CONFIG_MDIO_CAVIUM=y
> # CONFIG_MDIO_GPIO is not set
> CONFIG_MDIO_I2C=y
> # CONFIG_MDIO_MVUSB is not set
> CONFIG_MDIO_THUNDER=y
> 
> #
> # MDIO Multiplexers
> #
> 
> #
> # PCS device drivers
> #
> CONFIG_PCS_XPCS=y
> # end of PCS device drivers
> 
> # CONFIG_PLIP is not set
> CONFIG_PPP=y
> CONFIG_PPP_BSDCOMP=y
> CONFIG_PPP_DEFLATE=y
> CONFIG_PPP_FILTER=y
> CONFIG_PPP_MPPE=y
> CONFIG_PPP_MULTILINK=y
> CONFIG_PPPOATM=y
> CONFIG_PPPOE=y
> # CONFIG_PPPOE_HASH_BITS_1 is not set
> # CONFIG_PPPOE_HASH_BITS_2 is not set
> CONFIG_PPPOE_HASH_BITS_4=y
> # CONFIG_PPPOE_HASH_BITS_8 is not set
> CONFIG_PPPOE_HASH_BITS=4
> CONFIG_PPTP=y
> CONFIG_PPPOL2TP=y
> CONFIG_PPP_ASYNC=y
> CONFIG_PPP_SYNC_TTY=y
> CONFIG_SLIP=y
> CONFIG_SLHC=y
> CONFIG_SLIP_COMPRESSED=y
> CONFIG_SLIP_SMART=y
> # CONFIG_SLIP_MODE_SLIP6 is not set
> CONFIG_USB_NET_DRIVERS=y
> CONFIG_USB_CATC=y
> CONFIG_USB_KAWETH=y
> CONFIG_USB_PEGASUS=y
> CONFIG_USB_RTL8150=y
> CONFIG_USB_RTL8152=y
> CONFIG_USB_LAN78XX=y
> CONFIG_USB_USBNET=y
> CONFIG_USB_NET_AX8817X=y
> CONFIG_USB_NET_AX88179_178A=y
> CONFIG_USB_NET_CDCETHER=y
> CONFIG_USB_NET_CDC_EEM=y
> CONFIG_USB_NET_CDC_NCM=y
> CONFIG_USB_NET_HUAWEI_CDC_NCM=y
> CONFIG_USB_NET_CDC_MBIM=y
> CONFIG_USB_NET_DM9601=y
> # CONFIG_USB_NET_SR9700 is not set
> # CONFIG_USB_NET_SR9800 is not set
> CONFIG_USB_NET_SMSC75XX=y
> CONFIG_USB_NET_SMSC95XX=y
> CONFIG_USB_NET_GL620A=y
> CONFIG_USB_NET_NET1080=y
> CONFIG_USB_NET_PLUSB=y
> CONFIG_USB_NET_MCS7830=y
> CONFIG_USB_NET_RNDIS_HOST=y
> CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
> CONFIG_USB_NET_CDC_SUBSET=y
> CONFIG_USB_ALI_M5632=y
> CONFIG_USB_AN2720=y
> CONFIG_USB_BELKIN=y
> CONFIG_USB_ARMLINUX=y
> CONFIG_USB_EPSON2888=y
> CONFIG_USB_KC2190=y
> CONFIG_USB_NET_ZAURUS=y
> CONFIG_USB_NET_CX82310_ETH=y
> CONFIG_USB_NET_KALMIA=y
> CONFIG_USB_NET_QMI_WWAN=y
> CONFIG_USB_HSO=y
> CONFIG_USB_NET_INT51X1=y
> CONFIG_USB_IPHETH=y
> CONFIG_USB_SIERRA_NET=y
> CONFIG_USB_VL600=y
> CONFIG_USB_NET_CH9200=y
> # CONFIG_USB_NET_AQC111 is not set
> CONFIG_USB_RTL8153_ECM=y
> # CONFIG_WLAN is not set
> CONFIG_WAN=y
> CONFIG_HDLC=y
> CONFIG_HDLC_RAW=y
> # CONFIG_HDLC_RAW_ETH is not set
> CONFIG_HDLC_CISCO=y
> CONFIG_HDLC_FR=y
> CONFIG_HDLC_PPP=y
> 
> #
> # X.25/LAPB support is disabled
> #
> # CONFIG_FRAMER is not set
> # CONFIG_PCI200SYN is not set
> # CONFIG_WANXL is not set
> # CONFIG_PC300TOO is not set
> # CONFIG_FARSYNC is not set
> 
> #
> # Wireless WAN
> #
> # CONFIG_WWAN is not set
> # end of Wireless WAN
> 
> CONFIG_XEN_NETDEV_FRONTEND=y
> CONFIG_VMXNET3=y
> CONFIG_FUJITSU_ES=y
> CONFIG_USB4_NET=y
> CONFIG_HYPERV_NET=y
> CONFIG_NETDEVSIM=y
> CONFIG_NET_FAILOVER=y
> CONFIG_ISDN=y
> CONFIG_MISDN=y
> CONFIG_MISDN_DSP=y
> CONFIG_MISDN_L1OIP=y
> 
> #
> # mISDN hardware drivers
> #
> CONFIG_MISDN_HFCPCI=y
> CONFIG_MISDN_HFCMULTI=y
> CONFIG_MISDN_HFCUSB=y
> CONFIG_MISDN_AVMFRITZ=y
> CONFIG_MISDN_SPEEDFAX=y
> CONFIG_MISDN_INFINEON=y
> CONFIG_MISDN_W6692=y
> CONFIG_MISDN_NETJET=y
> CONFIG_MISDN_HDLC=y
> CONFIG_MISDN_IPAC=y
> CONFIG_MISDN_ISAR=y
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=y
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_SPARSEKMAP=y
> # CONFIG_INPUT_MATRIXKMAP is not set
> CONFIG_INPUT_VIVALDIFMAP=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=y
> CONFIG_INPUT_EVDEV=y
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADC is not set
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> # CONFIG_KEYBOARD_APPLESPI is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CYPRESS_SF is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_BYD=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> CONFIG_MOUSE_PS2_LIFEBOOK=y
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> CONFIG_MOUSE_PS2_ELANTECH=y
> CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
> CONFIG_MOUSE_PS2_SENTELIC=y
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> CONFIG_MOUSE_PS2_FOCALTECH=y
> CONFIG_MOUSE_PS2_VMMOUSE=y
> CONFIG_MOUSE_PS2_SMBUS=y
> CONFIG_MOUSE_SERIAL=y
> CONFIG_MOUSE_APPLETOUCH=y
> CONFIG_MOUSE_BCM5974=y
> CONFIG_MOUSE_CYAPA=y
> CONFIG_MOUSE_ELAN_I2C=y
> CONFIG_MOUSE_ELAN_I2C_I2C=y
> CONFIG_MOUSE_ELAN_I2C_SMBUS=y
> CONFIG_MOUSE_VSXXXAA=y
> # CONFIG_MOUSE_GPIO is not set
> CONFIG_MOUSE_SYNAPTICS_I2C=y
> CONFIG_MOUSE_SYNAPTICS_USB=y
> # CONFIG_INPUT_JOYSTICK is not set
> CONFIG_INPUT_TABLET=y
> CONFIG_TABLET_USB_ACECAD=y
> CONFIG_TABLET_USB_AIPTEK=y
> # CONFIG_TABLET_USB_HANWANG is not set
> CONFIG_TABLET_USB_KBTAB=y
> # CONFIG_TABLET_USB_PEGASUS is not set
> CONFIG_TABLET_SERIAL_WACOM4=y
> CONFIG_INPUT_TOUCHSCREEN=y
> # CONFIG_TOUCHSCREEN_ADS7846 is not set
> # CONFIG_TOUCHSCREEN_AD7877 is not set
> # CONFIG_TOUCHSCREEN_AD7879 is not set
> # CONFIG_TOUCHSCREEN_ADC is not set
> # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> # CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_BU21013 is not set
> # CONFIG_TOUCHSCREEN_BU21029 is not set
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
> # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
> # CONFIG_TOUCHSCREEN_CYTTSP5 is not set
> # CONFIG_TOUCHSCREEN_DYNAPRO is not set
> # CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
> # CONFIG_TOUCHSCREEN_EETI is not set
> # CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
> # CONFIG_TOUCHSCREEN_EXC3000 is not set
> # CONFIG_TOUCHSCREEN_FUJITSU is not set
> # CONFIG_TOUCHSCREEN_GOODIX is not set
> # CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C is not set
> # CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI is not set
> # CONFIG_TOUCHSCREEN_HIDEEP is not set
> # CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
> # CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX is not set
> # CONFIG_TOUCHSCREEN_ILI210X is not set
> # CONFIG_TOUCHSCREEN_ILITEK is not set
> # CONFIG_TOUCHSCREEN_S6SY761 is not set
> # CONFIG_TOUCHSCREEN_GUNZE is not set
> # CONFIG_TOUCHSCREEN_EKTF2127 is not set
> # CONFIG_TOUCHSCREEN_ELAN is not set
> CONFIG_TOUCHSCREEN_ELO=y
> CONFIG_TOUCHSCREEN_WACOM_W8001=y
> CONFIG_TOUCHSCREEN_WACOM_I2C=y
> # CONFIG_TOUCHSCREEN_MAX11801 is not set
> # CONFIG_TOUCHSCREEN_MMS114 is not set
> # CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
> # CONFIG_TOUCHSCREEN_MSG2638 is not set
> # CONFIG_TOUCHSCREEN_MTOUCH is not set
> # CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS is not set
> # CONFIG_TOUCHSCREEN_IMAGIS is not set
> # CONFIG_TOUCHSCREEN_INEXIO is not set
> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
> # CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> # CONFIG_TOUCHSCREEN_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
> # CONFIG_TOUCHSCREEN_WM97XX is not set
> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
> # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
> # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> # CONFIG_TOUCHSCREEN_TSC2004 is not set
> # CONFIG_TOUCHSCREEN_TSC2005 is not set
> # CONFIG_TOUCHSCREEN_TSC2007 is not set
> # CONFIG_TOUCHSCREEN_RM_TS is not set
> # CONFIG_TOUCHSCREEN_SILEAD is not set
> # CONFIG_TOUCHSCREEN_SIS_I2C is not set
> # CONFIG_TOUCHSCREEN_ST1232 is not set
> # CONFIG_TOUCHSCREEN_STMFTS is not set
> # CONFIG_TOUCHSCREEN_SUR40 is not set
> # CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
> # CONFIG_TOUCHSCREEN_SX8654 is not set
> # CONFIG_TOUCHSCREEN_TPS6507X is not set
> # CONFIG_TOUCHSCREEN_ZET6223 is not set
> # CONFIG_TOUCHSCREEN_ZFORCE is not set
> # CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
> # CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
> # CONFIG_TOUCHSCREEN_IQS5XX is not set
> # CONFIG_TOUCHSCREEN_IQS7211 is not set
> # CONFIG_TOUCHSCREEN_ZINITIX is not set
> # CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set
> CONFIG_INPUT_MISC=y
> # CONFIG_INPUT_AD714X is not set
> # CONFIG_INPUT_BMA150 is not set
> # CONFIG_INPUT_E3X0_BUTTON is not set
> CONFIG_INPUT_PCSPKR=y
> # CONFIG_INPUT_MMA8450 is not set
> CONFIG_INPUT_APANEL=y
> # CONFIG_INPUT_GPIO_BEEPER is not set
> # CONFIG_INPUT_GPIO_DECODER is not set
> # CONFIG_INPUT_GPIO_VIBRA is not set
> CONFIG_INPUT_ATLAS_BTNS=y
> CONFIG_INPUT_ATI_REMOTE2=y
> CONFIG_INPUT_KEYSPAN_REMOTE=y
> # CONFIG_INPUT_KXTJ9 is not set
> CONFIG_INPUT_POWERMATE=y
> CONFIG_INPUT_YEALINK=y
> CONFIG_INPUT_CM109=y
> CONFIG_INPUT_UINPUT=y
> # CONFIG_INPUT_PCF8574 is not set
> # CONFIG_INPUT_PWM_BEEPER is not set
> # CONFIG_INPUT_PWM_VIBRA is not set
> CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
> # CONFIG_INPUT_DA7280_HAPTICS is not set
> # CONFIG_INPUT_ADXL34X is not set
> # CONFIG_INPUT_IMS_PCU is not set
> # CONFIG_INPUT_IQS269A is not set
> # CONFIG_INPUT_IQS626A is not set
> # CONFIG_INPUT_IQS7222 is not set
> # CONFIG_INPUT_CMA3000 is not set
> CONFIG_INPUT_XEN_KBDDEV_FRONTEND=y
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
> CONFIG_RMI4_CORE=y
> CONFIG_RMI4_I2C=y
> CONFIG_RMI4_SPI=y
> CONFIG_RMI4_SMB=y
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> CONFIG_RMI4_F12=y
> CONFIG_RMI4_F30=y
> CONFIG_RMI4_F34=y
> CONFIG_RMI4_F3A=y
> # CONFIG_RMI4_F54 is not set
> CONFIG_RMI4_F55=y
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=y
> CONFIG_SERIO_ALTERA_PS2=y
> # CONFIG_SERIO_PS2MULT is not set
> CONFIG_SERIO_ARC_PS2=y
> CONFIG_HYPERV_KEYBOARD=y
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_VT_CONSOLE_SLEEP=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_LEGACY_TIOCSTI=y
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCILIB=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_NR_UARTS=32
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> # CONFIG_SERIAL_8250_PCI1XXXX is not set
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_RSA=y
> CONFIG_SERIAL_8250_DWLIB=y
> CONFIG_SERIAL_8250_DW=y
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> CONFIG_SERIAL_8250_PERICOM=y
> # CONFIG_SERIAL_8250_NI is not set
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> # CONFIG_SERIAL_MAX310X is not set
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_CONSOLE_POLL=y
> CONFIG_SERIAL_JSM=y
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> CONFIG_SERIAL_ARC=y
> # CONFIG_SERIAL_ARC_CONSOLE is not set
> CONFIG_SERIAL_ARC_NR_PORTS=1
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> CONFIG_SERIAL_NONSTANDARD=y
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> CONFIG_N_HDLC=y
> CONFIG_N_GSM=y
> CONFIG_NOZOMI=y
> # CONFIG_NULL_TTY is not set
> CONFIG_HVC_DRIVER=y
> CONFIG_HVC_IRQ=y
> CONFIG_HVC_XEN=y
> CONFIG_HVC_XEN_FRONTEND=y
> # CONFIG_SERIAL_DEV_BUS is not set
> CONFIG_PRINTER=y
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=y
> CONFIG_VIRTIO_CONSOLE=y
> CONFIG_IPMI_HANDLER=y
> CONFIG_IPMI_DMI_DECODE=y
> CONFIG_IPMI_PLAT_DATA=y
> CONFIG_IPMI_PANIC_EVENT=y
> CONFIG_IPMI_PANIC_STRING=y
> CONFIG_IPMI_DEVICE_INTERFACE=y
> CONFIG_IPMI_SI=y
> CONFIG_IPMI_SSIF=y
> CONFIG_IPMI_WATCHDOG=y
> CONFIG_IPMI_POWEROFF=y
> CONFIG_HW_RANDOM=y
> CONFIG_HW_RANDOM_TIMERIOMEM=y
> CONFIG_HW_RANDOM_INTEL=y
> CONFIG_HW_RANDOM_AMD=y
> # CONFIG_HW_RANDOM_BA431 is not set
> CONFIG_HW_RANDOM_VIA=y
> CONFIG_HW_RANDOM_VIRTIO=y
> # CONFIG_HW_RANDOM_XIPHERA is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_MWAVE is not set
> CONFIG_DEVMEM=y
> CONFIG_NVRAM=y
> CONFIG_DEVPORT=y
> CONFIG_HPET=y
> CONFIG_HPET_MMAP=y
> # CONFIG_HPET_MMAP_DEFAULT is not set
> CONFIG_HANGCHECK_TIMER=y
> CONFIG_UV_MMTIMER=y
> CONFIG_TCG_TPM=y
> CONFIG_TCG_TPM2_HMAC=y
> CONFIG_HW_RANDOM_TPM=y
> CONFIG_TCG_TIS_CORE=y
> CONFIG_TCG_TIS=y
> CONFIG_TCG_TIS_SPI=y
> # CONFIG_TCG_TIS_SPI_CR50 is not set
> # CONFIG_TCG_TIS_I2C is not set
> # CONFIG_TCG_TIS_I2C_CR50 is not set
> CONFIG_TCG_TIS_I2C_ATMEL=y
> CONFIG_TCG_TIS_I2C_INFINEON=y
> CONFIG_TCG_TIS_I2C_NUVOTON=y
> CONFIG_TCG_NSC=y
> CONFIG_TCG_ATMEL=y
> CONFIG_TCG_INFINEON=y
> # CONFIG_TCG_XEN is not set
> CONFIG_TCG_CRB=y
> # CONFIG_TCG_VTPM_PROXY is not set
> CONFIG_TCG_TIS_ST33ZP24=y
> CONFIG_TCG_TIS_ST33ZP24_I2C=y
> CONFIG_TCG_TIS_ST33ZP24_SPI=y
> CONFIG_TELCLOCK=y
> # CONFIG_XILLYBUS is not set
> # CONFIG_XILLYUSB is not set
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_CHARDEV=y
> CONFIG_I2C_MUX=y
> 
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_MUX_GPIO is not set
> # CONFIG_I2C_MUX_LTC4306 is not set
> # CONFIG_I2C_MUX_PCA9541 is not set
> # CONFIG_I2C_MUX_PCA954x is not set
> # CONFIG_I2C_MUX_REG is not set
> CONFIG_I2C_MUX_MLXCPLD=y
> # end of Multiplexer I2C Chip support
> 
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=y
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCA=y
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> CONFIG_I2C_AMD756=y
> CONFIG_I2C_AMD8111=y
> # CONFIG_I2C_AMD_MP2 is not set
> # CONFIG_I2C_AMD_ASF is not set
> CONFIG_I2C_I801=y
> CONFIG_I2C_ISCH=y
> CONFIG_I2C_ISMT=y
> CONFIG_I2C_PIIX4=y
> CONFIG_I2C_NFORCE2=y
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> CONFIG_I2C_SIS96X=y
> CONFIG_I2C_VIA=y
> CONFIG_I2C_VIAPRO=y
> CONFIG_I2C_ZHAOXIN=y
> 
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=y
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=y
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> # CONFIG_I2C_DESIGNWARE_AMDPSP is not set
> CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_PCA_PLATFORM=y
> CONFIG_I2C_SIMTEC=y
> # CONFIG_I2C_XILINX is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_DIOLAN_U2C=y
> # CONFIG_I2C_CP2615 is not set
> CONFIG_I2C_PARPORT=y
> # CONFIG_I2C_PCI1XXXX is not set
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> # CONFIG_I2C_TAOS_EVM is not set
> CONFIG_I2C_TINY_USB=y
> CONFIG_I2C_VIPERBOARD=y
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_MLXCPLD=y
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
> 
> CONFIG_I2C_STUB=m
> # CONFIG_I2C_SLAVE is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> # CONFIG_I3C is not set
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> CONFIG_SPI_MEM=y
> 
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> # CONFIG_SPI_BITBANG is not set
> # CONFIG_SPI_BUTTERFLY is not set
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_CH341 is not set
> # CONFIG_SPI_DESIGNWARE is not set
> # CONFIG_SPI_GPIO is not set
> # CONFIG_SPI_INTEL_PCI is not set
> # CONFIG_SPI_INTEL_PLATFORM is not set
> # CONFIG_SPI_LM70_LLP is not set
> # CONFIG_SPI_MICROCHIP_CORE is not set
> # CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
> # CONFIG_SPI_LANTIQ_SSC is not set
> # CONFIG_SPI_OC_TINY is not set
> # CONFIG_SPI_PCI1XXXX is not set
> # CONFIG_SPI_PXA2XX is not set
> # CONFIG_SPI_SC18IS602 is not set
> # CONFIG_SPI_SIFIVE is not set
> # CONFIG_SPI_MXIC is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
> # CONFIG_SPI_ZYNQMP_GQSPI is not set
> # CONFIG_SPI_AMD is not set
> 
> #
> # SPI Multiplexer support
> #
> # CONFIG_SPI_MUX is not set
> 
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> # CONFIG_SPI_TLE62X0 is not set
> # CONFIG_SPI_SLAVE is not set
> CONFIG_SPI_DYNAMIC=y
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> CONFIG_PPS_CLIENT_LDISC=y
> CONFIG_PPS_CLIENT_PARPORT=y
> CONFIG_PPS_CLIENT_GPIO=y
> # CONFIG_PPS_GENERATOR is not set
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> CONFIG_DP83640_PHY=y
> # CONFIG_PTP_1588_CLOCK_INES is not set
> CONFIG_PTP_1588_CLOCK_KVM=y
> CONFIG_PTP_1588_CLOCK_VMCLOCK=y
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> # CONFIG_PTP_1588_CLOCK_FC3W is not set
> # CONFIG_PTP_1588_CLOCK_MOCK is not set
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # CONFIG_PTP_1588_CLOCK_OCP is not set
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_PINMUX=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> # CONFIG_DEBUG_PINCTRL is not set
> # CONFIG_PINCTRL_AMD is not set
> # CONFIG_PINCTRL_CY8C95X0 is not set
> # CONFIG_PINCTRL_MCP23S08 is not set
> # CONFIG_PINCTRL_SX150X is not set
> 
> #
> # Intel pinctrl drivers
> #
> CONFIG_PINCTRL_BAYTRAIL=y
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> # CONFIG_PINCTRL_LYNXPOINT is not set
> CONFIG_PINCTRL_INTEL=y
> # CONFIG_PINCTRL_INTEL_PLATFORM is not set
> # CONFIG_PINCTRL_ALDERLAKE is not set
> CONFIG_PINCTRL_BROXTON=y
> CONFIG_PINCTRL_CANNONLAKE=y
> CONFIG_PINCTRL_CEDARFORK=y
> CONFIG_PINCTRL_DENVERTON=y
> # CONFIG_PINCTRL_ELKHARTLAKE is not set
> CONFIG_PINCTRL_EMMITSBURG=y
> CONFIG_PINCTRL_GEMINILAKE=y
> CONFIG_PINCTRL_ICELAKE=y
> # CONFIG_PINCTRL_JASPERLAKE is not set
> # CONFIG_PINCTRL_LAKEFIELD is not set
> CONFIG_PINCTRL_LEWISBURG=y
> # CONFIG_PINCTRL_METEORLAKE is not set
> # CONFIG_PINCTRL_METEORPOINT is not set
> CONFIG_PINCTRL_SUNRISEPOINT=y
> # CONFIG_PINCTRL_TIGERLAKE is not set
> # end of Intel pinctrl drivers
> 
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
> 
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_CDEV=y
> CONFIG_GPIO_CDEV_V1=y
> CONFIG_GPIO_GENERIC=y
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_ALTERA is not set
> CONFIG_GPIO_AMDPT=y
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> # CONFIG_GPIO_GRANITERAPIDS is not set
> CONFIG_GPIO_ICH=y
> # CONFIG_GPIO_MB86S7X is not set
> # CONFIG_GPIO_POLARFIRE_SOC is not set
> # CONFIG_GPIO_XILINX is not set
> # CONFIG_GPIO_AMD_FCH is not set
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_IT87 is not set
> # CONFIG_GPIO_SCH is not set
> # CONFIG_GPIO_SCH311X is not set
> # CONFIG_GPIO_WINBOND is not set
> # CONFIG_GPIO_WS16C48 is not set
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_FXL6408 is not set
> # CONFIG_GPIO_DS4520 is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCA9570 is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> # CONFIG_GPIO_ELKHARTLAKE is not set
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # end of PCI GPIO expanders
> 
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_74X164 is not set
> # CONFIG_GPIO_MAX3191X is not set
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_PISOSR is not set
> # CONFIG_GPIO_XRA1403 is not set
> # end of SPI GPIO expanders
> 
> #
> # USB GPIO expanders
> #
> CONFIG_GPIO_VIPERBOARD=y
> # CONFIG_GPIO_MPSSE is not set
> # end of USB GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_LATCH is not set
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_GPIO_VIRTIO is not set
> # CONFIG_GPIO_SIM is not set
> # end of Virtual GPIO drivers
> 
> #
> # GPIO Debugging utilities
> #
> # CONFIG_GPIO_VIRTUSER is not set
> # end of GPIO Debugging utilities
> 
> # CONFIG_W1 is not set
> CONFIG_POWER_RESET=y
> # CONFIG_POWER_RESET_RESTART is not set
> # CONFIG_POWER_SEQUENCING is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=y
> # CONFIG_GENERIC_ADC_BATTERY is not set
> # CONFIG_IP5XXX_POWER is not set
> # CONFIG_TEST_POWER is not set
> # CONFIG_CHARGER_ADP5061 is not set
> # CONFIG_BATTERY_CW2015 is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SAMSUNG_SDI is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_MANAGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_BATTERY_MAX17040 is not set
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_BATTERY_MAX1720X is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_LTC4162L is not set
> # CONFIG_CHARGER_MAX77976 is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> # CONFIG_CHARGER_BQ2515X is not set
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_BQ25980 is not set
> # CONFIG_CHARGER_BQ256XX is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_BATTERY_GOLDFISH is not set
> # CONFIG_BATTERY_RT5033 is not set
> # CONFIG_CHARGER_RT9455 is not set
> # CONFIG_FUEL_GAUGE_STC3117 is not set
> # CONFIG_CHARGER_BD99954 is not set
> # CONFIG_BATTERY_UG3105 is not set
> # CONFIG_FUEL_GAUGE_MM8013 is not set
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=y
> CONFIG_SENSORS_ABITUGURU3=y
> # CONFIG_SENSORS_AD7314 is not set
> CONFIG_SENSORS_AD7414=y
> CONFIG_SENSORS_AD7418=y
> CONFIG_SENSORS_ADM1025=y
> CONFIG_SENSORS_ADM1026=y
> CONFIG_SENSORS_ADM1029=y
> CONFIG_SENSORS_ADM1031=y
> # CONFIG_SENSORS_ADM1177 is not set
> CONFIG_SENSORS_ADM9240=y
> CONFIG_SENSORS_ADT7X10=y
> # CONFIG_SENSORS_ADT7310 is not set
> CONFIG_SENSORS_ADT7410=y
> CONFIG_SENSORS_ADT7411=y
> CONFIG_SENSORS_ADT7462=y
> CONFIG_SENSORS_ADT7470=y
> CONFIG_SENSORS_ADT7475=y
> # CONFIG_SENSORS_AHT10 is not set
> # CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
> # CONFIG_SENSORS_AS370 is not set
> CONFIG_SENSORS_ASC7621=y
> # CONFIG_SENSORS_ASUS_ROG_RYUJIN is not set
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> CONFIG_SENSORS_K8TEMP=y
> CONFIG_SENSORS_K10TEMP=y
> CONFIG_SENSORS_FAM15H_POWER=y
> CONFIG_SENSORS_APPLESMC=y
> CONFIG_SENSORS_ASB100=y
> CONFIG_SENSORS_ATXP1=y
> # CONFIG_SENSORS_CHIPCAP2 is not set
> # CONFIG_SENSORS_CORSAIR_CPRO is not set
> # CONFIG_SENSORS_CORSAIR_PSU is not set
> # CONFIG_SENSORS_DRIVETEMP is not set
> CONFIG_SENSORS_DS620=y
> CONFIG_SENSORS_DS1621=y
> CONFIG_SENSORS_DELL_SMM=y
> # CONFIG_I8K is not set
> CONFIG_SENSORS_I5K_AMB=y
> CONFIG_SENSORS_F71805F=y
> CONFIG_SENSORS_F71882FG=y
> CONFIG_SENSORS_F75375S=y
> CONFIG_SENSORS_FSCHMD=y
> # CONFIG_SENSORS_FTSTEUTATES is not set
> # CONFIG_SENSORS_GIGABYTE_WATERFORCE is not set
> CONFIG_SENSORS_GL518SM=y
> CONFIG_SENSORS_GL520SM=y
> CONFIG_SENSORS_G760A=y
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_HIH6130 is not set
> # CONFIG_SENSORS_HS3001 is not set
> # CONFIG_SENSORS_HTU31 is not set
> CONFIG_SENSORS_IBMAEM=y
> CONFIG_SENSORS_IBMPEX=y
> # CONFIG_SENSORS_IIO_HWMON is not set
> CONFIG_SENSORS_I5500=y
> CONFIG_SENSORS_CORETEMP=y
> # CONFIG_SENSORS_ISL28022 is not set
> CONFIG_SENSORS_IT87=y
> CONFIG_SENSORS_JC42=y
> # CONFIG_SENSORS_POWERZ is not set
> # CONFIG_SENSORS_POWR1220 is not set
> # CONFIG_SENSORS_LENOVO_EC is not set
> CONFIG_SENSORS_LINEAGE=y
> # CONFIG_SENSORS_LTC2945 is not set
> # CONFIG_SENSORS_LTC2947_I2C is not set
> # CONFIG_SENSORS_LTC2947_SPI is not set
> # CONFIG_SENSORS_LTC2990 is not set
> # CONFIG_SENSORS_LTC2991 is not set
> # CONFIG_SENSORS_LTC2992 is not set
> CONFIG_SENSORS_LTC4151=y
> CONFIG_SENSORS_LTC4215=y
> # CONFIG_SENSORS_LTC4222 is not set
> CONFIG_SENSORS_LTC4245=y
> # CONFIG_SENSORS_LTC4260 is not set
> CONFIG_SENSORS_LTC4261=y
> # CONFIG_SENSORS_LTC4282 is not set
> # CONFIG_SENSORS_MAX1111 is not set
> # CONFIG_SENSORS_MAX127 is not set
> CONFIG_SENSORS_MAX16065=y
> CONFIG_SENSORS_MAX1619=y
> CONFIG_SENSORS_MAX1668=y
> CONFIG_SENSORS_MAX197=y
> # CONFIG_SENSORS_MAX31722 is not set
> # CONFIG_SENSORS_MAX31730 is not set
> # CONFIG_SENSORS_MAX31760 is not set
> # CONFIG_MAX31827 is not set
> # CONFIG_SENSORS_MAX6620 is not set
> # CONFIG_SENSORS_MAX6621 is not set
> CONFIG_SENSORS_MAX6639=y
> CONFIG_SENSORS_MAX6650=y
> CONFIG_SENSORS_MAX6697=y
> # CONFIG_SENSORS_MAX31790 is not set
> # CONFIG_SENSORS_MC34VR500 is not set
> CONFIG_SENSORS_MCP3021=y
> # CONFIG_SENSORS_MLXREG_FAN is not set
> # CONFIG_SENSORS_TC654 is not set
> # CONFIG_SENSORS_TPS23861 is not set
> # CONFIG_SENSORS_MR75203 is not set
> # CONFIG_SENSORS_ADCXX is not set
> CONFIG_SENSORS_LM63=y
> # CONFIG_SENSORS_LM70 is not set
> CONFIG_SENSORS_LM73=y
> CONFIG_SENSORS_LM75=y
> CONFIG_SENSORS_LM77=y
> CONFIG_SENSORS_LM78=y
> CONFIG_SENSORS_LM80=y
> CONFIG_SENSORS_LM83=y
> CONFIG_SENSORS_LM85=y
> CONFIG_SENSORS_LM87=y
> CONFIG_SENSORS_LM90=y
> CONFIG_SENSORS_LM92=y
> CONFIG_SENSORS_LM93=y
> CONFIG_SENSORS_LM95234=y
> CONFIG_SENSORS_LM95241=y
> CONFIG_SENSORS_LM95245=y
> CONFIG_SENSORS_PC87360=y
> CONFIG_SENSORS_PC87427=y
> CONFIG_SENSORS_NTC_THERMISTOR=y
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775_CORE=y
> CONFIG_SENSORS_NCT6775=y
> # CONFIG_SENSORS_NCT6775_I2C is not set
> # CONFIG_SENSORS_NCT7363 is not set
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_NZXT_KRAKEN2 is not set
> # CONFIG_SENSORS_NZXT_KRAKEN3 is not set
> # CONFIG_SENSORS_NZXT_SMART2 is not set
> # CONFIG_SENSORS_OCC_P8_I2C is not set
> # CONFIG_SENSORS_OXP is not set
> CONFIG_SENSORS_PCF8591=y
> CONFIG_PMBUS=y
> CONFIG_SENSORS_PMBUS=y
> # CONFIG_SENSORS_ACBEL_FSG032 is not set
> # CONFIG_SENSORS_ADM1266 is not set
> CONFIG_SENSORS_ADM1275=y
> # CONFIG_SENSORS_ADP1050 is not set
> # CONFIG_SENSORS_BEL_PFE is not set
> # CONFIG_SENSORS_BPA_RS600 is not set
> # CONFIG_SENSORS_CRPS is not set
> # CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
> # CONFIG_SENSORS_FSP_3Y is not set
> # CONFIG_SENSORS_IBM_CFFPS is not set
> # CONFIG_SENSORS_DPS920AB is not set
> # CONFIG_SENSORS_INA233 is not set
> # CONFIG_SENSORS_INSPUR_IPSPS is not set
> # CONFIG_SENSORS_IR35221 is not set
> # CONFIG_SENSORS_IR36021 is not set
> # CONFIG_SENSORS_IR38064 is not set
> # CONFIG_SENSORS_IRPS5401 is not set
> # CONFIG_SENSORS_ISL68137 is not set
> CONFIG_SENSORS_LM25066=y
> # CONFIG_SENSORS_LT7182S is not set
> CONFIG_SENSORS_LTC2978=y
> # CONFIG_SENSORS_LTC3815 is not set
> # CONFIG_SENSORS_LTC4286 is not set
> # CONFIG_SENSORS_MAX15301 is not set
> CONFIG_SENSORS_MAX16064=y
> # CONFIG_SENSORS_MAX16601 is not set
> # CONFIG_SENSORS_MAX20730 is not set
> # CONFIG_SENSORS_MAX20751 is not set
> # CONFIG_SENSORS_MAX31785 is not set
> CONFIG_SENSORS_MAX34440=y
> CONFIG_SENSORS_MAX8688=y
> # CONFIG_SENSORS_MP2856 is not set
> # CONFIG_SENSORS_MP2888 is not set
> # CONFIG_SENSORS_MP2891 is not set
> # CONFIG_SENSORS_MP2975 is not set
> # CONFIG_SENSORS_MP2993 is not set
> # CONFIG_SENSORS_MP5023 is not set
> # CONFIG_SENSORS_MP5920 is not set
> # CONFIG_SENSORS_MP5990 is not set
> # CONFIG_SENSORS_MP9941 is not set
> # CONFIG_SENSORS_MPQ7932 is not set
> # CONFIG_SENSORS_MPQ8785 is not set
> # CONFIG_SENSORS_PIM4328 is not set
> # CONFIG_SENSORS_PLI1209BC is not set
> # CONFIG_SENSORS_PM6764TR is not set
> # CONFIG_SENSORS_PXE1610 is not set
> # CONFIG_SENSORS_Q54SJ108A2 is not set
> # CONFIG_SENSORS_STPDDC60 is not set
> # CONFIG_SENSORS_TDA38640 is not set
> # CONFIG_SENSORS_TPS25990 is not set
> # CONFIG_SENSORS_TPS40422 is not set
> # CONFIG_SENSORS_TPS53679 is not set
> # CONFIG_SENSORS_TPS546D24 is not set
> CONFIG_SENSORS_UCD9000=y
> CONFIG_SENSORS_UCD9200=y
> # CONFIG_SENSORS_XDP710 is not set
> # CONFIG_SENSORS_XDPE152 is not set
> # CONFIG_SENSORS_XDPE122 is not set
> CONFIG_SENSORS_ZL6100=y
> # CONFIG_SENSORS_PT5161L is not set
> # CONFIG_SENSORS_PWM_FAN is not set
> # CONFIG_SENSORS_SBTSI is not set
> # CONFIG_SENSORS_SBRMI is not set
> CONFIG_SENSORS_SHT15=y
> CONFIG_SENSORS_SHT21=y
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHT4x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> CONFIG_SENSORS_SIS5595=y
> CONFIG_SENSORS_DME1737=y
> CONFIG_SENSORS_EMC1403=y
> # CONFIG_SENSORS_EMC2103 is not set
> # CONFIG_SENSORS_EMC2305 is not set
> CONFIG_SENSORS_EMC6W201=y
> CONFIG_SENSORS_SMSC47M1=y
> CONFIG_SENSORS_SMSC47M192=y
> CONFIG_SENSORS_SMSC47B397=y
> CONFIG_SENSORS_SCH56XX_COMMON=y
> CONFIG_SENSORS_SCH5627=y
> CONFIG_SENSORS_SCH5636=y
> # CONFIG_SENSORS_STTS751 is not set
> # CONFIG_SENSORS_ADC128D818 is not set
> CONFIG_SENSORS_ADS7828=y
> # CONFIG_SENSORS_ADS7871 is not set
> CONFIG_SENSORS_AMC6821=y
> CONFIG_SENSORS_INA209=y
> CONFIG_SENSORS_INA2XX=y
> # CONFIG_SENSORS_INA238 is not set
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_SPD5118 is not set
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=y
> CONFIG_SENSORS_TMP102=y
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP108 is not set
> CONFIG_SENSORS_TMP401=y
> CONFIG_SENSORS_TMP421=y
> # CONFIG_SENSORS_TMP464 is not set
> # CONFIG_SENSORS_TMP513 is not set
> CONFIG_SENSORS_VIA_CPUTEMP=y
> CONFIG_SENSORS_VIA686A=y
> CONFIG_SENSORS_VT1211=y
> CONFIG_SENSORS_VT8231=y
> # CONFIG_SENSORS_W83773G is not set
> CONFIG_SENSORS_W83781D=y
> CONFIG_SENSORS_W83791D=y
> CONFIG_SENSORS_W83792D=y
> CONFIG_SENSORS_W83793=y
> CONFIG_SENSORS_W83795=y
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=y
> CONFIG_SENSORS_W83L786NG=y
> CONFIG_SENSORS_W83627HF=y
> CONFIG_SENSORS_W83627EHF=y
> # CONFIG_SENSORS_XGENE is not set
> 
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=y
> CONFIG_SENSORS_ATK0110=y
> # CONFIG_SENSORS_ASUS_WMI is not set
> # CONFIG_SENSORS_ASUS_EC is not set
> # CONFIG_SENSORS_HP_WMI is not set
> CONFIG_THERMAL=y
> CONFIG_THERMAL_NETLINK=y
> # CONFIG_THERMAL_STATISTICS is not set
> # CONFIG_THERMAL_DEBUGFS is not set
> # CONFIG_THERMAL_CORE_TESTING is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_BANG_BANG is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> CONFIG_THERMAL_GOV_USER_SPACE=y
> # CONFIG_PCIE_THERMAL is not set
> CONFIG_THERMAL_EMULATION=y
> 
> #
> # Intel thermal drivers
> #
> CONFIG_INTEL_POWERCLAMP=y
> CONFIG_X86_THERMAL_VECTOR=y
> CONFIG_INTEL_TCC=y
> CONFIG_X86_PKG_TEMP_THERMAL=y
> CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> CONFIG_INT340X_THERMAL=y
> CONFIG_ACPI_THERMAL_REL=y
> # CONFIG_INT3406_THERMAL is not set
> CONFIG_PROC_THERMAL_MMIO_RAPL=y
> # end of ACPI INT340X thermal drivers
> 
> CONFIG_INTEL_PCH_THERMAL=y
> # CONFIG_INTEL_TCC_COOLING is not set
> CONFIG_INTEL_HFI_THERMAL=y
> # end of Intel thermal drivers
> 
> # CONFIG_GENERIC_ADC_THERMAL is not set
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
> CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> CONFIG_WATCHDOG_SYSFS=y
> # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
> 
> #
> # Watchdog Pretimeout Governors
> #
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> 
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=y
> # CONFIG_LENOVO_SE10_WDT is not set
> # CONFIG_LENOVO_SE30_WDT is not set
> CONFIG_WDAT_WDT=y
> # CONFIG_XILINX_WATCHDOG is not set
> # CONFIG_ZIIRAVE_WATCHDOG is not set
> # CONFIG_MLX_WDT is not set
> # CONFIG_CADENCE_WATCHDOG is not set
> # CONFIG_DW_WATCHDOG is not set
> # CONFIG_MAX63XX_WATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_ADVANTECH_EC_WDT is not set
> CONFIG_ALIM1535_WDT=y
> CONFIG_ALIM7101_WDT=y
> # CONFIG_EBC_C384_WDT is not set
> # CONFIG_EXAR_WDT is not set
> CONFIG_F71808E_WDT=y
> CONFIG_SP5100_TCO=y
> CONFIG_SBC_FITPC2_WATCHDOG=y
> # CONFIG_EUROTECH_WDT is not set
> CONFIG_IB700_WDT=y
> CONFIG_IBMASR=y
> # CONFIG_WAFER_WDT is not set
> CONFIG_I6300ESB_WDT=y
> CONFIG_IE6XX_WDT=y
> CONFIG_ITCO_WDT=y
> CONFIG_ITCO_VENDOR_SUPPORT=y
> CONFIG_IT8712F_WDT=y
> CONFIG_IT87_WDT=y
> CONFIG_HP_WATCHDOG=y
> CONFIG_HPWDT_NMI_DECODING=y
> # CONFIG_SC1200_WDT is not set
> # CONFIG_PC87413_WDT is not set
> CONFIG_NV_TCO=y
> # CONFIG_60XX_WDT is not set
> CONFIG_SMSC_SCH311X_WDT=y
> # CONFIG_SMSC37B787_WDT is not set
> # CONFIG_TQMX86_WDT is not set
> CONFIG_VIA_WDT=y
> CONFIG_W83627HF_WDT=y
> CONFIG_W83877F_WDT=y
> CONFIG_W83977F_WDT=y
> CONFIG_MACHZ_WDT=y
> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> CONFIG_INTEL_MEI_WDT=y
> # CONFIG_NI903X_WDT is not set
> # CONFIG_NIC7018_WDT is not set
> # CONFIG_MEN_A21_WDT is not set
> CONFIG_XEN_WDT=y
> 
> #
> # PCI-based Watchdog Cards
> #
> CONFIG_PCIPCWATCHDOG=y
> CONFIG_WDTPCI=y
> 
> #
> # USB-based Watchdog Cards
> #
> CONFIG_USBPCWATCHDOG=y
> CONFIG_SSB_POSSIBLE=y
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=y
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> CONFIG_BCMA_HOST_PCI=y
> # CONFIG_BCMA_HOST_SOC is not set
> CONFIG_BCMA_DRIVER_PCI=y
> CONFIG_BCMA_DRIVER_GMAC_CMN=y
> CONFIG_BCMA_DRIVER_GPIO=y
> # CONFIG_BCMA_DEBUG is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_MFD_SMPRO is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> # CONFIG_MFD_CGBC is not set
> # CONFIG_MFD_CS42L43_I2C is not set
> # CONFIG_MFD_MADERA is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_MFD_MP2629 is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> CONFIG_LPC_ICH=y
> CONFIG_LPC_SCH=y
> # CONFIG_INTEL_SOC_PMIC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> CONFIG_MFD_INTEL_LPSS=y
> CONFIG_MFD_INTEL_LPSS_ACPI=y
> CONFIG_MFD_INTEL_LPSS_PCI=y
> # CONFIG_MFD_INTEL_PMC_BXT is not set
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77541 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77705 is not set
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> # CONFIG_MFD_MT6360 is not set
> # CONFIG_MFD_MT6370 is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_MFD_OCELOT is not set
> # CONFIG_EZX_PCAP is not set
> CONFIG_MFD_VIPERBOARD=y
> # CONFIG_MFD_RETU is not set
> # CONFIG_MFD_SY7636A is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT4831 is not set
> # CONFIG_MFD_RT5033 is not set
> # CONFIG_MFD_RT5120 is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_SI476X_CORE is not set
> CONFIG_MFD_SM501=y
> CONFIG_MFD_SM501_GPIO=y
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TI_LP873X is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS65912_SPI is not set
> # CONFIG_MFD_TPS6594_I2C is not set
> # CONFIG_MFD_TPS6594_SPI is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_WL1273_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TQMX86 is not set
> CONFIG_MFD_VX855=y
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_MFD_ATC260X_I2C is not set
> # CONFIG_MFD_CS40L50_I2C is not set
> # CONFIG_MFD_CS40L50_SPI is not set
> # CONFIG_MFD_INTEL_M10_BMC_SPI is not set
> # CONFIG_MFD_UPBOARD_FPGA is not set
> # end of Multifunction device drivers
> 
> # CONFIG_REGULATOR is not set
> CONFIG_RC_CORE=y
> # CONFIG_BPF_LIRC_MODE2 is not set
> CONFIG_LIRC=y
> CONFIG_RC_MAP=y
> CONFIG_RC_DECODERS=y
> CONFIG_IR_IMON_DECODER=y
> CONFIG_IR_JVC_DECODER=y
> CONFIG_IR_MCE_KBD_DECODER=y
> CONFIG_IR_NEC_DECODER=y
> CONFIG_IR_RC5_DECODER=y
> CONFIG_IR_RC6_DECODER=y
> # CONFIG_IR_RCMM_DECODER is not set
> CONFIG_IR_SANYO_DECODER=y
> # CONFIG_IR_SHARP_DECODER is not set
> CONFIG_IR_SONY_DECODER=y
> # CONFIG_IR_XMP_DECODER is not set
> CONFIG_RC_DEVICES=y
> CONFIG_IR_ENE=y
> CONFIG_IR_FINTEK=y
> # CONFIG_IR_IGORPLUGUSB is not set
> CONFIG_IR_IGUANA=y
> CONFIG_IR_IMON=y
> CONFIG_IR_IMON_RAW=y
> CONFIG_IR_ITE_CIR=y
> CONFIG_IR_MCEUSB=y
> CONFIG_IR_NUVOTON=y
> CONFIG_IR_REDRAT3=y
> CONFIG_IR_SERIAL=y
> CONFIG_IR_SERIAL_TRANSMITTER=y
> CONFIG_IR_STREAMZAP=y
> # CONFIG_IR_TOY is not set
> CONFIG_IR_TTUSBIR=y
> CONFIG_IR_WINBOND_CIR=y
> CONFIG_RC_ATI_REMOTE=y
> # CONFIG_RC_LOOPBACK is not set
> # CONFIG_RC_XBOX_DVD is not set
> CONFIG_CEC_CORE=y
> 
> #
> # CEC support
> #
> # CONFIG_MEDIA_CEC_RC is not set
> CONFIG_MEDIA_CEC_SUPPORT=y
> # CONFIG_CEC_CH7322 is not set
> # CONFIG_CEC_NXP_TDA9950 is not set
> # CONFIG_CEC_GPIO is not set
> # CONFIG_CEC_SECO is not set
> # CONFIG_USB_EXTRON_DA_HD_4K_PLUS_CEC is not set
> CONFIG_USB_PULSE8_CEC=y
> CONFIG_USB_RAINSHADOW_CEC=y
> # end of CEC support
> 
> CONFIG_MEDIA_SUPPORT=y
> CONFIG_MEDIA_SUPPORT_FILTER=y
> CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
> 
> #
> # Media device types
> #
> CONFIG_MEDIA_CAMERA_SUPPORT=y
> CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> CONFIG_MEDIA_RADIO_SUPPORT=y
> # CONFIG_MEDIA_SDR_SUPPORT is not set
> CONFIG_MEDIA_PLATFORM_SUPPORT=y
> # CONFIG_MEDIA_TEST_SUPPORT is not set
> # end of Media device types
> 
> CONFIG_VIDEO_DEV=y
> CONFIG_MEDIA_CONTROLLER=y
> CONFIG_DVB_CORE=y
> 
> #
> # Video4Linux options
> #
> CONFIG_VIDEO_V4L2_I2C=y
> CONFIG_VIDEO_V4L2_SUBDEV_API=y
> # CONFIG_VIDEO_ADV_DEBUG is not set
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> CONFIG_VIDEO_TUNER=y
> CONFIG_V4L2_FWNODE=y
> CONFIG_V4L2_ASYNC=y
> # end of Video4Linux options
> 
> #
> # Media controller options
> #
> CONFIG_MEDIA_CONTROLLER_DVB=y
> # end of Media controller options
> 
> #
> # Digital TV options
> #
> # CONFIG_DVB_MMAP is not set
> CONFIG_DVB_NET=y
> CONFIG_DVB_MAX_ADAPTERS=8
> CONFIG_DVB_DYNAMIC_MINORS=y
> # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> # CONFIG_DVB_ULE_DEBUG is not set
> # end of Digital TV options
> 
> #
> # Media drivers
> #
> 
> #
> # Drivers filtered as selected at 'Filter media drivers'
> #
> 
> #
> # Media drivers
> #
> CONFIG_MEDIA_USB_SUPPORT=y
> 
> #
> # Webcam devices
> #
> CONFIG_USB_GSPCA=y
> CONFIG_USB_GSPCA_BENQ=y
> CONFIG_USB_GSPCA_CONEX=y
> CONFIG_USB_GSPCA_CPIA1=y
> # CONFIG_USB_GSPCA_DTCS033 is not set
> CONFIG_USB_GSPCA_ETOMS=y
> CONFIG_USB_GSPCA_FINEPIX=y
> CONFIG_USB_GSPCA_JEILINJ=y
> CONFIG_USB_GSPCA_JL2005BCD=y
> # CONFIG_USB_GSPCA_KINECT is not set
> CONFIG_USB_GSPCA_KONICA=y
> CONFIG_USB_GSPCA_MARS=y
> CONFIG_USB_GSPCA_MR97310A=y
> CONFIG_USB_GSPCA_NW80X=y
> CONFIG_USB_GSPCA_OV519=y
> CONFIG_USB_GSPCA_OV534=y
> CONFIG_USB_GSPCA_OV534_9=y
> CONFIG_USB_GSPCA_PAC207=y
> CONFIG_USB_GSPCA_PAC7302=y
> CONFIG_USB_GSPCA_PAC7311=y
> CONFIG_USB_GSPCA_SE401=y
> CONFIG_USB_GSPCA_SN9C2028=y
> CONFIG_USB_GSPCA_SN9C20X=y
> CONFIG_USB_GSPCA_SONIXB=y
> CONFIG_USB_GSPCA_SONIXJ=y
> CONFIG_USB_GSPCA_SPCA1528=y
> CONFIG_USB_GSPCA_SPCA500=y
> CONFIG_USB_GSPCA_SPCA501=y
> CONFIG_USB_GSPCA_SPCA505=y
> CONFIG_USB_GSPCA_SPCA506=y
> CONFIG_USB_GSPCA_SPCA508=y
> CONFIG_USB_GSPCA_SPCA561=y
> CONFIG_USB_GSPCA_SQ905=y
> CONFIG_USB_GSPCA_SQ905C=y
> CONFIG_USB_GSPCA_SQ930X=y
> CONFIG_USB_GSPCA_STK014=y
> # CONFIG_USB_GSPCA_STK1135 is not set
> CONFIG_USB_GSPCA_STV0680=y
> CONFIG_USB_GSPCA_SUNPLUS=y
> CONFIG_USB_GSPCA_T613=y
> CONFIG_USB_GSPCA_TOPRO=y
> # CONFIG_USB_GSPCA_TOUPTEK is not set
> CONFIG_USB_GSPCA_TV8532=y
> CONFIG_USB_GSPCA_VC032X=y
> CONFIG_USB_GSPCA_VICAM=y
> CONFIG_USB_GSPCA_XIRLINK_CIT=y
> CONFIG_USB_GSPCA_ZC3XX=y
> CONFIG_USB_GL860=y
> CONFIG_USB_M5602=y
> CONFIG_USB_STV06XX=y
> CONFIG_USB_PWC=y
> # CONFIG_USB_PWC_DEBUG is not set
> CONFIG_USB_PWC_INPUT_EVDEV=y
> CONFIG_USB_S2255=y
> # CONFIG_VIDEO_USBTV is not set
> CONFIG_USB_VIDEO_CLASS=y
> CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
> 
> #
> # Analog TV USB devices
> #
> # CONFIG_VIDEO_GO7007 is not set
> CONFIG_VIDEO_HDPVR=y
> CONFIG_VIDEO_PVRUSB2=y
> CONFIG_VIDEO_PVRUSB2_SYSFS=y
> CONFIG_VIDEO_PVRUSB2_DVB=y
> # CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
> # CONFIG_VIDEO_STK1160 is not set
> 
> #
> # Analog/digital TV USB devices
> #
> CONFIG_VIDEO_AU0828=y
> CONFIG_VIDEO_AU0828_V4L2=y
> # CONFIG_VIDEO_AU0828_RC is not set
> CONFIG_VIDEO_CX231XX=y
> CONFIG_VIDEO_CX231XX_RC=y
> CONFIG_VIDEO_CX231XX_ALSA=y
> CONFIG_VIDEO_CX231XX_DVB=y
> 
> #
> # Digital TV USB devices
> #
> # CONFIG_DVB_AS102 is not set
> CONFIG_DVB_B2C2_FLEXCOP_USB=y
> # CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
> CONFIG_DVB_USB_V2=y
> CONFIG_DVB_USB_AF9015=y
> CONFIG_DVB_USB_AF9035=y
> CONFIG_DVB_USB_ANYSEE=y
> CONFIG_DVB_USB_AU6610=y
> CONFIG_DVB_USB_AZ6007=y
> CONFIG_DVB_USB_CE6230=y
> # CONFIG_DVB_USB_DVBSKY is not set
> CONFIG_DVB_USB_EC168=y
> CONFIG_DVB_USB_GL861=y
> CONFIG_DVB_USB_LME2510=y
> CONFIG_DVB_USB_MXL111SF=y
> CONFIG_DVB_USB_RTL28XXU=y
> # CONFIG_DVB_USB_ZD1301 is not set
> CONFIG_DVB_USB=y
> # CONFIG_DVB_USB_DEBUG is not set
> CONFIG_DVB_USB_A800=y
> CONFIG_DVB_USB_AF9005=y
> CONFIG_DVB_USB_AF9005_REMOTE=y
> CONFIG_DVB_USB_AZ6027=y
> CONFIG_DVB_USB_CINERGY_T2=y
> CONFIG_DVB_USB_CXUSB=y
> # CONFIG_DVB_USB_CXUSB_ANALOG is not set
> CONFIG_DVB_USB_DIB0700=y
> CONFIG_DVB_USB_DIB3000MC=y
> CONFIG_DVB_USB_DIBUSB_MB=y
> # CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
> CONFIG_DVB_USB_DIBUSB_MC=y
> CONFIG_DVB_USB_DIGITV=y
> CONFIG_DVB_USB_DTT200U=y
> CONFIG_DVB_USB_DTV5100=y
> CONFIG_DVB_USB_DW2102=y
> CONFIG_DVB_USB_GP8PSK=y
> CONFIG_DVB_USB_M920X=y
> CONFIG_DVB_USB_NOVA_T_USB2=y
> CONFIG_DVB_USB_OPERA1=y
> CONFIG_DVB_USB_PCTV452E=y
> CONFIG_DVB_USB_TECHNISAT_USB2=y
> CONFIG_DVB_USB_TTUSB2=y
> CONFIG_DVB_USB_UMT_010=y
> CONFIG_DVB_USB_VP702X=y
> CONFIG_DVB_USB_VP7045=y
> CONFIG_SMS_USB_DRV=y
> CONFIG_DVB_TTUSB_BUDGET=y
> CONFIG_DVB_TTUSB_DEC=y
> 
> #
> # Webcam, TV (analog/digital) USB devices
> #
> CONFIG_VIDEO_EM28XX=y
> # CONFIG_VIDEO_EM28XX_V4L2 is not set
> CONFIG_VIDEO_EM28XX_ALSA=y
> CONFIG_VIDEO_EM28XX_DVB=y
> CONFIG_VIDEO_EM28XX_RC=y
> CONFIG_MEDIA_PCI_SUPPORT=y
> 
> #
> # Media capture support
> #
> # CONFIG_VIDEO_MGB4 is not set
> # CONFIG_VIDEO_SOLO6X10 is not set
> # CONFIG_VIDEO_TW5864 is not set
> # CONFIG_VIDEO_TW68 is not set
> # CONFIG_VIDEO_TW686X is not set
> # CONFIG_VIDEO_ZORAN is not set
> 
> #
> # Media capture/analog TV support
> #
> # CONFIG_VIDEO_DT3155 is not set
> CONFIG_VIDEO_IVTV=y
> # CONFIG_VIDEO_IVTV_ALSA is not set
> CONFIG_VIDEO_FB_IVTV=y
> # CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
> # CONFIG_VIDEO_HEXIUM_GEMINI is not set
> # CONFIG_VIDEO_HEXIUM_ORION is not set
> # CONFIG_VIDEO_MXB is not set
> 
> #
> # Media capture/analog/hybrid TV support
> #
> CONFIG_VIDEO_BT848=y
> CONFIG_DVB_BT8XX=y
> CONFIG_VIDEO_CX18=y
> # CONFIG_VIDEO_CX18_ALSA is not set
> CONFIG_VIDEO_CX23885=y
> CONFIG_MEDIA_ALTERA_CI=y
> # CONFIG_VIDEO_CX25821 is not set
> CONFIG_VIDEO_CX88=y
> CONFIG_VIDEO_CX88_ALSA=y
> CONFIG_VIDEO_CX88_BLACKBIRD=y
> CONFIG_VIDEO_CX88_DVB=y
> # CONFIG_VIDEO_CX88_ENABLE_VP3054 is not set
> CONFIG_VIDEO_CX88_MPEG=y
> CONFIG_VIDEO_SAA7134=y
> CONFIG_VIDEO_SAA7134_ALSA=y
> CONFIG_VIDEO_SAA7134_RC=y
> CONFIG_VIDEO_SAA7134_DVB=y
> CONFIG_VIDEO_SAA7164=y
> 
> #
> # Media digital TV PCI Adapters
> #
> CONFIG_DVB_B2C2_FLEXCOP_PCI=y
> # CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
> CONFIG_DVB_DDBRIDGE=y
> # CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
> CONFIG_DVB_DM1105=y
> CONFIG_MANTIS_CORE=y
> CONFIG_DVB_MANTIS=y
> CONFIG_DVB_HOPPER=y
> # CONFIG_DVB_NETUP_UNIDVB is not set
> CONFIG_DVB_NGENE=y
> CONFIG_DVB_PLUTO2=y
> CONFIG_DVB_PT1=y
> # CONFIG_DVB_PT3 is not set
> # CONFIG_DVB_SMIPCIE is not set
> CONFIG_DVB_BUDGET_CORE=y
> CONFIG_DVB_BUDGET=y
> CONFIG_DVB_BUDGET_CI=y
> CONFIG_DVB_BUDGET_AV=y
> # CONFIG_VIDEO_IPU3_CIO2 is not set
> # CONFIG_VIDEO_INTEL_IPU6 is not set
> # CONFIG_INTEL_VSC is not set
> # CONFIG_IPU_BRIDGE is not set
> CONFIG_RADIO_ADAPTERS=y
> # CONFIG_RADIO_MAXIRADIO is not set
> # CONFIG_RADIO_SAA7706H is not set
> # CONFIG_RADIO_SHARK is not set
> # CONFIG_RADIO_SHARK2 is not set
> # CONFIG_RADIO_SI4713 is not set
> CONFIG_RADIO_TEA575X=y
> # CONFIG_RADIO_TEA5764 is not set
> # CONFIG_RADIO_TEF6862 is not set
> # CONFIG_RADIO_WL1273 is not set
> # CONFIG_USB_DSBR is not set
> # CONFIG_USB_KEENE is not set
> # CONFIG_USB_MA901 is not set
> # CONFIG_USB_MR800 is not set
> # CONFIG_USB_RAREMONO is not set
> # CONFIG_RADIO_SI470X is not set
> CONFIG_MEDIA_PLATFORM_DRIVERS=y
> # CONFIG_V4L_PLATFORM_DRIVERS is not set
> # CONFIG_DVB_PLATFORM_DRIVERS is not set
> # CONFIG_V4L_MEM2MEM_DRIVERS is not set
> 
> #
> # Allegro DVT media platform drivers
> #
> 
> #
> # Amlogic media platform drivers
> #
> 
> #
> # Amphion drivers
> #
> 
> #
> # Aspeed media platform drivers
> #
> 
> #
> # Atmel media platform drivers
> #
> 
> #
> # Cadence media platform drivers
> #
> # CONFIG_VIDEO_CADENCE_CSI2RX is not set
> # CONFIG_VIDEO_CADENCE_CSI2TX is not set
> 
> #
> # Chips&Media media platform drivers
> #
> 
> #
> # Intel media platform drivers
> #
> 
> #
> # Marvell media platform drivers
> #
> 
> #
> # Mediatek media platform drivers
> #
> 
> #
> # Microchip Technology, Inc. media platform drivers
> #
> 
> #
> # Nuvoton media platform drivers
> #
> 
> #
> # NVidia media platform drivers
> #
> 
> #
> # NXP media platform drivers
> #
> 
> #
> # Qualcomm media platform drivers
> #
> 
> #
> # Raspberry Pi media platform drivers
> #
> # CONFIG_VIDEO_RP1_CFE is not set
> 
> #
> # Renesas media platform drivers
> #
> 
> #
> # Rockchip media platform drivers
> #
> 
> #
> # Samsung media platform drivers
> #
> 
> #
> # STMicroelectronics media platform drivers
> #
> 
> #
> # Sunxi media platform drivers
> #
> 
> #
> # Texas Instruments drivers
> #
> 
> #
> # Verisilicon media platform drivers
> #
> 
> #
> # VIA media platform drivers
> #
> 
> #
> # Xilinx media platform drivers
> #
> 
> #
> # MMC/SDIO DVB adapters
> #
> CONFIG_SMS_SDIO_DRV=y
> 
> #
> # FireWire (IEEE 1394) Adapters
> #
> CONFIG_DVB_FIREDTV=y
> CONFIG_DVB_FIREDTV_INPUT=y
> CONFIG_MEDIA_COMMON_OPTIONS=y
> 
> #
> # common driver options
> #
> CONFIG_CYPRESS_FIRMWARE=y
> CONFIG_TTPCI_EEPROM=y
> CONFIG_UVC_COMMON=y
> CONFIG_VIDEO_CX2341X=y
> CONFIG_VIDEO_TVEEPROM=y
> CONFIG_DVB_B2C2_FLEXCOP=y
> CONFIG_VIDEO_SAA7146=y
> CONFIG_VIDEO_SAA7146_VV=y
> CONFIG_SMS_SIANO_MDTV=y
> CONFIG_SMS_SIANO_RC=y
> # CONFIG_SMS_SIANO_DEBUGFS is not set
> CONFIG_VIDEOBUF2_CORE=y
> CONFIG_VIDEOBUF2_V4L2=y
> CONFIG_VIDEOBUF2_MEMOPS=y
> CONFIG_VIDEOBUF2_VMALLOC=y
> CONFIG_VIDEOBUF2_DMA_SG=y
> CONFIG_VIDEOBUF2_DVB=y
> # end of Media drivers
> 
> CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y
> 
> #
> # Media ancillary drivers
> #
> CONFIG_MEDIA_ATTACH=y
> 
> #
> # IR I2C driver auto-selected by 'Autoselect ancillary drivers'
> #
> CONFIG_VIDEO_IR_I2C=y
> CONFIG_VIDEO_CAMERA_SENSOR=y
> # CONFIG_VIDEO_ALVIUM_CSI2 is not set
> # CONFIG_VIDEO_AR0521 is not set
> # CONFIG_VIDEO_GC0308 is not set
> # CONFIG_VIDEO_GC05A2 is not set
> # CONFIG_VIDEO_GC08A3 is not set
> # CONFIG_VIDEO_GC2145 is not set
> # CONFIG_VIDEO_HI556 is not set
> # CONFIG_VIDEO_HI846 is not set
> # CONFIG_VIDEO_HI847 is not set
> # CONFIG_VIDEO_IMX208 is not set
> # CONFIG_VIDEO_IMX214 is not set
> # CONFIG_VIDEO_IMX219 is not set
> # CONFIG_VIDEO_IMX258 is not set
> # CONFIG_VIDEO_IMX274 is not set
> # CONFIG_VIDEO_IMX283 is not set
> # CONFIG_VIDEO_IMX290 is not set
> # CONFIG_VIDEO_IMX296 is not set
> # CONFIG_VIDEO_IMX319 is not set
> # CONFIG_VIDEO_IMX355 is not set
> # CONFIG_VIDEO_MT9M001 is not set
> # CONFIG_VIDEO_MT9M111 is not set
> # CONFIG_VIDEO_MT9M114 is not set
> # CONFIG_VIDEO_MT9P031 is not set
> # CONFIG_VIDEO_MT9T112 is not set
> # CONFIG_VIDEO_MT9V011 is not set
> # CONFIG_VIDEO_MT9V032 is not set
> # CONFIG_VIDEO_MT9V111 is not set
> # CONFIG_VIDEO_OG01A1B is not set
> # CONFIG_VIDEO_OV01A10 is not set
> # CONFIG_VIDEO_OV02A10 is not set
> # CONFIG_VIDEO_OV08D10 is not set
> # CONFIG_VIDEO_OV08X40 is not set
> # CONFIG_VIDEO_OV13858 is not set
> # CONFIG_VIDEO_OV13B10 is not set
> # CONFIG_VIDEO_OV2640 is not set
> # CONFIG_VIDEO_OV2659 is not set
> # CONFIG_VIDEO_OV2680 is not set
> # CONFIG_VIDEO_OV2685 is not set
> # CONFIG_VIDEO_OV2740 is not set
> # CONFIG_VIDEO_OV4689 is not set
> # CONFIG_VIDEO_OV5647 is not set
> # CONFIG_VIDEO_OV5648 is not set
> # CONFIG_VIDEO_OV5670 is not set
> # CONFIG_VIDEO_OV5675 is not set
> # CONFIG_VIDEO_OV5693 is not set
> # CONFIG_VIDEO_OV5695 is not set
> # CONFIG_VIDEO_OV64A40 is not set
> # CONFIG_VIDEO_OV6650 is not set
> # CONFIG_VIDEO_OV7251 is not set
> # CONFIG_VIDEO_OV7640 is not set
> # CONFIG_VIDEO_OV7670 is not set
> # CONFIG_VIDEO_OV772X is not set
> # CONFIG_VIDEO_OV7740 is not set
> # CONFIG_VIDEO_OV8856 is not set
> # CONFIG_VIDEO_OV8858 is not set
> # CONFIG_VIDEO_OV8865 is not set
> # CONFIG_VIDEO_OV9640 is not set
> # CONFIG_VIDEO_OV9650 is not set
> # CONFIG_VIDEO_OV9734 is not set
> # CONFIG_VIDEO_RDACM20 is not set
> # CONFIG_VIDEO_RDACM21 is not set
> # CONFIG_VIDEO_RJ54N1 is not set
> # CONFIG_VIDEO_S5C73M3 is not set
> # CONFIG_VIDEO_S5K5BAF is not set
> # CONFIG_VIDEO_S5K6A3 is not set
> # CONFIG_VIDEO_CCS is not set
> # CONFIG_VIDEO_ET8EK8 is not set
> 
> #
> # Camera ISPs
> #
> # CONFIG_VIDEO_THP7312 is not set
> # end of Camera ISPs
> 
> #
> # Lens drivers
> #
> # CONFIG_VIDEO_AD5820 is not set
> # CONFIG_VIDEO_AK7375 is not set
> # CONFIG_VIDEO_DW9714 is not set
> # CONFIG_VIDEO_DW9719 is not set
> # CONFIG_VIDEO_DW9768 is not set
> # CONFIG_VIDEO_DW9807_VCM is not set
> # end of Lens drivers
> 
> #
> # Flash devices
> #
> # CONFIG_VIDEO_ADP1653 is not set
> # CONFIG_VIDEO_LM3560 is not set
> # CONFIG_VIDEO_LM3646 is not set
> # end of Flash devices
> 
> #
> # audio, video and radio I2C drivers auto-selected by 'Autoselect ancillary drivers'
> #
> CONFIG_VIDEO_CS3308=y
> CONFIG_VIDEO_CS5345=y
> CONFIG_VIDEO_CS53L32A=y
> CONFIG_VIDEO_MSP3400=y
> CONFIG_VIDEO_TDA7432=y
> CONFIG_VIDEO_TVAUDIO=y
> CONFIG_VIDEO_VP27SMPX=y
> CONFIG_VIDEO_WM8739=y
> CONFIG_VIDEO_WM8775=y
> CONFIG_VIDEO_SAA6588=y
> CONFIG_VIDEO_SAA711X=y
> 
> #
> # Video and audio decoders
> #
> CONFIG_VIDEO_SAA717X=y
> CONFIG_VIDEO_CX25840=y
> CONFIG_VIDEO_SAA7127=y
> CONFIG_VIDEO_UPD64031A=y
> CONFIG_VIDEO_UPD64083=y
> CONFIG_VIDEO_SAA6752HS=y
> CONFIG_VIDEO_M52790=y
> 
> #
> # Video serializers and deserializers
> #
> # end of Video serializers and deserializers
> 
> #
> # SPI I2C drivers auto-selected by 'Autoselect ancillary drivers'
> #
> 
> #
> # Media SPI Adapters
> #
> # CONFIG_CXD2880_SPI_DRV is not set
> # CONFIG_VIDEO_GS1662 is not set
> # end of Media SPI Adapters
> 
> CONFIG_MEDIA_TUNER=y
> 
> #
> # Tuner drivers auto-selected by 'Autoselect ancillary drivers'
> #
> CONFIG_MEDIA_TUNER_E4000=y
> CONFIG_MEDIA_TUNER_FC0011=y
> CONFIG_MEDIA_TUNER_FC0012=y
> CONFIG_MEDIA_TUNER_FC0013=y
> CONFIG_MEDIA_TUNER_FC2580=y
> CONFIG_MEDIA_TUNER_IT913X=y
> CONFIG_MEDIA_TUNER_M88RS6000T=y
> CONFIG_MEDIA_TUNER_MAX2165=y
> CONFIG_MEDIA_TUNER_MC44S803=y
> CONFIG_MEDIA_TUNER_MT2060=y
> CONFIG_MEDIA_TUNER_MT2063=y
> CONFIG_MEDIA_TUNER_MT20XX=y
> CONFIG_MEDIA_TUNER_MT2131=y
> CONFIG_MEDIA_TUNER_MT2266=y
> CONFIG_MEDIA_TUNER_MXL5005S=y
> CONFIG_MEDIA_TUNER_MXL5007T=y
> CONFIG_MEDIA_TUNER_QM1D1B0004=y
> CONFIG_MEDIA_TUNER_QM1D1C0042=y
> CONFIG_MEDIA_TUNER_QT1010=y
> CONFIG_MEDIA_TUNER_R820T=y
> CONFIG_MEDIA_TUNER_SI2157=y
> CONFIG_MEDIA_TUNER_SIMPLE=y
> CONFIG_MEDIA_TUNER_TDA18212=y
> CONFIG_MEDIA_TUNER_TDA18218=y
> CONFIG_MEDIA_TUNER_TDA18250=y
> CONFIG_MEDIA_TUNER_TDA18271=y
> CONFIG_MEDIA_TUNER_TDA827X=y
> CONFIG_MEDIA_TUNER_TDA8290=y
> CONFIG_MEDIA_TUNER_TDA9887=y
> CONFIG_MEDIA_TUNER_TEA5761=y
> CONFIG_MEDIA_TUNER_TEA5767=y
> CONFIG_MEDIA_TUNER_TUA9001=y
> CONFIG_MEDIA_TUNER_XC2028=y
> CONFIG_MEDIA_TUNER_XC4000=y
> CONFIG_MEDIA_TUNER_XC5000=y
> 
> #
> # DVB Frontend drivers auto-selected by 'Autoselect ancillary drivers'
> #
> 
> #
> # Multistandard (satellite) frontends
> #
> CONFIG_DVB_M88DS3103=y
> CONFIG_DVB_MXL5XX=y
> CONFIG_DVB_STB0899=y
> CONFIG_DVB_STB6100=y
> CONFIG_DVB_STV090x=y
> CONFIG_DVB_STV0910=y
> CONFIG_DVB_STV6110x=y
> CONFIG_DVB_STV6111=y
> 
> #
> # Multistandard (cable + terrestrial) frontends
> #
> CONFIG_DVB_DRXK=y
> CONFIG_DVB_MN88472=y
> CONFIG_DVB_MN88473=y
> CONFIG_DVB_SI2165=y
> CONFIG_DVB_TDA18271C2DD=y
> 
> #
> # DVB-S (satellite) frontends
> #
> CONFIG_DVB_CX24110=y
> CONFIG_DVB_CX24116=y
> CONFIG_DVB_CX24117=y
> CONFIG_DVB_CX24120=y
> CONFIG_DVB_CX24123=y
> CONFIG_DVB_DS3000=y
> CONFIG_DVB_MB86A16=y
> CONFIG_DVB_MT312=y
> CONFIG_DVB_S5H1420=y
> CONFIG_DVB_SI21XX=y
> CONFIG_DVB_STB6000=y
> CONFIG_DVB_STV0288=y
> CONFIG_DVB_STV0299=y
> CONFIG_DVB_STV0900=y
> CONFIG_DVB_STV6110=y
> CONFIG_DVB_TDA10071=y
> CONFIG_DVB_TDA10086=y
> CONFIG_DVB_TDA8083=y
> CONFIG_DVB_TDA8261=y
> CONFIG_DVB_TDA826X=y
> CONFIG_DVB_TS2020=y
> CONFIG_DVB_TUA6100=y
> CONFIG_DVB_TUNER_CX24113=y
> CONFIG_DVB_TUNER_ITD1000=y
> CONFIG_DVB_VES1X93=y
> CONFIG_DVB_ZL10036=y
> CONFIG_DVB_ZL10039=y
> 
> #
> # DVB-T (terrestrial) frontends
> #
> CONFIG_DVB_AF9013=y
> CONFIG_DVB_CX22700=y
> CONFIG_DVB_CX22702=y
> CONFIG_DVB_CXD2820R=y
> CONFIG_DVB_CXD2841ER=y
> CONFIG_DVB_DIB3000MB=y
> CONFIG_DVB_DIB3000MC=y
> CONFIG_DVB_DIB7000M=y
> CONFIG_DVB_DIB7000P=y
> CONFIG_DVB_DRXD=y
> CONFIG_DVB_EC100=y
> CONFIG_DVB_GP8PSK_FE=y
> CONFIG_DVB_L64781=y
> CONFIG_DVB_MT352=y
> CONFIG_DVB_NXT6000=y
> CONFIG_DVB_RTL2830=y
> CONFIG_DVB_RTL2832=y
> CONFIG_DVB_SI2168=y
> CONFIG_DVB_SP887X=y
> CONFIG_DVB_STV0367=y
> CONFIG_DVB_TDA10048=y
> CONFIG_DVB_TDA1004X=y
> CONFIG_DVB_ZL10353=y
> 
> #
> # DVB-C (cable) frontends
> #
> CONFIG_DVB_STV0297=y
> CONFIG_DVB_TDA10021=y
> CONFIG_DVB_TDA10023=y
> CONFIG_DVB_VES1820=y
> 
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> CONFIG_DVB_AU8522=y
> CONFIG_DVB_AU8522_DTV=y
> CONFIG_DVB_AU8522_V4L=y
> CONFIG_DVB_BCM3510=y
> CONFIG_DVB_LG2160=y
> CONFIG_DVB_LGDT3305=y
> CONFIG_DVB_LGDT3306A=y
> CONFIG_DVB_LGDT330X=y
> CONFIG_DVB_MXL692=y
> CONFIG_DVB_NXT200X=y
> CONFIG_DVB_OR51132=y
> CONFIG_DVB_OR51211=y
> CONFIG_DVB_S5H1409=y
> CONFIG_DVB_S5H1411=y
> 
> #
> # ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_DIB8000=y
> CONFIG_DVB_MB86A20S=y
> CONFIG_DVB_S921=y
> 
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_TC90522=y
> 
> #
> # Digital terrestrial only tuners/PLL
> #
> CONFIG_DVB_PLL=y
> CONFIG_DVB_TUNER_DIB0070=y
> CONFIG_DVB_TUNER_DIB0090=y
> 
> #
> # SEC control devices for DVB-S
> #
> CONFIG_DVB_A8293=y
> CONFIG_DVB_AF9033=y
> CONFIG_DVB_ATBM8830=y
> CONFIG_DVB_ISL6405=y
> CONFIG_DVB_ISL6421=y
> CONFIG_DVB_ISL6423=y
> CONFIG_DVB_IX2505V=y
> CONFIG_DVB_LGS8GXX=y
> CONFIG_DVB_LNBH25=y
> CONFIG_DVB_LNBP21=y
> CONFIG_DVB_LNBP22=y
> CONFIG_DVB_M88RS2000=y
> CONFIG_DVB_TDA665x=y
> CONFIG_DVB_DRX39XYJ=y
> 
> #
> # Common Interface (EN50221) controller drivers
> #
> CONFIG_DVB_CXD2099=y
> # end of Media ancillary drivers
> 
> #
> # Graphics support
> #
> CONFIG_APERTURE_HELPERS=y
> CONFIG_SCREEN_INFO=y
> CONFIG_VIDEO=y
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_PANEL is not set
> # CONFIG_AGP is not set
> CONFIG_VGA_SWITCHEROO=y
> # CONFIG_DRM is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB=y
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_UVESA is not set
> CONFIG_FB_VESA=y
> CONFIG_FB_EFI=y
> # CONFIG_FB_N411 is not set
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_SM501 is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_XEN_FBDEV_FRONTEND is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> CONFIG_FB_HYPERV=y
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_FB_SM712 is not set
> CONFIG_FB_CORE=y
> CONFIG_FB_NOTIFY=y
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_DEVICE=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYSMEM_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_IOMEM_FOPS=y
> CONFIG_FB_IOMEM_HELPERS=y
> CONFIG_FB_IOMEM_HELPERS_DEFERRED=y
> CONFIG_FB_SYSMEM_HELPERS=y
> CONFIG_FB_SYSMEM_HELPERS_DEFERRED=y
> # CONFIG_FB_MODE_HELPERS is not set
> CONFIG_FB_TILEBLITTING=y
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=y
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> # CONFIG_LCD_LTV350QV is not set
> # CONFIG_LCD_ILI922X is not set
> # CONFIG_LCD_ILI9320 is not set
> # CONFIG_LCD_TDO24M is not set
> # CONFIG_LCD_VGG2432A4 is not set
> CONFIG_LCD_PLATFORM=y
> # CONFIG_LCD_AMS369FG06 is not set
> # CONFIG_LCD_LMS501KF03 is not set
> # CONFIG_LCD_HX8357 is not set
> # CONFIG_LCD_OTM3225A is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> # CONFIG_BACKLIGHT_KTD253 is not set
> # CONFIG_BACKLIGHT_KTD2801 is not set
> # CONFIG_BACKLIGHT_KTZ8866 is not set
> # CONFIG_BACKLIGHT_PWM is not set
> CONFIG_BACKLIGHT_APPLE=y
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_LM3509 is not set
> # CONFIG_BACKLIGHT_LM3630A is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> CONFIG_BACKLIGHT_LP855X=y
> # CONFIG_BACKLIGHT_MP3309C is not set
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> # end of Backlight & LCD device support
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> # end of Console display driver support
> 
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=y
> # end of Graphics support
> 
> CONFIG_SOUND=y
> CONFIG_SOUND_OSS_CORE=y
> CONFIG_SOUND_OSS_CORE_PRECLAIM=y
> CONFIG_SND=y
> CONFIG_SND_TIMER=y
> CONFIG_SND_PCM=y
> CONFIG_SND_PCM_ELD=y
> CONFIG_SND_HWDEP=y
> CONFIG_SND_SEQ_DEVICE=y
> CONFIG_SND_RAWMIDI=y
> CONFIG_SND_COMPRESS_OFFLOAD=y
> CONFIG_SND_JACK=y
> CONFIG_SND_JACK_INPUT_DEV=y
> CONFIG_SND_OSSEMUL=y
> # CONFIG_SND_MIXER_OSS is not set
> # CONFIG_SND_PCM_OSS is not set
> CONFIG_SND_PCM_TIMER=y
> CONFIG_SND_HRTIMER=y
> CONFIG_SND_DYNAMIC_MINORS=y
> CONFIG_SND_MAX_CARDS=32
> # CONFIG_SND_SUPPORT_OLD_API is not set
> CONFIG_SND_PROC_FS=y
> CONFIG_SND_VERBOSE_PROCFS=y
> CONFIG_SND_CTL_FAST_LOOKUP=y
> # CONFIG_SND_DEBUG is not set
> # CONFIG_SND_CTL_INPUT_VALIDATION is not set
> # CONFIG_SND_UTIMER is not set
> CONFIG_SND_VMASTER=y
> CONFIG_SND_DMA_SGBUF=y
> CONFIG_SND_CTL_LED=y
> CONFIG_SND_SEQUENCER=y
> CONFIG_SND_SEQ_DUMMY=y
> CONFIG_SND_SEQUENCER_OSS=y
> CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
> CONFIG_SND_SEQ_MIDI_EVENT=y
> CONFIG_SND_SEQ_MIDI=y
> CONFIG_SND_SEQ_MIDI_EMUL=y
> CONFIG_SND_SEQ_VIRMIDI=y
> # CONFIG_SND_SEQ_UMP is not set
> CONFIG_SND_MPU401_UART=y
> CONFIG_SND_OPL3_LIB=y
> CONFIG_SND_OPL3_LIB_SEQ=y
> CONFIG_SND_VX_LIB=y
> CONFIG_SND_AC97_CODEC=y
> CONFIG_SND_DRIVERS=y
> CONFIG_SND_PCSP=y
> CONFIG_SND_DUMMY=y
> CONFIG_SND_ALOOP=y
> # CONFIG_SND_PCMTEST is not set
> CONFIG_SND_VIRMIDI=y
> CONFIG_SND_MTPAV=y
> # CONFIG_SND_MTS64 is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> CONFIG_SND_MPU401=y
> # CONFIG_SND_PORTMAN2X4 is not set
> CONFIG_SND_AC97_POWER_SAVE=y
> CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
> CONFIG_SND_PCI=y
> CONFIG_SND_AD1889=y
> # CONFIG_SND_ALS300 is not set
> # CONFIG_SND_ALS4000 is not set
> CONFIG_SND_ALI5451=y
> CONFIG_SND_ASIHPI=y
> CONFIG_SND_ATIIXP=y
> CONFIG_SND_ATIIXP_MODEM=y
> CONFIG_SND_AU8810=y
> CONFIG_SND_AU8820=y
> CONFIG_SND_AU8830=y
> # CONFIG_SND_AW2 is not set
> # CONFIG_SND_AZT3328 is not set
> CONFIG_SND_BT87X=y
> # CONFIG_SND_BT87X_OVERCLOCK is not set
> CONFIG_SND_CA0106=y
> CONFIG_SND_CMIPCI=y
> CONFIG_SND_OXYGEN_LIB=y
> CONFIG_SND_OXYGEN=y
> # CONFIG_SND_CS4281 is not set
> CONFIG_SND_CS46XX=y
> CONFIG_SND_CS46XX_NEW_DSP=y
> CONFIG_SND_CTXFI=y
> CONFIG_SND_DARLA20=y
> CONFIG_SND_GINA20=y
> CONFIG_SND_LAYLA20=y
> CONFIG_SND_DARLA24=y
> CONFIG_SND_GINA24=y
> CONFIG_SND_LAYLA24=y
> CONFIG_SND_MONA=y
> CONFIG_SND_MIA=y
> CONFIG_SND_ECHO3G=y
> CONFIG_SND_INDIGO=y
> CONFIG_SND_INDIGOIO=y
> CONFIG_SND_INDIGODJ=y
> CONFIG_SND_INDIGOIOX=y
> CONFIG_SND_INDIGODJX=y
> CONFIG_SND_EMU10K1=y
> CONFIG_SND_EMU10K1_SEQ=y
> CONFIG_SND_EMU10K1X=y
> CONFIG_SND_ENS1370=y
> CONFIG_SND_ENS1371=y
> # CONFIG_SND_ES1938 is not set
> CONFIG_SND_ES1968=y
> CONFIG_SND_ES1968_INPUT=y
> CONFIG_SND_ES1968_RADIO=y
> # CONFIG_SND_FM801 is not set
> CONFIG_SND_HDSP=y
> 
> #
> # Don't forget to add built-in firmwares for HDSP driver
> #
> CONFIG_SND_HDSPM=y
> CONFIG_SND_ICE1712=y
> CONFIG_SND_ICE1724=y
> CONFIG_SND_INTEL8X0=y
> CONFIG_SND_INTEL8X0M=y
> CONFIG_SND_KORG1212=y
> CONFIG_SND_LOLA=y
> CONFIG_SND_LX6464ES=y
> CONFIG_SND_MAESTRO3=y
> CONFIG_SND_MAESTRO3_INPUT=y
> CONFIG_SND_MIXART=y
> # CONFIG_SND_NM256 is not set
> CONFIG_SND_PCXHR=y
> # CONFIG_SND_RIPTIDE is not set
> CONFIG_SND_RME32=y
> CONFIG_SND_RME96=y
> CONFIG_SND_RME9652=y
> # CONFIG_SND_SONICVIBES is not set
> CONFIG_SND_TRIDENT=y
> CONFIG_SND_VIA82XX=y
> CONFIG_SND_VIA82XX_MODEM=y
> CONFIG_SND_VIRTUOSO=y
> CONFIG_SND_VX222=y
> # CONFIG_SND_YMFPCI is not set
> 
> #
> # HD-Audio
> #
> CONFIG_SND_HDA=y
> CONFIG_SND_HDA_GENERIC_LEDS=y
> CONFIG_SND_HDA_INTEL=y
> CONFIG_SND_HDA_HWDEP=y
> CONFIG_SND_HDA_RECONFIG=y
> CONFIG_SND_HDA_INPUT_BEEP=y
> CONFIG_SND_HDA_INPUT_BEEP_MODE=0
> CONFIG_SND_HDA_PATCH_LOADER=y
> CONFIG_SND_HDA_SCODEC_COMPONENT=y
> # CONFIG_SND_HDA_SCODEC_CS35L41_I2C is not set
> # CONFIG_SND_HDA_SCODEC_CS35L41_SPI is not set
> # CONFIG_SND_HDA_SCODEC_CS35L56_I2C is not set
> # CONFIG_SND_HDA_SCODEC_CS35L56_SPI is not set
> # CONFIG_SND_HDA_SCODEC_TAS2781_I2C is not set
> # CONFIG_SND_HDA_SCODEC_TAS2781_SPI is not set
> CONFIG_SND_HDA_CODEC_REALTEK=y
> CONFIG_SND_HDA_CODEC_ANALOG=y
> CONFIG_SND_HDA_CODEC_SIGMATEL=y
> CONFIG_SND_HDA_CODEC_VIA=y
> CONFIG_SND_HDA_CODEC_HDMI=y
> CONFIG_SND_HDA_CODEC_CIRRUS=y
> # CONFIG_SND_HDA_CODEC_CS8409 is not set
> CONFIG_SND_HDA_CODEC_CONEXANT=y
> # CONFIG_SND_HDA_CODEC_SENARYTECH is not set
> CONFIG_SND_HDA_CODEC_CA0110=y
> CONFIG_SND_HDA_CODEC_CA0132=y
> CONFIG_SND_HDA_CODEC_CA0132_DSP=y
> CONFIG_SND_HDA_CODEC_CMEDIA=y
> CONFIG_SND_HDA_CODEC_SI3054=y
> CONFIG_SND_HDA_GENERIC=y
> CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
> # CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
> # CONFIG_SND_HDA_CTL_DEV_ID is not set
> # end of HD-Audio
> 
> CONFIG_SND_HDA_CORE=y
> CONFIG_SND_HDA_DSP_LOADER=y
> CONFIG_SND_HDA_PREALLOC_SIZE=0
> CONFIG_SND_INTEL_NHLT=y
> CONFIG_SND_INTEL_DSP_CONFIG=y
> CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
> # CONFIG_SND_SPI is not set
> CONFIG_SND_USB=y
> CONFIG_SND_USB_AUDIO=y
> # CONFIG_SND_USB_AUDIO_MIDI_V2 is not set
> CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
> CONFIG_SND_USB_UA101=y
> CONFIG_SND_USB_USX2Y=y
> CONFIG_SND_USB_CAIAQ=y
> CONFIG_SND_USB_CAIAQ_INPUT=y
> CONFIG_SND_USB_US122L=y
> CONFIG_SND_USB_6FIRE=y
> CONFIG_SND_USB_HIFACE=y
> CONFIG_SND_BCD2000=y
> CONFIG_SND_USB_LINE6=y
> CONFIG_SND_USB_POD=y
> CONFIG_SND_USB_PODHD=y
> CONFIG_SND_USB_TONEPORT=y
> CONFIG_SND_USB_VARIAX=y
> CONFIG_SND_FIREWIRE=y
> CONFIG_SND_FIREWIRE_LIB=y
> CONFIG_SND_DICE=y
> CONFIG_SND_OXFW=y
> CONFIG_SND_ISIGHT=y
> CONFIG_SND_FIREWORKS=y
> CONFIG_SND_BEBOB=y
> CONFIG_SND_FIREWIRE_DIGI00X=y
> CONFIG_SND_FIREWIRE_TASCAM=y
> CONFIG_SND_FIREWIRE_MOTU=y
> CONFIG_SND_FIREFACE=y
> CONFIG_SND_SOC=y
> CONFIG_SND_SOC_COMPRESS=y
> CONFIG_SND_SOC_ACPI=y
> # CONFIG_SND_SOC_ADI is not set
> # CONFIG_SND_SOC_AMD_ACP is not set
> # CONFIG_SND_SOC_AMD_ACP3x is not set
> # CONFIG_SND_SOC_AMD_RENOIR is not set
> # CONFIG_SND_SOC_AMD_ACP5x is not set
> # CONFIG_SND_SOC_AMD_ACP6x is not set
> # CONFIG_SND_AMD_ACP_CONFIG is not set
> # CONFIG_SND_SOC_AMD_ACP_COMMON is not set
> # CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
> # CONFIG_SND_ATMEL_SOC is not set
> # CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
> # CONFIG_SND_DESIGNWARE_I2S is not set
> 
> #
> # SoC Audio for Freescale CPUs
> #
> 
> #
> # Common SoC Audio options for Freescale CPUs:
> #
> # CONFIG_SND_SOC_FSL_ASRC is not set
> # CONFIG_SND_SOC_FSL_SAI is not set
> # CONFIG_SND_SOC_FSL_AUDMIX is not set
> # CONFIG_SND_SOC_FSL_SSI is not set
> # CONFIG_SND_SOC_FSL_SPDIF is not set
> # CONFIG_SND_SOC_FSL_ESAI is not set
> # CONFIG_SND_SOC_FSL_MICFIL is not set
> # CONFIG_SND_SOC_FSL_XCVR is not set
> # CONFIG_SND_SOC_IMX_AUDMUX is not set
> # end of SoC Audio for Freescale CPUs
> 
> # CONFIG_SND_SOC_CHV3_I2S is not set
> # CONFIG_SND_I2S_HI6210_I2S is not set
> 
> #
> # SoC Audio for Loongson CPUs
> #
> # end of SoC Audio for Loongson CPUs
> 
> # CONFIG_SND_SOC_IMG is not set
> CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
> # CONFIG_SND_SOC_INTEL_CATPT is not set
> CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
> # CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
> CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=y
> CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
> CONFIG_SND_SOC_ACPI_INTEL_SDCA_QUIRKS=y
> # CONFIG_SND_SOC_INTEL_AVS is not set
> CONFIG_SND_SOC_INTEL_MACH=y
> # CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
> CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=y
> CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=y
> CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=y
> CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=y
> CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=y
> CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=y
> # CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
> CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=y
> CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=y
> CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=y
> # CONFIG_SND_SOC_MTK_BTCVSD is not set
> CONFIG_SND_SOC_SDCA=y
> CONFIG_SND_SOC_SDCA_OPTIONAL=y
> # CONFIG_SND_SOC_SOF_TOPLEVEL is not set
> 
> #
> # STMicroelectronics STM32 SOC audio support
> #
> # end of STMicroelectronics STM32 SOC audio support
> 
> # CONFIG_SND_SOC_XILINX_I2S is not set
> # CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
> # CONFIG_SND_SOC_XILINX_SPDIF is not set
> # CONFIG_SND_SOC_XTFPGA_I2S is not set
> CONFIG_SND_SOC_I2C_AND_SPI=y
> 
> #
> # CODEC drivers
> #
> # CONFIG_SND_SOC_AC97_CODEC is not set
> # CONFIG_SND_SOC_ADAU1372_I2C is not set
> # CONFIG_SND_SOC_ADAU1372_SPI is not set
> # CONFIG_SND_SOC_ADAU1373 is not set
> # CONFIG_SND_SOC_ADAU1701 is not set
> # CONFIG_SND_SOC_ADAU1761_I2C is not set
> # CONFIG_SND_SOC_ADAU1761_SPI is not set
> # CONFIG_SND_SOC_ADAU7002 is not set
> # CONFIG_SND_SOC_ADAU7118_HW is not set
> # CONFIG_SND_SOC_ADAU7118_I2C is not set
> # CONFIG_SND_SOC_AK4104 is not set
> # CONFIG_SND_SOC_AK4118 is not set
> # CONFIG_SND_SOC_AK4375 is not set
> # CONFIG_SND_SOC_AK4458 is not set
> # CONFIG_SND_SOC_AK4554 is not set
> # CONFIG_SND_SOC_AK4613 is not set
> # CONFIG_SND_SOC_AK4619 is not set
> # CONFIG_SND_SOC_AK4642 is not set
> # CONFIG_SND_SOC_AK5386 is not set
> # CONFIG_SND_SOC_AK5558 is not set
> # CONFIG_SND_SOC_ALC5623 is not set
> # CONFIG_SND_SOC_AUDIO_IIO_AUX is not set
> # CONFIG_SND_SOC_AW8738 is not set
> # CONFIG_SND_SOC_AW88395 is not set
> # CONFIG_SND_SOC_AW88166 is not set
> # CONFIG_SND_SOC_AW88261 is not set
> # CONFIG_SND_SOC_AW88081 is not set
> # CONFIG_SND_SOC_AW87390 is not set
> # CONFIG_SND_SOC_AW88399 is not set
> # CONFIG_SND_SOC_BD28623 is not set
> # CONFIG_SND_SOC_BT_SCO is not set
> # CONFIG_SND_SOC_CHV3_CODEC is not set
> # CONFIG_SND_SOC_CS35L32 is not set
> # CONFIG_SND_SOC_CS35L33 is not set
> # CONFIG_SND_SOC_CS35L34 is not set
> # CONFIG_SND_SOC_CS35L35 is not set
> # CONFIG_SND_SOC_CS35L36 is not set
> # CONFIG_SND_SOC_CS35L41_SPI is not set
> # CONFIG_SND_SOC_CS35L41_I2C is not set
> # CONFIG_SND_SOC_CS35L45_SPI is not set
> # CONFIG_SND_SOC_CS35L45_I2C is not set
> # CONFIG_SND_SOC_CS35L56_I2C is not set
> # CONFIG_SND_SOC_CS35L56_SPI is not set
> # CONFIG_SND_SOC_CS42L42 is not set
> # CONFIG_SND_SOC_CS42L51_I2C is not set
> # CONFIG_SND_SOC_CS42L52 is not set
> # CONFIG_SND_SOC_CS42L56 is not set
> # CONFIG_SND_SOC_CS42L73 is not set
> # CONFIG_SND_SOC_CS42L83 is not set
> # CONFIG_SND_SOC_CS42L84 is not set
> # CONFIG_SND_SOC_CS4234 is not set
> # CONFIG_SND_SOC_CS4265 is not set
> # CONFIG_SND_SOC_CS4270 is not set
> # CONFIG_SND_SOC_CS4271_I2C is not set
> # CONFIG_SND_SOC_CS4271_SPI is not set
> # CONFIG_SND_SOC_CS42XX8_I2C is not set
> # CONFIG_SND_SOC_CS43130 is not set
> # CONFIG_SND_SOC_CS4341 is not set
> # CONFIG_SND_SOC_CS4349 is not set
> # CONFIG_SND_SOC_CS53L30 is not set
> # CONFIG_SND_SOC_CS530X_I2C is not set
> # CONFIG_SND_SOC_CX2072X is not set
> CONFIG_SND_SOC_DA7213=y
> CONFIG_SND_SOC_DMIC=y
> # CONFIG_SND_SOC_ES7134 is not set
> # CONFIG_SND_SOC_ES7241 is not set
> CONFIG_SND_SOC_ES83XX_DSM_COMMON=y
> # CONFIG_SND_SOC_ES8311 is not set
> CONFIG_SND_SOC_ES8316=y
> # CONFIG_SND_SOC_ES8323 is not set
> # CONFIG_SND_SOC_ES8326 is not set
> # CONFIG_SND_SOC_ES8328_I2C is not set
> # CONFIG_SND_SOC_ES8328_SPI is not set
> # CONFIG_SND_SOC_GTM601 is not set
> # CONFIG_SND_SOC_HDA is not set
> # CONFIG_SND_SOC_ICS43432 is not set
> # CONFIG_SND_SOC_IDT821034 is not set
> # CONFIG_SND_SOC_MAX98088 is not set
> CONFIG_SND_SOC_MAX98090=y
> CONFIG_SND_SOC_MAX98357A=y
> # CONFIG_SND_SOC_MAX98504 is not set
> # CONFIG_SND_SOC_MAX9867 is not set
> CONFIG_SND_SOC_MAX98927=y
> # CONFIG_SND_SOC_MAX98520 is not set
> # CONFIG_SND_SOC_MAX98373_I2C is not set
> # CONFIG_SND_SOC_MAX98388 is not set
> CONFIG_SND_SOC_MAX98390=y
> # CONFIG_SND_SOC_MAX98396 is not set
> # CONFIG_SND_SOC_MAX9860 is not set
> # CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
> # CONFIG_SND_SOC_PCM1681 is not set
> # CONFIG_SND_SOC_PCM1789_I2C is not set
> # CONFIG_SND_SOC_PCM179X_I2C is not set
> # CONFIG_SND_SOC_PCM179X_SPI is not set
> # CONFIG_SND_SOC_PCM186X_I2C is not set
> # CONFIG_SND_SOC_PCM186X_SPI is not set
> # CONFIG_SND_SOC_PCM3060_I2C is not set
> # CONFIG_SND_SOC_PCM3060_SPI is not set
> # CONFIG_SND_SOC_PCM3168A_I2C is not set
> # CONFIG_SND_SOC_PCM3168A_SPI is not set
> # CONFIG_SND_SOC_PCM5102A is not set
> # CONFIG_SND_SOC_PCM512x_I2C is not set
> # CONFIG_SND_SOC_PCM512x_SPI is not set
> # CONFIG_SND_SOC_PCM6240 is not set
> # CONFIG_SND_SOC_PEB2466 is not set
> CONFIG_SND_SOC_RL6231=y
> # CONFIG_SND_SOC_RT5616 is not set
> # CONFIG_SND_SOC_RT5631 is not set
> CONFIG_SND_SOC_RT5640=y
> CONFIG_SND_SOC_RT5645=y
> CONFIG_SND_SOC_RT5651=y
> # CONFIG_SND_SOC_RT5659 is not set
> CONFIG_SND_SOC_RT5670=y
> # CONFIG_SND_SOC_RT9120 is not set
> # CONFIG_SND_SOC_RTQ9128 is not set
> # CONFIG_SND_SOC_SGTL5000 is not set
> # CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
> # CONFIG_SND_SOC_SIMPLE_MUX is not set
> # CONFIG_SND_SOC_SMA1303 is not set
> # CONFIG_SND_SOC_SMA1307 is not set
> # CONFIG_SND_SOC_SPDIF is not set
> # CONFIG_SND_SOC_SRC4XXX_I2C is not set
> # CONFIG_SND_SOC_SSM2305 is not set
> # CONFIG_SND_SOC_SSM2518 is not set
> # CONFIG_SND_SOC_SSM2602_SPI is not set
> # CONFIG_SND_SOC_SSM2602_I2C is not set
> CONFIG_SND_SOC_SSM4567=y
> # CONFIG_SND_SOC_STA32X is not set
> # CONFIG_SND_SOC_STA350 is not set
> # CONFIG_SND_SOC_STI_SAS is not set
> # CONFIG_SND_SOC_TAS2552 is not set
> # CONFIG_SND_SOC_TAS2562 is not set
> # CONFIG_SND_SOC_TAS2764 is not set
> # CONFIG_SND_SOC_TAS2770 is not set
> # CONFIG_SND_SOC_TAS2780 is not set
> # CONFIG_SND_SOC_TAS2781_I2C is not set
> # CONFIG_SND_SOC_TAS5086 is not set
> # CONFIG_SND_SOC_TAS571X is not set
> # CONFIG_SND_SOC_TAS5720 is not set
> # CONFIG_SND_SOC_TAS5805M is not set
> # CONFIG_SND_SOC_TAS6424 is not set
> # CONFIG_SND_SOC_TDA7419 is not set
> # CONFIG_SND_SOC_TFA9879 is not set
> # CONFIG_SND_SOC_TFA989X is not set
> # CONFIG_SND_SOC_TLV320ADC3XXX is not set
> # CONFIG_SND_SOC_TLV320AIC23_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC23_SPI is not set
> # CONFIG_SND_SOC_TLV320AIC31XX is not set
> # CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
> # CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
> # CONFIG_SND_SOC_TLV320ADCX140 is not set
> CONFIG_SND_SOC_TS3A227E=y
> # CONFIG_SND_SOC_TSCS42XX is not set
> # CONFIG_SND_SOC_TSCS454 is not set
> # CONFIG_SND_SOC_UDA1334 is not set
> # CONFIG_SND_SOC_UDA1342 is not set
> # CONFIG_SND_SOC_WM8510 is not set
> # CONFIG_SND_SOC_WM8523 is not set
> # CONFIG_SND_SOC_WM8524 is not set
> # CONFIG_SND_SOC_WM8580 is not set
> # CONFIG_SND_SOC_WM8711 is not set
> # CONFIG_SND_SOC_WM8728 is not set
> # CONFIG_SND_SOC_WM8731_I2C is not set
> # CONFIG_SND_SOC_WM8731_SPI is not set
> # CONFIG_SND_SOC_WM8737 is not set
> # CONFIG_SND_SOC_WM8741 is not set
> # CONFIG_SND_SOC_WM8750 is not set
> # CONFIG_SND_SOC_WM8753 is not set
> # CONFIG_SND_SOC_WM8770 is not set
> # CONFIG_SND_SOC_WM8776 is not set
> # CONFIG_SND_SOC_WM8782 is not set
> # CONFIG_SND_SOC_WM8804_I2C is not set
> # CONFIG_SND_SOC_WM8804_SPI is not set
> # CONFIG_SND_SOC_WM8903 is not set
> # CONFIG_SND_SOC_WM8904 is not set
> # CONFIG_SND_SOC_WM8940 is not set
> # CONFIG_SND_SOC_WM8960 is not set
> # CONFIG_SND_SOC_WM8961 is not set
> # CONFIG_SND_SOC_WM8962 is not set
> # CONFIG_SND_SOC_WM8974 is not set
> # CONFIG_SND_SOC_WM8978 is not set
> # CONFIG_SND_SOC_WM8985 is not set
> # CONFIG_SND_SOC_ZL38060 is not set
> # CONFIG_SND_SOC_MAX9759 is not set
> # CONFIG_SND_SOC_MT6351 is not set
> # CONFIG_SND_SOC_MT6357 is not set
> # CONFIG_SND_SOC_MT6358 is not set
> # CONFIG_SND_SOC_MT6660 is not set
> # CONFIG_SND_SOC_NAU8315 is not set
> # CONFIG_SND_SOC_NAU8540 is not set
> # CONFIG_SND_SOC_NAU8810 is not set
> # CONFIG_SND_SOC_NAU8821 is not set
> # CONFIG_SND_SOC_NAU8822 is not set
> CONFIG_SND_SOC_NAU8824=y
> # CONFIG_SND_SOC_NTP8918 is not set
> # CONFIG_SND_SOC_NTP8835 is not set
> # CONFIG_SND_SOC_TPA6130A2 is not set
> # CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
> # CONFIG_SND_SOC_LPASS_VA_MACRO is not set
> # CONFIG_SND_SOC_LPASS_RX_MACRO is not set
> # CONFIG_SND_SOC_LPASS_TX_MACRO is not set
> # end of CODEC drivers
> 
> # CONFIG_SND_SIMPLE_CARD is not set
> CONFIG_SND_X86=y
> CONFIG_SND_SYNTH_EMUX=y
> CONFIG_SND_XEN_FRONTEND=y
> # CONFIG_SND_VIRTIO is not set
> CONFIG_AC97_BUS=y
> CONFIG_HID_SUPPORT=y
> CONFIG_HID=y
> CONFIG_HID_BATTERY_STRENGTH=y
> CONFIG_HIDRAW=y
> CONFIG_UHID=y
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=y
> # CONFIG_HID_ACCUTOUCH is not set
> CONFIG_HID_ACRUX=y
> # CONFIG_HID_ACRUX_FF is not set
> CONFIG_HID_APPLE=y
> CONFIG_HID_APPLEIR=y
> # CONFIG_HID_APPLETB_BL is not set
> # CONFIG_HID_APPLETB_KBD is not set
> CONFIG_HID_ASUS=y
> CONFIG_HID_AUREAL=y
> CONFIG_HID_BELKIN=y
> CONFIG_HID_BETOP_FF=y
> # CONFIG_HID_BIGBEN_FF is not set
> CONFIG_HID_CHERRY=y
> CONFIG_HID_CHICONY=y
> CONFIG_HID_CORSAIR=y
> # CONFIG_HID_COUGAR is not set
> # CONFIG_HID_MACALLY is not set
> CONFIG_HID_PRODIKEYS=y
> CONFIG_HID_CMEDIA=y
> # CONFIG_HID_CP2112 is not set
> # CONFIG_HID_CREATIVE_SB0540 is not set
> CONFIG_HID_CYPRESS=y
> CONFIG_HID_DRAGONRISE=y
> # CONFIG_DRAGONRISE_FF is not set
> # CONFIG_HID_EMS_FF is not set
> CONFIG_HID_ELAN=y
> CONFIG_HID_ELECOM=y
> CONFIG_HID_ELO=y
> # CONFIG_HID_EVISION is not set
> CONFIG_HID_EZKEY=y
> # CONFIG_HID_FT260 is not set
> CONFIG_HID_GEMBIRD=y
> CONFIG_HID_GFRM=y
> # CONFIG_HID_GLORIOUS is not set
> CONFIG_HID_HOLTEK=y
> # CONFIG_HOLTEK_FF is not set
> # CONFIG_HID_GOODIX_SPI is not set
> # CONFIG_HID_GOOGLE_STADIA_FF is not set
> # CONFIG_HID_VIVALDI is not set
> CONFIG_HID_GT683R=y
> CONFIG_HID_KEYTOUCH=y
> CONFIG_HID_KYE=y
> # CONFIG_HID_KYSONA is not set
> CONFIG_HID_UCLOGIC=y
> CONFIG_HID_WALTOP=y
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_VRC2 is not set
> # CONFIG_HID_XIAOMI is not set
> CONFIG_HID_GYRATION=y
> CONFIG_HID_ICADE=y
> CONFIG_HID_ITE=y
> CONFIG_HID_JABRA=y
> CONFIG_HID_TWINHAN=y
> CONFIG_HID_KENSINGTON=y
> CONFIG_HID_LCPOWER=y
> CONFIG_HID_LED=y
> CONFIG_HID_LENOVO=y
> # CONFIG_HID_LETSKETCH is not set
> CONFIG_HID_MAGICMOUSE=y
> # CONFIG_HID_MALTRON is not set
> # CONFIG_HID_MAYFLASH is not set
> # CONFIG_HID_MEGAWORLD_FF is not set
> # CONFIG_HID_REDRAGON is not set
> CONFIG_HID_MICROSOFT=y
> CONFIG_HID_MONTEREY=y
> CONFIG_HID_MULTITOUCH=y
> # CONFIG_HID_NINTENDO is not set
> CONFIG_HID_NTI=y
> CONFIG_HID_NTRIG=y
> CONFIG_HID_ORTEK=y
> CONFIG_HID_PANTHERLORD=y
> # CONFIG_PANTHERLORD_FF is not set
> CONFIG_HID_PENMOUNT=y
> CONFIG_HID_PETALYNX=y
> CONFIG_HID_PICOLCD=y
> CONFIG_HID_PICOLCD_FB=y
> CONFIG_HID_PICOLCD_BACKLIGHT=y
> CONFIG_HID_PICOLCD_LCD=y
> CONFIG_HID_PICOLCD_LEDS=y
> CONFIG_HID_PICOLCD_CIR=y
> CONFIG_HID_PLANTRONICS=y
> # CONFIG_HID_PXRC is not set
> # CONFIG_HID_RAZER is not set
> CONFIG_HID_PRIMAX=y
> # CONFIG_HID_RETRODE is not set
> CONFIG_HID_ROCCAT=y
> CONFIG_HID_SAITEK=y
> CONFIG_HID_SAMSUNG=y
> # CONFIG_HID_SEMITEK is not set
> # CONFIG_HID_SIGMAMICRO is not set
> CONFIG_HID_SONY=y
> CONFIG_SONY_FF=y
> CONFIG_HID_SPEEDLINK=y
> # CONFIG_HID_STEAM is not set
> CONFIG_HID_STEELSERIES=y
> CONFIG_HID_SUNPLUS=y
> CONFIG_HID_RMI=y
> CONFIG_HID_GREENASIA=y
> # CONFIG_GREENASIA_FF is not set
> CONFIG_HID_HYPERV_MOUSE=y
> CONFIG_HID_SMARTJOYPLUS=y
> # CONFIG_SMARTJOYPLUS_FF is not set
> CONFIG_HID_TIVO=y
> CONFIG_HID_TOPSEED=y
> # CONFIG_HID_TOPRE is not set
> CONFIG_HID_THINGM=y
> CONFIG_HID_THRUSTMASTER=y
> # CONFIG_THRUSTMASTER_FF is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> # CONFIG_HID_U2FZERO is not set
> # CONFIG_HID_UNIVERSAL_PIDFF is not set
> CONFIG_HID_WACOM=y
> CONFIG_HID_WIIMOTE=y
> # CONFIG_HID_WINWING is not set
> CONFIG_HID_XINMO=y
> CONFIG_HID_ZEROPLUS=y
> # CONFIG_ZEROPLUS_FF is not set
> CONFIG_HID_ZYDACRON=y
> CONFIG_HID_SENSOR_HUB=y
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
> CONFIG_HID_ALPS=y
> # CONFIG_HID_MCP2200 is not set
> # CONFIG_HID_MCP2221 is not set
> # end of Special HID drivers
> 
> #
> # HID-BPF support
> #
> # CONFIG_HID_BPF is not set
> # end of HID-BPF support
> 
> CONFIG_I2C_HID=y
> # CONFIG_I2C_HID_ACPI is not set
> # CONFIG_I2C_HID_OF is not set
> 
> #
> # Intel ISH HID support
> #
> CONFIG_INTEL_ISH_HID=y
> # CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
> # end of Intel ISH HID support
> 
> #
> # AMD SFH HID Support
> #
> # CONFIG_AMD_SFH_HID is not set
> # end of AMD SFH HID Support
> 
> #
> # Intel THC HID Support
> #
> # CONFIG_INTEL_THC_HID is not set
> # end of Intel THC HID Support
> 
> #
> # USB HID support
> #
> CONFIG_USB_HID=y
> CONFIG_HID_PID=y
> CONFIG_USB_HIDDEV=y
> # end of USB HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_LED_TRIG=y
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_PCI=y
> CONFIG_USB_PCI_AMD=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=y
> # CONFIG_USB_FEW_INIT_RETRIES is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_PRODUCTLIST is not set
> CONFIG_USB_LEDS_TRIGGER_USBPORT=y
> CONFIG_USB_AUTOSUSPEND_DELAY=2
> CONFIG_USB_DEFAULT_AUTHORIZATION_MODE=1
> CONFIG_USB_MON=y
> 
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> CONFIG_USB_XHCI_HCD=y
> CONFIG_USB_XHCI_DBGCAP=y
> CONFIG_USB_XHCI_PCI=y
> # CONFIG_USB_XHCI_PCI_RENESAS is not set
> CONFIG_USB_XHCI_PLATFORM=y
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> CONFIG_USB_EHCI_TT_NEWSCHED=y
> CONFIG_USB_EHCI_PCI=y
> # CONFIG_USB_EHCI_FSL is not set
> # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> # CONFIG_USB_OXU210HP_HCD is not set
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_MAX3421_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_PCI=y
> # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> CONFIG_USB_UHCI_HCD=y
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> # CONFIG_USB_HCD_BCMA is not set
> # CONFIG_USB_HCD_TEST_MODE is not set
> # CONFIG_USB_XEN_HCD is not set
> 
> #
> # USB Device Class drivers
> #
> CONFIG_USB_ACM=y
> CONFIG_USB_PRINTER=y
> CONFIG_USB_WDM=y
> CONFIG_USB_TMC=y
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed; see USB_STORAGE Help for more info
> #
> CONFIG_USB_STORAGE=y
> # CONFIG_USB_STORAGE_DEBUG is not set
> CONFIG_USB_STORAGE_REALTEK=y
> CONFIG_REALTEK_AUTOPM=y
> CONFIG_USB_STORAGE_DATAFAB=y
> CONFIG_USB_STORAGE_FREECOM=y
> CONFIG_USB_STORAGE_ISD200=y
> CONFIG_USB_STORAGE_USBAT=y
> CONFIG_USB_STORAGE_SDDR09=y
> CONFIG_USB_STORAGE_SDDR55=y
> CONFIG_USB_STORAGE_JUMPSHOT=y
> CONFIG_USB_STORAGE_ALAUDA=y
> CONFIG_USB_STORAGE_ONETOUCH=y
> CONFIG_USB_STORAGE_KARMA=y
> CONFIG_USB_STORAGE_CYPRESS_ATACB=y
> CONFIG_USB_STORAGE_ENE_UB6250=y
> CONFIG_USB_UAS=y
> 
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=y
> CONFIG_USB_MICROTEK=y
> # CONFIG_USBIP_CORE is not set
> 
> #
> # USB dual-mode controller drivers
> #
> # CONFIG_USB_CDNS_SUPPORT is not set
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_DWC2 is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
> 
> #
> # USB port drivers
> #
> CONFIG_USB_SERIAL=y
> # CONFIG_USB_SERIAL_CONSOLE is not set
> CONFIG_USB_SERIAL_GENERIC=y
> # CONFIG_USB_SERIAL_SIMPLE is not set
> CONFIG_USB_SERIAL_AIRCABLE=y
> CONFIG_USB_SERIAL_ARK3116=y
> CONFIG_USB_SERIAL_BELKIN=y
> CONFIG_USB_SERIAL_CH341=y
> CONFIG_USB_SERIAL_WHITEHEAT=y
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
> CONFIG_USB_SERIAL_CP210X=y
> CONFIG_USB_SERIAL_CYPRESS_M8=y
> CONFIG_USB_SERIAL_EMPEG=y
> CONFIG_USB_SERIAL_FTDI_SIO=y
> CONFIG_USB_SERIAL_VISOR=y
> CONFIG_USB_SERIAL_IPAQ=y
> CONFIG_USB_SERIAL_IR=y
> CONFIG_USB_SERIAL_EDGEPORT=y
> CONFIG_USB_SERIAL_EDGEPORT_TI=y
> # CONFIG_USB_SERIAL_F81232 is not set
> CONFIG_USB_SERIAL_F8153X=y
> CONFIG_USB_SERIAL_GARMIN=y
> CONFIG_USB_SERIAL_IPW=y
> CONFIG_USB_SERIAL_IUU=y
> CONFIG_USB_SERIAL_KEYSPAN_PDA=y
> CONFIG_USB_SERIAL_KEYSPAN=y
> CONFIG_USB_SERIAL_KLSI=y
> CONFIG_USB_SERIAL_KOBIL_SCT=y
> CONFIG_USB_SERIAL_MCT_U232=y
> # CONFIG_USB_SERIAL_METRO is not set
> CONFIG_USB_SERIAL_MOS7720=y
> CONFIG_USB_SERIAL_MOS7715_PARPORT=y
> CONFIG_USB_SERIAL_MOS7840=y
> CONFIG_USB_SERIAL_MXUPORT=y
> CONFIG_USB_SERIAL_NAVMAN=y
> CONFIG_USB_SERIAL_PL2303=y
> CONFIG_USB_SERIAL_OTI6858=y
> CONFIG_USB_SERIAL_QCAUX=y
> CONFIG_USB_SERIAL_QUALCOMM=y
> CONFIG_USB_SERIAL_SPCP8X5=y
> CONFIG_USB_SERIAL_SAFE=y
> CONFIG_USB_SERIAL_SAFE_PADDED=y
> CONFIG_USB_SERIAL_SIERRAWIRELESS=y
> CONFIG_USB_SERIAL_SYMBOL=y
> CONFIG_USB_SERIAL_TI=y
> CONFIG_USB_SERIAL_CYBERJACK=y
> CONFIG_USB_SERIAL_WWAN=y
> CONFIG_USB_SERIAL_OPTION=y
> CONFIG_USB_SERIAL_OMNINET=y
> CONFIG_USB_SERIAL_OPTICON=y
> CONFIG_USB_SERIAL_XSENS_MT=y
> # CONFIG_USB_SERIAL_WISHBONE is not set
> CONFIG_USB_SERIAL_SSU100=y
> CONFIG_USB_SERIAL_QT2=y
> CONFIG_USB_SERIAL_UPD78F0730=y
> # CONFIG_USB_SERIAL_XR is not set
> CONFIG_USB_SERIAL_DEBUG=y
> 
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_USS720=y
> CONFIG_USB_EMI62=y
> CONFIG_USB_EMI26=y
> CONFIG_USB_ADUTUX=y
> CONFIG_USB_SEVSEG=y
> CONFIG_USB_LEGOTOWER=y
> CONFIG_USB_LCD=y
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> CONFIG_USB_IDMOUSE=y
> CONFIG_USB_APPLEDISPLAY=y
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> # CONFIG_USB_LJCA is not set
> CONFIG_USB_SISUSBVGA=y
> CONFIG_USB_LD=y
> # CONFIG_USB_TRANCEVIBRATOR is not set
> CONFIG_USB_IOWARRIOR=y
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> CONFIG_USB_ISIGHTFW=y
> # CONFIG_USB_YUREX is not set
> CONFIG_USB_EZUSB_FX2=y
> # CONFIG_USB_HUB_USB251XB is not set
> CONFIG_USB_HSIC_USB3503=y
> # CONFIG_USB_HSIC_USB4604 is not set
> # CONFIG_USB_LINK_LAYER_TEST is not set
> # CONFIG_USB_CHAOSKEY is not set
> CONFIG_USB_ATM=y
> CONFIG_USB_SPEEDTOUCH=y
> CONFIG_USB_CXACRU=y
> CONFIG_USB_UEAGLEATM=y
> CONFIG_USB_XUSBATM=y
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_USB_ISP1301 is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> CONFIG_TYPEC=y
> CONFIG_TYPEC_TCPM=y
> CONFIG_TYPEC_TCPCI=y
> CONFIG_TYPEC_RT1711H=y
> # CONFIG_TYPEC_TCPCI_MAXIM is not set
> CONFIG_TYPEC_FUSB302=y
> CONFIG_TYPEC_UCSI=y
> # CONFIG_UCSI_CCG is not set
> CONFIG_UCSI_ACPI=y
> # CONFIG_UCSI_STM32G0 is not set
> CONFIG_TYPEC_TPS6598X=y
> # CONFIG_TYPEC_ANX7411 is not set
> # CONFIG_TYPEC_RT1719 is not set
> # CONFIG_TYPEC_HD3SS3220 is not set
> # CONFIG_TYPEC_STUSB160X is not set
> # CONFIG_TYPEC_WUSB3801 is not set
> 
> #
> # USB Type-C Multiplexer/DeMultiplexer Switch support
> #
> # CONFIG_TYPEC_MUX_FSA4480 is not set
> # CONFIG_TYPEC_MUX_GPIO_SBU is not set
> CONFIG_TYPEC_MUX_PI3USB30532=y
> # CONFIG_TYPEC_MUX_IT5205 is not set
> # CONFIG_TYPEC_MUX_NB7VPQ904M is not set
> # CONFIG_TYPEC_MUX_PS883X is not set
> # CONFIG_TYPEC_MUX_PTN36502 is not set
> # CONFIG_TYPEC_MUX_TUSB1046 is not set
> # CONFIG_TYPEC_MUX_WCD939X_USBSS is not set
> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
> 
> #
> # USB Type-C Alternate Mode drivers
> #
> # CONFIG_TYPEC_TBT_ALTMODE is not set
> # end of USB Type-C Alternate Mode drivers
> 
> CONFIG_USB_ROLE_SWITCH=y
> CONFIG_USB_ROLES_INTEL_XHCI=y
> CONFIG_MMC=y
> CONFIG_MMC_BLOCK=y
> CONFIG_MMC_BLOCK_MINORS=8
> CONFIG_SDIO_UART=y
> # CONFIG_MMC_TEST is not set
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_SDHCI=y
> CONFIG_MMC_SDHCI_IO_ACCESSORS=y
> CONFIG_MMC_SDHCI_UHS2=y
> CONFIG_MMC_SDHCI_PCI=y
> CONFIG_MMC_RICOH_MMC=y
> CONFIG_MMC_SDHCI_ACPI=y
> CONFIG_MMC_SDHCI_PLTFM=y
> # CONFIG_MMC_SDHCI_F_SDH30 is not set
> # CONFIG_MMC_WBSD is not set
> CONFIG_MMC_TIFM_SD=y
> # CONFIG_MMC_SPI is not set
> CONFIG_MMC_CB710=y
> CONFIG_MMC_VIA_SDMMC=y
> CONFIG_MMC_VUB300=y
> CONFIG_MMC_USHC=y
> # CONFIG_MMC_USDHI6ROL0 is not set
> CONFIG_MMC_REALTEK_PCI=y
> CONFIG_MMC_REALTEK_USB=y
> CONFIG_MMC_CQHCI=y
> # CONFIG_MMC_HSQ is not set
> # CONFIG_MMC_TOSHIBA_PCI is not set
> # CONFIG_MMC_MTK is not set
> CONFIG_MMC_SDHCI_XENON=y
> # CONFIG_SCSI_UFSHCD is not set
> CONFIG_MEMSTICK=y
> # CONFIG_MEMSTICK_DEBUG is not set
> 
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> CONFIG_MSPRO_BLOCK=y
> # CONFIG_MS_BLOCK is not set
> 
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_MEMSTICK_TIFM_MS=y
> CONFIG_MEMSTICK_JMICRON_38X=y
> CONFIG_MEMSTICK_R592=y
> CONFIG_MEMSTICK_REALTEK_USB=y
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> # CONFIG_LEDS_CLASS_MULTICOLOR is not set
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_APU is not set
> # CONFIG_LEDS_AW200XX is not set
> CONFIG_LEDS_LM3530=y
> # CONFIG_LEDS_LM3532 is not set
> # CONFIG_LEDS_LM3642 is not set
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> CONFIG_LEDS_LP3944=y
> # CONFIG_LEDS_LP3952 is not set
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_PCA995X is not set
> # CONFIG_LEDS_DAC124S085 is not set
> # CONFIG_LEDS_PWM is not set
> # CONFIG_LEDS_BD2606MVV is not set
> # CONFIG_LEDS_BD2802 is not set
> CONFIG_LEDS_INTEL_SS4200=y
> # CONFIG_LEDS_LT3593 is not set
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_LM355x is not set
> # CONFIG_LEDS_IS31FL319X is not set
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=y
> CONFIG_LEDS_MLXCPLD=y
> # CONFIG_LEDS_MLXREG is not set
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> # CONFIG_LEDS_SPI_BYTE is not set
> 
> #
> # Flash and Torch LED drivers
> #
> 
> #
> # RGB LED drivers
> #
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=y
> CONFIG_LEDS_TRIGGER_ONESHOT=y
> CONFIG_LEDS_TRIGGER_DISK=y
> # CONFIG_LEDS_TRIGGER_MTD is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> CONFIG_LEDS_TRIGGER_BACKLIGHT=y
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> # CONFIG_LEDS_TRIGGER_GPIO is not set
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=y
> CONFIG_LEDS_TRIGGER_CAMERA=y
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> # CONFIG_LEDS_TRIGGER_TTY is not set
> # CONFIG_LEDS_TRIGGER_INPUT_EVENTS is not set
> 
> #
> # Simatic LED drivers
> #
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=y
> CONFIG_EDAC_LEGACY_SYSFS=y
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_DECODE_MCE=y
> CONFIG_EDAC_GHES=y
> # CONFIG_EDAC_SCRUB is not set
> # CONFIG_EDAC_ECS is not set
> # CONFIG_EDAC_MEM_REPAIR is not set
> CONFIG_EDAC_AMD64=y
> CONFIG_EDAC_E752X=y
> CONFIG_EDAC_I82975X=y
> CONFIG_EDAC_I3000=y
> CONFIG_EDAC_I3200=y
> CONFIG_EDAC_IE31200=y
> CONFIG_EDAC_X38=y
> CONFIG_EDAC_I5400=y
> CONFIG_EDAC_I7CORE=y
> CONFIG_EDAC_I5100=y
> CONFIG_EDAC_I7300=y
> CONFIG_EDAC_SBRIDGE=y
> CONFIG_EDAC_SKX=y
> CONFIG_EDAC_I10NM=y
> CONFIG_EDAC_PND2=y
> # CONFIG_EDAC_IGEN6 is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> # CONFIG_RTC_SYSTOHC is not set
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=y
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> CONFIG_RTC_DRV_DS1307=y
> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> CONFIG_RTC_DRV_DS1374=y
> # CONFIG_RTC_DRV_DS1374_WDT is not set
> CONFIG_RTC_DRV_DS1672=y
> CONFIG_RTC_DRV_MAX6900=y
> # CONFIG_RTC_DRV_MAX31335 is not set
> CONFIG_RTC_DRV_RS5C372=y
> CONFIG_RTC_DRV_ISL1208=y
> CONFIG_RTC_DRV_ISL12022=y
> CONFIG_RTC_DRV_X1205=y
> CONFIG_RTC_DRV_PCF8523=y
> # CONFIG_RTC_DRV_PCF85063 is not set
> # CONFIG_RTC_DRV_PCF85363 is not set
> CONFIG_RTC_DRV_PCF8563=y
> CONFIG_RTC_DRV_PCF8583=y
> CONFIG_RTC_DRV_M41T80=y
> CONFIG_RTC_DRV_M41T80_WDT=y
> CONFIG_RTC_DRV_BQ32K=y
> # CONFIG_RTC_DRV_S35390A is not set
> CONFIG_RTC_DRV_FM3130=y
> # CONFIG_RTC_DRV_RX8010 is not set
> # CONFIG_RTC_DRV_RX8111 is not set
> CONFIG_RTC_DRV_RX8581=y
> CONFIG_RTC_DRV_RX8025=y
> CONFIG_RTC_DRV_EM3027=y
> # CONFIG_RTC_DRV_RV3028 is not set
> # CONFIG_RTC_DRV_RV3032 is not set
> CONFIG_RTC_DRV_RV8803=y
> # CONFIG_RTC_DRV_SD2405AL is not set
> # CONFIG_RTC_DRV_SD3078 is not set
> 
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1302 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> # CONFIG_RTC_DRV_DS1343 is not set
> # CONFIG_RTC_DRV_DS1347 is not set
> # CONFIG_RTC_DRV_DS1390 is not set
> # CONFIG_RTC_DRV_MAX6916 is not set
> # CONFIG_RTC_DRV_R9701 is not set
> CONFIG_RTC_DRV_RX4581=y
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> # CONFIG_RTC_DRV_PCF2123 is not set
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS3232=y
> CONFIG_RTC_DRV_DS3232_HWMON=y
> # CONFIG_RTC_DRV_PCF2127 is not set
> CONFIG_RTC_DRV_RV3029C2=y
> # CONFIG_RTC_DRV_RV3029_HWMON is not set
> # CONFIG_RTC_DRV_RX6110 is not set
> 
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=y
> CONFIG_RTC_DRV_DS1286=y
> CONFIG_RTC_DRV_DS1511=y
> CONFIG_RTC_DRV_DS1553=y
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> CONFIG_RTC_DRV_DS1742=y
> CONFIG_RTC_DRV_DS2404=y
> CONFIG_RTC_DRV_STK17TA8=y
> # CONFIG_RTC_DRV_M48T86 is not set
> CONFIG_RTC_DRV_M48T35=y
> CONFIG_RTC_DRV_M48T59=y
> CONFIG_RTC_DRV_MSM6242=y
> CONFIG_RTC_DRV_RP5C01=y
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
> 
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
> # CONFIG_RTC_DRV_GOLDFISH is not set
> CONFIG_DMADEVICES=y
> # CONFIG_DMADEVICES_DEBUG is not set
> 
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_ACPI=y
> # CONFIG_ALTERA_MSGDMA is not set
> CONFIG_INTEL_IDMA64=y
> CONFIG_INTEL_IDXD_BUS=y
> CONFIG_INTEL_IDXD=y
> # CONFIG_INTEL_IDXD_COMPAT is not set
> CONFIG_INTEL_IDXD_SVM=y
> CONFIG_INTEL_IDXD_PERFMON=y
> CONFIG_INTEL_IOATDMA=y
> # CONFIG_PLX_DMA is not set
> # CONFIG_XILINX_DMA is not set
> # CONFIG_XILINX_XDMA is not set
> # CONFIG_AMD_PTDMA is not set
> # CONFIG_AMD_QDMA is not set
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> CONFIG_DW_DMAC_CORE=y
> CONFIG_DW_DMAC=y
> CONFIG_DW_DMAC_PCI=y
> # CONFIG_DW_EDMA is not set
> CONFIG_HSU_DMA=y
> # CONFIG_SF_PDMA is not set
> # CONFIG_INTEL_LDMA is not set
> 
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=y
> CONFIG_DMATEST=y
> CONFIG_DMA_ENGINE_RAID=y
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> # CONFIG_UDMABUF is not set
> # CONFIG_DMABUF_MOVE_NOTIFY is not set
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_DMABUF_SELFTESTS is not set
> # CONFIG_DMABUF_HEAPS is not set
> # CONFIG_DMABUF_SYSFS_STATS is not set
> # end of DMABUF options
> 
> CONFIG_DCA=y
> CONFIG_UIO=y
> CONFIG_UIO_CIF=y
> CONFIG_UIO_PDRV_GENIRQ=y
> # CONFIG_UIO_DMEM_GENIRQ is not set
> CONFIG_UIO_AEC=y
> CONFIG_UIO_SERCOS3=y
> CONFIG_UIO_PCI_GENERIC=y
> # CONFIG_UIO_NETX is not set
> # CONFIG_UIO_MF624 is not set
> CONFIG_UIO_HV_GENERIC=y
> CONFIG_VFIO=y
> CONFIG_VFIO_DEVICE_CDEV=y
> CONFIG_VFIO_GROUP=y
> CONFIG_VFIO_CONTAINER=y
> CONFIG_VFIO_IOMMU_TYPE1=y
> CONFIG_VFIO_NOIOMMU=y
> CONFIG_VFIO_VIRQFD=y
> # CONFIG_VFIO_DEBUGFS is not set
> 
> #
> # VFIO support for PCI devices
> #
> CONFIG_VFIO_PCI_CORE=y
> CONFIG_VFIO_PCI_INTX=y
> CONFIG_VFIO_PCI=y
> # CONFIG_VFIO_PCI_VGA is not set
> # CONFIG_VFIO_PCI_IGD is not set
> # CONFIG_MLX5_VFIO_PCI is not set
> # CONFIG_VIRTIO_VFIO_PCI is not set
> CONFIG_QAT_VFIO_PCI=m
> # end of VFIO support for PCI devices
> 
> CONFIG_IRQ_BYPASS_MANAGER=y
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO_ANCHOR=y
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_PCI_LIB=y
> CONFIG_VIRTIO_PCI_LIB_LEGACY=y
> CONFIG_VIRTIO_MENU=y
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_PCI_ADMIN_LEGACY=y
> CONFIG_VIRTIO_PCI_LEGACY=y
> # CONFIG_VIRTIO_PMEM is not set
> CONFIG_VIRTIO_BALLOON=y
> CONFIG_VIRTIO_MEM=y
> CONFIG_VIRTIO_INPUT=y
> # CONFIG_VIRTIO_MMIO is not set
> # CONFIG_VIRTIO_DEBUG is not set
> # CONFIG_VDPA is not set
> CONFIG_VHOST_TASK=y
> CONFIG_VHOST_MENU=y
> # CONFIG_VHOST_NET is not set
> # CONFIG_VHOST_SCSI is not set
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> CONFIG_HYPERV=y
> # CONFIG_HYPERV_VTL_MODE is not set
> CONFIG_HYPERV_TIMER=y
> CONFIG_HYPERV_UTILS=y
> CONFIG_HYPERV_BALLOON=y
> # CONFIG_MSHV_ROOT is not set
> # end of Microsoft Hyper-V guest support
> 
> #
> # Xen driver support
> #
> CONFIG_XEN_BALLOON=y
> # CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
> CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
> CONFIG_XEN_DEV_EVTCHN=y
> # CONFIG_XEN_BACKEND is not set
> CONFIG_XENFS=y
> CONFIG_XEN_COMPAT_XENFS=y
> CONFIG_XEN_SYS_HYPERVISOR=y
> CONFIG_XEN_XENBUS_FRONTEND=y
> # CONFIG_XEN_GNTDEV is not set
> # CONFIG_XEN_GRANT_DEV_ALLOC is not set
> # CONFIG_XEN_GRANT_DMA_ALLOC is not set
> # CONFIG_XEN_PVCALLS_FRONTEND is not set
> CONFIG_XEN_PRIVCMD=y
> CONFIG_XEN_EFI=y
> CONFIG_XEN_AUTO_XLATE=y
> CONFIG_XEN_ACPI=y
> CONFIG_XEN_FRONT_PGDIR_SHBUF=y
> # CONFIG_XEN_UNPOPULATED_ALLOC is not set
> # CONFIG_XEN_VIRTIO is not set
> # end of Xen driver support
> 
> # CONFIG_GREYBUS is not set
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> # CONFIG_GOLDFISH is not set
> # CONFIG_CHROME_PLATFORMS is not set
> CONFIG_MELLANOX_PLATFORM=y
> CONFIG_MLX_PLATFORM=y
> CONFIG_MLXREG_HOTPLUG=y
> # CONFIG_MLXREG_IO is not set
> # CONFIG_MLXREG_LC is not set
> # CONFIG_NVSW_SN2201 is not set
> CONFIG_SURFACE_PLATFORMS=y
> # CONFIG_SURFACE3_WMI is not set
> # CONFIG_SURFACE_3_POWER_OPREGION is not set
> # CONFIG_SURFACE_GPE is not set
> # CONFIG_SURFACE_HOTPLUG is not set
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> CONFIG_X86_PLATFORM_DEVICES=y
> CONFIG_ACPI_WMI=y
> CONFIG_WMI_BMOF=y
> # CONFIG_HUAWEI_WMI is not set
> # CONFIG_UV_SYSFS is not set
> CONFIG_MXM_WMI=y
> # CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
> # CONFIG_XIAOMI_WMI is not set
> # CONFIG_GIGABYTE_WMI is not set
> # CONFIG_YOGABOOK is not set
> CONFIG_ACERHDF=y
> # CONFIG_ACER_WIRELESS is not set
> CONFIG_ACER_WMI=y
> 
> #
> # AMD HSMP Driver
> #
> # CONFIG_AMD_HSMP_ACPI is not set
> # CONFIG_AMD_HSMP_PLAT is not set
> # end of AMD HSMP Driver
> 
> # CONFIG_AMD_PMC is not set
> # CONFIG_AMD_3D_VCACHE is not set
> # CONFIG_AMD_WBRF is not set
> # CONFIG_ADV_SWBUTTON is not set
> CONFIG_APPLE_GMUX=y
> CONFIG_ASUS_LAPTOP=y
> # CONFIG_ASUS_WIRELESS is not set
> CONFIG_ASUS_WMI=y
> CONFIG_ASUS_NB_WMI=y
> # CONFIG_ASUS_TF103C_DOCK is not set
> # CONFIG_MERAKI_MX100 is not set
> CONFIG_EEEPC_LAPTOP=y
> CONFIG_EEEPC_WMI=y
> # CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
> CONFIG_AMILO_RFKILL=y
> CONFIG_FUJITSU_LAPTOP=y
> CONFIG_FUJITSU_TABLET=y
> # CONFIG_GPD_POCKET_FAN is not set
> # CONFIG_X86_PLATFORM_DRIVERS_HP is not set
> # CONFIG_WIRELESS_HOTKEY is not set
> # CONFIG_IBM_RTL is not set
> CONFIG_IDEAPAD_LAPTOP=y
> # CONFIG_LENOVO_WMI_HOTKEY_UTILITIES is not set
> # CONFIG_LENOVO_YMC is not set
> CONFIG_SENSORS_HDAPS=y
> # CONFIG_THINKPAD_LMI is not set
> # CONFIG_INTEL_ATOMISP2_PM is not set
> CONFIG_INTEL_IFS=y
> # CONFIG_INTEL_SAR_INT1092 is not set
> CONFIG_INTEL_PMC_CORE=y
> CONFIG_INTEL_PMT_CLASS=y
> CONFIG_INTEL_PMT_TELEMETRY=y
> CONFIG_INTEL_PMT_CRASHLOG=y
> 
> #
> # Intel Speed Select Technology interface support
> #
> CONFIG_INTEL_SPEED_SELECT_TPMI=y
> CONFIG_INTEL_SPEED_SELECT_INTERFACE=y
> # end of Intel Speed Select Technology interface support
> 
> CONFIG_INTEL_WMI=y
> # CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
> CONFIG_INTEL_WMI_THUNDERBOLT=y
> 
> #
> # Intel Uncore Frequency Control
> #
> CONFIG_INTEL_UNCORE_FREQ_CONTROL_TPMI=y
> CONFIG_INTEL_UNCORE_FREQ_CONTROL=y
> # end of Intel Uncore Frequency Control
> 
> CONFIG_INTEL_HID_EVENT=y
> CONFIG_INTEL_VBTN=y
> # CONFIG_INTEL_INT0002_VGPIO is not set
> CONFIG_INTEL_OAKTRAIL=y
> # CONFIG_INTEL_ISHTP_ECLITE is not set
> # CONFIG_INTEL_PUNIT_IPC is not set
> CONFIG_INTEL_RST=y
> CONFIG_INTEL_SDSI=y
> # CONFIG_INTEL_SMARTCONNECT is not set
> CONFIG_INTEL_TPMI_POWER_DOMAINS=y
> CONFIG_INTEL_TPMI=y
> # CONFIG_INTEL_PLR_TPMI is not set
> CONFIG_INTEL_TURBO_MAX_3=y
> CONFIG_INTEL_VSEC=y
> # CONFIG_ACPI_QUICKSTART is not set
> # CONFIG_MEEGOPAD_ANX7428 is not set
> # CONFIG_MSI_EC is not set
> CONFIG_MSI_LAPTOP=y
> CONFIG_MSI_WMI=y
> # CONFIG_MSI_WMI_PLATFORM is not set
> # CONFIG_PCENGINES_APU2 is not set
> # CONFIG_BARCO_P50_GPIO is not set
> # CONFIG_SAMSUNG_GALAXYBOOK is not set
> CONFIG_SAMSUNG_LAPTOP=y
> CONFIG_SAMSUNG_Q10=y
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_TOSHIBA_BT_RFKILL=y
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_TOSHIBA_WMI is not set
> CONFIG_ACPI_CMPC=y
> CONFIG_COMPAL_LAPTOP=y
> # CONFIG_LG_LAPTOP is not set
> CONFIG_PANASONIC_LAPTOP=y
> CONFIG_SONY_LAPTOP=y
> CONFIG_SONYPI_COMPAT=y
> # CONFIG_SYSTEM76_ACPI is not set
> CONFIG_TOPSTAR_LAPTOP=y
> # CONFIG_SERIAL_MULTI_INSTANTIATE is not set
> # CONFIG_INSPUR_PLATFORM_PROFILE is not set
> # CONFIG_LENOVO_WMI_CAMERA is not set
> CONFIG_INTEL_IPS=y
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> # CONFIG_SIEMENS_SIMATIC_IPC is not set
> # CONFIG_WINMATE_FM07_KEYS is not set
> # CONFIG_SEL3350_PLATFORM is not set
> CONFIG_P2SB=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> # CONFIG_LMK04832 is not set
> # CONFIG_COMMON_CLK_MAX9485 is not set
> # CONFIG_COMMON_CLK_SI5341 is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI544 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # CONFIG_COMMON_CLK_PWM is not set
> # CONFIG_XILINX_VCU is not set
> CONFIG_HWSPINLOCK=y
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> CONFIG_PCC=y
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_IOMMU_IOVA=y
> CONFIG_IOMMU_API=y
> CONFIG_IOMMUFD_DRIVER=y
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> CONFIG_IOMMU_IO_PGTABLE=y
> # end of Generic IOMMU Pagetable Support
> 
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> # CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
> CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
> CONFIG_IOMMU_DMA=y
> CONFIG_IOMMU_SVA=y
> CONFIG_IOMMU_IOPF=y
> CONFIG_AMD_IOMMU=y
> CONFIG_DMAR_TABLE=y
> CONFIG_INTEL_IOMMU=y
> CONFIG_INTEL_IOMMU_SVM=y
> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> # CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_PERF_EVENTS=y
> CONFIG_IOMMUFD_DRIVER_CORE=y
> CONFIG_IOMMUFD=y
> CONFIG_IRQ_REMAP=y
> CONFIG_HYPERV_IOMMU=y
> # CONFIG_VIRTIO_IOMMU is not set
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
> 
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # fujitsu SoC drivers
> #
> # end of fujitsu SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
> 
> # CONFIG_WPCM450_SOC is not set
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> #
> # PM Domains
> #
> 
> #
> # Amlogic PM Domains
> #
> # end of Amlogic PM Domains
> 
> #
> # Broadcom PM Domains
> #
> # end of Broadcom PM Domains
> 
> #
> # i.MX PM Domains
> #
> # end of i.MX PM Domains
> 
> #
> # Qualcomm PM Domains
> #
> # end of Qualcomm PM Domains
> # end of PM Domains
> 
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> CONFIG_IIO=y
> CONFIG_IIO_BUFFER=y
> # CONFIG_IIO_BUFFER_CB is not set
> # CONFIG_IIO_BUFFER_DMA is not set
> # CONFIG_IIO_BUFFER_DMAENGINE is not set
> # CONFIG_IIO_BUFFER_HW_CONSUMER is not set
> CONFIG_IIO_KFIFO_BUF=y
> CONFIG_IIO_TRIGGERED_BUFFER=y
> # CONFIG_IIO_CONFIGFS is not set
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> # CONFIG_IIO_SW_DEVICE is not set
> # CONFIG_IIO_SW_TRIGGER is not set
> # CONFIG_IIO_TRIGGERED_EVENT is not set
> 
> #
> # Accelerometers
> #
> # CONFIG_ADIS16201 is not set
> # CONFIG_ADIS16209 is not set
> # CONFIG_ADXL313_I2C is not set
> # CONFIG_ADXL313_SPI is not set
> # CONFIG_ADXL345_I2C is not set
> # CONFIG_ADXL345_SPI is not set
> # CONFIG_ADXL355_I2C is not set
> # CONFIG_ADXL355_SPI is not set
> # CONFIG_ADXL367_SPI is not set
> # CONFIG_ADXL367_I2C is not set
> # CONFIG_ADXL372_SPI is not set
> # CONFIG_ADXL372_I2C is not set
> # CONFIG_ADXL380_SPI is not set
> # CONFIG_ADXL380_I2C is not set
> # CONFIG_BMA180 is not set
> # CONFIG_BMA220 is not set
> # CONFIG_BMA400 is not set
> # CONFIG_BMC150_ACCEL is not set
> # CONFIG_BMI088_ACCEL is not set
> # CONFIG_DA280 is not set
> # CONFIG_DA311 is not set
> # CONFIG_DMARD06 is not set
> # CONFIG_DMARD09 is not set
> # CONFIG_DMARD10 is not set
> # CONFIG_FXLS8962AF_I2C is not set
> # CONFIG_FXLS8962AF_SPI is not set
> CONFIG_HID_SENSOR_ACCEL_3D=y
> # CONFIG_IIO_KX022A_SPI is not set
> # CONFIG_IIO_KX022A_I2C is not set
> # CONFIG_KXSD9 is not set
> # CONFIG_KXCJK1013 is not set
> # CONFIG_MC3230 is not set
> # CONFIG_MMA7455_I2C is not set
> # CONFIG_MMA7455_SPI is not set
> # CONFIG_MMA7660 is not set
> # CONFIG_MMA8452 is not set
> # CONFIG_MMA9551 is not set
> # CONFIG_MMA9553 is not set
> # CONFIG_MSA311 is not set
> # CONFIG_MXC4005 is not set
> # CONFIG_MXC6255 is not set
> # CONFIG_SCA3000 is not set
> # CONFIG_SCA3300 is not set
> # CONFIG_STK8312 is not set
> # CONFIG_STK8BA50 is not set
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> # CONFIG_AD4000 is not set
> # CONFIG_AD4030 is not set
> # CONFIG_AD4130 is not set
> # CONFIG_AD4695 is not set
> # CONFIG_AD4851 is not set
> # CONFIG_AD7091R5 is not set
> # CONFIG_AD7091R8 is not set
> # CONFIG_AD7124 is not set
> # CONFIG_AD7173 is not set
> # CONFIG_AD7191 is not set
> # CONFIG_AD7192 is not set
> # CONFIG_AD7266 is not set
> # CONFIG_AD7280 is not set
> # CONFIG_AD7291 is not set
> # CONFIG_AD7292 is not set
> # CONFIG_AD7298 is not set
> # CONFIG_AD7380 is not set
> # CONFIG_AD7476 is not set
> # CONFIG_AD7606_IFACE_PARALLEL is not set
> # CONFIG_AD7606_IFACE_SPI is not set
> # CONFIG_AD7625 is not set
> # CONFIG_AD7766 is not set
> # CONFIG_AD7768_1 is not set
> # CONFIG_AD7779 is not set
> # CONFIG_AD7780 is not set
> # CONFIG_AD7791 is not set
> # CONFIG_AD7793 is not set
> # CONFIG_AD7887 is not set
> # CONFIG_AD7923 is not set
> # CONFIG_AD7944 is not set
> # CONFIG_AD7949 is not set
> # CONFIG_AD799X is not set
> # CONFIG_AD9467 is not set
> # CONFIG_ENVELOPE_DETECTOR is not set
> # CONFIG_GEHC_PMC_ADC is not set
> # CONFIG_HI8435 is not set
> # CONFIG_HX711 is not set
> # CONFIG_LTC2309 is not set
> # CONFIG_LTC2471 is not set
> # CONFIG_LTC2485 is not set
> # CONFIG_LTC2496 is not set
> # CONFIG_LTC2497 is not set
> # CONFIG_MAX1027 is not set
> # CONFIG_MAX11100 is not set
> # CONFIG_MAX1118 is not set
> # CONFIG_MAX11205 is not set
> # CONFIG_MAX11410 is not set
> # CONFIG_MAX1241 is not set
> # CONFIG_MAX1363 is not set
> # CONFIG_MAX34408 is not set
> # CONFIG_MAX9611 is not set
> # CONFIG_MCP320X is not set
> # CONFIG_MCP3422 is not set
> # CONFIG_MCP3564 is not set
> # CONFIG_MCP3911 is not set
> # CONFIG_NAU7802 is not set
> # CONFIG_PAC1921 is not set
> # CONFIG_PAC1934 is not set
> # CONFIG_RICHTEK_RTQ6056 is not set
> # CONFIG_SD_ADC_MODULATOR is not set
> # CONFIG_TI_ADC081C is not set
> # CONFIG_TI_ADC0832 is not set
> # CONFIG_TI_ADC084S021 is not set
> # CONFIG_TI_ADC12138 is not set
> # CONFIG_TI_ADC108S102 is not set
> # CONFIG_TI_ADC128S052 is not set
> # CONFIG_TI_ADC161S626 is not set
> # CONFIG_TI_ADS1015 is not set
> # CONFIG_TI_ADS1119 is not set
> # CONFIG_TI_ADS7138 is not set
> # CONFIG_TI_ADS7924 is not set
> # CONFIG_TI_ADS1100 is not set
> # CONFIG_TI_ADS1298 is not set
> # CONFIG_TI_ADS7950 is not set
> # CONFIG_TI_ADS8344 is not set
> # CONFIG_TI_ADS8688 is not set
> # CONFIG_TI_ADS124S08 is not set
> # CONFIG_TI_ADS131E08 is not set
> # CONFIG_TI_LMP92064 is not set
> # CONFIG_TI_TLC4541 is not set
> # CONFIG_TI_TSC2046 is not set
> # CONFIG_VF610_ADC is not set
> # CONFIG_VIPERBOARD_ADC is not set
> # CONFIG_XILINX_XADC is not set
> # end of Analog to digital converters
> 
> #
> # Analog to digital and digital to analog converters
> #
> # CONFIG_AD74115 is not set
> # CONFIG_AD74413R is not set
> # end of Analog to digital and digital to analog converters
> 
> #
> # Analog Front Ends
> #
> # CONFIG_IIO_RESCALE is not set
> # end of Analog Front Ends
> 
> #
> # Amplifiers
> #
> # CONFIG_AD8366 is not set
> # CONFIG_ADA4250 is not set
> # CONFIG_HMC425 is not set
> # end of Amplifiers
> 
> #
> # Capacitance to digital converters
> #
> # CONFIG_AD7150 is not set
> # CONFIG_AD7746 is not set
> # end of Capacitance to digital converters
> 
> #
> # Chemical Sensors
> #
> # CONFIG_AOSONG_AGS02MA is not set
> # CONFIG_ATLAS_PH_SENSOR is not set
> # CONFIG_ATLAS_EZO_SENSOR is not set
> # CONFIG_BME680 is not set
> # CONFIG_CCS811 is not set
> # CONFIG_ENS160 is not set
> # CONFIG_IAQCORE is not set
> # CONFIG_SCD30_CORE is not set
> # CONFIG_SCD4X is not set
> # CONFIG_SENSIRION_SGP30 is not set
> # CONFIG_SENSIRION_SGP40 is not set
> # CONFIG_SPS30_I2C is not set
> # CONFIG_SENSEAIR_SUNRISE_CO2 is not set
> # CONFIG_VZ89X is not set
> # end of Chemical Sensors
> 
> #
> # Hid Sensor IIO Common
> #
> CONFIG_HID_SENSOR_IIO_COMMON=y
> CONFIG_HID_SENSOR_IIO_TRIGGER=y
> # end of Hid Sensor IIO Common
> 
> #
> # IIO SCMI Sensors
> #
> # end of IIO SCMI Sensors
> 
> #
> # SSP Sensor Common
> #
> # CONFIG_IIO_SSP_SENSORHUB is not set
> # end of SSP Sensor Common
> 
> #
> # Digital to analog converters
> #
> # CONFIG_AD3552R_HS is not set
> # CONFIG_AD3552R is not set
> # CONFIG_AD5064 is not set
> # CONFIG_AD5360 is not set
> # CONFIG_AD5380 is not set
> # CONFIG_AD5421 is not set
> # CONFIG_AD5446 is not set
> # CONFIG_AD5449 is not set
> # CONFIG_AD5592R is not set
> # CONFIG_AD5593R is not set
> # CONFIG_AD5504 is not set
> # CONFIG_AD5624R_SPI is not set
> # CONFIG_AD9739A is not set
> # CONFIG_LTC2688 is not set
> # CONFIG_AD5686_SPI is not set
> # CONFIG_AD5696_I2C is not set
> # CONFIG_AD5755 is not set
> # CONFIG_AD5758 is not set
> # CONFIG_AD5761 is not set
> # CONFIG_AD5764 is not set
> # CONFIG_AD5766 is not set
> # CONFIG_AD5770R is not set
> # CONFIG_AD5791 is not set
> # CONFIG_AD7293 is not set
> # CONFIG_AD7303 is not set
> # CONFIG_AD8460 is not set
> # CONFIG_AD8801 is not set
> # CONFIG_BD79703 is not set
> # CONFIG_DPOT_DAC is not set
> # CONFIG_DS4424 is not set
> # CONFIG_LTC1660 is not set
> # CONFIG_LTC2632 is not set
> # CONFIG_LTC2664 is not set
> # CONFIG_M62332 is not set
> # CONFIG_MAX517 is not set
> # CONFIG_MAX5522 is not set
> # CONFIG_MAX5821 is not set
> # CONFIG_MCP4725 is not set
> # CONFIG_MCP4728 is not set
> # CONFIG_MCP4821 is not set
> # CONFIG_MCP4922 is not set
> # CONFIG_TI_DAC082S085 is not set
> # CONFIG_TI_DAC5571 is not set
> # CONFIG_TI_DAC7311 is not set
> # CONFIG_TI_DAC7612 is not set
> # CONFIG_VF610_DAC is not set
> # end of Digital to analog converters
> 
> #
> # IIO dummy driver
> #
> # end of IIO dummy driver
> 
> #
> # Filters
> #
> # CONFIG_ADMV8818 is not set
> # end of Filters
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> # CONFIG_AD9523 is not set
> # end of Clock Generator/Distribution
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> # CONFIG_ADF4350 is not set
> # CONFIG_ADF4371 is not set
> # CONFIG_ADF4377 is not set
> # CONFIG_ADMFM2000 is not set
> # CONFIG_ADMV1013 is not set
> # CONFIG_ADMV1014 is not set
> # CONFIG_ADMV4420 is not set
> # CONFIG_ADRF6780 is not set
> # end of Phase-Locked Loop (PLL) frequency synthesizers
> # end of Frequency Synthesizers DDS/PLL
> 
> #
> # Digital gyroscope sensors
> #
> # CONFIG_ADIS16080 is not set
> # CONFIG_ADIS16130 is not set
> # CONFIG_ADIS16136 is not set
> # CONFIG_ADIS16260 is not set
> # CONFIG_ADXRS290 is not set
> # CONFIG_ADXRS450 is not set
> # CONFIG_BMG160 is not set
> # CONFIG_FXAS21002C is not set
> CONFIG_HID_SENSOR_GYRO_3D=y
> # CONFIG_MPU3050_I2C is not set
> # CONFIG_IIO_ST_GYRO_3AXIS is not set
> # CONFIG_ITG3200 is not set
> # end of Digital gyroscope sensors
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> # CONFIG_AFE4403 is not set
> # CONFIG_AFE4404 is not set
> # CONFIG_MAX30100 is not set
> # CONFIG_MAX30102 is not set
> # end of Heart Rate Monitors
> # end of Health Sensors
> 
> #
> # Humidity sensors
> #
> # CONFIG_AM2315 is not set
> # CONFIG_DHT11 is not set
> # CONFIG_ENS210 is not set
> # CONFIG_HDC100X is not set
> # CONFIG_HDC2010 is not set
> # CONFIG_HDC3020 is not set
> CONFIG_HID_SENSOR_HUMIDITY=y
> # CONFIG_HTS221 is not set
> # CONFIG_HTU21 is not set
> # CONFIG_SI7005 is not set
> # CONFIG_SI7020 is not set
> # end of Humidity sensors
> 
> #
> # Inertial measurement units
> #
> # CONFIG_ADIS16400 is not set
> # CONFIG_ADIS16460 is not set
> # CONFIG_ADIS16475 is not set
> # CONFIG_ADIS16480 is not set
> # CONFIG_ADIS16550 is not set
> # CONFIG_BMI160_I2C is not set
> # CONFIG_BMI160_SPI is not set
> # CONFIG_BMI270_I2C is not set
> # CONFIG_BMI270_SPI is not set
> # CONFIG_BMI323_I2C is not set
> # CONFIG_BMI323_SPI is not set
> # CONFIG_BOSCH_BNO055_I2C is not set
> # CONFIG_FXOS8700_I2C is not set
> # CONFIG_FXOS8700_SPI is not set
> # CONFIG_KMX61 is not set
> # CONFIG_INV_ICM42600_I2C is not set
> # CONFIG_INV_ICM42600_SPI is not set
> # CONFIG_INV_MPU6050_I2C is not set
> # CONFIG_INV_MPU6050_SPI is not set
> # CONFIG_SMI240 is not set
> # CONFIG_IIO_ST_LSM6DSX is not set
> # end of Inertial measurement units
> 
> #
> # Light sensors
> #
> # CONFIG_ACPI_ALS is not set
> # CONFIG_ADJD_S311 is not set
> # CONFIG_ADUX1020 is not set
> # CONFIG_AL3000A is not set
> # CONFIG_AL3010 is not set
> # CONFIG_AL3320A is not set
> # CONFIG_APDS9160 is not set
> # CONFIG_APDS9300 is not set
> # CONFIG_APDS9306 is not set
> # CONFIG_APDS9960 is not set
> # CONFIG_AS73211 is not set
> # CONFIG_BH1745 is not set
> # CONFIG_BH1750 is not set
> # CONFIG_BH1780 is not set
> # CONFIG_CM32181 is not set
> # CONFIG_CM3232 is not set
> # CONFIG_CM3323 is not set
> # CONFIG_CM3605 is not set
> # CONFIG_CM36651 is not set
> # CONFIG_GP2AP002 is not set
> # CONFIG_GP2AP020A00F is not set
> # CONFIG_SENSORS_ISL29018 is not set
> # CONFIG_SENSORS_ISL29028 is not set
> # CONFIG_ISL29125 is not set
> # CONFIG_ISL76682 is not set
> CONFIG_HID_SENSOR_ALS=y
> CONFIG_HID_SENSOR_PROX=y
> # CONFIG_JSA1212 is not set
> # CONFIG_ROHM_BU27034 is not set
> # CONFIG_RPR0521 is not set
> # CONFIG_LTR390 is not set
> # CONFIG_LTR501 is not set
> # CONFIG_LTRF216A is not set
> # CONFIG_LV0104CS is not set
> # CONFIG_MAX44000 is not set
> # CONFIG_MAX44009 is not set
> # CONFIG_NOA1305 is not set
> # CONFIG_OPT3001 is not set
> # CONFIG_OPT4001 is not set
> # CONFIG_OPT4060 is not set
> # CONFIG_PA12203001 is not set
> # CONFIG_SI1133 is not set
> # CONFIG_SI1145 is not set
> # CONFIG_STK3310 is not set
> # CONFIG_ST_UVIS25 is not set
> # CONFIG_TCS3414 is not set
> # CONFIG_TCS3472 is not set
> # CONFIG_SENSORS_TSL2563 is not set
> # CONFIG_TSL2583 is not set
> # CONFIG_TSL2591 is not set
> # CONFIG_TSL2772 is not set
> # CONFIG_TSL4531 is not set
> # CONFIG_US5182D is not set
> # CONFIG_VCNL4000 is not set
> # CONFIG_VCNL4035 is not set
> # CONFIG_VEML3235 is not set
> # CONFIG_VEML6030 is not set
> # CONFIG_VEML6040 is not set
> # CONFIG_VEML6070 is not set
> # CONFIG_VEML6075 is not set
> # CONFIG_VL6180 is not set
> # CONFIG_ZOPT2201 is not set
> # end of Light sensors
> 
> #
> # Magnetometer sensors
> #
> # CONFIG_AK8974 is not set
> # CONFIG_AK8975 is not set
> # CONFIG_AK09911 is not set
> # CONFIG_ALS31300 is not set
> # CONFIG_BMC150_MAGN_I2C is not set
> # CONFIG_BMC150_MAGN_SPI is not set
> # CONFIG_MAG3110 is not set
> CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
> # CONFIG_MMC35240 is not set
> # CONFIG_IIO_ST_MAGN_3AXIS is not set
> # CONFIG_SENSORS_HMC5843_I2C is not set
> # CONFIG_SENSORS_HMC5843_SPI is not set
> # CONFIG_SENSORS_RM3100_I2C is not set
> # CONFIG_SENSORS_RM3100_SPI is not set
> # CONFIG_SI7210 is not set
> # CONFIG_TI_TMAG5273 is not set
> # CONFIG_YAMAHA_YAS530 is not set
> # end of Magnetometer sensors
> 
> #
> # Multiplexers
> #
> # CONFIG_IIO_MUX is not set
> # end of Multiplexers
> 
> #
> # Inclinometer sensors
> #
> CONFIG_HID_SENSOR_INCLINOMETER_3D=y
> CONFIG_HID_SENSOR_DEVICE_ROTATION=y
> # end of Inclinometer sensors
> 
> #
> # Triggers - standalone
> #
> # CONFIG_IIO_INTERRUPT_TRIGGER is not set
> # CONFIG_IIO_SYSFS_TRIGGER is not set
> # end of Triggers - standalone
> 
> #
> # Linear and angular position sensors
> #
> # CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE is not set
> # end of Linear and angular position sensors
> 
> #
> # Digital potentiometers
> #
> # CONFIG_AD5110 is not set
> # CONFIG_AD5272 is not set
> # CONFIG_DS1803 is not set
> # CONFIG_MAX5432 is not set
> # CONFIG_MAX5481 is not set
> # CONFIG_MAX5487 is not set
> # CONFIG_MCP4018 is not set
> # CONFIG_MCP4131 is not set
> # CONFIG_MCP4531 is not set
> # CONFIG_MCP41010 is not set
> # CONFIG_TPL0102 is not set
> # CONFIG_X9250 is not set
> # end of Digital potentiometers
> 
> #
> # Digital potentiostats
> #
> # CONFIG_LMP91000 is not set
> # end of Digital potentiostats
> 
> #
> # Pressure sensors
> #
> # CONFIG_ABP060MG is not set
> # CONFIG_ROHM_BM1390 is not set
> # CONFIG_BMP280 is not set
> # CONFIG_DLHL60D is not set
> # CONFIG_DPS310 is not set
> CONFIG_HID_SENSOR_PRESS=y
> # CONFIG_HP03 is not set
> # CONFIG_HSC030PA is not set
> # CONFIG_ICP10100 is not set
> # CONFIG_MPL115_I2C is not set
> # CONFIG_MPL115_SPI is not set
> # CONFIG_MPL3115 is not set
> # CONFIG_MPRLS0025PA is not set
> # CONFIG_MS5611 is not set
> # CONFIG_MS5637 is not set
> # CONFIG_SDP500 is not set
> # CONFIG_IIO_ST_PRESS is not set
> # CONFIG_T5403 is not set
> # CONFIG_HP206C is not set
> # CONFIG_ZPA2326 is not set
> # end of Pressure sensors
> 
> #
> # Lightning sensors
> #
> # CONFIG_AS3935 is not set
> # end of Lightning sensors
> 
> #
> # Proximity and distance sensors
> #
> # CONFIG_HX9023S is not set
> # CONFIG_IRSD200 is not set
> # CONFIG_ISL29501 is not set
> # CONFIG_LIDAR_LITE_V2 is not set
> # CONFIG_MB1232 is not set
> # CONFIG_PING is not set
> # CONFIG_RFD77402 is not set
> # CONFIG_SRF04 is not set
> # CONFIG_SX9310 is not set
> # CONFIG_SX9324 is not set
> # CONFIG_SX9360 is not set
> # CONFIG_SX9500 is not set
> # CONFIG_SRF08 is not set
> # CONFIG_VCNL3020 is not set
> # CONFIG_VL53L0X_I2C is not set
> # CONFIG_AW96103 is not set
> # end of Proximity and distance sensors
> 
> #
> # Resolver to digital converters
> #
> # CONFIG_AD2S90 is not set
> # CONFIG_AD2S1200 is not set
> # CONFIG_AD2S1210 is not set
> # end of Resolver to digital converters
> 
> #
> # Temperature sensors
> #
> # CONFIG_LTC2983 is not set
> # CONFIG_MAXIM_THERMOCOUPLE is not set
> CONFIG_HID_SENSOR_TEMP=y
> # CONFIG_MLX90614 is not set
> # CONFIG_MLX90632 is not set
> # CONFIG_MLX90635 is not set
> # CONFIG_TMP006 is not set
> # CONFIG_TMP007 is not set
> # CONFIG_TMP117 is not set
> # CONFIG_TSYS01 is not set
> # CONFIG_TSYS02D is not set
> # CONFIG_MAX30208 is not set
> # CONFIG_MAX31856 is not set
> # CONFIG_MAX31865 is not set
> # CONFIG_MCP9600 is not set
> # end of Temperature sensors
> 
> CONFIG_NTB=y
> # CONFIG_NTB_MSI is not set
> # CONFIG_NTB_AMD is not set
> # CONFIG_NTB_IDT is not set
> CONFIG_NTB_INTEL=y
> # CONFIG_NTB_EPF is not set
> # CONFIG_NTB_SWITCHTEC is not set
> CONFIG_NTB_PINGPONG=y
> CONFIG_NTB_TOOL=y
> CONFIG_NTB_PERF=y
> CONFIG_NTB_TRANSPORT=y
> CONFIG_PWM=y
> # CONFIG_PWM_DEBUG is not set
> # CONFIG_PWM_CLK is not set
> # CONFIG_PWM_DWC is not set
> # CONFIG_PWM_GPIO is not set
> CONFIG_PWM_LPSS=y
> CONFIG_PWM_LPSS_PCI=y
> CONFIG_PWM_LPSS_PLATFORM=y
> # CONFIG_PWM_PCA9685 is not set
> 
> #
> # IRQ chip support
> #
> # end of IRQ chip support
> 
> # CONFIG_IPACK_BUS is not set
> # CONFIG_RESET_CONTROLLER is not set
> 
> #
> # PHY Subsystem
> #
> # CONFIG_GENERIC_PHY is not set
> # CONFIG_USB_LGM_PHY is not set
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
> 
> #
> # PHY drivers for Broadcom platforms
> #
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # end of PHY drivers for Broadcom platforms
> 
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_CPCAP_USB is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # end of PHY Subsystem
> 
> CONFIG_POWERCAP=y
> CONFIG_INTEL_RAPL_CORE=y
> CONFIG_INTEL_RAPL=y
> CONFIG_INTEL_RAPL_TPMI=y
> CONFIG_IDLE_INJECT=y
> # CONFIG_MCB is not set
> 
> #
> # Performance monitor support
> #
> # CONFIG_DWC_PCIE_PMU is not set
> CONFIG_CXL_PMU=y
> # end of Performance monitor support
> 
> CONFIG_RAS=y
> # CONFIG_RAS_CEC is not set
> CONFIG_AMD_ATL=m
> CONFIG_AMD_ATL_PRM=y
> CONFIG_RAS_FMPM=m
> CONFIG_USB4=y
> # CONFIG_USB4_DEBUGFS_WRITE is not set
> # CONFIG_USB4_DMA_TEST is not set
> 
> #
> # Android
> #
> # CONFIG_ANDROID_BINDER_IPC is not set
> # end of Android
> 
> CONFIG_LIBNVDIMM=y
> CONFIG_BLK_DEV_PMEM=y
> CONFIG_ND_CLAIM=y
> CONFIG_ND_BTT=y
> CONFIG_BTT=y
> CONFIG_ND_PFN=y
> CONFIG_NVDIMM_PFN=y
> CONFIG_NVDIMM_DAX=y
> CONFIG_NVDIMM_KEYS=y
> # CONFIG_NVDIMM_SECURITY_TEST is not set
> CONFIG_DAX=y
> CONFIG_DEV_DAX=y
> CONFIG_DEV_DAX_PMEM=y
> CONFIG_DEV_DAX_HMEM=y
> CONFIG_DEV_DAX_CXL=y
> CONFIG_DEV_DAX_HMEM_DEVICES=y
> CONFIG_DEV_DAX_KMEM=y
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> # CONFIG_NVMEM_LAYOUTS is not set
> # CONFIG_NVMEM_RMEM is not set
> 
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> CONFIG_INTEL_TH=y
> CONFIG_INTEL_TH_PCI=y
> CONFIG_INTEL_TH_ACPI=y
> CONFIG_INTEL_TH_GTH=y
> CONFIG_INTEL_TH_MSU=y
> CONFIG_INTEL_TH_PTI=y
> # CONFIG_INTEL_TH_DEBUG is not set
> # end of HW tracing support
> 
> # CONFIG_FPGA is not set
> # CONFIG_TEE is not set
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> # CONFIG_MOST is not set
> # CONFIG_PECI is not set
> # CONFIG_HTE is not set
> CONFIG_DPLL=y
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=y
> CONFIG_FS_STACK=y
> CONFIG_BUFFER_HEAD=y
> CONFIG_LEGACY_DIRECT_IO=y
> # CONFIG_EXT2_FS is not set
> CONFIG_EXT3_FS=y
> # CONFIG_EXT3_FS_POSIX_ACL is not set
> # CONFIG_EXT3_FS_SECURITY is not set
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_USE_FOR_EXT2=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=y
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_JFS_FS is not set
> CONFIG_XFS_FS=y
> # CONFIG_XFS_SUPPORT_V4 is not set
> CONFIG_XFS_SUPPORT_ASCII_CI=y
> # CONFIG_XFS_QUOTA is not set
> CONFIG_XFS_POSIX_ACL=y
> # CONFIG_XFS_RT is not set
> # CONFIG_XFS_ONLINE_SCRUB is not set
> # CONFIG_XFS_WARN is not set
> # CONFIG_XFS_DEBUG is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
> # CONFIG_NILFS2_FS is not set
> # CONFIG_F2FS_FS is not set
> # CONFIG_BCACHEFS_FS is not set
> # CONFIG_ZONEFS_FS is not set
> CONFIG_FS_DAX=y
> CONFIG_FS_DAX_PMD=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FS_ENCRYPTION_ALGS=y
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=y
> CONFIG_CUSE=y
> CONFIG_VIRTIO_FS=y
> CONFIG_FUSE_DAX=y
> CONFIG_FUSE_PASSTHROUGH=y
> CONFIG_FUSE_IO_URING=y
> CONFIG_OVERLAY_FS=y
> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> # CONFIG_OVERLAY_FS_INDEX is not set
> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> # CONFIG_OVERLAY_FS_METACOPY is not set
> # CONFIG_OVERLAY_FS_DEBUG is not set
> 
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=y
> CONFIG_NETFS_STATS=y
> # CONFIG_NETFS_DEBUG is not set
> CONFIG_FSCACHE=y
> CONFIG_FSCACHE_STATS=y
> CONFIG_CACHEFILES=y
> # CONFIG_CACHEFILES_DEBUG is not set
> # CONFIG_CACHEFILES_ERROR_INJECTION is not set
> CONFIG_CACHEFILES_ONDEMAND=y
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> # CONFIG_UDF_FS is not set
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> CONFIG_EXFAT_FS=y
> CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
> CONFIG_NTFS3_FS=y
> # CONFIG_NTFS3_64BIT_CLUSTER is not set
> CONFIG_NTFS3_LZX_XPRESS=y
> CONFIG_NTFS3_FS_POSIX_ACL=y
> CONFIG_NTFS_FS=y
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_VMCORE=y
> CONFIG_PROC_VMCORE_DEVICE_DUMP=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_PROC_CPU_RESCTRL=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_TMPFS_XATTR=y
> # CONFIG_TMPFS_INODE64 is not set
> # CONFIG_TMPFS_QUOTA is not set
> CONFIG_HUGETLBFS=y
> # CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
> CONFIG_HUGETLB_PAGE=y
> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
> CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING=y
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> CONFIG_CONFIGFS_FS=y
> CONFIG_EFIVAR_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_ORANGEFS_FS is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_JFFS2_FS is not set
> # CONFIG_UBIFS_FS is not set
> CONFIG_CRAMFS=y
> CONFIG_CRAMFS_BLOCKDEV=y
> # CONFIG_CRAMFS_MTD is not set
> CONFIG_SQUASHFS=y
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=y
> CONFIG_SQUASHFS_DECOMP_SINGLE=y
> # CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
> CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
> # CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
> # CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> # CONFIG_SQUASHFS_LZ4 is not set
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> # CONFIG_SQUASHFS_ZSTD is not set
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_PSTORE=y
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
> CONFIG_PSTORE_COMPRESS=y
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> # CONFIG_PSTORE_FTRACE is not set
> CONFIG_PSTORE_RAM=y
> # CONFIG_PSTORE_BLK is not set
> # CONFIG_UFS_FS is not set
> CONFIG_EROFS_FS=y
> # CONFIG_EROFS_FS_DEBUG is not set
> CONFIG_EROFS_FS_XATTR=y
> CONFIG_EROFS_FS_POSIX_ACL=y
> CONFIG_EROFS_FS_SECURITY=y
> CONFIG_EROFS_FS_BACKED_BY_FILE=y
> # CONFIG_EROFS_FS_ZIP is not set
> CONFIG_EROFS_FS_ONDEMAND=y
> # CONFIG_NETWORK_FILESYSTEMS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="utf8"
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_CODEPAGE_737=y
> CONFIG_NLS_CODEPAGE_775=y
> CONFIG_NLS_CODEPAGE_850=y
> CONFIG_NLS_CODEPAGE_852=y
> CONFIG_NLS_CODEPAGE_855=y
> CONFIG_NLS_CODEPAGE_857=y
> CONFIG_NLS_CODEPAGE_860=y
> CONFIG_NLS_CODEPAGE_861=y
> CONFIG_NLS_CODEPAGE_862=y
> CONFIG_NLS_CODEPAGE_863=y
> CONFIG_NLS_CODEPAGE_864=y
> CONFIG_NLS_CODEPAGE_865=y
> CONFIG_NLS_CODEPAGE_866=y
> CONFIG_NLS_CODEPAGE_869=y
> CONFIG_NLS_CODEPAGE_936=y
> CONFIG_NLS_CODEPAGE_950=y
> CONFIG_NLS_CODEPAGE_932=y
> CONFIG_NLS_CODEPAGE_949=y
> CONFIG_NLS_CODEPAGE_874=y
> CONFIG_NLS_ISO8859_8=y
> CONFIG_NLS_CODEPAGE_1250=y
> CONFIG_NLS_CODEPAGE_1251=y
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=y
> CONFIG_NLS_ISO8859_2=y
> CONFIG_NLS_ISO8859_3=y
> CONFIG_NLS_ISO8859_4=y
> CONFIG_NLS_ISO8859_5=y
> CONFIG_NLS_ISO8859_6=y
> CONFIG_NLS_ISO8859_7=y
> CONFIG_NLS_ISO8859_9=y
> CONFIG_NLS_ISO8859_13=y
> CONFIG_NLS_ISO8859_14=y
> CONFIG_NLS_ISO8859_15=y
> CONFIG_NLS_KOI8_R=y
> CONFIG_NLS_KOI8_U=y
> CONFIG_NLS_MAC_ROMAN=y
> CONFIG_NLS_MAC_CELTIC=y
> CONFIG_NLS_MAC_CENTEURO=y
> CONFIG_NLS_MAC_CROATIAN=y
> CONFIG_NLS_MAC_CYRILLIC=y
> CONFIG_NLS_MAC_GAELIC=y
> CONFIG_NLS_MAC_GREEK=y
> CONFIG_NLS_MAC_ICELAND=y
> CONFIG_NLS_MAC_INUIT=y
> CONFIG_NLS_MAC_ROMANIAN=y
> CONFIG_NLS_MAC_TURKISH=y
> CONFIG_NLS_UTF8=y
> # CONFIG_DLM is not set
> CONFIG_UNICODE=y
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=y
> # CONFIG_BIG_KEYS is not set
> CONFIG_TRUSTED_KEYS=y
> CONFIG_HAVE_TRUSTED_KEYS=y
> CONFIG_TRUSTED_KEYS_TPM=y
> CONFIG_ENCRYPTED_KEYS=y
> # CONFIG_USER_DECRYPTED_DATA is not set
> # CONFIG_KEY_DH_OPERATIONS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_PROC_MEM_ALWAYS_FORCE=y
> # CONFIG_PROC_MEM_FORCE_PTRACE is not set
> # CONFIG_PROC_MEM_NO_FORCE is not set
> CONFIG_SECURITY=y
> CONFIG_HAS_SECURITY_AUDIT=y
> CONFIG_SECURITYFS=y
> CONFIG_SECURITY_NETWORK=y
> CONFIG_SECURITY_NETWORK_XFRM=y
> CONFIG_SECURITY_PATH=y
> CONFIG_INTEL_TXT=y
> CONFIG_LSM_MMAP_MIN_ADDR=65535
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
> CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
> # CONFIG_SECURITY_SELINUX_DEBUG is not set
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> CONFIG_SECURITY_APPARMOR=y
> # CONFIG_SECURITY_APPARMOR_DEBUG is not set
> CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
> CONFIG_SECURITY_APPARMOR_HASH=y
> CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
> CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
> CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=y
> # CONFIG_SECURITY_SAFESETID is not set
> CONFIG_SECURITY_LOCKDOWN_LSM=y
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
> CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
> # CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
> # CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
> # CONFIG_SECURITY_LANDLOCK is not set
> # CONFIG_SECURITY_IPE is not set
> CONFIG_INTEGRITY=y
> CONFIG_INTEGRITY_SIGNATURE=y
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> CONFIG_INTEGRITY_TRUSTED_KEYRING=y
> CONFIG_INTEGRITY_PLATFORM_KEYRING=y
> # CONFIG_INTEGRITY_MACHINE_KEYRING is not set
> CONFIG_LOAD_UEFI_KEYS=y
> CONFIG_INTEGRITY_AUDIT=y
> CONFIG_IMA=y
> # CONFIG_IMA_KEXEC is not set
> CONFIG_IMA_MEASURE_PCR_IDX=10
> CONFIG_IMA_LSM_RULES=y
> CONFIG_IMA_NG_TEMPLATE=y
> # CONFIG_IMA_SIG_TEMPLATE is not set
> CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> # CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
> CONFIG_IMA_DEFAULT_HASH_SHA256=y
> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> # CONFIG_IMA_DEFAULT_HASH_WP512 is not set
> # CONFIG_IMA_DEFAULT_HASH_SM3 is not set
> CONFIG_IMA_DEFAULT_HASH="sha256"
> # CONFIG_IMA_WRITE_POLICY is not set
> CONFIG_IMA_READ_POLICY=y
> CONFIG_IMA_APPRAISE=y
> # CONFIG_IMA_ARCH_POLICY is not set
> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> CONFIG_IMA_APPRAISE_BOOTPARAM=y
> CONFIG_IMA_APPRAISE_MODSIG=y
> # CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
> # CONFIG_IMA_BLACKLIST_KEYRING is not set
> CONFIG_IMA_LOAD_X509=y
> CONFIG_IMA_X509_PATH="/etc/keys/x509_ima.der"
> # CONFIG_IMA_APPRAISE_SIGNED_INIT is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
> # CONFIG_IMA_DISABLE_HTABLE is not set
> CONFIG_EVM=y
> CONFIG_EVM_ATTR_FSUUID=y
> # CONFIG_EVM_ADD_XATTRS is not set
> CONFIG_EVM_LOAD_X509=y
> CONFIG_EVM_X509_PATH="/etc/keys/x509_evm.der"
> CONFIG_DEFAULT_SECURITY_SELINUX=y
> # CONFIG_DEFAULT_SECURITY_APPARMOR is not set
> # CONFIG_DEFAULT_SECURITY_DAC is not set
> CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> # end of Memory initialization
> 
> #
> # Bounds checking
> #
> CONFIG_FORTIFY_SOURCE=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_HARDENED_USERCOPY_DEFAULT_ON=y
> # end of Bounds checking
> 
> #
> # Hardening of kernel data structures
> #
> CONFIG_LIST_HARDENED=y
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # end of Hardening of kernel data structures
> 
> CONFIG_RANDSTRUCT_NONE=y
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_XOR_BLOCKS=y
> CONFIG_ASYNC_CORE=y
> CONFIG_ASYNC_MEMCPY=y
> CONFIG_ASYNC_XOR=y
> CONFIG_ASYNC_PQ=y
> CONFIG_ASYNC_RAID6_RECOV=y
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_FIPS=y
> CONFIG_CRYPTO_FIPS_NAME="Linux Kernel Cryptographic API"
> # CONFIG_CRYPTO_FIPS_CUSTOM_VERSION is not set
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SIG=y
> CONFIG_CRYPTO_SIG2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_HKDF=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> CONFIG_CRYPTO_USER=y
> # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> # CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_PCRYPT=y
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_KRB5ENC is not set
> CONFIG_CRYPTO_TEST=m
> CONFIG_CRYPTO_SIMD=y
> # end of Crypto core or helper
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> # CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
> CONFIG_CRYPTO_ECC=y
> CONFIG_CRYPTO_ECDH=y
> # CONFIG_CRYPTO_ECDSA is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> # end of Public-key cryptography
> 
> #
> # Block ciphers
> #
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_AES_TI is not set
> CONFIG_CRYPTO_ANUBIS=y
> # CONFIG_CRYPTO_ARIA is not set
> CONFIG_CRYPTO_BLOWFISH=y
> CONFIG_CRYPTO_BLOWFISH_COMMON=y
> CONFIG_CRYPTO_CAMELLIA=y
> CONFIG_CRYPTO_CAST_COMMON=y
> CONFIG_CRYPTO_CAST5=y
> CONFIG_CRYPTO_CAST6=y
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_FCRYPT=y
> CONFIG_CRYPTO_KHAZAD=y
> CONFIG_CRYPTO_SEED=y
> CONFIG_CRYPTO_SERPENT=y
> CONFIG_CRYPTO_SM4=y
> CONFIG_CRYPTO_SM4_GENERIC=y
> CONFIG_CRYPTO_TEA=y
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> # end of Block ciphers
> 
> #
> # Length-preserving ciphers and modes
> #
> # CONFIG_CRYPTO_ADIANTUM is not set
> CONFIG_CRYPTO_ARC4=y
> CONFIG_CRYPTO_CHACHA20=y
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> # CONFIG_CRYPTO_HCTR2 is not set
> CONFIG_CRYPTO_LRW=y
> CONFIG_CRYPTO_PCBC=y
> CONFIG_CRYPTO_XTS=y
> CONFIG_CRYPTO_NHPOLY1305=y
> # end of Length-preserving ciphers and modes
> 
> #
> # AEAD (authenticated encryption with associated data) ciphers
> #
> # CONFIG_CRYPTO_AEGIS128 is not set
> CONFIG_CRYPTO_CHACHA20POLY1305=y
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=y
> CONFIG_CRYPTO_GENIV=y
> CONFIG_CRYPTO_SEQIV=y
> CONFIG_CRYPTO_ECHAINIV=y
> CONFIG_CRYPTO_ESSIV=y
> # end of AEAD (authenticated encryption with associated data) ciphers
> 
> #
> # Hashes, digests, and MACs
> #
> CONFIG_CRYPTO_BLAKE2B=y
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=y
> CONFIG_CRYPTO_POLY1305=y
> CONFIG_CRYPTO_RMD160=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=y
> CONFIG_CRYPTO_SM3=y
> CONFIG_CRYPTO_SM3_GENERIC=y
> # CONFIG_CRYPTO_STREEBOG is not set
> CONFIG_CRYPTO_WP512=y
> CONFIG_CRYPTO_XCBC=y
> CONFIG_CRYPTO_XXHASH=y
> # end of Hashes, digests, and MACs
> 
> #
> # CRCs (cyclic redundancy checks)
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32=y
> # end of CRCs (cyclic redundancy checks)
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> CONFIG_CRYPTO_ZSTD=y
> # end of Compression
> 
> #
> # Random number generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=y
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG_HASH=y
> CONFIG_CRYPTO_DRBG_CTR=y
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKS=64
> CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE=32
> CONFIG_CRYPTO_JITTERENTROPY_OSR=1
> # end of Random number generation
> 
> #
> # Userspace interface
> #
> CONFIG_CRYPTO_USER_API=y
> CONFIG_CRYPTO_USER_API_HASH=y
> CONFIG_CRYPTO_USER_API_SKCIPHER=y
> CONFIG_CRYPTO_USER_API_RNG=y
> # CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
> CONFIG_CRYPTO_USER_API_AEAD=y
> CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
> # end of Userspace interface
> 
> CONFIG_CRYPTO_HASH_INFO=y
> 
> #
> # Accelerated Cryptographic Algorithms for CPU (x86)
> #
> CONFIG_CRYPTO_AES_NI_INTEL=y
> CONFIG_CRYPTO_BLOWFISH_X86_64=y
> CONFIG_CRYPTO_CAMELLIA_X86_64=y
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
> CONFIG_CRYPTO_CAST5_AVX_X86_64=y
> CONFIG_CRYPTO_CAST6_AVX_X86_64=y
> CONFIG_CRYPTO_DES3_EDE_X86_64=y
> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
> CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
> CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
> CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=y
> CONFIG_CRYPTO_TWOFISH_X86_64=y
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
> # CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
> # CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
> CONFIG_CRYPTO_CHACHA20_X86_64=y
> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> CONFIG_CRYPTO_NHPOLY1305_SSE2=y
> CONFIG_CRYPTO_NHPOLY1305_AVX2=y
> # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> # CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
> CONFIG_CRYPTO_POLY1305_X86_64=y
> CONFIG_CRYPTO_SHA1_SSSE3=y
> CONFIG_CRYPTO_SHA256_SSSE3=y
> CONFIG_CRYPTO_SHA512_SSSE3=y
> CONFIG_CRYPTO_SM3_AVX_X86_64=y
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
> # end of Accelerated Cryptographic Algorithms for CPU (x86)
> 
> CONFIG_CRYPTO_HW=y
> CONFIG_CRYPTO_DEV_PADLOCK=y
> CONFIG_CRYPTO_DEV_PADLOCK_AES=y
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> CONFIG_CRYPTO_DEV_CCP=y
> CONFIG_CRYPTO_DEV_CCP_DD=y
> CONFIG_CRYPTO_DEV_SP_CCP=y
> CONFIG_CRYPTO_DEV_CCP_CRYPTO=y
> CONFIG_CRYPTO_DEV_SP_PSP=y
> # CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
> CONFIG_CRYPTO_DEV_NITROX=y
> CONFIG_CRYPTO_DEV_NITROX_CNN55XX=y
> CONFIG_CRYPTO_DEV_QAT=y
> CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
> CONFIG_CRYPTO_DEV_QAT_C3XXX=y
> CONFIG_CRYPTO_DEV_QAT_C62X=y
> CONFIG_CRYPTO_DEV_QAT_4XXX=y
> # CONFIG_CRYPTO_DEV_QAT_420XX is not set
> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
> CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
> CONFIG_CRYPTO_DEV_QAT_C62XVF=y
> # CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION is not set
> CONFIG_CRYPTO_DEV_IAA_CRYPTO=m
> CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS=y
> CONFIG_CRYPTO_DEV_CHELSIO=y
> # CONFIG_CRYPTO_DEV_VIRTIO is not set
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> CONFIG_SIGNED_PE_FILE_VERIFICATION=y
> # CONFIG_FIPS_SIGNATURE_SELFTEST is not set
> 
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> CONFIG_SECONDARY_TRUSTED_KEYRING=y
> # CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN is not set
> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> CONFIG_SYSTEM_REVOCATION_LIST=y
> CONFIG_SYSTEM_REVOCATION_KEYS=""
> # CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
> # end of Certificates for signature checking
> 
> # CONFIG_CRYPTO_KRB5 is not set
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=y
> CONFIG_RAID6_PQ_BENCHMARK=y
> CONFIG_PACKING=y
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_CORDIC=y
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_UTILS=y
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_AESCFB=y
> CONFIG_CRYPTO_LIB_AESGCM=y
> CONFIG_CRYPTO_LIB_ARC4=y
> CONFIG_CRYPTO_LIB_GF128MUL=y
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA_INTERNAL=y
> CONFIG_CRYPTO_LIB_DES=y
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
> CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> CONFIG_CRYPTO_LIB_POLY1305_INTERNAL=y
> CONFIG_CRYPTO_LIB_SHA1=y
> CONFIG_CRYPTO_LIB_SHA256=y
> # end of Crypto library routines
> 
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_ARCH_HAS_CRC_T10DIF=y
> CONFIG_CRC_T10DIF_ARCH=y
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> CONFIG_ARCH_HAS_CRC32=y
> CONFIG_CRC32_ARCH=y
> CONFIG_CRC64=y
> CONFIG_ARCH_HAS_CRC64=y
> CONFIG_CRC64_ARCH=y
> CONFIG_CRC8=y
> CONFIG_CRC_OPTIMIZATIONS=y
> CONFIG_XXHASH=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMMON=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_ARM64=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_RISCV=y
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_DECOMPRESS_ZSTD=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=y
> CONFIG_REED_SOLOMON_ENC8=y
> CONFIG_REED_SOLOMON_DEC8=y
> CONFIG_TEXTSEARCH=y
> CONFIG_TEXTSEARCH_KMP=y
> CONFIG_TEXTSEARCH_BM=y
> CONFIG_TEXTSEARCH_FSM=y
> CONFIG_BTREE=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_INTERVAL_TREE_SPAN_ITER=y
> CONFIG_XARRAY_MULTI=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_CLOSURES=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_DMA_OPS_HELPERS=y
> CONFIG_NEED_SG_DMA_FLAGS=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
> CONFIG_SWIOTLB=y
> # CONFIG_SWIOTLB_DYNAMIC is not set
> CONFIG_DMA_NEED_SYNC=y
> CONFIG_DMA_COHERENT_POOL=y
> CONFIG_DMA_CMA=y
> # CONFIG_DMA_NUMA_CMA is not set
> 
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=0
> CONFIG_CMA_SIZE_SEL_MBYTES=y
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> # CONFIG_CMA_SIZE_SEL_MAX is not set
> CONFIG_CMA_ALIGNMENT=8
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_CPUMASK_OFFSTACK=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_SIGNATURE=y
> CONFIG_DIMLIB=y
> CONFIG_OID_REGISTRY=y
> CONFIG_UCS2_STRING=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT=y
> CONFIG_VDSO_GETRANDOM=y
> CONFIG_GENERIC_VDSO_DATA_STORE=y
> CONFIG_FONT_SUPPORT=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_HAS_PMEM_API=y
> CONFIG_MEMREGION=y
> CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> CONFIG_ARCH_HAS_COPY_MC=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_STACKDEPOT_ALWAYS_INIT=y
> CONFIG_STACKDEPOT_MAX_FRAMES=64
> CONFIG_REF_TRACKER=y
> CONFIG_SBITMAP=y
> CONFIG_PARMAN=y
> CONFIG_OBJAGG=y
> # CONFIG_LWQ_TEST is not set
> # end of Library routines
> 
> CONFIG_PLDMFW=y
> CONFIG_ASN1_ENCODER=y
> CONFIG_FIRMWARE_TABLE=y
> CONFIG_UNION_FIND=y
> CONFIG_MIN_HEAP=y
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_PRINTK_CALLER=y
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_BOOT_PRINTK_DELAY=y
> CONFIG_DYNAMIC_DEBUG=y
> CONFIG_DYNAMIC_DEBUG_CORE=y
> CONFIG_SYMBOLIC_ERRNAME=y
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_AS_HAS_NON_CONST_ULEB128=y
> # CONFIG_DEBUG_INFO_NONE is not set
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> CONFIG_DEBUG_INFO_DWARF4=y
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> # CONFIG_DEBUG_INFO_REDUCED is not set
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
> # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_DEBUG_INFO_BTF=y
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
> CONFIG_DEBUG_INFO_BTF_MODULES=y
> # CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=2048
> CONFIG_STRIP_ASM_SYMS=y
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_OBJTOOL=y
> # CONFIG_OBJTOOL_WERROR is not set
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> CONFIG_DEBUG_FS=y
> CONFIG_DEBUG_FS_ALLOW_ALL=y
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=y
> CONFIG_KGDB=y
> CONFIG_KGDB_HONOUR_BLOCKLIST=y
> CONFIG_KGDB_SERIAL_CONSOLE=y
> CONFIG_KGDB_TESTS=y
> # CONFIG_KGDB_TESTS_ON_BOOT is not set
> CONFIG_KGDB_LOW_LEVEL_TRAP=y
> CONFIG_KGDB_KDB=y
> CONFIG_KDB_DEFAULT_ENABLE=0x0
> CONFIG_KDB_KEYBOARD=y
> CONFIG_KDB_CONTINUE_CATASTROPHIC=0
> CONFIG_ARCH_HAS_EARLY_DEBUG=y
> CONFIG_ARCH_HAS_UBSAN=y
> # CONFIG_UBSAN is not set
> CONFIG_HAVE_ARCH_KCSAN=y
> # end of Generic Kernel Debugging Instruments
> 
> #
> # Networking Debugging
> #
> CONFIG_NET_DEV_REFCNT_TRACKER=y
> CONFIG_NET_NS_REFCNT_TRACKER=y
> # CONFIG_DEBUG_NET is not set
> # CONFIG_DEBUG_NET_SMALL_RTNL is not set
> # end of Networking Debugging
> 
> #
> # Memory Debugging
> #
> # CONFIG_PAGE_EXTENSION is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_SLUB_DEBUG=y
> # CONFIG_SLUB_DEBUG_ON is not set
> CONFIG_SLUB_RCU_DEBUG=y
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_TABLE_CHECK is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=y
> # CONFIG_DEBUG_WX is not set
> CONFIG_ARCH_HAS_PTDUMP=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
> # CONFIG_PER_VMA_LOCK_STATS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SHRINKER_DEBUG is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> # CONFIG_DEBUG_VFS is not set
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_VIRTUAL is not set
> CONFIG_DEBUG_MEMORY_INIT=y
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> # CONFIG_MEM_ALLOC_PROFILING is not set
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> CONFIG_KASAN=y
> CONFIG_KASAN_GENERIC=y
> # CONFIG_KASAN_OUTLINE is not set
> CONFIG_KASAN_INLINE=y
> CONFIG_KASAN_STACK=y
> # CONFIG_KASAN_VMALLOC is not set
> # CONFIG_KASAN_EXTRA_INFO is not set
> CONFIG_HAVE_ARCH_KFENCE=y
> # CONFIG_KFENCE is not set
> CONFIG_HAVE_ARCH_KMSAN=y
> # end of Memory Debugging
> 
> CONFIG_DEBUG_SHIRQ=y
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> # CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM is not set
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> # CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY is not set
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> # CONFIG_HARDLOCKUP_DETECTOR_BUDDY is not set
> # CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set
> CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=y
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_DETECT_HUNG_TASK_BLOCKER=y
> # CONFIG_WQ_WATCHDOG is not set
> # CONFIG_WQ_CPU_INTENSIVE_REPORT is not set
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> # CONFIG_DEBUG_PREEMPT is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> # CONFIG_NMI_CHECK_CPU is not set
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=y
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_DEBUG_CLOSURES is not set
> # CONFIG_DEBUG_MAPLE_TREE is not set
> # end of Debug kernel data structures
> 
> #
> # RCU Debugging
> #
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=60
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
> # CONFIG_RCU_CPU_STALL_CPUTIME is not set
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> # CONFIG_LATENCYTOP is not set
> # CONFIG_DEBUG_CGROUP_REF is not set
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_RETHOOK=y
> CONFIG_RETHOOK=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_FREGS=y
> CONFIG_HAVE_FTRACE_GRAPH_FUNC=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
> CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_FENTRY=y
> CONFIG_HAVE_OBJTOOL_MCOUNT=y
> CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
> CONFIG_BUILDTIME_MCOUNT_SORT=y
> CONFIG_TRACER_MAX_TRACE=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> CONFIG_BOOTTIME_TRACING=y
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> # CONFIG_FUNCTION_GRAPH_RETVAL is not set
> # CONFIG_FUNCTION_GRAPH_RETADDR is not set
> CONFIG_FUNCTION_TRACE_ARGS=y
> CONFIG_DYNAMIC_FTRACE=y
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
> # CONFIG_FPROBE is not set
> CONFIG_FUNCTION_PROFILER=y
> CONFIG_STACK_TRACER=y
> # CONFIG_IRQSOFF_TRACER is not set
> # CONFIG_PREEMPT_TRACER is not set
> CONFIG_SCHED_TRACER=y
> CONFIG_HWLAT_TRACER=y
> CONFIG_OSNOISE_TRACER=y
> CONFIG_TIMERLAT_TRACER=y
> # CONFIG_MMIOTRACE is not set
> CONFIG_FTRACE_SYSCALLS=y
> CONFIG_TRACER_SNAPSHOT=y
> # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> CONFIG_BRANCH_PROFILE_NONE=y
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> CONFIG_BLK_DEV_IO_TRACE=y
> CONFIG_PROBE_EVENTS_BTF_ARGS=y
> CONFIG_KPROBE_EVENTS=y
> # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> CONFIG_UPROBE_EVENTS=y
> CONFIG_BPF_EVENTS=y
> CONFIG_DYNAMIC_EVENTS=y
> CONFIG_PROBE_EVENTS=y
> # CONFIG_BPF_KPROBE_OVERRIDE is not set
> CONFIG_FTRACE_MCOUNT_RECORD=y
> CONFIG_FTRACE_MCOUNT_USE_CC=y
> CONFIG_TRACING_MAP=y
> CONFIG_SYNTH_EVENTS=y
> # CONFIG_USER_EVENTS is not set
> CONFIG_HIST_TRIGGERS=y
> # CONFIG_TRACE_EVENT_INJECT is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> # CONFIG_RING_BUFFER_BENCHMARK is not set
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> # CONFIG_FTRACE_RECORD_RECURSION is not set
> # CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_FTRACE_SORT_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> # CONFIG_SYNTH_EVENT_GEN_TEST is not set
> # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> # CONFIG_HIST_TRIGGERS_DEBUG is not set
> # CONFIG_RV is not set
> CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_STRICT_DEVMEM=y
> # CONFIG_IO_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_EARLY_PRINTK_USB=y
> # CONFIG_X86_VERBOSE_BOOTUP is not set
> CONFIG_EARLY_PRINTK=y
> CONFIG_EARLY_PRINTK_DBGP=y
> CONFIG_EARLY_PRINTK_USB_XDBC=y
> # CONFIG_EFI_PGT_DUMP is not set
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> CONFIG_X86_DECODER_SELFTEST=y
> CONFIG_IO_DELAY_0X80=y
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEBUG_BOOT_PARAMS=y
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_ORC=y
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FUNCTION_ERROR_INJECTION=y
> CONFIG_FAULT_INJECTION=y
> CONFIG_FAILSLAB=y
> CONFIG_FAIL_PAGE_ALLOC=y
> CONFIG_FAULT_INJECTION_USERCOPY=y
> CONFIG_FAIL_MAKE_REQUEST=y
> CONFIG_FAIL_IO_TIMEOUT=y
> CONFIG_FAIL_FUTEX=y
> CONFIG_FAULT_INJECTION_DEBUG_FS=y
> CONFIG_FAIL_FUNCTION=y
> CONFIG_FAIL_MMC_REQUEST=y
> # CONFIG_FAIL_SKB_REALLOC is not set
> CONFIG_FAULT_INJECTION_CONFIGFS=y
> # CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> CONFIG_KCOV=y
> CONFIG_KCOV_ENABLE_COMPARISONS=y
> CONFIG_KCOV_INSTRUMENT_ALL=y
> CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
> # CONFIG_KCOV_SELFTEST is not set
> # CONFIG_RUNTIME_TESTING_MENU is not set
> CONFIG_ARCH_USE_MEMTEST=y
> # CONFIG_MEMTEST is not set
> # CONFIG_HYPERV_TESTING is not set
> # end of Kernel Testing and Coverage
> 
> #
> # Rust hacking
> #
> # end of Rust hacking
> # end of Kernel hacking
> 
> CONFIG_IO_URING_ZCRX=y

