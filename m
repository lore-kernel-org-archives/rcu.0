Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532630EF81
	for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204559; cv=fail; b=MvL1puaQyChtB2fK0pVEhaH4SZopDbsVCdR/EZKBPPugEiTECoMds+fUVC/CfQPjzLlQAsgpxdj9LHLBO7eg3o2awgNsygQL1Mmgv4K6gFrCrfUNzgjarzod+1WGAENiGYgDOHcF5H1VV34IsTWO3IFeNxfpbpJL59R5RLXIjy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204559; c=relaxed/simple;
	bh=W1F8U0DPVSGHknspBD8jKdeUL3qhozKMZwkBC+ENj4k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WQeBxMMeHtIco/PwCweh5JcVR1CIWFQO2tmS3RBZdM5LfBZ8NZ6NmsK3SVTvf3b33YiFR3ypOV9z3/4UT9HNshlqR8U/JoogE/1qFFLeo7Qc1TBqfv+Bj05UDx4mqzJSRdpqsCt1RTnPREhgOLMwORJ+X6rlzpFSe8MiBeUzEak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvtKEmKs; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvtKEmKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768204555; x=1799740555;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=W1F8U0DPVSGHknspBD8jKdeUL3qhozKMZwkBC+ENj4k=;
  b=MvtKEmKs/+C9oJztnVmJ9m4jQZrLA9sWhhiFxC4a+iEDauKJrRrcoqNH
   +gzIR9wlQ6jwp4CY+dVr1a6L0TmIOh1+zx8NHDolT+pFAoRzaZj4UW2VA
   PyVInVJkE/BdQmI4qrkBjw08ZHf3MHaMrnHCEVKfzgRuI/waSYKBg1hMS
   vP5xoUg39SbhFKpIE8kmiZafDhgKhANjaRpeJfBdOH4oiu3MmGrgMwUCf
   +qW79EgxuWQaNRKBYXOVorpqp0+kof0HBa7zaI2ujWz3xATdXKTLtrw2u
   z46KQo3Y4gDZ+lzT9bJN3lf1wYCVCjoMpMXE1nbPvJWBZZRVVGZO9PoWu
   w==;
