Return-Path: <SRS0=2gH0=EF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD03C4363A
	for <rcu@archiver.kernel.org>; Fri, 30 Oct 2020 13:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1C6221FA
	for <rcu@archiver.kernel.org>; Fri, 30 Oct 2020 13:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ORSYL4eY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0i2M4iAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgJ3N2j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Oct 2020 09:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgJ3N2j (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Oct 2020 09:28:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAC0C0613D4
        for <rcu@vger.kernel.org>; Fri, 30 Oct 2020 06:28:39 -0700 (PDT)
Date:   Fri, 30 Oct 2020 14:28:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604064517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XMJAwGRQLCC+fManA2Ok1eixy7GBI2SsP6s2z4eQ1hs=;
        b=ORSYL4eYpaXOSJW+xy6SrW7Ru7Xm9y6bTtH68lAw2vFT6wXkeoH1/WLRXvadxjYbguK1Iy
        kzda8sLNQvxQzvnaRuOjzZLLIVv89e97z///urnZ0bymfS8bbfNzIofkOh1sWoYNmQg0Ui
        Yc0uLcty8UBkH9ouIXUVIEgiR2IvDByqLA/CTc5NT4y2E6MP28ooGi2tlH0h87/vSnDkwR
        Aood8NQAUcLS7SA906knJAu7ImCMeZESO6VIIYA3LkTbj1mibLSJdJMYXbuO4WAE+0+v3g
        jK521BeEoft9P35NCjMPLTP9EiP4CCSYZFfTUGkyERKgzA03QQJmBMRvytuQ2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604064517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XMJAwGRQLCC+fManA2Ok1eixy7GBI2SsP6s2z4eQ1hs=;
        b=0i2M4iAI7zjuY0ghTET1bHaP2BQRj7Gd7bWmlZE+F9FcGzHUXi51FIcgykEX2GZuYpUOvH
        owPuR4xcNy6+uODA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RCU stall uses try_invoke_on_locked_down_task() with disabled
 interrupts
Message-ID: <20201030132835.plzgp5d6bv3rslr2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

|rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
|rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
|------------[ cut here ]------------
|WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:3009 try_invoke_on_locked_down_task+0x8a/0x120
|Modules linked in:
|CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.10.0-rc1+ #27
|Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1 04/01/2014
|EIP: try_invoke_on_locked_down_task+0x8a/0x120
|Call Trace:
| rcu_sched_clock_irq.cold+0x269/0x459
| update_process_times+0x44/0x80
| tick_sched_timer+0xe1/0x140
| __hrtimer_run_queues+0x216/0x560
| hrtimer_interrupt+0x115/0x260
| __sysvec_apic_timer_interrupt+0x88/0x2c0
| sysvec_apic_timer_interrupt+0x39/0x50
| handle_exception+0x10e/0x10e

rcu_sched_clock_irq.cold+0x269/0x459 is 
kernel/rcu/tree_stall.h:267 kernel/rcu/tree_stall.h:475 kernel/rcu/tree_stall.h:634 kernel/rcu/tree.c:3696 kernel/rcu/tree.c:2569

Sebastian
