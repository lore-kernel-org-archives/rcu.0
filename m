Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02370535D5
	for <rcu@vger.kernel.org>; Wed,  8 May 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715158876; cv=fail; b=JCcHBvyPqPoi7XAfqfKpY9IK9pab2n5/QeZ/tcUowk0aRaq67AQG4m9q1xsOI/G2pXJB3lEIVNK3+5nWKzIkVAG9NWNpGNxDnmI2LMFHJr4+CeKRUPPrcPyutr3AXYlVsQVDQSeF/aPF8UVShWrGhOmfdGnogm58nkFfuR+JYnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715158876; c=relaxed/simple;
	bh=/ni6WSI6SY6PPiYFYjrLgSPOBQWKncxMeLwIM9O3zCU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N5EtkyST8N3YWG5YhX+3BVMeT71dhPp1IyEw9JgiACAaXTJ4VvRWqF57vG5j+5WuL194Jq6eQCh425OdkaBcn5mmwT2ZWnfETn8E548Batra7rWWI51CdpwVxqR6WdiR9WQJJUM3UamB+ngfWKeE/nSvyMYwHW9wRD0QlwA/LZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTsOuRlj; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTsOuRlj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715158874; x=1746694874;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/ni6WSI6SY6PPiYFYjrLgSPOBQWKncxMeLwIM9O3zCU=;
  b=HTsOuRljRo1Dg+9Bya885lDbMaQ914E5lykv0dZDd8yFGYgtfw/Tajs9
   E3E07rOCBV5Ni/fgk+m8n2DycB6/Di+7YOdCZDDXhaWiBl3mP9+4V3hew
   XeT8l64rsV0yLPptBHXSNo8f1Y/LTshPmcfTsoxfgjSIMPwt4uUxxauUV
   iludIA04Kn353BmiWJ8QJbAs67UbNv2fjxU3zyj+SvSXfiZ4qUNAcboFF
   L98QO5gWG51vedWoCrq1aOUdpuHQNes+HLDZxa3JCYNumQX7cX+g1avbk
   kuuQit8suHiCRVLMut877XRM0GELIU3Jgjmwb5S5xiKoZc91ZGskS5Ze0
   Q==;
