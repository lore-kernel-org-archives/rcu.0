Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BF2C433F5
	for <rcu@archiver.kernel.org>; Wed,  6 Oct 2021 12:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2026E610A8
	for <rcu@archiver.kernel.org>; Wed,  6 Oct 2021 12:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbhJFMKx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Oct 2021 08:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbhJFMKx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Oct 2021 08:10:53 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E850C061753
        for <rcu@vger.kernel.org>; Wed,  6 Oct 2021 05:09:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g184so2283232pgc.6
        for <rcu@vger.kernel.org>; Wed, 06 Oct 2021 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=V33FRyfxRCOnEo8u7n9r2mHqIS4K2al0g2rrhqi7dVU=;
        b=N00Lzp22Mw4XPBmh6M29nCdZNN1qLdrAAgKPYPriiKMsoL4ZQCYm+RslD5mwEEebmT
         9VN3Qcs3uH6kE2UJQYhUOgvgW36oh+fohkNlPFtpYbAkFXWrcrtANX5k7zf/FQebRAOl
         KaYhvjkCCFvSDBxscD4eWciWgCYtDwuSI99M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=V33FRyfxRCOnEo8u7n9r2mHqIS4K2al0g2rrhqi7dVU=;
        b=7wQ/NATXjvXwK6ZPDlFH/SomkZyCOJkBTWROzY3LZsyrYno14CPdAcXTF1phuKQXEd
         ICvlrD1Kii8Klrp3h5xe5+c4i4+xUJ1NFpxW+37oZuB2a6i8xImhcID2F1KWWG3rFIcC
         ay89ywuMDzS0LNfzrkM4yVHa6ICjXTjtKbt02J6pfq/3n7stA9sMGk8ejRVx1D0QV3em
         NEXgOIKYmlWTRVgl+ktRG+keuNpCbE2rI5Laa3UpHqLB12jF1vM9Lx9d0d5suG3kSPzq
         fHztii+9kAt6lW6yc+xww604NMeNLS4a7TEjmrheJXdx/ePXNZTnVxgOQsTpK4QxTsEi
         4XGg==
X-Gm-Message-State: AOAM532g5VPBO6La1DX67P3XmGnuAvLwQGaCNNXRaDqVApqfo20NRBWX
        c3f892RzR6OrWrVVYpJBfICqJQ==
X-Google-Smtp-Source: ABdhPJzU05PoGdOet1bod/veyfpv7UoID9KqyjBp8bmarTQ3veR1//nZ/7omuf+zOx9iD+fXSnKqMQ==
X-Received: by 2002:a05:6a00:2311:b0:431:c19f:2a93 with SMTP id h17-20020a056a00231100b00431c19f2a93mr36461867pfh.11.1633522140499;
        Wed, 06 Oct 2021 05:09:00 -0700 (PDT)
Received: from localhost ([2001:4479:e300:600:322:fa78:c55e:6913])
        by smtp.gmail.com with ESMTPSA id h6sm5249368pji.6.2021.10.06.05.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 05:09:00 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: instrument_atomic_read()/_write() in noinstr functions?
In-Reply-To: <YV1W8FAV6h2t5gQo@hirez.programming.kicks-ass.net>
References: <871r4z55fn.fsf@dja-thinkpad.axtens.net>
 <YV1W8FAV6h2t5gQo@hirez.programming.kicks-ass.net>
Date:   Wed, 06 Oct 2021 23:08:57 +1100
Message-ID: <87k0iq4ap2.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Peter,

Thanks for your quick response, it is extremely helpful.

>> commit b58e733fd774 ("rcu: Fixup noinstr warnings") adds some
>> instrument_atomic_read calls to rcu_nmi_enter - a function marked
>> noinstr. Similar calls are added to some other functions as well.
>
> It moves the instrumentation, it was already there. Specifically:
>
> -       seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> +       seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
>
> removes the instrumentation from the critical place where RCU isn't yet
> watching, which is then added back here:
>
> +       // instrumentation for the noinstr rcu_dynticks_eqs_enter()
> +       instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
>
> Once it's deemed safe to run instrumentation.

Ah, my bad.

