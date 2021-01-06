Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CE4C4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 191F823133
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbhAFRcC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:32:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbhAFRcC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AB5123136;
        Wed,  6 Jan 2021 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954281;
        bh=2xDrC5b/1lODqHNPDPx9uKm9I4ZyQlgiJ/oTvBaOvSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RO9fmYzyVpBU8IYd1gTdJML5zuCuDNXLwQ9g/HsZFPYUlgRLFV900aXsyPYzkTehW
         IHofopwkrIm0OW6TxhOxYyHKai17WJ8cWVhqVPhwfKl/PmurbFh1gkPLxCLuw+L3Kr
         HQxP0OSaRhk7jXVkRp44TEdObhyRdHHhm4TgzOZSuAA9lMCevOg7zo7EWWxkXZlDFU
         rjTH08hqNOyxNdbQ+p/ZvlEg43BUNRq8l/hvTy5qePUP2geqf3ihaU0RL2KH6OI5Sh
         fYCZtIojSuC0bXGwaEGqVHBM5Az+luqWecWOkxfUnBHcQHymERXajbr1BvQudU/Txu
         0qn9Ma0+27yjA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/18] torture: Make torture.sh use common time-duration bash functions
Date:   Wed,  6 Jan 2021 09:31:04 -0800
Message-Id: <20210106173119.23159-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit makes torture.sh use the new bash functions get_starttime()
and get_starttime_duration() created for kvm.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/rcutorture/bin/torture.sh

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
old mode 100644
new mode 100755
index f556cc7..1657404
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -13,6 +13,10 @@
 scriptname=$0
 args="$*"
 
+KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
+PATH=${KVM}/bin:$PATH; export PATH
+. functions.sh
+
 # Default duration and apportionment.
 duration_base=10
 duration_rcutorture_frac=7
@@ -172,7 +176,7 @@ touch $T/successes
 
 ds="`date +%Y.%m.%d-%H.%M.%S`-torture"
 startdate="`date`"
-starttime="`awk 'BEGIN { print systime() }' < /dev/null`"
+starttime="`get_starttime`"
 
 # tortureme flavor command
 # Note that "flavor" is an arbitrary string.  Supply --torture if needed.
@@ -274,17 +278,7 @@ then
 	nfailures="`wc -l "$T/failures" | awk '{ print $1 }'`"
 	ret=2
 fi
-duration="`awk -v starttime=$starttime '
-BEGIN {
-	s = systime() - starttime; 
-	h = s / 3600;
-	d = h /24;
-	if (d < 1)
-		print h " hours";
-	else
-		print d " days (" h " hours)";
-}' < /dev/null`"
-echo Started at $startdate, ended at `date`, duration $duration. | tee -a $T/log
+echo Started at $startdate, ended at `date`, duration `get_starttime_duration $starttime`. | tee -a $T/log
 echo Summary: Successes: $nsuccesses Failures: $nfailures. | tee -a $T/log
 tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
 if test -n "$tdir"
@@ -293,9 +287,9 @@ then
 fi
 exit $ret
 
+# @@@
 # RCU CPU stall warnings?
 # scftorture warnings?
 # Need a way for the invoker to specify clang.
 # Work out --configs based on number of available CPUs?
-# Need a way to specify --configs.  --configs--rcutorture?
 # Need to sense CPUs to size scftorture run.  Ditto rcuscale and refscale.
-- 
2.9.5

