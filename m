Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC60C43217
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25754611EE
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhIPAPQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233260AbhIPAPP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 20:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79DE361157;
        Thu, 16 Sep 2021 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631751235;
        bh=09MBHLt60NaLtJCEGTeLNCt2/ijecFVBX99V0FudLJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mFvDEEuyrmMPQ81P3yWfQ+1xgK6g1ezF4ovkdr674Zb26Q/5hMxCOT6QP9MG4QUut
         om0Z6Rb2opUcL5bwmoKn9zwHPHhVwVOgELRq1iuUrXJhREzUAND2Q9u7KktV23vgvk
         yXT8RI+rh9RyIACVn7wuedeseedpNThfWDszMePJj7JTI0Xz5YHGpcSsGWi46GFORs
         ZlGEceqNKuapzQFXqsr0bCjFXWhXMjT1h/VWs1v9HFCvB6XekYmGJrh/mhT4dtzHWb
         3UkQf5founJ4v3amr6WxvYevn5bIJNpc6DN5Fz+ql7pHIWuciOfLVNBdfYb2g3dWm3
         RqMEni3IltP9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3B43F5C054E; Wed, 15 Sep 2021 17:13:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/7] rcutorture: Suppressing read-exit testing is not an error
Date:   Wed, 15 Sep 2021 17:13:46 -0700
Message-Id: <20210916001352.3909170-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
References: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, specifying the rcutorture.read_exit_burst=0 kernel boot
parameter will result in a -EINVAL exit code that will stop the rcutorture
test run before it has fully initialized.  This commit therefore uses a
zero exit code in that case, thus allowing rcutorture.read_exit_burst=0
to complete normally.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ab4215266ebe..59254fa15cc6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2741,7 +2741,7 @@ static int rcu_torture_read_exit(void *unused)
 static int rcu_torture_read_exit_init(void)
 {
 	if (read_exit_burst <= 0)
-		return -EINVAL;
+		return 0;
 	init_waitqueue_head(&read_exit_wq);
 	read_exit_child_stop = false;
 	read_exit_child_stopped = false;
-- 
2.31.1.189.g2e36527f23

