Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3A5C3815B
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 12:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44A82070B
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 12:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="e1JXIjlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgDTMgf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726020AbgDTMgf (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 20 Apr 2020 08:36:35 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DEFC061A0C
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 05:36:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o19so10281647qkk.5
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=QWOc4EL1CCfAm33wBNtxvJQyJSSdlmJYu7cFu1lRDMo=;
        b=e1JXIjlQpF4Uwk8kCnHHET0EtU6iM2G4CWIUY943zZAoys4kyviu5ctfRGrnq00B5X
         xr0TY1BfBvr1u9RiloZFI79BDdsaX9LGSzVsN6UJ34/SrJ8Scn8Me/eqb1bBn6mv0OS6
         T3LNWFkccDOJ0mbvTSEEigrLkFnDbgn9p4O9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=QWOc4EL1CCfAm33wBNtxvJQyJSSdlmJYu7cFu1lRDMo=;
        b=gTlxgndOx3JIPEwEX7EI24QGMQkQ23sBRBo7bIrcP8a2aeEAS9r1pZdTvHcraqFCLh
         iEt4Lqz3I8xST89j31BkV4pCGwMwqXCSGM1hHjrd5T3f22wmg+kajoqb58S6o1EPJkmr
         W1piYd/xLSxxtLkpvRwB8cZ8MaGM5ZgeZKLHYz14ZKs225e9U07NAbe7qctc2U0A673k
         xCx9E3zEnfQMpLwOQlCKYnuGam98i3uk38wRFwJ2Hf1LqD4qFsex7Og+eUg/cEMQ0O4i
         zGT3eWwQk+0gxiDNxBsEuTSaau6iYHiYoIfWEhbz7U3gMOFdLIqRJN8izQu48XpNPros
         nRFg==
X-Gm-Message-State: AGi0Pua4HiyM4tL88bzpbuJyIezWSMmQOP1K72TuzILTc2bX6B+sVia/
        s+q5X/F0mieFCESjEI7kCbCr9g==
X-Google-Smtp-Source: APiQypLm72/alBDmdf1/I77e7i73qGP0xOlXdsnIcUGY90E93Fxch8XK6dxNDbgmcvljbv6zbzaCyA==
X-Received: by 2002:a37:9b4a:: with SMTP id d71mr15538319qke.382.1587386193933;
        Mon, 20 Apr 2020 05:36:33 -0700 (PDT)
Received: from [192.168.1.17] (c-71-62-121-229.hsd1.va.comcast.net. [71.62.121.229])
        by smtp.gmail.com with ESMTPSA id z2sm479444qkc.28.2020.04.20.05.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 05:36:33 -0700 (PDT)
