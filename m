Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252517FE
	for <rcu@vger.kernel.org>; Tue, 20 Aug 2024 02:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724120824; cv=fail; b=tZj6pZ2ty21xn1B8DpwUY5Gf4Ulyz0t/hg9j2878soMMLrb1a57AGYIeMK9ePoSSLKeaGbokxoX5gUadXg44/9TGIwBsgj7j5lyS126nLWrwCRrYW6Jf9euPLB+HzNoM7q2K4VSO1eiwl5H2ByhgwoTGsjoJjZmpwrfoKmF0zeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724120824; c=relaxed/simple;
	bh=Q5U5INvOuLlC2oRJftyQ7XoBvHicQ9WRcGnxRcrmBZQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aOd5Sc94Ic+2U95Ilcwzf/QBpcfnH0y0vkmJvHzY393FN7EU4SAypkt2yWDqFPJWTyRytcuG7D+XRNUKzCxqWSx1HzVflcnEL4DQC4E19vIZuln7uWf68bJabsTAxQA2uByxR2QQAqsg+JY9fAERGMKvCuMjDNa+yxT0CEqBfl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMpxRQ7h; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMpxRQ7h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724120823; x=1755656823;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q5U5INvOuLlC2oRJftyQ7XoBvHicQ9WRcGnxRcrmBZQ=;
  b=QMpxRQ7hM/q9OnpDWK21adziemsQMLBt57D0TV9en2Hoz5eVXddv3oPu
   +a5XZBa91Clvly37u6/Y4TVniY+2Y2BkMEHSdUtBgfblBjduPWnb4lTh0
   3VHWoBi5Y6Lx3IF12m+wTnO/WtUYJp21oSfW0yDwkVhNyLqfHU956qPnA
   zC6HPwc+gJ6hD8f/skJmYSSC+nJET26kgEhu3GBUJ1PJvrR4xi66QCDRt
   3Ki9CbNC1IAcYZ/EPvCjTTbOLzGK/0U14tEONFdcshrY+Z0aQhmq9YQwK
   QbuxIYtwpyEwpvDNMUVG4bxLWhVtqpzN4zTBoKyz3fvlx1Ebp0B3gQj/M
   w==;
