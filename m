Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44244C2BA2B
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF0A2076D
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Xoy8qVGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgDPVCP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726296AbgDPVCP (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 17:02:15 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3694AC061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 14:02:15 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id s18so2836837qvn.1
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 14:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pro10VSUsnQvNNOskdMjHTIcTeM6EYFJiJZf9fKyfX0=;
        b=Xoy8qVGApcqv0DBqFKrh0zg4mCClB5Epise+IxxUMOT5UqkYBw1LobQAsXppPJowIQ
         80Z5lbNkqN/E04N9ahICAA45WYX0FVSzGB4+mocFEn5Bwcjr7UseXpslO3uGPqQD78Vz
         +y4mE4qCB1oDUz71UUzZbS4dP3vkB1sO21yFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pro10VSUsnQvNNOskdMjHTIcTeM6EYFJiJZf9fKyfX0=;
        b=I8924wP6r7vUnDwQZ0SElQb89H4nZWQMAX0+uln6OFumpVJ9FN0MWXWYiE/IidGbHg
         KdmmdrOIZ0V/5W2JcIzIN7fd2tjT96cM29vp7L9Nze9bKUKr0/3dmBoNCSTmGtUZow30
         H7IqS7ujAL5H+xEBcRziciZdpaQ1gMzsJfHmbepxcy8CFXM4FSKjf03VqzvpVbDO+d3v
         brYZeO+06Fugl9uKMgft48P0ePWesr48TUaExebrLMppw4QmM+dm5u1Pfpzlbx15A7XH
         LoZGfhofajh1nv+JGHHLRbzQncfskti34HYcDGeietVXSqKiyMcKbr0RNBLa3meVbzjp
         UjWQ==
X-Gm-Message-State: AGi0PuaxizleN5vdmSpNLazex9tf5INfQ3LdLzCncYtvS8X5bYMPk5AX
        n0PDmK4ab81xssLN/0G4wV7Ohg==
X-Google-Smtp-Source: APiQypLwmgtR2/9aN6VXpMX9cHz1aj02SE4Va+QPi01oGW8RFCmtS/z3GfDGix8MhAnABAfxrwRdvQ==
X-Received: by 2002:a05:6214:17c8:: with SMTP id cu8mr12386863qvb.178.1587070934343;
        Thu, 16 Apr 2020 14:02:14 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x55sm6743536qtk.3.2020.04.16.14.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:02:13 -0700 (PDT)
Date:   Thu, 16 Apr 2020 17:02:13 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416210213.GC176663@google.com>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
 <20200416195327.GW17661@paulmck-ThinkPad-P72>
 <20200416200557.GA11301@pc636>
 <20200416202530.GX17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416202530.GX17661@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 01:25:30PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 16, 2020 at 10:05:57PM +0200, Uladzislau Rezki wrote:
> > On Thu, Apr 16, 2020 at 12:53:27PM -0700, Paul E. McKenney wrote:
> > > On Thu, Apr 16, 2020 at 03:26:23PM -0400, Steven Rostedt wrote:
> > > > On Thu, 16 Apr 2020 14:59:34 -0400
> > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > 
> > > > > But, then will it be safe for kfree_rcu() callers from hard IRQ context to
> > > > > call this in PREEMPT_RT? That could would just break then as you cannot sleep
> > > > > in hard IRQ context even on PREEMPT_RT.
> > > > 
> > > > But where in PREEMPT_RT would it be called in hard IRQ context?
> > > 
> > > I believe that call_rcu() is invoked with raw spinlocks held, so we should
> > > allow kfree_rcu() to be invoked from similar contexts.  It obviously
> > > cannot allocate memory in such contexts, so perhaps the rule is that
> > > single-argument kfree_rcu() cannot be invoked within hard IRQ contexts
> > > or with raw spinlocks held.  In those contexts, you would instead need
> > > to invoke two-argument kfree_rcu(), which never needs to allocate memory.
> > > 
> > > Seem reasonable?

In current rcu/dev, we do GFP_NOWAIT and in all WIP/future patches, we would
be doing GFP_NOWAIT in all scenarios, so would RT really have a problem with
memory allocation?

Or, is the issue that -RT needs memory allocation to finish in bounded time?

Either way, I believe our last discussion led to not retrying hard and not
sleeping during allocation so -RT should be good I think. I believe
Sebastian's main motivation is to just make the code preemptible but I am not
fully sure.

> > Paul, just to make it more clear, even invoking two arguments fkree_rcu()
> > currently does an allocation. We maintain an array that contains pointers
> > for "bulk logic". 
> True, but that is an optimization rather than an absolute necessity.
> In addition, most two-argument kfree_rcu() callers will take another slot
> from the array that has already been allocated.  So one alternative is
> to do the allocation only if both interrupts and preemption are enabled.
> As long as most kfree_rcu() invocations can allocate, you get good
> performance and things work nicely in -rt.

As per my understanding, we can't detect context dynamically to do different
things without the calling code telling us. I also landed on some LWN
articles on the topic. I tried this last weekend: preemptible() would not
know whether the code is called in a sleepable context or not on
!CONFIG_PREEMPT so can't be used as a signal. For this to work, it seems
CONFIG_PREEMPT_COUNT also has to be enabled (which AIUI is possible to be
enabled only on debug kernels). Hopefully I didn't miss something about that.

thanks,

 - Joel

