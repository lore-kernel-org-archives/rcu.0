Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA1421ADA7;
	Fri, 18 Apr 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992962; cv=fail; b=GSaPqKAgCfSti00JxM79GWquU7+eShz+WPU5wFJ5JiMukLIa+wWPzCMNwW/amTTNoYFMKGh9LvN+6cBTcSwdOrnD1vLV4hRTwf1S7TGeeMm0vRNnlJ4XxUWgGdHrV93ovGTVNRXZ/4MbNPQw5prBcCsybFSZm/5JdRcV4GTNErQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992962; c=relaxed/simple;
	bh=nMDuI5drXMhXFUwbSEUHzUJeBHOXcJfEOHWK9w2X8QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X0o4a3xKAIIizsH2IiQZQySZDQhGXjEIefEPjQ8kcsedLggUG+wCi55lRMIglTwAGw3nD0bWglwZJP0Q8hnsjJKbqDXw0q7aoLyEAlfqreJ9kcASa0htuW2MMboN9cRgEJoBkfxlp+pByZpOczHMI5uNBLsqrJptG6Es0TGXmrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OMXCvEgn; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OMXCvEgn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liu238UDguRjXmfVqzw01FUXcOT7eecIMX4PyMgED707LcfN7/NRzJFJ+SjNtyzYmFBJxd5ndK4/nRF8jw+MckTPKW3Sk+hsowur18ThaVSRZUhvgvtcN4KRSht+z5fOvfun/f0Scw4RBV8aeN7V30pVCAU+eH4FzNboo9aoSCIfVuA33YWARZ3Y6U/5EPxGG1fm0u6zjnIqBp2+yU7OXYfbvoeEu4qvnVBsU309aqqTyf5zlqk1QYI07wh+cJ2llI9SSFLkAjyJQGxOydTySYh14THyekABCfGYMOLl8TxxYYY4fD/kfT45UCmebbJeBfNgmU0LaLseQkHe3JLsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L23ht2LL4eRsMUWClDybwDtg0pJJXss8GqhbddrEBnY=;
 b=EZVrg0Y7aiZR3mr9YC1Zq+L2uKQNWcM4F5/cWofc6SsAPv5Ansa8XqgdCeWZo/+I6DNabvuXG4afckNAE8p+MkAWCC4vlKl95P85hj4H4LqbeNiZoG498t9STAQ2SUfa5j+jrr6ch4Nd+GL9MOXk6iGTaPSUU6Y1zYvnMJiktOHeBzcV4opGvz3PqjvE5U9xdyzM46dcr2CHRakEzhicr/ZbKyTb/K2H9mpTJuApxMq4bLCYAZZbunT86RuJBwHyrHi7m6MNx84SE8otZGCGEpA1LECkvRi7hzSwHKTf5Y/7hOZfKacuQqJ2WMl1sU9VFNSRvKZ/HBY+XhSXZHDe8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L23ht2LL4eRsMUWClDybwDtg0pJJXss8GqhbddrEBnY=;
 b=OMXCvEgnRUrpWUqfXSYLHXfcb06NVr4uph6leHS1TS8oJdWlqzSRuwJHT22xrEXw58A2E4spJxXM/mZSq/KEtK4rQDaEBUBvbwfflDInKbReUEugE8e1EJN1Jg4t+xyRDmktPvwt/+5itdlXuK4+Z/d42hE23/ELD6+BpetriVowLLZfUjkmrT8qEUHx26OQh++VxLdPlCGyegr8i0D7Cy5MyrnT51+nFN04my3RvWXjJn6flnImu2TnK0rTEjCE8Nh+sHMl0fIPqhPpc/Og0kss7IYAYVrox+FR774SEhPbRHHetTdJgVxk7uCK31OIiGeqOoiaVTnUidIhyhc6WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Fri, 18 Apr
 2025 16:15:56 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:15:56 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>
Cc: rcu@vger.kernel.org,
	Yongliang Gao <leonylgao@tencent.com>,
	kernel test robot <lkp@intel.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH 3/7] rcu/cpu_stall_cputime: fix the hardirq count for x86 architecture
