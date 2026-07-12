Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F422459E1;
	Sun, 12 Jul 2026 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783848089; cv=fail; b=aYxCbvrTLljtjZkG+cDntnlph+WnQWgcvyiZngpzf8MmBHrxWmk9GvA+oq4qkrXCbgQ9KQpCMyBWudbeShTjkZoNJtUGM41yysUGw7stxZYcOypeXSNXqJknIPCI2gpCE7GPM+i+tz2CmcqExDepJpg/hp1lue9rdYxTUyLvgwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783848089; c=relaxed/simple;
	bh=6RLrfvqwGWi4fP0YhbUyJeGw8oxsgyImqRhvUPsnOIY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qSEN3neBAIR0MYdxSHtE21e+fQrIiNPd0F25ADlX9Oolw5mXe2LrhdfBJb+3PEWIiSThA6ONMQaQPE54YHHOj1MPa6tDgq9P2b2kah9fuZmRIP/C84ta2mbOK3eRA75JVlMXfcdgXMHjZdRTLM8ieQcG3Y2lsPKnRy0VwzMreY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l13XuQ4e; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l13XuQ4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783848086; x=1815384086;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6RLrfvqwGWi4fP0YhbUyJeGw8oxsgyImqRhvUPsnOIY=;
  b=l13XuQ4ehPgVjbRLYHmlOF22s6dMcuRAZIfTq0nPf58RuSc877nuorIy
   G+CqpvUOXHFFuvchKdmJyNFr7PJqg1fbmv+xPsQ2wy5ZIhhTXr1Vnm8TB
   A3a1CrJplqqxGgIY0YrKPjzshdHos/PxjhhpN7GandqmUtpV0JZH9lBR6
   Zpv8tNblkyYL1YzR6KSxelFw0wMV7NfRaI/sP7ZRQcjbah5AlCUPEQQrG
   2TaEBI5P/PTS5JwjDCeDncNkL9AEgn0G2viHBiBHH7eaRAR+9ZZNYpkXD
   b1R5amljRdAdu/RiS7gz4BcCH2mQK0tDyo9KD0Ddk8UmZ/8/BaiUJBdnT
   A==;
