Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F063CDBD5;
	Tue, 26 May 2026 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835834; cv=fail; b=fhVrz/tLLD8RGT5qVBeaT1ornnvrqUVfCNxLhZk/DVf6/EWFCg+zObMgZMvwtgp458gObFWe7kyLVfyV3Iq6dn9dvSeWyVA9wXqa9osj+zC6O3Yy9RDeH/K2DJqWDDgde5ShQDsZAhBG3ysFH0ZsSZpWaDOL064Sm4yhwGS5mpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835834; c=relaxed/simple;
	bh=fbRjpXyN/E2RaoqyvhlPNuYovKwltiVbHlD9OAiwTP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cGsuQaAYYRwVshKX+nLyEY7yP8Sdg9F7W6+s6cdlaZHEO97nd4d+LV/+Xx/DzCyfDXneUHvxtoGkWOJ//aqZ9d2k3G4rB8T/OpiBc3d72Cjg5YCYDvNh0lKlNFbZhPHTh5VLXMkzdDRMJgCXOtrTkUyS3Zgp4wQgoMhrkYLm+hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NlJ8Id0O; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NlJ8Id0O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIJn3cZLqm5T6OyHoO1ftqfiSMrpTcHeNat2e8r025c8aA1fXYIbRc32e3+drL8vAoXw/AgdtG38kLPBDT8AgJ5ZCuTngtpEIHqErdwc4M/NI0WEqASk9YVgSeX+CIbklN/95mcVWemkVqmlfBK5Dr0WJQQTBQMCq2xMmfCy6uTGj/hJ02w99ff9RqMnL4dT6l8lGOdBbIR0d7fxGu5D8OcJrlBRSfzpNmvFE++0I/JyueJaQC5bspM9FAAcASxviuuGFc3C8hGLuop5UAn9x+vVS95VwOPqzJLTkr1e4ZRKSUIhY263mIs161rhjhCihuBBwChgxu1BY2d/9LwZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2R2eohlshkyhTS7BzkyvjP9idrWHREPtQXCoqfqD+AE=;
 b=XLHmVS+GYrHVfJBfSMbe1NJ4pL9Vw3FZCn/ZNUFUBV3NbxF7qBBPO4qnBrNmdwFcXIGJCTod5IvxkHAKyEz0ulvP/DwrDIGSnRW5Kdw/ptebXu+7rmbPsNlmTvjDzZqrgd0hS/ivLMXCtRYIlK/jPK/UOPf9WaawY2kLiDLM5dsGBzmf/QG7siNDCG9hLbO58ksiRCGN9iji2uOiHlx2AfQ6FPQpEBedLM3fe0/FL80RlvaN6uW+REwcx4G+Epd6eFGfg45EE3JHpHE7RzOeBWN3PHhrfu2U0x4Z0y1rghsnIulziZncL+Z/2a1A5h8sGdyovk5BqzLKw/X6eD75vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R2eohlshkyhTS7BzkyvjP9idrWHREPtQXCoqfqD+AE=;
 b=NlJ8Id0O5M9Nsfmw2xW772p4g/mTWwIvgagAhcHkY2PPFWWbpK9JLSJuBtP5SybcgUhT7LDv1A/Hw5TY7Nr3fHJpBQlVnNMjBhbAg5A4f6+K6ymNLfZ0sSlwpLBps4MtXb4zGRRpyb92hj/mRD3fgIMzYt+yHmbyuHxowg+qM/2auRhiSVdvH1xD04EKSlNV917d7Ltm83MZ2724yfeNSI761fZ2mD+pOFtUtawyI+XYf7FKtYSZreysocNIH2i50oIWaf2ZXft8f2T0prKd6yngH/iG/Zfy9iQGT56S6HQiWM5CqeJMAjZOyhRC1mbe7XHhgkPqeqsBHyDl7ON8WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 22:50:25 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 22:50:25 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v2 3/7] rcu: clear defer_qs_pending in handler for compounded sections
