Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF52940D;
	Tue, 24 Mar 2026 00:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311282; cv=fail; b=oojYdyM+hsG8EitdI2rmb4/psQGN+e+V774FG2XjBx8XnXXkUYqm4xdC1yPw3pPXynIynDcHUR7X6elVWiuPFkzVpXYxIznptgLPPdqvB5PnjA37WkgmVXFqy0TE/fvQCZxJC9+meaCqrtOzfdP4agwpRkt2l5eZhpncMXR/r0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311282; c=relaxed/simple;
	bh=1hDOyodo+9eFYTqwLnDGYeKhueF2uPcDT8dZ0F4+7W4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=loAhfOm/eXTgY7OAxSuJ74MRtXNC7gMtzRf02z0N71M3bDI7bb9UQF2AFS+DTiPCEx8EAR3hsGVB5+9Wp3QcArOaLN2KlVe0bqYwKS/UL4kpyxDNG9bduBZrSQBKpa88waUrgqgJpaB2wuGRYt63Yjx2Qu4qZgCtee+dJLDbYkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WnqsRCFT; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WnqsRCFT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnIBa7CuS/oxJibOYVg8S3Ze8nm5FQLUKRH/8/+DHuBKOU+Xy+uxLVVUDFTfuaEPsnVt0ouWVT8+oY07GhcODpHHjcDb7/dSvQFZ+ahdOWsrGBp5uQ2Bx5Z030YLOkOr/54PnTRhSsBzMcNv6tulfxvVFNlEufjLY07/HXmlWA1AfBwuqq8tur/z4eA4/9PJeUFQTXyWL6W8P4XOhE4gpqGhphxqn1ujwOF7SYo1KuHfEe4YkHC4dy9ju7fzWIK4KaOudHC+yCKZfim7O9xfD8eQ5HXI9wFJwBwKycKCF6Iq3ZbZjDOS05LlaKLwBBh1VXX6j71p0OyA7xJxDYN3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3K0zxHkNFmZVnUY1uw/twkJQU6LMa6O2SV09kxYGsQ=;
 b=OzaDv981+DCg7ooTseTV2YXQplkPFGFF+vbRhtz/ngZG+DYOc3QuR6uyUQdiqS4leEkEm5Dn9SRtuQhzTrVCD+N9hSwojErvrg1itHEih7c9bZU+es/6GPbm85Ld9DPWKQPpWcq/B6kmBgq8oP4W9NDahOUa/Gbd4w6v4IQQBVmH3E53cj86mFlqKANr0eVZLYU04HC3UbHAEjm0Pw7bpGcSqrh5icGTzJUXYEwEe/kqS/j1EQyVjpRfD32imMfN58fGqjCI1MTgvQ4t2KsGYg5+luY6pdoLKgK0UUtOTAwUcJTP4NWRcCg83Ui7sVfE1E/eW2vfXBBgeDgJIw4UoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3K0zxHkNFmZVnUY1uw/twkJQU6LMa6O2SV09kxYGsQ=;
 b=WnqsRCFTr/jocCeCjiuyZvqAi4MNsZ3XiYSvOub5cutvda9A1OK/Ca4b/vVVzfKXwr2qkzZXZSIk1JJ/2y5xTJQH6sHTaxRf8V9By4bgvAgrgqmSB2HjU98bNuy7/r0QmsNsmEwSLMX4fS3p/8WzFMEVqfPhpdX627htwn3L9DKDriXs6q8gGxsqdDR9pKZsN/TbNNqcSzn2U4NuuuHz7pbfo7K58wfzjBrxWWSsOeFuwk3rfOVh6IVEcDcGswarkgyGSwdjulP+x9jEv2vAt/hrmI4KsLgdyMWTW9bcdhUtrxBNpt0Eqr1XuGTKBVFjavMkNq7OLvlZkjs7Flq/RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Tue, 24 Mar
 2026 00:14:38 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 00:14:38 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] srcu: Use irq_work to start GP in tiny SRCU