X-CSE-ConnectionGUID: l7BhoRAoSHSZ625UEmrQpw==
X-CSE-MsgGUID: rT5T+lXITaCe3OCs1RJV6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84603986"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84603986"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 02:21:25 -0700
X-CSE-ConnectionGUID: cxOrz9ubRmiT5G3xly8RTg==
X-CSE-MsgGUID: gAHuiQaESAy0soRjZpnCEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258862522"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 02:21:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 02:21:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 12 Jul 2026 02:21:24 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 02:21:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBMfWMTAVIjBSW0brTDCXDBuQVLZRV3QdwpRAoohPo6Kxwjd/382TTLZDDPtpISEeB50nsZSiVqS6EZ5evq0xVafD9PspbSqT7C44zgNMWTAQdy70Ejr8uf32BHnygC+zS+0jkBQq3vwcZBzoX9MxKDL0ieIRinfG8vXs7WWOsnBhr0EodFZgviOmUBzo0MHeLPymV4uWktwtO5S6tgGql2q00tohz2F7JB+IRvgUTBdgEx4w/OUpwAbDsq1/bNkt6SR9oaCCo0yMi0otsG/jgTXF/GYzpoOwZ1BsqhUWxIM+613ZbM0likyGEIAVwUewKrU3l4O0TybjVyXoiYWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1qLWCLulZiCLhjDs0ai6gX8Hwm1tinDivbnIvjspH4=;
 b=IVwP61Gl84k0szFKrf4X8q383pWPTb9Ol3Ah9omLDsJpHPirFn/3POfWnhX0Xkn88O75P9oQskKbReFmptXGATbfPwpvBQs9ZYofK9V6XYk8gmLBrlTKPlCMHEh7Z07mSK+MB4L/ZYaoprQnrloszyf4EplaS8U9CJSOEjJd4StNFPDrxBuhSSyJvXtYdhYANV74qL+V2NRV9ZkbMj4oMCMabSSfRAulL2SbxHSEyJsXbO9JnKn+tKvGL+EvhLTAzXOw+VklBnWBHl+7AvWfuqOJZxqyCOUrt0D/gc9RQO3X7H+/V0+WZV/H5ocPCD4YAJpBItv+7Gw8GA9Ga8Fr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by MN0PR11MB6278.namprd11.prod.outlook.com (2603:10b6:208:3c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Sun, 12 Jul
 2026 09:21:19 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 09:21:19 +0000
Date: Sun, 12 Jul 2026 17:21:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Julian Anastasov <ja@ssi.bg>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>, <rcu@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [rculist_bl]  1ac252ad03:
 BUG:KCSAN:data-race_in__d_lookup_rcu/print_report
Message-ID: <202607101627.2909550e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|MN0PR11MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: b276d776-3c73-490e-e385-08dedff6ee6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 97BgeKCpjizF4HOPF3m449zDVlSFcWSvkOHk5DdaaGRu56Zp1gT3FL+NqUZFFxmpyBVUa6hGXRa00G0nZf1fy2VnzIdVQjcwZBr8vPD+NFxPRwx6hYII9gU8fCq7PGozes720v9xHKiBjqRCRfbWw8sGCgTXRwS3Ii8cPrNBH0foo4DbnA6D2um5tJlT+HxyPqcb60Skg1rdexg9e31erXpe25JHTq7AwVnomD97K+r3Mz2RP02+sQnlSQMsfkWF1S5Ckkl88Q62EtaPv1jW5FB0+cVpkttDhmV6nK8tqbrGUaeXqtUjisfEFiCCfsSXnguHIsAUVPUqDNDImHj/Crdsldnw6T17OaTVGbe/nZzejcOWEC6ZJPmYeJrC1q5MkunKY7x/7wNyKSCtEYnne1Q1t/ti1VcGTts4mwC4YAc8kdj0dTE4aoIQKzJWD0SXc1+Hl8NxCoDu+CnOyu0CrhajgYfRBrdGctszR1fLKl4H41PcvBRRWSW/1fS5Yb/tc+JuJKXPGYEXdGMROiK3WfNcLhVI23SUlFusdot7sDSK+hGdAu7pO8D22VWAcaRJihP1nnYe+kdtghWM2N8pc/JlN33sVEQm+5iE2o6ndB2B22Qn8zJT61dI5ypA5DPZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QubDYgck7bmYjdeliWa6IN5O0EJqNCJZLHdItkeAH1rI+wcItCElbQTaocOL?=
 =?us-ascii?Q?3kwnAtYz5z2RRiyk5lJexnAV1Vwkv5SUECCKos5HVHp1pacd3CBboDyszPYq?=
 =?us-ascii?Q?2DAZd+G9wE2tLFkHvQfRFwH/EqdhyJ9cYJg3e1o7V2WV10MumjE0/FuP6t9I?=
 =?us-ascii?Q?cbAWdUmDhzhTfLEGBLYZk1WlX/+F5eOo9g7Pr+4K2+AvVVdHdlA3Uw6w5rH8?=
 =?us-ascii?Q?JgqGM9GcnUo3eztmW36JIXyYCpaTL12laO7hzltqAJZM+NeQ9UocZv5NDHJ8?=
 =?us-ascii?Q?pKjfe1jkS17ILp9Pu3+xhdu+KHF8EfMQ/NSwlVtoDXKIFmiLXrxRLdI70kp7?=
 =?us-ascii?Q?KNq+rHcxBDWZjIIiPgY84B8S0JjaEnZSKWWzToPgmdCQKDhM/6A8m+UDQ2hG?=
 =?us-ascii?Q?C0qyUMpsucvT22UcDTZN2NnTeFgJXx9LG/dbHmCD2Nf3qwGznxp4ITe3+diQ?=
 =?us-ascii?Q?THbUDj9TTee4zU25poipOYbDw4VUKYyctHxb4xwTggr67IrjCEVGqsFiE9L4?=
 =?us-ascii?Q?/ZqWNrUukFgBuSZXQ5wQAIMjpWrkt6MZijg4Vu9NUv0fCHNA3HvbGbWUTiHp?=
 =?us-ascii?Q?8igo5TMe61bgy76r91ME1N+X7/kA7cvhK+y/OrJWslgN2Ghc+/j+r8MwIteF?=
 =?us-ascii?Q?KiUzjD5agANM3RWEB5wh/MNBHHwvHXPwpzLpwJXcM8AP3QS2HX2LjXpG6Yx4?=
 =?us-ascii?Q?Zb4YGPkAyF7PvxXmkzexuIJWaLuNNGF7HBMwkQIHWJjuvtbEVtetqTHcpA6G?=
 =?us-ascii?Q?PJZZjm7KKDcBZlXmzqfTBvd0hBndbMBkt6lSpLAt3wm7h0Ese0Op7S7ep6tT?=
 =?us-ascii?Q?Gi1QiJhjZ1uSgtFYZlAGks5/zOPj53PrJsHUHxTogN34vybscYtS4dnRtfoq?=
 =?us-ascii?Q?cXt+CP9Mmk90sMO5s7ACgcsaL1DQuLzanRcZF5t3SSGRdCZ3U4lt8NSO0lB0?=
 =?us-ascii?Q?iWjkKO1pHA0tnoYHBbvVeoMaDN2I1VwoI/mnh+gpFK9ACLkOWV2b0y/MqnLn?=
 =?us-ascii?Q?ehWTq03Ngjlvni8rCFQytamxuhaO7fEd35MFYKZme5bZ+wCCHaHTr0Meug61?=
 =?us-ascii?Q?B45B+yr0PHoxKVNCpvROJSQUYpSc6JAfRmpiwEKv/j+V6q28HegcPL7JUWs4?=
 =?us-ascii?Q?KBMYuLVTaQGjcrUYbYUCKEAF0iNB5V4VeO11lMGbYk57p+yBJiU3lnDhI1qL?=
 =?us-ascii?Q?9y4AjdXwFcnMDqNW2Uj6UOEUgMHiuRuCyuzuFgVJxR7RsIklHW6UoD5bqG54?=
 =?us-ascii?Q?UUAEUOWfLZZNypFnGqgGDSLIKz3YYBw84LSynR+sTQX7+TavrdKbpYaVqfxM?=
 =?us-ascii?Q?qd/Tnn4DXbbwzJZLlxNcaqI1Db7fC/+trRkVAn3OTY+qvKuWbHgljZfSVIXM?=
 =?us-ascii?Q?0Qy4MpD+gTBjvks9w+Yim86W5HxzxanWUTgLDGt3CM4TyU+KlQPE+V/b30h3?=
 =?us-ascii?Q?MrCOixC6kZvN7uEOo0dCuuuzv6m/OMClUTuHU4SunhJU5IW2A/rCTsvaujeP?=
 =?us-ascii?Q?9z2fjCWPh3Ry6b94MjKL8EtdpKV9+gS9eWz0sCX+JOGQ52qo43MtpxL28ggi?=
 =?us-ascii?Q?lsvKVpxJtly9jSYhQtl1QGmtAtKpZ1+bWufbIsy1Ww9eKtj2Y0oaH/2ab9lS?=
 =?us-ascii?Q?Y639ZvJKXFTDBfU30lOt1YFNrgdBqbxa4LS5R8MkHYMffwWM/+BldXcumMPZ?=
 =?us-ascii?Q?8/OZ+EwA6NUElxejn1wEHt9ohkvwZyyeu/wia2aejQwaI4YKa+z+opixzmH/?=
 =?us-ascii?Q?kplosTI+Hg=3D=3D?=
X-Exchange-RoutingPolicyChecked: cJStm63whwpgP2J8AbfLBSsZ0PN8naFZUeyJveAR7cjj4PS8erHQBRg6W55oDrD1vKVjPoif5k5bsVIKlJP9x67IloAv4q3ZzhYEvpjdqTlc+QJUCHFC7PwbWCCFXepCdflbxi6vzJ45V18C7glu/4PKustNHEx2bymOmCwnzyCzO/+K4dsaz5aiGNoPqtq+l49BfTaGsBAemep+/D25VQ5IgReA6Wv3NjbU6tIQNeKmXp24CBdQ6IgTbxgdZ38P0Xx51AkipA9Yoei9WbRFP2OivjLLN2pifVeh9it2kEs9o58U+Y9hPeSTJ6R9AdcC7YJQTdZrWkv9pExcovjI1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: b276d776-3c73-490e-e385-08dedff6ee6d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 09:21:19.0500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEBPkR9ir6gOPR05n/lMt9PF1W9AhzTTkTYyGrVhnY+WMmmc6oDLsc05x+pjp9cQQwnU79uYpsM1COZiP9i3dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6278
X-OriginatorOrg: intel.com



Hello,

as we understand, this commit is not the root cause of the issue, it just
changes the stats of the (random) issue:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/sleep:
  vm-snb/boot/debian-11.1-i386-20220923.cgz/x86_64-randconfig-074-20260622/gcc-14/1

34a6a003d4e49313 1ac252ad036cdb18f5fb7f76bb6
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200         32%          65:200   dmesg.BUG:KCSAN:data-race_in__d_lookup_rcu/print_report
         69:200        -34%            :200   dmesg.BUG:KCSAN:data-race_in_hlist_bl_first_rcu/print_report


we still make out this report FYI in case it could supply any useful information
to solve any potential code problems. thanks



kernel test robot noticed "BUG:KCSAN:data-race_in__d_lookup_rcu/print_report" on:

commit: 1ac252ad036cdb18f5fb7f76bb6061adfed9cedf ("rculist_bl: add hlist_bl_for_each_entry_continue_rcu")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[tail failed on linus/master      d2c9a99135da931377240942d44f3dea104cedb8]
[test failed on linux-next/master 6eb8711ece2ce27e52e327a5b7a628ed39b97f45]

in testcase: boot

config: x86_64-randconfig-074-20260622
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607101627.2909550e-lkp@intel.com



[   94.613216][  T178] BUG: KCSAN: data-race in __d_lookup_rcu / print_report
[   94.616584][  T178]
[   94.617709][  T178] read (marked) to 0xffff88881e358348 of 8 bytes by task 170 on cpu 0:
[   94.621462][  T178]  __d_lookup_rcu (dcache.c:2332 (discriminator 2))
[   94.623009][  T178]  lookup_fast (namei.c:1850)
[   94.624382][  T178]  link_path_walk (namei.c:2275 namei.c:2647)
[   94.625855][  T178]  path_openat (namei.c:4826 (discriminator 2))
[   94.627207][  T178]  do_file_open (namei.c:4859)
[   94.628575][  T178]  do_sys_openat2 (open.c:1366 (discriminator 1))
[   94.630019][  T178]  do_sys_open (open.c:1372)
[   94.631330][  T178]  __ia32_compat_sys_openat (open.c:1434 open.c:1432 open.c:1432)
[   94.632980][  T178]  ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-074-20260622/./arch/x86/include/generated/asm/syscalls_32.h:296)
[   94.634453][  T178]  __do_fast_syscall_32 (x86/entry/syscall_32.c:83 x86/entry/syscall_32.c:307)
[   94.636053][  T178]  do_fast_syscall_32 (x86/entry/syscall_32.c:332)
[   94.637566][  T178]  do_SYSENTER_32 (x86/entry/syscall_32.c:370)
[   94.638930][  T178]  entry_SYSENTER_compat_after_hwframe (x86/entry/entry_64_compat.S:126)
[   94.640851][  T178]
[   94.641599][  T178] write to 0xffff88881e358348 of 8 bytes by task 178 on cpu 1:
[   94.643871][  T178]  print_report (kcsan/report.c:399)
[   94.645239][  T178]  kcsan_report_known_origin (kcsan/report.c:697)
[   94.646960][  T178]  kcsan_setup_watchpoint (kcsan/core.c:678)
[   94.648580][  T178]  hlist_bl_unlock (linux/instrumented.h:42 asm-generic/bitops/instrumented-lock.h:42 linux/bit_spinlock.h:96 linux/list_bl.h:155)
[   94.650030][  T178]  ___d_drop (dcache.c:569)
[   94.651274][  T178]  __d_drop (dcache.c:575)
[   94.652486][  T178]  __dentry_kill (dcache.c:668)
[   94.653876][  T178]  finish_dput (dcache.c:879)
[   94.655196][  T178]  dput (dcache.c:928)
[   94.656362][  T178]  step_into_slowpath (namei.c:1748 namei.c:2101)
[   94.657897][  T178]  link_path_walk (namei.c:2149 namei.c:2285 namei.c:2647)
[   94.659316][  T178]  path_parentat (namei.c:2851)
[   94.660680][  T178]  __filename_parentat (namei.c:2875)
[   94.662217][  T178]  filename_parentat (namei.c:2893)
[   94.663649][  T178]  filename_unlinkat (namei.c:5509)
[   94.665114][  T178]  __do_sys_unlink (namei.c:5575)
[   94.666511][  T178]  __ia32_sys_unlink (namei.c:5572 namei.c:5572)
[   94.667941][  T178]  ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-074-20260622/./arch/x86/include/generated/asm/syscalls_32.h:11)
[   94.669382][  T178]  __do_fast_syscall_32 (x86/entry/syscall_32.c:83 x86/entry/syscall_32.c:307)
[   94.670950][  T178]  do_fast_syscall_32 (x86/entry/syscall_32.c:332)
[   94.672430][  T178]  do_SYSENTER_32 (x86/entry/syscall_32.c:370)
[   94.673797][  T178]  entry_SYSENTER_compat_after_hwframe (x86/entry/entry_64_compat.S:126)
[   94.675698][  T178]
[   94.676432][  T178] Reported by Kernel Concurrency Sanitizer on:
[   94.678270][  T178] CPU: 1 UID: 0 PID: 178 Comm: systemd-udevd Not tainted 7.0.0-rc1-00328-g1ac252ad036c #1 PREEMPT(lazy)
[   94.682170][  T178] ==================================================================


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260710/202607101627.2909550e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

