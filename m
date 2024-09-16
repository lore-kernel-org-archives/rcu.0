Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199B224D6;
	Mon, 16 Sep 2024 05:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463338; cv=fail; b=DrCrp3A5BqX6hN4yv7QCGXv5L4ZDfs3ZJrf5XQywyb7j4qtl4H8RS6ztG3uRZOuxTVjB2Q2W9C/iFH1nf61a7E8/FwVKE6fqEIAHACSAYR3rjD0WlNjvWXLdBjEln/2hMGzUumjpOy8+JNBAZu5/7V0+tRDcDHGMuG1vKMjj0QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463338; c=relaxed/simple;
	bh=/OMPpbyioaekCErvkWbeqRAhGK/B9QKC7+zS3er2en8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMDokd865skha0prWtJpby72gnCPHe/z/seAsp3jdHprE4d3iQUoiFgMLzJJGeRuwBjmuF8zASSpgzQ6P7bbwGcqWlev10E8n/RDLRgn3/0MIfT6aa0LZvnP4VARg8l6cqf/xpoDsS0DXWTIvVqrGr2MVe5c/wUwqD+Q8ANs03E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EhiQEAT0; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EhiQEAT0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8whDK5gJFXerI/MTyfY0FBne/1JRw+lSXXunm7oyn1LPYQyOe/n3IDnWB8ZsulRyz44YH69xw1fU4dFMvLL7alcc6BwmAd7A9ka4erIbIvFTECJS5meOMB9GGwxeMbABj9/z4WtJ/76ciVDCg9WsoqA5bPbeAvtiDoBbMIopx0NGRfB6pigIjCXp4qDs8JBSNtckvgsRdGnbIQGWcHYxb8PwYAG3pQln47zwh7+23H8K2DH1LceDPZ5Xceen4eg/ugvHRAAjj0CwHmu5QN3xtDwOtw9oiR9pXzc9EK+pRZgrWhXcBVD3nSogavqb1kSkuYd4AKAC2H6+OopETz+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FBVw+pyjVJ0fOe69NB1TgCfKY+dzuWS4nyeSzMm6vs=;
 b=F9iKr9ys0TBpBlSR6TtIOykKbwn57qG+5bq4sb2iPURn97ysbHcFalDIXXxEJo66+M9c9XpseoRhbz5LcAS+dreTBy9aAqzkYS/w/xaUKWPfAL7sU5mlTTUDBlcXQENAh74Qr8GGGHduXt798vRzM4k9iaqJw7+qsRUJA4OdVx6+SvkZR0CM8OWCYh51aviZ2uuGf1SFRKci7Aj5Fs9xpIJRK6o+EjGGG3kz+H7j7BLKCUrgCb2yP5Uqy88xPoNh6wMgW71GS/h5TZIXkcjgBliyuVaXek9tw44CjCq2Ut08e4awQZIy/yQzqPQrewnuAygdXbxaGuPjMniTjpHLBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FBVw+pyjVJ0fOe69NB1TgCfKY+dzuWS4nyeSzMm6vs=;
 b=EhiQEAT0/J575zNjcrq9eW8Dx2YftJpvizrBx63itmdBMixYf56PcbMUSOcgf2q7VToFU3I2+CiP7tLL0nOqYuT81e+Biut4+Xowp72q+t9jAtKh56+j9GHBnNTjjr/pgshfpmSlcyIyK63uDF8BI/EOY3FCCEdlnzLJ57HC+QQ=
