Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12E2EA499;
	Wed, 13 Aug 2025 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092648; cv=fail; b=GZy0d7QoKSEUSSAlaB+2uJnnxgqGk+Bo7QSFGqFlMAE+D9x0RaZtufw74YbOiF4pm9kRi7lnTV6IOkzj4qaFi4aYBP1qB0BYgumtfjkOiuDCVb57uWwu+LVk7Xwwnt6Xwme5X44bB/TUAMIoECfwESit+6ipTjNT7Fsdoy6EC4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092648; c=relaxed/simple;
	bh=o7Udr8W7O3sJnKTJ+5O2XCE5ud8ydenGi+32BRGRiyk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wy699gOKBOYKBHSDBG0CZZIHloF1LJ7L2JthiimVzRtBLkbnB5aoN5JULtXbI46vKG0/eyEidTyhBDFDBWnoYtOpCW9xNdKDg68ME1nhHDgIU+/fJ/C4WD7w83cAV8PEnKV6w9gkSRBHBTgn4JuSdfdCaELOfUsMLgIIplHpiiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=McPnI70f; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="McPnI70f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755092647; x=1786628647;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o7Udr8W7O3sJnKTJ+5O2XCE5ud8ydenGi+32BRGRiyk=;
  b=McPnI70f5cko5y+uJUSM3qFoYbmdYzrgKW61C0kwtc3Rzmk6ppx8laAn
   gmlH1OUYfedoKKrlP8B/4yvY0gFOnA3VjhMLsAFm+s6vUKcaYodNQk+XE
   uJxIy9i24xqPQP5WzTjf3p0j29pr0+PwDklxjQQTF79LN7HTA5rIaK9Nc
   iQsYHalRs0N1i6aohpQ3TO6jDBBwg6De42UWxuSfsIE07VsQLunQN2Lfv
   X7omC0I6Qx6WfiOCA86IGQA5xcSU6IlD8m1BUPbR5Br4/JyhFI8s1N5e2
   NorCaJ+KagVr+fBVW/OXBzeRblqTxn9mT0APkkboMTdoqquuFfv1OAwPi
   A==;
