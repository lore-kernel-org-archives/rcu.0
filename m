Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F149C2BE7DF;
	Tue, 15 Jul 2025 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609748; cv=fail; b=tXX+XVi7I4uqEanRTpkoBn/hhbKpGkdim2Nru6yWfO4eRZzkRg4VpDeTb6wbP85QcAvoSfH4yYZqHXRWI47YPwK/2yHp7c8eSyESlXbaSOIq9cF9npYhcduyPemU+QQAtImRf4Km+vLDWlx9N/vKD3lsH891OQkj9xxEl1qPfbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609748; c=relaxed/simple;
	bh=aZjW/8sSUWVW98Hvvm8Ehe63LuLDA9Mk5wTVTqHK8NA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jaD1gt3COJI+cYOkJE4OCrA5i3w5JJkA+q4rIL5ty/K5I62uJOVMYtvwMc25NWhn9CNJ6dBpwIq79COxfnfE9lapCQHLlJ2wqPYbSSchNy3lVjie6myc2dKjOfO2R9mUycc/ur3yzjWlikQHgfdozKw6GYIEIVsFzA9+AhxommA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nnGPqDhV; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nnGPqDhV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0uCToV4XUHejqYxub1MdxGJo+t/gSVTfZF+EmPeuyC/sEndt/UuGQX1HWoXMfn8xPbOoq4X/DTWK5lKFmluY1p8/w/IpjO4CXRAuTLdSZ4PivMtu68BTD+DgsUnqUuADnYRaNhc84ztYXzcJfEy5QTXKLwFWwKLpfotvMPfno4i/SZDAL+3j3GSriD2k6XbmtOqJNx8LiAWlWamiYPbUtyaA0efvuAgAdr7aPAkje9jS36RBGw11H93u1wmZj/dJnLI8ebXcfuifGeHdxqINxJJRE2NC5WUjhhNuhSl49AGRXNLnFNFU9xRuhhU5n67g1KDYGDKck3HQhpvOX3zsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mcy7jtC1N1/MvUXfsiFuCayIALL3TPKOK1QPC8crkHg=;
 b=Ha4BG9cgSJ8ToeIeisxpbNlqYdXSb9oybg9bwF6ZuX5fs2lGcFq2wp7nphReKAAgX7vrza7sZxfg2MXZ6T6sq0cYf1ZDVGed7T6Hs9dmeCoqDRUFgjatVAHcwTrQEnUs9mFL7zvGM3tld3b21BuLlnTB0sEQ4gH5j0ncohh56+j5kFoGUXBgi7Eu23q08EmPvcirVICXku3+9b5ge93Vubv0t47eFYmNZbv1ySPXv1t7Iot12gCEA0AIpkfixGyUy7HVUOL3TClxRD+4FHefr+0zTy5tlPpRmSdoEWchoNLMsvtEPQlEAeEfOG21iJqivtEPBInI1aIHnCQ+Cfju/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mcy7jtC1N1/MvUXfsiFuCayIALL3TPKOK1QPC8crkHg=;
 b=nnGPqDhVo4YaY8gMHcEmd805+bF3N1uhOf15J8qlK4grXsBcUOtG05Nh8kMP9bKEItA01HeZ4/k3HHedhUjOsI4k/M6GKsI1GR0cZ7uCgGtxvpT1c2bJlv12yNHlUKH/dydjn3wxbaennmlkeoqDone+Luefdz1p7qqv0pakZMPXjiWSM2sZPU8IZ1i8JkAqptOll8Of5yrmhyTj3VVQzzLVLF5xv1vY6w7pqKWLYRLVFxxTOn+VD5/ozbwqiUJcywxC23ACN9VY665izbGBuP8F1YM1IzHrUPS1BD5/MFAW7XJgj3DK5qbmRcZr7SVwLqMEBnSICYqlgUKXwNVm8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 20:02:23 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 20:02:22 +0000
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
	neeraj.iitr10@gmail.com,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH -next 2/6] rcu: Refactor expedited handling check in rcu_read_unlock_special()
