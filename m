Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317086;
	b=EjMD4yiL0yUrSlfIYHIEKaLuDsu2QFjk3gwjBRiI/eIgHptqBJh0lLvnX6MXO1lCbR4Q
	 n8bpyfVJHkzUwhR0EOmKjXqqeE/5Qce6PwrVydHSmOQnvzRW+9VlCk48gruTE7DDgEZvv
	 p0RY8QeKpajq/sf/ode4+X42cERAnGgf0Gw8XV/3qcQdJErv/9qnFj8u6FTwy3qmC9tW+
	 N+O5RI5MKR16QUVP7JcrK71PkXX5aeC9VF6f0HhSP9ZbX59iNdx0uw5cvV5Bi9RSQnhyG
	 g21ZKk/+6RyaD2Ygmv1MbyE0HdA8rTVvw/x7WWmDl2l28LE8Hc3NE0xeJY/BjSg8SKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317086;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=vfRXqd1LnLdrT5DLeZnCBWIcxfbAfVCcHISw4AcMLXo=;
	b=Ixs1RvS0nqOZbXGDmzd+Ov+5a/eogjP5BtPlVddlOGKoyddHe2jDqYl8EFbbE2Pm6/uR
	 gmNfMZdksSWziQ623Ymp7eBVoEhYZniNtzcc2W67f1MWKUxdfsa/P2nCw/fjSWbpEirXK
	 YBmjWA4M5JmSVVadMlYnGf9Oqhgufv0Io125ogkc2YIwJ97gyFD3oYdEmJyiA+vcxzXHj
	 nERu5fs0Z7FDcxbsYwKiLOwIc+x7sJmDywtGBbWZrzyldSoau8aWwRsbl46qEyhc+LWKK
	 RSWwe4LKsalQ5n1lA5mPOtS9aDSfOnLqQEpJtF0+KHVclh5tx7SBh/MbRMXb2+G4Xhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YsFAercJ;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C40606B6E0;
	Tue, 10 Nov 2026 13:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C40606B6E0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YsFAercJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794317085; x=1825853085;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=5tTxzaWXVqSfgbdW+gLegN0tGIRw952nW7MOTTuw5TY=;
  b=YsFAercJ1EQwkGyMmQNITgpqs9L1kfw2G1tU0FbP6cMJwNUz+qmhU6zI
   rhP4tYu2JRSQT5ESlXh4WemF0v+hOpMZtAopDlVZg4sCBtIV0FCTdPoFK
   EmZrZf32NyO7VJXrmqO12RC5IRZn/ai2egDOr8jQ8TeIj+GsBj7X5SZe1
   r5FJ1t2BRfqGZn+9ICF6REqT1RLVsOz5zV0M3cCcy77C2aRfX1uosfe6b
   jjrjL+ohcKMhSRVFx68qqNx3exW+fKu7m5XO3RLdx+hHDzjhVDD3RLecA
   x8geyKO//D+MQ2VS/Y/msl8V9zbJOw1BgrWbJd3/vXr1RVLYOQql4XCVO
   A==;
X-CSE-ConnectionGUID: 5V++hhe2QGaO9DTIjkLbHg==
X-CSE-MsgGUID: 6oZmNImRQ4evQZweUCdNpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2949630"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2949630"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 05:24:44 -0800
X-CSE-ConnectionGUID: ryxvuePEQc2D+6Gn6yq2xg==
X-CSE-MsgGUID: 7BwU9qouQYK76O3ujJ1jmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8318947"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 05:24:39 -0800
Date: Tue, 10 Nov 2026 21:24:36 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, yi1.lai@intel.com
Subject: Re: [PATCH] rcu-tasks: Track barrier callbacks in debugobjects
Message-ID: <202611102000.66498f89-lkp@intel.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104153046.965890-1-joelagnelf@nvidia.com>


Hello,

kernel test robot noticed "WARNING:at_lib/debugobjects.c:#debug_print_object" on:

commit: 658b1b4ca701213b64469ec43cd8f10adaf395f2 ("[PATCH] rcu-tasks: Track barrier callbacks in debugobjects")
url: https://github.com/intel-lab-lkp/linux/commits/Joel-Fernandes/rcu-tasks-Track-barrier-callbacks-in-debugobjects/20261104-103045
base: https://git.kernel.org/cgit/linux/kernel/git/rcu/linux.git rcu/dev patch link: https://lore.kernel.org/all/20261104153046.965890-1-joelagnelf@nvidia.com/
patch subject: [PATCH] rcu-tasks: Track barrier callbacks in debugobjects

in testcase: rcutorture
with following parameters:

	runtime: 300s
	test: default
	torture_type: tasks


config: x86_64-randconfig-072-20260623
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu Cascadelake-Server-noTSX,enforce -smp 4 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202611102000.66498f89-lkp@intel.com


