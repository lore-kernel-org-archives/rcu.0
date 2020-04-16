Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD566C352BE
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FF1214AF
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 15:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896930AbgDPPqy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896922AbgDPPqw (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 11:46:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CE1C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 08:46:52 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jP6j1-0008WL-Kd; Thu, 16 Apr 2020 17:46:49 +0200
Date:   Thu, 16 Apr 2020 17:46:47 +0200
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
Message-ID: <20200416154647.ceotefna34pdxpfi@linutronix.de>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416150038.GA7772@pc636>
 <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
 <20200416153844.GA8191@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416153844.GA8191@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-04-16 17:38:44 [+0200], Uladzislau Rezki wrote:
> > What is the worst thing that can happen if a CPU migration happens
> > between raw_cpu_ptr() and spin_lock_irqsave() ?
> > 
> You will just introduce higher rate of lock contention what we would
> like to get rid of. 

The possibility of the migration is minimal. So it is not _always_
happening.

>                     Could you please explain what is broken when you
> do like:
> 
> <snip>
> local_irq_save(flags);
> krcp = this_cpu_ptr(&krc);
> spin_lock(&krcp->lock);
> <snip>

As written in my previous email to Joel (who somehow fell of the Cc
list in this part of the thread):
|local_irq_save() + spin_lock() is the problem, see
|    https://www.kernel.org/doc/html/latest/locking/locktypes.html#spinlock-t-and-rwlock-t

Sebastian
