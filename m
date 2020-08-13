Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5430C433E1
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 21:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E2B20791
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 21:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597353687;
	bh=T0CAT8kywJ9HaN2umOR3ajxz5LJ9JYCdh+jVacPXv5g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=TXxbDfP3hS3x5R0HOjSA4U1Ra807ceMYlbWorn2M+QbKw/Hn4H7hnP1NNdf00NCw9
	 +0qm21ZIcn/ytP6xj9mCPDmnqtXYtRY1eV1pFRCmMn2O4PwVHOMpTNvRlOSSHR1Jng
	 1xs3bFvIbyXCT/eGCd45UfSQdhgIHGYaTEBJWKGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHMVV1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgHMVV1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 17:21:27 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5157420791;
        Thu, 13 Aug 2020 21:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597353686;
        bh=T0CAT8kywJ9HaN2umOR3ajxz5LJ9JYCdh+jVacPXv5g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vt2FZnTmzfFKonC9+GVCaF6iuP6tl/Z0cnGoi3KOjHikCjkDU5igUHl0SkTAbetF+
         vYjBV6akQgjChhGkaz9TOtPjDBNMwZX+Suz6pdHfg83W51uBx4AE/t05Z0bxvqHoo/
         eGGAyBSTvXR56WOgxG3qaCybLVRyoq/cFSdVvGkM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1D0C7352279C; Thu, 13 Aug 2020 14:21:26 -0700 (PDT)
Date:   Thu, 13 Aug 2020 14:21:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chao Zhou <chaozhou1018@gmail.com>
Cc:     rcu@vger.kernel.org
Subject: Re: Allow multiple GP misses before Panic
Message-ID: <20200813212126.GG4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJdzfEd6nf9xBw7w26EdsM5ukpDEhKNc0L6PW7SKKJDCgtt+Sg@mail.gmail.com>
 <20200813181941.GD4295@paulmck-ThinkPad-P72>
 <CAJdzfEcgsCDyvVRm4dW1BAfWKKYwgfwjuEimr2wAm+sRO0JFzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJdzfEcgsCDyvVRm4dW1BAfWKKYwgfwjuEimr2wAm+sRO0JFzg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 11:50:47AM -0700, Chao Zhou wrote:
> Thanks Paul for the insights!
> 
> I studied the 3 options and think that #1+#3 offers both flexibility
> to users and coverage of boundary user cases.
> 
> For example, as an user of RCU, we want the warnings to be spilled at
> the default 21 seconds so that we know such events are happening. At
> the same time, we want Panic to happen if the stall is long enough to
> significantly affect available system memory on our system.

OK, good, you want to panic only on long stalls, not on multiple short
stalls.  Makes sense!

By the way, the short stalls sometimes indicate bugs that should
be fixed.  For example, there might be a long loop in the kernel
that needs an added cond_resched().  Fixing those would make your
systems less noisy.

I am not asking you to do anything I don't do myself:

0a3b3c253a1e ("mm/mmap.c: Add cond_resched() for exit_mmap() CPU stalls")
9f47eb5461aa ("fs/btrfs: Add cond_resched() for try_release_extent_mapping() stalls")

> Here is the plan based on our discussion, please advise if not inline
> with the idea:
> 1. modify panic_on_rcu_stall to be the maximum number of consecutive
> warnings to trigger Panic.
>     1) change its name to max_rcu_stall_to_panic,

This change would make sense were it not for the possibility that there
are lots of existing "panic_on_rcu_stall" instances in scripts, boot
parameters, and so on.  We need the old name for compatibility, and with
"0" and "1" having the same meanings as before.  We -can- use other
numbers because those other numbers were not legal before.

So we don't get to change the name.

>     2) default value to 1, which is the same behavior as today's.

The default value must be zero, which needs to mean "don't ever panic".
Setting the value to "1" must mean "panic after the very first RCU CPU
stall warning.  Other values can have other meanings.

But you could use the existing panic_on_rcu_stall to be (say) the number
of stall-warning messages that will be tolerated in a given grace period
before panicking.

