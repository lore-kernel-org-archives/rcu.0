Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BCCC433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A56323120
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbhAFR1J (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:27:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbhAFR1I (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D34C23139;
        Wed,  6 Jan 2021 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953970;
        bh=ubUzOi0XP9VmEKsmFjHM+O62jWvi+29MTxhncRfTNcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIMVe4m0wPmesFRi6uUQpoVjdnHnHggiLPz+FKWWE9oS2v5iMl1JhU+Ve7w1ju4ev
         aS7vdMduARNuV3Eh1yYMhezocGtuyXVfyJLqRTQCSqSW+xdnojJ+xw76mDvJkKGll3
         FJ4rKI1NGS+/jWMpGBsbKglvdZ2OU6T+1dyK3SqVisja/9VL15UlxF3q65ROHptXtl
         IY7mGmMJAgilfMjoIA/WAZ/nD3yLpcL4KGb0M2WJ6J+qZPZ9AA7H6zus9NzLSS48ll
         RHHv+VyCElYyFiDF3/7EzJB0M4viA8KcMJIIVohFyzgcwmf8egu6rUzVxFSWIUZXC+
         FosKW2gPUiD4A==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/20] torture: Prepare for splitting qemu execution from kvm-test-1-run.sh
Date:   Wed,  6 Jan 2021 09:25:52 -0800
Message-Id: <20210106172607.22816-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Distributed execution of rcutorture is eased if the qemu execution can
be split from the building of the kernel, as this allows target systems
to be used that are not set up to build kernels.  It also avoids issues
with toolchain version skew across the cluster, aside of course from
qemu and KVM version skew.

This commit therefore records needed data as comments in the qemu-cmd file
and moves recording of the starting time to just before qemu is launched.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 3cd03d0..4bc0e62 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -125,7 +125,6 @@ seconds=$4
 qemu_args=$5
 boot_args=$6
 
-kstarttime=`gawk 'BEGIN { print systime() }' < /dev/null`
 if test -z "$TORTURE_BUILDONLY"
 then
 	echo ' ---' `date`: Starting kernel
@@ -158,6 +157,8 @@ then
 	boot_args="$boot_args $TORTURE_BOOT_GDB_ARG"
 fi
 echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" $TORTURE_QEMU_GDB_ARG > $resdir/qemu-cmd
+echo "# TORTURE_SHUTDOWN_GRACE=$TORTURE_SHUTDOWN_GRACE" >> $resdir/qemu-cmd
+echo "# seconds=$seconds" >> $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
@@ -174,6 +175,7 @@ echo 'echo $! > $resdir/qemu_pid' >> $T/qemu-cmd
 echo "NOTE: $QEMU either did not run or was interactive" > $resdir/console.log
 
 # Attempt to run qemu
+kstarttime=`gawk 'BEGIN { print systime() }' < /dev/null`
 ( . $T/qemu-cmd; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
 commandcompleted=0
 if test -z "$TORTURE_KCONFIG_GDB_ARG"
-- 
2.9.5

