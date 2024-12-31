Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD0BA50
	for <rcu@vger.kernel.org>; Tue, 31 Dec 2024 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735621408; cv=fail; b=ef9FxYLCafonLAL4hRPQXfcLFXGLWHgSFpdZrfqWmHfsw9Jtld2WSDaSXYi0YE9OB/x7XBqDrcPaL/IB+uzYX/uFRajvETDeDGJITmWprhwEyVhCPoB0A6BSNBWgigp+4BCNT50u8LZfLubUZA24zivdttC6ZFJARk2YN6Apzwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735621408; c=relaxed/simple;
	bh=QD9nZ4dVe18T0DYQ4AuDLwnCW7Gizk3zMLUFFBYrR3Q=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LtWKzH3swKJ7srW3NjjKKCYZ4r4crOjoOOEMWe52nVNO3/pqN0NX0O00HZT0m66bwH6y4sCpRklje7Vl4kqZ0rwWRZxbT+Mv9DXpNAB8SIa51sSAPmjdIrO424wGjdHisTmSYTtdY4nyCHwt0gAlnTGDEjXkpt2jQOS1LRVyAOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hk6h7ZHe; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hk6h7ZHe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735621407; x=1767157407;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QD9nZ4dVe18T0DYQ4AuDLwnCW7Gizk3zMLUFFBYrR3Q=;
  b=Hk6h7ZHeEl0qjY1TddVmUrNQOOJSBSM7fYWeXFKUJ0OAlX48s1/W/cS5
   KKme3KKgZuYTT+4IjKRTgeAyuaS/YmvT9VhyN465guo4E6GolpH5aHr3M
   w+iGRmxkNZa+eZNgi/3ih5zDh0OrSf64XRyPIyCWxDp3AHqBOgzt/1oV2
   jLc+cG+4a1OfGl1K2uhZ2Dctq+cSneWmko2v6TFz0wepxtptjzVn5oeY1
   vmoM8cXdyndQC7aJkthB7T5bfhUy/PI60SNZZdMSgkWT6tIqovoZxAOIN
   WugUv39AUZkhx9WdoPFmc0bIIJ/7mCIg6Mr75KyEQILMGqPJgRsmo0iMu
   g==;
X-CSE-ConnectionGUID: qVhxidWXStiMleHvAe2paA==
X-CSE-MsgGUID: TbIsFl06SaKuHFctcUub3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11301"; a="36043957"
X-IronPort-AV: E=Sophos;i="6.12,278,1728975600"; 
   d="scan'208";a="36043957"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 21:03:27 -0800
