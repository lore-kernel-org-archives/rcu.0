Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34574C433E6
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E9D64F76
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350415AbhCDBBi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452930AbhCDAji (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49F8B64F02;
        Thu,  4 Mar 2021 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818295;
        bh=GM2PrsjltRBD3wBg90d7TJLM6WrEzpKzY8afqkGhLhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DhQOnOz3pyKvx8cqre9s1Zb1MRYOtsgleCgH0YcV3x45fKFCOVX4rxt3r9IKE3nPD
         +/tmXNSBAiqPusVVa6wLzlef7I4Xk/JQU2bis1GwEZk7Lw+ZY4P/yUr8X9rw+j8MEV
         MkHZQVSfR27vL4W89UFwzh6B0eZnpcnDqlicnYA554umFRedq1hHumohcpg5zZTl2j
         NIYx4vS5j75Rd0yIUoemmGB/zc2uw9342TR+juJl6epYYOka7+jEjdqrojyC1UksIG
         4q+p/u4CkXIUg24ALQDznvVr4wO7dNhrEdVzNWnije8B70uDOEOiLPJSb0uTH3tT/A
         C7f5qSEpAWsNQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/28] torture: Reverse jittering and duration parameters for jitter.sh
Date:   Wed,  3 Mar 2021 16:37:55 -0800
Message-Id: <20210304003812.24833-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Remote rcutorture testing requires that jitter.sh continue to be
invoked from the generated script for local runs, but that it instead
be invoked on the remote system for distributed runs.  This argues
for common jitterstart and jitterstop scripts.  But it would be good
for jitterstart and jitterstop to control the name and location of the
"jittering" file, while continuing to have the duration controlled by
the caller of these new scripts.

This commit therefore reverses the order of the jittering and duration
parameters for jitter.sh, so that the jittering parameter precedes the
duration parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 6 +++---
 tools/testing/selftests/rcutorture/bin/kvm.sh    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index ed0ea86..ff1d3e4 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -5,7 +5,7 @@
 # of this script is to inflict random OS jitter on a concurrently running
 # test.
 #
-# Usage: jitter.sh me duration jittering-path [ sleepmax [ spinmax ] ]
+# Usage: jitter.sh me jittering-path duration [ sleepmax [ spinmax ] ]
 #
 # me: Random-number-generator seed salt.
 # duration: Time to run in seconds.
@@ -18,8 +18,8 @@
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 me=$(($1 * 1000))
-duration=$2
-jittering=$3
+jittering=$2
+duration=$3
 sleepmax=${4-1000000}
 spinmax=${5-1000}
 
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index de93802..a2ee3f2 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -504,7 +504,7 @@ function dump(first, pastlast, batchnum)
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
 	print "\ttouch " rd "jittering"
 	for (j = 0; j < njitter; j++)
-		print "\tjitter.sh " j " " dur " " rd "jittering " ja[2] " " ja[3] "&"
+		print "\tjitter.sh " j " " rd "jittering " dur " " ja[2] " " ja[3] "&"
 	print "\twhile ls $runfiles > /dev/null 2>&1"
 	print "\tdo"
 	print "\t\t:"
-- 
2.9.5

