Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C83C4338F
	for <rcu@archiver.kernel.org>; Thu, 19 Aug 2021 23:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063D26109E
	for <rcu@archiver.kernel.org>; Thu, 19 Aug 2021 23:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhHSXBa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Aug 2021 19:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhHSXB3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Aug 2021 19:01:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1125AC061575;
        Thu, 19 Aug 2021 16:00:53 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n5so6049631pjt.4;
        Thu, 19 Aug 2021 16:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DIgqo2OBXJoSdsCXTz7ku1pCk/8Xq00XM5YE8fnBA3c=;
        b=qJmCsZl/7c7CrNxr5BeAzpbyRaIj4CTi71d4ya0o988dXB/WH3KlfgindcSZnWYyRV
         Ukc/s/w2eFzKGtXf8WNjDWfz/dvb3KqmYDQ8z2kIEt8MhupcUFcssDbugqSgsfrIJgKJ
         pPVR3sBsZqs3uqLzKmRp3wPrrFTk8ZZ5IVn2NN9Y+/op0+LrZDnRH02CEZG3nF1qJkrO
         948yknzg0cLJ/jSH4wwetmRUUghwCiONq415/IszMmf/IGrXwEROlgrL15ksf9++XEiv
         Hpal1bys7Wk4DCLQghBkitpSstWPRZt2dAmg9Dxjc//7P/eo4lJ6ht/tbnfQ1i8FJZAg
         1ulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DIgqo2OBXJoSdsCXTz7ku1pCk/8Xq00XM5YE8fnBA3c=;
        b=K5eKX2F1oKdI5lnpuSVnvaULPLEikicUuMlaRVwy7iUm8QIegD39rclg+lfWJk7FSr
         L+kWmhjw8yrRjp3LHKVh9E6uAm6Raei2BqPS6ohvYLtPDz6ZGl9YTTrd/BJ7XD93Zkpe
         Vfwz6A5i8qReGIBq1u7flFM+I1gtpRYFdEhQwX68lgFLIrgMGqr+TSSbTrxocHFiW3w3
         Ixn3qcIyVPc/e/+SlTFUfS3W95czoBafWNUe86dkGV6gerINudPGEONf7uS/E1LwPX/9
         BFHS9G4ErEXc8Z4pxaH2ZQSom26IlZmTIZFv5801fBJYsaAhCddWb5ioLwefQ7RxYH0P
         2Bkg==
X-Gm-Message-State: AOAM532KCQHV9M52M0/Or04hFq8P0fov97hZYCc2qkLp1SXyI2udW5go
        +iRQuVRnCZVuQx1s+qm/nDA=
X-Google-Smtp-Source: ABdhPJzaqWhuQOd1LdSu4ygw8RqzKGl56Rk5PrZIjVcr1FEm4928nb4+0CLH792Y2Plup0E5U6h0AQ==
X-Received: by 2002:a17:90a:9af:: with SMTP id 44mr1238095pjo.62.1629414052470;
        Thu, 19 Aug 2021 16:00:52 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id g26sm5413228pgb.45.2021.08.19.16.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 16:00:52 -0700 (PDT)
Date:   Fri, 20 Aug 2021 07:00:36 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] preempt: add in_serving_irq() and apply to rcutiny and
 vsprintf
Message-ID: <20210819230036.uh2amndgsyza6az7@mail.google.com>
References: <20210814014234.51395-1-changbin.du@gmail.com>
 <YRqMRFPDL0U9Orec@boqun-archlinux>
 <20210818235916.l3zbdt5nli5j65xi@mail.google.com>
 <YR26XQF3OXLqo4Pj@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR26XQF3OXLqo4Pj@boqun-archlinux>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 19, 2021 at 09:56:45AM +0800, Boqun Feng wrote:
> [Cc Thomas and Frederic since they contributed the clean-up to these
> macros recently]
> 
> Background for discussion:
> 
> 	https://lore.kernel.org/lkml/20210814014234.51395-1-changbin.du@gmail.com/
> 
> On Thu, Aug 19, 2021 at 07:59:16AM +0800, Changbin Du wrote:
> > On Tue, Aug 17, 2021 at 12:03:16AM +0800, Boqun Feng wrote:
> > > On Sat, Aug 14, 2021 at 09:42:34AM +0800, Changbin Du wrote:
> > > > At some places we need to determine whether we're in nmi, hardirq or
> > > > softirq context. This adds a macro in_serving_irq() as a shortcut for
> > > > that.
> > > > 
> > > > Meanwhile, apply this new macro to existing code in rcutiny and vsprintf.
> > > > 
> > > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > > ---
> > > >  include/linux/preempt.h | 4 +++-
> > > >  include/linux/rcutiny.h | 3 +--
> > > >  lib/vsprintf.c          | 2 +-
> > > >  3 files changed, 5 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> > > > index 9881eac0698f..9a1c924e2c6c 100644
> > > > --- a/include/linux/preempt.h
> > > > +++ b/include/linux/preempt.h
> > > > @@ -92,12 +92,14 @@
> > > >   * in_nmi()		- We're in NMI context
> > > >   * in_hardirq()		- We're in hard IRQ context
> > > >   * in_serving_softirq()	- We're in softirq context
> > > > + * in_serving_irq()	- We're in nmi, hardirq or softirq context
> > > >   * in_task()		- We're in task context
> > > >   */
> > > >  #define in_nmi()		(nmi_count())
> > > >  #define in_hardirq()		(hardirq_count())
> > > >  #define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
> > > > -#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
> > > > +#define in_serving_irq()	(in_nmi() | in_hardirq() | in_serving_softirq())
> > > > +#define in_task()		(!in_serving_irq())
> > > >  
> > > 
> > > So in_serving_irq() is !in_task(), right? If so, why not...
> > > 
> > Adding in_serving_irq() is to reflect the real purpose so improve readability.
> > And can we preserve that !in_task() means in serving irq context in future? I don't know.
> > 
> 
> Sure, no one could predict the future. But if a third context (other
> than thread context and {hard,soft}irq context) comes up, which I think
> is highly unlikely, we could (and should) audit all callsites of
> in_task() for necessary adjustment. And introducing in_serving_irq()
> won't help us in that case, because we will still need to audit usage of
> in_serving_irq(), for example, let's say rcu_is_idle_cpu() for RCU_TINY
> is defined as
> 
> 	#define rcu_is_idle_cpu(cpu) (is_idle_task(current) && !in_serving_irq())
> 
> and we have a new type of context, and we can use in_other() to test
> whether we are in it. Now even with in_serving_irq() introduced, we
> still need to make sure the correct version of rcu_is_idle_cpu() is
> either
> 
> 	(is_idle_task(current) && (!in_serving_irq() && !in_other()))
> 
> or
> 	
> 	(is_idle_task(current) && !in_serving_irq())
> 
> Therefore, I don't see the point of introducing in_serving_irq().
>
ok, as in_serving_irq() is only used in two places, it is not common to judge if
it is in serving irq context. So this new macro doesn't help much.

> Regards,
> Boqun
> 
> > -- 
> > Cheers,
> > Changbin Du

-- 
Cheers,
Changbin Du