Date: Tue, 15 Jul 2025 16:01:52 -0400
Message-Id: <20250715200156.2852484-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715200156.2852484-1-joelagnelf@nvidia.com>
References: <20250715200156.2852484-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e71695-65eb-4d05-10b8-08ddc3da82ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hrqAMRmtVKrzHQBmTzFSE7FInHY6SbNj1dktAp7LEJKl6X42d3mknG4EXZ31?=
 =?us-ascii?Q?eVwhhYwPVeOVx6wf+sEyaDPRlXaYAb6ZA+kjhRh8aoFw3Dl2qVz9CJ0/FkxM?=
 =?us-ascii?Q?CF2wPp1MMxiifieVhjQI1WCr9Mem1ou6VQWvGDEpS/2H3bxr1Jjou9fZ6TOp?=
 =?us-ascii?Q?nhMzC7xBTkamR49e8QmH0+ymsTqoEQYoYnplkjtzP9o2VTjo0eef2ebwBhPx?=
 =?us-ascii?Q?00MEv1l+wrhERJQTPFXUBb1RDWNCmZl9pDSdYUY5CRy1qBR1I2Kkn4E9cCSP?=
 =?us-ascii?Q?ajdY9SkcP3gN+PvEENAiEYIwOBhah83vNDSU1ZaQqPByrf2B6Wf8dluYZvdn?=
 =?us-ascii?Q?ncQ6uEM20Y1xcVQzqKoNoJ22z7LTmw0SSZCUB8Hzr7Hw5K8btlarlF61IQv8?=
 =?us-ascii?Q?rVZyLi7IyMzbkRBGO81Nn7wmGexl6UeUe99shXPuF87aRLlgas0K3uOtQGPb?=
 =?us-ascii?Q?oWCQq0qtGgKysI+98nLB0yWOZc9BVyMDMzYmGgZiG4ELWQlPHrwNJpSwc85R?=
 =?us-ascii?Q?o8TwOHpm9kMB8XCTWXrDEwSZ1tAQmE2U2cJLCxEq0UbsLlV9Xt8v2iSnjtBE?=
 =?us-ascii?Q?JwIvXhE1EYTPIoxklp6l7H7LMerIDZivjetS/SgluIXyNQr3ENmGqGYYsJqg?=
 =?us-ascii?Q?tfKB1H2JhFtps9vqgS9hhA1g8UNGpD5RJEBawI4ZILcJJQVCsLdB3ZKd1u1l?=
 =?us-ascii?Q?6h03J0wB6B2Rk/1VR4kuUusewDmgJwN47Ge4n80Gvw/ghYSQopGSk6Qy2aPP?=
 =?us-ascii?Q?8SzC4njQsvEKQ3DSMIXIA2Z3ZiBcawWm9VAf+OoLyrgtYykM54uU3qDUgpM3?=
 =?us-ascii?Q?+gk6K6J2sZvQYEg48Mh6CtJAq6nk2YLWvSa3KvzAs1/eIRr3ZmCxvFpaRxbG?=
 =?us-ascii?Q?SUCRTenbZaXqVhj8CsblhC5XTXYqrcrAnLElEiuS4KcrtcSC4+H0CYoxt9Cn?=
 =?us-ascii?Q?EYaMhDThWlWPhvsrgIvzRWKcTRmpJ8x8fRcM9b4IyIWdts+xRKrKEuZfkDwT?=
 =?us-ascii?Q?qE/fO3+rV03Q0P57OcHBHCUdShpSJ6xNN6ZTxetjcGRq3nzWnNPEyNi1fWUt?=
 =?us-ascii?Q?PGv94MzH4zqp2cffhLJhh/dpt9c2xsFMDYCREHKTnudReLVNdNwBO9dpwocp?=
 =?us-ascii?Q?7M6emLie7oQfMvJdI41Jzjx20GlUTnWClucdY0ILo/OjC1PRkuO09QojHJdV?=
 =?us-ascii?Q?OEX4bAWur1+oGwjz1wSdhnJvG3nLWKOOTtdedR7g1TgyWItpvH9FQfRFPYtW?=
 =?us-ascii?Q?vza0GTg5MewjWgCKDHyOxssxbv1qIe7r6rDLp1wEadc+NTYnQArmGs3fNmz4?=
 =?us-ascii?Q?6+RMoek0jxDm8QANgmyP2SvZI+wHi7cj28hOi3BV15AzG6I1CP4p5Tbsm9S2?=
 =?us-ascii?Q?WZwsPSPwSlKw5gXBYfEIfH8zvSgWga4ms0LAgf1X/VURdvcpDH0ZRK7kU27E?=
 =?us-ascii?Q?cHNY3ehpqThPCA1xZSSpEt4dqDwdGSjIaU7vJL2Ral6ik9ms0cukqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sclrsDPb7F1X/H9SemYAzYtmcfrhphk8VbpZ4cv+y9sySR10sAxhcNCI1+hu?=
 =?us-ascii?Q?4xY4tSN2+fgGTSlze23rV+nAeezNVm3Ks+35KsYpIwYK/yo6Vs+itqARiGg4?=
 =?us-ascii?Q?883ePMlgAFd2xG1qvO6Bs5nVtFoAQzGyB1bnkPaePxTL8/BOX5uzpL+Fq+It?=
 =?us-ascii?Q?NrjjQqeCXkzYW4/RMRTErlzHBVf+5g8h66PsWnJeecFlPWyjGIsQEqGCBvRY?=
 =?us-ascii?Q?sjv/aMniUDApjhSe3rDeE+3ZO9EOhEQwDeHFTz8Cis8FZzQGrCxSFVOlrPrP?=
 =?us-ascii?Q?FN/WoNuEnvzlry+qyw9xtsdg1SClZ+qrC8sBLch1hrKn0n2uuj7CYcEneJLB?=
 =?us-ascii?Q?71DnlHfM7CY/RHcV8jufqSicb2m8q9Ya0Nx+GkG0Q642ZojPfQzxtWnDB1lW?=
 =?us-ascii?Q?0o5uH74WuSJqOxRWt2xhKe5dD3lnQ9FSX5FC6/g1CSKgFsNs6FeJKfbNkUu7?=
 =?us-ascii?Q?RLXuNWdVhcTrGov/O0k57PLsOecJxLdwFZSGqi8dqBXu2kphaCmlTSIjMbZw?=
 =?us-ascii?Q?GqcGzDaRHc2ki6rIZDehVnb+bz5nQKAm1I9I73hBkojh6zRqVRy+dbdl3HIC?=
 =?us-ascii?Q?L9mbpD3o0Z0Rfvti5yhUXqe90evbDEtJ+iVeL0fns2V3D6R5PFmMA/Ux6E8W?=
 =?us-ascii?Q?VPf/uO5RXs3r0ahpRNyAw37L2KyU01RGRsNDSWSQ7ky6b/y/1lOlVKjUoRt2?=
 =?us-ascii?Q?woqurdU2v/VG5uFDWcc1b9uy8nJyZOh6qhrPIX1sXmii4yNLe0hZzSrbWV6k?=
 =?us-ascii?Q?kshqDef6/RcsHANq6Jl5YJQ9DttDBvCfVGk8B/jsWwR7lvEWmlLor8pGTKfd?=
 =?us-ascii?Q?XSx/cZgGIzz6MyCDHyb08HddPUw2gg7b3Y/WTzNXMGroNJoBdnXQlszWf0iL?=
 =?us-ascii?Q?nWoEDrOdVfHKrw0bsMyxyqqiIx+4G8VY2ulpMWWDfeYXtuMAS+Pnk+MgFJx+?=
 =?us-ascii?Q?3lAzni5pOvIG09gfE5perFE2ynxBINxuo483dS7oyEhslvNWRUi5eN0NhIgs?=
 =?us-ascii?Q?8SKs6QmqxuOhUlJ0VDcMZBM7BwLHBHhZevcwF0IaXc6zDbkTttRocrEqmzQ4?=
 =?us-ascii?Q?9+/d/Lxe5RT+5byLD8I9WkkNQ7i97506uKN+KFzpSQ8xtTlTg/cx3vqUx54d?=
 =?us-ascii?Q?SPYKmEzuFe8G6zP52eM5TqDXiouwmbIzgBRcz4P2kFvggYWvH19q80tOWNWs?=
 =?us-ascii?Q?rYmgJ6ddRyxRNd0o59COG0ix04LmOIZuH1BQhGRZTiR2oG9AKYMPR3nXa32V?=
 =?us-ascii?Q?6ZRMFWtaju+sm4th84Wq+XXAB878QfEW0czFvggcL5Eyf4WXiJ+ofa5zHf04?=
 =?us-ascii?Q?XtbXRcbJo4uWgn6Ap6m91NiMYPrILZFShZuCAmBDqXHdmazKSVFRLYehS2Lb?=
 =?us-ascii?Q?HXpfcdMViLFeZRFtwLwh48a70IkDtYrZrAsXShRdgD57gqHXHWvawOX+t1PI?=
 =?us-ascii?Q?WP4hbmf0rjVIVA32NZVWNbdILmL6zzyaiBx+WnTU/CcU939snc5O8/GUHVcV?=
 =?us-ascii?Q?p5MGhEH8LY5sugkr0nHIZ6ZWJ5/eCg3/MaWvMkvuJsToA1hMqcBuplb3rA9Y?=
 =?us-ascii?Q?PEpTMU9sfMeqDLBaRPFsgV7B5NLgyZ8YZwQa/o/6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e71695-65eb-4d05-10b8-08ddc3da82ac
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 20:02:22.0728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM54akR62vWH1QhcIj6uxe+SQ2bI2Yy9RfnQsnJuTcXkl6vNypqoxv/R8CCKNyEmCNP46zfe4QzV5Nw1Tldi4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

