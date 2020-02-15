Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700BAC35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0D6207FF
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581727300;
	bh=C6WX9LIBr/cuKR3mI/lfTm6nRYEGR1atD6ddskVekeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h4n2uNtakC+zP91suhaEKYtFon7Q9FrWCquDqND1oPy2/+qFnYSe/j5JZHkLjTx8u
	 9M8uQMnSJlJWQRnktk/ZdTZK9Fwzm9DY+poPl1GhU25fdZzSLSvIcoGWYyU1VofA3D
	 SxknDY4By3hSKK/fBiHifesSkhZZ1kiv5AcxuDno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBOAlj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAlj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:41:39 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0871420848;
        Sat, 15 Feb 2020 00:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727299;
        bh=C6WX9LIBr/cuKR3mI/lfTm6nRYEGR1atD6ddskVekeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eP47xYeV3NBMRuYJEBA03l482IDhoV5ZI7sOT2PFrVpcaQfZhtQuTGGoK5RcIbNxv
         pCytnGOIzW3na+d5NWANA2HnAKROz6Z/ZwdLSVGly5KSnjYCw0KjL4ZMMaDmln9kpa
         LasLw3NNkQTeHenuTyT2HMBbAgr2atEuFEeFptWY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/18] rcutorture: Summarize summary of build and run results
Date:   Fri, 14 Feb 2020 16:41:16 -0800
Message-Id: <20200215004125.16953-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

When running the default list of tests, the run summary of a successful
(that is, failed to find any errors) run fits easily on a 24-line screen.
But a run with something like "--configs '5*CFLIST'" will be 80 lines long,
and it is all too easy to miss a failure message when scrolling back.
This commit therefore prints out the number of runs with failing builds
or runtime failures, but only if there are any such failures.

For example, a run with a single build error and a single runtime error
would print two lines like this:

1 runs with build errors.
1 runs with runtime errors.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index e5edd51..0326f4a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -13,6 +13,9 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
+T=/tmp/kvm-recheck.sh.$$
+trap 'rm -f $T' 0 2
+
 PATH=`pwd`/tools/testing/selftests/rcutorture/bin:$PATH; export PATH
 . functions.sh
 for rd in "$@"
@@ -68,4 +71,16 @@ do
 		fi
 	done
 done
-EDITOR=echo kvm-find-errors.sh "${@: -1}" > /dev/null 2>&1
+EDITOR=echo kvm-find-errors.sh "${@: -1}" > $T 2>&1
+ret=$?
+builderrors="`tr ' ' '\012' < $T | grep -c '/Make.out.diags'`"
+if test "$builderrors" -gt 0
+then
+	echo $builderrors runs with build errors.
+fi
+runerrors="`tr ' ' '\012' < $T | grep -c '/console.log.diags'`"
+if test "$runerrors" -gt 0
+then
+	echo $runerrors runs with runtime errors.
+fi
+exit $ret
-- 
2.9.5

