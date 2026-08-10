Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644771E1E16
	for <rcu@vger.kernel.org>; Mon, 10 Aug 2026 01:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786323823; cv=fail; b=d7+vEHqKI/Dp8zlsOzfDIYAjY1IPIJvMmuzGHt9358XsYq0AxvwGQV9ldMJcfPONTQQDYkUaTSpVYG4yAiuEZby4Yulfzjq0x5RmmixGFrrwR8C42cHk9SRdXEmz1CM9un+jZ34aSyzZIe/oK2icZ8jMNz1h7w96cNY0SLn/60E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786323823; c=relaxed/simple;
	bh=UrjX9YMYwWkMP1bBs7CyA6T5UctMr7wO5JRAckCuGIk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=abdAxCz7UWAgMUzfBQifMjDL0csgmd5f7TZtHOWs7qseY3EAGSmVOQ3TEBegO5xtte+NKLp38Ayc5em0gXT9muWWFR4Ncg4dbNujHFq5G54y/+qBhZJvgykG+0HVrwbjWSYzAw4w0Cdp49cHecGWC1rlgti2i1JQ7oL2rakMT+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuGT51FM; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuGT51FM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786323822; x=1817859822;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UrjX9YMYwWkMP1bBs7CyA6T5UctMr7wO5JRAckCuGIk=;
  b=QuGT51FM3ekeNc5zxlj0fztvIxbNx01rBfMpVSio53RQVA1gkYIHZ31t
   ilvIAYe+ShrDhukmchfjFyVhn7rqL9EGHgbs++15aM+iyBZmR+9o0RueO
   eSs9KrWCgm31ktrWEWUn7w2Y44LAGA8Hza2SOM5mnC7C302m9j/UkuI+a
   OHV941Xdx4i8S0jNtYPJuZ0KcjA1roetxrOB7pW+B5BQWPPsT5vvYeyv+
   P/TPxnQa8qqWrOOR2lNuORNWi/GAkWozgb9Sla+ZO+ijb9a+Jwn1sa3O7
   Rl6OSXFSvYOBhcK9BAbGedP7EAV8krHKtLfj/NJecLG3gRWyhknGyjTvm
   A==;
