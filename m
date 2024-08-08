Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8A13CFA3
	for <rcu@vger.kernel.org>; Thu,  8 Aug 2024 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094344; cv=fail; b=hylOMQlpuWwIeGSsUyOtqnGcJcWdf39TN3x+b+JXcfNuLkinH3OABoDdgYLz1kPE4DosvP/NNc0MdA0ULXqR9ptZRnh0Vwb4J/DeOMFq/hYVQKMEcoDa6bKaPf+lBeSEf14G2xWFPfN+o+aKG7MIRTZohteeerU8gz8fp8dxaU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094344; c=relaxed/simple;
	bh=i/4L7HWWDuQsDAuWiee5GBkwkQ7BU9LjWWzteIoJVl4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=R8PORzTHKVOSK0PC2TBvRUvvUWb2NQy0mWb/teWppBGod5ZGXIMDRymC2vQVtJoIVbcLyqcxJ4VvJDD+nmp2EvsJ40kfJoy/+DrgqIzxH0klq7lA+wBV3luIWc9egrez5yeqSmInHgScz1UJ3uxQEgbDeSWNI0kl+P8S5yr2GZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxvBQuA8; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxvBQuA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723094342; x=1754630342;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i/4L7HWWDuQsDAuWiee5GBkwkQ7BU9LjWWzteIoJVl4=;
  b=MxvBQuA8wGEXHunF/TV6H5G/uxm2/VENEJ2DldHYOwzCLaVMxeRXNd2A
   Mig6k2zx1imfsjESxHuPbM7YNkhnUtn3OJ0NqwwPp+xWX/Yc7T97yz2Ds
   23aN/ZLeFeQuSr/ziHUrs1GRO0AllspSHdG2kmLJyvnw0Px03BBLMbyB7
   6y8DPC85eJTH+yVCWRqe1GID/gTo2H8nxVaCP+NZtGq75CeXzfaCfEEQT
   02tRXMi/a8wOtI2OobuJviiqK3G5r1AQxef8IgirpbBy0G+1zLfW6qiES
   TkHtB+MhhtHPdUo6hVgEM1g05ysxFkriDTnyalRfO2mq7mU21DrNDD2nR
   w==;
X-CSE-ConnectionGUID: GkafaA/tSZmE6+vQeDLnSA==
X-CSE-MsgGUID: g1Z6YgeSTc2foXj32T4w8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="31774169"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="31774169"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 22:19:01 -0700
X-CSE-ConnectionGUID: vss28b8aSqSZDMrktlNsVQ==
X-CSE-MsgGUID: WpYsvbhaTJWSNf2KgLuLYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="80327457"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 22:19:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 22:19:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 22:19:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 22:19:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTyOwtjloqjsULUWg8azqh+SZU7DYHEEnYn9v/XkzHQaQ5q/iZ3R0z+HzsA9DkSdgbT0IRTqDAFiGwgTZkOVqAXAYqBItOI5oi2IW4b7xrTvJEhyIvxPXIKQyEg4UAXcFBPNB00ZUTCvyrC27ep41x+ifCzT6cYD7e6WglaTmE/GNB7XZlhSI/l/5uRTbM6i2qu8YzG8vjAqwkwocJhoFCnJvEmjZuhWzOJ5Nk2JbiI4NxEFUr2v7i70oBnZJ53kYoC9J9F9mTNwbvog+Rlriq2U41wBWf/g+whmv1nwxalUd1v3iJwFNqU54VI9uHF+muqf7xNJQZZu1lK1RLywkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVGJokvS6hFA24iYBNtus7q9bMHonajwvYeU/P9ktuE=;
 b=pmbZeRB0Eb2iSWw6KcpFNF3DEQTsTEFBoIfM5ku5dcNbBc903OIgpzFNF+zU4UB7zuTsTyPEk0oRtEKOgL3l9euC9EjuTCZs3bZov/BMQNVW3dLYsbSpHOBGzSU87Uftf5zehIMdEtJuU3TYTNyhgafBhK3GoGOqGtk0X5Z7Md983Vg8skuQL1i3vlH98ZHCDDk4gJw9smYidm0iwALpx7EEEmVgMnCVNG+YDU4WpAtbtPQnzIFAhcjODDya7r+gO47If7QJtzLIUPYsKBHSv3okdAt/iR+eA4+mQZ6glkcbAc/qgiAFQNaQjeYpnil0hn0ZgiYlhpR/fmGojTLv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.27; Thu, 8 Aug 2024 05:18:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 05:18:57 +0000
