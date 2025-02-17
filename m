Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD014D433
	for <rcu@vger.kernel.org>; Mon, 17 Feb 2025 06:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739773839; cv=fail; b=eOTHNYEd9GsY1WgcScDdP2yDzLMrtohdm158D2C61NAye7OwsnPGeRoUirRhc5eULvsI4sWUgq+nvgHXq/HKHN6cA/4YB5avHfcjGNaw8lIolflU30cdfZ0LObibspDHTj3kq667OXD9sgYgZMF8FucOeU9Mc6+qlf/OPBZRJi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739773839; c=relaxed/simple;
	bh=L50UE277fhz14DhzxwwDA79i5u/zUXM2z4GGUgexoeQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ippK7W78cQpY5kV/mGAKydgsCwCvu+BOO8ZqNaX3e5zi5ICnHxok/Md/Yi69mAThtqTN+N/vSMYqVsD9ueozw3yLFDXJ1QbUm3PZUCc9DCTVn7ajyRzx0f5odH/jrbOx5lROYrYmEggC9AeTDP5rRAmtMNciZtP4zcSSPVWwe30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6MUhcL3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6MUhcL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739773838; x=1771309838;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L50UE277fhz14DhzxwwDA79i5u/zUXM2z4GGUgexoeQ=;
  b=J6MUhcL3L/MYhQ0POW5JfIPwaM6zm52BC1SYRlbeDGUBe8EuhpsiEo4l
   agYyuDSl8M2ygwZfiwE78OBywywSYeGwl1trgQu4YZXRxg+dqy0UR1FqH
   61UnMEmi4NV3suAfCR8YyKJVFvQKCHDpT44gWus8BwRUyk/3ckGgbGpnz
   +UHk+W2oQK7Zsy4ZS8fUk0W2gVV6PAmmI8BteAW4Vo6ZLX6I69O/eb6Bg
   b2VsFW+rbV3kfs8k1mc14jZlzGU3RTvTrasmPKDct+g6SMwUP7JA/fhFy
   3WUnoJdaV24CbLvFq94y0UXYPvEKcrTl+a/YN1rgAPPyY+JkFDjQalRfE
   w==;
X-CSE-ConnectionGUID: CJwJSKcsQ1i0fYBRPhiBWg==
X-CSE-MsgGUID: JBV7QnKOS4WpEn5jynEUog==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="51855388"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="51855388"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 22:30:34 -0800
X-CSE-ConnectionGUID: DZTWBo1wRECr15373d1hng==
X-CSE-MsgGUID: g7j0kkyIRSaFyVtTWc4uag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144948721"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2025 22:30:29 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Feb 2025 22:30:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 16 Feb 2025 22:30:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 22:30:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPB04eu5YjiuoUyoYZPHjXVoEqiOUlr2+hMe5wIaRJ3t/XZbOe6vPwJTJBZOTF+XyeRNeQlvCGxUtxL2DQp7pM8QWPvfZGv0llm/5pNSlNStI+PfERIys+m4AhkxnlwWeBjskQHYiOqQSEmER2T7W2Bvs4lwwv9D+WMFMSjVwI0Kitnp7CUy4dIMlAvwJ0JlHAPtG4lSTkoPuIJ1lnjvabQvSbH8NhReXHsbFrNPJc4BeiGDvAI9qcUSH9YM/ENM9oPhDHEggaYtQCQrussmWyEoZ9qUj/kfQDtkhZ+TS6tvdyAmrugxytFc5qPCLG4vYg3i3xwqE7T6w6TJhgWXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egSBFX/IoQjVP4xVIqjTXxCsn3WHvYjGV0olG8xWdbg=;
 b=yq0xl+XW25HsigODz7DtKlSWfSH1kDgjIPeRjO/MmGSkssz/h7I8e9qIWVcW0au2ogGOVjoVbDte1bUkidB/AGPKl8Z2+42e6zpCbwqNPrOFrTrHmS2wQHMn6tS8O/NgiSlNX25HOTECAVFF1n7jVa8beKpOmUsOudSJ6Pth/1qJzZfA61Cor3QMGYn4sCROgpv5qNFOOtw8/1qX2Pfo4S+0D9T0Re+P4Lyk+yLW7ZwrzaKc6Rrk8xzqPjwTkOGGbdeWbbuu7OMrLv/dgpELCME+xr5Ntn55JnTukpNyVZeQ4jezN74fWZ0OlZkiCdxQq2yhThTj9odNOXNhygnsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 06:30:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 06:30:26 +0000
