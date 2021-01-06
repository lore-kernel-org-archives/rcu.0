Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA48C43381
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A0423132
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbhAFR1a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:27:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbhAFR1a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADF7123142;
        Wed,  6 Jan 2021 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953970;
        bh=exah24qsjhdESOA1OkzzXZZ/DljTcAZdfVnlUL5oz0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpqcFssF6wPL/V1/pXQWXZh/SC1bSB9+0CIX2RNaJFQBx5KR8umpLzdEhJlUloN0/
         /6Q8/ODgfYyhVHHJoxsXmp4T4frnLscEzIMrCB5yDD7aN6HgIbBHZ4iLIDRKg04qaG
         +IHTiV5o7LOJwcJd8GJZFTNQOYN+IwMD7+Rx+xKnnxAURx8tDYGJ6D18/6kQ6P+WgX
         I89nFBRywDBlyzJMx4UAftJZpGs5Zxy9GFBEtWd2Mg9MwMc9JQ5rcMtVwbo9BLn08u
         /c0CBxj7uZr79phflf7dAnbtaIHA1DsKfIhBfsy/+NfD8J2wa6ijG+GmZaMC9TDHNY
         t4mYl6hbkijnA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/20] torture: Make kvm.sh "Test Summary" date be end of test
Date:   Wed,  6 Jan 2021 09:25:55 -0800
Message-Id: <20210106172607.22816-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the "date" command producing the output on the kvm.sh "Test
Summary" line is executed at the beginning of the test, which produces a
date that is less than helpful to someone wanting to know the duration
of the test.  This commit therefore defers this command's execution to
the end of the test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 0a9211a..c8356d5 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -517,10 +517,12 @@ END {
 		dump(first, i, batchnum);
 }' >> $T/script
 
-cat << ___EOF___ >> $T/script
+cat << '___EOF___' >> $T/script
 echo
 echo
 echo " --- `date` Test summary:"
+___EOF___
+cat << ___EOF___ >> $T/script
 echo Results directory: $resdir/$ds
 kcsan-collapse.sh $resdir/$ds
 kvm-recheck.sh $resdir/$ds
-- 
2.9.5

