Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E69F413D62
	for <rcu@vger.kernel.org>; Thu, 13 Aug 2026 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603780; cv=none; b=aLeHYym95qWbDXBgq79qZ+96uWzIdCMZVbcUB+WOQpm2lzlHHnx1sbGRZWvNglBIU4zy80NfX7PALzfk6F9U7db9KHJuRPqmQDVSGGtdmI+X81dqlXtcnpiCY7Y4P0aQ22okB/NFFw6MWwx0Iila/nS0WE3SBNLuWWN3Be6/SIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603780; c=relaxed/simple;
	bh=zjej5DS0bsfxfxbsF8cZMOUS4c8WA6q6Hfn3aXF69YI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kq+oxt09KeJ0Fm69BMFnCHVAvch2NAQjazHHCMtDfBDV4nIe5YtR9AFWWZKQ28KVcEmLWiQ09ERe2IEUcfoFge14fdQzTVXl3FxZG/4QJ5MR9wbBnDxugaGVd2OzhB8jG5j1VwJq8UGf2m/dxmJEk+Xl9/NDFiYz1a04ya6BjxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMpEX2jC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMpEX2jC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786603778; x=1818139778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zjej5DS0bsfxfxbsF8cZMOUS4c8WA6q6Hfn3aXF69YI=;
  b=aMpEX2jCC7k57wqjQt4AsJ5RcaQv0O6knlQcXTUB8FsF/rGUnSkNZzQ9
   mmHFeyNvcjf9b3nifkiy12UxXnFA75Lr5bCpIdjg/Zxgrm9xlaD9xy5uT
   EaN9xTp2MFTgllPb+DrWgqNgGkQXj8d+vbEa5d7e68TtsVqo0ucR3Q+Ss
   KCqxCTwRil0HWwDpKFNF4e8Y+bWzvvVuYQmOQTDS96/7UZZTCaJgm76Lr
   dQEsQl+SBzwN3QZ2e+Yy5mX+0DB4vcVmutx6NB+H86ZyJQEcAXuqhRFrK
   csxxy6VTa0v6+FW8/v4BXOlzgKdOZ8FhPROKQZAnV0wXxLKML8tpGbqTR
   A==;
X-CSE-ConnectionGUID: 1bzdvIB9T9OfooYGjrAtfA==
X-CSE-MsgGUID: bfWuTvP0SgaY39GrOzAKBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87051282"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87051282"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:49:37 -0700
X-CSE-ConnectionGUID: dEXqSifzRvK8E4bkVacJRw==
X-CSE-MsgGUID: IzCdM1JiQQGMCokNGRLV1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="269042149"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:49:35 -0700
Date: Thu, 13 Aug 2026 14:49:31 +0800
From: kernel test robot <yi1.lai@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Boqun Feng <boqun@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	rcu@vger.kernel.org, yi1.lai@intel.com
Subject: [paulmckrcu:non-rcu/next] [hazptrtorture] 9b08a09f6d:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202608130915.62b53936-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 9b08a09f6d073bebd38e7be08781b0a4758c924e ("hazptrtorture: Defer release of hazard pointers") https://github.com/paulmckrcu/linux non-rcu/next

[test failed on linux-next/master 6b8c8af514d739d0335f5579b585e02babe8a727]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429 with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5
	reproduction: run 254 cycles, the issue can be reproduced for 16 times.


config: i386-randconfig-015-20260807
compiler: clang-22
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)

If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com



[  419.412561][   T52] BUG: kernel NULL pointer dereference, address: 00000108
[  419.456670][   T52] #PF: supervisor read access in kernel mode
[  419.495649][   T52] #PF: error_code(0x0000) - not-present page
[  419.534113][   T52] *pde = 00000000
[  419.554661][   T52] Oops: Oops: 0000 [#1] SMP
[  419.579287][   T52] CPU: 0 UID: 0 PID: 52 Comm: hazptr_torture_ Tainted: G        W           7.2.0-rc3-00011-g9b08a09f6d07 #1 PREEMPTLAZY  809133f67ba61c2271624f9b1ff820a8a212cdad
[  419.666331][   T52] Tainted: [W]=WARN
[  419.686632][   T52] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  419.731225][   T52] EIP: hazptr_synchronize_overflow_list+0x43/0xc0
[  419.767103][   T52] Code: 30 8b 4e 34 90 90 90 89 4d e8 89 7d ec 8d 46 2c 89 45 f0 8b 45 f0 8b 00 89 45 f0 85 c0 74 67 90 90 90 90 90 90 90 90 8b 45 f0 <8b> 40 08 3b 45 e4 0f 95 c3 83 f8 01 0f 95 c7 89 f0 e8 67 bc fe 00
All code
========
   0:	30 8b 4e 34 90 90    	xor    %cl,-0x6f6fcbb2(%rbx)
   6:	90                   	nop
   7:	89 4d e8             	mov    %ecx,-0x18(%rbp)
   a:	89 7d ec             	mov    %edi,-0x14(%rbp)
   d:	8d 46 2c             	lea    0x2c(%rsi),%eax
  10:	89 45 f0             	mov    %eax,-0x10(%rbp)
  13:	8b 45 f0             	mov    -0x10(%rbp),%eax
  16:	8b 00                	mov    (%rax),%eax
  18:	89 45 f0             	mov    %eax,-0x10(%rbp)
  1b:	85 c0                	test   %eax,%eax
  1d:	74 67                	je     0x86
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	90                   	nop
  26:	90                   	nop
  27:	8b 45 f0             	mov    -0x10(%rbp),%eax
  2a:*	8b 40 08             	mov    0x8(%rax),%eax		<-- trapping instruction
  2d:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  30:	0f 95 c3             	setne  %bl
  33:	83 f8 01             	cmp    $0x1,%eax
  36:	0f 95 c7             	setne  %bh
  39:	89 f0                	mov    %esi,%eax
  3b:	e8 67 bc fe 00       	call   0xfebca7

