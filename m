Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4539BC433F5
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 13:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2099D61214
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 13:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhIPN6e (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Sep 2021 09:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231425AbhIPN6d (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Sep 2021 09:58:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1977261056;
        Thu, 16 Sep 2021 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631800633;
        bh=7pi9/WmFDGI13Epa0ZJPmoblkMM2+pVVYJaAkMhfSx4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HNMmiIrkabtVkvUeXE4v9ExrQ73p27uFUKRSgIMbodOW6lkR+UTsaxi6qj9LS9bEi
         hpKdqDwKiab7lp8VXV/VTMmDonlQBAK7ZpKioU4jaV50sKY02WtN3HdnMeRy53voqq
         1BKm0/GNQ6pUL/X0l8Rr1CqvcUzk43pNEV38gA5mK7SrId34/cRlqUlqByM/jQ7Iri
         kmK0PmjECNSxNa+dccYmtDQtL61xyrOzg+qOodLH8kT9ZARsDbI+F/x/YTax1qbvcO
         X4hLN0LTPwuGjANi/Q8VvWq6gWnfS6VyhQbYxVYPxWB4Sm69HO1fZXffew6fc+EsaS
         KJU52cQm+VUXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D310D5C0267; Thu, 16 Sep 2021 06:57:12 -0700 (PDT)
Date:   Thu, 16 Sep 2021 06:57:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH rcu 11/14] rcu: Make rcu_normal_after_boot writable again
Message-ID: <20210916135712.GB4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
 <20210915233343.3906738-11-paulmck@kernel.org>
 <YULyiT+RbAgHxO7u@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YULyiT+RbAgHxO7u@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 16, 2021 at 09:30:17AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 15, 2021 at 04:33:40PM -0700, Paul E. McKenney wrote:
> > From: Juri Lelli <juri.lelli@redhat.com>
> > 
> > Certain configurations (e.g., systems that make heavy use of netns)
> > need to use synchronize_rcu_expedited() to service RCU grace periods
> > even after boot.
> > 
> > Even though synchronize_rcu_expedited() has been traditionally
> > considered harmful for RT for the heavy use of IPIs, it is perfectly
> > usable under certain conditions (e.g. nohz_full).
> > 
> > Make rcupdate.rcu_normal_after_boot= again writeable on RT (if NO_HZ_
> > FULL is defined), but keep its default value to 1 (enabled) to avoid
> > regressions. Users who need synchronize_rcu_expedited() will boot with
> > rcupdate.rcu_normal_after_ boot=0 in the kernel cmdline.
> > 
> > Reflect the change in synchronize_rcu_expedited_wait() by removing the
> > WARN related to CONFIG_PREEMPT_RT.
> > 
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree_exp.h | 1 -
> >  kernel/rcu/update.c   | 2 +-
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 2796084ef85a..d9e4f8eb9ae2 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -512,7 +512,6 @@ static void synchronize_rcu_expedited_wait(void)
> >  		j = READ_ONCE(jiffies_till_first_fqs);
> >  		if (synchronize_rcu_expedited_wait_once(j + HZ))
> >  			return;
> > -		WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT));
> >  	}
> >  
> >  	for (;;) {
> 
> Urgh... I really don't like this. That would force RT applications to
> always use NOHZ_FULL which isn't always possible or desired.

???

RT systems they avoid expedited grace periods by booting with either
the rcupdate.rcu_normal or the rcupdate.rcu_normal_after_boot kernel
boot parameters.  And here is the definition for the latter:

static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);

In other words, RT systems shut off expedited grace periods by default,
and are thus free to use nohz_full CPU or not, as they choose.  When using
nohz_full, they can also enable expedited grace periods by booting with
rcupdate.rcu_normal_after_boot=0.  Or not, sysadm's choice.

So I am not seeing a problem here.  What am I missing?

> WTH does that netns crud need expedited so much?

Large systems with lots of networking configurations can take quite some
time to set things up due to waiting for many grace periods.  In addition,
last I checked, expedited grace periods were used to reduce contention
on RTNL.

If you have a modest-sized system with less elaborate networking setup
and make use of the batched network-configuration mechanisms, there
should be no problem using normal grace periods.

Which has been the set of constraints that RT has been living with for
quite some time.

Again, what am I missing?

							Thanx, Paul
