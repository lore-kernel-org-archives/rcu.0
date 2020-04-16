Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A70C3815B
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC1820786
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgDPSkG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729785AbgDPSkF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 14:40:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F317206E9;
        Thu, 16 Apr 2020 18:40:04 +0000 (UTC)
Date:   Thu, 16 Apr 2020 14:40:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416144002.5ba92b4a@gandalf.local.home>
In-Reply-To: <20200416163302.3fsroillwk2om5dh@linutronix.de>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
        <20200416144254.GC90777@google.com>
        <20200416150038.GA7772@pc636>
        <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
        <20200416153844.GA8191@pc636>
        <20200416154647.ceotefna34pdxpfi@linutronix.de>
        <20200416160129.GA8337@pc636>
        <20200416161149.lkvkfwevanff36kb@linutronix.de>
        <20200416161819.GA8551@pc636>
        <20200416163302.3fsroillwk2om5dh@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 16 Apr 2020 18:33:02 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > > > You mean that in CONFIG_PREEMPT_RT:
> > > > 
> > > > <snip>
> > > >  local_irq_save(flags);
> > > >  krcp = this_cpu_ptr(&krc);
> > > >  spin_lock(&krcp->lock);
> > > > <snip>
> > > > 
> > > > it will not be preempted, what does not follow PREEMPT_RT policy. Is that correct?  
> > > 
> > > No. local_irq_save() disables interrupts and spin_lock() acquires a
> > > sleeping lock which may schedule() if contended. The documentation has
> > > this piece:
> > >  
> > Ah. Got it. Then it is a problem, agree. Do you have something
> > that would guarantee of being staying on the same CPU?
> > migration_disable()?  
> 
> migrate_disable() would work.

I wonder if we should have a this_cpu_spin_lock_irqsave(), that would
encapsulate the migrate_disable()?

static inline this_cpu_spin_lock_irqsave(struct spinlock __per_cpu *lock)
{
	migrate_disable();
	spin_lock_irqsave(this_cpu_ptr(lock));
	migrate_enable();
}


?

-- Steve
