Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DFF4B1E55;
	Thu, 15 May 2025 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747276235; cv=fail; b=kQHFlFRNkcJggZ7ZGppO61Bbv/sBWF6y+JxixFO3XMt2ojCIHz1bLdBvfJmyszOO6QtbGV08HFgTuClvvIPXg+ywwZSYV/eraS2S+Ke7MdNFMT/Yqqi9XP5rbASNB87HVe4UP/ZnnMJoSbYOSqUvZM5HuY/fUcb2Wd2JF7LyaIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747276235; c=relaxed/simple;
	bh=1Z20OmGj8aBKt1SrnCRb7WoVXZj4I1NW9fWNtgnEpxQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j42L/TD3H376+AXhyCKm5TKIKWC/wAXAw9ParoJrWXfKc4Aikyb6CwRL9qfwA2y9HnZKQ3LDkW7od6UelvLuQ2cKbfOkv0PNkk4e86gR69HTnvbSygN9IrFE7zL8aRdot+Czw2/2GgmqYa9dE1WuocEGmS3PJkU//gU3oOeDYl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lrucym4g; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lrucym4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747276233; x=1778812233;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1Z20OmGj8aBKt1SrnCRb7WoVXZj4I1NW9fWNtgnEpxQ=;
  b=Lrucym4ghrkbqOVT+BCGZbKhnVFQ0tvLkY5aaKpma2bjL9bE3GD+RZyy
   ZOOg+Cui43zOi0sI5ImvtdlsG9xOpJbe7nLTGcHSXEEAv1LhU5AZO/qAU
   OySoFoPrBelbW/tdSBJBeI8Qz1MrL2y+GHWozbL/aubzOC/zVFyLtI9W1
   2mh+UxyLxivKDU37w27Ut/7kB8ce+BhIEB0s8XcCqILDST8bH75H1ZAYh
   q9yFKCyIo/QYW+YBAA/SKHQcK1+obYUHhU1PiH2OdXvKPIpB+mK3OdKa7
   gQUeYBRiwxnCPZydNc2cTS0xUNsMYJMTCxLUklycTfz6CYnf7WOw92xQo
   A==;
