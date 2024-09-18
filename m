Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22428EF;
	Wed, 18 Sep 2024 05:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726638280; cv=fail; b=BUq1OFVDNjEF2iwZ4Fe04jsKyStSAkNZ9vr+ESTLpNtbU+x/E7+WOhLYFYItiueqw+kZP4hrUrUFaytLK7lekSUWZyPYQ7zJTVxAVifQQsVY+FqGkstW+fY2NS7cuek1RheeVsPm0QKmWFFcWvRNedMWD5fO9ApoYBzqqa2ysSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726638280; c=relaxed/simple;
	bh=atjAfTs9/3+WkYU5DAXvPlTRfzhvVECvuOYM/BhKlDw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hRjP88unoPz4irpxqfkUfp5xbUsV2LAtRD0CWGvmDvAOyqEXVmUur8J7D/yod3sSEv+HCmAtIX2jl2JYSdnPtcRHLz3LjlNlbhKBV87GZ4YdDLrAjnf8fbexlzEEc/aHRQfn8+s47o+DgN9ZdST1j0644gzQ9B8Jl+dbgWKm8ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eebzEBR2; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eebzEBR2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726638279; x=1758174279;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=atjAfTs9/3+WkYU5DAXvPlTRfzhvVECvuOYM/BhKlDw=;
  b=eebzEBR2MAl9SYh4gaiTkjzFykKv56NHSAJrQTWnqYVAtXSnnUVRouVI
   cszzUorZbqcnTrKbBvSBn5Tn60gxigMtkC9IQUfSnKZPwzFzM+SiCxerN
   pUT9sJfzEggXfogWXTZjB+Rp9qXYRLj66+agHcsHXgLBK36gn+RSkhB5n
   CXV9HkxDs14YxDL0iyFZjeagmuwrxexmpG2rIGeXDZUYARYqWY8RCNkkO
   ERGaiDY3mwtO+0qKKzy/wCMDyLh156RWuJhhmeZSxVUeeo9Btv6Hu2FOC
   Uh3sD7/pb2Sstv1bNnilzfPSNDhrcKtvhRjBeFU+3xLY7LObO9tmnRxNY
   w==;
