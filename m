Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67579C34022
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 23:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3385D20801
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 23:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581981046;
	bh=IlqVkbwn4RNuULuX2RYl0Y7FZw236aKOJdaJutAiaQ0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=enBar/X994pGTI4Xssx6RArXHXzkUhO3nFISJCFKDqq9Vs/O7sCu9qtv+JgSaKlYd
	 TefEIGbrXrXxJFpo/ooN+tRC8KUVmrhL5cCYo0iHc2AWrl7O3V0w505GtgK2lXEbKI
	 BRnH3i7qaL1THmNU6/PFFqmUvIWbzFN1AspMPs0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgBQXKq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:10:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgBQXKp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 18:10:45 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D6620725;
        Mon, 17 Feb 2020 23:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581981045;
        bh=IlqVkbwn4RNuULuX2RYl0Y7FZw236aKOJdaJutAiaQ0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n/6vnVzMGQwVLBp4PNaPUzcfn77ztU9CwSpfl5XJL0vJ4cTHwnacI3VbELAnLKp39
         37cAD9Jnq2h/Lhu6BqQ1V4R1gbnzKi1612RVqQ7m2BM8vVaU5/qTpKm40hXgikLAec
         rCOFLdOKMOEtgccwHKpHKxVpNxN6XUKSekTwub1Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0D6E335227A8; Mon, 17 Feb 2020 15:10:45 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:10:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, Jules Irenge <jbi.octave@gmail.com>
Subject: Re: [PATCH tip/core/rcu 2/3] rcu: Add missing annotation for
 exit_tasks_rcu_start()
Message-ID: <20200217231045.GA2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-2-paulmck@kernel.org>
 <20200217144452.GA145700@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217144452.GA145700@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 17, 2020 at 09:44:52AM -0500, Joel Fernandes wrote:
> On Fri, Feb 14, 2020 at 04:25:19PM -0800, paulmck@kernel.org wrote:
> > From: Jules Irenge <jbi.octave@gmail.com>
> > 
> > Sparse reports a warning at exit_tasks_rcu_start(void)
> > 
> > |warning: context imbalance in exit_tasks_rcu_start() - wrong count at exit
> > 
> > To fix this, this commit adds an __acquires(&tasks_rcu_exit_srcu).
> > Given that exit_tasks_rcu_start() does actually call __srcu_read_lock(),
> > this not only fixes the warning but also improves on the readability of
> > the code.
> 
> For patch 1/3 and 2/3:
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied, thank you!

> Though IMO it would be good to squash both the patches.

Fair point, but I will leave them be.  ;-)

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/update.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index a27df76..a04fe54 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -801,7 +801,7 @@ static int __init rcu_spawn_tasks_kthread(void)
> >  core_initcall(rcu_spawn_tasks_kthread);
> >  
> >  /* Do the srcu_read_lock() for the above synchronize_srcu().  */
> > -void exit_tasks_rcu_start(void)
> > +void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
> >  {
> >  	preempt_disable();
> >  	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> > -- 
> > 2.9.5
> > 
