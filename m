Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D05C43217
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6883E23125
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbhAFRd1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbhAFRcn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABF5A2312F;
        Wed,  6 Jan 2021 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954282;
        bh=6qqITg7nkLW4xuFiJFwM8Dt+st1KEQZM1jvcR3+HJI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fT9c72yYmGWMKImDu38uYi4R6R/DRunWN4EldVKcdgJKSZpaflUzLuLI0lCKWgBAM
         CCZ9OCtOXV7xa/0YWxPfBrroUTc+oz7FTjupxvOVA4D2maDGEPFCbO7X+tZrCpxXil
         AYGcaME26ho7w0a9rJ3NKS3DFr60RE8K0w307N5s37DKRtcxJdKusvuNB4CUJSMsFq
         lMBTfCnIBgdpx7Mhn/FC8yXH5Pzs9IxtlBAVndQ/0U5M8UcJwh6jRBmjQL+5L+75Qh
         jXLvu9CEt6lSIScQbvIb9Q9Z8lomYEu3g/E/4vpDWAYoacx2hJM5MhmZpj4eb+JybW
         DQAzaehV+DSKg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/18] torture: Create doyesno helper function for torture.sh
Date:   Wed,  6 Jan 2021 09:31:11 -0800
Message-Id: <20210106173119.23159-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit saves a few lines of code by creating a doyesno helper bash
function for argument parsing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 78 ++++++-----------------
 1 file changed, 19 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index a3c3c25..a01079e 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -47,6 +47,16 @@ do_kvfree=yes
 do_kasan=yes
 do_kcsan=no
 
+# doyesno - Helper function for yes/no arguments
+function doyesno () {
+	if test "$1" = "$2"
+	then
+		echo yes
+	else
+		echo no
+	fi
+}
+
 usage () {
 	echo "Usage: $scriptname optional arguments:"
 	echo "       --doall"
@@ -79,44 +89,19 @@ do
 		do_kcsan=yes
 		;;
 	--do-allmodconfig|--do-no-allmodconfig)
-		if test "$1" = --do-allmodconfig
-		then
-			do_allmodconfig=yes
-		else
-			do_allmodconfig=no
-		fi
+		do_allmodconfig=`doyesno "$1" --do-allmodconfig`
 		;;
 	--do-kasan|--do-no-kasan)
-		if test "$1" = --do-kasan
-		then
-			do_kasan=yes
-		else
-			do_kasan=no
-		fi
+		do_kasan=`doyesno "$1" --do-kasan`
 		;;
 	--do-kcsan|--do-no-kcsan)
-		if test "$1" = --do-kcsan
-		then
-			do_kcsan=yes
-		else
-			do_kcsan=no
-		fi
+		do_kcsan=`doyesno "$1" --do-kcsan`
 		;;
 	--do-kvfree|--do-no-kvfree)
-		if test "$1" = --do-kvfree
-		then
-			do_kvfree=yes
-		else
-			do_kvfree=no
-		fi
+		do_kvfree=`doyesno "$1" --do-kvfree`
 		;;
 	--do-locktorture|--do-no-locktorture)
-		if test "$1" = --do-locktorture
-		then
-			do_locktorture=yes
-		else
-			do_locktorture=no
-		fi
+		do_locktorture=`doyesno "$1" --do-locktorture`
 		;;
 	--do-none)
 		do_allmodconfig=no
@@ -130,36 +115,16 @@ do
 		do_kcsan=no
 		;;
 	--do-rcuscale|--do-no-rcuscale)
-		if test "$1" = --do-rcuscale
-		then
-			do_rcuscale=yes
-		else
-			do_rcuscale=no
-		fi
+		do_rcuscale=`doyesno "$1" --do-rcuscale`
 		;;
 	--do-rcutorture|--do-no-rcutorture)
-		if test "$1" = --do-rcutorture
-		then
-			do_rcutorture=yes
-		else
-			do_rcutorture=no
-		fi
+		do_rcutorture=`doyesno "$1" --do-rcutorture`
 		;;
 	--do-refscale|--do-no-refscale)
-		if test "$1" = --do-refscale
-		then
-			do_refscale=yes
-		else
-			do_refscale=no
-		fi
+		do_refscale=`doyesno "$1" --do-refscale`
 		;;
 	--do-scftorture|--do-no-scftorture)
-		if test "$1" = --do-scftorture
-		then
-			do_scftorture=yes
-		else
-			do_scftorture=no
-		fi
+		do_scftorture=`doyesno "$1" --do-scftorture`
 		;;
 	--duration)
 		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(m\|h\|d\|\)$' '^error'
@@ -363,11 +328,6 @@ fi
 exit $ret
 
 # @@@
-# RCU CPU stall warnings?
-# scftorture warnings?
 # Need a way for the invoker to specify clang.  Maybe --kcsan-kmake or some such.
-# Work out --configs based on number of available CPUs?
-# Need to sense CPUs to size scftorture run.  Ditto rcuscale and refscale.
 # --kconfig as with --bootargs (Both have overrides.)
 # Command line parameters for --bootargs, --config, --kconfig, --kmake-arg, and --qemu-arg
-# Ensure that build failures count as failures
-- 
2.9.5

