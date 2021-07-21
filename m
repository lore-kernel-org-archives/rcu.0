Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99758C6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848306124C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGUUVS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE5F161377;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=G8La4NjHWKPC8j0EAHrMvvJRJqzlGgBYRKyw0zCFXlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEi2XzbQmgMkU4DhTsupSx7R/DqXioYuBMYxF+MHmnbD2TOzCCqvuArzqmbV3urvT
         Fzw4BqSC06cQrhqZy1nYWp/0AFW8q9dIXAtlwf5F7b6wtpOmCgLn6bva5clNyRXG8K
         jDF2ttHgXY3kZyONEP2RexHg5+1eGs9bt5ERpeafknSZfnUxPxNECrCSoAAtDM3lV6
         cFsKHheW7gvNuYljsFPYfrQEWEfjxY62A2GRHcSQsJwh8lLyiEmkj81LdLM61+geVq
         u91fmwj+cbalofEBVIuYZwMDXv5IWYf8dfKQxk2RibGOEFAju4Go0gu4SvtMtSMV3H
         6KOrc/tGVoZfA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EBC1F5C259B; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 19/21] torture: Don't use "test" command's "-a" argument
Date:   Wed, 21 Jul 2021 14:01:38 -0700
Message-Id: <20210721210140.787717-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There was a time long ago when the "test" command's documentation
claimed that the "-a" and "-o" arguments did something useful.
But this documentation now suggests letting the shell execute
these boolean operators, so this commit applies that suggestion to
kvm-test-1-run-qemu.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-test-1-run-qemu.sh    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index d828a34b5b89f..ca1d49c1c2f45 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -89,7 +89,7 @@ then
 fi
 while :
 do
-	if test -z "$qemu_pid" -a -s "$resdir/qemu-pid"
+	if test -z "$qemu_pid" && test -s "$resdir/qemu-pid"
 	then
 		qemu_pid=`cat "$resdir/qemu-pid"`
 	fi
@@ -122,11 +122,11 @@ do
 		break
 	fi
 done
-if test -z "$qemu_pid" -a -s "$resdir/qemu-pid"
+if test -z "$qemu_pid" && test -s "$resdir/qemu-pid"
 then
 	qemu_pid=`cat "$resdir/qemu-pid"`
 fi
-if test $commandcompleted -eq 0 -a -n "$qemu_pid"
+if test $commandcompleted -eq 0 && test -n "$qemu_pid"
 then
 	if ! test -f "$resdir/../STOP.1"
 	then
@@ -159,11 +159,11 @@ then
 		then
 			last_ts=0
 		fi
-		if test "$newline" != "$oldline" -a "$last_ts" -lt $((seconds + $TORTURE_SHUTDOWN_GRACE))
+		if test "$newline" != "$oldline" && test "$last_ts" -lt $((seconds + $TORTURE_SHUTDOWN_GRACE))
 		then
 			must_continue=yes
 		fi
-		if test $must_continue = no -a $kruntime -ge $((seconds + $TORTURE_SHUTDOWN_GRACE))
+		if test $must_continue = no && test $kruntime -ge $((seconds + $TORTURE_SHUTDOWN_GRACE))
 		then
 			echo "!!! PID $qemu_pid hung at $kruntime vs. $seconds seconds" >> $resdir/Warnings 2>&1
 			kill -KILL $qemu_pid
-- 
2.31.1.189.g2e36527f23