X-CSE-ConnectionGUID: Hbrqv/XSRLqNQXaAAO9w5Q==
X-CSE-MsgGUID: agvGhMrFTNC1Y93zRnFcBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25651034"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25651034"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 22:44:38 -0700
X-CSE-ConnectionGUID: /H0k4YoYRRqjyMNy833cgg==
X-CSE-MsgGUID: bF1ehEIpS6a/vQdI3rACGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="74419207"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2024 22:44:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 22:44:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 17 Sep 2024 22:44:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Sep 2024 22:44:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePbLkyhbFn3nI/qLV/1iODCIhzF+lL0hY5bIGEjo2+ZoIiKLs/3Os8138WZmh8h8XWsRJr8XsgvYrVPiOh55Ao4C7dA7ge/yXKxqCEEFw0H6gLPL3zuJKxwvFQxh8E0o/1bTfTCbCGS5ProQ7yHGPDm6l7zgE0rxINXOuJ2Gdh70SFbGUz3zZZ7yexFHTG1sTXF+UL9qDzVbENcpJ83gi1Y5JR6npECcQX/Oer5+R7E2fWJhUsHRgaLvUpEaposD+c31HcMhV+GL0tsqQ4pNZ96oSAAq6g/IqJ1FFVm53c9/rbWJYo9MdmPqgLl8YxmNWlGtG2HLWBiwW1nKryZMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzdaOWCzoxZZ6Ipfvq5Q+GEKC33zk03WueQjFz5/bPM=;
 b=Tt3Ij8JTN2fR6k5DQzlnoTZrG/pEZ2G0W2fjXZ/HkYbDMDNmA4qFmKOxLXb0uh8V3sfY6X6WOwZixUImcGmAmV9+OiDREMZJT/p+nE7PwuVPJi3/gNxusG7ZYF6ooqC8t1/V1TQ6VzbcEv2sQIIA09pBgKYHi65Zhep8O9cWUg0yN3LzKyDIYYKuJnD7nP7xNCrTMYJP6wVhNHv1JDBfTzJsCHPBXIA+ZcQP475co3PhrgKoelB2ieXSZH4mP/j52VCUW7TCmZSUu84F0jW8GLnXWszhXi5/PPGF4e0EptVNgPgs/wP3sT956HGyMkgdbtl8ZiSQ7uWcbj0wHgXu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8584.namprd11.prod.outlook.com (2603:10b6:408:1f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 05:44:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 05:44:34 +0000
Date: Wed, 18 Sep 2024 13:44:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <apparmor@lists.ubuntu.com>,
	<linux-kernel@vger.kernel.org>, <john.johansen@canonical.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<linux-security-module@vger.kernel.org>, <gautham.shenoy@amd.com>,
	<Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	<dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>, <linux-mm@kvack.org>,
	<rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [RFC 6/6] apparmor: Switch labels to percpu ref managed mode
Message-ID: <202409181358.c07681be-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240916050811.473556-7-Neeraj.Upadhyay@amd.com>
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 25671fe1-de0f-4673-3a15-08dcd7a4f9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OfTMd5UctsCueFYw/z0DwGQAb3Rh52cI6kxCGSAMBWX0MggGkyScVUQvHNrz?=
 =?us-ascii?Q?85UhV3uYbPUoqd6ZbeCjof3yp+zLM1+Eq17YMf8Mt3BJKCJ1ghM0Ah/uVv4h?=
 =?us-ascii?Q?fFBXps2LDqVi0mzTpllLzkiQj3uuXWpyiXz1wj8D08f3PMBHbRf0d5Qtq1YR?=
 =?us-ascii?Q?QSJTNFm6pc1LY0JZtqlheKQUltLxNuHNjVscOtSWkaouH8x3LCxoUltBcvup?=
 =?us-ascii?Q?++JLAAAI4N6vrV48NxfqryI9oMIbOW6pRnQDAK314HbkgSQ3oOwzJ+Y29sOU?=
 =?us-ascii?Q?zXADVHRkffuW2ZYfCF3Ilfk2mFiC/tgnmFV25bAkSmr/Nr6kT1E1T84ko3ki?=
 =?us-ascii?Q?uu3UnYKRFVKtFvJgubHyGt+PNIyq+IrXacZusD2x3Lw7WU2KtuzEcZDm78ZE?=
 =?us-ascii?Q?IE+M/aoKTpPCWhqG022u7qwZzIIXFs2XKDkRdyJd8hxVExOHgc4pgOEA6zmP?=
 =?us-ascii?Q?Pp9jzcJi3R4qKUH5rYLc0CiVvec7F48XsKgcJfa1j6crfebQiVvWPsu8XPbb?=
 =?us-ascii?Q?j31PnSR7+xWPuVzGcswRArkxxNbGEuSpw/YuxQoPNsWtFRkjz3mFDE3qr15D?=
 =?us-ascii?Q?5Y/cAZAQ59nOuXM2pw5vG0k9JUgMMKjH8wwvfXvwk7IiwMruE+qO2bItKINM?=
 =?us-ascii?Q?riX+I5njOeAgWozTCMSeQJlVAdBXiz+e5ImXf5BZnjVgEu+kj93INp6pt9Dz?=
 =?us-ascii?Q?GFUKiN0bVaDmm+c/CGgkpHF6FlXzZI+N8/7VYGzbIRsxSbrWK6MOOzCthr2v?=
 =?us-ascii?Q?Gm5qmzNFhGVJwBiV7N18iGwv5IFF6cc/nhVezACPZZhe1U+4gI7jxymWkrXs?=
 =?us-ascii?Q?E/8XVf4UNK2d7bB7gSGf1qOGpTNth2YrftYAGlwvArRMEdzfYd5grF0F6dcX?=
 =?us-ascii?Q?b4e/vCt3LB9BtZb6VD6yp/9M4qqAAErg1idvDdR05ZzwdpOGXOt8yfJ+AFUg?=
 =?us-ascii?Q?0LqYGXj+Dq8oXvxW6eiAwjzaKVDPUqVHn+KuVOeSq6Gu3baDhDp7v4VgVuHR?=
 =?us-ascii?Q?Vy27gbKBecC41lgICf2xEV3w+dn1NE/XPRbHGqsKQFpWYldfVMi7KBlids1d?=
 =?us-ascii?Q?eAf2LD7I1Sx/9NfADyILnmex+c1bI1w5sJfhUwDX9Z4/74WglgNfCALM47jw?=
 =?us-ascii?Q?n6BgmuSHYT/pHwiXWsfQfqfYQ9DrA+78dvBHyMBvIa34XLZPE7SiS3nWv1jj?=
 =?us-ascii?Q?J8eUNx+UIh6hhEVo/n2n7vRWy289FznKKs6Bhx3CCqxu9xgSP6fRD7COH2eX?=
 =?us-ascii?Q?W9pe9q60Tux4RTO64qYv39J98sqhUYD8EJctAeWhZ0f4niEnDr5IiVQlsxBx?=
 =?us-ascii?Q?TerrmRk6cPrEsX2RppzfU1Xcx6nvVWt2KWB7T5hCam7g9Yxfp9eANqOYnR0b?=
 =?us-ascii?Q?RrXl0rU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hxlk7CJkTO2pS9mIEoPxVOW5YfXN0uvTP3TCnGMkkUWvWoblIFkAaF43l5qd?=
 =?us-ascii?Q?X/+HP3GcJCkCm64raPykR3tyPftCHM/dRzUgPq98NvHG8XXa8/Nh13jfvuzu?=
 =?us-ascii?Q?8tsuHtjdwb/WzOVOcsnix50IzIvChA0Rnrh2VsqNoQz0SKEpnL+2vFmXv6dP?=
 =?us-ascii?Q?aiO7mC0iLMJJBWXAL8OPPLo/LtK+tJpiGbxtcAsmiIndCbgqbr3OMxLaTS/e?=
 =?us-ascii?Q?q5TvbAzYYCcNrQdiDVLQKVUXVu9BbZpTjP1Mq+jKiIlN4fTzxDXkhXMEpH+2?=
 =?us-ascii?Q?dErPl2RkIkllgXGJqv6tRRlf59CyzqFY9xxsOZK8VrLBVArtfb7bymMVS0eW?=
 =?us-ascii?Q?Ud/g6mO7k1GhAyAebVpuCek6kjyF9X8mhYksvZjVog61UqkdrZyGX+pJSC84?=
 =?us-ascii?Q?2NhwH/xRqILSiaG4I8191/wno7tNAm7A4YOjzYRHhexx4Bc9K8xiNcoOTnwb?=
 =?us-ascii?Q?UgELqios0uo0dquPSfMCb++EfmjGDlEN7fPOeeuS6HLjMSaDVLeeCEWpZjlQ?=
 =?us-ascii?Q?ayKhWPJW85FZh64pWudrfdIVTcqV0iTkGqrZyJnsw82lJaj1ZyNgEinbBUVA?=
 =?us-ascii?Q?CTk/vvu54hKX2JySAVqmQHe56haN+RlVXrKsO9dz/WGhw1yqh5TVcnrmeA7S?=
 =?us-ascii?Q?NPAGKNz0iwNUEWETjgcORLnovCu+9e5+zgznqEaCyn81lHtRxlppCrNmGCPh?=
 =?us-ascii?Q?zMifIjc2+dstgboDq8kTxJK55HfCHzYVQ/VX3jfsnZdxuZYk36kqpeV3IG2P?=
 =?us-ascii?Q?uQnbANnDXihjOCUlqIyxz+Po10DoWTmoe02QZvlWIBA0qc2KRnaNI+C7TbQK?=
 =?us-ascii?Q?BqyBuO0fukaWI/6Fu47OH6T4d5UUShH6tL329iStOLS0s4V1mYocFueqNGg8?=
 =?us-ascii?Q?IotVV/yP46MxHMbGgCsoY/cNcFQqhJE7Gc0MI5BZ3kFiXagEfXl2Yd4cbFDJ?=
 =?us-ascii?Q?fZUqGGQ7+ntw6Z1apvm3JoVE/S1bqG7NscPoWxzhlRq1sELmvi6FdpgK7jqK?=
 =?us-ascii?Q?hTpeqjYT8HDDwa4B6TToBDugQn6gM2+ghrcfx9AHqN1QMFd2ByhqJAtBJJ9+?=
 =?us-ascii?Q?pr/RcNn+YJbhIsbjeNmNH/c0qb6H2q4xD1X7G17sdp7ug9U8NT/2DMJA3H4R?=
 =?us-ascii?Q?dBbgkCdpDXxw7dX74FGUkcdPSGF1KAmfuXqk09hH+ZwBmgnZiRD5YThxE/nf?=
 =?us-ascii?Q?/hINNXovRA/ghww+OvyOX9QKEM+RVG8YlYawyS04fA6LfQgKOmMz3Rjpe5NQ?=
 =?us-ascii?Q?vU5IQAPFTyOwKacnKWdZhb9q975X10MLh4egt0cWw9R/3oDiW9Ws/BS17hCe?=
 =?us-ascii?Q?nx7Nrx/intYbHZQVP8Wh2zeSFfHT+KKAgqjZP2rlULL+yNt9fcGNaPCk6vTY?=
 =?us-ascii?Q?BmjO93h69SiI+0kbn/aSeychymsoo3gJ6J7gi49Mmx4FNDiAe0+ZHyv19sam?=
 =?us-ascii?Q?5d8rzehBx4IujCi0HDuSN529XF5Y/ppqTB6aVKK+Q7jzgRgARUD5SU906Kbc?=
 =?us-ascii?Q?O4b9tscPvu6pq6ztNm4ddciKQSm7ePrWKF0PoEZfH0dmzlq+bDEBjBsE2wHX?=
 =?us-ascii?Q?X+74o8ljKrNV6WG0iGJJ5QPBzP3rCmZ1ZhH/r89950k+Hsuia7nB+VxhpJ5N?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25671fe1-de0f-4673-3a15-08dcd7a4f9f4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 05:44:34.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1wKafqIPr1/oLtOFKd9PLvwcm0iI6c+iY2c2I8jrCqca2DOufI5YVlEF/zm7eq7ue4D8uTtIavQl77khZBrxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8584
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_lib/percpu-refcount.c:#__percpu_ref_switch_to_managed" on:

commit: 59b177cbdc4908a728329b8eec742969a2285979 ("[RFC 6/6] apparmor: Switch labels to percpu ref managed mode")
url: https://github.com/intel-lab-lkp/linux/commits/Neeraj-Upadhyay/percpu-refcount-Add-managed-mode-for-RCU-released-objects/20240916-131210
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link: https://lore.kernel.org/all/20240916050811.473556-7-Neeraj.Upadhyay@amd.com/
patch subject: [RFC 6/6] apparmor: Switch labels to percpu ref managed mode

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------------------+------------+------------+
|                                                                  | 124f137c55 | 59b177cbdc |
+------------------------------------------------------------------+------------+------------+
| WARNING:at_lib/percpu-refcount.c:#__percpu_ref_switch_to_managed | 0          | 13         |
| RIP:__percpu_ref_switch_to_managed                               | 0          | 13         |
+------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409181358.c07681be-oliver.sang@intel.com


[   13.041399][    T0] ------------[ cut here ]------------
[   13.042302][    T0] Percpu ref is already managed
[ 13.042302][ T0] WARNING: CPU: 0 PID: 0 at lib/percpu-refcount.c:151 __percpu_ref_switch_to_managed (lib/percpu-refcount.c:151 (discriminator 3)) 
[   13.042302][    T0] Modules linked in:
[   13.042302][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc6-00143-g59b177cbdc49 #12
[   13.042302][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 13.042302][ T0] RIP: 0010:__percpu_ref_switch_to_managed (lib/percpu-refcount.c:151 (discriminator 3)) 
[ 13.042302][ T0] Code: 03 75 58 65 48 ff 08 e8 c1 7c ee fe eb b1 80 3d 5d a2 ca 03 00 75 c5 48 c7 c7 c0 61 8f 91 c6 05 4d a2 ca 03 01 e8 03 af ce fe <0f> 0b eb ae 31 f6 48 89 df e8 05 f7 ff ff e9 54 fe ff ff e8 4b aa
All code
========
   0:	03 75 58             	add    0x58(%rbp),%esi
   3:	65 48 ff 08          	decq   %gs:(%rax)
   7:	e8 c1 7c ee fe       	callq  0xfffffffffeee7ccd
   c:	eb b1                	jmp    0xffffffffffffffbf
   e:	80 3d 5d a2 ca 03 00 	cmpb   $0x0,0x3caa25d(%rip)        # 0x3caa272
  15:	75 c5                	jne    0xffffffffffffffdc
  17:	48 c7 c7 c0 61 8f 91 	mov    $0xffffffff918f61c0,%rdi
  1e:	c6 05 4d a2 ca 03 01 	movb   $0x1,0x3caa24d(%rip)        # 0x3caa272
  25:	e8 03 af ce fe       	callq  0xfffffffffeceaf2d
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb ae                	jmp    0xffffffffffffffdc
  2e:	31 f6                	xor    %esi,%esi
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 05 f7 ff ff       	callq  0xfffffffffffff73d
  38:	e9 54 fe ff ff       	jmpq   0xfffffffffffffe91
  3d:	e8                   	.byte 0xe8
  3e:	4b aa                	rex.WXB stos %al,%es:(%rdi)

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb ae                	jmp    0xffffffffffffffb2
   4:	31 f6                	xor    %esi,%esi
   6:	48 89 df             	mov    %rbx,%rdi
   9:	e8 05 f7 ff ff       	callq  0xfffffffffffff713
   e:	e9 54 fe ff ff       	jmpq   0xfffffffffffffe67
  13:	e8                   	.byte 0xe8
  14:	4b aa                	rex.WXB stos %al,%es:(%rdi)
[   13.042302][    T0] RSP: 0000:ffffffff92407e00 EFLAGS: 00010082
[   13.042302][    T0] RAX: 0000000000000000 RBX: ffff8881008a6500 RCX: 1ffffffff24a3780
[   13.042302][    T0] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
[   13.042302][    T0] RBP: ffff8881008a6508 R08: 0000000000000000 R09: fffffbfff24a3780
[   13.042302][    T0] R10: ffffffff9251bc03 R11: 0000000000000001 R12: ffff8881001f3500
[   13.042302][    T0] R13: ffff8881001f3500 R14: 0000000000000005 R15: 00000000000147b0
[   13.042302][    T0] FS:  0000000000000000(0000) GS:ffff8883a8400000(0000) knlGS:0000000000000000
[   13.042302][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.042302][    T0] CR2: ffff88843ffff000 CR3: 00000003b6e62000 CR4: 00000000000006f0
[   13.042302][    T0] Call Trace:
[   13.042302][    T0]  <TASK>
[ 13.042302][ T0] ? __warn (kernel/panic.c:741) 
[ 13.042302][ T0] ? __percpu_ref_switch_to_managed (lib/percpu-refcount.c:151 (discriminator 3)) 
[ 13.042302][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 13.042302][ T0] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 13.042302][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 13.042302][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 13.042302][ T0] ? __percpu_ref_switch_to_managed (lib/percpu-refcount.c:151 (discriminator 3)) 
[ 13.042302][ T0] percpu_ref_switch_to_managed (include/linux/spinlock.h:406 lib/percpu-refcount.c:182) 
[ 13.042302][ T0] aa_alloc_root_ns (security/apparmor/policy_ns.c:383) 
[ 13.042302][ T0] ? aa_setup_dfa_engine (security/apparmor/lsm.c:2194) 
[ 13.042302][ T0] apparmor_init (security/apparmor/lsm.c:2235) 
[ 13.042302][ T0] initialize_lsm (security/security.c:263 (discriminator 3)) 
[ 13.042302][ T0] ordered_lsm_init (security/security.c:422 (discriminator 3)) 
[ 13.042302][ T0] security_init (security/security.c:475) 
[ 13.042302][ T0] start_kernel (init/main.c:1085) 
[ 13.042302][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:495) 
[ 13.042302][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:437 (discriminator 17)) 
[ 13.042302][ T0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
[   13.042302][    T0]  </TASK>
[   13.042302][    T0] ---[ end trace 0000000000000000 ]---
[   13.044823][    T0] AppArmor: AppArmor initialized
[   13.062176][    T0] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[   13.065846][    T0] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240918/202409181358.c07681be-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