X-CSE-ConnectionGUID: VQp4H4rTQk2O15N+I5AC7g==
X-CSE-MsgGUID: yWV02pN0QsS3CxNjcWDVPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="85951258"
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="85951258"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 18:03:41 -0700
X-CSE-ConnectionGUID: QSVSzc5YT0GBxMoK7DE42w==
X-CSE-MsgGUID: fHXh4ACOTFShbrhHmi4dYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="256676368"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 18:03:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 18:03:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 18:03:40 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 18:03:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPKXa31VH1xbFUI27yMyPJL4u9e4IiM0NC/yCfM61jQV0Zl5LxpE4dErNidW3vieblJEbDAO5U7GboGGzlilulISvVCFVVLHmDNpFz5xtAsZcOt7gvhrj7Jp+dXPoIY3lVgrG1Oj042NXl0/FoVAQFzQ93mz7YdOuYgIcFFP5NCaMiH8Gyu+vHrD83Nbiqv4GTNl5J04EF4pbn3ZxDVqN07Gke7uG+vEu1r+1mxYvaRDZp2pCkumPRASiTJUK32gH3Yk1DpZTSd3+BJ73DZiIAg7M8rSgmUtcV13A7eaEEcRD6PKxCdJA4Ldn3EnAqzMzdqRBo4lITaC2piQcCQV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdeDsyfaxJKHCklVWq9YWVeSizWe1ttBZXEEUbtfCbY=;
 b=dNzLrtWRlC4+7FDHdVZUVJZXjfjUxG3fupFA/giBI0NDezHCx4ntARrIM9ADtiJGvcX5VdWPRGogZDjdkINvTmlU0oltAY/QTbc/0OwkJ20ilxbe2XWfyEBWAEIY4qwT16ok58vs1rlSLSKUM0vLOuEj0U70WzEaDasKpn2v+ors5Is4tqFh6KYTBCeNhhISQPGKlJfbUIWzeFg5mKcqgqopZ+xSVheYydto1VcWZXVvtpqonWls3/DkoLEioy3Xnq84FavrbnGVihwVH7r4DOdrm7kM21od1dBQSeZQe0VaYsBLDiwkkRLpLvdirK4QufOuVNQbTFMY10nPAyuJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by LV8PR11MB8605.namprd11.prod.outlook.com (2603:10b6:408:1e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 01:03:31 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 01:03:31 +0000
Date: Mon, 10 Aug 2026 09:03:23 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Zqiang <qiang.zhang@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, <rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [srcu] 05c3e88488: RIP:cleanup_srcu_struct
Message-ID: <ankjW6lqDkCF5iHW@xsang-desk>
References: <202608060833.bce92909-lkp@intel.com>
 <2b6ec84c0a2469eea964d881de295ae2e156713b@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2b6ec84c0a2469eea964d881de295ae2e156713b@linux.dev>
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|LV8PR11MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: e52fcb8c-2154-48ef-ce72-08def67b321a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|10067099003|6133799003|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VynZlZ2P5PJIikAXDN7aH2yZ8r3diZveLYSHCNfR8lgLxHEfLeVoftI3HWc/Gijbc1EQEp3uFAkOYDll5HWJ1wkVhd8W88Z6/jin633fEXNVgY9qYi2JYoDd+TLwsWfPecJtBvDC/upaHqs0fdM6wy8PD5dq1PtGXkqs5XqkKVv91Pg+pNlx6rEQg+fxX0+RfxK9SJRdr/5ekTsEYKwZ8J/4MKhMBQo5WRYePfDXbN+PonrWC4d77gEb3EY9Ja7Qhv1qKN3zFr59zLc0htKDvVW6mr1oIzKfMxm1mSp0tSLeHc1kbGDVhIJO8CnGZRVrEhkAfILe0EBg/XHcFv4gGlEguBmvn9UTKQweL9+AHj4EnjY55PuxBO+Crb8HZQX+jmtM67KvReAEaOw2zgSScEP1xcYuYUEX7bM1KXEG5ns/SUxM3qDTzIsimOvrH5LXWMGTxgbxDzpo8GbQaG1QBJNvu6endGPEQDsJ5YN2KLtMPTNUDUUlYFir//5eEAjg/Mxi986mMuKVHyuRZzumKn9l7WgD65gWMI55q18qGFA13R7bIC+TbQBaxGoq9pvc9nJms8tzINwX/oH9ldBB8/ClzTKJY4A+ZrHMt7g0IJxGhW3rNmDSNiZ6c+AjNpuhhW0GfwVRZZnf+Nlf9jBO3HiM61D9TyjOe2V9cDgdrBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(6133799003)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gXCaNJgLbmOweo/nfVBes/Z9tt1RWBJSU1O6tubdy0g+W+2iMzmNz2X76scv?=
 =?us-ascii?Q?iumcZci9DaMv1lIMWit1qzEzQVvQAe+0Go/aQb15I3MsQvtCXpzUtnXMh4ue?=
 =?us-ascii?Q?IWFbAafXfRQMu0e2IlFw9o/NgQNCpL9v8lngGKkaPjljtY38LHQQvGNqe3pv?=
 =?us-ascii?Q?uWMolvCVt2uVb50Il9Nz9PYJTo34avYmvLAa3zHilPnDBW499lGnQeA+MV7r?=
 =?us-ascii?Q?4vp+Pbc4uGzWsdgxaCqSIWpjLpr805EqTelinNUAwCMaZJk8Y6FuzEdE9V4B?=
 =?us-ascii?Q?YjzkFHAB9gSZDrjlWVkJY6/RKNWhQ1yFiLek8Q/JpmBo6DEML7Xu8qd2TI80?=
 =?us-ascii?Q?4FTfug1h92quZePs7sELoQsdYbxFiwBIdzCMFuSFSWxCkr/u4sL3CIMghNkH?=
 =?us-ascii?Q?Teysg83jTWJhUnwfMQBwXRcjHDgyXoZm8+TaNCN549vi7pZOG0qjmkGIYDdp?=
 =?us-ascii?Q?hdkeM/OEDhrO5NTgdYDshINA9VVXVp9Bc4mXCyzMc0XP4UZ50bZwsM4wDMEc?=
 =?us-ascii?Q?EjYidiBwIam+jPknneYZih4ENxJAbqe41ot5TVf7HAYx9fgFdGZeKza8pAu/?=
 =?us-ascii?Q?7PgUua8sNzofdWtcHucHvE5oOE+ERtSl4aZSJR+t1wQhQAosGPay1FDSSIai?=
 =?us-ascii?Q?SA+5467sI5b9095GF8++79ja1R3b7VzLo3F7dj6LeApqwEn6cWOQ+j1WfyxG?=
 =?us-ascii?Q?FJEC2jKR391Q1XnCG/KirATxeIC97ZVivMjXMzLO3WTk2n0l4q2FsJUbWt40?=
 =?us-ascii?Q?UlmAIN2UzRFaB9BROV2BM9U126Hs8kTCY1sPk7ezd1Kug8aP5NYjq3BuVheG?=
 =?us-ascii?Q?Iusp7kDSEpxLQ7JoeGJG5FtUX9YW8Zlff+Dou+LU0Nzj+dEYRtLcRwRdFR9i?=
 =?us-ascii?Q?7+Afb3nMO0BvmKDYMzSRBNOI4qsDmGwPB0sdSsiOn52ZpmwMmsOzGxJ/MJLt?=
 =?us-ascii?Q?20Zrexlz9fH+kCILTEIfZGfgtBQLYjkIJue/9lla+WIKTRg2hAF6po9BD3xt?=
 =?us-ascii?Q?Cb41dQF6+6OZ7nB1Xln0d/mlxVab5U1JYi1TH7GtMmkopWOCD44lp2Khc2Mq?=
 =?us-ascii?Q?injGjlxiralxOU1NQmmPv3CY8FzBDXiYQrcBHxTRzOOXXj1/osRpBiiPMUxY?=
 =?us-ascii?Q?mUssmOqPcnWPtQ/VxgQeb/DqaJfMSd4EDnwOtY/3xsY5yxJ/mRtUq0ZivXMP?=
 =?us-ascii?Q?/dHUzY/JuQPb+3uwhJMZgyRirHnXkS7W6sebZ8GGYPYPamPt/xDBhSOYzX5h?=
 =?us-ascii?Q?z89/lhY2dYtA77UOOWVep9mZ91hapoYoVmYM7RXtrClsxby3I92zS6TxFPAi?=
 =?us-ascii?Q?o39QZM+IfKxACyimk17W6nHi0nGcnxLdyMdHGB3+u14GLtXrEbG16GV/6BFR?=
 =?us-ascii?Q?wOHAQWTTrgfff/2AxufeuU53aZfizhKV3+DbBoiAmcRIY3WsmcSF2WANJk2Z?=
 =?us-ascii?Q?cOhKc4LDBrD54Dp+JdOz09XlO7eBdJ/b7S6ri4Q8vTCTL46upoZyEri3iGdp?=
 =?us-ascii?Q?x8YHSbVQHt304AxDMhwEdATEcfiTEXPTlCHpf17C0Ud7RgyO/QGxB3/SElQJ?=
 =?us-ascii?Q?GOiWNEIJmSCNe6jsZTZ6QUBf9LjizfErMphWs3dxNCb66Km9Via06IWavoH1?=
 =?us-ascii?Q?WUBJTRmINTYgBJnehdg0ZdobezA2kU1l59sSyqo30+Pu/4aavfNapOs/vMEr?=
 =?us-ascii?Q?/XUJkQ8jRc1M0UU/iy5gXb6LLIUEA2CrciL85gxY8V+bprMIBy0OL7QwqyUy?=
 =?us-ascii?Q?9TwMwznq1g=3D=3D?=
X-Exchange-RoutingPolicyChecked: EjWdGaUe8t8vHQN5XkRKJYm7k0d2LF3fbhVcK01OwVb+d83NCoa8/JBB8C6ik6HxFAZ0hRGV6McEx9zmOqJQuBYS0tsFl0OuFkCzVhZ1YIwVJSCihnlYMDX6Zs8up9yTvF2v+Kam+2Vu4ERZtg5oNZdjtXZk9UCmhr2WpgjPWKLKCWpww85FAZdemDwl/P28vwL9l83hIVvuWDfN97mcTTVzXKQNe5vyfECH/BULgKKIG9oUOFBR0P08gKGG+rvdFC2SnZkM4s2ANSOm96OYrcihz0h65WidHqt0DUcsdj0n57N8qQ/JCuWVvIkc2Gs2QAJr8mpBb0ISXDPsAlIFMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e52fcb8c-2154-48ef-ce72-08def67b321a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 01:03:31.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EEX5WU6etC0xilsOEB5CNamsJqvzpM2zFNxGuRtQjnPKrnzhpUlBBt6ISA9EdpUKdlzvieeOqB5IGGzfzVM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8605
X-OriginatorOrg: intel.com

hi, Zqiang,

On Thu, Aug 06, 2026 at 01:32:37PM +0000, Zqiang wrote:
> >=20
> > Hello,
> >=20
> > kernel test robot noticed "RIP:cleanup_srcu_struct" on:
> >=20
> > commit: 05c3e88488ed8c12129ca04db84e4c02a16d7ee9 ("srcu: Queue sdp->wor=
k when the delay timer is successfully deleted")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >=20
> > in testcase: blktests
> > version: blktests-x86_64-6f5a1dc-1_20260728
> > with following parameters:
> >=20
> >  disk: 1SSD
> >  test: nvme-group-01
> >  nvme_trtype: rdma
> >  use_siw: true
> >=20
> > config: x86_64-rhel-9.4-func
> > compiler: gcc-14
> > test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with=
 32G memory
> >=20
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202608060833.bce92909-lkp@inte=
l.com
>=20
> Please try it:

below patch could fix the issue we reported. thanks

Tested-by: kernel test robot <oliver.sang@intel.com>


>=20
>=20
> The WARN_ON() is meant to catch callers that forgot srcu_barrier()
> before cleanup.  however, it can trigger even when srcu_barrier()
> was properly called.
>=20
> When a SRCU grace period ends and ss_state < SRCU_SIZE_BIG, the mask=3D~0
> causes delay_work timer be queued on every CPU regardless of whether its
> sdp->srcu_cblist has callbacks.  srcu_barrier() only wait srcu_barrier_he=
ad
> callbacks to complete, however, the srcu_barrier_head will not be inserte=
d
> into an empty sdp->srcu_cblist. when cleanup_srcu_struct() then finds a
> pending delay_work timer on a CPU with no callbacks, triggering a false
> positive.
>=20
> This commit therefore add rcu_segcblist_n_cbs() to WARN_ON(),  make the
> warning triggers only when the timer is still pending and there are actua=
l
> outstanding callbacks.
>=20
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  kernel/rcu/srcutree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 35fface51d50..090dddfc7463 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -753,8 +753,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
> =20
>  		// Call srcu_barrier() before this cleanup_srcu_struct()
>  		// to avoid triggering this WARN_ON().
> -		if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
> -					rcu_cpu_beenfullyonline(sdp->cpu))
> +		if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
> +			rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
> +				rcu_cpu_beenfullyonline(sdp->cpu))
>  			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
>  		flush_work(&sdp->work);
>  		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
> --=20
> 2.17.1
>=20
>=20
>=20
> >=20
> > kern :info : [ 42.171416] [ T3271] nvme nvme1: Removing ctrl: NQN "blkt=
ests-subsystem-1"
> > kern :info : [ 42.220396] [ T3271] ------------[ cut here ]------------
> > kern :warn : [ 42.221853] [ T3271] WARNING: kernel/rcu/srcutree.c:706 a=
t cleanup_srcu_struct+0x373/0xa70, CPU#10: nvme/3271
> > kern :warn : [ 42.223306] [ T3271] Modules linked in: siw loop btrfs li=
bblake2b raid6_pq zstd_compress xor binfmt_misc snd_hda_codec_intelhdmi snd=
_hda_codec_hdmi snd_hda_codec_alc269 snd_hda_codec_realtek_lib snd_hda_scod=
ec_component snd_hda_codec_generic intel_rapl_msr intel_uncore_frequency in=
tel_uncore_frequency_common x86_pkg_temp_thermal snd_hda_intel snd_sof_pci_=
intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic i915 soundwire_in=
tel intel_powerclamp snd_sof_intel_hda_sdw_bpt coretemp snd_sof_intel_hda_c=
ommon snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda soundwire_=
cadence snd_sof_pci snd_sof_xtensa_dsp snd_soc_sdw_utils snd_sof snd_sof_ut=
ils snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_gener=
ic_allocation snd_soc_acpi crc8 soundwire_bus snd_soc_sdca snd_soc_avs snd_=
soc_hda_codec snd_hda_ext_core snd_hda_codec kvm_intel snd_hda_core spi_pxa=
2xx_platform dw_dmac spi_pxa2xx_core snd_intel_dspcfg snd_intel_sdw_acpi in=
tel_gtt snd_hwdep drm_buddy ttm kvm snd_soc_core iwlwifi drm_display_helper
> > kern :warn : [ 42.223363] [ T3271] processor_thermal_device_pci process=
or_thermal_device btusb processor_thermal_wt_hint snd_compress platform_tem=
perature_control btrtl processor_thermal_soc_slider snd_pcm processor_therm=
al_rfim spi_nor btintel cec irqbypass processor_thermal_rapl drm_client_lib=
 rapl intel_rapl_common btbcm think_lmi btmtk drm_kms_helper mtd snd_timer =
