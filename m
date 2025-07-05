Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77E136349;
	Sat,  5 Jul 2025 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751747976; cv=fail; b=l+DA6xHo8+ShORVT/HtKw40VjJXS5EbWozPRnIHFoZFw3mCkQLcsetBNAuqk19qmWqBVbqkNtK5SH9+tQ8itBDs96+Qgl/48GhkgNou7CFSPvmIVRMKOc8HY2ZdmcjpQomFxIBMPDX/YFOlcPRq0IALVDGCcpDTCzDzRwWchjxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751747976; c=relaxed/simple;
	bh=mSrFWvEnuvjWZ+k838NccMMICBrqdL3HRQmoHzROKBw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nHSeQ68kwxn2cRuUlkDLC5E41CsG6lSPD805zhxIt1cOD3/U8NFgVGEtwpqDT8/0v1FjyPjTNCWDfVJFTZY8TouP7Yl9X6znl9xeQ790aG1pO3Rnq0y5tL6f06NDikAMDmhPbewa9BxqyUr43pseXLUFzmOeXSmuFKjQUFFtohQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RUvwlrbA; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RUvwlrbA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBKrMnDxeJv1xEoz7o0C6M1uYxAHNzacQEk3dZvy0KJF7cKwaml3q9sZRcSbOtEE2X4UUAnWeZC+D/pHllt8DztmtDiIeJ0BddnDJZioJ5sHeyR+0meQdb5WJs+rYMO4GW8mupRf1dUB9su2MkOlxolB7T6RfbOwzMObOEbYeb/IryRsS6DJMJ1uFrqs3cqQy//SYr+zxxPOo4Q7f4NLqCWRXBcaB2zP5fOZkTJB5gXwAHgrBIY9WDtxaMy/9EZL5ivX44tKLDXaccICc9hC0SkJ3h1bGtcB1sjHHJAgc23TVYSGDZ/dizvFVsawEp5htCMQhRfYGEMLkZVIPYPPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aesYfWeB2hXRAR5csBNenPYXjUgBLRnGv969qL0mua4=;
 b=JCD3tTyXq9uybanJMcnN5VVDxKFjyr84rXYDFcHWsei68FCsyFw/GIjBoMvoiLzBpJ7cVINwHkG/ffGfGCzHQzglqSGG0gmCOo6bVe9bqw2YT9ason8zUV4QX82/ZLYyeMPGidmpqCRTu3l1RsSwq/xjSYvG3W/wy3X9i6BASGT1QgW6ZZZwX6Iq5948rX/OdytnxVcVCK8sDxgy1ZW6s9JodH4p7Smw5WDmdD/RSGQELCvPwKDp46Gh3sxoXd9PUp9+wnnmul8ZjtAcuXDKhOuxEV0pzPZKC9TMGuu0osMRXVVUvdcb7IeeumRPJRz7SAqSi+SpFnVZWnD0A4m0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aesYfWeB2hXRAR5csBNenPYXjUgBLRnGv969qL0mua4=;
 b=RUvwlrbA8vt9//dG313wvRgzFvz1nprwEkM1z1R6tNQjfxxKTraCZwGBHu1RFR77uI+Sy5OiMdDHC8BT8F7VkirP9I/dgXDXWEBtPMfjziedZb/33KsUqYmodgyl8Uc/oFI32OlZErjV89FKIJB8HgAb6s+DMvI/63RBMActKDdx5tlz8Zhxqfmodl3sfKRyR+yzh1/7vIklu2fN54Zxdn8JId/e8ab+IJ2Z6hBQp6ftNxVk2qW9/iVhFiYd12DTDo/FG6kocTWeFNeLTwoMjZTn1Qku1lGUalp6qdhdvTe1MK5X6XczaXe03iKkeBRzGOeAZONiQZzQmfppeGkevA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Sat, 5 Jul
 2025 20:39:31 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Sat, 5 Jul 2025
 20:39:30 +0000
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
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH RFC 1/3] rcu: Fix rcu_read_unlock() deadloop due to IRQ work
Date: Sat,  5 Jul 2025 16:39:15 -0400
Message-ID: <20250705203918.4149863-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:207:3c::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 858d9da4-2423-4f12-1d34-08ddbc040b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?36M5cEFz4v0M+5pTdPoYvBRQAa0Qi//AW8pSWH7zzULqPs6ByzcH5lSta3Gn?=
 =?us-ascii?Q?MKX5pmuMUNOXl70K1nWveD+TjMkAnF4n1WhZeSNqMAK0XPsLxmXO+WCc7I02?=
 =?us-ascii?Q?Oe46l3+WUrxREtHqW/0ZX3i34gKYbtxlN6v1Ydf48099tl6Eod9Xemg2Pg2P?=
 =?us-ascii?Q?TUvClnEthnJp0ZvxPUKHpu4eK6FALA1hNY+CbvYoOTtQCDFuCHz+ng/jyBrx?=
 =?us-ascii?Q?OFLfJpdB8ZDRq1xgkRKnrbUREo3l/l1Hr6ith3YReFFCVQIPxRZxBH1D6DBl?=
 =?us-ascii?Q?8sw/vXcd6jXPy7/5VmbJdOhbu00io4B4Ak9MHyedMkfWffN3VehX+x+3+mxJ?=
 =?us-ascii?Q?yJXDi110JB85evIShAgIAMmvtHg32Cm/kYebGSgd1yqHeKWPuUGsp6hK3ac7?=
 =?us-ascii?Q?TQZKKliNfJR0RZWOu2eoxMITw88+mHE4U3/yl+b5iOfOpDcEAHHmaFOhK7za?=
 =?us-ascii?Q?BP8vGAQswek7FDQFrsATpRRY+l4NsNi6OqxE3ne5Yp6fl7Na1nXwHaWafTNy?=
 =?us-ascii?Q?zb5V4hL2QeqR2wT89RfIrasEK2BBg1wjWzn1V2P+pGCSxsDA/mYvGKy1ym8k?=
 =?us-ascii?Q?E1nnj5p95O5Z/rBV9YMVEJXGoTi8wRX4PZ0zCMPwagPUgMXo+8ek+4hXRHXq?=
 =?us-ascii?Q?1fhG/qE8CPZR6dNq2m4OOln/Vg7QnJ8yDP7l8mu2EK6GZn5A1CFVpXnTXnJj?=
 =?us-ascii?Q?OLPU06D7Cr0En9Vzc16Q0FcCYQO3fGbYrTeeMJ0JGVzMvgIoBerFwBLOWdFV?=
 =?us-ascii?Q?m4W6HhokNamZhnegi6NboFWpngcNyA/KwJAYnk+GVEmopQ9Xm/eiXoaR+A+d?=
 =?us-ascii?Q?O+I3UUq1uc6v3IE1zii7C1HUL0Z6Xo1y/blFZX662kbZXoMUIaHNe3ZW2SrS?=
 =?us-ascii?Q?qYJhpYKS67DnSf2Pvhlu92A78aoYDaJ5SthiLDQqI2BKrkMyQ3l316Gii/9C?=
 =?us-ascii?Q?Lon70bdeLN19/LM7vrcDMVfv9+1EkRppc49w8IG1Pm0PltlJa0gkvzXwLIg+?=
 =?us-ascii?Q?IAAsMwn0WxqjA0QEbh/hH3SfKLCF6gkzhRn8t1ICA1327cJPcBYJPu664kaC?=
 =?us-ascii?Q?ljhcaiJtYQhOfuBQsSaWKxXdX8aSjeURrs0WY3j+1EzMFCdNQvzk9z7bCL6w?=
 =?us-ascii?Q?yowoWO53XIeYE17dmjC83UJTOdWiZOu2jo0za8iyHlYm0eLVoaoENloWjFVY?=
 =?us-ascii?Q?uV/x+ey03Ij1OIqxP12UDWqm08COrgGxOzx7TYK+04ow3wTuLKqb1ElcuZv4?=
 =?us-ascii?Q?hC0X9LXZjuqc5NuH0nT/xVz/pmst08HRbsAUN5Lc5ikHPimJupqr5d0kX2pm?=
 =?us-ascii?Q?q/C4KB3R/OreAP6iA2oQFCFy6gQRXv9rPHRHFrr+R1N0FNxdRDuiD/OYe7P9?=
 =?us-ascii?Q?F3huAg31PCKt/mjdFYW2zcx3zVG94AVIPU+IaTBV3HTt7kSWG/8YRL23eqM7?=
 =?us-ascii?Q?u4LxM0+NRtdZ+M5JD5XMCFApkZYc9yYhfTQIy2b03w01d0PAKmZEDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fLnfDODlEgL1Ra3nx5y97OGaUhEeHTWTSd626iLaArBJepbp4NfuIbO36G2x?=
 =?us-ascii?Q?yEjK1GijeWmNEqYXmc+WxCgGFGxQ92TLm66vUIyqzB9MVC7n8z4e3JbE/svL?=
 =?us-ascii?Q?d9CAzHScfiqHt4yHgAWXpNlUloYGEbB0cvQN7CIJtoEZ3umsQ8G9wrWPxwMS?=
 =?us-ascii?Q?nr0yT96ySTDBTRBRM1Ctz7izjwqzuk26Fbi+3K2mSHus2oCGIKGWr9dC7l6R?=
 =?us-ascii?Q?OMZlh0aFgSik9Lr+cvkxG4GuD5yIb11NbNBUkVb/MQECDx6okH+5Actg00fn?=
 =?us-ascii?Q?hJmn8g2dbKAzzdpYaQgv9iSXuxbZ4NK/bAkUf/wS+WK3IbGflTv/bKdSlRyw?=
 =?us-ascii?Q?lzH4Y8fFN/vXXAEQvK8WxdI9dFEqWggW3ggSPIqON0k8zHlHjS116eD84wfn?=
 =?us-ascii?Q?DLLOX6UG9sVBaIz9SLfmkaKrjlIP/ichmZFKMvbjDnB3aA3i2slDjDl3d1HK?=
 =?us-ascii?Q?aNu5d5i7qQBx1qgNrFOebXkvz1as/fUsM0Mq9X6FjJCn3zoba2Qp2lzkA3Ib?=
 =?us-ascii?Q?yFlzwYnqaW6SOhmVGv8eHUL9s7P1GQdE/iXYcAxdEn9UmhQaYkJ3AhGsp9Lj?=
 =?us-ascii?Q?IcZAm2LN5yNJzhvBkOES20CowpcC5EaYST+VCW47RyG7iud/+it7Vb+NNpAf?=
 =?us-ascii?Q?XQ/w79pZBmjbhtiIP2VabRM1e08iU+Mkm4lu2p0CL+HuKs352JULCc1sEU38?=
 =?us-ascii?Q?900pJALfjtoRErv94V3xzpShqhF9b59Q7TrfKFfcPOi6vrcgloo8ck/YNstb?=
 =?us-ascii?Q?T3RqMpvQjVvIWIiZ1Pe3h2IE89XDzoNAyryaNt5nYFwzdXaNhfcp6UfRc8W2?=
 =?us-ascii?Q?7206xK0kn4s3adCZb/gE7I4VQr66npVHOXh6k+yOA6VQsHQ1qyiIzqEFWQvJ?=
 =?us-ascii?Q?lgZE+ckkEul24Q516I6Erhsqy4kT/x/xI4XbC8LuzhFFt6RZSdc7Qm7JyZ6z?=
 =?us-ascii?Q?OhWYDg1kxdlY0RCIcMD24Fhxc4InMbjkMW4lXcmm5zQqcx/xMyYWfDMuBF+q?=
 =?us-ascii?Q?/3G7noudaNKNZIaWuwW0rTnPm9+vMHO0OzsB4+WkSQbPHGmsGSjc/QING9PF?=
 =?us-ascii?Q?CF+aHkVMSfVF0j8S7UbYtDbRAPzcxm7iP15lvNTdid5WamM62jVODuGQIEwS?=
 =?us-ascii?Q?24P2UQP5duTPWkWmdEnMFmJYS3ZLjv4kXgLZ0COJpCZXa9cQpEgiKVf0OSqZ?=
 =?us-ascii?Q?sa075MXey/kH4/wx0Pk75IvxFGPXbK00vj6Gy6Jdt4D2ZydLLyStklZZHoIr?=
 =?us-ascii?Q?f1D94O7ZAHHzU1BzVek3rJR815lG1FP1/qx7g0q4EFX5tTe4nT6Rh7pjs/YG?=
 =?us-ascii?Q?AAF4X/u/lWSqAYLZs/Hp/uliNC1OAAUa0JCMcx4TdPU2cpyG5kbqYHkUB5F4?=
 =?us-ascii?Q?z+t7VNuwu0xlKeUOZr5coThUAjK5ktSibNOLX78VmKJhS+ho7TKIC4LVEMjU?=
 =?us-ascii?Q?scVQ4PPxt4aWa1B2DFbG5FdBKD4IOXJCpCLFiVz621oZWIeT0lAu68nHQbH+?=
 =?us-ascii?Q?VchWc+gKw18AkjU5yjuQpNnBKxWGUMAkCWq+f7d+yQwZdEvyDvMAVsfGJlzo?=
 =?us-ascii?Q?9pFEEq8hwbw7k0ikL50Vw7zWvP4gnxNyqg8aiGCG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858d9da4-2423-4f12-1d34-08ddbc040b01
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 20:39:30.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rumFQ1cFfa190haXbB9rDJjsjLsTEaEu8G3ibNsPSCsUTT6WOfvU87yjhzI45s5/tHHmNjOii7veHxzKpSgeJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h        | 11 ++++++++++-
 kernel/rcu/tree_plugin.h | 29 ++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 3830c19cf2f6..f8f612269e6e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -174,6 +174,15 @@ struct rcu_snap_record {
 	unsigned long   jiffies;	/* Track jiffies value */
 };
 
