Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC96C433DB
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 12:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F45F64DDD
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 12:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhA1Msb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Jan 2021 07:48:31 -0500
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com ([40.107.237.70]:7008
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231383AbhA1Msa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Jan 2021 07:48:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbKQcUAkd9RIaTePq1ZAZfQh51SyirzOfiJbEPlQ4m/F8Qh+U5WCfIshCcBl4wFBimAHnoLXyHdNP9SAFUYORpNlah8zSfnUqFgX+Y3zpqs4wCr3beVfHIWrE4SP+CI+Us3GCtPytW69Pr0q3gUuqbgDIgOKdfGyTk5tgX50TQOAwixKLkSKbsrgPpYRzAFYOz5elx8BS81L3vgLdbBtDHQjvkTdHorOyDGt7VziUEMCVI9x+Ri0P7/woKOxpbYNkBI/5P1DJ8K1uP0RluE4X8OosSSdCmwB64gQi2cZCduQRng21yGKWzEbRCmmMxLniYBxY01+Y6Hi4tQiraDrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU2jx7A367zK2m85/TCsKEd2OcDpq26cvPV6cyLm7+I=;
 b=PCScsJ3//d5ohf+LLD9t3mCbHScVtWqu2vyFLbOh+VR8fpNEPj6QAjKXGG/caVcr6jmX6Iq9VoOJt7iDR9BIicEuT4Spj1OTMXQSEM1xPI/toutGfdO1OEoz7fnhxSmwONdUpZbKUNLPuqXcOjP5YRnk8NsMyCYvP6hnCYGurxXCF7HuECj+8pgWtpLzdPr4j883ZuV4LEPsee7PU9TyZDj67WWTw6ErfjweECeHKpC1xIVCmscuhwl2nLYT2d728WrHhMnaKvgM4A6IwfIodHPzorYYFSTbE/pbOQtlfXc6ksveE4d8SLVBwXSlTXmamKHqVLeln1rnwqZoowMLBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU2jx7A367zK2m85/TCsKEd2OcDpq26cvPV6cyLm7+I=;
 b=bg6rVYDSzFPXCx+5Sh+aAtsCtBTc73KK6swFo/4O+PnGChyjs79f3SqSU+8oNLLcUOmZGTV8bxyrr90wYmUd/gmJoExiAS2hrswx4uLZMkC+1TUBFOr+s7szwOFdsxeViRD3zi/8hlrJxTDbfhfnLPJtVcma08i56Vm1AelOHm4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 12:47:15 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 12:47:15 +0000
From:   qiang.zhang@windriver.com
To:     urezki@gmail.com
Cc:     paulmck@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kvfree_rcu: Release page cache under memory pressure
Date:   Thu, 28 Jan 2021 21:05:09 +0800
Message-Id: <20210128130509.35489-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:203:b0::29) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1-vm1.wrs.com (60.247.85.82) by HK0PR03CA0113.apcprd03.prod.outlook.com (2603:1096:203:b0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 12:47:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49bf4738-803c-4e63-b51c-08d8c38ad6cb
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5053:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5053309D7B05BD8491B13BF2FFBA9@SJ0PR11MB5053.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ok3wO4JV6ZqUBs1Rqw3zosCTZBjuv0SD7rpRkMm+2sP5KNTiuRDZrQP2IutrWhr+7ezHdS0xHjQp/Zdwiyeav5gFT9RD4h+lr/nTdwlPc/lVk6D+vVeg+/rh/atEsky6bbyPJsBNF6wQmBaxfA26dxoQ5T5QnT20T1UA46Z8zvo6XguUUK8e591vEU/Uho5WSe+dyoQ9QazOCEmrfSjE2nkQCsDg4FyIFLv6yn+lyCkDuyrUNfacQliPur8ztW4pcAr6mmf7wm/HoDHSTnUaPs+FWquzZyKomW4btoEuHz+q1mIt9V6Rbmbst+jAigpV5A7Q0eScORPPfgAkc9pvVJ5bgK+oXqN8JwrGAsqEOlXRUqCGC+Z+eRZZHgAqGT7uLZP+hCvf+WXjZZjB9TsqaPaJrKpa/ntBZBoGCKZ0fBTL6tAj70982BmLgqAtt+AL9bGNwnrWhijsqX3aPIg98mTbhd2J9LdgOOXUyn3H0yitnu5GTNLaQyPdBVpVwyhnkuXvTyj7Y47f4zcr+MDixQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(66476007)(6666004)(66946007)(1076003)(5660300002)(6486002)(956004)(2616005)(66556008)(52116002)(6916009)(316002)(86362001)(8676002)(2906002)(26005)(186003)(16526019)(478600001)(36756003)(83380400001)(6506007)(8936002)(9686003)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UosBjbRbldxcO211RxpunLqByyv3NQtPweAmkF4athASJ5Q0KC+CMCVOwh6O?=
 =?us-ascii?Q?meLfmSVsDXEy6pa6P8Jl5YcVYteA3rTid6i6srZQccX0MBxMtekCjtifOI+M?=
 =?us-ascii?Q?sNGumHrnmOWG5ozC/H+iqf2/c5gufoesoG+sssXZz14O6cwKCmCijx1TL832?=
 =?us-ascii?Q?1pwo0lyXRPeY/ZMD3jgQEduacJXJUP2aKyNLwnq9IMgddnOyFlO+TROQ5xZr?=
 =?us-ascii?Q?ffyJTiO/PGHPPhAgQxi6fqYlPSgisEa2S+nBbSPklywtevooSNzmly3BMxgN?=
 =?us-ascii?Q?/+3r9PYxEPgrb3Fukro2FKTLPVn4ke2ftkhPRFcNOHlVMH6V/tkt0kr5M9NS?=
 =?us-ascii?Q?PpsgNZXIt0XMTgkFJIK7beprmkYVaTXeSOnAEnRFosexyCcN1pv8uw9zsg5v?=
 =?us-ascii?Q?cjvEpUfHIa1pWVFIRw/+DAgJshZKI5xHuee7ysuyfewNeZB3oWQe9F/rBm7r?=
 =?us-ascii?Q?JWRlfLYzd1NdjsstVzhdrqOjfnyusI/OKpCPsvwvxATpapdmHkTRu3/Iy0MO?=
 =?us-ascii?Q?9/3uqMw/sqEVhqRmSAOwAn2flPp46fqQcElpbInI9ET4spxH1PpmC7ShOzpA?=
 =?us-ascii?Q?z0QX5ziZ6JNfthwkydELlE+hLD13y1rrcjOCiDXz9TO3c045yvrZyrekS5wG?=
 =?us-ascii?Q?QVvYhf/I0Ij8sc6ss/mTPBN8GUaW2x8FEcu0f8GxXaFgDP5U/KoV95v5ke8w?=
 =?us-ascii?Q?nvpgvHPiGzrrjChwO/BDt2+IS41V7OLo3PSioMgrBJtpx62UDKFfLhsTlbZh?=
 =?us-ascii?Q?BrbbVP2bnkoUtTC6jH4BnsRc57uLRyFxxlbxi1xIbqd+U91Nzw7sds5GVwpf?=
 =?us-ascii?Q?essG2fa/z+FmVvK9v0qT+xmSknFAsHNdUB82Ou1LDY6iSP3oF1riqxoAmMMM?=
 =?us-ascii?Q?+D1hvZ8nzhlA3Evb2Pm9lizztLdNYpfqrVQCCL6VgBseetXVYlqW9GZ6NnSX?=
 =?us-ascii?Q?8X+c9MLv70QoxI4ikd9hrjTjfWpjfDldHYi7YcRGbyKM6tBrMPSUok4vaOQc?=
 =?us-ascii?Q?AoeeuNwAeNUcXZBeig9TW2zPuxhelfq2XglByxU3IyUSvBtctOY/3Z0stcRK?=
 =?us-ascii?Q?M/hsk5p4?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bf4738-803c-4e63-b51c-08d8c38ad6cb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 12:47:15.2620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3R8Efqa2GhkqZR1y3Ja1YaNz+gUU7uvJDoKCWtty3SY4d/JWFtClwD8w8kHF1Pzvy6TuDQTVYhQiT1K72Ig8tlQdnBADuVIo139hE+X6ZRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
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
index c1ae1e52f638..4e1c14b12bdd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3571,17 +3571,41 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
+static inline int free_krc_page_cache(struct kfree_rcu_cpu *krcp)
+{
+	unsigned long flags;
+	struct kvfree_rcu_bulk_data *bnode;
+	int i, num = 0;
+
+	for (i = 0; i < rcu_min_cached_objs; i++) {
+		raw_spin_lock_irqsave(&krcp->lock, flags);
+		bnode = get_cached_bnode(krcp);
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
+		if (!bnode)
+			break;
+		free_page((unsigned long)bnode);
+		num++;
+	}
+
+	return num;
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
@@ -3604,6 +3628,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		else
 			raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
+		count += free_krc_page_cache(krcp);
+
 		sc->nr_to_scan -= count;
 		freed += count;
 
-- 
2.17.1

