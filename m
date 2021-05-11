Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C05C43617
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C396D6192C
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhEKXNk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhEKXNc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18E2C6193B;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=wjk2s4YWaQbHPJvGdZeE0p7NCLjpy5t270Td5bLn5HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MEhGZStO7e+QfQf5Rq56lBL6zq6oXkV4iszoL4pZe6pLpCVfCzIdeescho2kHQQHO
         98PfzfAaYMJdo2nxrS3NxvtmxvtRQj1H2h9yjACq6VZylhkXrtPGb7+o1ZmliynX9s
         hkrcZh16abYZimpi+t0rdCCO8WiceargmYe3/0v6RjjkokxsQvM5acJ3l1mFbN/SqA
         JRB6DAniJJMqnvWtBCyt8jvVk3hIPlCwV4S3nzRIIQkq7oLOKQil8y/oAsLwk87Jbh
         /6Ur+P16sDoDv3xux47DKax6+DWbjpVeJAP+HKa/gLHtr2A7pWjXnEZ1KYoS73wk4X
         f9Ggs3NEPpXng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7D4E05C0DF3; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/26] torture: Make kvm.sh use abstracted kvm-end-run-stats.sh
Date:   Tue, 11 May 2021 16:12:08 -0700
Message-Id: <20210511231223.2895398-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit reduces duplicate code by making kvm.sh use the new
kvm-end-run-stats.sh script rather than taking its historical approach
of open-coding it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 3bd523a33700..fab3bd9cf9d1 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -550,20 +550,7 @@ END {
 	if (ncpus != 0)
 		dump(first, i, batchnum);
 }' >> $T/script
-
-cat << '___EOF___' >> $T/script
-echo | tee -a $TORTURE_RESDIR/log
-echo | tee -a $TORTURE_RESDIR/log
-echo " --- `date` Test summary:" | tee -a $TORTURE_RESDIR/log
-___EOF___
-cat << ___EOF___ >> $T/script
-echo Results directory: $resdir/$ds | tee -a $resdir/$ds/log
-kcsan-collapse.sh $resdir/$ds | tee -a $resdir/$ds/log
-kvm-recheck.sh $resdir/$ds > $T/kvm-recheck.sh.out 2>&1
-___EOF___
-echo 'ret=$?' >> $T/script
-echo "cat $T/kvm-recheck.sh.out | tee -a $resdir/$ds/log" >> $T/script
-echo 'exit $ret' >> $T/script
+echo kvm-end-run-stats.sh "$resdir/$ds" "$starttime" >> $T/script
 
 # Extract the tests and their batches from the script.
 egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
@@ -627,7 +614,6 @@ else
 	cp $T/batches $resdir/$ds/batches
 	cp $T/scenarios $resdir/$ds/scenarios
 	echo '#' cpus=$cpus >> $resdir/$ds/batches
-	echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a $resdir/$ds/log
 	exit $ret
 fi
 
-- 
2.31.1.189.g2e36527f23