Received: from SJ0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:a03:39e::16)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 05:08:50 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::b2) by SJ0PR03CA0281.outlook.office365.com
 (2603:10b6:a03:39e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29 via Frontend
 Transport; Mon, 16 Sep 2024 05:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 05:08:49 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 00:08:43 -0500
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	<gautham.shenoy@amd.com>, <Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	<dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>, <linux-mm@kvack.org>,
	<rcu@vger.kernel.org>
Subject: [RFC 1/6] percpu-refcount: Add managed mode for RCU released objects
Date: Mon, 16 Sep 2024 10:38:06 +0530
Message-ID: <20240916050811.473556-2-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 78289c7b-5265-47a9-fb05-08dcd60da6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jfpODw4Pkp7XUxB9GwMvh6Gd9CxIE3uU3HEs3OwN+9y6ZwUaQb5W2Y2qPWhI?=
 =?us-ascii?Q?c1RwPwT4yNwREf7YAQ1v3dHlC+Fv+RqNtcuj5aR2Kaa2jlXMqtUz//frYrAM?=
 =?us-ascii?Q?moHejRGmrC5DIi3fqVJLANnPxp+wlNlqmbmq34OSIcRJLD676vfmJrgnoFDV?=
 =?us-ascii?Q?G6hu9OzHZO+7CCnCRuqw+PHnKWM02zUf8HbUHD+tmdGBEMOSLTAbJGiYzZCT?=
 =?us-ascii?Q?VZmmNdHWNUGP29Bojepo1YcessldMi98WcNji3/rCKIUHMBwIL9xVcj6yw/I?=
 =?us-ascii?Q?88ousgZFW6huLIHWbOlKZIQAQFRQRHn+r5kEtFTaGoPUAgxuMWzizvEvpoVB?=
 =?us-ascii?Q?3NJvftudpBApofX7tg1roGhBV15WjtUDJfhPWrsbw8ODhQyRbn6nm2iEXL4D?=
 =?us-ascii?Q?VGyUOdclRLYYQBTQbGfytvICcYfp87D8ghmhSxIXaUg/MddrTgvOymo3YpJi?=
 =?us-ascii?Q?biIpF6FT4nr87IGPckH3xynhH6efHN6WyaZbkBNDr4ssH+BcFLGe3L0nkNM+?=
 =?us-ascii?Q?wvU6RngpzwT+RT9xqJpJPNhSqG9ZymgX/512tIS+YV60XeJc4xou+aymFjYp?=
 =?us-ascii?Q?08oZo/FhEqUx+WGyJWqdjI3NXvB4sKXuuA156mRxC+lt+IH5LdzDVvle58qj?=
 =?us-ascii?Q?nvTT1E7fVvaphbZbJpLuLJ7j81r2cQDq720iXZBH0kD4yrpsXFAOmvSk1mqR?=
 =?us-ascii?Q?Kh/zU2gb7yf0jxpeU4BFjn7jfcVnlC0rUHBXkFLbyf+24tpXCEmx9j35cbFh?=
 =?us-ascii?Q?pPeUUrOISqBq1lGOzj0AcmnJvH+uESOcJgODgISpsJJx5iBxbdSSxWO16njG?=
 =?us-ascii?Q?hudM1k3d/sDNnsZQKt9oVpC7WHkqL2B9PncMgt0dqcvpzJeaIShbKHs7NJAh?=
 =?us-ascii?Q?mysZj83oISqyxQGFPBNZGV1VoC1D5FjWulX79u4Nsp6ytYSqlrnLjTadhKBf?=
 =?us-ascii?Q?mqqRmp5244hXXf4Dce4Zr9New2k7FZRrCD8cf6lrE5if5rZcDCBoWxlVix5p?=
 =?us-ascii?Q?0ATz7PguZj2rN0tNPgHdCu5cVNxeRK/4lWL7IzWYSL3AxEV6fpb7rsOywf9K?=
 =?us-ascii?Q?YVqHLjsBMxy+kY2w7+odYySURvE88K4iopwmppaLPiDlxs/Pscww2/vtmgtX?=
 =?us-ascii?Q?vpDnhWB7veZqw5OBIdnPxAZaqbvVFEUUXUEEYNruntJ7nsC3cf4k2Zm1gPzZ?=
 =?us-ascii?Q?D6teJktY8gFWCDBTpueUoNGeFHEPHuMAgpXOxfCiHHqyoYDEIC7dpgOr0Cn1?=
 =?us-ascii?Q?tbP8BZFQ9Q0dBtxtA4fIfO4aUbSsKFSqUZRTvPRD8i4loZ/q7Z7jMh5nYLj/?=
 =?us-ascii?Q?sIcJzYg9TE09rsVtN3PgEQTRGlHiKnyQ+CctkIfT148T8HzlYUIPFQZXNxb2?=
 =?us-ascii?Q?++X2mzM5//3Mjv9IXMwbwUtvG14ea4j+anov6LVZVIY9lTh4IF21V0irQIMc?=
 =?us-ascii?Q?Jzytqu762bAlFD45MPHhJWrKo2vHmzfA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 05:08:49.9273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78289c7b-5265-47a9-fb05-08dcd60da6c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347

Add a new "managed mode" to percpu refcounts, to track initial
reference drop for refs which use RCU grace period for their object
reclaims. Typical usage pattern for such refs is:

// Called with elevated refcount
get()
    p = get_ptr();
    kref_get(&p->count);
    return p;

get()
    rcu_read_lock();
    p = get_ptr();
    if (p && !kref_get_unless_zero(&p->count))
        p = NULL;
    rcu_read_unlock();
    return p;

release()
    remove_ptr(p);
    call_rcu(&p->rcu, freep);

release()
    remove_ptr(p);
    kfree_rcu((p, rcu);

Currently, percpu ref requires users to call percpu_ref_kill() when
object usage enters a shutdown phase. Post killi operation, ref
increment/ decrement are performed on a atomic counter. For cases where
ref is actively acquired and released after percpu_ref_kill(),
percpu ref does not provide any performance benefits over using
an atomic reference counter. Managed mode offloads tracking of ref
kill to a manager thread, thereby not requiring users to explicitly
call percpu_ref_kill(). This helps avoid the problem of suboptimal
performance if a percpu ref is actively acquired and released after
percpu_ref_kill() operation.

A percpu ref can be initialized as managed either during
percpu_ref_init() by passing PERCPU_REF_REL_MANAGED flag or a
reinitable ref can be switched to managed mode using
percpu_ref_switch_to_managed() post its initialization. Deferred switch
to managed mode can be used for cases like module initialization
errors, where a inited percpu ref's initial reference is dropped before
the object becomes active and is referenced by other contexts. One such
case is Apparmor labels which are not associated yet with a namespace.
These labels are freed without waiting for a RCU grace period. So,
managed mode cannot be used for these labels until their initialization
has completed.

Following are the allowed initialization modes for managed ref:

                Atomic  Percpu   Dead  Reinit  Managed
Managed-ref       Y        N      Y      Y       Y

Following are the allowed transitions for managed ref:

To -->       A   P   P(RI)   M   D  D(RI)  D(RI/M)   KLL   REI   RES

  A          y   n     y     y   n    y       y       y     y     y
  P          n   n     n     n   y    n       n       y     n     n
  M          n   n     n     y   n    n       y       n     y     y
  P(RI)      y   n     y     y   n    y       y       y     y     y
  D(RI)      y   n     y     y   n    y       y       -     y     y
  D(RI/M)    n   n     n     y   n    n       y       -     y     y

Modes:
A - Atomic  P - PerCPU  M - Managed  P(RI) - PerCPU with ReInit
D(RI) - Dead with ReInit  D(RI/M) - Dead with ReInit and Managed

PerCPU Ref Ops:

KLL - Kill  REI - Reinit  RES - Resurrect

Once a percpu ref is switched to managed mode, it cannot be switched to
any other active mode. On reinit/resurrect, managed ref is reinitialized
in managed mode.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  12 +
 include/linux/percpu-refcount.h               |  13 +
 lib/percpu-refcount.c                         | 358 +++++++++++++++++-
 3 files changed, 364 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..0f02a1b04fe9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4665,6 +4665,18 @@
 			allocator.  This parameter is primarily	for debugging
 			and performance comparison.
 
+	percpu_refcount.max_scan_count= [KNL]
+			Specifies the maximum number of percpu ref nodes which
+			are processed in one run of percpu ref manager thread.
+
+			Default: 100
+
+	percpu_refcount.scan_interval= [KNL]
+			Specifies the duration (ms) between two runs of manager
+			thread.
+
+			Default: 5000 ms
+
 	pirq=		[SMP,APIC] Manual mp-table setup
 			See Documentation/arch/x86/i386/IO-APIC.rst.
 
diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index d73a1c08c3e3..e6aea81b3d01 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -68,6 +68,11 @@ enum {
 	__PERCPU_REF_FLAG_BITS	= 2,
 };
 
+/* Auxiliary flags */
+enum  {
+	__PERCPU_REL_MANAGED	= 1LU << 0,	/* operating in managed mode */
+};
+
 /* @flags for percpu_ref_init() */
 enum {
 	/*
@@ -90,6 +95,10 @@ enum {
 	 * Allow switching from atomic mode to percpu mode.
 	 */
 	PERCPU_REF_ALLOW_REINIT	= 1 << 2,
+	/*
+	 * Manage release of the percpu ref.
+	 */
+	PERCPU_REF_REL_MANAGED	= 1 << 3,
 };
 
 struct percpu_ref_data {
@@ -100,6 +109,9 @@ struct percpu_ref_data {
 	bool			allow_reinit:1;
 	struct rcu_head		rcu;
 	struct percpu_ref	*ref;
+	unsigned int		aux_flags;
+	struct llist_node	node;
+
 };
 
 struct percpu_ref {
@@ -126,6 +138,7 @@ void percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 				 percpu_ref_func_t *confirm_switch);
 void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref);
 void percpu_ref_switch_to_percpu(struct percpu_ref *ref);
+int percpu_ref_switch_to_managed(struct percpu_ref *ref);
 void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 				 percpu_ref_func_t *confirm_kill);
 void percpu_ref_resurrect(struct percpu_ref *ref);
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 668f6aa6a75d..7b97f9728c5b 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -5,6 +5,9 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
+#include <linux/llist.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/percpu-refcount.h>
 
@@ -38,6 +41,7 @@
 
 static DEFINE_SPINLOCK(percpu_ref_switch_lock);
 static DECLARE_WAIT_QUEUE_HEAD(percpu_ref_switch_waitq);
+static LLIST_HEAD(percpu_ref_manage_head);
 
 static unsigned long __percpu *percpu_count_ptr(struct percpu_ref *ref)
 {
@@ -45,6 +49,8 @@ static unsigned long __percpu *percpu_count_ptr(struct percpu_ref *ref)
 		(ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC_DEAD);
 }
 
+int percpu_ref_switch_to_managed(struct percpu_ref *ref);
+
 /**
  * percpu_ref_init - initialize a percpu refcount
  * @ref: percpu_ref to initialize
@@ -80,6 +86,9 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
 		return -ENOMEM;
 	}
 
+	if (flags & PERCPU_REF_REL_MANAGED)
+		flags |= PERCPU_REF_ALLOW_REINIT;
+
 	data->force_atomic = flags & PERCPU_REF_INIT_ATOMIC;
 	data->allow_reinit = flags & PERCPU_REF_ALLOW_REINIT;
 
@@ -101,10 +110,73 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
 	data->confirm_switch = NULL;
 	data->ref = ref;
 	ref->data = data;
+	init_llist_node(&data->node);
+
+	if (flags & PERCPU_REF_REL_MANAGED)
+		percpu_ref_switch_to_managed(ref);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(percpu_ref_init);
 
+static bool percpu_ref_is_managed(struct percpu_ref *ref)
+{
+	return (ref->data->aux_flags & __PERCPU_REL_MANAGED) != 0;
+}
+
+static void __percpu_ref_switch_mode(struct percpu_ref *ref,
+				     percpu_ref_func_t *confirm_switch);
+
+static int __percpu_ref_switch_to_managed(struct percpu_ref *ref)
+{
+	unsigned long __percpu *percpu_count;
+	struct percpu_ref_data *data;
+	int ret = -1;
+
+	data = ref->data;
+
+	if (WARN_ONCE(!percpu_ref_tryget(ref), "Percpu ref is not active"))
+		return ret;
+
+	if (WARN_ONCE(!data->allow_reinit, "Percpu ref does not allow switch"))
+		goto err_switch_managed;
+
+	if (WARN_ONCE(percpu_ref_is_managed(ref), "Percpu ref is already managed"))
+		goto err_switch_managed;
+
+	data->aux_flags |= __PERCPU_REL_MANAGED;
+	data->force_atomic = false;
+	if (!__ref_is_percpu(ref, &percpu_count))
+		__percpu_ref_switch_mode(ref, NULL);
+	/* Ensure ordering of percpu mode switch and node scan */
+	smp_mb();
+	llist_add(&data->node, &percpu_ref_manage_head);
+
+	return 0;
+
+err_switch_managed:
+	percpu_ref_put(ref);
+	return ret;
+}
+
+/**
+ * percpu_ref_switch_to_managed - Switch an unmanaged ref to percpu mode.
+ *
+ * @ref: percpu_ref to switch to managed mode
+ *
+ */
+int percpu_ref_switch_to_managed(struct percpu_ref *ref)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	ret = __percpu_ref_switch_to_managed(ref);
+	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(percpu_ref_switch_to_managed);
+
 static void __percpu_ref_exit(struct percpu_ref *ref)
 {
 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
@@ -283,6 +355,27 @@ static void __percpu_ref_switch_mode(struct percpu_ref *ref,
 		__percpu_ref_switch_to_percpu(ref);
 }
 
+static bool __percpu_ref_switch_to_atomic_checked(struct percpu_ref *ref,
+						  percpu_ref_func_t *confirm_switch,
+						  bool check_managed)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	if (check_managed && WARN_ONCE(percpu_ref_is_managed(ref),
+		      "Percpu ref is managed, cannot switch to atomic mode")) {
+		spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+		return false;
+	}
+
+	ref->data->force_atomic = true;
+	__percpu_ref_switch_mode(ref, confirm_switch);
+
+	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+
+	return true;
+}
+
 /**
  * percpu_ref_switch_to_atomic - switch a percpu_ref to atomic mode
  * @ref: percpu_ref to switch to atomic mode
@@ -306,17 +399,16 @@ static void __percpu_ref_switch_mode(struct percpu_ref *ref,
 void percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 				 percpu_ref_func_t *confirm_switch)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
-
-	ref->data->force_atomic = true;
-	__percpu_ref_switch_mode(ref, confirm_switch);
-
-	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+	(void)__percpu_ref_switch_to_atomic_checked(ref, confirm_switch, true);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic);
 
+static void __percpu_ref_switch_to_atomic_sync_checked(struct percpu_ref *ref, bool check_managed)
+{
+	if (!__percpu_ref_switch_to_atomic_checked(ref, NULL, check_managed))
+		return;
+	wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
+}
 /**
  * percpu_ref_switch_to_atomic_sync - switch a percpu_ref to atomic mode
  * @ref: percpu_ref to switch to atomic mode
@@ -327,11 +419,28 @@ EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic);
  */
 void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref)
 {
-	percpu_ref_switch_to_atomic(ref, NULL);
-	wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
+	__percpu_ref_switch_to_atomic_sync_checked(ref, true);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic_sync);
 