Then you could create a new panic_on_rcu_stall_age or similar that
does the time-based panicking.

Either way, people currently using panic_on_rcu_stall need to be able
to continue using panic_on_rcu_stall exactly as they are without seeing
any change in behavior.  We don't break users if we have a choice,
and here we really do have a choice.  So we don't break users.

> 2. use ((struct rcu_state *)->gpnum - (struct rcu_data *)->gpnum) >=
> max_rcu_stall_to_panic as condition to trigger Panic;

This probably won't do what you want.  This would trigger only if
the rcu_data structure's ->gpnum were to lag behind the rcu_state
structure's ->gpnum, which happens now whenever a CPU is idle for
an extended time period.

For the time-based approach (#1 below), the idea would be to compare
against the rcu_state structure's ->gp_start field, and even then only
when a grace period is actually in progress.  One way to do this is
to check against the "gps" local variable in check_cpu_stall() in
kernel/rcu/tree_stall.h.

> 3. reset (struct rcu_data *)->gpnum to (struct rcu_state *)->gpnum
> every time a new grace period starts;

Touching every rcu_data structure at the beginning of each grace
period will slow things down.  This slowdown is avoided in the
current code by having each CPU update its rcu_data structure's
->gpnum when it notices a new grace period.

And ->gpnum and ->completed have been combined into a single ->gp_seq
in recent kernels.

So it is better to compare against ->gp_start (AKA "gps") as discussed
above.

> 4. add a new member (struct rcu_data *)->gpmiss that is incremented at
> each miss to track how many misses so far for statistics/debug
> purpose.

This is for #3 below, correct?

If so, please instead create an ->nstalls_cur_gp or similar in the
rcu_state structure.  Zero this at the beginning of every grace
period (in record_gp_stall_check_time() in kernel/rcu/tree_stall.h)
and increment and check it in both legs of the "if" statement at the
end of check_cpu_stall() in this same file.

> Your insights and advice are highly appreciated.

Please let me know how it goes!

							Thanx, Paul

> Thanks!
> 
> Chao
> 
> On Thu, Aug 13, 2020 at 11:19 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Aug 13, 2020 at 10:22:09AM -0700, Chao Zhou wrote:
> > > Hi,
> > >
> > > Some RCU stalls are transient and a system is fully capable to recover
> > > after that, but we do want Panic after certain amount of GP misses.
> > >
> > > Current module parameter rcu_cpu_stall_panic only turn on/off Panic,
> > > and 1 GP miss will trigger Panic when it is enabled.
> > >
> > > Plan to add a module parameter for users to fine-tune how many GP
> > > misses are allowed before Panic.
> > >
> > > To save our precious time, a diff has been tested on our systems and
> > > it works and solves our problem in transient RCU stall events.
> > >
> > > Your insights and guidance is highly appreciated.
> >
> > Please feel free to post a patch.  I could imagine a number of things
> > you might be doing from your description above:
> >
> > 1.      Having a different time for panic, so that (for example) an
> >         RCU CPU stall warning appears at 21 seconds (in mainline), and
> >         if the grace period still has not ended at some time specified
> >         by some kernel parameter.  For example, one approach would be
> >         to make the existing panic_on_rcu_stall sysctl take an integer
> >         instead of a boolean, and to make that integer specify how old
> >         the stall-warned grace period must be before panic() is invoked.
> >
> > 2.      Instead use the number of RCU CPU stall warning messages to
> >         trigger the panic, so that (for example), the panic would happen
> >         on the tenth message.  Again, the panic_on_rcu_stall sysctl
> >         might be used for this.
> >
> > 3.      Like #2, but reset the count every time a new grace period
> >         starts.  So if the panic_on_rcu_stall sysctl was set to
> >         ten, there would need to be ten RCU CPU stall warnings for
> >         the same grace period before panic() was invoked.
> >
> > Of the above three, #1 and #3 seem the most attractive, with a slight
> > preference for #1.
> >
> > Or did you have something else in mind?
> >
> >                                                         Thanx, Paul
