Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6791CB527
	for <rcu@vger.kernel.org>; Tue,  3 Sep 2024 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346204; cv=fail; b=H2ftf33dUfDR1tJj7ahJ8gXqk3ZmfLYruaL1pwOyRp8ipD1jbFy2mUMIoVMuzcr92y92W1taQ5K/xwRFRQERe/jncw73d2FT949eoxHRBvaTPKzcGIToY2FevUOaiGmc+iFe6ZnNhrOMt5ttmhl0us/4cYXPOS+mHBrIc3GsSWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346204; c=relaxed/simple;
	bh=gize9TQulIhFoeKPM8Xz7oNoOojvm82DILaiT02Qws8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=imIKsStrqENnLGZz2hEU6DdbfzYlDdBI//aA0UXZnzCw3cwfqzfWqldUa1lizXiTQBvj4IxS/kD8dvSVo0RYgpKvhMPxY9k7pT/UWDtjV6B8vKGPhhTd6vvPmcXIWYeioVtjT05LzFahTz74mhLHVdFYCFW0ml8VXfDkVZ/dN8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3mp9QGY; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3mp9QGY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725346202; x=1756882202;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gize9TQulIhFoeKPM8Xz7oNoOojvm82DILaiT02Qws8=;
  b=h3mp9QGY1HTXop6aCRFFXy62Qn49S1seGQfYxPwAK1066p2I6cYwfmdP
   ThQ1G/zsYywTLzT1EDt9PakV1gzi9OFwYFxA15zbQnvo14//Rz0tzSt6x
   qk8/BHoh2LPjS9QpYnuwPqvgHLqnLALeJZFsOGXwPZ6B8xNmhiFzDIs1H
   Jp9J1LnyPlR3CKQKZLcBiYPnNFFpfJHsqTNDxneBAUVl51avOLqvUlq/D
   WV4aWxOtI7G0qJWmpG+j86F4A/u/1qpHS5emyL/PHalsL1e7NbRMGCX+q
   c/9hpEVUVi/HuAQblIhGuMHOAD3/mP4yYYEsH5Sp7re8CYYfq1v13rEib
   A==;
X-CSE-ConnectionGUID: oyiK4P2kQnuHuScxzHwQ7w==
X-CSE-MsgGUID: +jXHei+HQqepdphOUKQxYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35316373"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="35316373"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 23:50:02 -0700
X-CSE-ConnectionGUID: aE+wGLTUTsWBVF5BXwgntg==
X-CSE-MsgGUID: thr5BGWjQ9aOindfV9gH6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="65533155"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2024 23:50:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 23:50:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 23:50:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 23:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSBpDwYXZmCyKG78s+E+6bKN9JTPWsKzRIsL/L0qieGmYleqzzoKaK3LE54mhKeXxGVSzK4dI9oUROV6dcRB0Aikce8E0xZe3TW9XhCa48ID4HSkuL7U0EcoUFF+e6OI3OtOKFymXvrr3XYbtP32NteRoWhf0zWTU55TFYZ3MQndXcLuhX33N87FLk3d7lsNUj1qmAwPc5UHA0eRD1vw4uzgeXiDB5PncqhBdxR5HAPhrfg+11flyWC+UuPtwBgUEryiXqbob4pISNBjnPuWxpz1hDbS3mliZHrZ8Xo/z2w2r6zVtIw8uP8FrvYjzM6MVx3fWnFzt87VIZW8IS9Q1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aqlkF+DTbYzStvKPf6Kku80UC8CqPAoAeJmrEHynm4=;
 b=qZRWU8OJEu/9IUy7ImpG34eeQJUa61GSnh2yni8ihSI40XEmBkjm2nzHzsZmqcK4vc/Ixj1aszTG6NXtdfQ/L1fm0pg1H/YoZ3AL3Z/uRSZbJpceCAJuBeRzkYcONCAQcqAOAD0lgkSuTto7cArlRCfhAhhBsaziRjZUkIfkHqAwt5BOe5+l4YpAnXwA+ie6DjsU8kCGRbVUW5HCBS405fFJWdmxcfBlmLrLRjAa9QqUBG8mQdaPYw3psuOgE2hZIHDbyutQHGZ6mcg6BS8juNL3aHlK7MBnqzmoPA7tCfkih2nNTo8NL5JLSWCM63L4/Hx0DPYv6uykzXt1jrDN4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6952.namprd11.prod.outlook.com (2603:10b6:510:224::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 06:49:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 06:49:58 +0000
Date: Tue, 3 Sep 2024 14:49:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>,
	<rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2024.08.30b] [srcu]  558049054f:
 BUG:using__this_cpu_read()in_preemptible
