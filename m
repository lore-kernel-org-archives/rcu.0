Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B0AC43381
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 812F664E4B
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhBQTow (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:44:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbhBQToo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Feb 2021 14:44:44 -0500
Date:   Wed, 17 Feb 2021 20:43:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613591041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GMqp8oEZfhAb6qDKCdq5YeW4+55exCSRTAdK0yr3Q1s=;
        b=U7rgM9nSlM+RmwfpYhIiWwsXqTqxejKrydEZIjBjHHmy4R+cRjc8ibUf1C8cDmVOQ3DiMn
        ZibqMusrV/7GQs1KuYbGbreG/mICqROo30v+HubeSI1KwNf/1doCWXqJ7uouOCYG5K6H9I
        Yxb9qio0+LyZNyADZf7fXoFhX3fe/QGZcJltc+DGSWbG5ql9dEd+2Yq6SFBEKIeWeCiCr/
        T3hHBFT/Cfs7oBUBvLMwuizUJidQpciOwI2PLJhnOoYqMJXjC5ff7oCNs4F8RC8mTK2YvV
        aW2shLVO9TIGzrXdcuC8W8TKNSJX54rPMSzD0tLxRYqBJmdbLO1DJHXe24K9gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613591041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GMqp8oEZfhAb6qDKCdq5YeW4+55exCSRTAdK0yr3Q1s=;
        b=C2rdsvix9Cv3CClUnc0KLNo4CsVvV/mU4CJ7DJnZ8tKn2yOtzKAGs1FmwyifmJL9PUJ3AT
        SBzsNr+oqwKb4mAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: Should RCU_BOOST kernels use hrtimers in GP kthread?
Message-ID: <20210217194359.m647inivfp4frzc7@linutronix.de>
References: <20210216183609.GA7027@paulmck-ThinkPad-P72>
 <20210217153253.fy2mhxo3o3ehsuix@linutronix.de>
 <20210217155447.GC2743@paulmck-ThinkPad-P72>
 <20210217180159.c4lr3h34lkkvjn7s@linutronix.de>
 <20210217191907.GH2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217191907.GH2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2021-02-17 11:19:07 [-0800], Paul E. McKenney wrote:
> > Ah. One nice thing is that you can move the RCU threads to a house
> > keeping CPU - away from the CPU(s) running the RT tasks. Would this
> > scenario be still affected (if ksoftirqd would be blocked)?
> 
> At this point, I am going to say that it is the sysadm's job to place
> the rcuo kthreads, and if they are placed poorly, life is hard.

Good. Because that is what I suggest :)

> > Oh. One thing I forgot to mention: the timer_list timer is nice in terms
> > of moving forward (the timer did not fire, the condition is true and you
> > move the timeout forward).
> > A hrtimer timer on the other hand needs to be removed, forwarded and
> > added back to the "timer tree". This is considered more expensive
> > especially if the timer does not fire.
> 
> There are some timers that are used to cause a wakeup to happen from
> a clean environment, but maybe these can instead use irq-work.

irq-work has also a "hard" mode because people ended up to throwing
everything in there.

> That it can!  Aravinda Prasad prototyped a mechanism hinting to the
> hypervisor in such cases, but I don't know that this ever saw the light
> of day.

Ah, good to know.

> > My understanding of the need for RCU boosting is to get a task,
> > preempted (by a RT task) within a RCU section, back on the CPU to
> > at least close the RCU section. So it is possible to run RCU callbacks
> > and free memory.
> > The 10 seconds without RCU callbacks shouldn't be bad unless the OOM
> > killer got nervous (and if we had memory allocation failures).
> > Also, running thousands of accumulated callbacks isn't good either.
> 
> Sounds good, thank you!

I hope my understanding was correct. Glad to be if service :)

> 
> 							Thanx, Paul
> 
Sebastian
