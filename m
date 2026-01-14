Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D62D8773;
	Wed, 14 Jan 2026 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411945; cv=fail; b=dn0oc0KczreU3hBOzSTqUi9svjMFyRz9B4575p45l0jyGAISBaGm6jRz1tAHsStM6PbXTFQC/4NLH09HkG0LwqWiBi27E/3OZ4aI4EBv9PH0oKmp44ywsLK8AijUP7RWo/lRx6RQtZI3y5HLJO+z2eDp5Nak67XVipJ3cl80t/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411945; c=relaxed/simple;
	bh=2yH+9PlEA3wNuVu3XYft/zNSWoMWYCl19ndl8t6Pchc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y6qK0c1icanA9ErFQjJFRcy2B8uJB6py5JYZcKPDYDldGOjPTsdTQ/tSnkpnJZMNy45C2FQZb/OCgAgNtqoLks6DsVQwrsB3kmpn1a3qdE/AsLLFVRPv8USlnIDdSq1I/0I71Id8e6lJLL4gpfkc9+oDRL1YCCI3FYU2Io7nCe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=moBCWqK0; arc=fail smtp.client-ip=40.93.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="moBCWqK0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aT65JqlBUpUq9ip2cYKSV3BrA9aCQTI9dXEf+gLv/HN2QFzCZq4+1bufBLX/O3H92QMARa2NNPq6apoe2BjF9R6Q2B3PvzKWIQiWApvFxl270W5mbSpIfLG/INbvD+vOZXWIJpiVJCS2Ev+A46C3WX3sB/3mvJXU6Q5btXIiOGFW2aKTmV2w991I4OoIiiwHntMJBRmO8AsCFZHygPHAv1I7VhvSSOySVqGlWFXE03mXo2WXiGmbZo7EntqRSWBj9lt70vz0KpJ0VmutJy4buPsx7ELif33kztMYmaduehc2bJRyCcV2/wgmM7/jkxcdRM/kH1e/cgq9C2qxozqhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiewt5KDQd03EfZt7eVCzVtWfx6E9Z08LVGCqnNEw30=;
 b=AerlS8yqyYurLjfmme/IhpPofpGKM1tS/iTrZtn/cGRVFy0GfWsSnpx9WnVlXdaqbf5UPrGFXnaarNRBz42qUyUsyrhasM+4EnS4fNGn8tkLW7gBvFgPLjHa0qZITtx+Hv29Nr+DCeF+DlT/HBMqZWkQD0iEgHE0dVgtnJwEFaGc73IpFDWFuMg3MBrWljfTQIh4R9s7vDD/jhIny1fDTrcOVO52SLL7wLLL+vWZF2Q4gAORTVFedXI1m1PVCTCM7B+pwFZ6TcZI/sFhuGaJadxwt9iblCqcNxsbCc540cNxvPmPcogELJs1MINn6JpVnKVgPv3YDjgF8X73qEwGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiewt5KDQd03EfZt7eVCzVtWfx6E9Z08LVGCqnNEw30=;
 b=moBCWqK0OgKL/esofzYba/eMx2muAc8pVcThpRH4xC+AhrR5lmUdr57LouMZpI/g93SJuIxLSIBQyoEVZeHT4X4coJBjXFbYCVr7CDEJFmnSbQ24808NAccUXl8yhWYe3gzk3zM4kkAEHLV4HmxlcswJN69aypYcjmMxUWShYnxlcepO+y0Mp1B8sdJ+TR998ulxSxG0smWYp4zkGG8m+EwvQTJma32guL1qMVVbqDqcRPt2ezW77xYTOBmmeeRAEUHQyu9Qm8nX28zxgb1ib+kauGJ+nMK1x9jwAEhRzj64I+WEHMJAH2hY2wYVAimDZcwM6xfZQch60Z4BK4cSFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:32:18 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::f071:99a4:121:353a]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::f071:99a4:121:353a%6]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 17:32:18 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next v2 1/4] rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