Date: Mon, 17 Feb 2025 14:30:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Boqun Feng
	<boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>,
	<rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [rcu]  c9b55f9da0:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <202502171415.8ec87c87-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d58b47d-babe-4e81-88ff-08dd4f1c90a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C9iHb7HLqFwnpTuP4+cWxOttO/MfJ8cz/nNz8b/T7dcYdtoThAdxyfp/rmqx?=
 =?us-ascii?Q?a43Xld1B37y2Oz4sFacfsTGRgNCQLnMPFkehrsR8hiAmTIIGuS6M2huERbPQ?=
 =?us-ascii?Q?PMErpF4eB9vlqVNqda7dhoU/9pksfe3kUG01TvCgFqPB6eqmTqy55lM0aI0/?=
 =?us-ascii?Q?/msK8BUUwiVBg5voZyPCXyWwQjGBNCPbiwELafeuU6Ar7cBCsi18KPBOHC00?=
 =?us-ascii?Q?STUKRt3s5UwEVg9pBcF3UjabngQggJM/pYJbCL9NPp1YWJPoSnXg22a6Ol1M?=
 =?us-ascii?Q?UzDP/uFx4gpU1+Y/fzUbP2OK6WDqsOabgwp+ChNd/bPolTfei8Ysp49cSQp6?=
 =?us-ascii?Q?/stYW++hSAhAuNkWXFuMivRWXSIuFW9b/YDgoIyRbdp6K//4kxr3onTiDknv?=
 =?us-ascii?Q?kqtn8waSCtjaqWSgs1sT3XGkCiDPkdkHaMfDkkTpNO6qu5YWPSTZ8Zjzzntv?=
 =?us-ascii?Q?ivVWdghADukCIeEz4/Ia7WoNpOupL92QgOqzulnZtaps/HNSnlvJNWb5JoBX?=
 =?us-ascii?Q?yIVr/H7Rt7UfJaW2LPf+WrBreI6zYq3MeUIExS14FoqTfVZqPu0keiBRoPVy?=
 =?us-ascii?Q?gCZPnPetPi3f1KhEh5t0SEH+x05dWErCz+Yqe6t8IBxwlko06IeT/dfMt5Xt?=
 =?us-ascii?Q?nmFxpc+t8bZf5lXBHUSRsAMWCw+iklwieyXm1KakSzHVQn5PLUa9YObLwh4T?=
 =?us-ascii?Q?UXwgQZ9R/AsbF2uzcq9OerFzg5x+Ax8gho8unyBfl/4ZdefV5vu4bCtQGruM?=
 =?us-ascii?Q?9E1SUT/dqj1eLuZhcFnmXLcq22RooGT2JTXI79IdeLa/KW49UuRHUd/hYCJh?=
 =?us-ascii?Q?3VemMDWTm3d5rT+WXU6SMXtAWu35NU9FsjJDOMcykdNCg0uYUIQKrXHtKoK0?=
 =?us-ascii?Q?ChOyeRrXbVqtqbvSJa8YBZHotEh8Wy7NIoWzpGrdxEBKGw6alae0UTKJZd7B?=
 =?us-ascii?Q?PP1Toq40J4jkZbAgi/5Iw6P5oUlTC3woNTMeZSXb6O59LgkcP2UDsW6mKeCv?=
 =?us-ascii?Q?XbzwTXdY+Kseb+vuwetmz9jAU7rPuV9HuNUM4+r8j+JHEGZlVnkA1o6lkJAm?=
 =?us-ascii?Q?K6jqQCz3rhJJgKl7Sb4K8lWA+twR4R7Zm0GIHcb1JwV1KhZ/wVLmfg1aRlJo?=
 =?us-ascii?Q?2nC4l/c6wdDXgCDVvyXBku/wdd4GBjVypkwe3NpHjiDENL2GR2iUdhK/CX/+?=
 =?us-ascii?Q?RK+fqoxyqe5YarqwFfTXl1WwgzvZ/LTMOYkU+JIWDyXP/31BUj90Dy4vK60e?=
 =?us-ascii?Q?OeNkBNFL4n6TmpKsk5aNCqOnn3j4YYaPIQHqrhNqwtMdm7tjeMCjljlZF6l5?=
 =?us-ascii?Q?Kz6NwPnPIPNsltR/Ws9Eni9zPyPWBwRpbWqZONHEq5PE6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?INWZHxvZNE2hLNNYXrWxrBSjhhvLit8bB0F8nqOdtxn/tKcFzDzok1SZs+dX?=
 =?us-ascii?Q?vZNdx0sFi8yER5spdgY15NDQhPSGFlwgS9rKwqxxw84vdeMtM46eQAiMiDLS?=
 =?us-ascii?Q?2R2r160EMQt1JCeU4E/H6Cs93e+D3ihuW2jxPYk1K3W6h28a4lORvSUORxuB?=
 =?us-ascii?Q?yFheqJWOxAux/ihq82WIUflmtl4Yee1GQXmgj6RgEfZj0SJ4lBZg1GPi4MYs?=
 =?us-ascii?Q?v8hD+cWei52RWDVNW1tr9E+GuuQFZZe3QlnDZGdfM5T+XkziaWvrOl9bNS8N?=
 =?us-ascii?Q?L6jIcY+b/gZe1KdfSGcpPV84Vw6e1r4BMFjKmTGRQ4/rHKyhUn/Sz/mn0gKh?=
 =?us-ascii?Q?hYx2F6wQCDi6QIjHdYlPmqqvXC9xvPcOZRrMcRKAkkSYEAaZNdFFZz0RW0in?=
 =?us-ascii?Q?Y7/oJJslR2mqTIZhqy9dFrPkLPSDhRIaS8lQL95HoFit3xDjwJ8W2lwKuNXe?=
 =?us-ascii?Q?08jie2vqKDtsbgTDTpea2EfrQ5akwm1Wqd3jNgpA1WIAs9X+h6KsQHcsM5qA?=
 =?us-ascii?Q?XBpLzaYrqblb/iIWzXir0W80LrBMidG/WkOhqAuveCPuMhtnXV/exh1Rn9D0?=
 =?us-ascii?Q?fQWSI8K2gP5I4infG8nGRYVQgvptttBoKd7Y+mnSmvw5Apfp9pmBW1h0ZLQI?=
 =?us-ascii?Q?KGDGRGI2LVoUgbofnoxqP0WaROHcL8qWbK89rZ/qOK5dux3i5pAntN3pCzEn?=
 =?us-ascii?Q?ZKuRe/pMSUuhjNfrVpoogiBCPDnFMVFax/RNjK0I2l0A+VOpOkxILSAztQfo?=
 =?us-ascii?Q?s7cpad3rPpXEOm7uOoIEbU7VX3GYO1uJwqqAiC47G+oWLV4HiWHlQCgLNPSr?=
 =?us-ascii?Q?Z9zSqzp0/pRwUp1ZEd1VR49c5AEMhrUZPFjfkTT0gb+4iWUiwrUozHy+cY4i?=
 =?us-ascii?Q?akRBKVOfkZMpzpMprrTrFm4e9q23rHz5IbuaK2ENo2jYUnNIo1bOL4SsxRmR?=
 =?us-ascii?Q?Dpfb/JYLgPVraXgm3ZxlYWPYoSgbnUcwe4MRk3nC+1xTXkoM+8T7XFEJHaHr?=
 =?us-ascii?Q?l7MUhy7z44Crc62o4kFx0hXjgiBsklj7pUZYuFktOJDdQAUJswTD49z598qc?=
 =?us-ascii?Q?NFkEXba4nfF4j58X1eD+vGXtNxPwSQ8Z3eckXG260sciKXvgjYx2Rl2iaRCJ?=
 =?us-ascii?Q?a3kaAvRvSWojsF7UXuutzx00x/LUylPiLaiAEg7aniyiKDZGRzjgG+THSDle?=
 =?us-ascii?Q?pRsyRc8YDfG92jGXmr6Mpn2PBk2MUVyTUp9+MqPfR345cq2ZWQNgCoty97xd?=
 =?us-ascii?Q?0IR0Usd4906mzyX2lGjm8P8z48BRVtbfCEBjN7ZuGEryLHHeflp6g1k3Mo/Z?=
 =?us-ascii?Q?Z5KCjY9yacyO0mPUVXbZaXwE/c1wYsfrDOA7VneWAi3jaQejbsWL9GYL4r7m?=
 =?us-ascii?Q?DQSbK+fqmJmDveyhFGpxZAsBPPJNAhFet/hsybfAl/FMhwUpSdFvUK9OtKL2?=
 =?us-ascii?Q?cbGu1KnLYtE5SCNMy00LsxSA82lvI2RNGiqKD0GZxjkLt9DNDcVWX9YJq7yw?=
 =?us-ascii?Q?asfgplrOgyiemZtJhp6aSJrEamMMTy8lkmzW11rH7uxJFmi3vjpN2+1j7AF1?=
 =?us-ascii?Q?NDt6zgyBaCd5m61oBvX5j3O9IyODaHhpJLaeE9G8IQ5NDMrI17jo8e0GCePE?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d58b47d-babe-4e81-88ff-08dd4f1c90a9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 06:30:26.4533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCRKaJpf849b/eGIUv2/d09HyN7H5YmP+VFaUH8UcS26MDAKQ3sThSPpE2a6oyExqWArykRIpFjBVUbm5qnRtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6804
