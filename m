Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE8CC2B9F4
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 10:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0668613BE
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 10:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFVKk1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Jun 2021 06:40:27 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:10404 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbhFVKk1 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 22 Jun 2021 06:40:27 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MAbBSX006275;
        Tue, 22 Jun 2021 10:37:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-0064b401.pphosted.com with ESMTP id 39bdsc80j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 10:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA92U03ikkhd9l7dtpkQPEuksfqake8WNpa5O85JOwhPhRRtA45B9kG6obQa+wy5HZiePmFldCAjZc4YDxAD6FfrO3PgqoUeSMhDbNEVab4OUKcHdFQM9OnkD3GOLI4MMNxyvLWNJZIIW+fhFqx0JedoMdq2nYPnJjuMSgPh2Xc2ggw9q2JuECMS3h3I4MsY0EiiBc8raOB/Ei3vPCcsqa7jWORB6HoCoN8ssUesDlpjAsGoz1y3SU05dWofABtYTqdLmnnOwg1x7pT2vwC4qZAIf5CFKvVEtybKLingwt5UjMXYtkBveKTwIO9j9AX3EYlECZG3KJCnNDiB8Kuk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhXqIUW1qqJYfPNMMYDG6p/EnQmdMj2GGe1XBubAB8Q=;
 b=SMa/YqtLWjz5WEWf/pNHBM6VR2yEb52mA8he5WgdvqN+P1wG8NS3maMbzRi0aIac5+qPcPevpdls7t9ABJI5W9T0pYjII4PQPW27xQ58oLeHmU4tsTtmxFqChdUChthImUMdzxy7iyVrj7ggHu/Q/OFE7TJOgWlbpDcBn0IlFbe/3vzTQpTHBknFS7QiPW/RfX5Ikf2/kcLQzf9NSmYlkPbQpz84K9qmGj0sC5hHd1iRz4HUaaWyg8ZO673woIlKVVJpLvugcT14/4PdaM2GgiMansDYmol7mAglpX2kVZ23j1KDjIjmpC2dbhoncfJ7OvFKftK9ZmyTuh20NIC9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhXqIUW1qqJYfPNMMYDG6p/EnQmdMj2GGe1XBubAB8Q=;
 b=jdhmi/8kt2+LK2YVpIozJrC5k4kFNf6PFBw8hVcN9ExOMcx7o9FV+0iqdNrm0wSP1qS/XoMtzEBY0BhhqoYgQH19AT6yf2j1GzO8XXk3ySEZs445CEoErWpmR+CK0LhKPqXY6BM52XwNTI944PiR+fCjhZwFTn1KkuBO+u+qfLc=
Authentication-Results: stgolabs.net; dkim=none (message not signed)
 header.d=none;stgolabs.net; dmarc=none action=none header.from=windriver.com;
Received: from SN6PR11MB3309.namprd11.prod.outlook.com (2603:10b6:805:bd::14)
 by SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 10:37:23 +0000
