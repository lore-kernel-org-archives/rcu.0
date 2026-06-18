Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D83E122F;
	Thu, 18 Jun 2026 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808708; cv=fail; b=BkEuPABodf9rQdeWhV2B+3pzV9UK+1TP9g5QtzNj/NKc3gNVy/NY0hTtMbdX+XEIrmHgYpidrRslfpPrZuhjQkzmYYLLMF2d2C33eDCaIgJ3QLv9yrxjxVK1MavCrlr/Qh7v1kgXQXqKKE5innw2PRxO1fEJCLyFBuU8ill174M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808708; c=relaxed/simple;
	bh=wYrAdyQkPyY+sn+TjuztlaweIyim5T8dcWLh8sKIQWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mCY20ZJYhswtUzmG2OfQHfw78FuR2XT33Hr7e5wj4c0QkUrzBQboQwcHgRCvW0tgThfVkxemIya8LYemLB+8RtWCeM+XLWjmNqWZKxMtJjRqEGC7NayqfA7v+IrOMjFnC1mHaQi+0y0qoIkNHX6UGyc+yfPrj9VuanWvg5Yu8tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q/2FS4BC; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q/2FS4BC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfuLXVAei2Otvjjx2xvctGZUoEPeEVMfQ2SRgbNMWZzbI0h/fjYcT8q8ZzX0qlMEs6kziTvLPB1F7Fw/RAb/xVCHL6ISE6y3ZbNbFIAxqzPZ9QIw4vAt6bb145EyKnI6+nTMxB49M6gqpfQfWU2o/YzcTLxfpFlNc8yQrIIryvRh9U3Br5HxBsjqNXf1JLNG2vGxF793N8yw2L8LipmvNilK6l95g60au6u2bkOqVtNq+rDLCE4CoTDZGPbWf4W4hRftZJUhUS1WDP7mECtmwZzQh0xshk2aVmfdHUTAfAtxEXtnHvVVN4Lll3IjFDuNgnxozO9pjnLQxK7eZ1LeFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbxdbxbvNn2u8tEWNaU0ltZqVZ4sJ5UM6znrYfdm5Uk=;
 b=qXzpo9AEjH+2cLcQvhCeUzAPTd0c38oCLO/8cwNgV3HgZdBJRPZ7+Iww1yhreLksii1Uv4Tf6FRWm/uY3jcxuCzBjxE6V0ddEBN4K6dLGxpi8XWqlQTNZDQZPvqUdE5+Wj1/b8u5Uc7/rnUXUvzGqOXxbgfcThz6+RNoFnUygsFxxex5fAcroRhute/E2Uy2OrYzBTDKaYBGUeP4l2aFbpBG8QgFNgolj/a/pl7MIwXBfQ5WHFmuHhzSpDjwtvIaaWztHDdDj+le8b59vnOaf0NUA3juxmjB2UR9xJ6PLFdKDwlWSmRss9ywjufeY+PAvX5jLw5SVuB8eZHSpoicNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbxdbxbvNn2u8tEWNaU0ltZqVZ4sJ5UM6znrYfdm5Uk=;
 b=q/2FS4BCT6xQT/g9NWwU5TWE+dDoDM2vqrME2Ccs1xViSGUghkk7sVRI3dRpJK2+gM05cBhpdlYlw0fvA8Sew3UP7NXDyvihF2NqJN50o94iJcHS24SZ6OyAWbOGGQyYKe/Ccix3Dy9vpoTRho6qRZ0JPaMuLC/xJJMz+qsFwgF1rlQZKMfvW145ly+RCuOEoPzGeA0H4PDjN1BNGFHZankhuPjPyd4BY0IKOy+pKKAJV9LWMWB/5iyGDMgDNsdBmj/JyEsLDZU2UZTGN80Un8lYiyJ+u7KmxoT24ltEAfHbaDMpwfOBM84RcjCmaKViGScxGwcYW34z1sn+jFhPsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:32 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:32 +0000
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
Subject: [PATCH v3 11/14] rcutorture: Test RCU readers from hardware interrupt handlers
Date: Thu, 18 Jun 2026 14:50:27 -0400
Message-Id: <20260618185030.376450-12-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:208:239::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 2106c908-e052-4b53-d7ac-08decd6a9cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|5023799004|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+S3mqgyh/TuBCvJUZjdWiOOTSwCfNSZfspoEo9PvykQraqIHXnsnvOJ7+zkgtbxrTVbHq2McaY6UByA+R9bou9+Qrl1qTBvvAF7RfrRjPpzzMCNl65UNqhV2ZPv8e9UZzuvlVXrVvcxLOhLLWpwN8l2V3sIEG6z2O//PbDy5/G83i7ZhO6xLE4txbVY1w+szEiMgGII8DxdDwQ2ROLvZwznSb9etwqkF8gFEDK5x7K6bd0g9PfiqoX7hroO6g0qIou9w1eJ59WYILg5qK6LxJNbF4gWVUg+gMgH5WIXlCasyh72+T6y34mtyCKilPhOQfLVLp5Ye+IqtXChj45gt22IHkSrTnAK7d36tiLlwvHz7GKOuF5CHsCKWPk3BH3VZQuY6j0PydzFLADtVggATYehxpzys93VUMtisQnwfRmoeWZXNFJrlZ0YAqlP+eLytCpxmOid1R46+UXOtnuzQtDzFCCYoBwF2bGnNoIhPyTV1yX2VtbVn3/mbAHGfZZxS/lc4FlYuck9NyhkQfUzXNwmBAwmWikkA2vxvebshzdZYMIzXj4Y83Q3daO37+urWMKDlpW/xYiMOzILgvUKpkT4CpBBXpTda84VXQCJ36FShyyvFbu3LWDpi8NMlxWzw4kmMhXx6DnHnMaJYDtG1Pg2+tNf8PToftmU4mhZSb9M7G6ViY2OD7YL4gcg01YkE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UPg4JwnI4/RxRO0J7MtPBEg/GD7x+bLbvt8MS19IoPywwA19ALQuTg6/MXeO?=
 =?us-ascii?Q?lS1x3ZZS7hLq63uIw7j3Fck0copOxdmeLFVPZc/H4XPHNyhcEqOcrU7Ct6sp?=
 =?us-ascii?Q?fU09TJFRayWKLJb4uwkNLgiZfwhlaFzIX/okjZ/u23QrJ+uBkrqbLTuaGSke?=
 =?us-ascii?Q?1SPO0weOnbU/RuqqaZyD2m+GHY1sB4N6UvF5ahNGdmfnsJSoACtzXbNWnvit?=
 =?us-ascii?Q?bv+PapwQrLA043zQeZYPNUzoaxUMGV8o8IhMY23uHhIzlbnUVHL8Dxsh/uUl?=
 =?us-ascii?Q?FYb6EeFPobnqXpCHgD0sgLY8JQ8VnB2Fd1CkkOnhEQVaYIouoKOraSETpUD+?=
 =?us-ascii?Q?KiLi8CalgMnCd7Ka4BJsDGFh577pg5OG1/IZm5WqfbYxpGbWhYAEl5cCk+LZ?=
 =?us-ascii?Q?L63IU+y4y6ouX2TVvesNYAp94elIHd3tVSVV2M87t/yjjj17oVMuFwnBAOOg?=
 =?us-ascii?Q?TWewX5SV0W6HjyZmrHGq6xDGQ6o//7BaRNLH4L7QTNRH2TcyXoNX9gLxTEJ6?=
 =?us-ascii?Q?iAW4LKgnab7ekt/c/YbvMxxSEOgsGiyQa0+R5SvsvblOxS07ZQ+gpBKf+pdE?=
 =?us-ascii?Q?XkoB9PCOAGgYW5rNvRZkyn6IrOTWKHvvQSaQBrkgE+5B1+sWzA5JYNIa9ZZy?=
 =?us-ascii?Q?O5kcgf9B74tHg8ryoxDJNzPrnbZe0+GfHsgS185d9gkq+9WjB+8JL0qCDLCN?=
 =?us-ascii?Q?a6TJZbjQ4ZHGSfDlV6C4HWhDYx42MwnNrOSJSfHqiTkelPZ7JYplQG42Y4O8?=
 =?us-ascii?Q?cfRnc4H0mLRJz/QZh2wuTvNNw2c2BitDnJFqxFChR/qZ8QHncERdbh3K0Wkk?=
 =?us-ascii?Q?OSejxC3m2AGEKIg0lWuIO2iD/l2+dBsN8QKsy8t/MK3xkF2LpC3Fq1aAhMQd?=
 =?us-ascii?Q?G0M9YLkD1VwL3oiHaSTa+ZGroM/UgOBAN70bBtGsgj7eg/jqu5h7BTO3Oi3N?=
 =?us-ascii?Q?JJEcVJWLqpG5nr3HcXtzvOpXOwdZzfr1D7Cpm2PX2o9vokbYrVFKJGdlqLNr?=
 =?us-ascii?Q?7aIIIrBTakLQeZPhqlSryJKXARhtTiSKw2o2QfIomCv8vdEKXOEd5vb69rBf?=
 =?us-ascii?Q?2flU3aune8UNluzfvcv0AUxhBtb7a/NFTUsyPxDO5OQQs+SxTjleEyDzFc3N?=
 =?us-ascii?Q?TGFjYHChxLXCo1DW8kbo5y7AmCJWXssMDa0SQYb47KN5VYfMmf77gS70V/DT?=
 =?us-ascii?Q?8SxnNpD1e0Gyiu5GYHSt/u8aOVxc9p+Fi7Csd0dRtMYtDLdLGTH7jAUd+UnW?=
 =?us-ascii?Q?lupCiqmY6370bKgCeRP+Gjeug2AQtQkODPM0lOONL8aaFwJEgD5iyshzNe7g?=
 =?us-ascii?Q?CHgeu+7FaU9kNg3+nhR1X3Hc7HRjVRPjSNoAlyuIU2VCszpYKa/xuVpv7/81?=
 =?us-ascii?Q?0exagv4tp2htlXGeTNjBvoHIBSOwT9VEBYdm4kP2D8YB+fl6bY0WLec12so8?=
 =?us-ascii?Q?HKuxIuLhdgXSR258gUAVMlqbu5Dicxj2dw4STICjrJG6SdKbvYAAyuExEWG1?=
 =?us-ascii?Q?VDkKvOaCuITU5cHPtC/yxiQ2mN1Lt89VE1ggdqEf5fDOcVL8jqQrjXga6BBB?=
 =?us-ascii?Q?Mhf3DP/NulopOmXI0Q++tDApGYtEc7NUuZI4sU19d5AkwCKr83e233SZcwqr?=
 =?us-ascii?Q?Tsu15ZaRfWgq0yMUqjb5j9k+Vq+uFgcKPhVJlO0NusjP0K8Xa3IkShPfw1Qe?=
 =?us-ascii?Q?HddISY6oofCmQDgmyhU5127syf4xXmCCwcLv2hm/eBhD0B+xMXb9PpgNqOGZ?=
 =?us-ascii?Q?dLhSfjmU4A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2106c908-e052-4b53-d7ac-08decd6a9cfd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:32.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUKIr64+HhcvOCe8Y/6gbRRlJBwKz4fmtBn8Dzu1+RhedNefr+T7gQ0v4AFQaEv6OzO37anW34oQEj3BY3YHxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

