Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597FAC43381
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E60C64EF9
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350351AbhCDBBc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452915AbhCDAjR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3115064E6C;
        Thu,  4 Mar 2021 00:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818294;
        bh=z+HGCe//ytSnBPilWbxL+zFrzs9adZeUu8IaNhuNeSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aatqx6AvaCK3YRfsq5dnOMQXkWoLsc7dxJG5cnjq4IXV2wAmdnZdV+Mp9DGddMosz
         2nblAU2oqCnAZzwSuuXfkZui7G6pqR+vSeKw5lEp/P0/5wZN9mWg4RR0yLT0hX54+9
         Cx/Yg+dWF5dECxtelXH4IOp0iXzVcB/R+UCzFodFBTdd4IszWinI1yWXL6HQ/lcU8h
         YmTxpu9yE7ZbAsTGBm8HeKAquKosLf1f1a1HCtic4CedrvuuXciXVzvaSI3+zV1+Zj
         ziZp5Z/jOdRYEUm3DbEiWHTnOFQgR3+Ml9mNAEQdqj9Juyycgwa5u5It5cCItofOni
         KGLl6FKWb5+VA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/28] rcuscale: Disable verbose torture-test output
Date:   Wed,  3 Mar 2021 16:37:49 -0800
Message-Id: <20210304003812.24833-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Given large numbers of threads, the quantity of torture-test output is
sufficient to sometimes result in RCU CPU stall warnings.  The probability
of these stall warnings was greatly reduced by batching the output,
but the warnings were not eliminated.  However, the actual test only
depends on console output that is printed even when rcuscale.verbose=0.
This commit therefore causes this test to run with rcuscale.verbose=0.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
index 0333e9b..ffbe151 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
@@ -12,5 +12,5 @@
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
 	echo $1 rcuscale.shutdown=1 \
-		rcuscale.verbose=1
+		rcuscale.verbose=0
 }
-- 
2.9.5

