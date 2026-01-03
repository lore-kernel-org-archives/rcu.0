Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5FC27470;
	Sat,  3 Jan 2026 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399837; cv=fail; b=XZ4CgS0jGZj+7oCkST6+1I0rc3pB7yJiu8zsaS2T5Vtn56OT54OL8g8Q1RmqM9zOzrkxfLWEY8FTJ0biZCPVvCBDyf7C9NnuWielI7TrwGWA6VmEBylTOMtiPAdS8cGyHhB+5zrVn/Z98I051IgtiihMK/etyOPMoG9Oc501H5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399837; c=relaxed/simple;
	bh=Pzj4yF6yx5BAQEEk8xdy9gvf3iqQZqOBNBCAdgSJW/s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=G1onOwbLx5WyN48MevMs93MjFAjjWjoVmpnb8w/hsLYIntGFHRN/aChM3nQdidPw6XM9egWZMQTbwWhtLF74OofwHVtv8uMKSHFTZbGEYoSP8cqEYTtAZLqWJZozeNg+zWHYnm53+WhFWPmux03P7nZwGZjE2jg4icXhuszug88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JBJz9E8B; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JBJz9E8B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKif8b+HoViSGcx3KZ4TtoRrWVRIKJSOsOlh7ssC2/4yJ67Af3pN6Iz10qhc9KfRzFJ2TdC4eRHfoJRrGOHQUc9/JghUwLHYKqNa5avxl833pj/o+piALx5R7g3zN23iB2Sob1Fd/8P93kWymNougW0AbV2n3S2mhbobVexQxNObnap9vVeh7Gfzy/gVvdc7At654HUEQLF1KJ+xmCYipYvkh/rD0Zjo309r9ipxVsTyW86yc4l0vCYtK+cL7+EsJYBVgFDBvOqDa6cGuhwMgZwhZNdYHSjxmA6kRNXvElJsP1yMGOmkk6HfsZs1+PMByuWGYVf8TTtVG9Sk/FU5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYCu8YVtOxyEwnOy8SjXxK7VnKQ7k3l3mEI5uGWlzNQ=;
 b=W4FVW+CBF5PYiYe5IGsn+p4oM61AJNktJjukwlBoaIXCoc/zoYjDE7SPXCL5lxE3BMBVEAnmnCt0ACc4E21g8BYxowzIKzZCojZzPhMjKOK/kz72otPqtO3Z068LZYIjG3/dk58vBBZDCjA4un+tM5uQsgIaFHWAuptFz3G5TMotPAbI3lb7EiR+CqEoZUkzGp0/OnoKd3G4lgf1T9V9znS6g9sXwQ3h7drMUnItB42/3uRGH4AHnpvzwTsVJS6b5rP6wTy7lIVF1em2HX5eMd13oq6nE76lgZRMP8dpH17vCvBlPSJZa5bp3Q8IiDkyUYvNS0mE7JdodQUejGQRcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYCu8YVtOxyEwnOy8SjXxK7VnKQ7k3l3mEI5uGWlzNQ=;
 b=JBJz9E8BcNmG8YJ7ME9UjOK4JS7UV9tDX3HVeii6vOtkzoJ/XMQCB6lJLwd0NpS1UVWBg/5Lp6S5WxLtIBCTXJ1h07xlfU7CLCduYO8eGtwAg1wnkv1J5N1VGME6BfcXsnXquoAnn7W9vfOpedSrHR7PhvB4+tY8xfiKFz4w/JCLVzpwNueVdWj13Z+nZGbgj+oupUPfEeXXBIn8Adc5AxXV9F9Twxlwc8G/ToWpc8fA8YNK5+XAL83pnAiyrWgQuZj9Kp/6i/0loQ4NcC32XciRhCUua4Ea3Cf+29S9SOl+1940r4xyMjgczOPci7ArkUF59q6gmtzQbM7kkz/bhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:23:51 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:23:50 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Uladzislau Rezki <urezki@gmail.com>,
	joel@joelfernandes.org,
	rcu@vger.kernel.org
