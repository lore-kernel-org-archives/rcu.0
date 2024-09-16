Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D32744E;
	Mon, 16 Sep 2024 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463384; cv=fail; b=PCmgUMHlUN/vqZeBCJCrM6KJYIb/36tH6m2GjgcJR1k6cvrw8cA1Fh6BK7gu6/Vl9IxJhHLmxRhdssHOFHtjUAENFglxa0JZUOByYmytBb8lotERy2rwEmtWwp0IPhMIhDuZuQe9OD5+/jBzZk0CicN6ZkicSnbwLnLzDljWKdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463384; c=relaxed/simple;
	bh=w/gWoEVrx1J1LxDqTZO4Oo+g6ejZLoZDO95IPl92WNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D530e/OTPrECeXuveTUdaWVMoHchRGHIO7AQAY2R2lEjqvEn/ApoT4Axp76km2qGMi9DvBg70xompre3k7qlendF4jrD/inmjM6/VRdaUg9NDmj0yE20vMSkNkrjhNEicM/TaJA4LNpYdiouQL+h9Uky2eC0hsRC3hRRRZFBSn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p0BqNEe5; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p0BqNEe5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqUtnxMrjx6LqyfywxM5se9oeFvddKQ0FLQ9kHtdW+lwIJ7I0XEl/FlKxmOwyi+gg3YhjWivBBnF34frJPez9qbnCx/tBLuTn8hybsz6LV9Y2RC7uFUu8+dxjcKxflvsIL92ZoJulLL2Qq/hb57TGM5WU4K3cZ1PvklasJEnh7bkVrBcHIM/pDKMd0ElC8YD9xxS76ES2wQ4la5/x7EZHZzGxPJaqBoc/+a3kDyRyQ4w5g2Y01Og+OA4ZfiNB+G19dAwtUSqnTPn+pvSheizmxQFBj3lBwYGB156TqmDAPyS1wTboEp1NS47XhImgL12qrSj1VOs720u/yOcBsRPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r604xJvf0kpMD9SUu6dvCf+ZojbB7Oe7MWbhODd9r8k=;
 b=oBEuog5TwBBe6BHCL/G2+YlSmsR40Os+MQLHvKmCDfgQ8Th7DRyYhuCkbvvfUy0vLI79pz+gpg2gdtGzZytewdKnMYMU9+zhSE/B60Jo2vcYgU6rdC7CY0IcWaRXKovVFpIFNjul1ACkeJxAWpzc9Rd+SwfPSI1y2C8Pyo7OIMyZxb0Y1QTNVKurRqZXgbO0oZb3hRA2e6WqBFXYvWuXm6MXcwl7CQnnnwSLP+XWyu8Gi8Jerl0BKPsdaRbsaEwMO86yi7uqwNjTWhwtgyMjARJ2IDZj82CteiKEYANf2F2/q6Tx5v3VSqdWb0mubN2I9ZscGE8TwjQBhzT4+ZPegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r604xJvf0kpMD9SUu6dvCf+ZojbB7Oe7MWbhODd9r8k=;
 b=p0BqNEe57QVw/NguqJ5X6HfoDI1KREe/QUuLbKSsO5dKhYe2GtC6yKzO5BsIIh22xyY0qShz0e9M1a2TILWJXLlykA0wSQjtUucRy2h5jFmBp2JnTkpallwrAJxR0R+zddwib36pd8b2MT6sBKm1A0eyA1QZ44QNLoHIaM7MXqc=
