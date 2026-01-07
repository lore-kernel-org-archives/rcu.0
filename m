Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C96207A32;
	Wed,  7 Jan 2026 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767767965; cv=fail; b=lfPXd6gRXOP+Ek7V+dBIiDkKW9fATyyrGPKsbbAahYSVBuAVdZ4uW6aaU1yhIeSDiNLLH4z12aE0nWMdf6+0FKynFrX4xoHXykNKsOk0i0gMXP7L59M0+HBZGzBc/On8ModhWJnvqIWTGuYMPZHKxiOENVr1hhSt4KLrhcfYf3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767767965; c=relaxed/simple;
	bh=KD6GAEvpfqCSRql1wH6jKSRcrHPyYHxQOChRP/C5imU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qFVThPvbEVwroXwy8oXXvELb61pJRTlUFO8MQpjU7FYDe3ISdEbdN06pDhQjZerPjMhGdCqwFs/f3Cq5GHJtoG+47gqyRcoFA4iLdJR/TK7oMHwF26rCOsJSTYB6ZfbaoAOuAvEBPSgZTwixAAMO7tsEamfFif5BF3l79reHt34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gc51amO1; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gc51amO1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767767961; x=1799303961;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=KD6GAEvpfqCSRql1wH6jKSRcrHPyYHxQOChRP/C5imU=;
  b=Gc51amO1/ebWIhqsDujcMvrQzevgyRig/MQ8oz8qt4uacRMIuvIJbcGF
   Q6WcKxyD39C+UgqDlBYbLFs9ji3SvsngAje5nBSKsO9yXqWHmdyVJpB1w
   VorJW3cyR5MgTroFJYTsxXRBtEgtHzSOE2eiGipifjC9859ULpgQ/lHKE
   OgJtLhXZbZ+ZjLPuFwhONBs6VPFOnS6zw8cbdTbtXl/icd1hDekObNKBs
   YXyOXb8FjuESvW4s/wC82uhr4Fyw2mQqLvoo9m08wfrjZ01dlwg9zUIAC
   oVCzrr2Hx+xqXyIV1M4yBBwNovCLKrsKkOjWd4kbgu5QAW5GyHSAUchvR
   A==;
