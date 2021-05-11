Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF3C43460
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5EB61925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhEKXNm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhEKXNd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 511C861928;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=l2ODT2b2jDRnJSM5BFnJSJnMC9NUkRoHYF0DAJPidiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhGbN6FIzM4D+C4uoKHanOn2oUYpxCsb0DqPS3Vr+DjCiGpWd5L9DN4MErCFGcmdd
         mn5xYR4GlwEGRVnZYLZcOrelPao0oFv8XnQKqRU+Jdhtz4Tfg7kMgHIxFdMmNw1TXb
         Daf+MxD7pX5Pm6o5sb/0mnACKDd34W8PDBQH+mTgv8X+ajuaDZw+55uj5P3YgtAsfN
         g7iJxEQ0dN7E7f2MkRiMabUFJdtvqMu3Dt5T+I2VnEGPUZipkXS+ZFjVy6qh6+n1yA
         YFsLJrtmAV4v1wT+q3vtQyZR2yiN0kUUaDD0TaAQcjK14CmrTRjg4sHYmat5a3GE2a
         +/3hKz0SRpuuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 84D175C0E1E; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/26] torture: Correctly fetch number of CPUs for non-English languages
Date:   Tue, 11 May 2021 16:12:12 -0700
Message-Id: <20210511231223.2895398-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Grepping for "CPU" on lscpu output isn't always successful, depending
on the local language setting.  As a result, the build can be aborted
early with:

	"make: the '-j' option requires a positive integer argument"

This commit therefore uses the human-language-independent approach
available via the getconf command, both in kvm-build.sh and in
kvm-remote.sh.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-build.sh  | 2 +-
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 55f4fc102624..5ad973dca820 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -42,7 +42,7 @@ then
 fi
 
 # Tell "make" to use double the number of real CPUs on the build system.
-ncpus="`lscpu | grep '^CPU(' | awk '{ print $2 }'`"
+ncpus="`getconf _NPROCESSORS_ONLN`"
 make -j$((2 * ncpus)) $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
 retval=$?
 if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | egrep -q "Stop|Error|error:|warning:" || egrep -q "Stop|Error|error:" < $resdir/Make.out
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index c4859fca87b2..f08d415d4f99 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -136,7 +136,7 @@ chmod +x $T/bin/kvm-remote-*.sh
 # Check first to avoid the need for cleanup for system-name typos
 for i in $systems
 do
-	ncpus="`ssh $i lscpu | grep '^CPU(' | awk '{ print $2 }'`"
+	ncpus="`ssh $i getconf _NPROCESSORS_ONLN 2> /dev/null`"
 	echo $i: $ncpus CPUs " " `date` | tee -a "$oldrun/remote-log"
 	ret=$?
 	if test "$ret" -ne 0
-- 
2.31.1.189.g2e36527f23

