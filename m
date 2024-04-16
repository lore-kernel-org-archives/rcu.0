Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7B6CDDF
	for <rcu@vger.kernel.org>; Tue, 16 Apr 2024 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249631; cv=fail; b=Rws4PY52aI76yLHjKdQcB/xHjP8lG4Pz1yvEIEqxHAInAehF7Byc4b/3sgwH/y9DSLvf1Y5JGMlapluJ2PcdZXIh2rzbMaCZf29O5RuImtgou1KdZ3cr/ljB9JbyO5mG92JSLEWer+ivbxXnF7j5saK8SUZ4mZZNDHD674eCMb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249631; c=relaxed/simple;
	bh=tQoSTvfJRbI3ux/7b4TqH8j+ncGSa+uHi1bZh/QxGno=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=sD03vU8D35kRlJ1T9CxNKgE89sxO+x8pY6fgoPBMd0vdKdXUZemNRNMuNsbxFeGvlw4J4csiSq7JiEqh6MGbJerBBTHSWLD/gnWXAfdba2mXfQes21IgGH1gPM2vsHahIHhHgwqzQwfUPEX7JsIg20Nkj25MdS3iI8Lwsy6Ze0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APo7g9pW; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APo7g9pW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713249629; x=1744785629;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tQoSTvfJRbI3ux/7b4TqH8j+ncGSa+uHi1bZh/QxGno=;
  b=APo7g9pWKj6IRpPTe0Vx+bf4BCkG9i0uokkYRC6v72Qp6eNBWwbwNxxg
   1wDUPMEiLS7ReeSmyFHOHjqibzrdgxd5Eo3ZxgSEv8irT4KdIUkXP7xTn
   m11A0zgwOq6ptoS20pHGLFgx4893fkPMUL0TybaRCUpmyULuYvQSsK4j8
   gPm//FgkVh18f4tjoq08C23p+qqeRQ7UoCzt36hfasiGy/EKYUa4QkGki
   N6XgGkLpjrbelDQ+0qKMnSDAeA/sZirMiaYo/Oau8TtfpLAeHKIWVm2GD
   LiTyKsBNSEMfkpFXO7BRHxcDJoLsQTMhVQB7Eo5f9b8BTAE2wd+wN6gSb
   g==;
