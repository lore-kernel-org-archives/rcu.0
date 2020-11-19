Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B50FC2D0E4
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 05:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDB22224D
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 05:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="kKF02rZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgKSFe3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Nov 2020 00:34:29 -0500
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com ([40.107.236.85]:51424
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbgKSFe3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Nov 2020 00:34:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtjmZ4jrkg0xQiqjWlhdZF2qOHQbobuhGbBZw/+xuR3cTxgZb+C5SPonguc6aNN79wia2Q/0tKKbV5Apn093+0yFHzI04crvMpuJGX74O/F93n1quLLIIFjrUoGRq4OhvUX6CeQmTmzq+/dBucdz/drzmWbJ0F/7kKN/yn2ocAq8lgx42TtpznJByuJo/qWMExCxo66Tfk5azFuO+oAAChq7tR4SebkuaqDuIQMILWU14JY/DbNR6pTxTd3ZVpIYq12eirpREam/M7kxt0IJexn7lBbFfXNJYsxtjWYTNwPWqVRZZUNd/1tfb/741iN3AKH04ouz4HCkUxq+nG06RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uViAVT20hlabuabELH0lF0l+A1SXj5fjAOUrluyKFmA=;
 b=QaF5x9ljKZgotG95Q9Php7zDqRO8sUopoJWeQip8i5mPmnvKJwxMSwabLgDuFRLZA/cMCUrigc/iuYFPrR5tb8ByoVs492gWLPQ7t3P7b2vhWrUiV8+8Hha5llStYpw3Af/dOV3l6dL3rSSOoYSb09BH/Jjc0Ho08OpABjq+IRj6xpCGvdaW6u/1Dszgl27EF5k4AhmwNoLRe9n/0b7pj2Ba2TfyuDpWk0q+OzKXi/eL6/q8feslJD3558ENvm9cJQm9Y7SZ3bAXAl6iMbYGRHs6yC1Od92RgNeplVQw+hcNJTBl1y1D+eBnR8Qb0+tKSKm//+xUgUeFbljnDFMcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uViAVT20hlabuabELH0lF0l+A1SXj5fjAOUrluyKFmA=;
 b=kKF02rZcQnt7BIwamuea+OvS6wJ7Qtui3YTjKOug0eWTV0b2TTQUf3xWaRct2iwft00DJamozlK1mcWrJbpatELnZIIx+Ob8X9/JUgB6EV6ZZ+V6X01hq7eB3Fx3HcxWRMt5AcsdWk0dfoFc89l0udTVFb41aDgM/O0NDEiBuaM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3670.namprd11.prod.outlook.com (2603:10b6:a03:f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 19 Nov
 2020 05:34:25 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7%6]) with mapi id 15.20.3564.031; Thu, 19 Nov 2020
 05:34:25 +0000
