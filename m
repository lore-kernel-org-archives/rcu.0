Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD92E0B7A;
	Tue,  8 Jul 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984574; cv=fail; b=oN9vnVnuY6cpQLGoBomoAeEoQvSkDaU+8di0pl07QtHT2OGZ5Bkmt2XuvtfMEdSwcZt5fhcskZozyFdw3v2+sb4VrbeEQZ2aNw/xY5kTTH4ca/DkmqvTYd4DfMgOx7C7QyuPyXF06A1YZrdVEPqTLRO37J0uk89jFE+9zdmGkvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984574; c=relaxed/simple;
	bh=hZya7reUjyxHklx9W3Mqn655snOVe6cBZEYSRa3/ggU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yr29aFG+H8xWLJhObDQZfemkqwqxdTLYM9G5dA550lpFOYLtL1x/gZ4+gIYHs9ReREvf/dZAS9NSOFtkpRiloQ/rfm/1jZo1iiLCvavvA8tm/KvCCnRumGqj1X+XOBbCPi3dIMaN/OD3J14UAlIA1GIOnAnc8/NRQ8aGdTFNeUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MhsqaBVl; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MhsqaBVl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBXtgAVS2a8IwMOPLYQYcClPBrqWIMv2aJJxaXDxqVC6rdz0EjWTdEtZQNJ2tYBVUsui93kqQ8B8FMLoGQAggviItOQsVEzjWDbIwqWow1Q0+dEWrEtpjA52JxFcs+dBPEueVA+oKcDPfQj2GmY3cil6cTMDNqEicaFIVAxx3C2rRH0ppLbBv+y2CXfYSNppFIVtpmjoq/eosGrC1RlePgUSfK7CrmTrZUl22MPeuV7m1rqRdP8vsfqP8P0+sNJnJ1r9lD/EAk3cAltBH5G1D94OBONDXWeKECDr+gJO9u21ER1V45nsJk7j5ewRL6Fc5/Et6i7HtPdsGRjqWilA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnruQtTBzgJm7McQnm1dBM3b4mP1Z3EUCWOyoKOU/1U=;
 b=i8xATwnjvZWHgM8xAfVbpzGysu43BMnzQyWdjt9l11NdvkCG5/9Cohck29+4la3B9pRcx3fBQcZ9O/sM8lI4osNniW+hxc1HyT+PEmeRn836yZh5OJXl302o22KEZREZcRkpfcoRVk2COp+uipxIvMIJV55+/8jSQseHubeljyO3UdMvXWfwXVFJP+h09dFwtFhhxtjfmGfOrdsu01cKVHUZmeQDfINeyi7b1upM8Gqa3NYHfig0HA8N5l8jEbgl6xIsuBpXbQJBeiQd+w4k3v/qH8tkiJtdNQEBkpRJBEo+qtkJd8UcXvqNygiVZ5GvGyBPKQlipoKD0RjzNCPsww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnruQtTBzgJm7McQnm1dBM3b4mP1Z3EUCWOyoKOU/1U=;
 b=MhsqaBVlcYr/jylRwbz7crko3iSH62qzJBaZQ2n7dm8nHTD0yXKD+vx5wT1husGACJVt70PJi9XqXp6cpuQwWoFwt6lTxnWwGMOxcayQaZxLOtsB4qvLsilyb3HRn2V2du3v+Sk0oE691zvGfg2ZzDv0U7+oEsEyFZ9HL16WIV8RgUGiO57aTiFCzjwS6b0WLAoA6/Qoe6WySWLSCA1cn1lmKZi/Ffn27rRLBTKmo9pz+iP08QnXrwacDPlJvM4Q0pbghKbz5e65P+zBJa3v/BXr2cRCZCRf5OKpHgTw0Rh8N++C+glsbU+J1fiBKFTf6+hjIscU36XJO0n7KMsZ+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 14:22:46 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 8 Jul 2025
 14:22:46 +0000
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
Subject: [PATCH -rcu -next 4/7] rcu: Remove redundant check for irq state during unlock
Date: Tue,  8 Jul 2025 10:22:21 -0400
Message-Id: <20250708142224.3940851-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708142224.3940851-1-joelagnelf@nvidia.com>
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013E10.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 359b68a1-d0a0-4f32-a3fd-08ddbe2ae8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VhGO1y4mbtsF/hcRQhjOflvDV9HajW3ov/N3p9dA+Eysmo0ebwGz729vxH5D?=
 =?us-ascii?Q?/RKBu/R+w/aM/TYFomNB+4lWvDzdw7fKoh+OJd1hSLUxPg1j5QPOD3zfs9bH?=
 =?us-ascii?Q?7BouuruUaf7YQg6ptlBpIraSSKh3Z8jTUzv/GEYknWqN6jPI9+JxnMgaviXz?=
 =?us-ascii?Q?CIGhTbEScpnfw8IcF7pUIAJefWc/2NhIKi7ZbBtr2twgJx9nevGLoOL/hEZs?=
 =?us-ascii?Q?dhF11WrPOf+9AT1KQeA+2cvuPRnGsahF/gJRGTCCbOxdq3e5G8HVq1u2mb8C?=
 =?us-ascii?Q?CvhR6NBnXFz4Qenxcv5RDbMbJ7a+C0JarK4cbtdy18UOd4ncZKUQXNmc/0xT?=
 =?us-ascii?Q?hNVfXq/YKX8FgJc8Tt39QYQh/fl3JfnLCwJV93i7i0CP2eLFGXBLbrAp5ajH?=
 =?us-ascii?Q?MqRXmF4sQdjqQHCZXSnnCawQ6E4Ts0mV7FZLtGE6gW3hz9vA6iGG0PoiJHmM?=
 =?us-ascii?Q?ETCMJEaPz8pU8loFH6RhE+QiMIcwU7fXfr96j5A9Crd21oBaNdmaeqP3vNUW?=
 =?us-ascii?Q?6WJXiPLW4mmcTOeN4Q6VFSGmurA0Whxzza+84VRRAGSxM/FQxeSkRBiUbC17?=
 =?us-ascii?Q?1av1RPR4ThYA8+9EgES1IUri5gbJkrVJ0MWoeu3Hpsv3FcVtM/aAO0ktT67D?=
 =?us-ascii?Q?wEcMCUV3Q2vSOWtHZ1xsGD2UrlnS/fxeY00cFB6PxcWCMMiSx0bT4IMd2BVs?=
 =?us-ascii?Q?tsTRPT1kgvAHhJFte61QcWuPQ0Mx2PtrBgxl+N+Hs6Y7dl5O9SvtfbiIBJXL?=
 =?us-ascii?Q?MPn/Cr9TmAb6RaDJ02pPHdG2L1A0CWm5+00PZvQaE9986O0gCq04cljsDOcU?=
 =?us-ascii?Q?0Le3c0mqOQAHaldTvJxBWmXFEw+oHIFkpleYxrbg4tb2Bd23Xml8YmzVBQdh?=
 =?us-ascii?Q?f8ojNOqp3ij6q/lxm6M2Mew0lAGgTd1CBBoMs2haDMdTUCf3nuZVwzE6g+CC?=
 =?us-ascii?Q?XvLB1jZTC8rf2dOjWx1zgN5WkjDGivJFFyEsLIBEyn3jScjYflOCVJYCaltq?=
 =?us-ascii?Q?ep6fgjtZL/+Pr1WAtomxOlFTeS7eBXNEsgmy6rRIoqe3wJt3EzbVK8DM5Ezh?=
 =?us-ascii?Q?su78BPgpLad2NZdDviYRYxpVbTNlf0R4ZMY5cERbfo3km1M85pgihQlNHmYi?=
 =?us-ascii?Q?VCAKrbgMiOvBrA2mWsTfviUF5DtWA2NFSpv3daQn2+iE438/xhmr5PvEbhjO?=
 =?us-ascii?Q?lGGVHU/a2c5eaa4R4pRYJ6bZfOW330+Vjacb1PmQWa3UIwT+vflc7bdvnQUY?=
 =?us-ascii?Q?0Bxezm6nqCnZSTHQKPvKJ+fjEaANcqe0ycPogY4UGEsUUYhHTUqA7xb4TbMg?=
 =?us-ascii?Q?H04LNME0Sfl3e4NRwA2YcuXrfPyxkwKdorA7gvu8w/tlUQyNx7vxsNrfqaLK?=
 =?us-ascii?Q?EY7x/CsZkbz9Cgp18ua2Z/BfUZAm9wA1zm3fL546jfjzvGpYK3m6eDA5QyIO?=
 =?us-ascii?Q?zL0ABDxl0N9tJa87SaelVlKiTVAJ0uy3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lg3SFCbzOUb/SJ9K8JAaaeji8dNKemuVDLTV0R2m7n1+ck0XmDKsg7xUFCGg?=
 =?us-ascii?Q?ye09e/u6S3olLEz0HUpUgU4O3Pl4q1QOp9I/u7xLGg1OsIv4KBFDIr4D39rv?=
 =?us-ascii?Q?JvtN3GzEgwHrJdNE/a6UKkVLzafG0DSOY7RqR71ijS3meLK8syZyTQeeCI3Q?=
 =?us-ascii?Q?Wc0YQfK8KOrwxzICAH6tAM9bVAmp/YtdFkEW2F8aBtzAd1ABTDpscitl/6+S?=
 =?us-ascii?Q?xL7C8wGrL1NCdi7JSHp54ykMC3Q125f5PbbczXEsfQJ8ZxogXVHNLMOyHz5B?=
 =?us-ascii?Q?uvIXM7itBJUP5mjEgtlR/vccTG4sRDa1y9mdnnH9KPhkiR7/s+SRQ9Hwb4C7?=
 =?us-ascii?Q?A7BZDB1m369BP/YUPPJhGttYksn5J3vXUvCuBl6HwoMu2XpHJMnqxpsqqlf0?=
 =?us-ascii?Q?5EhKNio8+Px68AU77J/qJJmEyQWKEYS2tI1UY9ekkolUvKBm7lkzvIxYbBh/?=
 =?us-ascii?Q?IdIi+ooDel2Lp4ZQ7FXkD+xcmXsZ6eqW5ZEQDJ3gz3dt1s3/bCE/7gYR3yRn?=
 =?us-ascii?Q?BHd9pg6gcKdfDrSfVszA3Qa5Uc2aRUcTwk1W4c393Ubwv9PAWjPxF//negdS?=
 =?us-ascii?Q?E1vJr+cqDZrLw84am20z6gTvbIvb6Qb92JN2TwE0hFfQI5J1k+XA9iq2WUdi?=
 =?us-ascii?Q?/j0RdYF1+H9as4ht5ulmvQKfRviqpA9JyvMGvX+p1Tq86rblLiDpwV68rZ1L?=
 =?us-ascii?Q?M0iPbYmJFSXAVnFtmZRHy8rgIsZPzV70Dh19ULwPUK727dNzlaZQBb2E5HEc?=
 =?us-ascii?Q?5+ShiW+YQqjFmEw/HZlrZYHupyOSGbrtMhK0y1IDSp6tXweX9wHG2avE9bUm?=
 =?us-ascii?Q?ooHNGH8Iv/4mJ5XJXEDWzR3n1d0Xl4y4wCWWg+CiUMZKBgt7nt9i6Zkr7HmH?=
 =?us-ascii?Q?roPjwlYWv1yKqnl0dE8FX70+bW7F0st1kLHytELPIgv2JtM8Zo/oU9Lo8SIw?=
 =?us-ascii?Q?Ba51OA5mJU1vDqmlqXSUoDnBFLa8PEBmkbCOCRZSsU3W0+sj80NHUKvnNdQu?=
 =?us-ascii?Q?NgRzfKakQZ9QUWCdZfgkAUWqtL+mCGVBohvyrRsPc/Y1QmMuMre5RD7S8c71?=
 =?us-ascii?Q?npYFBhtExJqjvCY89xADuS2WkCrHSaUcciA/ylcwCEgNVjLsp9fLOWGGeRX6?=
 =?us-ascii?Q?vZYssNapRRPsywWwlBa5s9kuYZOIT7mEf/4/vc/5i+1I0Hy5uAqHBVJsQweO?=
 =?us-ascii?Q?QNlmkwb5BIFCA3b0Cxpqw86jqgq26YPicwBLa2MMFP8MGLFd8OyNqKDX1FAh?=
 =?us-ascii?Q?xU6Yz748l/7zqDnwGxzPikfY73qt9+Qqf3fGSk+vC5+2gSA1wH9Gq2ZSIyWj?=
 =?us-ascii?Q?H1IuKR3hJMoFxJTkRSXPCGiP5dfkvOmz5sTvqIKDYPYFIlE/gaooL2QS1D6E?=
 =?us-ascii?Q?liXNGp+YJwJU3s4boUsMGM2LlhoW/bNxcSs1JLxzKOgabGxmjA7itC0zsyfs?=
 =?us-ascii?Q?FYGMrfYaGbqPfH73jCPUIMa7ekBWW7HhiEI+Hm9iZn322PW4ipvlJfnk+mAq?=
 =?us-ascii?Q?e3w8Crc5z8DpqK+VsnCYCfYagG/KaWCiCz5WGZQHw1l4eE/dnSMKi56QDaNy?=
 =?us-ascii?Q?wuEO3sQQUsWXHdxaZ0IvYnU6bi4xxzL2qwS+TQrr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359b68a1-d0a0-4f32-a3fd-08ddbe2ae8b9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:22:46.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIey/4Ez0FiNQ6iCVNUiG4ES0tCKUlvPGkWzQUO0f8olCiP07UzwhyEFRij6t0zbvDWQxxWQcWHBsN6eQw/4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