+static void __percpu_ref_switch_to_percpu_checked(struct percpu_ref *ref, bool check_managed)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+
+	if (check_managed && WARN_ONCE(percpu_ref_is_managed(ref),
+		      "Percpu ref is managed, cannot switch to percpu mode")) {
+		spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+		return;
+	}
+
+	ref->data->force_atomic = false;
+	__percpu_ref_switch_mode(ref, NULL);
+
+	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+}
+
 /**
  * percpu_ref_switch_to_percpu - switch a percpu_ref to percpu mode
  * @ref: percpu_ref to switch to percpu mode
@@ -352,14 +461,7 @@ EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic_sync);
  */
 void percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
-
-	ref->data->force_atomic = false;
-	__percpu_ref_switch_mode(ref, NULL);
-
-	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+	__percpu_ref_switch_to_percpu_checked(ref, true);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_switch_to_percpu);
 
@@ -472,8 +574,226 @@ void percpu_ref_resurrect(struct percpu_ref *ref)
 
 	ref->percpu_count_ptr &= ~__PERCPU_REF_DEAD;
 	percpu_ref_get(ref);
-	__percpu_ref_switch_mode(ref, NULL);
+	if (percpu_ref_is_managed(ref)) {
+		ref->data->aux_flags &= ~__PERCPU_REL_MANAGED;
+		__percpu_ref_switch_to_managed(ref);
+	} else {
+		__percpu_ref_switch_mode(ref, NULL);
+	}
 
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_resurrect);
+
+#define DEFAULT_SCAN_INTERVAL_MS    5000
+/* Interval duration between two ref scans. */
+static ulong scan_interval = DEFAULT_SCAN_INTERVAL_MS;
+module_param(scan_interval, ulong, 0444);
+
+#define DEFAULT_MAX_SCAN_COUNT      100
+/* Number of percpu refs scanned in one iteration of worker execution. */
+static int max_scan_count = DEFAULT_MAX_SCAN_COUNT;
+module_param(max_scan_count, int, 0444);
+
+static void percpu_ref_release_work_fn(struct work_struct *work);
+
+/*
+ * Sentinel llist nodes for lockless list traveral and deletions by
+ * the pcpu ref release worker, while nodes are added from
+ * percpu_ref_init() and percpu_ref_switch_to_managed().
+ *
+ * Sentinel node marks the head of list traversal for the current
+ * iteration of kworker execution.
+ */
+struct percpu_ref_sen_node {
+	bool inuse;
+	struct llist_node node;
+};
+
+/*
+ * We need two sentinel nodes for lockless list manipulations from release
+ * worker - first node will be used in current reclaim iteration. The second
+ * node will be used in next iteration. Next iteration marks the first node
+ * as free, for use in subsequent iteration.
+ */
+#define PERCPU_REF_SEN_NODES_COUNT     2
+
+/* Track last processed percpu ref node */
+static struct llist_node *last_percpu_ref_node;
+
+static struct percpu_ref_sen_node
+	percpu_ref_sen_nodes[PERCPU_REF_SEN_NODES_COUNT];
+
+static DECLARE_DELAYED_WORK(percpu_ref_release_work, percpu_ref_release_work_fn);
+
+static bool percpu_ref_is_sen_node(struct llist_node *node)
+{
+	return &percpu_ref_sen_nodes[0].node <= node &&
+		node <= &percpu_ref_sen_nodes[PERCPU_REF_SEN_NODES_COUNT - 1].node;
+}
+
+static struct llist_node *percpu_ref_get_sen_node(void)
+{
+	int i;
+	struct percpu_ref_sen_node *sn;
+
+	for (i = 0; i < PERCPU_REF_SEN_NODES_COUNT; i++) {
+		sn = &percpu_ref_sen_nodes[i];
+		if (!sn->inuse) {
+			sn->inuse = true;
+			return &sn->node;
+		}
+	}
+
+	return NULL;
+}
+
+static void percpu_ref_put_sen_node(struct llist_node *node)
+{
+	struct percpu_ref_sen_node *sn = container_of(node, struct percpu_ref_sen_node, node);
+
+	sn->inuse = false;
+	init_llist_node(node);
+}
+
+static void percpu_ref_put_all_sen_nodes_except(struct llist_node *node)
+{
+	int i;
+
+	for (i = 0; i < PERCPU_REF_SEN_NODES_COUNT; i++) {
+		if (&percpu_ref_sen_nodes[i].node == node)
+			continue;
+		percpu_ref_sen_nodes[i].inuse = false;
+		init_llist_node(&percpu_ref_sen_nodes[i].node);
+	}
+}
+
+static struct workqueue_struct *percpu_ref_release_wq;
+
+static void percpu_ref_release_work_fn(struct work_struct *work)
+{
+	struct llist_node *pos, *first, *head, *prev, *next;
+	struct llist_node *sen_node;
+	struct percpu_ref *ref;
+	int count = 0;
+	bool held;
+
+	first = READ_ONCE(percpu_ref_manage_head.first);
+	if (!first)
+		goto queue_release_work;
+
+	/*
+	 * Enqueue a dummy node to mark the start of scan. This dummy
+	 * node is used as start point of scan and ensures that
+	 * there is no additional synchronization required with new
+	 * label node additions to the llist. Any new labels will
+	 * be processed in next run of the kworker.
+	 *
+	 *                SCAN START PTR
+	 *                     |
+	 *                     v
+	 * +----------+     +------+    +------+    +------+
+	 * |          |     |      |    |      |    |      |
+	 * |   head   ------> dummy|--->|label |--->| label|--->NULL
+	 * |          |     | node |    |      |    |      |
+	 * +----------+     +------+    +------+    +------+
+	 *
+	 *
+	 * New label addition:
+	 *
+	 *                       SCAN START PTR
+	 *                            |
+	 *                            v
+	 * +----------+  +------+  +------+    +------+    +------+
+	 * |          |  |      |  |      |    |      |    |      |
+	 * |   head   |--> label|--> dummy|--->|label |--->| label|--->NULL
+	 * |          |  |      |  | node |    |      |    |      |
+	 * +----------+  +------+  +------+    +------+    +------+
+	 *
+	 */
+	if (last_percpu_ref_node == NULL || last_percpu_ref_node->next == NULL) {
+retry_sentinel_get:
+		sen_node = percpu_ref_get_sen_node();
+		/*
+		 * All sentinel nodes are in use? This should not happen, as we
+		 * require only one sentinel for the start of list traversal and
+		 * other sentinel node is freed during the traversal.
+		 */
+		if (WARN_ONCE(!sen_node, "All sentinel nodes are in use")) {
+			/* Use first node as the sentinel node */
+			head = first->next;
+			if (!head) {
+				struct llist_node *ign_node = NULL;
+				/*
+				 * We exhausted sentinel nodes. However, there aren't
+				 * enough nodes in the llist. So, we have leaked
+				 * sentinel nodes. Reclaim sentinels and retry.
+				 */
+				if (percpu_ref_is_sen_node(first))
+					ign_node = first;
+				percpu_ref_put_all_sen_nodes_except(ign_node);
+				goto retry_sentinel_get;
+			}
+			prev = first;
+		} else {
+			llist_add(sen_node, &percpu_ref_manage_head);
+			prev = sen_node;
+			head = prev->next;
+		}
+	} else {
+		prev = last_percpu_ref_node;
+		head = prev->next;
+	}
+
+	last_percpu_ref_node = NULL;
+	llist_for_each_safe(pos, next, head) {
+		/* Free sentinel node which is present in the list */
+		if (percpu_ref_is_sen_node(pos)) {
+			prev->next = pos->next;
+			percpu_ref_put_sen_node(pos);
+			continue;
+		}
+
+		ref = container_of(pos, struct percpu_ref_data, node)->ref;
+		__percpu_ref_switch_to_atomic_sync_checked(ref, false);
+		/*
+		 * Drop the ref while in RCU read critical section to
+		 * prevent obj free while we manipulating node.
+		 */
+		rcu_read_lock();
+		percpu_ref_put(ref);
+		held = percpu_ref_tryget(ref);
+		if (!held) {
+			prev->next = pos->next;
+			init_llist_node(pos);
+			ref->percpu_count_ptr |= __PERCPU_REF_DEAD;
+		}
+		rcu_read_unlock();
+		if (!held)
+			continue;
+		__percpu_ref_switch_to_percpu_checked(ref, false);
+		count++;
+		if (count == max_scan_count) {
+			last_percpu_ref_node = pos;
+			break;
+		}
+		prev = pos;
+	}
+
+queue_release_work:
+	queue_delayed_work(percpu_ref_release_wq, &percpu_ref_release_work,
+			   scan_interval);
+}
+
+static __init int percpu_ref_setup(void)
+{
+	percpu_ref_release_wq = alloc_workqueue("percpu_ref_release_wq",
+				WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_FREEZABLE, 0);
+	if (!percpu_ref_release_wq)
+		return -ENOMEM;
+
+	queue_delayed_work(percpu_ref_release_wq, &percpu_ref_release_work,
+			   scan_interval);
+	return 0;
+}
+early_initcall(percpu_ref_setup);
-- 
2.34.1

