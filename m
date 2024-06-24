Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB386EB55
	for <rcu@vger.kernel.org>; Mon, 24 Jun 2024 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218657; cv=fail; b=pITUTXaaIvDKk7Y+2NmBM1TXvCYZo8yB6GUzxsmy9e+W3iyRl4Vl4kvOm0et/eK3jUOWy5fwIdsGwiKHS0C4Px2i3EP86YhufTioP7WuRVeAWN2AVoYv7iG5LJU40f26NqlCB4sXDthIpYKvGFt/um3QlCiV0cMV4Q3XA6Quk64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218657; c=relaxed/simple;
	bh=zLWazYO26zT2CXetlNYgVYDxlbjjjBdQnBDsVhfZ3OQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qNeWpRXGa1ztm2LDdh1oJRhvBg76+mVNCc6c2FqlGB0knjOOd42otTDyKrsQvhX73gxfS3Mz6aC0C+adbG+vKoSk//Qsq2DZIOgVBvOr7G3YDUZvnWadpd7UI94QjIXynLx54zsspe0wckU6Oep0Vl0MGZ+xc9dydxVcomvcy1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgCNA44Q; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgCNA44Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719218655; x=1750754655;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zLWazYO26zT2CXetlNYgVYDxlbjjjBdQnBDsVhfZ3OQ=;
  b=fgCNA44Qvq57Y0CzJUVjxKaUCcNd04l0JrEP46OfzSIVS8CeV/dlszcO
   yChLgIltfgdvE31WAg0/vo/+xC22m2eOrdBaw4kIAkkK//T+Z68QGTYNA
   cYPRvKBXYAFWedoKyM9KGeWt8Q/VjymZl2RT4AeqsI/xk4K3R3LZDN7Ys
   QidV5hs3VvR12N2c/ZD8KglFv8KTM+gGcNf7HseBqQroP5t9miFbCGf0C
   uXsf78ys4VpDS0wVC8ofz3WbdWXIVPYrBR/SrSKKsUm2ct6xkIZaXLgDM
   8U69qyjYmo0GTFXfx4cz1QHiCD0UnM/P+5Bv0FOSo/rYYBp7qXM2VEGrh
   Q==;
X-CSE-ConnectionGUID: NXO5kPinSp20H2Q8gY8LkQ==
X-CSE-MsgGUID: +9bmjLT4SS+F+ax54RWl7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="20062143"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="20062143"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 01:44:15 -0700
X-CSE-ConnectionGUID: 3Sd073HkRmyLVshnEpylIA==
X-CSE-MsgGUID: xBQUU7jUQQCbTIiUoueHcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="47679734"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 01:44:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 01:44:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 01:44:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 01:44:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 01:44:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bto7do64zNnnVyAzbBDzlHoq0iafInYbtbC0Ttret0P7y5AUSXQFRQt03BWfeEyaJy4cCv9IJVLm11fCMdrKDatFh1sdD3V3e/xA9W3vorK7Z1XXNYxK6RC5KjREpZ+ZOFMrC28Ida8nWJA6kWxMIbhOLwN09p7rIOduzukZGkio2VdMEdDL4T4Ux8trcJm42gPls/Ktx1OU5s4FJOz6Osm56E4jRBGdF5LwlIfn3kTh1fHilDMcSuTkMntojA8o5hZwrq3khSYkziHB+FKu45p84hRAz7b7Q3wn6K9xJS66jYxsBC4oPg8l//CjDDpTDgc+AW4ioPyoyb90ENDFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzgXuHti9bEAnV5A3UcnZOz/knaezzafajZFs7SeGe4=;
 b=Uk8CyHHaqAYYxOwVMh7Uc+rTph4xBQuRXq0uq05BRtSI0xyo4ZkIUt5NdjW6XheMOkMIIEcu3wLRogebbCbolPOaa+kVEZG1S13uiS7p+rVi5bparvrNU//JI0C70eOkcgK8qsMFzNdM+yf0PPpa0ypich+1MfBijl9m6EdJtbOlLuKlMaOkx/1qYCyK1a7xVVS3cvL0fLYkNo21zZ9mwq2df6o3KPntvptmwrtasxPukZ2SQeslx4CToTIZ49C22h8LsazBMVLEwtc8kfsu2JrJgoRoFm6DaGZmgMXBmYYY6X1GbEXI+co6bZZJnshxnb+G9GH7/LP1J+tumYHL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8561.namprd11.prod.outlook.com (2603:10b6:610:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 08:44:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 08:44:11 +0000
