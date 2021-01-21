Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188BCC4332E
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 06:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BF0238EE
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 06:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbhAUGdq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Jan 2021 01:33:46 -0500
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:9664
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727102AbhAUGcw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Jan 2021 01:32:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsUVHFLnnMn1ydQLlV/4LrVfsKTqe5tuQPDbco2MX8/6l5SStbESkZZE2pnkRss0B60r02uBOV06UJDuARFOhvcn2MNYK6cBCbemqSTh19NHzCPNDGHAQzU3oqncF4EcAc/lm1l7gdwp+IYBPSoOYObCuVBLp2weziEa5d4RhSo7dVNX3SGVyY99TIobhhoajP81hZKnSuRzhtWS/lQh6Z1+Hs1OHD6hHkN87LbsdJtBrS1p/Qo9gT48bPu6jNB4lcs86Xd2NksDJErR3YL21QyuWnkiaOM4XpCTiN6qAk4kbclSDlFkpgB661nEi0VaUmsYlUPVAeZG2KD+x3/7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9TGsCPBLgSvGknUGTaA1ZQbCBgPuOSKLCcLa6W7mEE=;
 b=Domj2HM3zW6jDsmJKWarnNg02CbjwZ+T/pTN7yK8CzdG5qZW03/n4jjTyIYaPLlscaFqUEFwFVRxFT9ZFiWZwjjVueZJLFLPU2YMIFj0wecTH0Fu0hAn9JIU/xzmit//GuSZ1m1vcaTc/T/jo8B8rNdTC2lj2zsywmTIaNpnWRSV97+NMUTpeV8fmFRv0/BEYs45pY7yfUjNTNbHRKEVBZlKPjImNdnVtFihmgusV5z0WfeIfYYYhCvpZklRgznMK7FHQR6jw/y6OulgcpKFSboR3JHvihYFgAPTF5WuGJDkm6Ztcxz78qpijMREAdujYG0DrGDp9wYhagQh7DLxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9TGsCPBLgSvGknUGTaA1ZQbCBgPuOSKLCcLa6W7mEE=;
 b=b+3uZXYMVQKbASwjjgjrwmQnrEI6yTu77/Oa757voRJsmwm7jgvD1rPBAJg21ExIzpPwHKoHeh6wTikLOnj1UemkAxnQ68c2zG73JLGZndzusHUobYDFN4r2h5FMP94JLdGely8epAuSpdqisN+2DT1ZgCtYn+LOWHm8oX1XMxU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Thu, 21 Jan
 2021 06:32:02 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006%5]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 06:32:02 +0000
From:   qiang.zhang@windriver.com
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Release per-cpu krcp page cache when CPU going offline
Date:   Thu, 21 Jan 2021 14:49:49 +0800
Message-Id: <20210121064949.16164-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:203:b0::17) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1-vm1.wrs.com (60.247.85.82) by HK0PR03CA0101.apcprd03.prod.outlook.com (2603:1096:203:b0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 06:32:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54f68f6f-6119-40dc-68c2-08d8bdd642f4
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5008:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB50088552310C2DE0442BBEE2FFA10@SJ0PR11MB5008.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjdvbGQ8UTu902FhdGDMZn+VmP7tYJQGMyTYxd6GnprXoXZM+IwR/sQoZoDrd04wf1TOFPjzk/fr78lxJeI+Hy2kmeYvWu3p6NmCOZV69MhstiDrIJovODRUj6NDLJGbNtoICdBbaC+xCShiC5PGz9SNi8NJxnmHB0zfzvu3/4J7VSGJwroa+7HJR0C33JOK+1ESjZRMGbwZ8hQhm/teYKrj9WscsFT6VfgTgIqlPMfURJ9cNQ583lR5EAlr7Cl7imUzjUlFNNRxx1/mxYKuCTU9/JiEYBkjiB8PdzwQY70L54xfWGG4kZ9vkvy9MUuk1hGDBWigLP0AficBHgSxaE/qqsgpWbpZRoXf+Uoc/dtFLvpQEKHPqAWQCRYBfo4e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39850400004)(366004)(376002)(5660300002)(26005)(8676002)(83380400001)(956004)(16526019)(478600001)(186003)(6916009)(2906002)(36756003)(4326008)(66476007)(66556008)(2616005)(9686003)(8936002)(6486002)(6512007)(52116002)(1076003)(6506007)(6666004)(66946007)(66574015)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UjotW8rCF1CN2dyT6VYI5ioa7ZNDBV1LPwI2p4qi7jgHneTHzIThQlqKnTkf?=
 =?us-ascii?Q?qyfnSmLP/c7VYUW13pWEuhy3P44YUddWBF/Ae+E+/ylXEbOYlW1SHVL31S5y?=
 =?us-ascii?Q?nuZijloEcImtsE7Rfem4KpIpWm0dn9ZYGHDNn2wiv4HSwXtQ6p5osLmUM8fH?=
 =?us-ascii?Q?jRJ9ydoH1n/q+VY66CDPY0bEB4UYYLz+dP6wh78mlz/SVO08epi9sXyFPCV4?=
 =?us-ascii?Q?77lZktRSrdAO9AXei1mb84GucVCnbBdRD4xarkAEkxX8KTgRdA9/EX4Aynhe?=
 =?us-ascii?Q?FfyNT05vrevDOsRRFW5T0YuUuy5K4gLR1HfCW2hf3Tvg13rT9mMbScA/dRAx?=
 =?us-ascii?Q?MFsyjhxqRCD/+sDCCRunZVwMXcqIAT05uECe+htulZKohS5ormlVAdB6Aajb?=
 =?us-ascii?Q?krFXOsXc2Q65TrMgtBiXU7ug3ARUtSB7cQJVbNaXTHDyOhA1rV1SfvR60Cm4?=
 =?us-ascii?Q?kIOd9rQNdDSMsTxx9JL1X7romJXuWq41lV4vRFsZ3vX5qDKCmE1+msWIVzPa?=
 =?us-ascii?Q?6jBqGuR5ltrTTAV5ViyB9G/PnOCRmju7u7OsFi3Of9WNQ89GvEKJlN3yUsKu?=
 =?us-ascii?Q?srD2Ccy1SEooXiD/9ohPXohAJ2XK7ItjK1UvCNhtqe9UtHac5NW3miMtTWo9?=
 =?us-ascii?Q?H36hOsp2hSmaNovBSSWbFQnh/J5ZKNKaAzPxsGq9NDVWQUXKSDKnD3wkulXP?=
 =?us-ascii?Q?ccIB5xwPkcPvZmrfrv3G3kDCvQqT2SeFlQTD/Z5YV/TSLwPivD2BqAJaa18W?=
 =?us-ascii?Q?Gwc66NhjCRAihPV1GwUdFEoJHeXi9JhMxr2NItgYxV9buVNwN+hb7ARXZ8/Q?=
 =?us-ascii?Q?uv/b0Rolt7sIYKKe7zLMfou9vhaund1JSGCJmXd+blHA5xum8ZCXp2gYTHoN?=
 =?us-ascii?Q?UeCKYRVl/H0hCmHDhoh/gxZVwU7F4c267pCkeNU/ShHL3UDKQDUNcI3v50i0?=
 =?us-ascii?Q?SQ5et5N7wXlGBoWLkAqpzocLPOxLMeggSpwIj+5NrOI=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f68f6f-6119-40dc-68c2-08d8bdd642f4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 06:32:02.2986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Li0rpPw+wj3FXw92blLnea4zWZdmmFy2bsK/3xxv0n92Vcpc1VKWnoNNZ6f0o2+Kn7QVPkX2z0USCTjCFm4n/TAdh857ljILGxcCvny4C/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

