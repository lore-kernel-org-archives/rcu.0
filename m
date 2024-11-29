Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5921684A0;
	Fri, 29 Nov 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870430; cv=fail; b=RsVeDD6o1V0zIru8qHoruviYmSJvH+RmigDgR2KdS+6AKPdN91/Kxo+zn3WbDj9AzB6n/H/F4o1t2zeFU2IqnCMahjtIp9PHhs4qf5xJzsoo1X1Pd1ckVpzz+3ZLyYPJ+29Txle4inD4YKxM/SsV1/c3tT8HK8RCj14Z7Ug9yjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870430; c=relaxed/simple;
	bh=CkNzetU2c6UCLn+3Z9IUagiBFTOf86vqAGEAuKWEWKU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tDxTxte+xLuX1eLqs0KHqyDsj2BEsT3pDp15moyQPsYqfD2h4H2yFAP2/hCEq6sh7rH6oTeJ8enp370MtPNtpNS0rYDrxFw+JpJUfTyqcFEKpccrO4w+B5A3nYFvUJxcrtG0jry71Kob+uRmz+vSe4EeE+90F1mIB8Jw4g2xPws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fw8BNM3v; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fw8BNM3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732870428; x=1764406428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CkNzetU2c6UCLn+3Z9IUagiBFTOf86vqAGEAuKWEWKU=;
  b=Fw8BNM3vXaOWU/AKDDHlImIQWA8Blq98bW8wO9PQboKMGteYg8r8G48g
   Z5I60CXKEWzCy/MtI0Xy1i27zyC6qzZJotcaJo6xorNQlZ+0Mj2BnoUqz
   bYqaIfeNigqkKbc+1FxbDvvU6AYIwVnu/XgOf/AO4YQVxvG6JYbX/TnVd
   y+hqXAA+AK3tyg3exrPSx2441v/fIdeqKKxJJpADY36cpYuWy39ZZteNL
   oy+NhzQCKy4ceUEF5EpXHBW0l3iduNAOMOH2w+jhsX4MoS5FwtV2mUg5I
   Sz5CRpuCTtRYoag+mfWGbqZeRq08Rzr2tT5kNF7DcwWoyHGGGsD6iAEqs
   A==;
X-CSE-ConnectionGUID: hDFJsul7QpaqkNO8X4DaMA==
X-CSE-MsgGUID: 7IAmGpLRSwaTFXdvO2VtDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="43769213"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="43769213"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 00:53:46 -0800
X-CSE-ConnectionGUID: 0pRbOx3xTz6gd0tR4+5K7Q==
X-CSE-MsgGUID: LMKA3E2cSxK+j0Ek8YMHYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="93279523"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2024 00:53:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 29 Nov 2024 00:53:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 29 Nov 2024 00:53:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 29 Nov 2024 00:53:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnoYoOaQrHwCokJ3RyKzhOMcyA2Q+vidHzhuNxUftnnImPE7K5Pq6F1tjJGlAoXoMehg7tVJB1Co+tpuFca7jKskQu9hNZ3a4LDnkHtRfJHES4mE5eNgyYXorH+pfGjbZnip0O+kI6voKUfNfgaibHHmXCIc3+prmCoJVUkncB7Jo7nNUuoUu+AJ/PZej8+YLDHUn0gwM17YLGbzqRXKyFkMbp7YlPmk/SdBf3UqRothLk64nsyFH/0tawI36O17m6mkW94nlEpx+ZoTcvoPtHOLP5yNkKj34v6uF5GqaDWLXDNihdbr9qM3QlOukxcMmicQjKheDf6/BjcaEfzeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95CSx6RBPYp95TwVRCQGfDAAjVtnYvQ4/K5z41sda58=;
 b=KvQMC9WzGeoJRoS5bXu8ieWbzYYFaW7W7uYFcLq71a6CxV9Qg227ZE3TkxsqsJiCsIt82QdPA7N/Z8ja329/G5OAEy2eRgwT3mewWyTKdOPOY4pahDGZ9VNlfrmSGSYQwuRp+Ezj3X9/93ybcEfzMxuxLnnhEIzgSluqifJlTdL43Pv2mKO89I3CqP8PiCKbSokRTQRtCRouZwH0lQRXo78qorY0NqvQHxNfxqq3AcpDqY+t7ubr33EUwzi+Yc8GfKMZ+tzRqaNBJbZIrVhVKSoUm/t7ciT2oSrZL8h+rAA+2udelcVFoWCQu0jQ8lAiVZI/jNBfO2+KbewyuRSQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 08:53:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 08:53:42 +0000
