Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413E1581E0
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055625; cv=fail; b=s7i2vz7QrXuAtycZqphajXzfZykl1cvHjnpDquwwr/cEMsXnhWAFVRjV34ArMFyB+HbM66qbXCNbecqXHoKKC5spzn6RV3RnmITD6TzQNAhHwi8dtovmeMIAxdBqDtullq5/Mvzfwk+wBybFNYHD4yKWqqe3dqbgHqTcetHOl0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055625; c=relaxed/simple;
	bh=1q5YTIue1MdHbOBTMDTA55ZtdZ7qj0BzmDeRaAt15Pg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pLqc5O02IyzkfzpEQRcTmJ/N26V3eiOdHT5MDF5f1H8bkO5Q72zZvui+w3HD5tPcF/paVEE8ZfzpXQA6P2FCuFZvQtEP6/veWUGd7Bd9lcps1FhyMKCyDoD67f6kh7D4wax9k40XnZEv62WEeD3SzweTmUn05jaDI2gFufaAmdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3q+6qRO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3q+6qRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724055622; x=1755591622;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1q5YTIue1MdHbOBTMDTA55ZtdZ7qj0BzmDeRaAt15Pg=;
  b=K3q+6qROEPu72bI8XsEX4cNeibCmeBHk5z9KEcSlgts0bVTbW2CdF+vr
   eztblCrvwJoyg+AICMrzJrNBHlZnXh5p/gbrX3fBCuawZwNSAdJR/E3Nv
   z1G+trdRYqLdtPqQFzvmL+58BAJ/RNVCquZMSP0JlZCrrt/WDOtpI3r8J
   xNsMwUXNBgVmIH+FHy0f6o/hqpeOBnl5dJYEhKt5K1m7GxLSlamUiIC5p
   eq/HTNSHDeZ67EyId0KXElLH9w4gqZ+A1YTIyxzgsVQSR+IL4r3AlXcaq
   YMM+F4uNCnd9++vxEidU9xAbMchvqkglftS/dX1RlRDCfi8NhL/hgnx0Z
   g==;
X-CSE-ConnectionGUID: yT1VbQncQIaa8JKC7wngWA==
X-CSE-MsgGUID: Wm9YJ/FNT72ZC4CyRBsE+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="26082561"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="26082561"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:20:13 -0700
X-CSE-ConnectionGUID: QmCMUTWJSdiQkuMzEeEtHg==
X-CSE-MsgGUID: fLw4whAbSBmfhl7oaavJMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60286120"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 01:20:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 01:20:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 01:20:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 01:20:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkzfaA2+LVGaRNVR4CgWJMOiYEMx2DYY8ULn7oLLMjD99D9ARB7guDGrjYwtudc2HhemevH9zxJIPHZwwmpm5xrumJ2t/AigTor+QRqHg4CZqQaUIPomurazBm6mVp79rf78AYuhcXnN1GpYsakaMSwGfxbifUyI2t1yQotnQ1JDAQI6XxIVfFqiJi6leKR6RicH0DozfKdM/BFcvE94rGFujgKqzP4NBO6S5id25c2BiHiqyG6oFvVFAt9+qvUbCf+09E+mYLrarXNlVqbnteWjv1pbpoyGADpbdoxWymjCwMINmB7xqLsSTGKOlmKKUUxh+k0rRarcnZXqESw4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktg8JHL/7R86vnd9BzJsvM6xGJ6WA72FAVVdvcFz9tM=;
 b=bAcAuAi/WMFH6xsIl3Rf+obd7qT8ZNPdjl63QlUH4pJiaPN5TXQu0G4bJi/kUTdmlx66bA+WtHkHe+GyupDZ9PAdQD+nWRKdFFhP0qlwbMzmRofwpWN2Rg1g1BlBxbrC3iYJ3zxezyfm41C3lMfRgV+54QkBhFgT4H7DO1Mrjp1Z7RS0wjohFV+O2/69+8/ne8gapizouH2B+6PNcWWGt3v4F1BdK4615eD8FpOgYjir9/DhsoU6LQM0EvtXlWQGXGNOz/y5x2LCVwwg6gGpxSxfAip2P7pP75r5cM+slQg25SZaXur8gmuSxQp+9xX0NiRJZbI860E+682QHlw6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 08:19:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 08:19:59 +0000