Date: Thu, 8 Aug 2024 13:18:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: JP Kobryn <inwardvessel@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, <rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2024.07.18b] [srcu]  8a4c716cfc:
 WARNING:at_kernel/rcu/rcutorture.c:#do_rtws_sync[rcutorture]
Message-ID: <202408081016.9d43eb89-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 9daebd56-0698-4ef5-8abb-08dcb7699a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mmpg1DL3JKAO0/U8wLj7lrAr8+fm1PHy7DbMCaKFqIniXEpQr20O+Ddp8Yx6?=
 =?us-ascii?Q?2nlA8hsX16uVauiU5mFGU0cjInFQ859Nvn38Wo50KL/GDxugfxQ1wBHRzESF?=
 =?us-ascii?Q?22PP0cp8Grgz417q0/Zx2AiSov+z75x7aOhTLmO7tAdkKBiW3zSSSXPEWlyR?=
 =?us-ascii?Q?qkI+DgexOAt8iQ17f9s9u5+AIgKB+LPKQ6SABXmq5Bnwio+cdSSn5fOPkJG/?=
 =?us-ascii?Q?JtuXHk7nB4TomlGuA2w/m6sFvqyWN3NNrCO2+cSsDDxV0XblMwlPIvUtxyVq?=
 =?us-ascii?Q?p3oPUS4Va+tu9eCnJ/eQbWv1ISByOk0ullYEgSsjWCg2I2NqWTA8eEIE0wiT?=
 =?us-ascii?Q?0eO1cb7RlzYa99WVK1vF75KnkT9hk+DF+bd+C3DThJ2uIuuCMo4CyS6ZF8/i?=
 =?us-ascii?Q?wOLQHE4X+F3/8VqNdOeATC1ipQjQnJfvNhGwt0JW3t3cSH/fEEeqVLmx5OE1?=
 =?us-ascii?Q?CjP2TP1THuePH8L+xPlW9VZVtmC1qHNg5PGUoP69sJKIExybJHan09hVfFVe?=
 =?us-ascii?Q?X5AiVUsWxXEZf/Eqgw2gAPPi/yIL3ZyupSvHMdFwejMm45EHcCfXwUePU4/h?=
 =?us-ascii?Q?spYD22iX9GlKsw2lhEwB0MxeUtDzcULh8V8BjRZ93gW0KQTpQTDsS3KbfKrd?=
 =?us-ascii?Q?OtXLbXCyqJyRat/S80GBP5BxVtSyMg/txODJH3dIpyh9nEAYJ5Vf4oSDS84M?=
 =?us-ascii?Q?MLBiIZ9Po9SXrdAn42vi07b/7N4faJr1jpMRgLt9WvYZ+epXWSbPmMWGusep?=
 =?us-ascii?Q?lE44wEEJ2Q5OEQyS37nYkKSi7ENSutPJvq2TE6XQtpBejRXFMYKGT813flHV?=
 =?us-ascii?Q?0i5cXIuIfGZAvlw726OFpSZK4YlWHpubeZ84RglDcX7vAFNSK63HIfPkGeRk?=
 =?us-ascii?Q?MyFKlT9EVRveroEMOteWsc5mJNPrsypYjtU4ou2/1YQnxpE3ysgDbIuhHIkT?=
 =?us-ascii?Q?pRp94ipWL4Y3XTrQeMbP3q02P4KnuX/V225q+5UnxapXZyveo7IMNKGPas81?=
 =?us-ascii?Q?fWlKsR7BdCZqTp5TvYUe5s5uXpjk7swlymgYY1ZVpJtrhAWRJSCsehMqKzoB?=
 =?us-ascii?Q?1PzQPQ9+YeO6v/4dD2gDIsjusGAdwwXe4Sxo3OzODF1HPYhY89gQsEyl5wST?=
 =?us-ascii?Q?QkuYTnQUhxpOmT5ioqA48oIPCH8j9xgSrOnN0mQkzWkz133dteiCF4y4gTKp?=
 =?us-ascii?Q?7ygcFn1GFcR2ZzDzJSq8biG+0u4tdtEtLs0RqMUwbi1OLJHgXrdNA1ky4Rws?=
 =?us-ascii?Q?YUpR7n2OHm04VfiEVdaYDqvaYCitzv4BERIOepHI04oJ9qfuNVvsbsRMRVtW?=
 =?us-ascii?Q?w4o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XuZ0co09x14SwMsJqXIdnkOvRAZzoST3X2M+CJ1Myih5xeieOhsp8mMjWto7?=
 =?us-ascii?Q?tHKlCohLsJmkiO4LvIINaTSIsb/ogsBbDejtrqx8f+68D7HOIOl0nEpUMwEx?=
 =?us-ascii?Q?r+pgczgmXTZN/gO3X5qVyTl5XnfLRyUsQ63cydd4S143oaAwKSSu9Gsv2Rep?=
 =?us-ascii?Q?xEPd3+pEZK/A5N8LqRdszEwOsbm3wO2Uqd8UZ4YXxq7oyag7i+QkJTP1IPgE?=
 =?us-ascii?Q?OWnu5lVJUPb7BLielhl5GBv+cOnjAKpTzsaNV2zhC0YUr5IqPfDvk0k2mpfv?=
 =?us-ascii?Q?gnBKC9zclgk3cKJTR25Ba1QQzBh834H/M0/eFtnXc9xvyrWF1+f785PP4hvp?=
 =?us-ascii?Q?i2CYxftaNBCp6NGNnR8Fkc39zg1ZR4yCtUdX8wajjyqDvrh/enOBaOUoybl0?=
 =?us-ascii?Q?KXf5NZ4cpo2Qb0a4OA71Gg/gxJzQKkwkj4HbXseaECqM9ey8/0ZIYNGGj+iJ?=
 =?us-ascii?Q?LF5rTDvhZBt8GCTk6Q+wFfYHUBhzARAdaYThI9re9fDyK3sMB3WBWo6jDT50?=
 =?us-ascii?Q?vxzVNW+wH7hcYJqQF4Zsu6lGbJTV7gxaQAbwI7LS8DMzaE9KSRbyfpOS51P+?=
 =?us-ascii?Q?BXegqI8oaNCGERMvD4DmQyWhVNg5FVuli5rNFGWuJpgCLP+DbZW1g5rPQjJx?=
 =?us-ascii?Q?b20t74ARyb3Tpnadafw+VpHVg9WEUXoK/xWmUuGCCaxJ/G0VLTTZ598nbjbt?=
 =?us-ascii?Q?0dyggvmJFyNEV5Z3DFnvX9f0dXglIHc9/MaS+J5XYww/sW0yalxoa+fqO59X?=
 =?us-ascii?Q?bJPAbcFGCH7C/Iq1WcvM2jy/RffOrHCTp/Mr0sbWjuGRGqHjK6D3eVsi6joe?=
 =?us-ascii?Q?dwkEBRSRtSd+ldUUwuk6y6SfJej724HDsfSWjCql4NnTU/jHcYaHf3j41NEy?=
 =?us-ascii?Q?JmGNVZCvHUOWcGvm04gONui1pr8+urf+IM9h3OQG4Ggoj1y7XFsr2nW0vbIT?=
 =?us-ascii?Q?NFJckIxmUmyTCwKB2dKlASd6QiiwPbnS9uAzgBrcBuUhG8W5AwQQOdoaV9eZ?=
 =?us-ascii?Q?CRD3uLONBQkReZNE9WT4TGXZDRaLWDxsUbcobHD+SfY/kQtXfLQvm8c1GDF+?=
 =?us-ascii?Q?hgf3Wsg82zAki17T7PMJzILuiJCgflQL1NdrGNvpyz4jMJNIwk471K2gzuwq?=
 =?us-ascii?Q?RcsNVSYraw8w+QWkd413vdgItJev1kh2UA1zw//cK5SIPCu8A1APxrHIUm67?=
 =?us-ascii?Q?qVZliS8aF2096LzjdWOwnqvYw0PhHua546KI+eFy+7LGQzuRWHMzcv9AANeQ?=
 =?us-ascii?Q?KoQPPBrh3CrPqNQ4cQmnAFhQRV55ldnhrLRDQk1sbZwhYjnPIRTCVkyPOEI9?=
 =?us-ascii?Q?rRlamTNs8MhaYW21KEr6mH6WvvGjZurhzg32oCAH9xxyZOQW2rLj03DRjNLh?=
 =?us-ascii?Q?TUQAqzX63hCjWSoxR1yqxiggpTSTNTQEWiHnZSrf/efYWYzzhXXRjKeoFbgK?=
 =?us-ascii?Q?mxaAQf96KUfldttBvGCVRDClRNuYKPq5EXyF7l7lkQ1fpL1vjUazPNCm630O?=
 =?us-ascii?Q?q8vNqZGp471VB7d3P/OWAiLF5bxcY5oOitJilbG64TAgcDtQ1EECfuBcDLoE?=
 =?us-ascii?Q?tFfXqZdKOt+YwYWtscgBySlb7odRE2ofoURcR+AHmkHGQxfk9GjFZsx2H+X9?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daebd56-0698-4ef5-8abb-08dcb7699a95
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 05:18:57.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9iYhznJJ4sYH50hqRrTX4XQDZNgKUuuxmdBLQf/qTN426CdaxANDhqj/0XMx1Hm7Re02fqcCe4LCgTFr/9WSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com


