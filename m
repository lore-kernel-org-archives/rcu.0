Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13FC1494DD
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740451445; cv=fail; b=GC0N8ZDWkS4mlJfNbrAZcHelhIdJB9v9GlAlr888yqsPlFAscyRlXTbL1iX+sqzddZeGR9xdSIfFnU2s5N1BoV0nAbDfrQLQspS/BDOCCfGBBRvTfTGVbWKEAnmWLtdn/H4vTF2T0pfGI2GUyRtiYYkYk7w7iBQk+1aQEDAxF/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740451445; c=relaxed/simple;
	bh=9bDUfpPWC9M5s/pwA2ywO/OB0tk3x1L1APIIRyct5Mk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UDoQolwCPMCgXwbkZzMHwG8nlRqNDAqdZ/qwY7uJ08xSuTrukoR+IXLocZAs7ydyQ+bWkFG9Ds7Jg8X7LeUTwGy0M980s6JlRBbvcNsYslo+iun0jwAkIg4YTalW1DPwrwpguooWFsBDwbF/+kSHNBXu5ObcelKbhqEmiSohFkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X13z6K8k; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X13z6K8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740451443; x=1771987443;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9bDUfpPWC9M5s/pwA2ywO/OB0tk3x1L1APIIRyct5Mk=;
  b=X13z6K8koLbGnRdN30udYPErZi6ZzuFdRGv0vhCNMq3Q348DxN13MkPy
   5Np6oNhUFuusO5cntfOJuFcrV1qfgzzyTzRyA/ChTt0yOg7hmLXxBCrX7
   jrLs4A/NjoB0XDjBB7+mXBFBZtUDTPBneMKtSnDe0Z8kU1Qo3C0vskTZl
   yFrbAsq5EeMB2JiWYtoba0O5qBMNRrwnTqdK8PzWO6xmrP5/Dyvi0ENLj
   d6kXVcPGH07JSRzv0Mt3Bd+RK97nCmD3cp4EgPZh1M/AutZCnDgy5zZtH
   Dh4Q1VyiFIPz2THa4SiA00L39N3TxOEdlHeTkxgp4/4nrMal6oow9H9jL
   g==;
X-CSE-ConnectionGUID: LX8ho4CUQ1OX1VQzYo0HYw==
X-CSE-MsgGUID: CzkdtZLmSMKPDVty6TPRtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41366442"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="41366442"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 18:44:02 -0800
X-CSE-ConnectionGUID: jtq7EkplSG2VXrfHGaACcA==
X-CSE-MsgGUID: rKxopREHQJK0aJRmpA54MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121225968"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2025 18:44:02 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 18:44:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 18:44:01 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 18:44:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1FHUr2zaCT85Mo++jE5nxiJFJ4nyS+MuRTmemjV/5n6eCvNmQQGD3ZMyhVDlyHXLvQeMhnqJrxbvNI5vwBKPnC0rHv7n9s4QVSK3O5gmwuBLG0iFmxfaG78VbG6Ms+dC3c0Yr2vqaGakDkRtzlb/bgRuqfdMpYfAAGrPA+e85RbYiFQOKK43hAkvQM3hgR1RK3heU2hqYcVVqQdq4DyiR0TQkrdzPjs1jxtXSoCvXtsZoN97yUV++73YtQCca8mfr0J9ykKrWacCGoUfW/P545mViAaWGgdOYFVJLbm9EfOk3xjrJye0K9yHQUtX2gKQ0tuguc+LmDTednBigGjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH1vTCUcEHDddWPqh4xhyjTf1yOctUj9LbGoIHsgZBY=;
 b=dHloSA6wAQo1MzkRcT7jGv0K9QMfFe+u9+K1lHgRwbZkVL3RiQME1eXavta8hjYqNOq63WGRxjBAI97Cu2MwYX7N08tzErDvzBUfxmH2TgO06XeaRaCY81GTHlnwuuowBEK0IgtcQ5PEihnARSAWdTlTGuETaNfun/tmghBnQDkwRt4klhyEDP6MlCwGFLf92csfbbCCN6kLpKXmSt56/E2kRCwwmll2BSI6IoKwJw+ZqTGrVSL2SS6uS+wbJx9iDxx+OhN+anI7Qssvh383rPN/NNN5UAi9dYcHfbYHICe7FsxciMJpJfqY1qxNv2py2q1Tfn4alVN2HikHQiQcjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Tue, 25 Feb
 2025 02:43:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 02:43:54 +0000