intel_lpss_pci ahci intel_cstate processor_thermal_wt_req cfg80211 firmware=
_attributes_class wmi_bmof bluetooth libahci processor_thermal_power_floor =
video mei_me intel_pmc_core snd intel_uncore i2c_i801 spi_intel_pci intel_l=
pss processor_thermal_mbox pl2303 pcspkr libata spi_intel i2c_smbus soundco=
re idma64 mei pmt_telemetry rfkill int340x_thermal_zone pmt_discovery wmi p=
mt_class intel_pmc_ssram_telemetry intel_pmc_pwrm_telemetry intel_vsec int3=
400_thermal acpi_pad pinctrl_tigerlake acpi_tad acpi_thermal_rel drm fuse [=
last unloaded: siw]
> > kern :warn : [ 42.233209] [ T3271] CPU: 10 UID: 0 PID: 3271 Comm: nvme =
Tainted: G S W 7.2.0-rc3+ #1 PREEMPT(lazy)
> > kern :warn : [ 42.235107] [ T3271] Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=
=3DWARN
> > kern :warn : [ 42.236721] [ T3271] Hardware name: LENOVO 90XW004HPL/336=
B, BIOS M5LKT1CA 01/06/2025
> > kern :warn : [ 42.238213] [ T3271] RIP: 0010:cleanup_srcu_struct (rcu/s=
rcutree.c:706 (discriminator 2))
> > kern :warn : [ 42.239837] [ T3271] Code: c1 ea 03 42 80 3c 22 00 0f 85 =
77 05 00 00 4a 03 1c f5 e0 dd 47 85 48 8d bb d8 00 00 00 e8 15 ca 07 00 85 =
c0 0f 84 0e ff ff ff <0f> 0b 48 8d 8b 58 01 00 00 48 b8 00 00 00 00 00 fc f=
f df 48 89 ca
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >  0: c1 ea 03 shr $0x3,%edx
> >  3: 42 80 3c 22 00 cmpb $0x0,(%rdx,%r12,1)
> >  8: 0f 85 77 05 00 00 jne 0x585
> >  e: 4a 03 1c f5 e0 dd 47 add -0x7ab82220(,%r14,8),%rbx
> >  15: 85=20
> >  16: 48 8d bb d8 00 00 00 lea 0xd8(%rbx),%rdi
> >  1d: e8 15 ca 07 00 call 0x7ca37
> >  22: 85 c0 test %eax,%eax
> >  24: 0f 84 0e ff ff ff je 0xffffffffffffff38
> >  2a:* 0f 0b ud2 <-- trapping instruction
> >  2c: 48 8d 8b 58 01 00 00 lea 0x158(%rbx),%rcx
> >  33: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
> >  3a: fc ff df=20
> >  3d: 48 89 ca mov %rcx,%rdx
> >=20
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  0: 0f 0b ud2
> >  2: 48 8d 8b 58 01 00 00 lea 0x158(%rbx),%rcx
> >  9: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
> >  10: fc ff df=20
> >  13: 48 89 ca mov %rcx,%rdx
> > kern :warn : [ 42.241383] [ T3271] RSP: 0018:ffffc900049778f0 EFLAGS: 0=
0010202
> > kern :warn : [ 42.242985] [ T3271] RAX: 0000000000000001 RBX: ffffe8fff=
f622fc0 RCX: ffffffff817d27dd
> > kern :warn : [ 42.244560] [ T3271] RDX: 1ffff110ea8e5ce0 RSI: 000000000=
0000246 RDI: ffff88875472e600
> > kern :warn : [ 42.246197] [ T3271] RBP: 0000000000000000 R08: 000000000=
0000001 R09: ffffed10ea8e5cc5
> > kern :warn : [ 42.247819] [ T3271] R10: ffff88875472e62f R11: 000000000=
0000040 R12: dffffc0000000000
> > kern :warn : [ 42.249508] [ T3271] R13: fffffbfff0d0d6ee R14: 000000000=
0000000 R15: ffff88818083c0a8
> > kern :warn : [ 42.251005] [ T3271] FS: 00007fd8541ea780(0000) GS:ffff88=
87ccda7000(0000) knlGS:0000000000000000
> > kern :warn : [ 42.252678] [ T3271] CS: 0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033
> > kern :warn : [ 42.254204] [ T3271] CR2: 00007f7098b7e2c0 CR3: 000000088=
3d05005 CR4: 0000000000f72ef0
> > kern :warn : [ 42.255916] [ T3271] PKRU: 55555554
> > kern :warn : [ 42.257486] [ T3271] Call Trace:
> > kern :warn : [ 42.259126] [ T3271] <TASK>
> > kern :warn : [ 42.260726] [ T3271] ? __mutex_unlock_slowpath+0x4b3/0x53=
0
> > kern :warn : [ 42.262369] [ T3271] blk_mq_free_tag_set (blk-mq.c:4976)
> > kern :warn : [ 42.263861] [ T3271] nvme_rdma_teardown_io_queues+0xee/0x=
130
> > kern :warn : [ 42.265514] [ T3271] nvme_rdma_delete_ctrl (nvme/host/rdm=
a.c:947 nvme/host/rdma.c:2157 nvme/host/rdma.c:2165)
> > kern :warn : [ 42.267029] [ T3271] nvme_do_delete_ctrl (nvme/host/core.=
c:247)
> > kern :warn : [ 42.268752] [ T3271] nvme_delete_ctrl_sync.cold (nvme/hos=
t/core.c:277)
> > kern :warn : [ 42.270328] [ T3271] nvme_sysfs_delete (nvme/host/sysfs.c=
:498)
> > kern :warn : [ 42.271987] [ T3271] kernfs_fop_write_iter (kernfs/file.c=
:345)
> > kern :warn : [ 42.273601] [ T3271] vfs_write (read_write.c:595 read_wri=
te.c:687)
> > kern :warn : [ 42.275278] [ T3271] ? __pfx_vfs_write (linux/fs.h:2733 (=
discriminator 1))
> > kern :warn : [ 42.276750] [ T3271] ? kmem_cache_free (linux/kasan.h:235=
 slub.c:2705 slub.c:6405 slub.c:6532)
