Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B9AC3815B
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 18:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783E021744
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 18:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587406400;
	bh=NGYdlkQpBRCIJcghQ3EYvAq/2L+qTXwwCcoPLpO5gYQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=WId7g3w+8OFa6x1cKxBeAVT0G6VQkBOgNxJ5pcz6XhN1aMPREeX28KJqCllYqd7HD
	 JZDUK2Njixh9yg80Jawjt87Ge4Q/qIzuaWhjl7fcPYTYoMq1r2w4oVpKotSr5ndLkr
	 MWMLhIIYG0UH8BSYGE7HX/Lzd4VpEYq72VUj/Cp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgDTSNU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgDTSNT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Apr 2020 14:13:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D96BD2084D;
        Mon, 20 Apr 2020 18:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587406398;
        bh=NGYdlkQpBRCIJcghQ3EYvAq/2L+qTXwwCcoPLpO5gYQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=D7qNe54NLWPxkPvaPbqoZUXiZargmJ2r9Np8yFGiH9StP6Emdynyp78kwnX4bK+aR
         2a4K3qyTBeKhyOPbs8g2kmdito+fK2RhLgVPzxpHPsuaRdoRSWPYrzhC2LlaVRb4tP
         eOyZ3VBHC3RU3onTmzSjXBoYxiSskj01XaA8IVyU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ABE113523398; Mon, 20 Apr 2020 11:13:18 -0700 (PDT)
Date:   Mon, 20 Apr 2020 11:13:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200420181318.GI17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200420130003.GA10470@pc636>
 <20200420132601.GY17661@paulmck-ThinkPad-P72>
 <20200420160847.GA11451@pc636>
 <20200420162534.GD17661@paulmck-ThinkPad-P72>
 <20200420162900.GA11867@pc636>
 <20200420164657.GE17661@paulmck-ThinkPad-P72>
 <20200420165924.GA12078@pc636>
 <20200420172126.GG17661@paulmck-ThinkPad-P72>
 <20200420174019.GB12196@pc636>
 <20200420175750.GA229870@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420175750.GA229870@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 20, 2020 at 01:57:50PM -0400, Joel Fernandes wrote:
> On Mon, Apr 20, 2020 at 07:40:19PM +0200, Uladzislau Rezki wrote:
> > On Mon, Apr 20, 2020 at 10:21:26AM -0700, Paul E. McKenney wrote:
> [...]
> > > > > > > > > > <snip>
> > > > > > > > > > /**
> > > > > > > > > >  * queue_work_on - queue work on specific cpu
> > > > > > > > > >  * @cpu: CPU number to execute work on
> > > > > > > > > >  * @wq: workqueue to use
> > > > > > > > > >  * @work: work to queue
> > > > > > > > > >  *
> > > > > > > > > >  * We queue the work to a specific CPU, the caller must ensure it
> > > > > > > > > >  * can't go away.
> > > > > > > > > >  *
> > > > > > > > > >  * Return: %false if @work was already on a queue, %true otherwise.
> > > > > > > > > >  */
> > > > > > > > > > <snip>
> > > > > > > > > > 
> > > > > > > > > > It says, how i see it, we should ensure it can not go away. So, if
> > > > > > > > > > we drop the lock we should do like:
> > > > > > > > > > 
> > > > > > > > > > get_online_cpus();
> > > > > > > > > > check a CPU is onlen;
> > > > > > > > > > queue_work_on();
> > > > > > > > > > put_online_cpus();
> > > > > > > > > > 
> > > > > > > > > > but i suspect we do not want to do it :)
> > > > > > > > > 
> > > > > > > > > Indeed, it might impose a few restrictions and a bit of overhead that
> > > > > > > > > might not be welcome at some point in the future.  ;-)
> > > > > > > > > 
> > > > > > > > > On top of this there are potential load-balancing concerns.  By specifying
> > > > > > > > > the CPU, you are limiting workqueue's and scheduler's ability to adjust to
> > > > > > > > > any sudden changes in load.  Maybe not enough to matter in most cases, but
> > > > > > > > > might be an issue if there is a sudden flood of  kfree_rcu() invocations.
> > > > > > > > > 
> > > > > > > > Agree. Let's keep it as it is now :)
> > > > > > > 
> > > > > > > I am not sure which "as it is now" you are referring to, but I suspect
> > > > > > > that the -rt guys prefer two short interrupts-disabled regions to one
> > > > > > > longer interrupts-disabled region.
> > > > > > 
> > > > > > I mean to run schedule_delayed_work() under spinlock.
> > > > > 
> > > > > Which is an interrupt-disabled spinlock, correct?
> > > > > 
> > > > To do it under holding the lock, currently it is spinlock, but it is
> > > > going to be(if you agree :)) raw ones, which keeps IRQs disabled. I
> > > > saw Joel sent out patches.
> > > 
> > > Then please move the schedule_delayed_work() and friends out from
> > > under the spinlock.  Unless Sebastian has some reason why extending
> > > an interrupts-disabled critical section (and thus degrading real-time
> > > latency) is somehow OK in this case.
> > > 
> > Paul, if move outside of the lock we may introduce unneeded migration
> > issues, plus it can introduce higher memory footprint(i have not tested).
> > I have described it in more detail earlier in this mail thread. I do not
> > think that waking up the work is an issue for RT from latency point of
> > view. But let's ask Sebastian to confirm.
> 
> I was also a bit concerned about migration. If we moved it outside of lock,
> then even on !PREEMPT_RT, we could be migrated before the work is
> scheduled. Then we'd lose the benefit of executing the work on the same CPU
> where it is queued. There's no migrate_disable() in non-PREEMPT_RT when I
> recently checked as well :-\ (PeterZ mentioned that migrate_disable() is hard
> to achieve on !PREEMPT_RT).
> 
> > Sebastian, do you think that placing a work on current CPU is an issue?
> > If we do it under raw spinlock?
> 
> Yes, I am also curious if calling schedule_delayed_work can cause long
> delays at all. Considering that workqueue code uses raw spinlocks as Mike
> mentioned, I was under the impression that this code should not be causing
> such issues, and the fact that it is called in many places from IRQ-disabled
> sections as well.
> 
> Let us definitely double-check and discuss it more to be sure.

Just to be clear, I am not trying to NAK this approach.  Yet, anyway.
Just trying to make sure that we think it through.  Because it is easier
to get it right now than it ever will be in the future.  ;-)

							Thanx, Paul
