Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77088C2D0E4
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 19:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1680722254
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 19:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UoSVrsHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbgKTTWO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 14:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732296AbgKTTWO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 14:22:14 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57936C0613CF
        for <rcu@vger.kernel.org>; Fri, 20 Nov 2020 11:22:14 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m13so11631932oih.8
        for <rcu@vger.kernel.org>; Fri, 20 Nov 2020 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3bHHSoIiWnpt6sSCrh+oplbMynkFaA5raUA9UFenU8=;
        b=UoSVrsHFC/6ajfj53sIgq9KZJKGyJRjJagX2Jw9X+kmRK3eYNEjIDWo3EC7ORKCCpt
         hk/fUm411A5vkCbbI2r5PPlNm+uAaBCXyw5DDpdTbArnuiKB8R5jPukjeHq0yHn7JPuS
         FsYdW1mnUJGNGP9LYa6xm3+eTfwy/7XO2bHCZG4KcwKl84YjZ4USlMDjxaWiH1tG3yVm
         trknR40qepg10Ly4PsYPcJVI7J8g0G1SfqFziv1yGiS5O2RGR5vyrkrpXuBU5Qrs/2rq
         zFAen6YmbgB/hglU1e+oKw4WsXGUpwniG6CFV3YewJ7i2+mdR2ftYdEThiGPdxxaeKev
         2IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3bHHSoIiWnpt6sSCrh+oplbMynkFaA5raUA9UFenU8=;
        b=Ydynw/a3FVf2Tjp6GRvXZSEKu8DZ6+GPQPPSmPkPhzVmiMlrwEIPGLzZiqbQpBTelg
         V44J8Rl12zCcmEvLtVZJos1BdXQMSmg9J1qyVxk8xDVckYmDRuZAbrENgmD6FVtYzHgx
         kCErhCiGqPck/g9lAF4cwMmDjIMAN3lBJFHitQ0kVus2UihD+KbQwbN95JsiwULV9Wcj
         JYO8HUSDnzEmppDKonJNEczL6v+bFnvynnmKQNHHoM+eMuyhELc5g4S0jmgO9B+mTeWl
         H6bKHu0GAZ84Fx4Gy7g8rpmg1ejkxaR4zg++KAJvCZGqo1xbb3qKxwxFW3BXGtjhaClV
         MrRA==
X-Gm-Message-State: AOAM533NKZ89Us/3JMcnQJBsB+WhAAQDADeCYfMikJV6BJrTGVSXqQlu
        kgaAhfAESUeYORD5Jjz7exfvfeC6XRHZUIF8CI0XiQ==
X-Google-Smtp-Source: ABdhPJxOU8HRyWfOhXUizg1VIov+ux7MpOo8HRr290PtSWN/SNAM+kBbp9E9fBX8fCWm0czXOt58ykdlbb+3hS00UcU=
X-Received: by 2002:a54:4681:: with SMTP id k1mr7597024oic.121.1605900133550;
 Fri, 20 Nov 2020 11:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20201118225621.GA1770130@elver.google.com> <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com> <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com> <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com> <20201119213512.GB1437@paulmck-ThinkPad-P72>
 <20201120141928.GB3120165@elver.google.com> <20201120102613.3d18b90e@gandalf.local.home>
 <20201120181737.GA3301774@elver.google.com> <20201120141639.3896a3c8@gandalf.local.home>
In-Reply-To: <20201120141639.3896a3c8@gandalf.local.home>
From:   Marco Elver <elver@google.com>
Date:   Fri, 20 Nov 2020 20:22:01 +0100
Message-ID: <CANpmjNN+smYsdcJDDHNCT9aD_WULV3q6UmVRAutKPjzGVi_yfQ@mail.gmail.com>
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 20 Nov 2020 at 20:16, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 20 Nov 2020 19:17:37 +0100
> Marco Elver <elver@google.com> wrote:
>
> > > > +++ b/kernel/rcu/Makefile
> > > > @@ -3,6 +3,13 @@
> > > >  # and is generally not a function of system call inputs.
> > > >  KCOV_INSTRUMENT := n
> > > >
> > > > +ifdef CONFIG_FUNCTION_TRACER
> > > > +CFLAGS_REMOVE_update.o = $(CC_FLAGS_FTRACE)
> > > > +CFLAGS_REMOVE_sync.o = $(CC_FLAGS_FTRACE)
> > > > +CFLAGS_REMOVE_srcutree.o = $(CC_FLAGS_FTRACE)
> > > > +CFLAGS_REMOVE_tree.o = $(CC_FLAGS_FTRACE)
> > > > +endif
> > > > +
> > >
> > > Can you narrow it down further? That is, do you really need all of the
> > > above to stop the stalls?
> >
> > I tried to reduce it to 1 or combinations of 2 files only, but that
> > didn't work.
>
> I'm curious if this would help at all?
>
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2a52f42f64b6..d020ecefd151 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1094,7 +1094,7 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
>   * if the current CPU is not in its idle loop or is in an interrupt or
>   * NMI handler, return true.
>   */
> -bool rcu_is_watching(void)
> +notrace bool rcu_is_watching(void)
>  {
>         bool ret;
>
> Although I don't see it in the recursion list.

It seems a patch to that effect is already in -next ("rcu,ftrace: Fix
ftrace recursion"), and my experiments so far have all been with it.

Thanks,
-- Marco