If CPUs go offline, the corresponding krcp's page cache can
not be use util the CPU come back online, or maybe the CPU
will never go online again, this commit therefore free krcp's
page cache when CPUs go offline.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/rcu/tree.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e04e336bee42..2eaf6f287483 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -158,6 +158,9 @@ static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 
+static void krc_offline(unsigned int cpu, bool off);
+static void free_krc_page_cache(int cpu);
+
 /* rcuc/rcub kthread realtime priority */
 static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
 module_param(kthread_prio, int, 0444);
@@ -2457,6 +2460,9 @@ int rcutree_dead_cpu(unsigned int cpu)
 
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
+
+	krc_offline(cpu, true);
+	free_krc_page_cache(cpu);
 	return 0;
 }
 
@@ -3169,6 +3175,7 @@ struct kfree_rcu_cpu {
 
 	struct llist_head bkvcache;
 	int nr_bkv_objs;
+	bool offline;
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
@@ -3220,6 +3227,8 @@ static inline bool
 put_cached_bnode(struct kfree_rcu_cpu *krcp,
 	struct kvfree_rcu_bulk_data *bnode)
 {
+	if (krcp->offline)
+		return false;
 	// Check the limit.
 	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
 		return false;
@@ -3230,6 +3239,39 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 
 }
 
+static void krc_offline(unsigned int cpu, bool off)
+{
+	unsigned long flags;
+	struct kfree_rcu_cpu *krcp;
+
+	krcp = per_cpu_ptr(&krc, cpu);
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	if (off)
+		krcp->offline = true;
+	else
+		krcp->offline = false;
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+}
+
+static void free_krc_page_cache(int cpu)
+{
+	unsigned long flags;
+	struct kfree_rcu_cpu *krcp;
+	int i;
+	struct kvfree_rcu_bulk_data *bnode;
+
+	krcp = per_cpu_ptr(&krc, cpu);
+
+	for (i = 0; i < rcu_min_cached_objs; i++) {
+		raw_spin_lock_irqsave(&krcp->lock, flags);
+		bnode = get_cached_bnode(krcp);
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
+		if (!bnode)
+			break;
+		free_page((unsigned long)bnode);
+	}
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bhead_free or ->head_free.
@@ -3549,7 +3591,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	kasan_record_aux_stack(ptr);
 	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
 	if (!success) {
-		run_page_cache_worker(krcp);
+		if (!krcp->offline)
+			run_page_cache_worker(krcp);
 
 		if (head == NULL)
 			// Inline if kvfree_rcu(one_arg) call.
@@ -4086,6 +4129,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rcu_spawn_cpu_nocb_kthread(cpu);
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus + 1);
 
+	krc_offline(cpu, false);
 	return 0;
 }
 
@@ -4591,6 +4635,7 @@ static void __init kfree_rcu_batch_init(void)
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
+		krcp->offline = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
 		pr_err("Failed to register kfree_rcu() shrinker!\n");
-- 
2.29.2

