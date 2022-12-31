Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2510BC4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 16:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiLaQIB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Dec 2022 11:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiLaQIB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Dec 2022 11:08:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ADC2DFF
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 08:07:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDE2260BEA
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 16:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D45C433EF;
        Sat, 31 Dec 2022 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672502876;
        bh=Lnoka6a+Cd1K8NMEkIb2MUzx68l8Bzl6tOJ8lJOrzb4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CBGGJkUqQo/ldtrt/82SX92pevAkOxiOlY8DQUeBLw8Q90gA8Fva74S3UCPGfOx0y
         0qiofRr1TjW0TuzIqmSy2YIkhXlAs6+C5uw9pX9ysE2Xmq3B8k+y2IcEIsZMGcWCqW
         8T2HlQZhP78zsZ27N0w/+tJ3vkepYGP4BqkDB0+fMWx8HAipkTXctDPa6J/xZLB54Y
         smF+4gvkBVU8o7kU01wuCFedUzc63cdbyfQ1JWCk+XKWoI0Abpqd0KNg8B65ARumC6
         E+TvPCBkoSg+mRpy1ATEkV1+xZNEoQNheINF4kRXLS2jXNhBEkVN0GbvBYGAmIrtWr
         GWU72e6cITLNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EBAA35C06D0; Sat, 31 Dec 2022 08:07:55 -0800 (PST)
Date:   Sat, 31 Dec 2022 08:07:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
Message-ID: <20221231160755.GR4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YStxQFB1qRyHhqFE_hjeO2f+_U-=KY07SewM0LHWv2Q+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YStxQFB1qRyHhqFE_hjeO2f+_U-=KY07SewM0LHWv2Q+g@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Dec 31, 2022 at 12:28:10AM -0500, Joel Fernandes wrote:
> On Fri, Dec 30, 2022 at 9:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Dec 30, 2022 at 08:42:24PM -0500, Joel Fernandes wrote:
> > > Hello,
> > >
> > > I have been firefighting a hang on 6.0.y stable kernels with
> > > rcutorture. It happens mostly consistently when TREE07 is shutting
> > > down.
> > >
> > > It appears that the RCU torture threads are attempted to stop but the
> > > shutdown thread, but are constantly awakened by a timer softirq
> > > handler in ksoftirqd context. When they wake up, they immediately goto
> > > sleep in uninterruptible state until the next time a timer handler
> > > wakes them up. It appears the timer softirq is long enough to cause
> > > RCU stalls and I see it calling 100s of timer function handlers
> > > (call_timer_fn).
> > >
> > > I am doing some more investigation with trace_printk(s):
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=stable/trace-hang-6.0.y&id=b779b1e92c97f29333a282ee8f548da02f64de2b
> > >
> > > Regarding the timer handlers, I was wondering if it is possible that a
> > > large number of timer handlers constantly queued can cause RCU stalls
> > > due to the timer softirq taking a very long time. That certainly
> > > appears to be the case here. Shouldn't the timer softirq also do
> > > rcu_softirq_qs() similar to the ksoftirq loop, in case there are too
> > > many of them?
> >
> > That is certainly a good thing to try!
> 
> I am trying something like this just for testing, let's see what happens ;-)
> 
> @@ -1788,9 +1796,14 @@ static inline void __run_timers(struct timer_base *base)
> 
>                 while (levels--)
>                         expire_timers(base, heads + levels);

Might you need to put it inside the body of this "while" loop?

> +
> +               rcu_softirq_qs();
>         }
> 
> I guess I am also wondering why the rcu reader does not stop queuing
> timers. It is doing schedule_timeout_interruptible() constantly even
> though the test is being stopped.

As in it is doing schedule_timeout_interruptible() in a loop that does
not check torture_must_stop()?  That would be bad unless there is some
reason the loop cannot just stop.  But if the loop cannot just stop,
that leads me to believe that there is a bug elsewhere.  After all, given
that the test is ending, why shouldn't all the loops be able to just stop?
(Maybe it is waiting on a buggy child task, for example.)

							Thanx, Paul
