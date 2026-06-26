Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0D827B50F;
	Fri, 26 Jun 2026 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434617; cv=fail; b=cyliG/tSgZOAyrnGI2wMojZ7Aq8a3jsa3Sl1qQx2n40rJXvvDlL3juxoEy3EC/or8cTtcMr0hHpjTWDk7U7cLuRdcZNaNPOWY/XcpXFQ1SIOPjNrVt3osEEbgzZct8/nNI6Z83GoCx7GZt0xPYnNAqUR0Vy5TsgPBw2HbN08vcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434617; c=relaxed/simple;
	bh=6ZfcMATOwZabTrdgoMpjBx0zqpOoavI/xkesRTwvw5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FQpWeuDkolpaYWJI0rVAohCebaxqSuf2i7UgIgudYy5Nk/6njUWyb5NB/NY5aG0sDsuDZJ8jkhrPZ5EGmNomLQcQ1dGXnVef6eZBctrshjHAXSnBtGZQrDG7OaM9lgDyx7pnq9EfxtS0OmqZDrkdHxyyY0QTUWx5u7TdwEiVmIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cLCmRsRD; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cLCmRsRD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cf+rr+8TA4A8Glj76MWsB3cwUXL/aIOsQrrbj3D1tsHZH/Q7y5+qIvO5ww5ChaBTvy+5aENXAtDzt4Tvu6cYbYgXZP1ehD3YAqExjkqZaW219DFA4a7xvx8j/gGGdSGyPtomXJMHfE2XvullCfyGkZrp3UZdzVlPFvQGzPr0tWfWyr8Y+nUs0YHBWTAPRcL2QhV+vxZIcOASQi2OQl+5sgNum/XOcxNby8YFnWRinZHC72BHTRZ95ZXmKvQSZewKNVqz1+gS5zVVS5tI8Qbgz0ctPguy5GcI0JEgJLYjB4YAvH1fbpJKCnGpb39gmDMFDc4meEpZbHDl5+RvE53RdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0I63LIYRIr0z0PoVNUz2xa8TEtgJ2ikHVtE2PdFi2cI=;
 b=BhDecWTy1aGZ+0b3H8QQLD2IDtMgzikp8RAsVZrTZ8zZSs9NMv7abrwAjE/oW12sJrkeWO36g6oemeayGCfOsgxlnZgk9VrzB+ID8ezDtAGT52WDSDe49aiu6yBIku68lX+aolk/M3zPHk71As5Nqelu1uLg3umW91PI4ahyL6gLMiitV50Sa7xU4b3vp4HiALt1J2J9rHlz2xEDv8fyH6molYv2fY/+zgv+nhbew9+hWQ7GL3bt1N9PiJ2S0fmRGt3PIfrA9RhzveATZD0O+ETwI093pfee3XxUm2tE0c5Px2J3r80mxysH1RvW0TYXPWy6/R4U2jZpp/Yv/YToJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I63LIYRIr0z0PoVNUz2xa8TEtgJ2ikHVtE2PdFi2cI=;
 b=cLCmRsRDC2um4NTAAPysDPTTtMav+TcVgFq5e8Cd7QEATJIIu5e9E4/ivF2WUy2g7kAV1RR/EwEHAuUQks7FtPaNddd5BBvU4VHTtKCqaw7taBakUtPZWmBDuHXsYQjWQ+Pewk2ebQrofWcO0SePliDpDMSKiOLRaLutMr55v1pYVvM/9h2W2P1XoH2g5w/jlVIUQjRn2hQxKLvIvT6c+Aum1eIFaJYxSDURGQuA7h3TB9xKrdXcCw40qTXpsJNrK3OusdbTuDxIjM61ek28tSoMSbGti5qWD/I+Mp1p4AE/ZJKyDAXFWYh8Crydi1DoTD9TsnhUU2SGwE1L5WCq1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.13; Fri, 26 Jun 2026 00:43:17 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 00:43:17 +0000
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
	rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v4 8/8] rcu: add per-CPU rescue hrtimer for deferred-QS reporting
