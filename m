Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739A0C433E0
	for <rcu@archiver.kernel.org>; Fri, 29 Jan 2021 16:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C9C64DFB
	for <rcu@archiver.kernel.org>; Fri, 29 Jan 2021 16:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhA2QlJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Jan 2021 11:41:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231537AbhA2Qji (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Jan 2021 11:39:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4301D64DD6;
        Fri, 29 Jan 2021 16:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611938337;
        bh=zqqLR1S+uRIwcx1AnEtqAqBKpsmic3ZFF20GVjeupRw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=muK6qMd0i8XcH++AR6E6e6vpvp2zDAj7SeuwkOV1gSHL4Ra2esPf5VFGV+cYn3O77
         IFO6y350TCYHlBKuMTOh4yChUQ7vFThzr0EJOTYqHiuhHtPwvPJdWbs1QdZLe6KHR/
         BltwDbgdL9LBsHOZjWW7MLAO7v7+nIGJ/QgO+kyJms7cWUnJL8sTkfM1MlSkE8NTnt
         VLNsbF/CaRm1HczHWtRoJq2CbYsEHp3m1JBak4g3SHyYJRMFAkKiAAlIofCnD34OV4
         Kk7vl4t1okIHPLpJ+4voCTm81lu4+WuixvjpQoHkG5VYshZDCWbDBQwGxP8GJbJwvg
         L2QVTH5bjGQ2g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D47BB35226B0; Fri, 29 Jan 2021 08:38:56 -0800 (PST)
Date:   Fri, 29 Jan 2021 08:38:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: Quick review of RCU-related patches in v5.10.8-rt23
Message-ID: <20210129163856.GD2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210128195037.GA9370@paulmck-ThinkPad-P72>
 <20210129161137.5e45ps7yzfuela2d@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129161137.5e45ps7yzfuela2d@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 29, 2021 at 05:11:37PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-01-28 11:50:37 [-0800], Paul E. McKenney wrote:
> > Hello, Sebastian,
> 
> Hi Paul,
> 
> > Just doing my periodic (but decidedly non-real-time) scan of RCU-related
> > patches in -rt, in this case v5.10.8-rt23:
> > 
> > f3541b467fbb ("sched: Do not account rcu_preempt_depth on RT in might_sleep()")
> > 	If the scheduler maintainers are OK with their part of this patch,
> > 	looks good to me, given CONFIG_PREEMPT_RT.  Feel free to add:
> > 	Acked-by: Paul E. McKenney <paulmck@ekernel.org>
> 
> Thank. I think we should pump it together with the rt-mutex part. But I
> add a note.
> 
> > d8c5a7d75e08 ("rcutorture: Avoid problematic critical section nesting on RT")
> > 	This one I need to understand better.  I do like the use of local
> > 	variables to make the "if" conditions less unruly.
> 
> This originated in
>   https://lkml.kernel.org/r/20190911165729.11178-6-swood@redhat.com
> 
> I planned to post it upstream last cycle but it appears that it broke
> apart and I did not yet look how to fix it.

I do recall the discussion, I just need to get up to speed on the
details.  ;-)

> > The rest are in -rcu already:
> > 
> > a163ef8687a1 ("rcu: make RCU_BOOST default on RT")
> > 	Commit 2341bc4a0311 in -rcu.  In yesterday's pull request.
> > 5ffd75a96828 ("rcu: Use rcuc threads on PREEMPT_RT as we did")
> > 	Commit 8b9a0ecc7ef5 in -rcu.  In yesterday's pull request.
> > e0b671bca2e7 ("rcu: enable rcu_normal_after_boot by default for RT")
> > 	Commit 36221e109eb2 in -rcu.  In yesterday's pull request.
> > e27ef68731a1 ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
> > 	This one is in v5.10 mainline.
> 
>  \o/
>  
> > Any reason I shouldn't pull in db93e2f1b4b0 ("rcu: Prevent false positive
> > softirq warning on RT") for v5.13?
> 
> tglx has a version of that with your Reviewed-by tag on it in this
> softirq tree waiting. So I guess just sit it out ;)

Works for me!

							Thanx, Paul

> Thank you for looking Paul.
> > 							Thanx, Paul
> 
> Sebastian
