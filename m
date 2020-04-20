Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2AEC3A5A0
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 16:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FC221473
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 16:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBO2rCqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgDTQ7j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbgDTQ7j (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 20 Apr 2020 12:59:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD52AC061A0C
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 09:59:38 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b2so5329324ljp.4
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A2r+PDzUK0JVItb8/RUEPDlpzch4iJ07BJTmIoTE84g=;
        b=NBO2rCqBDv3ga1vg+r33PvMmxzNwJJrn+R1VUGpP4xfYrh8U4nMlH2WSVEsp69SHSk
         iliGvrQetRmWslUURMdOvhg7V39gFn5pIxLaY5p3ZPjJXZ7iP9jKWC9RHqaGkTjJiWZU
         WgYAjBFgpMM+Xgnpz8bSklcSA5s6SyzUbGHNckWS3xd6U7lN7bHsLlyOY3ZqFYLU/ylf
         2t7+1ioKygwFyBIMGjMgvgYoVSZPu3nY7CmQb0GLmxU6Hj17V7ugrEKfm5pGHlYHKiPF
         Xn/tzCtV2nKuseOKKKXgA8xXnErvtwoZHhAiaX+F0tNFa0oy2SLzau1dNLv3yemxQg6/
         yL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A2r+PDzUK0JVItb8/RUEPDlpzch4iJ07BJTmIoTE84g=;
        b=JFvyMFm6YATFSV+VA8r0oRMOVzf3dubY/AegLwpaaANAx79wT01B+vQFx0+zBicckq
         fThnFP/xoX/Fge+zm5dLI2mIsYDI3zaMmRnFwd33C1Whok80MjX9VmzLYwYPIXh4w1DD
         HwpVV0jaf4nQNU41+oyc5q09fuLvsyKKdb+DTFP5MSH0E6ZHJRGe/mI2cXDFlqaIwoB2
         u+ChFwo8p9TjaBu3bqyhTZ5vjqptH/t/yhsIo8Bu2gjX8S12M1L0LyMj+Ni6ppEP4V7i
         nSQkm0/07cWhd0+ovJ0RofaC0LfAJeNLWmnTDDCFZo0F7IWt+aujZaSTNr9OeuOt66XB
         YtRw==
X-Gm-Message-State: AGi0PubRCMpFQ1TJWByNmZ69z93si5YP956iDWJ2xYwP6ui/u5dXapIE
        neekmIZ0+FFi/CJbxNCVAHk=
X-Google-Smtp-Source: APiQypKWo2xnlhm0zcvXira2dMWOFXR8M4DGlFgTBCMiCT/iPTfD8QOWvl9l/dInunlRQ7AksgrUlA==
X-Received: by 2002:a2e:9258:: with SMTP id v24mr2173362ljg.109.1587401977067;
        Mon, 20 Apr 2020 09:59:37 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id b28sm1221655lfo.46.2020.04.20.09.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:59:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 20 Apr 2020 18:59:24 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200420165924.GA12078@pc636>
References: <20200420011749.GF176663@google.com>
 <20200420014450.GX17661@paulmck-ThinkPad-P72>
 <20200420121316.GA10695@pc636>
 <616B79E2-977A-4079-ADAC-2D326A7284A4@joelfernandes.org>
 <20200420130003.GA10470@pc636>
 <20200420132601.GY17661@paulmck-ThinkPad-P72>
 <20200420160847.GA11451@pc636>
 <20200420162534.GD17661@paulmck-ThinkPad-P72>
 <20200420162900.GA11867@pc636>
 <20200420164657.GE17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420164657.GE17661@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 20, 2020 at 09:46:57AM -0700, Paul E. McKenney wrote:
> On Mon, Apr 20, 2020 at 06:29:00PM +0200, Uladzislau Rezki wrote:
> > On Mon, Apr 20, 2020 at 09:25:34AM -0700, Paul E. McKenney wrote:
> > > On Mon, Apr 20, 2020 at 06:08:47PM +0200, Uladzislau Rezki wrote:
> > > > On Mon, Apr 20, 2020 at 06:26:01AM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Apr 20, 2020 at 03:00:03PM +0200, Uladzislau Rezki wrote:
> > > > > > On Mon, Apr 20, 2020 at 08:36:31AM -0400, joel@joelfernandes.org wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On April 20, 2020 8:13:16 AM EDT, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > > > >On Sun, Apr 19, 2020 at 06:44:50PM -0700, Paul E. McKenney wrote:
> > > > > > > >> On Sun, Apr 19, 2020 at 09:17:49PM -0400, Joel Fernandes wrote:
> > > > > > > >> > On Sun, Apr 19, 2020 at 08:27:13PM -0400, Joel Fernandes wrote:
> > > > > > > >> > > On Sun, Apr 19, 2020 at 07:58:36AM -0700, Paul E. McKenney wrote:
> > > > > > > >> > > > On Sat, Apr 18, 2020 at 02:37:48PM +0200, Uladzislau Rezki
> > > > > > > >wrote:
> > > > > > > >> > > > > On Fri, Apr 17, 2020 at 11:54:49AM -0700, Paul E. McKenney
> > > > > > > >wrote:
> > > > > > > >> > > > > > On Fri, Apr 17, 2020 at 02:26:41PM -0400, Joel Fernandes
> > > > > > > >wrote:
> > > > > > > >> > > > > > > On Fri, Apr 17, 2020 at 05:04:42PM +0200, Sebastian
> > > > > > > >Andrzej Siewior wrote:
> > > > > > > >> > > > > > > > On 2020-04-16 23:05:15 [-0400], Joel Fernandes wrote:
> > > > > > > >> > > > > > > > > On Thu, Apr 16, 2020 at 11:34:44PM +0200, Sebastian
> > > > > > > >Andrzej Siewior wrote:
> > > > > > > >> > > > > > > > > > On 2020-04-16 14:00:57 [-0700], Paul E. McKenney
> > > > > > > >wrote:
> > > > > > > >> > > > > > > > > > > 
> > > > > > > >> > > > > > > > > > > We might need different calling-context
> > > > > > > >restrictions for the two variants
> > > > > > > >> > > > > > > > > > > of kfree_rcu().  And we might need to come up
> > > > > > > >with some sort of lockdep
> > > > > > > >> > > > > > > > > > > check for "safe to use normal spinlock in -rt".
> > > > > > > >> > > > > > > > > > 
> > > > > > > >> > > > > > > > > > Oh. We do have this already, it is called
> > > > > > > >CONFIG_PROVE_RAW_LOCK_NESTING.
> > > > > > > >> > > > > > > > > > This one will scream if you do
> > > > > > > >> > > > > > > > > > 	raw_spin_lock();
> > > > > > > >> > > > > > > > > > 	spin_lock();
> > > > > > > >> > > > > > > > > > 
> > > > > > > >> > > > > > > > > > Sadly, as of today, there is code triggering this
> > > > > > > >which needs to be
> > > > > > > >> > > > > > > > > > addressed first (but it is one list of things to
> > > > > > > >do).
> > > > > > > >> > > > > > > > > > 
> > > > > > > >> > > > > > > > > > Given the thread so far, is it okay if I repost the
> > > > > > > >series with
> > > > > > > >> > > > > > > > > > migrate_disable() instead of accepting a possible
> > > > > > > >migration before
> > > > > > > >> > > > > > > > > > grabbing the lock? I would prefer to avoid the
> > > > > > > >extra RT case (avoiding
> > > > > > > >> > > > > > > > > > memory allocations in a possible atomic context)
> > > > > > > >until we get there.
> > > > > > > >> > > > > > > > > 
> > > > > > > >> > > > > > > > > I prefer something like the following to make it
> > > > > > > >possible to invoke
> > > > > > > >> > > > > > > > > kfree_rcu() from atomic context considering
> > > > > > > >call_rcu() is already callable
> > > > > > > >> > > > > > > > > from such contexts. Thoughts?
> > > > > > > >> > > > > > > > 
> > > > > > > >> > > > > > > > So it looks like it would work. However, could we
> > > > > > > >please delay this
> > > > > > > >> > > > > > > > until we have an actual case on RT? I just added
> > > > > > > >> > > > > > > > 	WARN_ON(!preemptible());
> > > > > > > >> > > > > > > 
> > > > > > > >> > > > > > > I am not sure if waiting for it to break in the future is
> > > > > > > >a good idea. I'd
> > > > > > > >> > > > > > > rather design it in a forward thinking way. There could
> > > > > > > >be folks replacing
> > > > > > > >> > > > > > > "call_rcu() + kfree in a callback" with kfree_rcu() for
> > > > > > > >example. If they were
> > > > > > > >> > > > > > > in !preemptible(), we'd break on page allocation.
> > > > > > > >> > > > > > > 
> > > > > > > >> > > > > > > Also as a sidenote, the additional pre-allocation of
> > > > > > > >pages that Vlad is
> > > > > > > >> > > > > > > planning on adding would further reduce the need for
> > > > > > > >pages from the page
> > > > > > > >> > > > > > > allocator.
> > > > > > > >> > > > > > > 
> > > > > > > >> > > > > > > Paul, what is your opinion on this?
> > > > > > > >> > > > > > 
> > > > > > > >> > > > > > My experience with call_rcu(), of which kfree_rcu() is a
> > > > > > > >specialization,
> > > > > > > >> > > > > > is that it gets invoked with preemption disabled, with
> > > > > > > >interrupts
> > > > > > > >> > > > > > disabled, and during early boot, as in even before
> > > > > > > >rcu_init() has been
> > > > > > > >> > > > > > invoked.  This experience does make me lean towards raw
> > > > > > > >spinlocks.
> > > > > > > >> > > > > > 
> > > > > > > >> > > > > > But to Sebastian's point, if we are going to use raw
> > > > > > > >spinlocks, we need
> > > > > > > >> > > > > > to keep the code paths holding those spinlocks as short as
> > > > > > > >possible.
> > > > > > > >> > > > > > I suppose that the inability to allocate memory with raw
> > > > > > > >spinlocks held
> > > > > > > >> > > > > > helps, but it is worth checking.
> > > > > > > >> > > > > >
> > > > > > > >> > > > > How about reducing the lock contention even further?
> > > > > > > >> > > > 
> > > > > > > >> > > > Can we do even better by moving the work-scheduling out from
> > > > > > > >under the
> > > > > > > >> > > > spinlock?  This of course means that it is necessary to handle
> > > > > > > >the
> > > > > > > >> > > > occasional spurious call to the work handler, but that should
> > > > > > > >be rare
> > > > > > > >> > > > and should be in the noise compared to the reduction in
> > > > > > > >contention.
> > > > > > > >> > > 
> > > > > > > >> > > Yes I think that will be required since -rt will sleep on
> > > > > > > >workqueue locks as
> > > > > > > >> > > well :-(. I'm looking into it right now.
> > > > > > > >> > > 
> > > > > > > >> > >         /*
> > > > > > > >> > >          * If @work was previously on a different pool, it might
> > > > > > > >still be
> > > > > > > >> > >          * running there, in which case the work needs to be
> > > > > > > >queued on that
> > > > > > > >> > >          * pool to guarantee non-reentrancy.
> > > > > > > >> > >          */
> > > > > > > >> > >         last_pool = get_work_pool(work);
> > > > > > > >> > >         if (last_pool && last_pool != pwq->pool) {
> > > > > > > >> > >                 struct worker *worker;
> > > > > > > >> > > 
> > > > > > > >> > >                 spin_lock(&last_pool->lock);
> > > > > > > >> > 
> > > > > > > >> > Hmm, I think moving schedule_delayed_work() outside lock will work.
> > > > > > > >Just took
> > > > > > > >> > a good look and that's not an issue. However calling
> > > > > > > >schedule_delayed_work()
> > > > > > > >> > itself is an issue if the caller of kfree_rcu() is !preemptible()
> > > > > > > >on
> > > > > > > >> > PREEMPT_RT. Because the schedule_delayed_work() calls spin_lock on
> > > > > > > >pool->lock
> > > > > > > >> > which can sleep on PREEMPT_RT :-(. Which means we have to do either
> > > > > > > >of:
> > > > > > > >> > 
> > > > > > > >> > 1. Implement a new mechanism for scheduling delayed work that does
> > > > > > > >not
> > > > > > > >> >    acquire sleeping locks.
> > > > > > > >> > 
> > > > > > > >> > 2. Allow kfree_rcu() only from preemptible context (That is
> > > > > > > >Sebastian's
> > > > > > > >> >    initial patch to replace local_irq_save() + spin_lock() with
> > > > > > > >> >    spin_lock_irqsave()).
> > > > > > > >> > 
> > > > > > > >> > 3. Queue the work through irq_work or another bottom-half
> > > > > > > >mechanism.
> > > > > > > >> 
> > > > > > > >> I use irq_work elsewhere in RCU, but the queue_delayed_work() might
> > > > > > > >> go well with a timer.  This can of course be done conditionally.
> > > > > > > >> 
> > > > > > > >We can schedule_delayed_work() inside and outside of the spinlock,
> > > > > > > >i.e. it is not an issue for RT kernel, because as it was noted in last
> > > > > > > >message a workqueue system uses raw spinlicks internally. I checked
> > > > > > > >the latest linux-5.6.y-rt also. If we do it inside, we will place the
> > > > > > > >work on current CPU, at least as i see it, even if it is "unbound".
> > > > > > > >
> > > > > > > 
> > > > > > > Thanks for confirming!!
> > > > > > > 
> > > > > > > >If we do it outside, we will reduce a critical section, from the other
> > > > > > > >hand we can introduce a potential delay in placing the context into
> > > > > > > >CPUs
> > > > > > > >run-queuye. As a result we could end up on another CPU, thus placing
> > > > > > > >the work on new CPU, plus memory foot-print might be higher. It would
> > > > > > > >be good to test and have a look at it actually.
> > > > > > > >
> > > > > > > >But it can be negligible :)
> > > > > > > 
> > > > > > > Since the wq locking is raw spinlock on rt as Mike and you mentioned,  if wq holds lock for too long that itself will spawn a lengthy non preemptible critical section, so from that standpoint doing it under our lock should be ok I think.
> > > > > > > 
> > > > > > It should be OK, i do not expect to get noticeable latency for any RT
> > > > > > workloads.
> > > > > > 
> > > > > > > >
> > > > > > > >> > Any other thoughts?
> > > > > > > >> 
> > > > > > > >> I did forget to ask you guys your opinions about the downsides (if
> > > > > > > >any)
> > > > > > > >> of moving from unbound to per-CPU workqueues.  Thoughts?
> > > > > > > >> 
> > > > > > > >If we do it outside of spinlock, there is at least one drawback that i
> > > > > > > >see, i described it above. We can use schedule_delayed_work_on() but
> > > > > > > >we as a caller have to guarantee that a CPU we about to place a work
> > > > > > > >is alive :)
> > > > > > > 
> > > > > > > FWIW, some time back I did a simple manual test calling queue_work_on on an offline CPU to see what happens and it appears to be working fine. On a 4 CPU system, I offline CPU 3 and queue the work on it which ends up executing on CPU 0 instead.
> > > > > > > 
> > > > > > <snip>
> > > > > > /**
> > > > > >  * queue_work_on - queue work on specific cpu
> > > > > >  * @cpu: CPU number to execute work on
> > > > > >  * @wq: workqueue to use
> > > > > >  * @work: work to queue
> > > > > >  *
> > > > > >  * We queue the work to a specific CPU, the caller must ensure it
> > > > > >  * can't go away.
> > > > > >  *
> > > > > >  * Return: %false if @work was already on a queue, %true otherwise.
> > > > > >  */
> > > > > > <snip>
> > > > > > 
> > > > > > It says, how i see it, we should ensure it can not go away. So, if
> > > > > > we drop the lock we should do like:
> > > > > > 
> > > > > > get_online_cpus();
> > > > > > check a CPU is onlen;
> > > > > > queue_work_on();
> > > > > > put_online_cpus();
> > > > > > 
> > > > > > but i suspect we do not want to do it :)
> > > > > 
> > > > > Indeed, it might impose a few restrictions and a bit of overhead that
> > > > > might not be welcome at some point in the future.  ;-)
> > > > > 
> > > > > On top of this there are potential load-balancing concerns.  By specifying
> > > > > the CPU, you are limiting workqueue's and scheduler's ability to adjust to
> > > > > any sudden changes in load.  Maybe not enough to matter in most cases, but
> > > > > might be an issue if there is a sudden flood of  kfree_rcu() invocations.
> > > > > 
> > > > Agree. Let's keep it as it is now :)
> > > 
> > > I am not sure which "as it is now" you are referring to, but I suspect
> > > that the -rt guys prefer two short interrupts-disabled regions to one
> > > longer interrupts-disabled region.
> > 
> > I mean to run schedule_delayed_work() under spinlock.
> 
> Which is an interrupt-disabled spinlock, correct?
> 
To do it under holding the lock, currently it is spinlock, but it is
going to be(if you agree :)) raw ones, which keeps IRQs disabled. I
saw Joel sent out patches.

--
Vlad Rezki
