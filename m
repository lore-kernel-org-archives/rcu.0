Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DE3264CB
	for <rcu@vger.kernel.org>; Mon, 23 Mar 2026 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774247700; cv=fail; b=mOEZv/jD5NNWtPCIo3QMRWzVTQ/oRD6Ah7eMSaVoDoHeFaXwxR3C2d5oVAVR539qbv3S7M4tK4G+I691fN05iLiQCWLHT9Rtphjd3FSgNBTQ6D0dHUrwnwKuEwlbfuANieku0Uq0AClKNhRPwqoUvPOi4l03Q7m55whA0h9D64w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774247700; c=relaxed/simple;
	bh=TTv8ZvUYC7/uYJs+M+2HUk9ZHFRSDtP8QG6RjxpxFus=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QyG4eY1FuCN/7NhLrewgnLiTsgMUXXeLA9wPKuhzqlY1l8QSI3l3rtz/lqEDPi95ESjnFtl3kpp0cU+tq3oArxKscJSOpkzUmvu5+buNANeKO4tr0AV9mH1HCfbOgeRSR845ApJgaMruDq3pzcca24NTnB2xBtTQq5knHfGxpak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTCOrkRT; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTCOrkRT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774247698; x=1805783698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TTv8ZvUYC7/uYJs+M+2HUk9ZHFRSDtP8QG6RjxpxFus=;
  b=VTCOrkRThHs2zVRGhKCai0x6kUM2FSfVp5XBbGTQvxOxlo25j7Cxk1mZ
   uSX/yQvX374drBItxD1s47B8yBtvfAMS8FKuOiiYLJ0vAID2uezDtamE4
   0kAI2GnnZeA2I8RMgsdELjKMDcBuXW1P8qlH03guYUi6I/DRoSfBllmZv
   BjOI6FKiWQzOP8PVMG2m7EJjPpKy67N5G6XvPCvx4bhGXsGD/0dGRsG9Q
   qDbMmzwkEJhgnSSYqjw73LCz6PeZMWP7pvpP5HIbZhedeGoVuGWXdYbmm
   e4chZEevcZKg4r+p6+0hn0TlmTdrfsN9lRUz5iv0KWHG1fMvWBQi8S+1T
   w==;
X-CSE-ConnectionGUID: 5BDJesF/Q1OcuhlK/gl8Mg==
X-CSE-MsgGUID: kW7omuU/SA+IXCO+Nz3BFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75360682"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="75360682"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 23:34:54 -0700
X-CSE-ConnectionGUID: GsRSpATgQJSuYBx2R1L4Dw==
X-CSE-MsgGUID: mfGeDORrSdS73jLzC//sMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="246963561"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 23:34:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 23:34:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 23:34:53 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.29)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 23:34:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgMMg3Rhh3HLjbiG13a/6WO+AZbRK/7xMeuYsj9hZKEiw2pvJPnQBmqHuvi4JIn+gAJ2rXnmPwWmW5RSfcpDktPoY+6lA9J+zpb+gx6HRQkgpqd2PyZRzO374aaPkDGxjQHiYD0Q6huyOD5dykQfUgr8oSt9Wwije3AJkaXkdMHM3vZVCgYFRTcTEC5Bqc5Xm4OyhClZb7Dt+3n56H98CUtcaEFr2O2R89+PxJz7S3IO5weKbfhTpRmZUQTMAY6iDyq8gFUuLHXF9odbVRIe15p4MIyiNH0OtnmFEibwzD4QDAKGBBq2378+dw6nm30xR9AjD8Z8CJkg3x7iXF8/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XijUn0PicBea57Ha7w7kQ61a3HEe0CG1/9pMmTr+Pqw=;
 b=c3KpSnY8I+rN2FkaEHzzirHGjKHJdPz6wQW+FYmu1x13VmQT33qMVY3EEik+8ijlgyXyfzmJ5hPQ1+DUk3Q5Mqdbil9XN2NVBYK0abPbFAIOvI4RZmcHWJixg8tZMLrmFiolJfoL+fd5RAueNfPi43yyf0qVbgGXBa1sVWoQGYFuvLbqxQSRQxF8N0IX/ruK0UbAsctZ7L9wwybVSfdNQU+PP5Sbz7vpTK8VRUIcNVYqaUGhi1/YGDe5Wthp0yNGf59jB1mfqJDLle7g6q3UHl5a0udn9HLgzrUyedPQa0/kWbID8quW04HYRjfkdpovWw0OCJ7egzfNeoHRagfxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 06:34:50 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 06:34:50 +0000