X-CSE-ConnectionGUID: 8oW35CGcTS+Hqa9mnKx6Zw==
X-CSE-MsgGUID: lCvzPUqGRcSlU/RbH/HqCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11130429"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="11130429"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 02:01:14 -0700
X-CSE-ConnectionGUID: 9EmJBxH3TuSRw6WubHLGBQ==
X-CSE-MsgGUID: fZZJrtuZQ0m5srkH9hPvqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="52029313"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 02:01:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:01:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:01:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 02:01:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 02:01:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTOL3ql0YhoB4IVo2fSFjJvF4uRHG/ijnhIpzZiinu2vVXOBTff351Wm+PAgQ3aoEBeenjKlEINHB7NGPpe3/V/IgLCLfVQeZakiQucPi01d8jrHtdmfFBBKoYO0UTMUobyun1F47NOXvrPCkS67qT0vCoB0CEfavNOFhNw2ecPaOu8qSApg7YuJAbYIpQFXm451jJAo8hRo2QzV3AqlSKKbvZYBV0/NWBgRxV0P/Eox9YB8UM4EXnDAEf2uZ+Naj2XvvIfzK0q47FdL4EKCRMiY2HBl+Wz475qxx4rA1fNqxzJaUDHKiZGK5KiKDbMjcytTQhwGMHIi+q2Z7P3xfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV2crWyETajLLrkHEWAKJz3FE9E/3/2+5svwH0AVemk=;
 b=h40HxNegRIwLxxN23R5OyhRK97g+eX9CAe9fo1Jt8bU9Lhv3l4Zo/FgPdmW604NpKV1fXVsMKnXpRHaZRqvHzNWo1SiBxNSzzJwl5w+GQLSm/p0NodEIp/+zmX2652T9DkaOT+jz6l4waWAQTNuZOyzdHgyHzOZ+3MAK7jmRjXfZoYLyxi9qwa6DN9WZ7bbMYyAgOqbiwJOA4Tvqb3o7rPQKrlSl4kwNuNH9Pq4FWP6hC/Bh5m9k+wxxRTKjcz+jspcvGuigN69YXUZmpwUgisOBNBEakc4SZA3O2tmlYe5wtvArFqWJOvomUZU3xxRHfwZZYYTC04eBq+hHY98aLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6996.namprd11.prod.outlook.com (2603:10b6:806:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 09:01:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 09:01:08 +0000
Date: Wed, 8 May 2024 17:01:00 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Z qiang <qiang.zhang1211@gmail.com>
CC: Frederic Weisbecker <frederic@kernel.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Linux Memory Management List <linux-mm@kvack.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>, <yujie.liu@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [rcu/nocb] 4c66bc7cac:
 BUG:using_smp_processor_id()in_preemptible
Message-ID: <Zjs/TEtn/urkKw+m@xsang-OptiPlex-9020>
References: <202405072252.959dadc4-lkp@intel.com>
 <CALm+0cViRh07e88uMrRp=5K0TgBVFwmwLiLnejc7puEMXrmFsA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALm+0cViRh07e88uMrRp=5K0TgBVFwmwLiLnejc7puEMXrmFsA@mail.gmail.com>
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d9077b-af96-4726-68ae-08dc6f3d66a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iNo8JOHbe8KZ5a+CrgtLjURCzpNueW9+oJZECZdQj0fXR5PN45NKXjzh7BKu?=
 =?us-ascii?Q?QJn3Nm2MjOTCTb7iP1Mdyd2nrIcWsQsPpu5JkqmyAJNNzlVFHPsF0d+GipJ8?=
 =?us-ascii?Q?8cuLuKR7Din/wFbp24TNnSeYHn5vz75X/YLQBFIRukmmt6btYTDYTCnaytFx?=
 =?us-ascii?Q?s+M6i5lDKZahZWcSgdP+6XNBQy8LQIsOveb+PErhKQ5k0asieJyppRvmawhf?=
 =?us-ascii?Q?3qppImK88AQJ+Gtmn48fcfTz/eodVe9kFMkApPTqBosFnfrQh9ydZC7+muRG?=
 =?us-ascii?Q?IP8QSB685JSDy09Kd8gsp73UWO0AZ/RhgVNZtv6o4OM8M56p5f9YWiqoe3S/?=
 =?us-ascii?Q?7GlvLmG/NlCzl2tPX7Gt+YWWrXKpfE/koo4zf0radRtRRKi3l5fbELAhCBux?=
 =?us-ascii?Q?U4YbW1m9I0LQLudrLTjX+y3OVxYpZL+iEO0ViWhNHcFPS2tQHN1WwlLPEWCw?=
 =?us-ascii?Q?cnisc01Hb12KZVp8y9FzLo98viyRho7t1S97sUJACkA5etONZrOpapQIqCra?=
 =?us-ascii?Q?uQq3WvOqnpBG4eoBmMDNJJN+bBGHFHpXdPtv/NWaGheiJyHlhvMBK3qhTiih?=
 =?us-ascii?Q?ItixpUy1BJGtIfuVkcZbDpjYjMwH50414an9099UIUnNBFzd4QsXsR5a41Fp?=
 =?us-ascii?Q?whdHk2lFWl8IaJCs3x6c2zoQsCRaM3tOQIO4HFgfclUS2ZDkRR67pmzogHmR?=
 =?us-ascii?Q?0eiY3mQ0c+9cDcKG51yOhyDAQMWx5iMM2uyJme3/P7tiNeq+LgDRvHP+Y9Ky?=
 =?us-ascii?Q?x5UDO/EXV/DuNqopDsF99lwqP5tziw/lERvFrdI28UaJMEtyO2tHbnUf/Ma/?=
 =?us-ascii?Q?xUpwrlRoxkslHceF5qKrsboAMh13j41OjdvLmi6NmYVLiEWTaGOjkc5QSmxM?=
 =?us-ascii?Q?hd/eMUCpfM8SG6UCmvo1z092MrL5l7cfxCNT7RCFv6Riy8PlfQH6yVlGrVyI?=
 =?us-ascii?Q?Qh4g6rIvN0SVs7/icoNMvSApR9DXy1+fZG57C436FoeXFd7YpvQnD3dZgFfH?=
 =?us-ascii?Q?rFBxMToE0TFdeNUvjjaoOWfLmzNodKithfDtRg1TrMRsg7NAyRkI+RDxUp1L?=
 =?us-ascii?Q?7eyr8DQJNlw6RanDAeGKvV2CNXQDBSrENnkNcD1YcFxzCBJMeliUEhR29dpW?=
 =?us-ascii?Q?xzXNd9CQyNqbgMU3Z7U5G2ckZxTmiajOei6WRpbF8fJKSdxUk2RsKR2Q2d0s?=
 =?us-ascii?Q?mpdGFy6XWVxOku8XbBn+P8vff8ad6Pp+oPUelsK+7/P56AT3TIP0TsuiFcE?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ppfrkBM40s0l+mvgB9Ce/tZE4V2aDE4z2ONsRTuLDIqZsBKNHeWKhElNi+re?=
 =?us-ascii?Q?N8YY4uKrS0ZqU3m+sYaGSIQ40mnyaS+xvdblFnabUg3EuIsDhSZDgM1L8WlE?=
 =?us-ascii?Q?Wh1d9glsIU2wb4tlEpiwLy59DZh2iSClECc57F1Vlg0PnHFOBiMKny7DMYi4?=
 =?us-ascii?Q?zddPaofubwxf/KqE/GxEvthmYwoCpkCtaVisH2wwfy5AJ/ESgJYIdc0UUcMk?=
 =?us-ascii?Q?L3lb/B914TwMfvS1Tq2ioS+c5U/T/jcUfUxjxv5BwZxLqZinYavbDco7szTo?=
 =?us-ascii?Q?mvH4j2lniSn7TRzHR/CQnc7mu/i7CiFkm5sVVHKoRxeb9wpmR4F8dr9V8F+6?=
 =?us-ascii?Q?7lMOhlhmht8zyFktAnom4PlExo0WQa9G408ihYKZ6FOZsYhBorWIcTDvl5Wi?=
 =?us-ascii?Q?knAiZfBIFPmbwsgeabWaEhR7dRt4S+gZaUM34ZARITltNwG3pR33WZ5nb51D?=
 =?us-ascii?Q?QJ7+pGaxqR8AUYqKBBhsw/e0CADsP2jG+CENhWDAPV7nj9DZV457Ue240FEJ?=
 =?us-ascii?Q?bRo8/47ZDfQ5R5SWkmTPwl0mqAwohLyGZjyI1WgwPuP+9sLovifZHgQZ+GLF?=
 =?us-ascii?Q?UTThjRC7rwPROYGwh+GZh4GQlGwoTJZCNw3IdHMT0ymbCO12ylimM9pUMDJ0?=
 =?us-ascii?Q?8i9ODuOTD5kksKMB8C0qsbR/D9lv8kUVc4/aa73EIexmyAg9+oGpI1+0YXDZ?=
 =?us-ascii?Q?ZMdfCRGr9DxSfmyncUxUgOPrWLAqk+PO7n8xNGnW8J6uAQktlO0bmeY/TVQv?=
 =?us-ascii?Q?6T14UlOD70QDO5JaaEWzFuyydG+JNdZzK0B41PN3ZJl37f5Fu6NXezXYPjGK?=
 =?us-ascii?Q?nR3nl6mbPqDUZ3OUJK4/u2TK1no0+6YZtpRmwN+dvk1M1JLRbyXwQ2PWOlvv?=
 =?us-ascii?Q?YSKKHYo/EGvRT+lTVaz5gmUZd4taapPXwMApFdmT9EvgZxT2a62aSqt0EO/q?=
 =?us-ascii?Q?DmEUJNqGNLoA1AtT5hS032XYUktSplXMtuDnfWPi9rjAy2MvD0CueePSBi5X?=
 =?us-ascii?Q?Sh8m9hOGcclsmoQzNnE8o+9DjVpAYalMNcvmA3zZrC//Zhpn8d9O0USBOFLi?=
 =?us-ascii?Q?HTrCQz3yOzf78zWvfDOQNeZxwQtor8VPh0J42b4a1UNZU1AfDQRLB9hGDSNX?=
 =?us-ascii?Q?eT/Cw5E7i74lfYfJnmdSeGdAC0Aq2QtdDo4zSyyx3UQ4G/6sQE6xl5w4KvWu?=
 =?us-ascii?Q?i4yD60cpPfudvAt0sAV0VC48YrjniU8TQtSzQRuB1HUCUYS5CFqpgoZ/eS7D?=
 =?us-ascii?Q?ZF0Fdwi8MRLHSGO/A5g3jDW01Mw19eYbD5zuG+dcjhqVkpYH78QKqFsLNnoy?=
 =?us-ascii?Q?7zmXFWnEchKqma4h0jPhcr/jb4PeyJh3FyedV3FgrlMcI1YkNCxvV4E1dwzy?=
 =?us-ascii?Q?F/NUpSIu5XMfYXIncb2+EaC7OsUxYGW+4Ja6Ltvx9QiVqdPfeOopqKAyyu50?=
 =?us-ascii?Q?4mAx/IoR8vBUWXcmheJkPDZ8XJPfYhtHNXsEUq4FVJU9yPqPO2jwdi/UUAEc?=
 =?us-ascii?Q?txSzQlOPzOzfnSFw1uRKFJSRId8/xqaO6hE4A6ZDxxUUuifR1qMQVz97+keO?=
 =?us-ascii?Q?Dh21OSrCRb538nDR2NUVpw6mbDzWvUK5++6R/i7f9PTCr5s57ur6sjLY8JHE?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d9077b-af96-4726-68ae-08dc6f3d66a0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 09:01:08.9009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbvWoVJE2x8f/sziDEhftZmwtFChCC/tYjTN3vG0Y0SyLdvoNXKF943Dncjhd7hGRXjH5DGb7B1p9E16ztuAkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6996
X-OriginatorOrg: intel.com

hi, Z qiang,

On Wed, May 08, 2024 at 12:55:25PM +0800, Z qiang wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:
> >
> > commit: 4c66bc7cacc08e8abcf5049d2b90bfd800904336 ("rcu/nocb: Use kthread parking instead of ad-hoc implementation")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > [test failed on linux-next/master 9221b2819b8a4196eecf5476d66201be60fbcf29]
> >
> > in testcase: boot
> >
> > compiler: gcc-13
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > +--------------------------------------------------------------+------------+------------+
> > |                                                              | 6deb20902f | 4c66bc7cac |
> > +--------------------------------------------------------------+------------+------------+
> > | BUG:using_smp_processor_id()in_preemptible                   | 0          | 12         |
> > +--------------------------------------------------------------+------------+------------+
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202405072252.959dadc4-lkp@intel.com
> >
> >
> > [    4.099901][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.101313][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.102493][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.104098][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.104398][   T18] Call Trace:
> > [    4.104398][   T18]  <TASK>
> > [ 4.104398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.104398][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.104398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.104398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.104398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.104398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> 
> 
> Please try the following modifications:


the issue gone with below patch.

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 340bbefe5f65..b93e40206621 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -28,8 +28,8 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>                 !(lockdep_is_held(&rcu_state.barrier_mutex) ||
>                   (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
>                   rcu_lockdep_is_held_nocb(rdp) ||
> -                 (rdp == this_cpu_ptr(&rcu_data) &&
> -                  !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
> +                  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
> +                   rdp == this_cpu_ptr(&rcu_data)) ||
>                   rcu_current_is_nocb_kthread(rdp)),
>                 "Unsafe read of RCU_NOCB offloaded state"
>         );
> 
> Thanks
> Zqiang
> 
> 
> > [ 4.104398][ T18] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
> > [ 4.104398][ T18] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421 (discriminator 16))
> > [ 4.104398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.104398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.104398][ T18] kthread (kernel/kthread.c:388)
> > [ 4.104398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.104398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.104398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.104398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.104398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.104398][   T18]  </TASK>
> > [    4.106221][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.107796][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.108547][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.109667][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.111064][   T18] Call Trace:
> > [    4.111064][   T18]  <TASK>
> > [ 4.111064][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.111064][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.111064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.111064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.111064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.111064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.111064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.111064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.111064][ T18] kthread (kernel/kthread.c:388)
> > [ 4.111064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.111064][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.111064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.111064][   T18]  </TASK>
> > [    4.132677][    T1] NMI watchdog: Perf NMI watchdog permanently disabled
> > [    4.135331][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.137454][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.137849][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.139414][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.141064][   T18] Call Trace:
> > [    4.141064][   T18]  <TASK>
> > [ 4.141064][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.141064][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.141064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.141064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.141064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.141064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.141064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.141064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.141064][ T18] kthread (kernel/kthread.c:388)
> > [ 4.141064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.141064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.141064][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.141064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.141064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.141064][   T18]  </TASK>
> > [    4.141391][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.143427][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.144497][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.146055][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.147731][   T18] Call Trace:
> > [    4.147731][   T18]  <TASK>
> > [ 4.147731][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.147731][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.147731][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.147731][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.147731][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.147731][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.147731][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.147731][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.147731][ T18] kthread (kernel/kthread.c:388)
> > [ 4.147731][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.147731][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.147731][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.147731][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.147731][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.147731][   T18]  </TASK>
> > [    4.148538][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.150537][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.151144][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.152635][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.154398][   T18] Call Trace:
> > [    4.154398][   T18]  <TASK>
> > [ 4.154398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.154398][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.154398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.154398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.154398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.154398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.154398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.154398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.154398][ T18] kthread (kernel/kthread.c:388)
> > [ 4.154398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.154398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.154398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.154398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.154398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.154398][   T18]  </TASK>
> > [    4.156100][    T1] smp: Bringing up secondary CPUs ...
> > [    4.159421][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.161134][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.162569][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.164398][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.164398][   T18] Call Trace:
> > [    4.164398][   T18]  <TASK>
> > [ 4.164398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.164398][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.164398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.164398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.164398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.164398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.164398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.164398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.164398][ T18] kthread (kernel/kthread.c:388)
> > [ 4.164398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.164398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.164398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.164398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.164398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.164398][   T18]  </TASK>
> > [    4.168016][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.170139][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.171170][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.173242][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.174398][   T18] Call Trace:
> > [    4.174398][   T18]  <TASK>
> > [ 4.174398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.174398][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.174398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.174398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.174398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.174398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.174398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.174398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.174398][ T18] kthread (kernel/kthread.c:388)
> > [ 4.174398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.174398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.174398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.174398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.174398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.174398][   T18]  </TASK>
> > [    4.189949][    T1] smpboot: x86: Booting SMP configuration:
> > [    4.191158][    T1] .... node  #0, CPUs:      #1
> > [    1.668906][    T0] masked ExtINT on CPU#1
> > [    4.202955][   T29] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/1/29
> > [ 4.204471][ T29] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.205845][   T29] CPU: 0 PID: 29 Comm: rcuop/1 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.207731][   T29] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.207731][   T29] Call Trace:
> > [    4.207731][   T29]  <TASK>
> > [ 4.207731][ T29] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.207731][ T29] dump_stack (lib/dump_stack.c:124)
> > [ 4.207731][ T29] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.207731][ T29] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.207731][ T29] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.207731][ T29] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.207731][ T29] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
> > [ 4.207731][ T29] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421 (discriminator 16))
> > [ 4.207731][ T29] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.207731][ T29] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.207731][ T29] kthread (kernel/kthread.c:388)
> > [ 4.207731][ T29] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.207731][ T29] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.207731][ T29] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.207731][ T29] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.207731][ T29] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.207731][   T29]  </TASK>
> > [    4.207989][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.209997][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.211188][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.212898][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.214398][   T18] Call Trace:
> > [    4.214398][   T18]  <TASK>
> > [ 4.214398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.214398][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.214398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.214398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.214398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.214398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.214398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.214398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.214398][ T18] kthread (kernel/kthread.c:388)
> > [ 4.214398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.214398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.214398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.214398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.214398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.214398][   T18]  </TASK>
> > [    4.215399][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.217064][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.217772][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.219363][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.221064][   T18] Call Trace:
> > [    4.221064][   T18]  <TASK>
> > [ 4.221064][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.221064][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.221064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.221064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.221064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.221064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.221064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.221064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.221064][ T18] kthread (kernel/kthread.c:388)
> > [ 4.221064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.221064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.221064][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.221064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.221064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.221064][   T18]  </TASK>
> >
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240507/202405072252.959dadc4-lkp@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
> >