Date: Fri, 29 Nov 2024 16:53:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Frederic Weisbecker
	<frederic@kernel.org>, kernel test robot <oliver.sang@intel.com>,
	<rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [paulmckrcu:dev.2024.11.11a] [rcutorture]  d26acb0256:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <202411291603.52f83cd4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: a849b7be-347a-41b4-a41b-08dd10535323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xkuh403ZPYWQECvesLGCt+XIbJUsSfmlKLoTZjvVFTeOM8etQLeErLI1ovUr?=
 =?us-ascii?Q?4W95pGgUsw8dD6t8YQgT1KlzIxOW1fPnnXIX14QKVfBxxDA4uUKFFYiNKtzb?=
 =?us-ascii?Q?3+V8AjZg9sWoaB7Hb4oxcPPr0Eig2109L4ns0u2lid/QtH2sOzhaLb0FNPd/?=
 =?us-ascii?Q?TErCbB9eLZwd1FE4vw1T8u+Edk5OGf9XAbe7O7Ewa0zSj4tGgcgwXWmNn5Z4?=
 =?us-ascii?Q?s+eeYB2G3O6m93IM+Sbs60XAhBcLVGErPW6aiEB38g6NOTZUsyAdSvEnXEXV?=
 =?us-ascii?Q?Yn9BPLW4qSXgDnMkTdPA+dqptp+U8mPzfT5tWANHyXVT4URI3V1Pupdv0odF?=
 =?us-ascii?Q?waWvunCnABs9teWUOb7OjlkT8xRC2A7VV6EfGWtGqMpKeugfGLKM8Dc+PItr?=
 =?us-ascii?Q?3gBHTFougoI0acFvBCJoj8+F8EHeBQnAO4kyPHhSCVKV5J1J01AtGkDn+uO+?=
 =?us-ascii?Q?DBMPMNviT9RNVUYUc7Dal7wMV7ShxpzxZToG0s5yFB3agWk9dfjKptbqspDN?=
 =?us-ascii?Q?AIgZ74c4Chlu7L5Wb235l0oMUZ6Xn4xzhvCpyLCbCuQRfBNljNmsvS6BZXAz?=
 =?us-ascii?Q?eRP98DO+16WOZOZwUAQ4eUAHwtqvJxCDhah778kAn4GLddcU34oC+smVYIcx?=
 =?us-ascii?Q?KatV7Uc45Cj0fjzxqL7+Cuaxa2hU8T0V26z0/qszkHVxxLD1NSlg2he4ML9l?=
 =?us-ascii?Q?WXrE50dP6VkQRmZKG4grHAoBiTKfCMfyv5UatQyGmlLDKzk5TF6IOXRCcPYX?=
 =?us-ascii?Q?GXzKc5eVtComVjX8ZohYrnOYekdzkKPHHKWS5T6FrKwjSJNmO92US29CKA/N?=
 =?us-ascii?Q?hMCuCogrNNx4GfQSSg4DPYzmLD6r+t+EMadxIVP7g4hDJG5mrPOF8VumMGXE?=
 =?us-ascii?Q?iF2u18Q3NPIReiRWsDz9SwBkyltpCJCPkg+IurWm2FkQuDB6FHAjY3Nli1Ya?=
 =?us-ascii?Q?k7PZaEZPieM+jJNGWWevm+11qrqK+PTFU6zRRYcAiJeks27CrEfs7psPHbqX?=
 =?us-ascii?Q?0eNeYfpJMbvFcQwH6uwFKokw1R+B7/1e9f4eoXevBihELheAyRpFRnm/G31k?=
 =?us-ascii?Q?GKz6MXRURx25Xsaqzq+q4ayGfY5lvIy0lFwmBykfjDpCUuRAgKrtjDRvGVR2?=
 =?us-ascii?Q?mk+NgWZHwuphRi3GI0J7fxS9Y48fVTTKOMvYEnJxiRJ9wJ7HpHeKzNmKAleS?=
 =?us-ascii?Q?FS3SSmJQIcxtLDA6+e5VfWwxKkH1zVu5BrB4yJqbt8OHOLhtSS1bwRNcpRIR?=
 =?us-ascii?Q?cxugINkn/NxCF1igXyqcZoU+RcnnL1q/e6TSHIAEB74b3sPAbqvEYt+Yyz/O?=
 =?us-ascii?Q?GIIq9SlMs1x+3JfEd+qhhOmS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/sUor4/8SBOtZ2T69sWLU6j0+yyV6PoonvqIsFl/qdaHxfoJAb+SvHAJIhlw?=
 =?us-ascii?Q?JlyzxWJEcH8tZdgGVt3qKUNp/dIfStvJvtBizs6YQYICND7xY0Sod5l7GNz2?=
 =?us-ascii?Q?afHxD2ZCpkbWU+q87b+EEN87veDSyRMWskY/ALR5QOnStR0nQrhC+l74v0oj?=
 =?us-ascii?Q?QqSYfMYjOGw8zREt+ZVs8Ts5kXd0cJu7KcvAzI92+bbrR0GHAQQbMFgeAJob?=
 =?us-ascii?Q?wYAGBl1gVFrb2lF3i71MZQqi8h7R8SN0HorIRFK9e9cq0PZxkCRHoXGIHFlA?=
 =?us-ascii?Q?ZZlFXygPaEpagzgcTzgI0Yl0j0Sr8uE/s8e8ECCwUbSgWogHWety/gojF17N?=
 =?us-ascii?Q?RsDYcfnsn2lF8+PI00yk2wWM+PCK2QmYskwKPqL6ISvwsC84pTg/URHKDBoy?=
 =?us-ascii?Q?d3OsiPvgS62mIPxnV+WT+kxVD0IvhFc0cqaM59AmM3uriaBlPb6osa71D/9j?=
 =?us-ascii?Q?VMThNSs5WT6ilk9iqfuiT7ly+rqxPmOrMRe8nXQ+NA/rsHh2CnGu8SjOYO9G?=
 =?us-ascii?Q?N+4Qq6B+YRXLnZkBojVpb4hv0n6yADagivZyK/MCtXYYLy9oMWyP0NUiLvBv?=
 =?us-ascii?Q?owWqEKWHBPVtOMyjolPmObWLZIv5wbLDjmS9GcRyAvMY1y8dHy3VpdqrKx1T?=
 =?us-ascii?Q?Xu1bbOBkSpI5lm5oNwLloqjHTg1LatRHgN3n/ML12GbdSYuLw2Og7SGXIj/G?=
 =?us-ascii?Q?AeNwoLNfs+UljMs+h5hLACg8J7wuP6x90XXH9XWhsuT2DRQsm9hFloddGaAX?=
 =?us-ascii?Q?Og0kdi7dd2Jdutsi9QD9ygo9uFPp+omWklK3t6vbtxTjkWgcOFizkcE/vhy7?=
 =?us-ascii?Q?Zm6n3/Oq6s0oAslyRIfuAYpFlDmr8mgqTUsvHOEHora14iAQ49ICP6JPfDMd?=
 =?us-ascii?Q?2XrTahbrrpdkNoNRSnLeSnJAOYxR+47Ki3E89go4JNyts9Ir5U/2FQPX0ljQ?=
 =?us-ascii?Q?RYaQ5U5v2z5AQIltbFlVHu6bnIRgyNuOSCLn1/7JbaGCQmNBIvsvG2kNQ59m?=
 =?us-ascii?Q?IEYZFHrq/Y8+IdKVbw1mePG127IxoYwB8P5qiiqWUfyRu2+FV3mbIhnHZyii?=
 =?us-ascii?Q?ANuZ+oCgvQxXvDoGD7hHa5ZY36RMUOzDq1o7VUoZqgdAs81iAX+ZF2Zd2N9Z?=
 =?us-ascii?Q?nLpUMExcns4m2WMviHGhyHnHGbwsPUVNJO7YlQ6qTupDZ5jRxbM8DwxnWhsO?=
 =?us-ascii?Q?Ngm5+xG4KSBwd/50ls7D0PJDVFIO4HHooez/x+1+i7IC8X+Q0RDtJvap8vqF?=
 =?us-ascii?Q?hHyVgvQMQfnCQchXWu9mo9iKWxS73BiaJp+FuiXJU1bd8OoZ8W0XPUbBSpjb?=
 =?us-ascii?Q?Ct9dJoHlPScKGfo/ZqeqtreOxQqg3ILlw9ZlZOcRB53WY36kQ9BHvzGqvSbz?=
 =?us-ascii?Q?/7iwcBsK/dnVe9BnextkS6HnnVPEQnbT1p/NzzcnCPamDRBomM1Kc96abLsw?=
 =?us-ascii?Q?zzLe9blF9mFVJVoPrZKC9EA/V+eZ/knC8RUVmi+yXR4ylpaQTfche4P8bW/7?=
 =?us-ascii?Q?o8bB2qrjzCQju6UMVDicWx9wp/CgyDsYhvhpJlQ59QJP3nxV8XgP3+E+m6VW?=
 =?us-ascii?Q?GVVw3q9BNnE9/xl+TRwa/cLN/8ysu/m6vhXBA17bN15ww5VO16CK1pwbmuth?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a849b7be-347a-41b4-a41b-08dd10535323
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 08:53:42.2851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gMzWlhFYvYRsDugJvEHC4jHP74D/tAN1qxE6kyuIYd5kIrbCoPbf8ClfwLdzOtQCbG+ThP1lF7juOR/SnOP4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
X-OriginatorOrg: intel.com



