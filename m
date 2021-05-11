Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA29BC4363F
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22026192E
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhEKXNo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhEKXNd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AE0661959;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=+Y7Brkq4QGlRK9gl7dUiYWEuSh/16iUBzFPRbSF+lUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J2exsFq0kcylHjxT61lhA0UurGZb1nDKNnorPTKzOlW399nkyq5BlKnarEpc1Rucx
         DXAU1W/Uc2q/cLVkG5VSP52cs9+zlDLyeHwjHeIRcXlMLlLJLLAwY374SfzsrHjDaM
         /Brhp70OiK/CyCJe/cya2gd7z9Wh19g8Wv8ySpv+6C1/tvBrRH86shs/1ld3NU7xAO
         ZzoRmlLNZFnnjoJMVc97qkG44yZZuGIpgKGh+hgf11w1AFoAJhdZXMw3DYvA2pgt6E
         KIiNf/dHvwp9QzIdSXEsI3ivjtD7Pld4QbZnnnLG82UDWnZOEjQm8Wp86JnOd0Tkd+
         pbkKYe39xQ5hw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 93B115C0EAD; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 23/26] torture: Make kvm-remote.sh account for network failure in pathname checks
Date:   Tue, 11 May 2021 16:12:20 -0700
Message-Id: <20210511231223.2895398-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In a long-duration kvm-remote.sh run, almost all of the remote accesses will
be simple file-existence checks.  These are thus the most likely to be caught
out by network failures, which do happen from time to time.

This commit therefore takes a first step towards tolerating temporary
network outages by making the file-existence checks repeat in the face of
such an outage.  They also print a message every minute during a outage,
allowing the user to take appropriate action.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-remote.sh    | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index f08d415d4f99..20e848d2c0bb 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -159,6 +159,28 @@ do
 	fi
 done
 
+# Function to check for presence of a file on the specified system.
+# Complain if the system cannot be reached, and retry after a wait.
+# Currently just waits forever if a machine disappears.
+#
+# Usage: checkremotefile system pathname
+checkremotefile () {
+	local ret
+	local sleeptime=60
+
+	while :
+	do
+		ssh $1 "test -f \"$2\""
+		ret=$?
+		if test "$ret" -ne 255
+		then
+			return $ret
+		fi
+		echo " ---" ssh failure to $1 checking for file $2, retry after $sleeptime seconds. `date`
+		sleep $sleeptime
+	done
+}
+
 # Function to start batches on idle remote $systems
 #
 # Usage: startbatches curbatch nbatches
@@ -178,7 +200,7 @@ startbatches () {
 			echo $((nbatches + 1))
 			return 0
 		fi
-		if ssh "$i" "test -f \"$resdir/$ds/remote.run\"" 1>&2
+		if checkremotefile "$i" "$resdir/$ds/remote.run" 1>&2
 		then
 			continue # System still running last test, skip.
 		fi
@@ -216,7 +238,7 @@ echo All batches started. `date`
 # Wait for all remaining scenarios to complete and collect results.
 for i in $systems
 do
-	while ssh "$i" "test -f \"$resdir/$ds/remote.run\""
+	while checkremotefile "$i" "$resdir/$ds/remote.run"
 	do
 		sleep 30
 	done
-- 
2.31.1.189.g2e36527f23

