Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E40DC4167B
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 05:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiLaF2T (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Dec 2022 00:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiLaF2R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Dec 2022 00:28:17 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C33B178B2
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 21:28:15 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f20so23956037lja.4
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 21:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0v8A16IlYe9iAmv9A0MG7UO6i8I/FnlGv6CIM4NO+rg=;
        b=Q351QOWRgyG5EBfPJZ1SIM9vQ88jX4NaezHkbs7+CI5/ta2wm1+/+shSPYvOA7zpKp
         r/bzNfw8aumj/YdNrF1iJ3vJ3IhsoZQWauCnEu0q/krBTcM0/o9AY5Ryg2Nyry2eDAxU
         9tQiCHQrotIvsWXDgFRjP6KUJ0K9S0hvKV0+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0v8A16IlYe9iAmv9A0MG7UO6i8I/FnlGv6CIM4NO+rg=;
        b=nxqEHd5veHDHJs4jcjT9aOpFhzLIqEmbbXsl5250tsnNi1kb14qdLqFmP9wz65vF6h
         x/CAddk8RBxzOtYyMeRWCEoLoIC3UI2sAeD76yWh7WVMD9y6qnDPDrN5ALx5lO7yq/RL
         F61jooczOaKWSmr3rcpccnovhtWi7/SMJ2xYMzRTjYUZ5WdL/ksAv+opXnWcxaOoSbiy
         LjgZ7t7ifP3eakrNIuv89gwLhPucGxVRfQOzZK3N7hwvzQLFM7JmAGc2yutSLT0IIyDJ
         o7yKYa30FMz1azrDv+RFH2kgwmayx1f9fYTQFCToI9+VmUBGozckjTgJC+O4e+QQJZtM
         0TOA==
X-Gm-Message-State: AFqh2koEaGf8JMeUoHJwgYLUs3ro2p6sg2i5OrJTu279cZDkpAd+Cvyo
        Q3XXQpWRvLZJ7SzEVHjA/BjHRrpTmcanbchfPeTaAebqLbUh508idqQ=
X-Google-Smtp-Source: AMrXdXueuyUBYO0TZcq0TvPwAhGd8xM2uTQizMM7YdSZU0/9qkCqiiclbEUd06KxLsmmNx8QRs7J0TF2gkQ1ulo7JoQ=
X-Received: by 2002:a2e:3c15:0:b0:27f:dca1:8584 with SMTP id
 j21-20020a2e3c15000000b0027fdca18584mr512645lja.313.1672464493924; Fri, 30
 Dec 2022 21:28:13 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 31 Dec 2022 00:28:10 -0500
Message-ID: <CAEXW_YStxQFB1qRyHhqFE_hjeO2f+_U-=KY07SewM0LHWv2Q+g@mail.gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
To:     paulmck@kernel.org
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 30, 2022 at 9:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Dec 30, 2022 at 08:42:24PM -0500, Joel Fernandes wrote:
> > Hello,
> >
> > I have been firefighting a hang on 6.0.y stable kernels with
> > rcutorture. It happens mostly consistently when TREE07 is shutting
> > down.
> >
> > It appears that the RCU torture threads are attempted to stop but the
> > shutdown thread, but are constantly awakened by a timer softirq
> > handler in ksoftirqd context. When they wake up, they immediately goto
> > sleep in uninterruptible state until the next time a timer handler
> > wakes them up. It appears the timer softirq is long enough to cause
> > RCU stalls and I see it calling 100s of timer function handlers
> > (call_timer_fn).
> >
> > I am doing some more investigation with trace_printk(s):
> > https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=stable/trace-hang-6.0.y&id=b779b1e92c97f29333a282ee8f548da02f64de2b
> >
> > Regarding the timer handlers, I was wondering if it is possible that a
> > large number of timer handlers constantly queued can cause RCU stalls
> > due to the timer softirq taking a very long time. That certainly
> > appears to be the case here. Shouldn't the timer softirq also do
> > rcu_softirq_qs() similar to the ksoftirq loop, in case there are too
> > many of them?
>
> That is certainly a good thing to try!

I am trying something like this just for testing, let's see what happens ;-)

@@ -1788,9 +1796,14 @@ static inline void __run_timers(struct timer_base *base)

                while (levels--)
                        expire_timers(base, heads + levels);
+
+               rcu_softirq_qs();
        }

I guess I am also wondering why the rcu reader does not stop queuing
timers. It is doing schedule_timeout_interruptible() constantly even
though the test is being stopped.

thanks,

 - Joel
