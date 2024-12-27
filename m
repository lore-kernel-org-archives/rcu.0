Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C6146D6E
	for <rcu@vger.kernel.org>; Fri, 27 Dec 2024 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735291095; cv=fail; b=dvj0hQt1hmv1Bjp6YU4qvyvYDEMnlVpzTv8q3kJvxAMHA4YB0CtWcCPphtqRnwsrhAhtpPHQJHJ/VDXOVDVlOjT/oUeZkuhkxTpJ75qyMdHMB/Xm6Wr5nsCTrADhfo7Wb4poyNRMQaNdCPn4u5aLyS/SYCyNJ6e/125RYAWbFcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735291095; c=relaxed/simple;
	bh=zJPWHfG/bNf98sBoKVqz1J8J/NpI9sij9pQD1sxpDIw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PRzZNyo5EDvuSz8sImzal2PD7Gf3GNQm02EiHWblrI42T72KkiGZqeOdOHC31YyIH5XFRkHsUQT84aw0RWrGpHe4sy41Vm9/smeUhb38WKybmUrASxYx+GaADRp7vL6wLtohGiULV4UCaW4W7PQ6bM/ZgwAy/NAxqPoWgQGPWRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LK26PiHf; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LK26PiHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735291094; x=1766827094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zJPWHfG/bNf98sBoKVqz1J8J/NpI9sij9pQD1sxpDIw=;
  b=LK26PiHf7oWnGet7co27B0S/KsswHMxd/q7AgmxXJpOI4J1KoJ7Rjb9k
   l2UqFWKJSJXLIhN0IFB3G9x4Mr+CxtrcbAV5cir2iiHMKvEb2TJ0YlEv+
   /H1f3Emk3OW3ZrvVAfzliDhlB/yHJuJGK9EitE+wa3sHCRo0YoicRBhxa
   4Mk5PZckbJxBCAyeYdH2NpOJM8SSSRMMQzRlpgD0tsdk6HWx+4BDaf0Zm
   RW/lv65uRq+nQ5smDu2jnbGMJsB8AIBgzyDA1V1iX6dzdy5azm2zjFcjp
   WGFx4wOWSd9ZQhboRNMILie9mlbbI+uY6bepsB/BFmELaurYbh0WMMs7c
   Q==;
X-CSE-ConnectionGUID: q0pbclrNRU2syLC3JH5IyA==
X-CSE-MsgGUID: P0ORUFg1QH2ikDdkWfYzPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="61074328"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="61074328"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 01:18:13 -0800
X-CSE-ConnectionGUID: MXXYUfaVT36187ixkwkY4g==
X-CSE-MsgGUID: beEXqplsSuayezREj2J8Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104193201"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2024 01:18:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 27 Dec 2024 01:18:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 27 Dec 2024 01:18:12 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 27 Dec 2024 01:18:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qli/Tb9T3NPCeUzter9aoMdQIUxYdGvVm5TQP5z3+QKGCyTx5AIPmXO4NEewX0XWplbTvfUEypGUu0MoIZZJiSN4dv7aiKZGGIXZGtfMhurDt41+63u27+fvddz6JvfniYWvJ+YBwWhwKD9KlXmbOhpjMUyniHlhm9xN2My7B0sDfvjRwH583CMsYzlyj+aTwP02b6zfvXIP1GoEju7Z+KiF0TmixXeipi/R5RKCvq6wZMh35tB/7SHnH4yYB8dXfJvO7jbfeHUvi/yNKKSwStFG40Jj7X+YatphAWMwLf80TgwS4sD6T3pxVtwiB/R4FcFLuPcwaOWOxj2s2+5Fhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEe0sBYcY19vRkIYm7dPJncHBygGh/pJX5KxIL07eng=;
 b=bJ1OGEnd51133NC41MeIupw7d/bNQjIntUZkkUcTVQeW7SW51on7VRU01YzMOjwl/I9U1MDmHbgU5vC0nbRtBeeGW/0CtN+rc8QJhUfIMNfiixBbYfXgPsjABOA8GybGEl2um8YqHmYcgHyg7Ic7L/uPvJCi+AVOJ31WR+MSuCPKsUYzDC2YB55ikEkhJ5e0YNZ9Rdzjmk/OMoqYVwCw0gPZPQXMKysZJF/xaUUnW0uKFGobMlKkKM5gH4vAIr1CMd5YpC9lTHkwxcHS+EgbgDr4Sgqu/cE9BBIebLAB1dwlP8cEX80uUCVPyavBgeEjRJ0rq8CjP+wNZ/oULO1JtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4791.namprd11.prod.outlook.com (2603:10b6:510:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Fri, 27 Dec
 2024 09:17:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 09:17:26 +0000
Date: Fri, 27 Dec 2024 17:17:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <rcu@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2024.12.23a] [srcu]  c634c0678e:
 UBSAN:array-index-out-of-bounds_in_kernel/rcu/srcutree.c