Extract the complex expedited handling condition in rcu_read_unlock_special()
into a separate function rcu_unlock_needs_exp_handling() with detailed
comments explaining each condition.

This improves code readability. No functional change intended.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 83 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1ee0d34ec333..ffe6eb5d8e34 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -646,6 +646,75 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	local_irq_restore(flags);
 }
 
+/*
+ * Check if expedited grace period processing during unlock is needed.
+ *
+ * This function determines whether expedited handling is required based on:
+ * 1. Task blocking an expedited grace period (based on a heuristic, could be
+ *    false-positive, see below.)
+ * 2. CPU participating in an expedited grace period
+ * 3. Strict grace period mode requiring expedited handling
+ * 4. RCU priority deboosting needs when interrupts were disabled
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
+	 * Check if this task is blocking an expedited grace period. If the
+	 * task was preempted within an RCU read-side critical section and is
+	 * on the expedited grace period blockers list (exp_tasks), we need
+	 * expedited handling to unblock the expedited GP. This is not an exact
+	 * check because 't' might not be on the exp_tasks list at all - its
+	 * just a fast heuristic that can be false-positive sometimes.
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
+	 * In either case, require expedited handling for strict GP mode.
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
+	 * real-time priority for an extended period degrading real-time
+	 * responsiveness. This applies to all CONFIG_RCU_BOOST=y kernels,
+	 * not just to PREEMPT_RT.
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
@@ -665,18 +734,14 @@ static void rcu_read_unlock_special(struct task_struct *t)
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
@@ -689,7 +754,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
+			    needs_exp && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
 			    cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-- 
2.34.1

