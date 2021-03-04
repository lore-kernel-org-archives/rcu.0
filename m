Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ACCC433E9
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6BE64F35
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhCDBBB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448484AbhCDAZz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:25:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E65B364E67;
        Thu,  4 Mar 2021 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817395;
        bh=TtJbQpgH9nZfTHCrjhHp+Tq+zDCTjyv92rxpD0H+L50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mby3q7MRHkNPqovc3cbVbBT1jQDE12CuxaZF3yp0AlkQmAM2kd5P7v6+FTz3stYda
         Bhppo0GPjr3UTXMFYRaJWB7PFm4hnQFYrer4OloDcc5uViH9cZdk5LRdQmoImQ9Kv8
         x4jZfHx0XqkoqZs3BUioz2GvYwssenAypyVkzBlVKNGw6J25iEA1yVoNsF6ChIdwmq
         zkMTNCwdzTBvGJuTYmhKPjJOiS0BPeNsIhRH+UypSQ9xTtT+0tz33QvcBRPbGveH/l
         aNKfDytztO9WKQlllAPZCWaBF1hN0vjIFTGBmvqwK5XagAeHPE2oB7UUahXnTrOdNI
         P9CoimAJlaSuQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/12] rcu: Make nocb_nobypass_lim_per_jiffy static
Date:   Wed,  3 Mar 2021 16:23:07 -0800
Message-Id: <20210304002311.23655-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002225.GA23492@paulmck-ThinkPad-P72>
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

RCU triggerse the following sparse warning:

kernel/rcu/tree_plugin.h:1497:5: warning: symbol
'nocb_nobypass_lim_per_jiffy' was not declared. Should it be static?

This commit therefore makes this variable static.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 93d3938..a1a17ad 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1556,7 +1556,7 @@ early_param("rcu_nocb_poll", parse_rcu_nocb_poll);
  * After all, the main point of bypassing is to avoid lock contention
  * on ->nocb_lock, which only can happen at high call_rcu() rates.
  */
-int nocb_nobypass_lim_per_jiffy = 16 * 1000 / HZ;
+static int nocb_nobypass_lim_per_jiffy = 16 * 1000 / HZ;
 module_param(nocb_nobypass_lim_per_jiffy, int, 0);
 
 /*
-- 
2.9.5