Message-ID: <202412271623.8ceb422e-lkp@intel.com>
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
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4791:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4ac927-e832-49ad-ea4d-08dd265747bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9t3i0FSX0GMRK8UgPoOpMOTJUmQ60jI3iVrKbWk73Ax0jY/9/WBanBXadXlm?=
 =?us-ascii?Q?X6V/3xfNRizElFdNgOzkSSDWi+DdjZIA1nQooXBpMt7/wOdhZnAtau3BBT6V?=
 =?us-ascii?Q?30Q3LaQ3RDpylXTmbF9tyTk032AgBtrhJH1VML85RdQZOEvs27HRotpJXTqN?=
 =?us-ascii?Q?SFBhsNTRv12xIHY8LgaF5u8F1Yrpz0nLINFtAkbhnhHu9Ofet0OFDyoiiK0/?=
 =?us-ascii?Q?PCuFbXqlivNIHxPGqe1Eof8TXsp3LWwimVIllUwupUnECG8/VpGDy7+AOCv7?=
 =?us-ascii?Q?PqtPYN+uH9Vpyu77Mzh/O5HxfXszDLFDWynT86qx17uDkIZNkld9FIXDxdnk?=
 =?us-ascii?Q?tAYH5f6WgLG//2S4DhWbZT5WwG0PlaGX1DTP/gLEDjOK+kcPmnHVc1V0TxID?=
 =?us-ascii?Q?bdfDAdQKNX+H5GmoTXXAy5Do5ptVRG26xLwP+fz9aJ+tzKFS4H1xG6BSBRkt?=
 =?us-ascii?Q?WQmzhV5BmMXuh0EjnKWvKv+ZzcmKQctUGnKI6jbSt4ZbBMCjwmjUrDHPNPX8?=
 =?us-ascii?Q?9uKqtBMT3tovQ1oi7SVFAu+qpDh3gWl7XNhSS17kI8dzK94rbhgLp5PzZ7pK?=
 =?us-ascii?Q?Htk/7KDkAdAoz64uzRF0t2JZX8mL9c4k/6MCKs3FpdKH534w3TGCH1nBw3K0?=
 =?us-ascii?Q?7Ya/gXL4nhrvnA2lx9X3jtpzM70RAlMfZLVD4rbaakOyVLjHu32nJZOqWbHY?=
 =?us-ascii?Q?ebTVrxUhPZE4k54K7TqHezEgdMALP4655kY9rvpbDMHX4jmpRMwO4NoZlWUZ?=
 =?us-ascii?Q?uGPu0sIiiniWvzF8SW+CkjMVy+6KuD1g2xQDM+0vapWZwfJwzaWmfH7zhTVS?=
 =?us-ascii?Q?r6t7smk3dQhGlXEBCY1L0wmMNQ40VTZIDkBGZW9FD2jLnimTKNlElOaUMRDT?=
 =?us-ascii?Q?ekV+tFgHfxN4VtvZVY76e5m8zo5CB0L5ruNsZm/5+C4FTISYP+HX0SgYtDQu?=
 =?us-ascii?Q?FO+uYuxawTz2vMD1Mi2+xFGmaiH6W5b4M3vTSIcooPpOMFJQgW5K9n3mNRaw?=
 =?us-ascii?Q?pihAzmg9mumAMCQlW8YcZe3n8M7IeqxlSGJCrwjjq9JZ6S/6YbRuYhCTRK7w?=
 =?us-ascii?Q?dzEkp/mGIWuzwTTgPpv1qTf6T8wp47fZZKB0jfl1zDDo0JKUh4KMU228WPsQ?=
 =?us-ascii?Q?mBU1GaDXYMVaT3fDL5E32nY6giV22Rjq0Xp+yETeihYthoFt9RLLEkzyDirp?=
 =?us-ascii?Q?lPGT+tYlZvRAy2MgeV8AzwTiGMX5RW8r+xSVKMYJSJpDbMg2+BRd9kmfDvsk?=
 =?us-ascii?Q?N25nH3p1ZCUg2K/3kqkeRzkCJ5VHHANhn+4xD/k0pD8h+zo0AfiuScTf5H/w?=
 =?us-ascii?Q?hl0GfgitQ+15p1Y9FxrJy+bROhZzd27YVn8Z2DDVUeNVew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uETzzax9oGEkvrVnfiYrToZdhrktfoo2k5xJy4R7tNmmf//stTj5S1F1C0no?=
 =?us-ascii?Q?fuFxiqeYe08pzq0slSVgh5/EZOUYeF+es9dhfnAl5XplS+ZIFHSm8lv/fPch?=
 =?us-ascii?Q?6/OGTTKgb3ST3P1gCKa6abJD7Ou0ClnnvPqLkYsRbC+ry2Sxk9ldX2sYoIfC?=
 =?us-ascii?Q?ilh2RtvtCdt/pfFjn4Ya3U4M8QKxtGgXTYYfAZttbiG3xjRQebv7j9AgQB2i?=
 =?us-ascii?Q?vPx6OTY64Urqxw4Vhfg7SP424DRYWqIaDxHh8lnbrsoHHrkpoFKeWo+3UKhi?=
 =?us-ascii?Q?nSybSIdMmGBZZ1qO6v2hDIZ2T/nPtO3GYjsnlQpPN8RRDboT427rRBwLXKfG?=
 =?us-ascii?Q?x87vT6rDIhnBGywi/RjgHjyVvs9VCT0IXW0lP9qcl1gDEVjUccrcI8NeHOB4?=
 =?us-ascii?Q?0Jv7pIk3wR5hjDr5X3veByEvAwxNFJNDwXReMSpWm9hP3tFsm6yoA8RQ3ZGM?=
 =?us-ascii?Q?34VdbmCI1cCE0YHpEXq6goYpW0HJH7ablMA9Crb8I3VNkNHQBFHt+TG5zuhE?=
 =?us-ascii?Q?NvTw5EIk2r1/aDEmo6Wj6vkgqzzDfVD2wnv6SXLiZ7vMOvSIS9qlBn9pMTf5?=
 =?us-ascii?Q?qQDiIzAyS0nn58thNzUjBA4h75pkf4+t2Q98npFNW8IEZITyceBnHXdAPe80?=
 =?us-ascii?Q?W+aM9oNvvRSofAYqoIBvOSCTRcX0ECZD89T0zklSIM6q2InlmvgA3UeUBC9i?=
 =?us-ascii?Q?jgukBGdzvH+SKr41Y4YyF0Pe/QphoQMdEjB6rebnPP1OJw2Mx1xFPQthPiaB?=
 =?us-ascii?Q?Lhbc0Gi60s/DgbuNWUC4tZjF8Lamxne6yHXO6w6edPOU0j8yc/WWN5oR9/CO?=
 =?us-ascii?Q?Uf98Ogx/3ee4h8Lz815Kbd6VeURLef+6oLgmOYjP6aOEuERwQch6yND8SM9f?=
 =?us-ascii?Q?IX1HVCOAWK2vP53tgG4kFUSmTNGlEsKkiocHJVPgCtjbjFYobeDVjjQcodxS?=
 =?us-ascii?Q?PhE/lgl1Q+0n2VRlSbgHOripF8P0Cf8SKskpmNomyqRwiQxuyNu0kAY4e3f2?=
 =?us-ascii?Q?Z3pag/BjLk8w2pYRm7481cnnh+cYL21SRvT+Lk3RzxpUxJYzoK4HRvaxb8TZ?=
 =?us-ascii?Q?CYSaIEa0wa5UsrvN0IzhF5+p7+V8jXy6EGAyjzp9pfd9f0VIF1iyA+L7UVDe?=
 =?us-ascii?Q?0tA0WMY9E9lKJ9wbVGmwDMabILCQrxE4I0lKLK5B+FEB54WmoO+GS/hr3BKH?=
 =?us-ascii?Q?+1udSbFtA9zQCdYmK/hyiSPTO7DQxvozb0vuNz+FDhA34F0Fihm7EHllIVp6?=
 =?us-ascii?Q?AFJcmMlem8+0pUsn5cnjBoikMdKEvG1ljSD7acivQcyU9geeobFbF3npnvsH?=
 =?us-ascii?Q?xUx8TnTQLfN9jfSWQXanNBzjB+SMBAsKXiVia8dzS3odli+3eOlovAsb4Zkw?=
 =?us-ascii?Q?yupMJ260x956CgIr3gB/JJ3cCA+ZDvZNmjjOnFqllltm4B0QWTBmEdu1c5i+?=
 =?us-ascii?Q?yGqmjVau2E2AJJO2rsDdnbX3nP/MkVbbRTUpiYC4wFb7kOuaFpQDimViOG/O?=
 =?us-ascii?Q?YHQ+YtDV5dvjfGm/ts8eUsn3y8eezxTP11LgjjxnRrf3OqINJPC++K1y1Daq?=
 =?us-ascii?Q?yGA88yOEaEkENbP4sJQuBG7tjQnICNorA2N5z9nfEQkyFy7VH5tYUXiMxzbX?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4ac927-e832-49ad-ea4d-08dd265747bf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 09:17:26.5543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNCex+XiB5lk4GjCd+XXNiUUgy1kw4jQFkCR8v21hA7gyHMjC5EzzSoozLn1zHN30LgE8AaHJ9efkl2GdXYpBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4791
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "UBSAN:array-index-out-of-bounds_in_kernel/rcu/srcutree.c" on:

