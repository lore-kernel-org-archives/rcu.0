Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E3621507B;
	Fri, 18 Apr 2025 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992959; cv=fail; b=I8+jG9kV3rHM+xoPu382FJ95JNKvMe1xOFQ2qEjET01uBEQV4hQ84EPhnYij9kfHQ73cKDOUWG3X7irrt7y5m67pxrJjfWSLU5FXq2tg4oI8fsIV71JphMBlF3ZlY+e3PSMTe2qVDerlcrJpYHZ7WP9n6OTs7r59bIhISwoN5k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992959; c=relaxed/simple;
	bh=Wv+SQM2FUFFr+zHFUE4QLhHfumoC15sP+Esnt4564fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5O0DSbdiUJW2AeTtyy6XZDq08ZyMG+goE0Lv7S+svTX67aWXw2P3OGdJwHd+Pyid7r5O9PlHOK0SFCagAmYcuyO+9n2UDZBWYKwhsH2/3D80qL0CX1MkmuLH11wkQt2biTOWH3UB7d1Je9TIHaOmZpBxNJpR9xSBoN18nqK37M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=clUe1Z08; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="clUe1Z08"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XELoURG+GgVGInk0tiP2xEuXvjH50v+WYDzaxRSAIzPCHkj8BRyB8DTaOcfgoE09e+zXim11uAb469I2FXAJiLSv6X/fd5sTMY3q+yfkjHRQ9vvxAAO6t72uzi7e3beumBaYTF8wtMB9bcY9bIbHGfsM4cA9k09FOwMoaNFAH6u+YN3ghoKT9/dQMTig1qxHV1Xg5o3V87J4ItKP4x97Ol986QUtoClT164urwNZNv5tj2GcA2jo6gR8GC9mvDEPD6IS3DNN/pUGSlVkaAULqyTYo5c6sOXjsepfEcPsbD0MLXJIUMwUfT02AeYkDUYYNGsbHd8HLjlXT1d4AJ3Vdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoWIE52h9CwXXM3CCiuTnpUhWzhYIqQjqLw+n0wGkQE=;
 b=WXzLzd1jJ6N84WfrmQanGM6/x/agbA5Gq7WW00o2kYyA1p47a2dL1+efP8wrU0q+0PAolOw71ar2bq2gzObo4218bSsQ2QJfIamNQM005Qoc7EK18BuvmW2Y/KDcjxDtOS6M/yJibauyLEuiNNZd6pRWziB2aatDwoUDgE0dDzrCoHFp30G8aFdCc/u9PrVbKIN+ejVAYEp4lKBFUb3U98h7YXNpWh+SGJ+hJZ6cXBIzmK7ArML/yA0iX642fy3N5rBw3C0O2tcPKpWEuUvAqLbJfFRKQgaEnhueHNscXBbIO7TAV2LkWgyDNWXDNbrqj47Q5NSvY3/3pWstn8fTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoWIE52h9CwXXM3CCiuTnpUhWzhYIqQjqLw+n0wGkQE=;
 b=clUe1Z087kgttVridcm7Fmy3LQXXryCPscErYLDYdn1Udz9QbDzOK0c4JSLGcTDE8hQE5gcb59dMt4ZBRkP91QK74b02NPkPtSn+cZdpomIvOKsTG0xANRLlzzyH7mu1epzzxeEPUecGvFSwqffrJ8ZBMjitGINCgvVFNz2iGyI4d8nuDZyU1o8jEPxeEQ9NvO6tZdEAFz6DRX1qv7tNf9yYoy66EN1vyRiYFG2FPFMQMIRelX3kV/apWssZXUggGGcUR2mX5G29HMmHKEMujQG7Tj0l/bsh+sAMA/2hlxB6SHeEPygSldduICOo6BXHN0uYEIcaR+O3cYjIe0R1MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Fri, 18 Apr
 2025 16:15:53 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:15:53 +0000
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
	Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 2/7] rcu: Remove swake_up_one_online() bandaid