Received: from SJ0PR03CA0168.namprd03.prod.outlook.com (2603:10b6:a03:338::23)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 05:09:37 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::55) by SJ0PR03CA0168.outlook.office365.com
 (2603:10b6:a03:338::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 05:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 05:09:36 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 00:09:30 -0500
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	<gautham.shenoy@amd.com>, <Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	<dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>, <linux-mm@kvack.org>,
	<rcu@vger.kernel.org>
Subject: [RFC 3/6] percpu-refcount: Extend managed mode to allow runtime switching
Date: Mon, 16 Sep 2024 10:38:08 +0530
Message-ID: <20240916050811.473556-4-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916050811.473556-1-Neeraj.Upadhyay@amd.com>
References: <20240916050811.473556-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d30e1f-8e1a-4901-7e08-08dcd60dc294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2/eNvxGBUcgfLL6PgOg/waOf6yMmzplo3OmXZg6n5Gf3h/GeAwXbCtnE9c1t?=
 =?us-ascii?Q?uinzVRcytnuYbUNRwjgd6BZQxsUhIdK00v8ONVTC3C8VvYWgadiZ7tep3MBP?=
 =?us-ascii?Q?TrXxjkmcbi5xZVMunSygJQjEsZqS16ui4MBqfnmZdMcs38rdYrZIQe81agxq?=
 =?us-ascii?Q?Am613fIfJHyBYMb++jETLwwD2wVadL/902iv1mS5ubpFMgz9y3R7M0nBYlP1?=
 =?us-ascii?Q?an+M3Huk34JMVVF1iAFXevpQjvvBZd3RRRxr1FrC1193F1YGLKsmS7H+kc7Q?=
 =?us-ascii?Q?yl2nC04GdHj3O8u58o2uoaKEseLuf51OCnQFTKIzt4IjMYHUp8IBDtURWNXZ?=
 =?us-ascii?Q?wF25OovX+/GhsBP3rPZtehNbTgJxXgJl0zquc3X/rqfjofNqRjcxDsupOvca?=
 =?us-ascii?Q?8BWZbWaTayCU0DuyHzWx50/0xf+EfPEBfug5kwd0lTEw45zM5d+A5VRU3P+1?=
 =?us-ascii?Q?xDQxpvsjwAcmbm0BlHmzc3ZnKAQ8AlO6vsJuPFQEhLZzk+XWL1pjkVzhuzuO?=
 =?us-ascii?Q?h+HBuVF8f4jIAQkpdwzksY2uWEUr7nh/d41u2yrNEk2ArbqG8rPaPWpTHqwO?=
 =?us-ascii?Q?De99GWWuLdspZQSJLHLv96kKnf5GOi+k3ftkS0RG7NMHLExH4TzIDKABHoOe?=
 =?us-ascii?Q?No8MQMwPrmn8Cg+UgjP+T6K7WGcKo0EkMfD55TXvKEhOOSnkOce9U+Cn6twC?=
 =?us-ascii?Q?UpJWFgPjC1F7mhUs/ciZ+Vt/1Zk3SOmXD1gmAyqM4Pp2ce+K+fdoohjxPbEa?=
 =?us-ascii?Q?UBYBpvc/A8ufVHLvhYNCcXexAtbx27auq1qfMWaqmCbkOhlyxpqJmROJnSM0?=
 =?us-ascii?Q?4oPwbjxqufC/BoSp4tpBYBZD9h+55OI5Dya7kVcBPUiuCnrXzfcqilzCGUND?=
 =?us-ascii?Q?ytajrJySrDyWDf3A6TftirsXx0ps+ZFeKwZHQ7yFD14jJkQOCCIbmtH0VsaC?=
 =?us-ascii?Q?fdanTYa0xiO/CAGYlpl0Cr9iHC7xLULCUjeBVki/4zTxxbjQKzglUjPyZGpd?=
 =?us-ascii?Q?5BrEAf+BNZrx5fZKQkmSbM9Flaefs7N2oEtGTY38zjgsmiZclYYcEx2vI8DW?=
 =?us-ascii?Q?6m8iIKLg5yvXvz7cAhdSIvZEzspmaM6ExguszBhHkBO/wQBGvOMHMh6fcY+M?=
 =?us-ascii?Q?xG1gQdtirn12ebrt+YspG3FQpoht6EgURutpximmFSEdRjOYx//hbdFhuaMa?=
 =?us-ascii?Q?xY5+72xmgrU5pmjt2q2joactJsuEO6dL10okdX4uzoFu85yVBVWT8aEzAB4u?=
 =?us-ascii?Q?aYH7CzpHie93YjJMEziQojvE26l6PhzaDBVKJ4ekeSDJqFIM7UWOwEq8Rm9h?=
 =?us-ascii?Q?hdo55TkLIxAkaEg2Ds+jzzmY+aDJpO3yNfvG+x3JV+HS7bC4eBInZg2YAkms?=
 =?us-ascii?Q?mT+joegLmnjbfcOxpEpni9GwlgraDw8OA1sTjHmR0zmkGUAdJZG3PpZ2q/Vy?=
 =?us-ascii?Q?oyBS2g4fz7nBp0ncLAyn0WzC+M8NzFM3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 05:09:36.5791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d30e1f-8e1a-4901-7e08-08dcd60dc294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743

Provide more flexibility in terms of runtime mode switch for a managed
percpu ref. This can be useful for cases when in some scenarios, a
managed ref's object enters shutdown phase. Instead of waiting for
manager thread to process the ref, user can dirctly invoke
percpu_ref_kill() for the ref.

The init modes are same as in existing code. Runtime mode switching
allows switching back a managed ref to unmanaged mode, which allows
transitions to all reinit modes from managed mode.

To -->       A   P   P(RI)   M   D  D(RI)  D(RI/M)   EX   REI   RES

  A          y   n     y     y   n    y       y       y     y     y
  P          n   n     n     n   y    n       n       y     n     n
  M          y*  n     y*    y   n    y*      y       y*    y     y
  P(RI)      y   n     y     y   n    y       y       y     y     y
  D(RI)      y   n     y     y   n    y       y       -     y     y
  D(RI/M)    y*  n     y*    y   n    y*      y       -     y     y

Modes:
A - Atomic  P - PerCPU  M - Managed  P(RI) - PerCPU with ReInit
D(RI) - Dead with ReInit  D(RI/M) - Dead with ReInit and Managed

PerCPU Ref Ops:

KLL - Kill  REI - Reinit  RES - Resurrect

(RI) is for modes which are initialized with PERCPU_REF_ALLOW_REINIT.
The transitions shown above are the allowed transitions and can be
indirect transitions. For example, managed ref switches to P(RI) mode
when percpu_ref_switch_to_unmanaged() is called for it. P(RI) mode
can be directly switched to A mode using percpu_ref_switch_to_atomic().

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 include/linux/percpu-refcount.h |   3 +-
 lib/percpu-refcount.c           | 248 +++++++++++---------------------
 2 files changed, 88 insertions(+), 163 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index e6aea81b3d01..fe967db431a6 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -110,7 +110,7 @@ struct percpu_ref_data {
 	struct rcu_head		rcu;
 	struct percpu_ref	*ref;
 	unsigned int		aux_flags;
-	struct llist_node	node;
+	struct list_head	node;
 
 };
 
@@ -139,6 +139,7 @@ void percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref);
 void percpu_ref_switch_to_percpu(struct percpu_ref *ref);
 int percpu_ref_switch_to_managed(struct percpu_ref *ref);