Date: Wed, 14 Jan 2026 12:31:51 -0500
Message-Id: <20260114173154.1701056-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114173154.1701056-1-joelagnelf@nvidia.com>
References: <20260114173154.1701056-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:23a::26) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 85df0f9c-d7a2-43d1-a13a-08de5392dd5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FKWcwciflQ5ycyeuPYudyFbhuG+Nsk/RW+ED6a3Cbf99yLH/3ebdjXYaJisT?=
 =?us-ascii?Q?nYqi6NiJvmsUyx4E7FOF5T96jcfm+vJo6YmHaaMIC3XSHhYNOxGHsHxFRIAS?=
 =?us-ascii?Q?sgcctlUwWCjHiczBxl1bqgm+RXR03nMJPwxqrWF1Kz7PDgbFjowHQBlB9j8L?=
 =?us-ascii?Q?0WV/d+FTicfV+7BuPTOO2G9r/up5Fx3B8avY053+7OKwA0iswHUvz3gU0onA?=
 =?us-ascii?Q?WR6SrKvVn3bGO852UZXQ9hoEVJ+7+syg1eLZVq/SUE3rachUq2aGVgrlCqWw?=
 =?us-ascii?Q?c5VLJEUvIFfDy1kpP1d3LvdkZpNKZSJIcsHn6+1aN4SToikD8TQzSsWBbl7Q?=
 =?us-ascii?Q?p1lpq04CccMmQfG/Ri07W/Gb8H4hMWAzb5pfOs2HU7wNtTYYeiI9mQTqf/sc?=
 =?us-ascii?Q?/u2v81RCYQPaR6iUyBQT+Lrst+KySEyHPbP5qGJWX20xkWftiBnTci/ip2xj?=
 =?us-ascii?Q?1VbePuJCE+nz8kRvkj8VnJ2Oi/1t3EkTIN7VE6TXVShNaNVY4eiZSWZo9mIF?=
 =?us-ascii?Q?34VB/kgaqynsMshzS7IZkbXWZzexpU2trfGM4G3hnZQro4fueVE7it5QSBIP?=
 =?us-ascii?Q?HPO2qytsfAlS0BHn4SZM8SotZai+pzhkOp2JmuT4715+U94kTAUYCFcI9KJe?=
 =?us-ascii?Q?fTLc/s87GLopERMEH53OrwvuU2KhOCn3MM79/aeavD9ZbXhDMsONiCm0Qa4t?=
 =?us-ascii?Q?kBeQiJnrf0+mHEYR223poqfGzmbYS/yWBFfzevNPJRjaKya4TpoyvT8Nt/YN?=
 =?us-ascii?Q?5DKCZeoMx05aXERzPwpmrNrE0oTKbd2ZuUvgPC64PhW0QQ9On8pxFSWWegtX?=
 =?us-ascii?Q?UsoHQxvNYRf5fjB4xeD0rOGZXdh7n1tt813dtGuclv3MF3Zn1DhdG9p2ANq6?=
 =?us-ascii?Q?HvR50v6/bruaIGeMrD9ZF6ID1bvScSPNtj0cp4jg7Yd8UWQGATYvN4bs0lgT?=
 =?us-ascii?Q?LXGIR5ys7dSoM2hzgmuVqIz0fr3DfnQy7BHDj5oTrmRSOzWrYQaomGAlsim0?=
 =?us-ascii?Q?zpWjiPo8FKql3jH6vE/M87TKo01SzMGBOu9FzZzAkhq4oh7j2f//Mei8eRz1?=
 =?us-ascii?Q?LyUMBeqloCk/+4vypRWfGQYXOEJYBYq/yvMWjV01gX6fSiSnslAfB7bHL7Zp?=
 =?us-ascii?Q?CQhec2n8HkYVtS5AM5JwxoUcqCkRoPEuBFBzluNqV29C3TmSYFKwy1GZxeOp?=
 =?us-ascii?Q?4lm87fEZK+KqQqWm0JXYdsSrYFg9lWp3E5FX6HD4kxD41KjlcDIY426cJeug?=
 =?us-ascii?Q?Ljxzg+ypzO7FjF6Bg3yt2Yfq4m2n1+9UQnXYfg2RR06B0WiuEq5bArfLTRCG?=
 =?us-ascii?Q?pIyGYNlRLTRS6s+ySPYg0k4ErIXRKmfxKeG/XwibMQBGJP4/92zCL7Y0CneC?=
 =?us-ascii?Q?BDJpUyq9Bf93M7cNwVD/lzXVQ1TpW4inlfFZLYy1xO31/Q2IR06WDO44YZ01?=
 =?us-ascii?Q?gk77nyUZ3jGul9CO7N+D9C/hnCgHY3TdasrYiufXyvwd9MHQmfA/hO0Y/lS0?=
 =?us-ascii?Q?8Adm9gNiQILhsVi+zAQRJfPqlw0iEQAjm7mqswEw+oLYMqhKWM2gcDmZKQKP?=
 =?us-ascii?Q?Z1WkLaf+v69I2Msadqs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+EYUcMjNNp4mWahsLVfLWTTlmwobDdl9xzHBli0pc8ttAt8LrQc4REu7//n6?=
 =?us-ascii?Q?MH2L/ESk95X5sPPlevFOi7vGKTpmc6114WQoFGP8IgcZDg89GPoNamvXksI8?=
 =?us-ascii?Q?ZsbjM65KLwQQeVRCO3jN12+taClI/V6NBAMIZ9J3OYbULjY8hM0AmHsrMO4T?=
 =?us-ascii?Q?td81gzo+itYMJk6fmiRXZYJ8Of8445xnWRh+tlXTwyjMvAL6iJ8iktqsrD7V?=
 =?us-ascii?Q?uZDb9ighbZ0TKVDbZZdwPVzStdDPg8Iz85WNxEm2lRu06Pt9vjKXdkU4Wfgq?=
 =?us-ascii?Q?BWa4jFV+FiKpIeu4P139nxO5ccFGa+8MYatL/EuWIOs8HJiFZAIzohbNhU62?=
 =?us-ascii?Q?Kn3/mlUfLLkVe+cH4yIzIr7Dd10hQDg8/YxLSgA1AYxFzjrP5LFNsxz1H3Im?=
 =?us-ascii?Q?QmxRnYBt24QKrW8n611SqLWQ7XPFfbhRD6kpx9ah6fN8yCLoBBtLIUj0isvv?=
 =?us-ascii?Q?BtGWlHPkkxcUqIBUFWcX7lFpLFrXw1V6RKWTdH6zqZ3piT0aduqe7AZp9wkv?=
 =?us-ascii?Q?POZwLDRohXGLDMAqP4o+60Sp0GwQDDdf9GIClKnP1tAmgnHSeWRU/5hVKWPx?=
 =?us-ascii?Q?1MahJ4l9eGbxjoh/nEVdOPioJhL1hbyWb+zpvIsAW0owbje15vR08sTC55ag?=
 =?us-ascii?Q?OvMly24ccDvvYDZsX7WACRIT4M/J5g88OLPkVGi0vhwgVuAANyXR5H+bicR1?=
 =?us-ascii?Q?PC/cYS2e48x0MVh3E2etU4qeKmN+2PtagNZAgv5uH5Oa+Y4DxgCMi5n7TDff?=
 =?us-ascii?Q?LFzQzDlG81GtKb7UYkHncUhaRqJ8THPg09S6Z4E9Bivt9hWRL1TnyboAOIe6?=
 =?us-ascii?Q?4sQq7H+kee1kkF275WKGI5vK0gRoBkwl/EynmjIh8aMpDralwRtviQrZ505C?=
 =?us-ascii?Q?6UpTxU+0L7nEBQaXszxDpKPoRCmQDbIqQ0gordz6NzlvJ5ddzdUHqZ9Opmx6?=
 =?us-ascii?Q?PIKkCUBRqDpEXpNk51OQcThGcZOVM6a/ydx6gUoyA5zZgdW+51zdRe4LIQR8?=
 =?us-ascii?Q?0Rg7xPPssAek2K3ygjocoSGAm+ZPIavkE1p7JgfgL03ZrHjJytWdW9GEhZMd?=
 =?us-ascii?Q?cbxd1k9icPdEvTotx2Oxry4fnJ2o6i64flJhbK0mRhWTPscqq/m4Fq/SDxtb?=
 =?us-ascii?Q?AUFp17fJBFLZ5/Ld3FpvzmAxUFq0PUvz1or8vfHkdqIhekPR/VrstA1/BUHX?=
 =?us-ascii?Q?gaWC7YzeZ70kqzTj48d5FdoznidwqFwhk2+054Vyhm5g07mvd6D3nse9Kfal?=
 =?us-ascii?Q?q21rhOAA5Gb6HxVJ9HGxHCld54g/HAz6jnPy8ViUqy+ojiuhdj2ft1gqYC++?=
 =?us-ascii?Q?GeEsoXw/NJDuzikWk/0WQ03ynUWlhYquYUCKT625llqCymbdUJTjWV3q1ISJ?=
 =?us-ascii?Q?iT1YPX9NeQhuuI6x10dlbUPznkhOJKIt9xclw4iVVM1GJzBJAzeYLGG+bLx9?=
 =?us-ascii?Q?ymBM6l8gh/kZeqe6JhvFcVnf7kZUtVbCwXqWAYKi1q4SnePSpgTI6nRXjRIZ?=
 =?us-ascii?Q?dsvTJo4nIFrtVSgK2JIs46SJHVULS65YLoBXNfuxpRV+DPpC8VCyccblMiMs?=
 =?us-ascii?Q?GGNHWtWv/qgdWy9VKldE88/SldMjDptVFgtSwvAbkC0C7Wq0GnLa79Ibg8qM?=
 =?us-ascii?Q?sX9r2CV7pfSOdxe0y+6G7xtjpi/Hg+tRRAJBLzn8yLV3eQGy86uJ2BSxwPnN?=
 =?us-ascii?Q?2hIPnhHoC7zJzYbarJaFEcftpSdAkpDLEfzWfXfLt5zdTp7ZHsJk9WSrMFHw?=
 =?us-ascii?Q?f06QqHPbRw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85df0f9c-d7a2-43d1-a13a-08de5392dd5d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:32:17.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1Ip9+e+qDzLJbbc3had+IoxzAtzsI8snHjfRtDBKNLnydbl3yVjr7X1iMikTflQPWeEaEpmOE1J44wVaoLFgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

