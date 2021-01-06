Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93807C433E9
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A28423125
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbhAFRdG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:33:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbhAFRc7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FB4723333;
        Wed,  6 Jan 2021 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954284;
        bh=i/JePKqdSVZMT91Pj22HVVVHmDEyrJSROc8zWirgvbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAoH754e5kz5Kajsd1Zt395LGJAJY0BWE5FJxWb0q3Ydp7A/DCyXtj8/3aGLQwdIH
         UIaak04MZQMGbCnGLK+2gpca+4R4gS37bR0qMwRXRHfMfzKJzQhfRjHi3cAUmcRDZM
         m7uz9D+bBid/HkBOaWAo5MHocInCUHq0JCV1VAzcsZ0LBLJd/AdMRRP8ZVvGQ9nElK
         DFfzXmsqG6W8AkpmFH7HNQFtWKNyf+Ff9kuLMsgQjYVLo8QHmyOvB+jrGZakJETaPS
         D7IGhxSGtI2OHzE1n/ei9eWmrwNuS6IqHjvSE9+8A1cOmS+6i7vJyC02gnrN6mr66G
         RP+xdeUYt48Xw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/18] torture: Compress KASAN vmlinux files
Date:   Wed,  6 Jan 2021 09:31:19 -0800
Message-Id: <20210106173119.23159-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The sizes of vmlinux files built with KASAN enabled can approach a full
gigabyte, which can result in disk overflow sooner rather than later.
Fortunately, the xz command compresses them by almost an order of
magnitude.  This commit therefore uses xz to compress vmlinux file built
by torture.sh with KASAN enabled.

However, xz is not the fastest thing in the world.  In fact, it is way
slower than rotating-rust mass storage.  This commit therefore also adds a
--compress-kasan-vmlinux argument to specify the degree of xz concurrency,
which defaults to using all available CPUs if there are that many files in
need of compression.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 48 ++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 0867f30..ad7525b 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -36,7 +36,8 @@ configs_locktorture=
 configs_scftorture=
 kcsan_kmake_args=
 
-# Default duration and apportionment.
+# Default compression, duration, and apportionment.
+compress_kasan_vmlinux="`identify_qemu_vcpus`"
 duration_base=10
 duration_rcutorture_frac=7
 duration_locktorture_frac=1
@@ -65,6 +66,7 @@ function doyesno () {
 
 usage () {
 	echo "Usage: $scriptname optional arguments:"
+	echo "       --compress-kasan-vmlinux concurrency"
 	echo "       --configs-rcutorture \"config-file list w/ repeat factor (3*TINY01)\""
 	echo "       --configs-locktorture \"config-file list w/ repeat factor (10*LOCK01)\""
 	echo "       --configs-scftorture \"config-file list w/ repeat factor (2*CFLIST)\""
@@ -87,6 +89,11 @@ usage () {
 while test $# -gt 0
 do
 	case "$1" in
+	--compress-kasan-vmlinux)
+		checkarg --compress-kasan-vmlinux "(concurrency level)" $# "$2" '^[0-9][0-9]*$' '^error'
+		compress_kasan_vmlinux=$2
+		shift
+		;;
 	--config-rcutorture|--configs-rcutorture)
 		checkarg --configs-rcutorture "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
 		configs_rcutorture="$configs_rcutorture $2"
@@ -391,8 +398,45 @@ fi
 echo Started at $startdate, ended at `date`, duration `get_starttime_duration $starttime`. | tee -a $T/log
 echo Summary: Successes: $nsuccesses Failures: $nfailures. | tee -a $T/log
 tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
+if test -n "$tdir" && test $compress_kasan_vmlinux -gt 0
+then
+	# KASAN vmlinux files can approach 1GB in size, so compress them.
+	echo Looking for KASAN files to compress: `date` > "$tdir/log-xz" 2>&1
+	find "$tdir" -type d -name '*-kasan' -print > $T/xz-todo
+	ncompresses=0
+	batchno=1
+	if test -s $T/xz-todo
+	then
+		echo Size before compressing: `du -sh $tdir | awk '{ print $1 }'` `date` 2>&1 | tee -a "$tdir/log-xz" | tee -a $T/log
+		for i in `cat $T/xz-todo`
+		do
+			echo Compressing vmlinux files in ${i}: `date` >> "$tdir/log-xz" 2>&1
+			for j in $i/*/vmlinux
+			do
+				xz "$j" >> "$tdir/log-xz" 2>&1 &
+				ncompresses=$((ncompresses+1))
+				if test $ncompresses -ge $compress_kasan_vmlinux
+				then
+					echo Waiting for batch $batchno of $ncompresses compressions `date` | tee -a "$tdir/log-xz" | tee -a $T/log
+					wait
+					ncompresses=0
+					batchno=$((batchno+1))
+				fi
+			done
+		done
+		if test $ncompresses -gt 0
+		then
+			echo Waiting for final batch $batchno of $ncompresses compressions `date` | tee -a "$tdir/log-xz" | tee -a $T/log
+		fi
+		wait
+		echo Size after compressing: `du -sh $tdir | awk '{ print $1 }'` `date` 2>&1 | tee -a "$tdir/log-xz" | tee -a $T/log
+		echo Total duration `get_starttime_duration $starttime`. | tee -a $T/log
+	else
+		echo No compression needed: `date` >> "$tdir/log-xz" 2>&1
+	fi
+fi
 if test -n "$tdir"
 then
-	cp $T/log $tdir
+	cp $T/log "$tdir"
 fi
 exit $ret
-- 
2.9.5

