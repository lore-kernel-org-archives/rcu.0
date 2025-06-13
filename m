Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEAD2F4308
	for <rcu@vger.kernel.org>; Fri, 13 Jun 2025 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749773746; cv=fail; b=c/iarr7g/N3tCTi9ZD6k71szfnSTpDCsnhBLVtBAmJGZBrbsECdwV9VFUHXBKTU8iJ67tCaJzm7PmcwhF4CQZQPDhsw1tREksTsqN5Nv7QwoN1OO78A6yRbflnZbqdc6wE6JSpsXmNnreshDr7hq351CVBHedpDGmUwU4wZzA1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749773746; c=relaxed/simple;
	bh=eqWNpttQlwFFHsta9HCP1cjg6JGrwRdJ6M6pz18du8M=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Q3moGHwZzYL4Opyg+QqGzH1DIsu6I7wuo3xuKgiA8ErvMwJtrhcTkUKAfN2761L+PawM9NVF0zYXwU1qIpwHJNnIiyYoa7wuDKri3+qXW/sIOB6+0VfabU3P76BqGheqZc5cUS3HRGroQCY8p1UqmdNwheveJTLqK4L+o3omY+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcmiTAlR; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcmiTAlR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749773745; x=1781309745;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eqWNpttQlwFFHsta9HCP1cjg6JGrwRdJ6M6pz18du8M=;
  b=lcmiTAlRB8DL/C33SL0/fA5iSDicHw9kN2qstkHvgqj48qV2EAhK5ue0
   vSZ/eDNCa0ZeVGelFwNirxcCq5ccKFLP/kMdTpcAcj4D83U2XEBPvct+l
   MAJPxeFufdbi55FGoOkX4ytYnHiTL/DEocp1EEqeQRnOotJ+KLCUOdcXu
   SPyO/2Y79OtKE53PgfF1iIvT1JKvhjVdNZHP+/QRxGlWjfbPc9h5vkEie
   itfyWbCjMIMOiyQKLVBX8y6mDpNYo3TRNyFMrMYfBJi7HtsID4I8Td2JK
   QK0HmzcZJxHRg7G+mG61U0MeJCj6dRbGRQFZU8sWMuw2tBFJUNHGLj7e7
   A==;
X-CSE-ConnectionGUID: RbH3Hhe2R0yZCfnPimHmZQ==
X-CSE-MsgGUID: xxNV/8wjQTiyQon56hf+lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52075111"
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; 
   d="scan'208";a="52075111"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 17:15:44 -0700
X-CSE-ConnectionGUID: UPm2cyNJSs+xQK93EqNW6w==
X-CSE-MsgGUID: LpJH/BzrR2O4B7qeFS2oKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; 
   d="scan'208";a="178569082"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 17:15:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 17:15:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 17:15:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.51)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 17:15:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i23S+tje/1aa+44UQ3HujX36U9IQ/UqCYqtoxHQ+8v5I3uAGTnAB+J5YC2+KyekQlhJPOllPbcAiShORlp4GEZlVP1b8IK1OWjAmfsX4DwbthRjRJA9Qml5y61ySsMsWk3fEzdvt2PPWO8CtMwXFWeyvQTVzkwgssSxYi8tooG0nBDRkG3nwHKo9QmdHQzh+KTJXm74A9KAlEPwjHNfPJ1uzR7y5LpbbRJwDlFBOBgMR+NJDhAJUcQX6aNhWS2pYad+hlfJgj1QoVDZWREOy5VES487nFiZHrDr1ptHaKJCi60IYq4mW9X3vs4x6KGYfn7YFMqowZPtdjvl9YdClQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcamlkGxTqEc1foxUYyQTxEefRDBzTCJg0XJlYB0qC8=;
 b=De3kF9s1gVlEi/4Mzm9ql3+DsQ65oRDFdjDD0OKXmi+Vp8Tszhu38hKNO48MCB7m8K6g1QPxSOh2T3gyFqIHQ+TCzbKcJna1VgMimpDYADFfTORLi+OkomyApNtRsN9jMeUhxfah70S6bYZANzTDMa13z0YsmxImFtv7aw6srw7sixMdn6tAIIzh02tSn55Xz4CoZDTVqxH6Yq5i6hajfPb9jOWSOcYskVit3KodKuhEFzpoSHV4Iej+xKWRu1t2mmnK1Zp1kP36kJWRmsrbws8FDDI7LnjsyJAcTgcifP6zBTYn9ippWX+aIR3x9hJdLYkM0ct7rLMGCgFDcde07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7258.namprd11.prod.outlook.com (2603:10b6:208:43d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 00:15:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Fri, 13 Jun 2025
 00:15:33 +0000
Date: Fri, 13 Jun 2025 08:15:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Frederic Weisbecker <frederic@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, <rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2025.06.06a] [rcu/exp]  1fccb15145:
 WARNING:at_kernel/rcu/tree_exp.h:#__sync_rcu_exp_select_node_cpus
