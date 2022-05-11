Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1C2C433EF
	for <rcu@archiver.kernel.org>; Wed, 11 May 2022 02:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbiEKCrp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 May 2022 22:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245154AbiEKCrL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 May 2022 22:47:11 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF0554F91;
        Tue, 10 May 2022 19:47:07 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 11 May
 2022 10:47:07 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 11 May
 2022 10:47:05 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-kernel@vger.kernel.org>,
        <rcu@vger.kernel.org>
Subject: [PATCH] rcutorture: remove useless INIT_LIST_HEAD()
Date:   Wed, 11 May 2022 10:47:04 +0800
Message-ID: <1652237224-11656-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

list rcu_torture_freelist has been inited staticly through LIST_HEAD,
so there's no need to call another INIT_LIST_HEAD. Simply remove
it.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 kernel/rcu/rcutorture.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index faf6b4c7a757..0005e259c4ce 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3247,7 +3247,6 @@ rcu_torture_init(void)
 
 	/* Set up the freelist. */
 
-	INIT_LIST_HEAD(&rcu_torture_freelist);
 	for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++) {
 		rcu_tortures[i].rtort_mbtest = 0;
 		list_add_tail(&rcu_tortures[i].rtort_free,
-- 
2.7.4

