Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6FA419311;
	Thu, 18 Jun 2026 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808714; cv=fail; b=CA506y6PozKYn0DB70skD/k4suGNXuN1i6aSk8lsJtcHwUF/kX+43s/RIMgtsF8s/n7FYYqjN12D0jF9Pomup7Rc7vNQvYrE1bAfN5Um7BV3833HHdQf2Ulza70rdHMTQiguPiGwj1tjn9mJsergMtApskcf0qkEillrHus2C+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808714; c=relaxed/simple;
	bh=sjoZPX8R5/OsGd8KlpdRW2qMSDm2WXGk3X8m9eG/uhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AVIETpqCyfl2l+su5gRau+wxqGMZmXnD/kwHGEPhi2B7UXHhLd/59y+CEXoPWsQu8yLgOgP4ACaF9GNKVk2H4Stk1YnJOR8HeTacla3P/MlJ7A2bHEPzRbv9AbAXkOgjGRrTCxaGgnOuTJjIA7iY47ZwEI72VgTOKeBirJUhu34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kt6WwXvF; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kt6WwXvF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8G7TvdohOM/jI/jlNIwHB7ZYe+I4PB9B6yvmqDjQLQvoR7lDP3iXWCt8oX5dGHbj8o4ZYVE9fo3PqMOXNyh78zlyVJ+Zlq3aO0Q7Pmf3htJECcUj0vNjPt4P4vDHCCD175fCnaHKfQH8ou7RR+FUAs5XX4/CTphK1EbtA24gJNSIZ1nwKRQlLWU8QlZ/AFZY14PkgCEBz7VlQ0w/WdwPjKW7+rtR5JavEKkGY8uX99MZwJPnc/JWwj+4AXcnQ3/sB01xI5E7snzCB1Zbwww0iJ5+fqfA4yBKVP9OO2o5df/ckl7tpt+y/nFJur13Y48f3Xl/pP5ZKSQvlfOphChfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0N5BTN1NvYa8f4H0qghoRkgWaJirde5m8OrnhRgAzc=;
 b=GTOxpMRafICVwGXHKtshB7M/Jj1JRytZw0Se2B/tqU1Ck/UyM3EfEDa42ypnhxKFXgJau37JFo+qH9Xget8DVSZFw//odfiwkyAic5r1woG7b7JDy4PxRxAOkC5P+mbPlhxc1X59wOXhZKuzA6Loy+8516NLXGTQrdNDwoFyADDkUtHPhFttCNA36pp+0xvn65I6cjquyjogo5q1Nc/XCn2a/1sbAIR7yZg6OtNHUd+jWOiisz0mgARNva4u3GeFFSjvUwuzA2lHoTtXr3Y6trJuseizZQ91sLP92r1enx4MvBGp7DpQQE/uStfvWgUiWWflJVQq2/kC85XnG6xiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0N5BTN1NvYa8f4H0qghoRkgWaJirde5m8OrnhRgAzc=;
 b=Kt6WwXvFiCGZ0rJN6mzrNIcNfYPMQsXC+67obbL//oAsObSERXcDzDQDgqvIxfmhED+VpdNcttAHFWacqEvIEdVVRrs/c/ZKWdYalZFJ5HBGB8u9au3zEXQIicL/ym+u6efghW/+Qgk7e1YUDgVXtJ13BOH0T81ckg9jMZFKV3k17CG9ltxoZJnxj63Ryzmt1GeaioJrWfP0FK7fsdSWftcJ+K9lUi9SpFiFWSDj4NxAr8cdi8sMiTbC2+6QidgVJsvbNfU5LQRuoRVSw6z8ZUeQbMqPs4NKeYfKSJlbcb/uNB8zGaDNr1NUjktEnnGW1Wm5QaEIWrrkI6gli3epGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:38 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:38 +0000
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
Subject: [PATCH v3 14/14] [TEST COMMIT] rcu: detect stuck defer_qs_pending at GP cleanup
Date: Thu, 18 Jun 2026 14:50:30 -0400
Message-Id: <20260618185030.376450-15-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:208:236::25) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9e142b-2339-40c1-b551-08decd6a9ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	I2hiwewJ4KdCZLwUlsJwgz63TVz+hffO/bYhrR2u+/Xcqk6Drh1a/S4SQQbkux7g0z7Qhp6fWBx6s4UdXl0YZe4mEjiJ+Tao8qBkNPuM3nwxtuYkVMKkfDaF1YMSYvfUIrYJADLZWbEjgeM7D6UXIMDh0pzm8lATSCDwE1sxBc0/A7JocTUiPzuX7fJwHkZzyokSY16FVYp6ZiqtNeMQPNcXcbC/Bk/W6DUxbWYCoPTfR1/u381+1R4cTllhg1/lyInOZFRTvwZmMZTSuavxdWp4BRX1HZOzNniP1vT6PPzVcqo85mU/3gwZ9UiLEK4USzFcw/fg2hPLX9RHVrX1pW6JCJLseRIeeyorY4Kme6EvrHLm1x5SVkNwvbXSfQv4BBcVPXvYCL4GJFxUV7ZxfbPpktISXoHqcTZS0cvbkcHRgW34QU13fWdlGegwh8uYxvPVQsng02Cvt7eOauVIyIRboaBWN2x7/xxEFphNqPKPbmw7GUeGpn9QDy2mqvk+9s8qo3wbselxL9ed8ofgG34j5UuEZeBGi8kbIti7pyP3uBUFWTG7dVCrkfGNBAgo2dxYgPTLAMii36cSIuGTaNOcJy/bRFnGJoYCMM1nTwUXeJsIqttgldbKdYQM+AXKCgxWkcktPRyCsdrGaoEj49pLQbjGceIUj78UXYifvTzzvY2W+XYL9aEgVCt9roS/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z5vqRUC4uUyWzXvA3/0+ttGNIyv9CsBEflVcuut5xzwnaH47y+CEAIhW1IGx?=
 =?us-ascii?Q?p4r7siQXJHYW2duvvIFIsNXc4v6ZqqbVFCNWyrki3/j/y4gDhYgGGqwnBrGp?=
 =?us-ascii?Q?Z5t/ESdnmXneotLtx5kL3I81B5pdOaSDHWG3GKyn4fGkj4U9By6uN/QXFJIX?=
 =?us-ascii?Q?qQMoO3xUIwch4AgJi1c0SX1P6eCTjC1xvR+W/8eY3epAXWgIVo2VZwZYa2B/?=
 =?us-ascii?Q?643a0T8nRoWHpzbsKAPVyF5RRG4PEWyBXMZv0ETfWqo0B+DAnLf+mdBjgwlf?=
 =?us-ascii?Q?ZAYwVsmItdMsCcdFsktRV0JQTl8Ku7CTcVgv85CB5ibR9M9cnKr/fNXW9/+R?=
 =?us-ascii?Q?uHhD/RQ3HSiAkB5CJGw76A9YZbPuHgcegEdN8NHKFXzK/QRW1jfXIJJhV3Qn?=
 =?us-ascii?Q?s0+tJatmG0mWgy53p7r56/cH9GarW+2krEg0q3mEUmOTbRvqkfUkeTkG438o?=
 =?us-ascii?Q?H903Eds5x1g6EjR2NiaNEIoo8/PUHdcIm0cb7gEs6CFvw5J9Y2a57aGrPblx?=
 =?us-ascii?Q?pT1DmSVh5oDsRmBVvbTDz1Wc6jpk8SrQpB7vJLPUvf3zn2+6S3t0zmXzj+q6?=
 =?us-ascii?Q?pbfBK4e0BtZSjRWMXCaN1lDhGqXIFbD+ivTYMLLv8vMOu602gVyKUUXjFc+M?=
 =?us-ascii?Q?hdrERppXYtyNGHxGOEki13iwDqU3+/5f9ZtUZNPMeLoH2oJ6lZxOp46v1Cg3?=
 =?us-ascii?Q?GuS+Kj/+79VzN1+IidOYH3zpg1KtLWJnWL6M/z2nN1NSwUc9qaCRWfJOzsU6?=
 =?us-ascii?Q?bLVvqwOR4yaWWTM/YMCVod1mpmgwDkRcg1TMgKpcQkpCnXNjFts+nuANssW8?=
 =?us-ascii?Q?fcGtZzvAmmPU5PFRb3ihLZ6YreXUCwiCspEifBrJyagBg0Ly6/CV8oFajdfk?=
 =?us-ascii?Q?zc7XMmQWfBQu3Uf1Wh0mMjjsyXZ8U4Ye+WskQx2IBq8sLnf8UQ7P73+cMBFy?=
 =?us-ascii?Q?pHJ7fa9Ad/Ce1HKru3VUH+i5y3nJDPEy+0m+Fu8em8uwDpNJfx0hIFUiuIBT?=
 =?us-ascii?Q?lWkxtKPustpuv0s41HlK101o9A8bfu81EjFJOAUVvq6NasWoSO+3zM0QhC5O?=
 =?us-ascii?Q?Mo55LkVWpE2e+J3iBqosFb+quf13v3RlZisyp7mbrQHOtHv7RG4G+4K6Qpmk?=
 =?us-ascii?Q?35vrSeRCoQ6UHkP0Pl+ahvvgCNEXG1fD9SfnkSONLKZJ+0xzbL0j7s18FI67?=
 =?us-ascii?Q?t2weWNjRSNw5DaBHCtxLTaJSv/VWcjsaueqBN8D3H6WPZ8wApglBEqp8yooM?=
 =?us-ascii?Q?+w8Kzn0mwr14W6Y1TJFm75VXEFBJnybU2JBw5MCYD95SnNhegnSLg0P3HoKr?=
 =?us-ascii?Q?R3hC+HGvR8DehrCaXfcDWMkOuOml7kx1vLOTbzwkYrGExjCwPejY3Exj/yV9?=
 =?us-ascii?Q?MYKDmnlXiSkoNlh5DXYXc8rS7CFpA4lqXqOsS1KCP2sb3C38wcEh66aQnCJ5?=
 =?us-ascii?Q?ikE8Vc9KsnEK0wKuxAarLr8lzgHDViLebZB4cn+nIK9zs2ZNdL+FbI64J0SK?=
 =?us-ascii?Q?9vAmt47BaxNiNBJgw03use2Bc/roScT6ou08vvoG0Dgub95ule8fJ2xRPW5l?=
 =?us-ascii?Q?zfV6Ki3ySZdSmd5IbaDzT4Qq8/HcMULayVXwA4cJkf0tElF+QE86xKDoewtx?=
 =?us-ascii?Q?fF66YN3XfYLA9Yn9gk33xzoEt6W7KBq859bBvpiESr7wbQ4CqVwUIq0zSzCO?=
 =?us-ascii?Q?Qpj9NdHv5UBKxzEnAMUigF1unIp1pMdnDeZIFul9eyV+WKzyz1WPBlD7UoD0?=
 =?us-ascii?Q?ao8AFMGvBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9e142b-2339-40c1-b551-08decd6a9ff8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:36.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9CsC86kFgrDX0gEZjAoyp2pNRwawAoLZXwEs+JHlaN4JSqVRgFqyi0GMQ3t2PU0pVqqNJGheP2Fs/pFtX30CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

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
index 8fd62775c176..67d51990427d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2147,6 +2147,52 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
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
@@ -2221,6 +2267,7 @@ static noinline void rcu_gp_cleanup(void)
 
 	/* Declare grace period done, trace first to use old GP number. */
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
+	rcu_gp_cleanup_stale_check();
 	rcu_seq_end(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	WRITE_ONCE(rcu_state.gp_state, RCU_GP_IDLE);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 3da43935f5e0..010052a55477 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -205,6 +205,11 @@ struct rcu_data {
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
 	struct hrtimer defer_qs_iw_rescue;/* Rescue timer for deferred-QS. */
 	int defer_qs_pending;		/* irqwork or softirq pending? */
+#ifdef CONFIG_RCU_GP_CLEANUP_STALE_CHECK
+	atomic64_t   defer_qs_pending_clears;
+	s64          defer_qs_pending_clears_snap;
+	unsigned int defer_qs_pending_stuck_gps;
+#endif
 	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
 	/* 2) batch handling */
@@ -300,6 +305,9 @@ struct rcu_data {
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

