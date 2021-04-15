Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5427FC433B4
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F1D6109D
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhDORIQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232759AbhDORIL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 13:08:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E0C06109D;
        Thu, 15 Apr 2021 17:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618506468;
        bh=OJNggdW0+1ja/X+OPtr4SVyl/OXXtG6ShVmzItcJE8s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WqnAX6pRvPq0Kuxl0FqebuxdehDVaAo7/loIylqDYOcOf35B+X6WPkMSTsQ2DshWA
         yQn/7c+i0ZdlVXY+XsZKMZy/7KxfCdDhRtdMWzc2fV9P3W1EitKSg+WN8WcSoBP0x0
         59CojOZCupTnAubtPCL/kqJKPsu8xnv548BdE2089TK9CoFOYgujPK+n/y1GslXYx6
         zXpyjr3fJPswF2vAr61kj9wqPYQGDDEF7sqdP3a/3GQySY5lw/4EAtCZJ9rJSjyRct
         MpVF3EehhiEq+kNBphN5bbro+4puTu0TZFxqlZUEp19Y/aMjRBPb8UrikFIko1EUIY
         s61WMTLuMHzeA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1F2775C00F4; Thu, 15 Apr 2021 10:07:48 -0700 (PDT)
Date:   Thu, 15 Apr 2021 10:07:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Qestion] Is preempt_disable/enable needed in non-preemption
 code path
Message-ID: <20210415170748.GA4212@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <b068d707-0ac7-4840-a297-112731972d8a@windriver.com>
 <20210415154326.GF4510@paulmck-ThinkPad-P17-Gen-1>
 <adae433f-f886-32e7-2ebd-192a624d7586@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adae433f-f886-32e7-2ebd-192a624d7586@windriver.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 16, 2021 at 12:18:42AM +0800, Xu, Yanfei wrote:
> 
> 
> On 4/15/21 11:43 PM, Paul E. McKenney wrote:
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > 
> > On Thu, Apr 15, 2021 at 11:04:05PM +0800, Xu, Yanfei wrote:
> > > Hi experts,
> > > 
> > > I am learning rcu mechanism and its codes. When looking at the
> > > rcu_blocking_is_gp(), I found there is a pair preemption disable/enable
> > > operation in non-preemption code path. And it has been a long time. I can't
> > > understand why we need it? Is there some thing I missed? If not, can we
> > > remove the unnecessary operation like blow?
> > 
> > Good point, you are right that preemption is disabled anyway in that block
> > of code.  However, preempt_disable() and preempt_enable() also prevent the
> > compiler from moving that READ_ONCE() around.  So my question to you is
> > whether it is safe to remove those statements entirely or whether they
> > should instead be replaced by barrier() or similar.
> 
> Thanks for your reply! :)
> 
> Yes, preempt_disable() and preempt_enable() defined in !preemption are
> barrier(). barrier can prevent from reordering that READ_ONCE(), but base on
> my current understanding, volatile in READ_ONCE can also tell the compiler
> not to reorder it. So, I think it's safe?

Maybe.

Please keep in mind that although the compiler is prohibited from
reordering volatile accesses with each other, there is nothing stopping
it from reordering volatile accesses with non-volatile accesses.

							Thanx, Paul

> Best regards,
> Yanfei
> 
> > 
> >                                                          Thanx, Paul
> > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index da6f5213fb74..c6d95a00715e 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3703,7 +3703,6 @@ static int rcu_blocking_is_gp(void)
> > >          if (IS_ENABLED(CONFIG_PREEMPTION))
> > >                  return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
> > >          might_sleep();  /* Check for RCU read-side critical section. */
> > > -       preempt_disable();
> > >          /*
> > >           * If the rcu_state.n_online_cpus counter is equal to one,
> > >           * there is only one CPU, and that CPU sees all prior accesses
> > > @@ -3718,7 +3717,6 @@ static int rcu_blocking_is_gp(void)
> > >           * Those memory barriers are provided by CPU-hotplug code.
> > >           */
> > >          ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
> > > -       preempt_enable();
> > >          return ret;
> > >   }
> > > 
> > > 
> > > 
> > > Best regards,
> > > Yanfei
