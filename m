Return-Path: <SRS0=P5Uu=WI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E449FC0650F
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 01:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE7F20651
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 01:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VFBIjgaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfHLBYf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Aug 2019 21:24:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33497 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHLBYf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 11 Aug 2019 21:24:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so48911993pfq.0
        for <rcu@vger.kernel.org>; Sun, 11 Aug 2019 18:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qLivB1+BZbkGGap10nWLEwY5A3gGz2hPwEVRx1oKepg=;
        b=VFBIjgaQP2LJlGwsyagWAwTwCjvoU4/viDRAE6Sp6XIwrWX/Tl4zLh/21rIRVq1gms
         JoDuKjtdj0R7N4TMy9Rp7qF7bnyTktrKHcuwiBoeAFNLQ1P9Sxx2fM7nC7clvDpJ3yJG
         7+vhUK/b0Zx/+vENb6QOdcQOS2jhsFYnWsvwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qLivB1+BZbkGGap10nWLEwY5A3gGz2hPwEVRx1oKepg=;
        b=jCURZ4Qam12Igs5sbQYeFIDVheFHCVZyJfIuFHZaIYufxAH3o22nxhCPBiLgBtA4+V
         PTj+wONNKoII0l1ad4Romno81grV67RTnq/DGd2pWEwGzYGB2pwaDXd+YOfmS74XUuya
         1YUcvNglZKo+0TnY1omwgm+crq4qTUcESmJ5BEaVgpvlgvgnozozteKDSkybD3f0TE0W
         f52bYN0tjpvq/8qmu11fUgYwcy7IQ0Ib3A+7sOP02hoOxLT4IuJXesGQ0BmaGlRQDSFc
         xFTB/YD4NrUDaaH6p0nhsChlGwgCzB38OTyV3HyiKWWN0bfddOAe5CJTx0Z7m5hAWNmA
         cF7A==
X-Gm-Message-State: APjAAAXLtvhwjuF5phPmE/XiDQcU0NFhNpEC2f9xC3bzNf74GjlFCF4b
        x3fixqvjfQVyAdYqOkwSWMX1XIOGzs8=
X-Google-Smtp-Source: APXvYqwKRO73h2ASTeFOYcAo2XY8D9UOxDTg+mHrW+mCe2FT7LH3aOh1JfK2t//itJ5sumwrhqdI4Q==
X-Received: by 2002:a17:90a:bc42:: with SMTP id t2mr21007318pjv.121.1565573074017;
        Sun, 11 Aug 2019 18:24:34 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i137sm112862764pgc.4.2019.08.11.18.24.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 18:24:33 -0700 (PDT)
Date:   Sun, 11 Aug 2019 21:24:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190812012431.GC128944@google.com>
References: <20190811180852.GA128944@google.com>
 <CAEXW_YSbGCSLVrqD-_pDO5KJzLR2goYt8otOd65hWPQtZGkGUA@mail.gmail.com>
 <20190811211646.GY28441@linux.ibm.com>
 <20190811212505.GB128944@google.com>
 <20190811233024.GZ28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811233024.GZ28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 11, 2019 at 04:30:24PM -0700, Paul E. McKenney wrote:
> On Sun, Aug 11, 2019 at 05:25:05PM -0400, Joel Fernandes wrote:
> > On Sun, Aug 11, 2019 at 02:16:46PM -0700, Paul E. McKenney wrote:
> > > On Sun, Aug 11, 2019 at 02:34:08PM -0400, Joel Fernandes wrote:
> > > > On Sun, Aug 11, 2019 at 2:08 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > Hi Paul, everyone,
> > > > >
> > > > > I noticed on reading code that the need_heavy_qs check and
> > > > > rcu_momentary_dyntick_idle() is only called for !PREEMPT kernels. Don't we
> > > > > need to call this for PREEMPT kernels for the benefit of nohz_full CPUs?
> > > > >
> > > > > Consider the following events:
> > > > > 1. Kernel is PREEMPT=y configuration.
> > > > > 2. CPU 2 is a nohz_full CPU running only a single task and the tick is off.
> > > > > 3. CPU 2 is running only in kernel mode and does not enter user mode or idle.
> > > > > 4. Grace period thread running on CPU 3 enter the fqs loop.
> > > > > 5. Enough time passes and it sets the need_heavy_qs for CPU2.
> > > > > 6. CPU 2 is still in kernel mode but does cond_resched().
> > > > > 7. cond_resched() does not call rcu_momentary_dyntick_idle() because PREEMPT=y.
> > > > >
> > > > > Is 7. not calling rcu_momentary_dyntick_idle() a lost opportunity for the FQS
> > > > > loop to detect that the CPU has crossed a quiescent point?
> > > > >
> > > > > Is this done so that cond_resched() is fast for PREEMPT=y kernels?
> > > > 
> > > > Oh, so I take it this bit of code in rcu_implicit_dynticks_qs(), with
> > > > the accompanying comments, takes care of the scenario I describe?
> > > > Another way could be just call rcu_momentary_dyntick_idle() during
> > > > cond_resched() for nohz_full CPUs? Is that pricey?
> > > >         /*
> > > >          * NO_HZ_FULL CPUs can run in-kernel without rcu_sched_clock_irq!
> > > >          * The above code handles this, but only for straight cond_resched().
> > > >          * And some in-kernel loops check need_resched() before calling
> > > >          * cond_resched(), which defeats the above code for CPUs that are
> > > >          * running in-kernel with scheduling-clock interrupts disabled.
> > > >          * So hit them over the head with the resched_cpu() hammer!
> > > >          */
> > > >         if (tick_nohz_full_cpu(rdp->cpu) &&
> > > >                    time_after(jiffies,
> > > >                               READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
> > > >                 resched_cpu(rdp->cpu);
> > > >                 WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> > > >         }
> > > 
> > > Yes, for NO_HZ_FULL=y&&PREEMPT=y kernels.
> > 
> > Actually, I was only referring to the case of NO_HZ_FULL=y being the
> > troublesome one (i.e. rcu_need_heavy_qs flag would have no effect).
> > 
> > For NO_HZ_FULL=n, I have full confidence the scheduler tick will notice
> > rcu_urgent_qs and do a reschedule. The ensuing softirq then does the needful
> > to help end the grace period.
> 
> Whew!
> 
> That confidence was not at all apparent in your initial email.

Sorry, I should improve the quality of my emails for sure.

> > > Your thought of including rcu_momentary_dyntick_idle() would function
> > > correctly, but would cause performance issues.  Even adding additional
> > > compares and branches in that hot codepath is visible to 0day test robot!
> > > So adding a read-modify-write atomic operation to that code path would
> > > get attention of the wrong kind.  ;-)
> > 
> > But wouldn't these performance issues also be visible with
> > NO_HZ_FULL=y && PREEMPT=n?
> 
> In PREEMPT=n, cond_resched() already has a check, and with quite a bit
> of care it is possible to introduce another.

Actually, may be I did not express properly. I mean the performance issues
that 0day found (that you mentioned above) with invoking
rcu_momentary_dyntick_idle() from hotpaths should also have been found with
PREEMPT=n. However, sounds like it has found these issues only when invoking
rcu_momentary_dyntick_idle() with PREEMPT=y - which as you said is the reason
rcu_momentary_dyntick_idle() is not invoked in PREEMPT=y. So I was asking,
why are these same performance issues not seen with PREEMPT=n? And if they
are seen, why do we invoke rcu_momentary_dyntick_idle() in mainline for
PREEMPT=n kernels?


> >                             Why is PREEMPT=n made an exception?
> 
> The exception is actually CONFIG_NO_HZ_FULL=y && CONFIG_PREEMPT=y.
> In that case, we can rely on neither the scheduling-clock interrupt
> nor on cond_resched().  In the other three cases, we have one or both.

Agreed, that's what I found weird. PREEMPT=y with NOHZ_FULL=y has no support
to rely on. While PREEMPT=n with NOHZ_FULL=y does. So my question was about
the rationale for why there is this difference. Either we invoke
rcu_momentary_dyntick_idle for both PREEMPT options, or we don't invoke it
for either. Why invoke it for one but not the other?

> Next question:  Why does rcu_implicit_dynticks_qs() check only for
> tick_nohz_full_cpu() and not also IS_ENABLED(CONFIG_PREEMPT)?  After
> all, a nohz_full CPU in a !CONFIG_PREEMPT kernel should be able to
> rely on cond_resched(), right?
> 
> Should this change?  Why or why not?

Let me think more about this :) I have an answer in mind but I will think a
bit more about it and responsd :)

thanks,

 - Joel

