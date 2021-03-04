Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624B7C43331
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389D064FA9
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbhCDBA4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239725AbhCDAXH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:23:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD10564EC0;
        Thu,  4 Mar 2021 00:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817345;
        bh=YgYHKOAqZyFPTfZ3rrgRapvoH1gN/uGd7Jh/GedCTuo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=cH2xpKLrjwsWvhpv1R/+ELLco+agw59pwn99mLl83vPnsFfUT8g3GfC33yoXwXFY6
         NRiH1R2BKh1LH6DFM3AQk1aLD80+ji9OSss6QIkIpyugxlewaPqs5UvKTeFTjKNMW0
         lKF0PPBQCOeCb5RzKmT2OmJikjFBsv8F4hhXBUMxCt+mtqDp+W3f9S+NeOycrX+Q9u
         BYZJepAPN+sp8xXF0hW4QEJb3MUDMoKHXwYe0GGcADhPRA3VXkXXCa6ywR1pMRH4M8
         cau+A5sdRq+XrlrcPYYjt6a0ZTRnYeBfWrMi8Ka5NCoZzvAcgQLDtjE0wFPt7NO/pr
         Pv471Sr3+LH6g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 47FE33522591; Wed,  3 Mar 2021 16:22:25 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:22:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/12] NOCB updates for v5.13
Message-ID: <20210304002225.GA23492@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains updates for no-callbacks (NOCBs) CPUs:

1.	Detect unsafe checks for offloaded rdp, courtesy of Frederic
	Weisbecker.

2.	Report ignored local enqueue in nohz mode, courtesy of Frederic
	Weisbecker.

3.	Comment the reason behind BH disablement on batch processing,
	courtesy of Frederic Weisbecker.

4.	Forbid NOCB toggling on offline CPUs, courtesy of Frederic
	Weisbecker.

5.	Avoid confusing double write of rdp->nocb_cb_sleep, courtesy of
	Frederic Weisbecker.

6.	Only (re-)initialize segcblist when needed on CPU up, courtesy
	of Frederic Weisbecker.

7.	Rename nocb_gp_update_state to nocb_gp_update_state_deoffloading,
	courtesy of Frederic Weisbecker.

8.	Make nocb_nobypass_lim_per_jiffy static, courtesy of Jiapeng
	Chong.

9.	Fix missed nocb_timer requeue, courtesy of Frederic Weisbecker.

10.	Disable bypass when CPU isn't completely offloaded, courtesy of
	Frederic Weisbecker.

11.	Remove stale comment above rcu_segcblist_offload(), courtesy of
	Frederic Weisbecker.

12.	Move trace_rcu_nocb_wake() calls outside nocb_lock when possible,
	courtesy of Frederic Weisbecker.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcu_segcblist.h |    7 -
 kernel/rcu/rcu_segcblist.c    |    3 
 kernel/rcu/tree.c             |   33 +++---
 kernel/rcu/tree_plugin.h      |  222 ++++++++++++++++++++++++++++--------------
 kernel/sched/core.c           |   24 ++++
 5 files changed, 194 insertions(+), 95 deletions(-)
