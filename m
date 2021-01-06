Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916F4C43332
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1A423125
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbhAFRcS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:32:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbhAFRcS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C82D82313B;
        Wed,  6 Jan 2021 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954281;
        bh=l1rcZ3KArVbgksJGpiEqnOIXkO4v8BLPE4GdJgjbA50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kajb5KvK1L4U7h/M0uprpR7kBIx/b1/kh8nFkaO+Cx8CxsLo8nQ7DDdv/fFbc2GC9
         xSWIMWTpMXXeemWr2RVmQNlPfeqXKcqUEuCeMyGlqtidKFl9l20GMEOPhNHHMmbwcq
         HmBZS/eYwuJZUELPGGAVq8RAL+OL2Cr6MjSQYIV+msX7Je69NekLcwaMYYzhLWAuoz
         K0URc8x3RDi+uGI6C7jTzYRQRioDa8la0m2CmMtBS4acXh7sS5RHhpj2huW88TDD/C
         vB2BoTAUmTgET/2kB/MGL1Mx+WhMJBqO5+LZth+E4YOlMk7alCT8AptIxING+tiN6R
         YhhCjGB6JbA+g==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/18] torture: Add "make allmodconfig" to torture.sh
Date:   Wed,  6 Jan 2021 09:31:06 -0800
Message-Id: <20210106173119.23159-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the ability to do "make allmodconfig" to torture.sh,
given that normal rcutorture runs do not normally catch missing exports.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 37 ++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 0bd8e84..57f2f31 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -17,6 +17,9 @@ KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
 PATH=${KVM}/bin:$PATH; export PATH
 . functions.sh
 
+TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
+MAKE_ALLOTED_CPUS=$((TORTURE_ALLOTED_CPUS*2))
+
 # Default duration and apportionment.
 duration_base=10
 duration_rcutorture_frac=7
@@ -24,6 +27,7 @@ duration_locktorture_frac=1
 duration_scftorture_frac=2
 
 # "yes" or "no" parameters
+do_allmodconfig=yes
 do_rcutorture=yes
 do_locktorture=yes
 do_scftorture=yes
@@ -36,6 +40,7 @@ do_kcsan=no
 usage () {
 	echo "Usage: $scriptname optional arguments:"
 	echo "       --doall"
+	echo "       --doallmodconfig / --do-no-allmodconfig"
 	echo "       --do-kasan / --do-no-kasan"
 	echo "       --do-kcsan / --do-no-kcsan"
 	echo "       --do-kvfree / --do-no-kvfree"
@@ -53,6 +58,7 @@ while test $# -gt 0
 do
 	case "$1" in
 	--doall)
+		do_allmodconfig=yes
 		do_rcutorture=yes
 		do_locktorture=yes
 		do_scftorture=yes
@@ -62,6 +68,14 @@ do
 		do_kasan=yes
 		do_kcsan=yes
 		;;
+	--do-allmodconfig|--do-no-allmodconfig)
+		if test "$1" = --do-allmodconfig
+		then
+			do_allmodconfig=yes
+		else
+			do_allmodconfig=no
+		fi
+		;;
 	--do-kasan|--do-no-kasan)
 		if test "$1" = --do-kasan
 		then
@@ -95,6 +109,7 @@ do
 		fi
 		;;
 	--do-none)
+		do_allmodconfig=no
 		do_rcutorture=no
 		do_locktorture=no
 		do_scftorture=no
@@ -242,6 +257,26 @@ function torture_set {
 	fi
 }
 
+# make allmodconfig
+if test "$do_allmodconfig" = "yes"
+then
+	echo " --- allmodconfig:" Start `date` | tee -a $T/log
+	amcdir="tools/testing/selftests/rcutorture/res/$ds/allmodconfig"
+	mkdir -p "$amcdir"
+	make -j$MAKE_ALLOTED_CPUS clean > "$amcdir/Make.out" 2>&1
+	make -j$MAKE_ALLOTED_CPUS allmodconfig > "$amcdir/Make.out" 2>&1
+	make -j$MAKE_ALLOTED_CPUS > "$amcdir/Make.out" 2>&1
+	retcode="$?"
+	echo $retcode > "$amcdir/Make.exitcode"
+	if test "$retcode" == 0
+	then
+		echo "allmodconfig($retcode)" $amcdir >> $T/successes
+	else
+		echo "allmodconfig($retcode)" $amcdir >> $T/failures
+	fi
+fi
+
+# --torture rcu
 if test "$do_rcutorture" = "yes"
 then
 	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
@@ -320,7 +355,7 @@ exit $ret
 # @@@
 # RCU CPU stall warnings?
 # scftorture warnings?
-# Need a way for the invoker to specify clang.
+# Need a way for the invoker to specify clang.  Maybe --kcsan-kmake or some such.
 # Work out --configs based on number of available CPUs?
 # Need to sense CPUs to size scftorture run.  Ditto rcuscale and refscale.
 # --kconfig as with --bootargs (Both have overrides.)
-- 
2.9.5

