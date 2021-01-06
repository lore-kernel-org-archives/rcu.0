Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD193C4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957E823136
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbhAFR1Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:27:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbhAFR1Y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42CA123331;
        Wed,  6 Jan 2021 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953972;
        bh=yMMd62yyNc8bJ1C62oo2KduVedAyxxuUOxTIHhRgCek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1ErYxu4c1WAy5hlz2eJrPB4jC/K/OKy4wAx74GmyE6Y5K96BgR8QJ12ADYSyfHjm
         ZLuGb+PRWbr7JUINe0YGyS3/wMMkt5HvhLVniakfK53AUiwP6Gbcdw9GXcNx5bZko/
         R7Fx0CWZBy6vC89Iicw2rEsQwg2fsqXH1xR3hYlD0kmkYJg7MP0O3YoRqfmOsCdPCy
         qKHXpVIjudpLPRcmRRVXzYPWKOS6xRokbOUOiQ6WLr8Za/xmtw4Uy/y1YRotOBs7NG
         uX88bZGs2WNVqoPC79/LgcUdKe8xK63CGufz/Aofu6qCzTzYDK6fdCXXD4dH1P32Wf
         i8EBQfbeV1R/w==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/20] torture: s/STOP/STOP.1/ to avoid scenario collision
Date:   Wed,  6 Jan 2021 09:26:03 -0800
Message-Id: <20210106172607.22816-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit changes the "STOP" file that is used to cleanly halt a running
rcutorture run to "STOP.1" because no scenario directory will ever end
with ".1".  If there really was a scenario named "STOP", its directories
would instead be named "STOP", "STOP.2", "STOP.3", and so on.  While in
the area, the commit also changes the kernel-run-time checks for this
file to look directly in the directory above $resdir, thus avoiding the
need to pass the TORTURE_STOPFILE environment variable to remote systems.

While in the area, move the STOP.1 file to the top-level directory
covering all of the scenarios.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 8 ++++----
 tools/testing/selftests/rcutorture/bin/kvm.sh            | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 4bc0e62..536d103 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -211,7 +211,7 @@ do
 		if test -n "$TORTURE_KCONFIG_GDB_ARG"
 		then
 			:
-		elif test $kruntime -ge $seconds || test -f "$TORTURE_STOPFILE"
+		elif test $kruntime -ge $seconds || test -f "$resdir/../STOP.1"
 		then
 			break;
 		fi
@@ -254,16 +254,16 @@ then
 fi
 if test $commandcompleted -eq 0 -a -n "$qemu_pid"
 then
-	if ! test -f "$TORTURE_STOPFILE"
+	if ! test -f "$resdir/../STOP.1"
 	then
 		echo Grace period for qemu job at pid $qemu_pid
 	fi
 	oldline="`tail $resdir/console.log`"
 	while :
 	do
-		if test -f "$TORTURE_STOPFILE"
+		if test -f "$resdir/../STOP.1"
 		then
-			echo "PID $qemu_pid killed due to run STOP request" >> $resdir/Warnings 2>&1
+			echo "PID $qemu_pid killed due to run STOP.1 request" >> $resdir/Warnings 2>&1
 			kill -KILL $qemu_pid
 			break
 		fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6b900360..6051868 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -386,7 +386,7 @@ then
 fi
 mkdir -p $resdir/$ds
 TORTURE_RESDIR="$resdir/$ds"; export TORTURE_RESDIR
-TORTURE_STOPFILE="$resdir/$ds/STOP"; export TORTURE_STOPFILE
+TORTURE_STOPFILE="$resdir/$ds/STOP.1"; export TORTURE_STOPFILE
 echo Results directory: $resdir/$ds
 echo $scriptname $args
 touch $resdir/$ds/log
-- 
2.9.5