Subject: [PATCH RFC 00/14] rcu: Reduce rnp->lock contention with per-CPU blocked task lists
Date: Fri,  2 Jan 2026 19:23:29 -0500
Message-Id: <20260103002343.6599-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2f7a7d-54fd-4cc7-ba60-08de4a5e5e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IDZ0A15WsZk+bPr5nKeGjW5cW1L+m9V6JLVXomhVxIBXOIdBxE/ufOfbJws2?=
 =?us-ascii?Q?99uF6sBt5ZHY+91ObmFEwW5ynyGBW2EA7U5lUxMVvt2db9q2VTOOK0C4P/2k?=
 =?us-ascii?Q?uvONdzhJ48xbEvqlC8skDlEO92+VZ/rbifH1SdPSfwNZBnm3JXivFOh9NEty?=
 =?us-ascii?Q?rqLOTueodr0I4QLVH5PRDLU3ZmUQx9IEFMJuxldGycUmgwyQIIw5EZ59L2HJ?=
 =?us-ascii?Q?fKkEbZPJGVxTSrO0PgxywgsA/cONObpa1auUsznvDbgbzhMK0NRFVpQE0vCJ?=
 =?us-ascii?Q?VflwpmyByjUV/ToGid0EZydOei9wGt3B/J5sCJDcSBLr46Ix5lodp/OTyrKP?=
 =?us-ascii?Q?aTU7lR5DOOcQL1wAg6VG7MIktNFXAXhVh8ggL5HR0TJIwpeLuf1m2M2Cp13y?=
 =?us-ascii?Q?jSb9a4DVQLrAbD5ui4flsFo/aDqv+f1IWIGO5cGu5am7QHCT22CcMo7kNvWL?=
 =?us-ascii?Q?xEwCrnNPMtpze37AEw11TCGJyJBRJAjeZa0hapy0XCXXO2AKuhvayA4SEMeU?=
 =?us-ascii?Q?/diDAL2Daf1MVeVHfktQl+Dc7EsfBt4GAr5kcgmcyik9FtgFi27U8MOoaP06?=
 =?us-ascii?Q?IOlyDSDHj56S/FGfKMJnfW6og8SpTS4pw5XMREDUnAVLNgJYrK7v76Coa5/U?=
 =?us-ascii?Q?heyNRv9DHsPibb1s6HaAscniMa71PxILM0wo/TvhMJNNwjBhVh+ucK83moSv?=
 =?us-ascii?Q?TeNjzrnji1JKDLVc8hwwl4WK5cxwBUKxVC0hzksn9x++IszW4gtwyRth0Nxw?=
 =?us-ascii?Q?ZhgkIyvv3glni68xza1DRJU9iDrh/uiV4p16TbNrezceAwqYtwRSvCD/Jqz0?=
 =?us-ascii?Q?Zt5NzpqGovz/vhktRH4OV7Od3rUi1Sc2c0+zupUoqoIsVA+UIlWraCc5buBU?=
 =?us-ascii?Q?Hcsw4H2Yue3GIVd+bkzgzLBZ2kImlXKX1iejXY32mEVcB6hopcavC1ivGFOS?=
 =?us-ascii?Q?+gRAhoaWENF8jiMWjJgimcXki68LOLgilGRv86PslYaeYTAi06kWMoN0z5/u?=
 =?us-ascii?Q?i9EZcrTCK3jxV3q4HFovefujuebxvIwHkr7f9FFAsPl9UOw9W1Hy3SrZYf8d?=
 =?us-ascii?Q?+MFvPKlm/DQLYiMciC/51IU/K93QtiWqFq8rCMoWXJMtTgTEKZT+ABR9pMYb?=
 =?us-ascii?Q?98pe8YNFMZAjrKkFqdYkOObREE3Ev5V+GFcctrPEn25GSWDF/Ye1Qadwc3fA?=
 =?us-ascii?Q?sVWgK9YfkAeuxH+Za/+vGEM/kleLc+6FoFPt03BQUbXQuPIetqmCLA8FhLOK?=
 =?us-ascii?Q?Pm033MEFsYn6Mip5EE0e8y736YZV3Olrf5g/QoxEuuzik/pBoL7kwBU8b/l6?=
 =?us-ascii?Q?2G6X33jNNOO76YUhFwFv6sWqkBrtnHoSpleWieHOgO2HESe1imL9rYbnesKL?=
 =?us-ascii?Q?TGLMz0vN7OBaZgixh9dLOJSo2uu5Y0ySqSJx5YMd+GIBcPgoaG2xIILp5h4V?=
 =?us-ascii?Q?8MquPilPHPmC/k3UAzzsVFIkkCqcIBUIXUs9rsz4ERPlDafSFsVXqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KzDMD9vV5phCG5wQH8uXVS7O7V2Z8DbJvKiCsKIJl7y8gVYdbryqP3CDsZKg?=
 =?us-ascii?Q?ZgyfKtYfs4y23PaI3wdr+8IcfpX14RfjKhfpGTpkp60FlMECGdSlsOtLcksf?=
 =?us-ascii?Q?yDJm1YNpdU4j9xDzjuN6L/3a8BKdvoQqukqqWdqdXSWEKbrf9/PvoAluNfgw?=
 =?us-ascii?Q?SnTMTUnl2BONi63QCh3rUHP7nopSyMunG0llT0ith8G2UEfubLi5iLShetzb?=
 =?us-ascii?Q?Itf7S/8cE2zEuggmvnUvOj5Axh0ZCD+iTN8+1felKlr5UVpoN+Wx5EenYw9G?=
 =?us-ascii?Q?TwcXOTTlLDxOfwL4mz9saDxiV5D0Xg1XvTws9hnVzTOW9f6f+KAnvGrxs0Ks?=
 =?us-ascii?Q?RQ857Q/H7F8lnw6tU9DuiE0fmwFI2/LaL2JGOdmIdnXDK6TwmMqB/tgaeQnK?=
 =?us-ascii?Q?xppaLJA6kvW+F0b9HBBHcDsPbcZ1S4jeiac0RIOoCbwpCiQPwvOmKGoUMNRV?=
 =?us-ascii?Q?V7GdW/jOMA7cE1Hg+5rqmIyR+oPR7+5IMp1Md4dbX2x/Ggcx5Mm4Ycggm6dV?=
 =?us-ascii?Q?+b0UDtiQPospBITu3VL1K05qEujY0XLdn5DbK3CYKmMhtbKN1gjE5jtStG0I?=
 =?us-ascii?Q?WKz7sUVYvN6SuL3U1lATUwy6OVxVCMsrzbJCcy4Lp7i6AyjFe8lo7wlnGxnX?=
 =?us-ascii?Q?Qeh0FNVjOjOCVdmIY+t88tZjhXVhLik568Wqx6iP/VKKoTLHxMKr7HfY5uvA?=
 =?us-ascii?Q?GQACpE2TRj7W7bZBZK0TEKqOnkpEdkZSAvDmVXtFiiaFtSnh8BkgPWUSVUrW?=
 =?us-ascii?Q?kDu+k0yzeAQ+oCUnro/IDeQ3MA3T2M7anafLC6gNtSKhKLHJ76AAA5IPvL4D?=
 =?us-ascii?Q?EMMOUpIvCt8dkJpxxbEpz/ER2BrhMAuyLARCiXck/SZTuwEOaYgfQ34bu1xo?=
 =?us-ascii?Q?PcJvV5DbysNskSGc9E2muE5vphHa4gyjv7IXwW1xaMEf3PYl9E0DWwJQlYsj?=
 =?us-ascii?Q?iQA1/je5riRqkYAUFIhlGJZZTjZuyaIByIaL7wIDA2AI9n3qc472fNSi56Eu?=
 =?us-ascii?Q?KHeNTrHZj2hQs9kiZzkNQQaPEpmKN77JFyAVgcZszRfTl0vs7ydaOFO7RUpr?=
 =?us-ascii?Q?xOSJ4Lsv1wUU2e8TKePLW0Aj9fSkV7LBFvfEiHLKMtIdKa6IdV/ASFIevUic?=
 =?us-ascii?Q?Sq/tMhS5UwH/018eaQXhGvGYHmyR5W90SJHKDH3BMDS6jQPlIEtDFDRoiNeV?=
 =?us-ascii?Q?0vQkPyN6ria4UI7nQx83jT9bQ3D42F7nvjJJ2aZJzMM5iz+v8f+WyyJFdi9d?=
 =?us-ascii?Q?8Fe3/Cr5cdpWLblB1Hg3AQdPCCWyPWWYbnRkdQcuKxJA1ECAv8NVNVWkAe+Y?=
 =?us-ascii?Q?YJIDGSSUnjBGzY7wizSifgMYo38ovzQED64ult3Hk5JszuBLa201t/2NK2mW?=
 =?us-ascii?Q?xAbHBByBeeoAMYrsXeVX2AoRBPdnvrqCM4Z0zzgxB7j+7LAY4m+gqDrm16We?=
 =?us-ascii?Q?xsCxUWI/yASasOSNbmTBmJVgbrlwRqSyngSGteXEMC+bEYuaag9yvyK7dNPr?=
 =?us-ascii?Q?r75mUXVtqtyGl/BzPbu8WlV6AgsEl+PxB63GHFuWp8cp/cijW9RbVhP3XLkB?=
 =?us-ascii?Q?4/6aKWqeyqAAYgIoDtw80trOo31Go/vLATVXHWw4WGEP6G9e1KQkBa2ArcvA?=
 =?us-ascii?Q?G3dGtdxdemNcMSY/BUwpilwYsoQZIjY4gVqBN9eGWhm4xDIUKq/TCdiEyyEb?=
 =?us-ascii?Q?ImSlL0Or+y7FJ6B+mCd/wOaYk9OIovKJash1lAE2RP4hi4xb9Ud0ebzKUCJA?=
 =?us-ascii?Q?s/xHcU+3pw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2f7a7d-54fd-4cc7-ba60-08de4a5e5e93
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:23:50.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zq2CIoxLoBheBzonOrTNgns3WjM2UIxBD1lPmD9edOwfS4yu1gsLyLiWMKPeB7HLci4tqhia/UTQdS21CgZSng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