X-OriginatorOrg: intel.com


hi, Ankur Arora and all,

this is not a regression report as our bot normally does. this report is just
FYI that we observe a WARNING with this config, in case it could supply any
useful information and/or somebody wants to have a look.

by this change, the config has below diff with parent:

==================== PARENT FIRST_BAD KCONFIGS f001b7165def8f7af6ce95d08f0e1bbc2442654d ====================
--- /pkg/linux/i386-randconfig-r121-20250212/gcc-12/f001b7165def8f7af6ce95d08f0e1bbc2442654d/.config    2025-02-13 07:56:33.420457682 +0800
+++ /pkg/linux/i386-randconfig-r121-20250212/gcc-12/c9b55f9da0d2c72c8c8d8cd5df84af5251b74283/.config    2025-02-13 08:43:08.186415593 +0800
@@ -147,7 +147,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 # RCU Subsystem
 #
 CONFIG_TREE_RCU=y
-CONFIG_PREEMPT_RCU=y
 CONFIG_RCU_EXPERT=y
 CONFIG_TREE_SRCU=y
 CONFIG_TASKS_RCU_GENERIC=y
@@ -162,7 +161,6 @@ CONFIG_RCU_STALL_COMMON=y
 CONFIG_RCU_NEED_SEGCBLIST=y
 CONFIG_RCU_FANOUT=32
 CONFIG_RCU_FANOUT_LEAF=16
