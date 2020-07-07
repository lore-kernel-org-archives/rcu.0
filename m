Return-Path: <SRS0=8S7d=AS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFA8C433E0
	for <rcu@archiver.kernel.org>; Tue,  7 Jul 2020 18:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8758206E2
	for <rcu@archiver.kernel.org>; Tue,  7 Jul 2020 18:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="d7qtGy6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgGGSpe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgGGSpe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Jul 2020 14:45:34 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B6DC061755
        for <rcu@vger.kernel.org>; Tue,  7 Jul 2020 11:45:33 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id a14so19302812qvq.6
        for <rcu@vger.kernel.org>; Tue, 07 Jul 2020 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pG2rfBHuMMk3OEB7gVGSVBSplw8MMVUuOym1KKtoxnU=;
        b=d7qtGy6hWHtbgHfObrey4XSs+iqg6NYk/FHoHcBrE41c95M0cd5wiDIJ4yDXTtqBOi
         n8/IUeznX1FGJ4IJJ6Rv3unBs4OOce0lcfI+hlNh5xXCYVGjkY+kpBIaSRyBKnDg50iz
         C4R/XDT3bqjvCYzSXyehvE5YDas124HAb6amI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pG2rfBHuMMk3OEB7gVGSVBSplw8MMVUuOym1KKtoxnU=;
        b=AH9Q0QjcW07NTiTL/wrYIMko0IZsS7dJJX3BrN9N4u3xVNbMpvZYcNtApcAaZ6MOfl
         CoE5deko46RYbka7VZALR//T6GVk15WE/K07r+FEKHQwSTBJcIQP0VZybOQi1Fd29F6t
         qFBoIRv89hC0JUHWU4dlP2vqRHTrdA1AP5UnU2xGsaBQ0tE5gs/lgHkrzZmoOOXoNsc2
         UeP3v1DxGYs0DpFyrTdobLuXiraJgzvNx/clVX2F10XnxwGWTTLYe8tsW/Jdlqg/2ZCa
         75WPlkuVJjhc4/hXdWKrOzZi2HXK9cvX9b09E+5tY36rdTgimorp1fUM9eFOUWSGp5Fg
         5P3g==
X-Gm-Message-State: AOAM531oRfaHTLsy/h+atN7MMtakx69V7UvxfwWEzZPhW52VAAUuhhr8
        rF3HCOXWalPvejBosGm3JEsvuQ==
X-Google-Smtp-Source: ABdhPJxAJJxgayqbwMxEq+Lm1kpT/BWtAQO2SkYd3c23nWGvu+d+5XnLw4dIFDUbGY7lXnzRBtNFMA==
X-Received: by 2002:ad4:5912:: with SMTP id ez18mr43800249qvb.24.1594147532806;
        Tue, 07 Jul 2020 11:45:32 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 23sm24366602qkl.52.2020.07.07.11.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 11:45:32 -0700 (PDT)
Date:   Tue, 7 Jul 2020 14:45:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200707184531.GC233429@google.com>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
 <20200702164826.GQ9247@paulmck-ThinkPad-P72>
 <20200702201908.jfiacgvion6a4nmj@linutronix.de>
 <20200706210645.GJ9247@paulmck-ThinkPad-P72>
 <20200707173441.GA28267@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707173441.GA28267@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 07, 2020 at 07:34:41PM +0200, Uladzislau Rezki wrote:
