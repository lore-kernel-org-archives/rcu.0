Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF01C47082
	for <rcu@archiver.kernel.org>; Wed, 26 May 2021 03:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1EE61437
	for <rcu@archiver.kernel.org>; Wed, 26 May 2021 03:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhEZDXk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 May 2021 23:23:40 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:44576 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231614AbhEZDXj (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 25 May 2021 23:23:39 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14Q3LHe9015040;
        Wed, 26 May 2021 03:21:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-0064b401.pphosted.com with ESMTP id 38re2qh8dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 03:21:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7pCnBzJbVi2CEMKeJEyArdR0wzSDrDef6ZnZrOcZOvA2ucT5yn1W0F31oo9l7tzeROoHfMMMbOFPLYobKzOuJQgO5zLlpcu0vu60zYChZSQ8Mdehp7YJH669cUeCgb+iyb23Jy+TkoT2md1ICauB2tcOddK3oY0ELqVvGoml4uyLHgFVs0ty2uPBKdio9/bYm7gqHoJpyE6fs84uw8EYtgpp4jY5D4Aj0S9X9URYC4Xp5rcrjb8wPXroazOJDfYYOAIFzxjP/jr1adnbddNN/AQi2Ve75NmJXwCgoYdQJVwP5u78tY2M0BxirpuexJDmjD2rXjbp3wBP+gOuFLzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jWlSe816fWnOwwVlp1UFwOFSapjtRJI7yuCXxP6Rjk=;
 b=JviHgscy8+dmu8rY6wKKcsL4u4C1x9FGo9JCD82e8J7ELkOAskP1epQzx3RpyZ+cM3BHmkLFin+S4DGDxr4bzQ2K7tgKU+Csm6CDFhMA4gxrJBPVxHdJWvKkSokH3sGYFNnHXI1FVFCKMIeia2OvojUeZKfycCfFg1PrIA0A9H/gC0IawEVGMboAkqYXrBLif3eMdVdtSfnPapw3758a4EutvGMSsxAy5h1lwiFTU1lIQrzKRKoQzGB3bQpNnqJsWbhheTptBN7MFN8RjoHbDRs5EnDTWl+1IwCEkJAtOPYfcepYFYo1bFzR7g3lDjQCVog1HNs7e4OuBVGytExy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jWlSe816fWnOwwVlp1UFwOFSapjtRJI7yuCXxP6Rjk=;
 b=GjTzDjS3k01D8e7vqO9Eu0j0msbpgnBcYWWdOCNSVoLg8TvCQr8mTFpqwnV3Cx6p1gBS48sL0QP41u9Tr0HWfx705jxqMOl3ESmIfFBprfbCUNz6LQeKy09i8NWZjGhJ56Rxi99+WovbS72/Ellf+GBsq2lNRFfyC4LzWpduLRA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4306.namprd11.prod.outlook.com (2603:10b6:a03:1bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 03:21:14 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 03:21:14 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org,
        syzbot+7b2b13f4943374609532@syzkaller.appspotmail.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu-tasks: Fix an use-after-free when grace-period kthread touch the task_strcut
Date:   Wed, 26 May 2021 11:20:55 +0800
Message-Id: <20210526032055.2927345-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:202:2::27) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR0401CA0017.apcprd04.prod.outlook.com (2603:1096:202:2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 03:21:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4794280b-6082-40be-7efd-08d91ff550fd
X-MS-TrafficTypeDiagnostic: BY5PR11MB4306:
X-Microsoft-Antispam-PRVS: <BY5PR11MB43060E3B5A4F17F0DD23763BE4249@BY5PR11MB4306.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2q0y9Gt9JTx9htxhwt/MpwBBlkuXOVMvmXTA3mC6IGukOYf7My50eWoegBb5l+646gywb7Sft7s4E9TVzUshlETLw7cgbj/UJSQKT1Z8Xc1aWOz124zBtRmsd9YDURUr2Y9fQAHPjwMLZLa4QdVntYMRGDkIIC+bvIgATBX3mBAx1j8OKg22BBWzmTH95ie4kHE8Fm0NJIv0dpNSLqW8pinqr6K5Pl4V4oCl+wQ/hE0+L2gioCBDyyuPPNDvG1A869j4Dehyd797U98l1T1bOx1LXMdcd8m61/kbhNIA1qoUCJxUo1mkpRu78snlRavRpqAh+i3WdqnVaMjao+9nbisp2/Q1GUN2piUEc7IzVP26kD4yjaorK+AAHXmITGIB9ac5+fDfXU7JCCIsHc7hMoyM9rqZ8PS2SqIJ2mHbVxkdX6+Qprnady6KTT2LjWdVfZMNDD9eYD/ggRjrRwV6MUJhyFm20IPPI65tN7DE8uU2b4rKWFZueztYuiQqh5M9qP+RTGdL1xX5buObS1rLJVV5baVYXkea4Gh1TdcmWWKWMlJl6CVwhGKdAy3yAD8tuKlGQZTWOxxTyDCxOhumR2/Gf7uX8B1l5+B0W2mdHCZp4WaSqOO3XTq08C39/McsFaNAZrdZ+6SjmeeBnzq4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(39850400004)(376002)(38100700002)(2616005)(83380400001)(6506007)(1076003)(66556008)(956004)(36756003)(8936002)(8676002)(38350700002)(66476007)(26005)(6666004)(2906002)(478600001)(6512007)(86362001)(4326008)(66946007)(5660300002)(52116002)(44832011)(316002)(16526019)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nxrUP3142ZikmpE7pFgAFrtagS3H6st9Zlmsc4KPh2HjrepqIxNPw2UjjPTM?=
 =?us-ascii?Q?2e6SxdLlEiSsIlW1HwMq1MhQaWakX9n6WmOOpRR+NcB0uZfMFyfY89IeR9UL?=
 =?us-ascii?Q?dlX+WABQ0Pw98dIMXzdlIU/X8pt3bw6IdoeQeziN2mTGYnRKik4WNYDVhwsf?=
 =?us-ascii?Q?CTlyEG35Tbndp30xRAS3WfXZERm0SG8bvghCQcC8lhTI/m2ratqFxezqlv0n?=
 =?us-ascii?Q?Wcwxk31WDD0GiVdjd9psAbeSx2CVB9M9/ZAV+C7gliuHVGNg28ZKiWkHE1Y0?=
 =?us-ascii?Q?lBkbmG1s42y6ZrrGjigqqTlizJBQtPn9zabN7rrCXGBn/U0KhxKcXkgixs5J?=
 =?us-ascii?Q?LQxghnwLX5JYCWQPrPUog9SAE0DRtSTf+C1vQIgOlU5sA1i7nZ/YMV4NijYi?=
 =?us-ascii?Q?PkT+u5tIvlkFTwD0FmMwRYXoY5qbtUHMnb/qAJJq6FIspWraVoEVhEJ4Myah?=
 =?us-ascii?Q?s0j7eV/Gi97tHXB06NNRX6XckCiNYjPgO/sGalLAM4jNto+SFQaJQhINWBMx?=
 =?us-ascii?Q?jxYfas2Y7bOfE16BYukn6G6D8Ll+qjQjaAYO/2tZSnyUpnIOiyP3ClC2F1Tg?=
 =?us-ascii?Q?B2hywsF2QkrILs9n3P5ALycjSoV6oWUF7r+TkJma+vhl1AaVWktkl19r5wo8?=
 =?us-ascii?Q?oZ8YnvnRepTqZp5sLAvrSdCeoBCzFwEaN4NgJaW5ILpbVI2b+w5audMtD2eg?=
 =?us-ascii?Q?dzKECfMDccPEtFdGaYyKKzJemNRnN11q3+k79P9sUx2voFs7hVEHoQmVk6fk?=
 =?us-ascii?Q?xE+yvsG2OhK7jYAJvPhMZdz3mQ/l1lGhUPElgxJVI9cvsJDpmYczp0F9BJVu?=
 =?us-ascii?Q?hZiDR0STZQ4ex9dOPV3/WU1MvAmoLXFK8gRvTdxSuU7GwIFKD5u4di7P2vsn?=
 =?us-ascii?Q?VzrWHx1/7l3xoYOI6HW/Qv8zgkkQ5kaNL/NPmFe87VEdliLfoPVVBB246Tf6?=
 =?us-ascii?Q?jyFWvjJBzJrM9WGeqrsm7bLg/VZmI/2ir4eckJZhvaNi5xp3huEZYLVK3qGq?=
 =?us-ascii?Q?tT6Q3v7SYYS8r0W8DOaXWOQHuqnoTaddQv6hc20163CW7itke3/fIbqq6leK?=
 =?us-ascii?Q?0R8vXNfvrmSatz129GE2NxEt/+HFxL+LYw8JOPVsjEXlqsYIzq/DJwoJ7SoV?=
 =?us-ascii?Q?vMItGLGsKv1PcvdTY6gpXuCVvWH+v0Pa4iRg9osk/I7MIjOh+/8qD13L89cj?=
 =?us-ascii?Q?eqLcxYU/k4WwzlHYZaEwHV5P5uLtgskw9PouBhwp+wULHxRXbxGP8Xxr575o?=
 =?us-ascii?Q?RpXljnc79Nfs0qQZZUBt6ySAJ5i1OmwjY+H9sgUbqpQvUmaYm72Rg4AV3iLh?=
 =?us-ascii?Q?NMS8FDu7Jnm2nYL59TWyhq+v?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4794280b-6082-40be-7efd-08d91ff550fd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 03:21:14.0582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGRq14Bz5/WN3fZC3JrehLfWMlmo9sZ26nMIO5CWp5vJU0gc0LUIZzUs+kSV27XYs9bpO53iWNg3ClHSTKo9YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4306
X-Proofpoint-GUID: ZiV6zyggPEL578kf2BtZGcA2oT_griE1
X-Proofpoint-ORIG-GUID: ZiV6zyggPEL578kf2BtZGcA2oT_griE1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_02:2021-05-25,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260021
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

trc_del_holdout() invokes put_task_struct() may cause the task_struct
is freed once the task is exiting. If happened, then we shouldn't touch
the task_strcut, or it will triger an use-after-free. Here we only mark
it as checked, and grace-period kthread will romove it from holdout
list.

        CPU0                                        CPU1
trc_add_holdout(t, bhp)
//t->usage==2
......
                                       ......
                                       release_task
                                         ->put_task_struct_rcu_user
                                           ->delayed_put_task_struct
                                             ......
                                             ->put_task_struct(t)
                                             //t->usage==1

check_all_holdout_tasks_trace
  ->trc_wait_for_one_reader
    ->get_task_struct
    ->try_invoke_on_locked_down_task(trc_inspect_reader)
      ->trc_del_holdout
    ->put_task_struct(t)
  //t->usage==0 and task_struct freed
  ->READ_ONCE(t->trc_reader_checked)
  //ops, t had been freed.

BTW, do the same thing in trc_wait_for_one_reader() when the task is a
current running task even if it is safe.

Reported-by: syzbot+7b2b13f4943374609532@syzkaller.appspotmail.com
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
v1->v2:
1. improve the commit messages.
2. change the comments in codes.

 kernel/rcu/tasks.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 36607551f966..2303cb131367 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -872,10 +872,9 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 		in_qs = likely(!t->trc_reader_nesting);
 	}
 
-	// Mark as checked.  Because this is called from the grace-period
-	// kthread, also remove the task from the holdout list.
+	// Mark as checked so that the grace-period kthread will
+	// remove it from the holdout list.
 	t->trc_reader_checked = true;
-	trc_del_holdout(t);
 
 	if (in_qs)
 		return true;  // Already in quiescent state, done!!!
@@ -899,10 +898,11 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 	if (smp_load_acquire(&t->trc_ipi_to_cpu) != -1) // Order IPI
 		return;
 
-	// The current task had better be in a quiescent state.
+	// The current task had better be in a quiescent state, and
+	// mark as checked so that the grace-period kthread will
+	// remove it from the holdout list.
 	if (t == current) {
 		t->trc_reader_checked = true;
-		trc_del_holdout(t);
 		WARN_ON_ONCE(t->trc_reader_nesting);
 		return;
 	}
-- 
2.27.0

