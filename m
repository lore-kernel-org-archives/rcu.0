Return-Path: <SRS0=Ug6t=D4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD04C4363A
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 18:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5D5221FB
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 18:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KikvC/dD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504541AbgJUS5Q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504540AbgJUS5Q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Oct 2020 14:57:16 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0DFC0613CF
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 11:57:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p15so4343867ioh.0
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 11:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6EflYSSZfOJagfG1O7mOEg57cGG/t7TshjLdR/LpOU=;
        b=KikvC/dDNLSipbLp2+aex8FEZZ8QHyTcBR9YEPMK14+YoVBgYNENGhEtp1wZlFQNxu
         88w9qUncx3OkQTBkuiCFiKRGfj1YRtcgePVn8LM3i5Eo3Urrs+zZ1VMlyOolryAhbEF2
         2G6ZJUyA4Lp3TkNNbGIFOVpeNX9mxTB7dVhu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6EflYSSZfOJagfG1O7mOEg57cGG/t7TshjLdR/LpOU=;
        b=gzIYoEc4yYhRCJ9a1btWZjNxADdjA2kHL55cXT0wme8+SAbJIMPkriW/AbziImAb3o
         hxv4mTp0P8/0Ub88E1ZWiqZMdbwLK8UlgepWDbLJSBWsOIIyscoUEP+/7BRTleaYjLpp
         S7sP7d6yz3t1Tt5PaMrHHieRYmxTLKV6TKVnmBjehQaFBZ7jnYT7VxjulWWUkFuk6OXB
         UBEhispXPnutJ+Rv9uldbNnNvWnA/PaR8P5IqxcOHmVvR31gB0e65n37wCowCMDRf8PD
         xCMUD3gFwiDMSipaGog17wwkJJZZpEK2lAKf8IQmYWj7m70bvLlfWfL5VQFphbqL2ote
         9qLw==
X-Gm-Message-State: AOAM53307texbbBd1IkHMwat+tPFULvbsOkjgTRQNztYbYLKtHtRRF8K
        WKBvEJulZQHC5imNZm1RgJlDatxtucelR8Hr9Gyh3Q==
X-Google-Smtp-Source: ABdhPJyM64AKqnLUu6x0WWL/eowTsE/8okZDxiOOBQLiBeGkshsaHRFPdx1S+xiMm/AoZ6/EHATMsVD1SnGIM2xQICU=
X-Received: by 2002:a5e:9e02:: with SMTP id i2mr3891537ioq.154.1603306635690;
 Wed, 21 Oct 2020 11:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org> <20201015133511.GB127222@lothringen>
 <20201017012753.GB4015033@google.com> <20201017031941.GD4015033@google.com>
 <20201017132954.GA15657@lothringen> <20201018003556.GA1034551@google.com> <20201019123730.GA34192@lothringen>
In-Reply-To: <20201019123730.GA34192@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 21 Oct 2020 11:57:04 -0700
Message-ID: <CAEXW_YTtYspPNw_eL1vmGXhY8nJ8uQonSc5KuA1weYv3G+bWPg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain smp_mb()
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 19, 2020 at 5:37 AM Frederic Weisbecker <frederic@kernel.org> wrote:
>
[..]
> > >
> > > I'm very likely missing something obvious somewhere.
> > >
> > >       CPU 0                                CPU 1
> > >       rcu_barrier()                        call_rcu()/rcu_segcblist_enqueue()
> > >       ------------                         --------
> > >
> > >                                            smp_mb();
> > >                                            inc_len();
> > >                                        smp_mb();
> > >                                        queue callback;
> > >       for_each_possible_cpu(cpu)
> > >           if (!rcu_segcblist_n_cbs(&rdp->cblist))
> > >           continue;
> > >
> >
> > >                                             invoke_callback
> >
> > If CPU 0 saw the enqueue of the callback (that is the CPU 1's writes to the
> > segcb_list propagated to CPU 0), then it would have also seen the
> > effects of the inc_len. I forced this case in my last litmus test by this
> > code in P1():
>
> But then I can't find to which part of rcu_barrier() this refers to.
> I see the len read before anything else.
>
> >
> >         r1 = READ_ONCE(*enq);
> >         smp_mb();               /* barrier Just for test purpose to show that the.. */
> >                                 /* ..rcu_barrier() saw list modification */
> >
> > On the other hand, if CPU 0 did not see the enqueue, then there is really no
> > issue. Since that is the same case where call_rcu() happened _after_ the
> > rcu_barrier() and there's no race. rcu_barrier() does not need to wait if
> > there was no callback enqueued.
> >
> > This is not exactly the easiest thing to explain, hence the litmus.
>
> Now, reading the documentation of rcu_barrier() (thanks to you!):
>
>     Pseudo-code using rcu_barrier() is as follows:
>
>    1. Prevent any new RCU callbacks from being posted.
>    2. Execute rcu_barrier().
>    3. Allow the module to be unloaded.
>

Basically, you are saying that if all CPUs agree that len == 0
henceforth (through other memory barriers), then callback enqueuing
does not need a memory barrier before setting length to 0.

I think that makes sense but is it worth removing the memory barrier
before WRITE(len, 1) and hoping after #1, the caller would have
ensured things are fine? Also I am not sure if the above is the only
usecase for rcu_barrier().

> I think with point 1, it is assumed that the caller of rcu_barrier() must have
> not only stopped but also sync'ed with the possible enqueuers. Correct me if I'm wrong
> here. So for example if a kthread used to post the module RCU callbacks, calling kthread_stop()
> does the job as it prevents from further RCU callbacks from being enqueued and it also syncs
> with the kthread thanks to the completion implied by any caller of kthread_stop() which then
> sees what the kthread has read and written, including RCU callbacks enqueued. So if the caller
> of kthread_stop() calls rcu_barrier() right after, rcu_barrier() should see at least the len
> corresponding to the last enqueue.
>
> cancel_work_sync() also seem to really sync as well. I'm less sure about del_timer_sync().
>
> Say we have:
>
> expire_timers (CPU 0)                               CPU 1
> -------------                                       -----------
> detach_timer(timer)
> raw_spin_unlock(&base->lock);
> call_timer_fn(timer, fn, baseclk);
>    -> enqueue callback
> //would need at least smp_wmb() here
> base->running_timer = NULL;
>
>                                                     del_timer_sync() {
>                                                         raw_spin_lock(&base->lock);
>                                                         if (base->running_timer != timer)
>                                                             ret = detach_if_pending(timer, base, true);
>                                                                 if (!timer_pending())
>                                                                     return 0;
>                                                         raw_spin_unlock(&base->lock);
>                                                     }
>                                                     //would need at least smp_rmb() here

Regarding "would need at least smp_rmb.." :
But the rcu_barrier() has the control dependency we discussed in last
emails, between READ(len) and whatever follows the rcu_barrier().
That itself will provide the ordering right?

>                                                     //although rcu_seq_start() implies a full barrier
>                                                     rcu_barrier() {
>                                                         // Sees rcu_segcblist_n_cbs(rdp(CPU 0)->cblist) == 0
>                                                         // So ignore it
>
>
> But I'm sure I'm missing something obvious. That's my specialism.

I could be missing something too :-/. But I'll include this patch in
my next posting anyway and let us also maybe see if Paul disagrees.

thanks,

 - Joel