X-CSE-ConnectionGUID: FjcjJkDmSFiEH2qVc40C4g==
X-CSE-MsgGUID: Y8ZPLahISjmZWZMx6FF8ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105581213"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Dec 2024 21:03:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 30 Dec 2024 21:03:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 30 Dec 2024 21:03:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 30 Dec 2024 21:03:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmGwPoXeNK60OMVES+tdu7GIhNLw4agYnwL8hnNiNnIp/EaGHWjiZdgO8OTUEKCbaN6HgbQ9lvFrPWaYNqfsM+abxte0WnDLbQ3kg7vVdGTqCbWoJlFmVHDszcOJ0kDQZKpgvwRBCNWvM2tUKg/QJTJp3fOfgAw4yX1IxNz+9K87wvUsaxf+X8YsODiFC2Ym309skw5jbeI8oyqbd8ifPzq028WXWEeXBeXbL5Gao96uQtQjpXjaMKiY13R4kNxL5SF98d+m7jLqnB10+lKCyubfL7sa4zd4di/zXee3qZ/gGTKJ2lfg3FVSPE2XQg+tdPRoKSZWplA579kNYWhFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvCAprhrX8J/fAgJRBpQe5sSdIo3U7BqJkECFruPSLU=;
 b=UaYADweVP18k6rGFfjvHBNInIYFWauNgewyct1CFQ5dwjkwgoEhLWZs5TNLEodkZE9FlMn6bC5zYnDE16ADh8WruexjAITAPjFLEyVbPSqYf2mqpqZijynU811xphg9q87JkCN1CYns6upnUm14jV4J1ZwfGl3o3Lh9S24zC0TcosJ+HJSiVS5hZNQ43GMc8pgIWXJsLY/BJjao1A/2Vgd1j1BjNoZjhOthr/ddUk1xwHeYUpAhash3zlJ4igQ+Mj9JiBUY3tXWvtDbd3Cm3bqxaUlgca9o8zGEDzxiA94HAQvd/ygMcGPYkNr3OhInJFN+jwkCg/S8JqoIupVctxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5124.namprd11.prod.outlook.com (2603:10b6:303:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Tue, 31 Dec
 2024 05:02:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Tue, 31 Dec 2024
 05:02:50 +0000
Date: Tue, 31 Dec 2024 13:02:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <rcu@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2024.12.24a] [srcu]  9216c28c6a:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <202412311203.ca7bddba-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a82767-b767-48df-1f5f-08dd29586039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oby/sTFC06dhcQBUKpwtAcKeP0U9TlvGGPwdyftaBR3JnVTlmcfBMKeyDK7B?=
 =?us-ascii?Q?i4bDPVniadbMwRrmGxoLDkiJtL0ZuXayWtYbbtpGALb1g0e487OEpCPOBhqC?=
 =?us-ascii?Q?8YP3dqQqRbQCazR3yBSc4bUL9NK05fx2ylKHZoRGfKvYT2SqZwqOGw2hYm+8?=
 =?us-ascii?Q?rphqHQ9BTjcf3FcD3pPOblkkRj+bq2yH64Yp0JgO0ImHTMLr4dE+Tixqzmhr?=
 =?us-ascii?Q?y8YTD0rtyYdvJQota+kPs8S/69Ooi3iQH5kr6765VKorPHhoMI/G/NZdmGlC?=
 =?us-ascii?Q?dM4vYmUO+eaKJmKr77a6MqB84mEu9nC2LoLy9hq2mTz8hsNPTDVzkAT5U4bQ?=
 =?us-ascii?Q?r7NCgxtYgMeKD2qyl2uvOWDQaqKrlTu8BjNV6dX+DlU3i8FwimxqQeCN9pCe?=
 =?us-ascii?Q?281BLs2nx3y8aXemL8p/FFQyrlis3QbkFGJWSMPvTPbABg0sKECA4ZyENr3x?=
 =?us-ascii?Q?Kn7/axqRw9MRTMYcWIxduTQlyEfjA8ynahjyhU5m56d9XAzXlw5LkQR4wY+2?=
 =?us-ascii?Q?XbrxQe1OyRfFLg/Hkc6rH/HTUmIeDkG1s+ngFnw2JBRVGQeQnknjXrlXLM0E?=
 =?us-ascii?Q?pT1REezjdwcy9l6zZgLkgwfL2U+piyEpYygXTP6BBC8hC8wyoD4Ir0VclUTd?=
 =?us-ascii?Q?3rDqOG4mHDvGFWnWL3u9JEbF/Aw9rUP8p68fz9IACbVAVvzQjIyAHUgnv0Id?=
 =?us-ascii?Q?2XB8DMzhGSx9RESQmJ1TXBCiXXZBDhBDwmBqHIbTJ70usM10mEwzS9a56HUw?=
 =?us-ascii?Q?2ky96irtLbH8RvmYAOiSBq34E72peY1+jSv8DhuiBaCcsioXyU0E3KpTRMLE?=
 =?us-ascii?Q?EBArZQxcNzotrgAuEGlbvAkR/jZ1cA4LMM2h1EInd+ggk3TIjlQt7FYEps/3?=
 =?us-ascii?Q?fcSnwj2hqUT4C6EChv+nQjm0DxcQWScNupwWc5N/th/i4bsLbsWXJkhHGzU/?=
 =?us-ascii?Q?oqc1pnHIxPGlgizZcYKa3icbB+DnrU30mrXdzkQUSHnjhu/BvB576hgUhpTX?=
 =?us-ascii?Q?/BPzvPRoeKIYWL4xDgSwDDBw9xNCF/LsabRETT2w20jMDrmQ2nVvvvdpdeSl?=
 =?us-ascii?Q?0clbYIBIDX35TFPiv0Xivl2xG78d0loaa1OSPxa4Gwk/m5jbwAsjI5hPOQht?=
 =?us-ascii?Q?0gZSZA6RVaM4RxeTArPfGjxbmMiQXegkrx+TlbfBjEVapL9a7bSC7UNqarJg?=
 =?us-ascii?Q?zOsWR8HcuYmDMpmwYU8Nr4ua13su+jQ4BpZkTcA8zSz7ZEmM6Mh6y64BQjm6?=
 =?us-ascii?Q?dd6MjF4iRVzkpRurlnApngU3p80ebhD8D52pvZJGtRc2QAio7dal1BHCrBe8?=
 =?us-ascii?Q?lIJEbznDVqfKMcGc9Z/vJCMdEevtSqoCr4QV6bZKzRblHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RoFOUjN4mtVM/fwhGC7S6yx70kiC53QD31+z/uRnUnLILU+s734vuWoK5zbW?=
 =?us-ascii?Q?0V0VitaHmdwfeb+9zpLynoQKwxQvAGJcseYzKO4ICxSfDSsD1p8Mwj5Xp/eZ?=
 =?us-ascii?Q?i1URbXTJvreKPwJgBMgFbFRlwq2bJGirn8vt+D8vn8BCVU7whzgIgAGyh4lz?=
 =?us-ascii?Q?GZgM3gxluODxBL9tg/5OIkUN4RBfvLBHylbUIYHM2hQhavF0ON2ea32n6Xpa?=
 =?us-ascii?Q?d2oPZMGk1p1lHAYtjs+DxDtkvasJnTgpxpdyyxbFRTFnPjHcpQG7FFNENiNc?=
 =?us-ascii?Q?JY7ZyxfYFyt3082tsScnulhRhzjeQwngAEGDts6dNDVRMVRaVOM+1hLAyo2b?=
 =?us-ascii?Q?C6ayjTeDfhcEToSxq4+AxrKBF7vzPhCDKaXFxZfuSVRUiVoEhYmh8eoQXlF2?=
 =?us-ascii?Q?nUPrHSqwcsKM11CJRYAi40HVzxfFcagVl8iAn4ZOeZgkqrPQ9QCdw9LMfv3t?=
 =?us-ascii?Q?uk0qyk3kLX/UK0qr88n491AJww/yxqiZ1DT2PoqDitdnWS/uXu38tAfnjx7H?=
 =?us-ascii?Q?3/ilYfvop2U+DKuTTLDmW/EjqQhwxhCUrXVJrKxTxLSMS2Py0GRS6A7unf1g?=
 =?us-ascii?Q?+mOPaxwA6QL6hUlXPrAXyWQ4T6tc5pXyoLyaA9F+TxlO8icEA34wqlKERR+e?=
 =?us-ascii?Q?IpJw8YwniEKELzvHA8bwOu9cvQDDitz3wS1lvwM46NodyExsJS3yo2NlSa+j?=
 =?us-ascii?Q?DhxWEXmryVLyd12oFVNOXDA2oW3Tx/s+c7JUYxmO7lMjMR7pgfplOhSG11x2?=
 =?us-ascii?Q?ZD892Gkyx8dto4jelttqMXzbRxAJSM2o+aCBSHxx6l+wQAgJaqBD338EinQ+?=
 =?us-ascii?Q?ndkQ7ErB32NfpoqqPEHWeoKopNLYSzRU2IyJR7r3ae5kNV8D5ASfjizMNo8O?=
 =?us-ascii?Q?X5vakc0hR2JBydxmR/uAWUKc+bJLykuEx7RSokf+vuRaWJb/wpU+NdWzY6YN?=
 =?us-ascii?Q?Oi4VnMc5iWZ639P/HIcLkwq8SP4GJS3AjgCMyIqwZOo5bpnKI+Mv/Ew4ZKSb?=
 =?us-ascii?Q?qcne55HujKDFGZw5IHwg/9UsnqlFG4KWhzMFIwSthn6E3JUsO6wwixYTRF46?=
 =?us-ascii?Q?vbmS/bMcYBLOr3ctNXOKK/p/Ws//ApY7rjXj0lvWLEMnCAnSQ5PEdmesRMop?=
 =?us-ascii?Q?S59HlrvfvrEORxg5OguAZfT+t1ao3zWfcrU8h8OHSgKbyHdP6L5E5xWh/s4m?=
 =?us-ascii?Q?xga8EPGmRQ6U2uCw9w9ZVmhvj+W9jlhsc6mhN9f6Q3UumWOf/XYRzyt3b0v/?=
 =?us-ascii?Q?v5T2eyZ90TDmxhnnWYa1lW+heqHwC6nROd4Z+QaFYf6YS13ryRikWIv8/ClF?=
 =?us-ascii?Q?flf9IJr+Z7NcFhqQQxb59d4yaUToI8TT33bWIfcoFg0QK0a6+Xs2YBO393bh?=
 =?us-ascii?Q?l8PKLNyXZW6CMImU0gN4k5RS4ykvmK99CPh6noVvTHYDEETVUhjO/6ENJjK4?=
 =?us-ascii?Q?rE9T/msQGMOo1jGIFR6qfUliJ2BZ3LcuwSdNW3jaMBw/gWHbs98hRKv1DjoK?=
 =?us-ascii?Q?6kEYuFJYbcmiiKJu4FN5MPb7qortFOs8srzDj5oPNktrYnwuAxoIQU1gEpI9?=
 =?us-ascii?Q?ARZ4aoYJS6XGOeTqvkq/HX78gv2cE7bsL4cxKoJ4pquM1D8ZMFlIlVNwYNC+?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a82767-b767-48df-1f5f-08dd29586039
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 05:02:50.6307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUaWaJrKIxLZyhz07a81JcBjrb4ooo/UlqeUOzLIXftGBrjBfKSmTx4MbyIQEve4Y0cW9oLuEpm/RmM0oaZv1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5124
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: 9216c28c6a927fd20f116feed55bba025f18f401 ("srcu: Make SRCU readers use ->srcu_ctrs for counter selection")
https://github.com/paulmckrcu/linux dev.2024.12.24a

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: srcu



