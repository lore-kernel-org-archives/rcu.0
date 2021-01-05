Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2750C433DB
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A440F22BF3
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 13:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbhAENnb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbhAENnb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 08:43:31 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3625C061795;
        Tue,  5 Jan 2021 05:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+euDtxcGipU8q+U8BbJ2JReGBO3U7/zwdT6b3FGSnPY=; b=sn2God1DiTyvt/Xakejls2197D
        AtaU+rRl4bMkTxGXmvu96Yu8SsTSfftIky0jfQ9vysJLFWj1MkuAyI0aHyAw1EuNrilBUAD6vCvzw
        vAaSLruZhxBIIy+ActXuZ++ciZom9mr/W1GQ+So4KfPtUPZQmTxZ7eI2zAyF9+z8ugny5M8yhX+t0
        4BVeLWCohvdkGgc31SiIpNK6Gn12JToW2sI9I4fAe8oAJYwcGo9DjBYLv8xnx1ZTIPmqn7+uRAMqK
        OQAHh4YLRVl8ghOp0uCwjP3VyIMoR7UbBA305fQChny26NzVqohc6x+L6/9nSYVFgFfgGTH71M3c4
        Ud8HQdPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwmba-0007aK-0c; Tue, 05 Jan 2021 13:42:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E7A430015A;
        Tue,  5 Jan 2021 14:42:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16893200C641B; Tue,  5 Jan 2021 14:42:32 +0100 (CET)
Date:   Tue, 5 Jan 2021 14:42:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix dynticks_nmi_nesting underflow check in
 rcu_is_cpu_rrupt_from_idle
Message-ID: <20210105134232.GI3040@hirez.programming.kicks-ass.net>
References: <1608712777-1769-1-git-send-email-neeraju@codeaurora.org>
 <20201223151231.GC2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223151231.GC2657@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 23, 2020 at 07:12:31AM -0800, Paul E. McKenney wrote:
> On Wed, Dec 23, 2020 at 02:09:37PM +0530, Neeraj Upadhyay wrote:
> > For the smp_call_function() optimization, where callbacks can run from
> > idle context, in commit 806f04e9fd2c ("rcu: Allow for smp_call_function()
> > running callbacks from idle"), an additional check is added in
> > rcu_is_cpu_rrupt_from_idle(), for dynticks_nmi_nesting value being 0,
> > for these smp_call_function() callbacks running from idle loop.
> > However, this commit missed updating a preexisting underflow check
> > of dynticks_nmi_nesting, which checks for a non zero positive value.
> > Fix this warning and while at it, read the counter only once.
> > 
> > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > ---
> > 
> > Hi,
> > 
> > I was not able to get this warning, with scftorture.
> > 
> >   RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
> >     "RCU dynticks_nmi_nesting counter underflow/zero!");
> > 
> > Not sure if idle loop smp_call_function() optimization is already present
> > in mainline?
> 
> Now that you mention it, I don't see it.

kernel/sched/idle.c:do_idle() calls flush_smp_call_function_from_idle().

(nothing x86 specific about it)

> > Another thing, which I am not sure of is, maybe lockdep gets disabled
> > in the idle loop contexts, where rcu_is_cpu_rrupt_from_idle() is called?
> > Was this the original intention, to keep the lockdep based
> > RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0
> > check separate from idle task context nesting value
> > WARN_ON_ONCE(!nesting && !is_idle_task(current)) check?
> 
> An easy way to test lockdep is to create a pair of locks, acquire them
> in one order then release them both, and finally acquire them in the
> other order and then release them both.  If lockdep is configured and
> enabled, it will complain.

IIRC (and this is after not staring at the computer for 2 weeks) lockdep
should work just fine in idle, except of course that RCU will be stopped
so actually taking locks will scream bloody murder due to tracing etc..

> The only reason I used RCU_LOCKDEP_WARN() was that people were complaining
> to me about idle-entry overhead back at that time.  So without lockdep,
> there is zero overhead.  Maybe people have become more tolerant of idle
> delays, or perhaps they are not so worried about an extra check of a
> cache-hot quantity.

Not having checks also saves on $I and branches, in general I think
having checks depend on DEBUG features, esp. those we don't really
expect to trigger is still sane.

> I am tempted to pull this in as is, given the current logical
> inconsistency in the checks.  Thoughts?

Patch looks ok, although I've seen compilers do CSE on
__this_cpu_read() (on x86).