Date: Mon, 23 Mar 2026 14:34:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Boqun Feng <boqun@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Joel Fernandes
	<joelagnelf@nvidia.com>, Andrea Righi <arighi@nvidia.com>, Zqiang
	<qiang.zhang@linux.dev>, <rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [rcu:rcu/dev] [rcu]  02bf38db37: kernel_BUG_at_kernel/irq_work.c
Message-ID: <202603230706.d0d75fea-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SA1PR11MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb8813c-9c2d-4ace-75e2-08de88a648d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: rRrS7B6T5RXvZtdH66G0vWwEi4e0rnWQQ5piJb0187ETBgOSwFuwz1hFdjsB/MLAVO6S82f0VJuSsjBPNtq+pVzLV6k6hIUK3EvsUYiEps/9bNoy2uo58hWDrkoej1zlalcdOMcbxOvzWKmOFbRR/oe3dn/I3zQGElhMrFcOxQBBLzqCYwT9haopzK26gr7sZzZo7ZRzmxLje4KczlCEe4uTbSp3Q5Qgw49EbD4S28ITxQfx/A7K699WcgTPDDQFZJpI6fXemwl1mP7LHvDEBMSIdqSHn2alOzR7HacpBZNObgB3O1IabNTaL2/dHGAkWiMrxvE0S0eLI6hdxdtVDJW5ADeIZkZoSIN+IZtDnspqn0yUkcRurd9rtuD5QdDj/NazQh9/4ldh+9/1Og0QYOX1F7xvJyABGMBckphionIF/+315j68v1Oba5bXYLx+p7hGMt+1ynh44lyGIuepjkxIv0OOJJVYULeXgi6+MYEX+QcHGhBZvgV3AcoNjgJuk792VmdfrOKZCu8/8bi4HuAZsmf3IlnU6hHS35qDFlYjVh9tIgHeMhq13XOSOTkVOKWtVk4tytRxOEgfFPEqrtUf+3NKtn+wbhaJhxoLuFemHg88ul0tE6tlSQLlyEe08ieyNdl++L5fako7kYy38t3DVPopL2K2kRhlggpk4Db2CXAPFCOQYdObiZEBNHnqMlzNtQ8RD6rfNs6Yo8x7/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Spy9zQ/E/k7UKYg1yAWVtymtruOnAKsYgUYWbO6GXvg1qHXhAGZA5QwlR3h?=
 =?us-ascii?Q?h8vC5lDJmj/CWxPoC517UT1OCcayBxeb7zfdA2StBA+T93j3qK58o8MaH5jF?=
 =?us-ascii?Q?Y6zB3qtnUVZ69AWoe5vHuq2xCZr7gOGRF1yfuPUWyfT4XDR42P7F7xD75Axg?=
 =?us-ascii?Q?U006VI7FfRNYflpxYLsQIsef58RKEtidbDO7jH3StMbYj3rso16uoDX65JXJ?=
 =?us-ascii?Q?0Mc6QDFVX/4RbiI4oSCPmCaLAc/EpikbPOYXjKAMG3RVGxmiDI/Ff7d2GfgJ?=
 =?us-ascii?Q?c83a4X7dE2agC19JsIwqEO+HuCymShC0Wpd6JhoAj2WXxhx7gUE7ne281ekr?=
 =?us-ascii?Q?Kuw+OHofkaRqAXEwTR7doT9C6qy8XpBPi/FY7BGPbvSo7CnUGXCH1CgITaIv?=
 =?us-ascii?Q?dMQx8Uv1kJBQj8Ro0+2qm8EVjCTDoryKONu2fsmpRhNqfgPSdac437QbpNMw?=
 =?us-ascii?Q?qR74UB2xyQPT7f8cDd1tBFc92wHKLGkPMI1WWfNja2JgL0dUcocWaX/W9y/A?=
 =?us-ascii?Q?iC3n6ZYqjDAdU+Lv0ns7I5R8SXAAF9sScQflXC7/3RKv6mYuq1WgWXXbq1Jd?=
 =?us-ascii?Q?BaFNtVQMIJg4Vbemo5lynqOaPm189kx47s5DNQoU3CzkhtaKCz871bFqsL4j?=
 =?us-ascii?Q?qaIG3XJgGrSApOQ4JfDkpmT2UocsByvLOa+g5kfyyGCGxXHzVXObZ6Q16FkZ?=
 =?us-ascii?Q?2dJBPO4e1S+9X546kx8RbkfstTTD5ilkzJOF86F86FSRwkGbKKMVoqBkNfO8?=
 =?us-ascii?Q?P8zWfwj2fsG/G/jAOswI39IKojviQ6Runv9GdG/fElORLJHVhJLAbETkOLhh?=
 =?us-ascii?Q?G5mZBSGn1aA8VeJ2Frss8l9MH7XNoATYVX4IQmHHl8DJPxnocz7gDoREWLNr?=
 =?us-ascii?Q?Slrj0UYAFRcvv3fLcCdjHq0DK1o6owQlYvKvPiaBq8PZdWlk10WyAhLcUnYE?=
 =?us-ascii?Q?mNfNzRIimMqVQCosjBlJ9zrUJuD4kn8D1yufIyaAEt0HmZjojxm3OjPCM6B8?=
 =?us-ascii?Q?DtWBnzJ13ZbG3KghH8CisvHf56ggySyTu+TgOruCKd2xd6T7wS2wgezaOfFo?=
 =?us-ascii?Q?LH2fGjrkXRskEDlImroi5xgodqa2Ml4hTqyoxlXL8DHpm5KUqWcfRtRJGYIC?=
 =?us-ascii?Q?sE7Oi8Fp5PI1H8BjRw0HveoucW5MdISI+2vvDTWsYYeVHzT+knDZxq1yLl03?=
 =?us-ascii?Q?tx2gVVVUlYTaWXwx1WXpPjPs0Qa7zT8NNTPdD+89Z5ThTuhootXAYlLR7dIu?=
 =?us-ascii?Q?ieLNwdk5/ezSzuWDZ/0Cb0EK0tOPfPGGTjaEw52AxLH7Ssj3CAJQjCVCrumi?=
 =?us-ascii?Q?Dii9WrNX2lK0Y3y4xIjbUDiE6CEI/luJz6Zau8bcK2TiFXGZI8i9GTdKDirh?=
 =?us-ascii?Q?nUHerXR9lakXlTsaBY2WYj0V6B/xRKQbxtYQmNkocAFlfGDIoQCWd0OnvgUA?=
 =?us-ascii?Q?usoqVJFjYJyvijTx/nwfkwSQ7jIDzvGm+ttN2HJaQFRsb81uii8jZYMO3DYs?=
 =?us-ascii?Q?UtuQG9BA2zf7Q4ePzCXPIFioRq3FTTmQC9+CyzhGA7lp9iZjwojI/nTrAEIy?=
 =?us-ascii?Q?UCFcA1PGTBX5Vq5fcJfhOP7jPsDUtXYNft07yhnW7vDwb4ZR1uGVfeu5fmTM?=
 =?us-ascii?Q?0e3pHu1u1wk0RTO/hUzhqaY52HZCCAtMTGA7j9QIARzK6xNJfJLhtrxhYFv+?=
 =?us-ascii?Q?pYzucnoDQcEDpT9ByHjDDDVFqLeCWPgWTBYDKaKlwSlTl9BLKkmCbGP2IiEj?=
 =?us-ascii?Q?7SHtRKNFSg=3D=3D?=
