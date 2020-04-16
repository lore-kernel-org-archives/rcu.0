Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8E9C2BA2B
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86FD220786
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgDPVFD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgDPVFD (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 17:05:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE461C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 14:05:02 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jPBgy-0006aU-QH; Thu, 16 Apr 2020 23:05:00 +0200
Date:   Thu, 16 Apr 2020 23:05:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416210500.2gai6zkkfcuc7w5a@linutronix.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416144002.5ba92b4a@gandalf.local.home>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-04-16 14:40:02 [-0400], Steven Rostedt wrote:
> 
> I wonder if we should have a this_cpu_spin_lock_irqsave(), that would
> encapsulate the migrate_disable()?
> 
> static inline this_cpu_spin_lock_irqsave(struct spinlock __per_cpu *lock)
> {
> 	migrate_disable();
> 	spin_lock_irqsave(this_cpu_ptr(lock));
> 	migrate_enable();
> }
> 

I would postpone it until we have more potential users. If Uladzislau
wouldn't insist on avoidin a potential migration spot we wouldn't have
this conversation. Most code, as I remember it, is using locks so they
can access the data structure cross-CPU so the possible migration
doesn't matter much.
I would like to avoid the local-lock like zoo where we have/had a lot of
locking based function with two users or so.

> 
> ?
> 
> -- Steve

Sebastian
