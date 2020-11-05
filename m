Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160EDC56201
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE79D20756
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620121;
	bh=3glb+/dk0Hzr4EQkQdK4DKED+51XAdBnO9GYI/Isp64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=es9oaovoDqg0W0jHCkCuC/v9G+pbUGCfOSXU+zPFwdMnVBtmhv+tWae2wJiaFnL+j
	 4pJZmCkiMZu0L1qvuUvRvbolGvT2BBAmHeRP940rRMl89KfC2jSvE6oR9RSfXUUS45
	 o1yAEkdMENQ7AwD4/jCBEuYdrEh8HbPWBCSMYl7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbgKEXsk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:48:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732706AbgKEXr1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C5822227;
        Thu,  5 Nov 2020 23:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620047;
        bh=3glb+/dk0Hzr4EQkQdK4DKED+51XAdBnO9GYI/Isp64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6MABRMaVxRJ6vvGec3RkRNJkSd/wCgQDIOVS9MZOdXgdYZ51EgG3m/I1zHgCwfM5
         tsKr/4ebP4VglShW98gWqNhjFf7s3jbfUvhwFVPjlwuO7rSZb2x2I7+F1pbvS7lesN
         C7REWVHz32PxBuT6ufcsb5ddoF6/BWyCXib/zIxk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/28] locktorture: Prevent hangs for invalid arguments
Date:   Thu,  5 Nov 2020 15:47:05 -0800
Message-Id: <20201105234719.23307-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

If an locktorture torture-test run is given a bad kvm.sh argument, the
test will complain to the console, which is good.  What is bad is that
from the user's perspective, it will just hang for the time specified
by the --duration argument.  This commit therefore forces an immediate
kernel shutdown if a lock_torture_init()-time error occurs, thus avoiding
the appearance of a hang.  It also forces a console splat in this case
to clearly indicate the presence of an error.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 046ea2d..79fbd97 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/torture.h>
+#include <linux/reboot.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
@@ -1041,6 +1042,10 @@ static int __init lock_torture_init(void)
 unwind:
 	torture_init_end();
 	lock_torture_cleanup();
+	if (shutdown_secs) {
+		WARN_ON(!IS_MODULE(CONFIG_LOCK_TORTURE_TEST));
+		kernel_power_off();
+	}
 	return firsterr;
 }
 
-- 
2.9.5

