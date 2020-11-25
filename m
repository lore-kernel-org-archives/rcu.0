Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE09C56202
	for <rcu@archiver.kernel.org>; Wed, 25 Nov 2020 10:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65812206E0
	for <rcu@archiver.kernel.org>; Wed, 25 Nov 2020 10:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgKYK3E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Nov 2020 05:29:04 -0500
Received: from foss.arm.com ([217.140.110.172]:38578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgKYK3D (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Nov 2020 05:29:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AE40106F;
        Wed, 25 Nov 2020 02:29:02 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDFA93F70D;
        Wed, 25 Nov 2020 02:28:59 -0800 (PST)
Date:   Wed, 25 Nov 2020 10:28:49 +0000
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
Message-ID: <20201125102849.GB70906@C02TD0UTHF1T.local>
References: <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
 <20201119213512.GB1437@paulmck-ThinkPad-P72>
 <20201119225352.GA5251@willie-the-truck>
 <20201120103031.GB2328@C02TD0UTHF1T.local>
 <20201120140332.GA3120165@elver.google.com>
 <20201123193241.GA45639@C02TD0UTHF1T.local>
 <20201124140310.GA811510@elver.google.com>
 <20201124193034.GB8957@C02TD0UTHF1T.local>
 <20201125094517.GA1359135@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125094517.GA1359135@elver.google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 25, 2020 at 10:45:17AM +0100, Marco Elver wrote:
> On Tue, Nov 24, 2020 at 07:30PM +0000, Mark Rutland wrote:

[...]

> > > I noticed there are a bunch of warnings in the log
> > > that might be relevant (see attached).
> > 
> > > [   91.184432] =============================
> > > [   91.188301] WARNING: suspicious RCU usage
> > > [   91.192316] 5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25 Tainted: G        W        
> > > [   91.197536] -----------------------------
> > > [   91.201431] kernel/trace/trace_preemptirq.c:78 RCU not watching trace_hardirqs_off()!
> > > [   91.206546] 
> > > [   91.206546] other info that might help us debug this:
> > > [   91.206546] 
> > > [   91.211790] 
> > > [   91.211790] rcu_scheduler_active = 2, debug_locks = 0
> > > [   91.216454] RCU used illegally from extended quiescent state!
> > > [   91.220890] no locks held by swapper/0/0.
> > > [   91.224712] 
> > > [   91.224712] stack backtrace:
> > > [   91.228794] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25
> > > [   91.234877] Hardware name: linux,dummy-virt (DT)
> > > [   91.239032] Call trace:
> > > [   91.242587]  dump_backtrace+0x0/0x240
> > > [   91.246500]  show_stack+0x34/0x88
> > > [   91.250295]  dump_stack+0x140/0x1bc
> > > [   91.254159]  lockdep_rcu_suspicious+0xe4/0xf8
> > > [   91.258332]  trace_hardirqs_off+0x214/0x330
> > > [   91.262462]  trace_graph_return+0x1ac/0x1d8
> > > [   91.266564]  ftrace_return_to_handler+0xa4/0x170
> > > [   91.270809]  return_to_handler+0x1c/0x38
> > > [   91.274826]  default_idle_call+0x94/0x38c
> > > [   91.278869]  do_idle+0x240/0x290
> > > [   91.282633]  rest_init+0x1e8/0x2dc
> > > [   91.286529]  arch_call_rest_init+0x1c/0x28
> > > [   91.290585]  start_kernel+0x638/0x670
> > 
> > Hmm... I suspect that arch_cpu_idle() is being traced here, and I reckon
> > we have to mark that and its callees as noinstr, since it doesn't seem
> > sane to have ftrace check whether RCU is watching for every function
> > call. Maybe Paul or Steve can correct me. ;)
> 
> Yes, it's arch_cpu_idle().
> 
> > If you still have the binary lying around, can you check whether
> > default_idle_call+0x94/0x38c is just after the call to arch_cpu_idle()?
> > If you could dump the asm around that, along with whatever faddr2line
> > tells you, that'd be a great help. 
> 
> I reran to be sure, with similar results. I've attached a
> syz-symbolize'd version of the warnings.

Thanks for confirming, and for the symbolized report.

I'll see about getting this fixed ASAP.

Thanks,
Mark.
