Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C72C43332
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2303A64F48
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350884AbhCDBBl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452947AbhCDAjw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C44C564F0B;
        Thu,  4 Mar 2021 00:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818297;
        bh=+w+p+gupWYvEy3sjfA3W9Rzwm53ldTeseYBMwSJG4PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkvAe8XkP1qEPXKmlFOHh7Fi0YJ+QldQUgKSc38JG/W7PGjcYDQrNSqt+iN0wpo0G
         XB+Pp1IeynZZSiSo90Tsbs0leO/rPm8RrlfgvCpxOjn10g433/1GE/vwCEohA0V9dY
         zKks79J9MvvNeiujNDe8mgJWzapOk+Bb1QBFGKeX4YK2g5QD/NVXLBxys7tK+Liob2
         PS7IaVvJKT+hYv89OrplA8UknX+hiKFEYtffkNKjwHKu11xyFUcp3FPzrWQfuQeJA8
         xZ2dGGZditHtyCXMnLzobpjzqOcprzwj0WpruQoxssvShRL4KXiruOrFJiIs4G2rgA
         ohpTNCzxFBAoA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 24/28] torture: Make kvm-transform.sh update jitter commands
Date:   Wed,  3 Mar 2021 16:38:08 -0800
Message-Id: <20210304003812.24833-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

When rerunning an old run using kvm-again.sh, the jitter commands
will re-use the original "res" directory.  This works, but is clearly
an accident waiting to happen.  And this accident will happen with
remote runs, where the original directory lives on some other system.
This commit therefore updates the qemu-cmd commands to use the new res
directory created for this specific run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/kvm-again.sh  |  3 ++-
 .../selftests/rcutorture/bin/kvm-transform.sh      | 23 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 4de576495..21d1e99 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -153,7 +153,8 @@ do
 	cp "$i" $T
 	qemu_cmd_dir="`dirname "$i"`"
 	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
-	kvm-transform.sh $kernel_dir/bzImage $qemu_cmd_dir/console.log $dur < $T/qemu-cmd > $i
+	jitter_dir="`dirname "$kernel_dir"`"
+	kvm-transform.sh "$kernel_dir/bzImage" "$qemu_cmd_dir/console.log" "$jitter_dir" $dur < $T/qemu-cmd > $i
 	if test -n "$dur"
 	then
 		echo "# seconds=$dur" >> $i
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
index 162dddb..e9dcbce 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
@@ -3,7 +3,7 @@
 #
 # Transform a qemu-cmd file to allow reuse.
 #
-# Usage: kvm-transform.sh bzImage console.log [ seconds ] < qemu-cmd-in > qemu-cmd-out
+# Usage: kvm-transform.sh bzImage console.log jitter_dir [ seconds ] < qemu-cmd-in > qemu-cmd-out
 #
 #	bzImage: Kernel and initrd from the same prior kvm.sh run.
 #	console.log: File into which to place console output.
@@ -29,14 +29,31 @@ then
 	echo "Need console log file name."
 	exit 1
 fi
-seconds=$3
+jitter_dir="$3"
+if test -z "$jitter_dir" || ! test -d "$jitter_dir"
+then
+	echo "Need valid jitter directory: '$jitter_dir'"
+	exit 1
+fi
+seconds="$4"
 if test -n "$seconds" && echo $seconds | grep -q '[^0-9]'
 then
 	echo "Invalid duration, should be numeric in seconds: '$seconds'"
 	exit 1
 fi
 
-awk -v image="$image" -v consolelog="$consolelog" -v seconds="$seconds" '
+awk -v image="$image" -v consolelog="$consolelog" -v jitter_dir="$jitter_dir" \
+    -v seconds="$seconds" '
+/^# TORTURE_JITTER_START=/ {
+	print "# TORTURE_JITTER_START=\". jitterstart.sh " $4 " " jitter_dir " " $6 " " $7;
+	next;
+}
+
+/^# TORTURE_JITTER_STOP=/ {
+	print "# TORTURE_JITTER_STOP=\". jitterstop.sh " " " jitter_dir " " $5;
+	next;
+}
+
 /^#/ {
 	print $0;
 	next;
-- 
2.9.5

