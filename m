Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E2918E20;
	Wed,  3 Sep 2025 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756865044; cv=fail; b=MeJ8wXILFiBHB3wykdxAuMuCMpNFFEAyMKGyezCud13M1wfcGvGJ51kdr1be3Gx6zZ6nCt1Xf8PhTGUQOIcGV1d8zJj+z3mbi4lYd3IUhEcgospc2LMhsGxmZ9etdjjhQCBaz6dalllGqtQxpsScBfA/edqyfC8WHZz+KisxcNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756865044; c=relaxed/simple;
	bh=gYHOyEn184IF7F199sQdPmXVMvo+fKyd5D0hmemhM/Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VQkhf9fiftQFitTGNhGdDjzsvWoWj1rLC7oKGlq49ZehfYhxSys5x196GaEIaBux8V2Q8z5YMmfjzExbOyXbrZmn46c+WPET5QVtNBUBMd1YT25m5KIqduKiuXNMFMaa1Zmsm+I0VEq4VXCIMSnrzby3yecnBgqjKq7btD+eDDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEWKptW+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEWKptW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756865042; x=1788401042;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gYHOyEn184IF7F199sQdPmXVMvo+fKyd5D0hmemhM/Y=;
  b=bEWKptW+hctXcrz1HiiyjjbmZ5/cCnAqBr12WvU02QkvTwWUPJv7Or29
   HU6ANy6njpH/H4sIpVsfA1UesGh4CxrD71ktaB/KvkhOYwtm9sFR2fxRz
   baY5S4lR78jIesfUljfzSonESLEfWedaqKBkc4mApOa7ZZGs6z/FfWcuV
   Om6ubhLHCaHcUcq1rQF069D96UjyNnDr9smr/q3T0AZzK0FWHqUD6SRZj
   VHPn/gWpFVH5lhDYfRi0Q0e6tf7IP8D5LkX63w2nb8jgTzJ1hFvBjGtYj
   6Mru60h0Lf3P4xbI3JMavNy9VKSO0ZPqZE2IS69/NisxxHLPZnDeJuuWD
   w==;