X-CSE-ConnectionGUID: ZlpLXSYOTK+RQLvryP8URw==
X-CSE-MsgGUID: WjuzRZcKSU2ZNLs6Ojz2Nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="31148903"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="31148903"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:40:28 -0700
X-CSE-ConnectionGUID: aIlhMriMRs2fc4BazrkDZA==
X-CSE-MsgGUID: Inhv5rccQECfrJyQ7AlD1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22193206"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 23:40:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:40:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 23:40:28 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 23:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLsFIsbn/2q6t+YbFOjghrfGtRf/zQNiXRqPrJ/RhWdkwZ4pWKO2WMSv9101ZZvePWyn0fKpWTeRxeTSuUZD/nUjIlCbWQgu13d0hUp3LK1hI+rj/yG9tJ0cVdKkuGpyVGKkFFsURfQBTH7RPdJ7n/B18rkoVzIgVkM+HztWrANhNLGLyS7C1WrrQ0RI4MD34yk19GBGc/LFasNpWeqWRQJpXtYMNSo8rncuTW/Asj2KuuVvv5MRA+EoZIHeHsiDzfVpdiLS2JNztK43T8nKHcETeWb/ZmABVFwle8aSxzCWfuPka52y57nhZKu/Irya6wsGhWVQ3xsrSB/yeUh9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhG0ZYa2Qzzh5Dxra1fiiJnliaZvvdRLopOJQZ8rJ+s=;
 b=kOyYxxLsrcgCglV5NEJma9k9BmCgZFr7oeCtpyocdZMKDMF2RmUoTPRMQ4D1iQ/TDQ5fj3ZTo8hGINcVTVfeyrFNx/X52HAVQYsShrv3SRjpZZz6oA4yyd3oFL6lAEYRqX5iYxiBkuBfueEiPUktMWerTCb56EosENzXG4U8B/hO37uLKhaSvXcBWtitLHUP43jNqmKKUpGNfL6T7/hZy8puGmXVXS0Y0izmJSUseimmIgGfsf5KF16cNwyo9lbPg/LTd+ICkrje1tsxy5+fmfJ3waHNinamWqGNSRmtEDZjhSdvIz7JnOehjDjFgGhDExjG0JwT5903kd7PuNRHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6966.namprd11.prod.outlook.com (2603:10b6:806:2bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Tue, 16 Apr
 2024 06:40:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 06:40:24 +0000
Date: Tue, 16 Apr 2024 14:40:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Uladzislau Rezki <urezki@gmail.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Yan Zhai <yan@cloudflare.com>, <rcu@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [rcu]  3183059ad8:
 kernel/rcu/tree.c:#Illegal_rcu_softirq_qs()in_RCU_read-side_critical_section
Message-ID: <202404161239.4aa01f2-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 994bd536-7e2e-478c-4841-08dc5de01892
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xsYxmwPKsT2ndYWzsh6u20unImfPdbBG4KRLFdAWcPQF4QVEfseVR9jMQCZ5ZoPGP0hyk+QZHxvFh0SLt0tq9qD7zNtkcyGm7YSWxNO9qJ3l+RysPwRGk2D2xulnIx9u/8BPPkx2XJ4TvA3PEoIqiA+xqLjn1NNkq/ucM5Ga2vk6dsVweGWSfyYXeHWymy89ngEvaxQEeH8dDgOvSroz/RFYM1bJsHS5Dn3ViQyRyMFwwYfXDpglcRgl3S0sU4/rPjl5nph0ZgLVZ323yfGNVoC+NUuG1/0VKfQdDn8LWQq+6ZMgiq9APA3npAmnUd8FUhzLVdn89gbGSqLxcfpTQ+OQzuYSsaglHQA/DPcQbZVGp3RHZaStM3p0qLVHWTb85CEaDI1cVAiFvia52hQvvu0AOzv0WDqlxaeXBygBtzhQg8FDuJba1tATXA83bv56gkAbQwn5HfaX0nAmF1fuj+ae1/2+YESumWgl3CUaoYhxWm5kBpYdqylr2DuliLbAjvmnlWBLemL0Kz/CZqgSjr2Dg2f2FlA/6yo1Rqh04Fwpls1kVivsMLMz4rY0x/7VvCZid2OWtbzRB34W2nWradrcE7q78fuiy6K5bjhkF7BGt7gCJkhKOQcR8wHm6FW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2wE8KGPJxJpqv9D900fJKh/UWER2DUfxjK6/4AZDyRFQtJq68vqpgy/V9Lqi?=
 =?us-ascii?Q?kGB/8vqO+9IoQSECBckoVkJLbpFkiRRW+ZnsyO5EwiBQfkVyNTUZqCH1FJBh?=
 =?us-ascii?Q?orSQinWOjAFDq1k0enWeaJkFOTdq+tkhUHabnYli68sucQwyCc1lZuessyeF?=
 =?us-ascii?Q?HSp8n6qI2m2voB353gi7c7JHm3FT1hK/Ld+oDRsyeudSCz5+G7E0Zcnqg14H?=
 =?us-ascii?Q?5Afi43UTRdm3L0+1hDepHGKMXmKwgl6g1hcJOV/xq/v0GdTB3UEGhC20T7Eh?=
 =?us-ascii?Q?j7e35x4PzquR5CoX5udBcBhmqB4g4oJ1KhPydQlme9b6vOtdStJ9seU484/w?=
 =?us-ascii?Q?Gn7GTvXgbgSe8TT5UFoF1V/rZoCyuI37wjWvh4SZ55HbLpiN6zCWzzSPMjy+?=
 =?us-ascii?Q?zIZDZRixQRfnpyohO1cn/QcJQKDVPbOwuFUaiHAwOviaP8ry0R4gg7iHQUM7?=
 =?us-ascii?Q?AcXhS1slm0TGjBMb0x9ubDaUPn2WMKhhwKBjeytahWzTsBgP/TkhE4cXQHUJ?=
 =?us-ascii?Q?CcaJsEhvXlvVst7DEb6s3YoH6vwD6xi5JrBa2yrBsXAM8tjwFkoi2MESCIg2?=
 =?us-ascii?Q?3pTTsMDx6pQxsXs/9+SdNNsyzzfYBtEpVEqmmBXMXfOHX6Mk+A4zOV+IeQeh?=
 =?us-ascii?Q?ToWcCVF1BIXqM5zuKdnE6yDjZFyt5Q1uNgb6a63l1beETfBer3LHlGxVRz1G?=
 =?us-ascii?Q?8uYJsffM15zPQxoaSmh+ighYKUmV2VvwApIGZhTKBmqJNA6rS9O18tvJek6Q?=
 =?us-ascii?Q?h90/8P43kZNPGIPFGWCIBWILRe1QKpndMu+95VEpHiaUljRNihHU0sT0fCWA?=
 =?us-ascii?Q?CDIE6c/b9H9UvZ69qND7ee4/uslxuMDjR0JpCchX8DL5PiweOhooqUlgNNpH?=
 =?us-ascii?Q?P6cGyHSJvDb9zQLXd3Wg3E5KW3qNdLPt8Pvggm2gS0kulYAE5RexPI9TVZhs?=
 =?us-ascii?Q?fbg5xH7nWj2ZIx7kjlfX6lF2oi4DVJ1zN9ACk7uUVDjtnsLcIqey74lvet4k?=
 =?us-ascii?Q?m3qz2O1VCH0qgnL4UkAsPHNNLU+I110ynbDvgEBUk1kYBtz/j9vBPwYS0pzj?=
 =?us-ascii?Q?V1bYPCaKKnSGPyS7yiZpYpq2hi1jRPfVKbR4NW7+Nzdup4Iy1+VnvATByvBn?=
 =?us-ascii?Q?H9b1duRMMc0O+bZIIh68LlQjIbCX15zeZnVn5bz4eCVc3Qrc1odpiH+KibXY?=
 =?us-ascii?Q?M3GqoOOq3Kth/2cgihCaxsz+NryhbUXeiuvbOZSWsdM/zgL+QJJ5CmWje8gS?=
 =?us-ascii?Q?VlaOA8mXtIBl+W199NMa7Ib6oOrO+p/vn8jwzE4xanDHnDL+STGYfSZ+0gfX?=
 =?us-ascii?Q?TTjmHGCaAPeSF8wK9rADOtL7kE28gn/pwDimxiM9IvENi3R7kLWv5jWhzeCt?=
 =?us-ascii?Q?SRoiSt8jb55bPQ8o4A7vapQXywDAZLfLee4vhEoRpFiVmf2rMcj/X4+FpuG2?=
 =?us-ascii?Q?MkxokRHyQ+SLgVwzrusIzDanUBZvGGGlvSDWPxcJZApOWoW6wD5l6aSC+eC0?=
 =?us-ascii?Q?Se4mTMg+l4jeGXqXAQtlvSFZXvsHBWzatfeFKfuwdZMGApxFL8Gwo8YWojkw?=
 =?us-ascii?Q?KQpQjlWDT8ghSH2Zug4MR2Fz94tEC8vPwp/0oX/N9vBbSynuxyl5s/9dUfly?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 994bd536-7e2e-478c-4841-08dc5de01892
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:40:24.7391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57kjmYTgAnIvzuwfTVf2t6uBtXyfNSjsLMOndtd1a9flMP8usPLg6CI/3Tw3aX3uroiz2SYkKdNdpdBirM6Hgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6966
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel/rcu/tree.c:#Illegal_rcu_softirq_qs()in_RCU_read-side_critical_section" on:

commit: 3183059ad82a0daa8292daf43c325bac57daceb5 ("rcu: Add lockdep checks and kernel-doc header to rcu_softirq_qs()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 6bd343537461b57f3efe5dfc5fc193a232dfef1e]

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404161239.4aa01f2-lkp@intel.com


[  293.025781][    C0] WARNING: suspicious RCU usage
[  293.026196][    C0] 6.9.0-rc2-00001-g3183059ad82a #1 Tainted: G        W
[  293.026856][    C0] -----------------------------
[  293.027278][    C0] kernel/rcu/tree.c:269 Illegal rcu_softirq_qs() in RCU read-side critical section!
[  293.028021][    C0]
[  293.028021][    C0] other info that might help us debug this:
[  293.028021][    C0]
[  293.028967][    C0]
[  293.028967][    C0] rcu_scheduler_active = 2, debug_locks = 1
[  293.029640][    C0] 1 lock held by ksoftirqd/0/14:
[ 293.030049][ C0] #0: ffffffff85ee8ba0 (rcu_read_lock_sched){....}-{1:2}, at: __virt_addr_valid (include/linux/rcupdate.h:329 (discriminator 1) include/linux/rcupdate.h:873 (discriminator 1) include/linux/mmzone.h:2019 (discriminator 1) arch/x86/mm/physaddr.c:65 (discriminator 1)) 
[  293.031027][    C0]
[  293.031027][    C0] stack backtrace:
[  293.031577][    C0] CPU: 0 PID: 14 Comm: ksoftirqd/0 Tainted: G        W          6.9.0-rc2-00001-g3183059ad82a #1
[  293.032489][    C0] Call Trace:
[  293.032778][    C0]  <IRQ>
[ 293.033025][ C0] dump_stack_lvl (lib/dump_stack.c:117) 
[ 293.033421][ C0] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6713) 
[ 293.033864][ C0] rcu_softirq_qs (kernel/rcu/tree.c:269 (discriminator 11)) 
[ 293.034273][ C0] __do_softirq (kernel/softirq.c:568) 
[ 293.034723][ C0] ? __lock_text_end (kernel/softirq.c:512) 
[ 293.035189][ C0] ? tick_handle_periodic (kernel/time/tick-common.c:131 (discriminator 1)) 
[ 293.035627][ C0] irq_exit_rcu (kernel/softirq.c:428 kernel/softirq.c:633 kernel/softirq.c:645) 
[ 293.035994][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 47) arch/x86/kernel/apic/apic.c:1043 (discriminator 47)) 
[  293.036495][    C0]  </IRQ>
[  293.036811][    C0]  <TASK>
[ 293.037091][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 293.037626][ C0] RIP: 0010:lock_acquire (kernel/locking/lockdep.c:5722) 
[ 293.038107][ C0] Code: b8 ff ff ff ff 48 83 c4 28 65 0f c1 05 5a f4 c9 7e 83 f8 01 0f 85 8a 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
All code
========
   0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   5:	48 83 c4 28          	add    $0x28,%rsp
   9:	65 0f c1 05 5a f4 c9 	xadd   %eax,%gs:0x7ec9f45a(%rip)        # 0x7ec9f46b
  10:	7e 
  11:	83 f8 01             	cmp    $0x1,%eax
  14:	0f 85 8a 02 00 00    	jne    0x2a4
  1a:	48 85 ed             	test   %rbp,%rbp
  1d:	74 01                	je     0x20
  1f:	fb                   	sti
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df 
  2a:*	48 01 c3             	add    %rax,%rbx		<-- trapping instruction
  2d:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  34:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  3b:	00 
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	84                   	.byte 0x84
  3f:	24                   	.byte 0x24