commit: c634c0678e8b46a432aaf2993cc3fb81b6941981 ("srcu: Make Tree SRCU updates independent of ->srcu_idx")
https://github.com/paulmckrcu/linux dev.2024.12.23a

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: srcud



config: x86_64-randconfig-074-20241226
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412271623.8ceb422e-lkp@intel.com


[  434.917288][ T2320] ------------[ cut here ]------------
[  434.938323][ T2320] UBSAN: array-index-out-of-bounds in kernel/rcu/srcutree.c:1918:9
[  434.941267][ T2320] index -23500 is out of range for type 'srcu_ctr [2]'
[  434.942019][ T2320] CPU: 1 UID: 0 PID: 2320 Comm: rmmod Tainted: G                T  6.13.0-rc1-00070-gc634c0678e8b #1
[  434.943103][ T2320] Tainted: [T]=RANDSTRUCT
[  434.943530][ T2320] Call Trace:
[  434.943893][ T2320]  <TASK>
[ 434.944224][ T2320] dump_stack_lvl (lib/dump_stack.c:123)
[ 434.944766][ T2320] ubsan_epilogue (lib/ubsan.c:232)
[ 434.945286][ T2320] __ubsan_handle_out_of_bounds (lib/ubsan.c:429)
[ 434.945896][ T2320] srcu_torture_stats_print (kernel/rcu/srcutree.c:1918)
[ 434.946535][ T2320] rcu_torture_stats_print (kernel/rcu/rcutorture.c:2445) rcutorture
[ 434.947574][ T2320] ? rcu_torture_preempt (kernel/rcu/rcutorture.c:2362) rcutorture
[ 434.948560][ T2320] ? kfree (mm/slub.c:4598 mm/slub.c:4746)
[ 434.948994][ T2320] ? vfree (mm/vmalloc.c:3388)
[ 434.949526][ T2320] ? rcu_torture_mem_dump_obj (kernel/rcu/rcutorture.c:2489) rcutorture
[ 434.950627][ T2320] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
[ 434.951294][ T2320] ? cleanup_srcu_struct (kernel/rcu/srcutree.c:711)
[ 434.951899][ T2320] rcu_torture_cleanup (kernel/rcu/rcutorture.c:3664) rcutorture
[ 434.952906][ T2320] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:225)
[ 434.953470][ T2320] ? rcu_torture_print_module_parms+0x104/0x104 rcutorture
[ 434.954601][ T2320] ? __mutex_unlock_slowpath (kernel/locking/mutex.c:914)
[ 434.955225][ T2320] ? build_sched_groups (kernel/sched/wait.c:383)
[ 434.955799][ T2320] ? write_comp_data (kernel/kcov.c:246)
[ 434.956334][ T2320] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:225)
[ 434.956905][ T2320] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
[ 434.961646][ T2320] __do_sys_delete_module+0x36a/0x4ed
[ 434.962321][ T2320] ? module_flags (kernel/module/main.c:732)
[ 434.962828][ T2320] ? ftrace_likely_update (kernel/trace/trace_branch.c:220)
[ 434.963408][ T2320] ? write_comp_data (kernel/kcov.c:246)
[ 434.963949][ T2320] ? ftrace_likely_update (kernel/trace/trace_branch.c:220)
[ 434.964556][ T2320] ? ftrace_likely_update (kernel/trace/trace_branch.c:220)
[ 434.965115][ T2320] ? write_comp_data (kernel/kcov.c:246)
[ 434.965639][ T2320] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:225)
[ 434.966188][ T2320] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
[ 434.966797][ T2320] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[ 434.967296][ T2320] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  434.967978][ T2320]  </TASK>
[  434.968715][ T2320] ---[ end trace ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241227/202412271623.8ceb422e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

