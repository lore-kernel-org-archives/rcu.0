Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C70928642D;
	Mon, 25 Aug 2025 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105043; cv=fail; b=RPDopiyV/gXyeCZhbXLAd6uCzDeTcwTkjnPkjHYFdgEDS0sxPcyunyezM67qpulVixmXdp+o/0R5CfItGYtG7LYihp+zno7+yCN0Z1VCTbgi6FaApberPqnW91kv3jyXXFFy/veRWYWHdV/IOUDDvqRvk7eRV/OQkg0pyQOw7QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105043; c=relaxed/simple;
	bh=cfZAA2Brv64El9KTV4XfYzK8LE2xYFGS7Ubyj0gcddc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Ujq2JW8Q5Wmeuz0RPDhb3d2Zq3CoYzP2I4OFfc7vWygRagLmPTuj9HkJmm03Lzgqba5BX6rfuSb2r22x54SqyGwFt3gpkpE8AapIg6r+J04PCD6MGG3qUdRgU76KsFFUb9fGyR31sOOQDKWlaeyY92a4eH2Q+5ABIgkOdxRI+9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+NStQLu; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+NStQLu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756105040; x=1787641040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cfZAA2Brv64El9KTV4XfYzK8LE2xYFGS7Ubyj0gcddc=;
  b=H+NStQLuYl6Dxd+6IJSyXHGNrfmbW4ILyAKf5EszzcSOwxULt/oA3gxu
   cqqG3wHf/BuS/PIvEA/0pF7Ixj0ff4NZJhQbK+CkPnmKHVwutNkAGNTkC
   1MhEhPPKQZ8q/9Qz7FaXN19PZHh02v4fLGmH3mbjxu65v4idSpEoZlApt
   R1d3oXAVJmJUiJYzLv/u79ATD3JAOHOTdeSPmIId/sqBteF7kFOgPkhK0
   O2L8JhoGYBUyjKKym/3CMNyxnE7vGhBw0SABJZUR9gmCJQHLf8UCRkq/i
   VDFi6p17dvTZjdja/8F56h4RilVu4oIAzLumDnSZ4K4FjgIfn8Y7y+6B7
   g==;
X-CSE-ConnectionGUID: g3n7WGKVRDubZuyEIHvtkg==
X-CSE-MsgGUID: aFK325EbTeipos7cHYAlcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="75761530"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75761530"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 23:57:20 -0700
X-CSE-ConnectionGUID: zkrUOhmHRAerx3YpgMHzfw==
X-CSE-MsgGUID: ak/sKD8vQAOBDp8yznSq7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168720451"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 23:57:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 24 Aug 2025 23:57:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 24 Aug 2025 23:57:18 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 24 Aug 2025 23:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vml+AOYmPsCVt1Cr8VXlNzePl4LIr7zQ3zyJawFTgXYb3MBF8td8ivx1+V7paMSOBHbsoZWGxAYdnr01NOpwwU77nyYan45sHHEVYU4gcxZR/lnZZEOXQ9ncmwPgBlexhLmw34PFZuM/CqG8GMKu/XhrXnoiQv1hI3Ze7pTOKOHU6DbMkjENI44rJzwB/1Zvr1+Z42sO/BK6RZQ331OqT54Rqj4SM4w4M6i5kPHUhrHjSTCnPpqXeIhBRI69jOAAl+Bn5H3HBLfVa4wx1fr1rU6itg22EOmDjre7Oew/icr9u5wWcaXyi7nJwu/TYaA7i88Dh6hi3XsmqYGr4rX/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PNoaHEXpj9cZK7vAtJt6OKQqeyxXtZPS8MP4CSOLfc=;
 b=vriQ9c5U8KHBE1g8w10naOoa8SV5PTwMnMHkbChir433Zg1GKuYeeqQ+cPOjjY7xz6XYXDyKerJcMJ2jm+HufkgAG4FcuDy3EFNwNEJBetETfhfdyZ4SoCPI0WYgqhE6Yx9LKTGlh6e6cfmw+2raTR+hyMYGSmrb+qeLeMV4Jbxr5nAJw9KdXp4Os2V032Yp7YqOCqvaSLw/AwFZOPbaIl3rlcrkz4zF2oHs5+ySnGcLfnJjKE2+e6fEKNTAM6OzBD8Mw+0RnqUnMsqb6dk7xmX7Ta2iqYOxHHkNkBJ3zJJutJ1wYM8tBIvYZlkSosfJLYynF/EvYyc3bfGuHIYoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 25 Aug
 2025 06:57:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 06:57:15 +0000
