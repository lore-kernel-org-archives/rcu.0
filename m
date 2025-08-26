Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FFC217709;
	Tue, 26 Aug 2025 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198057; cv=fail; b=TG4LV/bGZIYlOpq4GSjZ7DBkOP1lr0EUoN+Lr/0hgUeRYuDMmB2TfY0qGpRHHv8MRpGEaBRmpwGqlXzIdzie6gmtX1mweWphHl8QuzfXxfx1j3u2jXcbZoYWF3jbyFsU/nr3YBHgqPask7NEChp6kgEiGySAMGqxrk3cGB6bmSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198057; c=relaxed/simple;
	bh=qG0M3joC68GYPCWbCP2wueCKV+EDy8WPJSd0r6M8d6Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=IYmYz4uuAsRsG0w9JwQtKd+LtqkVriaQuhnVj4wbYSR2CU/deeXbmL6gZWFku98faS83kBZhxB2Oghzw1ctT0/aa0wvtmgaAeVuomd5ooTlE7BcTS54XB1xOIM0izCH9uC2bNuSXPKb0vZ83UHG7EleRlqIP9uk7/hac/pVThZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TytSyAID; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TytSyAID"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756198056; x=1787734056;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qG0M3joC68GYPCWbCP2wueCKV+EDy8WPJSd0r6M8d6Y=;
  b=TytSyAIDi90S5ezyyfmOyxtlwYnVyKOpjAHD/6PTJuHTApEeuiudNOCO
   2VRicKIi+bKq6gceBytrTMNmXrZJyi6GJuqapJD72ukxZH9J73NsS/zz9
   6mLdVbKcldLf3fWjNex9QwrLqa7LFpjE/8zeuMLr4PKOUheYBiZleHHgr
   T8rhcx7IZiqTuLWQa+JCCL+MR/K9p4odfXdaC4p9YzAs3psTRijbti8iz
   xdYCbQTpewa5v1cPh8S0H0Go9vm31wYwN4JKTUOAkmIeMtYW/4JcZibVm
   8iDC+EYgw6/pNYGVSG/K+ym7IeLlDVu3uGDPNUDQqSpR8u6aGi47yGAK5
   w==;