Date: Fri, 18 Apr 2025 12:15:35 -0400
Message-ID: <20250418161542.2429420-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161542.2429420-1-joelagnelf@nvidia.com>
References: <20250418161542.2429420-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:408:ff::19) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b870ae-2f7f-4906-7f10-08dd7e944b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CmC3PFpGtpbISJu7OLXWu1kYskTeZAGihMjADxPelRx29nPGpdnLE8DJGYbY?=
 =?us-ascii?Q?B5UnSJJCISdZI2S1GAm8KBcstqqskWWHRlHT7PWd5ih0qDJ0v7WsTqigmruY?=
 =?us-ascii?Q?u9eZIilrkTpET5fAU3ROFC4LLO19I1zB4QAVot6yz6AYW5TCQUpdx6EanGB7?=
 =?us-ascii?Q?SSHRdkHw2iilnGgN5cBtADJkS5DRhoIigIgt0g9vW34WFYA25Ng+VVi3Gx6t?=
 =?us-ascii?Q?OMa0N+Yo0KFq48jkJBoTVz7fZ9uXdI+fxpGXF6MmGz0AO8bKEtXTMkLHvo7E?=
 =?us-ascii?Q?I3ECoxYETfAJXhwmk3GlL+zb82YQBc3zJMcmW5kBUq4t0Zr/WDOpznFfgI6C?=
 =?us-ascii?Q?ImiBI0TQJWRLwklomaVQ6nzntEckNBw53KE+mnQ/rEzqn0/5z+KxK8KBb9uc?=
 =?us-ascii?Q?BiRoc2xVS98R8hFzY1f9L2pPW9DJVJS40txJ7SGiRbNjDqTA+2DrA1+qxPj0?=
 =?us-ascii?Q?wyv2VQKhB3B623mffgtgXHhPORsuG7m9cjvwGO/kgnsp0pIoIuHabHHVbeCp?=
 =?us-ascii?Q?HYX9yzZWZLloHfTnd+t6Q82kuyHD3lZLewHJbOzXqAc1wNxs5UGvBVSmy5Gr?=
 =?us-ascii?Q?r3OeNWHfoHZpmYh0LcJcMe8tO4aHWde5VWt8MuINyjSu8L+U/ELHz3TkmRyc?=
 =?us-ascii?Q?Pe7h5ltSorAFU3ftsE3tEMcm6jQ992hcsMQG0g6yQrdHAJLLHWfulCOF5Tbc?=
 =?us-ascii?Q?CFL5KLYHw1nTZk/pjqufWBmRx91sPqDCsBFRqqsF2mYFqLLXWUE7bAwbCF07?=
 =?us-ascii?Q?UcVxOd7ndJTYcQiEemyzK1Dp/yvkgzgABnB+0hkcz0ZYvYWbJ0yCjhSrjqMS?=
 =?us-ascii?Q?NjQ9lI8SyOiB3xywb2DC3ZDZ39YfiJZYAmYzITDXpltjcD0e6BIvgvr2Ncin?=
 =?us-ascii?Q?pK6h9hPqiMtUUaxdBaLU0QYM5ZCTatSVk+c6PIk/JqO7OPA6Jo9lto+HSt2L?=
 =?us-ascii?Q?eZ/y6h3sQl7epXO2ipNq+QWT24AU5FmIe22EgeIjuQ9jUe7REChhWpXOpXoN?=
 =?us-ascii?Q?YwPXpwXUOiIWX2Hz0lqvsPPbKwT9AXfoAsPqYgB8+MU90BbnYJGT4V8P0Hc5?=
 =?us-ascii?Q?I5t7HBscA7YwvWYq0m9c4dJE7HZEQ7CBLU+e70Uf171mfKUuBpgPeRkOeESd?=
 =?us-ascii?Q?eH4UI2xBTLsKTSkK1j2ffMY4ECIVm+IllZ3M6O57/YaGZxFZNU/G0gcArBfe?=
 =?us-ascii?Q?qR3h+tFB4nwaOj6dXnyLOcfY8PG+5VgxryfUSpXirrtfGuRRrZYmCwq8B4bi?=
 =?us-ascii?Q?u/fEo+evCLkfResegZ/tfAfHst+Kq1+Ui0QQE/dqfvaBiNEprf7c6BLe00qP?=
 =?us-ascii?Q?jbwZk9yZzEelvtmJjpMmkv5+2iK+eRPjWSudQSFaKCSPRo3LEdSnsNjJtyP1?=
 =?us-ascii?Q?J5yWOesyRENXggIcPo97wAaxbTnZ7lstyrEQ79zobPDRNTkhgI3iCNB4AUGK?=
 =?us-ascii?Q?ORhw77hB8BVao6Eo21FQO8ybOZ5alVkd0RTgbQTaWsFgAntQebZFzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bub8eOvG5QImTTocGwAdV8aI8BhbcVs9quYPnApyyNHNojtcUjNzf/GgXmkv?=
 =?us-ascii?Q?zXjyJ3ZxPvNb2o1cbpRptqZDq+ncm8F30x31AuzrnKeN6x1wMqBIKJb5W+nk?=
 =?us-ascii?Q?jvBZu+GLrOzkPeynNWXmeudoXmlHKdOBxxjoCy0UkLUy/IeqsnTWXC8tNFap?=
 =?us-ascii?Q?+dOwCCoGTMhnJ2Mrd+aXhmU8yp8FLVBr2SXOiw/Z3oIM2H8Yw/bPRDCty2hL?=
 =?us-ascii?Q?Vu7OjW9Xc2gGAp0j8ZbXL11nYhUUYPHBcDysRwT3EnM1Wh2NyAh7f0ir7A+z?=
 =?us-ascii?Q?9acTjIayAwa/ijHgNV8RrF2KOBQ4trJRq2ZqZ5vyEFm6dkVii+6TwKP+F0Ri?=
 =?us-ascii?Q?T/QzeCaRU4jI4J3AUsL/EV9Y9EvDe3MCva1sa5HaN0Am0uazgHTT/z+7XIN1?=
 =?us-ascii?Q?1GAljGQUAExfcc8zzU7rno5lxxFsb56VL7PVwP9ueNF/718vUa5mPhzwSWya?=
 =?us-ascii?Q?o+QSMIGM9l2E88lPjQYQHHyF+Q5QzCMt4s/TZPr0HwpOX0CvFr7xGqwDAKr8?=
 =?us-ascii?Q?Ri/4g28ClcAwypSfd9zJiZkFMmGS1eUr2UFuAbI64RJNdfzviEdz7h7Fu7QG?=
 =?us-ascii?Q?1PZEYJEqnspI8plVP4uz0wmpaSr5iaHDtD+er+MjQe5d0GFtSWq9K5UnoAgF?=
 =?us-ascii?Q?4neJjDrf6FqA5RzZzCXMbNhLS0BWPka2atLaZWt0lggwb+DwD9XoFFPkLu2w?=
 =?us-ascii?Q?EKI2ho7w5pcXrVfe9yh1FuPx1HE4sunrkakUMzZZZQuqKrsYRghhgBX2cn9F?=
 =?us-ascii?Q?8cF2T/RxxgfGx3FMGR7L9gU+3RSuS0fPpyStNC0yBuTHl1pA42tftZlAAR+H?=
 =?us-ascii?Q?ubb8prrAjZ2bikwIqyPEYNawpJnzM/1lYFdEPSksd7rppATQZYaQVgAb9dat?=
 =?us-ascii?Q?pFKk1EZPOr6GF0quw76pM3BQ+iqdm4gHL58PAijW6MBi6MeleMRyoWeLYu41?=
 =?us-ascii?Q?syqZFEcRFTL1v3V4BDmUV4F8C6ylN5lc8pR1afYq0Wm7lQxl7i85GPITMPUi?=
 =?us-ascii?Q?Zl8Zq104253HjtLdNZ0paKDO1PG+25yHWhN30zfMyNNK7oUBd4Z9XWt3ke0t?=
 =?us-ascii?Q?YUqbekfTJjQGVV63214JabZvkbleaFat/rr/5SDkhV0n9TGfDfDPkTwCI5Ud?=
 =?us-ascii?Q?W1mT6HpgY5OyFQ85LqgL1rFKDhPoj6NlFPeYdkOO37HfXB4fBumbJfSTE8l4?=
 =?us-ascii?Q?Xdorg5DawY5cP0hn+Ur7EUpXKyAje4RRPpIkUqEJBJWLJhGPAhTLW2i7S69x?=
 =?us-ascii?Q?midlxfg5bypgqi+1zbB6A5MWiiO0yNEYIVFVp2AFFY7bRJr+QCwOkLk8JH/p?=
 =?us-ascii?Q?t47hzBOTN923qKV/dBhuqVnEhvG9Xh+2Lr3VmJvus3b6jS6MaKZUAwo6J0I8?=
 =?us-ascii?Q?25MCwDsrvbqk7Da5RWCzuwVKlV55PigiKPnB6gza1A86p8DmV7LLRy1vRN9o?=
 =?us-ascii?Q?8ZbWLEmRhs6iC+/pz0TNTKch8NplN9eGvLQ3RKtwfxa7gbEuNCOMkscD0M0o?=
 =?us-ascii?Q?G5e7oUiddLwNXkZF8fbLgvgqjE8FCvnIQPFV0maaFYhQhhZ1ZbX8oIebxeFd?=
 =?us-ascii?Q?AC7aZKJgabco1NBu7eQ5hhNUlkmN9CWlFZtu8Rqe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b870ae-2f7f-4906-7f10-08dd7e944b15
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:15:53.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1s1IvhdaMknbUgR0H9MZ99p3LJBp8/G1wj26YYsEfwxvG2vH16Ftg1QhwnFqWTzNIoYSj2PiDUKWUZSTmlemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