Date: Mon, 25 Aug 2025 14:57:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrii Nakryiko
	<andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, <rcu@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2025.08.19a] [rcu]  fe37e4521b:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <202508251443.2337dadc-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd6655a-0e5c-4193-ba58-08dde3a49fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Um/q0W4GpS6JmqQqtV5QzluFMjEVJlGSx+FPevOBkk67cwOaMlftBCHtKi9k?=
 =?us-ascii?Q?Fr9q2xzlhKeVgQ+iZ98alZEdAlmj0Oj6ws7LjxXdfyCeiJb1S9Wcnqc22qa9?=
 =?us-ascii?Q?osf4IUjtNihCgyC86qLeh4zAK7lRMEtWlc4AcBSDsyW4JfMaTVLVCTsasiwM?=
 =?us-ascii?Q?NjhaDhFNi8RbNxiSgxFX9FiRDWhYjr5CxoEYwFLb33KrBWy6e82ppcnpWvN1?=
 =?us-ascii?Q?xmE+AfWlWdTy+/aDJXENXqJf7K2vDTB0gD2G71TkKpi8QSgkb12Sxa74aBXX?=
 =?us-ascii?Q?g4+iJeOUZnp2Cl/1ZYODzfuhnZOHCRbSska07lx1SOL7oYw/xXV41EqOiqU2?=
 =?us-ascii?Q?Q4OvnqL2M9Ub3NU2iaFkqN6XLbJsc15naMvGvpoorJfH82ODwipWiiVWkqmP?=
 =?us-ascii?Q?zkjUPaG0m+Nbm1st7NCn1ijmAJ8dCFqXL6d6FxBAwSVJpHxoSmuBAZMjoQ/H?=
 =?us-ascii?Q?agKjwiZL4Nxh5WwbxxtrVqHAYQrOO3BAwg+a8v6gBlOhE+dL4Dv+OVTsLa43?=
 =?us-ascii?Q?yZS8NqvygdKdutQTn1jeIcP2lZ3Hu8PIKI/rDejf4CNyE9A2eYhGY8qUOH5p?=
 =?us-ascii?Q?xp5dXBVwnhDldVvunqdYsvfW0FIfXFjwXoRPyCL2RDZZlTjqrnjMfTgErC4X?=
 =?us-ascii?Q?W637G/vQDofj5PN8lDDcC3/KSbKUZKkmXFPGZaWGzfo5kSw4tsAHAT8xngC/?=
 =?us-ascii?Q?TMBT28C8ABW+9x4CxuVgycVLtY4kuckvl28URmmeXIj5AfX64C41yvahq0sM?=
 =?us-ascii?Q?GSopDZBvY58Nzp7534Z0D3GA3GsV5cn89IB+DfivH1u0GP0yaUHYHF9RBns0?=
 =?us-ascii?Q?pi4QOjO2css50rbi7Z+q6W1kTD+zEKv8UYi7F1lGZQAMXEkPC18E/SMxb/h7?=
 =?us-ascii?Q?6DVEiOwd1xCPEVpHrbt4hx8mTmgskDBi6lPl4zHbTCFYJmRrcxVyXIFYZ4Tw?=
 =?us-ascii?Q?fKT4Ox6uIDBk338uO7yhG9phcmfD3yQm11Xu1aoKYLqWyH1/egvqmkUCs7of?=
 =?us-ascii?Q?szR1l3oNBqDOcsqBJIkmxMUeFqsx3fXIxwrSGJ/ZTlQ8jR6STCbl5sxhkiq8?=
 =?us-ascii?Q?4Q+oCTRu4rtHGjUEsO2gbVo9f50YKk82d9XRIzpS8DDSe0HOncOUegY4J/ZC?=
 =?us-ascii?Q?1wevDM+ALZdgt+d0Y6jx44guCYlcBxbvohNbYrwmT3/tqpXYLhIaN4IcFlJa?=
 =?us-ascii?Q?AwTGBkVVShgINC8tkoTLLp1XL7P2Rumc8WIIwU/w4UqpjNcWnl0CupVxL7AS?=
 =?us-ascii?Q?hUTkDYFKttqfO3FGUlUI5VZVuYNLkfe3sBPEe9UuzbpUjMfTlFGmXLVsjsoG?=
 =?us-ascii?Q?qt077obA6PdpCVOP1fVlXZ5D/5Mr+f8DtnsAqenMUSw81XPmsZE/p74P7Nxf?=
 =?us-ascii?Q?UX0B9rqGE2L+t5PxrLZqB7Vl+JC+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M2/2DAcDV1ygCrnF4A8wqkEg/825NmL43XTG1Kb4+h49K8rpAi2cetGoOEil?=
 =?us-ascii?Q?9pQ/9bmtTmJN2VdpbX0hKuzBJklNbyE4FHjbHERetUmj5OwYxf03Pp3SDxRS?=
 =?us-ascii?Q?dQti70JG5ASA3Fy+F4zxwzigl4m1CSoahlEbCbRHZpuZXoP1PTv2sZ8M62hP?=
 =?us-ascii?Q?2EFkIvZOzITadhuyDmHc19vvm320W+xkhFvUAibJndVe+OFctqLqDlIzMWfL?=
 =?us-ascii?Q?brA6cvTmTG+JE1TM0TaPdn9H0usYW0FPVTL/YQiaPqxwA6D64W4Bbq9JnZBz?=
 =?us-ascii?Q?903Bmc6DnQcZGggXiSCI2JzEvFME7SNsWT8w5bQv+N4zTn0AA3+JO/qbsqYL?=
 =?us-ascii?Q?6LbOwXgtxPFPhx10eRhebbE3Iuov9D9IMlRVBTsF/U76JA+Unb4mKocCRfKF?=
 =?us-ascii?Q?Ldbm0XGsPR3TU+L6EvpkhgNXwhO5n9Des/TWOeyRL/YLOZln0pl94b76QsV3?=
 =?us-ascii?Q?jDx6WjpMS5BhK9UBWvvHQCusK1j4cK8RvcvV3mUvYpdh7Viv+lXgg/gbBnbi?=
 =?us-ascii?Q?5BlOAcbS9DWmLXD8wuhyzJH1DfVhP4TERDRbDO0TrbxO9t/uu3gnG1+YXArs?=
 =?us-ascii?Q?W10GooQRWiLljCqSrOuPoS5wIFvOG4wxoJ1dK4pKX+N60/NOzSBhO6sm63Ij?=
 =?us-ascii?Q?DvN55D5Keysqp+FaTOipn+tWMN6+TqLg/sTu6T0/uBQMXo00B2nB4iBsSvPf?=
 =?us-ascii?Q?/6Lj7DQL4sjFrTPw1/Z5uYe1qAkjCNdmP4qO8ehDnB4VskPSY+nnDcVbAq3c?=
 =?us-ascii?Q?LKUtGpXg5tkyHf66G9bFbZXxvjOKq7Eq+cNBygyxfmIw1r0+IglXppbcnx9M?=
 =?us-ascii?Q?9d5R4c9KE0a5lSPqM23sjffxhwEZFrxEiEymNA6XK5vsb0IbfDvQdWSFpqio?=
 =?us-ascii?Q?FM6fdimfNcWJsVDy09X3XCpKDEE4nkyAtkjSPPbjV0ejsEj9YkHo0YR74Ts4?=
 =?us-ascii?Q?447W+Q5puRohtFkC5M7JujwhRNQFkrdTsARcIec2kY0qJeD1vQgDYbz3eSmU?=
 =?us-ascii?Q?BMy4YlHK778TmIk1dugXe0l14HYi2yXxLJHDI0xYRTUsE7EBmX/Km2fBP9s3?=
 =?us-ascii?Q?FYBIrwu/RCg1c5llwvD4X24y2hW5oA0UzoFkLbDfgMF39aU6jaxKIsfU/v4J?=
 =?us-ascii?Q?sMNBdmqSNVMNq6YH8xE3Ew2TcQjUnVyOPpTsqm1RcaLr5WMUCQpVrMttgi2H?=
 =?us-ascii?Q?xyb9tJYi68ME7dRHhnghJ2dVXaJm3p2Bd7pHAD88TAB5CK7r+KoBzbxuZObZ?=
 =?us-ascii?Q?qpFVB8yI3nbeLEP+6Tusb3b7vo279rpzJBaN6Fa/RiEM5Bk1DZbds8i9XEoH?=
 =?us-ascii?Q?TZO7RG8scYrKtra53HI6NKG0eNVB/hAenaj4SLNmWPfsZ6NvGRHrWaqKWFny?=
 =?us-ascii?Q?SMeP6BmlOASNWDRQN4i6rWIUpp9icihKNcd9jJ4jguzU5bdNC90YLhTYsbXB?=
 =?us-ascii?Q?+fEZ9Nk7zdbmCZ4EcRt2Q1whJKGyGPv3SpZ0Yahv3slV9QCBNwYTR+Yt6g8Z?=
 =?us-ascii?Q?GEEKwglYOrOZQmAzGrUKuZuMqjOEj0CEwfhpRW9PGbSfj1O4NNBKAEjOFFu9?=
 =?us-ascii?Q?ftMDR6Ml9wf9IT5octdfaANlgiF841aCl8VpPVcXQFlTUCgBVo2zx71caeUr?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd6655a-0e5c-4193-ba58-08dde3a49fb9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 06:57:15.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0k2739XMVVHDnJq9aBwMKFkb3zclIu+Skeco40GIkeGgnyh32uPo4t0a6SuWV5G67o55KDjefdNFipYfYyPpPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7494
