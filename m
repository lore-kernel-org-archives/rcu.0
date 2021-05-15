Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A666EC433ED
	for <rcu@archiver.kernel.org>; Sat, 15 May 2021 16:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82429608FE
	for <rcu@archiver.kernel.org>; Sat, 15 May 2021 16:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhEOQql (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 15 May 2021 12:46:41 -0400
Received: from mail-dm6nam12on2080.outbound.protection.outlook.com ([40.107.243.80]:18144
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230216AbhEOQqk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 15 May 2021 12:46:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9S7H0h6FGtRYbxQLaqKwOJyclIt7dTOBKuNAGZSoBbNfu5oqAp51ghlKq5o4X1+3MSLNK2cA+2yIOO6RITs2WsV+IwFzSt6KREE/5BWq962GCYuTVsZ+YAZgFsrz/CzoY0odNCyP8qSyqamz5HpObb2xuzQd2ATpZwsFUxnDpoouIa9G7nxFMddK+YKFXNOGdCrVT5OzgN/gYcdrRdoVrKCgk7kTUahUUHRvsLH3q5hw35bZgdM2FDFTYpONCG+pPKbeWws0AYNAy2xD47Y171xS8grlyK33c20BHUrNu/2GtJEd1bQdKRkKjArBzVVZbqzxX/Ah8fzbhXh9vnvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOuLb9kqqeNuI4wtusZHW5oJmGZq9YbADa0qRFwyV1Q=;
 b=VA6/TK2CCr+0g8ydgk/if1s7ZE9KJNYEHQoOR8ocaNjbzLSsMdabW+1TGHJt5JcfK8JvJ5uyp6AqkOhdZlUOfiGny3JKSWvzoJHvG1GdtvN6ym0SNWGeaABS3fZa/IKk7XLuHNL67TEBoXIUBDcGEMcAz/iKlL8XOQLH8eDLeYdTMbgA3RmyLYhWZDxY2ehk/Q/NWAbyKdYyPvN+ceksfHIjrPEMWYx0ef6R9RGmZZfTjLm144QbRlQleo5myS+hMMFF9Ked/4Y5lkARH4h48gM6r4HmW2jhQsD1gE22xajchOj8kEGVsWvIsGOWMHD5u5+uR17nhX2ekwoymb51xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOuLb9kqqeNuI4wtusZHW5oJmGZq9YbADa0qRFwyV1Q=;
 b=kpvZGOytadvNbmjfzQ8botB55uj9FnW2PoHe8L/BVRy3OiUrA3hu/ONityXup0EuOPVtThx68dHBPmVIRzjhGa1M362onZBIV3/WVNVxY4whCS3PEbNIL+8mY1sXnneM27Pd3PkmQlM+TNKsNQojjx9hpDc8JsYhvOxsn7nBb8A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB4877.namprd11.prod.outlook.com (2603:10b6:a03:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Sat, 15 May
 2021 16:45:25 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.029; Sat, 15 May 2021
 16:45:24 +0000
From:   yanfei.xu@windriver.com
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: wrong stall log when only one task blocked within RCU read-side
Date:   Sun, 16 May 2021 00:45:11 +0800
Message-Id: <20210515164511.3547618-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0055.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::19) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK0PR01CA0055.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Sat, 15 May 2021 16:45:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7a49b72-2f4f-4f28-13fa-08d917c0d649
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4877:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB48770F67EFC0B9356B34AB1BE42F9@SJ0PR11MB4877.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUEDYCTCISYg5pmLg6G4EB0sWviaoWXGSbHe9W/huZcDg6Mnd0x9VL53KVHekQ0XCIGzBEVBmPGZYf/F8mR3ccEC3NWYj+Nu5/bu5r0M0FrVam1q0O8V+590DIHb4Y/Az8IMm4ebbEVZ/CUvMie8QpymsDdJJ1LGnXbwnJrKpGvvalUr0VqTQmpjB5gsw7UZxwZspHm/ZuYJiKaW1FAjgaemjxWMAZNY1OWfjUoM3PyEnyaD36SG7WkdJ45WBAu3WeccwhuOUhka5Xg9clBF/BED9m+gBOiJosSGp0Nn1DqC3jigsfMygcHp/Mx3j8k75hT4soFgoD5xdeSLstZ3FILuP44hKiVc08XBOv5GpL2ToCxA+nNLuPWHcDXJNqv9HsTJTHTHe4ZCU/gSEGsWxqRZ2Ah6hvn8PDeOU5MNP1pJw/n2Uom+Azxjp+ijvX/n+6R3zzvzB9hCH6FOeaODnOknrfNdP6NqM17nZB2AxNwd49dc3rWEePkWFqlLCYKMITbIJkKHH8yH4FSlmB262jd48VPzQY5vjoNkvDDFG2K+ghcPQV3PXSZ3vWwkKYpzcbuocAIkFavRTL9pLZi1dRKy+vYCT04rAcl1x1kS++YOF68k7gOG8ZoDtjNuwfD6XtLRZdmRi4JE8l/eheDSzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(366004)(136003)(376002)(396003)(8936002)(66556008)(66476007)(6506007)(5660300002)(66946007)(8676002)(6666004)(956004)(52116002)(6486002)(38100700002)(6512007)(9686003)(36756003)(38350700002)(83380400001)(478600001)(15650500001)(4326008)(26005)(2616005)(16526019)(186003)(316002)(1076003)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nna2EaZGJamPm0w0HiPUThErM9aXwHTIGaiZG+yMuWVmz7s0iAAkwmlwzIr4?=
 =?us-ascii?Q?pgikaRNXH1oN29gG1MNK9ejFCG0vRdZGmSLcQcX2kE13Xx+tlb8hFQKEGlcv?=
 =?us-ascii?Q?QnE6bdoy0EoU9btJ820f7I5b9ViEuwl2d2OIhYccmsjz6bbUWlrZrGI4m05I?=
 =?us-ascii?Q?YRXHu76ukhkSioAmaLD001Eab3MpjAn8aKjtfZexXtM/yawxE8/vhXN4hOaK?=
 =?us-ascii?Q?wKn0cZcK7CsaWbxRhMQPhAyAU/abpaZXHBkGvBK2nfJC8FlwBZX5OkNe3+g1?=
 =?us-ascii?Q?QNtiyhrogrZooqq1CLKTBoKL+axdYQRRvQo+Nc338FGpwIYhf/yU2VrwLI+G?=
 =?us-ascii?Q?domlKNC2EBEj6EpAoI4KejRo9dEaLrBcaFKP7/xpYLB2du+v0bpGdLIX470i?=
 =?us-ascii?Q?qPvB7u+uVKnJWneMqYm9fGJaAfuHimPuCE/XCyZade4gFwl/yO/lXl1nt+QP?=
 =?us-ascii?Q?fioHRRGuLFvfM2aHDa3fqagNj2ZABJMErSK5GXsl/9a7OaT8jFFBu0hI6wBO?=
 =?us-ascii?Q?2pvvUuirKmjlN7+qBh+HmFMD8Uo7NtT7EmuoDVEyQzH+DsD9qA8T04VoqcaW?=
 =?us-ascii?Q?1AUxiyngop7T9YVFwj90gMNp6IO2AOVWFNUZBbvgDOuIof5DGrrCtT81URxP?=
 =?us-ascii?Q?CrgxMOvsNGbY9aMUJsp+xnK7KTHYNdpAfuUzQixWlXyMqWoXWvEiJ/YCjqXN?=
 =?us-ascii?Q?MSfSMzn+t+1mAjPpXrNPtV4Sbc2U5aJ9tNa0VdxtTTnJhF8WCqs6PL9KXbbB?=
 =?us-ascii?Q?SDTmINYkJPlxTDmfKvT/QobEkIzK/kksXXZHIm+lmd/sCIfMpKGmIzhq8MVT?=
 =?us-ascii?Q?ncimJSJ5sSOzGagLkfHpWPDVPBMqnzBnYPrlVx0RplSnwEBN9VwKdWlBUHN3?=
 =?us-ascii?Q?uXapaDycPgi2uyTfkuUN5Ue3r295bPOfI69Zhj2VSQN+G5KetIzE/r/M6emG?=
 =?us-ascii?Q?ekKCed2lMuY9a5CC+dPyGCEHqOLSvjdDJz0fpJ5cO1EYp31DOo1pmzuo/hmZ?=
 =?us-ascii?Q?U5+iVl9CzwMFpXmO1v8kytoh9dXdrYQils1QYCt3A52O803kehxpZdEYmwx5?=
 =?us-ascii?Q?A7U0zKo9225EJkLbD9x4+84HwXrR3tHuJSaSFpva6i+rREH2fcq8eDH4mL87?=
 =?us-ascii?Q?BV5QpBu+RM3OfjCjaBxo6DN9BIiN4lF4KZaPoFDXoMuBQ3h3Vrtjx2jJunC5?=
 =?us-ascii?Q?xJ6bYK7Jm1YwSQeOhezr7md4faVTfJTsgTupvkBD3S6dBJmSbyhcDCj7On32?=
 =?us-ascii?Q?BCWc5bA2WmDv9wwnPNgTS3PfBqC/l9npSYkWZvm4s7/haoavelOlbdl6EaMw?=
 =?us-ascii?Q?cioMrr5eTZUGqCEJ6xMChp44?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a49b72-2f4f-4f28-13fa-08d917c0d649
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2021 16:45:24.7897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TQbkhIo++ZGiJzVrH0TmHKo4TwWPXFbmtwOMEue1XQSTzrybNWSMpkuwsgC13sVwrsjSOlnf+8UqI0WKKmkpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4877
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

The for loop in rcu_print_task_stall() always omits the first blocked
task in RCU read-ride critical section. It will cause status of the
blocked task can't be printed and lead a wrong ndetected variable.
With the above, the wired stall log comes, All QSes seen, but qsmask
still is not zero:

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:    Tasks blocked on level-1 rcu_node (CPUs 12-23):
        (detected by 15, t=6504 jiffies, g=164777, q=9011209)
rcu: All QSes seen, last rcu_preempt kthread activity 1
(4295252379-4295252378), jiffies_till_next_fqs=1, root ->qsmask 0x2
BUG: sleeping function called from invalid context at
include/linux/uaccess.h:156
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 70613, name:
msgstress04
INFO: lockdep is turned off.
Preemption disabled at:
[<ffff8000104031a4>] create_object.isra.0+0x204/0x4b0
CPU: 15 PID: 70613 Comm: msgstress04 Kdump: loaded Not tainted
5.12.2-yoctodev-standard #1
Hardware name: Marvell OcteonTX CN96XX board (DT)
Call trace:
 dump_backtrace+0x0/0x2cc
 show_stack+0x24/0x30
 dump_stack+0x110/0x188
 ___might_sleep+0x214/0x2d0
 __might_sleep+0x7c/0xe0

Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 kernel/rcu/tree_stall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 59b95cc5cbdf..b72311d24a9f 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -280,8 +280,8 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 			break;
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	for (i--; i; i--) {
-		t = ts[i];
+	while (i) {
+		t = ts[--i];
 		if (!try_invoke_on_locked_down_task(t, check_slow_task, &rscr))
 			pr_cont(" P%d", t->pid);
 		else
-- 
2.27.0

