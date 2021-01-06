Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC87BC433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B94823125
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbhAFRcC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:32:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbhAFRcC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4D642312C;
        Wed,  6 Jan 2021 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954281;
        bh=7I8Ofkv7ktYbxBnSNu9YqJcj3LCkha7dI0i6Y4lqvYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCyhGObtaha7OxG00mAwuEE4SW6fyLAS8fydT9OGv76KcqRYETSV/QUdIBRpYqgs1
         4hVc4aVtQCfZhjax40YOy2E2XDYfyC5Me02F8oj1bn2l3YQYyn4fPsR6HRVcjRDv7N
         p5ypn9JPr62flnSRAebUSAAXQGipbWeno3Rh4QYOCJSaNQj6gzhhaBNq+CR9Cn63IF
         LdBR5JgPnaMmGpII5Rsefbaf8/ugJUnnuf03D6CdvSkVAWwg+kUQwHVsvnJGnQaC2z
         rpLS10fHOzBSJg2PZDp/d8VtOxw9kka3hOcyd/cR6seoqqvztI22ef1mEuOMWpCRdV
         s81KzaiCcWk2Q==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/18] torture: Do Kconfig analysis only once per scenario
Date:   Wed,  6 Jan 2021 09:31:02 -0800
Message-Id: <20210106173119.23159-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, if a scenario is repeated as in "--configs '4*TREE01'",
the Kconfig analysis is performed for each occurrance (four times in
this example) and each analysis places the exact same data into the
exact same files.  This is not really an issue in this repetition-four
example, but it can needlessly consume tens of seconds of wallclock time
for something like "--config '128*TINY01'".

This commit therefore does Kconfig analysis only once per set of
repeats of a given scenario, courtesy of the "sort -u" command and an
automatically generated awk script.

While in the area, this commit also wordsmiths a comment.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6051868..8d3c99b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -286,7 +286,8 @@ then
 		exit 1
 	fi
 fi
-for CF1 in $configs_derep
+echo 'BEGIN {' > $T/cfgcpu.awk
+for CF1 in `echo $configs_derep | tr -s ' ' '\012' | sort -u`
 do
 	if test -f "$CONFIGFRAG/$CF1"
 	then
@@ -299,12 +300,20 @@ do
 		fi
 		cpu_count=`configfrag_boot_cpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
 		cpu_count=`configfrag_boot_maxcpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
-		echo $CF1 $cpu_count >> $T/cfgcpu
+		echo 'scenariocpu["'"$CF1"'"] = '"$cpu_count"';' >> $T/cfgcpu.awk
 	else
 		echo "The --configs file $CF1 does not exist, terminating."
 		exit 1
 	fi
 done
+cat << '___EOF___' >> $T/cfgcpu.awk
+}
+{
+	for (i = 1; i <= NF; i++)
+		print $i, scenariocpu[$i];
+}
+___EOF___
+echo $configs_derep | awk -f $T/cfgcpu.awk > $T/cfgcpu
 sort -k2nr $T/cfgcpu -T="$T" > $T/cfgcpu.sort
 
 # Use a greedy bin-packing algorithm, sorting the list accordingly.
@@ -324,11 +333,10 @@ END {
 	batch = 0;
 	nc = -1;
 
-	# Each pass through the following loop creates on test batch
-	# that can be executed concurrently given ncpus.  Note that a
-	# given test that requires more than the available CPUs will run in
-	# their own batch.  Such tests just have to make do with what
-	# is available.
+	# Each pass through the following loop creates on test batch that
+	# can be executed concurrently given ncpus.  Note that a given test
+	# that requires more than the available CPUs will run in its own
+	# batch.  Such tests just have to make do with what is available.
 	while (nc != ncpus) {
 		batch++;
 		nc = ncpus;
-- 
2.9.5

