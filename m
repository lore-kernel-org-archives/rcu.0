Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132E7C63777
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 14:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA5122272
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 14:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmgQYZ4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgKTOja (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 09:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbgKTOja (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 09:39:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7122224C;
        Fri, 20 Nov 2020 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605883169;
        bh=TAwBwzFSTpCTleLfZQ8+ZcWFhYmGk+5E1muhTgKlVwA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FmgQYZ4oMCALsaw6U1qaA54aFyaUqxhNoCwtOECuPWnMfsF7iTLeFxZkhPS916SF/
         rMfTurzQ/uZuMTNNsd6/8Q76z8U2b9I1LeSG2BUcxAbFvD8UnUyqLLLnUkUoPh3mc2
         mL/qo8R/Mg/Ov98CmrIsF1+Xuj4oSWG9ZL/tGcC8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AEB373522A6E; Fri, 20 Nov 2020 06:39:28 -0800 (PST)
Date:   Fri, 20 Nov 2020 06:39:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201120143928.GH1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201117182915.GM1437@paulmck-ThinkPad-P72>
 <20201118225621.GA1770130@elver.google.com>
 <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com>
 <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
 <20201119213512.GB1437@paulmck-ThinkPad-P72>
 <20201120141928.GB3120165@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120141928.GB3120165@elver.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 03:19:28PM +0100, Marco Elver wrote:
> On Thu, Nov 19, 2020 at 01:35PM -0800, Paul E. McKenney wrote:
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
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit bcca5277df3f24db15e15ccc8b05ecf346d05169
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Nov 19 13:30:33 2020 -0800
> > 
> >     rcu: Add lockdep_assert_irqs_disabled() to raw_spin_unlock_rcu_node() macros
> 
> None of those triggered either.
> 
> I found that disabling ftrace for some of kernel/rcu (see below) solved
> the stalls (and any mention of deadlocks as a side-effect I assume),
> resulting in successful boot.
> 
> Does that provide any additional clues? I tried to narrow it down to 1-2
> files, but that doesn't seem to work.

There were similar issues during the x86/entry work.  Are the ARM guys
doing arm64/entry work now?

							Thanx, Paul

> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
> index 0cfb009a99b9..678b4b094f94 100644
> --- a/kernel/rcu/Makefile
> +++ b/kernel/rcu/Makefile
> @@ -3,6 +3,13 @@
>  # and is generally not a function of system call inputs.
>  KCOV_INSTRUMENT := n
>  
> +ifdef CONFIG_FUNCTION_TRACER
> +CFLAGS_REMOVE_update.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_sync.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_srcutree.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_tree.o = $(CC_FLAGS_FTRACE)
> +endif
> +
>  ifeq ($(CONFIG_KCSAN),y)
>  KBUILD_CFLAGS += -g -fno-omit-frame-pointer
>  endif
