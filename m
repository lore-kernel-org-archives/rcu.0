Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D81AF0BB;
	Fri, 22 Aug 2025 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830958; cv=fail; b=AVLNgn3T1/fBQfbnU7DyerbTfNAFePFe24dkwfdrn5kMnXA7JcIqK2oykPBE9iQis3YYi7YttHQzKwTIB1OfKcQehEYRdaDtm1FI1OGZwp1bBCJl+037FBytesljKotY3y2b7Hjk0SbGenShgOMMTrLifbTJmMVEcU2zu4muflM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830958; c=relaxed/simple;
	bh=q9EfvTZdxVjz9YTHu3i1/TxsCmMYNOrDqplm8rBjE+g=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hR+5LuCuWkYc01uhEFa5IP4YeDpeyd2kXuSuyML498f04T79Hwyw79QDbfgAI1gUlkxYX43wcxNyXHuMwUCwGbbfEfAuVDjoKOcyWCIP8x1lt3UPywKf+J9FWyZSuOyogVqL+4gEPHnARHl3NqpdBdEPcMYDltUnxCoEa8CjC/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n68bo1yV; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n68bo1yV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755830957; x=1787366957;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q9EfvTZdxVjz9YTHu3i1/TxsCmMYNOrDqplm8rBjE+g=;
  b=n68bo1yVURt5EWkTloppiMaWTxwCsWkrP1FFlBgeTd1wwr1ZuSms3vrC
   Y6OZYIodOeeUJKkO7lhI17/c/c3QZXtN70EUe1gTaOlQrzi48SE31qwBi
   4UP3u+3qVzTQpqYJdlWCWuKyNhMbeLEbpjKZ80DnW/wpMQx6J7Td1jn2e
   ZJWVM5/0l9qXlA5j6CIDejD46Nn9a4OtOteohIi8Mv2sBM4wtHfrWqZSj
   /ErpLMCSzQZ79FjvZ64iPGYFX00+a163859Tv3kHEdSEb+N6R3shuP/T1
   W71kijWaLcNa32DBLGJFDSI1h9KZ2EvvMs+u4UqOKwdye/ml1teQ/Zv4R
   g==;
X-CSE-ConnectionGUID: wtUbEOG9QlyHzvhPjj+yAA==
X-CSE-MsgGUID: J/wTtT/mRCmHSHt1b5aJfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58203574"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58203574"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 19:49:16 -0700
X-CSE-ConnectionGUID: ripRHfOtSuOhVa+IcAB8iQ==
X-CSE-MsgGUID: GXPjZPA0T5C7wcMcvzNMYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="173902898"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 19:49:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 19:49:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 19:49:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.76)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 19:49:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8R4Riy9rtzGLjwP9AMBiIie4aOEUCiEZ+OdFPWMkS3rSaEf31XpmZSSd/v82Q1fOIW5gjPh6UjKFTPE+CT5CRxaRXDxejt0KsRCIvKv5WGZb6OFym4Y+nX9AdmO6XBRsFNGFMI2IRBNsdtqJPlQx5zXxPCFSpEIoNXw9m1jCvtKEd7nzdboqs0Q8qPYhXzOQ95zOTZ0kFry4ZKWXN1fQexvcW1jLFWKaL09vBRDUfjao0BfU9tHpcg4XHWObvagAy73wqmjjVRbWF2KzxfRs/xbfaxtg3hvYPJWM8en9pPuwqopaZf8i5PgTdo6HTQiEbvb8vkD1GdQqSuLgr2W4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0Jepsp0bANsJWDyXW/80mMEDXZ0GOJ/w/LFxrBZux0=;
 b=SfWaKMhHlktc+fBu/XACLbCIRkx44qRcOLdg+xa1ISvNNWwtBQDq6B5U6TK3lEiuSkUbIM+VBqk7JjzsgR4OXgoxsexjOQvjr/UzZdGfBy8+2lIVFM85blm8L/x8dI9zPF5XZa/vSc+OHcqI9BRU6y1FNXeOYdRgztd64xqMgBXXI8X1tjEeFIjjhCL4Ofo2LYeGTHFMoj93uiscpXTkNMQE5OBin+Jp49W/Cg5YSVflZdv67UGrYs6vpA3YpmtbocODvmVJ7NbaYPMlou21u1pHdGjGUDYOucKPXjy4kdTGnyxUeB9ErAJR1gByv4qtd9ATmdj+eFZ0+bzznq2tZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 02:49:12 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 02:49:12 +0000