+void percpu_ref_switch_to_unmanaged(struct percpu_ref *ref);
 void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 				 percpu_ref_func_t *confirm_kill);
 void percpu_ref_resurrect(struct percpu_ref *ref);
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 7d0c85c7ce57..b79e36905aa4 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -5,7 +5,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
-#include <linux/llist.h>
+#include <linux/list.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/mm.h>
@@ -43,7 +43,12 @@
 
 static DEFINE_SPINLOCK(percpu_ref_switch_lock);
 static DECLARE_WAIT_QUEUE_HEAD(percpu_ref_switch_waitq);
-static LLIST_HEAD(percpu_ref_manage_head);
+static struct list_head percpu_ref_manage_head = LIST_HEAD_INIT(percpu_ref_manage_head);
+/* Spinlock protects node additions/deletions */
+static DEFINE_SPINLOCK(percpu_ref_manage_lock);
+/* Mutex synchronizes node deletions with the node being scanned */
+static DEFINE_MUTEX(percpu_ref_active_switch_mutex);
+static struct list_head *next_percpu_ref_node = &percpu_ref_manage_head;
 
 static unsigned long __percpu *percpu_count_ptr(struct percpu_ref *ref)
 {
@@ -112,7 +117,7 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
 	data->confirm_switch = NULL;
 	data->ref = ref;
 	ref->data = data;
-	init_llist_node(&data->node);
+	INIT_LIST_HEAD(&data->node);
 
 	if (flags & PERCPU_REF_REL_MANAGED)
 		percpu_ref_switch_to_managed(ref);
@@ -150,9 +155,9 @@ static int __percpu_ref_switch_to_managed(struct percpu_ref *ref)
 	data->force_atomic = false;
 	if (!__ref_is_percpu(ref, &percpu_count))
 		__percpu_ref_switch_mode(ref, NULL);
-	/* Ensure ordering of percpu mode switch and node scan */
-	smp_mb();
-	llist_add(&data->node, &percpu_ref_manage_head);
+	spin_lock(&percpu_ref_manage_lock);
+	list_add(&data->node, &percpu_ref_manage_head);
+	spin_unlock(&percpu_ref_manage_lock);
 
 	return 0;
 
@@ -162,7 +167,7 @@ static int __percpu_ref_switch_to_managed(struct percpu_ref *ref)
 }
 
 /**
- * percpu_ref_switch_to_managed - Switch an unmanaged ref to percpu mode.
+ * percpu_ref_switch_to_managed - Switch an unmanaged ref to percpu managed mode.
  *
  * @ref: percpu_ref to switch to managed mode
  *
@@ -179,6 +184,47 @@ int percpu_ref_switch_to_managed(struct percpu_ref *ref)
 }
 EXPORT_SYMBOL_GPL(percpu_ref_switch_to_managed);
 
+/**
+ * percpu_ref_switch_to_unmanaged - Switch a managed ref to percpu mode.
+ *
+ * @ref: percpu_ref to switch back to unmanaged percpu mode
+ *
+ * Must only be called with elevated refcount.
+ */
+void percpu_ref_switch_to_unmanaged(struct percpu_ref *ref)
+{
+	bool mutex_taken = false;
+	struct list_head *node;
+	unsigned long flags;
+
+	might_sleep();
+
+	WARN_ONCE(!percpu_ref_is_managed(ref), "Percpu ref is not managed");
+
+	node = &ref->data->node;
+	spin_lock(&percpu_ref_manage_lock);
+	if (list_empty(node)) {
+		spin_unlock(&percpu_ref_manage_lock);
+		mutex_taken = true;
+		mutex_lock(&percpu_ref_active_switch_mutex);
+		spin_lock(&percpu_ref_manage_lock);
+	}
+
+	if (next_percpu_ref_node == node)
+		next_percpu_ref_node = next_percpu_ref_node->next;
+	list_del_init(node);
+	spin_unlock(&percpu_ref_manage_lock);
+	if (mutex_taken)
+		mutex_unlock(&percpu_ref_active_switch_mutex);
+
+	/* Drop the pseudo-init reference */
+	percpu_ref_put(ref);
+	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	ref->data->aux_flags &= ~__PERCPU_REL_MANAGED;
+	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+}
+EXPORT_SYMBOL_GPL(percpu_ref_switch_to_unmanaged);
+
 static void __percpu_ref_exit(struct percpu_ref *ref)
 {
 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
@@ -599,164 +645,35 @@ module_param(max_scan_count, int, 0444);
 
 static void percpu_ref_release_work_fn(struct work_struct *work);
 
-/*
- * Sentinel llist nodes for lockless list traveral and deletions by
- * the pcpu ref release worker, while nodes are added from
- * percpu_ref_init() and percpu_ref_switch_to_managed().
- *
- * Sentinel node marks the head of list traversal for the current
- * iteration of kworker execution.
- */
-struct percpu_ref_sen_node {
-	bool inuse;
-	struct llist_node node;
-};
-
-/*
- * We need two sentinel nodes for lockless list manipulations from release
- * worker - first node will be used in current reclaim iteration. The second
- * node will be used in next iteration. Next iteration marks the first node
- * as free, for use in subsequent iteration.
- */
-#define PERCPU_REF_SEN_NODES_COUNT     2
-
-/* Track last processed percpu ref node */
-static struct llist_node *last_percpu_ref_node;
-
-static struct percpu_ref_sen_node
-	percpu_ref_sen_nodes[PERCPU_REF_SEN_NODES_COUNT];
-
 static DECLARE_DELAYED_WORK(percpu_ref_release_work, percpu_ref_release_work_fn);
 
-static bool percpu_ref_is_sen_node(struct llist_node *node)
-{
-	return &percpu_ref_sen_nodes[0].node <= node &&
-		node <= &percpu_ref_sen_nodes[PERCPU_REF_SEN_NODES_COUNT - 1].node;
-}
-
-static struct llist_node *percpu_ref_get_sen_node(void)
-{
-	int i;
-	struct percpu_ref_sen_node *sn;
-
-	for (i = 0; i < PERCPU_REF_SEN_NODES_COUNT; i++) {
-		sn = &percpu_ref_sen_nodes[i];
-		if (!sn->inuse) {
-			sn->inuse = true;
-			return &sn->node;
-		}
-	}
-
-	return NULL;
-}
-
-static void percpu_ref_put_sen_node(struct llist_node *node)
-{
-	struct percpu_ref_sen_node *sn = container_of(node, struct percpu_ref_sen_node, node);
-
-	sn->inuse = false;
-	init_llist_node(node);
-}
-
-static void percpu_ref_put_all_sen_nodes_except(struct llist_node *node)
-{
-	int i;
-
-	for (i = 0; i < PERCPU_REF_SEN_NODES_COUNT; i++) {
-		if (&percpu_ref_sen_nodes[i].node == node)
-			continue;
-		percpu_ref_sen_nodes[i].inuse = false;
-		init_llist_node(&percpu_ref_sen_nodes[i].node);
-	}
-}
-
 static struct workqueue_struct *percpu_ref_release_wq;
 
 static void percpu_ref_release_work_fn(struct work_struct *work)
 {
-	struct llist_node *pos, *first, *head, *prev, *next;
-	struct llist_node *sen_node;
+	struct list_head *node;
 	struct percpu_ref *ref;
 	int count = 0;
 	bool held;
-	struct llist_node *last_node = READ_ONCE(last_percpu_ref_node);
 
-	first = READ_ONCE(percpu_ref_manage_head.first);
-	if (!first)
+	mutex_lock(&percpu_ref_active_switch_mutex);
+	spin_lock(&percpu_ref_manage_lock);
+	if (list_empty(&percpu_ref_manage_head)) {
+		next_percpu_ref_node = &percpu_ref_manage_head;
+		spin_unlock(&percpu_ref_manage_lock);
+		mutex_unlock(&percpu_ref_active_switch_mutex);
 		goto queue_release_work;
-
-	/*
-	 * Enqueue a dummy node to mark the start of scan. This dummy
-	 * node is used as start point of scan and ensures that
-	 * there is no additional synchronization required with new
-	 * label node additions to the llist. Any new labels will
-	 * be processed in next run of the kworker.
-	 *
-	 *                SCAN START PTR
-	 *                     |
-	 *                     v
-	 * +----------+     +------+    +------+    +------+
-	 * |          |     |      |    |      |    |      |
-	 * |   head   ------> dummy|--->|label |--->| label|--->NULL
-	 * |          |     | node |    |      |    |      |
-	 * +----------+     +------+    +------+    +------+
-	 *
-	 *
-	 * New label addition:
-	 *
-	 *                       SCAN START PTR
-	 *                            |
-	 *                            v
-	 * +----------+  +------+  +------+    +------+    +------+
-	 * |          |  |      |  |      |    |      |    |      |
-	 * |   head   |--> label|--> dummy|--->|label |--->| label|--->NULL
-	 * |          |  |      |  | node |    |      |    |      |
-	 * +----------+  +------+  +------+    +------+    +------+
-	 *
-	 */
-	if (last_node == NULL || last_node->next == NULL) {
-retry_sentinel_get:
-		sen_node = percpu_ref_get_sen_node();
-		/*
-		 * All sentinel nodes are in use? This should not happen, as we
-		 * require only one sentinel for the start of list traversal and
-		 * other sentinel node is freed during the traversal.
-		 */
-		if (WARN_ONCE(!sen_node, "All sentinel nodes are in use")) {
-			/* Use first node as the sentinel node */
-			head = first->next;
-			if (!head) {
-				struct llist_node *ign_node = NULL;
-				/*
-				 * We exhausted sentinel nodes. However, there aren't
-				 * enough nodes in the llist. So, we have leaked
-				 * sentinel nodes. Reclaim sentinels and retry.
-				 */
-				if (percpu_ref_is_sen_node(first))
-					ign_node = first;
-				percpu_ref_put_all_sen_nodes_except(ign_node);
-				goto retry_sentinel_get;
-			}
-			prev = first;
-		} else {
-			llist_add(sen_node, &percpu_ref_manage_head);
-			prev = sen_node;
-			head = prev->next;
-		}
-	} else {
-		prev = last_node;
-		head = prev->next;
 	}
+	if (next_percpu_ref_node == &percpu_ref_manage_head)
+		node = percpu_ref_manage_head.next;
+	else
+		node = next_percpu_ref_node;
+	next_percpu_ref_node = node->next;
+	list_del_init(node);
+	spin_unlock(&percpu_ref_manage_lock);
 
-	llist_for_each_safe(pos, next, head) {
-		/* Free sentinel node which is present in the list */
-		if (percpu_ref_is_sen_node(pos)) {
-			prev->next = pos->next;
-			percpu_ref_put_sen_node(pos);
-			continue;
-		}
-
-		ref = container_of(pos, struct percpu_ref_data, node)->ref;
+	while (!list_is_head(node, &percpu_ref_manage_head)) {
+		ref = container_of(node, struct percpu_ref_data, node)->ref;
 		__percpu_ref_switch_to_atomic_sync_checked(ref, false);
 		/*
 		 * Drop the ref while in RCU read critical section to
@@ -765,24 +682,31 @@ static void percpu_ref_release_work_fn(struct work_struct *work)
 		rcu_read_lock();
 		percpu_ref_put(ref);
 		held = percpu_ref_tryget(ref);
-		if (!held) {
-			prev->next = pos->next;
-			init_llist_node(pos);
+		if (held) {
+			spin_lock(&percpu_ref_manage_lock);
+			list_add(node, &percpu_ref_manage_head);
+			spin_unlock(&percpu_ref_manage_lock);
+			__percpu_ref_switch_to_percpu_checked(ref, false);
+		} else {
 			ref->percpu_count_ptr |= __PERCPU_REF_DEAD;
 		}
 		rcu_read_unlock();
-		if (!held)
-			continue;
-		__percpu_ref_switch_to_percpu_checked(ref, false);
+		mutex_unlock(&percpu_ref_active_switch_mutex);
 		count++;
-		if (count == READ_ONCE(max_scan_count)) {
-			WRITE_ONCE(last_percpu_ref_node, pos);
+		if (count == READ_ONCE(max_scan_count))
 			goto queue_release_work;
+		mutex_lock(&percpu_ref_active_switch_mutex);
+		spin_lock(&percpu_ref_manage_lock);
+		node = next_percpu_ref_node;
+		if (!list_is_head(next_percpu_ref_node, &percpu_ref_manage_head)) {
+			next_percpu_ref_node = next_percpu_ref_node->next;
+			list_del_init(node);
 		}
-		prev = pos;
+		spin_unlock(&percpu_ref_manage_lock);
 	}
 
-	WRITE_ONCE(last_percpu_ref_node, NULL);
+	mutex_unlock(&percpu_ref_active_switch_mutex);
+
 queue_release_work:
 	queue_delayed_work(percpu_ref_release_wq, &percpu_ref_release_work,
 			   scan_interval);
-- 
2.34.1

