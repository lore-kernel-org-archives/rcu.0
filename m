Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17777C4707A
	for <rcu@archiver.kernel.org>; Sun, 23 May 2021 18:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D996160FE4
	for <rcu@archiver.kernel.org>; Sun, 23 May 2021 18:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhEWSjt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 23 May 2021 14:39:49 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:65088 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231829AbhEWSjt (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 23 May 2021 14:39:49 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14NIbjBN027619;
        Sun, 23 May 2021 18:37:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-0064b401.pphosted.com with ESMTP id 38qk95r7r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 May 2021 18:37:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ff4QWt6EgLXoMag7XfUogVRCV4nzV9M+8xDd97ZgCWCPRSFXLTm7NDet3p4caZIY6u+Ing+y9vbtutfICGW2Cps0N1BFcAGQtd1bPg2vnfhdHhzRf8VT+AAHURq2Jj83ND8HzTBisvx8e1QYL0q/cObw79vDQ4fFUjswdYw0PwI1MHvz3iyO2UQbeSfyutq8Z70vTSe2f6IeoxgZkqvSf8neqGmZyq7Y/YZGnQ99ZVZnXs42UPq8g4mmar5r5m2ThzLhada4VqUj8KrrJt87oxMdHmO8Om7V2n8dTdvq53zM+lO/WgArJpeJE2HpL4NYqiK666LgwEzPf/DqPumviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXnVRjIq2xwXLuSnLm+T1Q0ldX4jpugSHWauBeg0URo=;
 b=GY1bPZB4dziJYkLqeAbLAh62jd8A6agr3Pd9ghq8afcir57WJJR623MZ9SE3V/CG+yXB0J/iuxWirpuHHHnRuy6AIEd+0G18YJRwJ2K+u7qWfD3lDEWwghpJ2laJ+oTyz+xE+mDwbPqwJYH0VgHjKWn+Q/X6BflvqondrS+qQAcX93ncmZYlWOAOOyKsjzPP7/mRth1EygYnwc1+2uSHLaV+ZdMf45ReirtEEeFBZHnSO41M8dIWGchMqeezIg6LtFlTQX7NAl2nPLbcciOTJRjc3YD3d9TY2ZIhKJWGEnQanMtnSO2ZQCAAZ7fVxaudVCa/fWJrQUMrqlXP8+ekhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXnVRjIq2xwXLuSnLm+T1Q0ldX4jpugSHWauBeg0URo=;
 b=GghIfve+81p0ZTBUkxdrDSr9aSH6CsZCMkmgBbHLtuUJ4s5XQl5uhevwtGbfTjlLB4kxQLPnaVlVCLdW9TTJiJvi40WKXBhAUFRQ4fFC8rk3Lw1tE8uAK48yo088pgcC+JL0tA82S4c7T5aCBveJO7w6Y+hO89iUvDhw3CdpiyY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3718.namprd11.prod.outlook.com (2603:10b6:a03:fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Sun, 23 May
 2021 18:37:41 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4150.027; Sun, 23 May 2021
 18:37:41 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: remove the task from holdout list a same place
Date:   Mon, 24 May 2021 02:37:27 +0800
Message-Id: <20210523183727.31536-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:202:2e::23) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR06CA0011.apcprd06.prod.outlook.com (2603:1096:202:2e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend Transport; Sun, 23 May 2021 18:37:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4068e622-d9c0-45b7-2e8f-08d91e19d8c1
X-MS-TrafficTypeDiagnostic: BYAPR11MB3718:
X-Microsoft-Antispam-PRVS: <BYAPR11MB371805E1640766DFA8659C6AE4279@BYAPR11MB3718.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHBVc/RZuf3Fetkl0ePP9QqGx+pE98aRidORPKPriCkkJpa7rHCCHkpuvTp7mYN2wGV31XIiXsDjtWwF2Kux54tPc4MFV2VH+zN6RRVHkIhsTaIvHQ4JHPaDQpC9b0W5Z2Uc+c5BJIFyQMZXU8IZN/JZ0UgcGy5vW2M/DJQtEU0rvtuwxRGro5B1psRi/Vn/PJT4rp+3/wDqrRVv0v9+aGpaztPr/I57Atq9gCj+C+7nb+nkdS3W7aPRlH2XVS0OV81TzCsGuMgGvg8v5zQaawlcdIXNJBKOFp4UkZLulAqrIrJoBcyvHHlTKykCncO/1YV5bP0qUqMXcGZ1KoFE2Ri5uWFJYx/GyQT/jqmryulnQOx48dCsmHhpGtRN6oRKJHqvA4dd9NH2Oe3JdPyJ7HPlGd7kshZuOWqR+GOj0d9wI+tP6boSCjInhC7TLlhzIR6va1z7KFd+15TurF0OGgOpbaRYOsxmVGobOUpBlqDZ3iK1mNZVdomDOQ1M94E3AV3U5Qz77MhXtryLediHFGyHA+U38gV+A3crKkBHrA54pSqlsTD7ofQMgPGZ0Qg58QHLDQlMi7EKeh3Gawu8zM3csJymqmjnLJ0h/xVRilhX7q1A+QpBBs6KH8znA+6pwRYaBd5IvhJx0rm44eHqLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39830400003)(136003)(396003)(376002)(366004)(38100700002)(2616005)(83380400001)(8936002)(26005)(956004)(1076003)(8676002)(38350700002)(36756003)(316002)(5660300002)(66476007)(6666004)(4326008)(478600001)(16526019)(2906002)(86362001)(6512007)(52116002)(66946007)(6506007)(44832011)(66556008)(186003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TTUdxfY8vzRy+FaxEQbjDkq6Gtj+dOyaOcRj3qz0E75cxgRnPS58vMlhxcTV?=
 =?us-ascii?Q?e+EcynIpAT/yeq+vPtJFF+5V8hVuenGP2PgXanUXurWhiXS7G8Yfdv/IgYUQ?=
 =?us-ascii?Q?XB5dIuWAQAw090ddFpQeFZUXmkn5gPEQRyJnpD62xX9KbeaytTA3Tpdya8Ko?=
 =?us-ascii?Q?nq8NhnyPfpF4hQ330TXwvLH3SuY7bZ4t1AGhL2ArEbPFZ4xQfyrSTaRZolD9?=
 =?us-ascii?Q?nSqvm3MuEbmgg55juiTv2/lin4A9Evl1rrNlyo2dOGdJx7CEy5P1KG3L0o20?=
 =?us-ascii?Q?Sey4wUPrarqw2rdBqGEfdYA0tKel/7nzV626ny8CSrCwbhjrz6WB3+taGiyn?=
 =?us-ascii?Q?BAJ4KUmFkx6dA5lqMdrLH/a9toery2H37rhbSdbJdb9fK/GwUnck2jkWu5v5?=
 =?us-ascii?Q?o2FJtyxv40TGnpphR4VXT/Nt9rj3yTMlaPMIcxuCgQ4WZPISKxH0rpMwGLl2?=
 =?us-ascii?Q?xPesbArd6fPeZ6vv9MZZ910TCAYRzzqjzs90LzMqiaAOtUAiA2U8m0H2Orl+?=
 =?us-ascii?Q?JKOPfmvX0iFootpN+YGbiSA2iIHOdqaqetJ1weljaj7k3fkE2ViTNYVc2qi3?=
 =?us-ascii?Q?ygvjQm8kQbss5q0zoLiOXMRAp4MwlUPiJaTPBXHDOErT8Jy2uMmOv+cZAaBN?=
 =?us-ascii?Q?J3Ji2o5Heh1UwrW/IBUnBWSpqxsd81LgFif/8/l/3PUIMQOGkOJJRofukcaG?=
 =?us-ascii?Q?QDIeE1NnfLQ2gYlLmIRTcwZh5kKXPj8GMgg8or/3zk4RCQJwNvlZuritQFva?=
 =?us-ascii?Q?M1rHe7m7MDS+2hW46Sex7M9EsZ93TyhdfAOZuchyh008y4wNc7H4kpYx40y+?=
 =?us-ascii?Q?Xsae0zsicX6UD/Zq+yNbvzjGXJ4YdEef47G0R2FhZin5Rpf7qIcgn9mbs6pt?=
 =?us-ascii?Q?A1VERIKz9OTTnTTWq9N/Dpg1c/Htdibf1byWmBtlcdZGHzGr0zwMp529ydkr?=
 =?us-ascii?Q?adrVomkUrQ80vEv2cetALQriOKV14e9o08OlAzd8KsBZFOKsDklAmnHFLEt0?=
 =?us-ascii?Q?Dl5YJKBMjEirtMu2rcnTb/w9wBShpS47ApcNPkTWgUs2org4ahNnPjU5lVpF?=
 =?us-ascii?Q?cSgpKiLWxe1DakaOveJKZ2pl4dkz5eITZA2uH4YVTj1oDG2XQMaEYR3aj/7W?=
 =?us-ascii?Q?GDsuC9pCCQHAdVJceLy4XHRBHG8dS79fMPKIF/eDmTeNXKg489LAe2cR7Z5p?=
 =?us-ascii?Q?wX4jQT81Xr6GRiZPInGQD7RHhAMHgsC9b/6BQQtWEgp6IEkRZMFtuaQIqv/l?=
 =?us-ascii?Q?w5WP1ZKBG2NpkHvVV6aWyesqiDSJcCWJZ6vl/Uho8qQATtU418IZ/8dqz/8U?=
 =?us-ascii?Q?/fEbtstm774J+HYnJfjJLckj?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4068e622-d9c0-45b7-2e8f-08d91e19d8c1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2021 18:37:41.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHnm90pntmk+Lv+2YMZxnhNYi/6R2Rx1pbG/nJg16ZX1jbRyv371AU7PEYwvF5uAZRby9XrJ6yzLIr9tQGdFFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3718
X-Proofpoint-GUID: AkEfiqES0rIKS9MQ6o66P899hKyNwkq-
X-Proofpoint-ORIG-GUID: AkEfiqES0rIKS9MQ6o66P899hKyNwkq-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-23_03:2021-05-20,2021-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105230139
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

trc_del_holdout() invokes put_task_struct() may cause the task_struct
is freed once the task is exsiting. If happened, we shouldn't access
the task_strcut, or it will triger a use-after-free. Hence we defer
the trc_del_holdout(), and do it in trc_wait_for_one_reader() after
checking t->trc_reader_checked.

Reported-by: syzbot+7b2b13f4943374609532@syzkaller.appspotmail.com
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 kernel/rcu/tasks.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 350ebf5051f9..d8a4367eb501 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -908,10 +908,8 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 		in_qs = likely(!t->trc_reader_nesting);
 	}
 
-	// Mark as checked.  Because this is called from the grace-period
-	// kthread, also remove the task from the holdout list.
+	// Mark as checked. Because this is called from the grace-period kthread.
 	t->trc_reader_checked = true;
-	trc_del_holdout(t);
 
 	if (in_qs)
 		return true;  // Already in quiescent state, done!!!
@@ -938,7 +936,6 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 	// The current task had better be in a quiescent state.
 	if (t == current) {
 		t->trc_reader_checked = true;
-		trc_del_holdout(t);
 		WARN_ON_ONCE(t->trc_reader_nesting);
 		return;
 	}
-- 
2.27.0

