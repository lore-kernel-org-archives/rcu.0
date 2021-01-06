Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4283C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8199923118
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbhAFQzx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:55:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727226AbhAFQzw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:55:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97BAD2311E;
        Wed,  6 Jan 2021 16:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609952111;
        bh=DFmHfyulUmxhonXXKvMvOP+F4WZqp9EGqnjhA9cKHFY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=noAaDJeI/J3gKQIIwsVgVl1QYZcJLQRF2ccyn5NcMLV/U44nJ2fGeqqfhfLjxgWw7
         tPwM+OO0I+hqQw4m8DS/+8w6Tc1hSYD7M1Xk0ytWEhlBScVwb6HEjxOV6cAaIsphzJ
         wHykoDYua1WHbWA1UvPoqqOMg0qa/Tof/DfG1WT2ma/7jKQJd4+ewJ2NSUXsE9+/w4
         0oHd0iRwUQlwwjqbW60WeLudJ4r+AWjfHyT3MLR20t2Oeeqe4zy2JOpUH7JXDVN3LU
         AU/Hpt7Z2947y65uy7ahTT/qmN5L7wQdwPWlygWSrj+JMfICXqdF4uxmesY+B8ijG3
         aU1aixrObqfng==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4FE7235225EC; Wed,  6 Jan 2021 08:55:11 -0800 (PST)
Date:   Wed, 6 Jan 2021 08:55:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, kent.overstreet@gmail.com
Subject: [PATCH tip/core/rcu 0/10] SRCU updates for v5.12
Message-ID: <20210106165511.GA20555@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains SRCU updates, most notably the polling grace-period
API requested by Kent Overstreet.

1.	Make Tiny SRCU use multi-bit grace-period counter.

2.	Provide internal interface to start a Tiny SRCU grace period.

3.	Provide internal interface to start a Tree SRCU grace period.

4.	Provide polling interfaces for Tiny SRCU grace periods.

5.	Provide polling interfaces for Tree SRCU grace periods.

6.	Document polling interfaces for Tree SRCU grace periods.

7.	Add comment explaining cookie overflow/wrap.

8.	Prepare for ->start_gp_poll and ->poll_gp_state.

9.	Add writer-side tests of polling grace-period API.

10.	Add reader-side tests of polling grace-period API.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Requirements/Requirements.rst |   18 ++
 include/linux/rcupdate.h                               |    2 
 include/linux/srcu.h                                   |    3 
 include/linux/srcutiny.h                               |    7 
 kernel/rcu/rcutorture.c                                |   99 +++++++++--
 kernel/rcu/srcutiny.c                                  |   77 +++++++-
 kernel/rcu/srcutree.c                                  |  148 +++++++++++++----
 7 files changed, 296 insertions(+), 58 deletions(-)
