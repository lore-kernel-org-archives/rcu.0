Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FAA1DC1A7
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464450; cv=fail; b=Tqdu/rLuu5qQo/DJXOqYGpuE8MPkcVfkma8HhVYn05mV2UfDH0H3hUQClZ/FLVYWXvyPWEMTrMt3s/0ODHZASOVArT7KjqiJnIl7UJjGgCOKihDmwV1IcHYmM3uw4ifBpshjHkqLecz5VKV+Qko1JIBQbPWhB0n/txS07hziViA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464450; c=relaxed/simple;
	bh=vPtrhOw9BIM8f4EcY/hwptdH4W47mc0Chyaupgnn7NI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OnwaDn6n1jEPn6Ibru/MURULwUQrdYxqbniyykYIWcduyChmfQCz0hphr/qDDsR3isQzjpBgSiqdoT8yiNKZpWk61bFKOF9Xo8zLS64QF9nS0CXuGG+9QvKEdvSSlcPwfAjMns84zVwTvNtKigg6WI+LqZc3njVWptlf7yMzJEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fu84esLq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fu84esLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740464450; x=1772000450;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vPtrhOw9BIM8f4EcY/hwptdH4W47mc0Chyaupgnn7NI=;
  b=fu84esLqGQDNiwadvkcPEazCsjchhJAiJJSv++ZF1R2qi+N5N7njjnag
   uO6VSys28PCiDlkpkzAVUHzUGraVChDuQPJPQyqpAJa/JcYTc5AJf1gwU
   SMuDRvRUm7zboTx8LKHAwJULIwboXzaRkTskwWMdjV/94W5Y1PEVYjkCK
   3V31vhC/xR8RsAqQYe9gr3KeB8ffqyRTvfCbz5ONrTYN213xMkhkE0/4n
   azuZrUREkweiSqeYu1gIVM+kEqHwnOQrXYezcGtMyUus6e64VtKlKOmAd
   Bh9s6+vMZqCHYrO9112oX3jHdl6b90tuO9FbE+hFoum8v3zPkvSInV9es
   A==;
X-CSE-ConnectionGUID: DOqSC8q6Q+WUThVE588kfA==
X-CSE-MsgGUID: RrUjtuKTTfi8UTyL2Up6dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41098727"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="41098727"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 22:20:49 -0800
X-CSE-ConnectionGUID: da922sK4TmCmavuwwjWW6A==
X-CSE-MsgGUID: o+fLC/98SrCDYjiv+V19Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116785716"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2025 22:20:48 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 22:20:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 22:20:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 22:20:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJRphYOWVlxHzzvvVnSqtYs9HLMii+6bE35oLl0AtElRFD4KUapNjdK/IMVc9on5z93BqADvCZzQg5UZadYFxZGfzjrNHqGZH75GjY+QamYJXTagNLRqJFVAkql12uw9a2GfWGOhuWO1PtwZLDstt6y+jVuS5OD2Jfd4ffopbwqHHrGsRQ00+n6FsvKjORyh8398xopnnmJvi5RBmiDzqbWl3OnVRW1tdfopBi9SncoOScpw0IRHFRKUtsrUhBln8xc7cHWvo4kUL/tgS09qKEusS2+Y1Iye4Kx4mS4aH8cj4tFmWS+mGt/dtrjJVLmF/LyKlSuRIMC7zRPSGRuQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyJ78BhNF7KynFpMIiO38E+9UK3+WVd6zYd9n+v/ssc=;
 b=NlOCmqL73H8cUbT2NDs/EWzDUWxlp+4pmDWgjGy7SboOmUdf130Rj9/NWojc31SbHYhQJa8dOAUf3jjXg0rHchZmzHalrBN1XXX+EizCZTTS73Q/M1wnRxgtV+WohrGEawt83FW/mi8EJ96Weac+dh3s4goQBrBU4FstfUXn+wvWuDUqZFH4W0NKilHbJRN5zRs010k3G5exRke0Khc9+NoVB/afLOXq3BbEDmKmMxh4/0YSBvhQFx0VyTyE3nBthGEgw524Fv/pLVpFpot8n8lPEK/1zHaDwti34NaCiVSlftOJ469loDBMcMJK2qe3Dso6Qvsoyyb4NINFq2Sq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:20:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 06:20:45 +0000