Date: Mon, 24 Jun 2024 16:44:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Ankur Arora <ankur.a.arora@oracle.com>, Peter Zijlstra
	<peterz@infradead.org>, <rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [rcutorture]  7a1fcbb52e:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
Message-ID: <202406241652.e44865a0-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d32a4c2-c4d9-4b24-d530-08dc9429d178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SVzeFqbC8E4u4HY78WosEZ+13fDKcEK4t6Xffwd95Rj8aIsUAZM2MjufNd9v?=
 =?us-ascii?Q?uGRU7ZIYX+daOgXirST6cp6TcqyetYj++QBzKUSG3eL7r32UUHkhGnsV/UhB?=
 =?us-ascii?Q?ZwBSQmtC1NP+lHBKS8nLgdSaRZ2KIdQ4qVHThKm8jZLCA84kXdaDDJ9Smxma?=
 =?us-ascii?Q?5IUKNa0JUYrQi6iL0CbSkvWy2DzEb50DD/0iwCuqUO+oMbcfgX8dGB5dxGt6?=
 =?us-ascii?Q?2+OF3+CX/PF7TiJd1hcAn/uXjw5Qg1B/LZrPJsdETmbN0oNoVGUTKUtcJeGM?=
 =?us-ascii?Q?cfHOb2eJqK+kYLFfAE8qFS0ifR+5hL2upM/z04gU3dZeq2EFWvhZakKxHRcW?=
 =?us-ascii?Q?pCGEDbnIyiUjV+TundKfAlZr+uPFoRnC2B9/uIHq48/QOoUAfeivw7khlPYp?=
 =?us-ascii?Q?2+pZnDwcU+9iMJEUU+j55IajUH6y448NZWCYwFbVvSrn4+CVOgwt01QibIst?=
 =?us-ascii?Q?V6h0YihoCC0V39KA2GDV5cJ8auz80Qlk6SgyqATv33cSQ6hTHAhrr25Ce4Wj?=
 =?us-ascii?Q?lldDiXPjf8/7d2okQ9hMC14UPHTKGap2IQrCdmAOQInM/PMezkKYsypQVCPT?=
 =?us-ascii?Q?qbPCJO+lLidXmzgvUegKXcv7WbUf6zc+4jUAAsw8NrlEEVp0hrNt1GBMeIb2?=
 =?us-ascii?Q?MgVOvVWEvzDS14XAqvwIWYG4EVacwfBRJTIQ67J7PzZ1EvR4pRwFlFyRkeWZ?=
 =?us-ascii?Q?aCrZnLMYhk1x46zSN8w/V8wBb1tEbUbgGfhp5+kt6H8t0VwGvKZ01GzC3Re8?=
 =?us-ascii?Q?Q85fhbHlUhls9UBF+GuQP1AxBGiNRAf5iNMjjA8uvDPnQy9gaBJPcWt7u2YR?=
 =?us-ascii?Q?jZ7c63tIbRI3Wa2m/w1/BhKvLsPTANcz9vAswN4oAJvexw9xBp8QMhPV/8WL?=
 =?us-ascii?Q?IGnNAf/A4wswJb2pYHwcghaim5irvyWxDLQF0u9uc9jf3X26gneAdyQsTIfM?=
 =?us-ascii?Q?wWrCKS8T18k2RTlM4L4vAlgGUXqLOLtiEk5FtNWlKmHkeYxbojHZ8+Io9Bvf?=
 =?us-ascii?Q?pZNUH1j1I/YrN/19npfsWnS7tRpy2i+fc/W2JW0s0AFPeOQ8DVqeqgKsIpQh?=
 =?us-ascii?Q?QamH9d9k9JQ2ppY0C6Yc9EuClH8y8zgDdx/+yzu4JLmObvCT6OwXZKmusXXV?=
 =?us-ascii?Q?Yq+4Aubrsnsx4vPl0rAlML3oDU9Ip1cB0AfIPJv62LinX9aFRxQuUMOnIiv5?=
 =?us-ascii?Q?K+NOlmw41o6tgHXT6oPl0VadkVHscKJthROiwElwqlA1BAnrkkzs4HOAdW/T?=
 =?us-ascii?Q?vCY58ixW39d8Z5SpO3JA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5C1IkcVbgrkBjV/2vP3r7RWDlnjQ9OrM+hkd8g3g8MLZYwMPQj4aD/mKvAVD?=
 =?us-ascii?Q?03dSce1/nD8SJ+T0jA2grkwXSllJyhJ9pQicdvX4Ru7CaMFPhvA5D5pILkY3?=
 =?us-ascii?Q?ZuE9m+1jZkHfcJgtpE5l6CErlcL0qJkoggk5oyYHaXicQBJRl0cFt5pAEIw3?=
 =?us-ascii?Q?8crEaL12ivqiZlds4tpgTI5zTcZLxbMciwuh0tb3c4CfTcgC/IbHalwFVBFq?=
 =?us-ascii?Q?7Q8mRYQtYJM+Iab3lfutu+KmhZLF72ib6zPp6ZvKS2z9Tti5Qx2flDjt4A6e?=
 =?us-ascii?Q?pLTB/qvS+uOCEq1fSmGWJo5fvHm/q2TGrPaPqO8f07wbbKi8Ks6AcqXBtC0W?=
 =?us-ascii?Q?BgOIw4ye9LSQKoBox7v4/86fNKMy7uk0r7FcGWFww6eyHQ5Xpsm+IyoJGOap?=
 =?us-ascii?Q?xz4dzbIcq/SiidMC1EW99g3+l94FZCfkU5zO58BhRCdMxTxa21udEDYT+53R?=
 =?us-ascii?Q?2vphNJIVPSiZOTBNPilbVgl7MXLWwhvZv8YvFrFtm3+MPmU6oHTGE7BymiTL?=
 =?us-ascii?Q?sjRcHELKcAC/IBYU8B+ekP4r37xKls19whfczOMCPgotrp5t/JyNY56JYKMg?=
 =?us-ascii?Q?K2gQkwzErENjxCE88OIxKuxr4O5tkfd5L/fm57qvXkLoXT3v6/CoWN0WHQ2b?=
 =?us-ascii?Q?yaKjaKGN2jMvHowW5Sn5LW4lTAMrrB7vdl5bmZBaL84G9XamXyQayZ/4WLx1?=
 =?us-ascii?Q?jLG1KyNJ/4/oFXLoJ1Fp8qDqUk/W6pmAJwWEydgqOD9uO0idPGbb/7Wn4sKk?=
 =?us-ascii?Q?jHy46LI1YFKXhlecFg0H4pQ+u3Pa1dPG+/UIA3P596Sg/D8zLBZabzvxvX90?=
 =?us-ascii?Q?v9mUBZfUnzZGdWLzOUHjqqxel9XoRog9zrBfTt2x0qkGAmB6aXhikmfuUmh5?=
 =?us-ascii?Q?i84seJb9fGJbL4BXURTAUHPjiIpZI+tEj4lqPvri+Ub45QIG/JL3kGaikNlO?=
 =?us-ascii?Q?ly5ISwY3cQ9bTtPHdxAfFlFYmQI5K150eLmR2Krt9G/eTwHQDw1EladSrWqf?=
 =?us-ascii?Q?pKhQn/qgOwdphLlZeVgYDeIfdPaCUMmYRvQiY/qYw2DP90dsqaBwfyWncHm3?=
 =?us-ascii?Q?yYa6MEPQ/z8jvsppDT/3E2JQEBzozgIsffYt85lmbLXtkdZszk4M8D0xo9cI?=
 =?us-ascii?Q?QOwMf9xt7P7HHVoPe9DiRE9/VslDVdDcY5I3ORV2ZttLB65kNBWdhau+/KTV?=
 =?us-ascii?Q?DGHaJFH7K1cx1g6bWjJ4Qst5gTiELOTnpA3rQZ4ln8vrOKuuJboBVtI/QtSu?=
 =?us-ascii?Q?9BT8ZRiM16pQmJ7Q6Lm1PS7FquC4eWF03DgxeYU7d9o4WDiB2JKXJo8WACnX?=
 =?us-ascii?Q?ZeqTg7yu8QKOJgBSWc7GTBSQVcIIcOgOC4BBXxC1vmlDc26JWUNEqbh8VCDO?=
 =?us-ascii?Q?s1v/HQtvsq8TivBRMdwX2qDfB0QDoXTYycAO/B9ynvq5QwWvkOuV0vsr1j2C?=
 =?us-ascii?Q?0PSvQfToeF0apNHZr4yEPKXV8v1MrzsXvwEX8Jl05tvmJMKMdhPLnMXMVupG?=
 =?us-ascii?Q?0LDHb/pm07bJk4RYkuF8b3bXJjzMYthToXASDrDapa8+YW2uSiSfAA7a502V?=
 =?us-ascii?Q?rryb5fgVPGHDBw1cwZR+foO88adEbrJ64hoG9hIka69W+9C98WJWfT5Gfpeq?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d32a4c2-c4d9-4b24-d530-08dc9429d178
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:44:11.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8m9bE+KfLnkZ1IoEBqO+MmJZS3KLi9dNri7y/5KnVZytCv/HeWAAhqsesILta09TXn1Avgfnbz4bjj3rgUNMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8561
X-OriginatorOrg: intel.com