X-CSE-ConnectionGUID: j5NwIoGoQZq6fpoRK6uMJQ==
X-CSE-MsgGUID: MhkDXqjZQhOdhjJvpqCcOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49180082"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="49180082"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 19:30:32 -0700
X-CSE-ConnectionGUID: /PpvqOW9Q6yyS9Z2n9NZ1w==
X-CSE-MsgGUID: RXlDUqJhT6WviUcmZwOe1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="137953061"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 19:30:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 19:30:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 19:30:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 19:30:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/HfJAYmBbqxXSbD8guedcc3WELb2IRK4yDNqDAa8JyfpsZsBZKdUgrjEAZhoNTFb8W7qzCmMg2mauZud4b4UD2PU7m7PURJJlEyWZseq6MQqYaQQdrkiz0SIj32A2GX8jT/USLXj9JBluiz8YRexlwhOgTk2tlsLsjaiL5pIsiKt0nzL+Yr8/H8KIh4EQ4K9/rF7xo+72Owd4wIS8QU6KhrM1AnlCGbXeQ5zAxHkbdJoKy8KDNkA3Yf8pRkDrvnj3wh1yvCDomb97397yDdgkSK7rzS0lfKCayp0jQbspuTbRoEyOrztzAomCFYeKSOKpJgmxG9czf43nsyRN/glQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ahf4vVpytgCx17a/7cjJVDWC4ndGKs5LgYbdis5PWD4=;
 b=Kx1jzWSbCcUiyO0UPB8OD9FE0RPiP4fIM+XYbHF4svIJxrq4vk3ZWZ2XD/sgzYHASrhwxn97o702lrIWP+twaZ9XpAQ07MLPgIB/30lUvPaOLGLpU70Z/ny5obPMnzK8QX21PdWyG/jR8tsMLJl7v5+INiI8VfXF/UsycQtahQMmM6QHjHf90bsDWe9YtmYd0fKmtOjZl8dcnHoIGmyPnO2ZNR5sFM+Cf+MMGKn79aapzBFYSJFsYhn11zPMI4IchbClASesO0buAZliS5y5TYpWzZBAXGJz1xAmFROOyKtP4qmS/K2HKa+AvYD3acWvsCyKOxUK1j8QIx5ROr9Fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6262.namprd11.prod.outlook.com (2603:10b6:8:a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 02:30:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 02:30:11 +0000
Date: Thu, 15 May 2025 10:30:02 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Joel Fernandes
	<joelagnelf@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [rcutorture]  c27d0d38f2:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <aCVRqvPSZLVaVwmR@xsang-OptiPlex-9020>
References: <202505140917.8ee62cc6-lkp@intel.com>
 <5e4444fb-0c27-4f7c-acbe-e62367f5ed37@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e4444fb-0c27-4f7c-acbe-e62367f5ed37@paulmck-laptop>
X-ClientProxiedBy: KU0P306CA0074.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: d4672c96-a45b-45a8-bbf3-08dd93586acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rqM0Yf7ObyhKa0yR+hSUhYSx3FJ9s8y7PBE2Dg9F/WevI8AyOulFYXe9/MES?=
 =?us-ascii?Q?HePWP0WAplXVdukEmQ06n8Y8iwk2Kr7sUbHGQJjljChXXDtoFEyAMkc3ICiJ?=
 =?us-ascii?Q?oU83VS8BGKs6PWIbsVHdPpTY5OiQmXMVhV2fuq/a1WlimaKrNBWi878KX3k5?=
 =?us-ascii?Q?9fWWG9YWC7ylADFmOGr/KPnBRrpqrTLPsi9vHcDmFQh30xYQ04/PlMArFN++?=
 =?us-ascii?Q?cyHwIne7/XljPdOOFdg9q71Ik1XyHDrY+4ZDdO67iUMiToOfFI3JNqNJbcVO?=
 =?us-ascii?Q?fXkGpIaXUP+vVUuPUYIdgteYRqq9INrPMQHl30sm66K2CWV4KDWe8z5Y7YaX?=
 =?us-ascii?Q?TSK/nfFIF44cYVeafgBD10oCuH3l3cfIU+VzULCWKcCag3+liUKnLMGhnW3P?=
 =?us-ascii?Q?LTeCT2ATeOIED1p2+0Q+EHvd1s9Rr1qg2i4ioymuMuVXeFhqg9uN2P+yEyx8?=
 =?us-ascii?Q?hqr70G0HmqItL7SQWCOCwfvK8ynKXLBD5Iq+LLYgM8tVIRqQp0Hft8z3EUBh?=
 =?us-ascii?Q?pLC/ze/ZMSssNSBB6xXyFN0NSLikTBRTEfj5zsLbzcNBH5piElV4rV71/kC/?=
 =?us-ascii?Q?tAqobJNqyZnOeGVNBV/1pRqbn5eWJHuEW4MjATPJVWimFRiUVrPSVo36ZZYM?=
 =?us-ascii?Q?QobDWiRsCZPIjHBM0IPx6kVpnlHh09MosdxmlfhEhx1hqO6Sx6KeMe557lUo?=
 =?us-ascii?Q?+2NU45Xk7NdnAZ+H4h0bsLG42wGlHtTyZZMp4T5QFEVDiD/DUdlUGfKQA7+4?=
 =?us-ascii?Q?01S5NF5ZKKipobsx5DpavDUcobc+RQINvugxYxNeYTu6M66LaWK69lZ5TGwy?=
 =?us-ascii?Q?euanRwLfuhU7yYnLZJq3vGtuOz4BHO0jPYPLcFPfXwtNY7v/Ps/RbK041hRs?=
 =?us-ascii?Q?hPf269qW7IQ8etcIUuSep1lueeWTVtOUAAGS2TS4R6eX3RZkybtb2jRqu5KK?=
 =?us-ascii?Q?zHB5Fj6YZ4lSsMIth7xWZA40nfeu5f2zLheJyFqmwm5q6xb8DiH0a49wdckc?=
 =?us-ascii?Q?cuiMdEubc4OWhrmfRYd6LFjLKH03XRITnJaFg/bOS9VKc9n8SjFvtUlQ1Hzo?=
 =?us-ascii?Q?0Lid8EsPWef7WM7Tp+4rvnBJBhVccUvarLHV66FmLGNVDln++saeKpF9LnH0?=
 =?us-ascii?Q?dv/ggkFHp5xJ2H5gaYZ8R59v5ulAY9BhiqIUV3L7OPL2zgNmlc+71hdyYQWl?=
 =?us-ascii?Q?UO7rObu/3ZJP+s2gyoGLQSJ5jxOCkOkdzSJpvOTK1aNzuyb0Me5pyjfcDUT9?=
 =?us-ascii?Q?ZYK7l5SW+WX2SyGlKa8CpR3DBggtHQeSqGyzOrC3qGw1CzYabCUXXWWP9KZP?=
 =?us-ascii?Q?DtYtOQWSZ6xN0sT9LzyTaVjveUaKCXCuQoUfnqy/20xHnkI9GN2diD38Bej7?=
 =?us-ascii?Q?DEpLOjaBuxrzW0caLL8J8rkqJXLt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KXNg3gZck9Lemj/dxl4Wd/mrA5zXTqqngA31v15JDJQ9JYN4kS8E8rhTtmYF?=
 =?us-ascii?Q?KeKKxpyvQAOJ7f+GcJ30Rn6DPRg2CwKT7j1pAhqOvUhXAp+2CE3vyjfj0TSp?=
 =?us-ascii?Q?Eq9hinwikuExrGENJGvQqDEAlDWrfN1wXtQ1vn+iBXevxl/1MN7w21GvluWi?=
 =?us-ascii?Q?AlCX+ARbBi0K1QGVmG7Li1KddzvfU+96uGIBLcWEJUhflSWagCrEh300M5S/?=
 =?us-ascii?Q?DBwhsuIMLeg+6ozLIhtjS5XHn9FuM9oBX2H683kBaHLgca4w6pvr8Xifp6T6?=
 =?us-ascii?Q?1t/zdim/5O8i+nE0MZApyAjkugNniS0EC5B3/yq7Hs4sFEavAOFCZ6vtusVw?=
 =?us-ascii?Q?yBNjS1Dg3X53oLHRYEjidOfIH5YpspY3l8FGIjXvYheSLvlZ2FUA8HUpYZqg?=
 =?us-ascii?Q?QkMERYk/5cBmHLOhm4AxHcSjXmsIV0R09aeTX+RwmSgVse85zZTSnqfo8vIx?=
 =?us-ascii?Q?ZppSrC11bLRBdGrTpN4Vv3wsWscvSDruq0IXbwVDjumCvTPPUARu9j2DIHpp?=
 =?us-ascii?Q?SgSJ0fyYQ+1H/98Ix9IB0JJHVSiHo6PnY2fZLsevvIRxwK3/w/qs8yztFDIf?=
 =?us-ascii?Q?DtVv+OmP9GxUhU5nARglOCp8ctvJCOzJV46rY97EzGW8sMNlxE1dxNKhBhgl?=
 =?us-ascii?Q?fAUad/tDdCVT9Xg2ZcP+rBS5+idWBFjvZzNIJSrCC2laSrQWmerxHZtT4lom?=
 =?us-ascii?Q?OjJ5rv77W0V1vxC1M1935cULRBhnpYbE9YJKw5dwy/OXjSchEcqiEcq0OI+/?=
 =?us-ascii?Q?WYm7YS7eKT9pRCCJ40bUi1dD3hTX80RSescopf+o6Ky9b8Du0mOd95yY56G4?=
 =?us-ascii?Q?GAEcJYorM97F6XWWGVmvmfHyYQ7EZbNF62tnyKk2Qy6KdF/13tP+2XsoWYdY?=
 =?us-ascii?Q?vO+W2btCMcliElKenCRf374FRJ5artsUrjiYrTDzWM/TtdgfnuppPohTY31h?=
 =?us-ascii?Q?wtiV+w/EWETuEzyBFFLoiX9oXEnT448B1s7V+efS8/nL3ZADZvCdGFQP/Lqi?=
 =?us-ascii?Q?R+f/QIm5pa1fasu1kBygcH5Mqo8FKDRrZPbIJF/K1U8zU06nhx6qyNYOd72z?=
 =?us-ascii?Q?jS2MPR8HSm2w6IUTcHLQsr52NFKciyNzdDit4VQ5rnleTBSkhDw0oqxUmxyN?=
 =?us-ascii?Q?y3PCQ7TwDJ7ReBWHbclKLDX1K7ZmkykZXRCO/xTECaIWoNkKPkWgfWSv5aoa?=
 =?us-ascii?Q?GELWbrV80g6cBSOB7wZT8cpco3vFiwvrVJ+LNsaCA2eGcJZ2qXblDQHqS5aw?=
 =?us-ascii?Q?co1whzWAmHlGyXSSG7mySe1b35tMQvWbGlKjj94qbUtzpHRKpGzqtxa7w7PI?=
 =?us-ascii?Q?6cvmCCs+Dvvy48u56+nUb2DDOgTKBLogFEiXib+045N+T0xw94FWLIYgjLkT?=
 =?us-ascii?Q?rk1QHScZIuozQYIV2XRRTA61260HgEXFw7Z2rPX/01rYPx2M35tFqMkkhm0h?=
 =?us-ascii?Q?GDAdDPSZgc7eF/wTxtb/FMVi5r1shWnHXin1oG9YgRhimK6s71VOW15nZOdA?=
 =?us-ascii?Q?ixA+2wzl/zcoSnh1j7yGooFx78nGg5rOTdCyACG8NhwTH4Z9gl8mEEtd9F3H?=
 =?us-ascii?Q?AnMnsTS/rtK+wcevURlWooDqmYDweh9X13rl7ykuid7lOLDK1LynCpd8wDFL?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4672c96-a45b-45a8-bbf3-08dd93586acc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 02:30:11.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUJfdxNGmxGxb0VAEk+dHzBmDn/lwlIYyqlUrJyqy6xvhsZQF9MJVTMFhV4qBZzDN20VltVA4BR9afgMjde0qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6262
X-OriginatorOrg: intel.com

hi, Paul,

On Wed, May 14, 2025 at 11:26:34AM -0700, Paul E. McKenney wrote:
> On Wed, May 14, 2025 at 10:47:30AM +0800, kernel test robot wrote:
> > 
> > hi, Paul,
> > 
> > for this commit we tested before, now we found it causes issues in linux-next
> > master branch.
> 
> Good catch as always!!!  Yes, using HRTIMER_MODE_HARD means that this
> ircutorture_one_extend_check() function must check for hardirq as well
> as softirq.  Which, oddly enough, permits simplifying the code, though
> a larger patch.
> 
> I could reproduce this, and the patch at the end of this email fixes it
> for me.  Does it work for you as well?

thanks a lot for information!

what's the base of the patch? I tried to apply it upon c27d0d38f2 or lastest
linux-next/master
bdd609656ff55 (tag: next-20250514, linux-next/master) Add linux-next specific files for 20250514

both failed. thanks


> 
> 							Thanx, Paul
> 
> > =========================================================================================
> > tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
> >   vm-snb/rcutorture/debian-11.1-i386-20220923.cgz/i386-randconfig-141-20250508/clang-20/300s/cpuhotplug/srcud
> > 
> > c795676b5c0a4ab7 c27d0d38f2cafb70a68ca42c410
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :50           2%           1:50    dmesg.EIP:__kernel_text_address
> >            :50           4%           2:50    dmesg.EIP:__srcu_check_read_flavor
> >            :50           2%           1:50    dmesg.EIP:_raw_spin_unlock_irq
> >            :50          14%           7:50    dmesg.EIP:_raw_spin_unlock_irqrestore
> >            :50          30%          15:50    dmesg.EIP:console_flush_all
> >            :50           4%           2:50    dmesg.EIP:console_trylock_spinning
> >            :50           2%           1:50    dmesg.EIP:delay_tsc
> >            :50           2%           1:50    dmesg.EIP:finish_lock_switch
> >            :50           2%           1:50    dmesg.EIP:kernel_text_address
> >            :50           2%           1:50    dmesg.EIP:lock_acquire
> >            :50          36%          18:50    dmesg.EIP:pv_native_safe_halt
> >           1:50          -2%            :50    dmesg.EIP:rcu_torture_fwd_prog_cr
> >           7:50         -14%            :50    dmesg.EIP:rcu_torture_writer
> >            :50         100%          50:50    dmesg.EIP:rcutorture_one_extend_check
> >          48:50           0%          48:50    dmesg.INFO:task_blocked_for_more_than#seconds
> >          48:50           0%          48:50    dmesg.Kernel_panic-not_syncing:hung_task:blocked_tasks
> >          50:50           0%          50:50    dmesg.UBSAN:negation-overflow_in_lib/sort.c
> >           1:50          -2%            :50    dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog_cr[rcutorture]
> >           7:50         -14%            :50    dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_writer[rcutorture]
> >            :50         100%          50:50    dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]   <--- (1)
> >           7:50         -14%            :50    dmesg.calltrace:__do_softirq
> >           1:50          -2%            :50    dmesg.calltrace:rcu_torture_pipe_update
> > 
> > though both c27d0d38f2/parent have various issues, it seems (1) is persistent
> > on c27d0d38f2 and clean on parent.
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:
> > 
> > commit: c27d0d38f2cafb70a68ca42c4105e170862aaf77 ("rcutorture: Complain if an ->up_read() is delayed more than 10 seconds")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master f48887a98b78880b7711aca311fbbbcaad6c4e3b]
> > 
> > in testcase: rcutorture
> > version: 
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	test: cpuhotplug
> > 	torture_type: srcud
> > 
> > 
> > 
> > config: i386-randconfig-141-20250508
> > compiler: clang-20
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202505140917.8ee62cc6-lkp@intel.com
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250514/202505140917.8ee62cc6-lkp@intel.com
> > 
> > 
> > [   76.027193][    C1] ------------[ cut here ]------------
> > [   76.027652][  T661] srcud-torture: rcu_torture_stats task started
> > [   76.027754][    C1] rcutorture_one_extend_check before change: Current 0x80  To add 0x0  To remove 0x80  preempt_count() 0x10001
> > [   76.029893][    C1] WARNING: CPU: 1 PID: 2 at kernel/rcu/rcutorture.c:1976 rcutorture_one_extend_check+0x5b/0x300 [rcutorture]
> > [   76.031093][    C1] Modules linked in: rcutorture(+) torture
> > [   76.031736][    C1] CPU: 1 UID: 0 PID: 2 Comm: kthreadd Tainted: G                T   6.15.0-rc1-00008-gc27d0d38f2ca #1 PREEMPT(full)  4c3e2c742772c0895467dcaa42b0aab115cc2926
> > [   76.033194][    C1] Tainted: [T]=RANDSTRUCT
> > [   76.033728][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [   76.034602][    C1] EIP: rcutorture_one_extend_check+0x5b/0x300 [rcutorture]
> > [   76.035319][    C1] Code: 05 68 e2 69 f0 01 64 a1 0c f0 b4 c3 25 ff ff ff 7f 50 ff 75 0c 57 53 56 68 e3 c9 6a f0 68 19 b5 6a f0 e8 b8 c8 96 d0 83 c4 1c <0f> 0b f6 c3 09 75 1d eb 35 9c 8f 45 ec f7 45 ec 00 02 00 00 74 09
> > [   76.037024][    C1] EAX: 0000006c EBX: 00000080 ECX: 00000027 EDX: 00000000
> > [   76.037760][    C1] ESI: f06ad951 EDI: 00000000 EBP: c7f19da0 ESP: c7f19d8c
> > [   76.038490][    C1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010082
> > [   76.039252][    C1] CR0: 80050033 CR2: b7e17eb0 CR3: 08be7000 CR4: 00040690
> > [   76.039989][    C1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [   76.040713][    C1] DR6: fffe0ff0 DR7: 00000400
> > [   76.041313][    C1] Call Trace:
> > [   76.041825][    C1]  rcutorture_one_extend+0x54/0x4b0 [rcutorture 4a4a34e515cdd0c53b2c18de8a71945278e82895]
> > [   76.042705][    C1]  ? lock_acquire+0xa8/0x1c0
> > [   76.043299][    C1]  rcu_torture_one_read_end+0x1b7/0x350 [rcutorture 4a4a34e515cdd0c53b2c18de8a71945278e82895]
> > [   76.044196][    C1]  ? local_bh_enable+0x20/0x20 [rcutorture 4a4a34e515cdd0c53b2c18de8a71945278e82895]
> > [   76.045049][    C1]  rcu_torture_updown_hrt+0x18/0x30 [rcutorture 4a4a34e515cdd0c53b2c18de8a71945278e82895]
> > [   76.045935][    C1]  __hrtimer_run_queues+0x18a/0x3b0
> > [   76.046555][    C1]  ? ktime_get_update_offsets_now+0x52/0x200
> > [   76.047309][    C1]  hrtimer_run_queues+0xf7/0x130
> > [   76.048063][    C1]  update_process_times+0x25/0xb0
> > [   76.048680][    C1]  tick_periodic+0xc4/0xe0
> > [   76.049272][    C1]  tick_handle_periodic+0x23/0x70
> > [   76.049875][    C1]  __sysvec_apic_timer_interrupt+0x73/0x190
> > [   76.050528][    C1]  ? sysvec_call_function_single+0x30/0x30
> > [   76.051175][    C1]  sysvec_apic_timer_interrupt+0x1a/0x34
> > [   76.051812][    C1]  handle_exception+0x150/0x150
> > [   76.052405][    C1] EIP: lock_acquire+0xda/0x1c0
> > [   76.052998][    C1] Code: 64 0f c1 05 8c 0e b5 c3 83 f8 01 0f 85 a5 00 00 00 9c 8f 45 d4 f7 45 d4 00 02 00 00 0f 85 a6 00 00 00 85 f6 74 01 fb 83 c4 20 <5e> 5f 5b 5d 2e e9 30 3d 3c 01 89 ce 89 55 f0 8b 55 f0 ff 75 14 ff
> > [   76.054753][    C1] EAX: 00000001 EBX: c345d894 ECX: b4a771ac EDX: 00000000
> > [   76.055499][    C1] ESI: 00000001 EDI: 00000000 EBP: c7f19f50 ESP: c7f19f44
> > [   76.056248][    C1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000286
> > [   76.057032][    C1]  ? try_to_wake_up+0x248/0x850
> > [   76.057690][    C1]  ? sysvec_call_function_single+0x30/0x30
> > [   76.058377][    C1]  ? try_to_wake_up+0x248/0x850
> > [   76.059009][    C1]  ? sysvec_call_function_single+0x30/0x30
> > [   76.059693][    C1]  ? lock_acquire+0xda/0x1c0
> > [   76.060312][    C1]  _raw_spin_lock+0x2a/0x3c
> > [   76.060927][    C1]  ? kthreadd+0xda/0x160
> > [   76.061549][    C1]  kthreadd+0xda/0x160
> > [   76.062126][    C1]  ? schedule_tail+0xd4/0x120
> > [   76.062729][    C1]  ? kthread_stop_put+0x30/0x30
> > [   76.063335][    C1]  ? kthread_stop_put+0x30/0x30
> > [   76.063933][    C1]  ret_from_fork+0x35/0x40
> > [   76.064505][    C1]  ret_from_fork_asm+0x12/0x1c
> > [   76.065091][    C1]  entry_INT80_32+0x10d/0x10d
> > [   76.065693][    C1] irq event stamp: 4386
> > [   76.066236][    C1] hardirqs last  enabled at (4385): [<c10f858d>] finish_lock_switch+0x9d/0xe0
> > [   76.067037][    C1] hardirqs last disabled at (4386): [<c24e7ab0>] sysvec_apic_timer_interrupt+0xc/0x34
> > [   76.067873][    C1] softirqs last  enabled at (2260): [<c10bb5d2>] handle_softirqs+0x372/0x3b0
> > [   76.068659][    C1] softirqs last disabled at (2255): [<c24f627f>] __do_softirq+0xf/0x16
> > [   76.069635][    C1] ---[ end trace 0000000000000000 ]---
> > [   76.099825][  T636] srcud-torture: Creating torture_stutter task
> > [   76.099831][  T667] srcud-torture: torture_shuffle task started
> > [   76.101418][  T636] srcud-torture: Creating torture_onoff task
> > 
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 373c65a6e1031..0840153c90d18 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1975,14 +1975,14 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
>  
>  // Verify the specified RCUTORTURE_RDR* state.
>  #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
> -static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
> +static void rcutorture_one_extend_check(char *s, int curstate, int new, int old)
>  {
>  	int mask;
>  
> -	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
> +	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE) || in_nmi())
>  		return;
>  
> -	WARN_ONCE(!(curstate & RCUTORTURE_RDR_IRQ) && irqs_disabled(), ROEC_ARGS);
> +	WARN_ONCE(!(curstate & RCUTORTURE_RDR_IRQ) && irqs_disabled() && !in_hardirq(), ROEC_ARGS);
>  	WARN_ONCE((curstate & RCUTORTURE_RDR_IRQ) && !irqs_disabled(), ROEC_ARGS);
>  
>  	// If CONFIG_PREEMPT_COUNT=n, further checks are unreliable.
> @@ -1997,9 +1997,9 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>  		  (curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
>  		  cur_ops->readlock_nesting() == 0, ROEC_ARGS);
>  
> -	// Timer handlers have all sorts of stuff disabled, so ignore
> +	// Interrupt handlers have all sorts of stuff disabled, so ignore
>  	// unintended disabling.
> -	if (insoftirq)
> +	if (in_serving_softirq() || in_hardirq())
>  		return;
>  
>  	WARN_ONCE(cur_ops->extendables &&
> @@ -2038,8 +2038,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>   * beginning or end of the critical section and if there was actually a
>   * change, do a ->read_delay().
>   */
> -static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
> -				  struct torture_random_state *trsp,
> +static void rcutorture_one_extend(int *readstate, int newstate, struct torture_random_state *trsp,
>  				  struct rt_read_seg *rtrsp)
>  {
>  	bool first;
> @@ -2054,7 +2053,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
>  	first = idxold1 == 0;
>  	WARN_ON_ONCE(idxold2 < 0);
>  	WARN_ON_ONCE(idxold2 & ~(RCUTORTURE_RDR_ALLBITS | RCUTORTURE_RDR_UPDOWN));
> -	rcutorture_one_extend_check("before change", idxold1, statesnew, statesold, insoftirq);
> +	rcutorture_one_extend_check("before change", idxold1, statesnew, statesold);
>  	rtrsp->rt_readstate = newstate;
>  
>  	/* First, put new protection in place to avoid critical-section gap. */
> @@ -2074,8 +2073,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
>  		idxnew2 = (cur_ops->readlock() << RCUTORTURE_RDR_SHIFT_2) & RCUTORTURE_RDR_MASK_2;
>  
>  	// Complain unless both the old and the new protection is in place.
> -	rcutorture_one_extend_check("during change",
> -				    idxold1 | statesnew, statesnew, statesold, insoftirq);
> +	rcutorture_one_extend_check("during change", idxold1 | statesnew, statesnew, statesold);
>  
>  	// Sample CPU under both sets of protections to reduce confusion.
>  	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)) {
> @@ -2150,7 +2148,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
>  	WARN_ON_ONCE(*readstate < 0);
>  	if (WARN_ON_ONCE(*readstate & ~RCUTORTURE_RDR_ALLBITS))
>  		pr_info("Unexpected readstate value of %#x\n", *readstate);
> -	rcutorture_one_extend_check("after change", *readstate, statesnew, statesold, insoftirq);
> +	rcutorture_one_extend_check("after change", *readstate, statesnew, statesold);
>  }
>  
>  /* Return the biggest extendables mask given current RCU and boot parameters. */
> @@ -2217,8 +2215,7 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
>   * critical section.
>   */
>  static struct rt_read_seg *
> -rcutorture_loop_extend(int *readstate, bool insoftirq, struct torture_random_state *trsp,
> -		       struct rt_read_seg *rtrsp)
> +rcutorture_loop_extend(int *readstate, struct torture_random_state *trsp, struct rt_read_seg *rtrsp)
>  {
>  	int i;
>  	int j;
> @@ -2233,7 +2230,7 @@ rcutorture_loop_extend(int *readstate, bool insoftirq, struct torture_random_sta
>  	for (j = 0; j < i; j++) {
>  		mask = rcutorture_extend_mask(*readstate, trsp);
>  		WARN_ON_ONCE(mask & RCUTORTURE_RDR_UPDOWN);
> -		rcutorture_one_extend(readstate, mask, insoftirq, trsp, &rtrsp[j]);
> +		rcutorture_one_extend(readstate, mask, trsp, &rtrsp[j]);
>  	}
>  	return &rtrsp[j];
>  }
> @@ -2279,7 +2276,7 @@ static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp
>  					  (rtorsp->readstate & RCUTORTURE_RDR_UPDOWN));
>  	if (rtorsp->p == NULL) {
>  		/* Wait for rcu_torture_writer to get underway */
> -		rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
> +		rcutorture_one_extend(&rtorsp->readstate, 0, trsp, rtorsp->rtrsp);
>  		return false;
>  	}
>  	if (rtorsp->p->rtort_mbtest == 0)
> @@ -2293,7 +2290,7 @@ static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp
>   * critical sections and check for errors.
>   */
>  static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
> -				     struct torture_random_state *trsp, long myid)
> +				     struct torture_random_state *trsp)
>  {
>  	int i;
>  	unsigned long completed;
> @@ -2340,7 +2337,7 @@ static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
>  	}
>  	if (cur_ops->reader_blocked)
>  		preempted = cur_ops->reader_blocked();
> -	rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
> +	rcutorture_one_extend(&rtorsp->readstate, 0, trsp, rtorsp->rtrsp);
>  	WARN_ON_ONCE(rtorsp->readstate);
>  	// This next splat is expected behavior if leakpointer, especially
>  	// for CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels.
> @@ -2370,13 +2367,13 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
>  	init_rcu_torture_one_read_state(&rtors, trsp);
>  	newstate = rcutorture_extend_mask(rtors.readstate, trsp);
>  	WARN_ON_ONCE(newstate & RCUTORTURE_RDR_UPDOWN);
> -	rcutorture_one_extend(&rtors.readstate, newstate, myid < 0, trsp, rtors.rtrsp++);
> +	rcutorture_one_extend(&rtors.readstate, newstate, trsp, rtors.rtrsp++);
>  	if (!rcu_torture_one_read_start(&rtors, trsp, myid)) {
> -		rcutorture_one_extend(&rtors.readstate, 0, myid < 0, trsp, rtors.rtrsp);
> +		rcutorture_one_extend(&rtors.readstate, 0, trsp, rtors.rtrsp);
>  		return false;
>  	}
> -	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, myid < 0, trsp, rtors.rtrsp);
> -	rcu_torture_one_read_end(&rtors, trsp, myid);
> +	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, trsp, rtors.rtrsp);
> +	rcu_torture_one_read_end(&rtors, trsp);
>  	return true;
>  }
>  
> @@ -2469,7 +2466,7 @@ static enum hrtimer_restart rcu_torture_updown_hrt(struct hrtimer *hrtp)
>  	struct rcu_torture_one_read_state_updown *rtorsup;
>  
>  	rtorsup = container_of(hrtp, struct rcu_torture_one_read_state_updown, rtorsu_hrt);
> -	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
> +	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
>  	WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
>  	WRITE_ONCE(rtorsup->rtorsu_nups, rtorsup->rtorsu_nups + 1);
>  	WRITE_ONCE(rtorsup->rtorsu_nmigrates,
> @@ -2519,7 +2516,7 @@ static void rcu_torture_updown_cleanup(void)
>  		if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
>  			continue;
>  		if (hrtimer_cancel(&rtorsup->rtorsu_hrt) || WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
> -			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
> +			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
>  			WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
>  			WRITE_ONCE(rtorsup->rtorsu_nups, rtorsup->rtorsu_nups + 1);
>  			smp_store_release(&rtorsup->rtorsu_inuse, false);
