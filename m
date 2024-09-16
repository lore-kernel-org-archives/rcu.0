Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D02BD19;
	Mon, 16 Sep 2024 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463400; cv=fail; b=pBdKDjAZWzIDi1/9kTQ9AZ+MeTVFb9TFxaCTkRecbnarI1JMzoQcP2Hfq+g6GaR6lwuMsidrXTy9/oUfNjd2ek6XNpWO6dPrTKTbd/OAKqegmOKP14apcMimjGwWIAPhstGENioHghOKT0HBZ/RSJm4L3YYnwuLyBnVOvVxqEbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463400; c=relaxed/simple;
	bh=9iWo5p6+3i8ZqjG/8dT4qlIGTch2mq8nMCtVnDnETyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdnspDBt6Ey0jt+Ex77VRE5kSpadi2FFYJXAix4OO2IMkPYPhz5CvIIR/oYIOq799zueS8SkV3uJ3nKKoYdB9XsDLttyxbX06F9IKAhkn7B0Ac84v4xv5kYfV/pu09KehystqS/blc95IhzK945E6hhIJuyZKgTQpByTWZnUAhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=APZ+J72m; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="APZ+J72m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yveyjA7KkyBNC1laqiTI+b0ZZ+4qeLDSgM3TKaeUF2LI0YQ6gbFUVBQUYPEN/QWWb2vE3yV5H2ZcPK5JL9+bCuUkQCuV0Y4CzU/TGuX7rfKQ5c/lId8VyGDH6rE4tBR+LxXrG68VLiLfj7SVF3ivt5RNVdrtOADx4tmMmK5Qfxh2K0BQ0IfhJBvEgHyoNrstUN7xLixQKnSo6MuPvQIEiKBbwEUvsjINMVuyRm+LLCUCfcUMppLn1zJAx+neZjrrg+bgrKJ6zTlwbzBJKF+jNbzOTD9DdMOHKnXFV9vE/aKdQ5bUzFTXzPy171+Fnfm/dCddhk9wQsFYVzGkK/50jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS9htN1kP9pZdhBQxkiiDa24nt1ICyEwzzMLrt19yj8=;
 b=wppSOUaB7d1Ahk+vLk+tnOkRyEirQsHo3ROoAPnR10OTl+RNwqQ5+bKCPA+kDHIuSY6yg1l3EXN6R8VVzzeHMeH5a1Ati9xFJk1jbFwIkYSd9VP+Hbi0AWS6URyISIPSjxYcuG8fT9I3u+o89qmc/SMTK29KFn1nDAYqiQa8O29Hi1kCTU89Snw7QlIwfSKzcXs6tIm3EEBO6usuhm8L6tXvebVjf5ZcXt+IrXCJLPO+FM3JeGw9URq3zqePFwbZ0rqgfdg1hI6htIREgeZPsHKlV+A5slZkgYe05ovOWK1rcOibx2sY4n49hJN1HSYsS4ExBKCbgIA7hqFBX3wm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS9htN1kP9pZdhBQxkiiDa24nt1ICyEwzzMLrt19yj8=;
 b=APZ+J72mtV6X1/Epc5jo0S+IJmiXxYIh5xLEceQbaIzwte7CHe0xFk29Iq/F0sVsAIkC8xQsNFjiRrAcWTN9ocrdAI5SdO5rBYSuSneuZX7rx4EfxE0KXUUoEJCkv1pWyqYAA5FzYPeSee1QeGoPp71NChDvjDTOyPKJsdkukBc=