The WakeOvfIsDeferred code path in __call_rcu_nocb_wake() attempts to
wake rcuog when the callback count exceeds qhimark and callbacks aren't
done with their GP (newly queued or awaiting GP). However, a lot of
testing proves this wake is always redundant or useless.

In the flooding case, rcuog is always waiting for a GP to finish. So
waking up the rcuog thread is pointless. The timer wakeup adds overhead,
rcuog simply wakes up and goes back to sleep achieving nothing.

This path also adds a full memory barrier, and additional timer expiry
modifications unnecessarily.

The root cause is that WakeOvfIsDeferred fires when
!rcu_segcblist_ready_cbs() (GP not complete), but waking rcuog cannot
accelerate GP completion.

This commit therefore removes this path.

Tested with rcutorture scenarios: TREE01, TREE05, TREE08 (all NOCB
configurations) - all pass. Also stress tested using a kernel module
that floods call_rcu() to trigger the overload conditions and made the
observations confirming the findings.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c      |  2 +-
 kernel/rcu/tree.h      |  3 +--
 kernel/rcu/tree_nocb.h | 49 ++++++++++++++----------------------------
 3 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 293bbd9ac3f4..2921ffb19939 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3769,7 +3769,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	}
 	rcu_nocb_unlock(rdp);
 	if (wake_nocb)
