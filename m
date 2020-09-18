Return-Path: <SRS0=xZUe=C3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377F2C43464
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 11:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038D822208
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 11:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIRLhj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:37:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13259 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbgIRLhj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Sep 2020 07:37:39 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6D142A4D0735F1DBFD98;
        Fri, 18 Sep 2020 19:37:35 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 19:37:29 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Josh Triplett <josh@joshtriplett.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
        <houtao1@huawei.com>
Subject: [PATCH v2 1/2] locktorture: doesn't check nreaders_stress when no readlock support
Date:   Fri, 18 Sep 2020 19:44:24 +0800
Message-ID: <20200918114424.100852-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
In-Reply-To: <20200918033755.GS29330@paulmck-ThinkPad-P72>
References: <20200918033755.GS29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When do locktorture for exclusive lock which doesn't have readlock
support, the following module parameters will be considered as valid:

 torture_type=mutex_lock nwriters_stress=0 nreaders_stress=1

But locktorture will do nothing useful, so instead of permitting
these useless parameters, let's reject these parameters by returning
-EINVAL during module init.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/locking/locktorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9cfa5e89cff7f..bebdf98e6cd78 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -868,7 +868,8 @@ static int __init lock_torture_init(void)
 		goto unwind;
 	}
 
-	if (nwriters_stress == 0 && nreaders_stress == 0) {
+	if (nwriters_stress == 0 &&
+	    (!cxt.cur_ops->readlock || nreaders_stress == 0)) {
 		pr_alert("lock-torture: must run at least one locking thread\n");
 		firsterr = -EINVAL;
 		goto unwind;
-- 
2.25.0.4.g0ad7144999

