Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C4C433B4
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 09:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037EB600CD
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 09:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhEPJaI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 May 2021 05:30:08 -0400
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com ([40.107.223.57]:17889
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231187AbhEPJaI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 May 2021 05:30:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEFhml28d2AF5h9nZonRyplFGMiErZoGsr1kWUtBfKX5kv73IxfHUn1I36BXl2JC0MsxqbMGM/TKCBWSQ/+F9wc2uI7ZtD9cTbIYKljesG/yvMhDsCe0vblBPi3x+a9s/quHTKnVeJ+MuMbhcyaawYTLgT4YFi2tsQ6rupRVPEz1L6ISW85dwRsQ9fbZCcu04BUlneTI0BNcR0sznd4Q3/E2tcuWDBvqQ2zhpvov4GkcwhTJ8bsmRCy6A2l3H2mzhrzEVTyVVzcodRf2bDh5AwPdrnO3Za0IxHw4/m7b1v/gODM8bArS9eR0RQW2BL8gTuZbiZZKz5ODnK3o6LIyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfAJ2m0H3Ek9uZJkUS6CdAzTkhHjYpgoS0JVTgLJPvk=;
 b=XoBcCcaQs5JVDsFiH4fn2si6Wsek2p9tlXRAmeoGtrcRs6Pj6ek3gw6Ut8Up4OPhzelvy/56MtlyOjEbakogwt30lr8O4RsYJZOXhehEWj87GR6nMqo3aqovSFWCCxIVB1ANUqM+/fkL7DXFWI2fiH/fzVzmoffERCsyHbVFmUaFptD5Bq3uWeOl4rlG3RWXRjC3pOHKvIh4Ah++bmkz0fWkSpgfoZjmnrm8boq5/XigU8WvBqwlz2YWEF8qP9gt7r+cqjV0c7s+usYZuCn4g4NHOBjiflKIe/ronQ+tUjf3uO9k/GunT776/yZwWeXksp+aZ7vuAk5yhLP6Cexb9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfAJ2m0H3Ek9uZJkUS6CdAzTkhHjYpgoS0JVTgLJPvk=;
 b=b9ayRVkk6qeAH17TiT7rq3jkaJMbrcYtCYnOFKQXn6r3Z5lo9sxjcQ2HU54MmlH+geEy+HQNg8e2km8gCYySlZc0HMlYTHys1TL0mVmgge6zDIv5yKwRDe/8QaKGobRUoE7rYEEc/x82eDOib6m51nXcWE58gleahDZRtKFyCHA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3221.namprd11.prod.outlook.com (2603:10b6:a03:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Sun, 16 May
 2021 09:28:51 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.029; Sun, 16 May 2021
 09:28:50 +0000
From:   yanfei.xu@windriver.com
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: fix a deadlock caused by not release rcu_node->lock
Date:   Sun, 16 May 2021 17:28:37 +0800
Message-Id: <20210516092837.3655526-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0054.apcprd04.prod.outlook.com
 (2603:1096:202:14::22) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR04CA0054.apcprd04.prod.outlook.com (2603:1096:202:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Sun, 16 May 2021 09:28:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2db402e7-b072-411e-3f57-08d9184d03ae
X-MS-TrafficTypeDiagnostic: BYAPR11MB3221:
X-Microsoft-Antispam-PRVS: <BYAPR11MB322125D60ED73EEC96357274E42E9@BYAPR11MB3221.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BC7UZl2e7eofG3jIMXmqwCqo7HTw1KtmnnYZ981G/ZznYzIgQgy+XZAXPFr+inhLF0nqQwt/xwtkOVjAmKPLMraGJ1vrigoOoJHGO5idEIo8lAqwKLz6LwNsXeh/PmKjDpTKy17eGDgGvLr7Kk1ApFDacwIqGMP0vPz/PuZoCnbnUryhSbs9gSbLutTYmAz9A0ANrDAWlv/pFZD2WFqD7wWaod7LSoKOk21EtM7g6bUPmzgogbhiHNiwOXFa+t+umTc2Vjl5kzQCnbye1I73qvUHlzCAvrIiAzNoiMKkQJmpTg9z4TVdT3UkUd0RUEZ0+HvULiw5vgvAgh3dE5ISLcftBLkbjs1hSyqepsY4J9d5vmidvcP0Ha9TrRhzEqQaWjLZ+8J+auAKTqixfGu55ZPJYw22j5XlESY3KoWNV2avt6eYnoXPYo65OuxZqavO/xRxLX7BIUF8a1pZA9YDdtfm5kSlCvX3rzBGPB9CIYdGPM61AFnCKq7KvcOjhZwiVk24RskBBiiBsO3WG6yJQXZqZEmPF0WpKOuPlV0Gg0k0iuLm50TXkizGyu8XDKMsprCA9yjxb37Z2bnOiqLaOcZucjJQLXn+2p08JbucQYzdL4m0RPPWQqoHDT3FDlRr7wAe/5RRhU6qLodQgfilbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39830400003)(396003)(1076003)(8936002)(316002)(83380400001)(186003)(8676002)(5660300002)(6486002)(4326008)(16526019)(2616005)(6666004)(66476007)(66556008)(2906002)(36756003)(478600001)(86362001)(956004)(6506007)(38100700002)(38350700002)(66946007)(26005)(52116002)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2AorSu5hxSsAf4MoAdamzQMCvr8RvyuSt8YFW8vbBZmu/aDvJGreprgU8Lr/?=
 =?us-ascii?Q?oq/MrdBTFpYdK/fqtCCRgquJ5LbMt8k/CWm51NC+wbfwPellAL4CG+R2HjMQ?=
 =?us-ascii?Q?WG86uRiPZio0ZWChqyd81LJuIwQPCVGAdYin4VUH4fBUbCEVLoDknVOYIK+c?=
 =?us-ascii?Q?PW1kJNxTFh9AFGc1Za/DhFMwRhLjQ41aIwiyKt6PdCqTnuWeG+M0GVVFzdJF?=
 =?us-ascii?Q?onqUvs6473XXYAjMI5h4EqhI+z9A1usCSiTvIZa1i6/XDfGv5edEwQPbySsi?=
 =?us-ascii?Q?YPZ3RwJyXqpKMbG8d+M1Ee17nIy5z4y1A5f4sWTuNLUwPuvHUNm9eVmC4CUN?=
 =?us-ascii?Q?z/wayOVRSnIg5dYLPOCL9GCbGim7a1LNwRp3VGJSl/lsgoIE8hzW/4LSF3O3?=
 =?us-ascii?Q?D/pNQ7/4kKZI0d3w2+JY4LQjmEt26TkLCbgFLFAMA5OLk34t9T80iHJbaeW3?=
 =?us-ascii?Q?5NE4jWLgSCEiztDdvoyn9l7eTQNmGtbCXv5bkVSZZPw5TglzNImYQ3V9g0/z?=
 =?us-ascii?Q?qTfwB11EWU+2JFPbKRjF1HnM+ZGrU9RyeSwwCEFYFb80+/gzcL0E2sXb7AED?=
 =?us-ascii?Q?MOLVGEXwQKY0/7AAWIp2eJPR8rIoPfMbWs7tiX2fIep9TV2KU4XpfF5YqS5m?=
 =?us-ascii?Q?QtxZySApQwS8PqFG9FN6Fu+IvUHW61YR909KygRD0oG3Ujo4lX9q1IrqEIXD?=
 =?us-ascii?Q?H9GSTeK8NG9ZvB3d0DfFl3XFzgvLANjCaC6cVJ4JEcGVjyAYS8xMsG1nf1cd?=
 =?us-ascii?Q?mpwgWzvWhhVqvGYv4qX59YYogonq+s0N9X6Ds1tC3OGhEDaTIPHHNB283ASM?=
 =?us-ascii?Q?xpiwi36vszIJ6Nom1WYrPB3hv6aZ7iZ+iFmgHx5FWFgsczo3Jucm3yc1D19z?=
 =?us-ascii?Q?LYEBcKc6QBKxZ483jQ5zvei96f6Ci1gGbBaLlbzyaUvfQOEMgBL1xqN1vLUM?=
 =?us-ascii?Q?/ZinA8/esqCfBUcO1FZbqQdOkCuJUVXSgerUD0icPRhH7Gn5eeqJugDvpAj0?=
 =?us-ascii?Q?Zzk+CYv5RxdCVGwvOCZ5banVouWpayTIbKMth46BLSn2m9kBA+sz2M1mxPmD?=
 =?us-ascii?Q?OhNNsFH+w4ITfG7FSppAlmTAWLg4FcsOX7pNFZ0UPKtN0VEzFWIK50X8sxvp?=
 =?us-ascii?Q?+C9Dus+g8E8ZJbzAT+xxU7GinUXbZL07A9NIXMhP+SrWJMI+dEZQMhgZBGJS?=
 =?us-ascii?Q?7gUjsvoMaAmYAgZYqjMIw60tnglwNg5dWezfhcqa0aJ2rOyGrPry0Rs4Wff/?=
 =?us-ascii?Q?ISZ3TSoforqEJw2HUsEfNrassqzNcXBHoNPDH52ZLWgV0ViCt/2w5Ei9zCR9?=
 =?us-ascii?Q?aoa3gxC4zoPko5+MzNd0qkl5?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db402e7-b072-411e-3f57-08d9184d03ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2021 09:28:50.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAlN4lomoh18kO7EYLxPHwkNZ0TO4y0+p3uucZ67LCzR2M7uOB9OK86ejjfTmun0jwmXr2rLrv7or5Xav8Rxfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3221
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

rcu_node->lock isn't released in rcu_print_task_stall() if the rcu_node
don't contain tasks which blocking the GP. However this rcu_node->lock
will be used again in rcu_dump_cpu_stacks() soon while the ndetected is
non-zero. As a result the cpu will hung by this deadlock.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 kernel/rcu/tree_stall.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b72311d24a9f..4e97c9977d1c 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -267,8 +267,10 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	struct task_struct *ts[8];
 
 	lockdep_assert_irqs_disabled();
-	if (!rcu_preempt_blocked_readers_cgp(rnp))
+	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
+		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		return 0;
+	}
 	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
 	       rnp->level, rnp->grplo, rnp->grphi);
 	t = list_entry(rnp->gp_tasks->prev,
-- 
2.27.0

