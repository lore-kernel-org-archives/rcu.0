Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E53C433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5815E61925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhEKXNc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhEKXNb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A461D610F8;
        Tue, 11 May 2021 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774744;
        bh=ZoS3KKh38avI3U5yWQ2DaolAwJ+zMctWAzsKPxSIv18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJpKH3b8WmlGPyZnZi/KnbOpsKMzabGFf5TxkX64fZKUGvneUXj4KIE87THg+tvz+
         Y41qZyl1oOR7vqep/T2mJ9NduLPfqvfKeDUA3PJ+2kGqLoPdUH7k6aqDLeWHDC+lJQ
         xoocSDNVmDBAoIGIqDNcjXZ+kR50ls6A6bnR2TDVSUaGFb1Tw8YIJtaNt9zMJqtvmF
         /tF4P3MtUM2mnse11h4ShUGamq7hJP3g5Uq84hFfxNzFUlONGPUknCoIEIUTS8sSTF
         92FxD9l9+648xA/xkJM70zukZMefi4eRUY0OoJu1xq4MxiPuM1iIvcVyPCX8oPPuOh
         vZ3qjLh6juSzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6C16E5C014E; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/26] torture: Add "scenarios" option to kvm.sh --dryrun parameter
Date:   Tue, 11 May 2021 16:11:59 -0700
Message-Id: <20210511231223.2895398-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds "--dryrun scenarios" to kvm.sh, which prints something
like this:

1.  TREE03
2.  TREE07
3.  SRCU-P SRCU-N
4.  TREE01 TRACE01
5.  TREE02 TRACE02
6.  TREE04 RUDE01 TASKS01
7.  TREE05 TASKS03 SRCU-T SRCU-U
8.  TASKS02 TINY01 TINY02 TREE09

This format is more convenient for scripts that run batches of scenarios.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6bf00a003d3d..3bd523a33700 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -64,7 +64,7 @@ usage () {
 	echo "       --cpus N"
 	echo "       --datestamp string"
 	echo "       --defconfig string"
-	echo "       --dryrun batches|sched|script"
+	echo "       --dryrun batches|scenarios|sched|script"
 	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
 	echo "       --gdb"
 	echo "       --help"
@@ -130,7 +130,7 @@ do
 		shift
 		;;
 	--dryrun)
-		checkarg --dryrun "batches|sched|script" $# "$2" 'batches\|sched\|script' '^--'
+		checkarg --dryrun "batches|sched|script" $# "$2" 'batches\|scenarios\|sched\|script' '^--'
 		dryrun=$2
 		shift
 		;;
@@ -577,6 +577,25 @@ egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
 		print batchno, $1, $2
 	}' > $T/batches
 
+# As above, but one line per batch.
+grep -v '^#' $T/batches | awk '
+BEGIN {
+	oldbatch = 1;
+}
+
+{
+	if (oldbatch != $1) {
+		print ++n ". " curbatch;
+		curbatch = "";
+		oldbatch = $1;
+	}
+	curbatch = curbatch " " $2;
+}
+
+END {
+	print ++n ". " curbatch;
+}' > $T/scenarios
+
 if test "$dryrun" = script
 then
 	cat $T/script
@@ -597,11 +616,16 @@ elif test "$dryrun" = batches
 then
 	cat $T/batches
 	exit 0
+elif test "$dryrun" = scenarios
+then
+	cat $T/scenarios
+	exit 0
 else
 	# Not a dryrun.  Record the batches and the number of CPUs, then run the script.
 	bash $T/script
 	ret=$?
 	cp $T/batches $resdir/$ds/batches
+	cp $T/scenarios $resdir/$ds/scenarios
 	echo '#' cpus=$cpus >> $resdir/$ds/batches
 	echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a $resdir/$ds/log
 	exit $ret
-- 
2.31.1.189.g2e36527f23