Date: Mon, 19 Aug 2024 16:19:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <rcu@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2024.08.05a] [srcu]  a7adbae9c5:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
Message-ID: <202408191537.5ab14400-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 490de243-28d9-43d3-0e2d-08dcc027b746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gvf5ql3U83EetHJ4CHSppDlq130p3Y9eAapUImQw0woXfRGCOj2xYCAh/phZ?=
 =?us-ascii?Q?bFm/MBH7p73ORAUevVumvHE4xXwVKUej4GdsqD9O9zyGMf+g6thjpq/iq/di?=
 =?us-ascii?Q?41Svp6PQimJnqxkr1lkWBHGyblOlTGPukOaJrxCsK3osgZgSeUqTZyPVkaBl?=
 =?us-ascii?Q?suPYb9H6Hi/qNO99dtfpQU8RktYWZKm18WX+1sdPJlOBJwAqdV3F3qFz5HpO?=
 =?us-ascii?Q?Qv0cFIi5JZC0pJcyqsjDkIwtRI1TLYsiys6QurQTDfBdsnkDC7gbeTE3RZ1w?=
 =?us-ascii?Q?0TzVo0j9J8o+rpYcDtIra38VLKOqkGJo6lhd9h5u6D3kmTn91QXtRXG7f8uS?=
 =?us-ascii?Q?bJItrVzxnjRwl4fCRjxyzTkv/KbfP/m+cRhElPYXtLbtaqUwlJPC6ygh+8VE?=
 =?us-ascii?Q?vrVkgdUEVXm1to+uOEiWbvXamEZ8jMdBbaePciCTK6p85VshVg5VFoV+SKiS?=
 =?us-ascii?Q?sZWSudI3fUuGnEzHECbKi7Oxr6s4KGe/s4jnkwGYxGqj9xTGDXNUYY9Eg9vX?=
 =?us-ascii?Q?fw6odghj9+0xGrHRRpX+bHjpirQJVAsKfrnN3TlikXTuorWOP1y3tOXKf93R?=
 =?us-ascii?Q?hvY2ehvtdplnPuCX13M4DJOptjuUHGu8Csa+aSzhIFe/XAuLfUyvtm3KAG/p?=
 =?us-ascii?Q?DOiehtrkt1RdiWXNZgdkkc4PzlezrYMzxf5pzbsmeUNtOC+bLGepL0JpvMla?=
 =?us-ascii?Q?d9GLbCLOECrrkejMkMS6wWfon1mxQyONEkjBhRh86cobXcAOcV65n0S4JPfi?=
 =?us-ascii?Q?DQZ8wyQ+ggWVnpHeGxb+xfNwaiq6WTdP4H3bHXOcMzrjzNpU0pCC+GX/twY6?=
 =?us-ascii?Q?XkgtHXpADo0TCXcYdG0NGhsDYG+IaVrZXMLwqk0DF8hK1Qz1WV8ng8hhtUf0?=
 =?us-ascii?Q?MQ5QOXjusHupeBddmRYrFNyVQQc+nmhvqhXcMGBV1hPK4tiPLsoS41Il5+Up?=
 =?us-ascii?Q?HIxqheQVzzFYSSy6M2QupwS4h+WAIZOrNA6GSPEEDo/bAv8an19V9pl4a+EB?=
 =?us-ascii?Q?P0jXvQUHv4P9XVJ1DMzFl6ojJUH4ZId8jJdQGiNBXyKFu8uwp6WhGwq52aKb?=
 =?us-ascii?Q?qELggMwRgsRekVC9HXmPp6eW1OZJ11QTmgXsrla84giklAPI19+fYjYWJPgF?=
 =?us-ascii?Q?3LJOb4bSWfE4sQFsrpED/wrMXaeN6GfZnpU/05Wh874345MVG7cx6XIrTBmj?=
 =?us-ascii?Q?XjoOmg+ZPWRvojTsH8a3U0Oi7DEzDv9wQQhXy5fgMnVdPMQDIhbdBq6urbTr?=
 =?us-ascii?Q?fKJWW4VX5EJL4/BqIkSz+rbwYe7x6e9c95Zw4Ec/xBOFWl1ZTJwiMQJ16Qjx?=
 =?us-ascii?Q?O4c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0coEztQq7EwBf5yGr3tdHRLPIiOm8L8EV0FxEzHbUk+HBA0lkRUtILDdEyEZ?=
 =?us-ascii?Q?fvq+u6jIx6F6gw+k/V+n/650w19r/PxPRd9nlNZ1yGNKcXgt9G0H0U7zCeJY?=
 =?us-ascii?Q?lt4VYxf+OySlvRxKKBHtYk0kUCPBrQwkPySdQ2cXxRRNSJfn90SwHjTJHFJa?=
 =?us-ascii?Q?yBe5O75VuJPADDyZj/phyh5z8YcPs/EYoduTgYX013ySsiVePXhyKHKagOTo?=
 =?us-ascii?Q?L1F+c5GxJ34V0J9iTmlh1HGuWlhrqz+hBo0d0F0xY0vTkOXRS/IZ2S3Fxy3n?=
 =?us-ascii?Q?ImhVfhFWy4IbMImUxqwDOjTG97fJqVf2GeNleXa/nzmouHeWgcIwlgRhxMak?=
 =?us-ascii?Q?OTqJqfK4DwkMbp4jmhArX6fFwgXdB+lv5mJv9URpms4fn7MiZl9PjVECN8lh?=
 =?us-ascii?Q?i/gDFGexGx/SNv/7AlxjIywvagKaCjkIle3grP5RGKgyF710/1CMSFKU+4TV?=
 =?us-ascii?Q?mjuocnm42ZAkQlK4qHHZ2K1coiXKcqCTdebCN6yfUoGvGaXLKH8jR10oTUAq?=
 =?us-ascii?Q?GUD1FJ7KfXkIBrtNNjNm7TxymXAjSMOu7k/F4yuit38RAl12zm2Pxv8di/Mr?=
 =?us-ascii?Q?a+zbbT2hL2L31QSBORyMFpuSLsAmzmh605HNANVOrCjzuKa9HP2NjOKVp9z3?=
 =?us-ascii?Q?TdDYQ8VbcnRCg38zWAg8+5VURZM87WDLCne94MInYEdtlYVGJEVPE1y2kMTC?=
 =?us-ascii?Q?MRAHzma1GJtDxcExx/sVlE9J9mlw77/rmpZRwKgxvA9l3OCKyFsX835TQUWA?=
 =?us-ascii?Q?rxv4z+BYd+V56DkjBtSwgyps4+KKQ64GB4RRYlrWzL0XR8GM0o917aEXJay3?=
 =?us-ascii?Q?d82+ysf7divdg7UbRNzaGVKGTdpo4IRx6r0nASHSl+OUzAJ/ABRVe0/hkVRT?=
 =?us-ascii?Q?eI+b0+/1HvvnUnSz2qHfUWRAGMlRm7QNCWE0F+VizSkiJbEPJqQJS//S4xut?=
 =?us-ascii?Q?Yt0LXsZiWToZlrUigqbWjINW6Lfd0GWyso/o0ocqgt2uiNXOvLVk0OKPo5+c?=
 =?us-ascii?Q?CuiDxruzD+ZAESrk8Wq0iKrzkUjrhnS0uKnCEi2iNRRLYeniClIoIk5583l8?=
 =?us-ascii?Q?EMHdtfO/PNZ4rVtSytfnDTqLgeoMOi3vxAkR0h8nBqJTq/umdgpBZE5JXL65?=
 =?us-ascii?Q?3rIfUFEqJx6Ts0a/coi2RhUH4cUbXDHkEa4luTEn8yYiU0LIIY8J4mRPbJii?=
 =?us-ascii?Q?eeuU0kn5ZkVVQjxu2e97jA/qAf7+jabJODSfayoJIlkHt12Ws7EyPAX801lA?=
 =?us-ascii?Q?lT8QCEdAwZN2bE5LAYUJFZyie6B82DSFWk1xTmsP6E5VY3cqfYvgib7h2uZF?=
 =?us-ascii?Q?95PA11KZRK79VqcWRPPshGnh9dBLZgkgWGBWAK98rd12akfv36nbhKCt5mxq?=
 =?us-ascii?Q?fnMQ8HRHr4PtuNxzAkkvKm/PTCg1Kpbgk6xal6cky7ulRFR8Py1TLih6kxD7?=
 =?us-ascii?Q?fskjSaZ6/eyuLzpTH2zTW7RruZKpYlMofTZ8+9r2pNrn/06cbggiZAgqjg6S?=
 =?us-ascii?Q?Z2KF2Cbvx+LPx08lGg7vFReaWoWoXUPhgJ6bgYWWWh1STgq/1n1ieY+1TSyf?=
 =?us-ascii?Q?xtBLDyzFkChObuW7PQ7uFKmGh5U9ibWaDu1HKUZ1cnlM6q6CN7o/1XQ8l8d6?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 490de243-28d9-43d3-0e2d-08dcc027b746
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 08:19:59.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fR3YWZqMf82R34coqI36bsTWXnZpCiyDU0/hQZIFIE4WQIcdesuIruWu36f2qqc975t3v1IdtNgWebGH0y5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com


