Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E20C2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 16:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3312223E
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 16:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391803AbgDPQLy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394918AbgDPQLx (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 12:11:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35228C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 09:11:53 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jP77F-0001I0-9P; Thu, 16 Apr 2020 18:11:49 +0200
Date:   Thu, 16 Apr 2020 18:11:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416161149.lkvkfwevanff36kb@linutronix.de>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416150038.GA7772@pc636>
 <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
 <20200416153844.GA8191@pc636>
 <20200416154647.ceotefna34pdxpfi@linutronix.de>
 <20200416160129.GA8337@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416160129.GA8337@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-04-16 18:01:29 [+0200], Uladzislau Rezki wrote:
> > As written in my previous email to Joel (who somehow fell of the Cc
> > list in this part of the thread):
> > |local_irq_save() + spin_lock() is the problem, see
> > |    https://www.kernel.org/doc/html/latest/locking/locktypes.html#spinlock-t-and-rwlock-t
> > 
> You mean that in CONFIG_PREEMPT_RT:
> 
> <snip>
>  local_irq_save(flags);
>  krcp = this_cpu_ptr(&krc);
>  spin_lock(&krcp->lock);
> <snip>
> 
> it will not be preempted, what does not follow PREEMPT_RT policy. Is that correct?

No. local_irq_save() disables interrupts and spin_lock() acquires a
sleeping lock which may schedule() if contended. The documentation has
this piece:
|On PREEMPT_RT kernel this code sequence breaks because RT-mutex
|requires a fully preemptible context. Instead, use spin_lock_irq() or
|spin_lock_irqsave() and their unlock counterparts.

Sebastian
