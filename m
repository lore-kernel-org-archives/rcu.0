Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04438B;
	Thu,  7 Aug 2025 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754545189; cv=fail; b=kwaf1/7QCsahaeomvR+IRFzOavSBQGEQ9oZlA3NEQR+xDGPHjYwo8FOrbC6qrLhyQqy5aWzBfRoHsHowvCVaChfFARKrFqW9ypePHtrsJZvyDFyKKfvwtJU5t80OVuZepk49+7yfT6m9+S7z7smStWuvt0tKVn7JOYoXsnhpVjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754545189; c=relaxed/simple;
	bh=5+97dd1UuK7KWIjjd1rGdYhDfWXAs0leqcudFp7zLEY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=nquKgdpeF2vWunEcByUGqnWGBTzM6ysSkWbKwRNbpmAHBSC8Y5FzCLNZvCG7q2t9UK3ozl83tk+pgLPx2M4phY/K+0sY1vu2+udJ4LR/czvLrTyx+Hnx+A5ezLFUJ35OFuLCE1iJUnpJcYasuBZiTUkOGluPsAtlBSaf+296pM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kd4n+3fk; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kd4n+3fk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754545188; x=1786081188;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5+97dd1UuK7KWIjjd1rGdYhDfWXAs0leqcudFp7zLEY=;
  b=kd4n+3fkZvoUdwp8U97OD1f7UsOL9GlXuT5UzX9OtMjBcPBq1n6tCIvh
   bK1w4t12dYt8ODMopp0NX+9LLXpCPUHvNTMsEaEkXvYpqDqrZArbVWe4o
   x/caoxsetgVPvCN7jZAespMsmfg/ouAyrAn3wN1YNPluf8Ug6F1a3SelE
   Pk3lxY0X2FGmeMkpDHXnVx/N6RF/ZJ8IPkNDHN3Ft//zIKro4hJ+daKbI
   Y+OQ/2RWCe6/w8PweXhG7xzJS5dcgnhW5d5ZHGwWA2Tlzil9GMuLZ03F0
   RvBct9QRVuPMFIcoS1HJNbXPaTEGL/QQSyZA7WYH49HEKcGmdnGMuIAqB
   A==;
X-CSE-ConnectionGUID: +9d+mxtOQvCs4Kscrbf87A==
X-CSE-MsgGUID: R9/a8u9MSryKEQVdGSGiAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67140079"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="67140079"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 22:39:47 -0700
X-CSE-ConnectionGUID: rByKPI1hSJuSTmVD2WxXzQ==
X-CSE-MsgGUID: DrYq84DHQaOnahIiVUFNYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="170342646"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 22:39:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 22:39:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 22:39:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.56)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 22:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjpOm7hZxkq5Oo9fmZXg26/WrpBdTuj7XvoVVFNRr0E5IRqadNTWb4ft0fbRIn1CRNcRyAkUP0TvJfOe3SNCNsRw19BppzI3OvejwqsCf4dbenntFYlkx56i8rdiDkHf60g4kH4lbaTPw8VC7lnDmwDYLA84url9zHEwOiFRKKuYxdfs5QpABpMpeEHIRkQkS1rEiXT2V9iY03jP7ELNhuGuZNz7Te4L83zeQzVRyX/6zNQf8IpIAqUGbLoxJ608waY7u5VA+QAvuxGWW+iFWSy/x2VcVXTDNTtmva7PJgG/T3CtalsIwLW8YxgrK/NAWxaJGNTa73LeIv/UgmncXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g5kTmqLqwBvuMc5+ywptwPW9m8IIVUFACeqL7kWG/Q=;
 b=pedc4aIzNVJmZ9ZPXnbaU0jedKjHEUKdh/lRpP4v6ajS9GSvjh0J6dwbU4lWqtMlMZQLQ8ejTyu2+uj3G7LwyoHmlVdAsjT3dSB9Z8T7r+zRt4VUvag8VXN6idc3JnLTskuNaAI4d53kAZ9+v6K9SCUri9/+Xe/CK0LKxxjfuHTgHedIIK6Wi9Agfdk/NUx+R6rsdGmuRT63b+S6qJgphcLmhIvYjH+wOldxj3/lyS+zxxe4Jaq4v74fd/SyvUTYOW1oTdhjQuqwpj7mOsFWigemfV2f/rhIqK6PF79UKqhJAZZaXlidLNyQU4KzrlTfwvKrpewf60AyJ7VB8p15xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 7 Aug
 2025 05:39:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 05:39:44 +0000
