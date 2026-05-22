Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4014657F5;
	Fri, 22 May 2026 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459858; cv=fail; b=rVyIqoA1aSFhfa9wllO6QLnLMRHjzV4kW9/3EqIo4mz/78XF6Snt1kg1tNuko/VkKqbUYITzopjcE5HO0eyub7D/WaI9CMd1NGnN9cBB7HHBDystgt3faDZ/ZVZKiHUYyfD2jAU02xo6DqSyHPtQoK6xbvIkIdLcDvPadL51td8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459858; c=relaxed/simple;
	bh=m3/W17dDH4ZJ6qWZ8ig1bN1JTHQ/vsXEjbga7JJKJJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QagcIUytY5L3jtl2xCtg7WDDxTaqBbAcgxclAQbbhY5mgayzkghVj6J4tnmcflCVOkXyOjp/l/OhoTse5eipkHKa05tbJPL2JSiG+hvfhMg82RzQ0/pmcm15pUrUf/mMVTqq52fgj7gRagi1fOlitMS5+nGg0qnd5dq4Uo7vGr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C5Qnv6Qk; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C5Qnv6Qk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGwk8vhB/vBoKyW5bl7Se3vLuDDivk+jW9zYrsaKNU38Unne1QwZrDbXCvb9Gi7nK4DrewuIybLd08kfxkX7Kijzi2iVlkTgq8ZXwx/Pie4boYYRoUUkE5fQllTzUU4XtrZVBI4B/U4TOchh/lvd20plraWlr0S/N0PNuOtFtxLyDUf4u+TcmmKi8mTsz3+SzWu4p1JqrV94TnoxuF4FWOeBZARnMXqnO+BZvYfOjjF4JboUsjxICObgbo7+FKTVxfP+oAbHHuaE5zJVXJrO3JxcTZJK2FieHkvOWI7WUmN1VNwtkddic/AqhpyzUC8Ilksxjd/46uRjem7nXd5HSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMOtViZGm4FnGZVYv4DWF8h2epfA5JojjLpAyxu0zCk=;
 b=AYUR3Pwb4JH8kheLllUe0d0iksbmj4Z+dkd05APYOLnkVBD0+/a5c5l2t3vC/fy+JtZIcdBQIZ1ciABCBEBVf3hdhRGAEInw1d3iyMHkcc93ZZUxDPvrjv65acTKTCExijCjV/NHtTDc7yWGDZ+sMBCrlVnODZOaax82ApAG7XgyvlFi5IqKIfTA6rnQFu5HZ7dPsIcGrNfazJSnwNBA8LqJnQbxzNf8F7xyZRifDbxb8BK8rJ1LqLASdzB4zRbYmB2U1GMBjSSNyQSsKgkdUioJ8wOYmjepiCFyrZXCqy1oKLIp5doBQMCoSRF0XjUaNB6k63XydWtqH4HwY9+A2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMOtViZGm4FnGZVYv4DWF8h2epfA5JojjLpAyxu0zCk=;
 b=C5Qnv6QkP3eRIYK8PFlsK1iUo0ZBRbTSj1qFgtoS37R+fRgiDfVEkybPd/RRm46nJPT20rW9Bxyxpws0dces02Esd+V8jjFy4YqE3KIucTlqBScFSN8qiemR5qehTldhSc+PvO4NcI3JXqwxiPeqRhQEfatCuXC4TU2nZbc/tyuEbWL2yr1/QWHH1LtOmJ3CdvqYUBRJTHqodlUJfpwCva2NO+0UlcMsIfp3ZhGg4+vu/QMMUNOWwYFa31+wxE+WLMQ2gtBNsuZIjjoaYXdNdR/ly3O7ULXoAdRX7W4xRxOeDpFce7zyMRR8Uo5BG+Zmmh2AD+we6RFfE9X5cIOowQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:24:12 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:24:12 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH RFC v1 6/6] [TEST COMMIT] rcu: detect stuck defer_qs_pending at GP cleanup
