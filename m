Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495221930B;
	Sat,  5 Jul 2025 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751747978; cv=fail; b=fsT14j7oevEPJyI5oPHa3QUwldgjZ005acwbCLq1d9MUNISegtLVq1y1Iqmg9qNvoxZ9fgzWD8wfz3ol4OoxpW0e7VDqmSsWZl5nLuy0NdfBCPLAgbTFLzgdZ+lKTjUP6kyDu3VeATVMjDtwTPyihGGOu2977ou6DQIi/ulcPJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751747978; c=relaxed/simple;
	bh=EURcSphSLSKMHfCdwDjdDayAHgabe/X+AjiBKLlfLkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KETg6fql/eqM//c5BvwuRlSCXTr+WVlkuFG3vdRMf3m4wVES1iFtHHxPk+xmAnEf/+QUGsJIp5QEAX6CZfNDtFpCf2mVbF3PfEdrJel3GmBFWRNxl4myBWIL1lstUYl4mp5LeBw0cJayPa4S6sVJa1MjGOu6Tu/s3Zdq53sbiss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJvpdatj; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJvpdatj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRhBO3zYEpoWR/e8ZQk2B6UgyoGbpv3EJoCuNE/eAaiaR9T52YuoYtDyOgEDfV+eIdjMXv1CxmpL2adf3iMxOH2+VE4A8LkKZjBiD0EFqrULLxVPXYaZx0U6GvFUx3f82WUrytBV+RkqIv/lI1JSmQDTwmkO9L9vgwuGcmzJyjrCGVdN/ZtN/XhLtrlHLs4+jgBIL9ENrtCtyq+ZsO0T+//h1yBQrJUsIkLKGGLHMunDDQdLxSQKBu/IacVQm6hDcwFuocrE8ec8Df8oDqZCCOACbKykckdKVGbQMyYrYK+22lEJ6982B0WuHb1mLNluRyBr3v/qzzO6dmjPw4lmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpPzq7Ls9yhwdyknEN5XxM2B7V8dP9yUScnlcZayAgY=;
 b=R6Ktw2bhVNDgdRENXlMXf+RIWiOtutKlfgofO/NsreOtim0ElgtmaaIT9+gHWVpPGaIcWU69mIzKQmouhHdIQPZErgSd6tYxg8qZTBxyVcze+oLRTlteNKJdsufKovn6BKCBz3s1AxXQcPLbXz7V2esDQ6EhrC2Mt5vZ54WYloh5Rm/HgbMPI/vKZBEUIiUtFELF6f9ORCeN2hjA9jl+e+8Hvl3eBXSZxmBSoUEhIKsl469bV9jH3nvaReB1R+Njb4E/ImnGaezyjPqmPgRL3XGQ6B7RjWZ8RQ9UrAbOsFODfysUVm6TefQQTKCBTWiJQE+TCAlhrnPmcSiKYwsbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpPzq7Ls9yhwdyknEN5XxM2B7V8dP9yUScnlcZayAgY=;
 b=IJvpdatjUJSuqMnUNZFQRSO2PvBQFEHLlB7/p2it/Pvhrhd7h5ZfrHXbCsa184Yo4tE9IwIMakVNZhDb2fhOX/cJOen20YdMiUpRaN/69J1KMJWlDVashZKofEVCeNEea/7wGFOIMnitfG4XaokmEa/m9Mk8DG8RZ0ElabgfUj0vJJHmpDhQ91/qb/kt8naYKWPCTiOw7C/G4sx0sDXkdQkhlph5az6EtOqprT9pTNoSbxoiZbIVBUV5JeyHYGCDvXovjODNqwvbPbHPnNxIaYSl57aXjzcpGJgRs9jAHmKPPAFSx7M5GS3pMkyRVJNMj+nvmZ5M7X4MgrqszMxKvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Sat, 5 Jul
 2025 20:39:33 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Sat, 5 Jul 2025
 20:39:33 +0000
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
	Zqiang <qiang.zhang@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>
