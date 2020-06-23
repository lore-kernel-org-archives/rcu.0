Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6EFC433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE86C2076A
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592870964;
	bh=tZm7U5xLo6MC8JKAoRbOzi5s59HZtP/yhPCcV6s19NU=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=iwIvni8VH5WU4noPgEQ+0TtY75h6vI1m+/JvwJSFwwUpsPGRO6y95LYJywZFFhWaP
	 UVkJsktr3a8diEsYBgcHfwt1EipfYFcJqZoCc5jud4VMyytM7f2eI6a6rRvWQM9LKz
	 UNrCnfXMlCfbdw1pPRZdN8QgyzwjPPKPiLi9NRUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbgFWAJY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731380AbgFWAJY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:09:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85C020738;
        Tue, 23 Jun 2020 00:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592870963;
        bh=tZm7U5xLo6MC8JKAoRbOzi5s59HZtP/yhPCcV6s19NU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=MVEDvT/3Yg8PjIXvfEFxzsxkEQWBqjKElNcY0/0Ei46NZa0JRW1Vt0O02tmRf7zPd
         WAMHKRpRqrX5vS4GGUcoF/GA6VadksNaazHfJ2SXDfLWuAKhMZNpVKQaut/wcfpE3e
         9IvGYOg75lifG8QPazN7gXF0xeq8AHn/5KyvSYaI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7DED6352306A; Mon, 22 Jun 2020 17:09:23 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:09:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/10] Documentation updates for v5.9
Message-ID: <20200623000923.GA25047@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides documentation updates.


1-7.	Convert Documentation/RCU files to .rst, courtesy of Mauro
	Carvalho Chehab.

8.	RCU: Don't duplicate chapter names in rculist_nulls.rst, courtesy
	of Mauro Carvalho Chehab.

9.	Timer problems can cause RCU CPU stall warnings.

10.	Tasks RCU must protect instructions before trampoline.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/rculist_nulls.txt                      |  172 ------------
 b/Documentation/RCU/Design/Requirements/Requirements.rst |    7 
 b/Documentation/RCU/checklist.rst                        |   17 -
 b/Documentation/RCU/index.rst                            |    9 
 b/Documentation/RCU/lockdep-splat.rst                    |  109 ++++----
 b/Documentation/RCU/lockdep.rst                          |   12 
 b/Documentation/RCU/rculist_nulls.rst                    |  200 +++++++++++++++
 b/Documentation/RCU/rcuref.rst                           |  199 +++++++-------
 b/Documentation/RCU/stallwarn.rst                        |   62 +++-
 b/Documentation/RCU/torture.rst                          |  117 ++++----
 b/Documentation/locking/locktorture.rst                  |    2 
 b/MAINTAINERS                                            |    4 
 b/include/linux/rculist_nulls.h                          |    2 
 b/kernel/rcu/rcutorture.c                                |    2 
 b/kernel/rcu/tree_stall.h                                |    4 
 b/net/core/sock.c                                        |    4 
 16 files changed, 509 insertions(+), 413 deletions(-)