X-Exchange-RoutingPolicyChecked: FI4TB/Ux1kGxlFrxLwVGiXWcrxZr+1XV9fD6ilbXJY39rViSw3FbP8y1jE1UUN4OQhwsci59MFkvXgDFGBEy30soxHaPdtBf8vVVHgmyRTwE1UF23BbLmV9IzeTyPfatihbVBwCh/YwtTltvCryWO/1nCjVbzV4Bc7dD0h0kqj5FrUbWScVUF/FA1t53R8uUyJZoV7l5a17GyR7/P1Jggtf4A5iJGBD18eqxoXPOHZR4zDFwC/9WRFGTXdMyWu1WcEgj/ajfDHYIV+IROdDu0TgT8Omg6KovmNXGhTAcaO7yeHU8W4RKyFOwJnSWTRkfTD0RV5sans8segTzack3AQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb8813c-9c2d-4ace-75e2-08de88a648d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:34:50.2957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YBq2C5exJeyaLlfJ5yne07biUe66kpm7lfl31jqutiyN+DZei9JUNp0erdzOSuZeZ4TJYlBDLCbyCUJfvCcxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_kernel/irq_work.c" on:

commit: 02bf38db37c44207e5fa4ee205148cea7588da7b ("rcu: Use an intermediate irq_work to start process_srcu()")
https://git.kernel.org/cgit/linux/kernel/git/rcu/linux.git rcu/dev

