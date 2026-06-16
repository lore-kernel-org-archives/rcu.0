Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28E3ACA71;
	Tue, 16 Jun 2026 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648794; cv=fail; b=XyeTmvLrx51GLQDmFO4CzsfXITrnZ8Xemz/kOmd70zm2KZYZ25M2sh+BAmmPpMmbzJVAvrE7M7MSqWWDrztYUDMtedQGhlqKtjnSOn4suu3KtePsGmyzbrPRGi0iI0AJf+oab3SnEXVKdwLGI1sBN+QtqGj009upbWRJqT0sS00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648794; c=relaxed/simple;
	bh=fk6oqn0kK+fDzNEw8Sv005MVV6gqRyz5Y2ToGOITUB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VvMwbx66LeFl+mQ6umooFUwlFipq60geBz3uejV9hyyBvb6S4Lu5KL7WkaCWWripm6NYpd7AUUSVhw1KDtxBFd0O1SjtiiwBWTT6GnN/OeXAfxC1VBJMwPBX0w7TrpP0LGuEZXu+KeBQdIkc+0tEsBCyWCqHo+HYhUNgGd3BQ2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VphC02GY; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VphC02GY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef3H3OgQ1J94Q0BxoCaHZxTHphoc5vTRkR9prysIGGkF8289po/k6AHs0WV6DvNC7sr51W+DoAkoJ0mrUGsIsrbSkyDm6E4+Q8eN6y4vc/WSlR/PKifLuEXnSSl3BmhxOfk3363kjTUk2cNOXfDGVhrSkal1Z/zy4mGxGNCiVrbTnslHzokHcI2EwWBteByJVPI8RFokpQXLvDSUDSGXMxAUJ+4TWb8YAY89/PPECwo3ZPGfsn9c/a89zrEIYTXsbTd+hdJwKtY30kuXm1R5UmaMIvzCvoYmAvK6IWE4i/m1CsOxIEEiygLYV9i/sLRBZqCw4n8XvbU23T46UkYyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOLd6o1HWrZjz7ZySqyf1s9Wqb8TBcNhXGqF14sJ/HE=;
 b=mtwyChXj7JcGudbkFYjxkGdGwB11UidY8Ue3ZC5CUHAFYc1TDGlMj/r1z8hnX6FLqqWeDx/dlB/12LFt6KHa5yMXWYNSlSerQZaZw8wxkDGhY6wEaMZqW6k6aPba+T0Om5f8PrVNAvqLlDtQF0znPSmum2IccqqoM97RXYU8LfCIslvLfA8bSiodzJULTOnJ8c3Hb/CwJSgqfWfBmE/DkzlHPO7wXMc1XEUIylLXjLWUF9xwpbuXx1GNxmhggMcL4Lz5qFVdpp0L41h3vh5MA83xdH0/CAmdNFGhIwbjHpw7o8luDbkujOGsKeZpps4Jv/2cN2+6D3afZFIel9OWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOLd6o1HWrZjz7ZySqyf1s9Wqb8TBcNhXGqF14sJ/HE=;
 b=VphC02GYdTn/ThhxJuBFtO6+/Vj6woviwxKDdlg49DmL2X+ROMt0a6g9uwLiLkfkj/1xxcrapX8FDOOKI+LnRltARhifUFthsCinHK6N8pRubkKLdNsdDDybWPRtBVM+O8fxbhmi/udTXnr5FfBLCSLSjvjIXbauGRRhM37u2By/V+5trEx9vopfuggkM06w8aBiENEv87bnwZ6P/74vF8kTaf4/dJy7FbcmZ8le+VQqiDvkf6x6Rq6H/pUt+jhyhs4k0mMCYbDdDLL2mdwNhdqw5Ofivat7JZwMzGcVEfN08ZnHq3MFd+JNvmgBqWpX5Ox6vQNW1TdXHb+QxYE6gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Tue, 16 Jun
 2026 22:26:28 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 22:26:27 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org
