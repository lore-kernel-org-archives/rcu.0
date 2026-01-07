Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423813C0C;
	Wed,  7 Jan 2026 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767763948; cv=fail; b=CLCAMg8efxzJOZyxiRCMHunOjw3dNdeJcBjkUoePZLadPzvk0VlcykNhYcpdrBgXGU01pbNxYr/ub757x9gYk7EtG2SWKnACJXxdVP88aAjC1mPy1obfZicTxL5UPpR0raHpAl0XNFqBIZ6YqVrqfVviU0HSBHcdz6JWVmVzTK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767763948; c=relaxed/simple;
	bh=yLEwlC8rw8vzXu8UVJQcKxpv5LT1rI11sSZIqfQ0qBA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=NfHDnxGB/HifY4Wm6jvhjze/eWYc/Q5pkED4K3/UywcLtTGIblrH51OvEubl8Y4Pp0cf5opjRZn1DFfg3BexmX9pOkwqc6S7ildz6fuyzTGNZu/RaD56LpgPueko4JnR/yT3nuIlrRzIvUdNq5AZ2X8Kji+OuBAIz68UY1JTzOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFot6kM1; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFot6kM1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767763946; x=1799299946;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=yLEwlC8rw8vzXu8UVJQcKxpv5LT1rI11sSZIqfQ0qBA=;
  b=SFot6kM1vZ6hQvXjkmy4JGUBkkU5q+rbeSj5y//Q8rUVvGQLy737NeQy
   BNO0P3bbJnw8UdK0S4KocmKGA3qbzS9awnwTmgOWRzuWCy+Onp9Vcxlnv
   Uem4vJX6aO/gihf4Q1Bdpw88bp5CdsvE/vEqDnz0IAuubQD+lWHYxGLfy
   oxBCOlFIfkzlYPf7r8ZSvcZO814p99UHKomgj018VQA1eMS4UzYhV8Rj3
   BN8oTaxWZe4vgEd58iBU3/g/vyF9fRcZNd05EPza2wFpYoF7Wx96TpVbJ
   B+n7/YFSikPUgS4Oh4hlBCCpQGWXuZh65B48hg1DTrnyccltVYlwDYUts
   w==;
X-CSE-ConnectionGUID: 0RvEoyH1T6WwGp6q+fKspw==
X-CSE-MsgGUID: g5ltzIWQR1CGJJwU5GjTng==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="80583963"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="80583963"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 21:32:26 -0800
X-CSE-ConnectionGUID: 1W1HwKBfSGOwi86XPJKsww==
X-CSE-MsgGUID: G/nWFQoESreu9TIY9sjbWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="203098524"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 21:32:25 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 6 Jan 2026 21:32:25 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 6 Jan 2026 21:32:25 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 6 Jan 2026 21:32:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5Jrui0JX5ENKJcGg6zgGo3KIVsktjS92G7nTZRDXMilyLeKwBII56zxR1Lr9AGgrDQGxGi3NC3vtCFhFn7PNnzQiivtTkZrSCpKdjv5S0qac3jjArrGzI7ZI1P+AAAACg8aJbms4/23mh5P3adliIthLnv82DZnGBUGnChJeuWl9JfFnxxRkHf3xaEzYJNTD58vU6p3yg8VA8XVp6Xdn2XuLdndNsX36s5H7YA3NVmg1eMbDs5vRsIxiaTJsckSCBhbokBFmG7d7eJ9+0ccH2dFS4h1ZnvixbKk1mrNjFip/mVAI/LiNd2H4vIwPi52my3v+ipYVJe0P/qoBaLDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzXaiJwXY5OVKFuxmeA/dvu/RnrKktL12jN77n2B9SY=;
 b=Nz1q2fpVzVfq01un1kLVOqsFQ49ZUxXKH3NDQrnBadH6uBTPU9fPzLFpUmefLSHMOCrDz9E8v2VMHfgbxFoskh4BKdb9JFDjrbMA4vvH7HRogL+p3IBperXDbKyhU3YphR1cX1jIml2QuMNaR7SAFgCkJ+/6nr2tJauQOaOU7DQKr3b/4lsx5uw/xdHM+Sw3E8fxpj6Rgu7oFaUEGixhxw8w9zGMk26ypRQMKBpChMmNNBsLl3bgYVjASYcOaMjWnQkvGhIuP60PEqFOkwxV7/Y7VUEyD505PIXrsUPP6O3QO9uCgmfcQp7uKp0bTrsPOyZ8cqmj6V0VQvfLCm5Hfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB8068.namprd11.prod.outlook.com (2603:10b6:806:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 05:32:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 05:32:17 +0000
Date: Wed, 7 Jan 2026 13:32:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrii Nakryiko
	<andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, <linux-doc@vger.kernel.org>, <rcu@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2025.12.16a] [rcu]  b41f5a411f: unixbench.throughput
 2.0% improvement
