Return-Path: <SRS0=B8+c=75=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7059DC433DF
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 08:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7DC20767
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 08:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgFPIk0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgFPIkZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Jun 2020 04:40:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19CAC05BD43;
        Tue, 16 Jun 2020 01:40:25 -0700 (PDT)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jl78X-0008Hw-0e; Tue, 16 Jun 2020 10:40:05 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8A2C010154B; Tue, 16 Jun 2020 10:40:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH x86/entry: Force rcu_irq_enter() when in idle task
In-Reply-To: <20200615201647.GC12037@google.com>
References: <20200611235305.GA32342@paulmck-ThinkPad-P72> <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com> <871rmkzcc8.fsf@nanos.tec.linutronix.de> <87wo4cxubv.fsf@nanos.tec.linutronix.de> <20200615201647.GC12037@google.com>
Date:   Tue, 16 Jun 2020 10:40:04 +0200
Message-ID: <871rmfcskb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Joel,

Joel Fernandes <joel@joelfernandes.org> writes:
> On Fri, Jun 12, 2020 at 03:55:00PM +0200, Thomas Gleixner wrote:
>> This is also correct vs. user mode entries in NOHZ full scenarios because
>> user mode entries bring RCU out of EQS and force the RCU irq nesting state
>
> I had to re-read this sentence a couple of times. The 'user mode entries'
> sounds like 'entry into user mode'. It would be good to reword it to 'IRQ
> entry in user mode'.

:)

> My knowledge predates the rcu-watching reworks so apologies on the below
> question but I still didn't fully follow why when the idle task behaves
> differently from being in user mode. Even with user mode we should have:
>
> <user mode>  (in EQS)
>   <irq entry>   <---------- exits EQS so now rcu is watching
>      <softirq entry in the exit path>
>         <timer tick irq entry>  <-- the buggy !watching logic prevents rcu_irq_enter
> 	    -> report QS since tick thinks it is first level.
>
> Is there a subtlety here I'm missing? I checked the RCU code and I did not
> see anywhere that rcu_user_enter() makes it behave differently. Both
> rcu_user_enter() and rcu_idle_enter() call rcu_eqs_enter().

The interrupt hit user mode entry does:

    idtentry_enter_cond_rcu()
      if (user_mode(regs))
         enter_from_user_mode()
           user_exit_irqoff()
             __context_tracking_exit(CONTEXT_USER)
               rcu_user_exit()
                 rcu_eqs_exit(1)
                   ...
                   WRITE_ONCE(rdp->dynticks_nmi_nesting,
                              DYNTICK_IRQ_NONIDLE);

i.e. for interrupts which enter from user mode we are not invoking
rcu_irq_enter() at all.

The return from interrupt path has nothing to do with that because
that's an entry in kernel mode.

Thanks,

        tglx