Message-ID: <202409031433.5ce7c1e3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c20bf7-6320-400b-fb60-08dccbe4a035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wu/g2Un2AM4M06Til4oFzVBO8xZ4GJCznWjoTffWkq1REr//CJDPrW+WZ8bX?=
 =?us-ascii?Q?kiFmXybMXhp9PujTuWlEWNIdwslZObZ/BRjlZhwCxpBjDClP6IgB28e0XLYD?=
 =?us-ascii?Q?DyvryhOH73+Nt94kMD9YAc4AhAiEkUrr8FfLeXw59L7VY2h3JkI2MjMrDGLx?=
 =?us-ascii?Q?9E3boJzsvAGjNA0TZKVXL6OkyXiyus1+DMOveKH367utJswJKdaSepTq3aJH?=
 =?us-ascii?Q?wzYrIKGyh+BbE0DVamJ4y19qfjv/C0hHj+0Rxm+ztz6aicdMgPRaQWCGlO6c?=
 =?us-ascii?Q?SLh8+k5j6gnntlUE+lCvquruuMFtXpoMIQt9NKw6/KvsaQ0j+8x3ebhBOu/H?=
 =?us-ascii?Q?NeCGw/ced2lw2H2PCnP68bBAg944uH6AoH+ox5sjPsE81+J+x/+7ZEn/J7q5?=
 =?us-ascii?Q?onzap8ts3nm8/bh1jQh5QSXBjOwTfm+FiEeTLXndTPEoLFA4GJtyHt6qIYq+?=
 =?us-ascii?Q?Nd5DOBAUDRZJb8FcwVeyhTiedFwFBenjCQkzcbRKEUVfEuj+veGKDQjUWKbw?=
 =?us-ascii?Q?b8jF0cF7lS7Ei7HQw96ipYLzUwgUyWS/ElFKxaKNoWJ2J/iZMIliUK7rq1/9?=
 =?us-ascii?Q?odUx9F1nNK6DZ/yiUXC0jBkSBG5b6ID0mvI/QiRFSUmgQgXEp9QHxWlOqULb?=
 =?us-ascii?Q?4ZD95a1heqscL0Xf6KU5f4Op4tDZ+f0t7FUx5Fm/59Yl920RwCuzdZAWc/9b?=
 =?us-ascii?Q?I1VGOo1x+wGTUfEbdQqEOyhmJYU2b3nHsXc77aNXhw2RwxVxLME5JGQJvhb5?=
 =?us-ascii?Q?uRKKUfYNc8ATDcxZizcRE+AXoSj+I3MpUFwzk2ZDAt+XCOzJa1TWxfP0rcy6?=
 =?us-ascii?Q?GNvjNhmlAZA05WX1zvTqRYLyAeHN74dBa3CThN7u/xrzA+LwzuV+XhkJ9PlE?=
 =?us-ascii?Q?NkccHGq7MUq7VH71aq4aaj2pYqZhuvS0UFb1p7L0HypA38VccVXTJYB/TNYI?=
 =?us-ascii?Q?kbUGBHx1Y1wL1hY8zQVCdo22SnnpSO0kQMIr/+bHv9SCgJHf1h7lsx5OX3b4?=
 =?us-ascii?Q?JWWAOdB6cQcVtcEjLTLW2tz3B4vF9dntBHLUSiQD+Cnu+HUEiz4CYa4H23Hq?=
 =?us-ascii?Q?IY3aGlj6Kac97J5uRpU98KGFTJzVsG+5BB20dpzkxZnupiyErNSxa1/Ti/6u?=
 =?us-ascii?Q?gpmsCDFa+g18eEisqwpZMAjaKAHLLgXZV7rWTkYXDD60kzCz1b05hD1+mshm?=
 =?us-ascii?Q?ZtwW2AS3wyt1TjTcA5KnIdNeevB0HpcIuKQNRofH1YGqmBYvSzIe4lWNjXMD?=
 =?us-ascii?Q?SkqBifM9AUUZ2uBXcjhNzPg4rp0zYNLK768+A9eNaPmaV5Ps9UJuRXYT/Swf?=
 =?us-ascii?Q?ZD4m77ZfG2zqDqOtIP0IBQWT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7GOSlKGwnbXzD+2BN9eL6rxIksOMTnSf//NU0zQ8YR7HfGW6sc2NWfRxkRg9?=
 =?us-ascii?Q?9mv4ii+scC2JA7MWJ3I1pw/vY23o5G3E0BrjE82qgu7KpH+/PoSsJ/+clqEL?=
 =?us-ascii?Q?9MwXeTHggzx6yb0GBgRuwNdUSO7NO9wBLFhzkQi5iantEGvWhagtYtNjfrUm?=
 =?us-ascii?Q?UZxZ7HTsIQ5QworR5zjeeeHGNmTUDAGKJKcENIYXt46JGK4qyUHfHmSXjYr7?=
 =?us-ascii?Q?nu3VFJT8Mk86LEFRswk451cCQIfQbd3CxQfLjPsj1eFWDg+VZ6BpHQvbZzQG?=
 =?us-ascii?Q?LBYn4H0UC3J9Wkfaj2vcv+6JiCa+FUUheE6N2P0U/6Cgl5EyenSW3JBGzeBM?=
 =?us-ascii?Q?lfyzx5uJQaurpm9pqq/5wVlg3bpX5usDiDbe+AF/UWxk/IiaTOSLRk7i6WTJ?=
 =?us-ascii?Q?lrWg8BBDg6LSuzEKUpcOPc/SQ7kAu57aCSBEt2mfvltiUmsh+duzqkQ1nt2I?=
 =?us-ascii?Q?ClXX2zFBkPpALnz3tBbxAHGaGM9CFEBtMvElsGfY5N8xe2U3rUbdifZv/d5n?=
 =?us-ascii?Q?eUJNlGjCK5QFhHSsLu76FLs8D0rKGulPBz+fbUwmzSGOvHYfdUYkOtpYpJ/V?=
 =?us-ascii?Q?yTwyqIa1tQNkAJ3xEyPXaKk5Mky24kW2/Wl0ssLXGa+AESWW29KWS3/CzW9S?=
 =?us-ascii?Q?tBCbBTpauR8wi7iQBlRz6Te0SiZcclJYS6fpZzcDu5LSD7ZCM9PAcbgdMzy0?=
 =?us-ascii?Q?lBkBK3cCCPTYk4bil+BTd3L/Sp6/eEL25wuwWkuaQbZAGax6372RzmUNhLJU?=
 =?us-ascii?Q?3Su+KhkCmwqIuU+1brEJjGcCcD3qtybCj4XyNHUc+7HoC5wflmgfjANpaCWB?=
 =?us-ascii?Q?S2RlJlKvXXkTXN+XrmaGLuwVehifik10W/kRdeVg0dX490Mr99MZXLGmYk2+?=
 =?us-ascii?Q?1+mLF6kWoIAxVC8w95IE1Y5Xxr/LuuNMYseEm4Uct0uYTvJ1x0JzMaghgI69?=
 =?us-ascii?Q?hdjUe/XBzhCRJTsBd2fwCron/RKF20K/N9lPrLWwdcqYQU8Cj7Om1ru43ucP?=
 =?us-ascii?Q?FJbPJpY8NpfMLOp11VANX2rdaUXrDkf00Nln3VHMQEDRUTPd59rD1R2MJIyd?=
 =?us-ascii?Q?vVLNH0RW4aTeAXq2Kjnq5ly0lCSKwdXj67l4u6FThkJ4uDMPCnAX2PIjpdRm?=
 =?us-ascii?Q?sb+ljxVlqjuCvV1BH0T6tdWf4ZYU8PjoHwMyidR/QJLKRjY1id52JJlE0kyX?=
 =?us-ascii?Q?6U308aOl0gx3870aOtvLfBo1uxMlmEZDedTW3AOYkQp3TCMRTMLUtvFYDXDD?=
 =?us-ascii?Q?TEoKj8lCZycd+j97KSRBC7IyWt1mnjXTjcbLejJ9ws5pxlKK9gMlEaGC1lc/?=
 =?us-ascii?Q?TktELAlN5BtMsqHAD2ogpLTZXlYqmlBaaOIUSrq76ciExL0hk0kMhFbSR6Ni?=
 =?us-ascii?Q?BX2rTYF3zVLf6VPAUvAiyufB0OxbHEVaFWcJHCCeiSByED2GWRzEei/3zzir?=
 =?us-ascii?Q?z+sB2w/07nHr81GfibuNRoG0eJPX75RGmPENMfgrWLSwRaZTeYYRVLwfZ9iL?=
 =?us-ascii?Q?ZRxMMrkQfQSGimeY9zx1exyYCkrpG7fTAVLJHZjMSsP6W+XHwWIpz61F3p9O?=
 =?us-ascii?Q?6nnmQoQ/OcaowjR0EyDiRa+aOdVry4ajBMgIKTcqDCvZoNhGnQSXPVlACjBi?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c20bf7-6320-400b-fb60-08dccbe4a035
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 06:49:58.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfUT8utESOYmh6hxPaLorqBhWP57VQw9gbD8ZZ4oTLqRimY+QAAOsmReYsqypLj0UGOrLmaUt6DJjbIbN9+hPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6952
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:using__this_cpu_read()in_preemptible" on:

commit: 558049054fe90985d650a50b6a757943a9faf646 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
https://github.com/paulmckrcu/linux dev.2024.08.30b

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | ddf16dbef6 | 558049054f |
+------------------------------------------+------------+------------+
| BUG:using__this_cpu_read()in_preemptible | 0          | 12         |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409031433.5ce7c1e3-lkp@intel.com


[   10.417780][    T1] BUG: using __this_cpu_read() in preemptible [00000000] code: swapper/0/1
[ 10.419771][ T1] caller is synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
[   10.421326][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T  6.11.0-rc1-00131-g558049054fe9 #1 4f684c68116af3bbce89b0137924bdf81528bc94
[   10.421734][    T1] Tainted: [T]=RANDSTRUCT
[   10.421734][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   10.421734][    T1] Call Trace:
[   10.421734][    T1]  <TASK>
[ 10.421734][ T1] dump_stack_lvl (lib/dump_stack.c:122) 
[ 10.421734][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 lib/smp_processor_id.c:53) 
[ 10.421734][ T1] synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
[ 10.421734][ T1] kmem_cache_shrink (mm/slab_common.c:612) 
[ 10.421734][ T1] acpi_os_purge_cache (drivers/acpi/osl.c:1575) 
[ 10.421734][ T1] acpi_purge_cached_objects (drivers/acpi/acpica/utxface.c:238) 
[ 10.421734][ T1] acpi_initialize_objects (drivers/acpi/acpica/utxfinit.c:250) 
[ 10.421734][ T1] acpi_bus_init (drivers/acpi/bus.c:1365) 
[ 10.421734][ T1] ? acpi_sleep_proc_init (drivers/acpi/bus.c:1334) 
[ 10.421734][ T1] ? kobject_add (lib/kobject.c:374 lib/kobject.c:426) 
[ 10.421734][ T1] ? kset_create_and_add (lib/kobject.c:412) 
[ 10.421734][ T1] ? rcu_is_watching (include/linux/context_tracking.h:126 kernel/rcu/tree.c:737) 
[ 10.421734][ T1] acpi_init (drivers/acpi/bus.c:1450) 
[ 10.421734][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
[ 10.421734][ T1] ? rng_is_initialized (drivers/char/random.c:934) 
[ 10.421734][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
[ 10.421734][ T1] do_one_initcall (init/main.c:1267) 
[ 10.421734][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1258) 
[ 10.421734][ T1] ? parameq (kernel/params.c:168) 
[ 10.421734][ T1] ? __kmalloc_noprof (include/trace/events/kmem.h:54 mm/slub.c:4159 mm/slub.c:4170) 
[ 10.421734][ T1] do_initcalls (init/main.c:1328 init/main.c:1345) 
[ 10.421734][ T1] ? rdinit_setup (init/main.c:1313) 
[ 10.421734][ T1] kernel_init_freeable (init/main.c:1582) 
[ 10.421734][ T1] ? rest_init (init/main.c:1465) 
[ 10.421734][ T1] kernel_init (init/main.c:1469) 
[ 10.421734][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
[ 10.421734][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 10.421734][ T1] ? rest_init (init/main.c:1465) 
[ 10.421734][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   10.421734][    T1]  </TASK>
[   10.423389][    T1] BUG: using __this_cpu_read() in preemptible [00000000] code: swapper/0/1
[ 10.424780][ T1] caller is synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
[   10.426769][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T  6.11.0-rc1-00131-g558049054fe9 #1 4f684c68116af3bbce89b0137924bdf81528bc94
[   10.434768][    T1] Tainted: [T]=RANDSTRUCT
[   10.434768][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   10.438767][    T1] Call Trace:
[   10.438767][    T1]  <TASK>
[ 10.440770][ T1] dump_stack_lvl (lib/dump_stack.c:122) 
[ 10.440770][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 lib/smp_processor_id.c:53) 
[ 10.442769][ T1] synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
[ 10.444768][ T1] kmem_cache_shrink (mm/slab_common.c:612) 
[ 10.444768][ T1] acpi_os_purge_cache (drivers/acpi/osl.c:1575) 
[ 10.446766][ T1] acpi_purge_cached_objects (drivers/acpi/acpica/utxface.c:239) 
[ 10.448764][ T1] acpi_initialize_objects (drivers/acpi/acpica/utxfinit.c:250) 
[ 10.448764][ T1] acpi_bus_init (drivers/acpi/bus.c:1365) 
[ 10.450765][ T1] ? acpi_sleep_proc_init (drivers/acpi/bus.c:1334) 
[ 10.452766][ T1] ? kobject_add (lib/kobject.c:374 lib/kobject.c:426) 
[ 10.452766][ T1] ? kset_create_and_add (lib/kobject.c:412) 
[ 10.454764][ T1] ? rcu_is_watching (include/linux/context_tracking.h:126 kernel/rcu/tree.c:737) 
[ 10.456780][ T1] acpi_init (drivers/acpi/bus.c:1450) 
[ 10.456780][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
[ 10.458770][ T1] ? rng_is_initialized (drivers/char/random.c:934) 
[ 10.460769][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
[ 10.460769][ T1] do_one_initcall (init/main.c:1267) 
[ 10.462764][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1258) 
[ 10.464766][ T1] ? parameq (kernel/params.c:168) 
[ 10.464766][ T1] ? __kmalloc_noprof (include/trace/events/kmem.h:54 mm/slub.c:4159 mm/slub.c:4170) 
[ 10.466765][ T1] do_initcalls (init/main.c:1328 init/main.c:1345) 
[ 10.468763][ T1] ? rdinit_setup (init/main.c:1313) 
[ 10.468763][ T1] kernel_init_freeable (init/main.c:1582) 
[ 10.470762][ T1] ? rest_init (init/main.c:1465) 
[ 10.472766][ T1] kernel_init (init/main.c:1469) 
[ 10.472766][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
[ 10.474764][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 10.476765][ T1] ? rest_init (init/main.c:1465) 
[ 10.476765][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   10.478882][    T1]  </TASK>
[   10.481604][    T1] BUG: using __this_cpu_read() in preemptible [00000000] code: swapper/0/1
[ 10.482582][ T1] caller is synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
[   10.483326][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T  6.11.0-rc1-00131-g558049054fe9 #1 4f684c68116af3bbce89b0137924bdf81528bc94
[   10.483734][    T1] Tainted: [T]=RANDSTRUCT
[   10.483734][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   10.483734][    T1] Call Trace:
[   10.483734][    T1]  <TASK>
[ 10.483734][ T1] dump_stack_lvl (lib/dump_stack.c:122) 
[ 10.483734][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 lib/smp_processor_id.c:53) 
[ 10.483734][ T1] synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
[ 10.483734][ T1] kmem_cache_shrink (mm/slab_common.c:612) 
[ 10.483734][ T1] acpi_os_purge_cache (drivers/acpi/osl.c:1575) 
[ 10.483734][ T1] acpi_purge_cached_objects (drivers/acpi/acpica/utxface.c:240) 
[ 10.483734][ T1] acpi_initialize_objects (drivers/acpi/acpica/utxfinit.c:250) 
[ 10.483734][ T1] acpi_bus_init (drivers/acpi/bus.c:1365) 
[ 10.483734][ T1] ? acpi_sleep_proc_init (drivers/acpi/bus.c:1334) 
[ 10.483734][ T1] ? kobject_add (lib/kobject.c:374 lib/kobject.c:426) 
[ 10.483734][ T1] ? kset_create_and_add (lib/kobject.c:412) 
[ 10.483734][ T1] ? rcu_is_watching (include/linux/context_tracking.h:126 kernel/rcu/tree.c:737) 
[ 10.483734][ T1] acpi_init (drivers/acpi/bus.c:1450) 
[ 10.483734][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
[ 10.483734][ T1] ? rng_is_initialized (drivers/char/random.c:934) 
[ 10.483734][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
[ 10.483734][ T1] do_one_initcall (init/main.c:1267) 
[ 10.483734][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1258) 
[ 10.483734][ T1] ? parameq (kernel/params.c:168) 
[ 10.483734][ T1] ? __kmalloc_noprof (include/trace/events/kmem.h:54 mm/slub.c:4159 mm/slub.c:4170) 
[ 10.483734][ T1] do_initcalls (init/main.c:1328 init/main.c:1345) 
[ 10.483734][ T1] ? rdinit_setup (init/main.c:1313) 
[ 10.483734][ T1] kernel_init_freeable (init/main.c:1582) 
[ 10.483734][ T1] ? rest_init (init/main.c:1465) 
[ 10.483734][ T1] kernel_init (init/main.c:1469) 
[ 10.483734][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
[ 10.483734][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 10.483734][ T1] ? rest_init (init/main.c:1465) 
[ 10.483734][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   10.483734][    T1]  </TASK>
[   10.484500][    T1] BUG: using __this_cpu_read() in preemptible [00000000] code: swapper/0/1
[ 10.485594][ T1] caller is synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
[   10.486311][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T  6.11.0-rc1-00131-g558049054fe9 #1 4f684c68116af3bbce89b0137924bdf81528bc94
[   10.486734][    T1] Tainted: [T]=RANDSTRUCT
[   10.486734][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   10.486734][    T1] Call Trace:
[   10.486734][    T1]  <TASK>
[ 10.486734][ T1] dump_stack_lvl (lib/dump_stack.c:122) 
[ 10.486734][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 lib/smp_processor_id.c:53) 
[ 10.486734][ T1] synchronize_srcu (kernel/rcu/srcutree.c:1242 kernel/rcu/srcutree.c:1553) 
[ 10.486734][ T1] kmem_cache_shrink (mm/slab_common.c:612) 
[ 10.486734][ T1] acpi_os_purge_cache (drivers/acpi/osl.c:1575) 
[ 10.486734][ T1] acpi_purge_cached_objects (drivers/acpi/acpica/utxface.c:243) 
[ 10.486734][ T1] acpi_initialize_objects (drivers/acpi/acpica/utxfinit.c:250) 
[ 10.486734][ T1] acpi_bus_init (drivers/acpi/bus.c:1365) 
[ 10.486734][ T1] ? acpi_sleep_proc_init (drivers/acpi/bus.c:1334) 
[ 10.486734][ T1] ? kobject_add (lib/kobject.c:374 lib/kobject.c:426) 
[ 10.486734][ T1] ? kset_create_and_add (lib/kobject.c:412) 
[ 10.486734][ T1] ? rcu_is_watching (include/linux/context_tracking.h:126 kernel/rcu/tree.c:737) 
[ 10.486734][ T1] acpi_init (drivers/acpi/bus.c:1450) 
[ 10.486734][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
[ 10.486734][ T1] ? rng_is_initialized (drivers/char/random.c:934) 
[ 10.486734][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1435) 
[ 10.486734][ T1] do_one_initcall (init/main.c:1267) 
[ 10.486734][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1258) 
[ 10.486734][ T1] ? parameq (kernel/params.c:168) 
[ 10.486734][ T1] ? __kmalloc_noprof (include/trace/events/kmem.h:54 mm/slub.c:4159 mm/slub.c:4170) 
[ 10.486734][ T1] do_initcalls (init/main.c:1328 init/main.c:1345) 
[ 10.486734][ T1] ? rdinit_setup (init/main.c:1313) 
[ 10.486734][ T1] kernel_init_freeable (init/main.c:1582) 
[ 10.486734][ T1] ? rest_init (init/main.c:1465) 
[ 10.486734][ T1] kernel_init (init/main.c:1469) 
[ 10.486734][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
[ 10.486734][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 10.486734][ T1] ? rest_init (init/main.c:1465) 
[ 10.486734][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   10.486734][    T1]  </TASK>



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240903/202409031433.5ce7c1e3-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

