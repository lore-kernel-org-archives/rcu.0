Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56652C56201
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 15:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15D920870
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 15:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xnLGfNCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbgKXPBs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Nov 2020 10:01:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389251AbgKXPBs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Nov 2020 10:01:48 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC3720757;
        Tue, 24 Nov 2020 15:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606230106;
        bh=bH2T7v50DRutwczCCuu1eYOi4eEyg3wYXGSRKTnLo6c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xnLGfNCOA96W2Rj7WNOmHpr9vgF1ItKA3vsgCH+/gXIKfdeZ/HQJ/smX/QPHY+3/O
         nA98XoNR+ZR2iI5OwO7hnWddyzyViDCSZD7XVRxAc2Lnw1+07AELtRZIllxOytrPij
         fB6q2fyOFJKE8UO3lukLJIIC4OGGt5ike0Etn37Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3A5293520FE6; Tue, 24 Nov 2020 07:01:46 -0800 (PST)
Date:   Tue, 24 Nov 2020 07:01:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-arm-kernel@lists.infradead.org, boqun.feng@gmail.com,
        tglx@linutronix.de
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201124150146.GH1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
 <20201119213512.GB1437@paulmck-ThinkPad-P72>
 <20201119225352.GA5251@willie-the-truck>
 <20201120103031.GB2328@C02TD0UTHF1T.local>
 <20201120140332.GA3120165@elver.google.com>
 <20201123193241.GA45639@C02TD0UTHF1T.local>
 <20201124140310.GA811510@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201124140310.GA811510@elver.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 24, 2020 at 03:03:10PM +0100, Marco Elver wrote:
> On Mon, Nov 23, 2020 at 07:32PM +0000, Mark Rutland wrote:
> > On Fri, Nov 20, 2020 at 03:03:32PM +0100, Marco Elver wrote:
> > > On Fri, Nov 20, 2020 at 10:30AM +0000, Mark Rutland wrote:
> > > > On Thu, Nov 19, 2020 at 10:53:53PM +0000, Will Deacon wrote:
> > > > > FWIW, arm64 is known broken wrt lockdep and irq tracing atm. Mark has been
> > > > > looking at that and I think he is close to having something workable.
> > > > > 
> > > > > Mark -- is there anything Marco and Paul can try out?
> > > > 
> > > > I initially traced some issues back to commit:
> > > > 
> > > >   044d0d6de9f50192 ("lockdep: Only trace IRQ edges")
> > > > 
> > > > ... and that change of semantic could cause us to miss edges in some
> > > > cases, but IIUC mostly where we haven't done the right thing in
> > > > exception entry/return.
> > > > 
> > > > I don't think my patches address this case yet, but my WIP (currently
> > > > just fixing user<->kernel transitions) is at:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/irq-fixes
> > > > 
> > > > I'm looking into the kernel<->kernel transitions now, and I know that we
> > > > mess up RCU management for a small window around arch_cpu_idle, but it's
> > > > not immediately clear to me if either of those cases could cause this
> > > > report.
> > > 
> > > Thank you -- I tried your irq-fixes, however that didn't seem to fix the
> > > problem (still get warnings and then a panic). :-/
> > 
> > I've just updated that branch with a new version which I hope covers
> > kernel<->kernel transitions too. If you get a chance, would you mind
> > giving that a spin?
> > 
> > The HEAD commit should be:
> > 
> >   a51334f033f8ee88 ("HACK: check IRQ tracing has RCU watching")
> 
> Thank you! Your series appears to work and fixes the stalls and
> deadlocks (3 trials)! I noticed there are a bunch of warnings in the log
> that might be relevant (see attached).
> 
> Note, I also reverted
> 
>   sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled
> 
> and that still works.

This is expected behavior given that there were no RCU CPU stall
warnings.  As to the warnings...

[ . . . ]

