Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0384CC433DB
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 18:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92DD64E76
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 18:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhBQSCp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:02:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46894 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbhBQSCm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Feb 2021 13:02:42 -0500
Date:   Wed, 17 Feb 2021 19:01:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613584920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IorYWVX6aTray9URwFxb4iXem9eN7bHL8eDC2Dpv93Y=;
        b=HCPELpW/mmnioa1NDn/N6RKGX4RSoOO/sMm2U57k60FuIGKCA3PxzbzC8h7BD0PHFWny/P
        UD6Kav1UoUPwOhHp5xOFEKYvFPXPWeUIUKjmP7MoI+j4z8fq5sIV9oeCf7M6kDc56RrDSE
        tFu+4PD07VaqUWIJSuotX6lLZbLAvjeZBQdeW6zWi5zTrQIN/b+miT9gRT5OIJjl30N+qQ
        zvdW7DhOpkYk9N6qlC4ZJ1UfrtpRI4tSFpM1G6ALQka1QBFhLyl97sVmh2d0gucXu5ZKEP
        7uCQD8ZzWeiCBpHAxZTTyOqFIVX3cdnti/7Yt8MnX6TLO3EB1lqHuNgJ9Gtekg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613584920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IorYWVX6aTray9URwFxb4iXem9eN7bHL8eDC2Dpv93Y=;
        b=naYHD/i74Jm6TrgW7qqjXb44yKU6O4Tv25tS96WNLPbQRFn0zWwIxK8pHVQiDACwLZV+Ce
        kHT7VwQjy/lRQkBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: Should RCU_BOOST kernels use hrtimers in GP kthread?
Message-ID: <20210217180159.c4lr3h34lkkvjn7s@linutronix.de>
References: <20210216183609.GA7027@paulmck-ThinkPad-P72>
 <20210217153253.fy2mhxo3o3ehsuix@linutronix.de>
 <20210217155447.GC2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217155447.GC2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2021-02-17 07:54:47 [-0800], Paul E. McKenney wrote:
> > I though boosting is accomplished by acquiring a rt_mutex in a
> > rcu_read() section. Do you have some code to point me to, to see how a
> > timer is involved here? Or is it the timer saying that *now* boosting is
> > needed.
> 
> Yes, this last, which is in the grace-period kthread code, for example,
> in rcu_gp_fqs_loop().
>
> > If your hrtimer is a "normal" hrtimer then it will be served by
> > ksoftirqd, too. You would additionally need one of the
> > HRTIMER_MODE_*_HARD to make it work.
> 
> Good to know.  Anything I should worry about for this mode?

Well. It is always hardirq. No spinlock_t, etc. within that callback.
If you intend to wake a thread, that thread needs an elevated priority
otherwise it won't be scheduled (assuming there is a RT tasking running
which would block otherwise ksoftirqd).

Ah. One nice thing is that you can move the RCU threads to a house
keeping CPU - away from the CPU(s) running the RT tasks. Would this
scenario be still affected (if ksoftirqd would be blocked)?

Oh. One thing I forgot to mention: the timer_list timer is nice in terms
of moving forward (the timer did not fire, the condition is true and you
move the timeout forward).
A hrtimer timer on the other hand needs to be removed, forwarded and
added back to the "timer tree". This is considered more expensive
especially if the timer does not fire.

> Also, the current test expects callbacks to be invoked, which involves a
> number of additional kthreads and timers, for example, in nocb_gp_wait().
> I suppose I could instead look at grace-period sequence numbers, but I
> believe that real-life use cases needing RCU priority boosting also need
> the callbacks to be invoked reasonably quickly (as in within hundreds
> of milliseconds up through very small numbers of seconds).

A busy/overloaded kvm-host could lead to delays by not scheduling the
guest for a while.

My understanding of the need for RCU boosting is to get a task,
preempted (by a RT task) within a RCU section, back on the CPU to
at least close the RCU section. So it is possible to run RCU callbacks
and free memory.
The 10 seconds without RCU callbacks shouldn't be bad unless the OOM
killer got nervous (and if we had memory allocation failures).
Also, running thousands of accumulated callbacks isn't good either.

> Thoughts?
> 
> 							Thanx, Paul
Sebastian