Date: Mon, 23 Mar 2026 20:14:18 -0400
Message-Id: <20260324001418.89363-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: e8dc5536-ba20-4f00-2268-08de893a565c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	rtijPDGkT5qROkWPacPnMw9SF2LxDKKb/o0+YJvRZg0k9o9eBt7oBf/bhJrnin35rMqhKilox/cnzyK97wX51n7IC0luKdPsJCZZkHqlt0ihFQyT+8NDRwj/LIv76pNxBxnWik3+wQXgKIB3FpkfcrgKxGIvbz2+XuiAQvK3SQhkMa2lo7cV1WySkZpK11EoryXDsafM6+3b408/OEdPFF1/YItq3cCeww6mmimz5wOsXRgY6Lp4lzRqb4P1EQ4WVbYubXFnShTu5P0ParpGuaVtJn4OEj3Z/zjb7IULzMHF6ljEVazHXV7rSSbSvQ0pNmffRdT3Mbop6k7Dtit+p/X2BA8vaZaehU9Yiq2GIQm9pmYRsBErW7tOVwBx/1YQU+9rr2o3FVNHvrDX8KOU0rTU6w3vUWglLC8mkL/wTjBWT/uyu6wT2+UFZS/KaXNgaljP3Eo/xucKkKHaKliwQ9YtwrByz059extA7SORc4nV3JTtqy+cbzFO6kKADJ4W8lOpolgSz6xWRcrfHQGJpXB9JeVDVuQLUdET7iKY4LmA7n8YOeZZV98KLhGfnPd1YlWW14e56KcK1KAVOqOHQk0A48mIvGu4FOcykM149KN6/6epq8VWG+uFbEord3Rx6wctYvYNNx52PnDQKnelYxiLUAi8RB+h1qoBvNxlPaSum9I0/CJML+I8S4gWM3r+oHwfsdrafSpAAQiK/VGXS7g2HWGLon/Fi+/qgEoE540=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ndQpFtKn94b2Hv9QyEW6Htsft3kJgvmsmgTobzhFuXBsfBhZ4T0mOnHI4gdT?=
 =?us-ascii?Q?/PYk3kaApv5xBcP5pb9pa2g0HIYJ5Le2uLltBoZ9RVHFl0Vn+zPov9e4FHqb?=
 =?us-ascii?Q?e7CnyiqfuBcdFcgQ83Ip3/EV1wQLVl/pWaPAgvOhQhGHTBe4dLLAQJZJgdGR?=
 =?us-ascii?Q?hAxRxUtH+CUl7Cr9j0/ag+G/3+/fp3smSA5YMiGrDa94360HhB3u68JVjSg+?=
 =?us-ascii?Q?w9QEeCca3LL+2a7XDejBXmY4p6Xp0sJY0GxcXu+KnJKxa0rEzseI4gAikhMo?=
 =?us-ascii?Q?W7GgAQqd/HVPGkglkerG2OYBE+yQW4fIAjslhQHh04kbivL5dAsTdYuZuuay?=
 =?us-ascii?Q?j+lIZr1Dzq9c70tLYzPDfmCoLySp01ZA8VnZ62M5Hx7gWpqYKOXhWC6TNomf?=
 =?us-ascii?Q?6XFaEgBxERsrciMBFqpGctkqDCT9mgjvmh0OdAshzJnAegj9vQqKJJxB+lGv?=
 =?us-ascii?Q?VM4ooQUk7ejwMJkRPE9Gb3hLiPSXafs1+MdPDccxiHhRwinFqbFpml4DSdNP?=
 =?us-ascii?Q?OrLBOMz9nCmEo+h4KM0Z+Z31C176Zs95nKMhVnC0YlXt9y8znOIkOAoLtn6R?=
 =?us-ascii?Q?xI8e8J+iNR15GkCL+i7fDaCknIhUL0xyfemmqQn8lOf4yvCMWN+M3e00AHYq?=
 =?us-ascii?Q?te4YKOvTtrH9FPtrI/cazQlimM6smgXWuH1a5gBsTny5+GNhnkmRe/VBaikU?=
 =?us-ascii?Q?atE5IDhNNIud5SrnR/iRhoQXcZRVs9CZUXlngk+pY3YhFJnO9RNtBJiOudWX?=
 =?us-ascii?Q?ivyqZK7kXTgF37Q/78i9+MsvDiwYR9iHsGPid8zfMw+WfCHjqVE9DMZYeDEV?=
 =?us-ascii?Q?a5zqk/GSIGifzxnFb/6IawU0jc7A0Jm2kFNsx7lPRSeQt+5aNSKsQtf6HX+z?=
 =?us-ascii?Q?FpRJO0mxcipi19m+LJqg7bUpx4QTm7M/nox20H9itdV615cuKV+Y4UZW5JYM?=
 =?us-ascii?Q?8Rpmb8K4qO5p1dUoK97TlHNBu/JWWF6syqiz3wuMfaNTgEwoKL+g2J2D2yAV?=
 =?us-ascii?Q?yXFFYJhLEInjo+p8VIA+e9s+HotiRPqnXH1/n+JdqZgHna37tmLYfscxpxex?=
 =?us-ascii?Q?hGnu4A2J9Dy03lryC6EyHv5jpxJf+VkgZo+Y3zQMWBdklmsGnwkAHRsQ+9ki?=
 =?us-ascii?Q?69o2GdjC/+o9lF87E85ssY7IGrbWlsa4L/dHe/CuEsOeTDhHlabwV3/+gG52?=
 =?us-ascii?Q?m+BpAOgs/5c45EPaF+BpvqWVk4tRz9aclmxpCem3vy1rQ+pOMj05bC8Kp8vE?=
 =?us-ascii?Q?IF9GYNiZOwJTUUa5dIgOD0mZNZ2WdUOg3Q6EQfRhLrP2B2QCGGIHU3skLwbl?=
 =?us-ascii?Q?sjCMtkK70Z74/tuHfGI4u19B8+EfjvuRLS69YhYC1HqNIwMKiFIPEBNl4cm9?=
 =?us-ascii?Q?yvdlKbvrW0j5RLDhiGNQqVWO2JqxdshDEyCrUIL5w3tgAmEaMNc74MqGjf2F?=
 =?us-ascii?Q?4ARn87Ji4m0wSw0YAmlqb9BfG+Xhi4MeAh/xvwjbd/EVVUlJsKJ+FEBBR+Md?=
 =?us-ascii?Q?prH8dv04o63DN8rWq1yN7T/BETJXAxK8hE31PAU37rJCQLUAYBgUA+ckcjEA?=
 =?us-ascii?Q?o/8LMXwZKPqmkiVccCxf1Ig6/TlvVSdX1GI65GWt8LTiY8qtmDmgxabvAUkX?=
 =?us-ascii?Q?DKpLh1h0DcCVPDTLtOFzkYT831nGY1+b1JZuOEg8ZfeZyt3AaoM82sHaS744?=
 =?us-ascii?Q?WikjcrvJf0hnVZizNjg+O+zwKuf9P1DNngquHNfudr+JnyD9KfulV69tGocs?=
 =?us-ascii?Q?ZTeSK77zwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dc5536-ba20-4f00-2268-08de893a565c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 00:14:38.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yW5nUeDQGq2uSNi+mkJBSmaTOfVLo6WIVzlJ+ZhxGJFiZohEua/OSnAY9cWNW2GVckGNKSmSzC2z9zcv13W0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782