X-OriginatorOrg: intel.com


hi, Paul,

for this commit, we reported
"[paulmckrcu:dev.2025.08.14a] [rcu]  2ad3ef4260: WARNING:at_mm/slub.c:#free_large_kmalloc"
in
https://lore.kernel.org/all/202508221045.ecc6098e-lkp@intel.com/

in fact, for 2ad3ef4260, we also noticed issue about
"WARNING:possible_circular_locking_dependency_detected"

now for this newer version fe37e4521b, the
"WARNING:at_mm/slub.c:#free_large_kmalloc" seems gone.


we also noticed there are similar commits in even newer branches
  dev.2025.08.20a
  dev.2025.08.21a

if "WARNING:possible_circular_locking_dependency_detected" is also fixed in
them, please just ignore this report. thanks


Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: fe37e4521bc46a111cf9e8d2b0b862bfd2daa54d ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
https://github.com/paulmckrcu/linux dev.2025.08.19a

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: tasks-tracing



config: x86_64-randconfig-121-20250821
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508251443.2337dadc-lkp@intel.com


[  157.064279][  T396] WARNING: possible circular locking dependency detected
[  157.064611][  T396] 6.17.0-rc1-00030-gfe37e4521bc4 #1 Not tainted
[  157.064911][  T396] ------------------------------------------------------
[  157.065241][  T396] rcu_torture_rea/396 is trying to acquire lock:
[ 157.065541][ T396] ffffffff878da730 (rcu_tasks_trace_srcu_struct.srcu_wq.lock){....}-{2:2}, at: swake_up_one (include/linux/list.h:373 kernel/sched/swait.c:26 kernel/sched/swait.c:53) 
[  157.066067][  T396]
[  157.066067][  T396] but task is already holding lock:
[ 157.066411][ T396] ffff88812ed552a8 (&p->pi_lock){-.-.}-{2:2}, at: rcutorture_one_extend (kernel/rcu/rcutorture.c:2139) rcutorture 
[  157.066917][  T396]
[  157.066917][  T396] which lock already depends on the new lock.
[  157.066917][  T396]
[  157.067404][  T396]
[  157.067404][  T396] the existing dependency chain (in reverse order) is:
[  157.067825][  T396]
[  157.067825][  T396] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[ 157.068190][ T396] __lock_acquire (kernel/locking/lockdep.c:5237) 
[ 157.068438][ T396] lock_acquire (kernel/locking/lockdep.c:470 kernel/locking/lockdep.c:5870) 
[ 157.068674][ T396] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 157.068947][ T396] try_to_wake_up (include/linux/err.h:70 include/linux/spinlock.h:557 kernel/sched/core.c:4216) 
[ 157.069191][ T396] swake_up_one (include/linux/list.h:218 include/linux/list.h:287 kernel/sched/swait.c:31 kernel/sched/swait.c:53) 
[ 157.069425][ T396] __srcu_read_unlock (kernel/rcu/srcutiny.c:111) 
[ 157.069688][ T396] tasks_tracing_torture_read_unlock (include/linux/srcu.h:408 include/linux/rcupdate_trace.h:81 kernel/rcu/rcutorture.c:1112) rcutorture 
[ 157.070066][ T396] rcutorture_one_extend (kernel/rcu/rcutorture.c:2141) rcutorture 
[ 157.070399][ T396] rcu_torture_one_read_end (kernel/rcu/rcutorture.c:2357) rcutorture 
[ 157.070744][ T396] rcu_torture_one_read (kernel/rcu/rcutorture.c:2378) rcutorture 
[ 157.071073][ T396] rcu_torture_reader (kernel/rcu/rcutorture.c:2443) rcutorture 
[ 157.071393][ T396] kthread (kernel/kthread.c:463) 
[ 157.071614][ T396] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 157.071858][ T396] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[  157.072125][  T396]
[  157.072125][  T396] -> #0 (rcu_tasks_trace_srcu_struct.srcu_wq.lock){....}-{2:2}:
[ 157.072584][ T396] check_prev_add (kernel/locking/lockdep.c:3166) 
[ 157.072827][ T396] validate_chain (kernel/locking/lockdep.c:3285 kernel/locking/lockdep.c:3908) 
[ 157.073074][ T396] __lock_acquire (kernel/locking/lockdep.c:5237) 
[ 157.073320][ T396] lock_acquire (kernel/locking/lockdep.c:470 kernel/locking/lockdep.c:5870) 
[ 157.073557][ T396] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 157.073827][ T396] swake_up_one (include/linux/list.h:373 kernel/sched/swait.c:26 kernel/sched/swait.c:53) 
[ 157.074063][ T396] __srcu_read_unlock (kernel/rcu/srcutiny.c:111) 
[ 157.074326][ T396] tasks_tracing_torture_read_unlock (include/linux/srcu.h:408 include/linux/rcupdate_trace.h:81 kernel/rcu/rcutorture.c:1112) rcutorture 
[ 157.074705][ T396] rcutorture_one_extend (kernel/rcu/rcutorture.c:2141) rcutorture 
[ 157.075038][ T396] rcu_torture_one_read_end (kernel/rcu/rcutorture.c:2357) rcutorture 
[ 157.075384][ T396] rcu_torture_one_read (kernel/rcu/rcutorture.c:2378) rcutorture 
[ 157.075711][ T396] rcu_torture_reader (kernel/rcu/rcutorture.c:2443) rcutorture 
[ 157.076040][ T396] kthread (kernel/kthread.c:463) 
[ 157.076261][ T396] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 157.076504][ T396] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[  157.076755][  T396]
[  157.076755][  T396] other info that might help us debug this:
[  157.076755][  T396]
[  157.077229][  T396]  Possible unsafe locking scenario:
[  157.077229][  T396]
[  157.077577][  T396]        CPU0                    CPU1
[  157.077829][  T396]        ----                    ----
[  157.078080][  T396]   lock(&p->pi_lock);
[  157.078276][  T396]                                lock(rcu_tasks_trace_srcu_struct.srcu_wq.lock);
[  157.078701][  T396]                                lock(&p->pi_lock);
[  157.079013][  T396]   lock(rcu_tasks_trace_srcu_struct.srcu_wq.lock);
[  157.079324][  T396]
[  157.079324][  T396]  *** DEADLOCK ***
[  157.079324][  T396]
[  157.079701][  T396] 1 lock held by rcu_torture_rea/396:
[ 157.079953][ T396] #0: ffff88812ed552a8 (&p->pi_lock){-.-.}-{2:2}, at: rcutorture_one_extend (kernel/rcu/rcutorture.c:2139) rcutorture 
[  157.080475][  T396]
[  157.080475][  T396] stack backtrace:
[  157.080753][  T396] CPU: 0 UID: 0 PID: 396 Comm: rcu_torture_rea Not tainted 6.17.0-rc1-00030-gfe37e4521bc4 #1 PREEMPT  aa183fc6ef9598fc40ccb278d8e2f41f5324934b
[  157.081421][  T396] Call Trace:
[  157.081580][  T396]  <TASK>
[ 157.081722][ T396] dump_stack_lvl (lib/dump_stack.c:124) 
[ 157.081938][ T396] dump_stack (lib/dump_stack.c:130) 
[ 157.082136][ T396] print_circular_bug (kernel/locking/lockdep.c:2045) 
[ 157.082377][ T396] check_noncircular (kernel/locking/lockdep.c:2178) 
[ 157.082609][ T396] ? find_held_lock (kernel/locking/lockdep.c:5350) 
[ 157.082835][ T396] check_prev_add (kernel/locking/lockdep.c:3166) 
[ 157.083055][ T396] ? finish_task_switch+0x1d7/0x770 
[ 157.083331][ T396] validate_chain (kernel/locking/lockdep.c:3285 kernel/locking/lockdep.c:3908) 
[ 157.083557][ T396] __lock_acquire (kernel/locking/lockdep.c:5237) 
[ 157.083783][ T396] lock_acquire (kernel/locking/lockdep.c:470 kernel/locking/lockdep.c:5870) 
[ 157.084004][ T396] ? swake_up_one (include/linux/list.h:373 kernel/sched/swait.c:26 kernel/sched/swait.c:53) 
[ 157.084227][ T396] ? rcutorture_one_extend (kernel/rcu/rcutorture.c:2139) rcutorture 
[ 157.084712][ T396] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 157.084960][ T396] ? swake_up_one (include/linux/list.h:373 kernel/sched/swait.c:26 kernel/sched/swait.c:53) 
[ 157.085181][ T396] swake_up_one (include/linux/list.h:373 kernel/sched/swait.c:26 kernel/sched/swait.c:53) 
[ 157.085396][ T396] __srcu_read_unlock (kernel/rcu/srcutiny.c:111) 
[ 157.085636][ T396] tasks_tracing_torture_read_unlock (include/linux/srcu.h:408 include/linux/rcupdate_trace.h:81 kernel/rcu/rcutorture.c:1112) rcutorture 
[ 157.086150][ T396] rcutorture_one_extend (kernel/rcu/rcutorture.c:2141) rcutorture 
[ 157.086621][ T396] ? rcu_read_delay (kernel/rcu/rcutorture.c:487 (discriminator 1)) rcutorture 
[ 157.087077][ T396] rcu_torture_one_read_end (kernel/rcu/rcutorture.c:2357) rcutorture 
[ 157.087563][ T396] rcu_torture_one_read (kernel/rcu/rcutorture.c:2378) rcutorture 
[ 157.088038][ T396] ? rcu_torture_one_read_end (kernel/rcu/rcutorture.c:2378) rcutorture 
[ 157.088551][ T396] ? ktime_get (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 arch/x86/include/asm/irqflags.h:159 include/linux/seqlock.h:74 kernel/time/timekeeping.c:818) 
[ 157.088765][ T396] ? ktime_get (kernel/time/timekeeping.c:822) 
[ 157.088977][ T396] ? __kasan_check_read (mm/kasan/shadow.c:32) 
[ 157.089217][ T396] ? kthread_should_stop (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:168) 
[ 157.089465][ T396] rcu_torture_reader (kernel/rcu/rcutorture.c:2443) rcutorture 
[ 157.089923][ T396] ? find_held_lock (kernel/locking/lockdep.c:5350) 
[ 157.090149][ T396] ? rcu_torture_one_read (kernel/rcu/rcutorture.c:2426) rcutorture 
[ 157.090623][ T396] ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 157.090898][ T396] ? __kthread_parkme (include/linux/instrumented.h:68 (discriminator 11) include/asm-generic/bitops/instrumented-non-atomic.h:141 (discriminator 11) kernel/kthread.c:290 (discriminator 11)) 
[ 157.091133][ T396] ? __this_cpu_preempt_check (lib/smp_processor_id.c:65) 
[ 157.091397][ T396] ? rcu_torture_reader (kernel/rcu/rcutorture.c:2405) rcutorture 
[ 157.091865][ T396] ? __kthread_parkme (arch/x86/include/asm/current.h:25 kernel/kthread.c:303) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250825/202508251443.2337dadc-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