From: "Paul E. McKenney" <paulmck@kernel.org>

Although rcutorture has long had the irqreader module parameter, this
parameter results only in RCU readers in softirq handlers, specifically,
timers.  This commit therefore uses smp_call_function_single() to test
RCU readers in real hardware interrupt handlers, thus providing the full
effect from the irqreader module parameter.

However, consistency/debug checks must account for the possibility that
the smp_call_function_single() handler function is directly invoked
from the idle loop, in which case, for example, in_hardirq() will
return false.  This commit uses a per-CPU variable to record being in
the rcu_torture_irq() smp_call_function_single() handler function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 75 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 04c36fcde5cd..13e0eec1e1ce 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -212,6 +212,7 @@ static long n_rcu_torture_boost_ktrerror;
 static long n_rcu_torture_boost_failure;
 static long n_rcu_torture_boosts;
 static atomic_long_t n_rcu_torture_timers;
+static atomic_long_t n_rcu_torture_irqs;
 static long n_barrier_attempts;
 static long n_barrier_successes; /* did rcu_barrier test succeed? */
 static unsigned long n_read_exits;
@@ -2103,6 +2104,8 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
 	smp_store_release(&rtrcp_assigner->rtc_chkrdr, -1); // Assigner can again assign.
 }
 
+static DEFINE_PER_CPU(bool, torture_in_scf_handler);
+
 // Verify the specified RCUTORTURE_RDR* state.
 #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
 static void rcutorture_one_extend_check(char *s, int curstate, int new, int old)
