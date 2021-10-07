Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CD0C433EF
	for <rcu@archiver.kernel.org>; Thu,  7 Oct 2021 00:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1EB61056
	for <rcu@archiver.kernel.org>; Thu,  7 Oct 2021 00:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhJGAUi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Oct 2021 20:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230491AbhJGAUi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Oct 2021 20:20:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E41F61177;
        Thu,  7 Oct 2021 00:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633565925;
        bh=gQCqAOHznde6By0G5rhZDtcpNGq2cAPcYB9m/ozoAu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AY1kddh5a1qMElbmhh08GuJgGYQmJuXc021Tl3pONbClHof7oq91/HPJYFEG6CE71
         Z/EitfXQv2nrsHbdikemb9foN/g7ijxRwVT1tN/BYR9+t4DmLUSp0bWbWIh0kyorbj
         biTGLl4ysN1DO4a33YJr9LsnTzd7W4d2NDiJfUF7who0i8a1vV/D7iiQYiziAaMmnX
         /cAinL+ARgKbC9iRtY18NMsvi0pKBBzbkvTShvTEJS3Z8J98GGBTBZE/6mM2FH3ntv
         sP+FYsa5FE3hDv40Owo4//gRE2UcpkRbCfbZldJ2Fi676dfOqO9aOeo5cYjorWYUGv
         52BfcjySD0Yrw==
Date:   Thu, 7 Oct 2021 02:18:43 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 10/11] rcu: Apply callbacks processing time limit only on
 softirq
Message-ID: <20211007001843.GA304532@lothringen>
References: <20210929221012.228270-1-frederic@kernel.org>
 <20210929221012.228270-11-frederic@kernel.org>
 <874ka0my57.mognet@arm.com>
 <20211004134748.GD273854@lothringen>
 <87ilyakx0z.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilyakx0z.mognet@arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 06, 2021 at 04:12:12PM +0100, Valentin Schneider wrote:
> On 04/10/21 15:47, Frederic Weisbecker wrote:
> > On Fri, Oct 01, 2021 at 06:51:32PM +0100, Valentin Schneider wrote:
> >> On 30/09/21 00:10, Frederic Weisbecker wrote:
> >> > Time limit only makes sense when callbacks are serviced in softirq mode
> >> > because:
> >> >
> >> > _ In case we need to get back to the scheduler,
> >> >   cond_resched_tasks_rcu_qs() is called after each callback.
> >> >
> >> > _ In case some other softirq vector needs the CPU, the call to
> >> >   local_bh_enable() before cond_resched_tasks_rcu_qs() takes care about
> >> >   them via a call to do_softirq().
> >> >
> >> > _ The time spent on other tasks after scheduling out, or on softirqs
> >> >   processing, is spuriously accounted to the time limit.
> >> >
> >>
> >> That wasn't the case before ("rcu: Fix callbacks processing time limit
> >> retaining cond_resched()")
> >
> > But if cond_resched_tasks_rcu_qs() was called and then on the next iteration
> > tlimit is checked, the time spent scheduling out is included, right?
> >
> 
> if tlimit was set, then that branch would either continue or break; both
> cases would have skipped over the cond_resched_tasks_rcu_qs() (which the
> aforementioned patch addresses).

Duh, right indeed. I need to clarify the changelog.

Thanks!