-		wake_nocb_gp(rdp, false);
+		wake_nocb_gp(rdp);
 	smp_store_release(&rdp->barrier_seq_snap, gseq);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2265b9c2906e..7dfc57e9adb1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -301,7 +301,6 @@ struct rcu_data {
 #define RCU_NOCB_WAKE_BYPASS	1
 #define RCU_NOCB_WAKE_LAZY	2
 #define RCU_NOCB_WAKE		3
-#define RCU_NOCB_WAKE_FORCE	4
 
 #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
 					/* For jiffies_till_first_fqs and */
@@ -500,7 +499,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
+static bool wake_nocb_gp(struct rcu_data *rdp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e6cd56603cad..f525e4f7985b 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -192,7 +192,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 
 static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 			   struct rcu_data *rdp,
-			   bool force, unsigned long flags)
+			   unsigned long flags)
 	__releases(rdp_gp->nocb_gp_lock)
 {
 	bool needwake = false;
@@ -209,7 +209,7 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 		timer_delete(&rdp_gp->nocb_timer);
 	}
 
-	if (force || READ_ONCE(rdp_gp->nocb_gp_sleep)) {
+	if (READ_ONCE(rdp_gp->nocb_gp_sleep)) {
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
 		needwake = true;
 	}
@@ -225,13 +225,13 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 /*
  * Kick the GP kthread for this NOCB group.
  */
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+static bool wake_nocb_gp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
-	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
+	return __wake_nocb_gp(rdp_gp, rdp, flags);
 }
 
 #ifdef CONFIG_RCU_LAZY