From: Frederic Weisbecker <frederic@kernel.org>

It's now ok to perform a wake-up from an offline CPU because the
resulting armed scheduler bandwidth hrtimers are now correctly targeted
by hrtimer infrastructure.

Remove the obsolete hackerry.

Link: https://lore.kernel.org/all/20241231170712.149394-3-frederic@kernel.org/
Reviewed-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c      | 34 +---------------------------------
 kernel/rcu/tree_exp.h  |  2 +-
 kernel/rcu/tree_nocb.h |  2 +-
 3 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 659f83e71048..1b8eee06183c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1060,38 +1060,6 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
 	return needmore;
 }
 
-static void swake_up_one_online_ipi(void *arg)
-{
-	struct swait_queue_head *wqh = arg;
-
-	swake_up_one(wqh);
-}
-
-static void swake_up_one_online(struct swait_queue_head *wqh)
-{
-	int cpu = get_cpu();
-
-	/*
-	 * If called from rcutree_report_cpu_starting(), wake up
-	 * is dangerous that late in the CPU-down hotplug process. The
-	 * scheduler might queue an ignored hrtimer. Defer the wake up
-	 * to an online CPU instead.
-	 */
-	if (unlikely(cpu_is_offline(cpu))) {
-		int target;
-
-		target = cpumask_any_and(housekeeping_cpumask(HK_TYPE_RCU),
-					 cpu_online_mask);
-
-		smp_call_function_single(target, swake_up_one_online_ipi,
-					 wqh, 0);
-		put_cpu();
-	} else {
-		put_cpu();
-		swake_up_one(wqh);
-	}
-}
-
 /*
  * Awaken the grace-period kthread.  Don't do a self-awaken (unless in an
  * interrupt or softirq handler, in which case we just might immediately
@@ -1116,7 +1084,7 @@ static void rcu_gp_kthread_wake(void)
 		return;
 	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
 	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
-	swake_up_one_online(&rcu_state.gp_wq);
+	swake_up_one(&rcu_state.gp_wq);
 }
 
 /*
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8d4895c854c5..c36c7d5575ca 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -200,7 +200,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 		if (rnp->parent == NULL) {
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			if (wake)
-				swake_up_one_online(&rcu_state.expedited_wq);
+				swake_up_one(&rcu_state.expedited_wq);
 
 			break;
 		}
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index fa269d34167a..109bc2df1d9a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -216,7 +216,7 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 	if (needwake) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DoWake"));
-		swake_up_one_online(&rdp_gp->nocb_gp_wq);
+		swake_up_one(&rdp_gp->nocb_gp_wq);
 	}
 
 	return needwake;
-- 
2.43.0

