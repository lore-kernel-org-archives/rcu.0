Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01A5C433E6
	for <rcu@archiver.kernel.org>; Fri, 29 Jan 2021 07:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63EB464DDB
	for <rcu@archiver.kernel.org>; Fri, 29 Jan 2021 07:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhA2Hue (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Jan 2021 02:50:34 -0500
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:55680
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232469AbhA2Hua (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Jan 2021 02:50:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbtJqfZ/YB+eb2hEBvUXErfdvV4fyDfkxzwQ/d0SlXb2VZ1Chf0ehx0U6BUN+0vaNAbp3riK+9gFDOtgSZiWaAh72YUQpVmbhIltWeMr23J2iIjQfQSgu1kWvvyUbqInrl7gjIHhGIF/IlSvHA/ZSQUZKIIBwrzzyS9c1UxNnAL9Oxz467E7BJFkneU06DADWR6Ul627aE9Oo4IbTtMEg16C8JwDnTq35KV+pY3JNF+mzVIk8dxnaC0c8qK9myYYjDcQ69cnZqYbRgfbb25K2km78HyPDB+YnwuluT+r2ZSLf5YfJrlyRkLlhjQ0R1EIWxIV2IVYlxnB68uCJvksSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMjDm+8WSaZlFkQ7JzyJEXv3Jc5yYdHaeEHiZLgNJ9Y=;
 b=jYgqUrHc2apHPCZT8+JZraxb9UOKe9l2IIAoGlUMqznRG3yQW0EJwgqDAwxjQkOrSZ+T/TrQKwDyJ3aRI0zTuhtzSGGWqhEmgTUg5rLUiJoqgGDCC6OSwL6mUcWBc/1HvxOlO1j55FJUyzt2CYQepkqC7TdM8qKnOnxZbasnoTuQNDO9nqMRBLTveaVwRkUZ5x+IUbPCXqKjh0ltqriqf8shTUn+6liuGPeNuXm3SXziirbxHr97kiklPJkj9DBzFmjuyCmtbNthf8aFdB6hZE3kyjPFPlKwVo/C2h6gg8hF6QJYewJGbMTi9jLsyC42rysMnJv6KQo9tXZAVyXwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMjDm+8WSaZlFkQ7JzyJEXv3Jc5yYdHaeEHiZLgNJ9Y=;
 b=qV6P7ozvhEdafZaas/97VoBFUwWei3XH9DyvdizM/HGdEQse4n0oiYbk8iZ+1DAsbTQSdEi3Icc+DfEcDTDDmnk8eWAzs0qjHuGhE+cH3V7ISjDxs8QU0juzfoQJPCi6VaWh8tBzAdayE357ZgLVXKbaiOgpEaB4brhgVTEimCQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by SJ0PR11MB4784.namprd11.prod.outlook.com (2603:10b6:a03:2da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 07:46:47 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Fri, 29 Jan 2021
 07:46:47 +0000
From:   qiang.zhang@windriver.com
To:     urezki@gmail.com
Cc:     paulmck@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kvfree_rcu: Release page cache under memory pressure
Date:   Fri, 29 Jan 2021 16:04:42 +0800
Message-Id: <20210129080442.16055-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0222.apcprd02.prod.outlook.com
 (2603:1096:201:20::34) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1-vm1.wrs.com (60.247.85.82) by HK2PR02CA0222.apcprd02.prod.outlook.com (2603:1096:201:20::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Fri, 29 Jan 2021 07:46:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be3bbee5-03cb-4366-16c0-08d8c42a0779
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4784:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB47846E231C21DEAFB2656582FFB99@SJ0PR11MB4784.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gWfVb+ktbxxju9iuis1dDlMUrkzEouaUVVMfF7X5GoAdYikGki5SADMS2SSFfCy5RmMfRDlJZ7jQSFRirKdl+poXD3jMKhzXJjGqH7r+FReU6PnOp05qLP5RuA/vOFatOm4EFIKZIJr37rNzH542YxO8iEarIUzXNz3NH0TIliAv7aQ3xFRAD/FPzxiDV7uyJ0D4GMIGyTsLHMbgR9qO65ANVcIT9QdVuaSloJ8K1C2kHF0no6paniuQJZch67Qs0ig137ypRKCqMlDL3zYUTPiGDsJwzh5zH6bdD88+vTR8g5Wy5Fvq6iI3GgrjAHrWBWbLiy7eEXzRgJc13WSUqxAStuEtwCvxkroL60Br8csEPhtATNBTjlYf0q7g68iMxJ97f+vGI8Fy0r7XSTxQmur82p6eauegQXg5wBF2M8NP6KNJmaSyPLLzi4X29dUhrFPmtJApQxK+xFXi0RuLtQ18rl2ART6GsydB+I7+lAkCPVyeh3oFTCXt6DUdCgS+Na56lRpHpyhkXFUR82uJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(136003)(366004)(346002)(956004)(8676002)(2616005)(6506007)(4326008)(6916009)(186003)(16526019)(1076003)(83380400001)(6486002)(316002)(6666004)(26005)(86362001)(52116002)(66946007)(6512007)(5660300002)(36756003)(66476007)(8936002)(9686003)(2906002)(66556008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zr86zqCEKVW/HgdK9plJvjbmbUqMsIyVIbFFMwi/2oLF59clbtpQAwsYQ0Pm?=
 =?us-ascii?Q?AmTGLR/GgSAJaxpoXx7LCVV5O9a+P2bz4shg2iScpA293kWKgISDrlmIFtXA?=
 =?us-ascii?Q?NKIptq3EIEq1cIHYRbaIvz1IHkeluwh+/v4qcvI/vR0DloIqsL/RUbeOd77t?=
 =?us-ascii?Q?NkRGo1Sm86cHE9ZTtpgpV+h5GaZ0bhF6eq2QI86rMjXCUaoCyAbkK1SOgHhB?=
 =?us-ascii?Q?jNwf/UK8IyIJBG91exKHmYc61KlV2FSJpidvgrqioLckSY4Ye/n5uSN606+2?=
 =?us-ascii?Q?I92IJc6I0A1FIFcpWaa0Ws1oLWxjQN+y9ErjuANBi1ipkbjtVFrffGjDaUqV?=
 =?us-ascii?Q?160FhkYqWsgFRGzgOW4Z78ZrU4b9PupvbTAmrt2VbQUPGJRfMtwRM1jtaQ1c?=
 =?us-ascii?Q?+xdrAA74qkiH1OPtJExCDhHEuFIzeB7U+rFd5x6DuOa4y7sQ1rb3IiPeiRN/?=
 =?us-ascii?Q?m+Qih823Rvt0je2THgGErZPZgNbVxvRBj7lDJ1H7WQwpzah/iWW8Z7JGLQkx?=
 =?us-ascii?Q?vWkMPu0rjWjKsaTiqY44ZULs/XW+xntUHzouHlY2CyDQRrmqP0Nw2XWwRH+N?=
 =?us-ascii?Q?32WG+A21R8u8hnQH1By4rR03XC9iA4zFDvbpN21cC+XTN/Q68/sVBhz/mo4N?=
 =?us-ascii?Q?/HwqUzr4PA2U+lVYZ3PakAPg0PZNooK5qmn/PuLr95OJ+OwCpxCm5rS5l8nu?=
 =?us-ascii?Q?ndqntxqkWsnSxxot4yJAzKO7I+RumrynJK6lFaEkpQIuyMq649pdWKQaGE7O?=
 =?us-ascii?Q?V1O7KADTXEeOLca84Sm8fCQRqh+p9qkqR7taJwRCt9x/5hyDOLsAyBIeMIKR?=
 =?us-ascii?Q?LWiyOeVVUod/uCtUPL+HH9MC8ocpVaKkJi6pR6z1rJvBOleKBSfakJrPyyyE?=
 =?us-ascii?Q?MKzymfAqczCVkj6szW5U6r/8OTw8p6yFQxkL/7n3AGYGg5aWsenTl8BxSPqd?=
 =?us-ascii?Q?hUG1kb9nki4CI3ZbwQSXZ2FF7faf0ZbNs8E69VIavqpjpWVOBmaDpeiG39kq?=
 =?us-ascii?Q?yHlw8KkFXH3A3ZxIjBPW7hSy341t73dQEK/CmGsZRUFyVifO+iLPQHA90VCJ?=
 =?us-ascii?Q?1Bxg71UI?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3bbee5-03cb-4366-16c0-08d8c42a0779
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 07:46:46.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRcXlQLQc4HU0Fuitodqlk3EAqhyG+sJH+TeCagn1nDYtJo0A1eZzkeDn8+fXCDPDTMVDY/DB4YoO27seaBysI5Ov5d4GhDzYegwqHb64yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4784
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Add free per-cpu existing krcp's page cache operation, when
the system is under memory pressure.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/rcu/tree.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c1ae1e52f638..ec098910d80b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3571,17 +3571,40 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
+static int free_krc_page_cache(struct kfree_rcu_cpu *krcp)
+{
+	unsigned long flags;
+	struct kvfree_rcu_bulk_data *bnode;
+	int i;
+
+	for (i = 0; i < rcu_min_cached_objs; i++) {
+		raw_spin_lock_irqsave(&krcp->lock, flags);
+		bnode = get_cached_bnode(krcp);
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
+		if (!bnode)
+			break;
+		free_page((unsigned long)bnode);
+	}
+
+	return i;
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
@@ -3598,6 +3621,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count = krcp->count;
+		count += free_krc_page_cache(krcp);
+
 		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (krcp->monitor_todo)
 			kfree_rcu_drain_unlock(krcp, flags);
-- 
2.17.1