Hello,

the config for this test is a randconfig. by this commit, the config has below
diff between parent and this commit.

--- /pkg/linux/i386-randconfig-r022-20221003/gcc-13/d65635ebba92ee02e8284acfabbaf6b59ec0b5b6/.config    2024-06-23 23:24:45.203220229 +0800
+++ /pkg/linux/i386-randconfig-r022-20221003/gcc-13/7a1fcbb52e611c49331bd66dd2da1efa4c0afef7/.config    2024-06-23 23:59:34.976722738 +0800
@@ -133,7 +133,7 @@ CONFIG_IRQ_TIME_ACCOUNTING=y
 CONFIG_TREE_RCU=y
 CONFIG_PREEMPT_RCU=y
 CONFIG_RCU_EXPERT=y
-CONFIG_TREE_SRCU=y
+CONFIG_TINY_SRCU=y
 CONFIG_TASKS_RCU_GENERIC=y
 CONFIG_FORCE_TASKS_RCU=y
 CONFIG_NEED_TASKS_RCU=y


we don't have enough knowledge how this diff impacts rcutorture test results,
just FYI what we observed in our tests.


kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]" on:

commit: 7a1fcbb52e611c49331bd66dd2da1efa4c0afef7 ("rcutorture: Add SRCU-V scenario for preemptible Tiny SRCU")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master f76698bd9a8ca01d3581236082d786e9a6b72bb7]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: busted_srcud



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------+------------+------------+
|                                                                         | d65635ebba | 7a1fcbb52e |
+-------------------------------------------------------------------------+------------+------------+
| WARNING:suspicious_RCU_usage                                            | 6          | 6          |
| kernel/rcu/rcutorture.c:#suspicious_rcu_dereference_check()usage        | 6          | 6          |
| WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture] | 0          | 6          |
| EIP:rcu_torture_stats_print                                             | 0          | 6          |
+-------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406241652.e44865a0-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240624/202406241652.e44865a0-lkp@intel.com