Received: from SN6PR11MB3309.namprd11.prod.outlook.com
 ([fe80::a170:9c84:bd22:f77c]) by SN6PR11MB3309.namprd11.prod.outlook.com
 ([fe80::a170:9c84:bd22:f77c%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 10:37:23 +0000
From:   "Jiangong.Han" <jiangong.han@windriver.com>
To:     dave@stgolabs.net, paulmck@kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        "Jiangong.Han" <jiangong.han@windriver.com>
Subject: [PATCH] rcu-scale: rcu-scale returns one less than the real number of gps in the dmesg report.
Date:   Tue, 22 Jun 2021 18:37:08 +0800
Message-Id: <20210622103708.16814-1-jiangong.han@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0016.apcprd03.prod.outlook.com
 (2603:1096:203:c8::21) To SN6PR11MB3309.namprd11.prod.outlook.com
 (2603:10b6:805:bd::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-jhan2-d1.wrs.com (60.247.85.82) by HKAPR03CA0016.apcprd03.prod.outlook.com (2603:1096:203:c8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Tue, 22 Jun 2021 10:37:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c0be7b-67b2-4a57-46bc-08d93569b88d
X-MS-TrafficTypeDiagnostic: SA2PR11MB5036:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB5036DB7553CEF936C5FFF0AA9F099@SA2PR11MB5036.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h70tneiGcymFCgs7POaEwSXHJf0L9g8sqhGQf3OLwSLBi6o910QIIomz5jAzSKTcv52YEuy4MgDdmr3SfXldpdlZxHskK5/i1BvWkPiCwreGnOTOgZ+jjGECu8o3p59CDEGTDSm3Re05OsbZgs4CCNbkwgDTXHqHKD27HsS14dgG9jDDuxdNhxc0q9YK6/52lIwA7xuHTkOibaja1/NEyQlXFUTmtk1DovbD5QjALfBXvfT8YBsA+UpL6/OSEJsX3C+w+DzAFiH2DIZZ7iuLj3ClRjpd4vCB6kEpDgqtH2nydSbNe3lTl5AJvNYQLrQmFn9w9O8lylZHC/751tHuCg9GEsVoF2soYp+Qc59nbvgKJ14x18mDdJuJc3k9KRujkwhIjCrMQSJjICA21U9BMishusVAsq5agDv8U0vXKZbqfaGmZ8FpX2yMzt9tKNxuGtIU7Qwt1Ix3eL9G5yclTK/wHrdMVH2iAQr9IIMbB60ly9NDQZSGZT4SzQJDN38ztUyflFYGrwSyuh6PQJIqlVSnCXmIZ1hdYvRt+rWtpHwnYHI4bobvuse4iH0MWdfcAEpqfZYS8QUvn8DN1tHShXrmlkk30efDbf9cUXxM8wk7U+Up2pzIhtdHltVkHFhcW6yYx+ii2wJtfWcDmF/hs+I4bU3Kwr0/XZFIBpBg/PM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3309.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39850400004)(86362001)(107886003)(66556008)(2616005)(6506007)(16526019)(66946007)(2906002)(1076003)(4326008)(6666004)(956004)(36756003)(66476007)(26005)(38350700002)(83380400001)(38100700002)(186003)(6486002)(8676002)(6512007)(52116002)(316002)(5660300002)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8cn1Hx9of/Tl24/Bw8YrdKQ1CuaRYMA6wDUp8pD1hlfDSjdwwhevOc62oO+l?=
 =?us-ascii?Q?MeOsvqK0sUzPihoDrJZ0evHjNGLMkst+9pW0L9NPl8vlLqaRieX26vBmtuq/?=
 =?us-ascii?Q?ZB2VW+f/7rzeFYNnjjb28rC4oKXpj940P2Esr0ZUzGDEgeBSi25me4THkNYN?=
 =?us-ascii?Q?1jgX+/UQP3QBPIadbVpR8FxPA65/fW2hRSRr6BwSPZ/gSdFIjabMFA7882Gw?=
 =?us-ascii?Q?nDl5vjKArILEjij2as4rf8u/p3bwzoJzJkeumEqKGa7Co9vmnGmbu2EqVA9V?=
 =?us-ascii?Q?zJb6zjIqBtos498fYb5PDhhHFNFLTik03iUWmkW0Na9o65vY2jNzTv0Ck4Ds?=
 =?us-ascii?Q?Xl/DKLTrphQoe0eC5EJI2uUUMfDSKtwAemgs4g0dPc5BUdBHqXyJ+P1sZlxI?=
 =?us-ascii?Q?Z7tuT/mMuMTWL4gSmXNTYD00HAeNs+TWgUXu9fQ0o6mJBDMFz70mKO7pmYkR?=
 =?us-ascii?Q?Cs/QZ5o7xMfAuslCiEjVs7fDqPn8yrFBqXyl86AUMlTmyuFwdmYYj4o/aYGr?=
 =?us-ascii?Q?kM8IegsN37BDLsw8fue+6bQSm6G+UsPhLgYkYouQwMWK2yWhXjb5j8P+3yfR?=
 =?us-ascii?Q?LH4UyovoenOuwHiphvoB4M1ZUHEsjZdpatNcRZfSjqnapCkDcu3Fc3INBp9q?=
 =?us-ascii?Q?Wd3DzZYNsrnRZP0MTSJsZJISnWur34KZ5iQ/qmgXwGC21JliKWVTdWC6eg2n?=
 =?us-ascii?Q?YqFtTUKGGy0IKBLxCXZDliqDb1TjA0kqrYw6t2JivwJIiTMaDbvrlJOpnj6a?=
 =?us-ascii?Q?3iQ34o2XGuEu+igVg6HWH5RaqF8E8ahf3JuORB1pLsmUyFVbbZUJ4dqBYqW2?=
 =?us-ascii?Q?E3JRYGvIJfyic6nbmQw5lZkA70DXixFvJETkDmz7kO6bpHC0fDxbGQbvYXpu?=
 =?us-ascii?Q?nDjIKonsaiyDMWf58TPGhVMgeLqJ9xlyH04ywntMdcPOAWnlJf1astieee8L?=
 =?us-ascii?Q?SgZXq17osI+5smIRDwrUnYejwj9bGizb0AH+XSsQZM1no1aSxp2ZG4KJhzW5?=
 =?us-ascii?Q?bN7W7EEeXmodeZ6cjKqKoFCU5afmKlDQ3FvpSCs2Yzi5qMcMt6Apsk3Z7Jsb?=
 =?us-ascii?Q?JnA2cRsPIfqex7HQQbq64n3GBst3PsjcTMEARePphESfqHt1NBfTu1V+c4dY?=
 =?us-ascii?Q?K8n+/3rr1hCxDYcOEjhBc/XCixuIAOd8jXaduwi9GKdAICnEeFLint+xWyFb?=
 =?us-ascii?Q?uMHXaYN9kDHlneLpdutCdXAnOkH49Mr6huP0nvYJm6GD7bHxKxiYkaFNej1e?=
 =?us-ascii?Q?tug+CtT4tU9Uf2KhJz9nFwjbeZQLtEGObR/AlD9V0VSJaxy3o2A6NSHLJxmG?=
 =?us-ascii?Q?DzXDS3ddczSb3fyLYOXCjf8I?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c0be7b-67b2-4a57-46bc-08d93569b88d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 10:37:23.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x07QYKio7EO1peiXL/oXUpg8Doj1WS062e6I9dbhhrSIm/7bjDMSmNTgq4OSgCjPyI1SVkY8yalUFiwrY0fjQr/8z0YISH+3JxszyVd/MlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
X-Proofpoint-ORIG-GUID: A0Ys-P9AVq4m5hYJKtAEhQx_ycxC125C
X-Proofpoint-GUID: A0Ys-P9AVq4m5hYJKtAEhQx_ycxC125C
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_05:2021-06-21,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=970 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220067
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The dmesg report on rcu-scale shows there are N grace periods, and gps
are listed from 0 to N.
This commit make writer_n_durations stores the counts of gps,
and shows there are N+1 gps, change the listed gps index begin from 0 to N.

From
    [ 8306.087880] rcu-scale: writer 0 gps: 133
    ......
    [ 8307.864630] rcu-scale:    0 writer-duration:     0 44003961
    [ 8307.935711] rcu-scale:    0 writer-duration:     1 32003582
    ......
    [ 8316.472860] rcu-scale:    0 writer-duration:   132 28004391
    [ 8316.538498] rcu-scale:    0 writer-duration:   133 27996410

to
    [ 8306.087880] rcu-scale: writer 0 gps: 134
    ......
    [ 8307.864630] rcu-scale:    0 writer-duration:     0 44003961
    [ 8307.935711] rcu-scale:    0 writer-duration:     1 32003582
    ......
    [ 8316.472860] rcu-scale:    0 writer-duration:   132 28004391
    [ 8316.538498] rcu-scale:    0 writer-duration:   133 27996410

Signed-off-by: Jiangong.Han <jiangong.han@windriver.com>
---
 kernel/rcu/rcuscale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index dca51fe9c73f..2cc34a22a506 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -487,7 +487,7 @@ rcu_scale_writer(void *arg)
 	if (gp_async) {
 		cur_ops->gp_barrier();
 	}
-	writer_n_durations[me] = i_max;
+	writer_n_durations[me] = i_max + 1;
 	torture_kthread_stopping("rcu_scale_writer");
 	return 0;
 }
@@ -561,7 +561,7 @@ rcu_scale_cleanup(void)
 			wdpp = writer_durations[i];
 			if (!wdpp)
 				continue;
-			for (j = 0; j <= writer_n_durations[i]; j++) {
+			for (j = 0; j < writer_n_durations[i]; j++) {
 				wdp = &wdpp[j];
 				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
 					scale_type, SCALE_FLAG,
-- 
2.17.1