Hello,

we noticed there is same commit in newer branch such like dev.2024.11.14a
and dev.2024.11.17a.

if this is out-of-date version, please just ignore.

we also noticed the WARN added in this commit hit. so just FYI.


kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:

commit: d26acb0256b36db3370238cc5c32210f31e9dfd6 ("rcutorture: Make rcutorture_one_extend() check reader state")
https://github.com/paulmckrcu/linux dev.2024.11.11a

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: srcu



config: i386-randconfig-053-20241111
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------------------------------+------------+------------+
|                                                                              | 43b1ae045d | d26acb0256 |
+------------------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]  | 0          | 12         |
| EIP:rcutorture_one_extend_check                                              | 0          | 12         |
+------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411291603.52f83cd4-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241129/202411291603.52f83cd4-lkp@intel.com


[   62.709400][  T404] ------------[ cut here ]------------
[   62.709782][  T404] rcutorture_one_extend_check during change: Current 0x20  To add 0x20  To remove 0x0
[   62.710433][  T404] WARNING: CPU: 0 PID: 404 at kernel/rcu/rcutorture.c:1892 rcutorture_one_extend_check+0x3f8/0x700 [rcutorture]
[   62.711255][  T404] Modules linked in: rcutorture(+) torture ppdev parport_pc parport ip_tables x_tables autofs4
[   62.712010][  T404] CPU: 0 UID: 0 PID: 404 Comm: rcu_torture_rea Not tainted 6.12.0-rc2-00092-gd26acb0256b3 #1 f6e892f24717504acbaf436db6a55201e01d506b
[   62.712960][  T404] EIP: rcutorture_one_extend_check+0x3f8/0x700 [rcutorture]
[   62.713491][  T404] Code: c9 6a 01 e8 2a 3a 51 ce 83 c4 04 ff 75 0c ff 75 08 8b 5d e4 53 ff 75 e0 68 a9 f7 cb f2 68 5e 03 cc f2 e8 7b 9c 3c ce 83 c4 18 <0f> 0b b8 30 dd d1 f2 ba 01 00 00 00 31 c9 6a 01 e8 f3 39 51 ce 83
[   62.715104][  T404] EAX: 00000000 EBX: 00000020 ECX: 00000000 EDX: 00000000
[   62.715608][  T404] ESI: ee0f4f01 EDI: 00000001 EBP: ee331d84 ESP: ee331d64
[   62.716116][  T404] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010292
[   62.716661][  T404] CR0: 80050033 CR2: b6b2c000 CR3: 0013cda0 CR4: 000406f0
[   62.717181][  T404] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   62.717696][  T404] DR6: fffe0ff0 DR7: 00000400
[   62.718038][  T404] Call Trace:
[   62.718290][  T404]  ? show_regs+0x62/0x70
[   62.718611][  T404]  ? __warn+0xb1/0x2c0
[   62.718919][  T404]  ? report_bug+0xaf/0x190
[   62.719244][  T404]  ? rcutorture_one_extend_check+0x3f8/0x700 [rcutorture 7a599467fd2675a29242fe514bf39d6557afa4d3]
[   62.720021][  T404]  ? exc_overflow+0x3c/0x3c
[   62.720345][  T404]  ? handle_bug+0x49/0x6c
[   62.720657][  T404]  ? exc_invalid_op+0x24/0x4c
[   62.720994][  T404]  ? handle_exception+0x164/0x164
[   62.721375][  T404]  ? exc_overflow+0x3c/0x3c
[   62.721707][  T404]  ? rcutorture_one_extend_check+0x3f8/0x700 [rcutorture 7a599467fd2675a29242fe514bf39d6557afa4d3]
[   62.722454][  T404]  ? exc_overflow+0x3c/0x3c
[   62.722791][  T404]  ? rcutorture_one_extend_check+0x3f8/0x700 [rcutorture 7a599467fd2675a29242fe514bf39d6557afa4d3]
[   62.723542][  T404]  rcutorture_one_extend+0x1ff/0x5d0 [rcutorture 7a599467fd2675a29242fe514bf39d6557afa4d3]
[   62.724694][  T404]  rcu_torture_one_read+0xb2/0xa10 [rcutorture 7a599467fd2675a29242fe514bf39d6557afa4d3]
[   62.725459][  T404]  rcu_torture_reader+0xe9/0x1d0 [rcutorture 7a599467fd2675a29242fe514bf39d6557afa4d3]
[   62.726154][  T404]  ? rcu_torture_pipe_update+0x150/0x150 [rcutorture 7a599467fd2675a29242fe514bf39d6557afa4d3]
[   62.726904][  T404]  kthread+0x163/0x170
[   62.727185][  T404]  ? rcu_torture_fakewriter+0x4b0/0x4b0 [rcutorture 7a599467fd2675a29242fe514bf39d6557afa4d3]
[   62.727902][  T404]  ? kthread_blkcg+0x60/0x60
[   62.728212][  T404]  ? kthread_blkcg+0x60/0x60
[   62.728538][  T404]  ret_from_fork+0x38/0x50
[   62.728864][  T404]  ret_from_fork_asm+0x12/0x18
[   62.729196][  T404]  entry_INT80_32+0x124/0x124
[   62.729552][  T404] irq event stamp: 525
[   62.729849][  T404] hardirqs last  enabled at (535): [<c10fc27d>] __console_unlock+0x6d/0xc0
[   62.730478][  T404] hardirqs last disabled at (544): [<c10fc264>] __console_unlock+0x54/0xc0
[   62.731122][  T404] softirqs last  enabled at (420): [<c1087c8d>] handle_softirqs+0x5cd/0x670
[   62.731735][  T404] softirqs last disabled at (397): [<c1e73fb3>] __do_softirq+0xf/0x13
[   62.732315][  T404] ---[ end trace 0000000000000000 ]---

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

