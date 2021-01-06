Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390E3C43381
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18EDE2312F
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbhAFRce (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:32:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbhAFRce (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DED023159;
        Wed,  6 Jan 2021 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954284;
        bh=8TY4I62hyzwhFizire/nMoHvXj4fz0OIjpw4Cg0LEHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iO9XJSYJBDWUWjBB/KQ3X0mQ31qdTINwKhcS7Jw8z/WE3AbaNb3Zz0DauQZxV9CiG
         VXnXkXSS+BqS37asohy46Oo82qF8KnOKc3Enr/ObIWfRwr0tEGaVvbyx6kJHT2VaXR
         sYxYPYBUPXIglNRovGjabuCYIK2nFINNefRRAiRWaHQoPSLtDZ+1zrAkvjcQZNzB4i
         QJOZ2sbToLyCWw0pfIvBZzP2fpW2WSlPdiI8+y3i5ujy2KosAR7+yaLxTCTtdZZQFQ
         DjWd/xDAQoXynSh0BxoMddSw889P3MtGzrq4864IGLTzzkOS+dOi1pIYVAEJYdhsz+
         AkYoAPxFQDqrg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/18] torture: Add --kcsan-kmake-arg to torture.sh for KCSAN
Date:   Wed,  6 Jan 2021 09:31:18 -0800
Message-Id: <20210106173119.23159-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In 2020, running KCSAN often requires careful choice of compiler.
This commit therefore adds a --kcsan-kmake-arg parameter to torture.sh
to allow specifying (for example) "CC=clang" to the kernel build process
to correctly build a KCSAN-enabled kernel.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 90ca736..0867f30 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -34,6 +34,7 @@ fi
 configs_rcutorture=
 configs_locktorture=
 configs_scftorture=
+kcsan_kmake_args=
 
 # Default duration and apportionment.
 duration_base=10
@@ -79,6 +80,7 @@ usage () {
 	echo "       --do-refscale / --do-no-refscale"
 	echo "       --do-scftorture / --do-no-scftorture"
 	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
+	echo "       --kcsan-kmake-arg kernel-make-arguments"
 	exit 1
 }
 
@@ -166,6 +168,11 @@ do
 		duration_base=$(($ts*mult))
 		shift
 		;;
+	--kcsan-kmake-arg|--kcsan-kmake-args)
+		checkarg --kcsan-kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
+		kcsan_kmake_args="`echo "$kcsan_kmake_args $2" | sed -e 's/^ *//' -e 's/ *$//'`"
+		shift
+		;;
 	*)
 		echo Unknown argument $1
 		usage
@@ -269,6 +276,8 @@ function torture_one {
 # Note that quoting is problematic.  So on the command line, pass multiple
 # values with multiple kvm.sh argument instances.
 function torture_set {
+	local cur_kcsan_kmake_args=
+	local kcsan_kmake_tag=
 	local flavor=$1
 	shift
 	curflavor=$flavor
@@ -281,7 +290,12 @@ function torture_set {
 	if test "$do_kcsan" = "yes"
 	then
 		curflavor=${flavor}-kcsan
-		torture_one $* --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --kmake-arg "CC=clang" --kcsan
+		if test -n "$kcsan_kmake_args"
+		then
+			kcsan_kmake_tag="--kmake-args"
+			cur_kcsan_kmake_args="$kcsan_kmake_args"
+		fi
+		torture_one $* --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" $kcsan_kmake_tag $cur_kcsan_kmake_args --kcsan
 	fi
 }
 
@@ -382,8 +396,3 @@ then
 	cp $T/log $tdir
 fi
 exit $ret
-
-# @@@
-# Need a way for the invoker to specify clang.  Maybe --kcsan-kmake or some such.
-# --kconfig as with --bootargs (Both have overrides.)
-# Command line parameters for --bootargs, --config, --kconfig, --kmake-arg, and --qemu-arg
-- 
2.9.5

