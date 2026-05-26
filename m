Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8213CFF44;
	Tue, 26 May 2026 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835835; cv=fail; b=UnRwuzrE5nxvueT65ZpBoYvdfaTkDj3btUUv6za+GIwyvM0IU0TdkA0PPO7pvIOHZNqAgb1/y932G1tODjV/xX4PU47dR/RPziG4/LGfCuwvZglVs8sGKi5nsiHZFiJMcGflxnqLxO4euG1kJULdWlsrsaYo9fIlOXeD79kyr+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835835; c=relaxed/simple;
	bh=hsxPzI+av6oaL8CBIfvbAcFT672ooILCBEN5mfn38x8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lpIGFYjr8YuqMexcPat185FqXK4FiX8agEFQiFekDIynduBU174T6moAH8pFQzgTwxrnFtGjB4KdiYQVbN+/pdsg2Cn6PewMDcPjUHSTWtgJ991j2KfWS3quSaLltc1aJwdR1ug7sNvI0pf1opkADNOaWjYa2/KGk5112p5N3E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d7A/ZG9E; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d7A/ZG9E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfZULY/0ODyOzXDLd4YyAle46tnDNueRVeJubISs24HCIw/WaZvGqujiGYgKmvIfELNqg3JruykKlKzQLa2RsAfZaJw7Rv8W3wfXv16Xz0yieVs4B+z/+mHhfnFQk3ajGu7ROUB+Qh7xeMyJmk0kkqaDXmtRg8EmB/gv5kI78H9d8R1VhdInp1rThSQOeXG8k+mc24j+F3RLLPH8WmPhVhBLlQOmtiERqIB3WJThXqqXlWsVg68cbhuBcLBLfs8aXUaFQv/wfPQs6EPKAtqqJCqalY9stGqdigEK9B2AOHl1jBEqmMqmRhCu3Lwt0xxVZrYcXrkHsUjhhyh2BhYQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOTcX9evTxo1FRB9J0hTdp18eLGUmzDvBQomLqMeZMY=;
 b=yWs2N4MdwIrMBet0bHqe+Vq6Q9QBO3jEYNutcDo0o44rFdXJfP1mLCLv++H7jfI/dcnFqdfIkgBo6JCMTRVhSOHbQ0WTTtznGAMCH4DHQ+iFAjXlax1EbNAGaxFIfSCcr0IZAAxLU54c0tDABTyjNOGr04hXSQICcGWTnMwMiIC3zlC3tFG2BV8Cl6sltHPUYJRaOv9sYIIi/w+uFCT0yHJc+ieY33VfuYZbvxbkLexOP8xwVoamjQYeYaTKee/PpMvx5G7m1WD8CFEs0cLYbnjxTYu6qqwYtxqp+D/PmEGH85GIZdwsWRrSyXcCKbJNo3XGGuuGjqnkg+BfCUImzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOTcX9evTxo1FRB9J0hTdp18eLGUmzDvBQomLqMeZMY=;
 b=d7A/ZG9Eu48HAHtE+k6bRhMuWdxH7Z9JxWGymjF6as2eLAu4wIRwuo9OVHDte26KDRjmWP+W9aq+sP1hmyJvv/wnQNsd8sgsau7J3fSa0rzRGmlKwA1HfxmAE1JxmWAYeUuVqVkdJABpS6Kpk9eUvWALaNfeOVR3PkoRhPTNHQJhfdfia5KVWbXoNUQoorS3OcZhkgaiVVyKWSnoa0XS3PchV7DEZ5tcpiuvprFles2IdIXsPXjR5hq8IGGOlZzO1ucnYjSSmIdzJvahNfLyWY7ykT1nblqO3sJ+1KdtiVmMZt78cFN34d2HKL3HX1Vn2DbPfXWSjQ2mClPjZ/ZnGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 22:50:26 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 22:50:26 +0000
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
Subject: [PATCH v2 4/7] rcu: drop redundant defer_qs_pending clear in irqrestore handler
Date: Tue, 26 May 2026 18:50:11 -0400
Message-Id: <20260526225014.314734-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526225014.314734-1-joelagnelf@nvidia.com>
References: <20260526225014.314734-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 552fa7f5-a757-4845-a954-08debb792d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ud4HWO6yrUVjzPXrSxX7XLmT/w6uKW3cTpQx6tZzMRZnjAz3HNrD24dKhXxzzsUHggv6ttj+S7Owil9lDsoqZ1IXZEjPPBCYT3t3+CrjR8yJJU5R0495MhInFyy7se7Zbx4hQTP4vzxUXy73bl0fOmmMI5RcX/4nkNrvHxw4ZZ9ARZB65rj00VbE75KyicpYVVd5Av2XtR9i55rT9Gl08iGuE2wQtzDyFsFx1gvoQbVdtq7MQwbC9g7J5nBMBqS43kBXuh6jWdS0PAf7/d6WEkntMkqTp080VTI36cHlyD2krsUJLfIAc/NG5DHZAfRaX+ljAfUU9qw1VGtV2xxzYDNGKGf/2zBYlGjAU0QXIi3qwvHyQsRzl8PQbhqBvDn7f869iDEa2xah2HwWzDpj/p068A/2Pd2gqqSRSL5Exe6ehzlvOOFX6RzWqsgBDWlWTDgwRcA/6k0gC+G2dkOQuLhirUMJzZE1OGVB+JUPNPq6ZsWKGmG44c868HRkzySqziPURKtZzbv49Jx+vztmKjoGC1B7gjU6O0grSyR8dBPLinnolKirQ+5d89Ey0noRGssGgLf8ZRKg66B2wVCNjn0088n7u3LtIeri5zyg4rlSvMQHTzNFpvaEdAKfyfR2CaedlCA2rUMGLTHXTS7Fy92DMjAzJoxEwnb1W7AZRAmpv97M50wcv1m9ElV5rXJh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TxQldZADn3cjmcT6mk4LCLqrVvo4/nYgWBoUFdV+QS+TH15Cov957c8yGo74?=
 =?us-ascii?Q?LSUgGxoHR/YpMKfODxdELWJw3JJcxC0eRElELpnmSaMLt9SlQUKyKt/AsFlu?=
 =?us-ascii?Q?O6uXZmbTA6btC5seXHzx8GpVwoiq8Usj+849fqYn9Z33ULpkFPz2drS7p2Ev?=
 =?us-ascii?Q?C9cUqOIbKXueQ4TA0/EnyMxQAT/B+9nv3kdHgAdpOf3nL3Ia8+y5q7hhsQrp?=
 =?us-ascii?Q?X4QuMMXVxT0ttm4IlNygHlby/QJ+13abG+B5TrUYIF8Sf3TDrMnRalVjHmtl?=
 =?us-ascii?Q?ZuAKKhgbB0Grwh+Ud8xoCycj6YgZYV7MencUaOQ/haIwU/1Dao1ZiZzEaFkd?=
 =?us-ascii?Q?DBAZc6XdtDE4btgbH/H1bhPOkiseQLvJWxwSWwAzDDqkZFWEGLEV8sHqGyp9?=
 =?us-ascii?Q?6W6O2L8P9CxOMN0rqixrGrbVufsWepk6DM0iYyjhqewizvVzDqbdaPjyeatb?=
 =?us-ascii?Q?Sn64sDFIBcJECoPLzF3dQiNTgd2gZukJVBUuyYrDVdzRqF8PkS3ENqkhUAs8?=
 =?us-ascii?Q?qU1qtU8TJ6+g0tyAIAFUYoFapcbK13OdR6yNuo3fkspopL7inD45RnpKO4DH?=
 =?us-ascii?Q?0akuvPT4UYcvQuHamBzI7czx6IuNpL8XwvWuKajwYng7brPJRnm8nkL4+A9d?=
 =?us-ascii?Q?UtmfOxIvACsXSN33gZswK8zyEQiDJDfJVWu0Ig4/4P9bs+iHT4EhPVFU04X0?=
 =?us-ascii?Q?0WKTIWx2+NlE5VS15QZmRXC/wSEoEUbrAI/APVEvIiyDa1DzGem6Y6h2sP0/?=
 =?us-ascii?Q?6jiB2Dcx3UqSqUTy0jhuCIw0gRpb5dbkTfuE1uI1TNnAeHydAQab61eJoURr?=
 =?us-ascii?Q?N0TZzkb7gGiwEwmqvvc0th67iZgaHPkfUYayz69s/nSeLb9fB5xN5Ox+VfYE?=
 =?us-ascii?Q?2DDY5uo5b8c/VSAx02dSYsDMfOtoNbeyURmuRRbqDIIHQO1k49TGn0gdHa3R?=
 =?us-ascii?Q?L5L8jswoKMIokJUBkSptjmbMQ8ElFmRNXBvtgU18Zfti1BtE+lY6/m0wCBtW?=
 =?us-ascii?Q?uCtnGqd8Roa/94nCIPHjXdPC+KvsTi5myVUXqyhK02dk2U6lHIHLBaGC5Eop?=
 =?us-ascii?Q?VCcRY7oY7GabyK108LBzK2mkYw6ZfUsWgVhnT5mqApUmDU352aSb4Ti4jAVU?=
 =?us-ascii?Q?WjJFijeAGMbwU04FsJ0tN8Zo2gtmsKz+C85DP4AOdL0Ys/t3t7Qz9p5+PqAx?=
 =?us-ascii?Q?coMKgjuoVgLWABq3CvzLAlDzgjhdNo1JXbggIonmWMpiGJcCx1Wm0GQq2Z97?=
 =?us-ascii?Q?nZpxbrfkmsSqvI3AzhuyB5ycqZN37Fj+JkmOGPI7+bpFaNeQtwxq5QSHfxZ7?=
 =?us-ascii?Q?P486nw2S4VtB3vMsk/7qR/u5R4cx2V2hOUtnSt0sev5QidSV7/d0F9+/F63W?=
 =?us-ascii?Q?VgFupizpLiaAjCZnQCNEWwvPIK0JxQp9CiAkRfq/f5Wsz1wNFlsqv/20DNok?=
 =?us-ascii?Q?0UJ5hZVR3HF8qip4P+Hc+HNLge5FTcmBOh49Q4jm3u3g5c3mDshWgsVuJeUB?=
 =?us-ascii?Q?oo5a5PECW+LErUOaj0RKdliDBfkCUdr+3m50GMDoDr+c7whcM9jGBbEhuc69?=
 =?us-ascii?Q?++cNZfRqS4NJoC/xayvy0jRmr3ajpLL1aJXqxfFuBWDOmXcgSZUD7FHuXbV2?=
 =?us-ascii?Q?Ssgx6oSh3GpHANLiBa9CMHAwUi3ppRUFqyAielOj76BuW5TqI9XztXGhy7CT?=
 =?us-ascii?Q?99Nzt9YkrahgyR1ikXtUWuw+veoO6okgJ9o0JzGI71xPBM+JwQQicx+39uwx?=
 =?us-ascii?Q?h/XvokQUHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552fa7f5-a757-4845-a954-08debb792d67
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 22:50:26.2078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prrxAPB2JhgW6PxGjZVJDB48g5bTHQ6ygd3cCIqUe0FHgY2THGTWNN6qxa3DuWoDJdwjpB/1nDGvb+6TkasLwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

With __note_gp_changes() now clearing defer_qs_pending at every
per-CPU GP advance, the per-irqrestore clear is redundant.  Remove it.

Effect: PENDING now stays set from arming until the next per-CPU GP
advance, future arming attempts on the same CPU within the same GP are
gated by the rcu_read_unlock_special().

This serves both as an optimization (should not need new irq_work again
this GP - for the compounded section case, we detect and clear it there),
and reduces risks of recursion due to clearing too aggressively.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2da009dbe64c..bb5f955a06df 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -487,8 +487,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	union rcu_special special;
 
 	rdp = this_cpu_ptr(&rcu_data);
-	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
-		rcu_defer_qs_clear(rdp);
 
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
-- 
2.34.1