config: i386-randconfig-005-20241230
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------+------------+------------+
|                                                | 2add2e88ea | 9216c28c6a |
+------------------------------------------------+------------+------------+
| BUG:unable_to_handle_page_fault_for_address    | 0          | 6          |
| Oops                                           | 0          | 6          |
| EIP:__srcu_read_lock                           | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception       | 0          | 6          |
+------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412311203.ca7bddba-lkp@intel.com


[  168.973150][  T628] BUG: unable to handle page fault for address: 2367a000
[  168.973700][  T628] #PF: supervisor write access in kernel mode
[  168.974809][  T628] #PF: error_code(0x0002) - not-present page
[  168.975761][  T628] *pde = 00000000
[  168.976236][  T628] Oops: Oops: 0002 [#1] PREEMPT SMP
[  168.977052][  T628] CPU: 0 UID: 0 PID: 628 Comm: rcu_torture_wri Tainted: G                T  6.13.0-rc2-00067-g9216c28c6a92 #1
[  168.978867][  T628] Tainted: [T]=RANDSTRUCT
[  168.979429][  T628] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 168.980862][ T628] EIP: __srcu_read_lock (kernel/rcu/srcutree.c:749)
[ 168.981213][ T628] Code: 85 ff 74 0c e8 45 59 00 00 83 3b 00 74 02 0f 0b 5b 5e 5f 5d c3 8b 00 f0 83 44 24 fc 00 83 c0 07 83 e0 fc c3 55 89 e5 8b 50 04 <64> ff 02 f0 83 44 24 fc 00 2b 50 08 5d 89 d0 c1 f8 03 c3 55 89 e5
All code
========
   0:	85 ff                	test   %edi,%edi
   2:	74 0c                	je     0x10
   4:	e8 45 59 00 00       	call   0x594e
   9:	83 3b 00             	cmpl   $0x0,(%rbx)
   c:	74 02                	je     0x10
   e:	0f 0b                	ud2
  10:	5b                   	pop    %rbx
  11:	5e                   	pop    %rsi
  12:	5f                   	pop    %rdi
  13:	5d                   	pop    %rbp
  14:	c3                   	ret
  15:	8b 00                	mov    (%rax),%eax
  17:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
  1d:	83 c0 07             	add    $0x7,%eax
  20:	83 e0 fc             	and    $0xfffffffc,%eax
  23:	c3                   	ret
  24:	55                   	push   %rbp
  25:	89 e5                	mov    %esp,%ebp
  27:	8b 50 04             	mov    0x4(%rax),%edx
  2a:*	64 ff 02             	incl   %fs:(%rdx)		<-- trapping instruction
  2d:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
  33:	2b 50 08             	sub    0x8(%rax),%edx
  36:	5d                   	pop    %rbp
  37:	89 d0                	mov    %edx,%eax
  39:	c1 f8 03             	sar    $0x3,%eax
  3c:	c3                   	ret
  3d:	55                   	push   %rbp
  3e:	89 e5                	mov    %esp,%ebp