hi, Paul,

we actually want to consult you about this patch. by it, the config has below
diff with parent in this tests (we use randconfig here)

--- /pkg/linux/i386-randconfig-004-20240810/gcc-12/157f4b896656dfe6ad6d37c94ca9a885d52f35ab/.config     2024-08-12 04:00:50.715727095 +0800
+++ /pkg/linux/i386-randconfig-004-20240810/gcc-12/a7adbae9c55d7f85b3b8c0e8e9417e5d52793137/.config     2024-08-12 04:02:38.647990561 +0800
@@ -136,7 +136,7 @@ CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TREE_RCU=y
 CONFIG_PREEMPT_RCU=y
 CONFIG_RCU_EXPERT=y
-CONFIG_TREE_SRCU=y
+CONFIG_TINY_SRCU=y
 CONFIG_TASKS_RCU_GENERIC=y
 CONFIG_FORCE_TASKS_RCU=y
 CONFIG_NEED_TASKS_RCU=y


then we saw issue show for this commit:

157f4b896656dfe6 a7adbae9c55d7f85b3b8c0e8e94
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6           67%           6:6     rcutorture.busted_srcud.fail
           :6           83%           6:6     dmesg.EIP:rcu_torture_stats_print
           :6           83%           6:6     dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]


another diff is, for parent, we can see:

[  465.948962] busted_srcud-torture:--- End of test: SUCCESS: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 stall_cpu_repeat=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000 test_nmis=0


but for this commit:


[  417.566774] busted_srcud-torture:--- End of test: FAILURE: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 stall_cpu_repeat=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000 test_nmis=0


are these expected? below full report FYI.


Hello,

kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]" on:

commit: a7adbae9c55d7f85b3b8c0e8e9417e5d52793137 ("srcu: Enable Tiny SRCU On all CONFIG_SMP=n kernels")
https://github.com/paulmckrcu/linux dev.2024.08.05a

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: busted_srcud



compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408191537.5ab14400-lkp@intel.com


[  180.101544][  T569] busted_srcud-torture: !!! 
[  180.101750][  T569] ------------[ cut here ]------------
[  180.103079][  T569] WARNING: CPU: 0 PID: 569 at kernel/rcu/rcutorture.c:2263 rcu_torture_stats_print+0x361/0x5a2 [rcutorture]
[  180.104531][  T569] Modules linked in: rcutorture torture intel_rapl_msr ipmi_devintf ipmi_msghandler mousedev bochs drm_vram_helper intel_rapl_common drm_ttm_helper crc32_pclmul ttm aesni_intel crypto_simd serio_raw drm_kms_helper rapl fuse drm drm_panel_orientation_quirks backlight i2c_core
[  180.108333][  T569] CPU: 0 UID: 0 PID: 569 Comm: rcu_torture_sta Tainted: G                T  6.11.0-rc1-00103-ga7adbae9c55d #1 89f8a658c4adbda3212056ebb1acba93a3453734
[  180.110128][  T569] Tainted: [T]=RANDSTRUCT
[  180.110676][  T569] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  180.111951][  T569] EIP: rcu_torture_stats_print+0x361/0x5a2 [rcutorture]
[  180.112889][  T569] Code: 74 02 0f 0b 6a 00 31 c9 b8 98 4d 54 ef 0f b6 db e8 9d 96 c1 c1 31 c9 89 da b8 80 4d 54 ef 6a 00 e8 8d 96 c1 c1 4e 58 5a 7e 02 <0f> 0b 6a 00 b8 68 4d 54 ef 31 c9 89 da e8 76 96 c1 c1 58 68 8d 96
[  180.115329][  T569] EAX: 00000000 EBX: 00000001 ECX: 00000000 EDX: 00000000
[  180.116208][  T569] ESI: 00000002 EDI: 00000000 EBP: b6be3f64 ESP: b6be3ee8
[  180.116977][  T569] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010202
[  180.117817][  T569] CR0: 80050033 CR2: 08082db0 CR3: 069fb000 CR4: 00040690
[  180.118722][  T569] Call Trace:
[  180.119180][  T569]  ? show_regs+0x65/0x71
[  180.119838][  T569]  ? rcu_torture_stats_print+0x361/0x5a2 [rcutorture c084aa8ea4885af620a5fd08bf5503a17a237677]
[  180.121034][  T569]  ? __warn+0x92/0xd3
[  180.121591][  T569]  ? report_bug+0xdd/0x156
[  180.122212][  T569]  ? rcu_torture_stats_print+0x361/0x5a2 [rcutorture c084aa8ea4885af620a5fd08bf5503a17a237677]
[  180.123567][  T569]  ? exc_overflow+0x3d/0x3d
[  180.124162][  T569]  ? handle_bug+0x2b/0x4b
[  180.124693][  T569]  ? exc_invalid_op+0x24/0x61
[  180.125262][  T569]  ? handle_exception+0x164/0x164
[  180.125896][  T569]  ? exc_overflow+0x3d/0x3d
[  180.126448][  T569]  ? rcu_torture_stats_print+0x361/0x5a2 [rcutorture c084aa8ea4885af620a5fd08bf5503a17a237677]
[  180.127705][  T569]  ? exc_overflow+0x3d/0x3d
[  180.128320][  T569]  ? rcu_torture_stats_print+0x361/0x5a2 [rcutorture c084aa8ea4885af620a5fd08bf5503a17a237677]
[  180.129584][  T569]  rcu_torture_stats+0x3f/0x60 [rcutorture c084aa8ea4885af620a5fd08bf5503a17a237677]
[  180.130712][  T569]  kthread+0x109/0x10e
[  180.131226][  T569]  ? rcu_torture_stats_print+0x5a2/0x5a2 [rcutorture c084aa8ea4885af620a5fd08bf5503a17a237677]
[  180.136140][  T569]  ? list_del_init+0x25/0x25
[  180.136464][  T569]  ret_from_fork+0x34/0x4d
[  180.136776][  T569]  ? list_del_init+0x25/0x25
[  180.137093][  T569]  ret_from_fork_asm+0x12/0x20
[  180.137422][  T569]  entry_INT80_32+0x124/0x124
[  180.137758][  T569] irq event stamp: 1025
[  180.138078][  T569] hardirqs last  enabled at (1047): [<b10bdcb0>] console_unlock+0x9b/0xfd
[  180.138658][  T569] hardirqs last disabled at (1056): [<b10bdc97>] console_unlock+0x82/0xfd
[  180.139225][  T569] softirqs last  enabled at (1042): [<b106fcea>] handle_softirqs+0x28a/0x2f3
[  180.139838][  T569] softirqs last disabled at (1033): [<b1b627cf>] __do_softirq+0xf/0x13
[  180.140398][  T569] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240819/202408191537.5ab14400-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

