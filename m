Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2EEC388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741AD2073A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620120;
	bh=Pb07ru45V3MFom76tDtD8Jd0DGP2IJZetTbJEU3yTAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xSSdCAvFUnLsFpWKip0nnEP9irrP8vQ3KhB0t4zPcA2uTtVeng6NkauIDAIYduY1H
	 oPuoHcZLqL98NFq2kw28Qk5LfczBcPy3ZPsKInx0LXoHZ7xTZ0lUPA4bD0HDn57d66
	 j45IPh9sfl8OlkKG3ju4rCHK2tgqi1Um8D4xk5+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbgKEXr1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732672AbgKEXr0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:26 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3823422203;
        Thu,  5 Nov 2020 23:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620046;
        bh=Pb07ru45V3MFom76tDtD8Jd0DGP2IJZetTbJEU3yTAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfDGAGKNf8cYru36Wh7/plhr9yKpfel7v6SGmsPSwmjKn1AAepa1n99ALmJ1XkA0b
         KsBGe+Ti8lVjVvbLWrVjQHwhbhjtO81czsqHKa+SuRzn4xm/wXGLa64QwG7CmTT1aX
         mQrtT8x1D7gi/uKYQOYv/06O75QAoLBF6RSlL0s4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/28] refscale: Prevent hangs for invalid arguments
Date:   Thu,  5 Nov 2020 15:47:02 -0800
Message-Id: <20201105234719.23307-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

If an refscale torture-test run is given a bad kvm.sh argument, the
test will complain to the console, which is good.  What is bad is that
from the user's perspective, it will just hang for the time specified
by the --duration argument.  This commit therefore forces an immediate
kernel shutdown if a ref_scale_init()-time error occurs, thus avoiding
the appearance of a hang.  It also forces a console splat in this case
to clearly indicate the presence of an error.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index fb5f20d..23ff36a 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -658,7 +658,6 @@ ref_scale_init(void)
 		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
 			pr_cont(" %s", scale_ops[i]->name);
 		pr_cont("\n");
-		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_SCALE_TEST));
 		firsterr = -EINVAL;
 		cur_ops = NULL;
 		goto unwind;
@@ -718,6 +717,10 @@ ref_scale_init(void)
 unwind:
 	torture_init_end();
 	ref_scale_cleanup();
+	if (shutdown) {
+		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_SCALE_TEST));
+		kernel_power_off();
+	}
 	return firsterr;
 }
 
-- 
2.9.5