Date: Thu, 25 Jun 2026 20:43:01 -0400
Message-Id: <20260626004301.1632168-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626004301.1632168-1-joelagnelf@nvidia.com>
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:208:32a::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddef5c2-a01e-4472-aae2-08ded31be985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZDMjzTh0ksN2/2bmUjNX6T2IK1nTtZ5AVh8vC11pC+kn8SQC8jOY8XUPRLDIxMWIagWyT3EpB+czcBC3EynyYBLMV2tGo+uJf/MZfgr67EN7Z1QOtgpLHceZbTgiwbtjlecdH/aLonGT4biatY9XRlBtlEGZbhSBA6RN1Ds2/6Ctghp4T/Rtj5O5lurqS0vjsFAY87ZUogkKgOXLYWQqy3TeXKJYJOMwP4nKC5rlPc+bi8ZdJjrvX2x7KlC5NVAWnLgB3solUI340ZuhhLKZ4sRZLtYCshRm1rbco+R3pVX+Z476jdgkQMT5boXG8AP8YlPUm2N2bHEFvcat2q2CnjUC2EckgfiSMUUlXPTYqa3H5PGMXG7zGnHLPhBWdeoqei9lajhZEVqf0VTLIM83IC9smgtCuxeCPdi+aLgxfRzvGKVSMNvPym+B3gfnFy6XpK+FlnUZjoLgfSHix0qerZed3PGX5V+J73hxO2HM6hoIhqNRzCt6Yoc7oX3bM7FfcvFouW0mdrWwM8eFmwpDMidYyZIOa/r3boMT4OjuN6bhDNsOVrVm5cRO7rxmxjV2gMZTk3+sAxi62DBN3MGYvFrVCtnpgFiDJAAOZBOaOnDv2UV+pwFxude0HBNpupgZWp0UojClpOemz4syN/+Z1wUndlESVdKtCMghovOf9QQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2F0jG48OgpslvpkLfyttITt5O3+kJlBuramMIzdLaHEThp0uvXTJ0+mcE0WZ?=
 =?us-ascii?Q?X3PRO4e5wWBv/8Fx+QnXUgCbkU9pLyMFC9w69UN2nKk7R5EDPOHbEhYqQFEs?=
 =?us-ascii?Q?tZgzGTS7tr7ffGhCQnsFuR+3Ya/izgy/MEyFqFKm/+oXq7JZnw84bZVIn37z?=
 =?us-ascii?Q?DsRmsvV6ek3ddTAt9CZAdTcYeT7WEkJKAmF/Zr60vaEoIzQlSpBscppZT7NI?=
 =?us-ascii?Q?o++CHuSieMghGQis9JIqbXAiEN3bd7YkaO2lgwGWBOfEwwyzyfGYjyfGrTJ4?=
 =?us-ascii?Q?CDrBXzi8Bksytoo6EKP/KIWvQWKeBMe2jsd9zZMBV9/n926kjfgdqLHO8/Cy?=
 =?us-ascii?Q?XhiD72lKJ5d5pnB0IpwPz/gNiefZheGA3i8tiRVa6tVrXyF0UIbVqR6ko2uB?=
 =?us-ascii?Q?fRJm4ianMwF6WCP69DsDeqXjaInk/0NQLIjeChx6IXHmjcinSDEJrp6bzB9+?=
 =?us-ascii?Q?mNMdXK3h+ojlpiZZ39ClP4WTXIhWD/sfGrYH44EayDXfaovEWRPdiwV9Y04k?=
 =?us-ascii?Q?OVD9v1mnRaDaZuHBQJqSW/8FDgBWwhFvrF9eGLYHvtNulM8311mj2tLTQoRy?=
 =?us-ascii?Q?uJJ/cN6hFPkj1hmtZZspXLECbV9HJem/WToHzf24DqXJCtTucc10jKD7l5VD?=
 =?us-ascii?Q?ni/y9c0Hz8IKBLz4JhEk/Vf298oQlOaPnIRoOejJ/LyblWNRHSvMbifQ+I7E?=
 =?us-ascii?Q?VDy4G/pmAeT+93n5anm6P+FITDQwKVwuZMj0cDaurjk8SWgeYtPsifEVGIFt?=
 =?us-ascii?Q?pWT44Rnvs9JzcHGwTx1qIrI9wVr9s1C81gxO0ilQjpWFx+hpfnVjcPcqjeFM?=
 =?us-ascii?Q?LSq1JNRFUHm/8ENBX/NclTfwBp3/DiKIOHGtPa3WcE0/jHDbIYbT76mWG2lR?=
 =?us-ascii?Q?1GSjNLUs3N8y9sPYnrsw4Mg2ZFlbMZdEw9IVttkWbLLxYNUVGn7BPImhhn1c?=
 =?us-ascii?Q?XMR9DH6sTzBcba4TtnLSnm63kA3DWaQEid/IjsFc4s3/jc23J7dvfV99RcsZ?=
 =?us-ascii?Q?15C6UbNRJX7IyA+IUJJIxMji9aIhs1MnJWRZ+Keb5okqIp7I91Ax3H4TIj21?=
 =?us-ascii?Q?UV+8Uhw/yWYV+D4McFGz2lrjrxDAvjKurF4zr6YGbeg8QNzjpmfvBgXaGGHc?=
 =?us-ascii?Q?pQu2XUbDQCVk4gW2L8+HNslllvwJdOkRehltGArDfl/gzSLfrvvSCW/WJmyZ?=
 =?us-ascii?Q?sWOJf80j8oKZnAYkhAOxh2Q0ZVRrAfVfy8joJu+wsrrdHLX8TFWMCfSzfMFK?=
 =?us-ascii?Q?jM+iV4D/zcO5yO0SOcIiVCxM176P1w3Yg3k8KZH1PVwyJaob+I9HzhYKbya5?=
 =?us-ascii?Q?LkNcXW5uCxiekG87NDRBKcLKpR9+/OYpFFKlhhxvV4yPpwaR1ojdCb5qrgvo?=
 =?us-ascii?Q?NpMMbLlCikj99a502ygH2sx1QBBbVNg/hcGSIWYw1HTVPOFZ7zlsFqW7JLww?=
 =?us-ascii?Q?N4C3edjdLtxtQr3plBBpdDO+Q87nEClFuGcaIJTqG1WrkYE1yGdWR96+NLJ+?=
 =?us-ascii?Q?rgFhLEEPcOJdtKxgxakwrOnbCx79LaUguu1zKG2/4Od8mtD1q3eCbi+1f87Y?=
 =?us-ascii?Q?vaWjwEZ9HNtPRg0uOUUP3mvkQpcwIULPSNA/fixgT+C1P4wef/I50xX7QODq?=
 =?us-ascii?Q?l0uUgd7RtUwVqbea9YCp4b0F3AV4mbox5zy5rWkDyjQ7NYlSU/PWMcjzda8l?=
 =?us-ascii?Q?pf8VQATLK885csfaJEB4HMmInWTi+OpsnrIp7rMdS4ZgXEPmD9GySlTbc38H?=
 =?us-ascii?Q?j6rVaQKF1w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddef5c2-a01e-4472-aae2-08ded31be985
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 00:43:16.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i93GLA+PbUs3l+9r3CktqW0uZtecB8B7q9sfsdthHiKq7oCKXNFeC2R/p8QizQ6LjYHc2x5HNmBEOrkz6WOBZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