X-CSE-ConnectionGUID: C0ivZsFwTimVx2NDJGKfYg==
X-CSE-MsgGUID: 7PNMm22nS6SH3Pb39kiUIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="79961103"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="79961103"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:44:07 -0700
X-CSE-ConnectionGUID: 4XtYJahTSf2twOX0LD4Dcw==
X-CSE-MsgGUID: UVPTy5WMTaeOJLGmNsgoeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170687168"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:44:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 06:44:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 06:44:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 06:44:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlQSKyp7+oDnDbIoa6npnHu5wThNW78nWX2dUmnFqVDZWBDII+O/feyVjo1fCT60hth4M437gYAUPY6t31LA+hPktIAx9HKwAIiY6ReCIkS8B2rZ6jOZUjLuwzOsTtuSt/tpJEph17se79KuhgaOa0poCEUNL3hmOfElTT5Rx8iQVQZZRtn2g0ILtdW2NP1nhd2/e+uXn/9m3H5jetQScGjmn9ErvyQITFM3ofuTbiPinlR8uVSigqCxO3SRFLzvV3Gff/eaqxSWKey+u0cUY7uk1zBlsUMc8Vk3JF+cn0tW5SNZN/ik7dCR3RoaxkCahulABb6yIpGUgstx+nKN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Qht+hsH1U1NuPUR57SW+kxb71QLKAW85bZGjRuFz8g=;
 b=ZqSv/B1xdFLhTV3+mqNRzzmpoyEKtGyz9OLnMsXJQ8uyM6aAt6hlB0KD8YGy53FmkB9ozFRdJwZl14qNtDFEIPYG7MDRC8nPwf/hcPycOsQFVzrF4WXqAKtxr5bDMry4Sr2TDwfDNP2Xw/hQL1HwOf+ob4OMHDT+QFtosi77utWXezi909SsJB811FXtCnz4ihVIzIZfm81u/7TakaIOaUPzwkZLbQ4Kfuo+0DFcSfCrqzJPngn0t7pUA48VsefjZfubHOWZtzsFFC2cljZayRSbJICK/y9LSo+zs/PoLxGACc5cnqGz3D2Zr/e1FIIt6Y+1spBHs8tO9TJgoa/UIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BY1PR11MB8006.namprd11.prod.outlook.com (2603:10b6:a03:52d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 13:44:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 13:44:03 +0000
Date: Wed, 13 Aug 2025 21:43:53 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
CC: Frederic Weisbecker <frederic@kernel.org>, Joel Fernandes
	<joelagnelf@nvidia.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Qi Xi <xiqi2@huawei.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Linux
 Kernel Functional Testing" <lkft@linaro.org>, <rcu@vger.kernel.org>
Subject: Re: [linus:master] [rcu]  b41642c877: BUG:kernel_hang_in_boot_stage
Message-ID: <aJyWmUdR0LzIiSai@xsang-OptiPlex-9020>
References: <202508071303.c1134cce-lkp@intel.com>
 <aJY1DsIUQxzq1U1Q@localhost.localdomain>
 <20250813044024.GA2872@neeraj.linux>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250813044024.GA2872@neeraj.linux>
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BY1PR11MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c31f9a-5977-44fb-f945-08ddda6f76e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KEjn7jPPX73jl8kzw2/twlfgrHG40IPkvmF0rzR1H0KnRrbdTQaYVeNLjaLp?=
 =?us-ascii?Q?EHx8LOKnsch8IWHLUEjzufNsR8gfRh7kkg3NnzUYikEA/tj2MkZ6V7kpyss2?=
 =?us-ascii?Q?HNarehRCCUaU33nm/tQHU6Lg3hwpOduNsmPpwcr5efvCAOFUGDHl1wE90SpX?=
 =?us-ascii?Q?+G54H2du8IBK+HH8a4BmiWyl4dD42oNdq8hKpC4h2UiJZWJytXHj9/93Cy1C?=
 =?us-ascii?Q?A9+UCZ57XJwLOEcPXLCtoL7DqgEcRTGdW5G3TsQOOttN6BVXq12YPLVrGZA+?=
 =?us-ascii?Q?ma9ClYZC0em+5HeWyjjtb1NMn4NkaVkfDgCHR59BCWhKprVM4HfCx8fNCvyc?=
 =?us-ascii?Q?TBhV7SHgy1g1nS1ZlpAU90je3GOSqOjM1fsz97m6Sp5N14/kPfvms15VTnBJ?=
 =?us-ascii?Q?oYELrvXdf9pvEy7Ka1c3cEV/+2rUEeAYz75sQAqypAy5CcDhVOiANqKLQJuB?=
 =?us-ascii?Q?bBoz+c7+EZc9oZ1wk1SFrgqIeV+WTznv7+mAgiup8Z+Q+UiCnkIVfjAetKlL?=
 =?us-ascii?Q?kofcQCVG1rpUp9fBIkR2N2gD9p01YozlH0DFTI+Cj3w6l4vxLcLLVYpVdThQ?=
 =?us-ascii?Q?jd8MBPl+VSC5q/7Jr2brlBVBd8LJaD4ff7ihyeGgZ/J7knScO4YdtJi6GuLh?=
 =?us-ascii?Q?Zr0CoN4rK+faZlS8vjc6oNEV0Yoy67LlUyWt6jnCD8UuwrDcV3B3fhTb4efv?=
 =?us-ascii?Q?W07bUdHfwo1g1gjU46p5BK9Y00WCxvTbUAu7fZFBtY2ZWwU0bZbD5HsAP6tY?=
 =?us-ascii?Q?T3OAu+tGDivzY7sjMD0gsnc117PQcXK3Nevtk2kbmiipJk6oaS1SVa+/tEok?=
 =?us-ascii?Q?GTVX8g5DXGMfo/XMfkK2ip+70Wa9h7sw4wRzvXJx4TO/Ad1cnSRR69jheJIo?=
 =?us-ascii?Q?iy/z6MUrdYV8Ck3eViw+zZXpfG4B35NH4MGDCjBX+HBR5u3Ta+YWif1MnE+N?=
 =?us-ascii?Q?egaUDbo+0O+P0SX0DP107auVmCVkFnMe4WLIYZgAF/hFiJsX5K5i+GQyBHep?=
 =?us-ascii?Q?7YNU+WF+jGVTV7yo9RMypOhFZhDJXwzlAsX2xnuPRJABYFG5b0+c6tBZCsc1?=
 =?us-ascii?Q?EJmich4+LcMfxEm1mrEuz1tzm0Qg8MpsW0g9swoU/mkPJGWDRs7nyNOIcCet?=
 =?us-ascii?Q?/stkxusZUEJuDK9V/tEgh2wwkO36t4QSte2sSrYuFUv6qSum0y1cpsX+KcWP?=
 =?us-ascii?Q?1fMAnBSafcqb1gB2/EI+EYwuuHrjZZMcaxiimTHGF6bQuHOO3lZJ7ZbhkIzr?=
 =?us-ascii?Q?3dNzMaSt824/94tQZjnCxLUxtmNUNoAm5x7D4BZf2Sp58jPauw6pQ7KBeK7t?=
 =?us-ascii?Q?lyfrBX1Q+m0AgJ0A+muAYnnYkuuiwjczZMJR7d5T4Li9qabZDYFcjUy40lfz?=
 =?us-ascii?Q?toCwIDdbQ0imkp5QOPIdjEoLO6e3/KUeEBFbndGPEUzO+G2CNxNhrJYIoKvY?=
 =?us-ascii?Q?QyR84EnV4rY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jH3fWSYZIY2O7w//71JnFEkOE2bnSY74XJRHWwmhWa2aasD+Dx74cU0+Qy2F?=
 =?us-ascii?Q?reexwPF5xjkO9FN6vJwUQ6IMWBPPE3NCDHHdDsGlAhHOrQBQrT8BiPX2WkOW?=
 =?us-ascii?Q?IFLtOz36TijfpptiKcLzy6EXWAat60ZFIN1wCqTvAisI8hJVGO/w7dAh7U9f?=
 =?us-ascii?Q?RKhOGnQGYVVgo4TIgbfys39IrQhDoUXQy8HKYqckYbWiRslhY2jfWmbfawG+?=
 =?us-ascii?Q?bikpHbBuZIRLzygAWht0O3LRIw5JJ9VK1mAgtwLSDVfTq3J2kbdqhifrJU+1?=
 =?us-ascii?Q?9E5GCtymy5o6b7jH/F1boT59uToy73o+q6DOy+T8PDf4ReMl2nlJ9zvEuo8d?=
 =?us-ascii?Q?iyg37QEmWxHPo7iDjJcGOcJsxvdu/Bb3/eonMxnFOrK+P5NR8b3agqQ1UkU0?=
 =?us-ascii?Q?LOqQd1c3Fa82pnbzwgMjAebjovlN/IXue70sj0WpzNR6gReKTk5ZmUsmMHbM?=
 =?us-ascii?Q?cWuzPAXUtGVWsXBTeUZ6rXO70kkrEv8Qd6GG6QrykpRq26hLvxZ0MbVI+hfv?=
 =?us-ascii?Q?d7Tqn262qYRSTyA6sN+jl+UFC7p9KCgiP0mes7gvrY85kqzhoDYnLOCvcTvI?=
 =?us-ascii?Q?gmsRwVbkCcF885vAWkAzLN6cznYDJpdi8bUcifY+oR1WW3ybsVI55Xfn6feJ?=
 =?us-ascii?Q?a6kRTfpzfaQWTm5bvt/P/3IAUCTptm7/yWsEDxVbwbWomDaNaaRydYn2gkPf?=
 =?us-ascii?Q?VL725Q1RaRIMLZ+o2pdpkg9IphSbhq0ozwlEq95tXclSpVquZ8yl4gduTNia?=
 =?us-ascii?Q?5vUOMyExmoC3vP/yxVfYR8b8liLR2OIHbtIOjCahsA2YbFd+8bsEPEfrz/Ix?=
 =?us-ascii?Q?ALKmmlYiuiCWao43EQKuKzFYP5H+1j/uqgCOAg+iJYDBlCU7lPV6FQpbtheO?=
 =?us-ascii?Q?1abSp/yJM95IIL5eW/DFXmz2mDaacZw5Svc5TumKro1aDzGuHzHPEqZ5WUhI?=
 =?us-ascii?Q?3WP0PjL+l3ppkZ5XXTAFXjhcFb7bNXAW4hmnM/djh1Z0RontKmGgI1ETHci0?=
 =?us-ascii?Q?BqSFph7rHeeOXitnnWM7qRhcYYoA+1O2l9Bz/92QKgrsb2NVLNJhWVNzU9Jc?=
 =?us-ascii?Q?2hdefk01PHxDX9NGflAsiBuHYR/oNHIGhiA1Lf8BMHAeG2cNca2kc4bfN/rT?=
 =?us-ascii?Q?mV3LOEyUo2Ojq2D95Lh7G6ONxtBUr7khCPGxAvJKC06wbWZo/z/AiSGbuQRh?=
 =?us-ascii?Q?bJO8URkQjQBCUn9kddtgCjFBEkSOjI3hmogcoM1bZz6J10WsQml/tQF/j1xm?=
 =?us-ascii?Q?8ZPLzypfDDV4ZCiH9AZ34hs5nyZw5A4Fjsb0T7zBkzURYFBsImvorstAnDoe?=
 =?us-ascii?Q?R8sag2fY5jCoNmVjO0GELUqmwEmCPObThe7/ffGlMq4cj4A/+4LZ1R/LBFSV?=
 =?us-ascii?Q?vQd8OU2Bw6NQlkw4BGaDnXNmQajSKWmeLAp3qigZZuPkqm5QOcWdM7s0I3Vq?=
 =?us-ascii?Q?YxrrwOGv/Q7Y3xLr1N8WYXrVsepbanu/iPfO+d5M4H8tSY9UvxrAGHsiJTkT?=
 =?us-ascii?Q?1sw+qrLytPrUcm88YsaJzq6Smk+qHaD+WXTd+GMAU2JUDvaRS33jBViKRMhX?=
 =?us-ascii?Q?UUyZhWxMrLUGl68Reoqp48Jnmppnc4J3X65jhGymO3gmPVnuyRfIE6ewHXqd?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c31f9a-5977-44fb-f945-08ddda6f76e6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:44:02.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awGSzWzEX8/6EbBYn0B9YOPJzOoH/J66o3IrYPeJrE7gkgzqHd3jYO4K6Nt37HVkrFbgBRbG9AqRHR0tKjttGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8006
X-OriginatorOrg: intel.com

hi, Neeraj,

On Wed, Aug 13, 2025 at 10:10:24AM +0530, Neeraj Upadhyay wrote:
> Hi kernel test robot,
> 
> > #syz test

sorry, we are not syz bot :) didn't capture this.

[...]

> > Fixes: b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202508071303.c1134cce-lkp@intel.com
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> 
> Can you please update testing results with the proposed fix?

now we finished the test with the proposed fix, it works. thanks!

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> 
> - Neeraj
> 
