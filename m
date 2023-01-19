Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1977C004D4
	for <rcu@archiver.kernel.org>; Thu, 19 Jan 2023 17:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjASRGp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjASRGn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Jan 2023 12:06:43 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D79382D72
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 09:06:41 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d30so4155822lfv.8
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 09:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bZgElKE+M6zPeGQ50PJSNi64y0Huvpk+yfU5mO8GMQ8=;
        b=Z1+X5u73zLWbRJIlRmxmmrKkFNMZ6vs8cT1hYVwktFOrR9+fiBm0Csn7zhfgjskvzr
         gC/w0L4J1BAzFHnK/wBhirlzFK+c2HXh7eTWLBfxXm43KxHIb8j9Pwl0RfEQ/7GAoayv
         8ZuGAD254vZYE3R8UK2aeR0hUsQiqLzeKAQqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZgElKE+M6zPeGQ50PJSNi64y0Huvpk+yfU5mO8GMQ8=;
        b=KYBx4yyc11umUZPylP4qtdnfylDdpmDtRAY4ZYD6CYflBMu46805XKQ68it8wVnNd6
         WMpwy9GiBbt7MXbzoUfiSMmpkVuHUTynUPvc5HyG0p7A3Y2hfMvHO/W4qddIAW1aHb7a
         kAArj0HkxF2tkCZbkK1DqJ0b3ADw2/Sm0tB8C0oJKo7GEEs6AB3wD3edfKyJkAsfh8pm
         AY9EF58E6dafYv5J/Rd3OxNx53Mgb7/G05n+qs5e9m/DYmx+RzhUIdqY+3p/i7LmSSp8
         qdNQyZOGnliMvatFZU/vSJaXODJi24zk7wRJ9k6WfXhJmzTVNpE16IHO1CtoVfX/cqxd
         pK7Q==
X-Gm-Message-State: AFqh2krI0FqAjeRez1RJh9si4GYLPd0H//XchV5KLCqG36b+ILexo0mk
        m0MSwLKcqkNddWHnuqMzoniy54I+LRI1QjX4d0EnSA==
X-Google-Smtp-Source: AMrXdXuuIJi2iX6baqynlQkpJQKthFNS/P46R+NVmgN+ZUumXwU0CTrZtql19XN9Yfc/LlPJMkos6m8wjyjtxo+2QKs=
X-Received: by 2002:ac2:4856:0:b0:4d1:afe6:423c with SMTP id
 22-20020ac24856000000b004d1afe6423cmr878254lfy.84.1674147999189; Thu, 19 Jan
 2023 09:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20230119141134.686626-1-frederic@kernel.org> <Y8lQjKKDd0G2zt3F@lothringen>
In-Reply-To: <Y8lQjKKDd0G2zt3F@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 19 Jan 2023 17:06:27 +0000
Message-ID: <CAEXW_YRhYHZRudo5ano+K4-k54Ts+y2_npcXJNaT28SPCmqNnw@mail.gmail.com>
Subject: Re: [PATCH] rcu: Further comment and explain the state space of GP sequences
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        quic_neeraju@quicinc.com, Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 19, 2023 at 2:15 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Thu, Jan 19, 2023 at 03:11:35PM +0100, Frederic Weisbecker wrote:
> > The state space of the GP sequence number isn't documented and the
> > definitions of its special values are scattered. Try to gather some
> > common knowledge near the GP seq headers.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/rcu.h | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 115616ac3bfa..fb95de039596 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -14,6 +14,39 @@
> >
> >  /*
> >   * Grace-period counter management.
> > + *
> > + * The two lowest significant bits gather the control flags.
> > + * The higher bits form the RCU sequence counter.
> > + *
> > + * About the control flags, a common value of 0 means that no GP is in progress.
> > + * A value of 1 means that a grace period has started and is in progress. When
> > + * the grace period completes, the control flags are reset to 0 and the sequence
> > + * counter is incremented.
> > + *
> > + * However some specific RCU usages make use of custom values.
> > + *
> > + * SRCU special control values:
> > + *
> > + *   SRCU_SNP_INIT_SEQ       :       Invalid/init value set when SRCU node
> > + *                                                   is initialized.
> > + *
> > + *   SRCU_STATE_IDLE         :       No SRCU gp is in progress
> > + *
> > + *   SRCU_STATE_SCAN1        :       State set by rcu_seq_start(). Indicates
> > + *                                                           we are scanning the inactive readers
> > + *                                                           index.

The term "inactive reader" is confusing. The readers can very much be
active during scans. During a scan stage, there might be a reader on
any of the 2 indexes that can be right in the middle of their critical
section (and we don't know which index because they could have got
preempted, right after sampling idx). Maybe "inactive slot" is a
better term? And define "inactive slot" as the slot which is no longer
going to be sampled by new readers.

> > + *
> > + *           SRCU_STATE_SCAN2        :       State set manually via rcu_seq_set_state()
> > + *                                                           Indicates we are flipping the readers
> > + *                                                           index and then scanning the newly inactive
> > + *                                                           readers index.
> > + *
> > + * RCU polled GP special control value:
> > + *
> > + *   RCU_GET_STATE_COMPLETED :       State value indicating that a polled GP
> > + *                                                           has completed. It's an absolute value
> > + *                                                           covering both the state and the counter of
> > + *                                                           the GP sequence.

This part I still have to learn (polling) so I'll go do that. But
otherwise your patch LGTM and thanks for doing it.

 - Joel

> >   */
> >
> >  #define RCU_SEQ_CTR_SHIFT    2
> > --
> > 2.34.1
> >
>
> Ok perhaps this one got the tabs right:
>
> ---
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Thu, 19 Jan 2023 14:29:34 +0100
> Subject: [PATCH v2] rcu: Further comment and explain the state space of GP
>  sequences
>
> The state space of the GP sequence number isn't documented and the
> definitions of its special values are scattered. Try to gather some
> common knowledge near the GP seq headers.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/rcu.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 115616ac3bfa..fb95de039596 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -14,6 +14,39 @@
>
>  /*
>   * Grace-period counter management.
> + *
> + * The two lowest significant bits gather the control flags.
> + * The higher bits form the RCU sequence counter.
> + *
> + * About the control flags, a common value of 0 means that no GP is in progress.
> + * A value of 1 means that a grace period has started and is in progress. When
> + * the grace period completes, the control flags are reset to 0 and the sequence
> + * counter is incremented.
> + *
> + * However some specific RCU usages make use of custom values.
> + *
> + * SRCU special control values:
> + *
> + *     SRCU_SNP_INIT_SEQ       :       Invalid/init value set when SRCU node
> + *                                     is initialized.
> + *
> + *     SRCU_STATE_IDLE         :       No SRCU gp is in progress
> + *
> + *     SRCU_STATE_SCAN1        :       State set by rcu_seq_start(). Indicates
> + *                                     we are scanning the inactive readers
> + *                                     index.
> + *
> + *     SRCU_STATE_SCAN2        :       State set manually via rcu_seq_set_state()
> + *                                     Indicates we are flipping the readers
> + *                                     index and then scanning the newly inactive
> + *                                     readers index.
> + *
> + * RCU polled GP special control value:
> + *
> + *     RCU_GET_STATE_COMPLETED :       State value indicating that a polled GP
> + *                                     has completed. It's an absolute value
> + *                                     covering both the state and the counter of
> + *                                     the GP sequence.
>   */
>
>  #define RCU_SEQ_CTR_SHIFT      2
> --
> 2.34.1
>
