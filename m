Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F742C2D0E4
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 18:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1452242B
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 18:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFr1zLBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgKTSRq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbgKTSRp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 13:17:45 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB9AC0613CF
        for <rcu@vger.kernel.org>; Fri, 20 Nov 2020 10:17:45 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so10938232wrc.8
        for <rcu@vger.kernel.org>; Fri, 20 Nov 2020 10:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=giLwGu45+mkpAyteW5JjczsUwt2xu5kU0h/C4LFwJ2c=;
        b=wFr1zLBjOF9rnmBu4dONY85QJfuQdrC1q3VGOLs6wv+27rz4ELtVLvqWNT1EQmPJeP
         b/DEveUrWtbf3ClEGVeEX8NeFHuqDwvPQUo6bXUjsr3Py7DHCLZcDEfbtgE1+aawCH5B
         eUzNpMiKo70UyssLqrE034oG+ojnU48jMeUGXB/OuuAU8XcWzvbKyHmTDJBrA768ALkL
         7BxCHw5a7bNl87a62XUxg1ioHwTlgDYAOiJFzkeFpMcufbTTMi90cj6T6DmFBgQxYn7S
         NJNCMDJeTh99hFoO/EBvtqS5im23Jav3qGAWiHWir13cnYDaqmT3kKCNWKOLz7Gvc/Go
         ua/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=giLwGu45+mkpAyteW5JjczsUwt2xu5kU0h/C4LFwJ2c=;
        b=RLpV09kP66ZRTewYyvjXLO0/1ddO7akZHzyfHW5jqHLiXYiUwuevKseNnSSzLLSx2Y
         CpIFuL2ZaACVWiZ/5ggpa3BOOgmFeldfA7OfS9OhUsURKM9v013/J1jPhN+zsYKIH/kP
         w5zlx3T5kJWpQo5ohoamKvI9Q+h6UHTuTOMiNof7QuZWUy+xpY/Qc53nJr+iRc1Z43j3
         oAfHJQHUS2IMuy8dGK+7v9+4ozNHTRWJ3fhfzp4rYqF7SvltiFy9IeJ/eMSteR30C18M
         YOqvJVf+IOV1tVO/MO7I1wNO4gMcLJQ4YAxBgd/5+mYpzY4FJGWOnfAXZsPqozKfrfCK
         qVCQ==
X-Gm-Message-State: AOAM533TwvszYwTLKVp2W6E+OeSm0WOYJTsM/42r07iIcFYuWEXV90TM
        89rN+OKOgg3xrTDx0Aa6AhQTkQ==
X-Google-Smtp-Source: ABdhPJypfvUfZgF5ojloWzuTAX8p2n/TOFSkwnjUALuGsK1Ip6DPAbzOUC423R8qr2cVO7IcyikW0Q==
X-Received: by 2002:adf:9e4c:: with SMTP id v12mr16806903wre.22.1605896264123;
        Fri, 20 Nov 2020 10:17:44 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id g11sm6243435wrq.7.2020.11.20.10.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 10:17:43 -0800 (PST)
Date:   Fri, 20 Nov 2020 19:17:37 +0100
From:   Marco Elver <elver@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20201120181737.GA3301774@elver.google.com>
References: <20201118225621.GA1770130@elver.google.com>
 <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com>
 <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
 <20201119213512.GB1437@paulmck-ThinkPad-P72>
 <20201120141928.GB3120165@elver.google.com>
 <20201120102613.3d18b90e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120102613.3d18b90e@gandalf.local.home>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 10:26AM -0500, Steven Rostedt wrote:
> On Fri, 20 Nov 2020 15:19:28 +0100
> Marco Elver <elver@google.com> wrote:
> 
> > None of those triggered either.
> > 
> > I found that disabling ftrace for some of kernel/rcu (see below) solved
> > the stalls (and any mention of deadlocks as a side-effect I assume),
> > resulting in successful boot.
> > 
> > Does that provide any additional clues? I tried to narrow it down to 1-2
> > files, but that doesn't seem to work.
> > 
> > Thanks,
> > -- Marco
> > 
> > ------ >8 ------  
> > 
> > diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
> > index 0cfb009a99b9..678b4b094f94 100644
> > --- a/kernel/rcu/Makefile
> > +++ b/kernel/rcu/Makefile
> > @@ -3,6 +3,13 @@
> >  # and is generally not a function of system call inputs.
> >  KCOV_INSTRUMENT := n
> >  
> > +ifdef CONFIG_FUNCTION_TRACER
> > +CFLAGS_REMOVE_update.o = $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_sync.o = $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_srcutree.o = $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_tree.o = $(CC_FLAGS_FTRACE)
> > +endif
> > +
> 
> Can you narrow it down further? That is, do you really need all of the
> above to stop the stalls?

I tried to reduce it to 1 or combinations of 2 files only, but that
didn't work.

> Also, since you are using linux-next, you have ftrace recursion debugging.
> Please enable:
> 
> CONFIG_FTRACE_RECORD_RECURSION=y
> CONFIG_RING_BUFFER_RECORD_RECURSION=y
> 
> when enabling any of the above. If you can get to a successful boot, you
> can then:
> 
>  # cat /sys/kernel/tracing/recursed_functions
> 
> Which would let me know if there's an recursion issue in RCU somewhere.

To get the system to boot in the first place (as mentioned in other
emails) I again needed to revert
  "rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled",
as otherwise would run into the deadlock. That used to still result in
stall warnings, except when ftrace's recursion detection is on it seems.

With that, this is what I get:

| # cat /sys/kernel/tracing/recursed_functions
| trace_selftest_test_recursion_func+0x34/0x48:   trace_selftest_dynamic_test_func+0x4/0x28
| el1_irq+0xc0/0x180:     gic_handle_irq+0x4/0x108
| gic_handle_irq+0x70/0x108:      __handle_domain_irq+0x4/0x130
| __handle_domain_irq+0x7c/0x130: irq_enter+0x4/0x28
| trace_rcu_dyntick+0x168/0x190:  rcu_read_lock_sched_held+0x4/0x98
| rcu_read_lock_sched_held+0x30/0x98:     rcu_read_lock_held_common+0x4/0x88
| rcu_read_lock_held_common+0x50/0x88:    rcu_lockdep_current_cpu_online+0x4/0xd0
| irq_enter+0x1c/0x28:    irq_enter_rcu+0x4/0xa8
| irq_enter_rcu+0x3c/0xa8:        irqtime_account_irq+0x4/0x198
| irq_enter_rcu+0x44/0xa8:        preempt_count_add+0x4/0x1a0
| trace_hardirqs_off+0x254/0x2d8: __srcu_read_lock+0x4/0xa0
| trace_hardirqs_off+0x25c/0x2d8: rcu_irq_enter_irqson+0x4/0x78
| trace_rcu_dyntick+0xd8/0x190:   __traceiter_rcu_dyntick+0x4/0x80
| trace_hardirqs_off+0x294/0x2d8: rcu_irq_exit_irqson+0x4/0x78
| trace_hardirqs_off+0x2a0/0x2d8: __srcu_read_unlock+0x4/0x88

Thanks,
-- Marco