Message-ID: <202601071255.645ef92e-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 689396a1-a74d-4993-1719-08de4dae1f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?nc/+f/tHULkLH++Ri9CMbPZqLnPLZ+muJ5THig1vdAa6If9oWNQjsdGry9?=
 =?iso-8859-1?Q?jvyS93nXw66IllDuUiM30vP2YBRzkIAOyxbr91hXRLvWOCT80HBDt81nD8?=
 =?iso-8859-1?Q?0j856WpB9GmmpqEquJQzuJv5SEfrHGjYslMCKT2of4FR8vYcRWLhAx1s7u?=
 =?iso-8859-1?Q?0yRmYhcaGbYf30sjP++81VbyUaxpM6/tr+avKWegFp5msgy0+BilB5/uHq?=
 =?iso-8859-1?Q?1DK9CHbtzWzPo7FVERZOeWmob8A4Klf6iDJk6aN2igaXDURnh7MJJK7T6H?=
 =?iso-8859-1?Q?ub/YJTsWhed9HYZaU6dvvYzrAJSf5vQKe+bTmvRxCzIhBqffTEGMno6hFy?=
 =?iso-8859-1?Q?rcRuioSf7cWhivTwjU8Z45WjqxuKrS90tAuZfkkdhNfnsl9vcoBdIcNDHF?=
 =?iso-8859-1?Q?iHDPfKL+R1hpZBJRSca1humWDs4a2SDJ20VjHro3YY+3pDoxo+EM1U1xWp?=
 =?iso-8859-1?Q?ufBMnPCfpSMh3bba4Rt4u8cVGHzgeyCOu3UDFcvEyOxPaNgxiweABw421v?=
 =?iso-8859-1?Q?7ohiQpg6eW0ulsycLrUI/WC02q5/z5aAfMdDEsQRzoMiyiA1PzJ7CxL6T6?=
 =?iso-8859-1?Q?jgvjgpk/RQE0+JpCMb9apgmLFRUyxA5WF5V3bcxGKuCD0/i5R0RJ+kme5N?=
 =?iso-8859-1?Q?RwYAXUL+fP8HeYEVUB6/dO/W75Iptn5/O+KRt4dUUoSQs1asLo4sKVdJzO?=
 =?iso-8859-1?Q?3wa/KGtz3hg0Xw9n0RVWe+CWRdCEHSC6gDceupXqei0ZPO/TysLS4PH7VO?=
 =?iso-8859-1?Q?s3ek01KpuI2D05wWsPEQI3MoSLxVnMuytCuE6ZO4gbs3tQtV5smsHWe5nO?=
 =?iso-8859-1?Q?iemOD8IsE96sR3oTyEimAQrIIdE9XAg5/8LyshnLVxphLdIWLJ8aVLzhs1?=
 =?iso-8859-1?Q?wPUEqDg6hE3nSErAjmKOel8Sok8nnx7gfScXMiT6nn0bK64DxaGrgdx1Ur?=
 =?iso-8859-1?Q?MV4FB68Rn32oEysuM2yLFjyCMId2IfWT7tC7jsyIX2yEj3qmLnJ3iJs7X+?=
 =?iso-8859-1?Q?AgjKtsSxJgWzMQveXC9CqkXHf44uRjlL1LbY5YG6o9XPNDp4lmfAq+DdDk?=
 =?iso-8859-1?Q?FIJCqApR88MkAev1LdsGR5hyn3r+i7xosG2IR7X17KuxGCRanGX1Wv8tqH?=
 =?iso-8859-1?Q?QuOC1rLVHqgh/0x5SgxU6R9nabs44a59QG/65dnzKB4T5hzDFnsgPVmqlB?=
 =?iso-8859-1?Q?YNkY32TQJQ9WMi8fj92Fc4VVtEjS1HtQs/yJzFfrDfrJxkRX/cz+wLOq4/?=
 =?iso-8859-1?Q?3brfnd83rCDoEfpp8xy6n2sSn9EJ0DI6M/KYiNeyZo9qynk0uX8F1JsQth?=
 =?iso-8859-1?Q?4Yc/mNXY+Gg5JO7hQr5JNwYxspW+Fmt/KSs7nizBAgJ1Zs/rGlKtbdYFoQ?=
 =?iso-8859-1?Q?E5mN4JiIhnKM71ERQ6Mu4t3zq389Zp4NCLSVTWFptX43c0EDnw/70/8/Sh?=
 =?iso-8859-1?Q?sjhxjrvUTo6RO/aPkpSsF7UkOzW3cQza4J7IybIQiRFPOyjqkUxnmYDHtN?=
 =?iso-8859-1?Q?dJXM169lFx/aIg04GPdVHu0xXM71dNVSRv2BUseqK64Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zgfSZCYsGZR+Ll02eTwg7ySJltR4yfC/QZ1qHNFmN4FrqvRMzXeYvmhEjZ?=
 =?iso-8859-1?Q?JQXChl4EaXuKDHoj/cgg+vpN4JPYEN3RMhqsVPeEVPaZlGbWdwOyhytBVb?=
 =?iso-8859-1?Q?tqIGNNM4sCJ+qHSxubS+QNI+YDq9OwWlAV+BjTQoEPxZwrG6xZLspK7iFJ?=
 =?iso-8859-1?Q?Lm/e229dIEpIWuzB8K9zKwqFw3F93DJQsyTIVx94Z84U4fp7T4ALqQRi0Z?=
 =?iso-8859-1?Q?P1Ls7T5qbrvcahxkAZDMiK2dL5rY58u70Gw7Vk2dB08AEpfWkCdI3ILPTk?=
 =?iso-8859-1?Q?VhfX/jnbMoXFp8v0hnD2KCctBrHoQAHf3YChNSVLJ5BlqrGvngiiOnJDPL?=
 =?iso-8859-1?Q?1CqjyTTb01CRPL4wunC0/YclCmCxsj6sbpZa3c9q87ncIjqCN+GUg3/CZD?=
 =?iso-8859-1?Q?v7YpmvK+kWI/lA1y4MQpyMR9OX7B5TYlvY2yK4A3kkxO6hKx2WoMoRq4j/?=
 =?iso-8859-1?Q?+66JgRDVBJSiPeopyAkW2BCQ3xH+lGI22Li5sF1JZjjws2wtyzDsfaiq2d?=
 =?iso-8859-1?Q?MSm5xNQpjPKwwvO4/BaKBxjMdMGHqxyuaT/8UbK988Cn3wToCudvVkeOkT?=
 =?iso-8859-1?Q?O/85FYF45jTybqsNombzdA8sRqNm6rjzoNARAvmkJHs2mXKSCJGtiy5TM4?=
 =?iso-8859-1?Q?+o6xhu4uFfVm+5xCmXRH5D8h4GQks76J/c6dz+848RHJkpAEbR2ybY+Ffd?=
 =?iso-8859-1?Q?YGd+9sB2v4pGICAtfy1DyPRkEJp6RfkhgxW5GBMjtgM3HJ1HO0D0S4rY1W?=
 =?iso-8859-1?Q?uLTS2VeJNim5dz8J3AUsUeKt7H64sG/I5M2WrIV3vz7fJsLhbuO93etysf?=
 =?iso-8859-1?Q?vEbpsRafI39vUPLA3GRYMuU9yPbSGN6m6sD5SHLm+9nRJSUCx1R5UB+C4f?=
 =?iso-8859-1?Q?9/F0e2dgpIDVhOFQJ55n3bDvJussJXUpRQ7cjA5/LzuccrNkYuVtj2vdHn?=
 =?iso-8859-1?Q?fIGG4zIWnhC2p44I90lwPYn4bg8XjOsRi9UyTr6iW+sWGXNmpEM/fzA6M0?=
 =?iso-8859-1?Q?wtLHBAebZUrYG32SF/xMohMQ1RVDy3sMxaDREMrPW0McZdNKRkFT9yzVl4?=
 =?iso-8859-1?Q?qZeArHGrQx8hGe3Bs1uL4ea5EMfCsmfv60odz4FsnwHpCDVVDe+MPzsdJF?=
 =?iso-8859-1?Q?yXQOvSCTHRLC8LSjv7eNBb/gpBnXF8t/W0T30HqkhBZpeNvRSL+WGzfgS1?=
 =?iso-8859-1?Q?kdWERiQ3BROxejPYF1LtuSBfMECyDJC2oRFA88+eqrIt18ZaAYHHlha3Ta?=
 =?iso-8859-1?Q?SqkVXNZHDXD6lhDfLZsY2HjX3Aj4qJvCFcqi4fwOWeCTsts/dJc1tQmB28?=
 =?iso-8859-1?Q?1lonl4hXF2iXnE345QmSSPCfatMvwPRHZ6r6EYKsJiJKRR56W7JM0MP4R2?=
 =?iso-8859-1?Q?PG2pvIyYqIdXe5ya0Kxtg6EkekxcW83yYbtrpqpH9xwTN/az6nosXFu112?=
 =?iso-8859-1?Q?amY2e385L07uKyIv5fYgJ8mAj1LTx9JajV2DhFvKxL582ag7n9jUGZS0po?=
 =?iso-8859-1?Q?uwKDiaBliduROVEA7Uw3dgVexpa1CITwTY5FpCOKCbdZ3cXqHkg38650F3?=
 =?iso-8859-1?Q?6KIxIFIB/l6g7vrjPF6FDNSfjJKOL7dKCabJOv/hdzNAemmcjMZvqA5wIh?=
 =?iso-8859-1?Q?vlc9vvdOGMQ6ASBZiIKonZznPdQLIDz0k9P+zWs5e6jVmyN/6kxdfRGKUW?=
 =?iso-8859-1?Q?ML5FCQVf5QMA3UwoQfn0rbzvWxDvqZY5tV+vesy1a4n5YEjlerdi6VE+f2?=
 =?iso-8859-1?Q?Qrqt4BH/Cbhqjrcp/d8/BXohPSXVBvncHauVerCmWs+LQOgbvFs+LNM4DU?=
 =?iso-8859-1?Q?LllyfrLtfA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 689396a1-a74d-4993-1719-08de4dae1f05
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 05:32:17.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZxWJglrhPJ8MnxkrhURC6hG1Sx7CYVXU56s0e2lGJJed2/yeNzA7Ro1Zu7/IDUhsFhZ+IU4jXpYV60zuVLnng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8068
X-OriginatorOrg: intel.com


