Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FBE3CE0B8;
	Tue, 26 May 2026 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835841; cv=fail; b=fMO0dHhLRPZWscPGIKGL1dzFJg0TMKHVzSVPOnIcGvO6ItRPwZKvwCJbNJj9RrX328mBIP2GZls8YfnPuw21ajMrtplIf2qUV1TDuJmI3sxvZqgyRBPjryNDtFr/5yYPzvZ/lhdYNmwJG2zv5ABim3/KnOp4wQ5KikArdaLQbMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835841; c=relaxed/simple;
	bh=m3/W17dDH4ZJ6qWZ8ig1bN1JTHQ/vsXEjbga7JJKJJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LDSsrMnm7G1GuQCHWH5WpYCiDFCJGVuf+7y6gBd9nTOO30dkPxg2CI7ytXJejHr8D87PfLb2sBThsRwezbcrUe9cdYCHWZd/iFx+KQKVdEdgZAcXEuUIra5t97YuKUgKqSvPxh6mUG8Zb8G0eIlqbIgHIkrBVJyghH2VKXUDGKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r63egzUc; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r63egzUc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2GmSoIqp3WsTBpLSRVLW0CjrTYllOwtbsYTslBtWu8fdazAdjeN87JG+PW1IEZh2b+ASGrzqsk65wZnUd6ybyPDccJv1LsaRUF8L9GjCSSk6VQzuJUMtgI2YWk7wNG1+O5MzMhKiFgnnkQsTsbc93WzyrCEpx2Dr43ctf+4SOSzTCF6vjouqZUCVuejwG16DkZxXk6QiFlibV7ZyqOqL5FgaxyGowwZ+wMkvEHpcQJUPBKKltTgTlM9s7bYCQNyiWqouVPqMwxDIwXm6ozBBIZpPK6jc2S9u6LhaPXupC9Q8HT9G37UbxBbal0gF+Pegea4QBRby4bHLGmHlfh0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMOtViZGm4FnGZVYv4DWF8h2epfA5JojjLpAyxu0zCk=;
 b=ECtk8DLSWyYDII9j5isctuoxGCMH6r1c8EM8KAJjuWZ4MXR9vGz8eSqQQgeDzpbhYHaMu7IGgRmaLECvpGgPvykiYbUN34glb5l7CaYGGdJ/TxWEmPb0U4fLdMOGNrdVG5c0rMuF9jdWME7XaSVOH1Chhyq4qrIpciCaY1KuP6WkpjfkH2MR7yv6NRjTN9VOV1J0QodZ2AFEJQ0xU40JamPON9z1mvxJ9ulNbOdloTerUg4jlt7SbtjxUGzc9PYz260G3Voel9f1G7deLLNTSLLP0tTPAcQBOnEkXY5PE4ejzXbgbcybLUugN/vlLHPqEhNJ2MAeOofOf6WHjYaaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMOtViZGm4FnGZVYv4DWF8h2epfA5JojjLpAyxu0zCk=;
 b=r63egzUcBpVApClL08303Yg/KH8Mf5XQzvJCMmXt1rx4cMMZAQPHcc5RXmL4LkEaZa5B7ytw2PS/J2hht7AhgvH2Z2jy9wiJ5ymYwdBTc8yQRJfzKPfbePuayuKi9dMOnR2SyKQsTfjwxyTOEEif1i1cBGYn/d86PnmCat3oYvJi8d6A5zgba0xTft7ifolHbStsagV8U8SdH9I5VXtlbsVKq5DjJld+stMZGzkvEb59vr5d+ESrq/B0JAkoOGSTHzQQ7EJoakNZkx6dgELepSCryhALAn2F0wen9GSaK+MuudeMCr8zTItGOnWEOwPjkh2rBSRN3orU21mRgsGKdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 22:50:31 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 22:50:30 +0000
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
Subject: [PATCH v2 7/7] [TEST COMMIT] rcu: detect stuck defer_qs_pending at GP cleanup
Date: Tue, 26 May 2026 18:50:14 -0400
Message-Id: <20260526225014.314734-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526225014.314734-1-joelagnelf@nvidia.com>
References: <20260526225014.314734-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:256::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b64f5a-609a-4c23-fab1-08debb79303b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	X556ulePvpR09g//dL2XyiaWL1PanYQwxJdFl5WbMLoeFDDbZGWy5a25Syc0HiRRSKSGN/wjR5aKpUveR89cIfHeJnslX+nnh5pO3YZ3Kfs6PENx1a2h16uxRHST5yimtwbnHDngQE1OPNd7ZAmS/V5JKxXdZfVZP0nKPu/NyF8Z4aGd9CwYe2UZv4asMs0xLeXYUZ3X2Vm3ZF8E26ST06khK4yj5omYnI+8ruObZTgbJ6pHS0WZAz4byeYi8C/ekheSO3/2oHqwSar8P+kunX9XHBKaevz81NQB5AEtlvoXmWx91ccOJug4wy9EirblVw4tByy9ROIybDcbVkHJZVb4fk+iaDlpFhiUqUp3vTunX0UXjVxsFT84cFjEtFURxK5ID6w6rR7IBPKQ6vEmPQFhx+HCoN3A58mNFPGdkw5qeeFfaxMPzWDmtyyt5ZStKVQTyD0AMMhRQDB9lDgdVJwdBwJVJcFPZRixk3MoRuG41G6CaMTKq0LVnOkjdSyib+7RapacPu64LoPkwyajqBbs7DrY1tAM/w6qq+toxe0rdkwvVyeHWRfvSYsSq0FwdgFabrIdxGWT3TQj6a3fU+oPsQgDoCszJyhTsMkRcefXCFjOuF0Vgb3NlDGKwQ9YVvdBFN4IZILYVjpwU4rFK4PE7EVckq41B/uWbdr52CmJ6bjfpak4PEv3CzwnPWIm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?abRwZNUSZb9Ji/cQEYeqfYOUIAGlTJ+kgXisgN6Y8VcUAF4X7GZhiAWRK9dY?=
 =?us-ascii?Q?FHdx3zUab/XAiWExKHPMznowTPOqlaCSgQwI4IsVuCiSeJtISbG1S5GS19Do?=
 =?us-ascii?Q?3HkiaX6S7eLf0hfrAPB5vs+fvNFSKkAQkMysaHBuA+jiiRWQWKXnjVdzKING?=
 =?us-ascii?Q?bKOUmRHQFgH4zI9e/QoKLWmJNsE8Z5CnXGcvapzS+5uFd7NcaMC4RFMGHEJe?=
 =?us-ascii?Q?hf2AKBaZLsSrX6EBA5VwXsqRDEALo5PMX7IEIGF7I/0u231jF18pn/A02I7Q?=
 =?us-ascii?Q?kAa/K+VJ+OFyMU77j3JXTOpzw788HWD3j/auU4I+urNw6NY0UJ1dsC4me+l5?=
 =?us-ascii?Q?WY40wUtcY4+xiMMUvpF04ABHVe8drK4SQFPWakYHlF45CzYg8suHynzQId7c?=
 =?us-ascii?Q?tkBjFLaKCJUlFM+SB68dX5LkndkurxawmQC77hPiWdjM37F8xs5RzjMrL8OD?=
 =?us-ascii?Q?QOo9H32iYF5wGI1uZfH/wGiPXe/OPD0k6MUPy7psDG/h7tKTnJrLU4InPY3M?=
 =?us-ascii?Q?ASq0WEFBasFcaMXG1KUhWGaONmLvGCgzwgT8Ypei4R0b9eunzz2fnBcHhRYK?=
 =?us-ascii?Q?/rHUSWIukxJIYOzntOMSHYuLtAmK0m0o3qgieFkaFI/dsyDdVoGrStBab9rG?=
 =?us-ascii?Q?Mv1ngpES+Sbo0xYgXpZEsT6oeLJlWJPT63KZjl6dRWytNdy5HXpQb9SvqxzQ?=
 =?us-ascii?Q?6NF3Mkkabnr0Thd2NcDaVKrf9j9R1S+n88MC92TfVXScbzqdD9CxAq9KWXxY?=
 =?us-ascii?Q?4yhUH9I8sGF/QyqPcS1akbADQ3Cxs6Xv0vgswZpCI3UPCHcJvIRdIawY4BpW?=
 =?us-ascii?Q?i1JVZfpk0WAPaJyzp6VMhKg4eYpqW1RLwI2Vs9Kds63yk06YNbVWiJTJ0Jgd?=
 =?us-ascii?Q?uacD0bauUYTVBng+cgnAqEk2BINCTDJmubBDnrgy9+6csj1ZUtnujNAd2ZoH?=
 =?us-ascii?Q?Tqq9+tF6526JKokgE4ijOOXCb30fxZFISrgqr6nZEvJyYP6glc2rxgCUOLdo?=
 =?us-ascii?Q?cTccgkQnPZKUu2HP+tpDuy+3swJPotIT/rd+4gD0qAfOctzeier2VmGZPrJq?=
 =?us-ascii?Q?4vlESDmhYarWV5P7Uepifz6WAPI9fnOiHfOd1pj4q17LXgKUuuwYNFfC7USU?=
 =?us-ascii?Q?eBv9TQm3AlG8UrOAApGT1Vt1syTuwPikOolMkNXTmBUGAkyNvlwgoKkHOETo?=
 =?us-ascii?Q?neKl83Z0VQWmjRG+RyvigZayU0LvFrFj7m1DudAsLt96cKrkcKtAhc7BIGS5?=
 =?us-ascii?Q?6OkcwcU2EfefchNWqY8BRMSPFXMmNQ3TPABbXgi1ycJYqSeXF8kN3KFqoEKj?=
 =?us-ascii?Q?yPOh0/KctGNhz8ThyTWogJKbHl8q9FzFPG4Ad8p9vkUyULlxE3S9PtGAEMbS?=
 =?us-ascii?Q?8H5YWyppUzLVinGBqEsMqxE0HDVRfib3oGEplLsO0p4jP1BN6QfF1qGCwz9P?=
 =?us-ascii?Q?/zEdpHhczX5cewTTzUQzCPaE5e3eewn8paa66+jEM1uVfFHhpW/TUYCTaCDR?=
 =?us-ascii?Q?Blx7zk2Il5GFxU0EmAAUINATtxA/qxpTjhWMFG/DaBElYt65HEwR1WnDWi5w?=
 =?us-ascii?Q?TJRdBpslNHyeFhya8hMwXM1htEMoo1jO6pvuFGThYLrTTRAyquU7zysY96YI?=
 =?us-ascii?Q?laXGWFSM8YltkVPc+W6PprfB2MTN4Sp0iOhQ299gLvyg9Fea7d4BEvRNeL2l?=
 =?us-ascii?Q?teUnJvkVsp+mYbCNqnQ/LPghNA6P0Xu0GC5dfJqLg6ZG/YUgAp2XeuK7F5tw?=
 =?us-ascii?Q?4d1eUE5JMw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b64f5a-609a-4c23-fab1-08debb79303b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 22:50:30.9132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQ2x2eKFaV9zrz+HduQ8gKDFKXJfWs/xZWeeJrt5zKZQ4k1MDwg3+813Ibe/8Bw15gNnxHQdj9UuTUvfS7/Uvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

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

