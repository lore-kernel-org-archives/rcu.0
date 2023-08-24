Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20114C6FA8F
	for <rcu@archiver.kernel.org>; Thu, 24 Aug 2023 13:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbjHXNWU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Aug 2023 09:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbjHXNWA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Aug 2023 09:22:00 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520CB19A9
        for <rcu@vger.kernel.org>; Thu, 24 Aug 2023 06:21:57 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79241bb5807so108090439f.0
        for <rcu@vger.kernel.org>; Thu, 24 Aug 2023 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692883316; x=1693488116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uBq+bzB7lscqikmSJhAFXBiktCV1gBbXEMWl3afWAOE=;
        b=o5dnZDcGUXqzt+x38Q9THJr6mkJ/ZPbZp2c1dSzm1oq2f84mhbL4T/QUsk6TOkXEwB
         rn4IK71ZT0VgTpC45tbN0UtU//K1rSY4cx6VE0cqNwYCerZcprGlwLyUPlhefayczlH7
         QFwQmc6flCefuHkV3qDJaImAtKhBileWEkADw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883316; x=1693488116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBq+bzB7lscqikmSJhAFXBiktCV1gBbXEMWl3afWAOE=;
        b=POjf1vACZ2tOphEGRO91qcoArBhODPEc1Wp6hlWKWWNcHQgCpZoMVtchN7hGEy72iZ
         jnub2TgCoavLcVwKEOE8RAtFKjMx5Xq0JDYhkggQomxZxcVlLLKnD5i8Ud0kwgKpdc99
         NTk7nR0K1x0PEH+b/d0w5erTq9SBfPQJjjWDAvP+AcIuknfIGagg5HC8sV51x+/9bf61
         5z3LocFw0XWgZXfqp3EYwm1+vVHiRrG43DmjATKmA75ewtlyLnY6ga4i9pNdh33m38+I
         Zn4zv+YlqDuNLQ9NqGPjb3eiqq7dyPkqHi7SbALB1y5IOMrVMBs+UKfwuGLY5ohBdd6w
         iVuA==
X-Gm-Message-State: AOJu0YwQD3p+e0vOplklCZn3710NxIdBWI0PaLnf314EXoZsPk3qY1t3
        Ks8YpnJsr51V/jalBaEp7HFSrg==
X-Google-Smtp-Source: AGHT+IFjWHnHBpCiFQH1AzAPX4bose/q+fwlgVd4v2eWmDLjFu9ry/Xs4MGnldrAr5VfE4TnbHY8pw==
X-Received: by 2002:a5e:990c:0:b0:786:cd9c:cfa2 with SMTP id t12-20020a5e990c000000b00786cd9ccfa2mr6035587ioj.0.1692883316587;
        Thu, 24 Aug 2023 06:21:56 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id b20-20020a02c994000000b0042b08954dc3sm4371841jap.33.2023.08.24.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:21:56 -0700 (PDT)
Date:   Thu, 24 Aug 2023 13:21:55 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Z qiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Message-ID: <20230824132155.GB3810470@google.com>
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
 <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttspct76.ffs@tglx>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello Thomas,

On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wrote:
> On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > On Thu, Aug 17, 2023 at 3:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >> > If  do_update_jiffies_64() cannot be used in NMI context,
> >>
> >> Can you not make the jiffies update conditional on whether it is
> >> called within NMI context?
> 
> Which solves what? If KGDB has a breakpoint in the jiffies lock held
> region then you still dead lock.

Yes, we had already discussed this that jiffies update is not possible from
here. There are too many threads since different patch revisions were being
reviewed in different threads.

> >> I dislike that..
> > Is this acceptable?
> >
> > void rcu_cpu_stall_reset(void)
> > {
> >         unsigned long delta;
> >
> >         delta = nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns());
> >
> >         WRITE_ONCE(rcu_state.jiffies_stall,
> >                    jiffies + delta + rcu_jiffies_till_stall_check());
> > }
> >
> > This can update jiffies_stall without updating jiffies (but has the
> > same effect).
> 
> Now you traded the potential dead lock on jiffies lock for a potential
> live lock vs. tk_core.seq. Not really an improvement, right?
> 
> The only way you can do the above is something like the incomplete and
> uncompiled below. NMI safe and therefore livelock proof time interfaces
> exist for a reason.

Yes, I had already mentioned exactly this issue here of not using an NMI-safe
interface:
https://lore.kernel.org/all/CAEXW_YT+uw5JodtrqjY0B2xx0J8ukF=FAB9-p5rxgWobSU2P2A@mail.gmail.com/
I like your suggestion of using last_jiffies_update though (which as you
mentioned needs to be explored more).

There are too many threads which makes the discussion hard to follow. Huacai,
it would be great if we can keep the discussions in the same thread (Say for
example by passing options like --in-reply-to to "git send-email" command).

thanks,

 - Joel


> 
> Thanks,
> 
>         tglx
> ---
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
>   */
>  static ktime_t last_jiffies_update;
>  
> +unsigned long tick_estimate_stale_jiffies(void)
> +{
> +	ktime_t delta = ktime_get_mono_fast_ns() - READ_ONCE(last_jiffies_update);
> +
> +	return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> +}
> +
>  /*
>   * Must be called with interrupts disabled !
>   */
> 
> 
