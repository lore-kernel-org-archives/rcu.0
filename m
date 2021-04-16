Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4DCC433B4
	for <rcu@archiver.kernel.org>; Fri, 16 Apr 2021 17:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3853B610CE
	for <rcu@archiver.kernel.org>; Fri, 16 Apr 2021 17:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbhDPR0z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Apr 2021 13:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235935AbhDPR0y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Apr 2021 13:26:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE88260FED;
        Fri, 16 Apr 2021 17:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618593989;
        bh=5P4/qPwdpux1jE4JlcCASPqUxEgy+/WluDGUYEnfiG0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JaBGkBjpLtY194K6WS2uxdqR/r1qu3qiBMiRynIkyqd2MmgY/YbGP73TNzgq+vojy
         EhMl5l1JPqMGYvtWarXEsG9OHijpShN9oRDF2faL+YOs8P6WlHNmhY7/BODeymVuSa
         mJjhT1EpBpwvizfWakOM9MhTrycojEkEJFLUejqph2HpSnTABrEZdPSeY+9KmsGj5x
         K4fWGYiW8H4nhjHOzLxgl/XsAsFU+RJVNHf0sWv5ALl7uiN6uXaCyheHAsefSlNoZI
         bEFg02mV31s5GirLmmqtExkuuRNTCSbzOdHPCVFcv0Mw3lcvKLXz8ohHCtbCOIQb+E
         Nb/ZplQMRgHpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 84E085C0253; Fri, 16 Apr 2021 10:26:29 -0700 (PDT)
Date:   Fri, 16 Apr 2021 10:26:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Qestion] Is preempt_disable/enable needed in non-preemption
 code path
Message-ID: <20210416172629.GH4212@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <b068d707-0ac7-4840-a297-112731972d8a@windriver.com>
 <20210415154326.GF4510@paulmck-ThinkPad-P17-Gen-1>
 <adae433f-f886-32e7-2ebd-192a624d7586@windriver.com>
 <20210415170748.GA4212@paulmck-ThinkPad-P17-Gen-1>
 <3ef49985-68c9-277d-648c-53447ff602f4@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ef49985-68c9-277d-648c-53447ff602f4@windriver.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 16, 2021 at 06:51:10PM +0800, Xu, Yanfei wrote:
> 
> 
> On 4/16/21 1:07 AM, Paul E. McKenney wrote:
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > 
> > On Fri, Apr 16, 2021 at 12:18:42AM +0800, Xu, Yanfei wrote:
> > > 
> > > 
> > > On 4/15/21 11:43 PM, Paul E. McKenney wrote:
> > > > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > > > 
> > > > On Thu, Apr 15, 2021 at 11:04:05PM +0800, Xu, Yanfei wrote:
> > > > > Hi experts,
> > > > > 
> > > > > I am learning rcu mechanism and its codes. When looking at the
> > > > > rcu_blocking_is_gp(), I found there is a pair preemption disable/enable
> > > > > operation in non-preemption code path. And it has been a long time. I can't
> > > > > understand why we need it? Is there some thing I missed? If not, can we
> > > > > remove the unnecessary operation like blow?
> > > > 
> > > > Good point, you are right that preemption is disabled anyway in that block
> > > > of code.  However, preempt_disable() and preempt_enable() also prevent the
> > > > compiler from moving that READ_ONCE() around.  So my question to you is
> > > > whether it is safe to remove those statements entirely or whether they
> > > > should instead be replaced by barrier() or similar.
> > > 
> > > Thanks for your reply! :)
> > > 
> > > Yes, preempt_disable() and preempt_enable() defined in !preemption are
> > > barrier(). barrier can prevent from reordering that READ_ONCE(), but base on
> > > my current understanding, volatile in READ_ONCE can also tell the compiler
> > > not to reorder it. So, I think it's safe?
> > 
> > Maybe.
> > 
> > Please keep in mind that although the compiler is prohibited from
> > reordering volatile accesses with each other, there is nothing stopping
> > it from reordering volatile accesses with non-volatile accesses.
> 
> Thanks for your patient explanation!
> 
> I am trying to absorb what you said. Blow are my understanding:
> 1. "the compiler is prohibited from reordering volatile accesses with each
> other" means these situations:
> int a;
> foo()
> {
>     for(;;)
>         READ_ONCE(a);
> }
> 
> or
> 
> int a,b;
> foo()
> {
>     int c,d;
>     c = READ_ONCE(a);
>     d = READ_ONCE(b);
> }

Yes, in both cases the load instructions emitted for the READ_ONCE()
macros must be emitted in order.  The underlying hardware is free
to reorder.

> 2. "volatile accesses with non-volatile accesses" means d=b may happen
> before c=READ_ONCE(a) :
> int a;
> foo()
> {
>     int b = 2
>     int c,d;
>     c = READ_ONCE(a);
>     d = b;
> }
> if we want to keep the ordering of volatile access "c=READ_ONCE(a)" and
> non-volatile access "d=b", we should use stronger barrier like barrier().

Or an additional READ_ONCE() for b or a WRITE_ONCE() for d.  But again,
this would constrain only the compiler, not the hardware.

But this wouldn't matter in most cases, because both b and d are local
variables whose addresses were never taken.  So someone would need to
be using something crazy to poke into others' stacks for this to matter.

> Hope I didn't misunderstand.

It looks like you have most of it.

> Back to rcu_blocking_is_gp(), I find this link today
> https://www.spinics.net/lists/rcu/msg03985.html
> With the content in this link, I still haven't got the meaning of these two
> barrier(). I think I should learn knowledge about cpu-hotplug and things
> which talked in the link first to make sure if I am missing something, and
> then consult you. :)

That sounds like a very good approach!

Keep in mind that I am worried not just about the current state of
the code and compilers, but also their possible future states.

							Thanx, Paul

> Best regards,
> Yanfei
> 
> > 
> >                                                          Thanx, Paul
> > 
> > > Best regards,
> > > Yanfei
> > > 
> > > > 
> > > >                                                           Thanx, Paul
> > > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index da6f5213fb74..c6d95a00715e 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -3703,7 +3703,6 @@ static int rcu_blocking_is_gp(void)
> > > > >           if (IS_ENABLED(CONFIG_PREEMPTION))
> > > > >                   return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
> > > > >           might_sleep();  /* Check for RCU read-side critical section. */
> > > > > -       preempt_disable();
> > > > >           /*
> > > > >            * If the rcu_state.n_online_cpus counter is equal to one,
> > > > >            * there is only one CPU, and that CPU sees all prior accesses
> > > > > @@ -3718,7 +3717,6 @@ static int rcu_blocking_is_gp(void)
> > > > >            * Those memory barriers are provided by CPU-hotplug code.
> > > > >            */
> > > > >           ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
> > > > > -       preempt_enable();
> > > > >           return ret;
> > > > >    }
> > > > > 
> > > > > 
> > > > > 
> > > > > Best regards,
> > > > > Yanfei
