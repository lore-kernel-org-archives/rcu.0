Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D10C433EF
	for <rcu@archiver.kernel.org>; Mon,  7 Mar 2022 11:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbiCGLbE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbiCGLar (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Mar 2022 06:30:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80813275C5
        for <rcu@vger.kernel.org>; Mon,  7 Mar 2022 03:17:58 -0800 (PST)
Date:   Mon, 7 Mar 2022 12:17:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646651877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PNInT6y7dTowlGKNppkhWSIEDGN3TyFFLyPDTDy5Xws=;
        b=Wi8LRymife/u0AnDhPLR0o5/gzcmSvQgwKaTPvygy8zUJTbieHV495iTy/Q0/PzmP7OEW5
        zvJf94jMoTFxE6KI0zbBza0eakc0pYzLuoYf37mgjkx1E8IlPFfuy9kbcG+vk3xUeidCfh
        6Zp6bLd3RAGNygmiSMJGcCrom9uPs1zr4JndEFKp3XptniuLR1f2oWbFhHCkKcRlUVVhnD
        dDXpAaol7xElbxCvbfR2ZWUpVtEUEQ2iUKI42sV6+f1oYnJ3dhpAHSxnZJ6k3tm0IJtmpT
        2FIg5q6q9WqAcG2VFgzESoioWF5Mju7EVapRlf0Layfu1zDmA9emzKPtN/yyWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646651877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PNInT6y7dTowlGKNppkhWSIEDGN3TyFFLyPDTDy5Xws=;
        b=p42vRa2HNnMUVwI/SpodEbEmWsrN7aKBU9wIanEM786NL1O3O1vUfteUotUkSyBmpke/a4
        Rp8qIXh3RizSVfBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu-tasks: Use rcuwait for the rcu_tasks_kthread().
Message-ID: <YiXp4+2atG0Ni2rJ@linutronix.de>
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <YiHy7Y5fTU3jRdMi@linutronix.de>
 <20220305044007.GV4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220305044007.GV4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2022-03-04 20:40:07 [-0800], Paul E. McKenney wrote:
> > This is what I had in mind. Does this work for you?
> 
> This does seem to be working, thank you!  I even manually inserted
> a pi_lock() acquisition across one of the calls to call_rcu_tasks(),
> and it did seem to work.

perfect.

> >  kernel/rcu/tasks.h | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index d64f0b1d8cd3b..f804afb304135 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -113,11 +113,11 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
> >  #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
> >  static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
> >  	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
> > -	.rtp_irq_work = IRQ_WORK_INIT(call_rcu_tasks_iw_wakeup),			\
> > +	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),			\
> 
> This is the key piece, right? 

Correct. Possible due to the removal of wait_queue_head (plus there is
nothing else that would stand in the way otherwise).

> If so, I am wondering if there are other
> irq_work instances that need to move to _HARD.

We already have:
kernel/rcu/tree.c:      rdp->rcu_iw = IRQ_WORK_INIT_HARD(rcu_iw_handler);

;)

> 							Thanx, Paul

Sebastian
