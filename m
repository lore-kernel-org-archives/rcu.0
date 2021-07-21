Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437FEC63793
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3012161362
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhGUUVO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C990861396;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=fA0nWCqfAX2QHZhwN4z5cxfWU4wICa7STSV/fG4Mnt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOoSKz5SvDVWDspfU05gvW6e+ieyWBxkr89BVcOHetwcD7l+xhePuCh9m3IMGKFDc
         moZRajLUjWKuMSunHcSV+68OwpGGzL0Ld6p2YMbMY2J3lh3AMarllbjPSiJXVQ+dpv
         5zXrxy8KIMKr+WHZlbAtMEz82GfY8Bu1gBTyqFuZAAg26PaDuLzw9BDuK52yMq2YDT
         xJJQTg5+nOt2vQNoi2P6uQdvSRSEB90N/7gusUu2HY2Liv9nsN6VKaKuWe9obfCyRI
         29FpsV2ZnooF/qZ/KsSC2g+NF1VwF4/y/vM/2Ja4JZTQ6Yj00Ozvmm+oZ9bsGKHSLO
         ae8nZJa7XE+QQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EF6335C268F; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 21/21] torture: Make kvm-test-1-run-qemu.sh check for reboot loops
Date:   Wed, 21 Jul 2021 14:01:40 -0700
Message-Id: <20210721210140.787717-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It turns out that certain types of early boot bugs can result in reboot
loops, even within a guest OS running under qemu/KVM.  This commit
therefore upgrades the kvm-test-1-run-qemu.sh script's hang-detection
heuristics to detect such situations and to terminate the run when
they occur.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index b41252033fac0..44280582c594e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -159,9 +159,13 @@ then
 		then
 			last_ts=0
 		fi
-		if test "$newline" != "$oldline" && test "$last_ts" -lt $((seconds + $TORTURE_SHUTDOWN_GRACE))
+		if test "$newline" != "$oldline" && test "$last_ts" -lt $((seconds + $TORTURE_SHUTDOWN_GRACE)) && test "$last_ts" -gt "$TORTURE_SHUTDOWN_GRACE"
 		then
 			must_continue=yes
+			if test $kruntime -ge $((seconds + $TORTURE_SHUTDOWN_GRACE))
+			then
+				echo Continuing at console.log time $last_ts \"`tail -n 1 $resdir/console.log`\" `date`
+			fi
 		fi
 		if test $must_continue = no && test $kruntime -ge $((seconds + $TORTURE_SHUTDOWN_GRACE))
 		then
-- 
2.31.1.189.g2e36527f23