@@ -2129,7 +2132,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old)
 
 	// Interrupt handlers have all sorts of stuff disabled, so ignore
 	// unintended disabling.
-	if (in_serving_softirq() || in_hardirq())
+	if (in_serving_softirq() || in_hardirq() || this_cpu_read(torture_in_scf_handler))
 		return;
 
 	WARN_ONCE(cur_ops->extendables &&
@@ -2321,12 +2324,19 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 			mask |= RCUTORTURE_RDR_RCU_1;
 	}
 
+	/*
+	 * Don't mess with interrupt masking in interrupt handlers.
+	 */
+	if (in_hardirq() || this_cpu_read(torture_in_scf_handler))
+		mask &= ~(preempts_irq | bhs);
+
 	/*
 	 * Can't enable bh w/irq disabled.
 	 */
 	if (mask & RCUTORTURE_RDR_IRQ)
 		mask |= oldmask & bhs;
 
+
 	/*
 	 * Ideally these sequences would be detected in debug builds
 	 * (regardless of RT), but until then don't stop testing
@@ -2581,6 +2591,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 		return false;
 	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, trsp, rtors.rtrsp);
 	rcu_torture_one_read_end(&rtors, trsp);
+
 	// This splat will happen on systems built with CONFIG_IRQ_WORK=n
 	// and on systems where arch_irq_work_has_interrupt() returns false.
 	// It might also happen on systems using a short-duration clock
@@ -2618,7 +2629,7 @@ static void rcu_torture_timer(struct timer_list *unused)
 	atomic_long_inc(&n_rcu_torture_timers);
 	(void)rcu_torture_one_read(this_cpu_ptr(&rcu_torture_timer_rand), -1);
 
-	/* Test call_rcu() invocation from interrupt handler. */
+	/* Test call_rcu() invocation from softirq handler. */
 	if (cur_ops->call) {
 		struct rcu_head *rhp = kmalloc_obj(*rhp, GFP_NOWAIT);
 
@@ -2627,6 +2638,41 @@ static void rcu_torture_timer(struct timer_list *unused)
 	}
 }
 