X-CSE-ConnectionGUID: A+tRUPkoSXOrNGMxh1fnKw==
X-CSE-MsgGUID: 6V8WFjizTbiAh1B5kY3Wyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62255439"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62255439"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 01:47:35 -0700
X-CSE-ConnectionGUID: ovRpYbeFRfOpWi/89gkJDw==
X-CSE-MsgGUID: kXi6kWo0TDeCes32rotAqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="174786251"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 01:47:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 01:47:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 01:47:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.80)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 01:47:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkbkSzdi7vADAErZIcB0oI17wK3HuF9OKjtFDpCMASNhQ87jIpoF1J9WX3iEJ27rcPlcfEugGuZlz/UllqX4qDUH1rJRyyp4QiD7mitr58ytapK/0vioCTnHg7y7gR1xhiUZlU7GWyDQSQbFE4ZhRQZzf3zUXy2X3X7vf+NFV3UDvIOeuGvP7WJG+g23eZot9gBbc85ZLrJxj5b7O9KrgvjuEM9nsWUxMEDe8ap9g5IWjVhm4msKHwNcxDmtxc4CMh1vxKEL6fgbyZXMGTc5BJkw1gHtuEPZkpbm65C0OlZd4cc5PltN/T57r7dKJpIHmX//awkQbts9Knw3YHyLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgD8NyM6LolVOzrfsYAlcLnlJ2T67XQSD20zII/p9pQ=;
 b=AvU9rkuBkc/M3RgVj47kAicf4kWu3n0dXq5FLk8Qmqanylvol1e5Mv1Hsi7U4LwmqZfam6P5WUr+Q/Qz+/Xpn1Sag/c6bLUgO3UlQ2BMr1dXaVnnPWVCI4ex6y+m8pD7DRrrgjOj8prisXL0tfGg5R+R0krTK/WpW5+du65eUCB6dJzLTuXLQlv46duyRv6N7y5T9tPqQuZzVIzfU8Xw+/Ok/xHlMjNosnK77IA52g868BweHvD78CzpBdo220NZAdIe4RXyafvs7g2VQ20/80HDjsJ+SH0SHZF9fTyg2+GXfqiuCUmmKREjQ4ZCdkSc5RXju1vRqk8zzC3xeJ29BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB7758.namprd11.prod.outlook.com (2603:10b6:8:101::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 08:47:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 08:47:32 +0000
Date: Tue, 26 Aug 2025 16:47:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrii Nakryiko
	<andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, <rcu@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2025.08.21a] [rcu]  8bd9383727:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <202508261642.b15eefbb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d831cb1-10c0-4496-ef44-08dde47d321d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rtRJIF3/WZrkCpzuabBEPY56WLwxfHx2Dl69dXVrr0j9OSPJwD+/+e1gg3zM?=
 =?us-ascii?Q?o+8Wkc0nLZufFq1cHc4vZEj9oI/DlZNzWAeal3QG3TOXtOT145PthxrnzbaA?=
 =?us-ascii?Q?Bo6DL39KPcVcLmxKhhCFFBIu3pr3asCWwPFDXRPRdIlVYcIIM3p7axKxrTv7?=
 =?us-ascii?Q?cB2rB1UWs2k+N9irBgJeBoM6lOJJPI3xU39lxhEm/Z3Y+4tDm/t1piTJf+4W?=
 =?us-ascii?Q?4Nnlh1DU7dWljni8qU6R9ker9In2Oqzmd2rUOk01OE4nlncFalfDTXZATv9J?=
 =?us-ascii?Q?sKyhYGd2hpFH2+9nphVAhdgH/fRHemPuqS7UpgJ/na/cH7CksHXTho84tgtH?=
 =?us-ascii?Q?5VBENrfra65N6RNHkxxXDN1AlF5ijSknbfNEUpBRx6KtPFvPPv58qMHx/Tst?=
 =?us-ascii?Q?t3Y1MAL4cSQXvk61NqwCbEv9L+jsgXuD73VoCOHTdo+F+GJ1BsB3C3usOQs7?=
 =?us-ascii?Q?cAEn8Sl2QQivyL1wTf58bAwdlwcBBCV8Qd5kI6VEm0IvizCDXL1cGx3EHbjm?=
 =?us-ascii?Q?ovmssK1bP1HLwb7JHLKrZAJ5FcFTPGL4smQWJQNZ7A2HaRf1+COfYemgQosj?=
 =?us-ascii?Q?VRAUQ5oJ8n8g92cbzwk6E2uRh01AESGsuWpNXO2zKLYvrzVjLkcZ3oKHQ0pN?=
 =?us-ascii?Q?PPzELd1Dk0o2cZYMbbY2gCRvoIL3ZDk04ju1Uc1Rp3omYJZHzR6YtEkgp+Su?=
 =?us-ascii?Q?6QxLw9yPd9Qdvba2eOJNN7Uv9q3l6jbyrPKdHLa3fSOqecOSEj8MXy5NPHZa?=
 =?us-ascii?Q?A4KylLVNaMySVwhscPbUSwIvJWkxF/aOx82EyHrPmbT8XMndy884jSmxKFjm?=
 =?us-ascii?Q?vhPyJH2y0M175q2md5zSeWv20Api/+ypM2s0zbavY1z2j+h3ZW4dI6+kASvp?=
 =?us-ascii?Q?TEzRUemGoI+AApFchYZ61Q4OKjzJ0aAQYbOCaJWRd5AXl2PwWmY4dtPAhcOW?=
 =?us-ascii?Q?ETSwy+sXdUTiuAvM4MpjrDOsQEFM1CrhEVA0tPXMvAJ6Yzrw8uzbBGuSwEL/?=
 =?us-ascii?Q?o2PLF/r47vu/b7IHHqltumKI/q1pTOTMfk3Pc1muwPmqXzYabknm4PtZJ4RS?=
 =?us-ascii?Q?Qp7N7KUEcgVYAa8LupeautTSjomp6CpNzbKluo0YCKytWzy86VQ7roni8j1N?=
 =?us-ascii?Q?LLuj7uxZaeTFy5Ok5bVap9555gbT1h1MzCEVY2LyEc3+7wk6el447/078hRz?=
 =?us-ascii?Q?bk9z0L5h4TMCxAL6gp+wuxlo8dU4oLdRy64iWHKkF5+/5UPEUZWUpsasRSsK?=
 =?us-ascii?Q?+J75HIfFhyQHWlmdoDm1UNl1EkX+KcH80hRpaJ+T0EhFnJGf+/0/yidca2G5?=
 =?us-ascii?Q?Q5fIndjDSwV9rdEJGRCR4IjaUWJhY2TCNGCfrESnC2FcwK3nc4Y9lugJkAn9?=
 =?us-ascii?Q?wRIjxm70JBZ8HfFSO1Mt51VJD0d4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9kIcvjhR4yXK7JQOsIO2ocdfvjRXSh6w9K+bN3e50vFgpXbAS4PQoCzqfzuZ?=
 =?us-ascii?Q?a6p+I54ahaJkhVF2r9B0NO8ecmev9C/iPZmaIMB5mC/lEDJhOrqUWh0bpld8?=
 =?us-ascii?Q?zCypsebGr/wFsacGkHNC2Y4ct1z62+oFA24t1j9JorNF2Fxopv0EcAsk7Y0q?=
 =?us-ascii?Q?9KiQYdwVMZzkft2Bb4C8q59de7AUK+vSShcr82NNHzyDHEUZomSxFqaruKhB?=
 =?us-ascii?Q?ilI0ABC8dDkADbg7FI5q8JCdvsOe5V6RvH3usOUP3S7ohsiMurqlHFS3tf3i?=
 =?us-ascii?Q?x323n2JKAPTsElQneoOKEoekc2pUTouqeuVWVEWeFkC2ZK5L5He2/s04eqOf?=
 =?us-ascii?Q?Nm2lmKfPy7h4q3Qg23BK4UUF0o5wRaD5HprbVYN/f/Z7qJC1+fMrQocUm8EY?=
 =?us-ascii?Q?uT1+CHMjY1UaTXs/bv4hWaciJyLELBNRXy629MS5z3a+o27VjQjiJX7BJaDI?=
 =?us-ascii?Q?qyRc2E5DLArBvcxbLvk6eh9QXrxQP0nJ4+I8xki1rHZBJimsQ+J0DddRc8W7?=
 =?us-ascii?Q?xSLHRVmSmqd+xVrRjMOp0X+EnKc77fP3UXOw7appPoJackKXWXK498/gy3qZ?=
 =?us-ascii?Q?VXszRm6/xTRiA+78gjdjH2W884lGNcPWwKsGNn60BKRkJ9QayaCAnstacqgL?=
 =?us-ascii?Q?qucIEhQ1UM/hVhZ2otnLv2q6IAW8ptjPiYiCUUHuUlgS/Nf4oYuvXwsGZWcR?=
 =?us-ascii?Q?kMtykils1wQjjA83seQPKJcpiu/7B1YKx+oaCKgc3uX6gIHoTHqTnGFnuAjL?=
 =?us-ascii?Q?rfhRtmnQyxVhafWgUQ7IFeZJoNE2moZMw5RDi8B/RHOTiuBIjHs5qM0vV48/?=
 =?us-ascii?Q?vyquYmmSxuZtI4wYbLIiYc8m9hWEKmlHMRolXOtM7f3F2gELqkHVQp5CyqHj?=
 =?us-ascii?Q?I+/uVhnWOncShr0fAlAvoUDcK+1+c3D49k9C6oQ8nUJNZUkkWBa8xJ21NRJV?=
 =?us-ascii?Q?bp15Hc3HjW4BAtqFZXARcg2iIqLF9fDi1VWGbV/s/NTTydbw4NvpAUM+hWxB?=
 =?us-ascii?Q?DU8yU0H2MWnCKCszFVYIcQsdl/xZfDkTKds+xTf5X/c3cNSqlg/4+zDrEJXP?=
 =?us-ascii?Q?r5USh052Jo8JNlk/PwOYP/so8HowcVFzR9zJPKJ+TQ3kAuXIF+bLm7BQMb/G?=
 =?us-ascii?Q?3BfzXmoUQhuA8WcIcNYkiZa1TZzrLUyOCTPjDl8kquZxINYH4Y+O8m71Bjl+?=
 =?us-ascii?Q?bk2YEDzpo2vlu8dkqzMhr91CkE9tSzSlvM5PQ9QLrzoD/qs9j+cxShBpikpG?=
 =?us-ascii?Q?0R50OK5B8LLiDfjPrDisLejRhgfb+1TJt6niiMjmdqMPPec7u/wwl18xpWS1?=
 =?us-ascii?Q?NvnsDwatJJXcoOC/dLFzURK3eRIxova606ijqmAaYP+QIxh4KvLnqTKFJe2X?=
 =?us-ascii?Q?rBFXxSGdIIkdBr1IAQwwIoNDkMX2zzuyUExym9pPZph42F/rKoBitddmgEu9?=
 =?us-ascii?Q?BHK/bNYd+e9hL72y5a1wnlLTFZ1NVxP0oZDwPZBm4sh5Xx3fVCALYzVltcn8?=
 =?us-ascii?Q?PkDrUJ+9KqC0w9udTaBIIBCT7TvZqB85lyiKZsoyClMVTi1oW5wvYZZ/JAtE?=
 =?us-ascii?Q?jQ416wzqqumKgitefA46hIf1GsQoj8pSXwgu74mQ9mI6fOCvxXRh0QFt5iPZ?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d831cb1-10c0-4496-ef44-08dde47d321d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 08:47:32.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eyf4vNJYj630boyqc8pOzwzg6it5T2nbOgMcJuCujkhPxvbnUnFa1VbQrMcl1SL4xlb5MYhPmerX1BYD79kgJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7758
