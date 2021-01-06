Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FD1C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6E422242
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbhAFAyP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:54:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbhAFAyP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 19:54:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4131221E2;
        Wed,  6 Jan 2021 00:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894414;
        bh=Zh5QVD7fI8R6EF8gXmELXswxS7rF50Hxzwyr8kfUn5Y=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=LTfjeXnvlqpPEGqYOvppiPl7CoA/uJlndrWg+/+sV9GTWYniOOVA+nDolRSCwm1iq
         Wun4l0MkhN/2hucIq2+67qr1zh7q/iqudRjq2mBXeR8fZPVVc+sZ3VsvVV4v7Aq9YC
         Ef7YjNhFzq1bCFyoHHm0kMJQO9yKlkULQQX2tmr32QlFqCsg67DcMCDpbvZ6Jpoe/4
         rtRoN0tID2t1DaJ899WN4BARvBe1J0zaJ6SDUhTnxn5XdpHfPc7rNm46p3n+1Bd7Vj
         Uzebuqc/QXrqlXGiREQQsOmBbZ3MjA0fKF+ZSPa3dKWjPN0x4syd8gdVSzC1Fu/G+b
         exoPZE9P7CJpw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7B62335228C6; Tue,  5 Jan 2021 16:53:34 -0800 (PST)
Date:   Tue, 5 Jan 2021 16:53:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/8] Documentation updates for v5.12
Message-ID: <20210106005334.GA12159@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides documentation updates.

1.	Remove redundant "``" from Requirements.rst.

2.	Remove obsolete RCU-bh and RCU-sched update-side API members.

3.	Fix a typo at the kernel-doc markup, courtesy of Mauro Carvalho
	Chehab.

4.	Fix typos and drop/fix dead links in RCU documentation, courtesy
	of Paul Gortmaker.

5.	Update RCU requirements RCU_INIT_POINTER() description.

6.	Remove obsolete rcutree.rcu_idle_lazy_gp_delay boot parameter.

7.	Update RCU's requirements page about the PREEMPT_RT wiki,
	courtesy of Sebastian Andrzej Siewior.

8.	Use CONFIG_PREEMPTION, courtesy of Sebastian Andrzej Siewior.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst |    4 
 Documentation/RCU/Design/Requirements/Requirements.rst                       |  742 ++++------
 Documentation/RCU/checklist.rst                                              |   10 
 Documentation/RCU/rcubarrier.rst                                             |    6 
 Documentation/RCU/stallwarn.rst                                              |    4 
 Documentation/RCU/whatisRCU.rst                                              |   10 
 Documentation/admin-guide/kernel-parameters.txt                              |    6 
 include/linux/list.h                                                         |    2 
 8 files changed, 387 insertions(+), 397 deletions(-)