hi, JP Kobryn and Paul E. McKenney,

we don't see commit with same title in later dev.2024.07*** or dev.2024.08***
branches in https://github.com/paulmckrcu/linux, so not sure if this report is
still useful.

another thing is the issue is random. just FYI.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
  vm-snb/rcutorture/debian-12-x86_64-20240206.cgz/x86_64-randconfig-003-20240730/clang-18/300s/cpuhotplug/srcu

commit:
  1815b92627178 ("workqueue: Add check for clocks going backwards to wq_worker_tick()")
  8a4c716cfcb96 ("srcu: Make SRCU GP sequence number wrap")

1815b926271780c9 8a4c716cfcb9602e0baedfced5f
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :100          9%           9:100   dmesg.RIP:do_rtws_sync[rcutorture]
           :100          9%           9:100   dmesg.WARNING:at_kernel/rcu/rcutorture.c:#do_rtws_sync[rcutorture]



Hello,

kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#do_rtws_sync[rcutorture]" on:

commit: 8a4c716cfcb9602e0baedfced5fa6d2c9169f421 ("srcu: Make SRCU GP sequence number wrap")
https://github.com/paulmckrcu/linux dev.2024.07.18b

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: srcu



compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408081016.9d43eb89-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240808/202408081016.9d43eb89-lkp@intel.com