Date: Thu, 7 Aug 2025 13:39:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Xiongfeng Wang
	<wangxiongfeng2@huawei.com>, Qi Xi <xiqi2@huawei.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Linux Kernel Functional Testing <lkft@linaro.org>,
	<rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [rcu]  b41642c877: BUG:kernel_hang_in_boot_stage
Message-ID: <202508071303.c1134cce-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MEWPR01CA0168.ausprd01.prod.outlook.com
 (2603:10c6:220:1f2::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c96eb8e-5a7a-4965-5a34-08ddd574cfc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1YJeFJxq/fy4Ws5ycz6NthWXZS7QAi21Mvyj0WEmQQShsv8l88anj9FLb+1r?=
 =?us-ascii?Q?dxCjoSz7TT07I36aE9LqAVeOUEE0q86MClxHJVfFtNP3p+9P3vdDZbR/UUBe?=
 =?us-ascii?Q?JouTRQIy4q+neUDw+ZC+504vJWjYWK37B/rwCVyOSNJrat6U6Srmf7X5xA9+?=
 =?us-ascii?Q?pCC9yVzulnaJ3EdXeQwJw9g3rqcZcY+WAOjPXWtyDOCHbtX8lQrnM/lgCx1k?=
 =?us-ascii?Q?wp0LiaHgEHaQbgEtG733jLhyHOY3TmlAf30GlkZ8KEqR4ytO2cCi/Z4ZBeQ1?=
 =?us-ascii?Q?JOoEQHwWed08Tx0PbrO71yovj4bB5VHFTkH0mqMIavk0g/35h2HrQkB2Xasc?=
 =?us-ascii?Q?lq5JEp3Z5s0CGrFlM9+1LeNu1GsVxZXtr77heVd88ag4N4Zdott9qacE3NSD?=
 =?us-ascii?Q?wJwHW9pOGyvWF3r8Q8V1BYJl8QOGumLngKSdQ4AA4xn5dQqV5eayoN8pEDfR?=
 =?us-ascii?Q?ovaNOpaswRked7TjnnTBGkCIY5YHhVmT7zaoXnIfzJ5NcA33BwcQQx4iEkkA?=
 =?us-ascii?Q?k2zYaDr5mEW1B4OeAewhJl5t8bQ0NGsowDFRwQ9lf7i+7V8ZmNTPiHH7V3hm?=
 =?us-ascii?Q?fHFkppEhQY9rr2eWe9AUq0umJ2VX1CytmUtDz+XSLerDxVXQpyJ/tZmGVO9I?=
 =?us-ascii?Q?eTiu+BlCFXnmA9OxY/Tp3zx8NukIFjCSZiKyecqWlymKPfdRkktVy81ZTvLV?=
 =?us-ascii?Q?RmbC1elUd4MmQNuPWrJ+FFeN6ehHCVTKGoeSA5sIcSDxrVEnoAK5eORSZSvW?=
 =?us-ascii?Q?xjXhEt9MFhk8w0K8onya/zkuv/RiCQnm973Y4nzk1LuzAyonZBmTG1cpbXxw?=
 =?us-ascii?Q?+h+//1zJZP9g48nS2btIilClQNCvQEaWh8FuttjDQySaNZd74sGXPWfGIQsv?=
 =?us-ascii?Q?84PXu6TukPccRXfjtesZ9d8ZH4Hsrg9Gk4Rqige00IXlGvVoDsOvfjHIUwNR?=
 =?us-ascii?Q?DmQyCdpUphDso5QOgSBp/8iYNGtJ+5q7CY7UNoXLvKzQpwNp4s+T7nn4M1X5?=
 =?us-ascii?Q?KZVzGU4duBMonq5lPj+wAXHOFFUfTb6kYC9Wpyc3EM8igpKSru21As5DshqV?=
 =?us-ascii?Q?iCq3E01pJ1tP0YGk4ZTf4/xZ3oP5WxCTUTUL/kfSks2bbVKgkMz0e7IvKI4l?=
 =?us-ascii?Q?CtBZid4eZUr30ZtTJYYaAE/ggKa3JznxKQCRo/LUqto+bVeAWvkFgWTHZjqN?=
 =?us-ascii?Q?8ntzu/3FjaaFEteiiW73NY5CPd1ijIc9U6+uoM3DLQx58qEVFMB+LvL7MvPH?=
 =?us-ascii?Q?fFEctdpBALCE+0NpH/F2B9Bvsj2UO6USH5hQ1DvjtMmjg/tXr6LpISeKLLyQ?=
 =?us-ascii?Q?rmO2W2JKQDV7rBjh6LZh8PG9Sf78PimL/1RwvzGzJzaYNVGIo3r9rxGyWSD6?=
 =?us-ascii?Q?8HEo41KC3GpJKyLh5eVVmAVlGWte?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tEQtKEyi/A+HIq1aKt3VitcPstBY2k83zPLb4GWICjiqEtl3rUiXYOppUAan?=
 =?us-ascii?Q?lIZ3DpZ4SS0ua4T2HKW+nkNcQZAgEAi8oEQQ1yDk/RCQlTeqpKTGHXU/ZwII?=
 =?us-ascii?Q?G2hDl/Xv6T9Xs8JLa/3MlfJONBahYE77j6hyHII/uwIpG3fBpBx9nOCs7YzV?=
 =?us-ascii?Q?cDDWm8qxwzTuIzETpezYqE4ZSgtmW3XkKeuVJrnzPLM+259MOmGkn/l2bT0z?=
 =?us-ascii?Q?0B3avY3U+s88PJYuu9TdN9EcDi0ri/7HrdcPxIFEQYgafAGW0rfbjqffnafy?=
 =?us-ascii?Q?/3VQyZ2SFkSW6GWCxHMmzvz3dbrOuVmQvv2OyC7vtsiBNt34LG5fLXs6i/Gu?=
 =?us-ascii?Q?1PJ22UyD9TkEe+f6Yzpo2AvVn6uwcfZyvZ2Kq47GRZ0Yp8/kl8krNS9yOchr?=
 =?us-ascii?Q?cQxHjUfDey95tCjYDYjWmzUhfMbX8vmzQdnKZ6UAvZCPHzQy5ddcx7Jtkcch?=
 =?us-ascii?Q?jcanhcVs+3v0r9EDGrDf4v6TFfWceF3hAbQWA50+Q8LsvwCsRBogJ69iZSlC?=
 =?us-ascii?Q?hUVlHBPuoxvq8ploqAbkgiH0xJe4CTTksjKCEk+7abF9nhWBaSpfcjxmquGD?=
 =?us-ascii?Q?MzwUPJCVcWf4CskyfhYXjTbXC577dyFY0CIeRml6aKWqXR8bVbxzjygHgiz/?=
 =?us-ascii?Q?FQ9HhGVPjzbGceo4K8hnHE1/pcfAsUMZ8pp8djvFOmcAGLws19Qcsgwq2WZG?=
 =?us-ascii?Q?FFcJMEnTJjpOzeBqr+R0DnltAx2edSVUudvH46fLQzJPy1AeM9NovCMnDYCl?=
 =?us-ascii?Q?zq2sUY8MjjpUk0MZlZISTwMW7Q1zr2JKHQH3C28a8jyGqjGHKm0TdN7Hr/sh?=
 =?us-ascii?Q?yHp7Z/tdY30JcpCBOxJzpIc1v9oZV8+IOo0VgZzmo24cYj/LKDmR58BHKgP9?=
 =?us-ascii?Q?QFIQZLIt0HEW66etkrrj9ynOjPWiDhB+2zq0r3mVSjdRFynjV+tIhUKUOCoY?=
 =?us-ascii?Q?dnM6IYFgl6oe6RoLzfBXNR2733/1sfGAi/m8b14ukv2szcjNBT9NTyLYgZEE?=
 =?us-ascii?Q?k8nSw+sLrjEoCumXBHtKxhd+6pE5gmyZ1yylXv/LbV1YI+p6DeB2tPRtm2cQ?=
 =?us-ascii?Q?YwdIcCbPGXKJuzq5zD/K5iSB4ZPQKHJPN6UYjxwUzUwxOfHf4rD1mi1Q42UH?=
 =?us-ascii?Q?otxGfE+7IUMJmGuEe10/KcW7qXvDBS+1XGKPyJzLHXVaTazRiKNcj5Ogj1cL?=
 =?us-ascii?Q?JmlOcCaexCwH2ypd93A5rpSfLRqAcAlU9XML7D1sEIqG+MrKwNTzsibrOwBW?=
 =?us-ascii?Q?158JCUohgY6G5PuH2Gtw7Wd8qYbh4Scox2L/OzWCW5MlfwnQ4i6jkt+UUaM3?=
 =?us-ascii?Q?GBLCZMJ3Rf0ldpNWi4PO/uD63sseaLQ90B283qbVn/6X0k9cW3CFPcoCEcmr?=
 =?us-ascii?Q?z2pV/1d7GGwywWuT1SZtO9bkyWcZcPo/BjkE6Ojhg7KMDNFUI6qaRjoJ87cW?=
 =?us-ascii?Q?jFoKEaFEd8RsbW9cKRQ+tfOG51x7hS2KTMrHrVj3MdBnwxb53TkqpkH8pyVy?=
 =?us-ascii?Q?TN1osD2YgI8skXxZvq2ZvbUsjpnHCvAeg+buUrp8HvbGz/6KicWwfthmkP9D?=
 =?us-ascii?Q?cMC3aoUMiEZggS/RtEs9jYv7Im7gwWziypPPXMCBvS/WwZuEgbdLcjDq8COU?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c96eb8e-5a7a-4965-5a34-08ddd574cfc6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 05:39:44.2391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0B0UtZ49g3L0gJrNPRJSgRb3ppr0tOdOPGYjUaGHsFAau/Iiq6ahBE31JRkFV+2ASYMgP/GlYjGvhsZ62xwXZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_hang_in_boot_stage" on:

commit: b41642c87716bbd09797b1e4ea7d904f06c39b7b ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      7e161a991ea71e6ec526abc8f40c6852ebe3d946]
[test failed on linux-next/master 5c5a10f0be967a8950a2309ea965bae54251b50e]