X-CSE-ConnectionGUID: L5XXpSBiTEOsvLTN5aFd2Q==
X-CSE-MsgGUID: Hrz9TnFRSQ6croBdO/quTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59279898"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="59279898"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:04:01 -0700
X-CSE-ConnectionGUID: TPl+6l6YTpaif3JLU6Srig==
X-CSE-MsgGUID: zEioZMiNR0y2Z1CqZFOBWg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:04:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:03:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:03:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.64)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:03:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3mrhbOHof7j8Tubs56Pe/BeCU9tMI4UXDxQ9CrGYsQu8Oc9B1KS/gJEagrqjNTUjtVJgeLpKsTQqvocwwHDlDJ/1G5T0nuLhsfLxntp9tccbtIJG2+ZtuRSy0L8n4ngFaxVPzJIvDzwxSOt7222VFlz1pswfi+Wj3vma1HCy6UfZrXETdOIATjZAFjLIBuVJXfqb8wUgxMiSOjaY9ZpvwMtrvomLQQgXmDyjVP5QQtiVLJwcUqBdSiOMzmUKKObuvbBSspLQtDJQ0WWG8rkkblj8BVE7O8cKwrFHyAPTSQBxd+dgToneivLj70O67SGrefu7CA9PlGEBvdCZADxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKvloJK5709IXLtXzXxfzYUqXNReYzHi4kw3RbUZxsA=;
 b=uSB3bwY+11N24sOuPL2a5Db+XI3ueYLQZRksMkw77ksn2ioXNCt7a50Lw2ElGpquLjS/BmH76Obf9eY5Qh5wcGUUHLHz2knzLjUl8BAhIrtYG3jBlt6cN/7sOB1KVfofeCRwYOJWejU6XsqoanRrt2V6T58dTTqhMUstiJKp4e+5YMiLOlJKo7ufTkoexn8q0L+mxPi7eM1pQ+xZw82zWB39rnqnffGSO0Q6GM1MDGi+WaTWaxhmaEzX/kgmnwriMzec+j1bxMN86AJRcI7iMPjx7N6MeI5zZtOphmjFr+5KZSmWwpmMb5650DHmLUJe9twmJ6AKNm/XXv67+HSXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5122.namprd11.prod.outlook.com (2603:10b6:303:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 02:03:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:03:57 +0000
Date: Wed, 3 Sep 2025 10:03:48 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrii Nakryiko
	<andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, <rcu@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [paulmckrcu:dev.2025.08.21a] [rcu]  8bd9383727:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <aLeiBGeUj5nHBlK1@xsang-OptiPlex-9020>
References: <202508261642.b15eefbb-lkp@intel.com>
 <2853a174-76e4-440b-bfc1-71ea30694822@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2853a174-76e4-440b-bfc1-71ea30694822@paulmck-laptop>
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: df70d4fc-0fdb-4b70-bb34-08ddea8e246a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ffYE3GC4NI/QPTQE6SQtpIUY/01JAN9WHn88SM52+BXqlSKnLuE2Ud8kDKC6?=
 =?us-ascii?Q?ey5dikZYnuDpFef5MRi3jziob4gniRVv72GUx+N9aDNWuiUvLjc9W03tszTO?=
 =?us-ascii?Q?WCBmuoU5bGQK5YCJmlhbxIV5Mppduu+fjc9f1oOw+gq6aAP9eiXDM2oIud7A?=
 =?us-ascii?Q?k10sGGo5Op+jfxIRSSumFx8FfHQ2t1yNzOsqYFXlz2eh35feiWE14NXEc8Dv?=
 =?us-ascii?Q?X3K8s9PVxQyBBE9k3xSVNpuDLNhu3kIH3dkw737sm8nuUvTB7P30qmREJgwX?=
 =?us-ascii?Q?/yja1R4ouAo7B7aT3CbKCsas3es0N1zHCGpVQeCmRU1ILLDRz9BLQoXEZH7c?=
 =?us-ascii?Q?9UJOAwWLmfTuIq7+H5SaQvIN7P7+Jaa4n4RfGCCZpFSRzQjdPpwjx5AoNuyy?=
 =?us-ascii?Q?fFEgKWW2RYcy9xZ5xzhsB45FzGfcdoRNyLVToB197+vB+/+4EYsS8HYBG5wS?=
 =?us-ascii?Q?IOUsP575BgsFuZB6z9TKyHZ9aLkZYG5JcuTZ7i2VhuAg0MkE+qmK1Ad0sGNi?=
 =?us-ascii?Q?xBAIz9rhkulCw4iSMUcjNA/5fUANAR+klYFuLvI8rkWSAOUvMffqAQY2kky8?=
 =?us-ascii?Q?zz+SwlpTtGM9I+kLPqnJKkC6Uv+9ATlu34QG7GZq8IVF3jbXTH0bc7gS45wk?=
 =?us-ascii?Q?bl49NSl0v1E0eBhmiIj8W+n68GhmVJbbmzsvXRkFdo63FaPQ8kWqdQyB3rve?=
 =?us-ascii?Q?S+6bPLp7eZf7/irsO0+/M2phVh6kmJtAZsdwLSwaykArVc1v7tYM9R+XKxZi?=
 =?us-ascii?Q?KYDW9fJ3Hu4oOtSuff/KRpyoZsXSPaowHM+EXpKuwlYHRqUoVI8j91cBBenj?=
 =?us-ascii?Q?CX4qeICR5bqlQeoQB53su+vMbF9PD+tmE/BsunH19gkaqvCEGFfwz4DW8gn/?=
 =?us-ascii?Q?ghnRceuiWvXM8sL19oe5iYTXGtNiG2kYCn/Rci8GQjWbafgtdVbxoMOCGXiD?=
 =?us-ascii?Q?5O39IuWFRQW+EFiu9oxh+ow1sySipCfrzzuoIPihFm5+xztuKsSFtLLagxcN?=
 =?us-ascii?Q?2kUlHNRddC2xrUaFE4uBhnoAlp47+NiZEO99Mx0kbP7ffvO38ZAwR35Sbkdz?=
 =?us-ascii?Q?AnIFtHgzm/5gKU37oZNGbFPgMXS20228KN66mOrvrWT1k4sq4mb/ps5yzMQQ?=
 =?us-ascii?Q?m6Ef15D7BPGPtgV9ZRFTJNK/xFm0uWFxDosrI4muI70qtxqo2zqE8frKOtUx?=
 =?us-ascii?Q?ZTyj467AOwU3QJo4FE/oH2k+ls+ASM36zHSMXqt4hyNIW5obweGzLHZLcO4a?=
 =?us-ascii?Q?3xv0cuFdRzK6g1QxTD6SNK9ufmZTzQDvyzVPIv2j5Xt3NnsSo7mJggtvZh6e?=
 =?us-ascii?Q?uSQf6GgiRUUyO09Zmfw8XVf+p8vE473JIdjn6RqhHIJIpFKw443XCk/4BXSh?=
 =?us-ascii?Q?3Ox84mG/FqAs49bSo+2oKDNjSSr5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iHxYPYPbwEvw4xk7TpmFegDXcp+cH5s3gNX86W7Em8mB7qBJug0wqsDXcinX?=
 =?us-ascii?Q?oXeZGDm/1+GrzRa+Hhyphog1bR9I7zT2ZlOyEB61dac4W6WqJwGK1fd+OIF2?=
 =?us-ascii?Q?3FvFEQArLrJUSJXunygfF4/AlpSGEk4sKpFkCRN0qXzRQPInO/MFWZNlpbOV?=
 =?us-ascii?Q?yhPYkPGr9OiRd8lmCfLIdZzE8a5GDiQxGlQABspsABBVJMC1kcos5RB1k12o?=
 =?us-ascii?Q?Rxjl7/p/OD3wXPiVPo1nvJdHXqEODfNKHQcfMbJ6Ird1Sm9ErTBmXz3QhizV?=
 =?us-ascii?Q?t6HlNqcIH5YYO60U7EkjEwYE2Laydzh08mGFyP5uZ/Ld/keyu5FUJ50RNxHy?=
 =?us-ascii?Q?IxrYFm2XUxoeACGJB4qRj64e9+V0M6WcYQUKSUqmBY/+ewucg2eS6wsHjbmQ?=
 =?us-ascii?Q?2H/l/z7L+p7vnP92bTkNu4pjGQJk0K7uPO0hVw+hId0S6cVJZmoLUpyD0YoR?=
 =?us-ascii?Q?cNWncD/7dI+X4Md77fRYH5wIR8CR7NdSwDMSPVHIeSZHL2lncNf+mUA0chYz?=
 =?us-ascii?Q?ldi7wotujcK+KnJaoZxzN5Z5kLe9IUSvycZrdp8PTb+sQ0aI1xn9Ykf2qqzW?=
 =?us-ascii?Q?hf4GC0dPb5m2oybJ7a38viSiYFqvwtrYKPE+rZJxEvFrE1PdaZnQnZ1n5s1Q?=
 =?us-ascii?Q?sGS4ejgxd/TowDsineZNqJNVl3Aoh4uc8erKjKlgPSvhJ+RWhpm5/4f6uaTb?=
 =?us-ascii?Q?ZfV/Bg6tOwJ5rLP4XGuasTOEC7sGcuFDD0ES9iM7C9D8EjiiaUhR7z3ovGrc?=
 =?us-ascii?Q?9QLzLxSL8WD0NQnL6ZkUPL8+wCFh2DWqjkeORnPDyXf1DnjvignoGYnks3ip?=
 =?us-ascii?Q?mQuIgbrvmVAib0JqK+MG0bQcHq1F6pyb+NDjp2f5ZzIfVZnzgjdtEarWc2Ul?=
 =?us-ascii?Q?B6PnZoi0MHMhmGxChWOdd3TuimNwUb49doRyE40+CwOxNsC80pyZ3zDlosYC?=
 =?us-ascii?Q?zpkBroKJx61aUnVdFZ5voN75mutHTuW7QogzhsNoLQYQcIMh1BV4IC0Ru8KW?=
 =?us-ascii?Q?47YmsxXK3ThD1jVx63W0mmkzvB0a8bX5KaW6ySmbobiWJtkAPiFDC43Y3jce?=
 =?us-ascii?Q?3zveinW72PQXZoeOg6n20j/1Ba58f5OHU7ovEohAi84a0ENtGnv8pyWCq+Se?=
 =?us-ascii?Q?ZJXylTUvrOpSXBltNalhCuMDkuOenYDO9La6IlMi2x+4TYHBjsti9zoXv4bs?=
 =?us-ascii?Q?34EjjpjpS/YEzBNhAgFzghU2PAy5dANNC+8Z7dh9RJh5+ku3+zqnB7Ti0AGa?=
 =?us-ascii?Q?aACm7j+Mgf+YxDRCWR9vAte1FWX8iMSmBercHqf7hE4vYb9LgkQsQ6J91Iip?=
 =?us-ascii?Q?ci/seREJrXbs1XBkqSmfY1HnD9k9aXC14LfGQCAJ2PRB0JFjyOAhBxYqWqjj?=
 =?us-ascii?Q?JWTG0zAjU9IprYQp7zL+4EyFmMC2damrVs0NVlNrPDwasvaJwyCepcjp+jy6?=
 =?us-ascii?Q?GkOAdvjjViQK6V91UWJUV+WeK8zKhtMPHKS6SI/VwgYWptWhivUsQWYuFYxc?=
 =?us-ascii?Q?uRaWRkjbs3pQCrS/Tf7aBq/beKE5aQjGw13j0yFxWTNhgDMPwD0qXWHtsd9O?=
 =?us-ascii?Q?R57bld1J7AcTO2C+zIu1D7mRa09kTXc9mUIbugQuFaU/oKOKkJZSjzaXXn/I?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df70d4fc-0fdb-4b70-bb34-08ddea8e246a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:03:57.5480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Soi2r1YyWWEZt0xy2hjMA43LQFa2DzGLLZ7o7Fsd429NHgEh5Dgor6jFVPO+xaiwX16A4K0Dea0o069OdUOKew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5122
X-OriginatorOrg: intel.com

hi, Paul,
On Fri, Aug 29, 2025 at 10:23:17AM -0700, Paul E. McKenney wrote:

[...]

> Again, apologies for being slow, and thank you for your testing efforts.
> 
> Idiot here forgot about Tiny SRCU, so please see the end of this email
> for an alleged fix.  Does it do the trick for you?

besides the patch [1] as in the end part of mail, we noticed you also have a
patch in [2]. I don't have enough knowledge to follow the dicussion between
you and Zqiang well. it just seems to me both patches are fixes which should
be squashed into original patch?

I made below applyment:

* e5ab29c09c470e squash! rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast   <--- patch in [2]
* f717bca99dfb15 1st fix patch for 8bd9383727 from Paul   <--- patch in [1]
* 8bd9383727068a rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast

by testing, the issue "WARNING:possible_circular_locking_dependency_detected"
cannot be reproduced on both f717bca99dfb15 and e5ab29c09c470e

sorry if I miss or misunderstood something, otherwise,

Tested-by: kernel test robot <oliver.sang@intel.com>


> 
> 							Thanx, Paul
> 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202508261642.b15eefbb-lkp@intel.com

[...]

> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250826/202508261642.b15eefbb-lkp@intel.com
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 

[1]

> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 6e9fe2ce1075d5..db63378f062051 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -106,7 +106,7 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
>  	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
>  	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
>  	preempt_enable();
> -	if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task())
> +	if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task() && !irqs_disabled())
>  		swake_up_one(&ssp->srcu_wq);
>  }
>  EXPORT_SYMBOL_GPL(__srcu_read_unlock);
> 

[2] https://lore.kernel.org/all/8f43f958-e3e6-44d5-9600-9e096c3a06b7@paulmck-laptop/
