Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFA7C47082
	for <rcu@archiver.kernel.org>; Sat,  5 Jun 2021 07:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34088613D2
	for <rcu@archiver.kernel.org>; Sat,  5 Jun 2021 07:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFEHDF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 5 Jun 2021 03:03:05 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:62338 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229755AbhFEHDE (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sat, 5 Jun 2021 03:03:04 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1556xJno008268;
        Sat, 5 Jun 2021 07:00:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by mx0a-0064b401.pphosted.com with ESMTP id 38yxg2g5x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Jun 2021 07:00:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geKpP50l7K98cSM9fjhZJFLJ4kq/bcZFQ2DLUeEuZ5Nfg6gGIHfRul2HQGsCqECRX4NbY0sdzdRdkMggsv2HOhida4dIJ0QFbFwy7BQG6sdwaPdGAIysekaF02FzXMzGpHkXKdiYUE7wqQa+wCFVrLd6QIt50ScF4wVxH+QC53G8OltdfRr3WnFCiEqoOl0RuLKEaoyEYJxkh5dJBF2lzkUXrI4UPTjFrJFk9aqmAeIgRXOxi84uCtrIaOAntpJz50Eo3yA/xufKFPSUn3Us7Ei0dwFoMqFIO0xktkd0zK0dvMjcNvIL2EdnEVKxnNHHQwNxDVGqe0QBpMgeUgJG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ro5os9qILruQ5i56LS2r6jToqs6l1OnpXqCl30imDU=;
 b=ST3shanPUpHIN5kb86QNtAx+vkb1aW66WEgEj8tji1YqOz//6Zv/H19CjVlaLj26lHm89dVmVKGF2F1OWt9ZsANuHzSkXWc6SZzQyd3I5ajS016mf3wqvXV2RIAzdZfKo91LLAw3z+Fkt8AMmqg1yRQeeEbk/1jfIMpupzjcCoFXB39r0MKVAJwvjgohOlmkLB8yovBofbuZb3nMyBMuILekLgQO7HtJ27q6coQJAGX+y3M11/bQKj/dXZCCD/pbjJy4G+jq6AIIQwS9P0uJtOu+DbSTrV0A+Sk4tEPDkcuQy26ueO4dKwt/DOjJSKiv6L/5eyzbHiQcB/b53jllLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ro5os9qILruQ5i56LS2r6jToqs6l1OnpXqCl30imDU=;
 b=T31baBj0SgkcVBZzBWI0RQejSmMdUl+z7MOltpI38AYDD16TjTmIEQ284AHeswQImbimSuEInvfF79V7svMXOb7fVSCYYTaBkBMlgHWkRGkn7iNbQleKZEWwHmvdCsz2z2KHGK7yJ7VknXGoglqX+4VEySgAGiLF246qe9X0tV8=
Authentication-Results: stgolabs.net; dkim=none (message not signed)
 header.d=none;stgolabs.net; dmarc=none action=none header.from=windriver.com;
Received: from SN6PR11MB3309.namprd11.prod.outlook.com (2603:10b6:805:bd::14)
 by SA0PR11MB4637.namprd11.prod.outlook.com (2603:10b6:806:97::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Sat, 5 Jun
 2021 07:00:35 +0000
Received: from SN6PR11MB3309.namprd11.prod.outlook.com
 ([fe80::a170:9c84:bd22:f77c]) by SN6PR11MB3309.namprd11.prod.outlook.com
 ([fe80::a170:9c84:bd22:f77c%6]) with mapi id 15.20.4173.036; Sat, 5 Jun 2021
 07:00:35 +0000
From:   "Jiangong.Han" <jiangong.han@windriver.com>
To:     dave@stgolabs.net, paulmck@kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        "Jiangong.Han" <jiangong.han@windriver.com>
Subject: [PATCH] rcu-scale: change rcu-scale report.
Date:   Sat,  5 Jun 2021 15:00:19 +0800
Message-Id: <20210605070019.30377-1-jiangong.han@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2P15301CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::20) To SN6PR11MB3309.namprd11.prod.outlook.com
 (2603:10b6:805:bd::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-jhan2-d1.wrs.com (60.247.85.82) by HK2P15301CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.3 via Frontend Transport; Sat, 5 Jun 2021 07:00:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25f1c110-f687-416b-51d5-08d927ef9dbe
X-MS-TrafficTypeDiagnostic: SA0PR11MB4637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR11MB46375E30F1DBD8D5431557D79F3A9@SA0PR11MB4637.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tmmc57KiR7N22W+YnQC//V7SzQflEYpOFlh6YFMwJj4XPQMVqCaFPji9nu56uVgo+CJmr2QI9efBFdrjXH7oKVwyNTnfrT+PhKHkyzDBiiGBkyREkwlD4v+/U6G8fRhkap3r5tBwCOyrBPq1/1jYA4X7kdnslFvbmp9Nz80cSyOudfMHfqR6fVvHK0PytThCgRTtkz1KO9Q4s+ZLODnD8wk+gDwSEAkKiELHeLXZuX/MZVBnFv9AW4zOWlDE1WZbNVzNe988zDZZbzx2MHb+MVlfnETZAD/WGzYcbOl8iHPpJdIqzAqu0Mxo3TtlqsuvIQSZL9Yxf+jdMY7PGGLpmCT3OfAj7whQyfNk1gwigMEHPk2TrWH9EvkJrpENqOs3G3UwCx7GZIMbqqh4D+kUksfuAdR8EMzGuO6M/fyMnalCU50HB9JkZ51H/QJEFBVfFTdC5DbjIw8e3euOelaCNk3uResEmmAkuewWssjnwoPcVHIDRCroyUv4fyzeSfsdOEw8efM7EDPyIqBfjKdYUKle1ZMYjQ2p7qTs+e4TQTbDIt7F+RD8CveWaQsZ5bo+QMxFBiSoCBiKZ3YS9tebsN3HPimOP6oWdo7NLuKMXz4XWQqDMGu8NftEQ68IbUYGka/rBMfe3w8q7X0hpMEUYuwiJdtLe8PF5QnB2hNUgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3309.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(39840400004)(136003)(6486002)(6512007)(1076003)(36756003)(4326008)(8676002)(6666004)(2906002)(38100700002)(316002)(8936002)(86362001)(38350700002)(5660300002)(478600001)(16526019)(6506007)(52116002)(83380400001)(186003)(2616005)(107886003)(66476007)(956004)(66946007)(26005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UIlI8G8gNusogKTWZZ2eKTZR5HlQIRGMhRlOJnRGvejzyS7zFTPR2THrFjDM?=
 =?us-ascii?Q?ttlAtg+AtrVb8Oq7uHs/b2tweACF8jKPbzWiL8nNBPq2G1Up7yqbx6pqTORJ?=
 =?us-ascii?Q?Sof7kkbqG9n2O3MqPQcay0PUvCAcnkyfw9j9+9M2YXKa37XXDjaYDUkGdJhk?=
 =?us-ascii?Q?C37j6AKBHT5XGXHvDIanHztYqPd1swEHROGNFVvaiMFKYSJ7j0ubg3/tzSjH?=
 =?us-ascii?Q?PjS7NPjrZJRd49HF8UGErDiJR5QHeEL5mjRzxPhQZB1/oDrlxz4vpEOBg0bl?=
 =?us-ascii?Q?26iMeXViaGUfhKzYdZ29qeUCq19PZiFzwdyANLSVDl62XjPmOIcLzLm87Sfd?=
 =?us-ascii?Q?IcWgJy7jeiH1lMsPed2nioY6ndC2A6Hm7dOZro8c4Y4M8aLL5LaGYlJlULUW?=
 =?us-ascii?Q?TLRiSrWTF66TEFiSlERQZ3siqoYd2ZTFEdCCNVXCFI7sT0DFmhxSK25+JWp8?=
 =?us-ascii?Q?046YZiQ7Orfh6cRz1Oq7XIHBjOGunHSATtWBrHtk2d02yEN3LRZoWWcCpLSl?=
 =?us-ascii?Q?sbyeLzVlCdUDfc5Mtf9UYuKjVJbYNk1ULqOoHkaMLROjCT++PyB/4E+1YhIb?=
 =?us-ascii?Q?8wU3803oht4wfR7sceZmPpCSv5LziiQdBE8kwGMqErH0RkWn7YjEy2ne1CpE?=
 =?us-ascii?Q?lKblb55sGFa3Gti6yTQLD1o/cM5Tv0u7Zt8gVmMPZHD9iOS+2UXk1lsQCj/2?=
 =?us-ascii?Q?60Z+v3mGmv+9oI4+8co4PxC2XNAq9+3N3+g10YdEm+OEpb/3Fx3bBsHZVZBs?=
 =?us-ascii?Q?oisXOx1C1817KTcIaMi2Lyzp5ewDF8kcevLRX89CJtWfeC2bvyadcIVbLTi9?=
 =?us-ascii?Q?PfH89cxl1+zoGZUYf5ZsXJihqjtgRWXlO6bhI3LzQ1Ysw96WoVWVWXxCxLs9?=
 =?us-ascii?Q?8woOVMuqZ7X2P7anvUiNukEdgkIUxx6g7eFkiJQLQEvQbev3CnbKWGFs99ly?=
 =?us-ascii?Q?Q+eyslmeKKPa152ldWl7YBle5PzwraubedMDbk3gifUWS4/PEpJI1QuHaeCm?=
 =?us-ascii?Q?0h+URRVZ3rgGEjdLKesvMJ6E+abwjbtzx7mhbWfr2INU21KxyUmaGgnKryZH?=
 =?us-ascii?Q?dcFzwLJefYTxpK56WPRaVLydyPWtqRauE6I2cSLMmuVFF/BiEyr8MrenRTNV?=
 =?us-ascii?Q?FfP+cKsV8XbgL4Q/xIUUjXhz6Rl2exw4x1bjyr5PSLs6QJGkLzv0PHMlOxN7?=
 =?us-ascii?Q?Y0wgTeSfPgN9loB4HUq+tu47MgyVTuHKvDnzZvwzHN+BEbBcjygXP5ZwaAan?=
 =?us-ascii?Q?18v05xPhV9Qie55N1XDc9/uRmS1ijqmxnnuugHHKFUTkP+M5KhVix4/7LPMd?=
 =?us-ascii?Q?Igtv9lyRLxxsk0NgEToLCuti?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f1c110-f687-416b-51d5-08d927ef9dbe
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2021 07:00:35.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zcO1jdKYFvQ5obwkptWO9181hh5wWWqEeX9KlG3CzelI/EJ9mDg86izAGkAMmSkqWm478/R563sRTp4A2hRB6alXBJx0VLPgImsyF0LAOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4637
X-Proofpoint-GUID: xieBfGNhFb1J3H3FVr7efw_AqrhPcJne
X-Proofpoint-ORIG-GUID: xieBfGNhFb1J3H3FVr7efw_AqrhPcJne
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-05_03:2021-06-04,2021-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 mlxscore=0 mlxlogscore=817 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106050049
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The report on rcu-scale shows there are N grace periods, and gps
are listed from 0 to N-1.
This commit make writer_n_durations stores the counts of gps,
change the listed gps index begin from 1 to N.

From
    [ 8306.087880] rcu-scale: writer 0 gps: 133
    ......
    [ 8307.864630] rcu-scale:    0 writer-duration:     0 44003961
    [ 8307.935711] rcu-scale:    0 writer-duration:     1 32003582
    ......
    [ 8316.472860] rcu-scale:    0 writer-duration:   131 28004391
    [ 8316.538498] rcu-scale:    0 writer-duration:   132 27996410

to
    [ 8306.087880] rcu-scale: writer 0 gps: 133
    ......
    [ 8307.864630] rcu-scale:    0 writer-duration:     1 44003961
    [ 8307.935711] rcu-scale:    0 writer-duration:     2 32003582
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