> On Mon, Jul 06, 2020 at 02:06:45PM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 02, 2020 at 10:19:08PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2020-07-02 09:48:26 [-0700], Paul E. McKenney wrote:
> > > > On Thu, Jul 02, 2020 at 04:12:16PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > On 2020-06-30 11:35:34 [-0700], Paul E. McKenney wrote:
> > > > > > > This is not going to work together with the "wait context validator"
> > > > > > > (CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
> > > > > > > printk() which is why it is still disabled by default.
> > > > > > 
> > > > > > Fixing that should be "interesting".  In particular, RCU CPU stall
> > > > > > warnings rely on the raw spin lock to reduce false positives due
> > > > > > to race conditions.  Some thought will be required here.
> > > > > 
> > > > > I don't get this part. Can you explain/give me an example where to look
> > > > > at?
> > > > 
> > > > Starting from the scheduler-clock interrupt's call into RCU,
> > > > we have rcu_sched_clock_irq() which calls rcu_pending() which
> > > > calls check_cpu_stall() which calls either print_cpu_stall() or
> > > > print_other_cpu_stall(), depending on whether the stall is happening on
> > > > the current CPU or on some other CPU, respectively.
> > > > 
> > > > Both of these last functions acquire the rcu_node structure's raw ->lock
> > > > and expect to do printk()s while holding it.
> > > 
> > > …
> > > > Thoughts?
> > > 
> > > Okay. So in the RT queue there is a printk() rewrite which fixes this
> > > kind of things. Upstream the printk() interface is still broken in this
> > > regard and therefore CONFIG_PROVE_RAW_LOCK_NESTING is disabled.
> > > [Earlier the workqueue would also trigger a warning but this has been
> > > fixed as of v5.8-rc1.]
> > > This was just me explaining why this bad, what debug function would
> > > report it and why it is not enabled by default.
> > 
> > Whew!!!  ;-)
> > 
> > > > > > > So assume that this is fixed and enabled then on !PREEMPT_RT it will
> > > > > > > complain that you have a raw_spinlock_t acquired (the one from patch
> > > > > > > 02/17) and attempt to acquire a spinlock_t in the memory allocator.
> > > > > > 
> > > > > > Given that the slab allocator doesn't acquire any locks until it gets
> > > > > > a fair way in, wouldn't it make sense to allow a "shallow" allocation
> > > > > > while a raw spinlock is held?  This would require yet another GFP_ flag,
> > > > > > but that won't make all that much of a difference in the total.  ;-)
> > > > > 
> > > > > That would be one way of dealing with. But we could go back to
> > > > > spinlock_t and keep the memory allocation even for RT as is. I don't see
> > > > > a downside of this. And we would worry about kfree_rcu() from real
> > > > > IRQ-off region once we get to it.
> > > > 
> > > > Once we get to it, your thought would be to do per-CPU queuing of
> > > > memory from IRQ-off kfree_rcu(), and have IRQ work or some such clean
> > > > up after it?  Or did you have some other trick in mind?
> > > 
> > > So for now I would very much like to revert the raw_spinlock_t back to
> > > the spinlock_t and add a migrate_disable() just avoid the tiny
> > > possible migration between obtaining the CPU-ptr and acquiring the lock
> > > (I think Joel was afraid of performance hit).
> > 
> > Performance is indeed a concern here.
> > 
> > > Should we get to a *real* use case where someone must invoke kfree_rcu()
> > > from a hard-IRQ-off region then we can think what makes sense. per-CPU
> > > queues and IRQ-work would be one way of dealing with it.
> > 
> > It looks like workqueues can also be used, at least in their current
> > form.  And timers.
> > 
> > Vlad, Joel, thoughts?
> >
> Some high level thoughts:
> 
> Currently everything is done in workqueue context, it means all freeing
> happens there. For RT kernel we can invoke a page allocator only for single
> kfree_rcu() argument(though we skip it). As for double one, it is impossible,
> that is why a simple path is used by linking rcu_head among each other for
> further reclaim in wq context. As of now, for RT, everything is already
> deferred.
> 
> If we revert to spinlock_t then calling of kfree_rcu() from hard IRQ
> context is broken, even though we think that for RT kernel it will
> never happen. Therefore i do not see a clear motivation and benefits
> why we should revert to spinlock_t.
> 
> IMHO, if we can avoid of such drawback i would go with that way, i.e.
> i would not like to think what to do with that when it becomes broken.

I am also of Vlad's opinion. It seems to me that doing the migrate_disable()
before dropping the raw spinlock should suffice.

Note that in the future, we may have other users of this path such as
a potential kmem_cache_free_rcu(). It seems burdensome to make these all
callable only from sleepable-context.

Is there a drawback of doing migrate_disable before dropping the raw internal
lock, that I'm missing?

thanks,

 - Joel

