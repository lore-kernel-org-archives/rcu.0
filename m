Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D87C433E0
	for <rcu@archiver.kernel.org>; Sun,  7 Feb 2021 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E0960203
	for <rcu@archiver.kernel.org>; Sun,  7 Feb 2021 12:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBGM1p (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 7 Feb 2021 07:27:45 -0500
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com ([40.107.94.87]:36830
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229510AbhBGM1m (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 7 Feb 2021 07:27:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrEbuOXwaZxfdR3+42ABh0zHpoKCxnEAdQgIG3vtrW9Yv9WGoTOLQOtBuf2O1OVMLogfUE+uv/dsP/iCBT31glcxrrHhn0tT8E0ROi1XczRsLVRIrS4wfjIqnYnrebuvejZLkhykzsGWpERZlEDzTfssdHxAF7H9naFQNhwDDQFf5DUnu0AP+65a1jYrgHhRUI6jotDw6/TaqTmRurChcPYRtD5K6P4gPaydR8ryc3JGh/E8eCKJM51qLgyuSnhaxKA+CPe8ovTPUiqS7Ev47UrPq4k+kMa3XlAgg6/3/i2pOvl9XzIu8tO90jwcYmG7/RoGrBONx/J4Q9uqMWPtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCB7prNXs4eU0326oxzzF0EnCojI9fDNDGYG9u9DBM8=;
 b=GKZvn9gURTVZW3b1ShoHtPfzl2BXfHa2x2eUACo46vPcUPEdf6puM4a7Hq42kokrLvUZGIRgTxQxjq6zNSsHAI1QUk36kSQwVBt+okF/sBIP4ZnsowsY/J+5KLYVVUYNC8KmiENIpqV2BGfPHUZ735GvDbyJwoVSHiuKAxUkEVGA71joyW3iVkX7zIFGv8NGRNg6lvE9qutVlxlUp3Mk6GiMtlwW/pyuYk6S4kxd84iHLxZ9uCgI+8uQ9y6ZI1q71bXsYH8q2f8kjmIbK+mYs3sY6DjlytSN7oOGetz+yKBMGqNGNUrn9SHyY9Au2xBN6huAHEW2K0u3Er14nY+2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCB7prNXs4eU0326oxzzF0EnCojI9fDNDGYG9u9DBM8=;
 b=daiKFZtA4KYlTtc2miTwsynVq2DJsDk18ZIkdDhW9dzV/lYEooUMb2tHMtybiN5S5/SAK/Mi7esOFeOVWhY47G7kEQ/AO/1iZ8mNObM1Tmx+yzkVGO7Nd7bBpLRF1VLCMSAX6sPXa+p3Jx08vQDbHb03ROkPZrbwPcsLoj2OM3M=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by SJ0PR11MB4815.namprd11.prod.outlook.com (2603:10b6:a03:2dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Sun, 7 Feb
 2021 12:26:27 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.026; Sun, 7 Feb 2021
 12:26:27 +0000
From:   qiang.zhang@windriver.com
To:     urezki@gmail.com, paulmck@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] kvfree_rcu: Release page cache under memory pressure
Date:   Sun,  7 Feb 2021 20:44:32 +0800
Message-Id: <20210207124432.10143-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0057.apcprd04.prod.outlook.com
 (2603:1096:202:14::25) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1-vm1.wrs.com (60.247.85.82) by HK2PR04CA0057.apcprd04.prod.outlook.com (2603:1096:202:14::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Sun, 7 Feb 2021 12:26:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaeed43c-b4c1-4563-2339-08d8cb63972e
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4815:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB4815FB1E9C48199FC88A4CF7FFB09@SJ0PR11MB4815.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6ry+5+GbE3Mzf5XHJew4EVu94IM73yu6s2P4cERWNSnxpHwDjoKQPNc3fMc99IBS3/hUmUUxa1OsVMKhaWwMrTZElLj7Mzepts5Cqs3gB2OOId6hm6Kd2TW6aSFppNUKmdxF2RcvXsmgPiOHlZtIlphv0xnw5U/KHbj6B3TNmGZFR1fHteXELAwNtOHmZHENd6kIC9BBlZKtYTrD46hsCeYDjR+Oqjm6Yl/+mWBexEGqd31UTzuE2f1ChneXdE22pZc3D5n9ZAEi3jnajU/RMjDwsHZ9fzWWMkT/0z72GLDqkiQjiTC2A90JxsAUmxeEvyGFl8FHOzypEaVXYHLjrCRYWBhSWFcjIr0RFOTgptW2W1pwKkgkP56Oy9Q064gOEIPEwPWa/FkrbJUADHbY/EXgENzoF8tjUH0e9mFuSKJwe+RmT1QFJYYdSacX8yPDMBKubW0d6r8e/omPT8aK/Gvot496HS/IPKlTow8rZkAIGth9t/NInUCU3AmPR5Xq9uMNoD0loQ8A29Y2kKLrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39840400004)(346002)(376002)(136003)(9686003)(5660300002)(6512007)(36756003)(83380400001)(26005)(186003)(16526019)(6506007)(1076003)(6486002)(316002)(66946007)(478600001)(52116002)(8676002)(2616005)(66476007)(8936002)(4326008)(66556008)(6666004)(86362001)(956004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XTVm87hwySNcQqul3xXuag1ELQnyQmESwdNx7yUxuXQaPVxgSqypF3hBHq0d?=
 =?us-ascii?Q?ZJ+WXtOFZSF1MObLnEsG8KTCYySkZXOSeQEoMQdtWYDGPebX6zNv2B+qizWU?=
 =?us-ascii?Q?GnKaxeeZdtDXt33PyDB6Z9TVu1gipQ8hYWduZ15pZuKCrTdMUHopA7YpdDG6?=
 =?us-ascii?Q?ymxwhz5baU0sFAD+Ru558UHy1pq7MRVLCB2TO+hQxkCdHeHXUgbm6QLWVdjX?=
 =?us-ascii?Q?RcaWFY0UWnorO6UB8EfytNp0yFjUyr2tp8IHE+nnquI7Gx7jfPL+xTqK58RK?=
 =?us-ascii?Q?gPj5H/DyuiIZE0BLnRnZh+rzL028xz/jOW4+3x7/qCyMOxUgbQdGc4z22Rwk?=
 =?us-ascii?Q?i4gy/X2BfusH7S64TZv/i8ZR0IWqpZvErPp5vh8lZwXUO1Iffv+VCxPfYkl4?=
 =?us-ascii?Q?uFvdOw1lLfUktzG+rUu3HMM7BDhgQDG2Ww0ReKJKv0y2v82BRq8fFXbFh3TG?=
 =?us-ascii?Q?o0TY3r2HLNlMa5jh8AfFTk64O0WDtfCzCxCBmoWbMpP+xfhMIrpipNIjoy7h?=
 =?us-ascii?Q?r53JnDOXovSSBQlieP0V2UFjogarYsY+SdGSpDFBKTfJxWsMtZoxl2Dd8nHV?=
 =?us-ascii?Q?frvYGNq8/AyorV0zhQKn4zgYX3NBRTpC99EaeGfhEUv4g5BFT4c9OA1uYpMj?=
 =?us-ascii?Q?U7rJq/BPb8qmWV4ltMLD00BQJW4fMsD3r0rfITraZOj0DqxxctaCJI6wxHof?=
 =?us-ascii?Q?hi8fuZWzjUTku9JIqz+MwrDpGYsw/M8oBvfA6++m7R1qrrxrzkPwywvoCwoA?=
 =?us-ascii?Q?1wZUCGTxWHG7fKNPExZORij8B2/byqd9RCi5gzc+qs76+ZZsaQrn7JNBbw/+?=
 =?us-ascii?Q?rdZ7+ISliEUe0xhmwQP5PlVYSwbW/sJnTMuhtJp6KhLpq1vZPfzO+5M8Vvxa?=
 =?us-ascii?Q?D16Uplnl5tU0wU2m3dHHlLCxDR+DIEYz5sA8USruckjLC/P2lNT614lDJEbu?=
 =?us-ascii?Q?EwXyi1IKQLYM70R7WzLBRKAV5O/ag1nuM1uWwKC0D7/zjb3I85z4Q2NXE1/y?=
 =?us-ascii?Q?IpBrqvqRRf7sb4RuBRclDWMaV0/pMM+5Hn4jLGgoX2CFbLz7j5Vs+IexeqjH?=
 =?us-ascii?Q?W8IMdoe6lamEaSVAcFfreEE40/A5QAvq/JkqSF5NNVVwlx1HcjpbdoRL0d6w?=
 =?us-ascii?Q?udwXtZ214XzvOnyK/FJIRPwujXLQAQ5FnmQ/byqp6AL5Z3D5RiTz8K3Bp6BQ?=
 =?us-ascii?Q?jy/UHSrHseZAF7p+6bz9xeGWw2imsWUIVWSFOGoBlfTvq4BbcSIpJ50tf0WY?=
 =?us-ascii?Q?oVu8Abffnb4Vf7Z6wxC3tVHL9FsX7F6NvUdO1F6oFvqqBWG3xLEcFH+whDB5?=
 =?us-ascii?Q?5ipyybMcIFt4fdPXPEgXztUa?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaeed43c-b4c1-4563-2339-08d8cb63972e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2021 12:26:27.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCXJFIG1p3XIv/16nnrbil8bZ6vEMQvgaYhoBY2W0Tq02hzAKpXqjVqWy8sbAxnXNOHMZiJbQ03wGcG925DRTy8Z4IROaaE2QOzIDnoHSt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4815
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Add free per-cpu existing krcp's page cache operation, when
the system is under memory pressure.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 v1->v2->v3->v4:
 During the test a page shrinker is pretty active, because of low memory
 condition. callback drains it whereas kvfree_rcu() part refill it right
 away making kind of vicious circle.
 Through Vlad Rezki suggestion, to avoid this, schedule a periodic delayed
 work with HZ, and it's easy to do that.

 kernel/rcu/tree.c | 50 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c1ae1e52f638..f3b772eef468 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3139,7 +3139,7 @@ struct kfree_rcu_cpu {
 	bool initialized;
 	int count;
 
-	struct work_struct page_cache_work;
+	struct delayed_work page_cache_work;
 	atomic_t work_in_progress;
 	struct hrtimer hrtimer;
 
@@ -3395,7 +3395,7 @@ schedule_page_work_fn(struct hrtimer *t)
 	struct kfree_rcu_cpu *krcp =
 		container_of(t, struct kfree_rcu_cpu, hrtimer);
 
-	queue_work(system_highpri_wq, &krcp->page_cache_work);
+	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
 	return HRTIMER_NORESTART;
 }
 
@@ -3404,7 +3404,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	struct kvfree_rcu_bulk_data *bnode;
 	struct kfree_rcu_cpu *krcp =
 		container_of(work, struct kfree_rcu_cpu,
-			page_cache_work);
+			page_cache_work.work);
 	unsigned long flags;
 	bool pushed;
 	int i;
@@ -3428,15 +3428,22 @@ static void fill_page_cache_func(struct work_struct *work)
 	atomic_set(&krcp->work_in_progress, 0);
 }
 
+static bool backoff_page_cache_fill;
+
 static void
 run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 {
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
-			HRTIMER_MODE_REL);
-		krcp->hrtimer.function = schedule_page_work_fn;
-		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		if (READ_ONCE(backoff_page_cache_fill)) {
+			queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, HZ);
+			WRITE_ONCE(backoff_page_cache_fill, false);
+		} else {
+			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
+				HRTIMER_MODE_REL);
+			krcp->hrtimer.function = schedule_page_work_fn;
+			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		}
 	}
 }
 
@@ -3571,19 +3578,44 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
+static int free_krc_page_cache(struct kfree_rcu_cpu *krcp)
+{
+	unsigned long flags;
+	struct llist_node *page_list, *pos, *n;
+	int freed = 0;
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	page_list = llist_del_all(&krcp->bkvcache);
+	krcp->nr_bkv_objs = 0;
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+	llist_for_each_safe(pos, n, page_list) {
+		free_page((unsigned long)pos);
+		freed++;
+	}
+
+	return freed;
+}
+
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu;
 	unsigned long count = 0;
+	unsigned long flags;
 
 	/* Snapshot count of all CPUs */
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count += READ_ONCE(krcp->count);
+
+		raw_spin_lock_irqsave(&krcp->lock, flags);
+		count += krcp->nr_bkv_objs;
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 
+	WRITE_ONCE(backoff_page_cache_fill, true);
 	return count;
 }
 
@@ -3598,6 +3630,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count = krcp->count;
+		count += free_krc_page_cache(krcp);
+
 		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (krcp->monitor_todo)
 			kfree_rcu_drain_unlock(krcp, flags);
@@ -4574,7 +4608,7 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
-- 
2.17.1

