Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB68C4742C
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C407A2071A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604618627;
	bh=6Ud0SjnsNaVe3Aygv4dl9iOgUwfB3qZdDMAv3XVy98I=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=osTgNNgWrJ+gXcpSU7RmRVaZ75pCBqmUoOnGAMoe0E6mZiuNVqyT3RXCpqUTmuq/3
	 CS1h4evME7sHImSrzYpFx88ddKLeayUuUCGJRGWmlyZbbpo4t41xoQTZih/2pf4Z7r
	 E95vZmtQdWVX1iM/4P7dIbE01MdTeu4iCRyXCw2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgKEXXq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:23:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgKEXXq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:23:46 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C51B520704;
        Thu,  5 Nov 2020 23:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604618625;
        bh=6Ud0SjnsNaVe3Aygv4dl9iOgUwfB3qZdDMAv3XVy98I=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=QJKfWjKTyo5mkJeZNKRw3Q7I+ap1w0g1n0J4iC8qa+aOOEh+Pjj+A/hTKm6vgNl4E
         VzCQkainbhwB7S6jEm+SawDknSFOwBBb0tnI6vi89weswSKHQk4TwwKZpZ3pq+Kbyr
         3G8di1WhPL5tLRklrqse0dN6tGPCUGDZUHWP4ITc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5CC703522A76; Thu,  5 Nov 2020 15:23:45 -0800 (PST)
Date:   Thu, 5 Nov 2020 15:23:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/7] Lockdep-RCU updates for v5.11
Message-ID: <20201105232345.GA19179@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series simplifies use of the lockdep-RCU API, all courtesy of
Jakub Kicinski:

1.	Un-hide lockdep_tasklist_lock_is_held() for !LOCKDEP.

2.	Un-hide RCU lockdep maps for !LOCKDEP.

3.	Un-hide networking lockdep_sock_is_held() for !LOCKDEP.

4.	Remove broken definitions in sched and un-hide for !LOCKDEP.

5.	Use a more appropriate lockdep helper in SRCU.

6.	Provide dummy forward declaration of *_is_held() helpers.

7.	Prevent RCU_LOCKDEP_WARN() from swallowing the condition.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/lockdep.h        |    6 ++++++
 include/linux/rcupdate.h       |   11 ++++++-----
 include/linux/rcupdate_trace.h |    4 ++--
 include/linux/sched/task.h     |    2 --
 include/net/sch_generic.h      |   12 ------------
 include/net/sock.h             |    2 --
 kernel/rcu/srcutree.c          |    2 +-
 7 files changed, 15 insertions(+), 24 deletions(-)
