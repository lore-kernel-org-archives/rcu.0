Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7E2C433E9
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF9A22BF3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbhAFEud (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:50:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbhAFEuc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6424D23105;
        Wed,  6 Jan 2021 04:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908538;
        bh=5DTWQUXbt6C8g0XsrJcolJeJ9TNHBuGpD7Aav+OtuG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gb9xTumFBbCd+eWJ8ut72/nskVbzD5AFI39PUF9200gWiGwn34E1D8vJjhGvVMiRY
         2PKJM1BQh9YwiUIGRgzIF6OQ5yz0M7D/aMpn0186WBB8pq4Tyid72DjZ3A/wJcCKD0
         6EZqsNM1RRGFk+jPjAEgjkE8Z/vVhOTnjWACE6EBdwOZvvt/GftotYNrhNlTzm8JEv
         TNd8JtDwPTlbwsSRJEN5lbt3rm8XN41AYTNGNGVJsbnmwPJAJ9OyCV0uLHDUMZTz0B
         3WKgtNH8ZGKs6K8IG4Ek8KBnNT+Nm+weTZM810rM7WMy2GH4WVw6j70gTJosX1A/6o
         rJ06kMyp3DTCw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/21] tools/rcutorture: Support nocb toggle in TREE01
Date:   Tue,  5 Jan 2021 20:48:49 -0800
Message-Id: <20210106044853.20812-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This commit adds periodic toggling of 7 of 8 CPUs every second to TREE01
in order to test NOCB toggle code.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
index d6da9a6..40af3df 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
@@ -2,5 +2,7 @@ maxcpus=8 nr_cpus=43
 rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
-rcu_nocbs=0
+rcu_nocbs=0-1,3-7
+rcutorture.nocbs_nthreads=8
+rcutorture.nocbs_toggle=1000
 rcutorture.fwd_progress=0
-- 
2.9.5

