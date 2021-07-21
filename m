Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B064C6377B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D57161246
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhGUUVH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12F64611C1;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=A/7nV5SAL79sHSHaEZ2l+SvV6ZtHjMLwx/eAY5cjZrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B98jG91kaY3tsjdNx5IfUYj/qzwwN4ujQ+Gy2Umf4iVElDQwSdQsu1NFSCvO8s9zB
         pH5xse51Uw7UIHiCF3eX3F+acMq50Waha6P6UV7Wn2pA92QTL3fIhkDWqbaRVJI+lu
         DUkHeHJc5kDQ5kibLqikkFccsDPT4BS72DJafRFC/dsGIBmQ8cm0MmTS1PL+R9nOkC
         6an6kKMzsLLv1TNkJatTs6+zvt60t3UifHHHW7c/b6sIK8sxLuklRuXlN91A5gYsOc
         GUik/CEPKVvRC0x/KTwlA5XaFBphB3FscWg6NciB1zdvTfNWU7UAN5q6Qj4sVBlskz
         yZycqQp9+WN+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CF7E35C0A2D; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/21] torture: Create KCSAN summaries for torture.sh runs
Date:   Wed, 21 Jul 2021 14:01:23 -0700
Message-Id: <20210721210140.787717-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, each -kcsan run in a torture.sh group of runs has its own
kcsan.sum summary.  This works, but there is usually a lot of duplication
between the runs.  This commit therefore also creates an overall kcsan.sum
file for the entire torture.sh run, if there was at least one -kcsan run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index f1d1dff715905..363f56081eff3 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -418,6 +418,10 @@ then
 	nfailures="`wc -l "$T/failures" | awk '{ print $1 }'`"
 	ret=2
 fi
+if test "$do_kcsan" = "yes"
+then
+	TORTURE_KCONFIG_KCSAN_ARG=1 tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh tools/testing/selftests/rcutorture/res/$ds > tools/testing/selftests/rcutorture/res/$ds/kcsan.sum
+fi
 echo Started at $startdate, ended at `date`, duration `get_starttime_duration $starttime`. | tee -a $T/log
 echo Summary: Successes: $nsuccesses Failures: $nfailures. | tee -a $T/log
 tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
-- 
2.31.1.189.g2e36527f23