Code starting with the faulting instruction
===========================================
   0:	48 01 c3             	add    %rax,%rbx
   3:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
   a:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  11:	00 
  12:	48                   	rex.W
  13:	8b                   	.byte 0x8b
  14:	84                   	.byte 0x84
  15:	24                   	.byte 0x24
[  293.039747][    C0] RSP: 0018:ffff888106a6fb58 EFLAGS: 00000206
[  293.040272][    C0] RAX: dffffc0000000000 RBX: 1ffff11020d4df6d RCX: 0000000000000000
[  293.040938][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  293.041606][    C0] RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
[  293.042327][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  293.043046][    C0] R13: 0000000000000000 R14: ffffffff85ee8ba0 R15: 0000000000000000
[ 293.043775][ C0] ? lock_sync (kernel/locking/lockdep.c:5722) 
[ 293.044186][ C0] ? lock_acquire (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5756 (discriminator 4)) 
[ 293.044620][ C0] ? remove_entity_load_avg (kernel/sched/fair.c:4808) 
[ 293.045079][ C0] ? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1)) 
[ 293.045518][ C0] ? __lock_release+0x103/0x450 
[ 293.045998][ C0] ? finish_task_switch+0x5ce/0xae0 
[ 293.046465][ C0] ? lockdep_tasklist_lock_is_held (kernel/fork.c:345) 
[ 293.046974][ C0] __virt_addr_valid (include/linux/rcupdate.h:874 include/linux/mmzone.h:2019 arch/x86/mm/physaddr.c:65) 
[ 293.047391][ C0] ? __virt_addr_valid (include/linux/rcupdate.h:329 (discriminator 1) include/linux/rcupdate.h:873 (discriminator 1) include/linux/mmzone.h:2019 (discriminator 1) arch/x86/mm/physaddr.c:65 (discriminator 1)) 
[ 293.047829][ C0] kasan_addr_to_slab (mm/kasan/common.c:37 (discriminator 1)) 
[ 293.048247][ C0] __kasan_record_aux_stack (mm/kasan/generic.c:531 (discriminator 1)) 
[ 293.048738][ C0] __call_rcu_common+0x6b/0x6a0 
[ 293.049245][ C0] put_task_stack (kernel/fork.c:371 kernel/fork.c:571 kernel/fork.c:578) 
[ 293.049646][ C0] finish_task_switch+0x5d6/0xae0 
[ 293.050136][ C0] __schedule (kernel/sched/core.c:6617) 
[ 293.050531][ C0] ? io_schedule_timeout (kernel/sched/core.c:6617) 
[ 293.050975][ C0] ? reacquire_held_locks (kernel/locking/lockdep.c:5405) 
[ 293.051450][ C0] ? schedule (kernel/sched/core.c:6804 (discriminator 1) kernel/sched/core.c:6837 (discriminator 1)) 
[ 293.051820][ C0] schedule (arch/x86/include/asm/preempt.h:84 (discriminator 13) kernel/sched/core.c:6824 (discriminator 13) kernel/sched/core.c:6838 (discriminator 13)) 
[ 293.052184][ C0] smpboot_thread_fn (kernel/smpboot.c:160) 
[ 293.052638][ C0] ? schedule (arch/x86/include/asm/preempt.h:84 (discriminator 13) kernel/sched/core.c:6824 (discriminator 13) kernel/sched/core.c:6838 (discriminator 13)) 
[ 293.052993][ C0] ? sort_range (kernel/smpboot.c:107) 
[ 293.053361][ C0] kthread (kernel/kthread.c:388) 
[ 293.053744][ C0] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 293.054220][ C0] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 293.054592][ C0] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 293.055091][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[  293.055556][    C0]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240416/202404161239.4aa01f2-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

