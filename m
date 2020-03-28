Return-Path: <SRS0=Mmc0=5N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5518C43331
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 15:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7036F2073B
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585409674;
	bh=fULbPKjOq4E91nu36KHICTyk0L3t37HcS6E+MYTYkbE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vXyCYgsWTWkm7OVFIWKgDj+DuQ2hiOSkSlpymb5bMdj2IVGipumtawWDfNIQMsug9
	 nQ6LAoc4CZ0Ys7CjFapXPSharlkLtoR2T7CzYh5dFYxNLKnvWJ5wgWQGf7Aso4Q5pN
	 4E63US8H/2zZVYKnQ8/+5b8kPrWVpkFew62B86zA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC1Pee (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 28 Mar 2020 11:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1Pee (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 276DA20716;
        Sat, 28 Mar 2020 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409673;
        bh=fULbPKjOq4E91nu36KHICTyk0L3t37HcS6E+MYTYkbE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Gf8YTMZrXX2dXhuLYBTp0EM6GbhACYRF8tkujSja7iWA3za3kgF3tp5U4uWmIoqDF
         Nu996ShHrubW9w1q7i6BNmXUaexpzq1WWDEfzbHXidoS76GzkT5LwatjcmPqP423CB
         3GszUhROM1m76SqM6WIMGIe05i6aossoiFz1IqO8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E6C3F35226C6; Sat, 28 Mar 2020 08:34:32 -0700 (PDT)
Date:   Sat, 28 Mar 2020 08:34:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH RFC v2 tip/core/rcu 14/22] rcu-tasks: Add an RCU Tasks
 Trace to simplify protection of tracing hooks
Message-ID: <20200328153432.GB19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-14-paulmck@kernel.org>
 <20200319154239.6d67877d@gandalf.local.home>
 <20200320002813.GL3199@paulmck-ThinkPad-P72>
 <20200319204838.1f78152a@gandalf.local.home>
 <20200320024152.GM3199@paulmck-ThinkPad-P72>
 <20200328140635.GA201808@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328140635.GA201808@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Mar 28, 2020 at 10:06:35AM -0400, Joel Fernandes wrote:
> On Thu, Mar 19, 2020 at 07:41:53PM -0700, Paul E. McKenney wrote:
> > On Thu, Mar 19, 2020 at 08:48:38PM -0400, Steven Rostedt wrote:
> > > On Thu, 19 Mar 2020 17:28:13 -0700
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > 
> > > > Good point.  If interrupts are disabled, it will need to use some
> > > > other mechanism.  One approach is irqwork.  Another is a timer.
> > > > 
> > > > Suggestions?
> > > 
> > > Ftrace and perf use irq_work, I would think that should work here too.
> > 
> > Sounds good, will give it a go!  And thank you for catching this!
> 
> Since the the Tasks-RCU holdout thread is supposed to wake up periodically to
> scan holdout tasks anyway, can it not detect the end of the Trace-RCU grace
> period on its next wake up? Sorry if I missed something.

It could, and that was how it was structured in the first version.
The reason for the timed waits is to be able to print stall warnings.

So here is the (abbreviated) sequence of events:

o	Callbacks appear, waking the kthread.

o	The kthread moves the callbacks to a private list
	and starts the grace period.

o	The kthread scans the tasklist, moving tasks that need
	further processing to the holdout list.  Note that these
	tasks are holding out from being checked, not necessarily
	from being in a quiescent state.

	Note also that tasks that are checked and found to be in
	a read-side critical section are only added to the holdout
	list if their state cannot be modified.

o	The kthreads repeatedly scans the holdout list.  Once a
	task has been successfully checked, it is removed from
	the holdout list.

o	When the holdout list is empty, the kthread stops scanning it.

o	However, the grace period is not necessarily over because some of
	the previously tasks might still be in their read-side critical
	sections.

	So, as noted above, the kthread does timed waits for the
	count of such tasks to go to zero, printing stall warnings
	along the way if it takes too long.

Or am I missing your point?

							Thanx, Paul
