Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE60AC433F5
	for <rcu@archiver.kernel.org>; Wed,  6 Oct 2021 07:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C826B61181
	for <rcu@archiver.kernel.org>; Wed,  6 Oct 2021 07:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhJFH7i (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Oct 2021 03:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbhJFH7h (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Oct 2021 03:59:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05592C06174E;
        Wed,  6 Oct 2021 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QgYsG4DybyVUkLhBWL4qDYk9xpuJmOv7rcrX1JZVF7o=; b=ldKp5AGBJZYwRoRVyB2NzwUWXZ
        pfVwmqBgteBAP0uDAZLCXeO5K8mbYu9VFopBE6oPegQNTPWn6WZ2jPxa9WyEcwSLKwD/XALVABkEZ
        ZsxisDBa4sDVBFrvmYQs7kmOz8NYZAIlfPCeIqO7McukWoDTeqGFOOzAy0uQcWQJMJwShHI4f0d+H
        0rsiUiM8okGgweK0k4dAJ3mVilpdq7mHoXiGKgzeIq0W6z15OMoxVK4UCr8TcO0XeuyA7j5uRni82
        lTnODcuW0dK4tGRT6mnMYynaIOm8Qf5zUUwqRXG7krxOchEqh70W4wgK2Xa5+H9uzmuzDXtJF+ESv
        /4oUs3eg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY1o1-008ERF-Em; Wed, 06 Oct 2021 07:57:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 842E9300056;
        Wed,  6 Oct 2021 09:57:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67566200C9CA8; Wed,  6 Oct 2021 09:57:36 +0200 (CEST)
Date:   Wed, 6 Oct 2021 09:57:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: instrument_atomic_read()/_write() in noinstr functions?
Message-ID: <YV1W8FAV6h2t5gQo@hirez.programming.kicks-ass.net>
References: <871r4z55fn.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r4z55fn.fsf@dja-thinkpad.axtens.net>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 06, 2021 at 12:05:00PM +1100, Daniel Axtens wrote:
> Hi,
> 
> commit b58e733fd774 ("rcu: Fixup noinstr warnings") adds some
> instrument_atomic_read calls to rcu_nmi_enter - a function marked
> noinstr. Similar calls are added to some other functions as well.

It moves the instrumentation, it was already there. Specifically:

-       seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+       seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);

removes the instrumentation from the critical place where RCU isn't yet
watching, which is then added back here:

+       // instrumentation for the noinstr rcu_dynticks_eqs_enter()
+       instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));

Once it's deemed safe to run instrumentation.

> This is causing me some grief on powerpc64 while trying to enable
> KASAN. powerpc64 book3s takes some NMIs in real mode, and in real mode
> we can't access where I'm proposing to put the KASAN shadow - we can
> only access it with translations on. So I end up taking a fault in the
> kasan_check_read path via rcu_nmi_enter.

Then your entry ordering is wrong :-( RCU should be the very last thing,
once RCU is watching it should be safe to run instrumentation.

> As far as I can tell `instrumentation_begin()` and
> `instrumentation_end()` don't make it safe to call instrumentation, they
> just tell the developer that instrumentation is safe. (And they are used
> to check the balance of _begin()/_end() blocks.)

That is correct. In that respect it is an unsafe (pun intended)
annotation. The annotation can be used to annotate away actual
violations (although the one at hand is not one such). There are some
explicitly unsafe annotations like that though, typically WARNs in early
init code where we really can't do much better than to ignore and hope
the error gets out.

> Is the underlying assumption that the KASAN shadow will always be safe
> to access, even in functions marked noinstr? It seems to undercut what
> an architecture can assume about a function marked noinstr...

The assumption is that RCU is the very last thing in the entry code to
be enabled, and the very first to be disabled. Therefore, the moment RCU
is active we can allow instrumentation, and hence the
instrumentation_begin() is correct there.

The NMI dance on x86 is particularly nasty, but the first part
(currently all in entry_64.S) ensures the kernel page-tables are active
and that we have a kernel stack.

Then we call into C, which is still gnarly and deals with
self-recursion, but eventually calls irqentry_nmi_enter(). This then
carefully frobs the preempt, lockdep and rcu states into the right place
after which we have a fully 'normal' C context.

> P.S. On a more generic note instrumentation_begin()/_end() is now
> scattered across the kernel and it makes me a bit nervous. It's making a
> statement about something that is in part a property of how the arch
> implements instrumentation. Are arches expected to implement things in
> such a way as to make these blocks accurate?

Yes, there's only a limited ways in which all this can slot toghether
due to all the nasty inter-dependencies. Thomas and me spend quite a bit
of time trying to untangle the web such that we have a coherent
entry/exit ordering that's actually workable.

Pretty much everybody had this wrong and was/is broken in various
non-fun ways.

It's just that we didn't seem to have gotten around to writing
much documentation for any of this :/

> For example in
> arch/powerpc/include/asm/interrupt.h::interrupt_nmi_enter_prepare we
> currently sometimes call nmi_enter in real mode; should we instead only
> call it when we have translations on?

nmi_enter() is the 'old' interface that has known issues. That said, you
seem to have a comment exactly there:

	/*
	 * Do not use nmi_enter() for pseries hash guest taking a real-mode
	 * NMI because not everything it touches is within the RMA limit.
	 */
	if (!IS_ENABLED(CONFIG_PPC_BOOK3S_64) ||
			!firmware_has_feature(FW_FEATURE_LPAR) ||
			radix_enabled() || (mfmsr() & MSR_DR))
		nmi_enter();


To me it sounds like this real-mode is something that's not a normal C
context and really should not ever run any instrumented code. As such I
don't think it should be using RCU.


Let me illustrate with the IRQ entry code, as that's easier:

Your code currently seems to do things like:

DEFINE_INTERRUPT_HANDLER_ASYNC()
  interrupt_async_enter_prepare()
    interrupt_enter_prepare()
      trace_hardirqs_off()
        lockdep_hardirqs_off()
	tracer_hardirqs_off()  // relies on RCU
	trace_irq_disable()    // relies on RCU
    irq_enter()
      rcu_irq_enter() // relies on lockdep, enables RCU
      ...


And there's a 'funnier' one involving trace_hardirqs_on(), there
lockdep itself relies on RCU and RCU relies on lockdep. But I'm not
quite sure how power does that.

