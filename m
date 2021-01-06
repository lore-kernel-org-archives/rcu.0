Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E8C4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8AF23123
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbhAFR14 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:27:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbhAFR1t (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99CF52313F;
        Wed,  6 Jan 2021 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953972;
        bh=92dtARZzSSK/dKR44zfTbCIH4tdjBsew/EjGVD1hYhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ax8ZMV24MAvgAHrcfY8f6NzrsGj12P7Qz5WnnttXCFNQP6CNvBgoNUyykZGR8PpfB
         dGnQEFh+JpYptvZeiPXehlq9lwVhzddOPTCpSwcLIqcJ8yPdy8eMfdGua59Q8E19Kt
         Ro7pnfIJNEnlIkj67bO9HUgPPimMcb66zBuehNvYaUo68oMcHIIDx7SBzgjJt+j0xy
         YucBfgK026NryH0o5Vu57ijSUBlE+xOe9agspWcr6hutI4IDUE8B3Bk2YqN59UqdbH
         BsxdsApVAvgCnNkNdCWrCD7PFPqfBvy+5ErL/ya4m9SqAxr/JetsnhUxF5WZlhajM8
         nwv5QxhBmPpZA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/20] torture: Remove "Failed to add ttynull console" false positive
Date:   Wed,  6 Jan 2021 09:26:05 -0800
Message-Id: <20210106172607.22816-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Commit 757055ae8ded ("init/console: Use ttynull as a fallback when
there is no console") results in the string "Warning: Failed to add
ttynull console. No stdin, stdout, and stderr for the init process!"
appearing on the console, which the rcutorture scripting interprets as
a warning, which causes every rcutorture run to be flagged.  However,
the rcutorture init process never attempts to do any I/O, and thus does
not care that it has no stdin, stdout, or stderr.

This commit therefore causes the rcutorture scripting to ignore this
message.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/console-badness.sh | 1 +
 tools/testing/selftests/rcutorture/bin/parse-console.sh   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
index 80ae7f0..e6a132d 100755
--- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -14,4 +14,5 @@ egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls o
 grep -v 'ODEBUG: ' |
 grep -v 'This means that this is a DEBUG kernel and it is' |
 grep -v 'Warning: unable to open an initial console' |
+grep -v 'Warning: Failed to add ttynull console. No stdin, stdout, and stderr.*the init process!' |
 grep -v 'NOHZ tick-stop error: Non-RCU local softirq work is pending, handler'
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 263b1be..9f624bd 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -128,7 +128,7 @@ then
 	then
 		summary="$summary  Badness: $n_badness"
 	fi
-	n_warn=`grep -v 'Warning: unable to open an initial console' $file | egrep -c 'WARNING:|Warn'`
+	n_warn=`grep -v 'Warning: unable to open an initial console' $file | grep -v 'Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process' | egrep -c 'WARNING:|Warn'`
 	if test "$n_warn" -ne 0
 	then
 		summary="$summary  Warnings: $n_warn"
-- 
2.9.5

