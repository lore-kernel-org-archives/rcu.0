Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCDEC433E9
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A0F64F39
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351233AbhCDBBj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452929AbhCDAji (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DE2864EEF;
        Thu,  4 Mar 2021 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818295;
        bh=KfXM0DW7KYgjw/O5KS3hZHg4hxXYqcazZaelpCiy2IA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qUSDpSn4Iq9rco7f2iAmNNa7oup0xaB0UWaGl9kPhp3HMNuUwFTnUZ9oz+9UDih72
         zt2YXHalVsQRev6DYraul2B6h5CvhLAGu8C9cEt7+tJEQQld5yy102ddDaF+PTEjQG
         V6tweN2knPen1ieviU7hUFhd1h10YXt4JH/ICbitsZm2rFaBTeY2OYjvGMfZ43q1x3
         UDSmClpu31dLZdAb8XgaqEXVytfW1pRb3Bv3Ujn6U5vYzIoTsq/EkeR7e5ES89YF0z
         gdakUK6bVUkjO90KCoGs2YqLKr6Fljyr95BKjYJV1SHI32J4TFRdkNGCOtjWTiQaHX
         /moHPmT3G6Sag==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/28] torture: Eliminate jitter_pids file
Date:   Wed,  3 Mar 2021 16:37:54 -0800
Message-Id: <20210304003812.24833-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Now that there is a reliable way to convince the jitter.sh scripts to
stop, the jitter_pids file is not needed, nor is the code that kills all
the PIDs contained in this file.  This commit therefore eliminates this
file and the code using it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 14 --------------
 tools/testing/selftests/rcutorture/bin/kvm.sh            |  5 +----
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index fed6f10..eb5346b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -270,20 +270,6 @@ do
 				echo "ps -fp $killpid" >> $resdir/Warnings 2>&1
 				ps -fp $killpid >> $resdir/Warnings 2>&1
 			fi
-			# Reduce probability of PID reuse by allowing a one-minute buffer
-			if test $((kruntime + 60)) -lt $seconds && test -s "$resdir/../jitter_pids"
-			then
-				awk < "$resdir/../jitter_pids" '
-				NF > 0 {
-					pidlist = pidlist " " $1;
-					n++;
-				}
-				END {
-					if (n > 0) {
-						print "kill " pidlist;
-					}
-				}' | sh
-			fi
 		else
 			echo ' ---' `date`: "Kernel done"
 		fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 48da4cd..de93802 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -502,12 +502,9 @@ function dump(first, pastlast, batchnum)
 	print "if test -n \"$needqemurun\""
 	print "then"
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
-	print "\techo > " rd "jitter_pids"
 	print "\ttouch " rd "jittering"
-	for (j = 0; j < njitter; j++) {
+	for (j = 0; j < njitter; j++)
 		print "\tjitter.sh " j " " dur " " rd "jittering " ja[2] " " ja[3] "&"
-		print "\techo $! >> " rd "jitter_pids"
-	}
 	print "\twhile ls $runfiles > /dev/null 2>&1"
 	print "\tdo"
 	print "\t\t:"
-- 
2.9.5

