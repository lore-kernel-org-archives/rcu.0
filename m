Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2792C388F9
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 22:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D77720BED
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 22:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kL3PAxbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgKSWyA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Nov 2020 17:54:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgKSWyA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Nov 2020 17:54:00 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8022078D;
        Thu, 19 Nov 2020 22:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605826439;
        bh=cyOhmgdck5bcUe3yZHXRL+9ZgqweKbNI89Rawb9k2oA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kL3PAxbGhIafzcP+yn+XTRJ5cnGQQusUt3dwLbUjKVttfqpW5ZKn7G9As98kHpgEh
         yrkXB/xjTOmWrUUK4IlpdZ4fxY0fVLSoXqlTShkI7PEm4TELJqOrdO+OAF3PiQy0Zd
         lIwLSfGTlM1h+e5zNMrhujlorNkmMS7GA7cV+3ig=
Date:   Thu, 19 Nov 2020 22:53:53 +0000
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20201119225352.GA5251@willie-the-truck>
References: <20201117105236.GA1964407@elver.google.com>
 <20201117182915.GM1437@paulmck-ThinkPad-P72>
 <20201118225621.GA1770130@elver.google.com>
 <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com>
 <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
 <20201119213512.GB1437@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119213512.GB1437@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 19, 2020 at 01:35:12PM -0800, Paul E. McKenney wrote:
> On Thu, Nov 19, 2020 at 08:38:19PM +0100, Marco Elver wrote:
> > On Thu, Nov 19, 2020 at 10:48AM -0800, Paul E. McKenney wrote:
> > > On Thu, Nov 19, 2020 at 06:02:59PM +0100, Marco Elver wrote:
> 
> [ . . . ]
> 
> > > > I can try bisection again, or reverting some commits that might be
> > > > suspicious? But we'd need some selection of suspicious commits.
> > > 
> > > The report claims that one of the rcu_node ->lock fields is held
> > > with interrupts enabled, which would indeed be bad.  Except that all
> > > of the stack traces that it shows have these locks held within the
> > > scheduling-clock interrupt handler.  Now with the "rcu: Don't invoke
> > > try_invoke_on_locked_down_task() with irqs disabled" but without the
> > > "sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled"
> > > commit, I understand why.  With both, I don't see how this happens.
> > 
> > I'm at a loss, but happy to keep bisecting and trying patches. I'm also
> > considering:
> > 
> > 	Is it the compiler? Probably not, I tried 2 versions of GCC.
> > 
> > 	Can we trust lockdep to precisely know IRQ state? I know there's
> > 	been some recent work around this, but hopefully we're not
> > 	affected here?
> > 
> > 	Is QEMU buggy?
> > 
> > > At this point, I am reduced to adding lockdep_assert_irqs_disabled()
> > > calls at various points in that code, as shown in the patch below.
> > > 
> > > At this point, I would guess that your first priority would be the
> > > initial bug rather than this following issue, but you never know, this
> > > might well help diagnose the initial bug.
> > 
> > I don't mind either way. I'm worried deadlocking the whole system might
> > be worse.
> 
> Here is another set of lockdep_assert_irqs_disabled() calls on the
> off-chance that they actually find something.

FWIW, arm64 is known broken wrt lockdep and irq tracing atm. Mark has been
looking at that and I think he is close to having something workable.

Mark -- is there anything Marco and Paul can try out?

Will
