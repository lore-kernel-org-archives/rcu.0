Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D443ACB;
	Mon, 16 Sep 2024 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463361; cv=fail; b=kX7wMf9shFeleAT7ha205Ib0kqyqEYIP3UnF6gnz30Upo2+c3IK178PyoR3wwq3hZB946FdJUpXuYTIsrOVTg3zTZCRuhnWJf7qmp98TPdD4RVrhECOYQMFDhvQggla6uPQFEVRXLmLdTmTMtzegtMosm3U+464CplaEflTUcfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463361; c=relaxed/simple;
	bh=cMnCbt8kRYfh4msHZJQH3lxJQDqr94sFrjU2OilMnWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFGLnLwpiIF9dWnK2rctnWXLm/T1T893f+ItBu0kPt9gapRLjTY1aSzCKTh3udIhV3dQdaaqwU5vSYLetTvpsu9JyozJxK/OEplZfXAsfXwEolAi0buUnCKSWX2l+ElR1AJhb0OsGccU6lJmLF/2p48GPEOjigK5w2jbP2W/OwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X7MRNBtn; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X7MRNBtn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbBdgvkRlg4WjNbnEva8nHBQeyZx6eRfCIGDkEqQbV1C6L8CQuaE1buuB8NMTubrObCqsDskq+FwUlqZD/iOfhdZVsnlpGEQG2E8Cm7nK3pCWDkwyHs53D/qOC42ng55+xfNgzc5KvcLg9YL4G8U0z9m2tSAJU/To40osNTkAtsRQPw3caJRE62LNHyjRDqd8uGp0FnGKXNo1KDLMYwSRGK+a/9hhIZlcuKzpmokQ1duI60QwwPWJgEpNh6WXjk/Gp1A86yYUCasrWmo7NNCjmhBJGpSC+p7c4SXa8kgfbO+rqVzUxQ5L7jMHwmKWN1YmkpPueLjLS8SkM4sAoeH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAYTEu/r5ZwyE4gU0EfeKdUTT2JqfoHk4L5udSk6Kng=;
 b=tkTc62pr39PWBh2YweLLSVn6h2zqTo7MMotR6b5oSFMs9CSC/W21EUQeaThnxlSJpFWxolWnLh1i8mEscVAi7wTc/BD2VbUSJ1bPbbWXykFSH7qIq6jDfynpm+kBPJpYKuHqNqemr+td23slUEBTYsPE9O/B+0fzod1Jsn75BGWrcMAGs+DsFWRz1eAtpj8sHPDAkLH8RKfa3w5pEIuDeiw0erzoOBIjO5E1813MlZNdSQp7B8UThjnzsjtPmEwPc9P9Dvk7t03TVcieP/tTtzxu4Xi5LiBHFfvs/Pnz7oE8IFJ2Tnq+hYzxWIAd2SjQpJXl6bVxq3cusCa3dsMJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAYTEu/r5ZwyE4gU0EfeKdUTT2JqfoHk4L5udSk6Kng=;
 b=X7MRNBtnYmAuur4tWHwjzQ2NPD53v/H864b5YPzoL3r1aB9Hi0CO6f8+jxFNg4gSHboK75cw8SgK3Nnqgocethc+u8QKoBSmLUbAL9FzDrRUSsJlg2sz4QVfKMKkInSL9VWZEJOTLWYAOGVd/2YKwmWiB1d8mKb8GMx+A/j2SrI=