Date: Fri, 18 Apr 2025 12:15:36 -0400
Message-ID: <20250418161542.2429420-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161542.2429420-1-joelagnelf@nvidia.com>
References: <20250418161542.2429420-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0400.namprd03.prod.outlook.com
 (2603:10b6:408:111::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 91dffb2f-ea6f-4726-7b64-08dd7e944ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zxnJvAUCr+Xrf7Ir8YZtabMiuBLPe/idvEIfPUcXOzF/M+qEWW2u5ACRs5F5?=
 =?us-ascii?Q?HlycrdSqbcYYZJadbCxKjOXORCK1CVYnonH2cXlyu9fmQBnYnLl1u30vlZTR?=
 =?us-ascii?Q?kyLDOQHbTvUMLxpvtjNnoETFJSIOCTYI8OV9oWxzdMcgE2vV6HZlABzb5eDA?=
 =?us-ascii?Q?bjDqaOPrDfm4NnmQgyZrrW4IEXlRXeV6U9D8z4lSb/DvNz447GdOqmxjtvRk?=
 =?us-ascii?Q?5aK0j9l+T6hoKVQQZBfY3zL7dTfq1qFP5gqax1xtpSjhlBMVvCTlK9+JNxQE?=
 =?us-ascii?Q?pVk/kxuYJOhQnIE683QUkVoAumsOvDqp0nvgOWn5xJfu2tQAFBLeHIZsZrQK?=
 =?us-ascii?Q?QmicqIikPMwa2o6pvZY3fxpgFPQHbVcNU3kQxpgdVvdMEpe63MtyfG1TJgM3?=
 =?us-ascii?Q?3FSqDJ4rR94DeyKKBZNpeJ5sMHKndlp9buU7v1C4AR2a/95mlN2YEQf3I+Lm?=
 =?us-ascii?Q?ZiQjYpDofScLMaQsF5k9rHUDHxlovXkCnOyLpYgipffnAbhXg1htn3/ylnpJ?=
 =?us-ascii?Q?w113OaaNMgFXR0YAMg7DNKIq8Cf5zdcjCf9JnPkoA4tL9BCEP656nJPCrk2V?=
 =?us-ascii?Q?avkWjY7yz8DNRO71mo4ZVHLt8ibP0K6WzU1IxvsaGVK0q3us7VTribngDU1Y?=
 =?us-ascii?Q?sjKr0pzpJcWG2dVlG2KkzYa0cc0jC2FGVUyDMkk736YtWsSokuppI3VOH1nS?=
 =?us-ascii?Q?+0a30kmAKAD8Ydca39cdiTs9EXb+gjTpDee+MVaNZmCwKORE4UqkwvvuLaP2?=
 =?us-ascii?Q?2/fLB97FdHYbsBvRotxK7F1K4cXam/FfaWj0GrWY96GekvaDMtjThPcOAmCy?=
 =?us-ascii?Q?Aa4mWFVmEKawNdikob3l4YXRZeLe/7D9W6tSLkR/OYkvFWV3LkHlFRXDNWVi?=
 =?us-ascii?Q?QKsT168fwbAWiCB3V8VExdzTgiki3FLMljTBBPcqap/Y6Br449rNBM/zGA47?=
 =?us-ascii?Q?4GBQhE/YYxu7XjLLAS1yk8LT0qZ7S833OBF6hL/AN7XJ8zVWCGxwvJLE34/E?=
 =?us-ascii?Q?dNg9HHLXZ5dD1nWlb+WxLl8fHwoqLo4REZjwwnzS5jTVe2on2RhR72qTp9lF?=
 =?us-ascii?Q?n08FeAhmLsgLNktC2ZoHihzc9l+NYcR9HdCssOkXNeHFd9Qrdh9TrFAHaKH+?=
 =?us-ascii?Q?IOSj1qg1VuViVmKHv1hh8dK1NmZJgp/3WDgebcyAzDwRf+pSguU/K5ozR8W2?=
 =?us-ascii?Q?cJeoXDk22gh5CxDu9U62NjnA6MEBS5eaaAKf5PXybgMBiRqBTwH6zIIge0AJ?=
 =?us-ascii?Q?MVSnSd9gQ2YH7hAuHLVyJM3IVRabfOWieoEIdoJAtwqAEH7sn6NGeBV2rp5M?=
 =?us-ascii?Q?A5Cy1ntB6xJiZ1vh/OoZ2pzJhrKrFsH1aadNrX+j2NJ56NwrlpM2GdUTid5D?=
 =?us-ascii?Q?uuL6W3xS/COwYQ5qRT+T9Bv8E8jF+ob6jHze43vEZhnCR5r+s90G47x0WSoK?=
 =?us-ascii?Q?ecs+mJhWk4fcM8tvwPCRvnzt+R5232pTDwghfPcCmXCWUxxSK7ZCiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UDN25qlXCbAN29sDsZwzIvCYzpv+HfVvsakeb4MHT2RPGVZiP0S+9/JaCFnt?=
 =?us-ascii?Q?tgyjcA8g7bFYGYeNpYgheJ+XWDDjk3hnqvPSafC707K0/o6vSk3Xzjfq5y6m?=
 =?us-ascii?Q?YQBLfw9dKpI5mU8zSWCfXs0a5LSxBLVmSg1thXIa6kbmFheClU6xfr1cAEXI?=
 =?us-ascii?Q?f75CsuIYu4MC7dK3EytF3RmZej6VM06rrFSQ945ASIteJOt6uI9zojVVz5bg?=
 =?us-ascii?Q?c6/Zv5FbBDEvi9Xv5iAUdn9Lw1KUyJ9ylOaYD6Dn+j1iSaFJh4k7LAuipYbe?=
 =?us-ascii?Q?wI8FTk2PR/qg1EvL07WThx8NBL3+HwJeSIxQkw9k9gd+47lY6P5Fx+xtvkIj?=
 =?us-ascii?Q?97qPjSLZOio8NQuFQEJXx1OqiIE3XHJJJulBvHvVdDIwVoy0cGahZ/D0PLd3?=
 =?us-ascii?Q?eimGDwGyOfM4lTzlGhje56+uJZukX/+AYUq7qRebGj9MfWdaQJuKusvQYucl?=
 =?us-ascii?Q?RCx711a4F9zMphYP/OHVv+1BNfqj2ZAfLT1bR/AsjCdcJiCIpMadkLeTRE+I?=
 =?us-ascii?Q?xOn9mmAvh+dmkvStAXzQvqLddlLX/yXLBBz/X8I7JjphSU4Vx83fce/dmcVz?=
 =?us-ascii?Q?SjSBV3/WRoTE6oORSwITDzXbcAibiQdSUWuWHQ9ZUGVR+aZ9feWws+3bJYjH?=
 =?us-ascii?Q?Q+9KW7SzYke2t7BkLqVNPbyeqkP7BZ45POEtFizcKWDqC5BtZLh6wIyRKPOy?=
 =?us-ascii?Q?0fhl5AXYVkCfIm6V34YHsCnEliwnB0r2QlregwABxhxY7hHt2BvlJ44CmkeH?=
 =?us-ascii?Q?L+DQaD6TF9sU6Zsu2tmdkXd82ub0Pd/EOtMf0vZqg9m9W4wgO9tLBoZ0jLZl?=
 =?us-ascii?Q?WXPUQy62QbRcaWfxcvYEHyQnTa40nfq+PLNnVVpBNFInn7frfNbZrjb8N5cQ?=
 =?us-ascii?Q?FJe289SgmNkonSNY3nnzGk8CmZ2gTpRSSmCfyVgmxG5RgPx+u+jUTwNkJrRf?=
 =?us-ascii?Q?9Eor5sgYAjX+DNFCYIIETfbMpbu+cEbxpjFrl7ywBNrI50xSDO6QQ2UjzurN?=
 =?us-ascii?Q?nfL8RIQFiRyTQMqDBXLw9MVQ9cmIR6r+CwwIYCkITI0EO9+KQRv34wRWKU3Y?=
 =?us-ascii?Q?eDWOaJYVG0sT8/aLNDcsLWGC3gdV4fwuaFBD7zCr4uxsKqrdaX8ZwcWzZJLo?=
 =?us-ascii?Q?CpzI6Rkj3WMy4MNG+KXNqlD5LuX0FCXtBGXqecAbK6YDzaf3itjF6Hw1WRvF?=
 =?us-ascii?Q?j3aCW8aLeL/c9m96Hh2HLNXht+qyu+bV2Aq/ig0fEc8u3XK+J5tzY8wA4CLv?=
 =?us-ascii?Q?96Ki9vlZxIywLqf66CCp5M7j/KOL+NdfAdI8omMxf+ehhPr7+5d/Pw3S1G0V?=
 =?us-ascii?Q?KScCGsWO9zZJokoy9VyxOYgWtJ45nP1nUNFmfXNN79HO7HbECg4fynXqCsPa?=
 =?us-ascii?Q?ebgGzEPCgNdVhWSxMyzDi+d+plooBYmvThhGJHzyElWuu/umFV1HpSiP5ZuZ?=
 =?us-ascii?Q?JzNm1T9DWetVrNm/dPnehFhSMePfqqLjWqgR/MrS1hKhCn5cbj5gb+ngHuTy?=
 =?us-ascii?Q?7RYRgR1yYQyT1DjzcYPLHeyyeJH3XXODcyGK4afwO96GYb1ihkz6t+rEclxn?=
 =?us-ascii?Q?cqurCMOoR0rMG4LlQu4eD7MV3+YopaT33cz1JweT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dffb2f-ea6f-4726-7b64-08dd7e944ca1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:15:56.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNuOTUibzhSoAE1PPd2yqOA4X1Y/s9KkJ/yqD0r5DzQFMUwM3fd5jPilhlfMi7XQlzydGf/KGOMyi82EkNXKig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

From: Yongliang Gao <leonylgao@tencent.com>

When counting the number of hardirqs in the x86 architecture,
it is essential to add arch_irq_stat_cpu to ensure accuracy.

For example, a CPU loop within the rcu_read_lock function.

Before:
[   70.910184] rcu: INFO: rcu_preempt self-detected stall on CPU
[   70.910436] rcu:     3-....: (4999 ticks this GP) idle=***
[   70.910711] rcu:              hardirqs   softirqs   csw/system
[   70.910870] rcu:      number:        0        657            0
[   70.911024] rcu:     cputime:        0          0         2498   ==> 2498(ms)
[   70.911278] rcu:     (t=5001 jiffies g=3677 q=29 ncpus=8)

After:
[   68.046132] rcu: INFO: rcu_preempt self-detected stall on CPU
[   68.046354] rcu:     2-....: (4999 ticks this GP) idle=***
[   68.046628] rcu:              hardirqs   softirqs   csw/system
[   68.046793] rcu:      number:     2498        663            0
[   68.046951] rcu:     cputime:        0          0         2496   ==> 2496(ms)
[   68.047244] rcu:     (t=5000 jiffies g=3825 q=4 ncpus=8)

Fixes: be42f00b73a0 ("rcu: Add RCU stall diagnosis information")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501090842.SfI6QPGS-lkp@intel.com/
Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Link: https://lore.kernel.org/r/20250216084109.3109837-1-leonylgao@gmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c       | 10 +++++++---
 kernel/rcu/tree.h       |  2 +-
 kernel/rcu/tree_stall.h |  4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1b8eee06183c..0b0dd9e1f057 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -801,6 +801,10 @@ static int rcu_watching_snap_save(struct rcu_data *rdp)
 	return 0;
 }
 