Message-ID: <202506121653.e7d1be72-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU0P306CA0047.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:28::19) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: e7680e7a-e72a-4eb3-caad-08ddaa0f6915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ahA84PSFU61RhmhESyvUZ/em4gdvaGOQZx37QkmeYyhgihvVRby0X0ZJm7wy?=
 =?us-ascii?Q?N3k33jw5AG0qKtdXxL638r5B/DOKOUUiRv7Qs9Ldbn+EZyOIybXxXFbOEeCz?=
 =?us-ascii?Q?2onucaGZqbrd3jFA/luj9a+ueyL/E0TN72ETLHxjkNnFR5Qy7w2mj0kGQR3Z?=
 =?us-ascii?Q?De91Ajm78tVQEFVysCdsGKlAneKeE1tdwl1Bte7kmjfKwgBIi1ydL4xJ/Ipa?=
 =?us-ascii?Q?QmaqDfDxPcQNta93Lu+9s92v5RnmXFwpf1HCYSqApvJ8tdBue3sdN7bSt/ce?=
 =?us-ascii?Q?51O1z5Pq7ZHEY0Z5YGhdv0ux94PC+LLkIgiEjDfp2iI+JxLrsfVCCFmipcuN?=
 =?us-ascii?Q?eUA56A9UY9b3skNJjgvab/xoe7YcjnIWdsl2gfAuFZZIeFNCKwi36npLW/eK?=
 =?us-ascii?Q?2NIrCB+qZYEGGGDMzECA4ZKspsEpJwD/J/R/7hHeZuqD9jTvPd2LWhexY2Se?=
 =?us-ascii?Q?mO8Swz7UNVMcAE7b/58CMwhBECi4rkgQ+XndvUloyCLuP5rm/Cp+CJYrcnFn?=
 =?us-ascii?Q?HyOP+Mpr++iOT0qFXoRGV9UL7Eqckvt45aRkKfOMrn7oCWoOduD+9g5D4kej?=
 =?us-ascii?Q?GtHzsQgxK1qGlUpZtu8nGkxiwt2IHee62G9WijUgBA/pp14vmYgb2Q/7or0y?=
 =?us-ascii?Q?87yzniGlQNTi+zeBDlb4u5B/UBaJVFDNsBUw2RMgAquTBiFgu0mIBDngLzsX?=
 =?us-ascii?Q?J1PnIYido3TlK05+JWk+uEvjRp4NSOpUD0axXuXvbnrfN76bgsS0XaeZH2jE?=
 =?us-ascii?Q?3hFrg3DlsswWOAbbFbq8AnT5EmQaUBxb6jyuRnFM5WE4dukoRQdlWSgIPwzt?=
 =?us-ascii?Q?cAtxv8ALv2dHwWAV6TNXEiSgzDDPGuso+5QLDE5qTJCf0aTP8r6i33OqmuBQ?=
 =?us-ascii?Q?Bp13U2y+xeRfrlm1Y/1iFwGJhwq/ngAcD4VhM/raH6jvAQDmDD49BHbR8VTc?=
 =?us-ascii?Q?pMinLT8tXn8Mq/fihnPJwrcGrB8ENktwu7WAYS8dtlcIzqCI8vZSoAdFU+TN?=
 =?us-ascii?Q?k4Zv0xtF0UHqcVogUeqqKu8wCmQQ4XA3jifoaknbE7is0qxWMrHoPRgOs49T?=
 =?us-ascii?Q?O1o+8iO9P8BARPRyRKzfO4MyFCkxFQzZSSZXhdTZDHPtsdOAU835d9gYHFWo?=
 =?us-ascii?Q?V9l11kABfoXPGhzvKi1UH7H/sOCmNpwdn2KCPfIHz/SP3G4QeyJ+qlHbhxqw?=
 =?us-ascii?Q?uFvNGHs0AR8zSrB2SE5JVqHl1OePhdpYhpjL7/mXZ4vEFv7fHK2CQ3IycMHn?=
 =?us-ascii?Q?HoohYMYo5dzUfxOcQO/hkVN9CWw1QMv0rgXhwloOeerb0KVTs42Q1Zkjf740?=
 =?us-ascii?Q?jwMKKpjaO4K9dtWO4c872SaAoG8gRDDd1S5EEwQ2j3QE9FuMVL/3vRLrChd1?=
 =?us-ascii?Q?rCj7LiU9//bYHLfZNSD5ZrcAoFzo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4n2VLXkMyWSSRW/5TYeOkZl77SSicbtJ9NH8wS4P00cnWIzD6BZLX+detwFv?=
 =?us-ascii?Q?x6ZvIgnv/X4uwa6jaoj92Xx23fXcQ8WZU3gXEkDQWAyOpXaUM2RfdN71iEIo?=
 =?us-ascii?Q?mw78oI7zN/TBeQXnx/HaAMxoE7EU70lK+6759Ol6gE7nS4jh0s9AVmm45R5o?=
 =?us-ascii?Q?UNsZNBgxKRN2unQquK6YzAr1IcE+EvpnB25y9JIe4PG0Es+ZUI/B3ePFAcT9?=
 =?us-ascii?Q?Ily6G6ES2wPWwl5TTzj9+489yJNUeKaqxrAlEGQ5O0HWRCB7KOevHbwlJ54u?=
 =?us-ascii?Q?M9NhIZLbIaP1bqidnUpZ95IOce2FKiUOVmXKNyGyYesVSi2WP95xustX3iR8?=
 =?us-ascii?Q?we3lNZMwT1COmDQsX08zDrl6qWUFrgns98qBzFsXkgJFgNgQz9WASOf1zaWE?=
 =?us-ascii?Q?P1Wa+3mkdckeJ7tWgTzYgIWMtwUSz+RQ1cV+aU0FK+PLLV4xiX2xcMnDR+A2?=
 =?us-ascii?Q?cuc11LgRsTZo0guTxvzSvGu3XpiYAb243hO4W4pGR1Cc+cMmU2s8dH/hWBrJ?=
 =?us-ascii?Q?p5grUrqWfjZzaM0bbS/dkQo8c6FRQVly25x6Gbtrx7lBjGQbBNdFyKAeN7F9?=
 =?us-ascii?Q?qcU62CMZ+gloclhrkEz3SCIgu/zU2YkVAPyrl4veOrJ6ri05y4tUtq4ISyms?=
 =?us-ascii?Q?IufJ2pHYskjCXQt5kOSzjhlCazU9S9kU5+P6d5HO4APawXtNJVOun5Ykg9bL?=
 =?us-ascii?Q?TM0qdVK5LAnF4EuLEio6lOa0OBVRxJZsD64V62r5oetZDY7IIjTwREs0Jupn?=
 =?us-ascii?Q?A67WU/xAb1OiJW+OmeSDujbzpvmNUlYVuynHI15ITgpx0U82DFOWd2kqyeRh?=
 =?us-ascii?Q?g9e6w59TDhnM7VBHhNfN/yeuFDJdVdFMrN4V64qVEsMmPcw0naFFv41/TC7Q?=
 =?us-ascii?Q?vdM+3GnQRwv6Le5BOzw7lKF9kZd1HDfONdRUS49PED8CSTxdFZbmrLqLbm6V?=
 =?us-ascii?Q?Ezh6E0+NGVoj1RoTHh5JPL7WgcodweQG5lSG/TQn/2VmJnpq9nO6s6pclteR?=
 =?us-ascii?Q?RHhp80b14rtHSJRIYX7ZMXfpYoH1n+Ade/SiaN6olTE0IaTXimrrZCY208Hp?=
 =?us-ascii?Q?8GK4ArBT8TyNHkoQ+XH90sv35Z49OUUCW0k/4sBLBghhKNBJPUq8psbRHN8P?=
 =?us-ascii?Q?QldpbG5Zl5vLy+W848CfjPrwWD+kq0ivpbYIb6E9ty2XL5HUr9uI6py6PEtl?=
 =?us-ascii?Q?mMo1ys0mQ9YnLVM/e3LsrOVMw8tmAnwkYr5QROepFnIro7luhBdg7dhClDWe?=
 =?us-ascii?Q?DCBmzd8nyMfzRSYqy71QSxnMrXJM6E+nnQg2thj+Gb8GH6mJkZH3ZjMdkntu?=
 =?us-ascii?Q?4QKJ47iQrKVBY4P706XzFZCHP/z5fKUQ71YUupn7jFotcITA5xYbmI/YsevD?=
 =?us-ascii?Q?rti73ZY8ea6+5O0nJfHnhx+Akuiy6yruZNS1WU77tlPaMI4KVL1ujUt95jlQ?=
 =?us-ascii?Q?uRUNhxRoAelu7VURO0neqUUicL1rdbUDwuufNnPnv4RZrIE5g5gGyoLJkL/J?=
 =?us-ascii?Q?T6vyJ1xN8IOgtGWUopo53+a6SJDxpbHMkfzwYb7L3K8g3u0snOgYXShVlwPs?=
 =?us-ascii?Q?tEtjQVOoqOzia6POEZjx4hkhkugDWbuJgLY0n3tHO3dt6kb89TsS/PozvwOw?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7680e7a-e72a-4eb3-caad-08ddaa0f6915
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 00:15:33.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/c07bwL5QNbxqjGtXRNH+sGWvGNd6ENELnq6zS8aL0KvuUdb1K8Dh9/itGJ7lQErImu0j83n7Ph6zPZlzv6Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7258
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/rcu/tree_exp.h:#__sync_rcu_exp_select_node_cpus" on:

commit: 1fccb15145eb73b06af682aff47acfe47235f139 ("rcu/exp: Warn on CPU lagging for too long within hotplug IPI's blindspot")
https://github.com/paulmckrcu/linux dev.2025.06.06a

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: rcu



config: x86_64-randconfig-007-20250609
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506121653.e7d1be72-lkp@intel.com


[  326.392305][   T17] ------------[ cut here ]------------
[ 326.395249][ T17] WARNING: CPU: 0 PID: 17 at kernel/rcu/tree_exp.h:419 __sync_rcu_exp_select_node_cpus (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/rcu/tree_exp.h:419 (discriminator 1)) 
[  326.398772][   T17] Modules linked in: rcutorture torture
[  326.401711][   T17] CPU: 0 UID: 0 PID: 17 Comm: rcu_exp_gp_kthr Not tainted 6.15.0-rc1-00059-g1fccb15145eb #1 PREEMPT(full)  c83de7334379d04ea860ac9db4e3031d8be8de51
[  326.407801][   T17] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 326.411423][ T17] RIP: 0010:__sync_rcu_exp_select_node_cpus (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/rcu/tree_exp.h:419 (discriminator 1)) 
[ 326.414685][ T17] Code: 85 c0 74 02 0f 0b 48 8b 75 98 48 8b 7d b8 ff 45 a8 e8 c4 dd 5a 04 bf 01 00 00 00 e8 f7 c5 5a 04 83 7d a8 0a 0f 8e 8d fe ff ff <0f> 0b e9 86 fe ff ff 48 8b 55 d0 b8 ff ff 37 00 48 c1 e0 2a 48 c1
All code
========
   0:	85 c0                	test   %eax,%eax
   2:	74 02                	je     0x6
   4:	0f 0b                	ud2
   6:	48 8b 75 98          	mov    -0x68(%rbp),%rsi
   a:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
   e:	ff 45 a8             	incl   -0x58(%rbp)
  11:	e8 c4 dd 5a 04       	call   0x45addda
  16:	bf 01 00 00 00       	mov    $0x1,%edi
  1b:	e8 f7 c5 5a 04       	call   0x45ac617
  20:	83 7d a8 0a          	cmpl   $0xa,-0x58(%rbp)
  24:	0f 8e 8d fe ff ff    	jle    0xfffffffffffffeb7
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 86 fe ff ff       	jmp    0xfffffffffffffeb7
  31:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
  35:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
  3a:	48 c1 e0 2a          	shl    $0x2a,%rax
  3e:	48                   	rex.W
  3f:	c1                   	.byte 0xc1

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 86 fe ff ff       	jmp    0xfffffffffffffe8d
   7:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   b:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
  10:	48 c1 e0 2a          	shl    $0x2a,%rax
  14:	48                   	rex.W
  15:	c1                   	.byte 0xc1