+static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_irq_rand);
+
+/*
+ * RCU torture reader from timer handler.  Dereferences rcu_torture_current,
+ * incrementing the corresponding element of the pipeline array.  The
+ * counter in the element should never be greater than 1, otherwise, the
+ * RCU implementation is broken.
+ *
+ * Note that on some systems, "interrupts" from idle are direct calls
+ * rather than interrupts.  The torture_in_scf_handler per-CPU variable
+ * accounts for this case.
+ */
+static void rcu_torture_irq(void *unused)
+{
+	WARN_ON_ONCE(in_nmi());
+	lockdep_assert_irqs_disabled();
+	atomic_long_inc(&n_rcu_torture_irqs);
+	this_cpu_write(torture_in_scf_handler, true);
+	(void)rcu_torture_one_read(this_cpu_ptr(&rcu_torture_irq_rand), -1);
+	this_cpu_write(torture_in_scf_handler, false);
+
+	// Test call_rcu() invocation from interrupt handler.  Interrupts
+	// will always be disabled here, even in CONFIG_PREEMPT_RT=y kernels.
+	// The "right" thing to do would be to create a special-purpose
+	// lockless or raw-spinlock-protected allocator, but in the meantime,
+	// skip testing call_rcu() from interrupt handlers in kernels built
+	// with either CONFIG_PREEMPT_RT=y or CONFIG_PROVE_LOCKING=y.
+	if (cur_ops->call && !IS_ENABLED(CONFIG_PROVE_LOCKING) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		struct rcu_head *rhp = kmalloc_obj(*rhp, GFP_NOWAIT);
+
+		if (rhp)
+			cur_ops->call(rhp, rcu_torture_timer_cb);
+	}
+}
+
 /*
  * RCU torture reader kthread.  Repeatedly dereferences rcu_torture_current,
  * incrementing the corresponding element of the pipeline array.  The
@@ -2636,6 +2682,7 @@ static void rcu_torture_timer(struct timer_list *unused)
 static int
 rcu_torture_reader(void *arg)
 {
+	unsigned long lastscf = jiffies;
 	unsigned long lastsleep = jiffies;
 	long myid = (long)arg;
 	int mynumonline = myid;
@@ -2649,8 +2696,25 @@ rcu_torture_reader(void *arg)
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);  // CPU bound, so need tick.
 	do {
 		if (irqreader && cur_ops->irq_capable) {
-			if (!timer_pending(&t))
+			if (!timer_pending(&t)) {
+				int cpu;
+
 				mod_timer(&t, jiffies + 1);
+				preempt_disable();
+				cpu = torture_random(&rand) % nr_cpu_ids;
+				if (!cpu_online(cpu)) {
+					cpu = cpumask_next(cpu, cpu_online_mask);
+					if (cpu >= nr_cpu_ids)
+						cpu = cpumask_next(-1, cpu_online_mask);
+				}
+				// An smp_call_function_single() to self is not an interrupt!
+				if (cpu != smp_processor_id() &&
+				    time_after(jiffies, lastscf + HZ * nrealreaders / 50)) {
+					smp_call_function_single(cpu, rcu_torture_irq, NULL, 0);
+					lastscf = jiffies;
+				}
+				preempt_enable();
+			}
 		}
 		if (!rcu_torture_one_read(&rand, myid) && !torture_must_stop())
 			schedule_timeout_interruptible(HZ);
@@ -2926,10 +2990,11 @@ rcu_torture_stats_print(void)
 		atomic_read(&n_rcu_torture_mbchk_fail), atomic_read(&n_rcu_torture_mbchk_tries),
 		n_rcu_torture_barrier_error,
 		n_rcu_torture_boost_ktrerror);
-	pr_cont("rtbf: %ld rtb: %ld nt: %ld ",
+	pr_cont("rtbf: %ld rtb: %ld nt: %ld ni: %ld ",
 		n_rcu_torture_boost_failure,
 		n_rcu_torture_boosts,
-		atomic_long_read(&n_rcu_torture_timers));
+		atomic_long_read(&n_rcu_torture_timers),
+		atomic_long_read(&n_rcu_torture_irqs));
 	if (updownreaders)
 		pr_cont("ndowns: %lu nups: %lu nhrt: %lu nmigrates: %lu ", ndowns, nups, nunexpired,  nmigrates);
 	torture_onoff_stats();
-- 
2.34.1

