Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2BBC2F2
	for <rcu@vger.kernel.org>; Mon, 23 Sep 2024 04:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727066327; cv=fail; b=qjBGKKGF47vfGBgQ3f5l6fy1yMh5c/5WH8PoDRclij8oSG45VCLVpa3juLGKqKotz4aaXIa/Bf1gExpdaenVwpW3G5dHtxFWMQG6tNOrlUk91QFrXMF5jCbhhetiKBBRyorMaiXWpVSp7t1dFROlxwYcXdqQWP7JVDI77nC195Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727066327; c=relaxed/simple;
	bh=UO7RPi9YGc/z79Ls/y5051OS0HHTBvOcnI6QZMQBD08=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tYvptC0CBmFLjAeDMmZyJhsZmpAO8Qzt8i0b/pQktOyqGGeLjbsoOvtFJiVzYaMSckmb57Vf2VnJKnMgC3QMb+iWBPGGNQQJWg4ZqAHLw/Kvl6DLx+EsLWKwrqEXffbn9Jpju6ckCimnkdhXaTrD0PYAsZvKBj+jBli4aLDSOzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXQA0ilS; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXQA0ilS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727066326; x=1758602326;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UO7RPi9YGc/z79Ls/y5051OS0HHTBvOcnI6QZMQBD08=;
  b=HXQA0ilSFy9Xn2TdxPEsTg0OjVaV/bordnUeD4EeufurIS9Oat8lhRep
   5fiTu5tTEl5xy9d2fd6rLbS96csiCB7Eke/YCHuwSIhKVmRLjFwQMefEb
   NSiB4iKxHFzwngt4tTK2JHNw5CuIJvp5qLvR2uVdV72iyd4jI6yy/e5Hq
   E5XydKJJSCuksuMtEh1QJNEXD8VmKuCF0x8OnEj7HMJX6rEUtu/3oNsBF
   +KL6El7pPyDE2cAeSwVuOxbNsXhtDm4vuaGlfNPLJd1um79L6YWJr2KN0
   3i7Eo6F/hiErmrvHxGm6ubZ+1XE/+vVMBH7vF5p6iIEvPE5D7jhjcmLF6
   g==;