> > kern :warn : [ 42.278425] [ T3271] ? fdget_pos (linux/instrumented.h:82=
 linux/atomic/atomic-instrumented.h:3188 linux/file_ref.h:215 file.c:1231 f=
ile.c:1257)
> > kern :warn : [ 42.279916] [ T3271] ? do_sys_openat2 (linux/fs.h:2564 li=
nux/fs.h:2566 open.c:1367)
> > kern :warn : [ 42.281536] [ T3271] ksys_write (read_write.c:739)
> > kern :warn : [ 42.283048] [ T3271] ? __pfx_ksys_write (read_write.c:723=
)
> > kern :warn : [ 42.284669] [ T3271] do_syscall_64 (x86/entry/syscall_64.=
c:63 x86/entry/syscall_64.c:94)
> > kern :warn : [ 42.286196] [ T3271] ? ksys_read (read_write.c:716)
> > kern :warn : [ 42.287822] [ T3271] ? do_syscall_64 (linux/irq-entry-com=
mon.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entry/s=
yscall_64.c:100)
> > kern :warn : [ 42.289367] [ T3271] ? __pfx___do_sys_newfstat (stat.c:44=
6)
> > kern :warn : [ 42.290855] [ T3271] ? do_syscall_64 (linux/irq-entry-com=
mon.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entry/s=
yscall_64.c:100)
> > kern :warn : [ 42.292405] [ T3271] ? do_syscall_64 (linux/irq-entry-com=
mon.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entry/s=
yscall_64.c:100)
> > kern :warn : [ 42.293886] [ T3271] ? __x64_sys_close (open.c:1511 open.=
c:1496 open.c:1496)
> > kern :warn : [ 42.295469] [ T3271] ? do_syscall_64 (linux/randomize_kst=
ack.h:57 x86/entry/syscall_64.c:92)
> > kern :warn : [ 42.296937] [ T3271] entry_SYSCALL_64_after_hwframe (x86/=
entry/entry_64.S:121)
> > kern :warn : [ 42.298472] [ T3271] RIP: 0033:0x7fd8549a2687
> > kern :warn : [ 42.299951] [ T3271] Code: 48 89 fa 4c 89 df e8 58 b3 00 =
00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 =
48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e=
8 23 ff ff ff
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >  0: 48 89 fa mov %rdi,%rdx
> >  3: 4c 89 df mov %r11,%rdi
> >  6: e8 58 b3 00 00 call 0xb363
> >  b: 8b 93 08 03 00 00 mov 0x308(%rbx),%edx
> >  11: 59 pop %rcx
> >  12: 5e pop %rsi
> >  13: 48 83 f8 fc cmp $0xfffffffffffffffc,%rax
> >  17: 74 1a je 0x33
> >  19: 5b pop %rbx
> >  1a: c3 ret
> >  1b: 0f 1f 84 00 00 00 00 nopl 0x0(%rax,%rax,1)
> >  22: 00=20
> >  23: 48 8b 44 24 10 mov 0x10(%rsp),%rax
> >  28: 0f 05 syscall
> >  2a:* 5b pop %rbx <-- trapping instruction
> >  2b: c3 ret
> >  2c: 0f 1f 80 00 00 00 00 nopl 0x0(%rax)
> >  33: 83 e2 39 and $0x39,%edx
> >  36: 83 fa 08 cmp $0x8,%edx
> >  39: 75 de jne 0x19
> >  3b: e8 23 ff ff ff call 0xffffffffffffff63
> >=20
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  0: 5b pop %rbx
> >  1: c3 ret
> >  2: 0f 1f 80 00 00 00 00 nopl 0x0(%rax)
> >  9: 83 e2 39 and $0x39,%edx
> >  c: 83 fa 08 cmp $0x8,%edx
> >  f: 75 de jne 0xffffffffffffffef
> >  11: e8 23 ff ff ff call 0xffffffffffffff39
> > kern :warn : [ 42.301560] [ T3271] RSP: 002b:00007ffdc9d84570 EFLAGS: 0=
0000202 ORIG_RAX: 0000000000000001
> > kern :warn : [ 42.303102] [ T3271] RAX: ffffffffffffffda RBX: 00007fd85=
41ea780 RCX: 00007fd8549a2687
> > kern :warn : [ 42.304724] [ T3271] RDX: 0000000000000001 RSI: 00007fd85=
4b4da0a RDI: 0000000000000004
> > kern :warn : [ 42.306296] [ T3271] RBP: 00007fd854b4da0a R08: 000000000=
0000000 R09: 0000000000000000
> > kern :warn : [ 42.307782] [ T3271] R10: 0000000000000000 R11: 000000000=
0000202 R12: 000055a417335e50
> > kern :warn : [ 42.309390] [ T3271] R13: 00007ffdc9d86703 R14: 000055a41=
7335e50 R15: 000055a417336760
> > kern :warn : [ 42.310924] [ T3271] </TASK>
> > kern :warn : [ 42.312525] [ T3271] ---[ end trace 0000000000000000 ]---
> >=20
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20260806/202608060833.bce92909-=
lkp@intel.com
> >=20
> > --=20
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
