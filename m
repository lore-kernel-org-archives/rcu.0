Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4F38B
	for <rcu@vger.kernel.org>; Fri,  9 Aug 2024 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165646; cv=fail; b=aAC+kYD0dIGHQEYL+XfAZX1Wt8kxpdqA2ZJ24PVb/51KFccSzV8ts673VgqFL1TyuQkR8t82cAhXFlXh38mJpeYrAMORPh2/gIGsMJhMZeA/pbx6M0buyFu9D0lzOf9EaNg1IlMHD/hjuz1XPTKjB3b+I1IddrrbzDnYLvwdqfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165646; c=relaxed/simple;
	bh=agtQhscWcIjxdgZKk0O1sW86ZAU8j37CW4NdyzHU0Xg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BRJ/CPWZD594wtlHbTyVJ1fdUcOeGQ2+2eMfvQTo24LzmNoPzrCyko9ffrOHipRGPJWEv0AW96356Ti2G/N+fdHnz3DDJq4emQEq0nFniVBjieHwDp0QYns1CF01nzZJHJbkWYV6n3S5seIE6nPWtWeWykLjighMCvLd/B8etjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BT/GopSc; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BT/GopSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723165645; x=1754701645;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=agtQhscWcIjxdgZKk0O1sW86ZAU8j37CW4NdyzHU0Xg=;
  b=BT/GopScGwvNq1VjWBk3x62d3Jfw2tI5QjTFNoIo3Pahshw25puTvj2m
   trsrwr38/OdLmAIzcB36+1gyg/EUFuwVtnxiHRPzJdYPHqQE8UyEXo/ed
   5xhsaW73D7JKVB8sHLiIUWXW3MQ/7EK/3NGt/uUlZbLLLqyfWS9aO2J48
   p7tyY2qli+f4BsMT1vGni5Bhw8oLVgYrt7FI0mxi365rF21MjTC7hIHaz
   3qwPLBweeM/ElT9Ga5InUm7sYiSUEyY3jA3rMOJWbIqHyYwol+HH+V0Ja
   9QkfTpKscDeMzQ7m/9aQqHwtyj3e32zGkOoN0QkIo9Y1K/JuXKCRmLDw4
   w==;
