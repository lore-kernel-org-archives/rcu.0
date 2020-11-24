Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E38DC56202
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 19:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06B620857
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 19:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgKXTan (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Nov 2020 14:30:43 -0500
Received: from foss.arm.com ([217.140.110.172]:50640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgKXTam (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Nov 2020 14:30:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06E501396;
        Tue, 24 Nov 2020 11:30:41 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.26.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2B6E3F70D;
        Tue, 24 Nov 2020 11:30:36 -0800 (PST)
Date:   Tue, 24 Nov 2020 19:30:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20201124193034.GB8957@C02TD0UTHF1T.local>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124140310.GA811510@elver.google.com>
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
> deadlocks (3 trials)! 

Thanks for testing! I'm glad that appears to work, as it suggests
there's not another massive problem lurking in this area.

While cleaning/splitting that up today, I spotted a couple of new
problems I introduced, and I'm part-way through sorting that out, but
it's not quite ready today after all. :/

Fingers crossed for tomorrow...

> I noticed there are a bunch of warnings in the log
> that might be relevant (see attached).

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

Hmm... I suspect that arch_cpu_idle() is being traced here, and I reckon
we have to mark that and its callees as noinstr, since it doesn't seem
sane to have ftrace check whether RCU is watching for every function
call. Maybe Paul or Steve can correct me. ;)

If you still have the binary lying around, can you check whether
default_idle_call+0x94/0x38c is just after the call to arch_cpu_idle()?
If you could dump the asm around that, along with whatever faddr2line
tells you, that'd be a great help. 

This looks like it should be reproducible, so I'll enable the boot-time
self tests in my kernel and check whether I see the above too.

Thanks,
Mark.
