Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC0BC2C6
	for <rcu@vger.kernel.org>; Thu,  5 Sep 2024 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502907; cv=fail; b=Qq9LsXig+yHS1Vsjr6318ZTM+rl1G2yBnkiwqB7T4SC/2XvH0HYWzeaTDFBef8ZR6+C4HG8qXbDZw0t8quPV4AEolhp2/eB8W2A/wLw3Di9L0GBEw3SCqEE6BRlhS0rWOQZElgtbbyoUEJPKB3tfc4zqwSEtD8JZMIsDfEfZlnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502907; c=relaxed/simple;
	bh=ueqXrS1LW3t4+AJnVSXgCTn7hQcXYqGWl5j6tnyDUXU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kCd69qQkl+SpblYvV3vjismPa/kF3C1imlkhS0DWWQ7iZVFwdWWGnEv5lgMYpSlM53rSQRbVlchmh2JOLXBn0MXzJgK0NF/bFf66K1Aq/MNUcG40Qg0kS4WYVPY7slESUyGMYguItlB8bN8t/RlrAehc59OTIdTxPSyRIoMrCUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbobklPZ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbobklPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725502906; x=1757038906;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ueqXrS1LW3t4+AJnVSXgCTn7hQcXYqGWl5j6tnyDUXU=;
  b=QbobklPZvsSPGm/LrqIv+cQ7PZJzoGxGBmDbi/Un+LIhJb0ckpiKrBH0
   DFHnuJDGJPm+zy9mB1DCbxOQXu1AiHoNmCVAukV/h/n/5Mr8tX4Ih/Yp5
   9gAl80aeX3UVUjwyYRfdpywnbwQIW1JfD5FJ64SMeAoMo6SSmMJzOfdj7
   4y1lEDblL1AQX7rm9DIt8a26ICtSUah/Xu1yyFllD3G1lGcZ25RpkomCJ
   mLV5fCMnbfQQVwew9kedvtrjh95CjdL+U1Bb1YUyXZmMv1oUoY4HAC4Ua
   Uo0nSVQX0XSixouS7y/r8IUJkc7fB89eAqJf5aMrKLP6WIm0hb4COjMns
   Q==;
