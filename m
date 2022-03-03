Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912F3C433F5
	for <rcu@archiver.kernel.org>; Thu,  3 Mar 2022 10:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiCCKK5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Mar 2022 05:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiCCKK4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Mar 2022 05:10:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFE11768C0
        for <rcu@vger.kernel.org>; Thu,  3 Mar 2022 02:10:09 -0800 (PST)
Date:   Thu, 3 Mar 2022 11:10:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646302207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7WwUai0gAIon2ogn9/tqFDAR1mFoSi/xqil/a+Zt4K8=;
        b=YAHZ9Qwb9Bj3y4GUPbzRUeuJWs3JQmKu/haLneBaomokzLh8RBHQaV54sFgshawXrdPCUd
        etvS1MnJfoE3XvvzzJhqXFz+qU2C6irDNP4cFDoJ19wEgD1iFWb4743+mJMEbzd41/mu2N
        JYJdY8xiHyQG732Iul9GkDTZeq8bdv4Wv5ClDRhRqYckk19tvvJt6mmSyqqzE8G9hR2PH3
        56mMYt322M6E6DpayxNZsMICazNBoomoHE6vNf9o7U/B0qPJM38LaYua0jhul3yrhu+1YH
        6G1bT5hArXjt7LytybEy3wLV8Egn5AQjX/L/zJK5jrqYNMCGH0O0VPs+Jlr2ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646302207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7WwUai0gAIon2ogn9/tqFDAR1mFoSi/xqil/a+Zt4K8=;
        b=qbVQls5oIbbkns0IgHy1tiKM8c4U0ehZ6MzMi3eqfV+e3FkuNI70y8AB2mKekCvN25kIDW
        NMoaa0ZqNWJ5ZkBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <YiCT/i3jlgg9LX/r@linutronix.de>
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2022-03-02 20:36:50 [-0800], Paul E. McKenney wrote:
> > To simply move the test from rcu_init_tasks_generic() to after
> > do_pre_smp_initcalls(). If we can't move rcu_init_tasks_generic() after
> > do_pre_smp_initcalls() or at least the test part because we need working
> > synchronize_rcu() in early_initcall() then I need to move the RT
> > requirements before. Simple ;)
>=20
> As long as RT confines itself to configurations that do not need a
> working synchronize_rcu() in the intervening code, yes, simple.  ;-)

;)

> > The requirements are:
> >=20
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1598,6 +1601,9 @@ static noinline void __init kernel_init_freeable(=
void)
> > =20
> >         init_mm_internals();
> > =20
> > +       spawn_ksoftirqd();
> > +       irq_work_init_threads();
> > +
> >         rcu_init_tasks_generic();
> >         do_pre_smp_initcalls();
> >         lockup_detector_init();
> >=20
> > spawn_ksoftirqd() is what I mentioned. What I just figured out is
> > irq_work_init_threads() due to
> > 	call_rcu_tasks_iw_wakeup()
> >=20
> > I can't move this to hard-IRQ context because it invokes wake_up() which
> > acquires sleeping locks. If you say that rtp->cbs_wq has only one waiter
> > and something like rcuwait_wait_event() / rcuwait_wake_up() would work
> > as well then call_rcu_tasks_iw_wakeup() could be lifter to hard-IRQ
> > context and we need to worry only about spawn_ksoftirqd() :)
>=20
> OK, I was expecting that the swait_event_timeout_exclusive() call from
> synchronize_rcu_expedited_wait_once() would be the problem.  Are you
> saying that this swait_event_timeout_exclusive() works fine? =20

swait_event_timeout_exclusive() uses schedule_timeout() which uses a
timer_list timer and this one requires ksoftirqd to work.

> Or are you
> instead saying that the call_rcu_tasks_iw_wakeup() issues cause trouble
> before that swait_event_timeout_exclusive() gets a chance to cause its
> own trouble?

Both is needed:
- ksoftirqd thread for timer_list timers handling.
- irq_work thread for irq_work which is not done in hard-IRQ context.

What I observe during boot:
| [    0.184838] cblist_init_generic: Setting adjustable number of callback=
 queues.
| [    0.184853] cblist_init_generic: Setting shift to 2 and lim to 1.
| [    0.188116] irq_work_single() wake_up_klogd_work_func+0x0/0x70 26
| [    0.188861] cblist_init_generic: Setting shift to 2 and lim to 1.
| [    0.189671] Running RCU-tasks wait API self tests
| [    0.190254] irq_work_single() call_rcu_tasks_iw_wakeup+0x0/0x20 22
| [    0.292569] expire_timers() process_timeout+0x0/0x10
| [    0.292655] irq_work_single() call_rcu_tasks_iw_wakeup+0x0/0x20 22
| [    0.295082] irq_work_single() call_rcu_tasks_iw_wakeup+0x0/0x20 22
| [    0.296481] irq_work_single() call_rcu_tasks_iw_wakeup+0x0/0x20 22
| [    0.304685] rcu: Hierarchical SRCU implementation.
| [    0.311415] Callback from call_rcu_tasks_trace() invoked.
| [    0.344100] smp: Bringing up secondary CPUs ...

1x schedule_timeout() and 4x call_rcu_tasks_iw_wakeup(). Both are
crucial.

> Either way, it sounds like that irq_work_queue(&rtpcp->rtp_irq_work) in
> call_rcu_tasks_generic() needs some adjustment to work in RT.  This should
> be doable.  Given this, and given that the corresponding diagnostic
> function rcu_tasks_verify_self_tests() is a late_initcall() function,
> you don't need to move the call to rcu_init_tasks_generic(), correct?

#1 ksoftirqd must be spawned first in order to get timer_list timer to
   work. I'm going to do that, this should not be a problem.

#2 call_rcu_tasks_iw_wakeup. Here we have the following options:
   - Don't use, delay, =E2=80=A6

   - if you can guarantee that there is only _one_ waiter
     =3D> Replace rcu_tasks::cbs_wq with rcuwait. Let this irq_work run
        then in hard-IRQ context.

   - if you can't guarantee that there is only _one_ waiter
     =3D> spawn the irq-work thread early.

As for #2, I managed to trigger the wakeup via tracing (and stumbled
into a bug un related to this) and I see only one waiter. Doesn't mean I
do it right and they can't be a second waiter.

> Back over to you so that I can learn what I am still missing.  ;-)

Hope that helps.

> 							Thanx, Paul

Sebastian