Subject: [PATCH RFC v1 2/5] rcutorture: Check for immediate deboosting at reader end
Date: Tue, 16 Jun 2026 18:26:19 -0400
Message-Id: <20260616222622.2981876-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616222622.2981876-1-joelagnelf@nvidia.com>
References: <20260616222622.2981876-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:52c::30) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 9634be48-26ef-403b-c04e-08decbf64eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|11063799006|5023799004|6133799003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	DGsoqnGRfnmfBfZDNOD+0Ewl2/76IZ/JRDR9p+Kx5PDY2YOAROJe3wpKeWWvl045+v9Nq4OHORuW7n8FVSnI7yxvciXv1KSCQhjUfDEPulyEaF9ypd8fVOqyk5k4G6blXmCXxxE0Ppz+HrIzUIwJc/I0k8vapGIByM+4YpRtAAgKCdNH2VYXSF84XSOyk1cc4zC5ggoh1arvm8IFjSl8hSm2myvrWD3ayRS1pW5+mPfbe5OMly9UgD+vooy16xng3/J2J4OkDqcz8okL6wcrjiMr+X6JXqlHj8QmyTy53v6fRuk2HCCe3xt6ccfkyqi4b1IFhdejCWFowt28pG+MO9B6QHy8hVD4BIp8Q4ilp7n9Y8a6sJgWxuHslo/TsEKuXfJJfu+9zM9m1OY+LMuIJpyz1WTiy9DX4/s3RzZseHICBUj2+cDJtTQX0v1DZzU1bnKxv8PRC8bXcpPUTc/J8ZBZt9ARQqqsjBCQESUC/+uLgIxYPYowi3nD5gCUo9pyw2/gEboB/UzOZX2ekLRqWOZfKBFrbCeT+hZ+iDNPUR7IKOt9fiOcDtUzZ1/UP/6zt4vTX7VcuMGwxzelbWExqP6khwBmaI42kuQCqRxgb6FxLKWyT9jhYRyVsp/fnEPt0aBPZxg3tGWs0P0vlyz+En4hCkXTixyoFS4EGGlL87DtkgO9+sADo1wFP8MiL26f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(6133799003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PEzfKo2SS220RKts0iIc6E82Mrazvt3UR5ABXI1aN9J4V03mQpRWrXAtz7x7?=
 =?us-ascii?Q?lhz4fxFv5cHhqMblDLC8fJ8/vSNYrXJOxdG3N67iJDRPgylfw7U2hgHLehwm?=
 =?us-ascii?Q?Gy+nVNf3T0w6n6F5BdTmlE0WZoyUbgzXVDt4MlZoMdEL5girdFLI/i7zqXCC?=
 =?us-ascii?Q?87vB/EZI0wpghRuD5mmzB87H9x2RkB9zlzoKOalZ2ou6nffRFQKJKQ3RQWz3?=
 =?us-ascii?Q?Yf8a77ZjkwtVmy0otfcUSupPSFJVhZoxNOygvZlCRuMaA43PuvwSvbZGgU5v?=
 =?us-ascii?Q?SJ4a/Qh3CwhqbDyCFhNrJi8PgbFEpQ6kblnl6aUhQN6WJXvsAOH3Cx00KEfE?=
 =?us-ascii?Q?ZCOh7YKgVKIPlVUKypHElYPAd7VOw6JyyeaPh28zEnL4gHVEj0eFCvENmndk?=
 =?us-ascii?Q?vxlIXaJfU9mAWAym18DcD3dcxVlhOzeDpwDNiD4sO0c9W+4VvEwGC5cHceG5?=
 =?us-ascii?Q?D/5L0mCdWrs+nYm2v/JUBclpg5o3joYBQmdSJJNXzwMrBhJJkboA6KF5/Ovf?=
 =?us-ascii?Q?R/MXaNygRntBccdsiQbsrn3oTG83XnU+b8KwSEIjPDHa/Q7Ml4pGg5uxdqG3?=
 =?us-ascii?Q?EFFe/K1Z3ADhaITHnVdZ8OEZjFSWWd+3NoYNNc4mQURfPhU40Tz7+eXnosKs?=
 =?us-ascii?Q?6MIUuPBApcWgauX4UVDJ9XtEaWKQ+BItjgzYg0ygdYEBGNTv+3ONWZCp7sja?=
 =?us-ascii?Q?UHnWfJRjVm1+q5Dk3MlAb5c6/eqKD+efnI5k3oZn1KL9Z9aoH94LJTA98NPM?=
 =?us-ascii?Q?5wD2YMWKD3AvzUd0yV/b+aDhQTDe/S6AAj7WbyfSdtFdmvy4gSpNr0dHq2wg?=
 =?us-ascii?Q?3fJk0LKkUkXNxWGi67Simc37lZ9nitoCDqcTKHL+aHbon1p1JOfJ0EGsCjq/?=
 =?us-ascii?Q?CZZMZ+0FzPV7YWn4QDC8q3KlJ/DaufK7Org8iSnDKoVVtihkS72uktIzofhp?=
 =?us-ascii?Q?YKX9lz0MiKJigFpw8iF5HU6RuSRgpd+ej3vZmOPXBAoAszEi8D+mXHVCJrcZ?=
 =?us-ascii?Q?LXA/JqI5e27Lr9DWLchMcEQ7DvdHeivhJyMg9ua6GX0btU3tL1Pd55abwK3/?=
 =?us-ascii?Q?CF2mzOf0xri79TSnxur/cLJCNd4iqkXGvFFAA5su7VChcRN4dr15929Tniwi?=
 =?us-ascii?Q?/mY0S7meoYKBaAo39Lx3qpnOrnqZNwaaNilA6DfLFbPB3BcMbjLmnEHqZoDj?=
 =?us-ascii?Q?NX0+VwiBjUEk03Ooe4KCY3Gt1sWMEQybeTM1qYghgP0qHCQJ84tXX+c0Efic?=
 =?us-ascii?Q?xe1z9ctksVovdsaU8SwYNFDWNvxt2yV3nLHpfvF9fgba97YyMkzVq+hcKXE6?=
 =?us-ascii?Q?XoSkbPyGTdVc7n8PIJbFxLrNCSEs2+mwGwD1cdWRvlpNvkUY5lA+NyRQqIcQ?=
 =?us-ascii?Q?me7WpazFyjrgfgGzMbem6+AHHhW1KoKfQ5zaJ6/IMymC/Fg19GoMg8g6pI0c?=
 =?us-ascii?Q?KjVrvqd5T0GvfFt5rLitENQPTU2M+x5zJYJncdlqkcHiEtS+n1NlgkmtfIHH?=
 =?us-ascii?Q?oUwsKRrJeGFt0wqp+NO4ft8VoznkmKf7EVJBvCjdokBlRL3PAfbbSByiief+?=
 =?us-ascii?Q?dc2YBeFbjktoRt9Rrf2GhYNdcdzqY5EiptEHoa1iaVPASwK1bYZWF4LyklV8?=
 =?us-ascii?Q?muXJyzVL+hmDp4NQU+Wk2aZM9mx8Jmk8CQHyy3pgGfFrALVpRVvJlAfiId3c?=
 =?us-ascii?Q?rTY82KllNJGj+N4prOTRFUb8graw5OImrdvWWiLDWnx+4UMrmyj5EvmC5I4S?=
 =?us-ascii?Q?rkugiDN78A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9634be48-26ef-403b-c04e-08decbf64eaa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 22:26:27.6542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25rN33yDpdjljfKMK8CYcHm+Eu88ys3d+G1vWfYAKS+PxFF47Cqe84fOtBATtdGPj/ZWS2RwyVBuVvS7duqZGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a check for failure to have fully deboosted a
multi-segmented RCU reader at the end of the full read-side critical
section.  This check only happens for fully task-level readers, because a
a handler might have interrupted an already-boosted task-level RCU reader,
and a reader in that handler could then cause false positives.  The first
failed check (due to an RCU reader that was not immediately deboosted)
causes a splat and a list of the segments making up that RCU reader.
Subsequent failures fail silently, all in the name of keeping console
output down to a dull roar.

Although most uses of RCU priority boosting serve as debugging aids,
this might change, and in fact might already have changed.  And allowing
(for example) RCU priority boosting to persist until the next scheduler
tick could cause an aggressively real-time system to miss sub-millisecond
deadlines.  So we do need to find this sort of problem during testing,
and preferably not in the field.

The name and type of the newly added rcu_torture_ops function pointer
(named "->is_task_rcu_boosted()") may need to change should other
end-of-reader checks be needed.  But let's start simple.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h         |  7 +++++++
 kernel/rcu/rcutorture.c  | 22 ++++++++++++++++++++++
 kernel/rcu/tree_plugin.h | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index fa6d30ce73d1..14faa11ef23c 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -695,4 +695,11 @@ static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { re
 void synchronize_rcu_trivial_preempt(void);
 #endif // #ifdef CONFIG_TRIVIAL_PREEMPT_RCU
 
+#if defined(CONFIG_RCU_TORTURE_TEST) && defined(CONFIG_RCU_BOOST)
+bool rcu_is_task_rcu_boosted(void);
+#else // #if defined(CONFIG_RCU_TORTURE_TEST) && defined(CONFIG_RCU_BOOST)
+static inline bool rcu_is_task_rcu_boosted(void) { return false; }
+#endif // #else // #if defined(CONFIG_RCU_TORTURE_TEST) && defined(CONFIG_RCU_BOOST)
+
+
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 42f94c62c18a..04c36fcde5cd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -426,6 +426,7 @@ struct rcu_torture_ops {
 	void (*format_gp_seqs)(unsigned long long seqs, char *cp, size_t len);
 	void (*set_gpwrap_lag)(unsigned long lag);
 	int (*get_gpwrap_count)(int cpu);
+	bool (*is_task_rcu_boosted)(void);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -635,6 +636,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.format_gp_seqs		= rcutorture_format_gp_seqs,
 	.set_gpwrap_lag		= rcu_set_gpwrap_lag,
 	.get_gpwrap_count	= rcu_get_gpwrap_count,
+	.is_task_rcu_boosted	= rcu_is_task_rcu_boosted,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -2565,7 +2567,9 @@ static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
  */
 static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 {
+	static int firsttime = 1;
 	int newstate;
+	unsigned int nsegs;
 	struct rcu_torture_one_read_state rtors;
 
 	WARN_ON_ONCE(!rcu_is_watching());
@@ -2577,6 +2581,24 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 		return false;
 	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, trsp, rtors.rtrsp);
 	rcu_torture_one_read_end(&rtors, trsp);
+	// This splat will happen on systems built with CONFIG_IRQ_WORK=n
+	// and on systems where arch_irq_work_has_interrupt() returns false.
+	// It might also happen on systems using a short-duration clock
+	// interrupt instead of a self-IPI (powerpc, s390) or that use
+	// neither a self-IPI nor a short-duration clock interrupts
+	// (all architectures using the generic implementation
+	// of arch_irq_work_raise()).  On such systems, RCU cannot
+	// guarantee to immediately deboost RCU readers when the outermost
+	// rcu_read_unlock() does not end the full segmented RCU read-side
+	// critical section.
+	if (WARN_ON_ONCE(cur_ops->is_task_rcu_boosted && cur_ops->is_task_rcu_boosted() &&
+			 !in_serving_softirq() && !in_hardirq() && !in_nmi()) &&
+	    READ_ONCE(firsttime) && xchg(&firsttime, 0)) {
+		nsegs = rtors.rtrsp - rtors.rtseg;
+		nsegs = clamp_val(nsegs, 0, RCUTORTURE_RDR_MAX_SEGS);
+		pr_alert("Slow-deboost rcutorture reader segments:\n");
+		rcu_torture_dump_read_segs(rtors.rtseg, nsegs);
+	}
 	return true;
 }
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fbbabcf2c3a7..d495747e143f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1093,7 +1093,7 @@ void rcu_read_unlock_strict(void)
 	 *
 	 * The in_atomic_preempt_off() check ensures that we come here holding
 	 * the last preempt_count (which will get dropped once we return to
-	 * __rcu_read_unlock().
+	 * __rcu_read_unlock()).
 	 */
 	rdp = this_cpu_ptr(&rcu_data);
 	rdp->cpu_no_qs.b.norm = false;
@@ -1490,6 +1490,36 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
 }
 
+#ifdef CONFIG_RCU_TORTURE_TEST
+
+/*
+ * Is the current task RCU priority boosted?  This is used by
+ * rcutorture to check that tasks are always deboosted once then exit
+ * an RCU read-side critical section, no matter how many overlapping
+ * segments of rcu_read_lock(), preempt_disable(), local_bh_disable(),
+ * or local_irq_disable() made up that reader.
+ *
+ * The lockless accesses in rt_mutex_owner(&rnp->boost_mtx.rtmutex)
+ * are safe because tasks release ->boost_mtx when they own it, they
+ * cannot be boosted unless current->rcu_blocked_node is non-NULL,
+ * current->rcu_blocked_node is modified only by the current task,
+ * rt_mutex_owner() uses READ_ONCE() on the ->owner field, and the owner
+ * switching among other tasks cannot force an equality comparison.
+ */
+bool rcu_is_task_rcu_boosted(void)
+{
+	struct rcu_node *rnp;
+	struct task_struct *t = current;
+
+	rnp = t->rcu_blocked_node;
+	if (!rnp)
+		return false;
+	return rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t;
+}
+EXPORT_SYMBOL_GPL(rcu_is_task_rcu_boosted);
+
+#endif // #ifdef CONFIG_RCU_TORTURE_TEST
+
 #else /* #ifdef CONFIG_RCU_BOOST */
 
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
-- 
2.34.1

