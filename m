Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B01E5B93;
	Mon, 21 Apr 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257652; cv=fail; b=bsNgtvLoJtnl079BkNxyjhT/e51nM/WzJstSEMnOWX51CqvJ20Sq887FPVtvZEf4jcrALGs+ipkDWfGPK9ryoifJvwhZ/sxB26egW3IDQtwigjDKhTsGlYJoBen+gKfHA92Kx5/B9jplwNu/L7KmJqpdP+M36kIZP4C34rnIZG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257652; c=relaxed/simple;
	bh=JrEPPSmeNiRoovRssCLiRAJG9vvoT+LyFX4pXvLbLlo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fIiOj+F1CZ+4+WGdN8DrfHd7+L6ki1FcaxmmaXH2jMx1DuPbQ80LlSZNIpsnJIpSOcqZIUX7m6XWlxmyjhH4vHgtMw3v0hkuNt9ri7RY3FmRpQ7ZopNrdyg1JFGVRr2LV+U3Yly8xsr0l4/M5UMhine4drDhWX+AJkpbbTw9Rvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VJHwNC1u; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VJHwNC1u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kK4XBvVaYHIROVCNOefXV7zAZXFCeKg2+x+xnGygz2R+WNh/UtvsIu2RidmVPGnrNXrf6Lb8KDh5jzIbtSvtdlPXlrbrtoPaWuuNt5lSel2DBDjDlNrk3XyfonFNfYET2UEz7KmQai0mhm7oLRaR+rzEa82gaOpFU4PbHvR6iC9ETT5/e11+85cwNt5SK1g+ja/WFceE+fD2v5hKZ3EJDNGQqWdpmHgvlCRJiHOYE6OKHKz63rKZAYA6ED4rZ0mP9R/kV+0wNkvagV/SfjvwyEIHhd0T9ElRLeKbxURZqgVa0vt6FiYloyAH9zV98ACnjP/kLUQsk0ndyXXV6KUWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjI0DkrBgQHCsuZ/PhRzXVWg3AvPaQctjHrRWQ3xsMU=;
 b=sDc9HnLPTYx1lJkSu2d28SeCbL6b9fTLtOugOIfosi5vdKNQu4UuH7uNMmi8TfvcZqwW/1nWxxW6JGDvupcXWHYWhoH4HEd163nyrnWIwwU6e7FRadHmQoQUwVqvn1xxOnrjUrMpQqp93BqKYJH3WMDxA8PhH/L5RPUnO6K53fhaEp6S1D/zjpxokweswPEkpykWD/0dAZkJV7RVODzeVOzis6tstG4R/P/Y5fxSbwgV0ARKnWYqr7do1rXY733eUD8M1HxUnujxkrXrNsOiSyzCEhOKLFQ38Qy2UHbRgGVBJWFs5YAKwKe02239VpG3ccqLdHkpUkrmd50t4g2WFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjI0DkrBgQHCsuZ/PhRzXVWg3AvPaQctjHrRWQ3xsMU=;
 b=VJHwNC1udba8V3tXzCqX9zHMu3dJsO19+h4rDYisqPsf/qhxlVs308bhP3X6PLS7U/BzrBKwp2MqFMHWeatWAT+MH2rZ+QHHZq3ouZr8EarQT2lu4lXGwhGDZMQD+grUxXSqCqB8haWcTDVzDto4EoxcjNsLU6LKzyQ/YJ5bMr2S43XcyBsoyQU6yMta7/uQRfOYZl6bUvMUAC7LQEJlae4B72FaOVivV4vZ7ebPfVfZJJY9fGOhb8K84/QEdCy6b8SmCZBUK8XiryogvoOnjMoxO+DSmmbz7QXH2kTFQ8JsdUXl0AYcNVov79+GFaMHLj3YdRL3oLGcHccsW6L4Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 17:47:24 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 17:47:24 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH v5] rcutorture: Perform more frequent testing of ->gpwrap