[  326.421654][   T17] RSP: 0018:ffffc9000011fd30 EFLAGS: 00010202
[  326.424977][   T17] RAX: 0000000000000000 RBX: ffffffff8837a488 RCX: 0000000000000000
[  326.428491][   T17] RDX: 0000000000000000 RSI: 0000000000000006 RDI: fffff52000023f7c
[  326.432035][   T17] RBP: ffffc9000011fdc0 R08: 0000000000000008 R09: 0000000000000000
[  326.435624][   T17] R10: fffffbfff147169b R11: ffffffff815ac0e5 R12: ffff8883ae954240
[  326.439162][   T17] R13: dffffc0000000000 R14: 0000000000000002 R15: 0000000000000001
[  326.442708][   T17] FS:  0000000000000000(0000) GS:ffff8884241ef000(0000) knlGS:0000000000000000
[  326.446372][   T17] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  326.449774][   T17] CR2: 000000000805b740 CR3: 0000000153efc000 CR4: 00000000000406f0
[  326.453432][   T17] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  326.456814][   T17] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  326.460466][   T17] Call Trace:
[  326.463548][   T17]  <TASK>
[ 326.466479][ T17] sync_rcu_exp_select_node_cpus (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/rcu/tree_exp.h:466) 
[ 326.469763][ T17] sync_rcu_exp_select_cpus (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/rcu/tree_exp.h:533) 
[ 326.473086][ T17] wait_rcu_exp_gp (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/rcu/tree_exp.h:731 kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/rcu/tree_exp.h:502) 
[ 326.476305][ T17] kthread_worker_fn (kbuild/obj/consumer/x86_64-randconfig-007-20250609/arch/x86/include/asm/jump_label.h:36 kbuild/obj/consumer/x86_64-randconfig-007-20250609/include/trace/events/sched.h:119 kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/kthread.c:1015) 
[ 326.479478][ T17] ? __kasan_check_read (kbuild/obj/consumer/x86_64-randconfig-007-20250609/mm/kasan/shadow.c:32) 
[ 326.482614][ T17] ? strict_work_handler (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/rcu/tree_exp.h:498) 
[ 326.485790][ T17] ? kthread_flush_work (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/kthread.c:971) 
[ 326.488992][ T17] kthread (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/kthread.c:464) 
[ 326.492081][ T17] ? preempt_latency_stop (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/sched/core.c:5876) 
[ 326.495175][ T17] ? kthread_is_per_cpu (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/kthread.c:413) 
[ 326.497975][ T17] ? _raw_spin_unlock_irq (kbuild/obj/consumer/x86_64-randconfig-007-20250609/arch/x86/include/asm/preempt.h:104 kbuild/obj/consumer/x86_64-randconfig-007-20250609/include/linux/spinlock_api_smp.h:160 kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/locking/spinlock.c:202) 
[ 326.501111][ T17] ? calculate_sigpending (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/signal.c:195) 
[ 326.504292][ T17] ? kthread_is_per_cpu (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/kthread.c:413) 
[ 326.507344][ T17] ret_from_fork (kbuild/obj/consumer/x86_64-randconfig-007-20250609/arch/x86/kernel/process.c:159) 
[ 326.510341][ T17] ? kthread_is_per_cpu (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/kthread.c:413) 
[ 326.513345][ T17] ret_from_fork_asm (kbuild/obj/consumer/x86_64-randconfig-007-20250609/arch/x86/entry/entry_64.S:258) 
[  326.516352][   T17]  </TASK>
[  326.519111][   T17] irq event stamp: 974697
[ 326.521876][ T17] hardirqs last enabled at (974711): __up_console_sem (kbuild/obj/consumer/x86_64-randconfig-007-20250609/arch/x86/include/asm/irqflags.h:26 (discriminator 1) kbuild/obj/consumer/x86_64-randconfig-007-20250609/arch/x86/include/asm/irqflags.h:109 (discriminator 1) kbuild/obj/consumer/x86_64-randconfig-007-20250609/arch/x86/include/asm/irqflags.h:151 (discriminator 1) kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/printk/printk.c:344 (discriminator 1)) 
[ 326.525370][ T17] hardirqs last disabled at (974724): __up_console_sem (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/printk/printk.c:342 (discriminator 1)) 
[ 326.528804][ T17] softirqs last enabled at (974422): handle_softirqs (kbuild/obj/consumer/x86_64-randconfig-007-20250609/arch/x86/include/asm/preempt.h:27 kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/softirq.c:426 kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/softirq.c:607) 
[ 326.532296][ T17] softirqs last disabled at (974411): __do_softirq (kbuild/obj/consumer/x86_64-randconfig-007-20250609/kernel/softirq.c:614) 
[  326.535643][   T17] ---[ end trace 0000000000000000 ]---
[  326.717325][ T1035] smpboot: CPU 1 is now offline
[  326.743123][  T886] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  326.747940][    T0] Masked ExtINT on CPU#1
[  326.806808][ T1035] smpboot: CPU 1 is now offline
[  326.836198][  T886] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  326.841248][    T0] Masked ExtINT on CPU#1
[  326.907274][ T1035] smpboot: CPU 1 is now offline
[  326.932209][  T886] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  326.936569][    T0] Masked ExtINT on CPU#1


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250612/202506121653.e7d1be72-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

