Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BCAC3815B
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 17:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C77420B1F
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 17:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="N52o7qIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgDTR5y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgDTR5x (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 20 Apr 2020 13:57:53 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5593C061A0C
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 10:57:53 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l13so9292651qtr.7
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q1ipLMLrbY4bei6wL9vWTH46eLq0e8tAch3hXTAsbCs=;
        b=N52o7qIa2i2jQj4+uZ3lK2WIoJEHRlO5wphLbu4XLxExyWkFSR//cypxgrqSMBJWEm
         3/6twiSBPjFmuO69hD4wOF63aj7wrRK4DJmdQjC3rlQ/sTguHYGsalS0jdFmT8rKAsyz
         HaM0up8TtrVBGWMTM8nZLSVIV+dNfcPLYozeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q1ipLMLrbY4bei6wL9vWTH46eLq0e8tAch3hXTAsbCs=;
        b=buWNqnwo4aoRFQRExZHjeffa3GZC/NUEIL29jBYcVzF7J7w8IjeetopAvJiHf2qiT7
         gW2Uls+m8KQEt5bhEUfaz7cdvV/O/LDw1lI/3CppZiVv4RHWri9LFE4M+6ydRhhxRZDK
         9sUsxXjxjPnXyRhlXw7jcwjLgjktV92Oq2pUqRXY5OvoIRRLIhDWImbbyn7F3EoM3oRl
         Z2upHjhnRZNpUfsN6PP9YWwBpnhaQrG2OtUsLs2P3ncT6LsO/FHQJMqGGrOwmd/o8CHn
         eba4Jm5aPSKNLZS/wnkfoim7Y/1TTdW/lzEE5tr6zw350GT6Z9ach9EMz8KwHxGhLNCf
         Nz6w==
X-Gm-Message-State: AGi0PuZxuriqH+QS1i9yTPmBUnwFT5MBAHn+VsleE9thCWwZqIXP0dTX
        rxzNZiZdm3K8Wk9wFTg3B/s0v+Oyy2E=
X-Google-Smtp-Source: APiQypJz5xjcy8CQIojPinPVxtSePmvhLJa2/ur4i/hoG7sOyE64vkH7tSMLn+XpPcO/aO9kRrQQFA==
X-Received: by 2002:ac8:39e5:: with SMTP id v92mr17497044qte.224.1587405471826;
        Mon, 20 Apr 2020 10:57:51 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o94sm4374qtd.34.2020.04.20.10.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:57:51 -0700 (PDT)
Date:   Mon, 20 Apr 2020 13:57:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200420175750.GA229870@google.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420174019.GB12196@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 20, 2020 at 07:40:19PM +0200, Uladzislau Rezki wrote:
> On Mon, Apr 20, 2020 at 10:21:26AM -0700, Paul E. McKenney wrote:
[...]
> > > > > > > > > <snip>
> > > > > > > > > /**
> > > > > > > > >  * queue_work_on - queue work on specific cpu
> > > > > > > > >  * @cpu: CPU number to execute work on
> > > > > > > > >  * @wq: workqueue to use
> > > > > > > > >  * @work: work to queue
> > > > > > > > >  *
> > > > > > > > >  * We queue the work to a specific CPU, the caller must ensure it
> > > > > > > > >  * can't go away.
> > > > > > > > >  *
> > > > > > > > >  * Return: %false if @work was already on a queue, %true otherwise.
> > > > > > > > >  */
> > > > > > > > > <snip>
> > > > > > > > > 
> > > > > > > > > It says, how i see it, we should ensure it can not go away. So, if
> > > > > > > > > we drop the lock we should do like:
> > > > > > > > > 
> > > > > > > > > get_online_cpus();
> > > > > > > > > check a CPU is onlen;
> > > > > > > > > queue_work_on();
> > > > > > > > > put_online_cpus();
> > > > > > > > > 
> > > > > > > > > but i suspect we do not want to do it :)
> > > > > > > > 
> > > > > > > > Indeed, it might impose a few restrictions and a bit of overhead that
> > > > > > > > might not be welcome at some point in the future.  ;-)
> > > > > > > > 
> > > > > > > > On top of this there are potential load-balancing concerns.  By specifying
> > > > > > > > the CPU, you are limiting workqueue's and scheduler's ability to adjust to
> > > > > > > > any sudden changes in load.  Maybe not enough to matter in most cases, but
> > > > > > > > might be an issue if there is a sudden flood of  kfree_rcu() invocations.
> > > > > > > > 
> > > > > > > Agree. Let's keep it as it is now :)
> > > > > > 
> > > > > > I am not sure which "as it is now" you are referring to, but I suspect
> > > > > > that the -rt guys prefer two short interrupts-disabled regions to one
> > > > > > longer interrupts-disabled region.
> > > > > 
> > > > > I mean to run schedule_delayed_work() under spinlock.
> > > > 
> > > > Which is an interrupt-disabled spinlock, correct?
> > > > 
> > > To do it under holding the lock, currently it is spinlock, but it is
> > > going to be(if you agree :)) raw ones, which keeps IRQs disabled. I
> > > saw Joel sent out patches.
> > 
> > Then please move the schedule_delayed_work() and friends out from
> > under the spinlock.  Unless Sebastian has some reason why extending
> > an interrupts-disabled critical section (and thus degrading real-time
> > latency) is somehow OK in this case.
> > 
> Paul, if move outside of the lock we may introduce unneeded migration
> issues, plus it can introduce higher memory footprint(i have not tested).
> I have described it in more detail earlier in this mail thread. I do not
> think that waking up the work is an issue for RT from latency point of
> view. But let's ask Sebastian to confirm.

I was also a bit concerned about migration. If we moved it outside of lock,
then even on !PREEMPT_RT, we could be migrated before the work is
scheduled. Then we'd lose the benefit of executing the work on the same CPU
where it is queued. There's no migrate_disable() in non-PREEMPT_RT when I
recently checked as well :-\ (PeterZ mentioned that migrate_disable() is hard
to achieve on !PREEMPT_RT).

> Sebastian, do you think that placing a work on current CPU is an issue?
> If we do it under raw spinlock?

Yes, I am also curious if calling schedule_delayed_work can cause long
delays at all. Considering that workqueue code uses raw spinlocks as Mike
mentioned, I was under the impression that this code should not be causing
such issues, and the fact that it is called in many places from IRQ-disabled
sections as well.

Let us definitely double-check and discuss it more to be sure.

thanks,

 - Joel