Date: Tue, 25 Feb 2025 10:43:45 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: Boqun Feng <boqun.feng@gmail.com>, Ankur Arora <ankur.a.arora@oracle.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>,
	<rcu@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/2] rcutorture: Update rcutorture_one_extend_check()
 for lazy preemption
Message-ID: <Z70uYdsH2hn8kNze@xsang-OptiPlex-9020>
References: <Z7v4MytjhhBZkG4S@Mac.home>
 <20250224044310.14373-1-boqun.feng@gmail.com>
 <07c31e33-4720-4204-9066-e57a708f5ae7@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <07c31e33-4720-4204-9066-e57a708f5ae7@paulmck-laptop>
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB4844:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4a21e6-e243-4bf9-1feb-08dd55463ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gDH8pw/cVpEhpLvsDu5peg8H00PMiE0PFwWglZXVSZ3XfHomubTHz9Ey8N7M?=
 =?us-ascii?Q?UUL78xlFsKeSLp7Mu63oGsNsAr0XW2ciwCtKIjjHu0Ct0ICi6BHalcuY9WnT?=
 =?us-ascii?Q?pVQOfSWKKBLrtkjPNGSgi+b+VJauMsptoxGKFKPTQbI6G/4X/SMbayt6VFNt?=
 =?us-ascii?Q?LJINOFFV5wf+4ZDgIm9IdOMgEcuAxDi/IfB5enHG3uSSdomipBfcUw3xfhkH?=
 =?us-ascii?Q?OhHxQr5GWI5gW8QvP+fV7piSLIB3pTDQY7vywSSbQ7KsdbGyTc/KsO6PvaBL?=
 =?us-ascii?Q?G9rKBrgsNbN3QwSQsF35bYlNLuHTfKIEkMV68nRndw3BzNqwoD/92jEllS9H?=
 =?us-ascii?Q?u/gmiTNnDYPGY3OlSoqaEoASnR31TOUk12l9KqHUMMArOYK+XrSGbBajSI6q?=
 =?us-ascii?Q?XomlydRg1RoiIvG1Dilj6/YLqk+9H6py1olQILHneauy8gfSNwkOcngjpMV4?=
 =?us-ascii?Q?uKiNqdrLxh0qiNrH+DSbpRpHk0e6K+I5rqGA5D0doC6GuoOkgTTNGA8c+Nrp?=
 =?us-ascii?Q?N0EcsskccQB8Lmu6y4WGultdcczXIUzzcHxWLZoRnIDk06gZC0NoVmb7HfxX?=
 =?us-ascii?Q?fgQPe+JxDJ4B/qensQVeL6XcMgYARwUsh49zy+oYS3t0zecpGCFfPDVZUcBj?=
 =?us-ascii?Q?V2feFYeN21NDXB7bn8ERHRxtMtU69PxDXFM/DssyXfHTnbhFlkm8OaDluIi5?=
 =?us-ascii?Q?NxhVeBoyQXukF9gn3Q1MaIEVj3Ir5szkE6D54AzIvoT/vVKnGSn07n0DSCo5?=
 =?us-ascii?Q?srxBx1GWzUOFSsemNBtA9gjf6Sw00ALZ+Hz3pOQSyH2BnPeP8O4Z4LUGjDp6?=
 =?us-ascii?Q?JoA0r00/661rGzhjNI+uysiTlOEkCIRPDE4gFImpe4/gLhwwk/VuMtopubl6?=
 =?us-ascii?Q?TqsTqdyjU10G7ttSHVmLGAu1gtM2f63ReQZl6i/1uX2DKEOqcisWocpoImAM?=
 =?us-ascii?Q?eDnpnA0O3Z8NUe0tRtAGuiQyIffIhWkj7ANcGQMJEj3hDgcvCBOh1esHJr1H?=
 =?us-ascii?Q?X+r42bZBvunqk51bfYy24Q9eT7ok7SgxOHki3EFVNfks5E8zTRXYaKX6G8F1?=
 =?us-ascii?Q?I0YHajtijdogbHbPvTbuXkY5S8ynxnxd6wcpPcUVljrUOJJJXHtaWv7YZ0rG?=
 =?us-ascii?Q?qK2Gdq0ylF880ioP/67iBhtF2E8d81ZNo86am/UuFaV2rvSLVyXLUedCrJwP?=
 =?us-ascii?Q?Q1j+4C+2h1na01GyHbtGbNdqvKl0tseth6T+O2cEhwEbjBmEPFbqo/JMbooL?=
 =?us-ascii?Q?5yf7ROUkuS2RNDmxRDapleTy9axcgwa1dDIIFXLk08IQK2QgTIpvETKXaaFt?=
 =?us-ascii?Q?ZFfSkZXqya9vIqNXXZ6NzNVwIgvqVt8mHM0D2XA77yFFdXvEC7xbqlaopIys?=
 =?us-ascii?Q?63P1JuvM1+tzeuJB8r65VBCoMurQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o9apCDgIlolu4YMn42Nrz9qTqtLWtDA8kMg8jURCnCLf8orxrKT9c5Yoj/UA?=
 =?us-ascii?Q?4gJo6s3JBRDKIvVL7ogLNVGvXPeMxVxKS3ujXfbN6GlSKi2C7XSBALPTQPrT?=
 =?us-ascii?Q?fxO3kz7GD728Ot+2Vxd+RUP4xwCTx7KY0c0xmBIEb8XGH2nCF0gGd/51Y2DW?=
 =?us-ascii?Q?i85xjA+KTiqZjXIolj7oNvTc1Ks+/9XkhsL18hQjDCBCtEm7NevF5o/7ROOz?=
 =?us-ascii?Q?In4xGGFSHK3i5+jHpkVX7s1M7HJSGupH2T+z6bIqR5yX+vdSZCwkGnQi1CYj?=
 =?us-ascii?Q?YNyzu90AhjCjMZHQKqW6uzJeYBHNHRJ4+EyQ3qLch/sVLl2R5PwdBlwvNnGk?=
 =?us-ascii?Q?TNrF7WOj0tr58lkllGXhfOqa5T+duuzMA4CJAYjax0I/KEOMfmfrAHSQ0nLO?=
 =?us-ascii?Q?lVEEXWGcNVQqzUxFQc+CqCMPv1TZJZr6oUw6zkz2H/NF/TU7FDEK2soFizFN?=
 =?us-ascii?Q?p0kavcv6vKLF7iUF2jEmWfgFZGgnPFzGUpPnTlbndg9GEvVgXguZlcbjrCpq?=
 =?us-ascii?Q?7MMRQnb3/i0U1wNgvhcvp/b4DXeMr19eJr7Ptb+FSmjPQvP99uB9fzBZF0Sw?=
 =?us-ascii?Q?aK/Sr9EiYtMc77A8dMF1w2w7kHx16tExQPYa2lhLtd3UBtsB7ZDVVUb6kn2z?=
 =?us-ascii?Q?nHyJ9UcRv7ItdC1Uv/QqjzbMpnlMq1IV/YjVnXs6kWGXgWMThWzOTrLY2SVP?=
 =?us-ascii?Q?VIs5qT9m8mLDn5dPsj8tiACJiirolgTBabCQjAhqx+yY1cA5doPbHg9nf9bN?=
 =?us-ascii?Q?tl3ZL8WF0Il1agrmTu7XBHLjY7eI55Eogwy7dpoePzyFB04MWB2vrj7Dy92S?=
 =?us-ascii?Q?Eo5IT1SqrgcH20F0JWRW299o0MwB+xCpwA7nqNhA7gskFCG+MZnteIOTd/rP?=
 =?us-ascii?Q?gikJE7fnhX3JXbWLsBPfmDL3KD1N1YBEBmXHrgbfpmHABp6erJvWlkJleRSH?=
 =?us-ascii?Q?58ZVvFvI4wCK3aEBGy3bNZMm3+YfO7pMWbCbtjgl3kpZFqZc9elZy7QQvr5J?=
 =?us-ascii?Q?A31IRbkyVbULfRsy8UnonOTyg2AQAKAWhitd3B3ScYjV7QIMnpzZB36SFEC1?=
 =?us-ascii?Q?YAXfLDEYnsrQOj90LAfBj5ymk/JOy4Wf4zrRLMfALCAj98hvg/gbxWfE+PFS?=
 =?us-ascii?Q?zrY7Xkhi1lRizc2J16WIYkt4HdgwVNncqGA92rB8tlSNlB7IaZNt/GcqL4Zk?=
 =?us-ascii?Q?KPM7Q0VP01eM2cRkE5HJZ1NPTLXlxBPbLvo62kxDxAa5CpRaT/U7O9fgOsar?=
 =?us-ascii?Q?G7SXBF4Rj8yQltYpfPFZPIOVdFAhpH0FHaUVnglWxbuFBhcp+6F9OcdcgQik?=
 =?us-ascii?Q?9On9AvGi8McRYW0Czv+78FUjzvhaZuVNo29lOnmAxZYOR6EKvsSdsh2EOwLL?=
 =?us-ascii?Q?QwIDwGCdBvZnOFtOgpiP85nTUWS0oA3A++TspFt8XSui0/Otlb35l2haQ+zx?=
 =?us-ascii?Q?0yCSPZnOmFuRakwLMnsR2staUMehJBapx0xbXVBITFsF8XWSIkitRVxKQ/fs?=
 =?us-ascii?Q?P94LhPZ3u9MtlLqBXLrP7+wu0gcXThClLKMFo4G54aNLfnQ0yE/2SfBAcaU1?=
 =?us-ascii?Q?PYxQ4iKCDpt9uDIoziT/RWTiMnPhsbXRHev4rTBpzp0rcITZnrSYXS90BCjA?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4a21e6-e243-4bf9-1feb-08dd55463ee8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 02:43:54.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PDvDAr/SAr+8JPHBnMvAL6X6fu4KBRqmO5haWDASl79W5JYmzk8tb7JgQQv7A2z8aR06ObiZMEv0h5Jpz69iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4844