[   27.636859][  T515] ------------[ cut here ]------------
[   27.636869][  T515] do_rtws_sync: Cookie check 3 failed srcu_torture_synchronize_expedited+0x0/0x20 [rcutorture]() online 0-1.
[   27.636964][  T515] WARNING: CPU: 0 PID: 515 at kernel/rcu/rcutorture.c:1348 do_rtws_sync+0x1fc/0x240 [rcutorture]
[   27.636983][  T515] Modules linked in: rcutorture(+) torture ip_tables x_tables
[   27.636999][  T515] CPU: 0 PID: 515 Comm: rcu_torture_wri Tainted: G                T  6.10.0-rc5-00120-g8a4c716cfcb9 #1
[   27.637005][  T515] RIP: 0010:do_rtws_sync+0x1fc/0x240 [rcutorture]
[   27.637021][  T515] Code: ae c0 00 00 01 90 8b 0d 5a a1 d3 e3 48 c7 c7 ab 48 04 a0 48 c7 c6 74 29 04 a0 48 89 da 49 c7 c0 68 80 d6 83 e8 35 a3 04 e1 90 <0f> 0b 90 90 45 84 e4 0f 85 7b ff ff ff eb ac c6 05 74 c0 00 00 01
[   27.637026][  T515] RSP: 0000:ffffc9000170bde0 EFLAGS: 00010286
[   27.637031][  T515] RAX: 000000000000006a RBX: ffffffffa002d860 RCX: 0000000000000027
[   27.637035][  T515] RDX: 0000000000000007 RSI: ffff888143590680 RDI: ffff88842fbd6cc8
[   27.637039][  T515] RBP: ffffc9000170be18 R08: ffff888143590680 R09: 0000000000000001
[   27.637042][  T515] R10: 0000000000000009 R11: 0000000000000000 R12: 0000000000000000
[   27.637046][  T515] R13: 0000000000000001 R14: 0000000000000004 R15: 0000000000000001
[   27.637049][  T515] FS:  0000000000000000(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
[   27.637054][  T515] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.637058][  T515] CR2: 00007f1846cf4000 CR3: 00000001440fc000 CR4: 00000000000406b0
[   27.637065][  T515] Call Trace:
[   27.637068][  T515]  <TASK>
[   27.637073][  T515]  ? show_regs+0x5e/0x70
[   27.637108][  T515]  ? __warn+0xcb/0x220
[   27.637116][  T515]  ? do_rtws_sync+0x1fc/0x240 [rcutorture]
[   27.637135][  T515]  ? report_bug+0xc6/0x160
[   27.637977][  T515]  ? handle_bug+0x42/0x80
[   27.637985][  T515]  ? exc_invalid_op+0x1b/0x50
[   27.637993][  T515]  ? asm_exc_invalid_op+0x1b/0x20
[   27.638004][  T515]  ? __cfi_srcu_torture_synchronize_expedited+0x10/0x10 [rcutorture]
[   27.638030][  T515]  ? do_rtws_sync+0x1fc/0x240 [rcutorture]
[   27.638055][  T515]  rcu_torture_writer+0x8c3/0x1040 [rcutorture]
[   27.638071][  T515]  ? local_clock+0x15/0x20
[   27.638081][  T515]  ? lock_release+0x120/0x4b0
[   27.638087][  T515]  ? kthread+0x128/0x190
[   27.638102][  T515]  ? kthread+0xad/0x190
[   27.638108][  T515]  kthread+0x179/0x190
[   27.638112][  T515]  ? __cfi_rcu_torture_writer+0x10/0x10 [rcutorture]
[   27.638131][  T515]  ? __cfi_kthread+0x10/0x10
[   27.638137][  T515]  ret_from_fork+0x4a/0x60
[   27.638143][  T515]  ? __cfi_kthread+0x10/0x10
[   27.638150][  T515]  ret_from_fork_asm+0x11/0x20
[   27.638174][  T515]  </TASK>
[   27.638177][  T515] irq event stamp: 333
[   27.638180][  T515] hardirqs last  enabled at (339): [<ffffffff8110c3bf>] vprintk_emit+0x21f/0x2c0
[   27.638188][  T515] hardirqs last disabled at (344): [<ffffffff8110c2b3>] vprintk_emit+0x113/0x2c0
[   27.638195][  T515] softirqs last  enabled at (40): [<ffffffffa002af04>] rcu_torture_writer+0x264/0x1040 [rcutorture]
[   27.638212][  T515] softirqs last disabled at (38): [<ffffffffa002aeba>] rcu_torture_writer+0x21a/0x1040 [rcutorture]
[   27.638228][  T515] ---[ end trace 0000000000000000 ]---



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

