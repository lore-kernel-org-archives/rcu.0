Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E76A33C
	for <rcu@vger.kernel.org>; Fri,  1 Mar 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285378; cv=fail; b=H96VNfblwd4mcyuHvmxMx70m26hJ8qwD8aRhtvzI9WFQmk1QSd79EqYE8gbh8Ck+vQocuVeRFHl0zlDXjCp6czCSmnSe/EkdOsh4Kf7QvVPbmMEUBZkvdQ/LRsSG6rusR0EEilEkRn+LauS0mB6MP334CYCtZMxB3Jj7MED523A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285378; c=relaxed/simple;
	bh=UtyAzTZeruGQXxGmkdQn0J5ZkpN3ak38NGNWHt+It4Q=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iAST2YgH47cUIgGXATBqVw325kgHxlKRioYGzLlW4ohy1dbuBBrBWAkU2P0ubZHs0unL1TVHqIFAZNeSQklwV3FzPYltF56tZOo9cvQiYbew24EVXTC1lA0LnbKpQ4IZRfUcQFYKKSpOa9gLLtuBXJVCnJhiJ4VY/Z0afkChxCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=af7BMJMo; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="af7BMJMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709285374; x=1740821374;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=UtyAzTZeruGQXxGmkdQn0J5ZkpN3ak38NGNWHt+It4Q=;
  b=af7BMJMov4+NOJ6AkJ3Gkjw8JdN+BjWg7cJp6AFzGTckbmRUGG7QaP3s
   25NOtH+p3qxfbBbk9dSCy8DXuOfIX7Ojm7pM1ISypSW+vNZeoE3xGweSI
   kr3KGaTwroou9tboQmiiiyYo0FOsbYG76Enhodjc2vmISgvP6fXO1mjtQ
   ZTVFVbh+MLm/NYqaaZTNcPD2YLT5y6iEwK0HaU1xUOeSNZi1DAIMg2iKw
   ROS+dxuOfY5G0xEhJ7MjXDElHzpPp59oU+ibKmB3qr1ecIqnnt1O5ODw8
   K8J2qL5C23WZIXlDu99zGNlC5sDlLy4KOLaXXD+DJiBbq5t3t3G6B5nwT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14384505"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="14384505"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 01:29:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="31328543"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 01:29:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 01:29:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 01:29:32 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 01:29:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTNuJr6hcVfymUQQgY9aHktY6ebmymqdyk40ClccCjlAr/+JQA4OSwXOQgxsL8qeDL+piAcKzFbH9UYjmB989VYYVn035HVK3bnjs0pdSHNyE/iR5Y98ijxgEXvQFaSzLVbb+w0SL72tRjUrpDWNm9sGt3KYwHBq8fHoEDnTa6GG9hwT3M28UwFZn+rBekXuV3luGP/S9WekCSJtl7Uqnhay0MbNvDjyAbnK+NYuuSTPr4ZTchHcFnPvlBVaFyZ2KHKTpVXYGZyI2MIz367qiDq+UxSWK/Aj+prfoWnlnDNE0fW48pATsLiuyNAVBpaoqHww4E7nJUlBhizcz6Xrog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhbRJ95zT+YwEwoNR45bh0eSSLfC8Egl9rWlfFs4Wj8=;
 b=BULV9ezKxU1orVQ9K2gnyPR7Z3KyEOVhca7yLI1A7zVGhMgzZxkJLzxlsg0vMT5YtA5oVycHgPRJcTwBPr6NlXEnMGeqcUeiTHw0B5BEiiaZnL4ssOhRUXN2TjgLgCky3qPSzy7oLFMt67/n8o+r9MbqFnGdYxVAW/TrQKP8j7XF+5lAq8CU6MiUOGTJHKXITeHt1CdZ1NtAP3bgYXddZ02uDdvP8KaxgjVKBfiNkNED2emJzs53WxzpulrmDg1/APR4viWL76zoOalKbEj2oYvQZld8Ixv4vTINvzwGcn7OHGJdBEDzk/Cxbz0kJJUOzIUkH4Y0fAjZVuswcuOvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8536.namprd11.prod.outlook.com (2603:10b6:408:1ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.16; Fri, 1 Mar
 2024 09:29:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7339.024; Fri, 1 Mar 2024
 09:29:29 +0000
Date: Fri, 1 Mar 2024 17:29:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Frederic Weisbecker <frederic@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Boqun Feng <boqun.feng@gmail.com>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, "Joel
 Fernandes" <joel@joelfernandes.org>, "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, <rcu@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [rcu/exp]  23da2ad64d:
 stress-ng.unshare.ops_per_sec 3.8% improvement
Message-ID: <202403011754.cef7ce78-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: ab87506d-9bd7-4220-2681-08dc39d2187a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8W1HlA7PMMgPrVRY1NlhAnV3MXTAc74ec3ZsK7uM5gDMNEtduYQk1OP662jPX7cd3dIBFbebjGUiycn2pfGjurF5A4InIdLZcH3eRhpQA4ZoGMjTSmSo2mC9djK6B3XAWeiFoGqgVRizoglzDnYSO1KTp8PbywBKp7cBHj4USMG8W9UhRAtT1DwJwnpjzIgepmx1nFxHE35UMkwd4LLgccTpzn6QiQg6Ye/sL34YcEnRH4lBnwhw6wTM7u1IgbmesBksL5J+gHhMkqGOeq+YIA5ETLBdUuK0+obVXRtJNJkMZprfzrpAgMpsPeCpYtoTz6W0rmKc9XIaUS2gIKEuPdm43NyEsGBjguxw4QIDKdPhqwdSsws890Auig1XOg/vft6yt53Ddjl7Q5AHyfVlnKmEuFiQFLS2lei6Lj/eHFHfU3HZCkOMPbBjfEuB0MrrQnleHBBcNRWcxdVU6XVBMkpBySOrOwmf82e2IIRXDFDSVKPYKD92fiz401Nc2+lZjdgcN4zTYBRXsEJk665l4y2NBwKXAkqmvl5HLjGKduhMdQKGbOM0M3rPGKDY6W0UcxITrV25IhFPPlmo1UAreB6Lj3rKeU88AzHf6RI/Ss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SOKviUqwYlXmMQAAaXZJqJsgpMvIRgfRnqR+ytlE05V4UypU7cUaEscHE7?=
 =?iso-8859-1?Q?VNL5NvufpDs55/jqgNxSfsqx+zHd2U5dAVbdJt2PgTBUsfCecrvRbyc92l?=
 =?iso-8859-1?Q?l8f1M1jld/ys6gZM/XoGxSyaobSYfay+6eF3jaCHnNfQX3cUDNKN25oaGb?=
 =?iso-8859-1?Q?eD2SxK0nB10oMA9d3uMzz9gDWlMOdlR9qILICQvbjbS2Qo6e5TUjpo8iED?=
 =?iso-8859-1?Q?dZfWyQcqhiIC+Z6bauYSYCwEGRTOji2S351qbku+SkGibOFceUUDVsf2Jp?=
 =?iso-8859-1?Q?/wpVjwaPJo6ny/YzibRwSCJnq20O3sebCKnm68klMLCwNYB0udI0JJJTVq?=
 =?iso-8859-1?Q?Uor9PYHn2uS3fXshlTku46mTfCgSEQHrq+Bja2oLp07b7QMnnc0BOYeOe4?=
 =?iso-8859-1?Q?uC+ucnSXqW2JDEtWNDCM7KnKB2id49/R/q5KcqRyrrLQk0uvZcuv9X5J8q?=
 =?iso-8859-1?Q?wAJi9f9PuTBVENOHCFOpXcEPZ4mUozGAvxctwhc5/B0Zw+aH7HXTzRuu7+?=
 =?iso-8859-1?Q?w+V/ow08tQl3vHVbeEHx/9MYTW7m+iboYiEkJvjKDNj5qi99mFz4VcpFSL?=
 =?iso-8859-1?Q?+ocQTqt/5/98NhcqM9mAqbWdQq4SP+o9y+wBHHZEypwZxdNy3XNQhnnR0q?=
 =?iso-8859-1?Q?3ytGIDD7UZ20Fs+Gmw8wkfo1xEKSK7IuMHbYi666S5dvQfpwAQo81ltSxz?=
 =?iso-8859-1?Q?iuxDnqhcw5a7uV+XrrvRmX3NUee38Gpm3iM3dTqdSW4aNaMXysqQwVClhv?=
 =?iso-8859-1?Q?Kz/jNyAAf1bbXZQDC3v9rifg8IsiqhPb3fN69T38oEB1OIeSTiwcCmYNZq?=
 =?iso-8859-1?Q?7rqA2Vf67PeKZ9A2mrzlLLey70nuVR/TNwDtenCkrmEmK/jAcT/rXqHr/d?=
 =?iso-8859-1?Q?kfm4B8vkR4ThEZ7xezwoO8m9A3b34wk4YdpfisP+aWcvIBakViUu0/q+EI?=
 =?iso-8859-1?Q?61n1U+Lp9QPslgSd/S2GHxZLz/NWAyn38iY5YLL1trK9uCfhQHpLspcwna?=
 =?iso-8859-1?Q?jfssKt3N1gijsNP0s02tg/VqHtOvG+mVWqvVOInybRtQoSDgO+DnptEtYe?=
 =?iso-8859-1?Q?NmyngRu0lPgwbcIXUW7HCxWuHm/5qJdW9SvWkS11VeFc1zuxQ0uUc8791B?=
 =?iso-8859-1?Q?kotj8naj6fFsrMJr71ZRSN8OTu5s517CapZo/dcuLDBqvllzs6ouzFzRDT?=
 =?iso-8859-1?Q?Y88/79FokXXHZa4fBgC6g5GDAicVVKpxcjXtTO30n90p19vIzpGOBDbwQB?=
 =?iso-8859-1?Q?c0Ihd+Ee0gFiUi8sjQlbDKQr+kwRzaxp/Bjd8BEPRrhzCkBT7M1qSf93RA?=
 =?iso-8859-1?Q?pbCvOvyAnBiLKEymH9xVW4BGcrqcvQhaBnfM3LMPkreMEx0hLb5ovUrXP2?=
 =?iso-8859-1?Q?S7kdFrk6YC5g/yL5jYw2HOtBGp6Wn20aJqFMOttHUu8rq37cyRVExVSWCx?=
 =?iso-8859-1?Q?ogPjLMoQVjiJ/OcaKHtV6/qODmsiVwcsmlVT1Ip9vdl89d6Ve4fa3B2qYJ?=
 =?iso-8859-1?Q?CvOTyWSoVFQRmLDpWJ9ShoYVnnWCPKTe37sxuOefv3fozkKrd2lD3wPU83?=
 =?iso-8859-1?Q?2Q/5i1CDMDL7NzwqGuhp8HT409LUp2WU7Xb8HrxfWCRJNDD9yU3sSCutFb?=
 =?iso-8859-1?Q?dyHfFFuZ92xX8cpjVGd0AMdpvYOyExE94fJVkCyTJRyitHV5aeEZGPMg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab87506d-9bd7-4220-2681-08dc39d2187a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 09:29:29.9595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJdMf7oaCOU2RTfMzfAxBAkiDTJSfx/9Fa7wkqQs4TJmYuqaYFtxd9pP0HRkd8HgmX39JUc/V0RUCsaeanUbSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8536
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 3.8% improvement of stress-ng.unshare.ops_per_sec on:


commit: 23da2ad64dbe9f3fab10af90484fe41e144337b1 ("rcu/exp: Remove rcu_par_gp_wq")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: unshare
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240301/202403011754.cef7ce78-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/unshare/stress-ng/60s

commit: 
  b67cffcbbf ("rcu/exp: Handle parallel exp gp kworkers affinity")
  23da2ad64d ("rcu/exp: Remove rcu_par_gp_wq")

b67cffcbbf9dc759 23da2ad64dbe9f3fab10af90484 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   4083498           +41.9%    5794411        cpuidle..usage
     39791           +72.6%      68680        vmstat.system.cs
     94731            +4.5%      98951        vmstat.system.in
    162611            -2.4%     158778        proc-vmstat.nr_kernel_stack
     83884            +1.6%      85234        proc-vmstat.nr_slab_reclaimable
    553698            +1.6%     562348        proc-vmstat.nr_slab_unreclaimable
      1220 ±  4%     +40.6%       1716 ±  4%  perf-c2c.DRAM.local
      3070 ±  4%     +38.1%       4238 ±  2%  perf-c2c.DRAM.remote
      2481 ±  5%     +32.7%       3291 ±  3%  perf-c2c.HITM.local
      1442 ±  4%     +35.9%       1960 ±  3%  perf-c2c.HITM.remote
      3189 ±  2%     -54.1%       1464 ±  3%  stress-ng.time.involuntary_context_switches
     17353           +10.2%      19130        stress-ng.time.voluntary_context_switches
      3427            +3.7%       3552        stress-ng.unshare.ops
     55.76            +3.8%      57.89        stress-ng.unshare.ops_per_sec
    107475 ±  9%     +13.3%     121741 ±  8%  sched_debug.cpu.avg_idle.stddev
      6510           +65.0%      10742        sched_debug.cpu.nr_switches.avg
     49403 ± 32%     -21.8%      38646 ±  5%  sched_debug.cpu.nr_switches.max
     12.11 ±  4%     -15.7%      10.21 ±  8%  sched_debug.cpu.nr_uninterruptible.avg
     30.76 ± 11%     -22.3%      23.90 ± 13%  sched_debug.cpu.nr_uninterruptible.stddev
      2.81            +7.8%       3.03        perf-stat.i.MPKI
     28.30            +2.8       31.06        perf-stat.i.cache-miss-rate%
  39928468            +6.1%   42351198        perf-stat.i.cache-misses
 1.395e+08            -2.9%  1.355e+08        perf-stat.i.cache-references
     40743           +75.8%      71627        perf-stat.i.context-switches
      2.59            -3.0%       2.51        perf-stat.i.cpi
    770.16 ±  3%     +28.8%     992.27        perf-stat.i.cpu-migrations
      1001 ±  2%      -9.0%     911.25        perf-stat.i.cycles-between-cache-misses
      0.43            +2.4%       0.44        perf-stat.i.ipc
      2.59            +6.2%       2.74        perf-stat.overall.MPKI
     28.74            +2.6       31.30        perf-stat.overall.cache-miss-rate%
      1085 ±  3%      -8.5%     993.69        perf-stat.overall.cycles-between-cache-misses
  39937502            +5.0%   41932438        perf-stat.ps.cache-misses
  1.39e+08            -3.6%   1.34e+08        perf-stat.ps.cache-references
     40364           +74.2%      70308        perf-stat.ps.context-switches
    774.79 ±  3%     +27.7%     989.35        perf-stat.ps.cpu-migrations
     50.99            -2.7       48.26        perf-profile.calltrace.cycles-pp.__x64_sys_unshare.do_syscall_64.entry_SYSCALL_64_after_hwframe.unshare
     50.99            -2.7       48.26        perf-profile.calltrace.cycles-pp.ksys_unshare.__x64_sys_unshare.do_syscall_64.entry_SYSCALL_64_after_hwframe.unshare
     51.46            -2.7       48.74        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unshare
     51.46            -2.7       48.74        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unshare
     51.49            -2.7       48.77        perf-profile.calltrace.cycles-pp.unshare
     46.23            -2.4       43.84        perf-profile.calltrace.cycles-pp.unshare_nsproxy_namespaces.ksys_unshare.__x64_sys_unshare.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.20            -2.4       43.82        perf-profile.calltrace.cycles-pp.create_new_namespaces.unshare_nsproxy_namespaces.ksys_unshare.__x64_sys_unshare.do_syscall_64
     41.66            -2.3       39.38        perf-profile.calltrace.cycles-pp.copy_mnt_ns.create_new_namespaces.unshare_nsproxy_namespaces.ksys_unshare.__x64_sys_unshare
     28.30            -1.8       26.52 ±  3%  perf-profile.calltrace.cycles-pp.down_write.copy_mnt_ns.create_new_namespaces.unshare_nsproxy_namespaces.ksys_unshare
     28.29            -1.8       26.52 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.copy_mnt_ns.create_new_namespaces.unshare_nsproxy_namespaces
     25.26 ±  2%      -1.4       23.85 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.copy_mnt_ns.create_new_namespaces
      2.03            -0.9        1.13 ±  3%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.69            -0.8        0.85 ±  3%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      9.61            -0.6        9.03        perf-profile.calltrace.cycles-pp.__memset.pcpu_alloc.alloc_vfsmnt.clone_mnt.copy_tree
     11.63            -0.6       11.05        perf-profile.calltrace.cycles-pp.alloc_vfsmnt.clone_mnt.copy_tree.copy_mnt_ns.create_new_namespaces
     12.73            -0.6       12.16        perf-profile.calltrace.cycles-pp.clone_mnt.copy_tree.copy_mnt_ns.create_new_namespaces.unshare_nsproxy_namespaces
     16.04            -0.5       15.49        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.put_mnt_ns.free_nsproxy
     10.57            -0.5       10.03        perf-profile.calltrace.cycles-pp.pcpu_alloc.alloc_vfsmnt.clone_mnt.copy_tree.copy_mnt_ns
     13.21            -0.5       12.70        perf-profile.calltrace.cycles-pp.copy_tree.copy_mnt_ns.create_new_namespaces.unshare_nsproxy_namespaces.ksys_unshare
     14.64            -0.4       14.21        perf-profile.calltrace.cycles-pp.down_write.put_mnt_ns.free_nsproxy.do_exit.do_group_exit
     14.64            -0.4       14.21        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.put_mnt_ns.free_nsproxy.do_exit
      4.11 ±  4%      -0.3        3.77 ±  2%  perf-profile.calltrace.cycles-pp.put_mnt_ns.free_nsproxy.ksys_unshare.__x64_sys_unshare.do_syscall_64
      4.12 ±  4%      -0.3        3.78 ±  2%  perf-profile.calltrace.cycles-pp.free_nsproxy.ksys_unshare.__x64_sys_unshare.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.64            -0.3       10.33        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.put_mnt_ns
      3.09 ±  4%      -0.3        2.79 ±  3%  perf-profile.calltrace.cycles-pp.down_write.put_mnt_ns.free_nsproxy.ksys_unshare.__x64_sys_unshare
      3.09 ±  4%      -0.3        2.79 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.put_mnt_ns.free_nsproxy.ksys_unshare
      4.54            -0.2        4.37        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.copy_mnt_ns
      2.55            -0.1        2.40        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_down_write_slowpath.down_write.copy_mnt_ns.create_new_namespaces
      0.79 ±  2%      -0.1        0.72 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.77 ±  2%      -0.1        0.70 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.78 ±  2%      -0.1        1.71 ±  2%  perf-profile.calltrace.cycles-pp.pcpu_alloc.__percpu_init_rwsem.alloc_super.sget_fc.get_tree_nodev
      1.93 ±  2%      -0.1        1.86 ±  2%  perf-profile.calltrace.cycles-pp.alloc_super.sget_fc.get_tree_nodev.vfs_get_tree.fc_mount
      1.96 ±  2%      -0.1        1.89 ±  2%  perf-profile.calltrace.cycles-pp.sget_fc.get_tree_nodev.vfs_get_tree.fc_mount.mq_init_ns
      1.54 ±  2%      -0.1        1.47 ±  2%  perf-profile.calltrace.cycles-pp.__memset.pcpu_alloc.__percpu_init_rwsem.alloc_super.sget_fc
      1.83 ±  2%      -0.1        1.76 ±  2%  perf-profile.calltrace.cycles-pp.__percpu_init_rwsem.alloc_super.sget_fc.get_tree_nodev.vfs_get_tree
      0.82            +0.1        0.88        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      0.68 ±  3%      +0.1        0.75 ±  3%  perf-profile.calltrace.cycles-pp.mnt_get_writers.cleanup_mnt.task_work_run.do_exit.do_group_exit
      0.90 ±  5%      +0.1        0.99 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      1.28 ±  2%      +0.1        1.38 ±  3%  perf-profile.calltrace.cycles-pp.mnt_get_count.mntput_no_expire.namespace_unlock.put_mnt_ns.free_nsproxy
      1.00 ±  3%      +0.1        1.09 ±  3%  perf-profile.calltrace.cycles-pp.cleanup_mnt.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
      1.04 ±  3%      +0.1        1.14 ±  3%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.50 ±  3%      +0.1        1.64 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      1.94 ±  3%      +0.2        2.11 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      1.80 ±  5%      +0.2        2.00 ±  2%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      2.69 ±  2%      +0.3        2.96 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_percpu.delayed_free_vfsmnt.rcu_do_batch
      2.78 ±  2%      +0.3        3.06 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_percpu.delayed_free_vfsmnt.rcu_do_batch.rcu_core
      2.90 ±  2%      +0.3        3.18 ±  4%  perf-profile.calltrace.cycles-pp.free_percpu.delayed_free_vfsmnt.rcu_do_batch.rcu_core.__do_softirq
      2.98 ±  2%      +0.3        3.26 ±  4%  perf-profile.calltrace.cycles-pp.delayed_free_vfsmnt.rcu_do_batch.rcu_core.__do_softirq.irq_exit_rcu
      3.20 ±  2%      +0.3        3.50 ±  4%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      3.23 ±  2%      +0.3        3.54 ±  4%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      6.58 ±  2%      +0.3        6.90        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      5.06 ±  2%      +0.3        5.37        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      6.90 ±  2%      +0.3        7.23        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.50 ±  2%      +0.4        3.85 ±  4%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      3.47 ±  2%      +0.4        3.83 ±  4%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      7.24 ±  2%      +0.4        7.61        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      7.24 ±  2%      +0.4        7.61        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      7.25 ±  2%      +0.4        7.62        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      7.25 ±  2%      +0.4        7.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      7.66 ±  2%      +0.4        8.06        perf-profile.calltrace.cycles-pp._Fork
      6.98 ±  2%      +0.5        7.44 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      7.00 ±  2%      +0.5        7.47 ±  2%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      7.00 ±  2%      +0.5        7.47 ±  2%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.87            +0.5        1.39 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle_xstate.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.63            +0.5        3.16 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      2.63            +0.5        3.16 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      2.63            +0.5        3.16 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.00            +0.6        0.57 ±  4%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.28 ±  2%      +0.9        7.15 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      6.28 ±  2%      +1.0        7.24 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      6.67 ±  2%      +1.2        7.89 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +1.4        1.38        perf-profile.calltrace.cycles-pp.kthread_worker_fn.kthread.ret_from_fork.ret_from_fork_asm
      7.89            +1.6        9.45 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      7.25 ±  3%      +1.7        8.92 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      7.25 ±  3%      +1.7        8.92 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      7.24 ±  3%      +1.7        8.92 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     50.99            -2.7       48.26        perf-profile.children.cycles-pp.__x64_sys_unshare
     50.99            -2.7       48.26        perf-profile.children.cycles-pp.ksys_unshare
     51.50            -2.7       48.78        perf-profile.children.cycles-pp.unshare
     46.08            -2.5       43.59        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     46.74            -2.5       44.29        perf-profile.children.cycles-pp.down_write
     46.23            -2.4       43.84        perf-profile.children.cycles-pp.unshare_nsproxy_namespaces
     46.20            -2.4       43.82        perf-profile.children.cycles-pp.create_new_namespaces
     41.66            -2.3       39.38        perf-profile.children.cycles-pp.copy_mnt_ns
     86.30            -2.2       84.06        perf-profile.children.cycles-pp.do_syscall_64
     86.31            -2.2       84.06        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     41.36            -2.0       39.41 ±  2%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     31.34            -1.5       29.80 ±  2%  perf-profile.children.cycles-pp.osq_lock
      2.03            -0.9        1.13 ±  3%  perf-profile.children.cycles-pp.worker_thread
      1.69            -0.8        0.85 ±  3%  perf-profile.children.cycles-pp.process_one_work
     13.87            -0.7       13.16        perf-profile.children.cycles-pp.__memset
      1.67            -0.7        0.99        perf-profile.children.cycles-pp.load_balance
      1.50            -0.7        0.84 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.53            -0.7        0.88        perf-profile.children.cycles-pp.find_busiest_group
      1.52            -0.6        0.87        perf-profile.children.cycles-pp.update_sd_lb_stats
     15.36            -0.6       14.71        perf-profile.children.cycles-pp.pcpu_alloc
      1.47            -0.6        0.82 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      1.44            -0.6        0.82 ±  2%  perf-profile.children.cycles-pp.update_sg_lb_stats
     12.30            -0.6       11.69        perf-profile.children.cycles-pp.alloc_vfsmnt
     13.98            -0.6       13.38        perf-profile.children.cycles-pp.rwsem_spin_on_owner
     12.73            -0.6       12.16        perf-profile.children.cycles-pp.clone_mnt
     13.21            -0.5       12.70        perf-profile.children.cycles-pp.copy_tree
      2.28 ±  2%      -0.5        1.79        perf-profile.children.cycles-pp.__schedule
      0.79 ±  3%      -0.5        0.30        perf-profile.children.cycles-pp.schedule_preempt_disabled
      1.55 ±  2%      -0.3        1.20        perf-profile.children.cycles-pp.schedule
      0.84 ±  3%      -0.2        0.64 ±  4%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.92 ±  3%      -0.2        0.73 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.90 ±  3%      -0.2        0.72 ±  3%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.21 ±  2%      -0.2        0.05        perf-profile.children.cycles-pp.schedule_timeout
      0.32 ±  4%      -0.1        0.18 ±  5%  perf-profile.children.cycles-pp.synchronize_rcu_expedited
      0.18 ±  6%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.exp_funnel_lock
      0.23 ±  3%      -0.1        0.10        perf-profile.children.cycles-pp.rcu_exp_wait_wake
      0.15 ±  4%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__mutex_lock
      0.34 ±  5%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.20 ±  5%      -0.1        0.11 ±  5%  perf-profile.children.cycles-pp.cpu_util
      1.10            -0.1        1.02 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.48 ±  3%      -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.update_blocked_averages
      1.13            -0.1        1.04 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.79            -0.1        0.71 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.22 ±  2%      -0.1        0.15 ±  6%  perf-profile.children.cycles-pp.idle_cpu
      1.93 ±  2%      -0.1        1.86 ±  2%  perf-profile.children.cycles-pp.alloc_super
      1.83 ±  2%      -0.1        1.76 ±  2%  perf-profile.children.cycles-pp.__percpu_init_rwsem
      1.96 ±  2%      -0.1        1.89 ±  2%  perf-profile.children.cycles-pp.sget_fc
      0.16 ±  6%      -0.1        0.10        perf-profile.children.cycles-pp.smp_call_function_single
      0.31 ±  3%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.__sync_rcu_exp_select_node_cpus
      0.66 ±  2%      -0.1        0.60 ±  3%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      0.56 ±  3%      -0.1        0.51 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.56 ±  2%      -0.0        0.51 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.13 ±  5%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp._find_next_and_bit
      0.32 ±  2%      -0.0        0.28 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      0.10 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      0.11 ±  6%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.12 ±  8%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.ct_idle_exit
      0.12 ±  6%      -0.0        0.09 ±  8%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.09 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__wait_for_common
      0.09 ± 10%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.36 ±  3%      -0.0        0.33 ±  5%  perf-profile.children.cycles-pp.rebalance_domains
      0.08 ±  8%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.force_qs_rnp
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.13 ±  6%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.activate_task
      0.08 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.find_unlink_vmap_area
      0.07 ±  6%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.15 ±  2%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.23 ±  2%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.28 ±  2%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.04 ± 45%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.39            +0.0        0.41 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.40 ±  2%      +0.0        0.42 ±  3%  perf-profile.children.cycles-pp.__vm_area_free
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.10 ±  8%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.12 ± 12%      +0.0        0.15 ±  8%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.44 ±  2%      +0.0        0.48 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.26 ±  4%      +0.0        0.30 ±  5%  perf-profile.children.cycles-pp.find_idlest_group
      0.08 ±  5%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.25 ±  4%      +0.0        0.29 ±  5%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.34 ±  3%      +0.0        0.38 ±  4%  perf-profile.children.cycles-pp.wake_up_new_task
      0.30 ±  3%      +0.0        0.34 ±  5%  perf-profile.children.cycles-pp.find_idlest_cpu
      0.12 ±  5%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.rcu_report_exp_cpu_mult
      0.23 ±  6%      +0.0        0.28 ±  6%  perf-profile.children.cycles-pp.clockevents_program_event
      0.01 ±223%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.read_tsc
      0.06 ±  6%      +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.__switch_to
      0.06 ± 11%      +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.83            +0.1        0.88        perf-profile.children.cycles-pp.unlink_file_vma
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.llist_add_batch
      0.36 ±  7%      +0.1        0.42 ±  7%  perf-profile.children.cycles-pp.ktime_get
      0.08 ± 11%      +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.available_idle_cpu
      0.02 ±141%      +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.need_update
      0.81 ±  2%      +0.1        0.88 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.llist_reverse_order
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.quiet_vmstat
      1.18            +0.1        1.26 ±  2%  perf-profile.children.cycles-pp._find_next_bit
      0.09 ± 10%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.49 ±  2%      +0.1        0.57 ±  4%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.18 ±  4%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.kthread_flush_work
      0.93 ±  3%      +0.1        1.02 ±  3%  perf-profile.children.cycles-pp.mnt_get_writers
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.select_task_rq
      0.06 ±  8%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.90 ±  5%      +0.1        1.00 ±  2%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.37 ±  3%      +0.1        0.47 ±  5%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.32 ±  2%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.21 ±  3%      +0.1        0.31 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.42 ±  3%      +0.1        1.53 ±  3%  perf-profile.children.cycles-pp.cleanup_mnt
      0.10 ±  9%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      1.46 ±  2%      +0.1        1.58 ±  3%  perf-profile.children.cycles-pp.task_work_run
      0.00            +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      1.80 ±  2%      +0.1        1.92 ±  2%  perf-profile.children.cycles-pp.mnt_get_count
      1.51 ±  3%      +0.1        1.64 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
      0.38 ±  3%      +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.intel_idle
      0.08 ± 12%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.2        0.15 ±  4%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      1.95 ±  3%      +0.2        2.11 ±  2%  perf-profile.children.cycles-pp.anon_vma_fork
      0.23 ±  3%      +0.2        0.40 ±  3%  perf-profile.children.cycles-pp.sync_rcu_exp_select_cpus
      0.23 ±  3%      +0.2        0.40 ±  3%  perf-profile.children.cycles-pp.wait_rcu_exp_gp
      0.20 ±  7%      +0.2        0.37 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      1.80 ±  5%      +0.2        2.00 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
      0.16 ±  6%      +0.2        0.37 ±  6%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.10 ±  6%      +0.2        0.34 ±  5%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.00            +0.2        0.25 ±  2%  perf-profile.children.cycles-pp.kthread_queue_work
      5.07 ±  2%      +0.3        5.38        perf-profile.children.cycles-pp.dup_mmap
      6.58 ±  2%      +0.3        6.90        perf-profile.children.cycles-pp.dup_mm
      6.90 ±  2%      +0.3        7.24        perf-profile.children.cycles-pp.copy_process
      3.49            +0.4        3.85 ±  4%  perf-profile.children.cycles-pp.delayed_free_vfsmnt
      3.49            +0.4        3.85 ±  4%  perf-profile.children.cycles-pp.free_percpu
      7.26 ±  2%      +0.4        7.62        perf-profile.children.cycles-pp.kernel_clone
      7.24 ±  2%      +0.4        7.61        perf-profile.children.cycles-pp.__do_sys_clone
      3.80            +0.4        4.18 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
      3.86            +0.4        4.24 ±  4%  perf-profile.children.cycles-pp.rcu_core
      7.69 ±  2%      +0.4        8.08        perf-profile.children.cycles-pp._Fork
      4.32            +0.4        4.75 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      6.99 ±  2%      +0.5        7.45 ±  2%  perf-profile.children.cycles-pp.exit_mmap
      7.00 ±  2%      +0.5        7.48 ±  2%  perf-profile.children.cycles-pp.__mmput
      7.02 ±  2%      +0.5        7.49 ±  2%  perf-profile.children.cycles-pp.exit_mm
      0.89            +0.5        1.42 ±  2%  perf-profile.children.cycles-pp.intel_idle_xstate
      2.63            +0.5        3.16 ±  2%  perf-profile.children.cycles-pp.kthread
      2.91            +0.6        3.46 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      2.94            +0.6        3.49        perf-profile.children.cycles-pp.ret_from_fork_asm
      5.65 ±  5%      +0.6        6.21 ±  4%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      6.70            +0.9        7.63 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      6.70            +0.9        7.63 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      7.16            +1.2        8.33 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.00            +1.4        1.38        perf-profile.children.cycles-pp.kthread_worker_fn
      7.89            +1.6        9.45 ±  2%  perf-profile.children.cycles-pp.do_idle
      7.89            +1.6        9.45 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
      7.89            +1.6        9.45 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      7.25 ±  3%      +1.7        8.92 ±  4%  perf-profile.children.cycles-pp.start_secondary
     31.11            -1.5       29.59 ±  2%  perf-profile.self.cycles-pp.osq_lock
     13.68            -0.7       12.96        perf-profile.self.cycles-pp.__memset
     13.86            -0.6       13.27        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      1.06            -0.4        0.61 ±  2%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.17 ±  5%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.cpu_util
      0.21            -0.1        0.14 ±  4%  perf-profile.self.cycles-pp.idle_cpu
      0.12 ±  7%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.smp_call_function_single
      0.15 ±  7%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.__sync_rcu_exp_select_node_cpus
      0.11 ±  6%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp._find_next_and_bit
      0.41 ±  2%      -0.0        0.37 ±  3%  perf-profile.self.cycles-pp.alloc_vfsmnt
      0.09 ± 10%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.rcu_report_exp_cpu_mult
      0.14 ±  6%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.update_rq_clock
      0.20 ±  3%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.filemap_map_pages
      0.14 ±  4%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.anon_vma_fork
      0.14 ±  4%      +0.0        0.16 ±  6%  perf-profile.self.cycles-pp.unmap_single_vma
      0.08 ± 10%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.22 ±  5%      +0.0        0.25 ±  6%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.47 ±  3%      +0.0        0.50 ±  3%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.08 ±  4%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.menu_select
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.06 ±  8%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.__switch_to
      0.01 ±223%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.llist_add_batch
      0.90 ±  2%      +0.1        0.96 ±  3%  perf-profile.self.cycles-pp._find_next_bit
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.newidle_balance
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.try_to_wake_up
      0.68 ±  3%      +0.1        0.74 ±  3%  perf-profile.self.cycles-pp.mnt_get_writers
      0.19 ±  3%      +0.1        0.25 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.available_idle_cpu
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.kthread_worker_fn
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.call_cpuidle
      0.96 ±  2%      +0.1        1.03 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.01 ±223%      +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.llist_reverse_order
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.89 ±  5%      +0.1        0.99 ±  2%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      1.53 ±  2%      +0.1        1.64 ±  3%  perf-profile.self.cycles-pp.mnt_get_count
      0.38 ±  3%      +0.1        0.52 ±  2%  perf-profile.self.cycles-pp.intel_idle
      0.88            +0.5        1.41 ±  2%  perf-profile.self.cycles-pp.intel_idle_xstate
      5.63 ±  5%      +0.6        6.19 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