hi, Paul E. McKenney,

we don't have enough knowledge to understand the performance impact of this
commit. since the data is stable, we still report out FYI what we see in our
tests. please educate us if this report is less meaningful. thanks


Hello,

kernel test robot noticed a 2.0% improvement of unixbench.throughput on:


commit: b41f5a411fb5f8c76c1d945ab391873414d01647 ("rcu: Clean up after the SRCU-fastification of RCU Tasks Trace")
https://github.com/paulmckrcu/linux dev.2025.12.16a

testcase: unixbench
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	nr_task: 100%
	test: double
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput 2.1% improvement                                          |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_task=100%                                                                              |
|                  | runtime=300s                                                                              |
|                  | test=long                                                                                 |
+------------------+-------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260107/202601071255.645ef92e-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/300s/lkp-icl-2sp9/double/unixbench

commit: 
  14c7fd5dbf ("context_tracking: Remove rcu_task_trace_heavyweight_{enter,exit}()")
  b41f5a411f ("rcu: Clean up after the SRCU-fastification of RCU Tasks Trace")

14c7fd5dbfa07e79 b41f5a411fb5f8c76c1d945ab39 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  13742762 ± 15%     +31.8%   18115584 ± 15%  meminfo.DirectMap2M
     43251            -2.0%      42383        proc-vmstat.nr_slab_unreclaimable
 2.114e+09            +2.0%  2.156e+09        unixbench.throughput
 2.748e+11            +2.0%  2.803e+11        unixbench.workload
     13.18 ± 51%      -7.8        5.39 ±142%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
     13.12 ± 51%      -7.7        5.39 ±142%  perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail.commit_tail
     13.12 ± 51%      -7.7        5.39 ±142%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail
     12.91 ± 52%      -7.6        5.29 ±141%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail
      1.80 ± 26%      -1.3        0.48 ±110%  perf-profile.calltrace.cycles-pp.setlocale
     13.18 ± 51%      -7.8        5.39 ±142%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      1.80 ± 26%      -1.1        0.69 ± 52%  perf-profile.children.cycles-pp.setlocale
      0.45 ± 86%      +0.8        1.29 ± 37%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.34 ±121%      +0.9        1.22 ± 32%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
 8.198e+10            +2.0%  8.361e+10        perf-stat.i.branch-instructions
      0.89            -0.1        0.75 ±  3%  perf-stat.i.branch-miss-rate%
 3.715e+08           -45.1%   2.04e+08 ±  2%  perf-stat.i.branch-misses
      1.09            -1.8%       1.07        perf-stat.i.cpi
 1.713e+11            +2.0%  1.746e+11        perf-stat.i.instructions
      0.97            +1.6%       0.98        perf-stat.i.ipc
      0.45            -0.2        0.24 ±  2%  perf-stat.overall.branch-miss-rate%
      1.02            -1.9%       1.00        perf-stat.overall.cpi
      0.98            +2.0%       1.00        perf-stat.overall.ipc
 8.136e+10            +2.0%  8.299e+10        perf-stat.ps.branch-instructions
 3.687e+08           -45.1%  2.024e+08 ±  2%  perf-stat.ps.branch-misses
   1.7e+11            +2.0%  1.733e+11        perf-stat.ps.instructions
 2.241e+13            +1.9%  2.283e+13        perf-stat.total.instructions


