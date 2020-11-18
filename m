Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABE0C5519F
	for <rcu@archiver.kernel.org>; Wed, 18 Nov 2020 03:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA53221FC
	for <rcu@archiver.kernel.org>; Wed, 18 Nov 2020 03:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="EdQ5Fw3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgKRDx0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Nov 2020 22:53:26 -0500
Received: from mail-co1nam11on2085.outbound.protection.outlook.com ([40.107.220.85]:29025
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbgKRDx0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Nov 2020 22:53:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXiWqyU0s83rTNYqbGbD5koek/V1dKRUJsn3sJaxgpzyZBBAtZGUYJIhLprwCNnpQ0P7VVvCYSZMmm9k+WWBONBrJuiaHFW/4KNP6YwaiA+Ca+Rx+h01HK4TQY2JW0c2S5uxyVIc5LhMLI5p7KzT4Rcc5oYv+zQciBQ4+sJsRQTVt+0srdHeyMPgezwxNRbnUDA1u9DRUBIJ2F/BCSgjPXGcCCbJRxXB/9msIsgqmRM65H1BeB7ZpQxz+75nEyCCVIRMnPIR38Ck2D0DW6ftlo4+wOfOo/1AVQSFyvXFpFOSJGd0aoPcv6HTBCMWShlK9ouXuKkBikLqOzK8MZdcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAJkCk84k+oMzAgFgzUQdbm6kAYJHy0E+VhZTrGUveg=;
 b=iJJEbWzioOQ79+OFg/6EEjBva78kWjW4/5xxyx3AtdjMrMdY+xUFxnJJrE2B5V5PdQ2PXCro6OwTv3F91bKbGxUO/A/qvlxSWk/unfFdwxNg6QMIzP+qxNJlm9RsZNui6DehkKVkUYcQsavrlEycpyOGu/YZtHZenxyXKt7BmQPDrHD3c2d8ZeTvWRz8Urt3W6+g3fLYzKpWDzWj1gwxAEFcIRRAljpsYNIPXOKWhffmFV/xPJ6dKxxjNGqXaLAPZjfcEkLu9fCT0p96BRXMJbkrpyv6O5OP8EcVZshPCRBa+1aNVu43f6l37L1L9XxZtfU61IbMs9Cp+vsWTQrJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAJkCk84k+oMzAgFgzUQdbm6kAYJHy0E+VhZTrGUveg=;
 b=EdQ5Fw3kL0GYBMYgHNQ+feGLC7dAULAAYAKFuDXmYlx7F3wcUm20pQabXhq/DquGGhsSYgQFOq33pQjm/NXkZI8dr5vv09XKY6iQMO1QQdPxKJVqnO/Il9ntPK4u9ZF5Z1db6x1vhWOunPGWThXVj6hPu2fac2Narfcgt5qiY44=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB3912.namprd11.prod.outlook.com (2603:10b6:a03:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Wed, 18 Nov
 2020 03:53:23 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7%6]) with mapi id 15.20.3564.031; Wed, 18 Nov 2020
 03:53:22 +0000
From:   qiang.zhang@windriver.com
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: kasan: record and print kvfree_call_rcu call stack
Date:   Wed, 18 Nov 2020 11:53:09 +0800
Message-Id: <20201118035309.19144-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:202::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Wed, 18 Nov 2020 03:53:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 707d8b1e-537e-456e-2ae1-08d88b757e6e
X-MS-TrafficTypeDiagnostic: BY5PR11MB3912:
X-Microsoft-Antispam-PRVS: <BY5PR11MB391292CC71E0F27993915BB0FFE10@BY5PR11MB3912.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqhypcQGKHRE1Ifbs1eKxJ5QgTImr2r3ATP5vO7a/dmKVzm8AZekPPzOsIU3QCZJTtYu7SIKBseJNGlt3j7efbqa2Oo8J9bloq69bkKGvmuRUjH8s+AmlZbGDm7at0s9rGeaG/rWNLYIKdVuZjMJBb6Q2FDn5JaRg7zp6UiCaai0H0xoUor1RljnSCb5ugMNcSYFf76MjwS2D/Rp39ZTl/38sENyZtJ0rf5HLtJLhAqgOaWUqDmdLhC/fZCXmIjvWk4a2K1nFcPRMhOgx7/6udCjEbTeVlBFB3qQ2Nw53bWn7fOSvehlC4uC/Hoz0rVibQ0WIWKE8OOaPs1ogAOdHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(346002)(136003)(366004)(376002)(956004)(2616005)(6512007)(6666004)(316002)(83380400001)(36756003)(478600001)(9686003)(52116002)(2906002)(4744005)(66556008)(6486002)(8676002)(16526019)(5660300002)(186003)(1076003)(66946007)(6506007)(86362001)(26005)(4326008)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XP6nVN70d/dyUJOWlx7asaV9evrPEGTo97bByDIoSpWC50YBh137jU1G8Vr+5DfShByG4klHkMGBhbtyRts+z1dWA/wEZM1rzva5KbJgFIO8C9wvANas2j1qqUNCBinYIsKU1/vpMR3jyyYJ4It46f+Ew8kLHRxmii35kS75Pu1IY6Zv75qubO1r8yZXJvdCFO2wtd5FKpXhOubWu3Tipu8fGF8py8BDS+3vcANlhSHCQqBT3RJ8iuCs96UWKIRcHBi4cNNaUbGdMwnw3KwiwiAoLyohYXaJvP4erE/dJ4Y9FYcj3xylWpEtdjyOfebPnVByB/0/0In5smPxIAk4ZoAXA+DDmd+yB2rvPfLuhVRaqJErI5gaOH1dEs9byyKatDKiXF9Sk1mT3SDpnhSGAhqIUaRsB59hfGhLA9Hqi7EO6sbyA1y5SpovHvcc/ybkLjfRpqC6cU7siQ6VzULNRAlwsUo61xgwyXSyQIB1Cuj0mS7+Gf/WnYd84ermTjx7sPajfqmrX9Pqv2Jj1K1BPFE5ANsTXPwhEZP1yrfj3A2hM2dP29hd14+9geSNzItBDPhZjIVo5FOPypJ6dGGoTRKM8kyp3mBrES5qXgr9DL5jOLVrqaAKLQCzFkaqF4rT/zBEu0OuAwRND4eVaqh6vw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707d8b1e-537e-456e-2ae1-08d88b757e6e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 03:53:22.7045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFdns8FJQQpeaEy5ejRnSyBp0F158JwnCaGm3IZ5tAcqxOMEZclyJDQeA14KWK0q27a5kmMPg5RNiZCrrw/my/qXJ0XPo6kgUlhTVPRAKTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3912
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Add kasan_record_aux_stack function for kvfree_call_rcu function to
record call stacks.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da3414522285..a252b2f0208d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3506,7 +3506,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		success = true;
 		goto unlock_return;
 	}
-
+	kasan_record_aux_stack(ptr);
 	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
 	if (!success) {
 		run_page_cache_worker(krcp);
-- 
2.17.1

