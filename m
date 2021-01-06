Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F751C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7E72312A
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbhAFRco (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:32:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbhAFRcn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FF9A23332;
        Wed,  6 Jan 2021 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954283;
        bh=UmLOWYVw+8doK7ogi+9FNrFVAv/UQBBHdWwo/gGyUDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qCGKKTLE8f5x5cKZp/poM7J3De6dLRlI+6LijOlRKpaUcPXlg1cgzkYcMH03o6XI0
         su/PuuFnCAYUuzCUusMMT8FXieyApzYt+Ck3Wy5MhZZvFXpotYpiaefXrI9pz1+1tH
         hQ58pbgu2hWFoKewSq1GiHtX/HkxVbrbfDBbCzTf3++KBQ1Oulf5JFdv+c6+C1SDPN
         j7u6RuUGVhf4Nezr9JsQdC40K1W/VLOa0svULIzyFbBe81LHpWpiwCuYFvk9k9BtaA
         9vFJrIv1PIuFwyk1v+Kk6n+y8P/mVtnZHevSOoVvdmtd5x1cqw3vggA/ULPgmWpc2h
         HLSO7WqaIZsbg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/18] torture: Drop log.long generation from torture.sh
Date:   Wed,  6 Jan 2021 09:31:15 -0800
Message-Id: <20210106173119.23159-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Now that kvm.sh puts all the relevant details in the "log" file,
there is no need for torture.sh to generate a separate "log.long"
file.  This commit therefore drops this from torture.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 43ef2c0..cf74123 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -203,11 +203,8 @@ function torture_one {
 	"$@" $boottag "$cur_bootargs" --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
 	retcode=$?
 	resdir="`grep '^Results directory: ' $T/$curflavor.out | tail -1 | sed -e 's/^Results directory: //'`"
-	if test -n "$resdir"
+	if test -z "$resdir"
 	then
-		cp $T/$curflavor.out $resdir/log.long
-		echo retcode=$retcode >> $resdir/log.long
-	else
 		cat $T/$curflavor.out | tee -a $T/log
 		echo retcode=$retcode | tee -a $T/log
 	fi
-- 
2.9.5

