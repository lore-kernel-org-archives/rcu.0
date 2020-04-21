Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8580C54FCC
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 15:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 906B7206F4
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587483662;
	bh=1lhnjJWsMC3T1WrP3jwmJrjJJT6cw2ZsGtYZY9lYdJE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=aW5uTHMjZ0Xam1vvy2uFpvMW7UUn0Pbj619dm9rvI7XcPAu1el08OZ27TEhCtAWn+
	 0f4fCK3AJQj51wHuxWKcMwvkf+XJgaG/Oheu9Kb3TJSM1Kb4Ww5h8ozz6qEtsoOqxy
	 II9oHsOqQRHpHWUbMzqBMoyhz7FJ2pxkwLN1mu7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgDUPlC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgDUPlC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Apr 2020 11:41:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6034206E9;
        Tue, 21 Apr 2020 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587483661;
        bh=1lhnjJWsMC3T1WrP3jwmJrjJJT6cw2ZsGtYZY9lYdJE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CkVltaQ9XEXGd0RayPpj4Gy9M2fBxEgiKm0wBTCv8miKh5vvvRarfhYz2L7WDI7CJ
         VRoiZEstKVUk91d2UnHlUhZ2UjcRi7V4hdfYuGpS3KvBRhv6slnbR1Trkkw8B4rmUO
         wKBXNal/JB0TDUu04r4zByxzqicT88gvdQ03tqSw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6B9B33523432; Tue, 21 Apr 2020 08:41:01 -0700 (PDT)
Date:   Tue, 21 Apr 2020 08:41:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, joel@joelfernandes.org,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200421154101.GN17661@paulmck-ThinkPad-P72>
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
 <20200421133947.cmdchrx73ru7szuz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421133947.cmdchrx73ru7szuz@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 21, 2020 at 03:39:47PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-20 19:40:19 [+0200], Uladzislau Rezki wrote:
> > Paul, if move outside of the lock we may introduce unneeded migration
> > issues, plus it can introduce higher memory footprint(i have not tested).
> > I have described it in more detail earlier in this mail thread. I do not
> > think that waking up the work is an issue for RT from latency point of
> > view. But let's ask Sebastian to confirm.
> > 
> > Sebastian, do you think that placing a work on current CPU is an issue?
> > If we do it under raw spinlock?
> 
> I sent one simple patch to address the issues I see now. It was raised
> that the patch may introduce a performance regression (`may' since we
> had no numbers back it up) in case where we the context would be
> migrated from one CPU to another between "this" and "spin_lock". It was
> suggested to use migrate_disable() to avoid it.
> 
> It was then decided to address possible future problems and make the
> lock raw which brings us here.
> 
> Invoking queue_work() is not a problem locking wise. It does however
> extend the length of the critical section (which is not yet needed).

I am guessing that by "which is not yet needed" you were meaning that
it is not absolutely necessary to extend the length of the critical
section.  Please correct me if my guess is wrong.

In the meantime, plunging ahead...

One approach might be to move queue_work() and friends out of the critical
section, but only enable interrupts between the two critical sections
under CONFIG_PREEMPT_RT_FULL.  Would that be a reasonable approach?

							Thanx, Paul
