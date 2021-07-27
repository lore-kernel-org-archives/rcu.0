Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DE2C4338F
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 23:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 157D260F9B
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 23:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhG0XU1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232198AbhG0XU0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jul 2021 19:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A278C60F57;
        Tue, 27 Jul 2021 23:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627428026;
        bh=oayX6ah1IH4ZK6fGILP3gmCx5zvZQX+ocgcqevCCn+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CpFr7/gRClIa2dD4l5zUN5a3tJMG2V4hBoc0TNEJfPcMvtyiaSyPzKN6Cc5gb5KDL
         dh/Sw8ZNm06JhUMknfrQv5x86E5jodQFuKG9Nr/krLzwyfCtfX3oN+oJ07PSJNkpaW
         PZIFPHuW0xVuyV7NxczmN6s5AUyAU3deZ3G7joo2EkYRfJlU1ADB/T4EawjfeMuWYY
         Ds+hb3nN0+UoJMKZg76svTos821LtNchk07iuz8a4EUarVpX9jZ8M4CBvempepwNSg
         yL9X7FLghCFREg7u5yOi6wo4xf3uXfKKj2xOObv7thy7O6Q9noBjpTtSSTx0gxty3e
         YNLK87GSBodPw==
Date:   Wed, 28 Jul 2021 01:20:23 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu/nocb: Extend checks for offloaded rdp by
 migrate_disable
Message-ID: <20210727232023.GD283787@lothringen>
References: <20210727163815.nwvg5delbqs3ysxl@linutronix.de>
 <20210727172351.GC4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210727172351.GC4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 27, 2021 at 10:23:51AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 27, 2021 at 06:38:15PM +0200, Sebastian Andrzej Siewior wrote:
> > Commit 3820b513a2e33 ("rcu/nocb: Detect unsafe checks for offloaded
> > rdp") added checks for safe rdp usage in the nocb case.
> > 
> > On PREEMPT_RT this checks triggers in the
> >  rcu_cpu_kthread() -> rcu_core() -> rcu_check_quiescent_state() ->
> >   rcu_rdp_is_offloaded()
> > 
> > call chain. On !PREEMPT_RT this warnings is suppressed because rcu_core()
> > is invoked with disabled BH which also disables preemption and
> > "preemptible()" is part of the checks which are considered safe.
> > On PREEMPT_RT disabling BH does not disable preemption and since there
> > is no other criteria the warning triggers.
> > 
> > According to the mentioned commit the goal is to check if the rcu data
> > pointer is "stable … and prevent from its value to be changed under us".
> > My understanding is that this may happen if the task is preemptible and
> > therefore free to be migrated to another CPU which would then lead to
> > another value of `rcu_data'.
> > One thing that has been overseen is that a task within a migrate-disable
> > region (as on PREEMPT_RT with disabled BH) is fully preemptible but may
> > not be migrated to another CPU which should be enough to guarantee that
> > rdp remains stable.
> > 
> > Check also disabled migration of the task if the RCU data pointer is
> > from current CPU. Put the whole check within an SMP ifdef block since
> > without SMP there are not CPU migrations to worry about (also
> > task_struct::migration_disabled is missing).
> > 
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > I don't fully understand why the CPU-hotplug lock matters here but this
> > is beside the point ;)
> 
> If I remember correctly, any attempt to change the offloaded state
> must hold off CPU-hotplug operations.  So if the current thread is
> holding off CPU-hotplug operations, no other thread can be doing
> an offload or de-offload operation.

Exactly! :)