Date: Mon, 21 Apr 2025 13:47:15 -0400
Message-ID: <20250421174717.3332525-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:52c::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 960a5425-44ce-4382-39b8-08dd80fc9310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8atOIm7K+SfxGXNhxgn2myC3H6mGLW1ejhckKBYKy9swraWcj+1JdVDWhXbl?=
 =?us-ascii?Q?bMTRwhCll8XgpE45OSrzGxEc8FZiR3qdQrXgALUYWCXjdTjdUDVjU3fyfvE4?=
 =?us-ascii?Q?/f/bsXE09/BjkeDSgHRjdsipDHOmG8ZrK0kMAC/6YTr3Zh93RFC+oKNVx4qG?=
 =?us-ascii?Q?IhUZv5Avr4rJ5GcxAh9GUbDzMy/lc3MXTP8dzObKOtGTfYjlBJdBga8dcbR3?=
 =?us-ascii?Q?3Y1eQZpGDjSjyvwkTPoeyTVjxKFWDAJxMgSpbD5Z8ZuQzW5DFoaUVNDwwb1M?=
 =?us-ascii?Q?20BvhGd5vtqt1f9YI48DM58fq0Zq0JHcT1UQmpMnWeQtbeePBvgCvm8sIG7a?=
 =?us-ascii?Q?HZLdTzX/CFSKvTI4OK+VX2+2cdDKArNkXifKBP0mPnHkgvhwCsa4OMvU9ztJ?=
 =?us-ascii?Q?BErWmEmqWKXXg3xISgxwGe/cKvYrvBgPyPH5HR3FgWeT/nqvwrseHtJl0TkX?=
 =?us-ascii?Q?Lm7t7Kob05WiYXY2APvkKZAwr1HMhBj1gtDXA6MLObDmnSHi3hRKE1u+pRsU?=
 =?us-ascii?Q?GwmJJORP5mQJLZl+uN3RfVkj6UI+GTccpEj0BWDuhp3DwsBhswIFlZf9vzob?=
 =?us-ascii?Q?cY1X3EfUpNxo8iC4WscC5fSJHw03rHX2ebYs1D6g1dqcfqWHguJqTtfe9yHB?=
 =?us-ascii?Q?3AEdeRjHprZMWi9sn0WC+VlzIpkoe/NGyWGVBmWj4UYEiCXKPr3nvysFlBkI?=
 =?us-ascii?Q?CIqPTh9ZdZAxXxZEOBTtn6rjw83YU/NgXXrEUizCrYY6EyL6y59HRiAEfekq?=
 =?us-ascii?Q?90S2aHbOudNWirdYDym/I/d/yRwjhvMWyfrLYRTHUUvbPRyJgD9VeUdh7hNo?=
 =?us-ascii?Q?op9EalyXyKHQhFVXJgL93ePGgafc7sW3mogc647rA7x03ioU7IkJQJnN3xPV?=
 =?us-ascii?Q?9NnmK3tZWf5L5KEYhmpZdnIJq0Al+1jzrLZvfOgSa1HHP6f/vf39ms3HwfQ6?=
 =?us-ascii?Q?3gXzvKpqghpFjpttBkUwxzpSs4OU1Cs8tqAlSbv1dNCP7S7YbNDPPqyarfFC?=
 =?us-ascii?Q?yc7uq7aYIp9E9iUr9shpDMLbXvkV5QmKzSgbNeldtCgqN6oLj4nOm4OK0hh2?=
 =?us-ascii?Q?koxvUc5LcGXKv5sCQOgPZlSe2Kjjv1Qdi5UEzAaZ4EZhKzd0SBY18bFQBPK3?=
 =?us-ascii?Q?QN48JkjthYlH/y7FJ6JZCl0Y48dgAHrxfWHmmzGLXBgNT5bPfddp+iXXygzI?=
 =?us-ascii?Q?BdCgBoM4ZCSve+zqeEE0yTWBVs+b1JkqdJ9dfnTDfC7cbNvfDxaX25Yko8LX?=
 =?us-ascii?Q?06QdIrl1I8yvlZbVGPn360wIukRvw8v4PFpZny54VUh49yhYSeMaSKhiF7fx?=
 =?us-ascii?Q?wNmIUJF9R+gSYPWQxotTBUia1WgA5/jrBOoRfJjJp51qKyEdUlTvflf15Lnw?=
 =?us-ascii?Q?B+iQODI9Sotgql86hnmtKhxxe8fIHgWYgHKBMaXjthCCsx9MtSf55bcMpai5?=
 =?us-ascii?Q?Oqepp5vhunPPfL/hzJRjHRJ8OwpF7yhXSRkqQpl5fevc3TI140Z5NA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ybD2NjrJ1yC3H2C41xuaJUQHkJwty8vWSaorSIVny3ZoL/O2TOvYV4tHuF6F?=
 =?us-ascii?Q?aEXj4gCVNTufVcNAeVWZM+dKHgDL+GGvSGnm1eZh9SxhMgjXI16NPqrOUFFp?=
 =?us-ascii?Q?FH1Ha/F6/RWmZ7zllTjmBAWZLtmTDu9qQt1hL/Oqx6TH0xhD9y7AK26sE0dy?=
 =?us-ascii?Q?j00wdDk7GpbzWLr4tnDDiv4IqNUG5vp6cqDSrxJbmnIW7se/QEwpVg9K+Q25?=
 =?us-ascii?Q?dU7VTq3R6HbWzTBCAXIBnNlXM7S0WWzHEMgriG6MlPU765snY7ZYxMoeuda+?=
 =?us-ascii?Q?Yq+Nh3xgR8w+MQdo4UTWfjeHcXxcd2mIfLlrJXFdv3lEcsiuVZqb4o8E2SUX?=
 =?us-ascii?Q?kF3ZT8PPtKVWX67hlq4Si0r+Yyp/wprO7iPqd/taWmrLsGE8rcWCYi06V5dm?=
 =?us-ascii?Q?Mt46V69AshslIMiDtkHe/9MmGqRpcISD8cpsO7PIPhc2Zd4lCGQA6MRD0e92?=
 =?us-ascii?Q?1KsnJApViZpvk6tfZBoI5dRcZpZbWhWqWeP3lOKjLz5i/GPL8tl7okS5cVko?=
 =?us-ascii?Q?fJ3hB+JlxhS7NyJlNSztDSp741BjpM/lYB875plyWP/JWkrozkPFYnRmBEDQ?=
 =?us-ascii?Q?DxCMYR1zZE3PcCImN5F1TP0/InTXqt3h7WWqHdwTT8LDGPMxU8MhOseEbSgZ?=
 =?us-ascii?Q?IersrgKEMTt8u8IMOnowKSVJMfWP2biIiNH5vz42ZNRiA/6gTAsJXU2PD4jG?=
 =?us-ascii?Q?sfM5hhQm20mR6rCbFefmqKhXIebx8Cs1GjYDKT/KxUcznM4AVF79Lx3zsKzT?=
 =?us-ascii?Q?V9fsUY4ptpIkqeqH8Fhwi+vWeEjiIAtFiLrs1P31Dq9IL3+YYgmkZ1y52ZUy?=
 =?us-ascii?Q?EYTK/PUDE3gR9C8TKfazEEWm8qM2G/h491NIfP5dfQa8uBsOq+UoNRyWN0jy?=
 =?us-ascii?Q?w1zUrdu9qlFNlorL5GWGeSMB2cUh4X1YKvJgaVV3e46AyojGdPJB9YUm31E0?=
 =?us-ascii?Q?YCk4b9rPDrwlWp+RwZD+RkGrC0M1vwTUGlBYGbkBHTyVjvzD5QmPFg+oPMaB?=
 =?us-ascii?Q?HhoL+rFCcCWPk0dV7rluKWsCbxPZOQouNYt2eWcdk0WRqwWpgXr3MYM244wv?=
 =?us-ascii?Q?6oOTAwKaXe0fmXeniH5FEH3SV7RSaU7IRkt5hEzLi89wkwKlaH4T/yXOBkW1?=
 =?us-ascii?Q?J/uEtxlCY1+tWJIeiJbXZqpBaAD0M/WOWM/1hUGTxJMmVgMo20j8HPK+p+4a?=
 =?us-ascii?Q?hmA/tTgwxj7a6v/5lOnyk7947chk1Jm6DGypgpqHnCKgYvpsw10PACxPHv84?=
 =?us-ascii?Q?1BXya0yizlpw6XhzmB3bRecNccZ0Z4nvCaXvFY1zn6AZs1PP2i2tFclcQoRr?=
 =?us-ascii?Q?iJxxNJc7oQAzwruPul9I5hKDmUFnf5AXX2oCMXPUnc/3AtoZh/mVIt0SH72/?=
 =?us-ascii?Q?r6SwxHQ093r5KHEiHGPqMPbusnmlxlGVfwgBUClXEn0qmFEAkVvpqA0P9hWa?=
 =?us-ascii?Q?Qf3x2PJG4J0ey95VywYfBNbdIxb6cyOjETMdhQ0vZYbUbsRc6qxnlx6wnAFI?=
 =?us-ascii?Q?6jjs210teAFHEecbjV0ZLJFnfyhA7pCtlwu614xm83REUKR2NPf90iJpdSSA?=
 =?us-ascii?Q?LtqRC2e1faYfVfYvdD9DFUI9c8gVm8s7Hfj15fOowPyGb1gIo5ybGzQnYt2T?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960a5425-44ce-4382-39b8-08dd80fc9310
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 17:47:24.5641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFc//B0qoEv6NDvyHxkAWyMInBYa+xaWAM1TQNTyoyuQEYJQ5XsahuN6HIVGFHHvy5Tx6fqVM8Di+5doKdZdVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968

