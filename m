Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53DDC2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 19:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFE7221E8
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 19:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgDPTYE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgDPTYD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 15:24:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B943E20715;
        Thu, 16 Apr 2020 19:24:02 +0000 (UTC)
Date:   Thu, 16 Apr 2020 15:24:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416152400.3b2c6f91@gandalf.local.home>
In-Reply-To: <20200416185312.GC149999@google.com>
References: <20200416144254.GC90777@google.com>
        <20200416150038.GA7772@pc636>
        <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
        <20200416153844.GA8191@pc636>
        <20200416154647.ceotefna34pdxpfi@linutronix.de>
        <20200416160129.GA8337@pc636>
        <20200416161149.lkvkfwevanff36kb@linutronix.de>
        <20200416161819.GA8551@pc636>
        <20200416163302.3fsroillwk2om5dh@linutronix.de>
        <20200416144002.5ba92b4a@gandalf.local.home>
        <20200416185312.GC149999@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 16 Apr 2020 14:53:12 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> > static inline this_cpu_spin_lock_irqsave(struct spinlock __per_cpu *lock)
> > {
> > 	migrate_disable();
> > 	spin_lock_irqsave(this_cpu_ptr(lock));
> > 	migrate_enable();
> > }  
> 
> Here we want to grab the pointer of a per-CPU structure for the local CPU,
> and then grab its lock at the same time without getting migrated, so at least
> for this code the above API, it may not fit properly but perhaps for other
> code it may.

	this_cpu_spin_lock_irqsave(&krc.lock);
	krcp = this_cpu_ptr(&krc);

Note, spin_lock() disables migration, even on PREEMPT_RT.

-- Steve
