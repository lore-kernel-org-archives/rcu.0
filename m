Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63ACC49EA5
	for <rcu@archiver.kernel.org>; Thu, 24 Jun 2021 14:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CCD8613EB
	for <rcu@archiver.kernel.org>; Thu, 24 Jun 2021 14:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFXOhq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Jun 2021 10:37:46 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:25794 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231735AbhFXOhq (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 24 Jun 2021 10:37:46 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OETemv000665;
        Thu, 24 Jun 2021 14:34:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-0064b401.pphosted.com with ESMTP id 39caqmrqj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 14:34:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZ85EzQfk7uplbbukZF65nbHIiPFklWjQwp2Qk3WLD0zfWZb1/iFOtN6f7nU59uOPcDTJDbWTLu+0cCrqdQC4gHkvOT293bWRRUR8UiAyfzzIde6Sm3SMrWK8hhhZdVnEz/KLoxCVIpnDDJx3oAbXKnDhZaL3gpyMEBD+dqx1UWvxSyn26iuyrAUoCZJefzb/pPsDQUa7il1DDgxR81f18X5Ch67jYzs7PcXmxeKpceGd57IkYMSaheSiIt9UAVK95nQXw0/yIvu3MJSNbzd15MVtra8fBMGb7fbYPmFJnDZwgoHJzjho3gd68jaN8Re+XO+ijprfVeeaWPXzh859w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx9EZaqwDkv7N9brwQubt+ZuQNB1+bw2ZRWXx7COSbc=;
 b=WF5JlXEbHlWcaR5zO6Pj1ePOcNqGH/8VKiMB1Y8gOlAohnAaC/J0OHCX/BKMNE0oe2HlJyRHoiSTfVVWYDQZjmV4Zk8YqyT8ZMg1H7sgBUEZ8iekTFYT0xKkeSYcdJL0oddEowYuJQKOHNqU5OhAEHCLS6MCiMbGUqp8ZBzOb00A3aD66FeAlxtgyKx/yff/SV1oln9TuG38Mzjbg3D2RVLZ32dwUW2dQpWQryPMgJbmDFyjxPpAscfQ1W3cPf0tW8eBGI6/5cLKlJ4z90xw2w7g/Y83895W0+okak1CfZfvlqK26ufMvYe+lCsWFtTaBKytLvEQH64ZsFUs27/OmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx9EZaqwDkv7N9brwQubt+ZuQNB1+bw2ZRWXx7COSbc=;
 b=MUCEFkZEYcGm0AzHJlxMhgbU0nYD0FZO6TFmNGwnJG0rdef9wFF0TK5rWOMb6vMTgnxhduPqoAuLzxlBcZqWku0Np9PvqkMkc5D5Yx7C9jcPjzLmpi5eSxg1wfUCmlDaMG/DspzDXqsqNPmUyl7Bjl4VVZpI/guaedZETdP+8LQ=
Authentication-Results: stgolabs.net; dkim=none (message not signed)
 header.d=none;stgolabs.net; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB3304.namprd11.prod.outlook.com (2603:10b6:a03:7a::21)
 by BYAPR11MB3478.namprd11.prod.outlook.com (2603:10b6:a03:7b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 24 Jun
 2021 14:34:44 +0000
Received: from BYAPR11MB3304.namprd11.prod.outlook.com
 ([fe80::104:aa30:cb9d:fdb3]) by BYAPR11MB3304.namprd11.prod.outlook.com
 ([fe80::104:aa30:cb9d:fdb3%3]) with mapi id 15.20.4242.024; Thu, 24 Jun 2021
 14:34:44 +0000
From:   "Jiangong.Han" <jiangong.han@windriver.com>
To:     dave@stgolabs.net, paulmck@kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        "Jiangong.Han" <jiangong.han@windriver.com>
Subject: [PATCH v3] rcuscale: Console output claims too few grace periods
Date:   Thu, 24 Jun 2021 22:34:24 +0800
Message-Id: <20210624143424.16158-1-jiangong.han@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To BYAPR11MB3304.namprd11.prod.outlook.com
 (2603:10b6:a03:7a::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-jhan2-d1.wrs.com (60.247.85.82) by HK2PR03CA0062.apcprd03.prod.outlook.com (2603:1096:202:17::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Thu, 24 Jun 2021 14:34:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec9cc4a6-4b38-45b6-8640-08d9371d3552
X-MS-TrafficTypeDiagnostic: BYAPR11MB3478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB347827471C91A8F2567290CC9F079@BYAPR11MB3478.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RF/ren18qbjyjGwey72cIoSv0EZftgUasZ7ZU6wI0q9taXnQIevBWn5RXtGxIcI5Ig/9/9V0SRK7p4RX/dCfVuPbA0boL8N0Y1Rij2lSoiFH72iN2X6zlrL6K+rIdiLCaG/pwvD9RV07ZFDt1WLZpqxnrgzSikxH9ZwMz1Y8tIQXXl7AeyD75LYJR+Nrr1Sj4SxOnJpnozfAWWDkA1nMAokAF9F01XwNnAKgUbTVYFUQq1+4QPqLLBQv+Uj2q+RW+hs475DTb8dxpmEZk9FsMa7TjRQIaCBNkE5Oh5xXGUl+AEq/2pykskzNC6fVQ0dABvNn0KruoBiR64OQx+sd91zcne9vN9V7o5QB4Lh3iGbLrAIO+BJiZAUP45nxOkTuas7Q033xyrgG4ZvF++161085I+oSqB5cYO0C8oO3J7lB1DObFeIocmuy2GeVG36iAhvpj80+VSP2IKgS9gKh8IxbfRXiFDZv0+Z1mMuOZb9PX33rIHFAhifvmNFghMm+BJUtZmbobYt/9uu38A4+ub2WuWENpaXKiVHGAO7zYOvMP3hCYSiur9yFkbZXYGA6jVTTuxrl7F0PqlqakeZ6WoB0qjnOFqJji8uhrgjeNBSWyOxaAHRrE1KORVdAPxich3hVH7bo7w9WRkqIEYrggwcrCdVk80f8SAvJAkK3WUvqZXYcdEr3yQ0kVA/GIxEt177YKUf3Gj2wFA3np46f8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(346002)(376002)(136003)(396003)(956004)(2616005)(316002)(6512007)(36756003)(107886003)(83380400001)(6506007)(6486002)(66946007)(8936002)(8676002)(5660300002)(1076003)(16526019)(86362001)(66556008)(478600001)(186003)(38350700002)(26005)(4326008)(6666004)(52116002)(66476007)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZmAyfTPKG55HXwDTPkkhljtMSac4MyrZYw3aL1ke9fpIjGtb3hticGES/el?=
 =?us-ascii?Q?6OB3wJQqlPJknKDTv4KT1GSkOae3K8xTbQEE1j568wtqQtaPsEyIE2SXK5Qn?=
 =?us-ascii?Q?9x29zdoUG0bm7X3DBN4x8/tXJfP6PMaz1kBYtLqWZc/zFofFgTFzPJjegAjg?=
 =?us-ascii?Q?f6iW92d29ToLqBs61NYUam41MNVa4b7hlkgDfWx6HmOxwtiwqOf/W90UNcyo?=
 =?us-ascii?Q?QhAWY80Zqv7Elt09LoIakgiE/KufRn0kn6J4bouhXB6w9MmSiMNi6o/bsQI8?=
 =?us-ascii?Q?wuHDZX3avJOEkWd2F72MrfctgG7FDkMjPOLKReXzMp+RRMPz+3A8tsIpVoc4?=
 =?us-ascii?Q?zjPmeTwYka7mWWE6/QVgeJGnSKXc0eS6hAKt7c37Xu4wP2/x+H+xQ7kdImrt?=
 =?us-ascii?Q?Yp8+MeZlQoKpQb7zMAiMPbSr6bhjOmSeA0ySlqQn2K+d+JtguD+N13UxSBky?=
 =?us-ascii?Q?6CLPQm8naq8GI+jGgguqZnECfYULeMl64Bx3GpoCQu9mxP0/DrCxuGb7n2Jm?=
 =?us-ascii?Q?/xa3hbwrbvleqLxgWAOD6RI/xKPv2qczqhiAezB4tqYo5FslWR8tZwn/+cd0?=
 =?us-ascii?Q?Bu8gaX0lmw8cqrx+kJzNRbC+qRinR+YjM7BSrGy42JNguUoMuv5YiWjryoDA?=
 =?us-ascii?Q?/WrQq0EEnk6TEIAauweMOQtUcKhfHPGn7UJ8G0Iow/VW/IGnITcWSqd1sr2X?=
 =?us-ascii?Q?nmGrW/3XbceDUN/MPStSS0MoJLIhT1UpYiW9mPUV/dezxFSntlX06nv8JgvH?=
 =?us-ascii?Q?/Vuj5YgCch+y+eS0wuDszuN/25WsM2iucG9M12jusOSttN/zZCdZgjTNveSF?=
 =?us-ascii?Q?uaFf+98csFplw68/sTp3kBY7WCGQ4KLq+9sCBfXGvLLk2YUcS6lPo/dePz+w?=
 =?us-ascii?Q?ocSl8xoS4yjRCToyeIo6QptKhuUUG61qOyr39fZIg1JBZ5j0XCBhRmN3fYfS?=
 =?us-ascii?Q?KiySZxdVPvZD9tuEox3VHayF87ZfTRJiabkr7vJxv7LK98tw4g9jAxbtS4cl?=
 =?us-ascii?Q?vRSj8ymDbACT7Eyn1+CaaZzqpYz7Imrue+bi/4I077RuCc8F5C8nhGnf8FeG?=
 =?us-ascii?Q?wRRfOhXM9bQnelHqvLh9LfPGmSCFF4KasJ5zAiWI38X9uI8ZBFCcXEvsPFLL?=
 =?us-ascii?Q?Gaba0K0lIxuGxesANoOf7sB+tn14jHSKAnZsr9wACK1xR2uYL5wa9STrxbem?=
 =?us-ascii?Q?L9cv5ijE5qAOJjE9sy8umiCGCO0nSPaeEy6ZAezlGvNEptQ/F10sysMBDk5g?=
 =?us-ascii?Q?MKFU+N+FlYZVjbTCidW5bqWqdelNZ8HEd7ze6/3WxjayZnSd/DfVubGBfo6M?=
 =?us-ascii?Q?4GWPa/bd24P2GHM623PnRAXL?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9cc4a6-4b38-45b6-8640-08d9371d3552
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 14:34:44.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sdlt3RcXPvY/L64/bDoIUFwcq4muq27FYdKw6XKP6MBxtjRsxXdt/O++ZFv7fwla7pzU6XQT0jD6JkDGutRxqQcNpaA4qN1noFzaToznWVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3478
X-Proofpoint-GUID: U3V9x9qSwmPYy40fpcnaRoMQASOcG4Ez
X-Proofpoint-ORIG-GUID: U3V9x9qSwmPYy40fpcnaRoMQASOcG4Ez
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_12:2021-06-24,2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=703 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240080
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The rcuscale console output claims N grace periods, numbered from zero
to N, which means that there were really N+1 grace periods.  The root
cause of this bug is that rcu_scale_writer() stores the number of the
last grace period (numbered from zero) into writer_n_durations[me]
instead of the number of grace periods. This commit therefore assigns
the actual number of grace periods to writer_n_durations[me], and also
makes the corresponding adjustment to the loop outputting per-grace-period
measurements.

Sample of old console output:
	rcu-scale: writer 0 gps: 133
	......
	rcu-scale:    0 writer-duration:     0 44003961
	rcu-scale:    0 writer-duration:     1 32003582
	......
	rcu-scale:    0 writer-duration:   132 28004391
	rcu-scale:    0 writer-duration:   133 27996410

Sample of new console output:
	rcu-scale: writer 0 gps: 134
	......
	rcu-scale:    0 writer-duration:     0 44003961
	rcu-scale:    0 writer-duration:     1 32003582
	......
	rcu-scale:    0 writer-duration:   132 28004391
	rcu-scale:    0 writer-duration:   133 27996410

Signed-off-by: Jiangong.Han <jiangong.han@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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