Date: Fri, 22 May 2026 10:23:40 -0400
Message-Id: <20260522142342.1536533-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522142342.1536533-1-joelagnelf@nvidia.com>
References: <20260522142342.1536533-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:208:239::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2b4284-c4d2-4638-9cfd-08deb80dcb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wjk/U4LTDHCeRV/OFnMPMQOZvcG5baC9GilW7t1GXmJ7zL1tVw4nk8m142dVAahZXHax8XGLQymQ/v0rqo0RTxBbaNNSSiE+GeSZYuYkk+/VeElTeHOL7gwPKQQcNeEFVHigyTPPwRedDJiplhP/0UggRM3u+1S5LVfoj5Ok+w7QMY666UwMsQJvJX/h66XsuzOambeTZip8maL1dAPOdiInxj04V9b1WeVdwOwraWZPCsQisG3eYKLBBSLxa59BrPxwQnfmqAwpISrjpg2cPSzlxX4DcW6npPP5TeIXbekX3ALw3Lr4HFea6fcw7xtrTnYn4lZLUvcbeann3CY0W950pG5Jndhv5RHMISwzFY8mrcKjWDANOHFyFEA4qhqjlIx8+MHuakqFvJR2infcpyLZqQLEi8mMGGOsoVenmAd7ssON/CRrrtEUVAFJAT6/yiAosCt8fRCL/Juv7sa4lnCYW2MSWEb2hPHv20g0KVRZu6eTSEep164ktoSoXo/tXt8ZBM2i6hTKWXXXXZL6ASDC7oijzLFNMOs8mjiOFDuPDVFh9Qnft/Qn/HGdRdMorg2v8p30hRdrfavb56ml6JBAGIGY4cMItmTyKK6LMT5AXuDUB+BE2zOyMiTqVYwmcqi/itc81XN7SuCJBnZ8HYYgwnrzVrgJ2gr6jkvfuZBRhKnegkzWXJ5yY8Afwt3Km+44WWJ9aQRcJILKYBQwaMcjSJmaJCydjbl4lsKgiyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(11063799006)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YCoiDdpxnmOcVA32xxevITmhVpfjLGOrDV2PohE3I4IqYR8jTO5YT6YYzSeG?=
 =?us-ascii?Q?csKqobbdwGjVW8GiQkwMfPzU56EK9iBUVJK6YNQc+b4boSM96iF5KSm34iTY?=
 =?us-ascii?Q?fJ4nRxOb7avF0wv69zoJnK7wDtzjMeSVbdItLyAS+4OlbroRfndvcKdKQ+0Z?=
 =?us-ascii?Q?dpEe+5p60mPvU2mNuNUX3wamMNymz051Npic2Rhd9yR+E621NJ87cNYXUSxY?=
 =?us-ascii?Q?EMv5VyS3QrQH13cDrkeO19f3DT4cXQaR8vLdB96EwMYvesn7DCWZuXzNiasE?=
 =?us-ascii?Q?7epHNeTayxPw59XqJqk5Gv7ZPCpu7G6R3xZF6fmaNZDOPDG2mow4M2LbPoeU?=
 =?us-ascii?Q?m6hmdtNvwylv5Z83hKChlNQURNJVFcdX7UxlrQbUl5hCQhPJZubemSiobmRL?=
 =?us-ascii?Q?I8+TVwoiqd/cCxUtN3hqTWa+aMcmAVtmMVXuA6oLGZEZXk6c3fJpn/e7ZiSQ?=
 =?us-ascii?Q?+l95hTFuj3T3CBKZ+Atqh+gZMo3eYEQK8ASZHmzrwg2eAHpfgLpGgJdyb2K9?=
 =?us-ascii?Q?74ovJi4kr3u3NFS2f79Bkgs26H4KOFxgp7jgMb7Im6lOg5iVDCuD58tOEKIZ?=
 =?us-ascii?Q?fxDCB1gGxOwjEv/kLnUU7opDkeW1Gu8osxpTQkJEmeVRyR7anBNm4tBqWAtQ?=
 =?us-ascii?Q?npOqiYqkrbBcXWsvEmDrwDkDENGHkfM7ExC9kb6qm7+MDTE9Q93jwFn1hNgD?=
 =?us-ascii?Q?oDhb4M7hnzH7iEdNVjKv4hK8ErC43Tf8Zx3rwArXjsGdgxFxph90Q0Rs3XB1?=
 =?us-ascii?Q?ttkluaKeMzHu2xyHj/7+4vrvgCN8fk1qpUuU3+68NLQSLV5HBdFfdcOsA++2?=
 =?us-ascii?Q?bsbF8+/ekh6crug0OYn9cLS49nD2k523rY/tnMLsALsUrjmkn4+cpcFj4fHO?=
 =?us-ascii?Q?Cbq3H/ejLQK3Izny+ma0a9sPGWsIUOUUr/4Gh65SrQ2nOOLuWwjBWHN/4KkJ?=
 =?us-ascii?Q?fcpBJMWjSZdklzMCDnv2CyqjyOt4exvA/buc3PLyqSfYoQ+KS+iDw4u193zN?=
 =?us-ascii?Q?X4v80lK+yQSUg1WcbhQF2jcBLMQ4NRLQFAE9rWkceLNcbHEEooPqS5IFqcjB?=
 =?us-ascii?Q?2Wa6kcuM2JqzgUsRjy3ri0ccWwhoasE9bryV6sGlJA48ea5hzDsaxJdweZCb?=
 =?us-ascii?Q?sEbLaYlM+BVI23J208RZ+0OvbSKVp/Vrg4KUNQTu+hlUS2CZZYCwBRMI06an?=
 =?us-ascii?Q?Gg7QGYlg5UcVnerG9iU4v3jC6YKluIFY0xXT628HE37UHycaSVZg3GeACWo/?=
 =?us-ascii?Q?WNsAzvMjXpqNmm0UXKvqmyjXgLuBqnaToYL4WSrEqEBLBSV4plS32ZpSuKRh?=
 =?us-ascii?Q?4st0HvxIoo+NlW39nm0A0jh/mkSyJG2228ZamMeIucEP2efpU/U2OwwYma34?=
 =?us-ascii?Q?a9frlIBympieE+S13z4ify1o3UM2zMWclFZvo1oyLRxtByYKx58tULQnsRhx?=
 =?us-ascii?Q?KJZ9TEiYMHBHun3Q/wtuhg+LSuZpvUfxpxkYPqJ5MKiIJ8F4nyugw6UtBuiC?=
 =?us-ascii?Q?kgwZHzyXMqs7feAy3n+NtK/fllyBc4lRFL1232LV/qtItqbKH1b6+OJTtTnW?=
 =?us-ascii?Q?jwHBGSi8NqcN+hKTcgPDVQIFQ80Un8YdvNRm6e/Z6bxPDKiO6BtehI03yuDI?=
 =?us-ascii?Q?GUyQyhnx4eKZtk9wChbzN9/7aAIzWzCWXuOVrO08gEo7IjYaxSWg4TY4P9+Y?=
 =?us-ascii?Q?Irmn0Jd6xD7OURi/ZHGG0I0DXL6SRF03qY8S8FgqHUUe5fk+4NHPsULMvSSu?=
 =?us-ascii?Q?lHcfndNMpw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2b4284-c4d2-4638-9cfd-08deb80dcb31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:24:11.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgQlAk/FIzaqTaxjCJ4hCIL1WL0XhrPTN+rQzbUQ06QG0JRvnWbrcofY4YvVt4FASldSlNQ65xKKmC3iTPucLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