Received: from SJ0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:a03:39e::15)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Mon, 16 Sep
 2024 05:09:13 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::e2) by SJ0PR03CA0280.outlook.office365.com
 (2603:10b6:a03:39e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Mon, 16 Sep 2024 05:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 05:09:13 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 00:09:07 -0500
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	<gautham.shenoy@amd.com>, <Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	<dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>, <linux-mm@kvack.org>,
	<rcu@vger.kernel.org>
Subject: [RFC 2/6] percpu-refcount: Add torture test for percpu refcount
Date: Mon, 16 Sep 2024 10:38:07 +0530
Message-ID: <20240916050811.473556-3-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a604ec-097e-40c1-7c2b-08dcd60db4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e3GE4r7ZazQvKAGYI45liIL+y6LeoiYsEmL2xsWFns5D9I5bJzdiSxoMEm6r?=
 =?us-ascii?Q?IoIc5aBiIISi05coB+QcqpnMGFYvtaDmUWWbC3tEtXYoI5aF+/m9Gk9UGKeJ?=
 =?us-ascii?Q?FG8C6iKEoUZRlz4fxrt09KoKuEHB5rDaQjxCY/txwD8mMYpLtqg3IOkMXozt?=
 =?us-ascii?Q?EAzaQE8BE5DeJgRp5qcK7A1dQliz8PwMsgj3NK2ZPT/X6lsaVsvR1zJ3KeX9?=
 =?us-ascii?Q?Wb8yaqxhoJHucY9JnB4CKv8GZ9TtHGhiXQdpOWTzuvZmGgsXY5198KavtftR?=
 =?us-ascii?Q?wc3A9JekQsEtnEkKiW+Uqsw41KCa3mK718fara+wTg8HsdLafPRfZadu42Yq?=
 =?us-ascii?Q?lIJMfz+7fh60NrVwUtJkpY9XhSaFkx9Z9hmrkX7P6a4PnT08kQpIZYl0ctbX?=
 =?us-ascii?Q?qdVCW451AsHhUfLXzW6d9yvMYYVKzc1vHNJxFQXi3OSS71BHiMeUYcDwoCXT?=
 =?us-ascii?Q?HI2XKZselOEbhlaJow3qVa3dIcclThuGf+e+4HtAu2+geWuOX/l4YdHDKO7Q?=
 =?us-ascii?Q?3LpsnuKMN/sS06i7XyRPVq3pRgdPuL7RpGOFrfdnYAJG7CsikM+ajsM5dJQo?=
 =?us-ascii?Q?IEgnpVg9Sjl+jaE9P2rWZlIXSyrd4hT4uYkMdJqRz3o8cNjh/5dImqzP5lJj?=
 =?us-ascii?Q?XtvQBpv2H09HuAZrkmnDAmkJvQhCL5Tjfa59zSsOtKdVOeCb5triuHDm+o//?=
 =?us-ascii?Q?W7V6JifbTXlza3wFL/zs2Boi5YMgBcgNDRkVMUptYzfIzHxQJJXUu6zSef4j?=
 =?us-ascii?Q?BLa2ps1y/yVUIyriNwHgAW2huqADWyaEGpCrvrfAGq+WO4x4DB05e5SG4DTQ?=
 =?us-ascii?Q?YxSYKsUNr8E/zAi61hrqwrlJGF+X2/r4OUxjCst4YvU9HgSbqn9O5WQknSRN?=
 =?us-ascii?Q?gqGMF8G/STmm5tGoI4c3ZaRveoYWWJTiBViOCTndQn9KndUMYvpxo3IhXOih?=
 =?us-ascii?Q?xZvsksNGSicLy0pXza95CwG/dBd0iiQyOJafd9yAU4R+1VTnv6wBWGQeyw1/?=
 =?us-ascii?Q?IS4kYS5qUiZZeOa7NDSpkIvB3DV94fSQkW5ziuPW1FvQ5qY1LEkRQQsBG/q9?=
 =?us-ascii?Q?+lzzQ+SfbW91Lq37SwmqvtSFF0nZZXCDhIOp+Ue13FVj61OcOACoN0HfxgCQ?=
 =?us-ascii?Q?F3cw1f6BNqFJNeJKDhf2vd69GOlIdH/3W/0yrpNkbjvZ0tTy6Sm6z1iuiliu?=
 =?us-ascii?Q?wNXbCyJ0Gym0iffsmfKxvG+N8epXKkMFBPK7cuat+JLJbDNVMZUc7A0D/xUs?=
 =?us-ascii?Q?YQLVXGwBL4j18xGlk2d4yA2xQYS5qNr9wJRf3UZWsfVe3ow+Xu2b55/9f0EV?=
 =?us-ascii?Q?j2x6Y0VumnRuYErI6Rf0uFRdAo+esfkVDdi94RMoFwkecupsmNcTUudthgBX?=
 =?us-ascii?Q?BniGagVZTjpxBZ4tNg0iuyT5Tnle24ukWq+CuE8Rex0wKY+6oDAPHhjMDFUk?=
 =?us-ascii?Q?npXmnk646+Mun45NNhEIqJ1vQNMNiVkb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 05:09:13.3022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a604ec-097e-40c1-7c2b-08dcd60db4b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426

Add torture test to verify percpu managed mode operations,
verifying that a percpu ref does not have non-zero count when
all users have dropped their reference and that there is no early
release of the ref while users hold references to it.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  57 +++
 lib/Kconfig.debug                             |   9 +
 lib/Makefile                                  |   1 +
 lib/percpu-refcount-torture.c                 | 367 ++++++++++++++++++
 lib/percpu-refcount.c                         |  49 ++-
 lib/percpu-refcount.h                         |   6 +
 6 files changed, 483 insertions(+), 6 deletions(-)
 create mode 100644 lib/percpu-refcount-torture.c
 create mode 100644 lib/percpu-refcount.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0f02a1b04fe9..225f2dac294d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4677,6 +4677,63 @@
 
 			Default: 5000 ms
 
+	percpu_refcount_torture.busted_early_ref_release= [KNL]
+			Enable testing buggy release of percpu ref while
+			there are active users. Used for testing failure
+			scenarios in the test.
+
+			Default: 0 (disabled)
+
+	percpu_refcount_torture.busted_late_ref_release= [KNL]
+			Enable testing buggy non-zero reference count after
+			all ref users have dropped their reference. Used for
+			testing failure scenarios in the test.
+
+			Default: 0 (disabled)
+
+	percpu_refcount_torture.delay_us= [KNL]
+			Delay (in us) between reference increment and decrement
+			operations of ref users.
+
+			Default: 10
+
+	percpu_refcount_torture.niterations= [KNL]
+			Number of iterations of ref increment and decrement by
+			ref users.
+
+			Default: 100
+
+	percpu_refcount_torture.nrefs= [KNL]
+			Number of percpu ref instances.
+
+			Default: 2
+
+	percpu_refcount_torture.nusers= [KNL]
+			Number of percpu ref user threads which increment and
+			decrement a percpu ref.
+
+			Default: 2
+
+	percpu_refcount_torture.onoff_holdoff= [KNL]
+			Set time (s) after boot for CPU-hotplug testing.
+
+			Default: 0
+
+	percpu_refcount_torture.onoff_interval= [KNL]
+			Set time (jiffies) between CPU-hotplug operations,
+			or zero to disable CPU-hotplug testing.
+
+	percpu_refcount_torture.stutter= [KNL]
+			Set wait time (jiffies) between two iterations of
+			percpu ref operations.
+
+			Default: 0
+
+	percpu_refcount_torture.verbose= [KNL]
+			Enable additional printk() statements.
+
+			Default: 0 (Disabled)
+
 	pirq=		[SMP,APIC] Manual mp-table setup
 			See Documentation/arch/x86/i386/IO-APIC.rst.
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..7e0117e01f05 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1611,6 +1611,15 @@ config SCF_TORTURE_TEST
 	  module may be built after the fact on the running kernel to
 	  be tested, if desired.
 
+config PERCPU_REFCOUNT_TORTURE_TEST
+	tristate "torture tests for percpu refcount"
+	select TORTURE_TEST
+	help
+	  This options provides a kernel module that runs percpu
+	  refcount torture tests for managed percpu refs. The kernel
+	  module may be built after the fact on the running kernel
+	  to be tested, if desired.
+
 config CSD_LOCK_WAIT_DEBUG
 	bool "Debugging for csd_lock_wait(), called from smp_call_function*()"
 	depends on DEBUG_KERNEL
diff --git a/lib/Makefile b/lib/Makefile
index 322bb127b4dc..d0286f7dfb37 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -50,6 +50,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o bitmap-str.o
 obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
+obj-$(CONFIG_PERCPU_REFCOUNT_TORTURE_TEST) += percpu-refcount-torture.o
 obj-y += string_helpers.o
 obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
 obj-y += hexdump.o
diff --git a/lib/percpu-refcount-torture.c b/lib/percpu-refcount-torture.c
new file mode 100644
index 000000000000..686f5a228b40
--- /dev/null
+++ b/lib/percpu-refcount-torture.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/percpu-refcount.h>
+#include <linux/torture.h>
+
+#include "percpu-refcount.h"
+
+static int busted_early_ref_release;
+module_param(busted_early_ref_release, int, 0444);
+MODULE_PARM_DESC(busted_early_ref_release,
+		 "Enable busted premature release of ref (default = 0), 0 = disable");
+
+static int busted_late_ref_release;
+module_param(busted_late_ref_release, int, 0444);
+MODULE_PARM_DESC(busted_late_ref_release,
+		 "Enable busted late release of ref (default = 0), 0 = disable");
+
+static long delay_us = 10;
+module_param(delay_us, long, 0444);
+MODULE_PARM_DESC(delay_us,
+		 "delay between reader refcount operations in microseconds (default = 10)");
+
+static long nrefs = 2;
+module_param(nrefs, long, 0444);
+MODULE_PARM_DESC(nrefs, "Number of percpu refs (default = 2)");
+
+static long niterations = 100;
+module_param(niterations, long, 0444);
+MODULE_PARM_DESC(niterations,
+		 "Number of iterations of ref increment and decrement (default = 100)");
+
+static long nusers = 2;
+module_param(nusers, long, 0444);
+MODULE_PARM_DESC(nusers, "Number of refcount users (default = 2)");
+
+static int onoff_holdoff;
+module_param(onoff_holdoff, int, 0444);
+MODULE_PARM_DESC(onoff_holdoff, "Time after boot before CPU hotplugs (seconds)");
+
+static int onoff_interval;
+module_param(onoff_interval, int, 0444);
+MODULE_PARM_DESC(onoff_interval, "Time between CPU hotplugs (jiffies), 0=disable");
+
+static int stutter;
+module_param(stutter, int, 0444);
+MODULE_PARM_DESC(stutter, "Stutter period in jiffies (default = 0), 0 = disable");
+
+static int verbose = 1;
+module_param(verbose, int, 0444);
+MODULE_PARM_DESC(verbose, "Enable verbose debugging printk()s");
+
+static struct task_struct **ref_user_tasks;
+static struct task_struct *ref_manager_task;
+static struct task_struct **busted_early_release_tasks;
+static struct task_struct **busted_late_release_tasks;
+
+static struct percpu_ref *refs;
+static long *num_per_ref_users;
+
+static atomic_t running;
+static atomic_t *ref_running;
+
+static char *torture_type = "percpu-refcount";
+
+static int percpu_ref_manager_thread(void *data)
+{
+	int i;
+
+	while (atomic_read(&running) != 0) {
+		percpu_ref_test_flush_release_work();
+		stutter_wait("percpu_ref_manager_thread");
+	}
+	/* Ensure ordering with ref users */
+	smp_mb();
+
+	percpu_ref_test_flush_release_work();
+
+	for (i = 0; i < nrefs; i++) {
+		WARN(percpu_ref_test_is_percpu(&refs[i]),
+			"!!! released ref %d should be in atomic mode", i);
+		WARN(!percpu_ref_is_zero(&refs[i]),
+			"!!! released ref %d should have 0 refcount", i);
+	}
+
+	do {
+		stutter_wait("percpu_ref_manager_thread");
+	} while (!torture_must_stop());
+
+	torture_kthread_stopping("percpu_ref_manager_thread");
+
+	return 0;
+}
+
+static int percpu_ref_test_thread(void *data)
+{
+	struct percpu_ref *ref = (struct percpu_ref *)data;
+	int i = 0;
+
+	percpu_ref_get(ref);
+
+	do {
+		percpu_ref_get(ref);
+		udelay(delay_us);
+		percpu_ref_put(ref);
+		stutter_wait("percpu_ref_test_thread");
+		i++;
+	} while (i < niterations);
+
+	atomic_dec(&ref_running[ref - refs]);
+	/* Order ref release with ref_running[ref_idx] == 0 */
+	smp_mb();
+	percpu_ref_put(ref);
+	/* Order ref decrement with running == 0 */
+	smp_mb();
+	atomic_dec(&running);
+
+	do {
+		stutter_wait("percpu_ref_test_thread");
+	} while (!torture_must_stop());
+
+	torture_kthread_stopping("percpu_ref_test_thread");
+
+	return 0;
+}
+
+static int percpu_ref_busted_early_thread(void *data)
+{
+	struct percpu_ref *ref = (struct percpu_ref *)data;
+	int ref_idx = ref - refs;
+	int i = 0, j;
+
+	do {
+		/* Extra ref put momemtarily */
+		for (j = 0; j < num_per_ref_users[ref_idx]; j++)
+			percpu_ref_put(ref);
+		stutter_wait("percpu_ref_busted_early_thread");
+		for (j = 0; j < num_per_ref_users[ref_idx]; j++)
+			percpu_ref_get(ref);
+		i++;
+		stutter_wait("percpu_ref_busted_early_thread");
+	} while (i < niterations * 10);
+
+	do {
+		stutter_wait("percpu_ref_busted_early_thread");
+	} while (!torture_must_stop());
+
+	torture_kthread_stopping("percpu_ref_busted_early_thread");
+
+	return 0;
+}
+
+static int percpu_ref_busted_late_thread(void *data)
+{
+	struct percpu_ref *ref = (struct percpu_ref *)data;
+	int i = 0;
+
+	do {
+		/* Extra ref get momemtarily */
+		percpu_ref_get(ref);
+		stutter_wait("percpu_ref_busted_late_thread");
+		percpu_ref_put(ref);
+		i++;
+	} while (i < niterations);
+
+	do {
+		stutter_wait("percpu_ref_busted_late_thread");
+	} while (!torture_must_stop());
+
+	torture_kthread_stopping("percpu_ref_busted_late_thread");
+
+	return 0;
+}
+
+static void percpu_ref_test_cleanup(void)
+{
+	int i;
+
+	if (torture_cleanup_begin())
+		return;
+
+	if (busted_late_release_tasks) {
+		for (i = 0; i < nrefs; i++)
+			torture_stop_kthread(busted_late_task, busted_late_release_tasks[i]);
+		kfree(busted_late_release_tasks);
+		busted_late_release_tasks = NULL;
+	}
+
+	if (busted_early_release_tasks) {
+		for (i = 0; i < nrefs; i++)
+			torture_stop_kthread(busted_early_task, busted_early_release_tasks[i]);
+		kfree(busted_early_release_tasks);
+		busted_early_release_tasks = NULL;
+	}
+
+	if (ref_manager_task) {
+		torture_stop_kthread(ref_manager, ref_manager_task);
+		ref_manager_task = NULL;
+	}
+
+	if (ref_user_tasks) {
+		for (i = 0; i < nusers; i++)
+			torture_stop_kthread(ref_user, ref_user_tasks[i]);
+		kfree(ref_user_tasks);
+		ref_user_tasks = NULL;
+	}
+
+	kfree(ref_running);
+	ref_running = NULL;
+
+	kfree(num_per_ref_users);
+	num_per_ref_users = NULL;
+
+	if (refs) {
+		for (i = 0; i < nrefs; i++)
+			percpu_ref_exit(&refs[i]);
+		kfree(refs);
+		refs = NULL;
+	}
+
+	torture_cleanup_end();
+}
+
+static void percpu_ref_test_release(struct percpu_ref *ref)
+{
+	WARN(!!atomic_add_return(0, &ref_running[ref-refs]), "!!! Premature ref release");
+}
+
+static int __init percpu_ref_torture_init(void)
+{
+	DEFINE_TORTURE_RANDOM(rand);
+	struct torture_random_state *trsp = &rand;
+	int flags;
+	int err;
+	int ref_idx;
+	int i;
+
+	if (!torture_init_begin("percpu-refcount", verbose))
+		return -EBUSY;
+
+	atomic_set(&running, nusers);
+	/* Order @running with later increment and decrement operations */
+	smp_mb();
+
+	refs = kcalloc(nrefs, sizeof(refs[0]), GFP_KERNEL);
+	if (!refs) {
+		TOROUT_ERRSTRING("out of memory");
+		err = -ENOMEM;
+		goto init_err;
+	}
+	for (i = 0; i < nrefs; i++) {
+		flags = torture_random(trsp) & 1 ? PERCPU_REF_INIT_ATOMIC : PERCPU_REF_REL_MANAGED;
+		err = percpu_ref_init(&refs[i], percpu_ref_test_release,
+				      flags, GFP_KERNEL);
+		if (err)
+			goto init_err;
+		if (!(flags & PERCPU_REF_REL_MANAGED))
+			percpu_ref_switch_to_managed(&refs[i]);
+	}
+
+	num_per_ref_users = kcalloc(nrefs, sizeof(num_per_ref_users[0]), GFP_KERNEL);
+	if (!num_per_ref_users) {
+		TOROUT_ERRSTRING("out of memory");
+		err = -ENOMEM;
+		goto init_err;
+	}
+	for (i = 0; i < nrefs; i++)
+		num_per_ref_users[i] = 0;
+
+	ref_user_tasks = kcalloc(nusers, sizeof(ref_user_tasks[0]), GFP_KERNEL);
+	if (!ref_user_tasks) {
+		TOROUT_ERRSTRING("out of memory");
+		err = -ENOMEM;
+		goto init_err;
+	}
+
+	ref_running = kcalloc(nrefs, sizeof(ref_running[0]), GFP_KERNEL);
+	if (!ref_running) {
+		TOROUT_ERRSTRING("out of memory");
+		err = -ENOMEM;
+		goto init_err;
+	}
+
+	for (i = 0; i < nusers; i++) {
+		ref_idx = torture_random(trsp) % nrefs;
+		atomic_inc(&ref_running[ref_idx]);
+		num_per_ref_users[ref_idx]++;
+		/* Order increments with subquent reads */
+		smp_mb();
+		err = torture_create_kthread(percpu_ref_test_thread,
+					     &refs[ref_idx], ref_user_tasks[i]);
+		if (torture_init_error(err))
+			goto init_err;
+	}
+
+	err = torture_create_kthread(percpu_ref_manager_thread, NULL, ref_manager_task);
+	if (torture_init_error(err))
+		goto init_err;
+
+	/* Drop initial reference, after test threads have started running */
+	udelay(1);
+	for (i = 0; i < nrefs; i++)
+		percpu_ref_put(&refs[i]);
+
+
+	if (busted_early_ref_release) {
+		busted_early_release_tasks = kcalloc(nrefs,
+						     sizeof(busted_early_release_tasks[0]),
+						     GFP_KERNEL);
+		if (!busted_early_release_tasks) {
+			TOROUT_ERRSTRING("out of memory");
+			err = -ENOMEM;
+			goto init_err;
+		}
+		for (i = 0; i < nrefs; i++) {
+			err = torture_create_kthread(percpu_ref_busted_early_thread,
+					     &refs[i], busted_early_release_tasks[i]);
+			if (torture_init_error(err))
+				goto init_err;
+		}
+	}
+
+	if (busted_late_ref_release) {
+		busted_late_release_tasks = kcalloc(nrefs, sizeof(busted_late_release_tasks[0]),
+						    GFP_KERNEL);
+		if (!busted_late_release_tasks) {
+			TOROUT_ERRSTRING("out of memory");
+			err = -ENOMEM;
+			goto init_err;
+		}
+		for (i = 0; i < nrefs; i++) {
+			err = torture_create_kthread(percpu_ref_busted_late_thread,
+					     &refs[i], busted_late_release_tasks[i]);
+			if (torture_init_error(err))
+				goto init_err;
+		}
+	}
+	if (stutter) {
+		err = torture_stutter_init(stutter, stutter);
+		if (torture_init_error(err))
+			goto init_err;
+	}
+
+	err = torture_onoff_init(onoff_holdoff * HZ, onoff_interval, NULL);
+	if (torture_init_error(err))
+		goto init_err;
+
+	torture_init_end();
+	return 0;
+init_err:
+	torture_init_end();
+	percpu_ref_test_cleanup();
+	return err;
+}
+
+static void __exit percpu_ref_torture_exit(void)
+{
+	percpu_ref_test_cleanup();
+}
+
+module_init(percpu_ref_torture_init);
+module_exit(percpu_ref_torture_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("percpu refcount torture test");
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 7b97f9728c5b..7d0c85c7ce57 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -11,6 +11,8 @@
 #include <linux/mm.h>
 #include <linux/percpu-refcount.h>
 
+#include "percpu-refcount.h"
+
 /*
  * Initially, a percpu refcount is just a set of percpu counters. Initially, we
  * don't try to detect the ref hitting 0 - which means that get/put can just
@@ -677,6 +679,7 @@ static void percpu_ref_release_work_fn(struct work_struct *work)
 	struct percpu_ref *ref;
 	int count = 0;
 	bool held;
+	struct llist_node *last_node = READ_ONCE(last_percpu_ref_node);
 
 	first = READ_ONCE(percpu_ref_manage_head.first);
 	if (!first)
@@ -711,7 +714,7 @@ static void percpu_ref_release_work_fn(struct work_struct *work)
 	 * +----------+  +------+  +------+    +------+    +------+
 	 *
 	 */
-	if (last_percpu_ref_node == NULL || last_percpu_ref_node->next == NULL) {
+	if (last_node == NULL || last_node->next == NULL) {
 retry_sentinel_get:
 		sen_node = percpu_ref_get_sen_node();
 		/*
@@ -741,11 +744,10 @@ static void percpu_ref_release_work_fn(struct work_struct *work)
 			head = prev->next;
 		}
 	} else {
-		prev = last_percpu_ref_node;
+		prev = last_node;
 		head = prev->next;
 	}
 
-	last_percpu_ref_node = NULL;
 	llist_for_each_safe(pos, next, head) {
 		/* Free sentinel node which is present in the list */
 		if (percpu_ref_is_sen_node(pos)) {
@@ -773,18 +775,53 @@ static void percpu_ref_release_work_fn(struct work_struct *work)
 			continue;
 		__percpu_ref_switch_to_percpu_checked(ref, false);
 		count++;
-		if (count == max_scan_count) {
-			last_percpu_ref_node = pos;
-			break;
+		if (count == READ_ONCE(max_scan_count)) {
+			WRITE_ONCE(last_percpu_ref_node, pos);
+			goto queue_release_work;
 		}
 		prev = pos;
 	}
 
+	WRITE_ONCE(last_percpu_ref_node, NULL);
 queue_release_work:
 	queue_delayed_work(percpu_ref_release_wq, &percpu_ref_release_work,
 			   scan_interval);
 }
 
+bool percpu_ref_test_is_percpu(struct percpu_ref *ref)
+{
+	unsigned long __percpu *percpu_count;
+
+	return __ref_is_percpu(ref, &percpu_count);
+}
+EXPORT_SYMBOL_GPL(percpu_ref_test_is_percpu);
+
+void percpu_ref_test_flush_release_work(void)
+{
+	int max_flush = READ_ONCE(max_scan_count);
+	int max_count = 1000;
+
+	/* Complete any executing release work */
+	flush_delayed_work(&percpu_ref_release_work);
+	/* Scan till the end of the llist */
+	WRITE_ONCE(max_scan_count, INT_MAX);
+	/* max scan count update visible to release work */
+	smp_mb();
+	flush_delayed_work(&percpu_ref_release_work);
+	/* max scan count update visible to release work */
+	smp_mb();
+	WRITE_ONCE(max_scan_count, 1);
+	/* max scan count update visible to work */
+	smp_mb();
+	flush_delayed_work(&percpu_ref_release_work);
+	while (READ_ONCE(last_percpu_ref_node) != NULL && max_count--)
+		flush_delayed_work(&percpu_ref_release_work);
+	/* max scan count update visible to work */
+	smp_mb();
+	WRITE_ONCE(max_scan_count, max_flush);
+}
+EXPORT_SYMBOL_GPL(percpu_ref_test_flush_release_work);
+
 static __init int percpu_ref_setup(void)
 {
 	percpu_ref_release_wq = alloc_workqueue("percpu_ref_release_wq",
diff --git a/lib/percpu-refcount.h b/lib/percpu-refcount.h
new file mode 100644
index 000000000000..be2ac0411194
--- /dev/null
+++ b/lib/percpu-refcount.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __LIB_REFCOUNT_H
+#define __LIB_REFCOUNT_H
+bool percpu_ref_test_is_percpu(struct percpu_ref *ref);
+void percpu_ref_test_flush_release_work(void);
+#endif
-- 
2.34.1