Date: Tue, 26 May 2026 18:50:10 -0400
Message-Id: <20260526225014.314734-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526225014.314734-1-joelagnelf@nvidia.com>
References: <20260526225014.314734-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:208:234::23) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: a7063840-dd0c-41b5-663c-08debb792c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3oxHctnBRqD4T11x/AiklfeDCjtx8ILYd/0Wb7FCmXVRnyCQjd46WIIoAD28+9E0EGV/eNfi9kM4fW3sNMkfpGFGevwm7nta1WJnY06UM1M5fWTUmD03xZyajCxnnWGoTOWAfBTGIGgO7twcAcXiEov4/jLIQhDwG/EbvAC7jhB2VH9nl9AsCoLpTas8U5dX6B2PmvZnCt8FCaXRFN4yD2R7a+AkjyWxshZUvS9DIfq7zrsO8T0bSZnOEIjdhwW/gjA1HxWX8OLj6cxd5xf8+9CI9u1IUfgcCTE4NL4VzPyi7Sfz+T8HQDMevjLqkY7rT88XkU14zqRWi+MJxXTw8gtSKRoR6tWAX5oLCF/0bLa5V/c4RtLxAePWK/dFBb5EDCQfcgVRGXNsd/F9JzaIspXARaWjDg+HdPEw6cUfMbPFb9a+L2RfDr1rOvaFimjmaWQLfmIE8gqGNfcSgcq04LrNauTr+mX7Mbv0jJKUnUgLWWGnpBl0RtKOMBOr94HXeGdeFbU27H3cOkeICP9VehmeK5cEH4a4CHCFUjoAvGsnNlpuiK8b2Yhk7M4DqOr9wjmnSetveBFcBM1UEmksfALo7iqxiXT62jjlWIeFOcJxmP7NE4zikoZEQfXsFO8vl8UUjHl4JESE0WWODPGmKlE3XQj6DPfI7OeeRObr/kxx9iMrIQEgbcM4KkKE2+wv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMgWKKWCtCHeWUFNhAMDFBDRLarGruPt6rWGkfN3q7KPXGC6+IjvqfWZ5xPj?=
 =?us-ascii?Q?U0JdYR4BT0izvnFgENXD0x8RE47wuQ1Xpu9z741TU/yKHrcHNTBlBMrFSTaa?=
 =?us-ascii?Q?F75JWTauOmNSrz1XPJs768KLM8hbDe3pGAL+KGHSyfJA4cydV693NDF+yGpU?=
 =?us-ascii?Q?mbs/Fu4D0zU2NegijkNT1I44iEq08XVdXkw3GnNPf2qXH0RGQP6k8OWOg0Cp?=
 =?us-ascii?Q?1lbGC5tGN3sLXyUE/U7O+G9jhjvnuYb2Ums32vA9ebBFFbCs6RJmqPwRJEIG?=
 =?us-ascii?Q?bUWVNqsRxF3No7dYja8N2F+luETi5t335I/YLJ9MHox0oTaBHxILlT/yBqSR?=
 =?us-ascii?Q?XUg0ru+UqEBfSTKSX4RbD4NYtZWT1ZNge4UC22zqQbYXYwFDOp6qWUYThh1a?=
 =?us-ascii?Q?wtN8Ve0otMGPhjBTjBrbtKY1JiM+YXP+xywKQcxg2SXTRcUDA+yS4l94Ie3o?=
 =?us-ascii?Q?ROV0qTTocUJyOwSwCX3o60AXQwxWUtyowpyBtfyzxv89hKSTwxx8JbMjFRWE?=
 =?us-ascii?Q?cWk8mDXMcveK6Ixov4BucnYvfC9gZ66YOp9+0y8t+HZfkvkP8xwCbitI5DAz?=
 =?us-ascii?Q?KIdFUPvzC2D20E/3Mj9JjXZYRtKFn5rIrtVROHq61K0G0nD+OYZSQ5g4kmy9?=
 =?us-ascii?Q?DD05dcCu0SBiKQAAyJ76DxwrrToQGyHhNsg1XlLYM4g1PPyTj9ZhSionJiDl?=
 =?us-ascii?Q?O8OEsXVOsNtsJgFrZYQlxMMkFdAq3N9B7ySd8BEuPGZtetqVupvqYI5QyuIm?=
 =?us-ascii?Q?+z4Bw/clpwKqXhSyZti4bnVjQROPIplsF9qbvjWkZ+DRz6j0SH2riYEJ65Wh?=
 =?us-ascii?Q?w3bjozFZ4Vxft+6kZoJGCWYut04zi8ajOB3V0CkEeImfz41aIEog4HfceaZZ?=
 =?us-ascii?Q?+6l3HwziNk5TY2mOk70QpPPFeYYZ9JxQ2NjI0svTZKt2K98DepsW04TEKI2p?=
 =?us-ascii?Q?GEUqe9F6KAz+y651+G9mrGWyqzodAaXcUR1rR5ucXWrfEu2wk2a+DKck1e7F?=
 =?us-ascii?Q?cDMgRWja69hKqrU/Ny3nr2f9dHrEb+u4BJLa3L4dCaLztpsKYZj4mpJ6dW/u?=
 =?us-ascii?Q?jQW81tejUmrl25O9qKEeuI/2+yeLqZZWdj5JXpIx5BkhCxUjZXY5pc8uyIzP?=
 =?us-ascii?Q?Z/cSclHyZK98SuRexXk3Uef1FUDSBuIoZ6ppKqYKBQ7ILTGzZalqCt2o/PUb?=
 =?us-ascii?Q?nY0IrTwx/fIe5eSZe3jWHfafkANSWBmSGo0cgyMOlutqDUOPe3Ast4sd6r2t?=
 =?us-ascii?Q?hwfnkorQiYWVMkPZHM4w2dDE/NCjR8exchYb6EukomvMx86jFlbBA+SG8Q/o?=
 =?us-ascii?Q?xDIYolgp/sJdrkOA08vnfveT1bAWU4s529Y3P+a31SZhUHDk7nxVw90qwHyE?=
 =?us-ascii?Q?qKAXfQcXrVq+ur9vUHBPE2khcwjPa+s5y2LLYQD/N5qqm5dYdCrxDvYyvGT4?=
 =?us-ascii?Q?HIdCMk9oF//RNWqPPkKcXU9w21S127EGxZXGsqO87HyUvYvu8ueaLB9KKAlF?=
 =?us-ascii?Q?NIuw9GCq67OdRJZklUTwNZgoT1D+V0mk/eJegZdtIX1BLX8GrRTMZJQhjtUk?=
 =?us-ascii?Q?JEBu27OoTPSMDwED8zJprPRvQtdI07O60seuiJRqpG/Rjp+jMqciafRWNQVD?=
 =?us-ascii?Q?yAorAe7FelFqJAtyQ/FZIM0DyRDrJhy47Q6XEpZJT+BHvtFHbzInwGe200WR?=
 =?us-ascii?Q?lfRIfWRMWQN0JiEfth5zFDMqiIhbqZup0Ip3umw6zn+uBQfKc/R7WyVJx7cL?=
 =?us-ascii?Q?wRkDUR/z6g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7063840-dd0c-41b5-663c-08debb792c82
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 22:50:24.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9J4MQcM9ZcCWOHD9B82b5dvLW0nhkJ0TBgWt7mFo+dlDY0ENZxq1/YX4MpTVOUHaPZoex7iXDHmoWQo0b5geBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