Tiny SRCU's srcu_gp_start_if_needed() directly calls schedule_work(),
which acquires the workqueue pool->lock.

This causes a lockdep splat when call_srcu() is called with a scheduler
lock held, due to:

  call_srcu() [holding pi_lock]
    srcu_gp_start_if_needed()
      schedule_work() -> pool->lock

  workqueue_init() / create_worker() [holding pool->lock]
    wake_up_process() -> try_to_wake_up() -> pi_lock

Also add irq_work_sync() to cleanup_srcu_struct() to prevent a
use-after-free if a queued irq_work fires after cleanup begins.

Tested with rcutorture SRCU-T and no lockdep warnings.

[ Thanks to Boqun for similar fix in patch "rcu: Use an intermediate irq_work
to start process_srcu()" ]

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 include/linux/srcutiny.h |  4 ++++
 kernel/rcu/srcutiny.c    | 19 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index dec7cbe015aa..905b629e8fa3 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_SRCU_TINY_H
 #define _LINUX_SRCU_TINY_H
 
+#include <linux/irq_work_types.h>
 #include <linux/swait.h>
 
 struct srcu_struct {
@@ -24,18 +25,21 @@ struct srcu_struct {
 	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
 	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
 	struct work_struct srcu_work;	/* For driving grace periods. */
+	struct irq_work srcu_irq_work;	/* Defer schedule_work() to irq work. */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 };
 
 void srcu_drive_gp(struct work_struct *wp);
+void srcu_tiny_irq_work(struct irq_work *irq_work);
 
 #define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignored)	\
 {									\
 	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
 	.srcu_cb_tail = &name.srcu_cb_head,				\
 	.srcu_work = __WORK_INITIALIZER(name.srcu_work, srcu_drive_gp),	\
+	.srcu_irq_work = { .func = srcu_tiny_irq_work },		\
 	__SRCU_DEP_MAP_INIT(name)					\
 }
 
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 3450c3751ef7..a2e2d516e51b 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/irq_work.h>
 #include <linux/mutex.h>
 #include <linux/preempt.h>
 #include <linux/rcupdate_wait.h>
@@ -41,6 +42,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
 	ssp->srcu_idx_max = 0;
 	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
 	INIT_LIST_HEAD(&ssp->srcu_work.entry);
+	init_irq_work(&ssp->srcu_irq_work, srcu_tiny_irq_work);
 	return 0;
 }
 
@@ -84,6 +86,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
 void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	WARN_ON(ssp->srcu_lock_nesting[0] || ssp->srcu_lock_nesting[1]);
+	irq_work_sync(&ssp->srcu_irq_work);
 	flush_work(&ssp->srcu_work);
 	WARN_ON(ssp->srcu_gp_running);
 	WARN_ON(ssp->srcu_gp_waiting);
@@ -177,6 +180,20 @@ void srcu_drive_gp(struct work_struct *wp)
 }
 EXPORT_SYMBOL_GPL(srcu_drive_gp);
 
+/*
+ * Use an irq_work to defer schedule_work() to avoid acquiring the workqueue
+ * pool->lock while the caller might hold scheduler locks, causing lockdep
+ * splats due to workqueue_init() doing a wakeup.
+ */
+void srcu_tiny_irq_work(struct irq_work *irq_work)
+{
+	struct srcu_struct *ssp;
+
+	ssp = container_of(irq_work, struct srcu_struct, srcu_irq_work);
+	schedule_work(&ssp->srcu_work);
+}
+EXPORT_SYMBOL_GPL(srcu_tiny_irq_work);
+
 static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
@@ -189,7 +206,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 	WRITE_ONCE(ssp->srcu_idx_max, cookie);
 	if (!READ_ONCE(ssp->srcu_gp_running)) {
 		if (likely(srcu_init_done))
-			schedule_work(&ssp->srcu_work);
+			irq_work_queue(&ssp->srcu_irq_work);
 		else if (list_empty(&ssp->srcu_work.entry))
 			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
 	}
-- 
2.34.1

