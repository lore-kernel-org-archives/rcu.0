Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AAEC433E6
	for <rcu@archiver.kernel.org>; Thu, 11 Feb 2021 12:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CFD64E95
	for <rcu@archiver.kernel.org>; Thu, 11 Feb 2021 12:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhBKMNT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Feb 2021 07:13:19 -0500
Received: from mail-eopbgr770081.outbound.protection.outlook.com ([40.107.77.81]:47683
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231715AbhBKMLK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 Feb 2021 07:11:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSn/Khi4QzKrFJxfvuU4d+694UtEcAQgbQJ9G4fX/sMr3Jo7BiqBIaX7AtW5Yl+7w2UWgCi7edBdoCDVaAWXkZjyq/MZgRIy6UGTd0zqAZAs05I80m0JdoP0yl2eHId9dK940mfl+u/crvBJ6Ru7wKA2831GEs2eM2zMipdwqqSC8DQwhc7rq/IA+VCIxAp4PkwhmO9L9J+3337qYZ0ozoUAv/jryXDoPUhcRdIHIYfKVg3Zk0tTWsSuPG7frylMR90KDa5bKxDTzCSBaQMbHRj27CCCbkmIXQCI71qg/e/HEBrCm5ap+mSrumnQCCo/tmN3MneyXZenGR+c0vW6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6YMWnk8GoEvQ1wyORqChPHIM5L7fblm3wG/zANaArA=;
 b=hNzpHKQDn6m+GhhIPUIsVdyv9BUUo6EmXnBgI3j/+i1oSY1kIiJKjnEK1BeUGY5xbF0LmwHsocku+QLVIclvga7VU2G9kk+OjvofYHtCy6ZaQACFgTLlOnEdxDaoVL/60mcLdBSTXBCpkbM/rh0SmfgoRisBf9diMd3M7b953UimnEVgy8569oJdHoDF1L8CGAoLtVWTgQKbOpl+KNOu+BTOJFNvWGzB7AbA/M+4ZdXYocjrxSvUdPaxkqtAzFAEZyxLrRxXdru+ZynQlCNIbEWZAshosP+oOs/h8am/QGLyoZY/WYA1/SbqDhWRfJux1wBxgJ3qzBI11jNWm7QD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6YMWnk8GoEvQ1wyORqChPHIM5L7fblm3wG/zANaArA=;
 b=qRwgAZqkg3d2kso2FRVuYAGSLrPQqLZxIXL7xUQ54KW+5ea62rOAsULHW4nRZwJ4hwklftVXQkwlpBLhFy5dc1uSp9B2CvUWPzxKxBWCf3PeVUHMHSeCzTa8YwjnAI3z0/ipPqKP7todT2dgiE09MRqUjDje6QRWENyX8ArAAZQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4353.namprd11.prod.outlook.com (2603:10b6:a03:1b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Thu, 11 Feb
 2021 12:10:27 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.026; Thu, 11 Feb 2021
 12:10:27 +0000
From:   qiang.zhang@windriver.com
To:     urezki@gmail.com, paulmck@kernel.org
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] kvfree_rcu: Release page cache under memory pressure
Date:   Thu, 11 Feb 2021 20:10:12 +0800
Message-Id: <20210211121012.278203-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2409:8a02:b422:31c0:98c4:8a81:334d:be19]
X-ClientProxiedBy: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-l1.corp.ad.wrs.com (2409:8a02:b422:31c0:98c4:8a81:334d:be19) by HK2PR02CA0213.apcprd02.prod.outlook.com (2603:1096:201:20::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 12:10:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3ef2ea2-fc99-4e6f-13e2-08d8ce860462
X-MS-TrafficTypeDiagnostic: BY5PR11MB4353:
X-Microsoft-Antispam-PRVS: <BY5PR11MB43535719084E28F0C1C746C8FF8C9@BY5PR11MB4353.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXlZLrQZZWmlZV0rHUjnxe463dLOFEpf61LKcaMf4xSWh/VDjgB1Nm0FH1blx3vc0unA8HYsBgGl2LzMa0uHXPZBtC4pLvgx+evsT2dzj10XS15knQALrrppmSDOfbZKL3fH5832S8+Pnz/hHgSRxd12NfgkNH4r5vU5AD5Pvj4mrB4GeEVTD42HZO7ZGUpfTQhqzufaRurYJ1g8sUe2sa5eo12RbUdw+43ykPoqNtALS1LHAQISSLMEdu9sxHGKkH5cE/n0bRMmZJx60hUx2VGMeqO25I/ACYUMomTpxIrX7E1R//GOILDAvlytqXi/VnhGCgE9oywsaVKAdrHtEm7futwa9kuP4xN4byiibf1u9szgVqRLXdUl+rOq+Q0VGrUBJ0r8F1oZ2EMpDhKMM0IQSq5ScgL79EmkF/28v47hdqrlcq7ZohVk5a+sb4fChAUwNB+6EqB1OZut32ldLywFmJQ3PwfbdREEQJueoWq8TRW96ga6uFw6u54+hh5I+jmyOpnikWqCNqlAT6/CSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39850400004)(66946007)(16526019)(186003)(6666004)(2906002)(4326008)(66556008)(9686003)(83380400001)(36756003)(52116002)(1076003)(6512007)(6506007)(5660300002)(6486002)(66476007)(316002)(86362001)(2616005)(478600001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hK1jqHabYYMiZ7g0EekAIXjiS0in1Bt/HSAgevth1sAqlAApEJH3Z3xKbh+k?=
 =?us-ascii?Q?XqWm2n/c/yfQZm0x+ADbRRnnOITRypH/LvujyW18KTTOjczEaBSQHmmSPoks?=
 =?us-ascii?Q?YE4swsc8p2gL7JiLUrusZdSd9S3saJmWiersYuQt9HgoF4ihpS8k3YkxRkwX?=
 =?us-ascii?Q?x4uBCLHf1zo+wKPMkwP0l4oltGnr470nGes49I27tQNmWNSg5YpRhT1dNKBq?=
 =?us-ascii?Q?mViCvavJIoHjzK3dB404lm9u0Hqe/3WDnKspELGNJR3R7Xwx33aPbbPI0SS/?=
 =?us-ascii?Q?8kjM22gsL10h3tZb94EsVzPSFqkFz1iPhQ4pZVE++jW6KQN5OUuxbaFm1GO6?=
 =?us-ascii?Q?anARiS2h3YMrjmlflz6kwVdPfNcGXHEGRqDeNcpTn1blkYvYP+Mko91JPJjy?=
 =?us-ascii?Q?aMFfm6GnEh0yV3fVTTN5rCfRlMVPwVY01bPfgqe6tnApNmRtn0zZOyl536l8?=
 =?us-ascii?Q?YbFxfgv2vK9j0vloGTFkrxdNSvc/mFnXjEDTQfLhOh7HV+JjcSbdmQzSyhU8?=
 =?us-ascii?Q?AofR/WNeABQk0+sCYUw+yzha/DSaRWvqNfgbZ8DnImndFHb0rrv815aU2Utm?=
 =?us-ascii?Q?oI/BHvdXKElRFOu3eboB1a4J1hTIj+m4p6c07nlr0w9RdQx9HANJwzfsYqit?=
 =?us-ascii?Q?Vmkhr8caXQVLo+/aIH7qLgkYzByxkLKD413GytLRV2gHHjK+GhLBG/oIU0jF?=
 =?us-ascii?Q?INbdWQTMnH8iOWM3/6n/3OBIc44Gbem6YRDTZlaOVSsIZoxuCUvnXgZR3fdX?=
 =?us-ascii?Q?L2A7WRBrGX2jd8M4dHTcw04z/PUUuRqUE4L+8Gn3auncGqTjEEupcZznJu/Z?=
 =?us-ascii?Q?RuD9W4+SyDaXvwogb6GoNaxi2iAu6gffXWb1SyC+qT5gWf3GITnJ0NSfmFvh?=
 =?us-ascii?Q?hglNnfx4zlMe6NgZaNOcdT0akAJ1ySM/aAoFupKo9R0DAaeRlE/quSXUkH7r?=
 =?us-ascii?Q?VOqepjGOlif7DtXdzGRroPXmiiz3CR7Wi4vcVkXtQZwm4Wn1wfYCIQ0PxxY9?=
 =?us-ascii?Q?AFDU3BQ2N2Hw1a9ivSgNMhnXbOth38fAR4mfwreFT4tootj2CxH1jxb4bVGX?=
 =?us-ascii?Q?arcBfnpKIWLoG3DhfbdLwm1Lnygrq4ITLY/M4ikWvmDI76fyX9w9BVre4FOc?=
 =?us-ascii?Q?u+/cEL9AzE2+aCMeh/zEEEjAXS0gti6IbP/+JQpd/cGOw1gO1O39q/kMN+e4?=
 =?us-ascii?Q?3Z5BUq+8LWE1TcOoRzGEg61Qg8kIK0m1i0peOKN75V7tzqTjS/9hVOSTlHqZ?=
 =?us-ascii?Q?aUM60Y4o4NPpEk65bXvtHDa5rQfhhLC1krFUyBHf4x6dVkI3QBgTPtX/Ax//?=
 =?us-ascii?Q?FZJogE6mm4PdNgln4HJSvnRm69ZUPf9dCftXRpPuAmfmiNVrxJovxWGM2xzc?=
 =?us-ascii?Q?v6XmcsT2UVJiJAHGjSHMH/z3HLHn?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ef2ea2-fc99-4e6f-13e2-08d8ce860462
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 12:10:26.9450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50LwtLgpNJVRIDWda5c5I6nHpfbftNmacUduJpCHcPfZJbOylYP6DXzPZ7g9N33cu42Z9gaiRJJSE+aJG4BZXpDiT2l0KGiRiS+UkJfVVXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4353
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Add free per-cpu existing krcp's page cache operation in shrink callback
function, and also during shrink period, simple delay schedule fill page
work, to avoid refill page while free krcp page cache.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 v1->v4:
 During the test a page shrinker is pretty active, because of low memory
 condition. callback drains it whereas kvfree_rcu() part refill it right
 away making kind of vicious circle.
 Through Vlad Rezki suggestion, to avoid this, schedule a periodic delayed
 work with HZ, and it's easy to do that.
 v4->v5:
 change commit message and use xchg replace WRITE_ONCE()

 kernel/rcu/tree.c | 49 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c1ae1e52f638..f1fba23f5036 100644
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
@@ -3428,15 +3428,21 @@ static void fill_page_cache_func(struct work_struct *work)
 	atomic_set(&krcp->work_in_progress, 0);
 }
 
+static atomic_t backoff_page_cache_fill = ATOMIC_INIT(0);
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
+		if (atomic_xchg(&backoff_page_cache_fill, 0)) {
+			queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, HZ);
+		} else {
+			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
+				HRTIMER_MODE_REL);
+			krcp->hrtimer.function = schedule_page_work_fn;
+			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		}
 	}
 }
 
@@ -3571,19 +3577,44 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
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
 
+	atomic_set(&backoff_page_cache_fill, 1);
 	return count;
 }
 
@@ -3598,6 +3629,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count = krcp->count;
+		count += free_krc_page_cache(krcp);
+
 		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (krcp->monitor_todo)
 			kfree_rcu_drain_unlock(krcp, flags);
@@ -4574,7 +4607,7 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
-- 
2.25.1

