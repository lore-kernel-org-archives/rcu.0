Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975A9C433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673F520781
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871710;
	bh=JWeEvxY1czQrY61YbGMme47ATcktCscWlySH9PAuJx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vLViNpRv/9941HzWQO74ipqbZCG201psCQVPsy1fUs97mX27Uzn1YjdWraJjAyJ5g
	 +xcMYSYqWtJvx0W6cYgKVGV+L/XZxkXTIMQ0rwe+vKD7fPm8CfzdAyVjsbgpwV2GIh
	 t2TQUd19l2jeHCwkFYQs2OQNH8txqgYlGT6B/F2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbgFWAVu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730309AbgFWAVu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6759F20720;
        Tue, 23 Jun 2020 00:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871709;
        bh=JWeEvxY1czQrY61YbGMme47ATcktCscWlySH9PAuJx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXfDUHGRwuP4kp7TtjbOR9fftgnIgYmmDwobs5wuU23smBfmfpIoi/7reD0VHi8EN
         arMdotaPsa4GT/pwxTCnKaUxrqT+JJlCg6Vji6bGiiy0Z8DScRor2pxrhbR9jeNVhH
         RRMP7xB7rcI4H5Hp4E+v0ZyKeLuxUjyIYocsDXyo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Wei Yang <richard.weiyang@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/26] rcu: Initialize and destroy rcu_synchronize only when necessary
Date:   Mon, 22 Jun 2020 17:21:22 -0700
Message-Id: <20200623002147.25750-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Wei Yang <richard.weiyang@gmail.com>

The __wait_rcu_gp() function unconditionally initializes and cleans up
each element of rs_array[], whether used or not.  This is slightly
wasteful and rather confusing, so this commit skips both initialization
and cleanup for duplicate callback functions.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 84843ad..f5a82e1 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -390,13 +390,14 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 			might_sleep();
 			continue;
 		}
-		init_rcu_head_on_stack(&rs_array[i].head);
-		init_completion(&rs_array[i].completion);
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
 				break;
-		if (j == i)
+		if (j == i) {
+			init_rcu_head_on_stack(&rs_array[i].head);
+			init_completion(&rs_array[i].completion);
 			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
+		}
 	}
 
 	/* Wait for all callbacks to be invoked. */
@@ -407,9 +408,10 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
 				break;
-		if (j == i)
+		if (j == i) {
 			wait_for_completion(&rs_array[i].completion);
-		destroy_rcu_head_on_stack(&rs_array[i].head);
+			destroy_rcu_head_on_stack(&rs_array[i].head);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(__wait_rcu_gp);
-- 
2.9.5