> [   91.184432] =============================
> [   91.188301] WARNING: suspicious RCU usage
> [   91.192316] 5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25 Tainted: G        W        
> [   91.197536] -----------------------------
> [   91.201431] kernel/trace/trace_preemptirq.c:78 RCU not watching trace_hardirqs_off()!
> [   91.206546] 
> [   91.206546] other info that might help us debug this:
> [   91.206546] 
> [   91.211790] 
> [   91.211790] rcu_scheduler_active = 2, debug_locks = 0
> [   91.216454] RCU used illegally from extended quiescent state!
> [   91.220890] no locks held by swapper/0/0.
> [   91.224712] 
> [   91.224712] stack backtrace:
> [   91.228794] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25
> [   91.234877] Hardware name: linux,dummy-virt (DT)
> [   91.239032] Call trace:
> [   91.242587]  dump_backtrace+0x0/0x240
> [   91.246500]  show_stack+0x34/0x88
> [   91.250295]  dump_stack+0x140/0x1bc
> [   91.254159]  lockdep_rcu_suspicious+0xe4/0xf8
> [   91.258332]  trace_hardirqs_off+0x214/0x330
> [   91.262462]  trace_graph_return+0x1ac/0x1d8
> [   91.266564]  ftrace_return_to_handler+0xa4/0x170
> [   91.270809]  return_to_handler+0x1c/0x38
> [   91.274826]  default_idle_call+0x94/0x38c
> [   91.278869]  do_idle+0x240/0x290
> [   91.282633]  rest_init+0x1e8/0x2dc
> [   91.286529]  arch_call_rest_init+0x1c/0x28
> [   91.290585]  start_kernel+0x638/0x670
> [   91.295524] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5279 check_flags.part.0+0x1d4/0x1f8
> [   91.296302] Modules linked in:
> [   91.297644] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25
> [   91.298317] Hardware name: linux,dummy-virt (DT)
> [   91.298975] pstate: 80000085 (Nzcv daIf -PAN -UAO -TCO BTYPE=--)
> [   91.299648] pc : check_flags.part.0+0x1d4/0x1f8
> [   91.300303] lr : check_flags.part.0+0x1d4/0x1f8
> [   91.300960] sp : ffffdb60f8d73a50
> [   91.301628] x29: ffffdb60f8d73a50 x28: ffffdb60f8d84000 
> [   91.303527] x27: ffffdb60f869cbb8 x26: ffffdb60f6835930 
> [   91.305431] x25: 0000000000000000 x24: 0000000000000000 
> [   91.307343] x23: ffffdb60f8daf360 x22: 0000000000000001 
> [   91.309242] x21: 0000000000000000 x20: 0000000000000001 
> [   91.311145] x19: ffffdb60f9bcf000 x18: 00000000749f6e65 
> [   91.313044] x17: 00000000dcd3f761 x16: 0000000000000005 
> [   91.314954] x15: 0000000000000000 x14: 0000000000000028 
> [   91.316854] x13: 000000000000067a x12: 0000000000000028 
> [   91.318753] x11: 0101010101010101 x10: ffffdb60f8d73820 
> [   91.320657] x9 : ffffdb60f6960ff8 x8 : 4e5241575f534b43 
> [   91.322582] x7 : 4f4c5f4755424544 x6 : ffff4454fdbd3667 
> [   91.324486] x5 : 00000000ffffffc8 x4 : ffff4454fdbd2c60 
> [   91.326413] x3 : ffffdb60f6800000 x2 : ffffdb60f7c60000 
> [   91.328308] x1 : 1c0af7741e0f0c00 x0 : 0000000000000000 
> [   91.330227] Call trace:
> [   91.330880]  check_flags.part.0+0x1d4/0x1f8
> [   91.331547]  lock_acquire+0x208/0x508
> [   91.332200]  _raw_spin_lock+0x5c/0x80
> [   91.332849]  vprintk_emit+0xb4/0x380
> [   91.333528]  vprintk_default+0x4c/0x60
> [   91.334189]  vprintk_func+0x120/0x330
> [   91.334863]  printk+0x78/0x9c
> [   91.335523]  lockdep_rcu_suspicious+0x2c/0xf8
> [   91.336195]  trace_hardirqs_off+0x214/0x330
> [   91.336854]  trace_graph_return+0x1ac/0x1d8
> [   91.337518]  ftrace_return_to_handler+0xa4/0x170
> [   91.338190]  return_to_handler+0x1c/0x38

This looks like tracing in the idle loop in a place where RCU is not
watching.  Historically, this has been addressed by using _rcuidle()
trace events, but the portion of the idle loop that RCU is watching has
recently increased.  Last I checked, there were still a few holdouts (that
would splat like this) in x86, though perhaps those have since been fixed.

> [   91.338841]  default_idle_call+0x94/0x38c
> [   91.339512]  do_idle+0x240/0x290
> [   91.340166]  rest_init+0x1e8/0x2dc
> [   91.340840]  arch_call_rest_init+0x1c/0x28
> [   91.341499]  start_kernel+0x638/0x670
> [   91.342147] irq event stamp: 1727
> [   91.342832] hardirqs last  enabled at (1727): [<ffffdb60f7c33094>] exit_el1_irq_or_nmi+0x24/0x50
> [   91.343502] hardirqs last disabled at (1724): [<ffffdb60f7c33060>] enter_el1_irq_or_nmi+0x20/0x30
> [   91.344193] softirqs last  enabled at (1726): [<ffffdb60f6835930>] return_to_handler+0x0/0x38
> [   91.344866] softirqs last disabled at (1725): [<ffffdb60f68c6880>] irq_enter_rcu+0x88/0xa8
> [   91.345546] ---[ end trace e131d25144579308 ]---

The other warning looked similar.

							Thanx, Paul
