Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0EEC433DB
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 17:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CBB22CBE
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbhAERPc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 12:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbhAERPc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 12:15:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1237E22CBE;
        Tue,  5 Jan 2021 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609866891;
        bh=ZBm+Do+2kpIYllhXGeLT1fi8UQ0K47P8KRqerz8BmBc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WGOaQyq6Gxu8cF+0m1fEt4Zq/BlRhG/B6xkErjztRNnP2Nae/r9fPIA3jWymFm1P0
         d0A6UpJ+1LF7fJxDWvXDfHVz6FP1mpe20RqgpOCvF3BVOVLqc6LG0c9P+Lw9dFGxld
         GLddJQIpGAJrQfLoqtTEdJbT65HFYmOogzX4IrFtmPtYow5XjiqHA5fu+0v+wNZHmt
         5PjB7JUR4AXf3254LiS0SBSABhUD4Q4ZvaZWA56Q0+PW/HK1/JVp+jvHVRUehy6gIj
         9oYs7Atp7/dCJCNf8QRn2nVL/eRZeANfffKJNZbp+/p23WYE4V7KBCV/H/6CuP4tIw
         bMg/harw4paFw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C76BD3521C49; Tue,  5 Jan 2021 09:14:50 -0800 (PST)
Date:   Tue, 5 Jan 2021 09:14:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix dynticks_nmi_nesting underflow check in
 rcu_is_cpu_rrupt_from_idle
Message-ID: <20210105171450.GF17086@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1608712777-1769-1-git-send-email-neeraju@codeaurora.org>
 <20201223151231.GC2657@paulmck-ThinkPad-P72>
 <20210105134232.GI3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105134232.GI3040@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 05, 2021 at 02:42:32PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 23, 2020 at 07:12:31AM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 23, 2020 at 02:09:37PM +0530, Neeraj Upadhyay wrote:
> > > For the smp_call_function() optimization, where callbacks can run from
> > > idle context, in commit 806f04e9fd2c ("rcu: Allow for smp_call_function()
> > > running callbacks from idle"), an additional check is added in
> > > rcu_is_cpu_rrupt_from_idle(), for dynticks_nmi_nesting value being 0,
> > > for these smp_call_function() callbacks running from idle loop.
> > > However, this commit missed updating a preexisting underflow check
> > > of dynticks_nmi_nesting, which checks for a non zero positive value.
> > > Fix this warning and while at it, read the counter only once.
> > > 
> > > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > ---
> > > 
> > > Hi,
> > > 
> > > I was not able to get this warning, with scftorture.
> > > 
> > >   RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
> > >     "RCU dynticks_nmi_nesting counter underflow/zero!");
> > > 
> > > Not sure if idle loop smp_call_function() optimization is already present
> > > in mainline?
> > 
> > Now that you mention it, I don't see it.
> 
> kernel/sched/idle.c:do_idle() calls flush_smp_call_function_from_idle().
> 
> (nothing x86 specific about it)

Got it, thank you!

The reason Neeraj was unable to trigger the problematic warning from
scftorture is that its smp_call_function() handlers do not invoke
rcu_is_cpu_rrupt_from_idle().  Without adding this to those handlers
(which would be a good change to make), the only way to trigger this is
for an expedited RCU grace period to IPI a CPU that goes idle while the
IPI is in flight, which is not the easiest thing to make happen.

> > > Another thing, which I am not sure of is, maybe lockdep gets disabled
> > > in the idle loop contexts, where rcu_is_cpu_rrupt_from_idle() is called?
> > > Was this the original intention, to keep the lockdep based
> > > RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0
> > > check separate from idle task context nesting value
> > > WARN_ON_ONCE(!nesting && !is_idle_task(current)) check?
> > 
> > An easy way to test lockdep is to create a pair of locks, acquire them
> > in one order then release them both, and finally acquire them in the
> > other order and then release them both.  If lockdep is configured and
> > enabled, it will complain.
> 
> IIRC (and this is after not staring at the computer for 2 weeks) lockdep
> should work just fine in idle, except of course that RCU will be stopped
> so actually taking locks will scream bloody murder due to tracing etc..

Fair enough...

And I hope that the time off went well for you and yours!

> > The only reason I used RCU_LOCKDEP_WARN() was that people were complaining
> > to me about idle-entry overhead back at that time.  So without lockdep,
> > there is zero overhead.  Maybe people have become more tolerant of idle
> > delays, or perhaps they are not so worried about an extra check of a
> > cache-hot quantity.
> 
> Not having checks also saves on $I and branches, in general I think
> having checks depend on DEBUG features, esp. those we don't really
> expect to trigger is still sane.

OK, so should we convert the WARN_ON_ONCE() to RCU_LOCKDEP_WARN() while
we are in the area?

> > I am tempted to pull this in as is, given the current logical
> > inconsistency in the checks.  Thoughts?
> 
> Patch looks ok, although I've seen compilers do CSE on
> __this_cpu_read() (on x86).

True, but the compilers might might have a harder time of this on other
architectures.

							Thanx, Paul
