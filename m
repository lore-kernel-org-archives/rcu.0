Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A603B0586
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813752; cv=none; b=fnAIyvciOoEmSO+qv9i27ZgxcKhMTp/jySuuOesp5A0t7t7fRjvYLaiM0AZH4VzVYZNEjY73cJfwcZQCX3g3gI6RSPAUSH/z4TNzO/E8RS+hcsyccp9x697s2LBHhnPz7Xtd7BmJ9r5mLxJE7QeM4MD4uhdWnnNjYfzSnEMpDHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813752; c=relaxed/simple;
	bh=E4DBlrpx9K3rsq7SrfjPT7sDeGjZgxVnmKr4XZiSc4A=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=DgZfzsvq55r669KQLVtXE4z6CH2KRvhdJeqAzgaDA8d/5JaCLyFE0c2kAslIZUNFcsm3sUh51HXNP+5e2PwLTsgqEYnU+5RV4KUfXrGdOKeFBHGlPS3NFKTbayOHpfxkXgj1ipt8p3YPvM/TrWfcmqmT2UxtqNf8ef5WAeFtBzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=NwJVfQWK; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=0+VXbwlS; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="NwJVfQWK";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="0+VXbwlS"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788813738; bh=WEv8aY73KJJT4gDCLJhWwYT
	HmE6dl/huMU4w3u/CPT4=; b=NwJVfQWKyx3s0n+h3JfvUpMB+ZvXmCHGPZ44VhSUMoUknmi7Ff
	EkFjaZSOKb5DbJ16yexqoaCbfYPd37bKPGXtv8CPhqpeS90AJEl+lLG78XiLWpNTuOWTEYBbiVP
	e/2A966mmRlEVh2iuvaGfoV666H1Hukclqj3fz4UdMXxs6AhL/4QHLC7w8LfbmqAEMGGGNL/EmI
	myboLGr2WneIR1EuyIAUGPSdsUz1uFv6wYkjcXoqgh1lf9SfDdf5x7AF1qxRP1Lp5ewAg1D8Ow9
	OA4yQzp51vJgr85qrsrL9GPr1p4hTNQqgr0HDFJdi0QjSonLeuwYIXSSz54m4nIeElA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788813738; bh=WEv8aY73KJJT4gDCLJhWwYT
	HmE6dl/huMU4w3u/CPT4=; b=0+VXbwlSD9XlRylYOVTEuCggG9+8w5aq95DdiyzGcs+1/lHLbu
	9tCdAHY+LtENU0DLbFL45o06oRxn/Tiq/uCQ==;
Date: Mon, 07 Sep 2026 21:42:19 +0100
From: Bradley Morgan <brads@mainlining.org>
To: yi1.lai@intel.com
CC: boqun@kernel.org, lkp@intel.com, mathieu.desnoyers@efficios.com,
 oe-lkp@lists.linux.dev, paulmck@kernel.org, rcu@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bpaulmckrcu=3Anon-rcu/n?=
 =?US-ASCII?Q?ext=5D_=5Bhazptrtorture=5D_9b08?=
 =?US-ASCII?Q?a09f6d=3A_BUG=3Akernel=5FNULL=5Fp?=
 =?US-ASCII?Q?ointer=5Fdereference=2Caddress?=