[  325.412340][ T1259] ------------[ cut here ]------------
[  325.413965][ T1259] ODEBUG: activate active (active state 1) object: ffffffff8a7b1f08 object type: rcu_head hint: 0x0
[  325.416551][ T1259] WARNING: lib/debugobjects.c:629 at debug_print_object+0x191/0x1d0, CPU#0: rcu_torture_fak/1259
[  325.419281][ T1259] Modules linked in: rcutorture torture
[  325.420580][ T1259] CPU: 0 UID: 0 PID: 1259 Comm: rcu_torture_fak Tainted: G                T   7.0.0-rc6-00019-g658b1b4ca701 #1 PREEMPT
[  325.423791][ T1259] Tainted: [T]=RANDSTRUCT
[  325.424756][ T1259] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  325.427494][ T1259] RIP: 0010:debug_print_object+0x1a6/0x1d0
[  325.428858][ T1259] Code: c1 ea 03 80 3c 02 00 74 05 e8 76 71 25 ff 48 8d 3d 0f 1c f3 0a 41 54 48 8b 14 dd c0 75 72 87 4d 89 f9 4d 89 f0 89 e9 4c 89 ee <67> 48 0f b9 3a 58 ff 05 32 2a ef 0a 5b 5d 41 5c 41 5d 41 5e 41 5f
[  325.433880][ T1259] RSP: 0018:ffffc90000357c70 EFLAGS: 00010246
[  325.435364][ T1259] RAX: dffffc0000000000 RBX: 0000000000000003 RCX: 0000000000000001
[  325.437272][ T1259] RDX: ffffffff87727500 RSI: ffffffff87726e60 RDI: ffffffff8d6cac90
[  325.439305][ T1259] RBP: 0000000000000001 R08: ffffffff8a7b1f08 R09: ffffffff872da660
[  325.441227][ T1259] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  325.443291][ T1259] R13: ffffffff87726e60 R14: ffffffff8a7b1f08 R15: ffffffff872da660
[  325.445186][ T1259] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[  325.447423][ T1259] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  325.449011][ T1259] CR2: 000000000805b740 CR3: 0000000154e57001 CR4: 00000000007706b0
[  325.451076][ T1259] PKRU: 55555554
[  325.451919][ T1259] Call Trace:
[  325.452654][ T1259]  <TASK>
[  325.453464][ T1259]  debug_object_activate+0x207/0x2a0
[  325.454826][ T1259]  ? debug_object_init_on_stack+0x20/0x20
[  325.456217][ T1259]  ? find_held_lock+0x2b/0x80
[  325.457536][ T1259]  ? lockdep_init_map_type+0xb1/0x200
[  325.462417][ T1259]  ? lockdep_init_map_type+0xb1/0x200
[  325.464677][ T1259]  ? __init_swait_queue_head+0xd3/0x140
[  325.471162][ T1259]  rcu_barrier_tasks_generic+0x10d/0x2a0
[  325.474128][ T1259]  rcu_torture_fakewriter+0x157/0x870 [rcutorture]
[  325.477019][ T1259]  ? rcu_read_delay+0x250/0x250 [rcutorture]
[  325.479711][ T1259]  ? lockdep_hardirqs_on+0xd0/0x100
[  325.481709][ T1259]  ? _raw_spin_unlock_irqrestore+0x4c/0xa0
[  325.483416][ T1259]  ? __kthread_parkme+0xfe/0x200
[  325.484751][ T1259]  ? rcu_read_delay+0x250/0x250 [rcutorture]
[  325.486553][ T1259]  kthread+0x3cd/0x3e0
[  325.487554][ T1259]  ? kthread_affine_node+0x150/0x150
[  325.488909][ T1259]  ret_from_fork+0x7a/0x7c0
[  325.490231][ T1259]  ? arch_exit_to_user_mode_prepare+0x150/0x150
[  325.491925][ T1259]  ? switch_fpu+0x14/0x1b0
[  325.493054][ T1259]  ? __switch_to+0x573/0xa70
[  325.494357][ T1259]  ? kthread_affine_node+0x150/0x150
[  325.495663][ T1259]  ret_from_fork_asm+0x11/0x20
[  325.496861][ T1259]  </TASK>
[  325.497866][ T1259] irq event stamp: 1019
[  325.499064][ T1259] hardirqs last  enabled at (1033): [<ffffffff815720e0>] __up_console_sem+0x40/0x60
[  325.501497][ T1259] hardirqs last disabled at (1048): [<ffffffff815720c0>] __up_console_sem+0x20/0x60
[  325.503957][ T1259] softirqs last  enabled at (1074): [<ffffffff8148eb5f>] handle_softirqs+0x61f/0x6f0
[  325.506531][ T1259] softirqs last disabled at (1095): [<ffffffff8148ecd8>] __irq_exit_rcu+0xa8/0x1e0
[  325.508825][ T1259] ---[ end trace 0000000000000000 ]---
[  325.649375][ T1259] ------------[ cut here ]------------


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261110/202611102000.66498f89-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


