Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417B8C433E6
	for <rcu@archiver.kernel.org>; Sat, 30 Jan 2021 13:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F8164E10
	for <rcu@archiver.kernel.org>; Sat, 30 Jan 2021 13:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhA3NBk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 30 Jan 2021 08:01:40 -0500
Received: from mail-eopbgr680048.outbound.protection.outlook.com ([40.107.68.48]:48755
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231228AbhA3NBj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 30 Jan 2021 08:01:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESBq9lbIiFHHI8TkgS8epzxVXzr1sZ1HjLLETd9zak8dr5Lz/c9mIo7/425vk3WvmyuMBd8m5Bfg5kIaH/nfoWcKZWB//LPLIFfKrnYH2iOSRNoJRjU7jJecktctLuL70FtRqvGmnoxTMSuTSzYnyAobMIyIWENmM/K2GDgEFBfORRf2puhIxSs3mwgtyc0YfcbcbheWJdpGwYdnMA2vMp63hRXpl8zc8Ly25jhaqARE5FBiOYsi8Mafelwr7sYa7Dx6vaOcmZtVfF1RvYOjL03lWK/6Tm4znIW1GPjXpyG7wvBIuwL2b4VXyjPpkldvEDa3x25D3EZoW+GVvXDWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJiRBoN7CJQ/ETQzIalRqR5gqL72iqIiL/RKYWpu+2g=;
 b=LGtdAIakngqr3OHcN4TQbLdDPUIgQb/BUVE9hlu4k6RhKUEhrOY3gHAg1rEYRbqiLhwgWiaYF1WYfTWMgTtdWM57dpGw3JALKYmHLyOH0LVdLnxVcAw/5zhwWlMXLfive0nM5O3qokK7WEEe/082WKKx4psPrvX9G17/FmKf1HgYofpKlOIdCXZlZBA0q9FISWMyfJ7Hg7ut3mQgEP4yOZZQqyaKhDVUWMdVkCHwm1oDwgzakScQvFSDAlNe2AoQIXfCkC6UXPZiFjaylvM90lKpD31pzxqTBmRuDkadLDCuX+busPLRk7hauY6lr9RUibnOqs3KQ+GoII4S3c6lWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJiRBoN7CJQ/ETQzIalRqR5gqL72iqIiL/RKYWpu+2g=;
 b=jutWqr+oGjELeREX+QyN3JhMADcvdymEftojVmZ8WOd5kfD2ZBAUawsP4zaqZVzsT5XcChPYrROQy/E6TR12G3KVJfqs6d647tlHK2aa60R4q8Nm9zT+i08EmGX4QtJeWMHANOMbqS433p5bXE78FoTYAxN7A4b9TKplM9Io0w8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3352.namprd11.prod.outlook.com (2603:10b6:a03:1d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Sat, 30 Jan
 2021 13:00:55 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Sat, 30 Jan 2021
 13:00:54 +0000
From:   qiang.zhang@windriver.com
To:     urezki@gmail.com, paulmck@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] kvfree_rcu: Release page cache under memory pressure
Date:   Sat, 30 Jan 2021 21:18:51 +0800
Message-Id: <20210130131851.23285-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1-vm1.wrs.com (60.247.85.82) by HK0PR03CA0108.apcprd03.prod.outlook.com (2603:1096:203:b0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Sat, 30 Jan 2021 13:00:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f948e57b-fdab-40bf-ded5-08d8c51f1417
X-MS-TrafficTypeDiagnostic: BYAPR11MB3352:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3352F82C896E35C0D7B572FBFFB89@BYAPR11MB3352.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0wGtuzBiSyO31n+9BW4xM+aHM6qLFkBjJq/lTkMuaQk4SUtZYm8t2Y33JXi7vrd/hbrjZo7tXNOdt8fJT5uzXU2phMf0QYMuWYM73MfieAT+IVaIbnb5LYlkqMygOfpHK8LiV2uwrQdihrQUrRBPYiih1RA88DP53BXBrUgJlar9lX4QoFcXTi2VBh5hLOwc3KzF/IbkL8ZZwkFQGa+sbgV9l+frWFMd6SQKssmcxnt3I9L3cgydjnx/VXvlduBO4wqd63/TsRsdcaEHuivJQioBzkhR4Dw4Nn37T3OFYr9oqFH76QeXUhMKuqAKg00Yoh4qIPbzgPRCk8bPcVj34nOAkvWybGqxV6cKTfVYVezbZWl5oEzewDGYdn7JB/wGQD+pBwMrbY/34Bu36u6yGOeJ3i/4qd16WYwTBENw+IWq2AEGBJPB3jQr9fIfxgeUtvN2qoxGafI9rmgo9RDPiscgAK2CINWkGmsAp8N40Ll0xtoLV0oLrIcY/fMw80kxVq9s/hvzO1Z4cGRscpNOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(136003)(396003)(366004)(956004)(66556008)(6512007)(52116002)(26005)(9686003)(86362001)(8676002)(16526019)(2616005)(66946007)(186003)(66476007)(478600001)(83380400001)(2906002)(6486002)(5660300002)(36756003)(8936002)(316002)(6506007)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OfOfHBytxW6fC3VHPoLC/NYD9zvEsLatu4MR7A3XSNOZP/1T77CkJU3pFzp6?=
 =?us-ascii?Q?NmYb6NLem1DFYhc5UMikhei56Iy9UsY1KW83UE89YaJ4hUuzq/voXpfl7Ixt?=
 =?us-ascii?Q?onISzdmC7f5MHo0KIfrhGBg8IOZkBQUKQjSyPlDWcIRXgM1iq9PPgAAn8H6x?=
 =?us-ascii?Q?INYvCoPoGy2ThKKweQ2ScfSG1ZH2Pbf1lD81MBti9ckxojk+57G62ynoI+E1?=
 =?us-ascii?Q?Ada3/CmnqAE9Xxs4nJSyUIlTvCYM4bfishwwzOZ3Z5qlYE8rmrL1LvypXjQE?=
 =?us-ascii?Q?MxrK/J3GefjLenZu0cw+1gvHE5Ae+LSh1d5DXGI/1qqyEdg1ID6fkP2smmxm?=
 =?us-ascii?Q?ROV0qIk+PL+AHOrNAIW8su3UQq/tkUDQ1JozDCOw1UmcGc7aiT8MBqd00nLT?=
 =?us-ascii?Q?r2wwCEmF+nk8/xn+fzj3Y/BsdIg7P9f3qcWuTPoPbf4W9T0UfowpZEZVRcMa?=
 =?us-ascii?Q?r4XAdXnvTSWcIEVlfSUxBI0dNEVIP9olswNeEL27bf5Yt/zuouFYg7Zz8pF1?=
 =?us-ascii?Q?Nfas1vNsuZP49hCUrJYL4HSl+Ysgn7ut2X1yJi7hNkJjrZu/eOAKXcxxWYrF?=
 =?us-ascii?Q?DMNhCHGnITCqRE8T22q/MI/430E0GaH/G7SrprAU46a/40Luh0SrMEVenZ/v?=
 =?us-ascii?Q?dkfTsfazPKylXB1RA75g++Udbye9ixuhGsnAvFO935EjepV74LVBuCkk8X1k?=
 =?us-ascii?Q?Ue91wpJgmwux9sxIAfQhzeRjCR4tMlhRJWYOtsoGsN56u3n4stLREoziFlIB?=
 =?us-ascii?Q?7OT4ty8cIqeBpINOSJu3m21HMM9g9l+TwmUxxe1WlGdo/iVzYpobu/KTfetK?=
 =?us-ascii?Q?fwmUR62xFkWEonDRCGh2Lx05RVC7Nt7oIc7wNxkiKaA4UgZLita0c/tBIdOP?=
 =?us-ascii?Q?S4v01JH4v8ViQnOiaT1susAZUOAX2LepUgUPMW/RcgQFoloXfiTBD6kpx6Cx?=
 =?us-ascii?Q?4WmIbcJtBgUAzQghQqiJXdhyp6jmABUgBs+x7cokd15636VukJ9sX6/izuFA?=
 =?us-ascii?Q?l1Vr25pk8KYURQV3rchO5EbnxYa4zOCpiwHNFKFPKQqGagCXgv5TMsU3d3er?=
 =?us-ascii?Q?4lEaWRZG?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f948e57b-fdab-40bf-ded5-08d8c51f1417
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 13:00:54.7840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T35+FNocrNr6Fm3RSQUfS1PO9EpNtkyNcPFjRkrZ6VPJQzYSHoq8gJOo5oKx9M2e2hXK9hc4/CO1SI3UQeTfrBgwlr8oBYrsncKTaRXZ0rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3352
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Add free per-cpu existing krcp's page cache operation, when
the system is under memory pressure.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/rcu/tree.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c1ae1e52f638..644b0f3c7b9f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3571,17 +3571,41 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
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
 
 	return count;
@@ -3598,6 +3622,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count = krcp->count;
+		count += free_krc_page_cache(krcp);
+
 		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (krcp->monitor_todo)
 			kfree_rcu_drain_unlock(krcp, flags);
-- 
2.17.1

