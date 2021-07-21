Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A505C6377C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E9A6124B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhGUUVO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB7D061376;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=W/T1L4ADquUBBRwfmcfi9/lg/+C05/mq/UKYi2sJkv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMtt8UDMxR0u99FfWXlt2JGsotR04wvdnMzrEGicjH1ZA6DEkSQu4SUfl4C/UtDz4
         rJQ+qimdOYm2WwkF7obJVb4dnyYZ8mH/7N+1BNi4LpPoYNvGr6RZjBDxN2VOt/8+lk
         ZLlMBszX4BLhwgQFF1Lt4aen543lhnUWsNdzIr+meGzRNdU6eIfxylvVaGq6cehunF
         Hmn20jqmjakfmGC0jbxtWOME83RsDVuCtqSX13YeG7bg4yUqkGeKm42/BUp3XfyKr2
         T8DA/o0KSHnpi5dECIjtrHSrp40e8m9EeMp/rwwnIKY++L4x0Mth9mMjlGc99LLnXf
         BbHS8BCrZav1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ED9585C261D; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 20/21] torture: Add timestamps to kvm-test-1-run-qemu.sh output
Date:   Wed, 21 Jul 2021 14:01:39 -0700
Message-Id: <20210721210140.787717-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The kvm-test-1-run-qemu.sh script logs the torture-test start time and
also when it starts getting impatient for the test to finish.  However, it
does not timestamp these log messages, which can make debugging needlessly
challenging.  This commit therefore adds timestamps to these messages.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-test-1-run-qemu.sh    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index ca1d49c1c2f45..b41252033fac0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -63,10 +63,10 @@ then
 	if test -s "$resdir/qemu-pid"
 	then
 		qemu_pid=`cat "$resdir/qemu-pid"`
-		echo Monitoring qemu job at pid $qemu_pid
+		echo Monitoring qemu job at pid $qemu_pid `date`
 	else
 		qemu_pid=""
-		echo Monitoring qemu job at yet-as-unknown pid
+		echo Monitoring qemu job at yet-as-unknown pid `date`
 	fi
 fi
 if test -n "$TORTURE_KCONFIG_GDB_ARG"
@@ -130,14 +130,14 @@ if test $commandcompleted -eq 0 && test -n "$qemu_pid"
 then
 	if ! test -f "$resdir/../STOP.1"
 	then
-		echo Grace period for qemu job at pid $qemu_pid
+		echo Grace period for qemu job at pid $qemu_pid `date`
 	fi
 	oldline="`tail $resdir/console.log`"
 	while :
 	do
 		if test -f "$resdir/../STOP.1"
 		then
-			echo "PID $qemu_pid killed due to run STOP.1 request" >> $resdir/Warnings 2>&1
+			echo "PID $qemu_pid killed due to run STOP.1 request `date`" >> $resdir/Warnings 2>&1
 			kill -KILL $qemu_pid
 			break
 		fi
@@ -165,7 +165,7 @@ then
 		fi
 		if test $must_continue = no && test $kruntime -ge $((seconds + $TORTURE_SHUTDOWN_GRACE))
 		then
-			echo "!!! PID $qemu_pid hung at $kruntime vs. $seconds seconds" >> $resdir/Warnings 2>&1
+			echo "!!! PID $qemu_pid hung at $kruntime vs. $seconds seconds `date`" >> $resdir/Warnings 2>&1
 			kill -KILL $qemu_pid
 			break
 		fi
-- 
2.31.1.189.g2e36527f23