Code starting with the faulting instruction
===========================================
   0:	64 ff 02             	incl   %fs:(%rdx)
   3:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
   9:	2b 50 08             	sub    0x8(%rax),%edx
   c:	5d                   	pop    %rbp
   d:	89 d0                	mov    %edx,%eax
   f:	c1 f8 03             	sar    $0x3,%eax
  12:	c3                   	ret
  13:	55                   	push   %rbp
  14:	89 e5                	mov    %esp,%ebp
[  168.982540][  T628] EAX: ef0c8420 EBX: ef0c8420 ECX: e5e1e840 EDX: 00000000
[  168.983022][  T628] ESI: ef0c919c EDI: 00000000 EBP: c75e9ee8 ESP: c75e9ee8
[  168.983503][  T628] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[  168.984024][  T628] CR0: 80050033 CR2: 2367a000 CR3: 075f5000 CR4: 00040690
[  168.984518][  T628] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  168.985008][  T628] DR6: fffe0ff0 DR7: 00000400
[  168.985329][  T628] Call Trace:
[ 168.985571][ T628] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465)
[ 168.985877][ T628] ? __die_body (arch/x86/kernel/dumpstack.c:421)
[ 168.986185][ T628] ? __die (arch/x86/kernel/dumpstack.c:435)
[ 168.986466][ T628] ? page_fault_oops (arch/x86/mm/fault.c:715)
[ 168.986811][ T628] ? kernelmode_fixup_or_oops+0x50/0x58
[ 168.987273][ T628] ? __bad_area_nosemaphore+0x37/0x1d5
[ 168.987726][ T628] ? validate_chain (kernel/locking/lockdep.c:3819 kernel/locking/lockdep.c:3872)
[ 168.988058][ T628] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835)
[ 168.988406][ T628] ? do_user_addr_fault (arch/x86/mm/fault.c:1280 (discriminator 1))
[ 168.988763][ T628] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
[ 168.989110][ T628] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
[ 168.989472][ T628] ? handle_exception (arch/x86/entry/entry_32.S:1048)
[ 168.989800][ T628] ? siphash_4u64 (lib/siphash.c:203)
[ 168.990123][ T628] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
[ 168.990539][ T628] ? __srcu_read_lock (kernel/rcu/srcutree.c:749)
[ 168.990858][ T628] ? rcu_torture_barrier_init (kernel/rcu/rcutorture.c:3381) rcutorture
[ 168.991319][ T628] ? siphash_4u64 (lib/siphash.c:203)
[ 168.991618][ T628] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
[ 168.992021][ T628] ? __srcu_read_lock (kernel/rcu/srcutree.c:749)
[ 168.992340][ T628] srcu_read_lock (include/linux/srcu.h:165 include/linux/srcu.h:257) rcutorture
[ 168.992735][ T628] srcu_torture_read_lock (kernel/rcu/rcutorture.c:693) rcutorture
[ 168.993184][ T628] rcu_torture_writer (kernel/rcu/rcutorture.c:1528) rcutorture
[ 168.993615][ T628] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
[ 168.994020][ T628] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80 (discriminator 13))
[ 168.994369][ T628] kthread (kernel/kthread.c:391)
[ 168.994647][ T628] ? rcu_torture_pipe_update (kernel/rcu/rcutorture.c:1447) rcutorture
[ 168.995108][ T628] ? list_del_init (include/linux/lockdep.h:248)
[ 168.995428][ T628] ret_from_fork (arch/x86/kernel/process.c:153)
[ 168.995735][ T628] ? list_del_init (include/linux/lockdep.h:248)
[ 168.996053][ T628] ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[ 168.996380][ T628] entry_INT80_32 (arch/x86/entry/entry_32.S:942)
[  168.996692][  T628] Modules linked in: rcutorture(+) torture intel_rapl_msr intel_rapl_common iosf_mbi crc32c_intel aesni_intel input_leds led_class fuse
[  168.997654][  T628] CR2: 000000002367a000
[  168.997945][  T628] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241231/202412311203.ca7bddba-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

