Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71B1D5AAF
	for <rcu@vger.kernel.org>; Thu, 26 Sep 2024 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727317928; cv=fail; b=IcbWKDlmzzFzwDHmTVbmY5gui/aC4P1hSM6m/mpXV56lAt0+/p1d7ZKPRq8hdFoWvvRxWD61pS+acwjnZTQQ6RnaKrRZfK2LURVLs1xvcnEBxc7LQWNLfablvGkOGVKBNAjwlojmIR62DoVj3JEa56t4dqF8MkQvp3thRPzBhe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727317928; c=relaxed/simple;
	bh=qfp9CKSjfTEamTSkObgYwoXMpwNrjnZYzmc3HlQ7OH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DJ2DKf7iFyd4Hc0Oun9XVXI6SxumIQj4ZKMV0v0DlfraOmPgn5tTJ7txq+G0M9lcPLA1bFzgoa52keU1clEVMCfIIvf+/nfyfcEIY/mO93P2cNwXeZYkmrIZPcFvJd/Er0AlH+4P6CIA+o1MSbuypiiZ/nA3QG2hpYiiK5T3pi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUy5qVt2; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUy5qVt2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727317926; x=1758853926;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qfp9CKSjfTEamTSkObgYwoXMpwNrjnZYzmc3HlQ7OH4=;
  b=aUy5qVt2Og5Y4FxeB51SQrVY4sl3RZGICb63I4n9pPetEL5L+OGBcjyA
   GLmonqIpvAUJIQBBSYPRn0i8c3b/rSS1w3EEteJq9Lbm3epnJv3UysCtP
   Arwenq0KoL8hRyZIwHAEUv4azh3HScMgJ29vEeyDP+hbnXn8Q2L6LwuG6
   8p4s+40uvGjt037IXg37oRrb+UwLGKg/C3MlbOzReGPD7WJ1wyOzV8IVT
   TWebqaPrBEdc7ye60g91zga1aMRUQy3Mhw8vXsOEA7qjqfTBip7IFYOTR
   uuC1Sc/yIshu1JXhAeYXyL+B7YaqgtwUhk1NLv6CjNyhQHGa34cqfvnsM
   w==;