in testcase: boot

config: i386-randconfig-2006-20250804
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------+------------+------------+
|                               | d827673d8a | b41642c877 |
+-------------------------------+------------+------------+
| boot_successes                | 15         | 0          |
| boot_failures                 | 0          | 15         |
| BUG:kernel_hang_in_boot_stage | 0          | 15         |
+-------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508071303.c1134cce-lkp@intel.com


[    8.004044][    T1] Run /init as init process
[    8.004883][    T1]   with arguments:
[    8.005620][    T1]     /init
[    8.006332][    T1]   with environment:
[    8.007080][    T1]     HOME=/
[    8.007722][    T1]     TERM=linux
[    8.008407][    T1]     RESULT_ROOT=/result/boot/1/vm-snb/quantal-i386-core-20190426.cgz/i386-randconfig-2006-20250804/clang-20/b41642c87716bbd09797b1e4ea7d904f06c39b7b/0
[    8.010989][    T1]     BOOT_IMAGE=/pkg/linux/i386-randconfig-2006-20250804/clang-20/b41642c87716bbd09797b1e4ea7d904f06c39b7b/vmlinuz-6.16.0-rc3-00005-gb41642c87716
[    8.013525][    T1]     branch=gustavoars/testing/wfamnae-next20250804
[    8.014578][    T1]     job=/lkp/jobs/scheduled/vm-meta-10/boot-1-quantal-i386-core-20190426.cgz-i386-randconfig-2006-20250804-b41642c87716-20250805-101381-u20lqt-1.yaml
[    8.016412][    T1]     user=lkp
[    8.016884][    T1]     ARCH=i386
[    8.017372][    T1]     kconfig=i386-randconfig-2006-20250804
[    8.018109][    T1]     commit=b41642c87716bbd09797b1e4ea7d904f06c39b7b
[    8.018928][    T1]     intremap=posted_msi
[    8.019543][    T1]     max_uptime=600
[    8.020064][    T1]     LKP_SERVER=internal-lkp-server
[    8.020735][    T1]     selinux=0
[    8.021215][    T1]     apic=debug
[    8.021707][    T1]     prompt_ramdisk=0
[    8.022251][    T1]     vga=normal
[    8.022791][    T1]     ia32_emulation=on
[    8.023339][    T1]     riscv_isa_fallback=1
[    8.779434][    C0] random: crng init done
LKP: ttyS0: 107: skip deploy intel ucode as no ucode is specified
BUG: kernel hang in boot stage


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250807/202508071303.c1134cce-lkp@intel.com