>> This is causing me some grief on powerpc64 while trying to enable
>> KASAN. powerpc64 book3s takes some NMIs in real mode, and in real mode
>> we can't access where I'm proposing to put the KASAN shadow - we can
>> only access it with translations on. So I end up taking a fault in the
>> kasan_check_read path via rcu_nmi_enter.
>
> Then your entry ordering is wrong :-( RCU should be the very last thing,
> once RCU is watching it should be safe to run instrumentation.
>
>> As far as I can tell `instrumentation_begin()` and
>> `instrumentation_end()` don't make it safe to call instrumentation, they
>> just tell the developer that instrumentation is safe. (And they are used
>> to check the balance of _begin()/_end() blocks.)
>
> That is correct. In that respect it is an unsafe (pun intended)
> annotation. The annotation can be used to annotate away actual
> violations (although the one at hand is not one such). There are some
> explicitly unsafe annotations like that though, typically WARNs in early
> init code where we really can't do much better than to ignore and hope
> the error gets out.
>
>> Is the underlying assumption that the KASAN shadow will always be safe
>> to access, even in functions marked noinstr? It seems to undercut what
>> an architecture can assume about a function marked noinstr...
>
> The assumption is that RCU is the very last thing in the entry code to
> be enabled, and the very first to be disabled. Therefore, the moment RCU
> is active we can allow instrumentation, and hence the
> instrumentation_begin() is correct there.
>
> The NMI dance on x86 is particularly nasty, but the first part
> (currently all in entry_64.S) ensures the kernel page-tables are active
> and that we have a kernel stack.

Yeah, this is where we come unstuck. We don't always activate kernel
page tables/turn on data relocations/leave real mode/whatever. In some
cases we run in real mode for (I believe) the entire NMI handler.

> Then we call into C, which is still gnarly and deals with
> self-recursion, but eventually calls irqentry_nmi_enter(). This then
> carefully frobs the preempt, lockdep and rcu states into the right place
> after which we have a fully 'normal' C context.
>
>> P.S. On a more generic note instrumentation_begin()/_end() is now
>> scattered across the kernel and it makes me a bit nervous. It's making a
>> statement about something that is in part a property of how the arch
>> implements instrumentation. Are arches expected to implement things in
>> such a way as to make these blocks accurate?
>
> Yes, there's only a limited ways in which all this can slot toghether
> due to all the nasty inter-dependencies. Thomas and me spend quite a bit
> of time trying to untangle the web such that we have a coherent
> entry/exit ordering that's actually workable.
>
> Pretty much everybody had this wrong and was/is broken in various
> non-fun ways.

Fair enough. What exactly are the preconditions for instrumentation?  In
other words, what must the arch ensure is true before we pass an
instrumentation_begin()?

I know from KASAN that we need to be able to access the shadow memory,
which on most (all?) platforms means we need relocations/virtual
addressing on. I don't know what else needs to be satisfied. (I'm
guessing we want to be in a position where taking a fault won't bring
down the system, for example.)

> It's just that we didn't seem to have gotten around to writing
> much documentation for any of this :/

A problem which I too suffer from - I am in no position to throw stones here!

>> For example in
>> arch/powerpc/include/asm/interrupt.h::interrupt_nmi_enter_prepare we
>> currently sometimes call nmi_enter in real mode; should we instead only
>> call it when we have translations on?
>
> nmi_enter() is the 'old' interface that has known issues. That said, you
> seem to have a comment exactly there:
>
> 	/*
> 	 * Do not use nmi_enter() for pseries hash guest taking a real-mode
> 	 * NMI because not everything it touches is within the RMA limit.
> 	 */
> 	if (!IS_ENABLED(CONFIG_PPC_BOOK3S_64) ||
> 			!firmware_has_feature(FW_FEATURE_LPAR) ||
> 			radix_enabled() || (mfmsr() & MSR_DR))
> 		nmi_enter();
>
>
> To me it sounds like this real-mode is something that's not a normal C
> context and really should not ever run any instrumented code. As such I
> don't think it should be using RCU.

Yeah, so it looks to me that we should not be calling nmi_enter() when
we don't have data relocations on (the mfmsr() & MSR_DR test) - we
shouldn't special case pseries hash guests.

I'll have to think through the implications of that, neither powerpc
exceptions nor Linux's exception handing are really my areas of
expertise!

What's the new interface I'm supposed to be using? Things like
irqentry_nmi_enter?

> Let me illustrate with the IRQ entry code, as that's easier:
>
> Your code currently seems to do things like:
>
> DEFINE_INTERRUPT_HANDLER_ASYNC()
>   interrupt_async_enter_prepare()
>     interrupt_enter_prepare()
>       trace_hardirqs_off()
>         lockdep_hardirqs_off()
> 	tracer_hardirqs_off()  // relies on RCU
> 	trace_irq_disable()    // relies on RCU
>     irq_enter()
>       rcu_irq_enter() // relies on lockdep, enables RCU
>       ...
>
>
> And there's a 'funnier' one involving trace_hardirqs_on(), there
> lockdep itself relies on RCU and RCU relies on lockdep. But I'm not
> quite sure how power does that.

We take most exceptions (on 64-bit server platforms, at least, and as
currently configured, etc etc) with relocations already on. But there
are 5 interrupts defined in the ISA which we always take with
relocations _off_.

It sounds like we may have been a bit optimistic about how far into the
generic kernel we could go in these cases. I guess the right thing to do
is to handle them quickly, touching only arch-specific known-safe
things, and then get out. But I will read the RCU docs to check what it
expects of us and bikeshed things on the linuxppc-dev list.

Thanks again, I really appreciate the quick, detailed and patient reply!

Kind regards,
Daniel
