Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D9DC433E0
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 20:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA41464DF5
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 20:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhA1UCb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Jan 2021 15:02:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhA1T66 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Jan 2021 14:58:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7863164E3E;
        Thu, 28 Jan 2021 19:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611863437;
        bh=nVxKIAL5HdXWdQLwg9P2FgRNYmS6bHs9MdKH8u6Mxr4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=HL5ev95dUCZwCxWSMFJcFNiJXhoNpONxnPZuxlH4wlEFBl1PHZzcBeEm1fjd1XGxO
         ZyMmJr7VVGr5fAArU2vup87djgYVmxPGkWrs0/Ruj2kVRC88Bog5iXocWe7RmWnH9V
         Xl8i14K1pjty1+k/l57zDshIu6ckv/5JcX3jeiS4rSPqY5KaTmPYhov7cb/+0bEJnP
         9yzHiGi8lK1RlA059mhAJ4YmJfsMEJK7HUIsLk33X5qywKX+nY5r6WllGOwkL+w7bQ
         U1+esVr08aJA6Otq/NBfWkZAxbU0Z48bWUAfoUSMx4KJCu0GFAabuw6MxxhJpa3fsr
         d8ozz5siClbvw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2842635237A0; Thu, 28 Jan 2021 11:50:37 -0800 (PST)
Date:   Thu, 28 Jan 2021 11:50:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     bigeasy@linutronix.de
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Quick review of RCU-related patches in v5.10.8-rt23
Message-ID: <20210128195037.GA9370@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Sebastian,

Just doing my periodic (but decidedly non-real-time) scan of RCU-related
patches in -rt, in this case v5.10.8-rt23:

db93e2f1b4b0 ("rcu: Prevent false positive softirq warning on RT")
	Looks ready for mainline, given CONFIG_PREEMPT_RT.
f3541b467fbb ("sched: Do not account rcu_preempt_depth on RT in might_sleep()")
	If the scheduler maintainers are OK with their part of this patch,
	looks good to me, given CONFIG_PREEMPT_RT.  Feel free to add:
	Acked-by: Paul E. McKenney <paulmck@ekernel.org>
d8c5a7d75e08 ("rcutorture: Avoid problematic critical section nesting on RT")
	This one I need to understand better.  I do like the use of local
	variables to make the "if" conditions less unruly.

The rest are in -rcu already:

a163ef8687a1 ("rcu: make RCU_BOOST default on RT")
	Commit 2341bc4a0311 in -rcu.  In yesterday's pull request.
5ffd75a96828 ("rcu: Use rcuc threads on PREEMPT_RT as we did")
	Commit 8b9a0ecc7ef5 in -rcu.  In yesterday's pull request.
e0b671bca2e7 ("rcu: enable rcu_normal_after_boot by default for RT")
	Commit 36221e109eb2 in -rcu.  In yesterday's pull request.
e27ef68731a1 ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
	This one is in v5.10 mainline.

Any reason I shouldn't pull in db93e2f1b4b0 ("rcu: Prevent false positive
softirq warning on RT") for v5.13?

							Thanx, Paul