The check for irqs_were_disabled is redundant in
rcu_unlock_needs_exp_handling() as the caller already checks for this.
This includes the boost case as well. Just remove the redundant check.

This is a first win for the refactor of the needs_exp (formerly
expboost) condition into a new rcu_unlock_needs_exp_handling() function,
as the conditions became more easier to read.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e20c17163c13..7d03d81e45f6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -659,14 +659,12 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
  * @t: The task being checked
  * @rdp: The per-CPU RCU data
  * @rnp: The RCU node for this CPU
- * @irqs_were_disabled: Whether interrupts were disabled before rcu_read_unlock()
  *
  * Returns true if expedited processing of the rcu_read_unlock() is needed.
  */
 static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
 				      struct rcu_data *rdp,
-				      struct rcu_node *rnp,
-				      bool irqs_were_disabled)
+				      struct rcu_node *rnp)
 {
 	/*
 	 * Check if this task is blocking an expedited grace period. If the
@@ -702,14 +700,14 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
 
 	/*
 	 * RCU priority boosting case: If a task is subject to RCU priority
-	 * boosting and exits an RCU read-side critical section with interrupts
-	 * disabled, we need expedited handling to ensure timely deboosting.
-	 * Without this, a low-priority task could incorrectly run at high
-	 * real-time priority for an extended period degrading real-time
+	 * boosting and exits an RCU read-side critical section, we need
+	 * expedited handling to ensure timely deboosting. Without this,
+	 * a low-priority task could incorrectly run at high real-time
+	 * priority for an extended period degrading real-time
 	 * responsiveness. This applies to all CONFIG_RCU_BOOST=y kernels,
 	 * not just to PREEMPT_RT.
 	 */
-	if (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled && t->rcu_blocked_node)
+	if (IS_ENABLED(CONFIG_RCU_BOOST) && t->rcu_blocked_node)
 		return true;
 
 	return false;
@@ -738,7 +736,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
-		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp, irqs_were_disabled);
+		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp);
 	
 		// Need to defer quiescent state until everything is enabled.
 		if (use_softirq && (in_hardirq() || (needs_exp && !irqs_were_disabled))) {
-- 
2.34.1