The compound branch of rcu_read_unlock_special() arms one of the
scheduler, RCU_SOFTIRQ (raise_softirq_irqoff()) or irq_work_queue_on()
in order to report a deferred quiescent state at a later time.

However, that is not enough in scenarios where an interrupts-disabled
section spans the preempt_enable() of a preempt-disabled section:

 rcu_read_lock();
 // receive IPI for expedited GP
 preempt_disable();
 rcu_read_unlock();    // sets the need-resched flag
 local_irq_disable();
 preempt_enable();     // cannot reschedule: IRQs are off
 local_irq_enable();
 // now outside the compound RCU read-side critical section, but the
 // expedited GP is still held up

Introduce a per-CPU bounded-delay rescue hrtimer, armed from the compound
branch when an expedited GP needs this CPU's quiescent state, that reports
the deferred QS via rcu_preempt_deferred_qs_try_report() once a clean
(non-reader, non-compound) context is reached.

To keep the rescue from firing once one of the normal mechanisms has
already reported the quiescent state, cancel it from
rcu_preempt_deferred_qs_irqrestore() -- the common path through which the
deferred QS is reported.  Without this the timer keeps firing (and
re-arming) only to find the work already done; cancelling on the natural
report path avoids the great majority of those fires (observed as a ~90%
reduction in rescue-timer fires under rcutorture TREE03 with
rcutorture.gp_exp=1).

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c        |  1 +
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_plugin.h | 70 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c4352d0c3876..0cacbe642235 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -27,6 +27,7 @@
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/nmi.h>
+#include <linux/hrtimer.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/export.h>
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index dc03231b2d46..58b120bf0b7b 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -218,6 +218,7 @@ struct rcu_data {
 					/*  during and after the last grace */
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
+	struct hrtimer defer_qs_iw_rescue;/* Rescue timer for deferred-QS. */
 	int defer_qs_pending;		/* irqwork or softirq pending? */
 	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6f5d31e3f1a3..324d08c7a91a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -592,6 +592,18 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		local_irq_restore(flags);
 		return;
 	}