Date:   Mon, 20 Apr 2020 08:36:31 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20200420121316.GA10695@pc636>
References: <20200416213444.4cc6kzxmwl32s2eh@linutronix.de> <20200417030515.GE176663@google.com> <20200417150442.gyrxhjymvfwsvum5@linutronix.de> <20200417182641.GB168907@google.com> <20200417185449.GM17661@paulmck-ThinkPad-P72> <20200418123748.GA3306@pc636> <20200419145836.GS17661@paulmck-ThinkPad-P72> <20200420002713.GA160606@google.com> <20200420011749.GF176663@google.com> <20200420014450.GX17661@paulmck-ThinkPad-P72> <20200420121316.GA10695@pc636>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
To:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
From:   joel@joelfernandes.org
Message-ID: <616B79E2-977A-4079-ADAC-2D326A7284A4@joelfernandes.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On April 20, 2020 8:13:16 AM EDT, Uladzislau Rezki <urezki@gmail=2Ecom> wr=
ote:
>On Sun, Apr 19, 2020 at 06:44:50PM -0700, Paul E=2E McKenney wrote:
>> On Sun, Apr 19, 2020 at 09:17:49PM -0400, Joel Fernandes wrote:
>> > On Sun, Apr 19, 2020 at 08:27:13PM -0400, Joel Fernandes wrote:
>> > > On Sun, Apr 19, 2020 at 07:58:36AM -0700, Paul E=2E McKenney wrote:
>> > > > On Sat, Apr 18, 2020 at 02:37:48PM +0200, Uladzislau Rezki
>wrote:
>> > > > > On Fri, Apr 17, 2020 at 11:54:49AM -0700, Paul E=2E McKenney
>wrote:
>> > > > > > On Fri, Apr 17, 2020 at 02:26:41PM -0400, Joel Fernandes
>wrote:
>> > > > > > > On Fri, Apr 17, 2020 at 05:04:42PM +0200, Sebastian
>Andrzej Siewior wrote:
>> > > > > > > > On 2020-04-16 23:05:15 [-0400], Joel Fernandes wrote:
>> > > > > > > > > On Thu, Apr 16, 2020 at 11:34:44PM +0200, Sebastian
>Andrzej Siewior wrote:
>> > > > > > > > > > On 2020-04-16 14:00:57 [-0700], Paul E=2E McKenney
>wrote:
>> > > > > > > > > > >=20
>> > > > > > > > > > > We might need different calling-context
>restrictions for the two variants
>> > > > > > > > > > > of kfree_rcu()=2E  And we might need to come up
>with some sort of lockdep
>> > > > > > > > > > > check for "safe to use normal spinlock in -rt"=2E
>> > > > > > > > > >=20
>> > > > > > > > > > Oh=2E We do have this already, it is called
>CONFIG_PROVE_RAW_LOCK_NESTING=2E
>> > > > > > > > > > This one will scream if you do
>> > > > > > > > > > 	raw_spin_lock();
>> > > > > > > > > > 	spin_lock();
>> > > > > > > > > >=20
>> > > > > > > > > > Sadly, as of today, there is code triggering this
>which needs to be
>> > > > > > > > > > addressed first (but it is one list of things to
>do)=2E
>> > > > > > > > > >=20
>> > > > > > > > > > Given the thread so far, is it okay if I repost the
>series with
>> > > > > > > > > > migrate_disable() instead of accepting a possible
>migration before
>> > > > > > > > > > grabbing the lock? I would prefer to avoid the
>extra RT case (avoiding
>> > > > > > > > > > memory allocations in a possible atomic context)
>until we get there=2E
>> > > > > > > > >=20
>> > > > > > > > > I prefer something like the following to make it
>possible to invoke
>> > > > > > > > > kfree_rcu() from atomic context considering
>call_rcu() is already callable
>> > > > > > > > > from such contexts=2E Thoughts?
>> > > > > > > >=20
>> > > > > > > > So it looks like it would work=2E However, could we
>please delay this
>> > > > > > > > until we have an actual case on RT? I just added
>> > > > > > > > 	WARN_ON(!preemptible());
>> > > > > > >=20
>> > > > > > > I am not sure if waiting for it to break in the future is
>a good idea=2E I'd
>> > > > > > > rather design it in a forward thinking way=2E There could
>be folks replacing
>> > > > > > > "call_rcu() + kfree in a callback" with kfree_rcu() for
>example=2E If they were
>> > > > > > > in !preemptible(), we'd break on page allocation=2E
>> > > > > > >=20
>> > > > > > > Also as a sidenote, the additional pre-allocation of
>pages that Vlad is
>> > > > > > > planning on adding would further reduce the need for
>pages from the page
>> > > > > > > allocator=2E
>> > > > > > >=20
>> > > > > > > Paul, what is your opinion on this?
>> > > > > >=20
>> > > > > > My experience with call_rcu(), of which kfree_rcu() is a
>specialization,
>> > > > > > is that it gets invoked with preemption disabled, with
>interrupts
>> > > > > > disabled, and during early boot, as in even before
>rcu_init() has been
>> > > > > > invoked=2E  This experience does make me lean towards raw
>spinlocks=2E
>> > > > > >=20
>> > > > > > But to Sebastian's point, if we are going to use raw
>spinlocks, we need
>> > > > > > to keep the code paths holding those spinlocks as short as
>possible=2E
>> > > > > > I suppose that the inability to allocate memory with raw
>spinlocks held
>> > > > > > helps, but it is worth checking=2E
>> > > > > >
>> > > > > How about reducing the lock contention even further?
>> > > >=20
>> > > > Can we do even better by moving the work-scheduling out from
>under the
>> > > > spinlock?  This of course means that it is necessary to handle
>the
>> > > > occasional spurious call to the work handler, but that should
>be rare
>> > > > and should be in the noise compared to the reduction in
>contention=2E
>> > >=20
>> > > Yes I think that will be required since -rt will sleep on
>workqueue locks as
>> > > well :-(=2E I'm looking into it right now=2E
>> > >=20
>> > >         /*
>> > >          * If @work was previously on a different pool, it might
>still be
>> > >          * running there, in which case the work needs to be
>queued on that
>> > >          * pool to guarantee non-reentrancy=2E
>> > >          */
>> > >         last_pool =3D get_work_pool(work);
>> > >         if (last_pool && last_pool !=3D pwq->pool) {
>> > >                 struct worker *worker;
>> > >=20
>> > >                 spin_lock(&last_pool->lock);
>> >=20
>> > Hmm, I think moving schedule_delayed_work() outside lock will work=2E
>Just took
>> > a good look and that's not an issue=2E However calling
>schedule_delayed_work()
>> > itself is an issue if the caller of kfree_rcu() is !preemptible()
>on
>> > PREEMPT_RT=2E Because the schedule_delayed_work() calls spin_lock on
>pool->lock
>> > which can sleep on PREEMPT_RT :-(=2E Which means we have to do either
>of:
>> >=20
>> > 1=2E Implement a new mechanism for scheduling delayed work that does
>not
>> >    acquire sleeping locks=2E
>> >=20
>> > 2=2E Allow kfree_rcu() only from preemptible context (That is
>Sebastian's
>> >    initial patch to replace local_irq_save() + spin_lock() with
>> >    spin_lock_irqsave())=2E
>> >=20
>> > 3=2E Queue the work through irq_work or another bottom-half
>mechanism=2E
>>=20
>> I use irq_work elsewhere in RCU, but the queue_delayed_work() might
>> go well with a timer=2E  This can of course be done conditionally=2E
>>=20
>We can schedule_delayed_work() inside and outside of the spinlock,
>i=2Ee=2E it is not an issue for RT kernel, because as it was noted in las=
t
>message a workqueue system uses raw spinlicks internally=2E I checked
>the latest linux-5=2E6=2Ey-rt also=2E If we do it inside, we will place t=
he
>work on current CPU, at least as i see it, even if it is "unbound"=2E
>

Thanks for confirming!!

>If we do it outside, we will reduce a critical section, from the other
>hand we can introduce a potential delay in placing the context into
>CPUs
>run-queuye=2E As a result we could end up on another CPU, thus placing
>the work on new CPU, plus memory foot-print might be higher=2E It would
>be good to test and have a look at it actually=2E
>
>But it can be negligible :)

Since the wq locking is raw spinlock on rt as Mike and you mentioned,  if =
wq holds lock for too long that itself will spawn a lengthy non preemptible=
 critical section, so from that standpoint doing it under our lock should b=
e ok I think=2E

>
>> > Any other thoughts?
>>=20
>> I did forget to ask you guys your opinions about the downsides (if
>any)
>> of moving from unbound to per-CPU workqueues=2E  Thoughts?
>>=20
>If we do it outside of spinlock, there is at least one drawback that i
>see, i described it above=2E We can use schedule_delayed_work_on() but
>we as a caller have to guarantee that a CPU we about to place a work
>is alive :)

FWIW, some time back I did a simple manual test calling queue_work_on on a=
n offline CPU to see what happens and it appears to be working fine=2E On a=
 4 CPU system, I offline CPU 3 and queue the work on it which ends up execu=
ting on CPU 0 instead=2E

Thanks,

- Joel

>
>--
>Vlad Rezki

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
