Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C324BC433EF
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A677F611C7
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhIPA3Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233238AbhIPA3V (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 20:29:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D11361157;
        Thu, 16 Sep 2021 00:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752081;
        bh=TbGNvLL/5Vipj4atHQAqTK6cPNyYp1efF4UCKmy377Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m53ZHfX4pqopklujLlNbv2YGgBKTcSs6ieMZmUBN3Q76ADd6bnRV9vFZbwcAHACHP
         8KA446Puiga3TFK+dPHGissbps+SuEppyfj1srRFa6711jEugWCMcRTtVDnTDQJ0F9
         kKkev8k3zeNrmLmP7L3MOvlkF6yz+Ftwnr+LBBUAcAky9snfQokqeq2m4nduq5XWWl
         YrqddoIkxhvj+5tOtUu7BeGHWquybPu3oRsXVCh0GsBdlcdozt8uD7sx6iaTHyXsz/
         snL7LvHZhWY4mrJ1iceov0rupUkbjQCUGdolwQvEv+Xn77gNw4bgl15PgFXA6/mMar
         r2r+RGk306iqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7024D5C06B9; Wed, 15 Sep 2021 17:28:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/5] torture: Make torture.sh print the number of files to be compressed
Date:   Wed, 15 Sep 2021 17:27:57 -0700
Message-Id: <20210916002800.3910056-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916002710.GA3909915@paulmck-ThinkPad-P17-Gen-1>
References: <20210916002710.GA3909915@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Compressing gigabyte vmlinux files can take some time, and it can be a
bit annoying to not know many more batches of compression there will be.
This commit therefore makes torture.sh print the number of files to be
compressed just before starting compression and just after compression
completes.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 363f56081eff..8e882346d2a6 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -434,7 +434,12 @@ then
 	batchno=1
 	if test -s $T/xz-todo
 	then
-		echo Size before compressing: `du -sh $tdir | awk '{ print $1 }'` `date` 2>&1 | tee -a "$tdir/log-xz" | tee -a $T/log
+		for i in `cat $T/xz-todo`
+		do
+			find $i -name 'vmlinux*' -print
+		done | wc -l | awk '{ print $1 }' > $T/xz-todo-count
+		n2compress="`cat $T/xz-todo-count`"
+		echo Size before compressing $n2compress files: `du -sh $tdir | awk '{ print $1 }'` `date` 2>&1 | tee -a "$tdir/log-xz" | tee -a $T/log
 		for i in `cat $T/xz-todo`
 		do
 			echo Compressing vmlinux files in ${i}: `date` >> "$tdir/log-xz" 2>&1
@@ -456,7 +461,7 @@ then
 			echo Waiting for final batch $batchno of $ncompresses compressions `date` | tee -a "$tdir/log-xz" | tee -a $T/log
 		fi
 		wait
-		echo Size after compressing: `du -sh $tdir | awk '{ print $1 }'` `date` 2>&1 | tee -a "$tdir/log-xz" | tee -a $T/log
+		echo Size after compressing $n2compress files: `du -sh $tdir | awk '{ print $1 }'` `date` 2>&1 | tee -a "$tdir/log-xz" | tee -a $T/log
 		echo Total duration `get_starttime_duration $starttime`. | tee -a $T/log
 	else
 		echo No compression needed: `date` >> "$tdir/log-xz" 2>&1
-- 
2.31.1.189.g2e36527f23

