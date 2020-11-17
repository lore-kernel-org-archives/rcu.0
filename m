Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF7BC5519F
	for <rcu@archiver.kernel.org>; Tue, 17 Nov 2020 00:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E432467C
	for <rcu@archiver.kernel.org>; Tue, 17 Nov 2020 00:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiFTe+4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgKQAkS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbgKQAkS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Nov 2020 19:40:18 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B7552467B;
        Tue, 17 Nov 2020 00:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605573617;
        bh=PGb+9cKP28ZB75NtAkqzFXdYd7JicCnlqRnH13QpZaA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=hiFTe+4OHMVSdhXZDkHPSFreuoCllTUTmZhDdb6r1r/DX7Y+bJwPiFySto/TTD9qm
         3n4fKIEKcpZtmd7yLEQU9EPmtNyXZpQuu8uq2xtnUZ1ZVimsJr9/JLikj0vJLm6j7A
         qyx+mKd2Ata4JvWqyD8Exe5uYBQPdK8JjlxGKJjc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 524293522684; Mon, 16 Nov 2020 16:40:17 -0800 (PST)
Date:   Mon, 16 Nov 2020 16:40:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/5] Provide SRCU polling grace-period interfaces
Message-ID: <20201117004017.GA7444@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides a polling interface for SRCU grace periods.  The
API is as follows:

unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)

	Returns a "cookie" that can be thought of as a snapshot of
	the specified SRCU instance's grace-period sequence number.
	Also ensures that enough future grace periods happen to eventually
	make the grace-period sequence number reach the cookie.

bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)

	Given a cookie from start_poll_synchronize_srcu(), returns true if
	at least one full SRCU grace period has elapsed in the meantime.
	Given finite SRCU readers in a well-behaved kernel, the following
	code will complete in finite time:

		cookie = start_poll_synchronize_srcu(&my_srcu);
		while (!poll_state_synchronize_srcu(&my_srcu, cookie))
			schedule_timeout_uninterruptible(1);

unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)

	Like start_poll_synchronize_srcu(), except that it does not start
	any grace periods.  This means that the following code is -not-
	guaranteed to complete:

		cookie = get_state_synchronize_srcu(&my_srcu);
		while (!poll_state_synchronize_srcu(&my_srcu, cookie))
			schedule_timeout_uninterruptible(1);

	Use this if you know that something else will be starting the
	needed SRCU grace periods.  This might also be useful if you
	had items that were likely to be reused before the SRCU grace
	period elapsed, so that you avoid burning CPU on SRCU grace
	periods that prove to be unnecessary.  Or if you don't want
	to have more than (say) 100 SRCU grace periods per seconds,
	in which case you might use a timer to start the grace periods.
	Or maybe you don't bother starting the SRCU grace period until
	some sort of emergency situation has arisen.  Or...

	OK, maybe no one needs it, but rcutorture does need it, so here
	it is anyway.

The patches in this series are as follows:

1.	Make Tiny SRCU use multi-bit grace-period counter.

2.	Provide internal interface to start a Tiny SRCU grace period.

3.	Provide internal interface to start a Tree SRCU grace period.

4.	Provide polling interfaces for Tiny SRCU grace periods.

5.	Provide polling interfaces for Tree SRCU grace periods.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcupdate.h |    2 
 include/linux/srcu.h     |    3 +
 include/linux/srcutiny.h |    5 +
 kernel/rcu/srcutiny.c    |   74 +++++++++++++++++++++++---
 kernel/rcu/srcutree.c    |  129 +++++++++++++++++++++++++++++++++++------------
 5 files changed, 169 insertions(+), 44 deletions(-)