Received: from MW4PR04CA0384.namprd04.prod.outlook.com (2603:10b6:303:81::29)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Mon, 16 Sep
 2024 05:09:55 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::9e) by MW4PR04CA0384.outlook.office365.com
 (2603:10b6:303:81::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 05:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 05:09:54 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 00:09:48 -0500
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	<gautham.shenoy@amd.com>, <Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	<dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>, <linux-mm@kvack.org>,
	<rcu@vger.kernel.org>
Subject: [RFC 4/6] percpu-refcount-torture: Extend test with runtime mode switches
Date: Mon, 16 Sep 2024 10:38:09 +0530
Message-ID: <20240916050811.473556-5-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be1d72c-8332-45e0-36a6-08dcd60dcd60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z70JubxGidW8xyCupr+gZAYJkEF1nNPrmas1rQZf3OKcxAoHLvQ2A2uNSPan?=
 =?us-ascii?Q?lek5alRGxkWvPYIMisGVkTchurTKylNrcMJiMsSKReA7ihRtLjFYiSuhQMl3?=
 =?us-ascii?Q?bla9r2oT0plHxxVOM3tLOQs3XF47BSBg2ZCPMNmZpg+2uQ/vP7TY9MEbRoDH?=
 =?us-ascii?Q?rFuWdgUK0NZA/U7PhqQJInZ8ldW5Fty1zQb2jEG//CE69zla2GrdCCKPQWa7?=
 =?us-ascii?Q?dolyJgTRk8+jMXGkzUR7oQE+Fycbq0R/3n4d2bcxdhQvzHfa1J2bIv3hK7Ud?=
 =?us-ascii?Q?Ji3fIqD9YHkl/uitzqafQIcVqdLtHHdZOhCQuSLEDTPopHx5zbHnOBGIOzL+?=
 =?us-ascii?Q?GaZ+/WXidJd56MStLklEvsitCaBWcG09tvzCznmyJmt3wV9REgb2HPJSBDkL?=
 =?us-ascii?Q?BgofpBVuS4e3TWt4UYv3BtHAzyA/rQtlxflMSYN8Tioowbq2q2iPl5wt64gO?=
 =?us-ascii?Q?npUoay0dFd8U70M2kdJZAWu1ubgWDsqM2vBeRcLx0bKxp1ws+p6VYy3jYeQ1?=
 =?us-ascii?Q?IYhpS2gyAyGAVedikCbIsZ4a+BezlEYZpJOVdKLXI2gL4MOrXMdeANG66sRF?=
 =?us-ascii?Q?lGtuNl4yrRymvQ3a5U/fPzyWbRbM8pgPb8OaoyIaMwkEF+WfCLAay7PbKgHx?=
 =?us-ascii?Q?tsSwrzdyPt4pBNKFBhZdcMMzPt5EG0n0hgSH8pCoJJ9hVIFrj2lUMuMXU5vo?=
 =?us-ascii?Q?v+OnpgH3dXGGRxzAiOKB2P0A7jWvrIrs3fStgQswHMoH4B2TTg7gWH447O7D?=
 =?us-ascii?Q?3y97PiIObEDalhfEw8KAJuNgs+/T78zfBMZd4chAh7SSQTirmDqS83U7ReWu?=
 =?us-ascii?Q?F6qRaKDIcZ2bsqT1XYzNcghkRmtWsSd03dpe6BSz5PRMcg1o2qEOTvOntWTA?=
 =?us-ascii?Q?8B9wC4AXYFJw9kHYfonMfPLvIFUAHa8b0jJPQfbYAqZSiVUQ4/XhIFWexGKM?=
 =?us-ascii?Q?6Uw+DVNd8Ca8XSzuRq5q1NdPgRbiv+1hc3qYF+bnt3lE5kaz2DTETtnzst0Q?=
 =?us-ascii?Q?WVSMj9RcU51FhYWFXqi1U92fhdNRo2I4QfEdR2vTpBKbSABy+hCgMt6alRgF?=
 =?us-ascii?Q?iUOAoofDKDNNMYyLewuHiQfNsb86wPNfjSV/quCr9BFelmEY5MyGtz3LlGa4?=
 =?us-ascii?Q?ahws4g2cC0/BP8Vri8oEdrDmOp+EyC1Nat3d8jbZS9w8r5R1D3J+kLY/Z6P8?=
 =?us-ascii?Q?GAqaEvq7vZ6um+fzw4KXFAdLYRhjMRbuSYsMbF9ZwezC3lZJ6jKHhwzSYChQ?=
 =?us-ascii?Q?NyBapizQFwtroRtstZlOR0uy/+eMBj5kLY3b60VVxfeZYEokQH5ErIgeLTdq?=
 =?us-ascii?Q?Lfdmcro4uJaieQce+/d6uJV366QnPorH7MeJvv1WZoFZMSumZSX+M3OVjL+c?=
 =?us-ascii?Q?Sh6ngrhX5568rXKsQyTu8qKhBQfiIJRNYcwBUUo5vcqyQot4VG0ysu7lSRoI?=
 =?us-ascii?Q?Sjp85BEMV9AzyPuERGP3DVKjs+7Tx/oy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 05:09:54.6758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be1d72c-8332-45e0-36a6-08dcd60dcd60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931

Extend the test to exercise runtime switching from managed
mode to other reinitable active modes.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 lib/percpu-refcount-torture.c | 41 +++++++++++++++++++++++++++++++++--
 lib/percpu-refcount.c         | 12 +++++++++-
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/lib/percpu-refcount-torture.c b/lib/percpu-refcount-torture.c
index 686f5a228b40..cb2700b16517 100644
--- a/lib/percpu-refcount-torture.c
+++ b/lib/percpu-refcount-torture.c
@@ -3,6 +3,7 @@
 #include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/percpu-refcount.h>
 #include <linux/torture.h>
 
@@ -59,6 +60,7 @@ static struct task_struct **busted_late_release_tasks;
 
 static struct percpu_ref *refs;
 static long *num_per_ref_users;
+static struct mutex *ref_switch_mutexes;
 
 static atomic_t running;
 static atomic_t *ref_running;
@@ -97,19 +99,36 @@ static int percpu_ref_manager_thread(void *data)
 static int percpu_ref_test_thread(void *data)
 {
 	struct percpu_ref *ref = (struct percpu_ref *)data;
+	DEFINE_TORTURE_RANDOM(rand);
+	int ref_idx = ref - refs;
+	int do_switch;
 	int i = 0;
 
 	percpu_ref_get(ref);
 
 	do {
 		percpu_ref_get(ref);
+		/* Perform checks once per 256 iterations */
+		do_switch = (torture_random(&rand) & 0xff);
 		udelay(delay_us);
+		if (do_switch) {
+			mutex_lock(&ref_switch_mutexes[ref_idx]);
+			percpu_ref_switch_to_unmanaged(ref);
+			udelay(delay_us);
+			percpu_ref_switch_to_atomic_sync(ref);
+			if (do_switch & 1)
+				percpu_ref_switch_to_percpu(ref);
+			udelay(delay_us);
+			percpu_ref_switch_to_managed(ref);
+			mutex_unlock(&ref_switch_mutexes[ref_idx]);
+			udelay(delay_us);
+		}
 		percpu_ref_put(ref);
 		stutter_wait("percpu_ref_test_thread");
 		i++;
 	} while (i < niterations);
 
-	atomic_dec(&ref_running[ref - refs]);
+	atomic_dec(&ref_running[ref_idx]);
 	/* Order ref release with ref_running[ref_idx] == 0 */
 	smp_mb();
 	percpu_ref_put(ref);
@@ -213,6 +232,13 @@ static void percpu_ref_test_cleanup(void)
 	kfree(num_per_ref_users);
 	num_per_ref_users = NULL;
 
+	if (ref_switch_mutexes) {
+		for (i = 0; i < nrefs; i++)
+			mutex_destroy(&ref_switch_mutexes[i]);
+		kfree(ref_switch_mutexes);
+		ref_switch_mutexes = NULL;
+	}
+
 	if (refs) {
 		for (i = 0; i < nrefs; i++)
 			percpu_ref_exit(&refs[i]);
@@ -251,7 +277,8 @@ static int __init percpu_ref_torture_init(void)
 		goto init_err;
 	}
 	for (i = 0; i < nrefs; i++) {
-		flags = torture_random(trsp) & 1 ? PERCPU_REF_INIT_ATOMIC : PERCPU_REF_REL_MANAGED;
+		flags = (torture_random(trsp) & 1) ? PERCPU_REF_INIT_ATOMIC :
+							PERCPU_REF_REL_MANAGED;
 		err = percpu_ref_init(&refs[i], percpu_ref_test_release,
 				      flags, GFP_KERNEL);
 		if (err)
@@ -269,6 +296,16 @@ static int __init percpu_ref_torture_init(void)
 	for (i = 0; i < nrefs; i++)
 		num_per_ref_users[i] = 0;
 
+	ref_switch_mutexes = kcalloc(nrefs, sizeof(ref_switch_mutexes[0]), GFP_KERNEL);
+	if (!ref_switch_mutexes) {
+		TOROUT_ERRSTRING("out of memory");
+		err = -ENOMEM;
+		goto init_err;
+	}
+
+	for (i = 0; i < nrefs; i++)
+		mutex_init(&ref_switch_mutexes[i]);
+
 	ref_user_tasks = kcalloc(nusers, sizeof(ref_user_tasks[0]), GFP_KERNEL);
 	if (!ref_user_tasks) {
 		TOROUT_ERRSTRING("out of memory");
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index b79e36905aa4..4e0a453bd51f 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -723,6 +723,7 @@ EXPORT_SYMBOL_GPL(percpu_ref_test_is_percpu);
 void percpu_ref_test_flush_release_work(void)
 {
 	int max_flush = READ_ONCE(max_scan_count);
+	struct list_head *next;
 	int max_count = 1000;
 
 	/* Complete any executing release work */
@@ -738,8 +739,17 @@ void percpu_ref_test_flush_release_work(void)
 	/* max scan count update visible to work */
 	smp_mb();
 	flush_delayed_work(&percpu_ref_release_work);
-	while (READ_ONCE(last_percpu_ref_node) != NULL && max_count--)
+
+	while (true) {
+		if (!max_count--)
+			break;
+		spin_lock(&percpu_ref_manage_lock);
+		next = next_percpu_ref_node;
+		spin_unlock(&percpu_ref_manage_lock);
+		if (list_is_head(next, &percpu_ref_manage_head))
+			break;
 		flush_delayed_work(&percpu_ref_release_work);
+	}
 	/* max scan count update visible to work */
 	smp_mb();
 	WRITE_ONCE(max_scan_count, max_flush);
-- 
2.34.1