Code starting with the faulting instruction ===========================================
   0:	8b 40 08             	mov    0x8(%rax),%eax
   3:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
   6:	0f 95 c3             	setne  %bl
   9:	83 f8 01             	cmp    $0x1,%eax
   c:	0f 95 c7             	setne  %bh
   f:	89 f0                	mov    %esi,%eax
  11:	e8 67 bc fe 00       	call   0xfebc7d
[  419.872228][   T52] EAX: 00000100 EBX: 00000000 ECX: 00000000 EDX: 00000202
[  419.904569][   T52] ESI: e4f7e13c EDI: 00000829 EBP: b3e9df20 ESP: b3e9df04
[  419.941247][   T52] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010006
[  419.980096][   T52] CR0: 80050033 CR2: 00000108 CR3: 05fb1000 CR4: 00000690
[  420.005370][   T52] Call Trace:
[  420.022998][   T52]  hazptr_synchronize+0x166/0x200
[  420.050473][   T52]  hazptr_torture_writer+0x153/0x400
[  420.076986][   T52]  ? __kthread_parkme+0x4b/0x100
[  420.094745][   T52]  kthread+0x107/0x140
[  420.112829][   T52]  ? hazptr_torture_reader+0x340/0x340
[  420.140468][   T52]  ? kthread_unuse_mm+0xc0/0xc0
[  420.165878][   T52]  ? kthread_unuse_mm+0xc0/0xc0
[  420.185387][   T52]  ret_from_fork+0x131/0x240
[  420.207521][   T52]  ? kthread_unuse_mm+0xc0/0xc0
[  420.231501][   T52]  ret_from_fork_asm+0x12/0x20
[  420.256219][   T52]  entry_INT80_32+0x125/0x125
[  420.280981][   T52] Modules linked in: ipmi_devintf ppdev rapl i2c_piix4 tpm_tis tpm_tis_core i2c_smbus tpm i2c_core ata_generic i6300esb libata parport_pc rtc_cmos parport fuse
[  420.365047][   T52] CR2: 0000000000000108
[  420.387629][   T52] ---[ end trace 0000000000000000 ]---
[  420.416535][   T52] EIP: hazptr_synchronize_overflow_list+0x43/0xc0
[  420.451442][   T52] Code: 30 8b 4e 34 90 90 90 89 4d e8 89 7d ec 8d 46 2c 89 45 f0 8b 45 f0 8b 00 89 45 f0 85 c0 74 67 90 90 90 90 90 90 90 90 8b 45 f0 <8b> 40 08 3b 45 e4 0f 95 c3 83 f8 01 0f 95 c7 89 f0 e8 67 bc fe 00
All code
========
   0:	30 8b 4e 34 90 90    	xor    %cl,-0x6f6fcbb2(%rbx)
   6:	90                   	nop
   7:	89 4d e8             	mov    %ecx,-0x18(%rbp)
   a:	89 7d ec             	mov    %edi,-0x14(%rbp)
   d:	8d 46 2c             	lea    0x2c(%rsi),%eax
  10:	89 45 f0             	mov    %eax,-0x10(%rbp)
  13:	8b 45 f0             	mov    -0x10(%rbp),%eax
  16:	8b 00                	mov    (%rax),%eax
  18:	89 45 f0             	mov    %eax,-0x10(%rbp)
  1b:	85 c0                	test   %eax,%eax
  1d:	74 67                	je     0x86
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	90                   	nop
  26:	90                   	nop
  27:	8b 45 f0             	mov    -0x10(%rbp),%eax
  2a:*	8b 40 08             	mov    0x8(%rax),%eax		<-- trapping instruction
  2d:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
  30:	0f 95 c3             	setne  %bl
  33:	83 f8 01             	cmp    $0x1,%eax
  36:	0f 95 c7             	setne  %bh
  39:	89 f0                	mov    %esi,%eax
  3b:	e8 67 bc fe 00       	call   0xfebca7

Code starting with the faulting instruction ===========================================
   0:	8b 40 08             	mov    0x8(%rax),%eax
   3:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
   6:	0f 95 c3             	setne  %bl
   9:	83 f8 01             	cmp    $0x1,%eax
   c:	0f 95 c7             	setne  %bh
   f:	89 f0                	mov    %esi,%eax
  11:	e8 67 bc fe 00       	call   0xfebc7d


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260813/202608130915.62b53936-lkp@intel.com



--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