X-OriginatorOrg: intel.com

hi, Paul, hi, Boqun Feng,

On Sun, Feb 23, 2025 at 08:58:16PM -0800, Paul E. McKenney wrote:
> On Sun, Feb 23, 2025 at 08:43:09PM -0800, Boqun Feng wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > The rcutorture_one_extend_check() function's last check assumes that
> > if cur_ops->readlock_nesting() returns greater than zero, either the
> > RCUTORTURE_RDR_RCU_1 or the RCUTORTURE_RDR_RCU_2 bit must be set, that
> > is, there must be at least one rcu_read_lock() in effect.
> > 
> > This works for preemptible RCU and for non-preemptible RCU running in
> > a non-preemptible kernel.  But it fails for non-preemptible RCU running
> > in a preemptible kernel because then RCU's cur_ops->readlock_nesting()
> > function, which is rcu_torture_readlock_nesting(), will return
> > the PREEMPT_MASK mask bits from preempt_count().  The result will
> > be greater than zero if preemption is disabled, including by the
> > RCUTORTURE_RDR_PREEMPT and RCUTORTURE_RDR_SCHED bits.
> > 
> > This commit therefore adjusts this check to take into account the case
> > fo non-preemptible RCU running in a preemptible kernel.
> > 
> > [boqun: Fix the if condition and add comment]
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202502171415.8ec87c87-lkp@intel.com
> > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  kernel/rcu/rcutorture.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index d26fb1d33ed9..280bff706017 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -1873,6 +1873,8 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
> >  #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
> >  static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
> >  {
> > +	int mask;
> > +
> >  	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
> >  		return;
> >  
> > @@ -1902,8 +1904,16 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
> >  	WARN_ONCE(cur_ops->extendables &&
> >  		  !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
> >  		  (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
> > -	WARN_ONCE(cur_ops->readlock_nesting &&
> > -		  !(curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
> > +
> > +	/*
> > +	 * non-preemptible RCU in a preemptible kernel uses "preempt_count() &
> > +	 * PREEMPT_MASK" as ->readlock_nesting().
> > +	 */
> > +	mask = RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> 
> Good catch, thank you, and it looks good to me!
> 
> Oliver, you are right, I was looking at the wrong console output.
> One of those days, I guess...  :-/


we tested this new patch-set, and confirmed the WARN we reported is fixed by
whole patch-set. thanks

Tested-by: kernel test robot <oliver.sang@intel.com>


just want to confirm one thing, we applied the patch-set as below:

* b9aa59295f037 rcutorture: Update ->extendables check for lazy preemption
* 5ffd825e807bd rcutorture: Update rcutorture_one_extend_check() for lazy preemption
* c9b55f9da0d2c rcu: limit PREEMPT_RCU configurations

we also made the test upon 5ffd825e807bd, which still shows the similar WARN.
is this expected?

> 
> 							Thanx, Paul
> 
> > +		mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> > +
> > +	WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
> >  		  cur_ops->readlock_nesting() > 0, ROEC_ARGS);
> >  }
> >  
> > -- 
> > 2.39.5 (Apple Git-154)
> > 
