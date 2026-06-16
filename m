Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1453AA1BB;
	Tue, 16 Jun 2026 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648806; cv=fail; b=JjqB6K5nfMi3IF3lKTbzMEKzeXzLN8dIstnJe6+GgzSgg/dw+xMLI8o43Vc0K6FOI5lnQ6OKsRJP2yfhCpDHk5mAWOQ0tcIAwqeaGLA+9BeIZfyE08IOq2kEeROKQcg8n70k73sMx7passgchY1npRiKz+BDy+KqGaD6TMEpUVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648806; c=relaxed/simple;
	bh=xWVcU+dRwEEX7yMGDtIucgSBJx1TYxh4krfO0uehP9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QfE79OZ+M3SLhdfM2kluVfPimbZBnuzeVGmtSkEHyxZC9ESR9T9hu7HlD608QdABNqMcjZ3AgP3BytKnzdNRwRr+ziTFY1rOZwZwBV5vp2YUGCFGp/xK6bzUbBpjpUORtS57xGb7qX94xZ7Frp5IXaGBQmsEwv9yzcUCD5Kgavw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VCuwOxR8; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VCuwOxR8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=claio6K/9SOJGb2LMqTWpVpPQrhnaFPgzNl7mrfKRKWVZrVqBA1sHwNACTJjq1CQ72bNZZbgwLkH4CiWi/54lFkT1uvMdYUTpkZSapzAhCclo26VtEkrJ32kut6f9zjepQZe0d9W2UMrhacYfKZ5xNrqFXVGy1WUeZdYE47B1NyOAVXUOGIWk+GPMg4Qey7yTUFiD/d+r/8v4bpkTCUkDDec7k3lOU+ggPt7qMogt3co23lO5bIyavUMqqFk29n1W5QDfbyZgFPh3a4hHFIPT6bSD0RsEgQQcTGgR1q0DGoTDFI2RdslfEnPyqAH6fsZt7JQwXW00dee/kOTk8v6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdtqNMFlvgkEyHzbRwJiC8lyHE91voXpXoC2RUQoNnA=;
 b=i6L80xt6d1Kgx3UiO+HqsduSeeoxsePLp44K01zYCTMOpTE0NgDNpT6iUo1fxfUgGJFKWPdfmOep0QHjNZmOYv4ohbiwbRfHWFmf6uP282MZkJ9wFA6wBU64syoei8Bx8YcaBoCSZxjk8JJL+KnrGUTCQV1vsn9i4cxmS17gCPo9qL7XATWjfPYqVAuGXWhCoL+b5TygPT87szLNdjW/w+G5Q87h5s6FPnLOB4/fVQmMzQf0XiUdjGS4WN6zmxzK0cUjPy2ovbc6C20gszUrY8MbCP4REdTn5cWHdGCeUK9esr12uU4c3I/TCrikfkrjqrS1m6xGGD12XFie3HBueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdtqNMFlvgkEyHzbRwJiC8lyHE91voXpXoC2RUQoNnA=;
 b=VCuwOxR8jHRVRt8IpbpyAK/RJYf1J/zPRsBjW67cnAINYZNN5Hdyq7YVbs+aj371WLniGxRi3m2H3jaxmMhxO44ffGnSyEA9PhNFyktD65bdzWt8yR7PjGcXpxubsmIItJuDtZi+XiY4s7SY4IxjOPNhSF6TyDIoH1DJmooUB1KCYEdjvqhE6ZO4jCPYvWUZJ0oaaFXuAs8PxOLu+WSpYcIs1dUc3Ct3V9bDUp3PcySKpLat6rdYTwFdcc1FKt4DBVCEM+JuIoNHkU9ZrHXrlpQA4hFtLLyvbMryJhlM2pQFl7gJUPZ+aAnO6IKZSXsDw6+0Hy3k0Kt5QWPturhfng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Tue, 16 Jun
 2026 22:26:29 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 22:26:29 +0000
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
Subject: [PATCH RFC v1 3/5] rcutorture: Test RCU readers from hardware interrupt handlers
Date: Tue, 16 Jun 2026 18:26:20 -0400
Message-Id: <20260616222622.2981876-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616222622.2981876-1-joelagnelf@nvidia.com>
References: <20260616222622.2981876-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da25078-79de-4628-7991-08decbf64f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|11063799006|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	os//QZfAf6/bcllU2wlzPHuA7spbcGDp65aH1VD97HMdoVH4PBCW9LkFMZs1whP2NVrnVsTTcE6wJjNijOUfamTzSR4CwmN2wCq+GP+2Q8482WnBjKOOzZmWgOkHxIt+uwEG7DZj4uM0VwYyT3omHgNwJIwzHfb8YBx8ITp+OKLGEGNdaw94xFE6kEjjLaPQEw73K65ZslBwNNwjaEyDx3xXSQxQmmuQ7SXV/MQuR7Q/l7Bh+qXpyxFRLJrl9cxb/VZ8hiUGN/+jVDfMarF2EatynPyLRg0Qz/BGKnwnj1ecLgIFofNu1Qe8SA7veQCA+rjcd9sRDd9VQCEJmKyOoSHT8V1uYWy6qevEsJ/fDXOL/o5xaz2bv6YqyJt38Y2UqOLDt7BZgwTefESqFTzHdPTu95Jx4fv8OAWllHkpv1Imc6BfukVD92SypGd5kXGQ/VXmf1Z1kIfq8Gkw/7JF0phIxzJp4s+m4ziI0cG5rdRo+h1rfzg9SsB/SepiG8358DECN7A1My6hTVA28Y8T333ViPOVv3DTF+zw1Jfhbk0LtWScsJjdpDJbgVs/vMnCt3mbak38T2ptxekBVvYSbUzyRSPXq8W8EXc0xIXrjjofDEUvcu5ZtA8CfSRmXEtaUl1JK/G7KZCoQ/pmM2G2hYJttpxceTyAR4IQ6pEyxGZABsOFkOVXZ0cLz4P23FEY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WLQvERdrNu63/Thmyl4yzXhSXRv75CgYxpGxUseoM+kV8U2/dP3nysQFzQzZ?=
 =?us-ascii?Q?zbpo+LiFd2KKn0ErZdauMIiIJlF5YjHFR073lXdwRpmJt/RtyEYyHY3zSLF0?=
 =?us-ascii?Q?V2wIU8w8W4J2Eju4YwjTU8hIq+q4TGMKVPCl/rd08xBnXgqAKOUWHahVRNhZ?=
 =?us-ascii?Q?Lr2WOIu3xLLk7PtJIErYkxnQs6b6VrSu8LKA9P7QvKpEpaC+YIgEN02lxLdc?=
 =?us-ascii?Q?oedTpRR9QOkYeg7WYLuMrigkRR9qJWD1rQp+3xj/LTaj4q595FCh/t8l1kFp?=
 =?us-ascii?Q?vTMr2j9twXJDXGiaXFhoyjTwiGckWBdBGrGfgKrLrcGWQ7Cbr2RxzU8VymUW?=
 =?us-ascii?Q?ytbc3nnw9Y9Zq0MzTLcaMdsILguJcO88JcrSOf7dsPciza93jynxRodyRyzr?=
 =?us-ascii?Q?H/BXmYgfPywsLErH5HfLViMwNSDNYskkouqrCOxZk/DokVKCHVrdYM3iDeg8?=
 =?us-ascii?Q?ing39HCCUNB46uJOhpWAWx87yaWjJLdO8zeE6UioRd8UVWg9z3oRnU49Zlvg?=
 =?us-ascii?Q?NvWn0FbShBc1uv3PI6qA3sDYmpkV5lY+5VBG+05J+eiYF0G8Rnu6oruu3Pft?=
 =?us-ascii?Q?JU9Q/0wL4m6ak1TylLIE8V70uSP0a9KSgQP/1xDty4l3zkGrc3QPYpAvGY22?=
 =?us-ascii?Q?/oI4FTIKqLoDaq91oZ/u4n2++PebVmErGScbXGtA0UpNcQ+EAaMGc17Zknj5?=
 =?us-ascii?Q?TVUATTUbC+prGZO0Tx5V51k5JRJvTyhEzW+tlcf2vleapU4zqepXZ6rAAgpJ?=
 =?us-ascii?Q?sdqePGB5bk+y3LtBERWui6070GEB+JsaMJs0TOssre/BC93f6U2lGbkGi3DD?=
 =?us-ascii?Q?oRRKj6QDCEKVszyzP4ueFSXGbWLfUNlt7bER22yh7RLQPBAQ7zkuDgoSq/SK?=
 =?us-ascii?Q?Sj4NVMETbvovj4a506oUQmnQghUC+f0W4voxmPuDI6bT0VrqKrtK+dqgNd4z?=
 =?us-ascii?Q?FOXDx50AzXvzMwBTMZc6iMEDHQ3H3XT47PrCVb538TMjcksZ4bzo91Azgf7t?=
 =?us-ascii?Q?4laa1jo/KOdNa6adu6KBK6M54kabN9PKCUZ7TbIKVdBMfmXtynIJke7kHDNd?=
 =?us-ascii?Q?w9fU/9xtmeLPwRCQMk2QKsJMGCR1kOHMlhMipGB4EZk8YogkVYMDKtCUWNge?=
 =?us-ascii?Q?tomKyYF6rgBZwcmNriFy+VFd3T3CHiwqxGKCjqDHel/g+MOz1lxDR9Hvm7lS?=
 =?us-ascii?Q?TA3MM34aayTOYqxuT0CGkMp9TpF4cfWdJ+6KBcrA7reraZpPAG9hkWK6Cc2e?=
 =?us-ascii?Q?zZIsywjYmdltmd9hVKmppXLc/XWpXCz+brsUO0tm8Wq0QlcNj0kZXuoT0wgc?=
 =?us-ascii?Q?X8nZBYbrAo1g9DLF4GDAXLgjLsYIgnfzg/eW0H+Yinh7l2rOIiot/NCHzSXE?=
 =?us-ascii?Q?5Buf7nH+ioHxNEuZNinfxYxz84+gP0tz2L8S3OO57X8YbyK1/ACeZREhO5T2?=
 =?us-ascii?Q?eBrrEpM54w+IvRqJ3l8+jVF9PNv6U2h4huMsS1iafYvMnX0+cRujBf0s4S8t?=
 =?us-ascii?Q?FqdBN5YP5A5J55AQr/I3zMogtvUVP81FakbH4k9sHAFHenG668BFs2ZIYde3?=
 =?us-ascii?Q?D/8TFAjzeVpyABK34vS70NkWdRCWSgmvNtJX3aO2I6IUCEt5Au97p8zrLOrC?=
 =?us-ascii?Q?akBDWCX+QhtBVUgB9hBJIXO3ZPgB9AFYaW7yqDlbFDeNHLG7HPJtFulRFjI6?=
 =?us-ascii?Q?wNL18xC4frHGZ7Bk5asPfb2SZK0tv5MY55y5cRi4ZvgQd8llKZfARe58YGCS?=
 =?us-ascii?Q?qIzmy5GW5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da25078-79de-4628-7991-08decbf64f77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 22:26:29.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcK2ftr8WvY4F8LSdLhJg87bJ+TqlxrxBN2Lc9VT0F5VSkclaL0DwtY05B+HUwqK5GIz1KSxxLsJrbX1leazxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831

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

