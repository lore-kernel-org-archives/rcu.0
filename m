Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C37C07E96
	for <rcu@archiver.kernel.org>; Thu, 15 Jul 2021 13:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDDFD613C4
	for <rcu@archiver.kernel.org>; Thu, 15 Jul 2021 13:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhGONff (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232113AbhGONff (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Jul 2021 09:35:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C152613C3;
        Thu, 15 Jul 2021 13:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626355962;
        bh=0/bB+AOFBoHuvGu4BNLp/b32//0AS6DhMAkFlQyyyTE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ONUsoHkDT05z3VuKLkvHPCtvcJ2SXmhykk6vi1/0sSCVrN7Gahc+2rZ06vpxomSlt
         4UaMeSTPeNyIWDvU7RP/lb0eIgLMGurLWUlOcIJ0pIYljbbCcXXzXeGwSO9N4J3hWl
         WB0vGjKN8cdtGVhjAT7PveWN2GIpe9vUhVcU0Oy/8BpCxi8+UlQFNeakrMUpJ2/bJ4
         /FlXr6nKHlMkgPTCsW9eJOfrBcIY4tenjCYXTgjKlsumJR7KOXGR3nuB/OWSjEb+wc
         j1bBQNOu5TSecnIr29NeOIkSVqDxYrFLd11/MZLdnCks1I9mTtXnDkOozGC8XJ9O8b
         wqqyMPr+SyZrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BE9F45C03A0; Thu, 15 Jul 2021 06:32:41 -0700 (PDT)
Date:   Thu, 15 Jul 2021 06:32:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] rcu/tree: handle VM stoppage in stall detection
Message-ID: <20210715133241.GJ4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210521155624.174524-1-senozhatsky@chromium.org>
 <YO/7WS/WefdkFFbj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO/7WS/WefdkFFbj@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 15, 2021 at 06:09:45PM +0900, Sergey Senozhatsky wrote:
> On (21/05/22 00:56), Sergey Senozhatsky wrote:
> > Soft watchdog timer function checks if a virtual machine
> > was suspended and hence what looks like a lockup in fact
> > is a false positive.
> > 
> > This is what kvm_check_and_clear_guest_paused() does: it
> > tests guest PVCLOCK_GUEST_STOPPED (which is set by the host)
> > and if it's set then we need to touch all watchdogs and bail
> > out.
> > 
> > Watchdog timer function runs from IRQ, so PVCLOCK_GUEST_STOPPED
> > check works fine.
> > 
> > There is, however, one more watchdog that runs from IRQ, so
> > watchdog timer fn races with it, and that watchdog is not aware
> > of PVCLOCK_GUEST_STOPPED - RCU stall detector.
> > 
> > apic_timer_interrupt()
> >  smp_apic_timer_interrupt()
> >   hrtimer_interrupt()
> >    __hrtimer_run_queues()
> >     tick_sched_timer()
> >      tick_sched_handle()
> >       update_process_times()
> >        rcu_sched_clock_irq()
> > 
> > This triggers RCU stalls on our devices during VM resume.
> > 
> > If tick_sched_handle()->rcu_sched_clock_irq() runs on a VCPU
> > before watchdog_timer_fn()->kvm_check_and_clear_guest_paused()
> > then there is nothing on this VCPU that touches watchdogs and
> > RCU reads stale gp stall timestamp and new jiffies value, which
> > makes it think that RCU has stalled.
> > 
> > Make RCU stall watchdog aware of PVCLOCK_GUEST_STOPPED and
> > don't report RCU stalls when we resume the VM.
> 
> Hello Paul,
> 
> I've noticed that this patch set didn't make it to Linus's tree.
> Was it intentional?

This patch (and the 18 preceding it) didn't make the cutoff for the
just-past merge window.  If this patch is urgent, please let me know
and I can push it, with luck by the end of next week.

If that one is urgent, are these two also?

817690fd18af ("rcu: Do not disable GP stall detection in rcu_cpu_stall_reset()")
9ed9bf0d17cd ("rcu: Start timing stall repetitions after warning complete")

If so, it is better to handle them as a group than separately.

The cutoff for a given merge window is normally shortly after the close
of the previous merge window.  This time, I am a bit slow creating
branches, but the cutoff for the v5.15 merge window should be by the
end of the week.  This is a bit more lag than most subsystems, but
this is after all RCU.

As always, if a given commit is urgent, please let me know and I
will see what I can do to fast-track it.

For reference:

https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html

Again, if this one needs to hit mainline before the v5.15 merge
window, please let me know.

							Thanx, Paul