-# CONFIG_RCU_BOOST is not set
 # CONFIG_RCU_NOCB_CPU is not set
 # CONFIG_TASKS_TRACE_RCU_READ_MB is not set
 # CONFIG_RCU_DOUBLE_CHECK_CB_TIME is not set


below is full report.


Hello,

kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:

commit: c9b55f9da0d2c72c8c8d8cd5df84af5251b74283 ("rcu: limit PREEMPT_RCU configurations")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master c674aa7c289e51659e40dda0f954886ef7f80042]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: rcu



config: i386-randconfig-r121-20250212
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------------------+------------+------------+
|                                                                             | f001b7165d | c9b55f9da0 |
+-----------------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture] | 0          | 12         |
| EIP:rcutorture_one_extend_check                                             | 0          | 12         |
+-----------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502171415.8ec87c87-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250217/202502171415.8ec87c87-lkp@intel.com


[  109.553253][  T781] rcu-torture: rcu_torture_reader task started
[  109.553258][  T781] ------------[ cut here ]------------
[  109.553259][  T781] rcutorture_one_extend_check during change: Current 0x4  To add 0x4  To remove 0x0  preempt_count() 0x1
[  109.553292][  T781] WARNING: CPU: 1 PID: 781 at kernel/rcu/rcutorture.c:1905 rcutorture_one_extend_check+0x25a/0x267 [rcutorture]
[  109.553302][  T781] Modules linked in: rcutorture(+) torture
[  109.553307][  T781] CPU: 1 UID: 0 PID: 781 Comm: rcu_torture_rea Tainted: G                T  6.14.0-rc1-00007-gc9b55f9da0d2 #1
[  109.553310][  T781] Tainted: [T]=RANDSTRUCT
[  109.553311][  T781] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  109.553312][  T781] EIP: rcutorture_one_extend_check+0x25a/0x267 [rcutorture]
[  109.553318][  T781] Code: 75 2d c6 05 fd 04 1c f1 01 64 a1 84 77 7c 97 25 ff ff ff 7f 50 ff 75 08 57 53 56 68 60 9f 1c f1 68 a4 74 1c f1 e8 8d d3 ca a3 <0f> 0b 83 c4 1c 8d 65 f4 5b 5e 5f 5d c3 55 31 d2 83 f8 1f 89 e5 53
[  109.553320][  T781] EAX: 00000066 EBX: 00000004 ECX: 00000027 EDX: e89c1a00
[  109.553322][  T781] ESI: f11c92d9 EDI: 00000004 EBP: 825d1d88 ESP: 825d1d54
[  109.553323][  T781] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010282
[  109.553327][  T781] CR0: 80050033 CR2: 77235000 CR3: 010c5000 CR4: 00040690
[  109.553328][  T781] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  109.553330][  T781] DR6: fffe0ff0 DR7: 00000400
[  109.553331][  T781] Call Trace:
[  109.553333][  T781]  ? show_regs+0x4c/0x52
[  109.553343][  T781]  ? rcutorture_one_extend_check+0x25a/0x267 [rcutorture]
[  109.553349][  T781]  ? __warn+0x9e/0x15f
[  109.553354][  T781]  ? report_bug+0xe8/0x14a
[  109.553357][  T781]  ? rcutorture_one_extend_check+0x25a/0x267 [rcutorture]
[  109.553364][  T781]  ? exc_overflow+0x37/0x37
[  109.553367][  T781]  ? handle_bug+0x3a/0x55
[  109.553369][  T781]  ? exc_invalid_op+0x1a/0x56
[  109.553372][  T781]  ? handle_exception+0x148/0x148
[  109.553376][  T781]  ? osq_wait_next+0x18/0x41
[  109.553379][  T781]  ? exc_overflow+0x37/0x37
[  109.553381][  T781]  ? rcutorture_one_extend_check+0x25a/0x267 [rcutorture]
[  109.553388][  T781]  ? exc_overflow+0x37/0x37
[  109.553390][  T781]  ? rcutorture_one_extend_check+0x25a/0x267 [rcutorture]
[  109.553399][  T781]  rcutorture_one_extend+0x18c/0x3c1 [rcutorture]
[  109.553410][  T781]  rcu_torture_one_read+0x95/0x4d2 [rcutorture]
[  109.553417][  T781]  ? validate_chain+0x3d/0x24c
[  109.553420][  T781]  ? mark_lock+0x6a/0x14d
[  109.553440][  T781]  rcu_torture_reader+0xc4/0xdbd [rcutorture]
[  109.553448][  T781]  ? rcu_torture_one_read+0x4d2/0x4d2 [rcutorture]
[  109.553457][  T781]  kthread+0x169/0x16e
[  109.553459][  T781]  ? rcu_torture_read_exit_child+0x3a/0x3a [rcutorture]
[  109.553466][  T781]  ? kthread_is_per_cpu+0x17/0x17
[  109.553468][  T781]  ret_from_fork+0x19/0x2c
[  109.553471][  T781]  ? kthread_is_per_cpu+0x17/0x17
[  109.553472][  T781]  ret_from_fork_asm+0x12/0x20
[  109.553475][  T781]  entry_INT80_32+0x108/0x108
[  109.553481][  T781] irq event stamp: 307
[  109.553482][  T781] hardirqs last  enabled at (313): [<94ebb6cb>] console_trylock_spinning+0x6b/0x10a
[  109.553485][  T781] hardirqs last disabled at (318): [<94ebb691>] console_trylock_spinning+0x31/0x10a
[  109.553486][  T781] softirqs last  enabled at (0): [<94e613c4>] copy_process+0x945/0x1a7d
[  109.553489][  T781] softirqs last disabled at (0): [<00000000>] 0x0
[  109.553491][  T781] ---[ end trace 0000000000000000 ]---
[  109.553494][  T781] ------------[ cut here ]------------
[  109.553496][  T781] rcutorture_one_extend_check after change: Current 0x60  To add 0x60  To remove 0x4  preempt_count() 0x2
[  109.553510][  T781] WARNING: CPU: 1 PID: 781 at kernel/rcu/rcutorture.c:1902 rcutorture_one_extend_check+0x20d/0x267 [rcutorture]
[  109.553517][  T781] Modules linked in: rcutorture(+) torture
[  109.553520][  T781] CPU: 1 UID: 0 PID: 781 Comm: rcu_torture_rea Tainted: G        W       T  6.14.0-rc1-00007-gc9b55f9da0d2 #1
[  109.553523][  T781] Tainted: [W]=WARN, [T]=RANDSTRUCT
[  109.553524][  T781] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  109.553525][  T781] EIP: rcutorture_one_extend_check+0x20d/0x267 [rcutorture]
[  109.553530][  T781] Code: 3d fe 04 1c f1 00 75 27 25 ff ff ff 7f c6 05 fe 04 1c f1 01 50 ff 75 08 57 53 56 68 60 9f 1c f1 68 a4 74 1c f1 e8 da d3 ca a3 <0f> 0b 83 c4 1c a1 40 09 1c f1 8b 40 1c 85 c0 74 41 f6 c3 60 75 3c
[  109.553532][  T781] EAX: 00000067 EBX: 00000060 ECX: 00000027 EDX: e89c1a00
[  109.553533][  T781] ESI: f11c936d EDI: 00000060 EBP: 825d1d88 ESP: 825d1d54
[  109.553535][  T781] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010282
[  109.553537][  T781] CR0: 80050033 CR2: 77235000 CR3: 010c5000 CR4: 00040690
[  109.553539][  T781] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  109.553540][  T781] DR6: fffe0ff0 DR7: 00000400
[  109.553541][  T781] Call Trace:
[  109.553543][  T781]  ? show_regs+0x4c/0x52
[  109.553545][  T781]  ? rcutorture_one_extend_check+0x20d/0x267 [rcutorture]
[  109.553551][  T781]  ? __warn+0x9e/0x15f
[  109.553555][  T781]  ? report_bug+0xe8/0x14a
[  109.553558][  T781]  ? rcutorture_one_extend_check+0x20d/0x267 [rcutorture]
[  109.553565][  T781]  ? exc_overflow+0x37/0x37
[  109.553567][  T781]  ? handle_bug+0x3a/0x55
[  109.553569][  T781]  ? exc_invalid_op+0x1a/0x56
[  109.553572][  T781]  ? handle_exception+0x148/0x148
[  109.553575][  T781]  ? osq_wait_next+0x18/0x41
[  109.553578][  T781]  ? exc_overflow+0x37/0x37
[  109.553580][  T781]  ? rcutorture_one_extend_check+0x20d/0x267 [rcutorture]
[  109.553587][  T781]  ? exc_overflow+0x37/0x37
[  109.553589][  T781]  ? rcutorture_one_extend_check+0x20d/0x267 [rcutorture]
[  109.553599][  T781]  rcutorture_one_extend+0x3b7/0x3c1 [rcutorture]
[  109.553610][  T781]  rcu_torture_one_read+0x21b/0x4d2 [rcutorture]
[  109.553638][  T781]  rcu_torture_reader+0xc4/0xdbd [rcutorture]
[  109.553646][  T781]  ? rcu_torture_one_read+0x4d2/0x4d2 [rcutorture]
[  109.553655][  T781]  kthread+0x169/0x16e
[  109.553658][  T781]  ? rcu_torture_read_exit_child+0x3a/0x3a [rcutorture]
[  109.553664][  T781]  ? kthread_is_per_cpu+0x17/0x17
[  109.553667][  T781]  ret_from_fork+0x19/0x2c
[  109.553669][  T781]  ? kthread_is_per_cpu+0x17/0x17
[  109.553671][  T781]  ret_from_fork_asm+0x12/0x20
[  109.553673][  T781]  entry_INT80_32+0x108/0x108
[  109.553679][  T781] irq event stamp: 607
[  109.553680][  T781] hardirqs last  enabled at (613): [<94ebb6cb>] console_trylock_spinning+0x6b/0x10a
[  109.553682][  T781] hardirqs last disabled at (618): [<94ebb691>] console_trylock_spinning+0x31/0x10a
[  109.553684][  T781] softirqs last  enabled at (0): [<94e613c4>] copy_process+0x945/0x1a7d
[  109.553686][  T781] softirqs last disabled at (0): [<00000000>] 0x0
[  109.553688][  T781] ---[ end trace 0000000000000000 ]---
[  109.634034][  T769] rcu-torture: Creating torture_shuffle task
[  109.635952][  T782] rcu-torture: rcu_torture_stats task started
[  109.637994][  T769] rcu-torture: Creating torture_stutter task

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