Date: Tue, 25 Feb 2025 14:20:35 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Boqun Feng <boqun.feng@gmail.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>, Ankur Arora
	<ankur.a.arora@oracle.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>,
	<rcu@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/2] rcutorture: Update rcutorture_one_extend_check()
 for lazy preemption
Message-ID: <Z71hM/HEysIIYKbp@xsang-OptiPlex-9020>
References: <Z7v4MytjhhBZkG4S@Mac.home>
 <20250224044310.14373-1-boqun.feng@gmail.com>
 <07c31e33-4720-4204-9066-e57a708f5ae7@paulmck-laptop>
 <Z70uYdsH2hn8kNze@xsang-OptiPlex-9020>
 <Z7069Yj6zIaDbGLA@Mac.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z7069Yj6zIaDbGLA@Mac.home>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: 17da22c3-182f-43d8-b83d-08dd556489bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w8DSL67ly52OX87O58yx1hzdaWydVGsaZ+ZrOP4IrajWEmClvbFdG9Dcjg57?=
 =?us-ascii?Q?nK2i6ae+9k1jfMynQOWY74GxdEJTfHqV+gLeHlzl02DzuM7V980H6khTDE1D?=
 =?us-ascii?Q?VSUS6L/RpYuxeH5a8YFGUMxdnY4M2ObW5RWh6bbw/dJsBP1LgMIBWjy/1AdX?=
 =?us-ascii?Q?EQmyTe9+37CNWy7iIBTr1p/D/yP4cVUBFXy5zUZP+Vi+l7H54yFTik59Kvfk?=
 =?us-ascii?Q?3la6IUOqUmY2wNN2nivgCessmQM0LE8YEBP6gOX+AYEM6SaemkmO7qH/PRMg?=
 =?us-ascii?Q?joY9RPTghLne43vNLyJQeQMjf0cAMp3aInGNmFVQ0K0bEAUVKo9c9mH/nAoH?=
 =?us-ascii?Q?HqON4wYjWNy7/iVafogcbTNVdjPfEjgGVpIenlt3KiA6tmZ/P3F8qAqdwa4z?=
 =?us-ascii?Q?LitiFvRsWJjPsrvNoV2BSRUCkay2GtN7Ce9AoyA4X8HHYRNY8tp4Kj7ekNwc?=
 =?us-ascii?Q?Kvciwmsh8OG6fGqOyTskIjaAReEo/oXlnSzM5FJnnusPpfYxnpBDLm2/q84B?=
 =?us-ascii?Q?SEHjB7ianrcR3kfcX1qNYwYKSP/+it9DZfMX97AOdH5yYSgOh6bw7BEGwLjz?=
 =?us-ascii?Q?mbxe1DhznCsQD6JnSPOe86U9/G+iDnEsg95Eak+lPtI52RBSe0jf69Q1ctG6?=
 =?us-ascii?Q?cCPSCDpXEa6BnY/5bWE8ULCtuRhEjYwkANgRDJd2fpCrFyVXDPbavvh/u2+R?=
 =?us-ascii?Q?SpDep3RoUp+T7rZgQJAqLzxVynX7GJTIfpTwMMY83E/MrSNlQS0iULsbWonv?=
 =?us-ascii?Q?c0W7nsGVKCbhIkqr929DagKaBb2fHiZ+mxwVk3UxLg4x6z8t0sYvApzZGXLo?=
 =?us-ascii?Q?GPl0CBwo/j22LItcgXwI3JLD50j9WKMD/KG6wFPtDAu+CX6HZQtOq7X7KM82?=
 =?us-ascii?Q?elGS5kEfAPROfgQ5C5X9rpyzmetqPzYEIIH2mpHhmUyIV+MtLhNciebRhlUh?=
 =?us-ascii?Q?TsDudFWQ7M6TmnkRceSdpf6+WQaEtLyPCiWanWJ/nQY8o/qUjO68zB6n65SH?=
 =?us-ascii?Q?5wzTcec0FJT/vau01cFfNu/9+HOXgisqwv+3iPE++g0Q6HaYhKhbK7mabbTs?=
 =?us-ascii?Q?pQKIB8brGLHvof9/4e5zrM/IeQBh7NCtX2eGKbiWxnCk3zxWetpepBLgln10?=
 =?us-ascii?Q?JHTVcXSip8TgF+9BemguGPF1RCe9EMWFSoWHigb483BonAceJ/wA5J7piWF1?=
 =?us-ascii?Q?dWGIWrsHt2AAsGcZaFlEZym0QW7KlIVkZbNfEROjfOGNLYwcaFbnO+E+LZUQ?=
 =?us-ascii?Q?tL3k/yrZiLlwhHdisOIVhb/qbwh0gt7kb7+n+gggVNEZGfTp5tJSEADMRnfs?=
 =?us-ascii?Q?86PC4NUwk3S7n1SdFrlMltEm8ozDmOC4OfXZbQH4e/ASEJE+6lTXxTzug/Xr?=
 =?us-ascii?Q?Z0RRd4ub5M0pe2dm3L4Q8ol6iNin?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8hZ9Oll4LnFeMSvqhCA74sVLnTFeB4ayRi63+vsYYjHNHNiLNm9yFdlhQE7z?=
 =?us-ascii?Q?bmxncY64d3HByqyXjWpzPVTh7LRUKxoYCa4q7GWsZogX3VyA9N8eWhxy/WNI?=
 =?us-ascii?Q?a+d0AAoA6BCCa4RRt0wM0rWzdPVVnNsksdGq0tt/lLQ6556P25pA7XFebhlt?=
 =?us-ascii?Q?fU2/diCegfri3CNdf6bgJjtwmLFoRloM/XGlOAibrPwLPhiBhAISpgXMbw2r?=
 =?us-ascii?Q?sa3DRT/O7+ftflL5gWiZr1NigV5yNUhTcPtazs25UH9qES+Qwi2qishmeBGH?=
 =?us-ascii?Q?16gcoNv6wkeIM3qJSL9O8aZlHmmmC9PynzL9gErfZ0s/4y8DV2ILT6WHkKpR?=
 =?us-ascii?Q?P32jBLr66jl09/fi7FEUa8Rc49Lf9+m4pGHyowSB238qjqZ/B3tu2Eap1Cm6?=
 =?us-ascii?Q?J/Kmnmi7hAEMGVsPsRHnJqDYlnZSfvrC1eVgKid9G1/55wkz1CmpenukewZ2?=
 =?us-ascii?Q?eTHvTQJBArMMBqSp9FfVSHgVlL/fo5/K1D6wz1sJaQQ/8BydgrD1rZodbCi2?=
 =?us-ascii?Q?IQSpZFyk4ZyhEyv4WwW4wVhAUnnhK8eN34lcswQFXlsEZI3OPmtc7ExYp/Qr?=
 =?us-ascii?Q?XZTpyfRdsySSbUgLkXmTnp5j9raARZpLDTtzt4FRKCbsOP1ZYlJSZZuFsERq?=
 =?us-ascii?Q?8KC/NykPSy3m08ABmxc3GbF+RqJ9WNs0F0dNWBlL0zgFYyMF/w0YhvKNPOP/?=
 =?us-ascii?Q?+7rORfpz3fNX+AN2jiqFe7XA3Xq8igrGxSThOQsXblJx1qDGpZxzsM7L2333?=
 =?us-ascii?Q?17LddIkZHVHYfmTCDmOo4nqHx7SV88Ib+KiNwAbJmMoNs9tusgDeuNNnEP0q?=
 =?us-ascii?Q?7jap/1m7iWbeUSmW/chavICFaRQ/vXMR7M/i0wN6wqRlnmEaSRJJqudAqWXU?=
 =?us-ascii?Q?nTFrfTsM+fN9fI2UFu3sSL8lYYdbYa+6ZNVFlR6ZjKHU1d8y9bkTdxA/4uG6?=
 =?us-ascii?Q?v9gXpVUp/yr5Dj/8g9zZ9FCJjy43MQ9u8ceQJyY0qr+8EhnKLxDupHN5dBWi?=
 =?us-ascii?Q?BAxqvnKMkKUUwZju8nH21JWgee5czfPSwuU57J/+7FdHjyZrFwjaCmPwn0Q7?=
 =?us-ascii?Q?NRoIqsGnU9Qp4hQVuOpPlsKtcuLj1QdTHnH+GqOc0SqdF0v1SojwRk9xSonb?=
 =?us-ascii?Q?wJx+zrh472ymQ55PBvDvmjPSyGH3jNuBGXO3Mq8u5XwYVSM2YwbW1JXjeoMM?=
 =?us-ascii?Q?jW8Ad1g4ijO5mNt2E6aXRwXh0wRw+hDav0B7J/IsX3RCdHgFXjJ8NZupFx2b?=
 =?us-ascii?Q?K1yzW7cMKQjhX1zgQ9le0p4J5sivmPFpXOnF6i3OQtXJpOkht/sLN15j165c?=
 =?us-ascii?Q?82iZx8bZ5AReNZGjvlgvMKkxa7h16MWipq6X747fwjgDg1KYPS1HcpFeSlhP?=
 =?us-ascii?Q?7M21NuyA00zSA12xdBViynv9Jdxu6UcAvZc8z3Ce8FMlwnnbWmpH399Y3V8w?=
 =?us-ascii?Q?JoI4/ry8Qhs3vvifK3fHxYLCB8Qc0eI1Pyv9jrSI0nuhzA8nnAhFlE/93kj3?=
 =?us-ascii?Q?DN9mgJPLYYAGndpGlzrHeMimC+c+eSgR+Qy04skgAabL5AxBPyj68nWVEIDl?=
 =?us-ascii?Q?Byf9bB5QAXCfa0KJYy6uQ9sWXLrHMC4slk2Tqv2ehWNZOnP4ICki10aCIH/k?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17da22c3-182f-43d8-b83d-08dd556489bd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:20:45.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFzvFFk8xd1dedTcviOQZ5AjeljfN5Lr/DTlA4pTWBmM8z1jDMju5NzBRUt1+XZed4Ebc5b/P3ZT7S6JUVv1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5296
X-OriginatorOrg: intel.com

hi, Boqun,

On Mon, Feb 24, 2025 at 07:37:25PM -0800, Boqun Feng wrote:

[...]

> > 
> > * b9aa59295f037 rcutorture: Update ->extendables check for lazy preemption
> > * 5ffd825e807bd rcutorture: Update rcutorture_one_extend_check() for lazy preemption
> > * c9b55f9da0d2c rcu: limit PREEMPT_RCU configurations
> > 
> > we also made the test upon 5ffd825e807bd, which still shows the similar WARN.
> > is this expected?
> > 
> 
> Yes, that's expected, and that's why commit b9aa59295f037 is needed,

thanks a lot for information!

> thank you for the double confirmation.

you are welcome. always our great pleasure :)

> 
> Regards,
> Boqun
> 
> > > 
> > > 							Thanx, Paul
> > > 
> > > > +		mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> > > > +
> > > > +	WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
> > > >  		  cur_ops->readlock_nesting() > 0, ROEC_ARGS);
> > > >  }
> > > >  
> > > > -- 
> > > > 2.39.5 (Apple Git-154)
> > > > 
> 
