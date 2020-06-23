Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674CEC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408B720720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871864;
	bh=a5jLBi6LcqgzU1CHaVUmq462KXGA+/QhM1CIaE6EJKI=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=we8ioTujUw4yQPGLHVeafellmoqg4RrjcEk/GwvfrMxQ+uMZjfudcwBvjLTavissi
	 PlF4gP8Kbudqq61oiVBaD6z4TzqYVrAbjcJENYmZPVkDkSQPgVyDaTVc/RD2/vhIom
	 gXU55Edj/EULHT3peRWHdp44CeqUAscft7U7wEGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbgFWAYY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730987AbgFWAYX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:24:23 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67EE720702;
        Tue, 23 Jun 2020 00:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871863;
        bh=a5jLBi6LcqgzU1CHaVUmq462KXGA+/QhM1CIaE6EJKI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Z+ryXX6qW7cqTVDttGtmhj4DNa2dVcLWVd5Gj/staJr5azFSoylSDFdxJ+ZKt21NV
         dgpTBE41NRWvioDgz2UbskpldSznjvgFsvko1RKfbu3Odez0IOyaaQZ8OTh7Th14iv
         GkPo3zAPi7lzi7jCoUUFlIIAnbnSIUn94Fu4wlyM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4D5DA352306A; Mon, 22 Jun 2020 17:24:23 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:24:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/5] RCU tasks updates for v5.9
Message-ID: <20200623002423.GA25869@paulmck-ThinkPad-P72>
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

This series contains code-style and build-issue fixes to the various
RCU Tasks flavors.

1.	rcu-tasks: Convert sleeps to idle priority.

2.	rcu-tasks: Make rcu_tasks_postscan() be static.

3.	rcu-tasks: Add #include of rcupdate_trace.h to update.c.

4.	rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads().

5.	rcu-tasks: Fix code-style issues.

						Thanx, Paul

------------------------------------------------------------------------

 tasks.h  |   28 +++++++++++++++++++++-------
 update.c |    1 +
 2 files changed, 22 insertions(+), 7 deletions(-)
