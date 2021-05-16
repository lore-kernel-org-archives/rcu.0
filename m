Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1022C433B4
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 09:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BB261004
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 09:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhEPJvn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 May 2021 05:51:43 -0400
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com ([40.107.92.72]:26848
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230233AbhEPJvn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 May 2021 05:51:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvQO986aLi/W9bnvIQUi+TfaSCkalqiPukEkbEYtHr9LuDkczztEEdukPg/ZUVadRbWKGo0XKR8jnYeYCg5R2shDm+G3NsNRiBtMzzSSE0EDjMALBL/iAx0TF8IgizKZy1KCDBWwLO6CGeaNNKr9bPL7OjU232bODG3yzLQXS41Iennz+8bQADVZLFkvVqXdcTVNL6PN87C1KcEbtaAGBxBy7WEVwIZ6omVFjEtFJFWhfd+PEuz6VN8nDwffZm5HX7WwQ3PsstQYPjENC4c6l7D7WutsjwGgCmRDV+vXpuRGOyFT30EF77zgjvF1XTU84/zvGyzW2wXqCFKxrkaWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI1cD4R5TvOLlh6FG6A2yG7lGhov+b0Xi6RIKPFjqNU=;
 b=bbE7lRqiPY8Q84TbVNnUqzOG0QmKbj9mK+L5EimycwNZ3XElw+O80S/7O2UXOlpZOZjF4T6cHUqGgituLMyggij6EE0s36DB9ouDuxNbK/pwWNeexJuYLdeduhGgDDZwDI8tGwP2qmGQ+rOeoRrQwASN8YlOrM+vDRBLEIjNKBz4ud3gwlfauOnL1KQpbjuMBiwlCNFo+Ckv0M/VU1rSqGnqIJLGKbU5vbcl2GvcscKknGTa/4pui9P2aJdogcKZOBTOOT5nVBDJcwx7jT5uOXvOi3JHxTX7EWnPKfcCPB952iufdR39LglckhnM9q6GSV6fWS66KqS6MYgJFuGBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI1cD4R5TvOLlh6FG6A2yG7lGhov+b0Xi6RIKPFjqNU=;
 b=e4ShCSi3X1WYn9eXSRMy0tNtxP8ui6IFTpAtLDercjbj+SRr5GIeUw8NwCxyT1E6r4DtQ9uUdziDcYRUhMFJM3U5fPFRgbQPSC62E6xH8PXoY4nnnU7uwez/Vxz3vrc8IPj3UaYhSih4Wm7nmO3efpqXB4F44Efnrkb3uxJImcE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3671.namprd11.prod.outlook.com (2603:10b6:a03:b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Sun, 16 May
 2021 09:50:24 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.029; Sun, 16 May 2021
 09:50:24 +0000
From:   yanfei.xu@windriver.com
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu: fix a deadlock caused by not release rcu_node->lock
Date:   Sun, 16 May 2021 17:50:10 +0800
Message-Id: <20210516095010.3657134-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0186.apcprd02.prod.outlook.com (2603:1096:201:21::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.35 via Frontend Transport; Sun, 16 May 2021 09:50:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ea4b137-de71-460a-4879-08d9185006ea
X-MS-TrafficTypeDiagnostic: BYAPR11MB3671:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3671AA59006D6B7CEC39FBD7E42E9@BYAPR11MB3671.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KY+BRZ1HPtOonaNHhrq58A+bMA22QCOQ4LQiwqdpqDtEQh4zEx2OY2lwadzR5iWIsyz0YMZnC7uR9Ao6Nnxk0jiqot3CQTlbQ6wXVWukos12ATEaOIFbHHXdZGClQw5wNNgGqb+J1hm4Q38XH7HRHgqE5r1pmb3DxoFONuzIl66I03e/2YG7eqw1tbT9xHunoX5dH+GRrdYOB+uHqVUHCAE/655h/YnzBgzawVUbJgCAW5d1LebWptm3qU1a31ZFMmie1PUxzVAKCDJfsC4dfp18hhe1pyDGxldFLQF7oZvW6pfc4qlN8+sN6b6NVHMhW5bdDK32OoG3yiobqHaZ0YEKF/82dYpRQ0Xuu0cjittbFHZ9tXb11b1lAGlO6Utqbzp5BbI3pHIGpNX6+WC+ny7RDPxCpF92plK7nzgD+bhZG/Vo3gZSMJWA9Nf/FyeWwMr+kQNuFbql8E8QZRnlQTNxM9V5/HGTusxIr+auFML0JcNQQf8wwzxz/+DEqb2YlwO2R0xB1ePAXpv9TPTVa+68AIe2mKrdhTqectYGovcDQcLbbgk4nP5d0vxH3tLkpN6EeR8dKpbTNga5m7wNoh/T3BcRjfXZNpfbeH85ca2KAcYDb8SNhrc43dlmwu6L2SVtNLbxZi7jEscXF6ZY/O7iBTR1DsK8rMjEVNzQtk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(39830400003)(396003)(83380400001)(6506007)(9686003)(6512007)(8936002)(66556008)(66476007)(66946007)(956004)(2616005)(4326008)(52116002)(36756003)(316002)(26005)(6486002)(2906002)(6666004)(38100700002)(38350700002)(8676002)(5660300002)(186003)(16526019)(1076003)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jxsxHJHjyR3mn4/bTcaAJHvcGF9NY9WtVwRhOkFUKyfyNQGqIB3I6VfvZxqx?=
 =?us-ascii?Q?9WNVmTCX3nvqjYmeEZI/5s1buNCK7xVGtMgU/vA6RH6unZQwj6BKWrQ31GAu?=
 =?us-ascii?Q?UuZEvGWxLBMtc2Mu5ln7kQE4GB17mxnP2Hvc9WQtnS8of3LYaIaxoGlXVYmS?=
 =?us-ascii?Q?TVx1mQzMrOm46n0cGSwcQbwTb0cU8uT8xPr2FWiXocXROkFrd1wB5SC/6HQP?=
 =?us-ascii?Q?tdwl/t30scoD8asmQQ5sKWmKZpiFfkHm8jAdmbP5QQuTayPDEMOErgnXyKOF?=
 =?us-ascii?Q?Ks/tyh1qqshjhEvxxW8vi9eWg3TwLdqth4ihUJmAR4V8WTnh4WWWYfsTG01h?=
 =?us-ascii?Q?zVFctO4aQsM4bJzXbnxGZilctXDEoSG2PZh3Qk+aJHMUAGmShUsPvlxds/Ds?=
 =?us-ascii?Q?bT08y7KHWLQ/mw08yc+tvAnaYBFkanL7Fuibl7/RuAk3+1Ga8julDdnUwA61?=
 =?us-ascii?Q?7Tl787bY0v4f+/bajZUVPd+MVoeqbnsevw9jGwlf+f2SETyIt1gUWp4hSDI0?=
 =?us-ascii?Q?PKyNHqDgLKlLVxfwY+hyZYzxH4wR1xsAOOfPuJboNM6ybNGT2Cr+vuL8ySx+?=
 =?us-ascii?Q?lhJ8TDBUp3w30x/IDgkJTLFRwtt0F2N0bcQapRJBNwg9xa/64dvbFjb5fMPn?=
 =?us-ascii?Q?wCsjpu1QvnkVZXCQO/D4g8/CDVrH9XKVRcvPNG7aOLlgfVU4su3L7fcykBzK?=
 =?us-ascii?Q?bX+JONMs/XlHiRqIUio6EkXIl+FCeLiXtSAzsDY79FiuZR01Ti09Lwbh0jPV?=
 =?us-ascii?Q?cQhpW5qhV2E9h3t0WfqOEGXvnspuVQHoZWjGrqVRI7N1NenawJc2GQMWnKna?=
 =?us-ascii?Q?AlOn1olx/GZDGKH0sNCTkJCgLSAd6SVSmejOn+PxTS25QeMExWDDFuH43j2V?=
 =?us-ascii?Q?SSqnjayz37TGdZUEfGkBI4PMWmSNV47aL95YQEqpMhrdJKlwtqmEFgaEQYOU?=
 =?us-ascii?Q?uiLzY9iY0gMxl5rRxYztMirdklbru6RwBZ+oQ+EyaqQWZCzriMXcVHdigTxZ?=
 =?us-ascii?Q?t5UDvTlRb71tLRiUTAsotmq7NpJLD4rNs6X3/ajhnT/6tPcJFWdY6zSJW28T?=
 =?us-ascii?Q?G5taMj8S3U82nhEdD9xhvUU3CvopUFeanZCPn2rcTqXeXhfZ42/bvcZ+uj6M?=
 =?us-ascii?Q?Vyb2uQQNNM+Ga2WploDD8vPNsga4W7NYWXZwWsAAhfV2fyAkiG41V6B3dBUU?=
 =?us-ascii?Q?r01GDu9lWWgzkA52ztbiSmd1jaNuPZ+ZPZBKU7TUgTTcsHhC6s3vK3u6K4I+?=
 =?us-ascii?Q?GNkyirsLX2DFf4dQ1J6IOFhBLbUGBadQ7wdwlqTY4Sw1VjV2/JUlnuwFjfLn?=
 =?us-ascii?Q?0jqcW0cAiRspBXzQ/L3kNxVz?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea4b137-de71-460a-4879-08d9185006ea
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2021 09:50:24.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzxIOp85DAwk3w9n1DCXtx4ndIOHfqtZ3Dj1ig2E+q+e4+5uwO8KiQvVGhskKYabdcN2JEAF1Ht6NZW8Afz9UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3671
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

rcu_node->lock isn't released in rcu_print_task_stall() if the rcu_node
don't contain tasks which blocking the GP. However this rcu_node->lock
will be used again in rcu_dump_cpu_stacks() soon while the ndetected is
non-zero. As a result the cpu will hung by this deadlock.

Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
v1->v2:
    1.change the lock function to unlock function.
    2.add fixes tag.

 kernel/rcu/tree_stall.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b72311d24a9f..b09a7140ef77 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -267,8 +267,10 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	struct task_struct *ts[8];
 
 	lockdep_assert_irqs_disabled();
-	if (!rcu_preempt_blocked_readers_cgp(rnp))
+	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return 0;
+	}
 	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
 	       rnp->level, rnp->grplo, rnp->grphi);
 	t = list_entry(rnp->gp_tasks->prev,
-- 
2.27.0