X-OriginatorOrg: intel.com


hi, Paul,

the similar issue still exists on this dev.2025.08.21a branch.
again, if the issue is already fixed on later branches, please just ignore.
thanks


Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: 8bd9383727068a5a18acfecefbdfa44a7d6bd838 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
https://github.com/paulmckrcu/linux dev.2025.08.21a

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: tasks-tracing



config: x86_64-randconfig-003-20250824
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508261642.b15eefbb-lkp@intel.com


[   42.365933][  T393] WARNING: possible circular locking dependency detected
[   42.366428][  T393] 6.17.0-rc1-00035-g8bd938372706 #1 Tainted: G                T
[   42.366985][  T393] ------------------------------------------------------
[   42.367490][  T393] rcu_torture_rea/393 is trying to acquire lock:
[ 42.367952][ T393] ffffffffad41dc88 (rcu_tasks_trace_srcu_struct.srcu_wq.lock){....}-{2:2}, at: swake_up_one (kernel/sched/swait.c:52 (discriminator 1)) 
[   42.368775][  T393]
[   42.368775][  T393] but task is already holding lock:
[ 42.369278][ T393] ffff88813d1ff2e8 (&p->pi_lock){-.-.}-{2:2}, at: rcutorture_one_extend (kernel/rcu/rcutorture.c:?) rcutorture 
[   42.370043][  T393]
[   42.370043][  T393] which lock already depends on the new lock.
[   42.370043][  T393]
[   42.370755][  T393]
[   42.370755][  T393] the existing dependency chain (in reverse order) is:
[   42.371388][  T393]
[   42.371388][  T393] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[ 42.371903][ T393] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
[ 42.372309][ T393] try_to_wake_up (include/linux/spinlock.h:557 (discriminator 1) kernel/sched/core.c:4216 (discriminator 1)) 
[ 42.372669][ T393] swake_up_locked (include/linux/list.h:111) 
[ 42.373029][ T393] swake_up_one (kernel/sched/swait.c:54 (discriminator 1)) 
[ 42.373380][ T393] tasks_tracing_torture_read_unlock (include/linux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (discriminator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutorture 
[ 42.373952][ T393] rcutorture_one_extend (kernel/rcu/rcutorture.c:2141) rcutorture 
[ 42.374452][ T393] rcu_torture_one_read_end (kernel/rcu/rcutorture.c:2357) rcutorture 
[ 42.374976][ T393] rcu_torture_one_read (kernel/rcu/rcutorture.c:?) rcutorture 
[ 42.375460][ T393] rcu_torture_reader (kernel/rcu/rcutorture.c:2443) rcutorture 
[ 42.375920][ T393] kthread (kernel/kthread.c:465) 
[ 42.376241][ T393] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 42.376603][ T393] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[   42.376973][  T393]
[   42.376973][  T393] -> #0 (rcu_tasks_trace_srcu_struct.srcu_wq.lock){....}-{2:2}:
[ 42.377657][ T393] __lock_acquire (kernel/locking/lockdep.c:3166) 
[ 42.378031][ T393] lock_acquire (kernel/locking/lockdep.c:5868) 
[ 42.378378][ T393] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
[ 42.378794][ T393] swake_up_one (kernel/sched/swait.c:52 (discriminator 1)) 
[ 42.379152][ T393] tasks_tracing_torture_read_unlock (include/linux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (discriminator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutorture 
[ 42.379714][ T393] rcutorture_one_extend (kernel/rcu/rcutorture.c:2141) rcutorture 
[ 42.380217][ T393] rcu_torture_one_read_end (kernel/rcu/rcutorture.c:2357) rcutorture 
[ 42.380731][ T393] rcu_torture_one_read (kernel/rcu/rcutorture.c:?) rcutorture 
[ 42.381220][ T393] rcu_torture_reader (kernel/rcu/rcutorture.c:2443) rcutorture 
[ 42.381714][ T393] kthread (kernel/kthread.c:465) 
[ 42.382060][ T393] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 42.382420][ T393] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[   42.382796][  T393]
[   42.382796][  T393] other info that might help us debug this:
[   42.382796][  T393]
[   42.383515][  T393]  Possible unsafe locking scenario:
[   42.383515][  T393]
[   42.384052][  T393]        CPU0                    CPU1
[   42.384428][  T393]        ----                    ----
[   42.384799][  T393]   lock(&p->pi_lock);
[   42.385083][  T393]                                lock(rcu_tasks_trace_srcu_struct.srcu_wq.lock);
[   42.385707][  T393]                                lock(&p->pi_lock);
[   42.386180][  T393]   lock(rcu_tasks_trace_srcu_struct.srcu_wq.lock);
[   42.386663][  T393]
[   42.386663][  T393]  *** DEADLOCK ***
[   42.386663][  T393]
[   42.387236][  T393] 1 lock held by rcu_torture_rea/393:
[ 42.387626][ T393] #0: ffff88813d1ff2e8 (&p->pi_lock){-.-.}-{2:2}, at: rcutorture_one_extend (kernel/rcu/rcutorture.c:?) rcutorture 
[   42.388419][  T393]
[   42.388419][  T393] stack backtrace:
[   42.388852][  T393] CPU: 0 UID: 0 PID: 393 Comm: rcu_torture_rea Tainted: G                T   6.17.0-rc1-00035-g8bd938372706 #1 PREEMPT(full)
[   42.389758][  T393] Tainted: [T]=RANDSTRUCT
[   42.390057][  T393] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   42.390786][  T393] Call Trace:
[   42.391020][  T393]  <TASK>
[ 42.391225][ T393] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 2)) 
[ 42.391544][ T393] print_circular_bug (kernel/locking/lockdep.c:2045) 
[ 42.391898][ T393] check_noncircular (kernel/locking/lockdep.c:?) 
[ 42.392242][ T393] __lock_acquire (kernel/locking/lockdep.c:3166) 
[ 42.392594][ T393] ? __schedule (kernel/sched/sched.h:1531 (discriminator 1) kernel/sched/core.c:6969 (discriminator 1)) 
[ 42.392930][ T393] ? lock_release (kernel/locking/lockdep.c:470 (discriminator 3)) 
[ 42.393272][ T393] ? swake_up_one (kernel/sched/swait.c:52 (discriminator 1)) 
[ 42.393610][ T393] lock_acquire (kernel/locking/lockdep.c:5868) 
[ 42.393930][ T393] ? swake_up_one (kernel/sched/swait.c:52 (discriminator 1)) 
[ 42.394264][ T393] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
[ 42.394640][ T393] ? swake_up_one (kernel/sched/swait.c:52 (discriminator 1)) 
[ 42.394969][ T393] swake_up_one (kernel/sched/swait.c:52 (discriminator 1)) 
[ 42.395281][ T393] tasks_tracing_torture_read_unlock (include/linux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (discriminator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutorture 
[ 42.395814][ T393] rcutorture_one_extend (kernel/rcu/rcutorture.c:2141) rcutorture 
[ 42.396276][ T393] rcu_torture_one_read_end (kernel/rcu/rcutorture.c:2357) rcutorture 
[ 42.396756][ T393] rcu_torture_one_read (kernel/rcu/rcutorture.c:?) rcutorture 
[ 42.397219][ T393] ? __cfi_rcu_torture_reader (kernel/rcu/rcutorture.c:2426) rcutorture 
[ 42.397690][ T393] rcu_torture_reader (kernel/rcu/rcutorture.c:2443) rcutorture 
[ 42.398126][ T393] ? __cfi_rcu_torture_timer (kernel/rcu/rcutorture.c:2405) rcutorture 
[ 42.398565][ T393] kthread (kernel/kthread.c:465) 
[ 42.398857][ T393] ? __cfi_kthread (kernel/kthread.c:412) 
[ 42.399169][ T393] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 42.399491][ T393] ? __cfi_kthread (kernel/kthread.c:412) 
[ 42.399815][ T393] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[   42.400151][  T393]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250826/202508261642.b15eefbb-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