[   96.952168][  T436] busted_srcud-torture: !!! 
[   96.952253][  T436] ------------[ cut here ]------------
[   96.954867][  T436] WARNING: CPU: 0 PID: 436 at kernel/rcu/rcutorture.c:2268 rcu_torture_stats_print+0x253/0x496 [rcutorture]
[   96.956537][  T436] Modules linked in: rcutorture torture ppdev i6300esb rapl ipmi_devintf parport_pc bochs drm_vram_helper parport drm_ttm_helper ttm drm_kms_helper i2c_piix4 tiny_power_button ata_generic button fuse drm drm_panel_orientation_quirks i2c_core configfs
[   96.959483][  T436] CPU: 0 PID: 436 Comm: rcu_torture_sta Not tainted 6.10.0-rc1-00067-g7a1fcbb52e61 #1
[   96.960380][  T436] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   96.961355][  T436] EIP: rcu_torture_stats_print+0x253/0x496 [rcutorture]
[   96.962139][  T436] Code: 85 c0 74 02 0f 0b 83 3d e4 17 59 ef 00 74 02 0f 0b 83 3d e0 17 59 ef 00 74 02 0f 0b 83 3d dc 17 59 ef 00 74 02 0f 0b 4b 7e 02 <0f> 0b 68 31 76 59 ef 31 db e8 40 11 54 de 5f 83 fb 0b 72 0c 89 da
[   96.963988][  T436] EAX: 00000000 EBX: 00000003 ECX: ef597627 EDX: ef59762c
[   96.964651][  T436] ESI: ef591994 EDI: 0000453c EBP: c6567f6c ESP: c6567eec
[   96.965187][  T436] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010206
[   96.965660][  T436] CR0: 80050033 CR2: b6b5f000 CR3: 04f71000 CR4: 00040690
[   96.966172][  T436] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   96.966624][  T436] DR6: fffe0ff0 DR7: 00000400
[   96.966924][  T436] Call Trace:
[   96.967138][  T436]  ? show_regs+0x45/0x4b
[   96.967415][  T436]  ? rcu_torture_stats_print+0x253/0x496 [rcutorture]
[   96.967849][  T436]  ? __warn+0x7c/0x113
[   96.968117][  T436]  ? report_bug+0xb3/0x111
[   96.968406][  T436]  ? rcu_torture_stats_print+0x253/0x496 [rcutorture]
[   96.968880][  T436]  ? exc_overflow+0x37/0x37
[   96.969174][  T436]  ? handle_bug+0x2b/0x47
[   96.969452][  T436]  ? exc_invalid_op+0x17/0x53
[   96.969755][  T436]  ? handle_exception+0x100/0x100
[   96.970141][  T436]  ? exc_overflow+0x37/0x37
[   96.970434][  T436]  ? rcu_torture_stats_print+0x253/0x496 [rcutorture]
[   96.970871][  T436]  ? exc_overflow+0x37/0x37
[   96.971162][  T436]  ? rcu_torture_stats_print+0x253/0x496 [rcutorture]
[   96.971599][  T436]  ? __timer_delete_sync+0x82/0x92
[   96.971938][  T436]  rcu_torture_stats+0x3d/0x5e [rcutorture]
[   96.972322][  T436]  kthread+0xdc/0xe1
[   96.972575][  T436]  ? rcu_torture_stats_print+0x496/0x496 [rcutorture]
[   96.973010][  T436]  ? kthread_park+0x62/0x62
[   96.973302][  T436]  ret_from_fork+0x1c/0x2f
[   96.973589][  T436]  ? kthread_park+0x62/0x62
[   96.973879][  T436]  ret_from_fork_asm+0x12/0x18
[   96.974230][  T436]  entry_INT80_32+0xef/0xef
[   96.974519][  T436] irq event stamp: 535
[   96.974777][  T436] hardirqs last  enabled at (543): [<cda8b4e9>] console_unlock+0x80/0xd4
[   96.975183][  T436] hardirqs last disabled at (550): [<cda8b4cc>] console_unlock+0x63/0xd4
[   96.975588][  T436] softirqs last  enabled at (104): [<cda4d6de>] handle_softirqs+0x2cf/0x2f9
[   96.976007][  T436] softirqs last disabled at (97): [<ce313fce>] __do_softirq+0xa/0xc
[   96.976392][  T436] ---[ end trace 0000000000000000 ]---
[   96.999461][  T436] Reader Pipe:  1738294 6779 1992 57 1 0 0 0 0 0 0
[   96.999803][  T436] busted_srcud-torture: Reader Batch:  1747123 0 0 0 0 0 0 0 0 0 0



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

