Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8326AC2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 15:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E67206D9
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 15:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgDPPSc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504349AbgDPPS3 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 11:18:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2855C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 08:18:28 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jP6HY-00072e-9i; Thu, 16 Apr 2020 17:18:24 +0200
Date:   Thu, 16 Apr 2020 17:18:24 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416151824.a372pdiphube3x3l@linutronix.de>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416144254.GC90777@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-04-16 10:42:54 [-0400], Joel Fernandes wrote:
> Hi Sebastian,
Hi Joel,

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
> I agree with the patch, except for this bit. Would it be ok to split the
> other parts of this patch into separate patch(es)?

if you want, I could split it. Part of the goal is to get rid of the
local_irq_save(). I don't mind if it happens a patch later :)

> For this part of the patch, I am wondering what is the value in it. For one,

local_irq_save() + spin_lock() is the problem, see
    https://www.kernel.org/doc/html/latest/locking/locktypes.html#spinlock-t-and-rwlock-t

(the link-instead-explaining part is nice)

> we don't want migration between sampling the value of the pointer, and
> actually using it. One reason at least is because we have certain resources
> in the per-cpu structure that take advantage of cache locality (such as the
> kfree_rcu_cpu::krw_arr array). In the common case, the callback would be
> executed on the same CPU it is queued on. All of the access is local to the
> CPU.

In the common case, yes.

> I know the work item can still be handled on other CPUs so we are not
> strictly doing it in the worst case (however per my understanding, the work
> item is executed in the same CPU most of the time).

The worker is migrated if the CPU goes offline for instance.

> Also on a slightly related note, could you share with me why this_cpu_ptr()
> is unsafe to call in non-preemptible context, but raw_cpu_ptr() is ok? Just
> curious on that.

I wouldn't use safe/unsafe as a term to describe the situation. Both do
the same however this_cpu_ptr() raises a warning (given it is enabled)
if the current context can migrate to another CPU
(check_preemption_disabled()).
If you know what you do and it does not matter whether migration happens
or not, you can use raw_cpu_ptr() to avoid the warning. In this case it
is okay because CPU migration does not matter here since the data
structure is protected with a lock. Using the data structure from
another CPU (due to accidental migration) is not ideal but _no_
assumption happens later on for dealing with the current or further
data. The timer/worker will be scheduled on the "wrong" CPU but this
again has no bad consequences. The timer and worker use container_of()
so they operate on the correct resources. Would they instead use
per_cpu_ptr(krc, smp_processor_id()) then it would operate on the wrong
data.

Regarding the safe/unsafe: Would this_cpu_ptr() trigger a warning and
you add preempt_disable() around the block, where you use the per-CPU
data, then you would silence the warning and everything would look fine.
If this per-CPU data structure would also be accessed from interrupt
context then you would get inconsistent data and no warning.
What I'm trying to say is that even this_cpu_ptr() is not "safe" if used
without a thought.

> thanks,
> 
>  - Joel

Sebastian