X-CSE-ConnectionGUID: tcvEvQLoRVCOohg3eD7WZQ==
X-CSE-MsgGUID: 3uuCqzcfSu+/x+NwQp8Qvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34760979"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="34760979"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 19:21:45 -0700
X-CSE-ConnectionGUID: YZnr1acyRZqDY2QY+TdaLA==
X-CSE-MsgGUID: rkruv50SRw2CpQqV9rTBfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="65512018"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 19:21:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 19:21:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 19:21:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 19:21:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 19:21:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiuUFwt6RRsuqkCDdylOf5BWAJNJuHS9dHg4LZ48Cw/ljNR2u6h5xKc+yFAC9gD04sCqlhCUeWhiT8U05jVpsw9j/LzVLJWCePdWTISMTJmlkMGG7K72FPJRqfoiEy/f5wFlj94MwiuCsO1l+cW4RC2Gx6leOn2FcQLnS4FK1vCV45uZf+i4Zj9h5udfk5tIrj8Y7Cuvi2qSWH/lUk1ZVouwLEMxN+UvOpcXQaaMvs+oEMt4uWAWBuHjJj+HDbSUvltf60qZRF006lG35DTc537WrJAlalimAT53QhJelaUzmxWIlq4Z7j1IA8J7vwcenRn2uQ/BT8EVc2UqhQnEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aq6+cvpcSxy4FiHVJtxUyKV/ktMDU7RTAJVAIOKV4BU=;
 b=AI2r9oVQrnxhO0egEOj3cmNQQKVQe3IpVyZsc/dXpXyNglKuMoJFLob+TFa7ZD+HCVR1hYzLJVcbc9RGMDhL2EK9KvkO9UQU35OXV75lkdegLGeJiG0+YdcVZK+uHKReswRGBhYUohn16ZDPcqG3Oh9T0zBSbokaLyLtHZqA9ch79H1fLpQO3QvYHqKOheEErMMRkjNml3Jwgxhyh17OXZw63FbyqSWI/Gt193s2dLqw7SkIS10P9N1rufoht/1rl6B1n8qidygYorg5HztK8UgCK7LCLxs65VXKSna90qj4DDdPMBQKZtWQRDpQuoWVz1q3f8qjeibOoarfcfe/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB7993.namprd11.prod.outlook.com (2603:10b6:806:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 02:21:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Thu, 5 Sep 2024
 02:21:41 +0000
Date: Thu, 5 Sep 2024 10:21:32 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>,
	<rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [paulmckrcu:dev.2024.08.30b] [srcu]  558049054f:
 BUG:using__this_cpu_read()in_preemptible
Message-ID: <ZtkVrGo+GeyyG2bO@xsang-OptiPlex-9020>
References: <202409031433.5ce7c1e3-lkp@intel.com>
 <474f6fa0-e5b5-4834-9c6c-25549eb6478f@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <474f6fa0-e5b5-4834-9c6c-25549eb6478f@paulmck-laptop>
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 6091adac-6249-4b45-bb4b-08dccd517ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eDS9f08h+hdo9nUfCyFl3yfF2yN15zzXeVOSHzOWO18P5KLQuVWZRMhdeM0E?=
 =?us-ascii?Q?KBP7g/pGtzXDA8VeVxyHzQI9tpTnmKvzdArCM3u75sl4N2hswJgrJWqfVdy9?=
 =?us-ascii?Q?YQKQwq9wtryDk6DFjoVhggdNyv6x1GEI74ru5zT8MP2LJa+HDecXFw+wttYw?=
 =?us-ascii?Q?f1IlP6U8TQa2hyNJudeihVHXFaGptdfup9qn3ORunsb9Socjl0ZE3PMy7Vik?=
 =?us-ascii?Q?bAENcdLK7FWQl6m8DN0NfOMsc/uq1lEs9j6nSNxqjfV9daaJhKdqtB86v5mU?=
 =?us-ascii?Q?XoQGnieQcpRLTZW0asOheims8NwvPRn78JvlyaoMNpIdo65uhctjuV1wpAl9?=
 =?us-ascii?Q?tt3TZ9oEebm1VsbMr2GZSuz+6a8sCtb/sj18yYRVlsAWCncuOG+lqEJ8/ieh?=
 =?us-ascii?Q?cixFbCfTLxEu+63uptNAQlSdBWNiQF4+G34v8mkvAQZo+I41HIwPhJYhNqeM?=
 =?us-ascii?Q?H4qoesv7+K77HmdBIAehZt2KmvfmzHNRRK5WcL4icPWP5X6nk/Vin98Amw+T?=
 =?us-ascii?Q?C/DRd0hzT4U4l0RvB2TTF22NCzKgFRb80nltbvP3Fxs8FubX+94Qa2wi/8R9?=
 =?us-ascii?Q?qb2/UMkG92SVUfv/TQsIy5hfPD+mlEGw4R0Zi1Rs7NtIeA+njxcV+Ns3LOpf?=
 =?us-ascii?Q?X7mhOZxgRlc2W3i59fFT7veRZ7qOvHNJZm85HKOweDLAbGXndXV44dXGiQeA?=
 =?us-ascii?Q?LiaZiRj0+rmulQldPfgg5028QEyIYxeT+5qm4nveIqZEqZillbt7whgWPD9v?=
 =?us-ascii?Q?KLVPOGYsLjsBU4tFanDYXMXocN6i3bi7ZJNkjSURDa/kB0AAEruGp365m570?=
 =?us-ascii?Q?JfSePQDmwxdKRsGbKXD/Fa8PHGuEKq9OsdKciqCyiV7MCNuw5IEEF3wJbimB?=
 =?us-ascii?Q?nYPAzDUGYzwFas7UilMdCuoHsS7pFE+Y3z77YrHZS9S519bsrH8xzxjxzfAT?=
 =?us-ascii?Q?p21eoMTzzJWi3vRJWRAJRPUSnVJvX8aIM7d7iXBTXUPyvXEqHEjRNMajPKv+?=
 =?us-ascii?Q?m8bHjvYOTotFivVLiNuDLtBkVlAD7pqEUdsajJG5pkr0a8C4XXmvDinon6TY?=
 =?us-ascii?Q?ZkBtCumo1wI5h5jboW7Vum6Cw9wPLFZ4EmdDJSaatxoxzCCLgIljKWB1qLEF?=
 =?us-ascii?Q?PSwRNuQT8BNFA28ZmDoVi2GUKsiSF8CztOu6ZhDa8H1pESpLY20zisWiUqag?=
 =?us-ascii?Q?7eQFLrPFKkL78LhSDUbkY9ICgSHkoLVqRPrpROJI98RUP06fn6xZWpIMCWJY?=
 =?us-ascii?Q?Fa6wOooui8U+thEgolNm1ot4jUXaWZQyQ0kdbOj5B2Dzu74sRrfxZpCBlyJI?=
 =?us-ascii?Q?pbHaoxm7PrFIne1ONOcGvh3chVYwbGgoEwhkBePUpdEqOFoNLvZ/JRTMUFQ0?=
 =?us-ascii?Q?l2YFTS8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZjLDRIxDfTOes2uW5csCAtKhP72226fVs8kP9QZTNMVCx8hLPEdLKSUjeHXo?=
 =?us-ascii?Q?EnvL/mnSvc6Nb4KnVRof6/G6YELq91GMBafQQkXmZYxJyCzceWpBd4I/VZgX?=
 =?us-ascii?Q?ZRH5miJkTggQQhJpcbbsrwxAgoq47GSCLA3XGVfi8GZm4TMsBbWpH1sBTO/z?=
 =?us-ascii?Q?tklBc8iAnBGI5Oh62PHPW2Vftwn4hi/ED6RE2QpV0V9p1cOc0//dFgfcB1E5?=
 =?us-ascii?Q?b9pJge+JCpDAmUkOUQXfZxbYH/cYhXTZWaofkKGmUw1GS4HMzZ4tLUPj3+mU?=
 =?us-ascii?Q?iQin/iUF6wzRu87hX1rEs/y5vJOzOFS1wzGjBj6N6PIUWtT1QKw126uFpM/8?=
 =?us-ascii?Q?SUD++13SLHzJR4RnCRA/JCe5wfqB/tfERIVA92GSaKirwFZtBH5TUp+NITSJ?=
 =?us-ascii?Q?b855LdsqpW3leNdwnb8sdRN/srxr68jK+yUwZ2kp6hjXHfKs+VYSzEGmJ+kU?=
 =?us-ascii?Q?k31+0MhYM2HvkjQ4l5dyp0bCztQ+rsgcai4tKyCzKv674Kf3c1zcV/KCxQ5N?=
 =?us-ascii?Q?H5LxuAqTeshiQAwaDrjvtd6G0ZPeDxsfgRaXgi11L6Q6t1Vbm0mL3nMMneBj?=
 =?us-ascii?Q?rUgLu4tEhYLFpX5+XbCrqMwo4uDzNilSBOfwYhwXAGqt79RtGoPdQZUIXTgV?=
 =?us-ascii?Q?2eutaNPuXbwWNRRlbPwl3mmtkLPf8vw1wYmtZfuMBnRUkbh1dPvXio9fIsHn?=
 =?us-ascii?Q?KiumkZr45Xu49huQlfhyX6P2DQhQrFHS6FWid/hPl9RyeMgEJcX5fF0cLwYz?=
 =?us-ascii?Q?OZXCVHeYQrDaiTV/+pfvke58JTGsTIOr1on8VCOXcyOM87IGTbQlE/TQnC9H?=
 =?us-ascii?Q?kc2XtdnkJTqgVhZRK6WCa5zu3Lwrmsbkn/KsSDeNJeiQcxUpLDRnIM1ec3wY?=
 =?us-ascii?Q?AGFbbxf1iCKSLI1AwMdUar+FpTngG6VDV9bbKlLsHi5qAoCjPhZ+fRlUKvVu?=
 =?us-ascii?Q?EHcS5dUTAfMHkduL6LypjN/KEhtD/Z3hfBCY/y0pRA0hs4n4bIQuHGKIj0Dk?=
 =?us-ascii?Q?FUXvFSSAv9rXyZ7jyw768wjLQm8LAWVZn5sMQWFZOPVOddpGAdro6UNjB+96?=
 =?us-ascii?Q?W48eYzg/DbspeG/rIPjeh8dbIvZ+bUMjTpKthriNd1F4bKluuyw25DFbDzE1?=
 =?us-ascii?Q?p+5BQhLXmqNDIz21o0Le0CXtoDYe6B0zrE2x3S2aD0m4W9swmABnB83jtrSW?=
 =?us-ascii?Q?z9uWGY3RtQVpyS8bN5fJaK+pWwGiDigZqNvzaoW7GF5UUSFviAyxPFvQz9Kx?=
 =?us-ascii?Q?cOAR1KXfCCI0s8qFtN5M3/aGpgAoiRRkktMB8BN+N+p6s51ujSGTLp0p+bNy?=
 =?us-ascii?Q?q9o9Au/nQg+PpSu9J9tCxUHS3XZE0umctPGmoV6Yw9cz4xN9YE3cOh0cXm/M?=
 =?us-ascii?Q?zEFi7rvG2IBSChcR5lysKjwLMpbL3AM+NhooySRsfc61TNQayGDzIF7Ypvdx?=
 =?us-ascii?Q?EQWEjKxDbYDRNDJoG7jDyU//Pb+5bESial9FEGRrSkTffBHo10aWGqa3bsqz?=
 =?us-ascii?Q?f2NUZS7xC8MMELf7/8ajd5MbPvc6VW6uw86nS/pRSnEAugrGcKRBBw4W9ttU?=
 =?us-ascii?Q?C6XBZyIYcJY+5YlqzmKBzeOYxfkPaO20VrMTzeIofEbnL2g1dfHy0owfAdap?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6091adac-6249-4b45-bb4b-08dccd517ac4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 02:21:41.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xH+df+oFRNLpJWulwqXXnSasiiSLBpl8jga96lUnhXIJzsy/TNr2kL3fuQL1EIFIopzHizIo1a7FvQAY0UQ80A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7993
X-OriginatorOrg: intel.com

hi, Paul,

On Tue, Sep 03, 2024 at 03:26:43AM -0700, Paul E. McKenney wrote:
> On Tue, Sep 03, 2024 at 02:49:48PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "BUG:using__this_cpu_read()in_preemptible" on:
> > 
> > commit: 558049054fe90985d650a50b6a757943a9faf646 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
> > https://github.com/paulmckrcu/linux dev.2024.08.30b
> > 
> > in testcase: boot
> > 
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > +------------------------------------------+------------+------------+
> > |                                          | ddf16dbef6 | 558049054f |
> > +------------------------------------------+------------+------------+
> > | BUG:using__this_cpu_read()in_preemptible | 0          | 12         |
> > +------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202409031433.5ce7c1e3-lkp@intel.com
> 
> Good catch, thank you for testing!  Does the incremental patch at the
> end of this email fix this for you?
> 
> 							Thanx, Paul

I applied patch directly upon 558049054f, confirmed the issue gone.

> 
> 
> commit 01c732e108f6ea51e1660ad6bd59fff36e653ddb
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Sep 3 03:25:27 2024 -0700
> 
>     squash! srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()
>     
>     [ paulmck: Apply kernel test robot feedback. ]
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 3133646f0b258..637d366a4dc7b 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1239,7 +1239,7 @@ static bool srcu_should_expedite(struct srcu_struct *ssp)
>  
>  	check_init_srcu_struct(ssp);
>  	/* If _lite() readers, don't do unsolicited expediting. */
> -	if (__this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE)
> +	if (this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE)
>  		return false;
>  	/* If the local srcu_data structure has callbacks, not idle.  */
>  	sdp = raw_cpu_ptr(ssp->sda);