Currently, the ->gpwrap is not tested (at all per my testing) due to the
requirement of a large delta between a CPU's rdp->gp_seq and its node's
rnp->gpseq.

This results in no testing of ->gpwrap being set. This patch by default
adds 5 minutes of testing with ->gpwrap forced by lowering the delta
between rdp->gp_seq and rnp->gp_seq to just 8 GPs. All of this is
configurable, including the active time for the setting and a full
testing cycle.

By default, the first 25 minutes of a test will have the _default_
behavior there is right now (ULONG_MAX / 4) delta. Then for 5 minutes,
we switch to a smaller delta causing 1-2 wraps in 5 minutes. I believe
this is reasonable since we at least add a little bit of testing for
usecases where ->gpwrap is set.

Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
v4->v5
 - Added gpwrap_lag torture param to turn off entire test.
 - replaced references to 'ovf' with 'gpwrap lag'.

Will move this to my rcu/torture-for-6.16 and update my rcu/for-next branches.
 
 .../admin-guide/kernel-parameters.txt         |  5 ++
 kernel/rcu/rcu.h                              |  4 ++
 kernel/rcu/rcutorture.c                       | 72 ++++++++++++++++++-
 kernel/rcu/tree.c                             | 34 ++++++++-
 kernel/rcu/tree.h                             |  1 +
 5 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 76e538c77e31..e1d11b6595fd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5657,6 +5657,11 @@
 			are zero, rcutorture acts as if is interpreted
 			they are all non-zero.
 
