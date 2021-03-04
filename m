Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575BEC4332D
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3050460201
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351388AbhCDBBj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452927AbhCDAji (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E657F64F1B;
        Thu,  4 Mar 2021 00:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818295;
        bh=t3b+JENtvhgq7J65/4gvBuSgDEFuwJbKZZUFVbmC6AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3gmxkGHX3YNCciuBkKgKL9xf8lT4PIomZWpFsfy5uyNvVYUOYUaLSbdwqZR9ihBE
         OfeDpeD9PHyjsegwLC5ko2IPKcUqiCEXNW1x/685FsMjHp0ngDlDvwRUweUU4aN+lE
         +vlZuscgynphSGbLUzlyhGXBsEwZe3BzPdf2ufUu++SZctM32kdlNroigxiZ0Tlhnp
         zjko2JE3KQHTC0nmz9asPTc2FimWKWGl/o1yx8OWrqCG/Fn8A2aHFA3kShSvr3n1DZ
         cb21dB74U8C4HPVvo3UuAvX6VLg9bHeA5FCHfAVc5+/aOb10P/EkVagJrIvj7uCCKJ
         O/NwVFkxn+J4g==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/28] torture: Use "jittering" file to control jitter.sh execution
Date:   Wed,  3 Mar 2021 16:37:53 -0800
Message-Id: <20210304003812.24833-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, jitter.sh execution is controlled by a time limit and by the
"kill" command.  The former allowed jitter.sh to run uselessly past
the end of a set of runs that panicked during boot, and the latter is
vulnerable to PID reuse.  This commit therefore introduces a "jittering"
file in the date-stamp directory within "res" that must be present for
the jitter.sh scripts to continue executing.  The time limit is still
in place in order to avoid disturbing runs featuring large trace dumps,
but the removal of the "jittering" file handles the panic-during-boot
scenario without relying on PIDs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 10 ++++++----
 tools/testing/selftests/rcutorture/bin/kvm.sh    |  5 ++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 188b864..ed0ea86 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -5,10 +5,11 @@
 # of this script is to inflict random OS jitter on a concurrently running
 # test.
 #
-# Usage: jitter.sh me duration [ sleepmax [ spinmax ] ]
+# Usage: jitter.sh me duration jittering-path [ sleepmax [ spinmax ] ]
 #
 # me: Random-number-generator seed salt.
 # duration: Time to run in seconds.
+# jittering-path: Path to file whose removal will stop this script.
 # sleepmax: Maximum microseconds to sleep, defaults to one second.
 # spinmax: Maximum microseconds to spin, defaults to one millisecond.
 #
@@ -18,8 +19,9 @@
 
 me=$(($1 * 1000))
 duration=$2
-sleepmax=${3-1000000}
-spinmax=${4-1000}
+jittering=$3
+sleepmax=${4-1000000}
+spinmax=${5-1000}
 
 n=1
 
@@ -47,7 +49,7 @@ do
 	fi
 
 	# Check for stop request.
-	if test -f "$TORTURE_STOPFILE"
+	if ! test -f "$jittering"
 	then
 		exit 1;
 	fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 1f5f872..48da4cd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -503,14 +503,17 @@ function dump(first, pastlast, batchnum)
 	print "then"
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
 	print "\techo > " rd "jitter_pids"
+	print "\ttouch " rd "jittering"
 	for (j = 0; j < njitter; j++) {
-		print "\tjitter.sh " j " " dur " " ja[2] " " ja[3] "&"
+		print "\tjitter.sh " j " " dur " " rd "jittering " ja[2] " " ja[3] "&"
 		print "\techo $! >> " rd "jitter_pids"
 	}
 	print "\twhile ls $runfiles > /dev/null 2>&1"
 	print "\tdo"
 	print "\t\t:"
 	print "\tdone"
+	print "\trm -f " rd "jittering"
+	print "\twait"
 	print "\techo ---- All kernel runs complete. `date` | tee -a " rd "log";
 	print "else"
 	print "\twait"
-- 
2.9.5