+#ifndef arch_irq_stat_cpu
+#define arch_irq_stat_cpu(cpu) 0
+#endif
+
 /*
  * Returns positive if the specified CPU has passed through a quiescent state
  * by virtue of being in or having passed through an dynticks idle state since
@@ -936,9 +940,9 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
 			rsrp->cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
 			rsrp->cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
 			rsrp->cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
-			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
-			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
-			rsrp->nr_csw = nr_context_switches_cpu(rdp->cpu);
+			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu);
+			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(cpu);
+			rsrp->nr_csw = nr_context_switches_cpu(cpu);
 			rsrp->jiffies = jiffies;
 			rsrp->gp_seq = rdp->gp_seq;
 		}
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a9a811d9d7a3..1bba2225e744 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -168,7 +168,7 @@ struct rcu_snap_record {
 	u64		cputime_irq;	/* Accumulated cputime of hard irqs */
 	u64		cputime_softirq;/* Accumulated cputime of soft irqs */
 	u64		cputime_system; /* Accumulated cputime of kernel tasks */
-	unsigned long	nr_hardirqs;	/* Accumulated number of hard irqs */
+	u64		nr_hardirqs;	/* Accumulated number of hard irqs */
 	unsigned int	nr_softirqs;	/* Accumulated number of soft irqs */
 	unsigned long long nr_csw;	/* Accumulated number of task switches */
 	unsigned long   jiffies;	/* Track jiffies value */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 925fcdad5dea..56b21219442b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -435,8 +435,8 @@ static void print_cpu_stat_info(int cpu)
 	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
 
 	pr_err("\t         hardirqs   softirqs   csw/system\n");
-	pr_err("\t number: %8ld %10d %12lld\n",
-		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
+	pr_err("\t number: %8lld %10d %12lld\n",
+		kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu) - rsrp->nr_hardirqs,
 		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
 		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
 	pr_err("\tcputime: %8lld %10lld %12lld   ==> %d(ms)\n",
-- 
2.43.0

