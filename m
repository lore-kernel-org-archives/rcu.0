Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6445AC433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35548216C4
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbhAFQwu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:55672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbhAFQwu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:52:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E8122313A;
        Wed,  6 Jan 2021 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609951930;
        bh=NU6sVwBU+rX1yOug4JMJ05CisnfqwFMj6wVt/23uDcQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=KS2k8ZWESGEi4wrTDcj8iA8hn3jfPD/7yvZZ0i0TGupLcYV17h/TFG4ift5DdHh02
         ygYeAl/Q7rXH5799JFvWpXu3vIgVwz49ZTDREdOlrr4DwMjVPDkDKXEf9AOKrDNAeW
         vNf9fZklZDmsvz46R6hzXLEJ6SDDXcO+R3ukoikMQ0k7WYOG4UlWm48fa6f/WVhWyd
         T155S4E93il6asdlBgEQFqpPDVU99V7GVdRg0Z/Ye77UKiNxXOZFZb08qwgaK/TUJU
         VxHvnsuS5Rfejs9H9alwML+GhYIXxWDaM7YN6/6U8sdGHEId3rbsE0OqlmKMW9vLG8
         DlHVQJ/t0lqGw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1AB5735225EC; Wed,  6 Jan 2021 08:52:10 -0800 (PST)
Date:   Wed, 6 Jan 2021 08:52:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/4] Stall-warning updates for v5.12
Message-ID: <20210106165210.GA20296@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series enhances RCU CPU stall-warning messages.

1.	Mark obtuse portion of stall warning as internal debug.

2.	For RCU grace-period kthread starvation, dump last CPU it ran on.

3.	Do not NMI offline CPUs.

4.	Check and report missed fqs timer wakeup on RCU stall, courtesy
	of Neeraj Upadhyay.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/stallwarn.rst |   23 +++++++++++++++
 kernel/rcu/tree.c               |   25 ++++++++++-------
 kernel/rcu/tree_exp.h           |    2 -
 kernel/rcu/tree_stall.h         |   58 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 90 insertions(+), 18 deletions(-)