+/*
+ * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
+ * It can be in one of the following states:
+ * - DEFER_QS_IDLE: An IRQ work was never scheduled.
+ * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
+ */
+#define DEFER_QS_IDLE		0
+#define DEFER_QS_PENDING	1
+
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
@@ -192,7 +201,7 @@ struct rcu_data {
 					/*  during and after the last grace */
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
-	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
+	int defer_qs_iw_pending;	/* Scheduler attention pending? */
 	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
 	/* 2) batch handling */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dd1c156c1759..baf57745b42f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	struct rcu_node *rnp;
 	union rcu_special special;
 
+	rdp = this_cpu_ptr(&rcu_data);
+	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
+		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
+
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
 	 * report the fact that it has exited.  Because irqs are disabled,
 	 * t->rcu_read_unlock_special cannot change.
 	 */
 	special = t->rcu_read_unlock_special;
-	rdp = this_cpu_ptr(&rcu_data);
 	if (!special.s && !rdp->cpu_no_qs.b.exp) {
 		local_irq_restore(flags);
 		return;
@@ -623,12 +626,24 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
  */
 static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 {
-	unsigned long flags;
-	struct rcu_data *rdp;
+	volatile unsigned long flags;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
 	local_irq_save(flags);
-	rdp->defer_qs_iw_pending = false;
+
+	/*
+	 * Requeue the IRQ work on next unlock in following situation:
+	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
+	 * 2. CPU enters new rcu_read_lock()
+	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
+	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
+	 * 5. Deferred QS reporting does not happen.
+	 */
+	if (rcu_preempt_depth() > 0) {
+		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
+		local_irq_restore(flags);
+		return;
+	}
 	local_irq_restore(flags);
 }
 
@@ -675,7 +690,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
+			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
 				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
@@ -685,7 +700,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 				else
 					init_irq_work(&rdp->defer_qs_iw,
 						      rcu_preempt_deferred_qs_handler);
-				rdp->defer_qs_iw_pending = true;
+				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
 		}
-- 
2.43.0

