Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14401C43331
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65E623136
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhAFR1t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbhAFR1b (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3C3723158;
        Wed,  6 Jan 2021 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953971;
        bh=abfsuKOb4RPwpjDTNoqKqxStIBUtvA05Dj8OdY0hLeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lWL53EvFe8TyRwjJU4KuMhKqOMzYrLrqJ5fXzd0+rPlk+ZG48k5Kmh0wpiL7qJcYt
         +JnHJ0rH6GQhJzo14SMIoo2e02XjZsdeLZSxcKVnT8AU56JvZnZsynxEswvOWPd5Ea
         nmyKLGqr9KNiMcixwGLoxZCjBBFK00BpL+R0psJ2H3af/Duvrx/ZZO4APcjjBP78/i
         /UHhO6G7+pv0XDOt/BURQ/wW0x1nJ2I8A3gQfrxacM0FlAh7k4LtUtbdZSV9RPGDXj
         a911XL8xZ4S3foNrfJjBTejbNLWYCInanbIexasxcuKPVDyk8R71PK7HBPGvIpcx8A
         QN/abgaYPHJdg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/20] torture: Add kvm.sh test summary to end of log file
Date:   Wed,  6 Jan 2021 09:26:00 -0800
Message-Id: <20210106172607.22816-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the test summary to the end of the log in the top-level
directory containing the kvm.sh test artifacts.  While in the area, it adds
the kvm.sh exit code to this test summary.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 472929c..667896f 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -527,15 +527,18 @@ END {
 }' >> $T/script
 
 cat << '___EOF___' >> $T/script
-echo
-echo
-echo " --- `date` Test summary:"
+echo | tee -a $TORTURE_RESDIR/log
+echo | tee -a $TORTURE_RESDIR/log
+echo " --- `date` Test summary:" | tee -a $TORTURE_RESDIR/log
 ___EOF___
 cat << ___EOF___ >> $T/script
-echo Results directory: $resdir/$ds
-kcsan-collapse.sh $resdir/$ds
-kvm-recheck.sh $resdir/$ds
+echo Results directory: $resdir/$ds | tee -a $resdir/$ds/log
+kcsan-collapse.sh $resdir/$ds | tee -a $resdir/$ds/log
+kvm-recheck.sh $resdir/$ds > $T/kvm-recheck.sh.out 2>&1
 ___EOF___
+echo 'ret=$?' >> $T/script
+echo "cat $T/kvm-recheck.sh.out | tee -a $resdir/$ds/log" >> $T/script
+echo 'exit $ret' >> $T/script
 
 if test "$dryrun" = script
 then
@@ -556,9 +559,9 @@ then
 	exit 0
 else
 	# Not a dryrun, so run the script.
-	sh $T/script
+	bash $T/script
 	ret=$?
-	echo " --- Done at `date` (`get_starttime_duration $starttime`)"
+	echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a $resdir/$ds/log
 	exit $ret
 fi
 
-- 
2.9.5

