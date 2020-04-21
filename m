Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7ABC54FC9
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 13:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45246206A5
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 13:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgDUNjy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728391AbgDUNjx (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 21 Apr 2020 09:39:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A4BC061A10
        for <rcu@vger.kernel.org>; Tue, 21 Apr 2020 06:39:53 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jQt7r-0003t7-IR; Tue, 21 Apr 2020 15:39:47 +0200
Date:   Tue, 21 Apr 2020 15:39:47 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, joel@joelfernandes.org,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200421133947.cmdchrx73ru7szuz@linutronix.de>
References: <616B79E2-977A-4079-ADAC-2D326A7284A4@joelfernandes.org>
 <20200420130003.GA10470@pc636>
 <20200420132601.GY17661@paulmck-ThinkPad-P72>
 <20200420160847.GA11451@pc636>
 <20200420162534.GD17661@paulmck-ThinkPad-P72>
 <20200420162900.GA11867@pc636>
 <20200420164657.GE17661@paulmck-ThinkPad-P72>
 <20200420165924.GA12078@pc636>
 <20200420172126.GG17661@paulmck-ThinkPad-P72>
 <20200420174019.GB12196@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200420174019.GB12196@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-04-20 19:40:19 [+0200], Uladzislau Rezki wrote:
> Paul, if move outside of the lock we may introduce unneeded migration
> issues, plus it can introduce higher memory footprint(i have not tested).
> I have described it in more detail earlier in this mail thread. I do not
> think that waking up the work is an issue for RT from latency point of
> view. But let's ask Sebastian to confirm.
> 
> Sebastian, do you think that placing a work on current CPU is an issue?
> If we do it under raw spinlock?

I sent one simple patch to address the issues I see now. It was raised
that the patch may introduce a performance regression (`may' since we
had no numbers back it up) in case where we the context would be
migrated from one CPU to another between "this" and "spin_lock". It was
suggested to use migrate_disable() to avoid it.

It was then decided to address possible future problems and make the
lock raw which brings us here.

Invoking queue_work() is not a problem locking wise. It does however
extend the length of the critical section (which is not yet needed).

> Thank you!
> 

Sebastian