Debug-only stuck-state detector for upstream review.  This commit is
NOT for merge; it is a review aid.  Reviewers can enable
CONFIG_RCU_GP_CLEANUP_STALE_CHECK to gain runtime confidence in the
preceding fix commits.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/Kconfig.debug | 11 ++++++++++
 kernel/rcu/tree.c        | 47 ++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.h        |  8 +++++++
 3 files changed, 66 insertions(+)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 35218ba74eb5..5a40c4fe544c 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -98,6 +98,17 @@ config RCU_TORTURE_TEST_LOG_GP
 	  Say Y here if you want grace-period sequence numbers logged.
 	  Say N if you are unsure.
 
+config RCU_GP_CLEANUP_STALE_CHECK
+	bool "Detect stuck defer_qs_pending state at GP cleanup"
+	depends on RCU_TORTURE_TEST
+	default n
+	help
+	  This option adds a per-CPU instrumentation counter on every
+	  PENDING -> IDLE transition of rdp->defer_qs_pending, and a
+	  detector in rcu_gp_cleanup().
+
+	  Say N if you are unsure.
+
 config RCU_REF_SCALE_TEST
 	tristate "Scalability tests for read-side synchronization (RCU and others)"
 	depends on DEBUG_KERNEL
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d0816468ffee..1307f3fb48ac 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2146,6 +2146,52 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 	}
 }
 