***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/300s/lkp-icl-2sp9/long/unixbench

commit: 
  14c7fd5dbf ("context_tracking: Remove rcu_task_trace_heavyweight_{enter,exit}()")
  b41f5a411f ("rcu: Clean up after the SRCU-fastification of RCU Tasks Trace")

14c7fd5dbfa07e79 b41f5a411fb5f8c76c1d945ab39 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     43238            -1.9%      42435        proc-vmstat.nr_slab_unreclaimable
 2.113e+09            +2.1%  2.156e+09        unixbench.throughput
 2.746e+11            +2.1%  2.803e+11        unixbench.workload
 8.191e+10            +2.1%   8.36e+10        perf-stat.i.branch-instructions
      0.91 ±  2%      -0.2        0.72        perf-stat.i.branch-miss-rate%
 3.799e+08           -46.3%  2.041e+08 ±  2%  perf-stat.i.branch-misses
    644407 ±  2%      -3.0%     624964        perf-stat.i.cycles-between-cache-misses
 1.711e+11            +2.1%  1.746e+11        perf-stat.i.instructions
      0.97            +1.7%       0.98        perf-stat.i.ipc
      0.46            -0.2        0.24 ±  2%  perf-stat.overall.branch-miss-rate%
      1.03            -2.0%       1.00        perf-stat.overall.cpi
      0.98            +2.1%       1.00        perf-stat.overall.ipc
  8.13e+10            +2.1%  8.297e+10        perf-stat.ps.branch-instructions
 3.771e+08           -46.3%  2.025e+08 ±  2%  perf-stat.ps.branch-misses
 1.698e+11            +2.1%  1.733e+11        perf-stat.ps.instructions
  2.24e+13            +2.0%  2.286e+13        perf-stat.total.instructions
     16.25 ± 81%      -8.4        7.84 ±141%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.25 ± 81%      -8.4        7.84 ±141%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.18 ± 80%      -8.3        7.84 ±141%  perf-profile.calltrace.cycles-pp.console_flush_one_record.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold
     16.18 ± 80%      -8.3        7.84 ±141%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold.vfs_write
     16.18 ± 80%      -8.3        7.84 ±141%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.cold.vfs_write.ksys_write.do_syscall_64
     16.18 ± 80%      -8.3        7.84 ±141%  perf-profile.calltrace.cycles-pp.devkmsg_write.cold.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.18 ± 80%      -8.3        7.84 ±141%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.cold.vfs_write.ksys_write
     15.38 ± 80%      -7.7        7.63 ±141%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_one_record.console_unlock.vprintk_emit.devkmsg_emit
     13.33 ± 82%      -6.4        6.90 ±141%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_one_record.console_unlock.vprintk_emit
     10.50 ± 77%      -4.9        5.65 ±141%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_flush_one_record.console_unlock
      1.58 ± 22%      +0.9        2.46 ± 20%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.cmd_record.run_builtin.handle_internal_command
      1.58 ± 22%      +0.9        2.46 ± 20%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.cmd_record.run_builtin.handle_internal_command.main
      1.52 ± 25%      +0.9        2.46 ± 20%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.cmd_record.run_builtin
     16.18 ± 80%      -8.3        7.84 ±141%  perf-profile.children.cycles-pp.console_flush_one_record
     16.18 ± 80%      -8.3        7.84 ±141%  perf-profile.children.cycles-pp.console_unlock
     16.18 ± 80%      -8.3        7.84 ±141%  perf-profile.children.cycles-pp.devkmsg_emit
     16.18 ± 80%      -8.3        7.84 ±141%  perf-profile.children.cycles-pp.devkmsg_write.cold
     16.18 ± 80%      -8.3        7.84 ±141%  perf-profile.children.cycles-pp.vprintk_emit
     15.38 ± 80%      -7.9        7.52 ±141%  perf-profile.children.cycles-pp.serial8250_console_write
     13.92 ± 81%      -6.8        7.11 ±141%  perf-profile.children.cycles-pp.wait_for_lsr
     11.03 ± 77%      -5.3        5.74 ±141%  perf-profile.children.cycles-pp.io_serial_in
      1.58 ± 22%      +0.9        2.46 ± 20%  perf-profile.children.cycles-pp.perf_mmap__push
      1.58 ± 22%      +0.9        2.46 ± 20%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      1.52 ± 25%      +0.9        2.46 ± 20%  perf-profile.children.cycles-pp.record__pushfn
     11.03 ± 77%      -5.3        5.74 ±141%  perf-profile.self.cycles-pp.io_serial_in





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

