Return-Path: <SRS0=Ms3y=WH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7979C433FF
	for <rcu@archiver.kernel.org>; Sun, 11 Aug 2019 21:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B1521743
	for <rcu@archiver.kernel.org>; Sun, 11 Aug 2019 21:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Gwimm/1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfHKVZM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:25:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41524 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfHKVZI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 11 Aug 2019 17:25:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id 196so1558032pfz.8
        for <rcu@vger.kernel.org>; Sun, 11 Aug 2019 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2VUELSQuKa9rXbGh+fTX1AQrQA2JZNsBjIC53r0yD9w=;
        b=Gwimm/1Gmb5mBMK68qmIhk7WbpZ1NHak3lzDendkE6EOF1gh5EKQ27BUEoWXrj35Ho
         jDlfGEnYXJMx3kiUuU8/XZj0G+u86hLFhNXB9j1Z49UJ6lDkI6GP6rbuja/xpbcRlgS/
         /bnTnKlN4XcYQjYn0abntMoh+lcwH7C9P13qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2VUELSQuKa9rXbGh+fTX1AQrQA2JZNsBjIC53r0yD9w=;
        b=I88qqn0STK9kCje4FkLNg1PjX2AdpWUd2HWyXtpgI8lj+3edvi8eWdqE2d1a0ezenQ
         rBeEe8hwQlnbbHr9kou1fWY1DrNxC+m+6crPgRi9aVXHU1NCMVITPDlxp6ZM6MfZX3gM
         vn1KBDIz5e93sCgBbGI9Lba3mtuP5MCYpSrxc2G8L1s6mTMdOUvZVa/lxEXBVaHqDmUS
         RQ2hDJdJ1MccW2l9imQrrbtElGpT0xIC8U+szJsVImVkue9bd+AFgSHLqK0otuECgJJv
         +w3L0Dan7o5DMOojyytN39CcZeaGvkT98wXq4U+hbMa2jwK1cR/VdGxEMfPBdzZ0nm2l
         S4ag==
X-Gm-Message-State: APjAAAVFdA8wYPRl5xKHKs85EBjozQIPIRKJmkbZOfQhOprUJdeLYkky
        +lZPkk0OFX+RmeZKBjSWA9yEzZDV6V8=
X-Google-Smtp-Source: APXvYqzbk5Jt9ipu+/EoRIcd5iAU9x2f75Dfia2tr7lV7stw1d6MQx9cqK/Tr9XZ9Uv5qts+yE3w7w==
X-Received: by 2002:a65:6216:: with SMTP id d22mr25598923pgv.404.1565558707717;
        Sun, 11 Aug 2019 14:25:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u16sm12744591pjb.2.2019.08.11.14.25.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 14:25:07 -0700 (PDT)
Date:   Sun, 11 Aug 2019 17:25:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190811212505.GB128944@google.com>
References: <20190811180852.GA128944@google.com>
 <CAEXW_YSbGCSLVrqD-_pDO5KJzLR2goYt8otOd65hWPQtZGkGUA@mail.gmail.com>
 <20190811211646.GY28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811211646.GY28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 11, 2019 at 02:16:46PM -0700, Paul E. McKenney wrote:
> On Sun, Aug 11, 2019 at 02:34:08PM -0400, Joel Fernandes wrote:
> > On Sun, Aug 11, 2019 at 2:08 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > Hi Paul, everyone,
> > >
> > > I noticed on reading code that the need_heavy_qs check and
> > > rcu_momentary_dyntick_idle() is only called for !PREEMPT kernels. Don't we
> > > need to call this for PREEMPT kernels for the benefit of nohz_full CPUs?
> > >
> > > Consider the following events:
> > > 1. Kernel is PREEMPT=y configuration.
> > > 2. CPU 2 is a nohz_full CPU running only a single task and the tick is off.
> > > 3. CPU 2 is running only in kernel mode and does not enter user mode or idle.
> > > 4. Grace period thread running on CPU 3 enter the fqs loop.
> > > 5. Enough time passes and it sets the need_heavy_qs for CPU2.
> > > 6. CPU 2 is still in kernel mode but does cond_resched().
> > > 7. cond_resched() does not call rcu_momentary_dyntick_idle() because PREEMPT=y.
> > >
> > > Is 7. not calling rcu_momentary_dyntick_idle() a lost opportunity for the FQS
> > > loop to detect that the CPU has crossed a quiescent point?
> > >
> > > Is this done so that cond_resched() is fast for PREEMPT=y kernels?
> > 
> > Oh, so I take it this bit of code in rcu_implicit_dynticks_qs(), with
> > the accompanying comments, takes care of the scenario I describe?
> > Another way could be just call rcu_momentary_dyntick_idle() during
> > cond_resched() for nohz_full CPUs? Is that pricey?
> >         /*
> >          * NO_HZ_FULL CPUs can run in-kernel without rcu_sched_clock_irq!
> >          * The above code handles this, but only for straight cond_resched().
> >          * And some in-kernel loops check need_resched() before calling
> >          * cond_resched(), which defeats the above code for CPUs that are
> >          * running in-kernel with scheduling-clock interrupts disabled.
> >          * So hit them over the head with the resched_cpu() hammer!
> >          */
> >         if (tick_nohz_full_cpu(rdp->cpu) &&
> >                    time_after(jiffies,
> >                               READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
> >                 resched_cpu(rdp->cpu);
> >                 WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> >         }
> 
> Yes, for NO_HZ_FULL=y&&PREEMPT=y kernels.

Actually, I was only referring to the case of NO_HZ_FULL=y being the
troublesome one (i.e. rcu_need_heavy_qs flag would have no effect).

For NO_HZ_FULL=n, I have full confidence the scheduler tick will notice
rcu_urgent_qs and do a reschedule. The ensuing softirq then does the needful
to help end the grace period.

> Your thought of including rcu_momentary_dyntick_idle() would function
> correctly, but would cause performance issues.  Even adding additional
> compares and branches in that hot codepath is visible to 0day test robot!
> So adding a read-modify-write atomic operation to that code path would
> get attention of the wrong kind.  ;-)

But wouldn't these performance issues also be visible with
NO_HZ_FULL=y && PREEMPT=n?  Why is PREEMPT=n made an exception? Is it that
0day doesn't test this combination much? :-D

thanks,

 - Joel

