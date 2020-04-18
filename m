Return-Path: <SRS0=hY+h=6C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E29C3A5A0
	for <rcu@archiver.kernel.org>; Sat, 18 Apr 2020 12:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D22206D9
	for <rcu@archiver.kernel.org>; Sat, 18 Apr 2020 12:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTCc1oSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDRMh7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Apr 2020 08:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbgDRMh6 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sat, 18 Apr 2020 08:37:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E92C061A0C
        for <rcu@vger.kernel.org>; Sat, 18 Apr 2020 05:37:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u15so4828466ljd.3
        for <rcu@vger.kernel.org>; Sat, 18 Apr 2020 05:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CRDVgZ9W5HNWXaxz6RVHrX96wEn/AbgBRYcLl4zTD8c=;
        b=gTCc1oSIC23aQuN2g2cjJvHLyFt9/aep/W+cB1ULQFIxOHyupn6uwSgbtCpJGZKY/E
         cHJ894hXU9XL1lm0uLXnPROY/96FVuYoO1jnqP6CU7MpisrTsZGX8w16VO7/+0iharl9
         03FO8ClR0Kg+NLB+J84M9m3HZ3mID/Hl4ZNPuZq0LFnH5EvaYFpLnVJkLeKyJVUL9Qvq
         EGq5WrvdUugFTzDcmCTm8VgFn//m+wCdPl72D2ISeMrhKQclrmdD9KYLnS1Em3yCJ8Ju
         gqb5Cx527OfNpsH7TTdckwy0xwPvtvByIB5DM4/LMqTYAwJlRSU6HQs6RDAaNQsBDY8M
         cAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CRDVgZ9W5HNWXaxz6RVHrX96wEn/AbgBRYcLl4zTD8c=;
        b=Nx6++4VuNQjH03QsUE1U5eBS+ampcCTIZnMHqMHPy5YuTIc0jOktNmlJZCHMpHA5Bj
         m5eZHFUMnRVnhak10uOHc/VwEV5cKajr/jeD0NKype889FKS9JjflBVO5GDIc9vazVSK
         3JeWOBwjJ+3GR1kc+5fn8xY5KSW894sprT1XF8s9rmY9dpiKpNsrlikRqTttY4JU3d8U
         9gZN4PHqwWBYZxGh4NAFAD2qUCr08l7oaMuWBYVT4NG1K+6RAHOpeoBrQYUua68yD34E
         Vq6R8HKqYFu8M79dwYhoxTARBQ5W0/3sJNNJcXPxEjV3bABxU/CbGRijK6JLI9ofw8/R
         gXRg==
X-Gm-Message-State: AGi0Pub6NtATJW2VC0Jzk3rXLCDBu7TRZvN8KuozCxRkRL+qSv+iWdMG
        YDnc2AQ/pXeX5044ro367PA=
X-Google-Smtp-Source: APiQypKKxjHISQ9WxUvKJMvQ8VsDvLc4SiuCZxF/nLKlXoUycTOzqlIIwseXGRg9vZ7qWbq95fld2A==
X-Received: by 2002:a2e:7815:: with SMTP id t21mr4778746ljc.146.1587213476258;
        Sat, 18 Apr 2020 05:37:56 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id g5sm18529445ljl.106.2020.04.18.05.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 05:37:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 18 Apr 2020 14:37:48 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200418123748.GA3306@pc636>
References: <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
 <20200416203637.GA176663@google.com>
 <20200416210057.GY17661@paulmck-ThinkPad-P72>
 <20200416213444.4cc6kzxmwl32s2eh@linutronix.de>
 <20200417030515.GE176663@google.com>
 <20200417150442.gyrxhjymvfwsvum5@linutronix.de>
 <20200417182641.GB168907@google.com>
 <20200417185449.GM17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417185449.GM17661@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 17, 2020 at 11:54:49AM -0700, Paul E. McKenney wrote:
> On Fri, Apr 17, 2020 at 02:26:41PM -0400, Joel Fernandes wrote:
> > On Fri, Apr 17, 2020 at 05:04:42PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2020-04-16 23:05:15 [-0400], Joel Fernandes wrote:
> > > > On Thu, Apr 16, 2020 at 11:34:44PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > On 2020-04-16 14:00:57 [-0700], Paul E. McKenney wrote:
> > > > > > 
> > > > > > We might need different calling-context restrictions for the two variants
> > > > > > of kfree_rcu().  And we might need to come up with some sort of lockdep
> > > > > > check for "safe to use normal spinlock in -rt".
> > > > > 
> > > > > Oh. We do have this already, it is called CONFIG_PROVE_RAW_LOCK_NESTING.
> > > > > This one will scream if you do
> > > > > 	raw_spin_lock();
> > > > > 	spin_lock();
> > > > > 
> > > > > Sadly, as of today, there is code triggering this which needs to be
> > > > > addressed first (but it is one list of things to do).
> > > > > 
> > > > > Given the thread so far, is it okay if I repost the series with
> > > > > migrate_disable() instead of accepting a possible migration before
> > > > > grabbing the lock? I would prefer to avoid the extra RT case (avoiding
> > > > > memory allocations in a possible atomic context) until we get there.
> > > > 
> > > > I prefer something like the following to make it possible to invoke
> > > > kfree_rcu() from atomic context considering call_rcu() is already callable
> > > > from such contexts. Thoughts?
> > > 
> > > So it looks like it would work. However, could we please delay this
> > > until we have an actual case on RT? I just added
> > > 	WARN_ON(!preemptible());
> > 
> > I am not sure if waiting for it to break in the future is a good idea. I'd
> > rather design it in a forward thinking way. There could be folks replacing
> > "call_rcu() + kfree in a callback" with kfree_rcu() for example. If they were
> > in !preemptible(), we'd break on page allocation.
> > 
> > Also as a sidenote, the additional pre-allocation of pages that Vlad is
> > planning on adding would further reduce the need for pages from the page
> > allocator.
> > 
> > Paul, what is your opinion on this?
> 
> My experience with call_rcu(), of which kfree_rcu() is a specialization,
> is that it gets invoked with preemption disabled, with interrupts
> disabled, and during early boot, as in even before rcu_init() has been
> invoked.  This experience does make me lean towards raw spinlocks.
> 
> But to Sebastian's point, if we are going to use raw spinlocks, we need
> to keep the code paths holding those spinlocks as short as possible.
> I suppose that the inability to allocate memory with raw spinlocks held
> helps, but it is worth checking.
>
How about reducing the lock contention even further?

<snip>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f288477ee1c2..fb916e065784 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3053,7 +3053,8 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,

        // Previous RCU batch still in progress, try again later.
        krcp->monitor_todo = true;
-       schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+       schedule_delayed_work_on(raw_smp_processor_id(),
+               &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
        spin_unlock_irqrestore(&krcp->lock, flags);
 }

@@ -3168,7 +3169,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
        if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
            !krcp->monitor_todo) {
                krcp->monitor_todo = true;
-               schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+               schedule_delayed_work_on(raw_smp_processor_id(),
+                       &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
        }

 unlock_return:
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 891ccad5f271..49fcc50469f4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1723,7 +1723,9 @@ static void rcu_work_rcufn(struct rcu_head *rcu)

        /* read the comment in __queue_work() */
        local_irq_disable();
-       __queue_work(WORK_CPU_UNBOUND, rwork->wq, &rwork->work);
+
+       /* Just for illustration. Can have queue_rcu_work_on(). */
+       __queue_work(raw_smp_processor_id(), rwork->wq, &rwork->work);
        local_irq_enable();
 }
<snip>

Thoughts?

--
Vlad Rezki
