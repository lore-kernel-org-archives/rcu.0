Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A4FC433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE13F61432
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhEKWz5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEKWz5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:55:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88B7161260;
        Tue, 11 May 2021 22:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773690;
        bh=A72CbQhZAawT5X/NaQJ3qlXdfpWHfSuXJCpS4j20Pfc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=kHAx5A3837baT4x7gRdzksryIW4nvO6vRh7Z8j/4sXbuWzqAb2oKS9ovQFX86RHUJ
         McPxhx9K+UL4MAvw437cqaqAJR/3ROTrkLZPPpoGvG+kikIVysB2t0q4t+oDBrKybr
         VUmhzzF9idrR7hqhgs2ZYa2E4PPAkjrx0HaNhpoygGmPk1btvIaXQ5P+pfcytOM/8Y
         6Q1jjzyIkis2ErHLpVZcnhfDxNk+tGSCwdNEOhz0zMtMVVcSSf3y6vAryZFeb/7PTt
         ufxLAdIg9egvljsMWpKhjS6q3zMxp3z/SFG9ErBIF9KjBmZtbjd84zQZ5il4j8BiBj
         TnV9jYiDwUXPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4D5715C0138; Tue, 11 May 2021 15:54:50 -0700 (PDT)
Date:   Tue, 11 May 2021 15:54:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/7] kvfree_rcu() updates for v5.14
Message-ID: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains kfree_rcu() updates.

1.	kvfree_rcu: Release a page cache under memory pressure, courtesy
	of Zhang Qiang.

2.	kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access to
	nr_bkv_objs, courtesy of "Uladzislau Rezki (Sony)".

3.	kvfree_rcu: Add a bulk-list check when a scheduler is run,
	courtesy of "Uladzislau Rezki (Sony)".

4.	kvfree_rcu: Update "monitor_todo" once a batch is started,
	courtesy of "Uladzislau Rezki (Sony)".

5.	kvfree_rcu: Use kfree_rcu_monitor() instead of open-coded variant,
	courtesy of "Uladzislau Rezki (Sony)".

6.	kvfree_rcu: Fix comments according to current code, courtesy of
	"Uladzislau Rezki (Sony)".

7.	kvfree_rcu: Refactor kfree_rcu_monitor(), courtesy of "Uladzislau
	Rezki (Sony)".

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt |    5 
 b/kernel/rcu/tree.c                               |   82 ++++++++++++--
 kernel/rcu/tree.c                                 |  127 +++++++---------------
 3 files changed, 121 insertions(+), 93 deletions(-)
