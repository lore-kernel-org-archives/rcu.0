Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CABC433DB
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B0D64F76
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhCDBBr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452973AbhCDAkR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:40:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9949F64F09;
        Thu,  4 Mar 2021 00:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818297;
        bh=9IGzbVIPgkV9C891g0qV4xr/QDAgESm9Ufcw0nIBUak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Njj9O8hh0801NhEojZKItjqu/fx4hTN1azAWPxu5h1HQVFCnSXTf7d4mjmI32jCJp
         j7f55iY5/i4yJjeCwUAHRyY26L4H4S7vFXrb/PYYGd0ZCcyd3qgVnrIWgTlK7IQyGC
         6OQVg4DKz8ToL+PWQVkFvPW26PbWoL77WGuOTxiQDkFdztkUgSP2uNRoOQnT8IFNNr
         7VzjqfTJaHbEQaqaXJpcbDXcSg4KHQj2eaReB8cPxsw0x3bTTaUdRMY4AJ0VGsEshg
         UND7Kkj/r/8fEz8h5IZQLTK19+5h2d6482T0iC1BIJkShj/TTD5ZyeLEehl2BprIWx
         uZxeQq6xuDz4w==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 23/28] torture: Add --duration argument to kvm-again.sh
Date:   Wed,  3 Mar 2021 16:38:07 -0800
Message-Id: <20210304003812.24833-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a --duration argument to kvm-again.sh to allow the user
to override the --duration specified for the original kvm.sh run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/kvm-again.sh  | 25 ++++++++++++++++++-
 .../selftests/rcutorture/bin/kvm-transform.sh      | 29 +++++++++++++++++-----
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 92cf396..4de576495 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -52,6 +52,7 @@ PATH=${KVM}/bin:$PATH; export PATH
 . functions.sh
 
 dryrun=
+dur=
 default_link="cp -R"
 rundir="`pwd`/tools/testing/selftests/rcutorture/res/`date +%Y.%m.%d-%H.%M.%S-again`"
 
@@ -61,6 +62,7 @@ starttime="`get_starttime`"
 usage () {
 	echo "Usage: $scriptname $oldrun [ arguments ]:"
 	echo "       --dryrun"
+	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
 	echo "       --link hard|soft|copy"
 	echo "       --remote"
 	echo "       --rundir /new/res/path"
@@ -73,6 +75,23 @@ do
 	--dryrun)
 		dryrun=1
 		;;
+	--duration)
+		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(s\|m\|h\|d\|\)$' '^error'
+		mult=60
+		if echo "$2" | grep -q 's$'
+		then
+			mult=1
+		elif echo "$2" | grep -q 'h$'
+		then
+			mult=3600
+		elif echo "$2" | grep -q 'd$'
+		then
+			mult=86400
+		fi
+		ts=`echo $2 | sed -e 's/[smhd]$//'`
+		dur=$(($ts*mult))
+		shift
+		;;
 	--link)
 		checkarg --link "hard|soft|copy" "$#" "$2" 'hard\|soft\|copy' '^--'
 		case "$2" in
@@ -134,7 +153,11 @@ do
 	cp "$i" $T
 	qemu_cmd_dir="`dirname "$i"`"
 	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
-	kvm-transform.sh $kernel_dir/bzImage $qemu_cmd_dir/console.log < $T/qemu-cmd > $i
+	kvm-transform.sh $kernel_dir/bzImage $qemu_cmd_dir/console.log $dur < $T/qemu-cmd > $i
+	if test -n "$dur"
+	then
+		echo "# seconds=$dur" >> $i
+	fi
 	echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
 done
 grep -v '^#' $T/batches.oldrun | awk '
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
index c45a953..162dddb 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
@@ -3,7 +3,7 @@
 #
 # Transform a qemu-cmd file to allow reuse.
 #
-# Usage: kvm-transform.sh bzImage console.log < qemu-cmd-in > qemu-cmd-out
+# Usage: kvm-transform.sh bzImage console.log [ seconds ] < qemu-cmd-in > qemu-cmd-out
 #
 #	bzImage: Kernel and initrd from the same prior kvm.sh run.
 #	console.log: File into which to place console output.
@@ -29,20 +29,37 @@ then
 	echo "Need console log file name."
 	exit 1
 fi
+seconds=$3
+if test -n "$seconds" && echo $seconds | grep -q '[^0-9]'
+then
+	echo "Invalid duration, should be numeric in seconds: '$seconds'"
+	exit 1
+fi
+
+awk -v image="$image" -v consolelog="$consolelog" -v seconds="$seconds" '
+/^#/ {
+	print $0;
+	next;
+}
 
-awk -v image="$image" -v consolelog="$consolelog" '
 {
 	line = "";
 	for (i = 1; i <= NF; i++) {
-		if (line == "")
+		if ("" seconds != "" && $i ~ /\.shutdown_secs=[0-9]*$/) {
+			sub(/[0-9]*$/, seconds, $i);
+			if (line == "")
+				line = $i;
+			else
+				line = line " " $i;
+		} else if (line == "") {
 			line = $i;
-		else
+		} else {
 			line = line " " $i;
+		}
 		if ($i == "-serial") {
 			i++;
 			line = line " file:" consolelog;
-		}
-		if ($i == "-kernel") {
+		} else if ($i == "-kernel") {
 			i++;
 			line = line " " image;
 		}
-- 
2.9.5

