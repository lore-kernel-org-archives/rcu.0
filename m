Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A18C433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C3423135
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbhAFR1Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:27:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbhAFR1Y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E75823159;
        Wed,  6 Jan 2021 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953972;
        bh=JyVBwsvKEgrfSpqv7BpwvNNnxHOXNKBnYtSAE8a7MRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UoaI16ma2v2bA9JY45GXoU2Cw8Ydwht948e4vm1esCJAzviFgX/ZTPOyGjKHwbm9E
         UO55EbfRMAYs4KLF39Mt+u5NieRKMB+33mE2c7z450KslVc0bzGhzgJs7zDDL4cQje
         M5Kxzd4lH82zbINBOIW/wzoWiTZZtXzal3AI1qohdtcYzsS+vppf+ibvXMMqN4okR5
         UNIFEXB1aUkY9tcFXvfRCIr3+6BrnBceVuftvu5ACACW8F3f7R223jQd9FAEHbakf7
         IYa6/NSLS1JFfUYagu5ux2rXB8i9aUioCYBDs7ICfUdqinwM+F0s296EIK6EDvas3E
         V7VkNatdgOIqA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/20] torture: Simplify exit-code plumbing for kvm-recheck.sh and kvm-find-errors.sh
Date:   Wed,  6 Jan 2021 09:26:04 -0800
Message-Id: <20210106172607.22816-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit simplifies exit-code plumbing.  It makes kvm-recheck.sh return
the value 1 for a build error and 2 for a runtime error.  It also makes
kvm-find-errors.sh avoid checking runtime files for --build-only runs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh | 1 +
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index be26598..0670841 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -46,6 +46,7 @@ fi
 if grep -q -e "--buildonly" < ${rundir}/log
 then
 	echo Build-only run, no console logs to check.
+	exit $editorret
 fi
 
 # Find console logs with errors
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 840a467..47cf4db 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -87,15 +87,16 @@ do
 	fi
 done
 EDITOR=echo kvm-find-errors.sh "${@: -1}" > $T 2>&1
-ret=$?
 builderrors="`tr ' ' '\012' < $T | grep -c '/Make.out.diags'`"
 if test "$builderrors" -gt 0
 then
 	echo $builderrors runs with build errors.
+	ret=1
 fi
 runerrors="`tr ' ' '\012' < $T | grep -c '/console.log.diags'`"
 if test "$runerrors" -gt 0
 then
 	echo $runerrors runs with runtime errors.
+	ret=2
 fi
 exit $ret
-- 
2.9.5

