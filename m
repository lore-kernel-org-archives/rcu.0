Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32647C433EF
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 14:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiDHOyk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Apr 2022 10:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiDHOyi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Apr 2022 10:54:38 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9515116B5D
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 07:52:34 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z6so10950654iot.0
        for <rcu@vger.kernel.org>; Fri, 08 Apr 2022 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8VRYQ19FRWWgFB7eclpNXP2B+Re0MnAnD9mT5UitObs=;
        b=K1wi6jy6dYdW+QpMSK3lfRGk4zGJJ8ogB8ZcDlfiGH3GEEOszOV9MxSDftrmkKhTz3
         szCu7VsuIjubs5IEfqfb/bfE8LOTX934fRkIGREGB0ChGz9X8hy5IXOCfkarC2fUJRVw
         Hu8rHgf0l2L0a8T1HtK35w2olAaeJfU7uETgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VRYQ19FRWWgFB7eclpNXP2B+Re0MnAnD9mT5UitObs=;
        b=Yh2lllciMUmFM/67pdhUaQZgGD9upNAk6w3esNDDPVytMLiJT9JwWbgMftLPWDp0gL
         swxynaByOPfeD0pCQ8eewRekzBuV1hztN3X0K+ZCXNULsfxEfFpfFrZcT/jKYzlqJsye
         gla7r4C5fIavSjvMTMuxQUwzjrwJbJR0GxBFc/okbn+MzDBXAGOvGdNq+anRb+3gNO6T
         AcFwSHSjCg/9gjcOpyBRFTDKZ5hvr8nlGUBPWmfhp+pzXyMjhBCv5ZSLmXImU9v5YUnc
         e46vKvOFWwfMAjixMFfN4M44XoXOqpneHR3MrzlxF3JS7AfcveRnHJit4T+cvGs3RkIj
         zjXQ==
X-Gm-Message-State: AOAM53374Pf1jRCy8cE1ltmGP3/l82N9Jw+dMcCiG2/Xh80GoOQ+273/
        coJuW7b6s2BIjcQi8QM8oXM52d024TU6OQNO+xq69A==
X-Google-Smtp-Source: ABdhPJz1dIbPRtI2UatBy2KD/GE6d9cFkS0wAFaLtoor9dgLbnw2qoyzh4xp7F/X2+FFjvYqH9TMgWjgexBcH1bqCCM=
X-Received: by 2002:a5e:8d15:0:b0:645:c856:e84a with SMTP id
 m21-20020a5e8d15000000b00645c856e84amr8616203ioj.84.1649429554195; Fri, 08
 Apr 2022 07:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220407210734.2548973-1-joel@joelfernandes.org> <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Apr 2022 10:52:21 -0400
Message-ID: <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for RCU_NOCB_CPU=y
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 8, 2022 at 10:22 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Apr 07, 2022 at 09:07:33PM +0000, Joel Fernandes wrote:
> > On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> > which ends up not offloading any CPU. This patch removes yet another
> > dependency from the bootloader having to know about RCU, about how many
> > CPUs the system has, and about how to provide the mask. Basically, I
> > think we should stop pretending that the user knows what they are doing :).
> > In other words, if NO_CB_CPU is enabled, lets make use of it.
> >
> > My goal is to make RCU as zero-config as possible with sane defaults. If
> > user wants to provide rcu_nocbs= or nohz_full= options, then those will
> > take precedence and this patch will have no effect.
> >
> > I tested providing rcu_nocbs= option, ensuring that is preferred over this.
>
> Unless something has changed, this would change behavior relied upon
> the enterprise distros.  Last I checked, they want to supply a single
> binary, as evidenced by the recent CONFIG_PREEMPT_DYNAMIC Kconfig option,
> and they also want the default to be non-offloaded.  That is, given a
> kernel built with CONFIG_RCU_NOCB_CPU=y and without either a nohz_full
> or a nocbs_cpu boot parameter, all of the CPUs must be non-offloaded.

Just curious, do you have information (like data, experiment results)
on why they want default non-offloaded? Or maybe they haven't tried
the recent work done in NOCB code?

Another option I think is to make it enforce NOCB if NR_CPUS <= 32 if
that makes sense.

> So for me to push this to mainline, I need an ack from someone from each
> of the enterprise distros, and each of those someones needs to understand
> the single-binary strategy used by the corresponding distro.

Ok.

> And is it really all -that- hard to specify an additional boot parameter
> across ChromeOS devices?  Android seems to manage it.  ;-)

That's not the hard part I think. The hard part is to make sure a
future Linux user who is not an RCU expert does not forget to turn it
on. ChromeOS is not the only OS that I've seen someone forget to do it
;-D. AFAIR, there were Android devices too in the past where I saw
this forgotten. I don't think we should rely on the users doing the
right thing (as much as possible).

The single kernel binary point makes sense but in this case, I think
the bigger question that I'd have is what is the default behavior and
what do *most* users of RCU want. So we can keep sane defaults for the
majority and reduce human errors related to configuration.

thanks,

-Joel
