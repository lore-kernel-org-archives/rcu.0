Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E916347BDC;
	Thu, 18 Jun 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808681; cv=fail; b=NTdWAQKQOsBwxzaUeoFLNO5w4UACcrGDmZesqq3EgJvnDJJwBFsJmBvw8eKioTn54Et7jzEcE82Y/3ibhGcFovUvB6PpIxqhQ2O5EkDeNAEYimCIyGdOtZJS5Z1ULE5VIBmYsIA16uAhR9f5xk92lYNhezO22Y/NqIv5HdvX+GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808681; c=relaxed/simple;
	bh=sNzdxytoBechEvKKJnuMx+G/XO/jUlvbQQkcFNUwhLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PkHlgVMVEDO4CmlBaSPTXeoIMxfw3top0OhbgpQA8kHfqSiN9Fo2mzvgnrq65q+ybJlZ7GtzEtJnb01+deEw+gWvXmeofUTPQfE50tWKSIBJTAD0Z3ydztNaFk0/rzxq6iwCB0nwAU0Mbpp6YGpH+h24AkFGn25BhebqwlqyOAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EbaHbvOI; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EbaHbvOI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geBpElfPsnP/YHZSGpXtjpzuDetFRqnqZRLhRXiJSFHvtJz6cxVE2wJYTRXKhG/XydtOAfp4gni2ldmZfNxmsHWLbYd0BwnbA4Eg/VpQMP5xFDN36MHf6rY/rWqtNhG/eloNo5W3IIPrUo6aKV3q0/O6eh2qn0mF1dr2yqwvZnOyV3/vCic4on9Ar/aRbkkRdj0T0KcMUETbBRg7oa9Ouw1G7EiP6FQUfdYhisIfC3/5ccmh/MCdR/36DKtT0/de5tud0CY39t9esX+cPL9lXLNbOPdIqtJDVl22Bbh47W5+xhAj2P5Xju/mzwcBOum83KisOLeJVzWUz01BfaJOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1YouM4wpBFrfULDHc0G/kHx5Tabrcs9Hjji7ybst4o=;
 b=d8SG6AyfMWiKKvPCbNNOqDG4IWTxytjlSoIJuNgwsdFj9PKrC4tDBEQNa+ToRuhfyBtI+ns6fbfMiLBz9HMJ5/n2bripAfyjBQHwxOLJ8EvnEXR/tyckXqGvXfCCXwMZvq+SGxo4h3IPNkCCUUo6tcRQu61Bj6FBukVdDBCDX1LqggkP1UFaHkGwjFfoIgXv4uPcsM4frBDrcgbXTKliGjsfK2t9NaA6N9jiFSR0HqKjeD7VnNh7r59d7glcDeZpy4wEaLoCmSkTCewILoJ4NQEXIac4qfqMu/SNdfDdPGCaTaYcmoTFc2RL5wjIgnLZ+HO9tHH1J4Mc3pj0Q/5QKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1YouM4wpBFrfULDHc0G/kHx5Tabrcs9Hjji7ybst4o=;
 b=EbaHbvOIAeIjD7qy+HmWNkOxAdNhnoS1rvTDnnedFOinIvfz6w+oYAHeNcE8ERoiycVdr8QkkfbAVa5oqX3eO0SkJYKCQ3+RE+e+CoqeOlL/JI5HGw5tJx+Y51Ef9BfURKYpDefSDdBRoBXNnyDtLOU7m+/lefGGgAnTIyIwRcdTk67FH/mtDyV3IREnY/ZFHRt6xAPB0kbTDN5uTLNntIK7BVgvKdfwEm7ZSFYugmVgVpmymATkH/xnd9SUK3qOl1o+JKdiNgV/CubBYe9T5ho+9lTUWZMafJ6qNGiAFE2tePIO32chfWQuJ3U5cswymLSWO6KxRRqUvWwnAlhRSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:13 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:13 +0000
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
	Davidlohr Bueso <dave@stgolabs.net>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org
