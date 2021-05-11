Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AB9C43462
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49DA61606
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhEKXEr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhEKXEp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:04:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B19A61628;
        Tue, 11 May 2021 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774218;
        bh=J06E8gAce9oxGChw0+OD0B5UKjPlpnx/MSvjWsuHwlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlOd6y1kgpUWi7UHjqRFTdy9nR40ZOZGerfSrgNfY5LA2O7xune0mQlTit6MMuz29
         fRDYgFuPfG9UFNx6Ss8L89kClomMwUhyPUREoGLEeUxl2qGRU1gXUVynH0vHgRBKtN
         Vf001VDARAeYejZHBDqxc/ihLUXJqxWlJ+dpscXM7AHuiZYbKp/bMDSlSdIMNuO3eB
         lk19WImfHtJHNIhy4cJ1RlJReXqKGpw+wdLiIGGtOONVKD59zIzDuGNaMjghVqr3/q
         B20OikBlRS+oxGTo86G7XAATWUHS55yof0g6WRZqm+pb13Pw3lYcqRt1yHKjrodCU8
         5SAgN+RWS2rAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 613CF5C0D4A; Tue, 11 May 2021 16:03:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/10] rcu/nocb: Cancel nocb_timer upon nocb_gp wakeup
Date:   Tue, 11 May 2021 16:03:31 -0700
Message-Id: <20210511230336.2894314-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

When waking up in nocb_gp_wait(), there is no need to keep the nocb_timer
around because this function will traverse the whole rdp list. Any
update performed before the timer was armed will now be visible after
the ->nocb_gp_lock acquire.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 015adec5bdc5..a667551a5501 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2211,6 +2211,10 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
 		if (bypass)
 			del_timer(&my_rdp->nocb_bypass_timer);
+		if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
+			WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
+			del_timer(&my_rdp->nocb_timer);
+		}
 		WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
 		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 	}
-- 
2.31.1.189.g2e36527f23