X-CSE-ConnectionGUID: 8NMytJ6IRkiqC87kWxBUcg==
X-CSE-MsgGUID: pohDBp07REKJ+V5VNzKRvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69629064"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69629064"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 23:55:54 -0800
X-CSE-ConnectionGUID: HHT+qJrfSGu7HrJJCW5Y6w==
X-CSE-MsgGUID: 0Ah9igjcQEe/X6+Nrrf0Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="235263635"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 23:55:54 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 11 Jan 2026 23:55:53 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 11 Jan 2026 23:55:53 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 11 Jan 2026 23:55:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHYCnAbVr0ZCAsNKpnq1WuKXsR1W6ZgiLqJ+v1swnZcSobIFdcNEMj/GVWiMBc/Yv2qso+nWcyHTqOGMv10n5HmHaifI+fNxr5ruOQZ2GiplUTd6GAapNC8tU9FOb31UrX4uskCYuCZcYzm/B1w/e+6iSZG1y/iRi1u/bsi2zu4wx7sPxVi/amliqeXAuWpY5CimiLMVJJnhQ5SfWTiTkLEfxjocM9sQEVku7CTa3OXR6Zm4XAIrhMOKIHXofjjeiEWNg+dbDoxWGrKwsmb5p7FyihB9PIuKt2j5pz2jGnWOQpZZTsQEWcc4SjxrG5QaKls25e6/OsUbiXUrhQvn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R88+G3AtpDlObwWNrIRvVOXTMr0Cufbx6z+FKqIcHJs=;
 b=StPB5VJGYq8gElB5zz7bQGhNK1wF/fEVYgZp0DA/GHtAcOkd8MrEx6439DO8I9R0x7u77A0BR2hltP6AYOUiawQJ/VV0Eg5y2TEReww+JSO1Xmyh8epPyiC/vTwCZKIZS5hmhOnBDBXnBz1ERWYKgUitbLDso9AGl6F6f3/6ouD6opuXbt8SsURi0Fj+oe9UxIWRmgkw6b4uWop3QFeCjeD/hihoUG19YpIHIeZSwAxE7H/TWGJbeKe5sPsv8h0uvVdqTxvcFzEJoOC1KRlVJe6Xg/G4xmgJQPZm9eDCcszSJwpk5aUrBFkHN9A9oDLYv5Jv4iyBi3ZmYzmGiPhC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7382.namprd11.prod.outlook.com (2603:10b6:8:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 07:55:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 07:55:51 +0000
Date: Mon, 12 Jan 2026 15:55:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Boqun Feng
	<boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, <rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [rcu]  168b367025: stress-ng.led.ops_per_sec
 150.8% improvement
Message-ID: <202601121452.11de9a7e-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ea3f30-36a0-4f44-434d-08de51b00152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?OMfQXJo9nzzklp65SHGEm4KFGyyhiFP6Xdx6fXYRIZMLc0hd6LrxIGdP+/?=
 =?iso-8859-1?Q?QpM7xzJ1AkCBPGdMJ9Hz2lruHBDK0IkyXKXlWYVRQtuxooPG1ppRTOh+IV?=
 =?iso-8859-1?Q?0/beDHnT/VtNu5GpgVomFiQVBRppIVupWVVSFp1Xn7mSO/jAIfGKj9uoGa?=
 =?iso-8859-1?Q?FDrnX5246PkIPNPLlAkVIiQBbi+7YbkAeCGrUjuqx8g8/qxau3/wv1jwyY?=
 =?iso-8859-1?Q?VUpJFiKJFRSEtuxkNTWCu/vlYlx4dTDIm31D2ogh67tRfGSnf5CxufBXCM?=
 =?iso-8859-1?Q?PZg+Icsxrf8byhzDG8EPqL4gU4l7ZkcDBJYzN5pQUfMA34g16NmF0CHPkn?=
 =?iso-8859-1?Q?nrRdIlLMK6LW1c1d4/3NcJ8wXe3CWRCLiieLVgOdULE/HYSqjIM1GbjExG?=
 =?iso-8859-1?Q?eu+awgBTOnlt1/dWV3OGywKxLWdXgDufa1WDjLUYIsJC5pkgkXV5b1Juv2?=
 =?iso-8859-1?Q?dBQ1ujRV+MCq0wpe3VIy9YgDJnAWHsxVSCaYgPKLrykMvzPHK8p0/rpKIc?=
 =?iso-8859-1?Q?K3bW5sdE+IrPaU0OHKDEYbbm3lMVA2xFbC2tMgv0NrB5QZHXJAIHQkZVm6?=
 =?iso-8859-1?Q?IYri8n2ldN2FDS2EKjqi9rcX06f/R+qGI75qK3dlbVBXvYy4yiKIp4+bIf?=
 =?iso-8859-1?Q?DIBDOT3LeR8kbH4/S4won8Dx5P0bLeWVZOOWGowLgFGtQTnrVLsOn+j1M6?=
 =?iso-8859-1?Q?br2KMXKew3Ik18gvdv8jqeK3T2bNA87y+jXQkKP3uSIV+K4xLbVfPXyeFw?=
 =?iso-8859-1?Q?bZt0DyxOynCFrRlF4hMopIxT8w3sP/9HNtnAekD9KWd3bRnIDaGbkti6lE?=
 =?iso-8859-1?Q?gQ2HikmJVeI6MSSM59hlUDL7XGYi7dEG6m49qQquTLPSC2x6MeaIWr2gUE?=
 =?iso-8859-1?Q?pCTmWfZt9T4lhIJpNqQ0oeWY0Jmx2Uuu5vo/SB5Xha+jQ02bcJA8qpmcnh?=
 =?iso-8859-1?Q?9inSygqyPvZh4x4in83h+Jc1Wi51TVTAgztjB0LN1A7wcKi9lxY9loKA+O?=
 =?iso-8859-1?Q?EOtLNtwSqcWX37e3oa4hm+tFT5hak+mnnAmlSebY6+wXCycLcIGE1ZOfOS?=
 =?iso-8859-1?Q?FgLeeUV0jpK8NcQJkb8CbAbhovWLsHFJxvdVxrz6BNOWpDWRnGxrYDlr9p?=
 =?iso-8859-1?Q?tva8Va6jJYlp7uBMQElOHX7FOiAP1Sqap9yne/WyUXtP8BlqSRqVSlleT5?=
 =?iso-8859-1?Q?Y+3SYCeEx7uinU3lQGIsVE3ApL6N8WfhiC14Q1TwV9FV6hTjm1YYIUr1xb?=
 =?iso-8859-1?Q?tA0SKjzk49K57hLMr9tLO+X9XNViL6wGebzdbh2Hd16vtF+x62vUfZJKPQ?=
 =?iso-8859-1?Q?+DgNZY2caJDPOklWdRfWDbJSINNQh1CLUiJeYYgA8WNqavmXfiqPtBbcOo?=
 =?iso-8859-1?Q?O9fZBVYyDEd0uX/ZpXUkD2kFoZK7ui6RRPERDnu9BXOJBgxy4rtEP5ztOz?=
 =?iso-8859-1?Q?J7V5xgAbNTCxfAEAIn50RXl2s77014fvuDO6vWwgfjYmT9nfLp67g52grf?=
 =?iso-8859-1?Q?Z08lsYV147LnMmRBjPALajJMQKxkiBmV5brypjyaTBgQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5C7OI7qbJpyMmGpHxM//UfYDhb6HEayEhoYuqd3mKLe4mbq5UvJByNuQXy?=
 =?iso-8859-1?Q?rOXFeXtDiP+EAM3JnUgjzUjwr9IDksRPya2qLhz8EyM42RgQrEHotU68ik?=
 =?iso-8859-1?Q?01Pf/UZujwaP1cT2Kr/tV94HqiXG9LWbhftsoaY9FA8d7JKrIZKlp6FNJG?=
 =?iso-8859-1?Q?Q3dGTXOMKGaYICAVxaOwsOReOwoSEVbMmSZv9fFPXmH2QNR+GySztS2qRv?=
 =?iso-8859-1?Q?C6lThRlcWjB3bwHsXWxJZSFlo40Mvpk7S//3mfcYHZiVSPc06MR5cqIsL8?=
 =?iso-8859-1?Q?93/kAdA8taeSeB1MKEYe66nPA6tDMSGiCRt5iLMhQmK827Y01QDwgOLuqe?=
 =?iso-8859-1?Q?2hnHldkP8Ye805+PX4BcS1W8+jZTZzo8xTpX/YbwOSlrbC7uoZZlecf2N6?=
 =?iso-8859-1?Q?N2Du7W8ZNHCOvuILXVY8Vw0cWE94Aiigi4qHoDRgunEqR7kRymTnFoJ38J?=
 =?iso-8859-1?Q?pGDnlJLbMD+JE1kOQWEZLyNnVNUFT0fj8ha0TiB166anA51cDtTojpVLsM?=
 =?iso-8859-1?Q?yAF3mGP2rlCM4PoVvaWOJpRx7FsQnSkOfYjv//tgYSSsuMy6bRRTD6EXme?=
 =?iso-8859-1?Q?J7iNUvjlkaE+Is4w1hEbd0Ce80Xt8opMUWh8WAXdA7gSal/QpCLlJgGI2g?=
 =?iso-8859-1?Q?/aXFvhccyA+Gt4QUZVgwWCsc8YRFRpkS5Mz59skVA6ZAPcvwPsV7soCIoJ?=
 =?iso-8859-1?Q?6ez6oCz9BOSLne/YSLbqguYhX+obNjEMoG5HJZ1M4RFQIgdGw35R/TPmgW?=
 =?iso-8859-1?Q?xvlAyIQrobVicmG4jCObLD+k+3o+28cNeHdyabEb1aWK95kw/M+z8P1SH+?=
 =?iso-8859-1?Q?z/MZO6AlivvMLYSMwAWN16QdXUjrdIw/1jy2ryjBSXM5u5BbmBxthADnpp?=
 =?iso-8859-1?Q?+AF67lAogJEk/zu4vN6BDdqTN8G3JnfaLPwy840noNSVBhdQ3XejSVxTvH?=
 =?iso-8859-1?Q?vx79nZNb1RtjDxdhP4wOVjSyrXpiMMr2Iwy1lRVgV4ZZjMEsSW5kBso0MR?=
 =?iso-8859-1?Q?h1wgLdaGx+jFyp2DiNJaN0MQTGxFxXFK3mivXrvWHzQnovo3WrRDuMhf+y?=
 =?iso-8859-1?Q?dEqZAiB4l3vtE9Mmg4uw4iH/oTz32N0QO04FSXauPFNis90vxtcUOE+YMz?=
 =?iso-8859-1?Q?kr6nZ5Kdk1dtsLVQpBkSu5kG83ooP+nIHu4RhLsCqbzGNohRF3D+8cxPy/?=
 =?iso-8859-1?Q?a9x1CtsicV+jwHU47pGtRAa36MV7hECZMBa22H7Hn958wHd7eM+GCXhXPj?=
 =?iso-8859-1?Q?FR3JMxLOJ+83k0NTGcCn73bPxugs0FH0Mc5iUdqW4i6YVIJmX7smbcbMnT?=
 =?iso-8859-1?Q?FgVN8D8DCFbTFRNlddrcnefLfmsL4QGfOg7irwi0wipeplT3xZVqglyXcf?=
 =?iso-8859-1?Q?YHSnNEuLkqN48ZXhf9DYbsIRDRq2zNYmyoGWquQUbYXHtI9mUo0NBFCAdC?=
 =?iso-8859-1?Q?NJ3nyrbpzECJn3AtjV6LOkS1Qsxg4lotnpF7OcOKNd8V/2NFPXaLKXakNq?=
 =?iso-8859-1?Q?4QtXePbcjSXMa4Ad+QqB2e1xZgM/b3YLrNvN0SI6rXu7Kk/22FGCGL8xQv?=
 =?iso-8859-1?Q?gzMltdza56AxLStV1jGz+wnRajKzC4to3ta69ksolN/3Ed1rlcM8bFZ9lw?=
 =?iso-8859-1?Q?oc6tLNLWu08cPR/SXUs4NM3KpLKLMECOrI04UaU+ddvatr6LU2o1ennQat?=
 =?iso-8859-1?Q?x+9J+Ud44jH+cbUUZAQe4e/301+GmoKlFzq9dTT2AlAR9j1uSRRnEYBR+h?=
 =?iso-8859-1?Q?G6EwzJyH0rgVO2IPuZ2nB1l+RD3tYDvboXvmDG9OsLdQXuqFoonL34hHm7?=
 =?iso-8859-1?Q?0HQ9Xpco4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ea3f30-36a0-4f44-434d-08de51b00152
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 07:55:51.7369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WY2nyFh/9/fcV6jPAmsOcktrP3LMP711UxwgcPn44IN+AEq/O/npeUPM/AcIn3ME1JbvVXfW3C778uy4uZOww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7382
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 150.8% improvement of stress-ng.led.ops_per_sec on:


commit: 168b3670254e707a2d8f46166aff34d70cd3652e ("rcu: Reduce synchronize_rcu() latency by reporting GP kthread's CPU QS early")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: led
	cpufreq_governor: performance


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260112/202601121452.11de9a7e-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp2/led/stress-ng/60s

commit: 
  d5bb7b9ca4 ("rcu/nocb: Add warning to detect if overload advancement is ever useful")
  168b367025 ("rcu: Reduce synchronize_rcu() latency by reporting GP kthread's CPU QS early")

d5bb7b9ca4049cbd 168b3670254e707a2d8f46166af 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    775598 ±  3%     +28.8%     998973 ±  4%  cpuidle..usage
     21479           +20.6%      25904 ±  2%  meminfo.Shmem
     13353 ±  5%     +32.8%      17739 ±  5%  numa-meminfo.node1.Shmem
      3332 ±  5%     +33.1%       4434 ±  5%  numa-vmstat.node1.nr_shmem
    515.90            +8.7%     560.59        sched_debug.cpu.clock_task.stddev
    534.33 ±  7%     +18.4%     632.75 ± 10%  sched_debug.cpu.nr_switches.min
      4094           +34.8%       5521 ±  2%  vmstat.system.cs
     13611 ±  6%     +34.5%      18308 ±  6%  vmstat.system.in
      0.02 ± 11%      +0.0        0.03 ±  8%  mpstat.cpu.all.irq%
      0.01 ±  8%      +0.0        0.02 ± 10%  mpstat.cpu.all.soft%
      0.07 ± 17%      +0.1        0.21 ±  7%  mpstat.cpu.all.sys%
      0.04            +0.0        0.05 ±  4%  mpstat.cpu.all.usr%
      8.00 ± 28%    +177.1%      22.17 ± 19%  perf-c2c.DRAM.local
     66.50 ± 23%    +250.1%     232.83 ± 19%  perf-c2c.DRAM.remote
    102.83 ± 10%    +186.7%     294.83 ± 14%  perf-c2c.HITM.local
     46.67 ± 23%    +293.6%     183.67 ± 22%  perf-c2c.HITM.remote
    215.83 ±  6%    +152.7%     545.50 ±  4%  stress-ng.led.ops
      3.31 ±  6%    +150.8%       8.31 ±  5%  stress-ng.led.ops_per_sec
      4661 ±  6%    +101.9%       9409 ±  5%  stress-ng.time.involuntary_context_switches
     18555 ±  2%     +68.1%      31188 ±  3%  stress-ng.time.voluntary_context_switches
      5.67 ±  8%    +120.6%      12.50 ±  6%  turbostat.Avg_MHz
      0.18 ±  8%      +0.2        0.39 ±  6%  turbostat.Busy%
      0.76 ±  6%     -36.0%       0.49 ±  2%  turbostat.IPC
    719079 ±  2%     +46.7%    1055184 ±  5%  turbostat.IRQ
     13508 ± 11%    +344.7%      60076 ± 11%  turbostat.NMI
    255.33           -10.7%     227.94 ±  3%  perf-sched.total_wait_and_delay.average.ms
      8144           +26.9%      10334 ±  2%  perf-sched.total_wait_and_delay.count.ms
    255.32           -10.7%     227.91 ±  3%  perf-sched.total_wait_time.average.ms
    255.33           -10.7%     227.94 ±  3%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      8144           +26.9%      10334 ±  2%  perf-sched.wait_and_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
    255.32           -10.7%     227.91 ±  3%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      5372           +20.6%       6478 ±  2%  proc-vmstat.nr_shmem
      1285 ± 12%     +25.3%       1610 ±  6%  proc-vmstat.numa_hint_faults
    674620            +3.7%     699298        proc-vmstat.numa_hit
    475606            +5.2%     500280        proc-vmstat.numa_local
      1908 ±  2%     +11.6%       2130 ±  4%  proc-vmstat.numa_pte_updates
    733415            +3.4%     758344        proc-vmstat.pgalloc_normal
    713437            +3.0%     734908        proc-vmstat.pgfree
     18732            +2.3%      19168        proc-vmstat.pgreuse
    145.00          +647.6%       1084 ± 11%  proc-vmstat.unevictable_pgs_culled
      0.91 ±  2%      -6.6%       0.85 ±  3%  perf-stat.i.MPKI
 1.638e+08 ±  2%     +42.7%  2.337e+08 ±  4%  perf-stat.i.branch-instructions
      2.52            -0.1        2.40        perf-stat.i.branch-miss-rate%
   5945623           +21.7%    7234870 ±  3%  perf-stat.i.branch-misses
     17.40 ±  2%      -1.4       16.02 ±  2%  perf-stat.i.cache-miss-rate%
    932631 ±  2%     +28.2%    1195478 ±  3%  perf-stat.i.cache-misses
   3374241 ±  4%     +71.4%    5784108 ±  4%  perf-stat.i.cache-references
      3778           +38.3%       5226 ±  3%  perf-stat.i.context-switches
      1.61 ±  6%     +46.6%       2.35        perf-stat.i.cpi
 1.093e+09 ±  9%    +122.2%  2.429e+09 ±  6%  perf-stat.i.cpu-cycles
    427.18 ±  3%     +44.9%     619.15 ±  4%  perf-stat.i.cpu-migrations
      2354 ±  8%     +39.0%       3272 ±  4%  perf-stat.i.cycles-between-cache-misses
 8.073e+08 ±  2%     +42.9%  1.154e+09 ±  4%  perf-stat.i.instructions
      0.69 ±  2%     -18.1%       0.56        perf-stat.i.ipc
      1.15           -10.2%       1.04 ±  2%  perf-stat.overall.MPKI
      3.63            -0.5        3.10        perf-stat.overall.branch-miss-rate%
     27.64 ±  3%      -7.0       20.65 ±  2%  perf-stat.overall.cache-miss-rate%
      1.35 ±  6%     +55.7%       2.11 ±  2%  perf-stat.overall.cpi
      1173 ±  7%     +73.5%       2034 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.74 ±  6%     -36.0%       0.48 ±  2%  perf-stat.overall.ipc
 1.613e+08 ±  2%     +42.7%  2.302e+08 ±  4%  perf-stat.ps.branch-instructions
   5859537           +21.6%    7125221 ±  3%  perf-stat.ps.branch-misses
    917224 ±  2%     +28.2%    1175849 ±  3%  perf-stat.ps.cache-misses
   3323027 ±  4%     +71.5%    5699707 ±  4%  perf-stat.ps.cache-references
      3723           +38.4%       5151 ±  3%  perf-stat.ps.context-switches
 1.077e+09 ±  9%    +122.4%  2.395e+09 ±  6%  perf-stat.ps.cpu-cycles
    421.01 ±  3%     +45.0%     610.36 ±  4%  perf-stat.ps.cpu-migrations
 7.952e+08 ±  2%     +42.9%  1.136e+09 ±  4%  perf-stat.ps.instructions
 5.525e+10 ±  2%     +42.0%  7.848e+10 ±  4%  perf-stat.total.instructions
     37.54 ± 13%     -25.2       12.32 ± 10%  perf-profile.calltrace.cycles-pp.common_startup_64
     32.99 ± 14%     -23.8        9.22 ± 11%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     32.99 ± 14%     -23.8        9.22 ± 11%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     32.97 ± 14%     -23.7        9.22 ± 11%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     26.11 ± 12%     -17.7        8.37 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     28.12 ± 11%     -17.4       10.70 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     27.71 ± 11%     -17.1       10.56 ±  8%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     27.69 ± 11%     -17.1       10.55 ±  8%  perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     27.68 ± 11%     -17.1       10.55 ±  8%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     23.55 ± 13%     -16.0        7.51 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
     23.59 ± 12%     -16.0        7.62 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     22.35 ± 16%     -12.6        9.73 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     22.23 ± 16%     -12.6        9.67 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.19 ±  9%     -12.4        8.76 ±  8%  perf-profile.calltrace.cycles-pp.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
     13.21 ± 10%      -8.6        4.63 ±  7%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry
      8.62 ±  9%      -5.4        3.22 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.pv_native_safe_halt.acpi_safe_halt
      8.40 ±  9%      -5.2        3.16 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.pv_native_safe_halt
      8.19 ±  9%      -4.2        3.98 ± 13%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
      5.63 ± 10%      -3.5        2.12 ±  7%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      5.08 ± 10%      -3.1        1.98 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      4.72 ± 16%      -2.9        1.79 ± 13%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.69 ± 16%      -2.9        1.78 ± 13%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.61 ±  9%      -2.9        3.73 ± 13%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry
      3.28 ± 22%      -2.8        0.42 ± 73%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      3.28 ± 22%      -2.8        0.42 ± 73%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      3.28 ± 22%      -2.8        0.42 ± 73%  perf-profile.calltrace.cycles-pp.execve
      3.27 ± 22%      -2.8        0.42 ± 73%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      3.27 ± 23%      -2.8        0.42 ± 73%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      6.42 ± 15%      -2.7        3.68 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.40 ± 15%      -2.7        3.66 ±  5%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.39 ± 19%      -2.4        0.97 ± 10%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.37 ± 19%      -2.4        0.96 ± 10%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.40 ± 14%      -2.4        1.00 ± 12%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.pv_native_safe_halt.acpi_safe_halt
      5.46 ± 19%      -2.3        3.12 ±  5%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.43 ± 19%      -2.3        3.09 ±  5%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      3.30 ± 14%      -2.3        0.96 ± 12%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.pv_native_safe_halt
      3.70 ± 17%      -2.3        1.38 ± 15%  perf-profile.calltrace.cycles-pp.kernfs_fop_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.35 ± 10%      -1.9        1.45 ±  8%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.95 ± 23%      -1.6        0.38 ± 70%  perf-profile.calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.56 ±  8%      -1.5        3.10 ± 14%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      4.56 ±  8%      -1.5        3.10 ± 14%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      4.56 ±  8%      -1.5        3.10 ± 14%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      4.56 ±  8%      -1.5        3.10 ± 14%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      4.56 ±  8%      -1.5        3.10 ± 14%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      4.56 ±  8%      -1.5        3.10 ± 14%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      4.53 ±  8%      -1.4        3.08 ± 14%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      4.53 ±  8%      -1.4        3.09 ± 13%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.start_kernel
      1.68 ± 24%      -1.4        0.32 ±101%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt
      1.72 ± 23%      -1.3        0.41 ± 73%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt.acpi_safe_halt
      4.23 ±  9%      -1.3        2.94 ± 13%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt.acpi_safe_halt
      4.23 ±  9%      -1.3        2.94 ± 13%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt
      4.22 ±  9%      -1.3        2.93 ± 14%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.handle_softirqs.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single
      1.78 ± 10%      -1.2        0.57 ± 45%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.88 ± 16%      -1.2        0.67 ± 15%  perf-profile.calltrace.cycles-pp.led_trigger_write.kernfs_fop_write_iter.vfs_write.ksys_write.do_syscall_64
      1.78 ± 17%      -1.1        0.69 ± 15%  perf-profile.calltrace.cycles-pp.brightness_store.kernfs_fop_write_iter.vfs_write.ksys_write.do_syscall_64
      1.44 ±  8%      -1.0        0.49 ± 45%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.36 ± 23%      -0.9        0.48 ± 46%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains
      1.59 ± 11%      -0.9        0.74 ±  9%  perf-profile.calltrace.cycles-pp.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      1.12 ± 12%      -0.7        0.38 ± 70%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.rename
      1.12 ± 12%      -0.7        0.38 ± 70%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.rename
      1.14 ± 11%      -0.7        0.39 ± 70%  perf-profile.calltrace.cycles-pp.rename
      1.11 ± 12%      -0.7        0.37 ± 70%  perf-profile.calltrace.cycles-pp.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe.rename
      1.06 ± 13%      -0.7        0.35 ± 70%  perf-profile.calltrace.cycles-pp.do_renameat2.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe.rename
      1.33 ± 19%      -0.6        0.74 ± 12%  perf-profile.calltrace.cycles-pp.syscall_trace_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.27 ± 19%      -0.6        0.69 ± 11%  perf-profile.calltrace.cycles-pp.__seccomp_filter.syscall_trace_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.67 ± 18%      -0.6        1.10 ±  8%  perf-profile.calltrace.cycles-pp.path_lookupat.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.20 ± 18%      -0.6        0.64 ± 12%  perf-profile.calltrace.cycles-pp.seccomp_run_filters.__seccomp_filter.syscall_trace_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.36 ± 17%      -0.5        0.82 ±  6%  perf-profile.calltrace.cycles-pp.__fstat64
      1.47 ± 14%      -0.5        1.00 ± 17%  perf-profile.calltrace.cycles-pp.sched_balance_domains._nohz_idle_balance.handle_softirqs.__irq_exit_rcu.sysvec_call_function_single
      1.09 ± 18%      -0.4        0.66 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__fstat64
      1.07 ± 19%      -0.4        0.65 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fstat64
      0.87 ±  8%      -0.4        0.46 ± 44%  perf-profile.calltrace.cycles-pp.malloc
      1.12 ± 17%      -0.4        0.75 ± 17%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains._nohz_idle_balance.handle_softirqs
      1.10 ± 17%      -0.4        0.72 ± 17%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains._nohz_idle_balance
      1.30 ± 14%      -0.4        0.94 ± 18%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_domains._nohz_idle_balance.handle_softirqs.__irq_exit_rcu
      1.01 ± 12%      -0.3        0.70 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.00 ± 14%      -0.3        0.69 ±  5%  perf-profile.calltrace.cycles-pp.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.89 ± 20%      -0.3        0.58 ±  7%  perf-profile.calltrace.cycles-pp.__do_sys_newfstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fstat64
      0.98 ± 12%      -0.3        0.68 ±  5%  perf-profile.calltrace.cycles-pp.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84 ± 13%      -0.3        0.58 ±  4%  perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64
      0.80 ± 12%      -0.2        0.56 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.76 ± 12%      -0.2        0.55 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
      0.78 ± 16%      -0.2        0.60 ±  5%  perf-profile.calltrace.cycles-pp.readlinkat
      0.75 ± 15%      -0.2        0.58 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.readlinkat
      0.75 ± 15%      -0.2        0.58 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.readlinkat
      0.73 ± 15%      -0.2        0.56 ±  4%  perf-profile.calltrace.cycles-pp.do_readlinkat.__x64_sys_readlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.readlinkat
      0.73 ± 15%      -0.2        0.56 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_readlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.readlinkat
      0.31 ±101%      +0.4        0.70 ± 12%  perf-profile.calltrace.cycles-pp.sched_balance_update_blocked_averages._nohz_idle_balance.handle_softirqs.__irq_exit_rcu.sysvec_call_function_single
      0.00            +0.7        0.66 ±  7%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_flush_one_record.console_unlock
      0.00            +0.7        0.66 ±  7%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_one_record.console_unlock.vprintk_emit
      0.09 ±223%      +0.7        0.81 ± 18%  perf-profile.calltrace.cycles-pp.fbcon_redraw.fbcon_scroll.con_scroll.lf.vt_console_print
      0.09 ±223%      +0.8        0.85 ± 17%  perf-profile.calltrace.cycles-pp.con_scroll.lf.vt_console_print.console_flush_one_record.console_unlock
      0.09 ±223%      +0.8        0.85 ± 17%  perf-profile.calltrace.cycles-pp.fbcon_scroll.con_scroll.lf.vt_console_print.console_flush_one_record
      0.09 ±223%      +0.8        0.85 ± 17%  perf-profile.calltrace.cycles-pp.lf.vt_console_print.console_flush_one_record.console_unlock.vprintk_emit
      0.10 ±223%      +0.9        0.98 ± 17%  perf-profile.calltrace.cycles-pp.vt_console_print.console_flush_one_record.console_unlock.vprintk_emit.dev_vprintk_emit
      0.00            +2.4        2.45 ±  6%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes
      0.70 ±223%      +7.8        8.51 ±  8%  perf-profile.calltrace.cycles-pp.io_serial_out.serial8250_console_write.console_flush_one_record.console_unlock.vprintk_emit
      0.77 ±223%      +8.7        9.42 ±  8%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_one_record.console_unlock.vprintk_emit.dev_vprintk_emit
      0.87 ±223%      +9.6       10.44 ±  9%  perf-profile.calltrace.cycles-pp.console_flush_one_record.console_unlock.vprintk_emit.dev_vprintk_emit.dev_printk_emit
      0.87 ±223%      +9.6       10.44 ±  9%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.dev_vprintk_emit.dev_printk_emit._dev_warn
      0.87 ±223%      +9.6       10.49 ±  8%  perf-profile.calltrace.cycles-pp.vprintk_emit.dev_vprintk_emit.dev_printk_emit._dev_warn.usbhid_request
      0.87 ±223%      +9.6       10.50 ±  8%  perf-profile.calltrace.cycles-pp._dev_warn.usbhid_request.process_one_work.worker_thread.kthread
      0.87 ±223%      +9.6       10.50 ±  8%  perf-profile.calltrace.cycles-pp.dev_printk_emit._dev_warn.usbhid_request.process_one_work.worker_thread
      0.87 ±223%      +9.6       10.50 ±  8%  perf-profile.calltrace.cycles-pp.dev_vprintk_emit.dev_printk_emit._dev_warn.usbhid_request.process_one_work
      0.90 ±223%      +9.7       10.58 ±  8%  perf-profile.calltrace.cycles-pp.usbhid_request.process_one_work.worker_thread.kthread.ret_from_fork
      5.31 ±223%     +50.3       55.63 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
      5.31 ±223%     +50.3       55.64 ±  4%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
      5.31 ±223%     +50.3       55.64 ±  4%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty
      5.31 ±223%     +50.4       55.67 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work
      5.31 ±223%     +50.4       55.69 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      5.32 ±223%     +50.4       55.77 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      5.32 ±223%     +50.4       55.77 ±  4%  perf-profile.calltrace.cycles-pp.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      5.32 ±223%     +50.4       55.77 ±  4%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.00           +54.3       54.32 ±  4%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail
     12.53 ±100%     +55.2       67.70 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     12.53 ±100%     +55.2       67.71 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     12.53 ±100%     +55.2       67.71 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.00           +55.5       55.52 ±  4%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail
      0.00           +55.5       55.53 ±  4%  perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail.commit_tail
      0.00           +55.6       55.62 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
      8.08 ±166%     +58.8       66.85 ±  4%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      7.80 ±173%     +58.9       66.72 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     37.54 ± 13%     -25.2       12.32 ± 10%  perf-profile.children.cycles-pp.common_startup_64
     37.54 ± 13%     -25.2       12.32 ± 10%  perf-profile.children.cycles-pp.cpu_startup_entry
     37.53 ± 13%     -25.2       12.32 ± 10%  perf-profile.children.cycles-pp.do_idle
     32.99 ± 14%     -23.8        9.22 ± 11%  perf-profile.children.cycles-pp.start_secondary
     35.49 ± 16%     -21.5       13.94 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     35.34 ± 16%     -21.5       13.86 ±  8%  perf-profile.children.cycles-pp.do_syscall_64
     30.65 ± 11%     -19.2       11.46 ±  8%  perf-profile.children.cycles-pp.cpuidle_idle_call
     28.13 ± 11%     -17.4       10.70 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
     28.12 ± 11%     -17.4       10.70 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter_state
     27.71 ± 11%     -17.2       10.56 ±  8%  perf-profile.children.cycles-pp.acpi_idle_enter
     27.69 ± 11%     -17.1       10.55 ±  8%  perf-profile.children.cycles-pp.acpi_idle_do_entry
     27.69 ± 11%     -17.1       10.55 ±  8%  perf-profile.children.cycles-pp.acpi_safe_halt
     27.66 ± 11%     -17.1       10.55 ±  8%  perf-profile.children.cycles-pp.pv_native_safe_halt
     18.94 ± 10%     -11.4        7.51 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     13.57 ± 10%      -8.7        4.85 ±  7%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      9.07 ± 12%      -5.8        3.30 ± 17%  perf-profile.children.cycles-pp._nohz_idle_balance
      8.84 ±  9%      -5.4        3.39 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      8.63 ±  9%      -5.3        3.32 ±  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      8.12 ±  9%      -4.0        4.07 ± 11%  perf-profile.children.cycles-pp.__irq_exit_rcu
      6.07 ± 17%      -3.9        2.13 ± 12%  perf-profile.children.cycles-pp.__schedule
      7.90 ±  8%      -3.9        4.03 ± 11%  perf-profile.children.cycles-pp.handle_softirqs
      5.80 ±  9%      -3.5        2.26 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      7.43 ±  9%      -3.4        3.99 ± 13%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      5.00 ± 17%      -3.2        1.78 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      5.27 ± 10%      -3.2        2.11 ±  7%  perf-profile.children.cycles-pp.tick_nohz_handler
      6.87 ± 16%      -3.1        3.76 ±  5%  perf-profile.children.cycles-pp.__x64_sys_openat
      6.85 ± 16%      -3.1        3.74 ±  5%  perf-profile.children.cycles-pp.do_sys_openat2
      4.76 ± 16%      -3.0        1.80 ± 13%  perf-profile.children.cycles-pp.ksys_write
      4.73 ± 16%      -2.9        1.79 ± 13%  perf-profile.children.cycles-pp.vfs_write
      4.04 ± 21%      -2.9        1.10 ± 11%  perf-profile.children.cycles-pp.ksys_read
      6.61 ±  9%      -2.9        3.73 ± 13%  perf-profile.children.cycles-pp.sysvec_call_function_single
      4.66 ± 16%      -2.9        1.78 ± 12%  perf-profile.children.cycles-pp.schedule
      3.82 ± 21%      -2.8        1.05 ± 10%  perf-profile.children.cycles-pp.vfs_read
      5.12 ± 12%      -2.7        2.41 ± 13%  perf-profile.children.cycles-pp.sched_balance_rq
      3.28 ± 22%      -2.7        0.58 ± 20%  perf-profile.children.cycles-pp.execve
      3.28 ± 23%      -2.7        0.58 ± 20%  perf-profile.children.cycles-pp.__x64_sys_execve
      3.28 ± 23%      -2.7        0.58 ± 20%  perf-profile.children.cycles-pp.do_execveat_common
      4.28 ± 15%      -2.7        1.62 ± 13%  perf-profile.children.cycles-pp.__pick_next_task
      5.81 ± 18%      -2.6        3.22 ±  5%  perf-profile.children.cycles-pp.do_filp_open
      5.78 ± 18%      -2.6        3.20 ±  5%  perf-profile.children.cycles-pp.path_openat
      4.14 ± 15%      -2.6        1.59 ± 13%  perf-profile.children.cycles-pp.pick_next_task_fair
      4.64 ± 13%      -2.5        2.11 ± 13%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      4.57 ± 13%      -2.5        2.08 ± 13%  perf-profile.children.cycles-pp.update_sd_lb_stats
      4.28 ± 14%      -2.4        1.86 ± 13%  perf-profile.children.cycles-pp.update_sg_lb_stats
      3.31 ± 16%      -2.3        0.96 ± 11%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      3.70 ± 17%      -2.3        1.38 ± 15%  perf-profile.children.cycles-pp.kernfs_fop_write_iter
      2.76 ± 19%      -2.3        0.49 ± 21%  perf-profile.children.cycles-pp.asm_exc_page_fault
      2.71 ± 24%      -2.2        0.47 ± 18%  perf-profile.children.cycles-pp.handle_internal_command
      2.71 ± 24%      -2.2        0.47 ± 18%  perf-profile.children.cycles-pp.main
      2.71 ± 24%      -2.2        0.47 ± 18%  perf-profile.children.cycles-pp.run_builtin
      3.59 ± 16%      -2.2        1.42 ± 12%  perf-profile.children.cycles-pp.sched_balance_newidle
      2.52 ± 24%      -2.1        0.44 ± 18%  perf-profile.children.cycles-pp.cmd_stat
      2.52 ± 24%      -2.1        0.44 ± 18%  perf-profile.children.cycles-pp.dispatch_events
      2.52 ± 24%      -2.1        0.44 ± 19%  perf-profile.children.cycles-pp.process_interval
      2.49 ± 20%      -2.1        0.44 ± 20%  perf-profile.children.cycles-pp.exc_page_fault
      2.45 ± 25%      -2.0        0.42 ± 19%  perf-profile.children.cycles-pp.read_counters
      2.46 ± 20%      -2.0        0.43 ± 21%  perf-profile.children.cycles-pp.do_user_addr_fault
      2.58 ± 21%      -1.9        0.66 ± 13%  perf-profile.children.cycles-pp.seq_read_iter
      2.33 ± 21%      -1.9        0.40 ± 18%  perf-profile.children.cycles-pp.smpboot_thread_fn
      3.50 ±  9%      -1.9        1.58 ±  8%  perf-profile.children.cycles-pp.update_process_times
      2.27 ± 21%      -1.9        0.41 ± 21%  perf-profile.children.cycles-pp.handle_mm_fault
      2.22 ± 24%      -1.8        0.39 ± 21%  perf-profile.children.cycles-pp.bprm_execve
      2.18 ± 21%      -1.8        0.39 ± 22%  perf-profile.children.cycles-pp.__handle_mm_fault
      2.09 ± 22%      -1.8        0.32 ± 24%  perf-profile.children.cycles-pp.sched_setaffinity
      2.60 ± 10%      -1.7        0.88 ± 11%  perf-profile.children.cycles-pp.ktime_get
      1.97 ± 30%      -1.7        0.32 ± 17%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.91 ± 30%      -1.6        0.31 ± 18%  perf-profile.children.cycles-pp.do_mmap
      1.91 ± 25%      -1.6        0.34 ± 20%  perf-profile.children.cycles-pp.exec_binprm
      2.22 ± 18%      -1.5        0.68 ± 18%  perf-profile.children.cycles-pp.update_rq_clock
      1.85 ± 25%      -1.5        0.33 ± 20%  perf-profile.children.cycles-pp.load_elf_binary
      1.78 ± 31%      -1.5        0.30 ± 19%  perf-profile.children.cycles-pp.__mmap_region
      4.56 ±  8%      -1.5        3.10 ± 14%  perf-profile.children.cycles-pp.rest_init
      4.56 ±  8%      -1.5        3.10 ± 14%  perf-profile.children.cycles-pp.start_kernel
      4.56 ±  8%      -1.5        3.10 ± 14%  perf-profile.children.cycles-pp.x86_64_start_kernel
      4.56 ±  8%      -1.5        3.10 ± 14%  perf-profile.children.cycles-pp.x86_64_start_reservations
      2.45 ± 11%      -1.4        1.08 ± 10%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      1.83 ± 22%      -1.4        0.47 ± 25%  perf-profile.children.cycles-pp.__mutex_lock
      1.68 ± 24%      -1.4        0.32 ± 18%  perf-profile.children.cycles-pp.kernel_clone
      1.92 ± 10%      -1.2        0.70 ± 14%  perf-profile.children.cycles-pp.clockevents_program_event
      1.44 ± 32%      -1.2        0.22 ± 15%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      1.82 ± 22%      -1.2        0.61 ± 18%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      1.88 ± 16%      -1.2        0.67 ± 15%  perf-profile.children.cycles-pp.led_trigger_write
      1.76 ± 22%      -1.2        0.59 ± 17%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      1.53 ± 15%      -1.2        0.37 ± 17%  perf-profile.children.cycles-pp.update_rq_clock_task
      2.82 ± 20%      -1.2        1.66 ±  6%  perf-profile.children.cycles-pp.link_path_walk
      2.39 ± 10%      -1.1        1.29 ± 14%  perf-profile.children.cycles-pp.sched_balance_domains
      1.74 ± 10%      -1.1        0.64 ±  9%  perf-profile.children.cycles-pp.idle_cpu
      1.78 ± 17%      -1.1        0.69 ± 15%  perf-profile.children.cycles-pp.brightness_store
      1.52 ± 18%      -1.1        0.44 ± 13%  perf-profile.children.cycles-pp.enqueue_task
      1.29 ± 22%      -1.1        0.21 ± 21%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      1.82 ± 14%      -1.1        0.74 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.38 ± 22%      -1.1        0.31 ± 24%  perf-profile.children.cycles-pp.x64_sys_call
      1.47 ± 15%      -1.0        0.45 ± 10%  perf-profile.children.cycles-pp.menu_select
      1.18 ± 22%      -1.0        0.19 ± 23%  perf-profile.children.cycles-pp.do_fault
      1.41 ± 18%      -1.0        0.42 ± 13%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.32 ± 13%      -1.0        0.33 ± 36%  perf-profile.children.cycles-pp.rcu_gp_kthread
      1.17 ± 25%      -1.0        0.21 ± 24%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      1.17 ± 25%      -1.0        0.21 ± 24%  perf-profile.children.cycles-pp.do_group_exit
      1.17 ± 25%      -1.0        0.21 ± 24%  perf-profile.children.cycles-pp.do_exit
      2.72 ± 14%      -0.9        1.80 ±  6%  perf-profile.children.cycles-pp.path_lookupat
      1.10 ± 29%      -0.9        0.19 ± 27%  perf-profile.children.cycles-pp.__mmput
      1.09 ± 30%      -0.9        0.19 ± 28%  perf-profile.children.cycles-pp.exit_mmap
      1.36 ± 20%      -0.9        0.46 ± 10%  perf-profile.children.cycles-pp.try_to_wake_up
      1.68 ± 11%      -0.9        0.78 ±  9%  perf-profile.children.cycles-pp.sched_tick
      1.09 ± 27%      -0.9        0.20 ± 16%  perf-profile.children.cycles-pp.copy_process
      1.33 ± 20%      -0.9        0.45 ± 14%  perf-profile.children.cycles-pp.sched_ttwu_pending
      1.09 ± 21%      -0.9        0.22 ± 18%  perf-profile.children.cycles-pp._Fork
      1.33 ± 20%      -0.9        0.46 ± 11%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.15 ± 12%      -0.9        0.30 ± 36%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      1.17 ± 20%      -0.8        0.34 ±  9%  perf-profile.children.cycles-pp.enqueue_entity
      1.12 ± 22%      -0.8        0.30 ± 19%  perf-profile.children.cycles-pp.schedule_idle
      0.95 ± 24%      -0.8        0.14 ± 27%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.96 ± 25%      -0.8        0.15 ± 27%  perf-profile.children.cycles-pp.do_read_fault
      1.21 ± 16%      -0.8        0.42 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.98 ± 24%      -0.8        0.20 ± 18%  perf-profile.children.cycles-pp.__do_sys_clone
      0.91 ± 27%      -0.8        0.14 ± 25%  perf-profile.children.cycles-pp.filemap_map_pages
      0.99 ± 24%      -0.8        0.23 ± 24%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.13 ± 25%      -0.8        0.38 ± 16%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      1.10 ± 26%      -0.7        0.36 ± 17%  perf-profile.children.cycles-pp.dev_attr_show
      1.09 ± 19%      -0.7        0.35 ±  6%  perf-profile.children.cycles-pp.rcu_core
      0.98 ± 28%      -0.7        0.25 ± 28%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.84 ± 25%      -0.7        0.12 ± 18%  perf-profile.children.cycles-pp.cpu_stopper_thread
      0.84 ± 24%      -0.7        0.12 ± 28%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.82 ± 25%      -0.7        0.12 ± 18%  perf-profile.children.cycles-pp.migration_cpu_stop
      1.05 ± 15%      -0.7        0.36 ± 11%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.80 ± 26%      -0.7        0.12 ± 21%  perf-profile.children.cycles-pp.move_queued_task
      1.75 ±  8%      -0.7        1.07 ±  7%  perf-profile.children.cycles-pp.lookup_fast
      0.82 ± 27%      -0.7        0.14 ± 27%  perf-profile.children.cycles-pp.exit_mm
      0.79 ± 32%      -0.7        0.12 ± 45%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.78 ± 38%      -0.7        0.11 ± 44%  perf-profile.children.cycles-pp.khugepaged
      1.48 ± 17%      -0.7        0.82 ± 12%  perf-profile.children.cycles-pp.syscall_trace_enter
      0.76 ± 27%      -0.7        0.10 ± 35%  perf-profile.children.cycles-pp.tmigr_handle_remote
      0.78 ± 28%      -0.7        0.12 ± 15%  perf-profile.children.cycles-pp.mm_init
      0.76 ± 38%      -0.7        0.11 ± 45%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      0.76 ± 38%      -0.7        0.11 ± 44%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.75 ± 27%      -0.6        0.10 ± 35%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
      0.79 ± 32%      -0.6        0.15 ± 27%  perf-profile.children.cycles-pp.elf_load
      0.96 ± 19%      -0.6        0.32 ± 10%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.78 ± 26%      -0.6        0.14 ± 25%  perf-profile.children.cycles-pp.__vfork
      1.38 ± 18%      -0.6        0.75 ± 12%  perf-profile.children.cycles-pp.__seccomp_filter
      0.73 ± 38%      -0.6        0.10 ± 48%  perf-profile.children.cycles-pp.collapse_huge_page
      1.37 ± 10%      -0.6        0.74 ± 10%  perf-profile.children.cycles-pp.led_trigger_set
      0.80 ± 28%      -0.6        0.18 ± 10%  perf-profile.children.cycles-pp.__pi_memset
      1.50 ± 17%      -0.6        0.88 ±  5%  perf-profile.children.cycles-pp.__fstat64
      1.30 ± 18%      -0.6        0.69 ± 12%  perf-profile.children.cycles-pp.seccomp_run_filters
      0.90 ± 16%      -0.6        0.29 ± 11%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.92 ± 15%      -0.6        0.32 ± 13%  perf-profile.children.cycles-pp.get_jiffies_update
      0.77 ± 21%      -0.6        0.17 ± 22%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.92 ± 21%      -0.6        0.32 ± 14%  perf-profile.children.cycles-pp.vsnprintf
      0.73 ± 29%      -0.6        0.13 ± 26%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.76 ± 20%      -0.6        0.17 ± 22%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.88 ± 18%      -0.6        0.28 ± 14%  perf-profile.children.cycles-pp.update_wall_time
      1.14 ± 11%      -0.6        0.55 ± 10%  perf-profile.children.cycles-pp.rename
      0.70 ± 24%      -0.6        0.11 ± 30%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.72 ± 29%      -0.6        0.13 ± 24%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      1.11 ± 12%      -0.6        0.52 ±  9%  perf-profile.children.cycles-pp.__x64_sys_rename
      1.01 ± 18%      -0.6        0.42 ± 12%  perf-profile.children.cycles-pp.__wait_for_common
      0.70 ± 26%      -0.6        0.12 ± 20%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.69 ± 26%      -0.6        0.11 ± 25%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.68 ± 32%      -0.6        0.11 ± 18%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      1.04 ± 25%      -0.6        0.47 ± 16%  perf-profile.children.cycles-pp.schedule_timeout
      0.66 ± 37%      -0.6        0.10 ± 47%  perf-profile.children.cycles-pp.__collapse_huge_page_copy
      1.06 ± 13%      -0.6        0.50 ± 10%  perf-profile.children.cycles-pp.do_renameat2
      0.66 ± 30%      -0.6        0.09 ± 14%  perf-profile.children.cycles-pp.__mmap
      0.67 ± 37%      -0.6        0.11 ± 18%  perf-profile.children.cycles-pp.alloc_bprm
      1.01 ± 20%      -0.5        0.46 ±  5%  perf-profile.children.cycles-pp.open_last_lookups
      0.63 ± 33%      -0.5        0.08 ± 30%  perf-profile.children.cycles-pp.tmigr_handle_remote_cpu
      0.80 ± 17%      -0.5        0.26 ± 17%  perf-profile.children.cycles-pp.tick_irq_enter
      0.73 ± 22%      -0.5        0.18 ± 12%  perf-profile.children.cycles-pp.__pi_memcpy
      0.80 ± 17%      -0.5        0.26 ± 17%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.63 ± 28%      -0.5        0.10 ± 15%  perf-profile.children.cycles-pp.show_stat
      0.68 ± 29%      -0.5        0.15 ± 18%  perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      0.64 ± 35%      -0.5        0.12 ± 25%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.68 ± 29%      -0.5        0.16 ± 18%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.70 ± 18%      -0.5        0.18 ± 36%  perf-profile.children.cycles-pp.force_qs_rnp
      0.61 ± 37%      -0.5        0.09 ± 35%  perf-profile.children.cycles-pp.unmap_vmas
      0.70 ± 29%      -0.5        0.18 ± 24%  perf-profile.children.cycles-pp.native_sched_clock
      1.06 ± 19%      -0.5        0.56 ± 12%  perf-profile.children.cycles-pp.__x64_sys_close
      0.59 ± 28%      -0.5        0.10 ± 29%  perf-profile.children.cycles-pp.perf_event_mmap
      0.62 ± 29%      -0.5        0.14 ± 16%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.59 ± 30%      -0.5        0.10 ± 27%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.58 ± 39%      -0.5        0.10 ± 22%  perf-profile.children.cycles-pp.setlocale
      0.82 ± 17%      -0.5        0.34 ± 14%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.83 ± 21%      -0.5        0.35 ± 10%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.80 ± 13%      -0.5        0.33 ± 22%  perf-profile.children.cycles-pp.kmem_cache_free
      0.63 ± 20%      -0.5        0.16 ± 27%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.66 ± 22%      -0.5        0.20 ± 20%  perf-profile.children.cycles-pp.asm_sysvec_posted_msi_notification
      0.54 ± 39%      -0.5        0.08 ± 29%  perf-profile.children.cycles-pp.unmap_page_range
      0.53 ± 38%      -0.5        0.07 ± 51%  perf-profile.children.cycles-pp.zap_pmd_range
      0.56 ± 34%      -0.5        0.10 ± 25%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.52 ± 39%      -0.5        0.06 ± 50%  perf-profile.children.cycles-pp.zap_pte_range
      0.55 ± 40%      -0.5        0.10 ± 22%  perf-profile.children.cycles-pp.__split_vma
      0.63 ± 17%      -0.4        0.19 ± 15%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.74 ± 32%      -0.4        0.30 ±  3%  perf-profile.children.cycles-pp.step_into_slowpath
      0.54 ± 27%      -0.4        0.11 ± 24%  perf-profile.children.cycles-pp.wake_up_new_task
      0.77 ± 24%      -0.4        0.34 ± 17%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.56 ± 32%      -0.4        0.13 ± 23%  perf-profile.children.cycles-pp.dup_mm
      0.51 ± 30%      -0.4        0.09 ± 28%  perf-profile.children.cycles-pp.fold_vm_zone_numa_events
      0.60 ± 27%      -0.4        0.18 ± 15%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.52 ± 31%      -0.4        0.10 ± 16%  perf-profile.children.cycles-pp.evsel__read_counter
      0.72 ± 20%      -0.4        0.31 ± 14%  perf-profile.children.cycles-pp.uevent_show
      0.56 ± 33%      -0.4        0.15 ± 29%  perf-profile.children.cycles-pp.wakeup_preempt
      0.87 ± 10%      -0.4        0.46 ± 13%  perf-profile.children.cycles-pp.getname_flags
      0.49 ± 42%      -0.4        0.08 ± 60%  perf-profile.children.cycles-pp.__open64_nocancel
      0.59 ± 30%      -0.4        0.18 ± 13%  perf-profile.children.cycles-pp.dequeue_entities
      0.75 ± 19%      -0.4        0.35 ±  7%  perf-profile.children.cycles-pp.lookup_open
      0.47 ± 25%      -0.4        0.07 ± 60%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.46 ± 47%      -0.4        0.06 ± 47%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.45 ± 34%      -0.4        0.05 ± 73%  perf-profile.children.cycles-pp.affine_move_task
      0.46 ± 27%      -0.4        0.07 ± 18%  perf-profile.children.cycles-pp.refresh_cpu_vm_stats
      0.44 ± 39%      -0.4        0.05 ± 71%  perf-profile.children.cycles-pp.zap_present_ptes
      0.48 ± 29%      -0.4        0.09 ± 25%  perf-profile.children.cycles-pp.finish_task_switch
      0.45 ± 33%      -0.4        0.06 ± 29%  perf-profile.children.cycles-pp.__run_timers
      0.47 ± 24%      -0.4        0.09 ± 25%  perf-profile.children.cycles-pp.begin_new_exec
      0.55 ± 21%      -0.4        0.17 ± 15%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.63 ± 20%      -0.4        0.26 ± 17%  perf-profile.children.cycles-pp.__dentry_kill
      0.51 ± 19%      -0.4        0.14 ± 27%  perf-profile.children.cycles-pp.__timekeeping_advance
      0.53 ± 26%      -0.4        0.16 ± 26%  perf-profile.children.cycles-pp.sysvec_posted_msi_notification
      0.63 ± 21%      -0.4        0.26 ± 17%  perf-profile.children.cycles-pp.finish_dput
      0.46 ± 40%      -0.4        0.08 ± 24%  perf-profile.children.cycles-pp.perf_evsel__read
      0.53 ± 32%      -0.4        0.16 ± 23%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.42 ± 36%      -0.4        0.06 ± 52%  perf-profile.children.cycles-pp.tmigr_cpu_activate
      0.44 ± 36%      -0.4        0.08 ± 22%  perf-profile.children.cycles-pp.clear_page_erms
      0.44 ± 36%      -0.4        0.08 ± 23%  perf-profile.children.cycles-pp.prep_new_page
      0.51 ± 35%      -0.4        0.14 ± 27%  perf-profile.children.cycles-pp.sched_clock
      0.62 ± 15%      -0.4        0.26 ± 13%  perf-profile.children.cycles-pp.__wake_up_sync_key
      0.48 ± 30%      -0.4        0.12 ± 24%  perf-profile.children.cycles-pp.__resched_curr
      0.43 ± 43%      -0.4        0.07 ± 22%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.62 ± 25%      -0.4        0.26 ± 17%  perf-profile.children.cycles-pp.dev_uevent
      0.76 ± 20%      -0.4        0.40 ± 15%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.38 ± 43%      -0.4        0.03 ±102%  perf-profile.children.cycles-pp.timer_expire_remote
      0.43 ± 36%      -0.4        0.08 ± 23%  perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      0.39 ± 30%      -0.4        0.04 ±110%  perf-profile.children.cycles-pp.tmigr_update_events
      0.50 ± 32%      -0.3        0.15 ± 16%  perf-profile.children.cycles-pp.dequeue_entity
      0.43 ± 21%      -0.3        0.08 ± 21%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.50 ± 30%      -0.3        0.15 ± 17%  perf-profile.children.cycles-pp.__cond_resched
      1.06 ± 12%      -0.3        0.71 ±  5%  perf-profile.children.cycles-pp.filename_lookup
      0.41 ± 33%      -0.3        0.07 ± 48%  perf-profile.children.cycles-pp.alloc_pages_noprof
      0.41 ± 22%      -0.3        0.08 ± 24%  perf-profile.children.cycles-pp.__mmdrop
      0.46 ± 24%      -0.3        0.13 ± 15%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.42 ± 34%      -0.3        0.08 ± 24%  perf-profile.children.cycles-pp.do_anonymous_page
      0.63 ± 28%      -0.3        0.29 ±  7%  perf-profile.children.cycles-pp.do_open
      0.66 ±  9%      -0.3        0.32 ± 11%  perf-profile.children.cycles-pp.strncpy_from_user
      0.93 ± 19%      -0.3        0.60 ±  7%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.62 ± 14%      -0.3        0.29 ± 13%  perf-profile.children.cycles-pp.__wake_up_common
      0.41 ± 39%      -0.3        0.08 ± 25%  perf-profile.children.cycles-pp.perf_read
      0.43 ± 28%      -0.3        0.10 ± 21%  perf-profile.children.cycles-pp.folios_put_refs
      0.88 ±  7%      -0.3        0.54 ±  6%  perf-profile.children.cycles-pp.malloc
      0.53 ± 24%      -0.3        0.20 ± 23%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.47 ± 22%      -0.3        0.15 ±  8%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.46 ± 27%      -0.3        0.14 ± 10%  perf-profile.children.cycles-pp.read_tsc
      0.51 ± 30%      -0.3        0.19 ± 20%  perf-profile.children.cycles-pp.irqentry_enter
      0.39 ± 27%      -0.3        0.07 ± 35%  perf-profile.children.cycles-pp.exec_mmap
      0.40 ± 52%      -0.3        0.08 ± 54%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.38 ± 25%      -0.3        0.06 ± 60%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.37 ± 33%      -0.3        0.06 ± 16%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      1.01 ± 12%      -0.3        0.70 ±  5%  perf-profile.children.cycles-pp.__x64_sys_epoll_wait
      1.01 ± 14%      -0.3        0.70 ±  5%  perf-profile.children.cycles-pp.do_epoll_wait
      0.50 ± 22%      -0.3        0.19 ± 10%  perf-profile.children.cycles-pp.rcu_do_batch
      0.42 ± 22%      -0.3        0.11 ± 28%  perf-profile.children.cycles-pp.timekeeping_update_from_shadow
      0.87 ± 14%      -0.3        0.56 ±  7%  perf-profile.children.cycles-pp.__d_lookup
      0.41 ± 22%      -0.3        0.10 ± 15%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.34 ± 27%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.41 ± 22%      -0.3        0.11 ± 15%  perf-profile.children.cycles-pp.switch_hrtimer_base
      0.99 ± 12%      -0.3        0.69 ±  5%  perf-profile.children.cycles-pp.ep_poll
      0.52 ± 18%      -0.3        0.23 ±  5%  perf-profile.children.cycles-pp.shmem_mknod
      0.40 ± 34%      -0.3        0.10 ± 22%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.33 ± 52%      -0.3        0.04 ± 76%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.41 ± 37%      -0.3        0.12 ± 46%  perf-profile.children.cycles-pp.rcu_watching_snap_save
      0.34 ± 19%      -0.3        0.06 ± 50%  perf-profile.children.cycles-pp.anon_pipe_write
      0.49 ± 22%      -0.3        0.21 ±  7%  perf-profile.children.cycles-pp.path_find_first_component
      0.52 ± 30%      -0.3        0.24 ± 11%  perf-profile.children.cycles-pp.kobject_uevent_env
      0.65 ± 26%      -0.3        0.37 ±  9%  perf-profile.children.cycles-pp.wait_for_completion_state
      0.30 ± 24%      -0.3        0.02 ± 99%  perf-profile.children.cycles-pp.vmstat_update
      0.50 ± 17%      -0.3        0.22 ± 12%  perf-profile.children.cycles-pp.__check_object_size
      0.54 ± 32%      -0.3        0.26 ± 15%  perf-profile.children.cycles-pp.alloc_empty_file
      0.32 ± 19%      -0.3        0.05 ± 74%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.41 ± 20%      -0.3        0.14 ± 18%  perf-profile.children.cycles-pp.start_dl_timer
      0.33 ± 31%      -0.3        0.06 ± 49%  perf-profile.children.cycles-pp.vmstat_start
      0.46 ± 13%      -0.3        0.20 ± 14%  perf-profile.children.cycles-pp.evict
      0.42 ± 24%      -0.3        0.15 ± 16%  perf-profile.children.cycles-pp.try_to_block_task
      0.34 ± 30%      -0.3        0.08 ± 31%  perf-profile.children.cycles-pp.asm_sysvec_call_function
      0.47 ± 29%      -0.3        0.20 ± 12%  perf-profile.children.cycles-pp.cfree
      0.36 ± 26%      -0.3        0.09 ± 28%  perf-profile.children.cycles-pp.dup_mmap
      0.84 ± 12%      -0.3        0.58 ±  4%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
      0.30 ± 39%      -0.3        0.04 ± 72%  perf-profile.children.cycles-pp.call_timer_fn
      0.83 ± 14%      -0.3        0.57 ±  5%  perf-profile.children.cycles-pp.do_readlinkat
      0.62 ± 26%      -0.3        0.37 ± 10%  perf-profile.children.cycles-pp.__wait_rcu_gp
      0.46 ± 13%      -0.3        0.20 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.41 ± 12%      -0.3        0.16 ± 16%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.62 ± 26%      -0.3        0.37 ± 10%  perf-profile.children.cycles-pp.synchronize_rcu_normal
      0.41 ± 28%      -0.2        0.16 ±  9%  perf-profile.children.cycles-pp.pick_link
      0.41 ± 18%      -0.2        0.17 ± 14%  perf-profile.children.cycles-pp.shmem_evict_inode
      0.35 ± 33%      -0.2        0.11 ± 14%  perf-profile.children.cycles-pp.anon_pipe_read
      0.37 ± 27%      -0.2        0.13 ± 10%  perf-profile.children.cycles-pp._copy_to_user
      0.44 ± 25%      -0.2        0.21 ± 16%  perf-profile.children.cycles-pp.siphash24_compress
      0.27 ± 30%      -0.2        0.04 ±101%  perf-profile.children.cycles-pp.lookup_slow
      0.39 ± 17%      -0.2        0.16 ± 18%  perf-profile.children.cycles-pp.shmem_undo_range
      0.34 ± 23%      -0.2        0.11 ± 26%  perf-profile.children.cycles-pp.__sysvec_posted_msi_notification
      0.40 ± 16%      -0.2        0.16 ± 16%  perf-profile.children.cycles-pp.check_heap_object
      0.46 ± 22%      -0.2        0.23 ± 11%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.29 ± 16%      -0.2        0.06 ± 49%  perf-profile.children.cycles-pp.wp_page_copy
      0.46 ± 21%      -0.2        0.24 ± 21%  perf-profile.children.cycles-pp.sock_def_readable
      0.32 ± 19%      -0.2        0.08 ± 26%  perf-profile.children.cycles-pp.note_gp_changes
      0.29 ± 14%      -0.2        0.07 ± 18%  perf-profile.children.cycles-pp.tick_do_update_jiffies64
      0.30 ± 25%      -0.2        0.07 ± 27%  perf-profile.children.cycles-pp.load_elf_interp
      0.42 ± 15%      -0.2        0.20 ± 11%  perf-profile.children.cycles-pp.fstatat64
      0.39 ± 33%      -0.2        0.17 ± 10%  perf-profile.children.cycles-pp.kobject_uevent_net_broadcast
      0.26 ± 33%      -0.2        0.04 ± 72%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.25 ± 36%      -0.2        0.03 ±103%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.39 ± 14%      -0.2        0.17 ± 13%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.39 ± 28%      -0.2        0.17 ± 31%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.32 ± 13%      -0.2        0.10 ± 17%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.41 ± 18%      -0.2        0.19 ± 13%  perf-profile.children.cycles-pp.__netlink_sendskb
      0.26 ± 36%      -0.2        0.04 ± 73%  perf-profile.children.cycles-pp.copy_strings
      0.47 ± 23%      -0.2        0.25 ± 11%  perf-profile.children.cycles-pp.__sys_sendmsg
      0.32 ± 21%      -0.2        0.10 ± 26%  perf-profile.children.cycles-pp.handle_irq_event
      0.50 ± 19%      -0.2        0.28 ±  7%  perf-profile.children.cycles-pp.led_trigger_remove
      0.32 ± 21%      -0.2        0.10 ± 25%  perf-profile.children.cycles-pp.handle_edge_irq
      0.46 ± 24%      -0.2        0.25 ± 11%  perf-profile.children.cycles-pp.___sys_sendmsg
      0.33 ± 31%      -0.2        0.12 ± 13%  perf-profile.children.cycles-pp.do_one_broadcast
      0.26 ± 33%      -0.2        0.05 ± 73%  perf-profile.children.cycles-pp.notifier_call_chain
      0.26 ± 33%      -0.2        0.04 ± 76%  perf-profile.children.cycles-pp.pvclock_gtod_notify
      0.35 ± 29%      -0.2        0.14 ± 11%  perf-profile.children.cycles-pp.netlink_broadcast_filtered
      0.41 ± 12%      -0.2        0.20 ± 23%  perf-profile.children.cycles-pp.arch_exit_to_user_mode_prepare
      0.30 ± 27%      -0.2        0.09 ± 25%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      0.30 ± 27%      -0.2        0.09 ± 25%  perf-profile.children.cycles-pp.xhci_irq
      0.37 ± 26%      -0.2        0.17 ±  8%  perf-profile.children.cycles-pp.generic_perform_write
      0.36 ± 19%      -0.2        0.16 ± 16%  perf-profile.children.cycles-pp.vfs_fstatat
      0.34 ± 22%      -0.2        0.14 ± 20%  perf-profile.children.cycles-pp.rcu_pending
      0.23 ± 19%      -0.2        0.03 ±103%  perf-profile.children.cycles-pp.timerqueue_del
      0.29 ± 44%      -0.2        0.09 ± 17%  perf-profile.children.cycles-pp.update_curr
      0.28 ± 51%      -0.2        0.08 ± 37%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.22 ± 44%      -0.2        0.02 ± 99%  perf-profile.children.cycles-pp.timerqueue_add
      0.30 ± 23%      -0.2        0.10 ± 25%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.43 ± 24%      -0.2        0.23 ± 12%  perf-profile.children.cycles-pp.____sys_sendmsg
      0.32 ± 29%      -0.2        0.13 ± 17%  perf-profile.children.cycles-pp.snprintf
      0.44 ± 18%      -0.2        0.24 ± 16%  perf-profile.children.cycles-pp.ep_poll_callback
      0.42 ± 26%      -0.2        0.22 ± 12%  perf-profile.children.cycles-pp.netlink_sendmsg
      0.38 ± 27%      -0.2        0.19 ± 16%  perf-profile.children.cycles-pp.statx
      0.26 ± 31%      -0.2        0.07 ± 24%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.38 ± 20%      -0.2        0.19 ± 20%  perf-profile.children.cycles-pp.__wake_up_sync
      0.30 ± 29%      -0.2        0.11 ± 10%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.26 ± 34%      -0.2        0.07 ± 18%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.30 ± 15%      -0.2        0.12 ± 30%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.20 ± 18%      -0.2        0.02 ± 99%  perf-profile.children.cycles-pp.seq_read
      0.79 ± 17%      -0.2        0.61 ±  4%  perf-profile.children.cycles-pp.readlinkat
      0.31 ± 22%      -0.2        0.13 ± 18%  perf-profile.children.cycles-pp.vfs_statx
      0.27 ± 30%      -0.2        0.09 ± 22%  perf-profile.children.cycles-pp.mutex_lock
      0.30 ± 36%      -0.2        0.12 ± 14%  perf-profile.children.cycles-pp.netlink_broadcast
      0.25 ± 27%      -0.2        0.08 ± 22%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.30 ± 40%      -0.2        0.12 ± 23%  perf-profile.children.cycles-pp.input_print_modalias_parts
      0.21 ± 32%      -0.2        0.03 ±106%  perf-profile.children.cycles-pp.sysvec_call_function
      0.30 ± 29%      -0.2        0.12 ± 15%  perf-profile.children.cycles-pp.cp_new_stat
      0.23 ± 21%      -0.2        0.06 ± 17%  perf-profile.children.cycles-pp.free_pgtables
      0.29 ± 21%      -0.2        0.12 ± 19%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.22 ± 38%      -0.2        0.06 ± 52%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.73 ± 15%      -0.2        0.56 ±  4%  perf-profile.children.cycles-pp.__x64_sys_readlinkat
      0.35 ± 25%      -0.2        0.18 ± 16%  perf-profile.children.cycles-pp.vfs_rename
      0.20 ± 36%      -0.2        0.04 ±100%  perf-profile.children.cycles-pp.__mutex_unlock_slowpath
      0.21 ± 44%      -0.2        0.05 ± 48%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.22 ± 30%      -0.2        0.07 ± 11%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.25 ± 21%      -0.2        0.09 ± 24%  perf-profile.children.cycles-pp.select_task_rq
      0.24 ± 31%      -0.2        0.08 ± 13%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.25 ± 21%      -0.2        0.10 ± 18%  perf-profile.children.cycles-pp.kfree
      0.35 ± 17%      -0.2        0.20 ± 20%  perf-profile.children.cycles-pp.ep_autoremove_wake_function
      0.25 ± 40%      -0.1        0.10 ± 29%  perf-profile.children.cycles-pp.input_print_modalias_bits
      0.20 ± 49%      -0.1        0.05 ± 49%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.21 ± 48%      -0.1        0.06 ± 47%  perf-profile.children.cycles-pp.format_decode
      0.19 ± 53%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.do_unlinkat
      0.18 ± 17%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.need_update
      0.27 ± 32%      -0.1        0.12 ± 20%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.18 ± 27%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.19 ± 46%      -0.1        0.05 ± 80%  perf-profile.children.cycles-pp.refill_obj_stock
      0.20 ± 45%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp.unlink
      0.18 ± 35%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.set_next_task_fair
      0.23 ± 31%      -0.1        0.10 ± 19%  perf-profile.children.cycles-pp.check_cpu_stall
      0.20 ± 50%      -0.1        0.07 ± 28%  perf-profile.children.cycles-pp.add_uevent_var
      0.21 ± 32%      -0.1        0.07 ± 21%  perf-profile.children.cycles-pp.usbhid_restart_ctrl_queue
      0.22 ± 24%      -0.1        0.09 ± 20%  perf-profile.children.cycles-pp.__shmem_get_inode
      0.19 ± 29%      -0.1        0.06 ± 51%  perf-profile.children.cycles-pp.llist_reverse_order
      0.19 ± 34%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp.number
      0.27 ± 17%      -0.1        0.14 ±  9%  perf-profile.children.cycles-pp.path_init
      0.26 ± 20%      -0.1        0.14 ± 12%  perf-profile.children.cycles-pp.mempool_alloc_tile
      0.19 ± 35%      -0.1        0.07 ± 24%  perf-profile.children.cycles-pp.__queue_work
      0.27 ± 28%      -0.1        0.15 ± 13%  perf-profile.children.cycles-pp.siphash24_finalize
      0.29 ± 21%      -0.1        0.16 ± 22%  perf-profile.children.cycles-pp.sock_recvmsg
      0.19 ± 40%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.utimensat
      0.19 ± 32%      -0.1        0.08 ± 24%  perf-profile.children.cycles-pp.simple_offset_add
      0.19 ± 29%      -0.1        0.08 ± 25%  perf-profile.children.cycles-pp.mtree_alloc_cyclic
      0.18 ± 37%      -0.1        0.07 ± 28%  perf-profile.children.cycles-pp.fchmod
      0.22 ± 15%      -0.1        0.10 ± 13%  perf-profile.children.cycles-pp.shmem_write_begin
      0.22 ± 25%      -0.1        0.11 ± 18%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.18 ± 42%      -0.1        0.07 ± 23%  perf-profile.children.cycles-pp.__x64_sys_utimensat
      0.18 ± 42%      -0.1        0.07 ± 23%  perf-profile.children.cycles-pp.do_utimes
      0.14 ± 33%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.__d_alloc
      0.18 ± 23%      -0.1        0.08 ± 19%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.25 ± 24%      -0.1        0.14 ± 17%  perf-profile.children.cycles-pp.input_handle_event
      0.15 ± 43%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.update_se
      0.18 ± 22%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.update_dl_rq_load_avg
      0.14 ± 38%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.rmqueue
      0.23 ± 15%      -0.1        0.13 ± 27%  perf-profile.children.cycles-pp.switch_fpu_return
      0.22 ± 24%      -0.1        0.12 ± 25%  perf-profile.children.cycles-pp.startswith
      0.26 ± 24%      -0.1        0.16 ± 12%  perf-profile.children.cycles-pp.input_inject_event
      0.19 ± 31%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.shmem_rename2
      0.18 ± 12%      -0.1        0.09 ± 18%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.12 ± 20%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.vscnprintf
      0.13 ± 38%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.kernfs_unlink_open_file
      0.19 ± 22%      -0.1        0.10 ± 25%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.12 ± 33%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.alloc_inode
      0.14 ± 13%      -0.1        0.05 ± 49%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.11 ± 37%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.__note_gp_changes
      0.15 ± 44%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp._find_next_and_bit
      0.14 ± 41%      -0.1        0.06 ± 47%  perf-profile.children.cycles-pp.fstatfs64
      0.16 ± 24%      -0.1        0.07 ± 18%  perf-profile.children.cycles-pp.usb_hcd_submit_urb
      0.17 ± 22%      -0.1        0.08 ± 24%  perf-profile.children.cycles-pp.hid_submit_ctrl
      0.15 ± 37%      -0.1        0.07 ± 20%  perf-profile.children.cycles-pp.new_inode
      0.12 ± 47%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.shmem_file_read_iter
      0.14 ± 27%      -0.1        0.06 ± 51%  perf-profile.children.cycles-pp.xhci_urb_enqueue
      0.10 ± 41%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__x64_sys_recvfrom
      0.14 ± 46%      -0.1        0.06 ± 17%  perf-profile.children.cycles-pp.queue_work_on
      0.20 ± 16%      -0.1        0.12 ± 18%  perf-profile.children.cycles-pp.netlink_recvmsg
      0.12 ± 28%      -0.1        0.05 ± 76%  perf-profile.children.cycles-pp.xhci_queue_ctrl_tx
      0.17 ± 31%      -0.1        0.10 ± 15%  perf-profile.children.cycles-pp.vfs_readlink
      0.12 ± 18%      -0.1        0.05 ± 46%  perf-profile.children.cycles-pp._find_next_bit
      0.14 ± 40%      -0.1        0.07 ±  9%  perf-profile.children.cycles-pp.simple_offset_rename
      0.12 ± 22%      -0.1        0.06 ± 50%  perf-profile.children.cycles-pp.realloc
      0.12 ± 37%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.generic_fillattr
      0.12 ± 19%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.set_task_cpu
      0.00            +0.1        0.08 ± 15%  perf-profile.children.cycles-pp.drm_gem_vunmap
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.ww_mutex_lock
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.drm_gem_fb_vunmap
      0.01 ±223%      +0.2        0.25 ± 27%  perf-profile.children.cycles-pp.drm_fb_helper_damage
      0.06 ±223%      +0.4        0.48 ± 19%  perf-profile.children.cycles-pp.drm_fbdev_shmem_defio_imageblit
      0.05 ±223%      +0.4        0.48 ± 19%  perf-profile.children.cycles-pp.sys_imageblit
      0.08 ±223%      +0.7        0.77 ± 21%  perf-profile.children.cycles-pp.bit_putcs
      0.08 ±223%      +0.7        0.78 ± 22%  perf-profile.children.cycles-pp.fbcon_putcs
      0.06 ±223%      +0.7        0.78 ±  7%  perf-profile.children.cycles-pp.wait_for_lsr
      0.09 ±223%      +0.7        0.82 ± 19%  perf-profile.children.cycles-pp.fbcon_redraw
      0.09 ±223%      +0.8        0.86 ± 18%  perf-profile.children.cycles-pp.con_scroll
      0.09 ±223%      +0.8        0.86 ± 18%  perf-profile.children.cycles-pp.fbcon_scroll
      0.09 ±223%      +0.8        0.86 ± 18%  perf-profile.children.cycles-pp.lf
      0.06 ±223%      +0.8        0.90 ±  7%  perf-profile.children.cycles-pp.io_serial_in
      0.10 ±223%      +0.9        1.00 ± 18%  perf-profile.children.cycles-pp.vt_console_print
      0.70 ±223%      +7.9        8.58 ±  8%  perf-profile.children.cycles-pp.io_serial_out
      0.77 ±223%      +8.7        9.50 ±  8%  perf-profile.children.cycles-pp.serial8250_console_write
      1.10 ±174%      +9.5       10.58 ±  8%  perf-profile.children.cycles-pp.usbhid_request
      0.87 ±223%      +9.6       10.50 ±  8%  perf-profile.children.cycles-pp._dev_warn
      0.87 ±223%      +9.6       10.50 ±  8%  perf-profile.children.cycles-pp.dev_printk_emit
      0.87 ±223%      +9.6       10.50 ±  8%  perf-profile.children.cycles-pp.dev_vprintk_emit
      0.87 ±223%      +9.6       10.51 ±  8%  perf-profile.children.cycles-pp.vprintk_emit
      0.88 ±223%      +9.6       10.52 ±  9%  perf-profile.children.cycles-pp.console_unlock
      0.87 ±223%      +9.6       10.52 ±  9%  perf-profile.children.cycles-pp.console_flush_one_record
      5.30 ±223%     +50.2       55.52 ±  4%  perf-profile.children.cycles-pp.memcpy_toio
      5.30 ±223%     +50.2       55.53 ±  4%  perf-profile.children.cycles-pp.drm_fb_memcpy
      5.30 ±223%     +50.2       55.53 ±  4%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      5.31 ±223%     +50.3       55.63 ±  4%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      5.31 ±223%     +50.3       55.64 ±  4%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      5.31 ±223%     +50.3       55.65 ±  4%  perf-profile.children.cycles-pp.commit_tail
      5.31 ±223%     +50.4       55.67 ±  4%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      5.33 ±222%     +50.4       55.69 ±  4%  perf-profile.children.cycles-pp.drm_atomic_commit
      5.38 ±220%     +50.4       55.77 ±  4%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      5.38 ±220%     +50.4       55.77 ±  4%  perf-profile.children.cycles-pp.drm_fbdev_shmem_helper_fb_dirty
      5.38 ±220%     +50.4       55.77 ±  4%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
     12.64 ± 99%     +55.1       67.74 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
     12.64 ± 99%     +55.1       67.74 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
     12.53 ±100%     +55.2       67.70 ±  4%  perf-profile.children.cycles-pp.kthread
      0.00           +55.6       55.62 ±  4%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      8.09 ±166%     +58.8       66.85 ±  4%  perf-profile.children.cycles-pp.worker_thread
      7.91 ±170%     +58.8       66.76 ±  4%  perf-profile.children.cycles-pp.process_one_work
      6.49 ± 17%      -4.7        1.79 ± 11%  perf-profile.self.cycles-pp.pv_native_safe_halt
      4.70 ± 15%      -3.0        1.74 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
      3.41 ± 15%      -1.9        1.53 ± 13%  perf-profile.self.cycles-pp.update_sg_lb_stats
      2.22 ± 10%      -1.4        0.78 ± 14%  perf-profile.self.cycles-pp.ktime_get
      1.90 ± 16%      -1.3        0.61 ± 17%  perf-profile.self.cycles-pp.update_rq_clock
      1.74 ± 10%      -1.1        0.64 ±  9%  perf-profile.self.cycles-pp.idle_cpu
      1.27 ± 15%      -1.0        0.27 ± 23%  perf-profile.self.cycles-pp.update_rq_clock_task
      1.63 ± 15%      -0.9        0.71 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.79 ± 32%      -0.7        0.12 ± 43%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      1.30 ± 18%      -0.6        0.68 ± 12%  perf-profile.self.cycles-pp.seccomp_run_filters
      0.92 ± 16%      -0.6        0.32 ± 13%  perf-profile.self.cycles-pp.get_jiffies_update
      0.77 ± 30%      -0.6        0.18 ± 11%  perf-profile.self.cycles-pp.__pi_memset
      0.70 ± 29%      -0.6        0.12 ± 26%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.64 ± 25%      -0.5        0.10 ± 22%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.72 ± 21%      -0.5        0.18 ± 12%  perf-profile.self.cycles-pp.__pi_memcpy
      0.70 ± 29%      -0.5        0.18 ± 24%  perf-profile.self.cycles-pp.native_sched_clock
      0.82 ±  8%      -0.5        0.34 ± 12%  perf-profile.self.cycles-pp.sched_balance_update_blocked_averages
      0.63 ± 20%      -0.5        0.16 ± 27%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.77 ± 17%      -0.5        0.31 ± 15%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.68 ± 21%      -0.5        0.22 ± 20%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.67 ± 22%      -0.4        0.23 ± 10%  perf-profile.self.cycles-pp.update_load_avg
      0.51 ± 30%      -0.4        0.09 ± 28%  perf-profile.self.cycles-pp.fold_vm_zone_numa_events
      0.59 ± 10%      -0.4        0.17 ± 20%  perf-profile.self.cycles-pp.tick_nohz_handler
      0.46 ± 47%      -0.4        0.06 ± 47%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.63 ± 24%      -0.4        0.27 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.48 ± 30%      -0.4        0.12 ± 24%  perf-profile.self.cycles-pp.__resched_curr
      0.43 ± 35%      -0.4        0.08 ± 22%  perf-profile.self.cycles-pp.clear_page_erms
      0.75 ± 21%      -0.4        0.40 ± 15%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.45 ± 30%      -0.3        0.14 ± 12%  perf-profile.self.cycles-pp.read_tsc
      0.41 ± 18%      -0.3        0.11 ± 32%  perf-profile.self.cycles-pp.menu_select
      0.82 ± 12%      -0.3        0.52 ±  7%  perf-profile.self.cycles-pp.malloc
      0.40 ± 34%      -0.3        0.10 ± 22%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.41 ± 37%      -0.3        0.12 ± 46%  perf-profile.self.cycles-pp.rcu_watching_snap_save
      0.48 ± 21%      -0.3        0.20 ±  6%  perf-profile.self.cycles-pp.path_find_first_component
      0.30 ± 17%      -0.3        0.04 ± 77%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.42 ± 30%      -0.2        0.18 ± 16%  perf-profile.self.cycles-pp.cfree
      0.44 ± 25%      -0.2        0.21 ± 17%  perf-profile.self.cycles-pp.siphash24_compress
      0.32 ± 27%      -0.2        0.09 ± 13%  perf-profile.self.cycles-pp.do_syscall_64
      0.41 ± 14%      -0.2        0.19 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.35 ± 27%      -0.2        0.13 ±  8%  perf-profile.self.cycles-pp._copy_to_user
      0.36 ± 20%      -0.2        0.15 ± 25%  perf-profile.self.cycles-pp.kmem_cache_free
      0.28 ± 29%      -0.2        0.08 ± 51%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.37 ± 25%      -0.2        0.17 ± 19%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.30 ± 23%      -0.2        0.10 ± 22%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.23 ± 42%      -0.2        0.03 ±105%  perf-profile.self.cycles-pp.handle_softirqs
      0.28 ± 20%      -0.2        0.08 ± 22%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.26 ± 31%      -0.2        0.06 ± 19%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.25 ± 37%      -0.2        0.07 ± 18%  perf-profile.self.cycles-pp.sched_balance_domains
      0.30 ± 28%      -0.2        0.12 ± 20%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.26 ± 32%      -0.2        0.08 ± 13%  perf-profile.self.cycles-pp.vfs_getattr_nosec
      0.30 ± 16%      -0.2        0.12 ± 30%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.21 ± 41%      -0.2        0.04 ± 73%  perf-profile.self.cycles-pp.pvclock_gtod_notify
      0.27 ± 24%      -0.2        0.10 ± 17%  perf-profile.self.cycles-pp.vsnprintf
      0.29 ± 20%      -0.2        0.12 ± 18%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.27 ± 37%      -0.2        0.10 ± 12%  perf-profile.self.cycles-pp.__schedule
      0.25 ± 26%      -0.2        0.09 ± 25%  perf-profile.self.cycles-pp.mutex_lock
      0.22 ± 30%      -0.2        0.07 ± 11%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.26 ± 22%      -0.2        0.12 ± 24%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.21 ± 26%      -0.1        0.06 ± 49%  perf-profile.self.cycles-pp.__smp_call_single_queue
      0.22 ± 36%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.20 ± 47%      -0.1        0.06 ± 46%  perf-profile.self.cycles-pp.format_decode
      0.19 ± 22%      -0.1        0.06 ± 54%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.23 ± 31%      -0.1        0.10 ± 19%  perf-profile.self.cycles-pp.check_cpu_stall
      0.19 ± 29%      -0.1        0.06 ± 51%  perf-profile.self.cycles-pp.llist_reverse_order
      0.26 ± 20%      -0.1        0.14 ± 12%  perf-profile.self.cycles-pp.mempool_alloc_tile
      0.23 ± 15%      -0.1        0.11 ± 10%  perf-profile.self.cycles-pp.irqentry_enter
      0.26 ± 27%      -0.1        0.14 ± 12%  perf-profile.self.cycles-pp.siphash24_finalize
      0.19 ± 29%      -0.1        0.07 ± 18%  perf-profile.self.cycles-pp.sched_balance_rq
      0.16 ± 40%      -0.1        0.04 ±108%  perf-profile.self.cycles-pp.sched_tick
      0.18 ± 29%      -0.1        0.06 ± 21%  perf-profile.self.cycles-pp.number
      0.26 ± 12%      -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.strncpy_from_user
      0.18 ± 23%      -0.1        0.07 ± 18%  perf-profile.self.cycles-pp.arch_exit_to_user_mode_prepare
      0.15 ± 41%      -0.1        0.04 ± 75%  perf-profile.self.cycles-pp.__cond_resched
      0.18 ± 22%      -0.1        0.07 ± 12%  perf-profile.self.cycles-pp.update_dl_rq_load_avg
      0.13 ± 26%      -0.1        0.03 ±105%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.13 ± 57%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.step_into_slowpath
      0.12 ± 28%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.enqueue_entity
      0.20 ± 20%      -0.1        0.10 ± 23%  perf-profile.self.cycles-pp.startswith
      0.15 ± 28%      -0.1        0.06 ± 15%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.19 ± 22%      -0.1        0.10 ± 25%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.18 ± 24%      -0.1        0.10 ± 30%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.16 ± 28%      -0.1        0.07 ± 16%  perf-profile.self.cycles-pp.kfree
      0.13 ± 16%      -0.1        0.05 ± 49%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.11 ± 37%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.rcu_pending
      0.17 ± 37%      -0.1        0.09 ± 35%  perf-profile.self.cycles-pp.__d_lookup
      0.13 ± 29%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.path_extend_internal
      0.11 ± 34%      -0.1        0.05 ± 48%  perf-profile.self.cycles-pp._find_next_bit
      0.08 ± 11%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.update_process_times
      0.10 ± 20%      -0.1        0.05 ± 51%  perf-profile.self.cycles-pp.realloc
      0.00            +0.1        0.07 ± 20%  perf-profile.self.cycles-pp.ww_mutex_lock
      0.00            +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.fbcon_redraw
      0.05 ±223%      +0.4        0.48 ± 19%  perf-profile.self.cycles-pp.sys_imageblit
      0.06 ±223%      +0.8        0.90 ±  7%  perf-profile.self.cycles-pp.io_serial_in
      0.70 ±223%      +7.9        8.58 ±  8%  perf-profile.self.cycles-pp.io_serial_out
      5.29 ±223%     +50.2       55.48 ±  4%  perf-profile.self.cycles-pp.memcpy_toio




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