X-CSE-ConnectionGUID: cvQmeloLR36RCeXJg/v0aQ==
X-CSE-MsgGUID: YtflSR+ESUyVoQVpklPoxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69182673"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="69182673"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 22:39:20 -0800
X-CSE-ConnectionGUID: QhzpSTSBTGiv7oy2O4zp1w==
X-CSE-MsgGUID: EgpwF2dNRUiWh6fP6NuX6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="240330905"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 22:39:21 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 6 Jan 2026 22:39:19 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 6 Jan 2026 22:39:19 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 6 Jan 2026 22:39:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6YeLr/a1KTQflp7rcvKvmZTBippZvoAjEah9+gsZYj5zpx/m3rvQSaoBtUN4WEaQXxbg9qs2xQyHzNZdCE4H3+/mEGhNtRvKulafzOqJgX6F5g9gNks2WXmh/OQNa0BhSiNy4A/OSveyQ7cpOsoYqCTlScpd9UqH0/7y6j4kQr/HJi0jZ0fX3nVXL4bOIG0ff+CPmMoWvWv6Z/Kc814JmgfDWpZa9tJyMbfY/DFkiKyLh2LRaIjhXX9x//akFah2KVHlkNoFMjlw1PxEl61lqwf4uR6zQ1da/5Dxh3N6MPtSIGW0c6i04Mgg3IDhk29HN6KMHlk7vu2LBPia/RppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3YpHoCFjRlpojh0JqOXkMQOfcncmPVLGN8uCrQCSfk=;
 b=LXZU0NZ8OirW3iH41/b2LXo1pdhXQFYH+LTfeloTBafXIqK41R6UyALI9pjJq8N3ROHOijWqkZqI3ERZVsrqmk9WHiskzYY0KQksHWeUSYi/fiQy8/MdM4zBD0q4FxczYPr0OYNWfTM4/3oOmRjcB1n1ZswtxunfJQ+rG+hvHWnqGvSzcGZ19yukGIFyrq6kutyRClGvZWa7z6ry6sh6k2tuDjIDhrimhli4cWdRIxVk9sq70G5Z/KbHthPcA9tblmSF/8bMGVT/6G2pM9wD6OLn5ldKn1HBox2stujKVKNwJ2kfvDUFCgHzccqIxdZivu9e0KHPRPbNS4AYmJA/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL1PR11MB5221.namprd11.prod.outlook.com (2603:10b6:208:310::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 06:39:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 06:39:16 +0000
Date: Wed, 7 Jan 2026 14:39:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, kernel test robot
	<oliver.sang@intel.com>, Andrii Nakryiko <andrii@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [paulmckrcu:dev.2025.12.16a] [rcu]  1ac50ec628:
 stress-ng.memfd.ops_per_sec 3.4% improvement
Message-ID: <202601071316.992a1d32-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL1PR11MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: 51498ed5-9615-4f07-d43a-08de4db77a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?vua0EtRZxqc1QFf757Da2K+wTw5G05GN4I7D57OJEbWGsyofn6sxejlU4S?=
 =?iso-8859-1?Q?zCgsbe99tiUiq7RaRqN9FfrXf2KT7T5qV2v5uL8cXznAIBjIFtF3XcET7M?=
 =?iso-8859-1?Q?bovO7uIFTHMHhmTy3MX93G/sr4o7stZ8FzYN73TPJHREvffrBMJf0Nn3DQ?=
 =?iso-8859-1?Q?y8WNp3cK53uw9v4mWIEdt5AipohM+USoCaquD6mXMoBFgt5cGN2UFHX0WE?=
 =?iso-8859-1?Q?QfRpqqGf8zqesa5fW7E6y2mieh9saZ/H6xlduipPBxYHoYKfpDxz3X6+B0?=
 =?iso-8859-1?Q?kRVtpuzx3x4Ld0BmlxVND4/AgBnKiHCf5TYGjylYBiNAyZQJFmJoUO6ndP?=
 =?iso-8859-1?Q?+/IQJPb+lSm+4YFEWh5DAAKhegg5mXZmuHlZzKv0pV+Hl8+AGSJdrEFqL3?=
 =?iso-8859-1?Q?dDVa5nznp7z22gwCX9fyyDp6Ozit9TnaL4ALRzkizapmlkngcV0N68E2Vl?=
 =?iso-8859-1?Q?weMpKdquWvNAVPohTKLOKJFzLnuEV2NcGg101x6/ZUutlNglL7Hngj0Jdf?=
 =?iso-8859-1?Q?YiPAUQ9CQI0egwDTW7J/t3BkWKA/GerLuzKK7TndM/QepauZVputwuGsF4?=
 =?iso-8859-1?Q?PgxpxB5uOfvbZMzFzLG7PPcoy0hW/5GE6q9z52efCIPPKpCrR9jGR/5JUw?=
 =?iso-8859-1?Q?vdfq22Of2KTqdmjYxbaaAduIZoq2IzEEMgyVfFeY9MpDKsnNk1/r8XZiug?=
 =?iso-8859-1?Q?m3Wn98/G+wpnfYic2DnwVafdF7ZY0TP4PReWnQJGB7P6xwR1ZMjr+OEJGP?=
 =?iso-8859-1?Q?6fIbskLJPJfuSUJIOW1beY3YvrWYGvpJC34i7+kW9pQWHhXwPZTA0eiNO0?=
 =?iso-8859-1?Q?eq3s/x66Ld966eWxufKNRP4VVyJ7XQxiNMzFUC5B2vLhm9SjSfDiQp4Mqe?=
 =?iso-8859-1?Q?VwwW1D44dYTEt+i/4Aahd2F0ZWMTl2DapnVLrjQEIni1z7sUEOCNzLXq1b?=
 =?iso-8859-1?Q?OXyQTS4lR8qk1l4HjLH5oa9WCu1Rbhaw4l56sHbiZ/ZzDn3ssX/BvVKiYP?=
 =?iso-8859-1?Q?72FecNMkFPffzyTEAcoWrTFpAANjhxyotTm4m3cWupmmYkLu7jtaHi5y3b?=
 =?iso-8859-1?Q?9vJ+gCTWaoC8bk0rao1msdpoYGA01fusTgoqbzVzKFsBG+PtB4K1mmpgZ9?=
 =?iso-8859-1?Q?Pmk7DicwWEKSNNNS4Z4TSBn8b6s8O5AS4HlIRVTIj3S455mCY93nq1k+Hf?=
 =?iso-8859-1?Q?3BsuafMCXovh0PhipIyvqUGQHh8Kk3VUcg9hNfp3V6UBmPkGVmGJ7ejnbr?=
 =?iso-8859-1?Q?zPRhJB+bfID67C9YXiW9bqCMiHuPxyNHyARlA57tamM1KEJ8srIOXTTepR?=
 =?iso-8859-1?Q?KdKAz4TCs8g7YIRsAg0w98CzcXr+ca/l078bsOasfpVoC4Urp1rI93WMyg?=
 =?iso-8859-1?Q?GQrfXaaDdNj1gHMDFvgCk9VQ6WfhK/nIZDuxdKCy0X25cxr22ubKzvTZUg?=
 =?iso-8859-1?Q?OCItUTrSQ15ucc+FepoddV0M/yGbhtyFglAQMu0NdLQc3Wi6YWo683ymwV?=
 =?iso-8859-1?Q?HGOwXcawHOxg//iMYdFKYuBuf9TFmzFyLc9DCS7j9RpA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?10csJM9CJGZ1G4cA21Wy8mZxo77bwDnjfmJfBNB3dIEhzYTxejIM949Xod?=
 =?iso-8859-1?Q?N/An/p6k3REMzzhGqRIHiI1mFe9lSLwmY+Tj9rY0bU7Uw1NmtIQTqoXm4I?=
 =?iso-8859-1?Q?o5O18gVMROwgF0x5uDoQflt9YH7GMRUo9uykze5P35H5aEJ3uxAtL7N5Op?=
 =?iso-8859-1?Q?ps6HmqeXZlcmF7JM84fPL4prBGUv5llXPbnaLgiVdMemUZJr6fqqiquv6m?=
 =?iso-8859-1?Q?kORcgZtNHpi0nAoQ//A0hBQ/g98sKHmpnEi7HUdzk35q3fWYnJXqjMN5mW?=
 =?iso-8859-1?Q?lPWfAZwlCvvKIk7WCFi88Ql6gJtxoKZqlAVOvfPRa4NifNjLqE30bttTBe?=
 =?iso-8859-1?Q?I4deQKstxtqxW01S2FUu0BCGrbkEcq2q7yAcAyCXEJsCzszsAcY6y38QxK?=
 =?iso-8859-1?Q?0EWf34GR8e+NQa3QiTgUzEsPPPZvymm2VyBcSo19Gudpi1riy2d4NHRikq?=
 =?iso-8859-1?Q?yPYSbrJ6U66SlS94Myk7SrcT7n077XXzIfuxIujoPMWVJPgSK7CoetejNW?=
 =?iso-8859-1?Q?jC4x/tmPOb5kOSDP0T0jecVPn5MdFKU/6xl6hfgXluZUgKqHlfUv6wR7TU?=
 =?iso-8859-1?Q?JFwUupiDbIpKBHY25CgNWp+XjZ190r/Azi7SEX6CwBR5NlhnhIbpJYqMGh?=
 =?iso-8859-1?Q?pwF46j0eQNGmeQHeO49MWCz/7mCyz1oVKuM2gHBDmdjsVVKxoTrciPzRql?=
 =?iso-8859-1?Q?nvHtjVZS1Ej+J9d9DI66fMCxL8MO3p/t4vKFQvo32Y95lyZV1tmaR0QYpe?=
 =?iso-8859-1?Q?pzVlbx05k7OUR8tAprbAudCfopRPqNGdEg7MyRI4YEG8KI0wQNmgGPEPNC?=
 =?iso-8859-1?Q?Nh4DbypR+dtLtYhMYN7mcZsRMXSccMbvJftHyNItl6b4zNUigNDCjK0+wu?=
 =?iso-8859-1?Q?Lv6zoE9nxmz9ied5V2Nxy+hasI+K608Kq7Qrz9IwskeCIcyqGofJgWvCQS?=
 =?iso-8859-1?Q?1iMshkmhafMivxgFhkmBq9sK/fR2p5sgUeWSop1keQu1bxmDl1fzmIzLvu?=
 =?iso-8859-1?Q?aI4O739IXJDP2svvor+5tdc2xn7BeeRVA4M9noXIZO9cVG3N48TL4kP8uK?=
 =?iso-8859-1?Q?KfdAijx41QolgI3fHOfp9SjdeRx5UJkCDTF1S0LOgmd70zF7jLVnM7Edug?=
 =?iso-8859-1?Q?aZroCCqkseMiDOd5blcrKpXFXgxEzAad8Yh3gqykJbj/Xb+IkrsuEyfNiL?=
 =?iso-8859-1?Q?P6uNJ1pYPpWHeTdEs7RkNLhPvRDK2rYPAH/kJsyWJPJ6L9GnQD+vdxqtZF?=
 =?iso-8859-1?Q?HqNyLjVm16b7CpZXfLAMrN3gwP9BN0qnjgHwbxLRPW1VnTiD5LAKthtG8q?=
 =?iso-8859-1?Q?cOyd/3JuWQA3kI1vGyXU/6+2U6FrUwH9FIuIqA8ZbN76Idf3EL+ZHi5l42?=
 =?iso-8859-1?Q?RhZNq0A9sPZlghYlIGm8n1FQJtXbx0wYaUMBzi+fp8glRReO75oJu9xhc/?=
 =?iso-8859-1?Q?tqLl3MlHVx1epaFEXJZCE/P2ddMC9w93xs/8MK5tLdfdkLC05n+SJw5mu/?=
 =?iso-8859-1?Q?NwaSvN8iNT7P8D14oVyMDAmudMg8lSfzNZP1UsLgq2ElkiP/wwY1XuomET?=
 =?iso-8859-1?Q?ewJReP+M55wr/qTTa5hltaKx7ADb2nOzxrzrspQQll2nOZF3r/cYrqBzFi?=
 =?iso-8859-1?Q?+fTi/jt3LDOzuRm3UIGJuY4sueB3b4Yabm1Pn3COt+bzK3rG5sPLtFOGfB?=
 =?iso-8859-1?Q?lCYwtuWK/cofwan8wkUrnc5uBVdenA1ihAt1O+eDiUztx/ak/wEqbR97jy?=
 =?iso-8859-1?Q?biwvyQgtUiy5AVzbcBZyk7aVUT2jW49MT0ZbuSpv4YLfsq6sXMvHGHgHPB?=
 =?iso-8859-1?Q?pr0k0U4kqA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51498ed5-9615-4f07-d43a-08de4db77a53
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 06:39:16.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMP0SG4ryfKNzBwsGO+RCboZTamXLRePX+cPSu8jgIWFQ8zsKpts6lgCdpiyfNiXK7ZCGMds01WFNZuJpjj6Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5221
X-OriginatorOrg: intel.com


hi, Paul E. McKenney,

similar to b41f5a411f report we just made out. we make this report based on
stable data.
please educate us if this report is less meaningful. thanks


Hello,

kernel test robot noticed a 3.4% improvement of stress-ng.memfd.ops_per_sec on:


commit: 1ac50ec62874025381a864f784583dbdc30dcc7c ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
https://github.com/paulmckrcu/linux dev.2025.12.16a

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: memfd
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260107/202601071316.992a1d32-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp2/memfd/stress-ng/60s

commit: 
  43c23963b3 ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
  1ac50ec628 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")

43c23963b3c549da 1ac50ec62874025381a864f7845 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    203232 ± 22%     -21.8%     158902 ± 18%  numa-meminfo.node1.Mapped
     50977 ± 22%     -21.8%      39853 ± 18%  numa-vmstat.node1.nr_mapped
      7039            +1.6%       7152        vmstat.system.cs
    107613            -3.9%     103453        stress-ng.memfd.nanosecs_per_memfd_create_call
    193537            +3.4%     200175        stress-ng.memfd.ops
      3226            +3.4%       3337        stress-ng.memfd.ops_per_sec
    187908            +1.6%     190921        stress-ng.time.involuntary_context_switches
  99134672            +3.4%  1.025e+08        stress-ng.time.minor_page_faults
     61965 ±  3%      -6.2%      58116        proc-vmstat.nr_mapped
 1.526e+08            +3.4%  1.578e+08        proc-vmstat.numa_hit
 1.524e+08            +3.4%  1.576e+08        proc-vmstat.numa_local
 1.631e+08            +3.4%  1.687e+08        proc-vmstat.pgalloc_normal
  99574028            +3.4%   1.03e+08        proc-vmstat.pgfault
 1.624e+08            +3.4%  1.679e+08        proc-vmstat.pgfree
      2.26            +1.1%       2.28        perf-stat.i.MPKI
 1.646e+10            +1.8%  1.675e+10        perf-stat.i.branch-instructions
      0.24            +0.0        0.25        perf-stat.i.branch-miss-rate%
  38660390            +6.8%   41301381        perf-stat.i.branch-misses
 1.714e+08            +3.1%  1.768e+08        perf-stat.i.cache-misses
 2.884e+08            +3.3%  2.979e+08        perf-stat.i.cache-references
      6758            +1.3%       6846        perf-stat.i.context-switches
      7.88            -2.0%       7.73        perf-stat.i.cpi
      3504            -3.1%       3397        perf-stat.i.cycles-between-cache-misses
 7.628e+10            +2.0%  7.783e+10        perf-stat.i.instructions
      0.13            +2.0%       0.13        perf-stat.i.ipc
     17.01            +3.5%      17.59        perf-stat.i.metric.K/sec
   1632582            +3.5%    1689088        perf-stat.i.minor-faults
   1632582            +3.5%    1689088        perf-stat.i.page-faults
      2.25            +1.1%       2.27        perf-stat.overall.MPKI
      0.23            +0.0        0.25        perf-stat.overall.branch-miss-rate%
      7.91            -2.0%       7.76        perf-stat.overall.cpi
      3519            -3.1%       3411        perf-stat.overall.cycles-between-cache-misses
      0.13            +2.0%       0.13        perf-stat.overall.ipc
 1.619e+10            +1.8%  1.648e+10        perf-stat.ps.branch-instructions
  37927942            +6.8%   40525278        perf-stat.ps.branch-misses
 1.687e+08            +3.1%   1.74e+08        perf-stat.ps.cache-misses
 2.841e+08            +3.3%  2.933e+08        perf-stat.ps.cache-references
      6638            +1.4%       6729        perf-stat.ps.context-switches
 7.503e+10            +2.0%  7.654e+10        perf-stat.ps.instructions
   1606108            +3.5%    1661536        perf-stat.ps.minor-faults
   1606108            +3.5%    1661536        perf-stat.ps.page-faults
 4.564e+12            +1.8%  4.647e+12        perf-stat.total.instructions
     46.05            -0.3       45.79        perf-profile.calltrace.cycles-pp._raw_spin_lock.inode_sb_list_add.new_inode.__shmem_get_inode.__shmem_file_setup
     45.93            -0.3       45.68        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.inode_sb_list_add.new_inode.__shmem_get_inode
     46.36            -0.3       46.10        perf-profile.calltrace.cycles-pp.__shmem_get_inode.__shmem_file_setup.__x64_sys_memfd_create.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.12            -0.3       45.87        perf-profile.calltrace.cycles-pp.inode_sb_list_add.new_inode.__shmem_get_inode.__shmem_file_setup.__x64_sys_memfd_create
     46.26            -0.3       46.01        perf-profile.calltrace.cycles-pp.new_inode.__shmem_get_inode.__shmem_file_setup.__x64_sys_memfd_create.do_syscall_64
     46.57            -0.2       46.32        perf-profile.calltrace.cycles-pp.__shmem_file_setup.__x64_sys_memfd_create.do_syscall_64.entry_SYSCALL_64_after_hwframe.memfd_create
     46.62            -0.2       46.38        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.memfd_create
     46.61            -0.2       46.37        perf-profile.calltrace.cycles-pp.__x64_sys_memfd_create.do_syscall_64.entry_SYSCALL_64_after_hwframe.memfd_create
     46.64            -0.2       46.40        perf-profile.calltrace.cycles-pp.memfd_create
     46.62            -0.2       46.37        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.memfd_create
     45.57            -0.2       45.38        perf-profile.calltrace.cycles-pp._raw_spin_lock.evict.__dentry_kill.finish_dput.__fput
     45.40            -0.2       45.22        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.evict.__dentry_kill.finish_dput
     46.69            -0.2       46.53        perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.61            -0.2       46.45        perf-profile.calltrace.cycles-pp.finish_dput.__fput.task_work_run.exit_to_user_mode_loop.do_syscall_64
     46.73            -0.2       46.57        perf-profile.calltrace.cycles-pp.close_range
     46.71            -0.2       46.55        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close_range
     46.71            -0.2       46.55        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close_range
     46.73            -0.2       46.57        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.close_range
     46.73            -0.2       46.57        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.close_range
     46.60            -0.2       46.45        perf-profile.calltrace.cycles-pp.__dentry_kill.finish_dput.__fput.task_work_run.exit_to_user_mode_loop
     46.40            -0.2       46.24        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.finish_dput.__fput.task_work_run
      0.59            +0.0        0.60        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.56            +0.0        0.57        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.62            +0.0        0.64        perf-profile.calltrace.cycles-pp.__munmap
      0.59            +0.0        0.60        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.57            +0.0        0.59        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.59            +0.0        0.61        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      0.59            +0.0        0.61        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.98            +0.0        1.01        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.94            +0.0        0.97        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.94            +0.0        0.97        perf-profile.calltrace.cycles-pp.do_shared_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.01            +0.0        1.04        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_memfd_child
      0.83            +0.0        0.86        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_shared_fault.do_fault
      0.84            +0.0        0.87        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_shared_fault.do_fault.__handle_mm_fault
      0.84            +0.0        0.88        perf-profile.calltrace.cycles-pp.__do_fault.do_shared_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.08            +0.0        1.12        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_memfd_child
      1.09            +0.0        1.14        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_memfd_child
      1.25            +0.1        1.30        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_memfd_child
      1.26            +0.1        1.32        perf-profile.calltrace.cycles-pp.stress_memfd_child
      0.81 ±  2%      +0.1        0.91 ±  2%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.80 ±  3%      +0.1        0.90 ±  2%  perf-profile.calltrace.cycles-pp.__mmap_region.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.99 ±  2%      +0.1        1.11        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.00 ±  2%      +0.1        1.13        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.03 ±  2%      +0.1        1.16        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      1.02 ±  2%      +0.1        1.15        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.03 ±  2%      +0.1        1.16        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.21            +0.1        1.35        perf-profile.calltrace.cycles-pp.__mmap
     92.36            -0.4       91.92        perf-profile.children.cycles-pp._raw_spin_lock
     92.52            -0.3       92.17        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     46.12            -0.3       45.87        perf-profile.children.cycles-pp.inode_sb_list_add
     46.26            -0.3       46.01        perf-profile.children.cycles-pp.new_inode
     46.36            -0.3       46.10        perf-profile.children.cycles-pp.__shmem_get_inode
     46.57            -0.2       46.32        perf-profile.children.cycles-pp.__shmem_file_setup
     46.61            -0.2       46.37        perf-profile.children.cycles-pp.__x64_sys_memfd_create
     46.65            -0.2       46.41        perf-profile.children.cycles-pp.memfd_create
     47.18            -0.2       47.01        perf-profile.children.cycles-pp.__fput
     47.10            -0.2       46.94        perf-profile.children.cycles-pp.finish_dput
     46.73            -0.2       46.57        perf-profile.children.cycles-pp.close_range
     47.09            -0.2       46.93        perf-profile.children.cycles-pp.__dentry_kill
     46.88            -0.2       46.72        perf-profile.children.cycles-pp.evict
     46.71            -0.2       46.55        perf-profile.children.cycles-pp.exit_to_user_mode_loop
     46.71            -0.2       46.55        perf-profile.children.cycles-pp.task_work_run
     97.60            -0.1       97.51        perf-profile.children.cycles-pp.do_syscall_64
     97.61            -0.1       97.53        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.14            +0.0        0.15        perf-profile.children.cycles-pp.xas_create
      0.11            +0.0        0.12        perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      0.11            +0.0        0.12        perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.mas_rev_awalk
      0.12            +0.0        0.13        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.12            +0.0        0.13        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.29            +0.0        0.30        perf-profile.children.cycles-pp.kmem_cache_free
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.xas_expand
      0.17 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.22            +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.flush_tlb_func
      0.47            +0.0        0.49        perf-profile.children.cycles-pp.kthread
      0.47            +0.0        0.49        perf-profile.children.cycles-pp.ret_from_fork
      0.47            +0.0        0.49        perf-profile.children.cycles-pp.ret_from_fork_asm
      0.23            +0.0        0.25        perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.12 ±  4%      +0.0        0.14        perf-profile.children.cycles-pp.shmem_alloc_folio
      0.46            +0.0        0.48        perf-profile.children.cycles-pp.run_ksoftirqd
      0.14 ±  3%      +0.0        0.16        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.13 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.vm_unmapped_area
      0.15 ±  3%      +0.0        0.17        perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.08 ±  5%      +0.0        0.10        perf-profile.children.cycles-pp.mas_empty_area_rev
      0.59            +0.0        0.60        perf-profile.children.cycles-pp.__vm_munmap
      0.53            +0.0        0.55        perf-profile.children.cycles-pp.handle_softirqs
      0.52            +0.0        0.54        perf-profile.children.cycles-pp.rcu_do_batch
      0.56            +0.0        0.57        perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.59            +0.0        0.61        perf-profile.children.cycles-pp.__x64_sys_munmap
      0.52            +0.0        0.54        perf-profile.children.cycles-pp.rcu_core
      0.31            +0.0        0.33        perf-profile.children.cycles-pp.unmap_page_range
      0.13 ±  2%      +0.0        0.15        perf-profile.children.cycles-pp.unmapped_area_topdown
      0.15 ±  2%      +0.0        0.17        perf-profile.children.cycles-pp.__get_unmapped_area
      0.28            +0.0        0.30        perf-profile.children.cycles-pp.zap_pte_range
      0.63            +0.0        0.65        perf-profile.children.cycles-pp.__munmap
      0.57            +0.0        0.59        perf-profile.children.cycles-pp.do_vmi_munmap
      0.15 ±  2%      +0.0        0.17        perf-profile.children.cycles-pp.shmem_get_unmapped_area
      0.21            +0.0        0.23        perf-profile.children.cycles-pp.zap_page_range_single
      0.36            +0.0        0.38        perf-profile.children.cycles-pp.__mmap_new_vma
      0.29            +0.0        0.31        perf-profile.children.cycles-pp.zap_pmd_range
      0.19            +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.zap_page_range_single_batched
      0.23            +0.0        0.26        perf-profile.children.cycles-pp.unmap_mapping_range
      0.05            +0.0        0.08        perf-profile.children.cycles-pp.perf_iterate_sb
      0.51            +0.0        0.54        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.98            +0.0        1.02        perf-profile.children.cycles-pp.__handle_mm_fault
      0.94            +0.0        0.97        perf-profile.children.cycles-pp.do_fault
      0.94            +0.0        0.97        perf-profile.children.cycles-pp.do_shared_fault
      1.01            +0.0        1.04        perf-profile.children.cycles-pp.handle_mm_fault
      0.84            +0.0        0.87        perf-profile.children.cycles-pp.shmem_fault
      1.09            +0.0        1.12        perf-profile.children.cycles-pp.do_user_addr_fault
      0.84            +0.0        0.88        perf-profile.children.cycles-pp.__do_fault
      1.09            +0.0        1.14        perf-profile.children.cycles-pp.exc_page_fault
      0.14 ±  3%      +0.0        0.18        perf-profile.children.cycles-pp.perf_event_mmap
      0.13 ±  3%      +0.0        0.17        perf-profile.children.cycles-pp.perf_event_mmap_event
      1.02            +0.0        1.06        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.fault_dirty_shared_page
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.perf_event_mmap_output
      1.40            +0.1        1.46        perf-profile.children.cycles-pp.asm_exc_page_fault
      1.53            +0.1        1.60        perf-profile.children.cycles-pp.stress_memfd_child
      0.81 ±  2%      +0.1        0.91 ±  2%  perf-profile.children.cycles-pp.mmap_region
      0.80 ±  2%      +0.1        0.90 ±  2%  perf-profile.children.cycles-pp.__mmap_region
      0.99 ±  2%      +0.1        1.11        perf-profile.children.cycles-pp.do_mmap
      1.00 ±  2%      +0.1        1.13        perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.02 ±  2%      +0.1        1.15        perf-profile.children.cycles-pp.ksys_mmap_pgoff
      1.22            +0.1        1.36        perf-profile.children.cycles-pp.__mmap
     92.16            -0.4       91.80        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.mas_rev_awalk
      0.12            +0.0        0.13        perf-profile.self.cycles-pp.native_flush_tlb_one_user




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

