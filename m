Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96013C2BA2B
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 20:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E4A206A2
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 20:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dx8vfodY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgDPUgl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgDPUgk (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 16:36:40 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E05C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 13:36:39 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id x66so52836qkd.9
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q0vd3JQ3YK/q3AttaSjev2rbg1zUfXEqBIcNF6yVS2w=;
        b=dx8vfodYb6vFoLlXS7T6LCTTxWj+cj5T1GaWlDiKF69HmqNUDGvSflSRWQYE9nix+G
         tdmrtyehxwPq5/ItRV2lOANjeH5uZY8lhJhOUO9HVyK+oDFWURL03bI0kXxRQxTS2PYh
         Pvn0PWvR7v6CR13qFWlFrtov7NTHjqa2r7/uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q0vd3JQ3YK/q3AttaSjev2rbg1zUfXEqBIcNF6yVS2w=;
        b=hd2ZWbYkLQ73mBDA41QqMMJT3NbPt//XzicEgLw5z+nHMp5ImBzU6FmZVM82RfL6w2
         hSVVC2IRwa8oc0JLQhMRqn3WN9ofWfULAZ47hLd2TNcNjqCtvKyNLXtQHrcB3AzLiSyy
         UdYSRJh7O1KW8FxsBkE/Kx2FYqmoE+VW7MhafldoK9eixtqQiX4oPfDFO93H+gkLKLqQ
         Uy5FBrf4Xh2SkPIvFpfQNF19Sse4eVAk4sPqAlkVDr50zuRz5xGgZV1EaDYdkV/o64yR
         pvIlmJeU4JzBi4MPSFgtp9nlnApiskjfMQ8NwN8tDCGq8CtADrjzG4LJ/ek+TBI6qKK2
         xOlw==
X-Gm-Message-State: AGi0PuYzK/aQ8fSveK3LmBCu834b5US4pN95kdqf5Ar4B99G2Gq+i7P8
        3F0Fu2Q76ryjVvtGhBHfMg1qhA==
X-Google-Smtp-Source: APiQypL/EwWTzNhyDbIdg6UUsnuuJNq+3rA2Tq97RtlmJBOmyBaKIABN40Zbw/+hSfZ4rfFypwKyGA==
X-Received: by 2002:a05:620a:556:: with SMTP id o22mr21866240qko.166.1587069398289;
        Thu, 16 Apr 2020 13:36:38 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d189sm15804599qkf.118.2020.04.16.13.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:36:37 -0700 (PDT)
Date:   Thu, 16 Apr 2020 16:36:37 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416203637.GA176663@google.com>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416152623.48125628@gandalf.local.home>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 03:26:23PM -0400, Steven Rostedt wrote:
> On Thu, 16 Apr 2020 14:59:34 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > But, then will it be safe for kfree_rcu() callers from hard IRQ context to
> > call this in PREEMPT_RT? That could would just break then as you cannot sleep
> > in hard IRQ context even on PREEMPT_RT.
> 
> But where in PREEMPT_RT would it be called in hard IRQ context?

I am not saying that it is called now, but in the future if it is called for
an interrupt that is not threaded on -rt, it would be a problem right?

> Note, most interrupt handlers in PREEMPT_RT are turned into threads (except
> for a very few, which shouldn't be calling kfree_rcu()).

Yes those very few is what I was referring to. It also sounds like from the
other thread, Paul is saying it should be allowed to be called from some
contexts that are not sleepable. In those cases also the rtmutex will fall
apart.

thanks,

 - Joel