Subject: [PATCH v3 01/14] rcu: introduce rcu_defer_qs_clear() helper
Date: Thu, 18 Jun 2026 14:50:17 -0400
Message-Id: <20260618185030.376450-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:91::11) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: fab9b24d-c1c2-4bac-747f-08decd6a9110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WcP3bvnCh852dPtG388GCghG/kBW9t9IxDXd5CqPHRLYiJvBR3Vgv3H0TOSRinG6VJQEqv7U+bZ1azIXuDXMu2gdwyVKActO9OpWW3WFr6tkngsoIc8qPoKae4MMfD1z5EMJNUv8H4Gw0JWZUWLRRUU+VkHaYh6vQesDRcw4YZD8zI44sJcdmR3uKHSdp1p65Xk4TnQBhZ6sLUdrFmtcvVQnZgrQt/85mVOvgto3FPZyVoziJcReYTjfFNXMJn+5CWGAcZKRZk3SChhuze8eDUIX1FtQNdBaXJlEiiCg28qK9b8gtYAEqUuVVR+eTmLe8SvCM/y38H9jbLtyFZ9X6CSlRGAooQr0wfPeZxGmIdPaW7+uADpjuPsxCUhvBdzJ5t4eBYBsNoiFKNqgAQEK8T6F4trd2cMJJ8Sn/xi7zibJoxgc/IL7dg2r9gVENoSY4FZ+UUIfiwV5yJD2Rj+9HNBaWMKw8TyapnyjOP0u5R5gaxvFJ6Qpc1D9dBXN+RuC0D2qXwXdjU8SHZYKqPN0z9T+pIEwOGbk+cBnliyf7Kxpru7DRTmf/kalv4i2JKM4FiVctCqseJhYNkh/qG2jumP6UPlIMU4QrkcuZPx+kMPP4hspviaftVNXWg+LvCx7Em++6TM8iMubG/3MUT0EX3SDcBzsh+86RmICl8QsCpHwlLObnMgwv0RlbpRe5UOR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Mz+O0h/MoVQooCTWElI0SH7qXb0RhzM0TqdYeTkmweWVQ+bwUeqVbQqklwH?=
 =?us-ascii?Q?2ErsBFIgNOPniVu77AZoq7eqjx6bJ92wk9vwN6JXpySqa4lfh1xQFp5EJite?=
 =?us-ascii?Q?xYtAn2qviexKS5s0n74FTAzEhyAp50wsQiWxvSmnixkUW60xS1zzTsEBOnf8?=
 =?us-ascii?Q?zr8anNsUoDK2CzQLmeM1vS1dDuWfv6jHpl+WD/q15+8TzD6UDuzbyig5lX6j?=
 =?us-ascii?Q?8geTUjFL+T/mn/qIK98U2q5KR4Mu4pl+URbnFzJ4vxlPrHH0sxPSY+60fwET?=
 =?us-ascii?Q?OoEUBUesLHWJoFY9ZeE8rAfSaoMdgh3bjFbR+xxp6c2Y3wLM5S1nvC2OLiY7?=
 =?us-ascii?Q?UKUu0gOHb/KtosFPz8ZKhaD5TQoldrD6QthR+Zu53o7uRqaRvZOmEGinHyjo?=
 =?us-ascii?Q?jGPTUrK1vJ0/EmAFGh+2Fddf8LwafpyUjjyld9s/my4rBNvBibDi6XgYnYsi?=
 =?us-ascii?Q?mPPg+hml5gRRb4YAhK3S5u3BBfzaqAWYoezKcODhlpQyGmYwYed4w/1dDf1l?=
 =?us-ascii?Q?9VxUm9fhGBpB4ucfLvltJYybj8YwN/C0ZuFYQ/fre7pdMfd1nn5BEKUzR8Uc?=
 =?us-ascii?Q?V+TVKasjY0CjHM95xr5PtM9WguPSpFVzb6cKuvB70kioz6vML+lZZKkrQmYv?=
 =?us-ascii?Q?mX3j/qbbb0yVcrKQ42w80jymQtWHbGnrBPswzwQS5UQs24heJEfzVqLA1Gqa?=
 =?us-ascii?Q?kQLJgNiEwcgn9ITZL8G6gHB/3g1ctyXDA+V0cxAIzMILnoBOt+ou+KZ+DVSo?=
 =?us-ascii?Q?o1Jugy9uuLecttocSS621fLOgt56OQicr4Y/oZpb9eZ59rBp28lFg7tNy/ZQ?=
 =?us-ascii?Q?TJyfR/xA/2+Z3v6tP+iV8mN2Q7aOA7Pz62JG3W3acHTKjtWcsTRqLsHls1OZ?=
 =?us-ascii?Q?3qeGeiTtdyvvsr9OuJH4EU0BkBSVZVDTqkm5+/6dKYP0BlXyzJ2wQve6Mw2t?=
 =?us-ascii?Q?00c/YsAu30Xwo5z26ycuhIomaX19pEtdrfzMVufmasFc8pBJEeVTCBxQmebB?=
 =?us-ascii?Q?16dAW3+gmpdNl81dp5hb1ZPHgp7BBa5gEOKkYCVftIbp6v2TNm0JqJtCi+1a?=
 =?us-ascii?Q?cw6HRPA2DKm+m70GQZacm3qy6AwJ8y4JjJ0OfRFz7mPFRdgfh1cWQXjhc012?=
 =?us-ascii?Q?wHFA06MCVa8sqh3yg1BpewH1VCFnLS80Z4FYkewJPLUtkxDgomuk7SdDBooA?=
 =?us-ascii?Q?RkJM51vdqyxSQBpSkIaWWfM28Q55A516rywz8pbFl6mLSBbwlCmg1xzG9QlW?=
 =?us-ascii?Q?kP7jFYLcAWhA3Ng0IaWG5oPPO9C4WxekM+dVAVTJOfO53mhRPQ6j2vvWmQ3I?=
 =?us-ascii?Q?GGCLQsvA2oIcI+TostQ80si4355vIT3XU1BTSj+VE1tsDlvLALTxfDfUuhW6?=
 =?us-ascii?Q?QvnJLSUSMoR3hdkksXILjEvtabuvwOF33VZEJCz+VxYLXSWR7HUoPrDqAuMZ?=
 =?us-ascii?Q?s5hh/LYFW8sH2lX1ItqEq86MpkSUStyzN0upzmOWiTJD+unNDG0oWx89a+Zt?=
 =?us-ascii?Q?ZNheICG4DEIP/dvM708TA41AbqeoOjtcxxcJmQhccYy6WIu0KBwcWwtlxN1g?=
 =?us-ascii?Q?qMHvXXkejqyApLHm3FincjKL7ddEBGD4cl54hA/cQdL2WXWUi/kWuWcF7iUH?=
 =?us-ascii?Q?UOA3E9sswMzvAsZ6fznIkkHUthinGKt/IQsHvdwMsknSlyuYMBjnmPD0MdOw?=
 =?us-ascii?Q?78iB/NznTGeG7XsG0VF116Rx2ttMXGVa84+uvADV/d4F8yRz8Op82PmPAN0s?=
 =?us-ascii?Q?mzQB76aO9A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab9b24d-c1c2-4bac-747f-08decd6a9110
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:11.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8v655wLrMfo4ueu6Hdb5Ahpt+M29k4VWBv2SaK56wptyvL5nkWbTmxqb8YeYJospFRA1OLzSKKkHuawA0R9Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