Cc: rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH RFC 2/3] rcu: Refactor expedited handling check in rcu_read_unlock_special()
Date: Sat,  5 Jul 2025 16:39:16 -0400
Message-ID: <20250705203918.4149863-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250705203918.4149863-1-joelagnelf@nvidia.com>
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:91::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 400640fe-9307-40a8-8e0d-08ddbc040c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FsR6asRfs16U/OqSgLCbjXApY/IpPB8VaGAFeVQbuvFmO+JO3vaDMsRSfTdD?=
 =?us-ascii?Q?72CPP0Z0c+ttC4tz47IxFOebXbrTJGeP31Ov4RhFymyFaYPa9HbDmN/8fr5A?=
 =?us-ascii?Q?TCicQd1I+gkgNENG8ugI23Jg1k+nenIHXos6AVaHmvMrUgvvjCosP5cwNX/q?=
 =?us-ascii?Q?Oo87R6YYULTmyKJ5zIgoW2AqZAbYtxp/UTBMJAyhonD+f06XEPd+L552qmzm?=
 =?us-ascii?Q?3qPomc/K5K6C7rRQkCWndGXp4X/1aQk80tYmeycViJALs1n7hQUACD2kvAy1?=
 =?us-ascii?Q?9gJ4GA2mGBuZwTaz5zWy4U51GJbj8Z2hqH1Dpcb85cmMQgSlBxh6f4v9XhMf?=
 =?us-ascii?Q?UKVwx+jDStvObYdgq47qdQVjogFm2VXGnRyTaoVU0xcraTcwF601xIBluK6m?=
 =?us-ascii?Q?Ff+D6/mPsFbJYs5m1jU418ZpPl9Wfkg+FflDXbR/yHAqZvAencnuk+CD/I1l?=
 =?us-ascii?Q?dHBQK22Nel0yQxrcZ8CNmnQYgQRP4puxzI7aub7WZQntcOoMB2pHBvvjk4G/?=
 =?us-ascii?Q?dEorFcNuuzyb/cmJCsD/FLFkqQuK+1x4JJIvq9DrEMB9z6YDf89X6c0nUqsy?=
 =?us-ascii?Q?JkAItNHW1xjTnFQ4iWUpgEcPFh+gXqOiLD8W9aP8jkg1Wjfqfl+mdsIJ8tcm?=
 =?us-ascii?Q?w9r8abIUlUqnf6B6/UXM7xthCVXZiGeKpY+x7wkME8hooqRcs4FBjD8l0lel?=
 =?us-ascii?Q?nF4CMb1PmFc27xudG2JxC/zF06EWDwCSjHrGZmJGtOdFiNvVvB+rz5BCFe8k?=
 =?us-ascii?Q?F7+9h7EHR+aYJMwlsRbTrZYluPcY8bH2jR2KvWikoR6SkUKoETkplV1IjzTL?=
 =?us-ascii?Q?3RhtI7yjpdXn97dso9iQNa4WQN9YR8tDpbI6+WTNG2Gt8xNtyUAJjIL0ctwQ?=
 =?us-ascii?Q?k0WT+E76VteFKF45bFkZfPE7Ob7yYu5kcFOPnhAIgz91KNhrCh2Yz2njb8mF?=
 =?us-ascii?Q?TWuxjw7JAXTvkIglBaRBZBIfQAuGafSqL56zg4taTfKC5vJS8nfxZtE0Cfks?=
 =?us-ascii?Q?yUEf+Bs12CO7hh9ZAM2MwT0fM1hBWqwV67kenz5YlmnS2RS6fMa9OrA2pLqX?=
 =?us-ascii?Q?e3fjOfYO8FJ9qpG83d31AC/kkNBI4jnQPbM5BHiS2rXwNE9wBFZ8cHDszbQX?=
 =?us-ascii?Q?KtRAI7B0yjV53vZGFaUjYcm90uj+014eCl7PVrJxt/ip/0WqPlgQVUeX2AW4?=
 =?us-ascii?Q?WD+DxYFl7W/NFzKZ5fkDJdimT21MB2Qp/A2NnG6N9CKVkHbyDkpsxW4qO8od?=
 =?us-ascii?Q?z9nBJPA+ITCA1iAWMrzRbT60x2AoAt8nbW5bG1vrGHqArRx3Qq14Rr45tb5u?=
 =?us-ascii?Q?H9hvAk/tpuNsRZL7yvG6AJUjEy6Kpd2CBumlW8W4Gd5jcYW14O/nSZttstWF?=
 =?us-ascii?Q?8otbOqD0Ab5f1IDGKVAFk6XYZXJqWcEdSW3xr+WAiUNv4SMM9vuUVASUXT1I?=
 =?us-ascii?Q?9G4J+WBP4nuAO10Bf/ERwTAFHl1EZftc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpZYcb7is+5SHr8Hoyc3G/SzGdq7g0q2egDl4cC4CxLAz4md0oanF35QlObG?=
 =?us-ascii?Q?s1mS2faqiLMLIA+VPEsck5YT9JBAl8OAsaNLPl1JmC++ZHC/8kyfPTxNtyLr?=
 =?us-ascii?Q?pAvFtyWExvuHOvy4/wUpRqcW8TCKFBbDgG06VnWkk49T2Q1fxzKA2gDCAIT1?=
 =?us-ascii?Q?xFYZv5rEXxlwb3oPknUqWKoy89BgngnefeaLmYtCSS/JAPsQp8aZopSp/5ZH?=
 =?us-ascii?Q?VzAPYCZmUwVByyoXre4vz4jF/n1Q5ZTeJvEGhzjJtC7EQ20XmCzGweuBqvU9?=
 =?us-ascii?Q?XYRY/MGk/fGhLJhDBkJuxVN8AZSasmGeeE3Pz3jzHiANq5i4aXXPD0kWrpUG?=
 =?us-ascii?Q?yQ7iKC72QzLqxpcy04avW3m/lHLSMO0ENCn4V9HDOorxWZUiDO4bs/XPuFPZ?=
 =?us-ascii?Q?ES0bkrymbbEtRLmY3bKBRpWept84iNWRnvJiwLQI20l7l7n2fmhLOV06q6Dg?=
 =?us-ascii?Q?d3ko045+63bXxlBETCHWOii9vb6E4YJVarPM6p5kM8QYjeLX59NgI/ZkjoWE?=
 =?us-ascii?Q?QG4iVIHzIhNs+cBKYIDsvS++cqhMIoRHF2DTRLQUu1ha1YoqYAukrOjWnKa4?=
 =?us-ascii?Q?5PagP+IU2xFlVffnfwKB+ZeF40jLRSfs0dMTivf/TD2KQG8y8SQpwA/ymejT?=
 =?us-ascii?Q?IG5a9xFP228r+GXJZE7qRvGHFCmehfftm9lcNN83OCrrcQ8PhXbqlohlFleK?=
 =?us-ascii?Q?jyo4UR9H2dMnE8KjIaJDoiXJIWP//1DfDw4RAGQsQQjBFa4vs5/QZNpAb/Tz?=
 =?us-ascii?Q?QbnwmoCwXtTWRHABTrTb3k79GuzvaSMl8tGh4X+0OEGn+m0XJ7CATlTh12JO?=
 =?us-ascii?Q?T3XnVBgBZHrKAXu7vsZbt3qZ5O9BYPh46CAdLgxA3m57h+8YcuzJxowLJPkF?=
 =?us-ascii?Q?1YtbsYI4Wu745a8u8J/L1HUuAMHVIQDCSRUynCDYihLVbFMwPYJNNHP30lRD?=
 =?us-ascii?Q?dJfCZjsGTsSQ3ymcNqNihv5OLt2bBxd31NSwv3GNYabb4P3bRS5qtbX/9zgO?=
 =?us-ascii?Q?3eYPpADSJlvMvvWoB4ftULojp5Ft/UKZ4yusDNLmszOIPGZ0TmZMhdM2zC4s?=
 =?us-ascii?Q?nTMWmvXGJ3Og5oyobof9t2KqiM8yFttPW7qHLS0uwNWCV3XAPEuNHStcg+NF?=
 =?us-ascii?Q?hClW6yNiU3+oGTDl8u9Gjq3sE7TE8Sh6Ck49cVbF6XR6hhq9/gFq6S9tdXXC?=
 =?us-ascii?Q?lG7yjmYnesYB/YJluuoUzP4GTwVwkTWTdzwdetogyzQ+JBgI0pxg4N/X8nGt?=
 =?us-ascii?Q?yOBHkRULh3dwcHWcNKKsoXF8uVZJcEKShXvtsPrH2ije942TgEPRYU3BTpKa?=
 =?us-ascii?Q?Nv/nd762hYejPZlZqfKv8fnMM1TPgXnydXJSnpfEfSKLI/uYhWpVdF9KOytl?=
 =?us-ascii?Q?QDG85zlgEKIATDhEUWxviwxbv7uQJXMK67XDswOuy5ddr6FZfhGfk6tsZUHH?=
 =?us-ascii?Q?/dGIy9UhrtlLJxkhe1ZxbCA2TbONa+lP0jg8rQatWjwf9VaF6UT7Dux/umT8?=
 =?us-ascii?Q?k7qGsx7u2KIWRVXOLOvQieMhQYxVJmg3mIFFUM+ao1RIzGfAJNAaMEw56fZ+?=
 =?us-ascii?Q?qZOJE64RM3xLqAR07AdRI0gZvrf3giqCmglQjwT8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400640fe-9307-40a8-8e0d-08ddbc040c53
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 20:39:32.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1X7BU0xDPRbc89umE+XdwGfNpVf4WDv60Gy5xLMPUZAvcWEZHPM5QGg9UiuOA+vNyT6IKkaQ9a4PZyJT31Zgrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

