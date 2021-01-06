Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB729C4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B681A2312A
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbhAFRdP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbhAFRcn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3868123331;
        Wed,  6 Jan 2021 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954283;
        bh=fPZWiFc5cSA6GJO1zjcKXRS/t+VjaVwkXGhJxQIXZAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJDU1wVNR/Mp2jzXUZUobuYVqr44ZqTmP5xxfFUxyL7dZdiE9YNojET4vzwzhffc6
         3E35iNSsj3a/LbF2wJ7uIMWkcGNqQi307diTOLbgX63kW5baMkob1q8+obK72+bwWh
         rUR644vrd98V2MFDP7/l1v/Jawj18Dva6cUMlBrTuV61Z0CjpjjiDINSVe0wY5HaPv
         V16UZBSQOkV8GY1TldKj+iWtV5ScfzKKVjj2immGPAJiLt3AA00tpXW0jsJ0gq17Bk
         gg+mP5OH/JlN5CqWsx9TseExi+xkoJG+x/7JR3QKH/Y9muHBCiOugGsy94XY5zi0lq
         ckRD7jt6pbhKQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/18] torture: Make torture.sh refuse to do zero-length runs
Date:   Wed,  6 Jan 2021 09:31:14 -0800
Message-Id: <20210106173119.23159-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit causes torture.sh to check for zero-length runs and to take
the cowardly option of refusing to run them, logging its cowardice for
later inspection.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 25 +++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index f2f9140..43ef2c0 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -151,16 +151,29 @@ do
 	shift
 done
 
-duration_rcutorture=$((duration_base*duration_rcutorture_frac/10))
-# Need to sum remaining weights, and if duration weights to zero,
-# set do_no_rcutorture. @@@
-duration_locktorture=$((duration_base*duration_locktorture_frac/10))
-duration_scftorture=$((duration_base*duration_scftorture_frac/10))
-
 T=/tmp/torture.sh.$$
 trap 'rm -rf $T' 0 2
 mkdir $T
 
+duration_rcutorture=$((duration_base*duration_rcutorture_frac/10))
+if test "$duration_rcutorture" -eq 0
+then
+	echo " --- Zero time for rcutorture, disabling" | tee -a $T/log
+	do_rcutorture=no
+fi
+duration_locktorture=$((duration_base*duration_locktorture_frac/10))
+if test "$duration_locktorture" -eq 0
+then
+	echo " --- Zero time for locktorture, disabling" | tee -a $T/log
+	do_locktorture=no
+fi
+duration_scftorture=$((duration_base*duration_scftorture_frac/10))
+if test "$duration_scftorture" -eq 0
+then
+	echo " --- Zero time for scftorture, disabling" | tee -a $T/log
+	do_scftorture=no
+fi
+
 touch $T/failures
 touch $T/successes
 
-- 
2.9.5