In-Reply-To: <202608130915.62b53936-lkp@intel.com>
Message-ID: <9D3C10DF-2BA2-4F97-AAB1-C36AF227F6B3@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 13 August 2026 07:49:31 BST, kernel test robot <yi1.lai@intel.com>
wrote:
>
>
>Hello,
>
>kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address"
>on:
>
>commit: 9b08a09f6d073bebd38e7be08781b0a4758c924e ("hazptrtorture: Defer release of hazard pointers") https://github.com/paulmckrcu/linux non-rcu/next
>
>[test failed on linux-next/master
>6b8c8af514d739d0335f5579b585e02babe8a727]
>
>in testcase: trinity
>version: trinity-i386-abe9de86-1_20230429 with following parameters:
>
>	runtime: 300s
>	group: group-00
>	nr_groups: 5
>	reproduction: run 254 cycles, the issue can be reproduced for 16 times.
>
>
>config: i386-randconfig-015-20260807
>compiler: clang-22
>test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>
>(please refer to attached dmesg/kmsg for entire log/backtrace)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new
>version of the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <yi1.lai@intel.com>
>| Closes:
>https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
>
>
>
>[  419.412561][   T52] BUG: kernel NULL pointer dereference, address:
>00000108
>[  419.456670][   T52] #PF: supervisor read access in kernel mode
>[  419.495649][   T52] #PF: error_code(0x0000) - not-present page
>[  419.534113][   T52] *pde = 00000000
>[  419.554661][   T52] Oops: Oops: 0000 [#1] SMP
>[  419.579287][   T52] CPU: 0 UID: 0 PID: 52 Comm: hazptr_torture_
>Tainted: G        W           7.2.0-rc3-00011-g9b08a09f6d07 #1 PREEMPTLAZY
> 809133f67ba61c2271624f9b1ff820a8a212cdad
>[  419.666331][   T52] Tainted: [W]=WARN
>[  419.686632][   T52] Hardware name: QEMU Standard PC (i440FX + PIIX,
>1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>[  419.731225][   T52] EIP: hazptr_synchronize_overflow_list+0x43/0xc0
>[  419.767103][   T52] Code: 30 8b 4e 34 90 90 90 89 4d e8 89 7d ec 8d 46
>2c 89 45 f0 8b 45 f0 8b 00 89 45 f0 85 c0 74 67 90 90 90 90 90 90 90 90 8b
>45 f0 <8b> 40 08 3b 45 e4 0f 95 c3 83 f8 01 0f 95 c7 89 f0 e8 67 bc fe 00
>All code
>========
>   0:	30 8b 4e 34 90 90    	xor    %cl,-0x6f6fcbb2(%rbx)
>   6:	90                   	nop
>   7:	89 4d e8             	mov    %ecx,-0x18(%rbp)
>   a:	89 7d ec             	mov    %edi,-0x14(%rbp)
>   d:	8d 46 2c             	lea    0x2c(%rsi),%eax
>  10:	89 45 f0             	mov    %eax,-0x10(%rbp)
>  13:	8b 45 f0             	mov    -0x10(%rbp),%eax
>  16:	8b 00                	mov    (%rax),%eax
>  18:	89 45 f0             	mov    %eax,-0x10(%rbp)
>  1b:	85 c0                	test   %eax,%eax
>  1d:	74 67                	je     0x86
>  1f:	90                   	nop
>  20:	90                   	nop
>  21:	90                   	nop
>  22:	90                   	nop
>  23:	90                   	nop
>  24:	90                   	nop
>  25:	90                   	nop
>  26:	90                   	nop
>  27:	8b 45 f0             	mov    -0x10(%rbp),%eax
>  2a:*	8b 40 08             	mov    0x8(%rax),%eax		<-- trapping instruction
>  2d:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
>  30:	0f 95 c3             	setne  %bl
>  33:	83 f8 01             	cmp    $0x1,%eax
>  36:	0f 95 c7             	setne  %bh
>  39:	89 f0                	mov    %esi,%eax
>  3b:	e8 67 bc fe 00       	call   0xfebca7
>
>Code starting with the faulting instruction
>===========================================
>   0:	8b 40 08             	mov    0x8(%rax),%eax
>   3:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
>   6:	0f 95 c3             	setne  %bl
>   9:	83 f8 01             	cmp    $0x1,%eax
>   c:	0f 95 c7             	setne  %bh
>   f:	89 f0                	mov    %esi,%eax
>  11:	e8 67 bc fe 00       	call   0xfebc7d
>[  419.872228][   T52] EAX: 00000100 EBX: 00000000 ECX: 00000000 EDX:
>00000202
>[  419.904569][   T52] ESI: e4f7e13c EDI: 00000829 EBP: b3e9df20 ESP:
>b3e9df04
>[  419.941247][   T52] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
>EFLAGS: 00010006
>[  419.980096][   T52] CR0: 80050033 CR2: 00000108 CR3: 05fb1000 CR4:
>00000690
>[  420.005370][   T52] Call Trace:
>[  420.022998][   T52]  hazptr_synchronize+0x166/0x200
>[  420.050473][   T52]  hazptr_torture_writer+0x153/0x400
>[  420.076986][   T52]  ? __kthread_parkme+0x4b/0x100
>[  420.094745][   T52]  kthread+0x107/0x140
>[  420.112829][   T52]  ? hazptr_torture_reader+0x340/0x340
>[  420.140468][   T52]  ? kthread_unuse_mm+0xc0/0xc0
>[  420.165878][   T52]  ? kthread_unuse_mm+0xc0/0xc0
>[  420.185387][   T52]  ret_from_fork+0x131/0x240
>[  420.207521][   T52]  ? kthread_unuse_mm+0xc0/0xc0
>[  420.231501][   T52]  ret_from_fork_asm+0x12/0x20
>[  420.256219][   T52]  entry_INT80_32+0x125/0x125
>[  420.280981][   T52] Modules linked in: ipmi_devintf ppdev rapl
>i2c_piix4 tpm_tis tpm_tis_core i2c_smbus tpm i2c_core ata_generic i6300esb
>libata parport_pc rtc_cmos parport fuse
>[  420.365047][   T52] CR2: 0000000000000108
>[  420.387629][   T52] ---[ end trace 0000000000000000 ]---
>[  420.416535][   T52] EIP: hazptr_synchronize_overflow_list+0x43/0xc0
>[  420.451442][   T52] Code: 30 8b 4e 34 90 90 90 89 4d e8 89 7d ec 8d 46
>2c 89 45 f0 8b 45 f0 8b 00 89 45 f0 85 c0 74 67 90 90 90 90 90 90 90 90 8b
>45 f0 <8b> 40 08 3b 45 e4 0f 95 c3 83 f8 01 0f 95 c7 89 f0 e8 67 bc fe 00
>All code
>========
>   0:	30 8b 4e 34 90 90    	xor    %cl,-0x6f6fcbb2(%rbx)
>   6:	90                   	nop
>   7:	89 4d e8             	mov    %ecx,-0x18(%rbp)
>   a:	89 7d ec             	mov    %edi,-0x14(%rbp)
>   d:	8d 46 2c             	lea    0x2c(%rsi),%eax
>  10:	89 45 f0             	mov    %eax,-0x10(%rbp)
>  13:	8b 45 f0             	mov    -0x10(%rbp),%eax
>  16:	8b 00                	mov    (%rax),%eax
>  18:	89 45 f0             	mov    %eax,-0x10(%rbp)
>  1b:	85 c0                	test   %eax,%eax
>  1d:	74 67                	je     0x86
>  1f:	90                   	nop
>  20:	90                   	nop
>  21:	90                   	nop
>  22:	90                   	nop
>  23:	90                   	nop
>  24:	90                   	nop
>  25:	90                   	nop
>  26:	90                   	nop
>  27:	8b 45 f0             	mov    -0x10(%rbp),%eax
>  2a:*	8b 40 08             	mov    0x8(%rax),%eax		<-- trapping instruction
>  2d:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
>  30:	0f 95 c3             	setne  %bl
>  33:	83 f8 01             	cmp    $0x1,%eax
>  36:	0f 95 c7             	setne  %bh
>  39:	89 f0                	mov    %esi,%eax
>  3b:	e8 67 bc fe 00       	call   0xfebca7
>
>Code starting with the faulting instruction
>===========================================
>   0:	8b 40 08             	mov    0x8(%rax),%eax
>   3:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
>   6:	0f 95 c3             	setne  %bl
>   9:	83 f8 01             	cmp    $0x1,%eax
>   c:	0f 95 c7             	setne  %bh
>   f:	89 f0                	mov    %esi,%eax
>  11:	e8 67 bc fe 00       	call   0xfebc7d
>
>
>The kernel config and materials to reproduce are available at:
>https://download.01.org/0day-ci/archive/20260813/202608130915.62b53936-lkp@intel.com
>
>
>
>--
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki
>
>
>
>
Hi, could anybody test if this fixes it?


From 3e92b8153c31106d6a080e1c9bbe9bf1e86e1f63 Mon Sep 17 00:00:00 2001
From: Bradley Morgan <brads@mainlining.org>
Date: Mon, 7 Sep 2026 18:00:08 +0000
Subject: [PATCH] hazptrtorture: Only detach acquired hazard pointers

hazptr_torture_acquire() detaches unconditionally, even when the
readlock fails. A failed acquire leaves nothing to detach, but the
detach still promotes the context to its backup slot and chains that
slot into the running CPU's overflow list. The reader then retries on
its own CPU, the fast path hands out a per-CPU slot and overwrites
ctx->slot, and the chained backup node is orphaned, still linked,
with nobody left to unchain it.

The next detach of the same context chains the same node a second
time, into another CPU's list, and the node ends up reachable from
both. The eventual release unchains it once, hlist_del() poisons
node->next, and the first list is left pointing at the poisoned node.
The writer's next hazptr_synchronize() walks that list, steps onto
LIST_POISON1 (0x100 on i386, where POISON_POINTER_DELTA is 0), and
reads slot.addr at offset 8 of the backup slot, address 0x108, which
is the crash the robot hit.

  cpuA (IPI acquire)     cpuR (reader)          cpuD (do_pending)
  ---------------------  ---------------------  -------------------
  readlock() returns
    NULL
  detach chains the
    backup node into
    cpuA list
                         hpp_htp is NULL,
                           continue
                         reacquire, ctx->slot
                           is now a cpuR
                           per-CPU slot
                         acquire succeeds,
                           defer, detach chains
                           the SAME node into
                           cpuR list
                                                release, unchain
                                                  once, node->next
                                                  is POISON1
                                                kfree(hppp)
  synchronize walks cpuA
    list, node->next is
    0x100, reads 0x108,
    Oops

Skip the detach when the acquire failed. The slot holds NULL in that
case, note_context_switch() and the synchronize scanners skip NULL
slots, and the next acquire overwrites ctx->slot, so leaving the
context attached is safe.

The robot's original report was against the defer path before detach
existed, which 4bd7f458229a fixed. This is the same crash surviving
through the IPI acquire path that 6357ec235c59 added.

Fixes: 6357ec235c59 ("hazptrtorture: Fix hazptr ownership issue")
Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/rcu/hazptrtorture.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 7c8b589..267f262 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -373,8 +373,11 @@ static void hazptr_torture_acquire(void *hppp_in)
 	/*
 	 * Acquiring a hazard pointer from a remote CPU.
 	 * Detach hazptr from its task so it can be released by another task.
+	 * A failed acquire has nothing to detach, and detaching one anyway
+	 * orphans the chained backup slot on this CPU's overflow list.
 	 */
-	hazptr_detach(&hppp->hpp_hc);
+	if (hppp->hpp_htp)
+		hazptr_detach(&hppp->hpp_hc);
 	atomic_long_inc(per_cpu_ptr(&hazptr_torture_acquires_irq, raw_smp_processor_id()));
 }
 
-- 
2.47.3


--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