we didn't observe more information in dmesg. and we only observe this "kernel
hang in boot stage" with a i386 random config. kernel is compiled by clang-20.


as a contrast, parent dmesg looks like below:

[    8.301768][    T1] Run /init as init process
[    8.302821][    T1]   with arguments:
[    8.303849][    T1]     /init
[    8.304408][    T1]   with environment:
[    8.305053][    T1]     HOME=/
[    8.305635][    T1]     TERM=linux
[    8.306225][    T1]     RESULT_ROOT=/result/boot/1/vm-snb/quantal-i386-core-20190426.cgz/i386-randconfig-2006-20250804/clang-20/d827673d8a4e69937dd3731da2686a2d8206aef5/0
[    8.308434][    T1]     BOOT_IMAGE=/pkg/linux/i386-randconfig-2006-20250804/clang-20/d827673d8a4e69937dd3731da2686a2d8206aef5/vmlinuz-6.16.0-rc3-00004-gd827673d8a4e
[    8.310619][    T1]     branch=gustavoars/testing/wfamnae-next20250804
[    8.311610][    T1]     job=/lkp/jobs/scheduled/vm-meta-7/boot-1-quantal-i386-core-20190426.cgz-i386-randconfig-2006-20250804-d827673d8a4e-20250805-99925-p5h1vs-1.yaml
[    8.313843][    T1]     user=lkp
[    8.314287][    T1]     ARCH=i386
[    8.314701][    T1]     kconfig=i386-randconfig-2006-20250804
[    8.315329][    T1]     commit=d827673d8a4e69937dd3731da2686a2d8206aef5
[    8.316029][    T1]     intremap=posted_msi
[    8.316574][    T1]     max_uptime=600
[    8.317018][    T1]     LKP_SERVER=internal-lkp-server
[    8.317599][    T1]     selinux=0
[    8.318009][    T1]     apic=debug
[    8.318424][    T1]     prompt_ramdisk=0
[    8.318888][    T1]     vga=normal
[    8.319307][    T1]     ia32_emulation=on
[    8.319841][    T1]     riscv_isa_fallback=1
[    9.079686][    C0] random: crng init done
LKP: ttyS0: 108: skip deploy intel ucode as no ucode is specified
[    9.371040][  T182] udevd[182]: starting version 175
LKP: ttyS0: 108: Kernel tests: Boot OK!
LKP: ttyS0: 108: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 6.16.0-rc3-00004-gd827673d8a4e 1
LKP: ttyS0: 108:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-7/boot-1-quantal-i386-core-20190426.cgz-i386-randconfig-2006-20250804-d827673d8a4e-20250805-99925-p5h1vs-1.yaml
[   10.016422][    T1] init: failsafe main process (327) killed by TERM signal
[   10.080302][    T1] init: udev-fallback-graphics main process (366) terminated with status 1
[   10.120853][    T1] init: networking main process (373) terminated with status 1
LKP: ttyS0: 108: LKP: rebooting forcely
[   21.082808][  T108] sysrq: Emergency Sync
[   21.084955][   T40] Emergency Sync complete
[   21.086476][  T108] sysrq: Resetting



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

