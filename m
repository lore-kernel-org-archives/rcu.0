Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B389FC4332F
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C740611CA
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhIPAPQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233101AbhIPAPP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 20:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 726DD611C6;
        Thu, 16 Sep 2021 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631751235;
        bh=HnfOty7je3tKBbpPAIrJNDDOzn4hSP6qe0HDE4Z4HL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7LfOLADgcPDFC3UlkLA3IlOVzYou7jB4YKUfk30lBt2NUCCJr/M1AG2vieqfD8t1
         BOtN5teaB0cbbtChpPAJBwziIndNNV1DcOBGGaJpY9yVMEBR1ru0MwKI8N6Cci+f4n
         5+LEwFiBqVYz5/1T6ToJfVxi3ub2qDlDeaR+gQIFEurUIAzrUQPcUGZLoKsPQXSEyP
         /FWJ4HvAEKAbI26ZwPSbn+szR4hjef/YTU6Nv41v6WV46hf0XIS4gGujHPIpqwVnA+
         qqK5iqeYp3HtJDdCplNSep0uIIRbJD+KgMoWVO4dLqBnLokJl2LrTTwG/uGgrrOsfQ
         d66Qf1KO0skEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 40AD45C08DB; Wed, 15 Sep 2021 17:13:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/7] locktorture: Warn on individual lock_torture_init() error conditions
Date:   Wed, 15 Sep 2021 17:13:48 -0700
Message-Id: <20210916001352.3909170-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
References: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When running locktorture as a module, any lock_torture_init() issues will be
reflected in the error code from modprobe or insmod, as the case may be.
However, these error codes are not available when running locktorture
built-in, for example, when using the kvm.sh script.  This commit
therefore adds WARN_ON_ONCE() to allow distinguishing lock_torture_init()
errors when running locktorture built-in.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 7c5a4a087cc7..397ac13d2ef7 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -1022,23 +1022,23 @@ static int __init lock_torture_init(void)
 	if (onoff_interval > 0) {
 		firsterr = torture_onoff_init(onoff_holdoff * HZ,
 					      onoff_interval * HZ, NULL);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	if (shuffle_interval > 0) {
 		firsterr = torture_shuffle_init(shuffle_interval);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	if (shutdown_secs > 0) {
 		firsterr = torture_shutdown_init(shutdown_secs,
 						 lock_torture_cleanup);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	if (stutter > 0) {
 		firsterr = torture_stutter_init(stutter, stutter);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 
@@ -1082,7 +1082,7 @@ static int __init lock_torture_init(void)
 		/* Create writer. */
 		firsterr = torture_create_kthread(lock_torture_writer, &cxt.lwsa[i],
 						  writer_tasks[i]);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 
 	create_reader:
@@ -1091,13 +1091,13 @@ static int __init lock_torture_init(void)
 		/* Create reader. */
 		firsterr = torture_create_kthread(lock_torture_reader, &cxt.lrsa[j],
 						  reader_tasks[j]);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	if (stat_interval > 0) {
 		firsterr = torture_create_kthread(lock_torture_stats, NULL,
 						  stats_task);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	torture_init_end();
-- 
2.31.1.189.g2e36527f23