X-CSE-ConnectionGUID: Bbm3XQkdRY+1ok53B9by1w==
X-CSE-MsgGUID: IKW+eqkjR/KDlIqcq6OAxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25196019"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="25196019"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 18:07:24 -0700
X-CSE-ConnectionGUID: IiqDJguiQAmqarBYXiW9+w==
X-CSE-MsgGUID: f3xjh8iIRRKB8L4u/b0hXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="61795303"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 18:07:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 18:07:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 18:07:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 18:07:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 18:07:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tk1kUGoM+bHxjBisfVkTw5F0GYkXhkIZ12MZvT13YnhFjMcaiXoElIKujLvsEqpA2cEDWzXfKdPpy1vtzzBG0iBQ6mM6zvUVVR9IISprOQdZVVtYkj64y6B6g1i/OtrmGcFtbv1hXH6bR2dN7y8MU8/v4AkM/1BNdRfU/lVgmj1QQVj0Rh8ynT7vYIhFX8hI1onSHUPdwb+VNjqDhIygVpEQZFqiBoNVb2yJLAJLpeK3IcABAUtnomU5UeFVMV3xPiAQ9sYveotkSKSjuye+cTW0nefBF9D24K2M0XxaOmgIG0v0y2qCR4SCUaFmMNcSmKv4V7suS3aipy3jg9PX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltkOckgvrKI73esxk11L1wrriarfSOpZRk+pTpB44wk=;
 b=PtBcwpPWzywZFyuhNLgCBo3gVYkCbU9v3dzEnDI/3WXkTbanauImBqs1tCMlg3YFjE9JQMLPudbK61pSFWXMryDFPca2zpmxYaT0mWk7ZLI1F27On66wkr1792FTKt7s8xhaqKufLHj4lh3iGru+BmOsru9p7HBx/DY1yxF/8fidjDHNqdPnSIHU4SZxkJF33dMDIaHd5WzPGfKTRu8sWzH21rHWPjZorcvV2f8olsu7Utp3bis8ry8xMpkq1TRLyphb00P4JZCQCZ0G1ekYyoPLnz/c0gPNX6gOzyiM28wpjY1ooj30mU5QrUDv7IbNxw7xAZUwomFWP9osL34mbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4833.namprd11.prod.outlook.com (2603:10b6:303:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Fri, 9 Aug
 2024 01:07:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 01:07:20 +0000
Date: Fri, 9 Aug 2024 09:07:11 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: JP Kobryn <inwardvessel@gmail.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <rcu@vger.kernel.org>
Subject: Re: [paulmckrcu:dev.2024.07.18b] [srcu]  8a4c716cfc:
 WARNING:at_kernel/rcu/rcutorture.c:#do_rtws_sync[rcutorture]
Message-ID: <ZrVrvzRXVzn6T5Q/@xsang-OptiPlex-9020>
References: <202408081016.9d43eb89-lkp@intel.com>
 <7b4990b7-62d6-43a0-8bdc-612e8c0c2655@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7b4990b7-62d6-43a0-8bdc-612e8c0c2655@paulmck-laptop>
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: d8043a37-9ba7-4759-05d2-08dcb80f9e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QVjYsLDoXYW4Ch66TI0WCPIPfdo9DydpWjDHgysL/0EQNFeqbvVhzX8/q/xw?=
 =?us-ascii?Q?/ecqPK1P6gnyTQQZMeHK6Weqok8ERuxrEZb/Gj2lIvEaTxNDFZDuCX7V/chO?=
 =?us-ascii?Q?8je205ccYInmFAD1A7MVe5yLr+Kj/Mnb8dGPddkz92OGd7ZehfX7r7jICC6L?=
 =?us-ascii?Q?JQyc4V7ilGs9QvlQ/ZeUhUAOD1XDrJgSxpKSi9Sl7SeaB2XsQ3lDVnDLWKpV?=
 =?us-ascii?Q?UkfOXllRS0zdLOV4j+WtNGmXBKmNnZj1AGdb7jHEbAoWfzgJsuO8DrCozUdV?=
 =?us-ascii?Q?w/tRnVGISu2kp7aBwbe53itzqwfbluQ0nlbozM5UTW2ypc/eVt3fqdFxoVFy?=
 =?us-ascii?Q?Azdln5EfMf/h2cg5yObD1PT87wvHMtT/LULndltm/b2Sv3xCadX/tW7bEOYc?=
 =?us-ascii?Q?6AteyQbZ0XPP0uYnb2VO6Y3FOr/hktId6cI/1dkbLOAwuYV4WXW3hL3IXauD?=
 =?us-ascii?Q?JtjiKhd/+SpfYmYloQ9sAzCVQM0uHIJSgdYeZ8hsX8jY7SGr6tK15oQSfbbS?=
 =?us-ascii?Q?7/SDebSYF26SfhN+ZbKUUwntazmfMSAz5dSjglwEsJZOgrSFzB3HBzbNODwJ?=
 =?us-ascii?Q?aYTdKXhS7qCRPhAYP0J+hI4uQ/LVmIMZYzyhhTCEfyvoT3r8csnFOertoA4p?=
 =?us-ascii?Q?OvPLtxqIvzN+rveSXEYmpf3TlRKNfnqqqscbYVDFR6K/c8HXOU8XjU2hER1c?=
 =?us-ascii?Q?YVjxO9+9HjIke59anbnMU5ce6ymET/XK2BgFSWGQFkM0xbcZPe5fOnwuZDV4?=
 =?us-ascii?Q?YD8MAXfCmQho0YF+4NuQsCxuF+by7wchLNCDdwTAdG3CXjXhlZVPO5brykH1?=
 =?us-ascii?Q?JolwAJTKP/XwRMONE4DF2YVTe6ZS5Oa5Yrb6WFnmkOJpEhUhfBKMQuxAlMa1?=
 =?us-ascii?Q?D3TQJimlwedNzErfSgXUK87mmRMp+CIXFRFyV/RIFNB9qihxaaZ/dKHbSmZQ?=
 =?us-ascii?Q?jiwt2Z7GZnEsKQkDEKuu44TyVBt/AirlX5dBgrYvvdGjxUbaHHMqJ/2dTyuF?=
 =?us-ascii?Q?UsrW8XpSJQSHRyR1ai+E3GqS6CsKRiPfpl73B0qTrkNlON5Zbi3SfhwynGVt?=
 =?us-ascii?Q?+v0pdoAHt4uaAc9B97K9Jnn/4kMjiljCEzozTLi6EUfTcnrgGEY9f+KkBOfm?=
 =?us-ascii?Q?97cq0WFSbWN76oo92oMKJmOgQ+VYRkSpQSYI0qvalBbcIWOVM3fxmt0FGf9x?=
 =?us-ascii?Q?fTDjpOH2lkkKMxZd9Y50+0Px1qE8Qa8e0mpFG1pilrdk0P8Ze+Lw3Kih/1Oi?=
 =?us-ascii?Q?z6yX+F0pB4gOJ2RaVXXX+3iVXk38IuZqkeT7mhbgN3y8wgMy559wH4o2q7Y3?=
 =?us-ascii?Q?liA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TUqY4G8+NGYXjVzSKgFZNTqvvLSpXt0taKGguYyT0DNVmgtWS5T0hW/texoV?=
 =?us-ascii?Q?+3M5fZuXGC2YGevDkHSK4Ah+X4nIrG1880yssebjbvic3cnpexievsr8p4Fe?=
 =?us-ascii?Q?ubk42XtnZyO8NCHIVDGHbILdLJcK2HFb9R44/hY1khF/Nq+v7anLMypUI1Wd?=
 =?us-ascii?Q?ib4m0ggMBam1hHFK8ikAzpMBP7RuWKt5tBAiZlnkVsPARrxefcQbrWE4Bhsy?=
 =?us-ascii?Q?2Bw2J0NoNLh7hkmjX//pdSec+vClx7JSKbYBMXky9y2cuZg3MidvwdAdAP2x?=
 =?us-ascii?Q?oK4JXqmTF/402i0e9LhQHYYsEvKnGKnUGsbqgTq2F2OYNkLbgDuXUMAYgOET?=
 =?us-ascii?Q?Q24c6TETdRtFftWPqJ5dxlwct3WbenoHY2E8efzC58YkxLP6MEQbomyMWYq/?=
 =?us-ascii?Q?JGNzhU8l3RjZmRZeUAk0vVh9ZW6c0Q8i2hOYmBbJOmrcFtnBv/3Q8ZcpYUec?=
 =?us-ascii?Q?VcKZEGQq32lvQ5Ql1izWiM53WoKpPJ+k88buyPD9byQQCVN8b9ew40OiqoY0?=
 =?us-ascii?Q?AU3NJz4xwKxr2q3CqbnsiYSB1UNbHbbnTMWenwdkAYDmapiitRmcQbUOPtx5?=
 =?us-ascii?Q?26o1qDeKWfzrdUB9M4ldPlT2cDbut8b9Pa+kJg9ohRNM2DdFz5JJ/nNJ1rxt?=
 =?us-ascii?Q?6kZIsQubFrVCfcsFqxndApF5BftYhjHPeqkknz23TKjzXbWtYuK9vUg9oRzo?=
 =?us-ascii?Q?tLEprY4e0tk44ab89MydHp9M+a8rN6tC1aPD47fKATQed7Bfc4N0chZ7zMc6?=
 =?us-ascii?Q?TI90skAhCYBo7ZDDI4HZEbU7o7/GIP0juHZKbyBQRlRZngt8vwU5InfztUhd?=
 =?us-ascii?Q?UHK82lNgq4T97NYMXl8fOEuVCJ/+BULUhrhxzT0lL6MI3ylguU2vta/pTGf2?=
 =?us-ascii?Q?p6GU2NNAvYefAyx3GZqX0+4kxRN8ZhT3lN42eVFKfd7GYUxzAS7kkTao6Oss?=
 =?us-ascii?Q?iaXyCRJp7ZToykku//t3JzaKuJsXTq9om2iDzPIi/esbAcymwtsdTvHwx88P?=
 =?us-ascii?Q?K7R19BfDqVNFzIUt7904d4EOKU7spr8OhlTV2g3P2Qwq/KebChDkB1Vtqyno?=
 =?us-ascii?Q?OD+rgigweLOFLz96Q4hz/VgAJV/Sk+mHjslyO6logRGOovQqqMrhpf/bowzs?=
 =?us-ascii?Q?ZT0B4ZozH+1Hve0V+FXaSVj0YrtGaJurq68UoZmx3eaIw5kzE7D/6zLv/Afm?=
 =?us-ascii?Q?gmL571b6IRCa8GAL3VkGZH+vlnJbn63dHOBnyh09kRNiub6TKF8lBjEG3gO6?=
 =?us-ascii?Q?Fu6knMxT9ZJoph2ZQB3owZiWblJxutPTpORZ8YOb6f+UUI2NvM03Mf9PUHkg?=
 =?us-ascii?Q?5lk2WL5cbpGnNO4xqAZvHoLNd9H5ANdfJznHKiozxrUz1PxqdZoirDXT605j?=
 =?us-ascii?Q?cTVfbX3EhnHBSmU9ELFYLUxdhZYfAQRlhkspcu2QwTkvA15l1yTDLn1u0wfS?=
 =?us-ascii?Q?wLiJmqLCnfHZNDwZK38f5dzlcL3b1nNleag4NiCsVlhisfMLTkIv5xI/eCfc?=
 =?us-ascii?Q?g/mMF3/PqgCwvSIxeu7sjYclFUNGxBSx/t/M+qoN2K0Y2F2k3lXfFwhtdDwP?=
 =?us-ascii?Q?IZnYJ4KV2zldtwn/0/fRs5k7i6XINCZkkAni5aPsBQ6kumi2ok2e3d/IcKvI?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8043a37-9ba7-4759-05d2-08dcb80f9e48
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 01:07:20.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wyLBlaWy/kXMvc3ZfeGJcKmzvgd0M9iEoalhonZPqeOGJrNjvCIudBBRr3ifHFns8RtfXpzub0umdvW7cy/Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4833
X-OriginatorOrg: intel.com

hi, Paul, thanks a lot for information!

On Thu, Aug 08, 2024 at 07:07:34AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 08, 2024 at 01:18:48PM +0800, kernel test robot wrote:
> > 
> > hi, JP Kobryn and Paul E. McKenney,
> > 
> > we don't see commit with same title in later dev.2024.07*** or dev.2024.08***
> > branches in https://github.com/paulmckrcu/linux, so not sure if this report is
> > still useful.
> > 
> > another thing is the issue is random. just FYI.
> 
> This commit is bad, and the later commit is a fix:
> 
> 316a003bd5a4 ("srcu: faster gp seq wrap-around")
> 
> The 9% failure rate is not atypical, and in fact is a rather higher rate
> of reproduction than we saw in our testing.  ;-)
> 
> Thank you for your testing efforts!
> 
> 							Thanx, Paul
> 
