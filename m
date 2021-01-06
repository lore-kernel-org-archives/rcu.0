Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A708BC43332
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FEE523123
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbhAFR14 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:27:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbhAFR1t (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1759923329;
        Wed,  6 Jan 2021 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953972;
        bh=GpMOteaVheoDswm1wDRmC+0UKSMNBIdcSYcaOHfd708=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVaYt9LcVTjyqS1lvNdn8sh2oNhV8FjwHlEY/zLeBUmoafUToIhI/QXELh9Xqdich
         5s6SQtV4Fd6ohXgU+EnRzP1Kuzc881l8xH99dEcaWZEWLwUMgdXD2z7J6wgL2rM2Fo
         wbidOlQHCIaUdsZ6BW93GUJx+iohzKmGI/6A5UVF62V6E9QwqgRqVuCWXKxYNdd0xo
         dE7mHUN+SE7SMqYa4BQDkfvq8p3NrzvwYbmTyDNv6vkTDlU8z3aq1GLt2fuih4jc4g
         npZBTFiNptt4+z8gApjoVtane1ok1pjWeXqZEXVMAWUO0oC8kyDa03zGLZ0d9Zt8UM
         WxdujrTxLhbnA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/20] torture: Add --dryrun batches to help schedule a distributed run
Date:   Wed,  6 Jan 2021 09:26:02 -0800
Message-Id: <20210106172607.22816-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

When all of the remote systems have the same number of CPUs, one
approach is to use one "--buildonly" run and one "--dryrun sched" run,
and then distributing the batches out one per remote system.  However,
the output of "--dryrun sched" is not made for parsing, so this commit
adds a "--dryrun batches" that provides the same information in easily
parsed form.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 667896f..6b900360 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -60,7 +60,7 @@ usage () {
 	echo "       --cpus N"
 	echo "       --datestamp string"
 	echo "       --defconfig string"
-	echo "       --dryrun sched|script"
+	echo "       --dryrun batches|sched|script"
 	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
 	echo "       --gdb"
 	echo "       --help"
@@ -126,7 +126,7 @@ do
 		shift
 		;;
 	--dryrun)
-		checkarg --dryrun "sched|script" $# "$2" 'sched\|script' '^--'
+		checkarg --dryrun "batches|sched|script" $# "$2" 'batches\|sched\|script' '^--'
 		dryrun=$2
 		shift
 		;;
@@ -235,7 +235,7 @@ do
 	shift
 done
 
-if test -z "$TORTURE_INITRD" || tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+if test -n "$dryrun" || test -z "$TORTURE_INITRD" || tools/testing/selftests/rcutorture/bin/mkinitrd.sh
 then
 	:
 else
@@ -547,8 +547,7 @@ then
 elif test "$dryrun" = sched
 then
 	# Extract the test run schedule from the script.
-	egrep 'Start batch|Starting build\.' $T/script |
-		grep -v ">>" |
+	egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
 		sed -e 's/:.*$//' -e 's/^echo //'
 	nbuilds="`grep 'Starting build\.' $T/script |
 		  grep -v ">>" | sed -e 's/:.*$//' -e 's/^echo //' |
@@ -557,6 +556,19 @@ then
 	nbatches="`grep 'Start batch' $T/script | grep -v ">>" | wc -l`"
 	echo Total number of batches: $nbatches
 	exit 0
+elif test "$dryrun" = batches
+then
+	# Extract the tests and their batches from the script.
+	egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
+		sed -e 's/:.*$//' -e 's/^echo //' -e 's/-ovf//' |
+		awk '
+		/^----Start/ {
+			batchno = $3;
+			next;
+		}
+		{
+			print batchno, $1, $2
+		}'
 else
 	# Not a dryrun, so run the script.
 	bash $T/script
-- 
2.9.5