@@ -518,10 +518,8 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 }
 
 /*
- * Awaken the no-CBs grace-period kthread if needed, either due to it
- * legitimately being asleep or due to overload conditions.
- *
- * If warranted, also wake up the kthread servicing this CPUs queues.
+ * Awaken the no-CBs grace-period kthread if needed due to it legitimately
+ * being asleep.
  */
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 				 unsigned long flags)
@@ -533,7 +531,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	long lazy_len;
 	long len;
 	struct task_struct *t;
-	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
@@ -549,22 +546,22 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	lazy_len = READ_ONCE(rdp->lazy_len);
 	if (was_alldone) {
 		rdp->qlen_last_fqs_check = len;
+		rcu_nocb_unlock(rdp);
 		// Only lazy CBs in bypass list
 		if (lazy_len && bypass_len == lazy_len) {
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
 		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
-			rcu_nocb_unlock(rdp);
-			wake_nocb_gp(rdp, false);
+			wake_nocb_gp(rdp);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
 		}
+
+		return;
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
 		/* ... or if many callbacks queued. */
 		rdp->qlen_last_fqs_check = len;
@@ -575,21 +572,10 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
-		smp_mb(); /* Enqueue before timer_pending(). */
-		if ((rdp->nocb_cb_sleep ||
-		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
-		    !timer_pending(&rdp_gp->nocb_timer)) {
-			rcu_nocb_unlock(rdp);
-			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
-					   TPS("WakeOvfIsDeferred"));
-		} else {
-			rcu_nocb_unlock(rdp);
-			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
-		}
-	} else {
-		rcu_nocb_unlock(rdp);
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 	}
+
+	rcu_nocb_unlock(rdp);
+	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 }
 
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
@@ -966,7 +952,6 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
 					   unsigned long flags)
 	__releases(rdp_gp->nocb_gp_lock)
 {
-	int ndw;
 	int ret;
 
 	if (!rcu_nocb_need_deferred_wakeup(rdp_gp, level)) {
@@ -974,8 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
 		return false;
 	}
 
-	ndw = rdp_gp->nocb_defer_wakeup;
-	ret = __wake_nocb_gp(rdp_gp, rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
+	ret = __wake_nocb_gp(rdp_gp, rdp, flags);
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
 
 	return ret;
@@ -991,7 +975,6 @@ static void do_nocb_deferred_wakeup_timer(struct timer_list *t)
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
 
 	raw_spin_lock_irqsave(&rdp->nocb_gp_lock, flags);
-	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
 	do_nocb_deferred_wakeup_common(rdp, rdp, RCU_NOCB_WAKE_BYPASS, flags);
 }
 
@@ -1272,7 +1255,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		}
 		rcu_nocb_try_flush_bypass(rdp, jiffies);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
-		wake_nocb_gp(rdp, false);
+		wake_nocb_gp(rdp);
 		sc->nr_to_scan -= _count;
 		count += _count;
 		if (sc->nr_to_scan <= 0)
@@ -1657,7 +1640,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+static bool wake_nocb_gp(struct rcu_data *rdp)
 {
 	return false;
 }
-- 
2.34.1

