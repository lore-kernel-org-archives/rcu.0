Return-Path: <SRS0=Hkx7=5Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D273C2BB86
	for <rcu@archiver.kernel.org>; Thu,  9 Apr 2020 11:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F7420771
	for <rcu@archiver.kernel.org>; Thu,  9 Apr 2020 11:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDILo3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:44:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbgDILo2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 9 Apr 2020 07:44:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D67071A3D8173519489F;
        Thu,  9 Apr 2020 19:44:13 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 19:44:06 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <dave@stgolabs.net>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] rcutorture: make rcu_fwds and rcu_fwd_emergency_stop static
Date:   Thu, 9 Apr 2020 19:42:38 +0800
Message-ID: <20200409114238.39765-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Fix the following sparse warning:

kernel/rcu/rcutorture.c:1695:16: warning: symbol 'rcu_fwds' was not
declared. Should it be static?
kernel/rcu/rcutorture.c:1696:6: warning: symbol 'rcu_fwd_emergency_stop'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5453bd557f43..d621a31de8a4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1692,8 +1692,8 @@ struct rcu_fwd {
 	unsigned long rcu_launder_gp_seq_start;
 };
 
-struct rcu_fwd *rcu_fwds;
-bool rcu_fwd_emergency_stop;
+static struct rcu_fwd *rcu_fwds;
+static bool rcu_fwd_emergency_stop;
 
 static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
 {
-- 
2.17.2

