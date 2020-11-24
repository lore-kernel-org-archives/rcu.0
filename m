Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC8CC63777
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 19:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5245F208CA
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 19:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgKXTnR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Nov 2020 14:43:17 -0500
Received: from foss.arm.com ([217.140.110.172]:51230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgKXTnQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Nov 2020 14:43:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D2441396;
        Tue, 24 Nov 2020 11:43:15 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.26.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2D9D3F718;
        Tue, 24 Nov 2020 11:43:11 -0800 (PST)
Date:   Tue, 24 Nov 2020 19:43:08 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
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
Message-ID: <20201124194308.GC8957@C02TD0UTHF1T.local>
References: <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
 <20201119213512.GB1437@paulmck-ThinkPad-P72>
 <20201119225352.GA5251@willie-the-truck>
 <20201120103031.GB2328@C02TD0UTHF1T.local>
 <20201120140332.GA3120165@elver.google.com>
 <20201123193241.GA45639@C02TD0UTHF1T.local>
 <20201124140310.GA811510@elver.google.com>
 <20201124150146.GH1437@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124150146.GH1437@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 24, 2020 at 07:01:46AM -0800, Paul E. McKenney wrote:
> On Tue, Nov 24, 2020 at 03:03:10PM +0100, Marco Elver wrote:
> > [   91.184432] =============================
> > [   91.188301] WARNING: suspicious RCU usage
> > [   91.192316] 5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25 Tainted: G        W        
> > [   91.197536] -----------------------------
> > [   91.201431] kernel/trace/trace_preemptirq.c:78 RCU not watching trace_hardirqs_off()!
> > [   91.206546] 
> > [   91.206546] other info that might help us debug this:
> > [   91.206546] 
> > [   91.211790] 
> > [   91.211790] rcu_scheduler_active = 2, debug_locks = 0
> > [   91.216454] RCU used illegally from extended quiescent state!
> > [   91.220890] no locks held by swapper/0/0.
> > [   91.224712] 
> > [   91.224712] stack backtrace:
> > [   91.228794] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25
> > [   91.234877] Hardware name: linux,dummy-virt (DT)
> > [   91.239032] Call trace:
> > [   91.242587]  dump_backtrace+0x0/0x240
> > [   91.246500]  show_stack+0x34/0x88
> > [   91.250295]  dump_stack+0x140/0x1bc
> > [   91.254159]  lockdep_rcu_suspicious+0xe4/0xf8
> > [   91.258332]  trace_hardirqs_off+0x214/0x330
> > [   91.262462]  trace_graph_return+0x1ac/0x1d8
> > [   91.266564]  ftrace_return_to_handler+0xa4/0x170
> > [   91.270809]  return_to_handler+0x1c/0x38
> > [   91.274826]  default_idle_call+0x94/0x38c
> > [   91.278869]  do_idle+0x240/0x290
> > [   91.282633]  rest_init+0x1e8/0x2dc
> > [   91.286529]  arch_call_rest_init+0x1c/0x28
> > [   91.290585]  start_kernel+0x638/0x670

> This looks like tracing in the idle loop in a place where RCU is not
> watching.  Historically, this has been addressed by using _rcuidle()
> trace events, but the portion of the idle loop that RCU is watching has
> recently increased.  Last I checked, there were still a few holdouts (that
> would splat like this) in x86, though perhaps those have since been fixed.

Yup! I think this is a latent issue my debug hacks revealed (in addition
to a couple of other issues in the idle path), and still affects x86 and
others. It's only noticeable if you hack trace_hardirqs_{on,off}() to
check rcu_is_watching(), which I had at the tip of my tree.

AFAICT, the issue is that arch_cpu_idle() can be dynamically traced with
ftrace, and hence the tracing code can unexpectedly run without RCU
watching. Since that's dynamic tracing, we can avoid it by marking
arch_cpu_idle() and friends as noinstr.

I'll see about getting this fixed before we upstream the debug hack.

Thanks,
Mark.