When a task is preempted while holding an RCU read-side lock, the kernel
must track it on the rcu_node's blocked task list. This requires acquiring
rnp->lock shared by all CPUs in that node's subtree.

Posting this as RFC for early feedback. There could be bugs lurking,
especially related to expedited GPs which I have not yet taken a close
look at. Several TODOs are added. It passed light TREE03 rcutorture
testing.

On systems with 16 or fewer CPUs, the RCU hierarchy often has just a single
rcu_node, making rnp->lock effectively a global lock for all blocked task
operations. Every context switch where a task holds an RCU read-side lock
contends on this single lock.

Enter Virtualization
--------------------
In virtualized environments, the problem becomes dramatically worse due to vCPU
preemption. Research from USENIX ATC'17 ("The RCU-Reader Preemption Problem in
VMs" by Gopinath and Paul McKenney) [1] explores the issue that RCU
reader preemption in VMs causes multi-second latency spikes and huge increases
in grace period duration.

When a vCPU is preempted by the hypervisor while holding rnp->lock, other
vCPUs spin waiting for a lock holder that isn't even running. In testing
with host RT preemptors to inject vCPU preemption, lock hold times extended
from ~4us to over 4000us - a 1000x increase.

The Solution
------------
This series introduces per-CPU lists for tracking blocked RCU readers. The
key insight is that when no grace period is active, blocked tasks complete
their critical sections before really requiring any rnp locking.

