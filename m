Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7038CC43461
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E26616E8
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEKXI4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbhEKXIz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:08:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 414A061928;
        Tue, 11 May 2021 23:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774468;
        bh=2w8SNOnj4hUbptaRDHT+py87ltYdjWVG+fK7QN6uEiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZtp29qsj09uO0/gUFbG+6yNBUGpFRE4fK7qILnRrVmB17R7Z8KshKVUixPEAAeUe
         I7l1Xtr3iDlbxB1LXv1EYRKx/In9/9BWrEta/DAPC2L+R6j/RGaXhDfShXYE462Q6u
         Fm32z0BiZvqZEhLEP3FjcBAeGQazquW9PJtx5ja0tAa9bhWY8aYZEr0SZKm9bdBNd/
         5x0bfKroRh6c8X91n6pqd5ER7+ZVI5ODLk9rB6RwAxhsMC8rbjfhLtkaDybD8p6qK/
         Q1PBmwiF/NHhOIBJGo2M3CHVQagqrwO7XdNN0+ztLeMznHQITrl0eDvcTIThFaw33Y
         vsiYajgDHdqDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DC6565C014E; Tue, 11 May 2021 16:07:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/6] srcu: Remove superfluous ssp initialization for early callbacks
Date:   Tue, 11 May 2021 16:07:41 -0700
Message-Id: <20210511230745.2894650-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Pre-srcu_init() invocations of call_srcu() initialize the srcu_struct
structure in question, so there is no need to check this initialization
in srcu_init() when initiating grace periods for srcu_struct structures
that had early call_srcu() invocations.  This commit therefore drops
the calls to check_init_srcu_struct() in srcu_init().

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 3414aff2a4b0..f4f0cbf7a02b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1388,7 +1388,6 @@ void __init srcu_init(void)
 	while (!list_empty(&srcu_boot_list)) {
 		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
 				      work.work.entry);
-		check_init_srcu_struct(ssp);
 		list_del_init(&ssp->work.work.entry);
 		queue_work(rcu_gp_wq, &ssp->work.work);
 	}
-- 
2.31.1.189.g2e36527f23