+#ifdef CONFIG_RCU_GP_CLEANUP_STALE_CHECK
+/*
+ * Threshold of consecutive GPs with rdp->defer_qs_pending stuck at
+ * PENDING and no observed PENDING -> IDLE transition before WARN.
+ */
+#define RCU_DEFER_QS_STUCK_GPS_THRESHOLD	5
+
+static void rcu_gp_cleanup_stale_check(void)
+{
+	int cpu;
+	unsigned long cur_gp_seq = READ_ONCE(rcu_state.gp_seq);
+
+	for_each_online_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		s64 clears_now;
+		int p_now;
+
+		if (READ_ONCE(rdp->gp_seq) != cur_gp_seq) {
+			rdp->defer_qs_pending_stuck_gps = 0;
+			rdp->defer_qs_pending_clears_snap =
+				atomic64_read(&rdp->defer_qs_pending_clears);
+			continue;
+		}
+
+		clears_now = atomic64_read(&rdp->defer_qs_pending_clears);
+		p_now = READ_ONCE(rdp->defer_qs_pending);
+
+		if (p_now != DEFER_QS_PENDING ||
+		    clears_now != rdp->defer_qs_pending_clears_snap) {
+			rdp->defer_qs_pending_stuck_gps = 0;
+			rdp->defer_qs_pending_clears_snap = clears_now;
+			continue;
+		}
+
+		rdp->defer_qs_pending_stuck_gps++;
+		WARN_ONCE(rdp->defer_qs_pending_stuck_gps >=
+			  RCU_DEFER_QS_STUCK_GPS_THRESHOLD,
+			"RCU: defer_qs_pending STUCK on CPU %d for %u GPs (gp_seq=%lu, clears=%lld)\n",
+			cpu, rdp->defer_qs_pending_stuck_gps,
+			cur_gp_seq, clears_now);
+	}
+}
+#else
+static inline void rcu_gp_cleanup_stale_check(void) { }
+#endif /* CONFIG_RCU_GP_CLEANUP_STALE_CHECK */
+
 /*
  * Clean up after the old grace period.
  */
@@ -2220,6 +2266,7 @@ static noinline void rcu_gp_cleanup(void)
 
 	/* Declare grace period done, trace first to use old GP number. */
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
+	rcu_gp_cleanup_stale_check();
 	rcu_seq_end(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	WRITE_ONCE(rcu_state.gp_state, RCU_GP_IDLE);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4069132f9d44..29d852bbe218 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -204,6 +204,11 @@ struct rcu_data {
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
 	int defer_qs_pending;		/* irqwork or softirq pending? */
+#ifdef CONFIG_RCU_GP_CLEANUP_STALE_CHECK
+	atomic64_t   defer_qs_pending_clears;
+	s64          defer_qs_pending_clears_snap;
+	unsigned int defer_qs_pending_stuck_gps;
+#endif
 	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
 	/* 2) batch handling */
@@ -299,6 +304,9 @@ struct rcu_data {
 static inline void rcu_defer_qs_clear(struct rcu_data *rdp)
 {
 	WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
+#ifdef CONFIG_RCU_GP_CLEANUP_STALE_CHECK
+	atomic64_inc(&rdp->defer_qs_pending_clears);
+#endif
 }
 
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
-- 
2.34.1