From:   qiang.zhang@windriver.com
To:     paulmck@kernel.org
Cc:     jiangshanlai@gmail.com, rostedt@goodmis.org, josh@joshtriplett.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] srcu: Remove srcu_cblist_invoking member from sdp
Date:   Thu, 19 Nov 2020 13:34:11 +0800
Message-Id: <20201119053411.11698-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:202:2::27) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK2PR0401CA0017.apcprd04.prod.outlook.com (2603:1096:202:2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 05:34:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33e3d192-c83a-475d-6a3a-08d88c4cc6a2
X-MS-TrafficTypeDiagnostic: BYAPR11MB3670:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3670A9AF01140D20B939C756FFE00@BYAPR11MB3670.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xoNAFJqfyzID2QqQXvM0bVaRm4CaCopIjeGkGICoiLVU7h7pFOY7gDIzRxrLQBWtshJ7Q78tNX6BumrhUJyfG8F+Pr/ueADOnsYDl2nzRFg9nfTNp1DAQVfl+wJbzyTpM6jzs8opZTHLdSOPMA8LS1km5beD9wN/camlVh0/8IwyFmMUMpq0F8YTYPt+2euhNa4+xS2523U8KYg9tj/+Wtg+4DxBCwPiELfzewvKe6f8X32kZ4d+9ct2w7dTC21n4Za7O4/fh6hq0rwns4H9qBbfyQ0lrGnkOO//FerrkC9Y9apshlZQ7GDM9aUQW2YeX8IGGlqzu6NcHd3N9YJmCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(39850400004)(136003)(4326008)(16526019)(52116002)(6512007)(6666004)(2906002)(36756003)(9686003)(6916009)(1076003)(26005)(186003)(8936002)(83380400001)(66946007)(66556008)(6506007)(86362001)(66476007)(8676002)(316002)(5660300002)(6486002)(956004)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Xq044X7EoBauwAA1xr2V/K2KP+fb5PzFKNeqwi3a4aiqbUFZTqe6uth+7P8ghXrg3C/dVU+kBCJlmUmmTbXFjd84PPkmdPnPjBEzhO+QN/UI/Ha6LXGwZjrQ+5C0cFMKf6cRi6+foa5V/ufoGgHhTfjtoqUvkzbhHwT3OmoSrZM+4uNNz2YV+/flJuhynj6lRFR3xrr8KC2Xo1NnjDcICfJfI+xBdFl0Kpg0E2b6DWBEKbfE3Cud4igpLtPVY87BI4jBj9q62E/zGOgUkghSpZ1Ic3Nu1ozjovhV++CfPqUvxLKR133NNNly4ZfMUlHO2YuGAnqi5tlYwg1Lpp38oV6lO4Aq6RSCd3lC6kM5i9xBkDlJjqYeTMRBsFcWTidiCGVYcExnEYPWQEaDKmGQs28/rOWea6bopv/heck3SFAdNf36NLSo8iJ8Pwue2QBfcIGinlcFn9iSqmk4ywXh8wH5qXy2vKhXszI+NMuN3v4zbxqFV4qTC3IHlW3oUeU3mxZ1H1NK3lZKnArc5/lNUIO/vsrZDRR/kMX6tYP5ql/pO/KMrt5KV6YLdjlrC1eHV7xOm7Khsko8R9h9tTmqnnhSVETOF2KNILQvpzML1HIefj9NqZXVLIADukH+O/xhz2yRiAwh/8FzXm4okadmug==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e3d192-c83a-475d-6a3a-08d88c4cc6a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 05:34:25.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMKYZL0v00teXtuD7M2fAyns+0FtM/rfJyZfn865fDwb/O0jag0lL0c1xgEn5HsYuHW61v62BUMjaj+2CY6TM/Wqxowl7d+HxTqdbp5wLWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3670
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Workqueue can ensure the multiple same sdp->work sequential
execution in rcu_gp_wq, not need srcu_cblist_invoking to
prevent concurrent execution, so remove it.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 include/linux/srcutree.h | 1 -
 kernel/rcu/srcutree.c    | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 9cfcc8a756ae..62d8312b5451 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -31,7 +31,6 @@ struct srcu_data {
 	struct rcu_segcblist srcu_cblist;	/* List of callbacks.*/
 	unsigned long srcu_gp_seq_needed;	/* Furthest future GP needed. */
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
-	bool srcu_cblist_invoking;		/* Invoking these CBs? */
 	struct timer_list delay_work;		/* Delay for CB invoking */
 	struct work_struct work;		/* Context for CB invoking. */
 	struct rcu_head srcu_barrier_head;	/* For srcu_barrier() use. */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 3c5e2806e0b9..c4d5cd2567a6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -134,7 +134,6 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
 		sdp = per_cpu_ptr(ssp->sda, cpu);
 		spin_lock_init(&ACCESS_PRIVATE(sdp, lock));
 		rcu_segcblist_init(&sdp->srcu_cblist);
-		sdp->srcu_cblist_invoking = false;
 		sdp->srcu_gp_seq_needed = ssp->srcu_gp_seq;
 		sdp->srcu_gp_seq_needed_exp = ssp->srcu_gp_seq;
 		sdp->mynode = &snp_first[cpu / levelspread[level]];
@@ -1254,14 +1253,11 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	spin_lock_irq_rcu_node(sdp);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_gp_seq));
-	if (sdp->srcu_cblist_invoking ||
-	    !rcu_segcblist_ready_cbs(&sdp->srcu_cblist)) {
+	if (!rcu_segcblist_ready_cbs(&sdp->srcu_cblist)) {
 		spin_unlock_irq_rcu_node(sdp);
 		return;  /* Someone else on the job or nothing to do. */
 	}
 
-	/* We are on the job!  Extract and invoke ready callbacks. */
-	sdp->srcu_cblist_invoking = true;
 	rcu_segcblist_extract_done_cbs(&sdp->srcu_cblist, &ready_cbs);
 	len = ready_cbs.len;
 	spin_unlock_irq_rcu_node(sdp);
@@ -1282,7 +1278,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
 				       rcu_seq_snap(&ssp->srcu_gp_seq));
-	sdp->srcu_cblist_invoking = false;
+
 	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
 	spin_unlock_irq_rcu_node(sdp);
 	if (more)
-- 
2.17.1

