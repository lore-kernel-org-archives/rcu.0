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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32804C432BE
	for <rcu@archiver.kernel.org>; Wed, 18 Aug 2021 23:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11EB460FE8
	for <rcu@archiver.kernel.org>; Wed, 18 Aug 2021 23:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhHSAAA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Aug 2021 20:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhHRX76 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Aug 2021 19:59:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0014C061764;
        Wed, 18 Aug 2021 16:59:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w6so2854983plg.9;
        Wed, 18 Aug 2021 16:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IeP832SJzqeVnjZ0PVnLToyHfJsIkOgVQujTdfwewaQ=;
        b=HLvCFvJRIjjfuLDY2SGy0zjxO1rqlnS5OZVluJmJva8WUFGPnr1EArc6LykYJOVHK7
         y3Hs14pTxjX3RqjaxWI1ZD7Dq6p0uYUjKNYgoJjmhVy4dXmanVOVeo+pA4mZgYoU3tLG
         Gt1NzLtKzwa8yM/xW3zTSvq5f322qSXxX8IkSYFnklyhfP7GDs4kRPyn26ahyR4eYnKt
         XxH1FP9J8ZwySSmXr4/FkuF6PeLumbkkCixFT3OKjXUYwWl8AcbTV1uEAlGlNwNowyHL
         rc8lt6do5MV5CBcYsYG2H5awZo6oTwpGiL3pWmzvFMW9B5+DcRpgbL1ImaUmW5aSuBq9
         JPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IeP832SJzqeVnjZ0PVnLToyHfJsIkOgVQujTdfwewaQ=;
        b=DGmnU3NZP6yWRrLCO0KoUkDjBv48q4mGVbbzUQ9Nt2in+X2cjOCOhfL4F0zj4Nznf7
         7C52ty9U33TACLsPQRLoKVDBT7t1L9RcKMFoef1cBOX8myBNxy0Mj5597b+6sKCTVxXa
         5bg5igtuW0SydtcO1hjMSpRcHylHy3QsGg5N10UYSRp+OHzehtXoxNBufRfKUQf9awKE
         thX/Dft/sMynUTGLAmC86Z3RMh3OON3iJnggjDtLfzNojaYY5H/1owIa9+KYEPTzxc3q
         iUpKYYbiRPltD1r8OSgompzA2LL17NF9DW9lb8CVyKCviW04hodisOSuO7TjF6mzbd6w
         DX2g==
X-Gm-Message-State: AOAM531tOzBl0bA4s7h5nRAXhJne0GxCKNSwlGYVysgHQE0txqljL4Kh
        ADUON9CpDhtdBGILEpgkqdA=
X-Google-Smtp-Source: ABdhPJxHhgQmZvA13GqpT391mhTAohwHcoo5bDGNyhSgVMeZm7R7WZ66RBmasYP+9jnUaRyaCJvYBA==
X-Received: by 2002:a17:90a:2f88:: with SMTP id t8mr11919550pjd.2.1629331162314;
        Wed, 18 Aug 2021 16:59:22 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id k25sm894131pfa.213.2021.08.18.16.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:59:21 -0700 (PDT)
Date:   Thu, 19 Aug 2021 07:59:16 +0800
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
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] preempt: add in_serving_irq() and apply to rcutiny and
 vsprintf
Message-ID: <20210818235916.l3zbdt5nli5j65xi@mail.google.com>
References: <20210814014234.51395-1-changbin.du@gmail.com>
 <YRqMRFPDL0U9Orec@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRqMRFPDL0U9Orec@boqun-archlinux>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 17, 2021 at 12:03:16AM +0800, Boqun Feng wrote:
> On Sat, Aug 14, 2021 at 09:42:34AM +0800, Changbin Du wrote:
> > At some places we need to determine whether we're in nmi, hardirq or
> > softirq context. This adds a macro in_serving_irq() as a shortcut for
> > that.
> > 
> > Meanwhile, apply this new macro to existing code in rcutiny and vsprintf.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  include/linux/preempt.h | 4 +++-
> >  include/linux/rcutiny.h | 3 +--
> >  lib/vsprintf.c          | 2 +-
> >  3 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> > index 9881eac0698f..9a1c924e2c6c 100644
> > --- a/include/linux/preempt.h
> > +++ b/include/linux/preempt.h
> > @@ -92,12 +92,14 @@
> >   * in_nmi()		- We're in NMI context
> >   * in_hardirq()		- We're in hard IRQ context
> >   * in_serving_softirq()	- We're in softirq context
> > + * in_serving_irq()	- We're in nmi, hardirq or softirq context
> >   * in_task()		- We're in task context
> >   */
> >  #define in_nmi()		(nmi_count())
> >  #define in_hardirq()		(hardirq_count())
> >  #define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
> > -#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
> > +#define in_serving_irq()	(in_nmi() | in_hardirq() | in_serving_softirq())
> > +#define in_task()		(!in_serving_irq())
> >  
> 
> So in_serving_irq() is !in_task(), right? If so, why not...
> 
Adding in_serving_irq() is to reflect the real purpose so improve readability.
And can we preserve that !in_task() means in serving irq context in future? I don't know.

-- 
Cheers,
Changbin Du