in testcase: boot

config: x86_64-rhel-9.4
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------+------------+------------+
|                                                       | 15d921a7bb | 02bf38db37 |
+-------------------------------------------------------+------------+------------+
| boot_successes                                        | 6          | 0          |
| boot_failures                                         | 0          | 7          |
| kernel_BUG_at_kernel/irq_work.c                       | 0          | 7          |
| Oops:invalid_opcode:#[##]SMP_PTI                      | 0          | 7          |
| RIP:irq_work_run_list                                 | 0          | 7          |
| RIP:_raw_spin_unlock_irqrestore                       | 0          | 7          |
| Kernel_panic-not_syncing:Fatal_exception_in_interrupt | 0          | 7          |
+-------------------------------------------------------+------------+------------+

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603230706.d0d75fea-lkp@intel.com


[    7.880152][    C1] ------------[ cut here ]------------
[    7.881714][    C1] kernel BUG at kernel/irq_work.c:245!
[    7.883180][    C1] Oops: invalid opcode: 0000 [#1] SMP PTI
[    7.884704][    C1] CPU: 1 UID: 0 PID: 29 Comm: kworker/u8:1 Not tainted 7.0.0-rc3-00020-g02bf38db37c4 #1 PREEMPTLAZY
[    7.887379][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    7.889736][    C1] Workqueue: events_unbound fsnotify_mark_destroy_workfn
[    7.891397][    C1] RIP: 0010:irq_work_run_list (kernel/irq_work.c:245 (discriminator 1))
[    7.892706][    C1] Code: f0 0f b1 53 08 48 8b 05 9d 71 f5 01 f6 c4 02 75 bc 48 8d 7b 18 e8 cf 7a e1 ff 4d 85 ed 75 b3 5b 5d 41 5c 41 5d e9 8f b7 e0 00 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 66 66 2e 0f 1f 84 00
All code
========
   0:	f0 0f b1 53 08       	lock cmpxchg %edx,0x8(%rbx)
   5:	48 8b 05 9d 71 f5 01 	mov    0x1f5719d(%rip),%rax        # 0x1f571a9
   c:	f6 c4 02             	test   $0x2,%ah
   f:	75 bc                	jne    0xffffffffffffffcd
  11:	48 8d 7b 18          	lea    0x18(%rbx),%rdi
  15:	e8 cf 7a e1 ff       	call   0xffffffffffe17ae9
  1a:	4d 85 ed             	test   %r13,%r13
  1d:	75 b3                	jne    0xffffffffffffffd2
  1f:	5b                   	pop    %rbx
  20:	5d                   	pop    %rbp
  21:	41 5c                	pop    %r12
  23:	41 5d                	pop    %r13
  25:	e9 8f b7 e0 00       	jmp    0xe0b7b9
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  33:	00 00 00 00 
  37:	66 90                	xchg   %ax,%ax
  39:	66                   	data16
  3a:	66                   	data16
  3b:	2e                   	cs
  3c:	0f                   	.byte 0xf
  3d:	1f                   	(bad)
  3e:	84 00                	test   %al,(%rax)

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 00 
   d:	66 90                	xchg   %ax,%ax
   f:	66                   	data16
  10:	66                   	data16
  11:	2e                   	cs
  12:	0f                   	.byte 0xf
  13:	1f                   	(bad)
  14:	84 00                	test   %al,(%rax)
[    7.896993][    C1] RSP: 0018:ffffcf20000f0fc0 EFLAGS: 00010206
[    7.898320][    C1] RAX: ffff8b7e91a34000 RBX: ffffcf20000ffca8 RCX: 0000000000000001
[    7.900113][    C1] RDX: 0000000000000020 RSI: 0000000000000002 RDI: ffff8b7e1fd2ad00
[    7.901905][    C1] RBP: 0000000000000000 R08: 0000000000000400 R09: 0000000000000002
[    7.903620][    C1] R10: ffff8b7e1fd31d80 R11: ffff8b7701401ad0 R12: 0000000000000000
[    7.905254][    C1] R13: 0000000000000200 R14: 0000000000000000 R15: 0000000000000000
[    7.906941][    C1] FS:  0000000000000000(0000) GS:ffff8b7e91a34000(0000) knlGS:0000000000000000
[    7.908747][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.910001][    C1] CR2: 00007fe73c0c9170 CR3: 0000000100bb2000 CR4: 00000000000406f0
[    7.911582][    C1] Call Trace:
[    7.913403][    C1]  <IRQ>
[    7.914087][    C1]  __sysvec_irq_work (arch/x86/include/asm/jump_label.h:37 arch/x86/include/asm/trace/irq_vectors.h:63 arch/x86/kernel/irq_work.c:23)
[    7.915049][    C1]  sysvec_irq_work (arch/x86/kernel/irq_work.c:17 (discriminator 35) arch/x86/kernel/irq_work.c:17 (discriminator 35))
[    7.915965][    C1]  </IRQ>
[    7.916600][    C1]  <TASK>
[    7.917214][    C1]  asm_sysvec_irq_work (arch/x86/include/asm/idtentry.h:733)
[    7.918173][    C1] RIP: 0010:_raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:179 (discriminator 2) kernel/locking/spinlock.c:194 (discriminator 2))
[    7.919364][    C1] Code: 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 c6 07 00 0f 1f 00 f7 c6 00 02 00 00 74 01 fb 65 ff 0d 41 c5 b9 01 <74> 05 c3 cc cc cc cc e8 d5 78 f4 fe c3 cc cc cc cc 90 90 90 90 90
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	f3 0f 1e fa          	endbr64
   f:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  14:	c6 07 00             	movb   $0x0,(%rdi)
  17:	0f 1f 00             	nopl   (%rax)
  1a:	f7 c6 00 02 00 00    	test   $0x200,%esi
  20:	74 01                	je     0x23
  22:	fb                   	sti
  23:	65 ff 0d 41 c5 b9 01 	decl   %gs:0x1b9c541(%rip)        # 0x1b9c56b
  2a:*	74 05                	je     0x31		<-- trapping instruction
  2c:	c3                   	ret
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	e8 d5 78 f4 fe       	call   0xfffffffffef4790b
  36:	c3                   	ret
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	74 05                	je     0x7
   2:	c3                   	ret
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	e8 d5 78 f4 fe       	call   0xfffffffffef478e1
   c:	c3                   	ret
   d:	cc                   	int3
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260323/202603230706.d0d75fea-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

