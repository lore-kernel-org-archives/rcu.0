Return-Path: <SRS0=nsBp=BW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC1AC433E0
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073B320781
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597272994;
	bh=lDSUqcZleiRS36fjIZi7JKKWrjlK6ctnU/z+2EfAe2Y=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=QUzxK25dSR8EQrDBXTQdBkod0TK7IWlDVnhm3tBh163ppQutFe8Pb4bPhYRqSGcOh
	 MM3wN/tk6pGVpJI1dUTTeA8lSZE5eiZJy4NoeBGjrvXfPxLKKVLbnmIUcrCMiepiOb
	 C71CAsHPVIUFFIXM7YxwEHmP7tC1PsgM4UCXOMA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHLW4d (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgHLW4d (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Aug 2020 18:56:33 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C19920771;
        Wed, 12 Aug 2020 22:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597272993;
        bh=lDSUqcZleiRS36fjIZi7JKKWrjlK6ctnU/z+2EfAe2Y=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=U6I7hbtH/kW8zMaps+egDyHnpqK9BQfRx+bTNCW25ivZuQ0MUBEZqKpYOpLLVBBK+
         ysFTKCCImqjnpotsH8OObbNLOTeGzO6hr6/OxoPTtvNJGgMC7gKl/ihBJoY+4Q5IpW
         wDMM9O1febjfvqMcHHYy3vnm6/oP1RyyM0EaviTE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D7E593522615; Wed, 12 Aug 2020 15:56:32 -0700 (PDT)
Date:   Wed, 12 Aug 2020 15:56:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        elver@google.com, dvyukov@google.com, jannh@google.com
Subject: [PATCH tip/core/rcu 0/12] Add strict short-grace-period Kconfig
 option
Message-ID: <20200812225632.GA19759@paulmck-ThinkPad-P72>
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

This series adds a CONFIG_RCU_STRICT_GRACE_PERIOD Kconfig option that
causes RCU to strive for short grace periods even at great expense in
terms of performance, scalability, and real-time response.  This option is
therefore not for production use, but rather to allow tools such as KASAN
to more readily detect pointer leaks from RCU read-side critical sections.
Here is an example of such a pointer leak:

	rcu_read_lock();
	p = rcu_dereference(gp);
	do_something(p);
	rcu_read_unlock(); // *p might be freed immediately!
	do_something_else(p); // Potential use after free BUG!!!

This series also adds a rcutree.rcu_unlock_delay kernel boot parameter
that delays the specified number of microseconds after the outermost
rcu_read_unlock() in an attempt to further bend the odds in KASAN's favor.

The patches in this series are as follows:

1.	Add Kconfig option for strict RCU grace periods.

2.	Reduce leaf fanout for strict RCU grace periods.

3.	Restrict default jiffies_till_first_fqs for strict RCU GPs.

4.	Force DEFAULT_RCU_BLIMIT to 1000 for strict RCU GPs.

5.	Always set .need_qs from __rcu_read_lock() for strict GPs.

6.	Do full report for .need_qs for strict GPs.

7.	Attempt QS when CPU discovers GP for strict GPs.

8.	IPI all CPUs at GP start for strict GPs.

9.	IPI all CPUs at GP end for strict GPs.

10.	Provide optional RCU-reader exit delay for strict GPs.

11.	Execute RCU reader shortly after rcu_core for strict GPs.

12.	Report QS for outermost PREEMPT=n rcu_read_unlock() for strict GPs.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    9 +++
 include/linux/rcupdate.h                        |    7 ++
 kernel/rcu/Kconfig                              |    8 +-
 kernel/rcu/Kconfig.debug                        |   15 +++++
 kernel/rcu/tree.c                               |   65 +++++++++++++++++++++---
 kernel/rcu/tree.h                               |    1 
 kernel/rcu/tree_plugin.h                        |   47 +++++++++++++----
 7 files changed, 132 insertions(+), 20 deletions(-)