X-CSE-ConnectionGUID: v/tm1tbaRyu09LWcLm+kAg==
X-CSE-MsgGUID: faKNvjwXROCzP6zfhdN/lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="13632779"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="13632779"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 21:38:45 -0700
X-CSE-ConnectionGUID: 2X5wLNddSOeFeP7VRwhFgg==
X-CSE-MsgGUID: PzkwGV+8Sd6OP9hGFIfFgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="71380927"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2024 21:38:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 22 Sep 2024 21:38:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 22 Sep 2024 21:38:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 22 Sep 2024 21:38:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 22 Sep 2024 21:38:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvLQEogTbq481pOE38tiI3aLBeqlA8v7Ku+3VD4DXq4hR/tMH+VL7ihyEjuMDEXSuPEXY3WTMTgc12crYJo/etcOw8EVQ0OxZcurmpJepGlWaoumMz22Sl2l3my/ip/WxPzw69W0SwP02zc1ER4em6jCMY9Jwu2ralkpm+HqV+k6yAb61pqFFvkW4SyKsglgx5amArPerkYWioXrN+t4dxSVh/AFq0U+xVAYHjJwc0m0Sj/noTXZvAJ7gVKuDUe60e5quWpgPq1yn14xKJ4rATwYoOEI7iVwk6xVgfCZfYkEGKmQ18AMJ5MwcLntek6phyf2nqwg9iBdVdoKMenGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1SqjdMqJ9BeY3SKAeSNZ7IY71gkTeEbHDDwX+KSqxY=;
 b=ZOkig0hoSpkTw8is0nBjQC1ilOB2bhx4/sAMFZdSMQW8wnN+BAjcfRxrIhMZY0UpRnD8TdyHDZFJL613OjP8dqVlyznAKUWjGrr89NwlSYlVxW0gYPrBSSQd6EhXpTu2C1QRfT5bSH0Pj+gf4uiotXPcI8+hM8SPujXWfrqaT+aw4tIlQH+tkyETRdXW/CzmNZEDt7ASDHA4unJ8H+57LlvpfmGmH7edbSY7V4q0iPszzkoH3Vz41upsiZgfbyv8bb/9e7pXHdyCbCWV4l64NEmimiaACDyne0njw2IaqcKugWNMRjY7efjJM95jbOPro2lucU7VolN9Fa0snriLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB8021.namprd11.prod.outlook.com (2603:10b6:806:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 04:38:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 04:38:40 +0000
Date: Mon, 23 Sep 2024 12:38:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, kernel test robot
	<oliver.sang@intel.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
	<andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kent Overstreet
	<kent.overstreet@linux.dev>, <rcu@vger.kernel.org>
Subject: [paulmckrcu:dev] [srcu]  26cb612c43:
 BUG:using__this_cpu_read()in_preemptible
Message-ID: <202409231124.358fed11-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eaae9b1-555e-4106-faef-08dcdb899922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VSvqPGSkbQrlZaF/6rqzPjFMfByi9aX6UCWZQEGhUqkUgu5Q+CoRT1i4ElEV?=
 =?us-ascii?Q?nBaI/DSAaujyR3ZME7+mF+2ZNh9TCp+AX3HptO8+VZt3gicdRnEjo8/43bzN?=
 =?us-ascii?Q?sfhSMoZ9kFpXTaBZ4gXRajMojvgJpCpzOYStptmqUusEviKKCrnmrwfb1YA3?=
 =?us-ascii?Q?f1hXfdqBm5AhnsZWEddmq2yl63vpyqSwk6bUPWTBgmydgE1H97z8zobLENh/?=
 =?us-ascii?Q?DCbRJSTG56KWP4jEIXq6dHU58nfAuqv8lgXJZsaH4beH0BJxxo/P8QdI2+Xx?=
 =?us-ascii?Q?ssCjs/8DKLa4wPNVQyxrvSDwcSplf8py6xsEyceCOoWJI6y5ZTeu5dXTbAGS?=
 =?us-ascii?Q?kcxCILL0o9QNPLSVYeZm9HN1DaPmaOCQp4Jc6HOLTGfdA1wjtyxGN0qG3Zw1?=
 =?us-ascii?Q?rkqRekIE1SOzPWbrcbS3XrqeUcPNlX9gTzEXA5NjiCbo3ZdV14fFKmEkIRpP?=
 =?us-ascii?Q?xH/HBRLBaUo6Kkzi1WmNaxbd9hoFWQnbJXxceNsxXarm+PyJiKLg3+iIB+dN?=
 =?us-ascii?Q?jeVgQinSlMXnJP7f6BFbty7iByYXtCRvHXmAC6xRLD+1717Ob21jGSaDoSgZ?=
 =?us-ascii?Q?/sRzuKIb1xSWiVfSDSmwujCRXsZvBwfHTZ55uORGadJ/tyaORH/Gwze4P7p2?=
 =?us-ascii?Q?Der78tnVCF3HmD+jtXnY7FHMjWn2HDmGABGI22sj1NvcJzlygTZpob70Gpcr?=
 =?us-ascii?Q?TmaH5NKSu98MS6SwIJ+R6PZ+QIiOyBjuNTJWRZkm6D4hU2YZXF/XwUNNUpYp?=
 =?us-ascii?Q?ANloTfLB+zBqX6vsmQ789em5IeQvgXVIqLlz7GunHweH5n7ReC0AQ0f8kz/l?=
 =?us-ascii?Q?mT3Vt1ZpBua/DG5tKmLiRdVFM90D3T/h78Euo4Ph1JA/elrOY+77b7OIK5WM?=
 =?us-ascii?Q?pax3/0D7uCi7FiRJNAq5vE2T5UKA/sna2ZBIhiVj8szL/g615t3ca+vIv50t?=
 =?us-ascii?Q?b8TPvgkNRFIykXu+oUaImo3Dl/I2HGXnrHc8alHhlUI0diKwRrAZqBUPsn18?=
 =?us-ascii?Q?0MSXQMfDqr9noDIuoq4A3jQqbb8ul9fc1hPVq27ZxZCPWm7ViLx06hNN++17?=
 =?us-ascii?Q?qIDVNK6K+E5k8QK9OdYJFJfCAyQeaWYIQy5yj54iw+iWgjZn6Xculn66UxKu?=
 =?us-ascii?Q?B2iTugnyHUJH5tdzy5zu69JONBLGwwu6z1zZWh2ilJl4Yhnxt0+bY3zf+dZC?=
 =?us-ascii?Q?Yj5yCQ9aSsSZF6KPZpNr7Nzu2B1EPz4tkg/ILn0CWepvyOtTBSg2DI/LJ8HC?=
 =?us-ascii?Q?pk0rwkWDMcUisUBRDWFuw2ZQZWWeQOYWchX0HvsfOgbN3q1L3xdYumYoVIPG?=
 =?us-ascii?Q?s6AI3gLHUnvgIIzpaF345lW+qNuZcDTKaV4bsGIewqO4afLwqXtMqb70bnML?=
 =?us-ascii?Q?iZSS4uY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6eEdFavQjDtrSDx58eMfX1CKUgpcLD+JtiKxhElIcTuThSMSHw8qQ9uVPXKM?=
 =?us-ascii?Q?TikwEsbf3kwaObzwF60AbQAyXyQlKFgWF7vn1xrQDII2Vie9v3l0bvqiUNCL?=
 =?us-ascii?Q?VL2Mq3CFSGokaU4ws8zAK14j0CRtkr6JElW6PCdxIUfJvc1f0NRwjpbqlu34?=
 =?us-ascii?Q?gOUXM94blmBqGf5XwV4uZuGJu7VirrAwYDpOkLPW2UiFqQ7OkKH/ZA8LAK99?=
 =?us-ascii?Q?9y0gp7gKPY9jzJbqmPbi3es/g3ADaF2QcQF3mU23s/039f65gOPrRyFn9vT7?=
 =?us-ascii?Q?YFsBa5KA21whL8FDWu0ebz4kkdJd7+huC595vKv0hbh1G+nXM19ype4L2WHN?=
 =?us-ascii?Q?hOUkVgUgCUvmf3U9juolnlf8WaEYs1Ui7OElzGNC/h3tlFW1NrPP1Skuwkgl?=
 =?us-ascii?Q?zJBd9428TF5wtqLonnsvYV5Q+1bjT5b0C2npT13UKeZpTDu3R+nb9Kcj+1YZ?=
 =?us-ascii?Q?sFh4JuGHXc1ZJlKkQE7XuIZxkVzjYjkECqVWRnOfFLTd1Ehf9ha1dVGs9ud9?=
 =?us-ascii?Q?R3HuIG475GmW/v9F2kHHdWsVNaGvdWQfRq1txm2qB2lUeMquWQTOt35TRrDq?=
 =?us-ascii?Q?jjGfOMBtFvW4vLrqfnbwUQo/YVlwQsTd6+F9zc+TQW0hlUBijN/QXd/nVpa0?=
 =?us-ascii?Q?EnLb0KHt25edix/OItcaAhOJAbJUk+/PJSvcHrwFBoTvZ77dxCCa+MEZ7OVk?=
 =?us-ascii?Q?aei/wUNQX6vbwalTCMvNZYnwXwnI5azLqczjmn+vGxc9yahTOquDjIdN+yZq?=
 =?us-ascii?Q?hfBDQvSlVdj/t5g+m7aAvvGH7x3uf5ZcsC3ECfm+9R3Mpr2v/shm4rfCJP35?=
 =?us-ascii?Q?O9vqdfMW+Su1Sw980uhjpEnRrLQV5Q5Et1OmjWWso9IpQyZ6wYmtZDh8CEwz?=
 =?us-ascii?Q?Pk6y6EUB2T1aHJZfwPkF7DTbyPu07kFaJLVvxe95weGq0uwWOMqXjoYDw98b?=
 =?us-ascii?Q?0uvZMdtVb8oGNb9lVDdedTyPdzvEom4vZOAqFNjuCRfOGc5ndSyS/BhgdQw7?=
 =?us-ascii?Q?wVlJIexrsOK7pV6ezbWg0EQ4qmt8Y7sLhXPIfyzM3e8mET4ZRF+IZEgeL1Yu?=
 =?us-ascii?Q?TgReT+fZXb/zd3Et7yvCqZBLKbNbp958+BbLQVmqUgNOCXmWK0GqejLnoTU4?=
 =?us-ascii?Q?VH6k2WhHfo6GEBt5sEqv8wIAWkRF1hCR3o1B8CtfF/j2gc2AZdbMZoMpJBSj?=
 =?us-ascii?Q?C/MhxjvV/rVrpK9RjFWDcmqWoCOAmW0f5mtuvyihaD0CHOnO36BvmleJHwU9?=
 =?us-ascii?Q?rqQxVBkRDfTg29TUb2y3d9yu7cKa7UYu06YjRfsjnTsV1PYmkjkcO66Dpc5d?=
 =?us-ascii?Q?5TqVoHgbE/bpe4SD8H9pGyCOZ+05SCNZYaAlpdYIeu8Bfj4w0gYQx480LVRh?=
 =?us-ascii?Q?6UKDCMDsBQyfRV4znVjfN5Vrauk8rvSyGqYgTnKJYPsmBHYYbsYUOWd6snUs?=
 =?us-ascii?Q?7e+JunvCd0OAaTAk4alEe/PSC/wvLnEobcXuHtWMCPRYpPu8KeqgsB1hlyCp?=
 =?us-ascii?Q?17EGbjfUSPeSygx1bOfRYCntKbmv0kiExrl9ITeVql9W3amaFNbBffHCFaoy?=
 =?us-ascii?Q?2VhbElGX9EfGP/nwR4qZwuVu4pg4WLnmRkexpMR+PklLLp8WssBAZHphQyoC?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaae9b1-555e-4106-faef-08dcdb899922
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 04:38:40.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icsb9DgfKKc7hzeizgVIf28/34JD3FRy3dsQsB4uqMAmenCrNBmFU14EHWN3N91bYHx1PqDsl4zeUxlMGsSf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8021
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:using__this_cpu_read()in_preemptible" on:

commit: 26cb612c431de5093ae6a3a67ecaa0363f5b8829 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
https://github.com/paulmckrcu/linux dev

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: srcud



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


in our tests, this issue doesn't always happen, but with a not small rate.

daf812f27d6bbe4c 26cb612c431de5093ae6a3a67ec
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :50          66%          33:50    dmesg.BUG:using__this_cpu_read()in_preemptible



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409231124.358fed11-lkp@intel.com


[  169.560380][   T76] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/1:2/76
[ 169.561229][ T76] caller is try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
[  169.561657][   T76] CPU: 0 UID: 0 PID: 76 Comm: kworker/1:2 Not tainted 6.11.0-rc1-00125-g26cb612c431d #1
[  169.562369][   T76] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  169.563120][   T76] Workqueue: rcu_gp process_srcu
[  169.563518][   T76] Call Trace:
[  169.563789][   T76]  <TASK>
[ 169.564031][ T76] dump_stack_lvl (lib/dump_stack.c:122) 
[ 169.564418][ T76] check_preemption_disabled (lib/smp_processor_id.c:52) 
[ 169.564842][ T76] ? try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
[ 169.565219][ T76] ? process_one_work (kernel/workqueue.c:3206) 
[ 169.565592][ T76] ? srcu_advance_state (kernel/rcu/srcutree.c:1784) 
[ 169.565994][ T76] ? process_srcu (kernel/rcu/srcutree.c:1893) 
[ 169.566373][ T76] ? process_one_work (kernel/workqueue.c:3236) 
[ 169.566790][ T76] ? __pfx_process_one_work (kernel/workqueue.c:3133) 
[ 169.567199][ T76] ? __list_add (include/linux/list.h:83 include/linux/list.h:150) 
[ 169.567559][ T76] ? process_scheduled_works (kernel/workqueue.c:3312) 
[ 169.567990][ T76] ? worker_thread (include/linux/list.h:373 kernel/workqueue.c:948 kernel/workqueue.c:3391) 
[ 169.568361][ T76] ? __kthread_parkme (arch/x86/include/asm/current.h:49 kernel/kthread.c:293) 
[ 169.568761][ T76] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
[ 169.569156][ T76] ? kthread (kernel/kthread.c:389) 
[ 169.569474][ T76] ? __pfx_kthread (kernel/kthread.c:342) 
[ 169.569848][ T76] ? ret_from_fork (arch/x86/kernel/process.c:153) 
[ 169.570212][ T76] ? __pfx_kthread (kernel/kthread.c:342) 
[ 169.570563][ T76] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[  169.570954][   T76]  </TASK>
[  169.652036][   T76] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/1:2/76
[ 169.652785][ T76] caller is try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
[  169.653204][   T76] CPU: 0 UID: 0 PID: 76 Comm: kworker/1:2 Not tainted 6.11.0-rc1-00125-g26cb612c431d #1
[  169.653945][   T76] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  169.654710][   T76] Workqueue: rcu_gp process_srcu
[  169.655095][   T76] Call Trace:
[  169.655357][   T76]  <TASK>
[ 169.655591][ T76] dump_stack_lvl (lib/dump_stack.c:122) 
[ 169.655958][ T76] check_preemption_disabled (lib/smp_processor_id.c:52) 
[ 169.656392][ T76] ? try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
[ 169.656771][ T76] ? process_one_work (kernel/workqueue.c:3206) 
[ 169.657162][ T76] ? srcu_advance_state (kernel/rcu/srcutree.c:1765) 
[ 169.657559][ T76] ? process_srcu (kernel/rcu/srcutree.c:1893) 
[ 169.657909][ T76] ? process_one_work (kernel/workqueue.c:3236) 
[ 169.658263][ T76] ? __pfx_process_one_work (kernel/workqueue.c:3133) 
[ 169.658623][ T76] ? __list_add (include/linux/list.h:83 include/linux/list.h:150) 
[ 169.658911][ T76] ? process_scheduled_works (kernel/workqueue.c:3312) 
[ 169.659254][ T76] ? worker_thread (include/linux/list.h:373 kernel/workqueue.c:948 kernel/workqueue.c:3391) 
[ 169.659554][ T76] ? __kthread_parkme (arch/x86/include/asm/current.h:49 kernel/kthread.c:293) 
[ 169.659885][ T76] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
[ 169.660211][ T76] ? kthread (kernel/kthread.c:389) 
[ 169.660480][ T76] ? __pfx_kthread (kernel/kthread.c:342) 
[ 169.660773][ T76] ? ret_from_fork (arch/x86/kernel/process.c:153) 
[ 169.661069][ T76] ? __pfx_kthread (kernel/kthread.c:342) 
[ 169.661363][ T76] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[  169.661693][   T76]  </TASK>
[  169.662140][   T76] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/1:2/76
[ 169.662810][ T76] caller is try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
[  169.663222][   T76] CPU: 0 UID: 0 PID: 76 Comm: kworker/1:2 Not tainted 6.11.0-rc1-00125-g26cb612c431d #1
[  169.663934][   T76] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  169.664696][   T76] Workqueue: rcu_gp process_srcu
[  169.665091][   T76] Call Trace:
[  169.665353][   T76]  <TASK>
[ 169.665586][ T76] dump_stack_lvl (lib/dump_stack.c:122) 
[ 169.665959][ T76] check_preemption_disabled (lib/smp_processor_id.c:52) 
[ 169.666369][ T76] ? try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
[ 169.666727][ T76] ? preempt_count_sub (kernel/sched/core.c:5685) 
[ 169.667127][ T76] ? process_one_work (kernel/workqueue.c:3206) 
[ 169.667519][ T76] ? srcu_advance_state (kernel/rcu/srcutree.c:1784) 
[ 169.667938][ T76] ? process_srcu (kernel/rcu/srcutree.c:1893) 
[ 169.668310][ T76] ? process_one_work (kernel/workqueue.c:3236) 
[ 169.668719][ T76] ? __pfx_process_one_work (kernel/workqueue.c:3133) 
[ 169.669150][ T76] ? __list_add (include/linux/list.h:83 include/linux/list.h:150) 
[ 169.669517][ T76] ? process_scheduled_works (kernel/workqueue.c:3312) 
[ 169.669954][ T76] ? worker_thread (include/linux/list.h:373 kernel/workqueue.c:948 kernel/workqueue.c:3391) 
[ 169.670303][ T76] ? __kthread_parkme (arch/x86/include/asm/current.h:49 kernel/kthread.c:293) 
[ 169.670692][ T76] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
[ 169.671077][ T76] ? kthread (kernel/kthread.c:389) 
[ 169.671412][ T76] ? __pfx_kthread (kernel/kthread.c:342) 
[ 169.671761][ T76] ? ret_from_fork (arch/x86/kernel/process.c:153) 
[ 169.672114][ T76] ? __pfx_kthread (kernel/kthread.c:342) 
[ 169.672463][ T76] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[  169.672861][   T76]  </TASK>
[  169.690595][   T75] smpboot: CPU 1 is now offline



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240923/202409231124.358fed11-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

