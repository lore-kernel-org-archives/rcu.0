Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A116C77B6C
	for <rcu@archiver.kernel.org>; Thu, 13 Apr 2023 00:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDMAYd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Apr 2023 20:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMAYc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Apr 2023 20:24:32 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBEA2134
        for <rcu@vger.kernel.org>; Wed, 12 Apr 2023 17:24:31 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54bfa5e698eso405363027b3.13
        for <rcu@vger.kernel.org>; Wed, 12 Apr 2023 17:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1681345471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wtul3Z8jJEzUyTGyM60eqK7vbLWh1bkMyVJkOssHu7M=;
        b=rtY0/9OtcurYPtYIapuV/k4bBgvp1yNBP3UXLU61ovIOF9y/ROGOEKmEANW7euSGJg
         p8Gv5AMujfvSmbRylD2GcuNzaksfjuhHh7EDCBsdt4YgEU9kLOTOIUGgeMbMYdx66xt6
         BaywR9zxv7ykjNxurW+lI3iy/ZEH5802jtMck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681345471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wtul3Z8jJEzUyTGyM60eqK7vbLWh1bkMyVJkOssHu7M=;
        b=F86/etwQNa0qsRhl564UY7aWQBEF06pIkGgxclO4/s+M017lPJUgBL7i8l2wOHiQDv
         jZvwecNxGB+L3bUpTP5fi+hYquzwg2R0pS3OaWxhbfRq/rFhH/wrz9NQpl1So9H4g4TT
         TsbdV8zaE5V9NdisVk+epZAbaDeerG/F41IMSRBa6ZeP8PSAqfIqVtj6p+Jl+LOz57Do
         DTZ+JMrcuavDbGK/lCD7HLMOsuoJGZXFrQAuCas6X84TmbpW+HwyazuuEuWJgLIn7wsv
         6gPYcmsP/p8pQmHB99tyPS0B1ujfftjc3IoY9brcA1XwgE1zdVZRRHjEQnu1xMiD+dBm
         skEA==
X-Gm-Message-State: AAQBX9chP9PWg5UTjSIF5Yb9F7tVeyk4alz109oPaysYTnvtdJEOU0PE
        NSGmbJz6aIRQ7JwdGpKo7C4c3Kh0tFEQJlDSVXiQ+UzGZqcZ1d/NDRw=
X-Google-Smtp-Source: AKy350YYq2bMN8DqYdnl/ogFagoOINRW2F2OuIwv3C+B33qpvClV8Jz3MQJBdHaaQsG8/zSEzfvW84GkRp/APU3TB+s=
X-Received: by 2002:a81:ef02:0:b0:545:883a:544d with SMTP id
 o2-20020a81ef02000000b00545883a544dmr224210ywm.9.1681345470692; Wed, 12 Apr
 2023 17:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
 <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz> <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
 <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz> <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
 <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local> <PH0PR11MB58805856C1C47D49D1BA8092DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <eef7fefe-3a0c-31de-0fe3-c8ca8294a0df@bytedance.com>
In-Reply-To: <eef7fefe-3a0c-31de-0fe3-c8ca8294a0df@bytedance.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 12 Apr 2023 20:24:19 -0400
Message-ID: <CAEXW_YQhLsf7NsbGZa5u9kcr2hesAuK_5RKZh+qtSfn_Ha2ugg@mail.gmail.com>
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as raw_spinlock
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhao Gongyi <zhaogongyi@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 12, 2023 at 2:57=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
>
>
>
> On 2023/4/12 14:44, Zhang, Qiang1 wrote:
[..]
> > Maybe no need to convert ->list_lock to raw_spinlock.
> >
> > --- a/lib/debugobjects.c
> > +++ b/lib/debugobjects.c
> > @@ -562,10 +562,10 @@ __debug_object_init(void *addr, const struct debu=
g_obj_descr *descr, int onstack
> >          unsigned long flags;
> >
> >          /*
> > -        * On RT enabled kernels the pool refill must happen in preempt=
ible
> > +        * The pool refill must happen in preemptible
> >           * context:
> >           */
> > -       if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
> > +       if (preemptible())
> >                  fill_pool();
> >
> >          db =3D get_bucket((unsigned long) addr);
>
> Ah, this does fix the warning I was encountered!

Actually fill_pool() should be safe to call on !CONFIG_PREEMPT_RT
kernels as it is GFP_ATOMIC, however with the above change, that goes
away just to satisfy a false-positive report. Because now all
!preemptible() sections on !CONFIG_PREEMPT_RT kernels cannot call
fill_pool(), right? So you will not end up filling the pool when it is
safe to do so?

I think it would be better to fix PROVE_LOCKING / CONFIG_PREEMPT_RT
instead of degrading !CONFIG_PREEMPT_RT just to satisfy a
false-positive report.

+Steven Rostedt as well.

thanks,

 - Joel


>
> >
> >
> >
> > Thanks
> > Zqiang
> >
> >>
> >>
> >> Regards,
> >> Boqun
> >>
> >>>>
> >>>> It's indeed unfortunate for the warning in the commit message. But
> >>>> functions like kmem_cache_alloc(GFP_ATOMIC) may indeed be called
> >>>> in the critical section of raw_spinlock or in the hardirq context, w=
hich
> >>>
> >>> Hmm, I thought they may not, actually.
> >>>
> >>>> will cause problem in the PREEMPT_RT kernel. So I still think it is
> >>>> reasonable to convert kmem_cache_node->list_lock to raw_spinlock typ=
e.
> >>>
> >>> It wouldn't be the complete solution anyway. Once we allow even a GFP=
_ATOMIC
> >>> slab allocation for such context, it means also page allocation can h=
appen
> >>> to refill the slabs, so lockdep will eventually complain about zone->=
lock,
> >>> and who knows what else.
> >>
> >> Oh, indeed. :(
> >>
> >>>
> >>>> In addition, there are many fix patches for this kind of warning in =
the
> >>>> git log, so I also think there should be a general and better soluti=
on. :)
> >>>
> >>> Maybe, but given above, I doubt it's this one.
> >>>
> >>>>
> >>>>>
> >>>>
> >>>
> >>
> >> --
> >> Thanks,
> >> Qi
>
> --
> Thanks,
> Qi