Date: Fri, 22 Aug 2025 10:49:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrii Nakryiko
	<andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	<rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2025.08.14a] [rcu]  2ad3ef4260:
 WARNING:at_mm/slub.c:#free_large_kmalloc
Message-ID: <202508221045.ecc6098e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6854c8-4b51-4297-2eb7-08dde12679ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7aA1Jfq9YeXp0DULDgRCTQn+I+z8O26TBrmAbJZ/NHGn3MQwjSHbshSJEC63?=
 =?us-ascii?Q?iY4UM1kZK5IyTPbt+tweNe7nyP/5iOeyheK9WTl/7/hwoVjbLG3iDnCgsUZr?=
 =?us-ascii?Q?kmUFkUf1Thb1b/wpmFvc0zK/GC7ERPjkAiecbyfORDmsgn6yvWFS3oC+7Q+l?=
 =?us-ascii?Q?l6asaJKQzOSbw74Nlil3HPlslaWcjXH09EiHJkhLXsLBBNx+LxOWhodSAb4V?=
 =?us-ascii?Q?qr018Z4XBdwjAfrqoYZ0quQMzgGMESX+6WhQQdwUvWgIi+3On/6qdpA01C/7?=
 =?us-ascii?Q?ouj2hB+uWcYfNpZX5uAOO2s/aeTpWnmOeLcXEySVQ1OG+WMPRQm3jFLpSqy+?=
 =?us-ascii?Q?6wo+sC2ukLfsPDDd9l/8Us2uHi41vqO/pe0EQNeXGSYuC6s0kTOw2WjonOkb?=
 =?us-ascii?Q?PujNpZvcOCzhKEjDADlCb6fajxqYwvO+pxeV1dICZShMeLBjkNyzew5Kf3FE?=
 =?us-ascii?Q?Xs97Ysq1Tw03k/8yhZHjCxArXbOu2nDINZd1t4lpPjAPQprFzb805GtHmvxo?=
 =?us-ascii?Q?qFvR7yU3uXC4r+7XlIJArgLbN1evUi71m8tvwlkB0wmj+lv7zMyfdzmJWP1G?=
 =?us-ascii?Q?B1PswFI2HfbcyYF5dB+AUroIXkLl5e8CGSxoZYCAHsw8LzG+XNR+fxk6zr0V?=
 =?us-ascii?Q?UNs7iuxp6YkCu+ERUMy9COVNeBs34SDl8/n6m/JiW3NndlFCEEJSSIsVW7Uv?=
 =?us-ascii?Q?zA3Wb9hrF5eYfG+l2t3U9ZMaowCeeVbatTY91fvDNxXr/msqk8yquzE2mXPV?=
 =?us-ascii?Q?41wPocVC32vmgFGtFH5yfuCLsK5uOsSzXI54/YaB5sBGgDgR1VPIOQ1o2YeF?=
 =?us-ascii?Q?8swXMhgwzu2jFDX//XV25bA62IlJNfdJVvV++oW4OiAFQbEA9S/cNHZlV2/9?=
 =?us-ascii?Q?sFWiH6FjWd55QgXZNYCsIw2GugOI0+JneN0S4yEvjcHPpRzX0bJq81nwk/r0?=
 =?us-ascii?Q?Z3HBBLJmDxHDb1AP+PQ50WVWE/g4IMtIN+YuTL4sM0otoSWNcUP3RbkvQruG?=
 =?us-ascii?Q?HHC/3IrB+8K5oD5xvPIKWWXfPIxvYgB04cfGPQqfWAHkJmlw393hCmmVH2w7?=
 =?us-ascii?Q?XOAw5l47SIzjo27nV2sO7epB4lqVPXvF82DDOIFce/4fwWEs1TvXOpHsNekT?=
 =?us-ascii?Q?tQ3mS2Z1xWcsUTZCZvdhH9P2ln4Eny7MEOi3QXUvcQKiGDJ8NPLwq/Oh2yz/?=
 =?us-ascii?Q?JUQhcnwr3qIIk6SzjL2sYVHDEM291aoL3ygKeXhrxPFMo1FhfZg4C+llAm7b?=
 =?us-ascii?Q?45q7dSILl+pAObri1KOWbPs7XTbmEuUZtVf0TBZXnbsuwsAuUofsRCU/GNu+?=
 =?us-ascii?Q?u/cmXQhipUT0Z1D9Pc5IvcCd+Hi7yhfQ2E6y0ThpWMGZUeDnEq1wGjvSofU/?=
 =?us-ascii?Q?RPgpvJrX7NQuSjGWyscPPhXzKPGr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eyNTiH10hZ0KJDdVhif8ib3W4V+sk3ygm/w722PJN4g2BhOC6AnLdKvKyoq9?=
 =?us-ascii?Q?gNFMvak1aBjHOPInGTZHnXsMLY+z4RoMZjT7RuBkpuqSSV2cavmGVYnhAAWo?=
 =?us-ascii?Q?ycevdshAxsK+83zu2ShGNrMH29W3B5zYIvSJrCXu6/86zheSOX8pc62RmCQi?=
 =?us-ascii?Q?fpKBdh1ZvFKhV2ZLxvqaTsDec7MYR9vfhjN9dC+H3wg326uzDgs4lC6XKJzq?=
 =?us-ascii?Q?x4FN/e3wTgeKT4uL6t+rPzRI9dJxfRXK8vs8LZQKU5iBJfo+o93mTBjvJxVp?=
 =?us-ascii?Q?TtVhFj6FG2DH4L8sVVScPkmFOQZsDvQ6RhPQcc3GpCFIOtkd3Q/QNm6RmiwE?=
 =?us-ascii?Q?9Iv5ZME8t0GWLJtoNklUZJU6/X4BzavmPVj0bjiOjhaAHiKVcJwOayjICQdi?=
 =?us-ascii?Q?Z35GTzrBHYEulQNTkQZ97hLVHvAcReyVh9A7fwJGZ/cnYXUpy+xNyxm2OQwM?=
 =?us-ascii?Q?KtNakelpa9KDeKHd1Pd8VuBL5LX3eirNghPk2r8lhafOiwDSd/8rTRnG5w5d?=
 =?us-ascii?Q?dubYPxIV54iL7eHZAdr/YvPYwT81OLY2OYfoh3L8vCMWkj7cxdcmjd6yLBYV?=
 =?us-ascii?Q?23+ZxgqEUxJHJ/YkkjH+XG2rMAJHAssLZmmgw4qkWGtvDxRf4zTYNytnTDXc?=
 =?us-ascii?Q?/APy/DYZ65diuDIs/UzJZ0ZuVdXAyYb/+H3is3lPLUcS/8+Sv0KKr3Bc78U5?=
 =?us-ascii?Q?iupCka73ZQHQqSN/HmaL7oh1c6aWL3agJx9Vp2DjFT/xRn1iVotRQwz2VKj1?=
 =?us-ascii?Q?a24S8Qg5LpDFLg+dbdjqE1aTI5ZVXG0ACyGQtFdRbmxeKUHyNuV7GuRkPIpC?=
 =?us-ascii?Q?ok25h7jo5ITmz6e2sDBWblDAwvoaCOgcGrjF4oc74y/4hLibk9OnY5iLFg+c?=
 =?us-ascii?Q?bBf37fIMy3xSe2tCJzcyqiYaWwE5pvXZBRy/LYvwrES6bchXemlCmbcMg5kv?=
 =?us-ascii?Q?fWMvVMW6ijQWWm1Hn7XA3KFc1rInzeDW8OyPdpHVOhCaMbE4C+uASAudny9T?=
 =?us-ascii?Q?iRelDynbyEN0RNVgJNcJ6z6Qm7muSMifvchUGEi51UuCq0axKidi6O3+DRZe?=
 =?us-ascii?Q?XmIaeVokU0pIFs8s7fHV/uPhrwY3Xd38SUf5ReJ8tS/430Umj4AmtNZrTjz/?=
 =?us-ascii?Q?NKN5ma0NuwZO9N2LxypngJ/OeAYfsgCjkieUdAtbjqjphDaVmIsWRmaBINOv?=
 =?us-ascii?Q?C4azwK0jdlQL43RDUNsd0nquvS/wNgSPgL9UY3Ydw5PkJh+faaBLqJ6p9IMC?=
 =?us-ascii?Q?iEg0CllZ/THmjVnJwl2rI2sVN4ewyP3tSBQLnquJG/vPTO5L8dKhobFKBSPD?=
 =?us-ascii?Q?Q/FaPRtUaRGGGQ2qT7cUIWbeAiD039p4w4tTx6wiKq9v5iSHXVAKgcUd5qRz?=
 =?us-ascii?Q?ai8Wnw5lvJXJaf5kR1sv1//Pi1HoGFl2bZt891W9bntqm5AfKawVLT2hrsmy?=
 =?us-ascii?Q?ey7T/EqtookV/ytDr5CYsEpIANdIBBZl/8+k4/c+cIPVTNEYFp35rM2mVdIP?=
 =?us-ascii?Q?WWgJlq/sr2aVT3lo4g2Tgm648IO7K5M7r4iCD1pxHjZmD6A96aU7ZhK3Huc5?=
 =?us-ascii?Q?jg+JmVh5534KDXNhHemiH/bM/iBlkRrHbHRfGy2lo5teSjCgnihwFnV7BR7S?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6854c8-4b51-4297-2eb7-08dde12679ef
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 02:49:12.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ty/l3HzbJTw4ZSH4ryEnV/xQcIQcbsOFDK/hHjOY1mHivo+LLaAric7OdUa2gNwW47OwFTw61jGkxdD/sCqnWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
X-OriginatorOrg: intel.com