X-CSE-ConnectionGUID: 2n2cK6iETNGc2jiigeMZQA==
X-CSE-MsgGUID: hHwhWQu4Tqmu66e7neU6qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22019269"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="22019269"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 19:27:02 -0700
X-CSE-ConnectionGUID: oC0/uMfFT1yew8TorBVrqg==
X-CSE-MsgGUID: 7Gf7cdcGQ9axqLm6kp83xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="60720510"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 19:27:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 19:27:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 19:27:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 19:27:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7k1XU7n0BE/vP9j/uNDbUfOm//HdPXDrXeq3GBj2dBH59ou78bctvnHkZ0hqT+1bzI5cOh1nZhz9+xQi/vHF2UIHlVRY9wCp95ydOlIq2bkDkt7ykmsnZ46SDyUIHJyqId3JheGPZn1L0oHgGHTu/xAFTLnAbgyYYPdqY6yNlbgopx8OoMyPSymEgjGGpncZapko/X9Jt0wjetnXFnqwG3n1RTDsQpYNQ/woMWxBWQ4XhyqUmLHuJiCZRBAFWFm4lEwCjms79ZdIkSObQUlYIHPNuLDOa+JCLea8dRYKgwFGx0CbSl+7ZVWLi52HIyx05Dk7PZqZVvSiTkXguhiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJcPNif+J9GRwJf9KmC6ZpUAHcg9TEjsn3YUZkZYq54=;
 b=AEvqElS8g7v97+fnFbcfVY5zYtDIT/3kaDeZyldwfZH8Qvwkm1ZrsaRXFpL3zU5/NwxgP7Rp+bsHFlc9UN5qwEElIrxiLCqqbshieZIz+1dEyHImr6HGTJui9ioFHHTu6OWIwhMMLKCLWr6JjAxIBUjssTwVGRiM6uB/PUpHr0yNUpGSehsq9Et0qD4loZzNL7RI7RT4pqIARw9sW+RC+yKAHlwsSfRcynamdTzjsaPPOIQPw6h7O7wpl3MqIeox0RuYxPAfXSRHs2H7XIQR1ztPc52EqEO1OJzK6NLfZ5I6BpWg70U2/wK/rSnKrFnTQ+dHuaTel70Mx6rR0C9Rjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6501.namprd11.prod.outlook.com (2603:10b6:8:88::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 20 Aug 2024 02:26:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 02:26:54 +0000
Date: Tue, 20 Aug 2024 10:26:46 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Z qiang <qiang.zhang1211@gmail.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [paulmckrcu:dev.2024.08.05a] [srcu] a7adbae9c5:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
Message-ID: <ZsP+5p1xNIRp+o+g@xsang-OptiPlex-9020>
References: <202408191537.5ab14400-lkp@intel.com>
 <CALm+0cXaHPibx13EYveJJcS8gxrzjCzu6ZX58iGS_EmywzXvCQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALm+0cXaHPibx13EYveJJcS8gxrzjCzu6ZX58iGS_EmywzXvCQ@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cf7b60-4de5-4767-b083-08dcc0bf8eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S9WtFmpe8K5aH9wYYoXUpsx7a+96Py92ckxfZSYEotJkK98qYkZ368y1sMP3?=
 =?us-ascii?Q?ikWiGZgioPokImqUIiyEc3GGNEcEmRf+Cezm+LkgYEQc1wMSvVttGKn0KEWc?=
 =?us-ascii?Q?oag+Ffb8EA4iM7KcESVRvMfxaUhE1SY4dhbJjt9t8xvan6pWOOvbn2jnXcyP?=
 =?us-ascii?Q?+Iqkw9euFUxJq6Z2CR+EjNz7n9VmqLQ5JDJV1g28T7v+MrPlpDkNpsgNaOaU?=
 =?us-ascii?Q?LYtK7b1LlC3mqM6tPVRJrSxBPCmJllgVcpDMpmkPsTN/jxBvdk1nY31eI6kz?=
 =?us-ascii?Q?+VUmlNKUl34zSBQEwilo5LTbwByxQKSntWkIOl+nBjG50EbUpt2smKTae4sQ?=
 =?us-ascii?Q?Jq1wIF3pWgxnlNSE7ivbkA+cS2JyPFiDnPjoJsP1K5r6+AGPPc76QTiq+vEc?=
 =?us-ascii?Q?how9XkgMqOsRrXKSeQsj74/3By1ITQnh7trhd9y41lBWlzDgkrFQqgK8TYDJ?=
 =?us-ascii?Q?3++O/kKN1Q5WEPdAqiiUGl5tq6UWhFGh3UcSJHbp+r3cspCQidgQMK6Nvzxx?=
 =?us-ascii?Q?/KR8mQBixtcPRevErHQtdIZcCLiwv2f2bdp4W0/hx6TmkmH/3NIP39I2c1Z3?=
 =?us-ascii?Q?Nq0XXC9M4KVE1OhONRjUFnfL3GfUZQ5ePLjQT2mFLNYMxoMJQtoCtS/Z7N6h?=
 =?us-ascii?Q?VBeB+wmv3yXjoMtf38pKsFHY37IFkuk4VPYIZc+55+CEwRVSf6dRuZMDkZtQ?=
 =?us-ascii?Q?tbf4mbaY/XWsJ4Wot7iGW3CxYW/yOPheLqxPhEkX6C4yLxhIoZ6R/z2WVNh0?=
 =?us-ascii?Q?nNFx3+LDopz8D3fecK2ucjZsUaj0WWsLnJBU3YZ6Mu4MiEMTU8U0f0I++seS?=
 =?us-ascii?Q?sbvyA+A4lBEB8M4q0X5GoMtSd+5mglgwZ8wZcxhnUCLx/9wwYjfFnZXsCVqt?=
 =?us-ascii?Q?ueEdNXyYbbWlP6gPy8VPh29DYua38Pr3QtlHWmdQeEIZOjFoDk1lLLqL6ckJ?=
 =?us-ascii?Q?4WCR9qBOVwBlsscM8x2nQIjWD7fy5l6IiBDSjLllw42NpVlPN1MxxgCFQSF4?=
 =?us-ascii?Q?B6wpcHzHJOHf5KXs+yBpOjk+3wSamLzP+7B6gYK+U6TN2rP5FkvHU45/fGOt?=
 =?us-ascii?Q?1r2ntqIU9Nay6z8xWFREeQMdXu5oCQjtSeGmQGZDNO9gzFiTFzmXwdUGvrzn?=
 =?us-ascii?Q?bzbUZK2DA+XZM02RV3+I0Jjz8GVr+wicnwb4ZYmioE90SB8j95vk5d82YQE5?=
 =?us-ascii?Q?MRsEZFy9GhAu+upNveAnzwcc2jO95JLtYDTSJzVBhAK9z3lHYk5dTB1HwfA+?=
 =?us-ascii?Q?4y07XJAQv0HNI7kMi6Z/ZmOGU3yChvHdfnZ0q8fY6JKKHEM722xBy0/ZZB4j?=
 =?us-ascii?Q?uA+r5tJ6xlZm1SdeHDZkja/YwGNBy52MyBWUvkY6Ugv07g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZRHrdaIAgidLPA5gQxvbOUQo8nsaLTXlltD+puLiRtHjI656rTrXPJuRrzaE?=
 =?us-ascii?Q?AZmZ9CJ8HFuU9YQr0pPXOuRCF4L1ldlmKWO1Nks89F/MLnhcIPrUTdV6i/+4?=
 =?us-ascii?Q?f7N4FBYoDqtX8AXdiwkYwUlqqB/WdHteIZQZlsfXUZpPe45MlduN0Uv97FFk?=
 =?us-ascii?Q?UlIHP/+Bqa3tyFTX2XlGdxDpNJn5XvgzzlKMAk667eg0kgzsIFciWoXdqk9+?=
 =?us-ascii?Q?FtCcToFWYaLggKe2FNFZy4+GE/mlgcUuZ6FrBAyX4X/Gh4wVxrE5Sc1Os2bM?=
 =?us-ascii?Q?74xoSZVQPiXhpmDVZJnQ+k5BJYmRyXXl7iSrSHgks4XgtJoNWwF+VLFvy1N4?=
 =?us-ascii?Q?UfhytKyJ9T7o6qW2MLGAmbupnfgP8FWQioxVzTfyn6D6slbEyql+YfP/TMnd?=
 =?us-ascii?Q?13HVr1Yunm1BPa9nUkaefRVj/Z8pfs7iBAs3BXySb9H5ld9XjBHbLw78ZrsN?=
 =?us-ascii?Q?DZ45T4xnzZ1DdJ7hnIBefs3jfx0NTvaH0vl60QidlhpM4XJBMZXPw0MBMFjG?=
 =?us-ascii?Q?HqjNTHGbNpC3FqRjoo53PCM5vcEznOxrNgS/9TWPur72qEDzAZXDlHrrMqAr?=
 =?us-ascii?Q?SiMJ67OaQ0gwomit/ehRuIYQ8jL+qxEXAzTn0TiHNoc/BBAr3NcvSFZyoEkT?=
 =?us-ascii?Q?uFw6xTaE39TEDR6cz4KhzLICioYmAtii91fbKutfK7689qYM7xThhZBZHzY+?=
 =?us-ascii?Q?h3qXre6mgdeMVdHzwsxiDnGZALtCN8uf7MjghCUyoyYnxZ2KC+rvzvKTZNEZ?=
 =?us-ascii?Q?wbgbeYi/bSB0jbR00KKD1+bmP0t0i0oMFD1MviWuYplH9RYjJWcxAIumadyI?=
 =?us-ascii?Q?vVDgo94ve4YFcBRzH/5Bu6oTyDLpaT4XU9/lQxHHZBIOdWy+kxRRU47U9NGn?=
 =?us-ascii?Q?iDgBR9fNP+C3CiZeTAShtPvCYUwDrfZ50bgSIFgyTv4FotyV1HxQUY+MNQGn?=
 =?us-ascii?Q?Q4cQyRw31YTWfPL2KrxhI5OT10VS87hYkAovPl23iI8rfJ/dmfUbE/2QddzV?=
 =?us-ascii?Q?9fK5wkKG+25IFcaOg56Ncl33u6x6mlrOqhaWDgwNQxUhbirtmnIg+e2L94Ca?=
 =?us-ascii?Q?dTVK+k5adF4HnJHgN0kS2706ac6/g0nWE5vnOU5VTq/RMPgVpyarmp4/w4nL?=
 =?us-ascii?Q?+5fHu6Rep5rNqw/BhWITvXrxI5Za77pNx69JD5h6418wVflJ02GhlubOzpMW?=
 =?us-ascii?Q?FjEWD1K3JVi2uYZbVv/oNMMig2bbY+C+3agjNYNTQeoPtsc8/5/wsaiwnb0v?=
 =?us-ascii?Q?meRiDhUeIRCS9VpUZ+SLR/pBKk8IxsA0uJ9gjBUQBY+vMOa64uJUDzdUYdC5?=
 =?us-ascii?Q?bwMlt27QVZKqFyTRdBdmF6zkn6pijIZ+zc8/VlzhaAUE8Es5YY/r68Y9u+6Z?=
 =?us-ascii?Q?WLVDAHjW8PD48lltab2v7RMi6i2F1PYTNX7Cie/xucySP6M7ccZ2x8ztJpY/?=
 =?us-ascii?Q?lQfHyFtyyZPC3WO0QDJB7Cl18YKDCieGmIiJ8OA2OZTyQJiUbiQREIw9pc1r?=
 =?us-ascii?Q?0AWmySagRnQyt5ImzUY4r/vicmzY0pQjie/rKYxGdWf/YoywYYzFUyRymVi/?=
 =?us-ascii?Q?bwurxW005a2Q1Y74m7+Bivx0QsosdWdtQL1FBmf8es20zhaIDDe3ct+3CH13?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cf7b60-4de5-4767-b083-08dcc0bf8eb8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 02:26:54.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8k9q4nSZv+Z1GVHky4+n20uBO/XFiTm17BBETj0ZCQj77W+e9uEqO1d0TZatydoRhI+M0hpAxtP11bbqV8gJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6501
X-OriginatorOrg: intel.com

hi, Z qiang,

On Mon, Aug 19, 2024 at 05:11:44PM +0800, Z qiang wrote:
> >
> >
> > hi, Paul,
> >
> > we actually want to consult you about this patch. by it, the config has below
> > diff with parent in this tests (we use randconfig here)
> >
> > --- /pkg/linux/i386-randconfig-004-20240810/gcc-12/157f4b896656dfe6ad6d37c94ca9a885d52f35ab/.config     2024-08-12 04:00:50.715727095 +0800
> > +++ /pkg/linux/i386-randconfig-004-20240810/gcc-12/a7adbae9c55d7f85b3b8c0e8e9417e5d52793137/.config     2024-08-12 04:02:38.647990561 +0800
> > @@ -136,7 +136,7 @@ CONFIG_BSD_PROCESS_ACCT_V3=y
> >  CONFIG_TREE_RCU=y
> >  CONFIG_PREEMPT_RCU=y
> >  CONFIG_RCU_EXPERT=y
> > -CONFIG_TREE_SRCU=y
> > +CONFIG_TINY_SRCU=y
> >  CONFIG_TASKS_RCU_GENERIC=y
> >  CONFIG_FORCE_TASKS_RCU=y
> >  CONFIG_NEED_TASKS_RCU=y
> >
> >
> > then we saw issue show for this commit:
> >
> > 157f4b896656dfe6 a7adbae9c55d7f85b3b8c0e8e94
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :6           67%           6:6     rcutorture.busted_srcud.fail
> >            :6           83%           6:6     dmesg.EIP:rcu_torture_stats_print
> >            :6           83%           6:6     dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
> >
> >
> > another diff is, for parent, we can see:
> >
> > [  465.948962] busted_srcud-torture:--- End of test: SUCCESS: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 stall_cpu_repeat=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000 test_nmis=0
> >
> >
> > but for this commit:
> >
> >
> > [  417.566774] busted_srcud-torture:--- End of test: FAILURE: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 stall_cpu_repeat=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000 test_nmis=0
> >
> >
> > are these expected? below full report FYI.
> 
> 
> Due to setting ->extendables=RCUTORTURE_MAX_EXTEND for busted_srcud testing,
> they use abnormal reader critical sections,   this is expected
> behavior. not a problem.


got it. thanks a lot for information.

