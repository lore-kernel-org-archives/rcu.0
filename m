Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83583C2BA2B
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B7C22201
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOjV60vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgDPV06 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbgDPV06 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 17:26:58 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55E7C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 14:26:57 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m19so6697203lfq.13
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 14:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OxKMuW4AzDoEiOLwpli/l8O+cOdYu0lQGEBugoi1264=;
        b=TOjV60vypjEdmFHyDZemPbXRrM3RU8ezDfEO5fgXn/r7Mr1bVAuDyht0t+z0vAPL34
         TzGv784Iuz8mYJIhGd3HeT9KI57vLH3xO87jaTI05maKODq9kICOb+FGamOUsqM6Z1aI
         vzDaILupaYD7vFdHq5THh3dMQN9Z2qlknc59G659Q4hMhhFCyxK9+LcbiSoghMwgv4Dv
         OUDLEpZmy7fmxKjZtvsIOdAjpFPnbS1Zwu1dW0PGTvbUnfluWlYGeDgySucrXEmIx97p
         C/unRgUl7y0aQ/UVF+/XtEiQJdLGKbkvg2IdhY9Lnd2L8hixSR8YRI3I0bwZE2YPlvsZ
         c++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OxKMuW4AzDoEiOLwpli/l8O+cOdYu0lQGEBugoi1264=;
        b=GgpLIb4V7azsfpv7K35j5MZ5w6lTZSHP4GgMTItH6bQfvfYzgx3uzHdAG0L2N6wPVy
         m3Fkvd5ZNLTGqhi5fZuMzdJiFD+2TrrOE7/bPWtBtvCxN8q8R/0chjZHw5xS45fy3dqV
         rEXeWtNYrxuwPR994m6JrI3FbyD3kLNx1cKQzWkpeW8KyX9j9hS/Aql5zeuCw1GD1IWn
         8ZXw/Mv+VbHRTNT1RzyZZLSRloOxccme54tCULCaIa3hqeGvJfAq84HTh5Y+g9tHcQ1O
         e/tZMvlHENyWmsC0u2xA/fBOFKLaR0kwqW3LTGQwqllJIK7Kcj2MGkRsH3uz0mXtO8Lw
         HqOA==
X-Gm-Message-State: AGi0PuZbF/b5UjFEI3JGjQpCos7HczKDUEJFV+y0f9x8VzVMrbsuQWzh
        VubvMe5uK9LYauNkWEwb77A=
X-Google-Smtp-Source: APiQypLKJSRLoPK2P2up1aojHD2o76GWfC5FjUSNmSD+7CFDmUPNDYP0Qla+1juAFRcCp6bQiLDQmQ==
X-Received: by 2002:ac2:4573:: with SMTP id k19mr7020021lfm.144.1587072416039;
        Thu, 16 Apr 2020 14:26:56 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id t19sm16008215lfl.53.2020.04.16.14.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:26:54 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Apr 2020 23:26:46 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416212630.GA11872@pc636>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
 <20200416195327.GW17661@paulmck-ThinkPad-P72>
 <20200416200557.GA11301@pc636>
 <20200416202530.GX17661@paulmck-ThinkPad-P72>
 <20200416211838.GA11753@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416211838.GA11753@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 11:18:38PM +0200, Uladzislau Rezki wrote:
> On Thu, Apr 16, 2020 at 01:25:30PM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 16, 2020 at 10:05:57PM +0200, Uladzislau Rezki wrote:
> > > On Thu, Apr 16, 2020 at 12:53:27PM -0700, Paul E. McKenney wrote:
> > > > On Thu, Apr 16, 2020 at 03:26:23PM -0400, Steven Rostedt wrote:
> > > > > On Thu, 16 Apr 2020 14:59:34 -0400
> > > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > 
> > > > > > But, then will it be safe for kfree_rcu() callers from hard IRQ context to
> > > > > > call this in PREEMPT_RT? That could would just break then as you cannot sleep
> > > > > > in hard IRQ context even on PREEMPT_RT.
> > > > > 
> > > > > But where in PREEMPT_RT would it be called in hard IRQ context?
> > > > 
> > > > I believe that call_rcu() is invoked with raw spinlocks held, so we should
> > > > allow kfree_rcu() to be invoked from similar contexts.  It obviously
> > > > cannot allocate memory in such contexts, so perhaps the rule is that
> > > > single-argument kfree_rcu() cannot be invoked within hard IRQ contexts
> > > > or with raw spinlocks held.  In those contexts, you would instead need
> > > > to invoke two-argument kfree_rcu(), which never needs to allocate memory.
> > > > 
> > > > Seem reasonable?
> > > > 
> > > Paul, just to make it more clear, even invoking two arguments fkree_rcu()
> > > currently does an allocation. We maintain an array that contains pointers
> > > for "bulk logic". 
> > 
> > True, but that is an optimization rather than an absolute necessity.
> > In addition, most two-argument kfree_rcu() callers will take another slot
> > from the array that has already been allocated.  So one alternative is
> > to do the allocation only if both interrupts and preemption are enabled.
> > As long as most kfree_rcu() invocations can allocate, you get good
> > performance and things work nicely in -rt.
> > 
> Agree it is not absolutely necessary :) The easiest way is something like that:
> 
> #ifdef CONFIG_PREEMPT_RT
>     if (is_there_any_space_in_array())
>         put_the_pointer_into_arry()
> 	finish.
>     else
>         queue_it_using_rcu_head_helper()
> #endif
>

Sorry, somme correction:

#ifdef CONFIG_PREEMPT_RT
     if (is_there_any_space_in_array())
         put_the_pointer_into_arry()
     else if (not in irq && not in NMI)
        alloca_page_and_put_ptr_there();
     else
         queue_it_using_rcu_head_helper()
#endif

--
Vlad Rezki
