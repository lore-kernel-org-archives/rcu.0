Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B975C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1765E64EA4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbhCDBBk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452932AbhCDAji (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75AEB64F16;
        Thu,  4 Mar 2021 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818295;
        bh=mEWfg2Z8xmiNkHpp4+qzerIdI4Ugb1hHR/8FbKRjaQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSkHT+TmOZMVQrvgjlKEL/GKyWbLpfU9WTGM2mQfbfgrjIulCnr3EzkQh723B9B0M
         fiv64CuNyP2FlqZSuG2AV+3QUfDlkLElwBb7kgOyuJkySBIxbw4BRK5DltCm8st+Mf
         biFx2V42dwI89nNeyzHyrMRhF1oXkFOT5Z0AoHPA5cyS4svn2JBDX3xHbkeUaXPAA2
         GHauu1oyNQzx+PtCi+7hq8J2pRpsNn8mF5cyoGerhROS8HD7Rzc9wAVrTJXeVSMlQX
         AWatVYCJZRXZR+l5hTKGWDpR2ohml/ebCrD7sXXp1qVH8EmUUL7Ne7uL+CTogcDHiS
         CBL8upqxqtxCg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/28] torture: Abstract jitter.sh start/stop into scripts
Date:   Wed,  3 Mar 2021 16:37:56 -0800
Message-Id: <20210304003812.24833-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit creates jitterstart.sh and jitterstop.sh scripts that handle
the starting and stopping of the jitter.sh scripts.  These must be sourced
using the bash "." command to allow the generated script to wait on the
backgrounded jitter.sh scripts.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/jitterstart.sh        | 37 ++++++++++++++++++++++
 .../testing/selftests/rcutorture/bin/jitterstop.sh | 23 ++++++++++++++
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  7 ++--
 3 files changed, 62 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/bin/jitterstart.sh
 create mode 100644 tools/testing/selftests/rcutorture/bin/jitterstop.sh

diff --git a/tools/testing/selftests/rcutorture/bin/jitterstart.sh b/tools/testing/selftests/rcutorture/bin/jitterstart.sh
new file mode 100644
index 0000000..9fe3e83
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/jitterstart.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Start up the specified number of jitter.sh scripts in the background.
+#
+# Usage: . jitterstart.sh n jittering-dir duration [ sleepmax [ spinmax ] ]
+#
+# n: Number of jitter.sh scripts to start up.
+# jittering-dir: Directory in which to put "jittering" file.
+# duration: Time to run in seconds.
+# sleepmax: Maximum microseconds to sleep, defaults to one second.
+# spinmax: Maximum microseconds to spin, defaults to one millisecond.
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+jitter_n=$1
+if test -z "$jitter_n"
+then
+	echo jitterstart.sh: Missing count of jitter.sh scripts to start.
+	exit 33
+fi
+jittering_dir=$2
+if test -z "$jittering_dir"
+then
+	echo jitterstart.sh: Missing directory in which to place jittering file.
+	exit 34
+fi
+shift
+shift
+
+touch ${jittering_dir}jittering
+for ((jitter_i = 1; jitter_i <= $jitter_n; jitter_i++))
+do
+	jitter.sh $jitter_i "${jittering_dir}jittering" "$@" &
+done
diff --git a/tools/testing/selftests/rcutorture/bin/jitterstop.sh b/tools/testing/selftests/rcutorture/bin/jitterstop.sh
new file mode 100644
index 0000000..b70d1f4
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/jitterstop.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Remove the "jittering" file, signaling the jitter.sh scripts to stop,
+# then wait for them to terminate.
+#
+# Usage: . jitterstop.sh jittering-dir
+#
+# jittering-dir: Directory containing "jittering" file.
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+jittering_dir=$1
+if test -z "$jittering_dir"
+then
+	echo jitterstop.sh: Missing directory in which to place jittering file.
+	exit 34
+fi
+
+rm -f ${jittering_dir}jittering
+wait
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index a2ee3f2..d6973e4 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -502,15 +502,12 @@ function dump(first, pastlast, batchnum)
 	print "if test -n \"$needqemurun\""
 	print "then"
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
-	print "\ttouch " rd "jittering"
-	for (j = 0; j < njitter; j++)
-		print "\tjitter.sh " j " " rd "jittering " dur " " ja[2] " " ja[3] "&"
+	print "\t. jitterstart.sh " njitter " " rd " " dur " " ja[2] " " ja[3]
 	print "\twhile ls $runfiles > /dev/null 2>&1"
 	print "\tdo"
 	print "\t\t:"
 	print "\tdone"
-	print "\trm -f " rd "jittering"
-	print "\twait"
+	print "\t. jitterstop.sh " rd
 	print "\techo ---- All kernel runs complete. `date` | tee -a " rd "log";
 	print "else"
 	print "\twait"
-- 
2.9.5