Extract the complex expedited handling condition in rcu_read_unlock_special()
into a separate function rcu_unlock_needs_exp_handling() with detailed
comments explaining each condition.

This improves code readability. No functional change intended.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 80 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index baf57745b42f..8504d95bb35b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -647,6 +647,72 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	local_irq_restore(flags);
 }
 
+/*
+ * Check if expedited grace period processing during unlock is needed.
+ *
+ * This function determines whether expedited handling is required based on:
+ * 1. Task blocking an expedited grace period
+ * 2. CPU participating in an expedited grace period
+ * 3. Strict grace period mode requiring expedited handling
+ * 4. RCU priority boosting needs when interrupts were disabled
+ *
+ * @t: The task being checked
+ * @rdp: The per-CPU RCU data
+ * @rnp: The RCU node for this CPU
+ * @irqs_were_disabled: Whether interrupts were disabled before rcu_read_unlock()
+ *
+ * Returns true if expedited processing of the rcu_read_unlock() is needed.
+ */
+static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
+				      struct rcu_data *rdp,
+				      struct rcu_node *rnp,
+				      bool irqs_were_disabled)
+{
+	/*
+	 * Check if this task is blocking an expedited grace period.
+	 * If the task was preempted within an RCU read-side critical section
+	 * and is on the expedited grace period blockers list (exp_tasks),
+	 * we need expedited handling to unblock the expedited GP.
+	 */
+	if (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks))
+		return true;
+
+	/*
+	 * Check if this CPU is participating in an expedited grace period.
+	 * The expmask bitmap tracks which CPUs need to check in for the
+	 * current expedited GP. If our CPU's bit is set, we need expedited
+	 * handling to help complete the expedited GP.
+	 */
+	if (rdp->grpmask & READ_ONCE(rnp->expmask))
+		return true;
+
+	/*
+	 * In CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, all grace periods
+	 * are treated as short for testing purposes even if that means
+	 * disturbing the system more. Check if either:
+	 * - This CPU has not yet reported a quiescent state, or
+	 * - This task was preempted within an RCU critical section
+	 * In either case, requird expedited handling for strict GP mode.
+	 */
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
+	    ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node))
+		return true;
+
+	/*
+	 * RCU priority boosting case: If a task is subject to RCU priority
+	 * boosting and exits an RCU read-side critical section with interrupts
+	 * disabled, we need expedited handling to ensure timely deboosting.
+	 * Without this, a low-priority task could incorrectly run at high
+	 * real-time priority for an extended period effecting real-time
+	 * responsiveness. This applies to all CONFIG_RCU_BOOST=y kernels,
+	 * not just PREEMPT_RT.
+	 */
+	if (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled && t->rcu_blocked_node)
+		return true;
+
+	return false;
+}
+
 /*
  * Handle special cases during rcu_read_unlock(), such as needing to
  * notify RCU core processing or task having blocked during the RCU
@@ -666,18 +732,14 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	local_irq_save(flags);
 	irqs_were_disabled = irqs_disabled_flags(flags);
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
-		bool expboost; // Expedited GP in flight or possible boosting.
+		bool needs_exp; // Expedited handling needed.
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
-		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
-			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
-			   (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
-			   ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node)) ||
-			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
-			    t->rcu_blocked_node);
+		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp, irqs_were_disabled);
+	
 		// Need to defer quiescent state until everything is enabled.
-		if (use_softirq && (in_hardirq() || (expboost && !irqs_were_disabled))) {
+		if (use_softirq && (in_hardirq() || (needs_exp && !irqs_were_disabled))) {
 			// Using softirq, safe to awaken, and either the
 			// wakeup is free or there is either an expedited
 			// GP in flight or a potential need to deboost.
@@ -690,7 +752,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING && cpu_online(rdp->cpu)) {
+			    needs_exp && rdp->defer_qs_iw_pending != DEFER_QS_PENDING && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
 				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
-- 
2.43.0

