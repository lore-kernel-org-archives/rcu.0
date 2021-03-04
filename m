Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091F2C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0C264F38
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351455AbhCDBBm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452949AbhCDAjx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28C6864F4C;
        Thu,  4 Mar 2021 00:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818298;
        bh=bo1U1k07T+WKwJCBwy2Q0vfSngbVDIZCIR70TzZJwvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDqAdcLIPVI4Gcaqd73nS4ywoRcOqCjLtuZwVYyc/4jZXQODZV372gQ9x5bVvmCAz
         8tblcNXIFdEoNT4rtzQNJH+M3sACsaxMgeVGJ8GGCUkXsFl3/yOGGogHjKZPPL0t0K
         ku24x5CpnBwULNA5mtFn4oSfS+CNJHgstQHbLyO8tNY3Y/Tj5+Cvt4Jr+a7jHmSvJS
         FYCzLZUA4gYZn1n2AvpYsEGbMCYXaYBmuXuOB3VFom0Yl3ZkiihuYryyqQNmkyUbE2
         B0VXzfYVTYdeuCkt1A3Cdw4lmeyNFUvHdvz+WFLLqULv6/IJKsyjhUxLqsHWs3Jo7T
         HBtAIXOYi2ojQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 26/28] torture: Print proper vmlinux path for kvm-again.sh runs
Date:   Wed,  3 Mar 2021 16:38:10 -0800
Message-Id: <20210304003812.24833-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The kvm-again.sh script does not copy over the vmlinux files due to
their large size.  This means that a gdb run must use the vmlinux file
from the original "res" directory.  This commit therefore finds that
directory and prints it out so that the user can copy and pasted the
gdb command just as for the initial run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh           | 5 ++++-
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 0407df8..75e6afe 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -159,7 +159,10 @@ do
 	then
 		echo "# seconds=$dur" >> $i
 	fi
-	echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
+	if test -n "$arg_remote"
+	then
+		echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
+	fi
 done
 
 # Extract settings from the last qemu-cmd file transformed above.
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index 576a9b7..5b1aa2a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -67,7 +67,11 @@ then
 	base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
 	if ! test -f $base_resdir/vmlinux
 	then
-		base_resdir=/path/to
+		base_resdir="`cat re-run`/$resdir"
+		if ! test -f $base_resdir/vmlinux
+		then
+			base_resdir=/path/to
+		fi
 	fi
 	echo Waiting for you to attach a debug session, for example: > /dev/tty
 	echo "    gdb $base_resdir/vmlinux" > /dev/tty
-- 
2.9.5