+	rcutorture.gpwrap_lag= [KNL]
+			Enable grace-period wrap lag testing. Setting
+			to false prevents the gpwrap lag test from
+			running.
+
 	rcutorture.irqreader= [KNL]
 			Run RCU readers from irq handlers, or, more
 			accurately, from a timer handler.  Not all RCU
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index eed2951a4962..516b26024a37 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c_old,
 			       unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
+void rcu_set_gpwrap_lag(unsigned long lag);
+int rcu_get_gpwrap_count(int cpu);
 #else
 static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 {
@@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 	do { } while (0)
 #endif
 static inline void rcu_gp_set_torture_wait(int duration) { }
+static inline void rcu_set_gpwrap_lag(unsigned long lag) { }
+static inline int rcu_get_gpwrap_count(int cpu) { return 0; }
 #endif
 unsigned long long rcutorture_gather_gp_seqs(void);
 void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 402b9979e95a..92e2686a4795 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -118,6 +118,10 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(bool, gpwrap_lag, true, "Enable grace-period wrap lag testing");
+torture_param(int, gpwrap_lag_gps, 8, "Value to set for set_gpwrap_lag during an active testing period.");
+torture_param(int, gpwrap_lag_cycle_mins, 30, "Total cycle duration for gpwrap lag testing (in minutes)");
+torture_param(int, gpwrap_lag_active_mins, 5, "Duration for which gpwrap lag is active within each cycle (in minutes)");
 torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
 torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
 torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
@@ -419,6 +423,8 @@ struct rcu_torture_ops {
 	bool (*reader_blocked)(void);
 	unsigned long long (*gather_gp_seqs)(void);
 	void (*format_gp_seqs)(unsigned long long seqs, char *cp, size_t len);
+	void (*set_gpwrap_lag)(unsigned long lag);
+	int (*get_gpwrap_count)(int cpu);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -626,6 +632,8 @@ static struct rcu_torture_ops rcu_ops = {
 				  : NULL,
 	.gather_gp_seqs		= rcutorture_gather_gp_seqs,
 	.format_gp_seqs		= rcutorture_format_gp_seqs,
+	.set_gpwrap_lag		= rcu_set_gpwrap_lag,
+	.get_gpwrap_count	= rcu_get_gpwrap_count,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -2631,6 +2639,7 @@ rcu_torture_stats_print(void)
 	int i;
 	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
 	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
+	long n_gpwraps = 0;
 	struct rcu_torture *rtcp;
 	static unsigned long rtcv_snap = ULONG_MAX;
 	static bool splatted;
@@ -2641,6 +2650,8 @@ rcu_torture_stats_print(void)
 			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
 			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
 		}
+		if (cur_ops->get_gpwrap_count)
+			n_gpwraps += cur_ops->get_gpwrap_count(cpu);
 	}
 	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
 		if (pipesummary[i] != 0)
@@ -2672,8 +2683,9 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
 	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
-	pr_cont("nocb-toggles: %ld:%ld\n",
+	pr_cont("nocb-toggles: %ld:%ld ",
 		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
+	pr_cont("gpwraps: %ld\n", n_gpwraps);
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
@@ -3844,6 +3856,57 @@ static int rcu_torture_preempt(void *unused)
 
 static enum cpuhp_state rcutor_hp;
 
+static struct hrtimer gpwrap_lag_timer;
+static bool gpwrap_lag_active;
+
+/* Timer handler for toggling RCU grace-period sequence overflow test lag value */
+static enum hrtimer_restart rcu_gpwrap_lag_timer(struct hrtimer *timer)
+{
+	ktime_t next_delay;
+
+	if (gpwrap_lag_active) {
+		pr_alert("rcu-torture: Disabling gpwrap lag (value=0)\n");
+		cur_ops->set_gpwrap_lag(0);
+		gpwrap_lag_active = false;
+		next_delay = ktime_set((gpwrap_lag_cycle_mins - gpwrap_lag_active_mins) * 60, 0);
+	} else {
+		pr_alert("rcu-torture: Enabling gpwrap lag (value=%d)\n", gpwrap_lag_gps);
+		cur_ops->set_gpwrap_lag(gpwrap_lag_gps);
+		gpwrap_lag_active = true;
+		next_delay = ktime_set(gpwrap_lag_active_mins * 60, 0);
+	}
+
+	if (torture_must_stop_irq())
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward_now(timer, next_delay);
+	return HRTIMER_RESTART;
+}
+
+static int rcu_gpwrap_lag_init(void)
+{
+	if (!gpwrap_lag)
+		return 0;
+
+	if (gpwrap_lag_cycle_mins <= 0 || gpwrap_lag_active_mins <= 0) {
+		pr_alert("rcu-torture: lag timing parameters must be positive\n");
+		return -EINVAL;
+	}
+
+	hrtimer_setup(&gpwrap_lag_timer, rcu_gpwrap_lag_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	gpwrap_lag_active = false;
+	hrtimer_start(&gpwrap_lag_timer,
+		      ktime_set((gpwrap_lag_cycle_mins - gpwrap_lag_active_mins) * 60, 0), HRTIMER_MODE_REL);
+
+	return 0;
+}
+
+static void rcu_gpwrap_lag_cleanup(void)
+{
+	hrtimer_cancel(&gpwrap_lag_timer);
+	cur_ops->set_gpwrap_lag(0);
+	gpwrap_lag_active = false;
+}
 static void
 rcu_torture_cleanup(void)
 {
@@ -4017,6 +4080,9 @@ rcu_torture_cleanup(void)
 	torture_cleanup_end();
 	if (cur_ops->gp_slow_unregister)
 		cur_ops->gp_slow_unregister(NULL);
+
+	if (gpwrap_lag && cur_ops->set_gpwrap_lag)
+		rcu_gpwrap_lag_cleanup();
 }
 
 static void rcu_torture_leak_cb(struct rcu_head *rhp)
@@ -4519,6 +4585,10 @@ rcu_torture_init(void)
 	torture_init_end();
 	if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
 		cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
+
+	if (gpwrap_lag && cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
+		goto unwind;
+
 	return 0;
 
 unwind:
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 659f83e71048..6ec30d07759d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -80,6 +80,15 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *);
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.gpwrap = true,
 };
+
+int rcu_get_gpwrap_count(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	return READ_ONCE(rdp->gpwrap_count);
+}
+EXPORT_SYMBOL_GPL(rcu_get_gpwrap_count);
+
 static struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
 	.gp_state = RCU_GP_IDLE,
@@ -757,6 +766,25 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 	smp_store_release(per_cpu_ptr(&rcu_data.rcu_urgent_qs, cpu), true);
 }
 
+/**
+ * rcu_set_gpwrap_lag - Set RCU GP sequence overflow lag value.
+ * @lag_gps: Set overflow lag to this many grace period worth of counters
+ * which is used by rcutorture to quickly force a gpwrap situation.
+ * @lag_gps = 0 means we reset it back to the boot-time value.
+ */
+static unsigned long seq_gpwrap_lag = ULONG_MAX / 4;
+
+void rcu_set_gpwrap_lag(unsigned long lag_gps)
+{
+	unsigned long lag_seq_count;
+
+	lag_seq_count = (lag_gps == 0)
+			? ULONG_MAX / 4
+			: lag_gps << RCU_SEQ_CTR_SHIFT;
+	WRITE_ONCE(seq_gpwrap_lag, lag_seq_count);
+}
+EXPORT_SYMBOL_GPL(rcu_set_gpwrap_lag);
+
 /*
  * When trying to report a quiescent state on behalf of some other CPU,
  * it is our responsibility to check for and handle potential overflow
@@ -767,9 +795,11 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + ULONG_MAX / 4,
-			 rnp->gp_seq))
+	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + seq_gpwrap_lag,
+			 rnp->gp_seq)) {
 		WRITE_ONCE(rdp->gpwrap, true);
+		WRITE_ONCE(rdp->gpwrap_count, READ_ONCE(rdp->gpwrap_count) + 1);
+	}
 	if (ULONG_CMP_LT(rdp->rcu_iw_gp_seq + ULONG_MAX / 4, rnp->gp_seq))
 		rdp->rcu_iw_gp_seq = rnp->gp_seq + ULONG_MAX / 4;
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a9a811d9d7a3..63bea388c243 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -183,6 +183,7 @@ struct rcu_data {
 	bool		core_needs_qs;	/* Core waits for quiescent state. */
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
+	unsigned int	gpwrap_count;	/* Count of GP sequence wrap. */
 	bool		cpu_started;	/* RCU watching this onlining CPU. */
 	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
 	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
-- 
2.43.0