X-CSE-ConnectionGUID: FEArLXdjSFuk6czBb5Ueng==
X-CSE-MsgGUID: RRdDuFzxTKy/gI4Q+BR9kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="51810289"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="51810289"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 19:32:06 -0700
X-CSE-ConnectionGUID: zxRkUKZ3S7ap4fV7dr3GBg==
X-CSE-MsgGUID: 6pVXkfBcQrKwK4+x9poiaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="71987157"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 19:32:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 19:32:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 19:32:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 19:32:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 19:32:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URLAq+pcvmv5h/OnqJqRO1TV/x/1j2ytWIxiGRCreRKCgKnKvTZbSprqsfWzcvUh6xVLKXhPTYo3GV1c/n+4k+orfToOE+J5/aL9xV68KwB2Qz3pgg3+t6bJCC6o3fW3TGPTV2FMMNcPb1cyV9Ff3SVOIfduhKJqRyBMa65x1NO8OKDL7qVYug1GTTDQhuMtHXYa3KFTNDO+6lpyNQLSzL90KzsoYuHZR6vEw10IaoSIXqgYaEXXlfPuEb4+k4JvInofPC1jq/xr4r+FvbXcXq6R7dCGbWQS4tsaOgMgggdLW2W/h4FlcXgWgRMrUac8NGpZ0rxJDcNKwd0ubIPQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPT+usFdPZApEKE4PJL+551AbrODscMysQxsxp9GyjY=;
 b=LwnhJp2edie8ACnZRfYUAoQuLH4It1JlrvJ429inqMsXiROcKLNjxqaOJpCN2sFouvoJZfKg5DYy9OHWtzi2TAfTtbEsnHega4R931PFE6GlVBlEO3vuiHAp+9QOKIhN2cwkM4NVOe26Rot2iGUj75WUKFg7pnxOtJuArkuoKj7QCYCrHKJS9y8LlWfgcJGCM2KbD3T8NmnCoToTxNgacdyHbJ9EeH14VUgp9tQy39G5+NklkbwsDsb6Pi5Eecj5UlFElnzOCqw5NqMRR1Wx44rwX/FjKlwdYVQNezoCEi1GLv5cPdKLw22f7axiJ3NeMSmoxbsu9RVOHChK1zCEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8154.namprd11.prod.outlook.com (2603:10b6:610:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 02:32:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 02:32:00 +0000
Date: Thu, 26 Sep 2024 10:31:50 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>,
	<rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [paulmckrcu:dev] [srcu]  26cb612c43:
 BUG:using__this_cpu_read()in_preemptible
Message-ID: <ZvTHlplYV4acwazZ@xsang-OptiPlex-9020>
References: <202409231124.358fed11-lkp@intel.com>
 <ff495e02-dcd4-4310-8806-58fad0dad794@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ff495e02-dcd4-4310-8806-58fad0dad794@paulmck-laptop>
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: 074e3199-4208-4cc4-1211-08dcddd36603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kOX7a6LqBL6ywoxll3dSvN6oMk92JlOBmpEoskJq72LUPXmiE67FP//mg0IW?=
 =?us-ascii?Q?aA4K2FhlaPGw53Xbhx71Q0RIk6oOFD4ct8+nykandb8cI9Umlom52+rdV5NE?=
 =?us-ascii?Q?SucktnLDezbe9WErFeYz9b6jZjmVYyVIjqUDOFlm0cn7QYPygOEyfPX5RoG7?=
 =?us-ascii?Q?BlGheyIQj+LMcOYj8kvV+ZQPeDv960zqu67lvtasN8hrMIUH3foWyxwuKI4j?=
 =?us-ascii?Q?9lNjHvaAx2KV7+7tNUor1MYIiNOqSGZVSZwX9NaROSY/ScbrX/6dJVY9tuXL?=
 =?us-ascii?Q?qgcZKToujHCm/+3acgX40LZaQyHgNCK6Dy04yFEnPEtJZIB8IzXwMV5pGV/2?=
 =?us-ascii?Q?0MWSUmfGvCax75cZQ8WVkXZ+CyeSdLh7siF+I23XTNoO2DTNmztSCb9Slymy?=
 =?us-ascii?Q?SOFZ7ZQqWgS+gZl/4NckMeQkK+lBNO+skVcD+hBe34NB0X2wvXyYMhzfdR1m?=
 =?us-ascii?Q?VN2j9vocapepLi5FqvaUqhFOREXLd6wIRzK3JQEOJOUGrivLxBU9SUNEPJSb?=
 =?us-ascii?Q?/SKOMqFrrJdQ4ECYWq2ve9yOCdv9WlqgKywFvmpaHJVzG+U5eQlYO03aWWQy?=
 =?us-ascii?Q?splo/hdWMNAVDUXl838hwCvyGyItcISarTE4qTZWGm91ehfvECOMzWzAeKsI?=
 =?us-ascii?Q?XvXxXkx6DNpjJ71E40XVe68mlrzJJkeMxU/Jylzj/pf/uLqutptRpw2EzbOh?=
 =?us-ascii?Q?lf69mAeQhmWVi6InbImjsNDUPctJSz+JdkHWS1/QuF9+O0FQ7TGSIGRf52wr?=
 =?us-ascii?Q?HDXYvx4ubPex/zNk9lbsgXhbdlHfJ2FXX1BdokwVMXwhFQ0katQGDzXhyqcK?=
 =?us-ascii?Q?vahMgl8Ni/TCq4a9Pv7aSqz9yRgXfHPBvGM1MlYfMsW+XXadkxyHXXaPGDam?=
 =?us-ascii?Q?9Z9hYWPmbXJHY8XlLbAu5F+Z1hAfTT/VaLI7S4pENy0LvlHdEXa7dE2AjS3L?=
 =?us-ascii?Q?nAzH4mblkmW6r9j3xc10b68GKYmYOxUlswon9bAu6fokmiCjhHtNpGczbLyA?=
 =?us-ascii?Q?kZoKPgkEFOu+37n3M+XhJWU+EHhnZv4dJIqjBZglxZja7F1XDRm5m1gM1ZWs?=
 =?us-ascii?Q?o3aCh7L7xcH208RemP7qeFWqCLPn3SMHyNGoqgW95d06Y7BY3/AxajhFr5WF?=
 =?us-ascii?Q?1McH+nOwKJvxc+2xjBHGT1AjiYGGN8aB1oAI6E+X7bHpNbkr/hCC+3w8bHN/?=
 =?us-ascii?Q?p6sfr4NwopeWXOP4j7Ym7oLheB1JeeKFsFBX86zekJIUmWm1Ss2bihJZr2gb?=
 =?us-ascii?Q?IKoR5Pnu5gaCvyWLIP446S8fJJlbPGouaJO8cxMXknpy9yY7xqsdZrltxrkI?=
 =?us-ascii?Q?rKLku7H0GC2DjjNCA/GFcmbp3mF9haVnnP2VBEYZRMgIJoWIFuLI/PPwxkiu?=
 =?us-ascii?Q?81f8nfo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d89WE6W5ekMzCRHRidWOq7YJ8auyTtibTTH6XZo7Y8RrPaqZGDebGL2+9BQU?=
 =?us-ascii?Q?LN9mE2lAZVWvHdTs2vRAp6jzELjU3De9ewd7CacI+h/fpdXXpeiVw70hS79w?=
 =?us-ascii?Q?Pp9ZTbP071SG3fEBmMgl7i0LDBcNBX9+kLn8jfKOZaOQCDiA942PLHpFekbI?=
 =?us-ascii?Q?1UnBr2jKtU5uPPbaCDr6pIFuQX11HzzII/RDj6gOs/dE0JWMNydCODWh/xz5?=
 =?us-ascii?Q?J1HfkwjpZ1UF8xgvHfv6ZgTQKL4sf1KjrzgDGQsFpTd+KsIqYl/Pw3WMX/8d?=
 =?us-ascii?Q?0cEoM3L8fWHpyV1CpIdCzL0gslw2sqPvcxf1x7iCBInLU6iZG/yv/mMjngdU?=
 =?us-ascii?Q?p2ocKzSBaA0MnpLyY+58LVaWs8Li2t3yUclI3kwhiJ0oC06Qz8FRKPU41Zgy?=
 =?us-ascii?Q?HIjGNJQVnO/7heUXlQe7M4ChLd8v53L+mk0Ft5CAr6mYf3RohXQT7aF4jnAN?=
 =?us-ascii?Q?CixQcd4JCO9aQ5ZIyqmT6LW4+eQCmQhjKuImMumt3IMvrD8Lf8x+zRWX0OpH?=
 =?us-ascii?Q?tS1kO/RFg9fCqGd1brxuoYdQx/NtZKUcYurYM+6DgxabTOPj6p4rHbjsyJyX?=
 =?us-ascii?Q?9X9enijBlzKglKG6gzXNaj66RnJEejEyYJBRV1fKY0TG0I3x3Bl5kv6YaPmv?=
 =?us-ascii?Q?ix8sc5oGL8WqfPxFbhDJ/VyXNWxGjkGhMyqrWuvgTALk0TO1JxlcDYW8IWx9?=
 =?us-ascii?Q?dP601wkMdylRDJYj8QEEY8NGJtPqXShR5HkD6soVleJvF3kz12aFcVwKA119?=
 =?us-ascii?Q?L7oWOaipDPSOMUZvvUTJTQ4j3RiKArB3kAHHb3YKKQ+kxx+ys62Q0J9E94sr?=
 =?us-ascii?Q?d/97oooQ5L5kDfF4um1bVfnMaXWpg+hrkTM9/bSp6uFwUiX0VsETWO+Ino8+?=
 =?us-ascii?Q?7RmmI1J7Xmex3o5qLJ0Us49/5p9WfMJBEsHBJCUY7Hacs6f4w0kByH6SuaUH?=
 =?us-ascii?Q?8AcjY2mRgnVn24HlI3nf0Z1bAj97cOxvoVo8VnfKUd+2E1OnnluZahE1+Nk9?=
 =?us-ascii?Q?g6EbVD65cAAdvXhHNLTY4NZYe8jPUQoOcJ/LHRLchlHDqIGFFsGhrGWwT9eC?=
 =?us-ascii?Q?dZSV21pQSYPNZqg7yWoBlaLPbAO7t23WbtIKWkPILNWj6EjdWHNd2vEO+rac?=
 =?us-ascii?Q?lDeKmewkGvzJyuTqUMDWAwwDeMgBzJEvwr3bhJBTY8paBf48qd6pOf7QG283?=
 =?us-ascii?Q?CAeGUTOwyY0lufeB8pHh5mOosbevuYAj/VXHhTuB0w313Htip21GcEq5Sl5V?=
 =?us-ascii?Q?Gt556o/JX7pJfsRLYITsRaSK6N/kvy7NHg96QPHdE6XZLTzOlgEGspjmBToe?=
 =?us-ascii?Q?YasmHk4+2Gj/AkR7h2QLx6h88BKHJmY0iEDX1m71uCt66uUtmFY6wMvBrgZg?=
 =?us-ascii?Q?5RqxOF6OoMQi/wdSdSH8mTHAwkqPakvMReANYy9eHjge4y5FjQH8b6b/fJ2p?=
 =?us-ascii?Q?i/uoR9zn6onnMvtKaWrtBbfOiDE29EaVICi3YeFgRK29EE8f2UzKYiIFMPST?=
 =?us-ascii?Q?5nsTore3GOCFFPX/lpaITJRWxb9zLBFP2wp6QhvQePkYZQrEmoBiDafp0Znd?=
 =?us-ascii?Q?wBbvUZ8hlw1Uf7XYEIfKXhjARDq8tLEneiS5TtaqKEn67S3oSnfcWoSRiy7M?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 074e3199-4208-4cc4-1211-08dcddd36603
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 02:32:00.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iY7wGQxjWbtZDG/2N/32qXU5Z2fEay3yAAmW5ltNK1rubi9uDUnrfzKRDf+ToYLc3iRFFqbuUTE/13Vg/hfKWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8154
X-OriginatorOrg: intel.com

hi, Paul,

On Wed, Sep 25, 2024 at 01:57:45AM -0700, Paul E. McKenney wrote:
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202409231124.358fed11-lkp@intel.com
> > 
> > 
> > [  169.560380][   T76] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/1:2/76
> > [ 169.561229][ T76] caller is try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
> 
> Does this diff fix things for you?  Here the per-CPU access is a
> heuristic that reduces overhead once the bulk of the CPUs have done
> srcu_read_lock_lite().  So it is OK to get migrated just after the check.

yes, this patch fixed the random failures in our tests.
Tested-by: kernel test robot <oliver.sang@intel.com>

we applied patch upon 26cb612c43 and run the same tests up to 200 times,
didn't observe the issue. thanks!

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
  gcc-12/x86_64-randconfig-006-20240921/debian-12-x86_64-20240206.cgz/300s/vm-snb/cpuhotplug/rcutorture/srcud

commit:
  daf812f27d6bb ("srcu: Standardize srcu_data pointers to "sdp" and similar")
  26cb612c431de ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
  f2f1565029268  <--- your patch

daf812f27d6bbe4c 26cb612c431de5093ae6a3a67ec f2f1565029268e27760307bc82b
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :50          66%          33:50           0%            :200   dmesg.BUG:using__this_cpu_read()in_preemptible


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index f3db4d42e70ab..07147efcb64d3 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -482,7 +482,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
>   */
>  static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
>  {
> -	bool did_gp = !!(__this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
> +	bool did_gp = !!(raw_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
>  	unsigned long unlocks;
>  
>  	unlocks = srcu_readers_unlock_idx(ssp, idx);
> 
> ------------------------------------------------------------------------
