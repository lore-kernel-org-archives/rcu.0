Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC27C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F7664F4E
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351932AbhCDBBq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452966AbhCDAkO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:40:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4149E64F45;
        Thu,  4 Mar 2021 00:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818297;
        bh=E07oIrMZ0Bl3Bh9m+EbhgZfSJL/MS32GkbuJL6K4khg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftGA7T66c97buvPL6NwaS06DXxZWSagq3LC0Sty1eRiEGqYPkj1JvpmmHYwbWztG5
         r0WxHFU6oytrzY9unARTbSR1DWkuhrNfgblVqKReHiS0D5iV9N4QrQwMr8ToyjJlp1
         RpDBMcb6ZGHVEAuStn+S0LtnXAaJ56hxRo3KGGvQgyotdOPfB2DPFAIY0ubslaweeI
         rqC5BM0x6ywtcEJ9xPS5nGx9s+/o6lp0V8Mml9FPXoO+1ZKooyXxgmQbLPvNKn8mUw
         o0TPdyeMeCMshIJSxaIajvQ3YmmmOPx+0R0FVsXCzUjCeZE9+woNtaQNAz6nAR1uP2
         440KqEItOdslg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 21/28] torture: Create a "batches" file for build reuse
Date:   Wed,  3 Mar 2021 16:38:05 -0800
Message-Id: <20210304003812.24833-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit creates a "batches" file in the res/$ds directory, where $ds
is the datestamp.  This file contains the batches and the number of CPUs,
for example:

1 TREE03 16
1 SRCU-P 8
2 TREE07 16
2 TREE01 8
3 TREE02 8
3 TREE04 8
3 TREE05 8
4 SRCU-N 4
4 TRACE01 4
4 TRACE02 4
4 RUDE01 2
4 RUDE01.2 2
4 TASKS01 2
4 TASKS03 2
4 SRCU-t 1
4 SRCU-u 1
4 TASKS02 1
4 TINY01 1
5 TINY02 1
5 TREE09 1

The first column is the batch number, the second the scenario number
(possibly suffixed by a repetition number, as in "RUDE01.2"), and the
third is the number of CPUs required by that scenario.  The last line
shows the number of CPUs expected by this batch file, which allows
the run to be re-batched if a different number of CPUs is available.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 29 ++++++++++++++++-----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index a1cd05c..0add163 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -565,6 +565,18 @@ echo 'ret=$?' >> $T/script
 echo "cat $T/kvm-recheck.sh.out | tee -a $resdir/$ds/log" >> $T/script
 echo 'exit $ret' >> $T/script
 
+# Extract the tests and their batches from the script.
+egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
+	sed -e 's/:.*$//' -e 's/^echo //' -e 's/-ovf//' |
+	awk '
+	/^----Start/ {
+		batchno = $3;
+		next;
+	}
+	{
+		print batchno, $1, $2
+	}' > $T/batches
+
 if test "$dryrun" = script
 then
 	cat $T/script
@@ -583,21 +595,14 @@ then
 	exit 0
 elif test "$dryrun" = batches
 then
-	# Extract the tests and their batches from the script.
-	egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
-		sed -e 's/:.*$//' -e 's/^echo //' -e 's/-ovf//' |
-		awk '
-		/^----Start/ {
-			batchno = $3;
-			next;
-		}
-		{
-			print batchno, $1, $2
-		}'
+	cat $T/batches
+	exit 0
 else
-	# Not a dryrun, so run the script.
+	# Not a dryrun.  Record the batches and the number of CPUs, then run the script.
 	bash $T/script
 	ret=$?
+	cp $T/batches $resdir/$ds/batches
+	echo '#' cpus=$cpus >> $resdir/$ds/batches
 	echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a $resdir/$ds/log
 	exit $ret
 fi
-- 
2.9.5

