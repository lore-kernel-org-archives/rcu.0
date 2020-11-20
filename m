Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C387BC5519F
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 10:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3E122255
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 10:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgKTKaj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 05:30:39 -0500
Received: from foss.arm.com ([217.140.110.172]:46888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgKTKaj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 05:30:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C0C21042;
        Fri, 20 Nov 2020 02:30:38 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.27.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAB813F70D;
        Fri, 20 Nov 2020 02:30:34 -0800 (PST)
Date:   Fri, 20 Nov 2020 10:30:31 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
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
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201120103031.GB2328@C02TD0UTHF1T.local>
References: <20201117182915.GM1437@paulmck-ThinkPad-P72>
 <20201118225621.GA1770130@elver.google.com>
 <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com>
 <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
 <20201119213512.GB1437@paulmck-ThinkPad-P72>
 <20201119225352.GA5251@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119225352.GA5251@willie-the-truck>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 19, 2020 at 10:53:53PM +0000, Will Deacon wrote:
> On Thu, Nov 19, 2020 at 01:35:12PM -0800, Paul E. McKenney wrote:
> > On Thu, Nov 19, 2020 at 08:38:19PM +0100, Marco Elver wrote:
> > > On Thu, Nov 19, 2020 at 10:48AM -0800, Paul E. McKenney wrote:
> > > > On Thu, Nov 19, 2020 at 06:02:59PM +0100, Marco Elver wrote:
> > 
> > [ . . . ]
> > 
> > > > > I can try bisection again, or reverting some commits that might be
> > > > > suspicious? But we'd need some selection of suspicious commits.
> > > > 
> > > > The report claims that one of the rcu_node ->lock fields is held
> > > > with interrupts enabled, which would indeed be bad.  Except that all
> > > > of the stack traces that it shows have these locks held within the
> > > > scheduling-clock interrupt handler.  Now with the "rcu: Don't invoke
> > > > try_invoke_on_locked_down_task() with irqs disabled" but without the
> > > > "sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled"
> > > > commit, I understand why.  With both, I don't see how this happens.
> > > 
> > > I'm at a loss, but happy to keep bisecting and trying patches. I'm also
> > > considering:
> > > 
> > > 	Is it the compiler? Probably not, I tried 2 versions of GCC.
> > > 
> > > 	Can we trust lockdep to precisely know IRQ state? I know there's
> > > 	been some recent work around this, but hopefully we're not
> > > 	affected here?
> > > 
> > > 	Is QEMU buggy?
> > > 
> > > > At this point, I am reduced to adding lockdep_assert_irqs_disabled()
> > > > calls at various points in that code, as shown in the patch below.
> > > > 
> > > > At this point, I would guess that your first priority would be the
> > > > initial bug rather than this following issue, but you never know, this
> > > > might well help diagnose the initial bug.
> > > 
> > > I don't mind either way. I'm worried deadlocking the whole system might
> > > be worse.
> > 
> > Here is another set of lockdep_assert_irqs_disabled() calls on the
> > off-chance that they actually find something.
> 
> FWIW, arm64 is known broken wrt lockdep and irq tracing atm. Mark has been
> looking at that and I think he is close to having something workable.
> 
> Mark -- is there anything Marco and Paul can try out?

I initially traced some issues back to commit:

  044d0d6de9f50192 ("lockdep: Only trace IRQ edges")

... and that change of semantic could cause us to miss edges in some
cases, but IIUC mostly where we haven't done the right thing in
exception entry/return.

I don't think my patches address this case yet, but my WIP (currently
just fixing user<->kernel transitions) is at:

https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/irq-fixes

I'm looking into the kernel<->kernel transitions now, and I know that we
mess up RCU management for a small window around arch_cpu_idle, but it's
not immediately clear to me if either of those cases could cause this
report.

Thanks,
Mark.
