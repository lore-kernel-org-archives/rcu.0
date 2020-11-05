Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7733C4742C
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDFB2073A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620048;
	bh=HzwUWY2YZpUynALsoJs6v6eJGIe4fiNOIxvviiTKnro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E+oBJpjM2gNWmJdgm80kP9zGNqeW3NbxzN/7Da3Eb+yI4A905WMhxO7ONXRQZWJav
	 z+F46g1yYlwPsz3j21wMFrmsmQIz8mTR8H4gbjopIAUbtkpA7KGBLdmO/hJtsA+cpe
	 TAyq9Z41DbzDMDJTic+VNncy3lZ85Ezn+s/Tj3v4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732740AbgKEXr2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:47:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732696AbgKEXr1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4703221F8;
        Thu,  5 Nov 2020 23:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620046;
        bh=HzwUWY2YZpUynALsoJs6v6eJGIe4fiNOIxvviiTKnro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFz0NGKXnKM+wvqk4o+HAhGUXUDFHAaX2fcdS+kUJZuD00SXvKfPezQwzKSqHXbvF
         CmevWn7+sgIWlCvJml9D2fdA972Ldl7YJ7nnGufjtCeho/udJOKGZJjTL312pQhVqZ
         MCVNQfpdQ4edxlSUCnuOEZlwWmfR0ATwGhbMePHk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Hou Tao <houtao1@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/28] locktorture: Ignore nreaders_stress if no readlock support
Date:   Thu,  5 Nov 2020 15:47:04 -0800
Message-Id: <20201105234719.23307-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Exclusive locks do not have readlock support, which means that a
locktorture run with the following module parameters will do nothing:

 torture_type=mutex_lock nwriters_stress=0 nreaders_stress=1

This commit therefore rejects this combination for exclusive locks by
returning -EINVAL during module init.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 316531d..046ea2d 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -870,7 +870,8 @@ static int __init lock_torture_init(void)
 		goto unwind;
 	}
 
-	if (nwriters_stress == 0 && nreaders_stress == 0) {
+	if (nwriters_stress == 0 &&
+	    (!cxt.cur_ops->readlock || nreaders_stress == 0)) {
 		pr_alert("lock-torture: must run at least one locking thread\n");
 		firsterr = -EINVAL;
 		goto unwind;
-- 
2.9.5

