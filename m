Return-Path: <SRS0=1n6r=WY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6749CC3A5A1
	for <rcu@archiver.kernel.org>; Wed, 28 Aug 2019 21:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC7A22DA7
	for <rcu@archiver.kernel.org>; Wed, 28 Aug 2019 21:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="n+Iz3RNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfH1V5A (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:57:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43204 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfH1V47 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Aug 2019 17:56:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id v12so617572pfn.10
        for <rcu@vger.kernel.org>; Wed, 28 Aug 2019 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nd+bPWlCXNocXiigb90jYgWHpu3MGjlLHt1H4GIPKsk=;
        b=n+Iz3RNKIv2G78ZVZ1TXSEKF9j9dLXkEdNpnMNVoicyXdstnIuPLFqkCjqyGSH9iJY
         o8gawdyeaRKIA7HYM9GwBrmZEUjqEqoQzGDPL6Qjj+hPvALZQLVeqdqiODiTzfmDwDgB
         jXgqJyq703XAb4M2dMxq/L+kBPkok4Gcf/Gco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nd+bPWlCXNocXiigb90jYgWHpu3MGjlLHt1H4GIPKsk=;
        b=H9gCfXuSoVDUG6ino+jJO7BuC08u1B1zAQ26LiKO2TCzAW8YVlucu6jHZs+Kr/E+cF
         DJX0C/+vPKmC0okDZNiHV0nsv78ViyrIS+MVI8TxB8AsdO3Npuwx1Lec1mXgEt1l2pJl
         Jc/+CsZf/gpOoAMLbrr91qSiS8xi3vqD9DuXKJyWMe2M3T5Mp4qqO7n9QATxIkCQS/SB
         ktcKnIHcqwRmBaYZW0L2rxiIDuyI2022xYYLWwQe6JH9Bf76u3HPEQI9kGSiTtjUxgGc
         GyIPqJ2mA0P+xMrFiJmVhuk+jyJEATId2IPoNpgT79tsiv+WvBteqscQHytcFhx1In7O
         zyaQ==
X-Gm-Message-State: APjAAAW3jOyidEdb837ebEk49HKBG1e6ns9m3JNUzoxsytInz+uj2mTG
        q3rYhxCYX04YcLAv1pwNYQ67Xg==
X-Google-Smtp-Source: APXvYqxBWzjFcxT5J+UW/brCQQfj77xr5PR8jRpUK60AFtolo6N4nAisXuYYuZDv08g7jCpB0ygItg==
X-Received: by 2002:a17:90a:bb91:: with SMTP id v17mr6143826pjr.84.1567029418977;
        Wed, 28 Aug 2019 14:56:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p20sm144125pgj.47.2019.08.28.14.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 14:56:58 -0700 (PDT)
Date:   Wed, 28 Aug 2019 17:56:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 1/2] rcu/tree: Clean up dynticks counter usage
Message-ID: <20190828215657.GA71365@google.com>
References: <5d648895.1c69fb81.5e60a.fc6f@mx.google.com>
 <20190828201344.GR26530@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828201344.GR26530@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 28, 2019 at 01:13:44PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 26, 2019 at 09:33:53PM -0400, Joel Fernandes (Google) wrote:
> > The dynticks counter are confusing due to crowbar writes of
> > DYNTICK_IRQ_NONIDLE whose purpose is to detect half-interrupts (i.e. we
> > see rcu_irq_enter() but not rcu_irq_exit() due to a usermode upcall) and
> > if so then do a reset of the dyntick_nmi_nesting counters. This patch
> > tries to get rid of DYNTICK_IRQ_NONIDLE while still keeping the code
> > working, fully functional, and less confusing. The confusion recently
> > has even led to patches forgetting that DYNTICK_IRQ_NONIDLE was written
> > to which wasted lots of time.
> > 
> > The patch has the following changes:
[snip]
> >  /*
> >   * Grace-period counter management.
> >   */
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 68ebf0eb64c8..255cd6835526 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -81,7 +81,7 @@
> >  
> >  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
> >  	.dynticks_nesting = 1,
> > -	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
> > +	.dynticks_nmi_nesting = 0,
> 
> C initializes to zero by default, so this can simply be deleted.

Fixed.

> >  	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
> >  };
> >  struct rcu_state rcu_state = {
> > @@ -558,17 +558,18 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
> >  /*
> >   * Enter an RCU extended quiescent state, which can be either the
> >   * idle loop or adaptive-tickless usermode execution.
> > - *
> > - * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
> > - * the possibility of usermode upcalls having messed up our count
> > - * of interrupt nesting level during the prior busy period.
> >   */
> >  static void rcu_eqs_enter(bool user)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  
> > -	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
> > -	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
> > +	/* Entering usermode/idle from interrupt is not handled. These would
> > +	 * mean usermode upcalls or idle entry happened from interrupts. But,
> > +	 * reset the counter if we warn.
> > +	 */
> 
> Please either put the "/*" on its own line or use "//"-style comments.

I'll put "/*" on its own line.

> >  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting <= 0);
> >  	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
> >  
> > +	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> > +		   rdp->dynticks_nmi_nesting - 1);
> 
> This is problematic.  The +/-1 and +/-2 dance is specifically for NMIs, so...

This counter is deleted in the following patch so I hope its Ok to leave it
here for this one. I just kept it split into different patch to make
testing/review/development easier.

> >  	if (irq)
> >  		rcu_prepare_for_idle();
> > @@ -723,10 +728,6 @@ void rcu_irq_exit_irqson(void)
> >  /*
> >   * Exit an RCU extended quiescent state, which can be either the
> >   * idle loop or adaptive-tickless usermode execution.
> > - *
> > - * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
> > - * allow for the possibility of usermode upcalls messing up our count of
> > - * interrupt nesting level during the busy period that is just now starting.
> >   */
> >  static void rcu_eqs_exit(bool user)
> >  {
> > @@ -747,8 +748,13 @@ static void rcu_eqs_exit(bool user)
> >  	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> >  	WRITE_ONCE(rdp->dynticks_nesting, 1);
> > -	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
> > -	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
> > +
> > +	/* Exiting usermode/idle from interrupt is not handled. These would
> > +	 * mean usermode upcalls or idle exit happened from interrupts. But,
> > +	 * reset the counter if we warn.
> > +	 */
> > +	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
> > +		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
> 
> And here.  Plus this is adding a test and branch in the common case.
> Given that the location being written to should be hot in the cache,
> it is not clear that this is a win.

The next patch removes the branch itself and just has the warning.

> >  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
> >  
> >  	/*
> > @@ -826,16 +833,21 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> >  
> >  		incby = 1;
> >  	} else if (tick_nohz_full_cpu(rdp->cpu) &&
> > -		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
> > -		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > +		   !rdp->dynticks_nmi_nesting && rdp->rcu_urgent_qs &&
> > +		   !rdp->rcu_forced_tick) {
> 
> OK.  Though you should be able to save a line by pulling the
> "rdp->rcu_urgent_qs &&" onto the first line.

Fixed.

> >  		rdp->rcu_forced_tick = true;
> >  		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> >  	}
> > +
> 
> Not clear that the added blank line is a win, here or below.

Fixed,

thanks!

 - Joel

[snip]