Currently rdp->defer_qs_pending transitions from DEFER_QS_PENDING to
DEFER_QS_IDLE at two sites: rcu_preempt_deferred_qs_irqrestore() and
rcu_preempt_deferred_qs_handler() (depth>0 reset).  Both write the
IDLE value directly.

Introduce a single inline helper rcu_defer_qs_clear() in tree.h and
route both sites through it.  This becomes the single
PENDING->IDLE transition point for upcoming work.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h        | 5 +++++
 kernel/rcu/tree_plugin.h | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7dfc57e9adb1..4069132f9d44 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -296,6 +296,11 @@ struct rcu_data {
 	int cpu;
 };
 
+static inline void rcu_defer_qs_clear(struct rcu_data *rdp)
+{
+	WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
+}
+
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
 #define RCU_NOCB_WAKE_NOT	0
 #define RCU_NOCB_WAKE_BYPASS	1
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 95ad967adcf3..8637f405cb47 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -488,7 +488,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 
 	rdp = this_cpu_ptr(&rcu_data);
 	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
-		rdp->defer_qs_pending = DEFER_QS_IDLE;
+		rcu_defer_qs_clear(rdp);
 
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
@@ -645,7 +645,7 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	 * 5. Deferred QS reporting does not happen.
 	 */
 	if (rcu_preempt_depth() > 0)
-		WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
+		rcu_defer_qs_clear(rdp);
 }
 
 /*
-- 
2.34.1