1. Fast path: At context switch, Add the task only to the
   per-CPU list - no rnp->lock needed.

2. Promotion on demand: When a grace period starts, promote tasks from
   per-CPU lists to the rcu_node list.

3. Normal path: If a grace period is already waiting, tasks go directly
   to the rcu_node list as before.

Results
-------
Testing with 64 reader threads under vCPU preemption from 32 host SCHED_FIFO
preemptors), 100 runs each. Throughput measured of read lock/unlock iterations
per second.

                        Baseline        Optimized
Mean throughput         66,980 iter/s   97,719 iter/s   (+46%)
Lock hold time (mean)   1,069 us        ~0 us

The optimized version maintains stable performance with essentially close to
zero rnp->lock overhead.

rcutorture Testing
------------------
TREE03 Testing with rcutorture without RCU or hotplug errors. More testing is
in progress.

Note: I have added a CONFIG_RCU_PER_CPU_BLOCKED_LISTS to guard the feature but
the plan is to eventually turn this on all the time.

[1] https://www.usenix.org/conference/atc17/technical-sessions/presentation/prasad

Joel Fernandes (14):
  rcu: Add WARN_ON_ONCE for blocked flag invariant in exit_rcu()
  rcu: Add per-CPU blocked task lists for PREEMPT_RCU
  rcu: Early return during unlock for tasks only on per-CPU blocked list
  rcu: Promote blocked tasks from per-CPU to rnp lists
  rcu: Promote blocked tasks for expedited GPs
  rcu: Promote per-CPU blocked tasks before checking for blocked readers
  rcu: Promote late-arriving blocked tasks before reporting QS
  rcu: Promote blocked tasks before QS report in force_qs_rnp()
  rcu: Promote blocked tasks before QS report in
    rcutree_report_cpu_dead()
  rcu: Promote blocked tasks before QS report in rcu_gp_init()
  rcu: Add per-CPU blocked list check in exit_rcu()
  rcu: Skip per-CPU list addition when GP already started
  rcu: Skip rnp addition when no grace period waiting
  rcu: Remove checking of per-cpu blocked list against the node list

 include/linux/sched.h    |   4 +
 kernel/fork.c            |   4 +
 kernel/rcu/Kconfig       |  12 +++
 kernel/rcu/tree.c        |  60 +++++++++--
 kernel/rcu/tree.h        |  11 +-
 kernel/rcu/tree_exp.h    |   5 +
 kernel/rcu/tree_plugin.h | 211 +++++++++++++++++++++++++++++++++++----
 kernel/rcu/tree_stall.h  |   4 +-
 8 files changed, 279 insertions(+), 32 deletions(-)


base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
--
2.34.1