+
+	/*
+	 * A natural report path reached the deferred quiescent state before
+	 * the bounded-delay rescue hrtimer fired.  Cancel any pending rescue
+	 * on this CPU so it does not fire only to find the quiescent state
+	 * already reported.  Use hrtimer_try_to_cancel() rather than
+	 * hrtimer_cancel(): interrupts are disabled here and the timer is
+	 * HARD/PINNED, so a callback that is already running must not be
+	 * waited on (in that case this is a harmless no-op).
+	 */
+	hrtimer_try_to_cancel(&rdp->defer_qs_iw_rescue);
+
 	t->rcu_read_unlock_special.s = 0;
 	if (special.b.need_qs) {
 		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)) {
@@ -772,6 +784,54 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 		rcu_defer_qs_clear(rdp);
 }
 
+/*
+ * Bounded-delay rescue timeout for the deferred-QS reporting.
+ *
+ * The compound branch of rcu_read_unlock_special() arms either the
+ * scheduler, RCU_SOFTIRQ (raise_softirq_irqoff) or irq_work_queue_on() in order
+ * to report a deferred QS at a later time.
+ *
+ * However, that is not enough as in scenarios where local_irq_disable()d
+ * sections span the preempt_enable() call of a preempt-disabled section:
+ *
+ *  rcu_read_lock();
+ *  // receive IPI for exp GP
+ *  preempt_disable();
+ *  rcu_read_unlock();    // Set the "need reschedule" flag.
+ *  local_irq_disable();
+ *  preempt_enable();     // Cannot reschedule as IRQs are off.
+ *  local_irq_enable();
+ *  // Now outside the compound RCU read-side critical section
+ *  // however, the expedited GP is still held up.
+ *
+ * Introduce a rescue timer, firing every 50 micro seconds after the last
+ * rcu_read_unlock() call, to fix this.
+ */
+static int defer_qs_rescue_delay_us = 50;
+module_param(defer_qs_rescue_delay_us, int, 0644);
+MODULE_PARM_DESC(defer_qs_rescue_delay_us,
+		 "Microseconds before the rescue timer fires a deferred-QS report.");
+
+static enum hrtimer_restart
+rcu_preempt_deferred_qs_rescue(struct hrtimer *hrtp)
+{
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Still inside a reader / compound section: deboosting is unsafe, so
+	 * rearm and retry after a bounded delay.  Once clean,
+	 * rcu_preempt_deferred_qs_try_report() reports the deferred QS and
+	 * releases any boost in the current task's context (or is a no-op if
+	 * natural recovery already landed).
+	 */
+	if (!rcu_preempt_deferred_qs_try_report(current)) {
+		hrtimer_forward_now(hrtp,
+				    us_to_ktime(defer_qs_rescue_delay_us));
+		return HRTIMER_RESTART;
+	}
+	return HRTIMER_NORESTART;
+}
+
 /*
  * Check if expedited grace period processing during unlock is needed.
  *
@@ -892,6 +952,13 @@ static void rcu_read_unlock_special(struct task_struct *t)
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
 		}
+		// Bounded-delay rescue: arm whenever the compound branch
+		// entered with a pending deferred-QS / deboost obligation,
+		// regardless of which mechanism above was chosen.
+		if (needs_exp && cpu_online(rdp->cpu))
+			hrtimer_start(&rdp->defer_qs_iw_rescue,
+				      us_to_ktime(defer_qs_rescue_delay_us),
+				      HRTIMER_MODE_REL_PINNED_HARD);
 		local_irq_restore(flags);
 		return;
 	}
@@ -1033,6 +1100,9 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp)
 {
 	rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
+	hrtimer_setup(&rdp->defer_qs_iw_rescue,
+		      rcu_preempt_deferred_qs_rescue,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
 }
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
-- 
2.34.1