hi, Paul,

we noticed there are similar commits and fix commits in newer branches.
  dev.2025.08.19a
  dev.2025.08.20a
but we didn't finish the test/bisect for new branches.

this report is just FYI, if the issue was already fixed in new branches, please
ignore this report. sorry if any inconvenience.


Hello,

kernel test robot noticed "WARNING:at_mm/slub.c:#free_large_kmalloc" on:

commit: 2ad3ef4260e9bd8628025b35fa2613c7e4e7720f ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
https://github.com/paulmckrcu/linux dev.2025.08.14a

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: tasks-tracing



config: i386-randconfig-013-20250820
compiler: clang-20
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508221045.ecc6098e-lkp@intel.com


[    5.780201][    T1] ------------[ cut here ]------------
[ 5.780793][ T1] WARNING: CPU: 0 PID: 1 at mm/slub.c:4790 free_large_kmalloc (mm/slub.c:4790 (discriminator 12)) 
[    5.781568][    T1] Modules linked in:
[    5.782001][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   6.17.0-rc1-00030-g2ad3ef4260e9 #1 PREEMPT(lazy)  f3de4fe5b382f5192602efb6727d7dab8a9b7f2f
[    5.784147][    T1] Tainted: [T]=RANDSTRUCT
[    5.784803][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 5.786255][ T1] EIP: free_large_kmalloc (mm/slub.c:4790 (discriminator 12)) 
[ 5.787027][ T1] Code: 89 d9 d3 e2 c1 fa 0c 01 15 ac cf d2 d0 01 15 d4 d5 5c d1 83 3e ff 74 06 c7 06 ff ff ff ff 89 da e8 8d 55 ff ff 5e 5f 5b 5d c3 <0f> 0b ba 2c b2 4e d0 e8 6c a4 c7 ff eb ed 89 c7 b8 30 26 b3 d0 ba
All code
========
   0:	89 d9                	mov    %ebx,%ecx
   2:	d3 e2                	shl    %cl,%edx
   4:	c1 fa 0c             	sar    $0xc,%edx
   7:	01 15 ac cf d2 d0    	add    %edx,-0x2f2d3054(%rip)        # 0xffffffffd0d2cfb9
   d:	01 15 d4 d5 5c d1    	add    %edx,-0x2ea32a2c(%rip)        # 0xffffffffd15cd5e7
  13:	83 3e ff             	cmpl   $0xffffffff,(%rsi)
  16:	74 06                	je     0x1e
  18:	c7 06 ff ff ff ff    	movl   $0xffffffff,(%rsi)
  1e:	89 da                	mov    %ebx,%edx
  20:	e8 8d 55 ff ff       	call   0xffffffffffff55b2
  25:	5e                   	pop    %rsi
  26:	5f                   	pop    %rdi
  27:	5b                   	pop    %rbx
  28:	5d                   	pop    %rbp
  29:	c3                   	ret
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	ba 2c b2 4e d0       	mov    $0xd04eb22c,%edx
  31:	e8 6c a4 c7 ff       	call   0xffffffffffc7a4a2
  36:	eb ed                	jmp    0x25
  38:	89 c7                	mov    %eax,%edi
  3a:	b8 30 26 b3 d0       	mov    $0xd0b32630,%eax
  3f:	ba                   	.byte 0xba

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	ba 2c b2 4e d0       	mov    $0xd04eb22c,%edx
   7:	e8 6c a4 c7 ff       	call   0xffffffffffc7a478
   c:	eb ed                	jmp    0xfffffffffffffffb
   e:	89 c7                	mov    %eax,%edi
  10:	b8 30 26 b3 d0       	mov    $0xd0b32630,%eax
  15:	ba                   	.byte 0xba
[    5.789718][    T1] EAX: e7722700 EBX: e7238660 ECX: ff000000 EDX: e7238660
[    5.790702][    T1] ESI: e7722700 EDI: cecc63c8 EBP: c1259a80 ESP: c1259a74
[    5.791669][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010206
[    5.792787][    T1] CR0: 80050033 CR2: b7fa3cd4 CR3: 10ed1000 CR4: 000406d0
[    5.793708][    T1] Call Trace:
[ 5.794192][ T1] ? crypto842_free_ctx (crypto/842.c:40) 
[ 5.794849][ T1] kfree (mm/slub.c:4874) 
[ 5.795393][ T1] crypto842_free_ctx (crypto/842.c:40) 
[ 5.796104][ T1] crypto_acomp_alloc_streams (include/linux/err.h:70 crypto/acompress.c:431) 
[ 5.796915][ T1] crypto_scomp_init_tfm (crypto/scompress.c:128) 
[ 5.797665][ T1] crypto_create_tfm_node (crypto/api.c:541) 
[ 5.798430][ T1] crypto_init_scomp_ops_async (include/linux/err.h:70 crypto/scompress.c:314) 
[ 5.799284][ T1] crypto_acomp_init_tfm (crypto/acompress.c:124) 
[ 5.800029][ T1] crypto_create_tfm_node (crypto/api.c:541) 
[ 5.800809][ T1] crypto_alloc_tfm_node (crypto/api.c:642) 
[ 5.801584][ T1] crypto_alloc_acomp_node (crypto/acompress.c:162) 
[ 5.802380][ T1] zswap_cpu_comp_prepare (mm/zswap.c:836) 
[ 5.803160][ T1] ? zswap_setup (mm/zswap.c:822) 
[ 5.803856][ T1] cpuhp_issue_call (kernel/cpu.c:205) 
[ 5.804563][ T1] ? mutex_lock_nested (kernel/locking/mutex.c:760 kernel/locking/mutex.c:812) 
[ 5.805313][ T1] ? zswap_setup (mm/zswap.c:822) 
[ 5.806053][ T1] __cpuhp_state_add_instance (kernel/cpu.c:2427 kernel/cpu.c:2448) 
[ 5.806918][ T1] zswap_pool_create (mm/zswap.c:295) 
[ 5.807704][ T1] __zswap_pool_create_fallback (mm/zswap.c:362) 
[ 5.808596][ T1] zswap_setup (mm/zswap.c:1868) 
[ 5.809302][ T1] zswap_init (mm/zswap.c:?) 
[ 5.809938][ T1] do_one_initcall (init/main.c:1269) 
[ 5.810654][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4674) 
[ 5.811372][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4674) 
[ 5.812111][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4674) 
[ 5.812834][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4674) 
[ 5.813557][ T1] ? __update_load_avg_cfs_rq (include/trace/events/sched.h:833 (discriminator 3)) 
[ 5.814379][ T1] ? lock_acquire (kernel/locking/lockdep.c:5868) 
[ 5.815070][ T1] ? lock_acquire (kernel/locking/lockdep.c:5868) 
[ 5.815799][ T1] ? ktime_get (include/linux/seqlock.h:226 (discriminator 3)) 
[ 5.816484][ T1] ? ktime_get (include/linux/seqlock.h:226 (discriminator 3)) 
[ 5.817045][ T1] ? ktime_get (include/linux/seqlock.h:226 (discriminator 3)) 
[ 5.817486][ T1] ? kvm_clock_get_cycles (arch/x86/include/asm/preempt.h:95 arch/x86/kernel/kvmclock.c:80 arch/x86/kernel/kvmclock.c:86) 
[ 5.817998][ T1] ? ktime_get (kernel/time/timekeeping.c:289 kernel/time/timekeeping.c:398 kernel/time/timekeeping.c:820) 
[ 5.818440][ T1] ? clockevents_program_event (kernel/time/clockevents.c:336) 
[ 5.818995][ T1] ? profile_tick (include/linux/profile.h:50) 
[ 5.819423][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80) 
[ 5.819882][ T1] ? irqentry_exit (kernel/entry/common.c:?) 
[ 5.820317][ T1] ? sysvec_hyperv_stimer0 (arch/x86/kernel/apic/apic.c:1050) 
[ 5.820829][ T1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050 (discriminator 6)) 
[ 5.821357][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1048) 
[ 5.821826][ T1] ? strlen (arch/x86/lib/string_32.c:167) 
[ 5.822209][ T1] ? next_arg (lib/cmdline.c:273) 
[ 5.822623][ T1] ? parameq (kernel/params.c:90 (discriminator 1) kernel/params.c:99 (discriminator 1)) 
[ 5.823014][ T1] ? swapfile_init (mm/zswap.c:1900) 
[ 5.823449][ T1] do_initcall_level (init/main.c:1330 (discriminator 6)) 
[ 5.823906][ T1] do_initcalls (init/main.c:1344 (discriminator 2)) 
[ 5.824319][ T1] ? rest_init (init/main.c:1461) 
[ 5.824747][ T1] ? rest_init (init/main.c:1461) 
[ 5.825163][ T1] do_basic_setup (init/main.c:1367) 
[ 5.825590][ T1] kernel_init_freeable (init/main.c:1581) 
[ 5.826058][ T1] kernel_init (init/main.c:1471) 
[ 5.826472][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 5.826906][ T1] ? rest_init (init/main.c:1461) 
[ 5.827326][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 5.827778][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[    5.828225][    T1] irq event stamp: 1016907
[ 5.828641][ T1] hardirqs last enabled at (1016917): __console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:344 kernel/printk/printk.c:2885) 
[ 5.829782][ T1] hardirqs last disabled at (1016928): __console_unlock (kernel/printk/printk.c:342 (discriminator 9)) 
[ 5.831001][ T1] softirqs last enabled at (1008778): __do_softirq (kernel/softirq.c:614) 
[ 5.832169][ T1] softirqs last disabled at (1008769): __do_softirq (kernel/softirq.c:614) 
[    5.833335][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250822/202508221045.ecc6098e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