The deferred-QS irq-work handler previously cleared defer_qs_pending
only when the handler ran inside an active rcu_read_lock() critical
section (rcu_preempt_depth() > 0).  Paul McKenney pointed out a common
multi-segment compound pattern where the handler fires between
segments and segment N+1's arming attempt is silently suppressed by
the rcu_read_unlock_special() pending-gate:

    rcu_read_lock();           // segment 1 starts
    // may be preempted/boosted here
    local_irq_disable();
    rcu_read_unlock();          // segment 1 ends; arms defer_qs_pending
    preempt_disable();
    local_irq_enable();         // handler MAY fire here: depth==0, but
                                // but preempt is disabled, so it cant
                                // nudge.

    rcu_read_lock();            // segment 2 starts
    preempt_enable();
    local_irq_disable();
    rcu_read_unlock();     // arming attempt suppressed incorrectly -- (1)
    local_irq_enable();

Waiting for the next __note_gp_changes() clear is too slow for the
compound case, we need the deferred QS report sooner.

Therefore, make the irq_work handler clears defer_qs_pending whenever
rcu_in_compounded_section() is true so that (1) can do the arming.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8637f405cb47..2da009dbe64c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -621,6 +621,17 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
 
+/*
+ * True if the current context is inside a compounded RCU read-side
+ * section, i.e. either in an active rcu_read_lock() (depth>0) or in an
+ * outer preempt-disabled / BH-disabled scope.
+ */
+static inline bool rcu_in_compounded_section(void)
+{
+	return rcu_preempt_depth() > 0 ||
+	       (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) != 0;
+}
+
 /*
  * Minimal handler to give the scheduler a chance to re-evaluate.
  */
@@ -632,19 +643,10 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
 
 	/*
-	 * If the IRQ work handler happens to run in the middle of RCU read-side
-	 * critical section, it could be ineffective in getting the scheduler's
-	 * attention to report a deferred quiescent state (the whole point of the
-	 * IRQ work). For this reason, requeue the IRQ work.
-	 *
-	 * Basically, we want to avoid following situation:
-	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
-	 * 2. CPU enters new rcu_read_lock()
-	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
-	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
-	 * 5. Deferred QS reporting does not happen.
+	 * Clear defer_qs_pending when the handler fires inside a compounded
+	 * section as we may need to rearm the irq_work.
 	 */
-	if (rcu_preempt_depth() > 0)
+	if (rcu_in_compounded_section())
 		rcu_defer_qs_clear(rdp);
 }
 
-- 
2.34.1

