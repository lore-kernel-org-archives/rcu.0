Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A20C2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 15:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DBD206D9
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 15:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTsykRuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409485AbgDPPBz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408964AbgDPPBx (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 11:01:53 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D97C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 08:01:52 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j14so5824067lfg.9
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bN5zOsX/YF3I7wMgWkoKHYHPMW6sJpdxNWkkEXOz+jQ=;
        b=vTsykRuVzD49pThT4WP1675INY3ZlRHAg+0lfz77oqEKhfDr3HbgyUyLrPU+SWImAB
         RX8oSr3Eddz5j3v/4myZd1UzEQtnGvDDFNj+M5D9n8rcEXDQoGNyGeoIW+kTUAmQUrxg
         MbU5PXwWb4t/lbgoAgO0tRwmvgZ1wZMuh04XarQ7wLirG8rT+Ccbfl6w9V1JDH/jSJ/n
         Etza3WG/CxN0IcJ3RsbssPRZVgfBTAWXQ2fSgXN46M7LVxjVrQ/eHxPB9ar+KaL/wxNq
         O64km01KYurnIjwqMHfupklpDIUc1nTM/+iPA/bz23wW4J+pMRWs7QynYk8dbnLVnF1u
         /FKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bN5zOsX/YF3I7wMgWkoKHYHPMW6sJpdxNWkkEXOz+jQ=;
        b=acTJY733X1LB9gPX6sarVpWhw8NQ6pLR7Qv5pp2di3lb7VSVkB7HR8vdWmcE1ea/Yx
         q3KqtMXWN8RH/AhBQlyQjLnyu4xsH8ZbeX5dbT23NIsOvWLhAZf7UbDVGSIkxla0dlld
         xaQPjK6VN+RhHdSYlz6ZpSYefUyWv71V0fA1qCroQtYZTapZKrZaPNzWj9kMUln8gfjx
         XkJAooRuIKaScckTmMkgQmjm5vo81O7jsNSOVHmg8CoDnrZ5gjDBO5gICrCaeAQ/u8SL
         t7Xj8ah3oiLX33DiOrz7Cw7nJ7lov+s6Ffx+BDrr5VCTbq52cNZbkEOI1QVNt3WZ4MGQ
         GS8g==
X-Gm-Message-State: AGi0PuablXormY9SpwUr27seEhvlzVYEkdfERcimgLjOFYY5ucyAIseI
        cD4wWW7z7qFFyKhPSuyFwxE=
X-Google-Smtp-Source: APiQypK5Q3VoKnTx17fJaWmKj7xIzsUojdmxhpcAiKiayRMHM4Poy4ZcA5VL7IYTD17kq3kimFuGHg==
X-Received: by 2002:ac2:4466:: with SMTP id y6mr6367175lfl.125.1587049310854;
        Thu, 16 Apr 2020 08:01:50 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id i3sm1762696ljg.82.2020.04.16.08.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:01:50 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Apr 2020 17:01:43 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416150038.GA7772@pc636>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416144254.GC90777@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello.

I am not fully in the picture(next time will be :)). But see some comments below.

> > The per-CPU variable is initialized at runtime in
> > kfree_rcu_batch_init(). This function is invoked before
> > `rcu_scheduler_active' is set to `RCU_SCHEDULER_RUNNING'. After the
> > initialisation, `->initialized' is to true.
> > 
> > The spin_lock is only acquired if `->initialized' is set to true. The
> > worqueue item is only used if `rcu_scheduler_active' set to
> > RCU_SCHEDULER_RUNNING' which happens after initialisation.
> > 
> > Use a static initializer for krc.lock and remove the runtime
> > initialisation of the lock. Since the lock can now be always acquired,
> > remove the `->initialized' check.
> > The local_irq_save() is removed and raw_cpu_ptr() + spin_lock_irqsave()
> > is used. The worst case scenario is that after raw_cpu_ptr() the code
> > has been moved to another CPU. This is "okay" because the data strucure
> > itself is protected with a lock.
> > Add a warning in kfree_rcu_batch_init() to ensure that this function is
> > invoked before `RCU_SCHEDULER_RUNNING' to ensure that the worker is not
> > used earlier.
> > 
> > Reported-by: Mike Galbraith <efault@gmx.de>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/rcu/tree.c | 22 +++++++---------------
> >  1 file changed, 7 insertions(+), 15 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index f288477ee1c26..5b0b63dd04b02 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2893,7 +2893,6 @@ struct kfree_rcu_cpu_work {
> >   * @lock: Synchronize access to this structure
> >   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> >   * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
> > - * @initialized: The @lock and @rcu_work fields have been initialized
> >   *
> >   * This is a per-CPU structure.  The reason that it is not included in
> >   * the rcu_data structure is to permit this code to be extracted from
> > @@ -2908,12 +2907,13 @@ struct kfree_rcu_cpu {
> >  	spinlock_t lock;
> >  	struct delayed_work monitor_work;
> >  	bool monitor_todo;
> > -	bool initialized;
> >  	// Number of objects for which GP not started
> >  	int count;
> >  };
> >  
> > -static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
> > +static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> > +	.lock	= __SPIN_LOCK_UNLOCKED(krc.lock),
> > +};
> >  
> >  static __always_inline void
> >  debug_rcu_head_unqueue_bulk(struct rcu_head *head)
> > @@ -3080,9 +3080,6 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> >  {
> >  	struct kfree_rcu_bulk_data *bnode;
> >  
> > -	if (unlikely(!krcp->initialized))
> > -		return false;
> > -
> >  	lockdep_assert_held(&krcp->lock);
It makes sense to initialize the spinlock statically, i mean not in runtime.

> >  
> >  	/* Check if a new block is required. */
> > @@ -3139,10 +3136,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  	unsigned long flags;
> >  	struct kfree_rcu_cpu *krcp;
> >  
> > -	local_irq_save(flags);	// For safely calling this_cpu_ptr().
> > -	krcp = this_cpu_ptr(&krc);
> > -	if (krcp->initialized)
> > -		spin_lock(&krcp->lock);
> > +	krcp = raw_cpu_ptr(&krc);
> > +	spin_lock_irqsave(&krcp->lock, flags);
> 
It is not a good way to access to per-CPU variable. There is a race in
your code. So, we will rework it anyway soon. To guarantee that we stay
on the same CPU, first we disable IRQ's then we access per-CPU var and
take a spinlock.

--
Vlad Rezki
