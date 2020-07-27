Return-Path: <SRS0=qouz=BG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1B2C433F7
	for <rcu@archiver.kernel.org>; Mon, 27 Jul 2020 13:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6C82073E
	for <rcu@archiver.kernel.org>; Mon, 27 Jul 2020 13:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3QBk1Xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgG0Ntb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0Ntb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Jul 2020 09:49:31 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5E4C061794;
        Mon, 27 Jul 2020 06:49:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id x6so1621766qvr.8;
        Mon, 27 Jul 2020 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ys5tpR5z0WknQnFG2eW96i+fTqWp/FuE3f3knG67cMM=;
        b=T3QBk1XaUNia5fyKu9JWJvEdI5u12HIHt6qZ8fOipa8tvRQweGXZrz03VxnipCgRtD
         quiU5X/OZDElax37XfkhxB5bwBfD082eQToSHHwkmDlfZXrHoE3WoorWytTMJzRQPXnJ
         Yw/LOEWh3vIKBRPcxRpDDTq2IE8Sb9a9sdnpgp4ZFCetRG7pkqIT7cW3KhHDf+Ep5zY6
         R2LJGKlJa3yyBHaqaU+B/J/vBdTQo6FMJ8bqK4/91uGvyRPnaMQK9sqruWyXKbGvqMyE
         UMBmrhRwopQc5vp/NVzyFbcLGC8aIvHe3eDjk2zvvMKY/zQ3U54FKFAn9+CAWjjMwNOF
         ezwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ys5tpR5z0WknQnFG2eW96i+fTqWp/FuE3f3knG67cMM=;
        b=YsDDO3Ty6MAcbgxI8mGjNahkEpf/KftUWr4EMFe1pM3TnSsIWsCluQ9QaWuN/c8Jg5
         3Jl8QMP7kCk89QNqJWZE9RTv3ShjPhY3yGKDx3kubT7QzLCR6zGX8lFZRC5kihMbEuMt
         tbdAYRwlYnPo25xF+J7qjfwSWKq6Uy+Qjszv6GcLC8fEODf7fGhVGyRLrVfgtKnsiJ4s
         CL+6LOm69i9F9SiYpsM65wyt0nBHxjoSmCOZWqaMxI1wsoyBc3GZjNPw50C1nXoDZiEX
         /KSbpqp8bHdrwXYSGyWzP126slWq6TlPO+lQNLa4Db6JlmVVHkl3MJRrzx3oEEAoLqBA
         gbAg==
X-Gm-Message-State: AOAM531/jENhnR6J+qd/Ac49MqkpE8OSuCuvlkYp1VSqqiY1Q4fEMtne
        3d6S36o3B5czqdYb9OMGeig=
X-Google-Smtp-Source: ABdhPJw5D+FN76Jc+8iebnuT+fysb1WTePuYNYSdQyTUjR9R5RGZjl/ltV8fmGNNtG7NAEsmhH2nrQ==
X-Received: by 2002:a0c:e5c4:: with SMTP id u4mr3011357qvm.109.1595857770327;
        Mon, 27 Jul 2020 06:49:30 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t8sm5091588qke.7.2020.07.27.06.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 06:49:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 661B727C005A;
        Mon, 27 Jul 2020 09:49:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 27 Jul 2020 09:49:28 -0400
X-ME-Sender: <xms:Z9seXzuuwIAWJBZNLzmt8mPLZarfUnkECBDwGHUso6Z2ZlnOgZzk-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedriedtgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejheekueegteffkeduiedvteegveevtdeffeetudefheffudduheefgfef
    geenucffohhmrghinhepghhnuhdrohhrghenucfkphephedvrdduheehrdduuddurdejud
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvg
X-ME-Proxy: <xmx:Z9seX0dN7f7wUFF4hWkg-K3JxduQkXnGQGfY0lEN6NjhiXNdg9TbMg>
    <xmx:Z9seX2wJTIV_EwcXwTEPG6ZelDmGe4JT0Jncvz-wghM_MaHdjFlXEw>
    <xmx:Z9seXyN3Sq7lzi2DCGjOxhJTI5wCe_tBlGZQb9e55vUAkzBj5eUWbQ>
    <xmx:aNseXzwYcvDyc0tHFt-qbbzaj-QpD_2wRYCkR0kFGJsw3u8ZmFIRCA>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5FE163280064;
        Mon, 27 Jul 2020 09:49:27 -0400 (EDT)
Date:   Mon, 27 Jul 2020 21:49:25 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC v2] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200727134925.GB79404@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200719035518.2386828-1-joel@joelfernandes.org>
 <CAEXW_YQhYiYQZOJ95dqBcu_fAZ_6k7HGbrw53eTgPrgXU+5few@mail.gmail.com>
 <20200719041841.GA2398236@google.com>
 <20200720082211.GA35358@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <CAEXW_YR4dxuPV+Yu9HcYCSAdiV1H=9Rk9HJgCST-YMMc7J2Mgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YR4dxuPV+Yu9HcYCSAdiV1H=9Rk9HJgCST-YMMc7J2Mgg@mail.gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 24, 2020 at 03:34:46PM -0400, Joel Fernandes wrote:
> On Mon, Jul 20, 2020 at 4:22 AM <boqun.feng@gmail.com> wrote:
> >
> > Hi Joel,
> 
> Sorry for the late reply as I was on vacation last several days.
> 
> >
> > On Sun, Jul 19, 2020 at 12:18:41AM -0400, Joel Fernandes wrote:
> > > On Sun, Jul 19, 2020 at 12:06:28AM -0400, Joel Fernandes wrote:
> > > > On Sat, Jul 18, 2020 at 11:55 PM Joel Fernandes (Google)
> > > > <joel@joelfernandes.org> wrote:
> > > > [...]
> > > > >         /* If no callbacks moved, nothing more need be done. */
> > > > > @@ -419,10 +494,9 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
> > > > >          * callbacks.  The overall effect is to copy down the later pointers
> > > > >          * into the gap that was created by the now-ready segments.
> > > > >          */
> > > > > -       for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++, j++) {
> > > > > -               if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
> > > > > -                       break;  /* No more callbacks. */
> > > > > +       for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL && j < RCU_NEXT_TAIL; i++, j++) {
> > > > >                 WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
> > > > > +               rcu_segcblist_move_seglen(rsclp, i, j);
> > > > >                 rsclp->gp_seq[j] = rsclp->gp_seq[i];
> > > > >         }
> > > >
> > > > Unfortunately I broke this code, _sigh_.  I need to reinstate the
> > > > if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL]) , I completely
> > > > misunderstood that.
> > >
> > > And hopefully, third time's a charm with various extra newlines removed:
> > >
> > > ---8<-----------------------
> > >
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > Subject: [PATCH v3] rcu/segcblist: Add counters to segcblist datastructure
> > >
> > > Add counting of segment lengths of segmented callback list.
> > >
> > > This will be useful for a number of things such as knowing how big the
> > > ready-to-execute segment have gotten. The immediate benefit is ability
> > > to trace how the callbacks in the segmented callback list change.
> > >
> > > Tested by profusely reading traces when segcblist counts updated.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > v1->v3: minor nits.
> > > ---
> > >  include/linux/rcu_segcblist.h |  2 +
> > >  kernel/rcu/rcu_segcblist.c    | 77 +++++++++++++++++++++++++++++++++--
> > >  2 files changed, 76 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> > > index b36afe7b22c9..d462ae5e340a 100644
> > > --- a/include/linux/rcu_segcblist.h
> > > +++ b/include/linux/rcu_segcblist.h
> > > @@ -69,8 +69,10 @@ struct rcu_segcblist {
> > >       unsigned long gp_seq[RCU_CBLIST_NSEGS];
> > >  #ifdef CONFIG_RCU_NOCB_CPU
> > >       atomic_long_t len;
> > > +     atomic_long_t seglen[RCU_CBLIST_NSEGS];
> > >  #else
> > >       long len;
> > > +     long seglen[RCU_CBLIST_NSEGS];
> > >  #endif
> > >       u8 enabled;
> > >       u8 offloaded;
> > > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > > index 9a0f66133b4b..c5841efcd38e 100644
> > > --- a/kernel/rcu/rcu_segcblist.c
> > > +++ b/kernel/rcu/rcu_segcblist.c
> > > @@ -88,6 +88,57 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
> > >  #endif
> > >  }
> > >
> > > +/* Get the length of a segment of the rcu_segcblist structure. */
> > > +static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
> > > +{
> > > +#ifdef CONFIG_RCU_NOCB_CPU
> > > +     return atomic_long_read(&rsclp->seglen[seg]);
> > > +#else
> > > +     return READ_ONCE(rsclp->seglen[seg]);
> > > +#endif
> > > +}
> > > +
> > > +/* Set the length of a segment of the rcu_segcblist structure. */
> > > +static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
> > > +{
> > > +#ifdef CONFIG_RCU_NOCB_CPU
> > > +     atomic_long_set(&rsclp->seglen[seg], v);
> > > +#else
> > > +     WRITE_ONCE(rsclp->seglen[seg], v);
> > > +#endif
> >
> > These #ifdef really make me uncomfortable ;-) Since we are allowed to
> > use the '_Generic' key from C11 (see include/linux/compiler_types.h), I
> > wonder whether it's better if we have a few "generic" primitives like:
> >
> >         #define gen_long_read(x) _Generic((x),                                          \
> >                                           atomic_long_t: atomic_long_read(&x, v),       \
> >                                           long: READ_ONCE(x)),                          \
> >                                           ...
> >
> >         #define gen_long_set(x, v) _Generic((x),                                        \
> >                                             atomic_long_t: atomic_long_set(&x, v),      \
> >                                             long: WRITE_ONCE(x, v)),                    \
> >                                             ...
> >
> > , and similar for _xchg and _add.
> 
> This sounds like a good idea. But isn't the kernel compiled with -std=gnu89
> 
> Here are the KBUILD_CFLAGS
> 
> KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
>                    -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
>                    -Werror=implicit-function-declaration -Werror=implicit-int \
>                    -Wno-format-security \
>                    -std=gnu89
> 
> With "make kernel/rcu/tree.o V=1" confirming it as well:
> 
>   gcc -Wp,-MD,kernel/rcu/.tree.o.d  -nostdinc -isystem
> /usr/lib/gcc/x86_64-linux-gnu/9/include -I./arch/x86/include
> -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi
> -I./arch/x86/include/generated/uapi -I./include/uapi
> -I./include/generated/uapi -include ./include/linux/kconfig.h -include
> ./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef
> -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing
> -fno-common -fshort-wchar -fno-PIE
> -Werror=implicit-function-declaration -Werror=implicit-int
> -Wno-format-security -std=gnu89
> 

Note that gnu89 is not equal to c89, according to gcc manual:

	https://gcc.gnu.org/onlinedocs/gcc/Standards.html#C-Language

"""
By default, GCC provides some extensions to the C language that, on
rare occasions conflict with the C standard. See Extensions to the C
Language Family. Some features that are part of the C99 standard are
accepted as extensions in C90 mode, and some features that are part of
the C11 standard are accepted as extensions in C90 and C99 modes. Use of
the -std options listed above disables these extensions where they
conflict with the C standard version selected. You may also select an
extended version of the C language explicitly with -std=gnu90 (for C90
with GNU extensions), -std=gnu99 (for C99 with GNU extensions) or
-std=gnu11 (for C11 with GNU extensions).
"""

So C11 features are available to gnu89 as extensions, also I tried to
compile the following code with -std=gnu89:

	#include <stdio.h>

	typedef struct {
		int a;
	} atomic_t;

	void g(void) {
		printf("this is g\n");
	}

	void h(void) {
		printf("this is f\n");
	}

	#define gen(x) _Generic((x), atomic_t : h(), int : g())

	int main(void) {
		int a;
		atomic_t b;
		gen(a);
		gen(b);
		gen(b);
	}

, and it worked.

Besides, please note that in include/linux/compiler_types.h, _Generic is
already used.

> >
> > With these primitives introduced, you can avoid () to add those
> > rcu_segcblist_*_seglen() which have #ifdefs in them. Of course, an
> > alternative would be that we implement rcu_segcblist_*_seglen() using
> > _Generic, but I think someone else may have the similar problems or
> > requirement (already or in the future), so it might be worthwhile to
> > introduce the gen_ primitives for broader usage.
> 
> One issue is code using memory barriers around the operation, such as
> in rcu_segcblist_add_len() where you use smp_mb__before_atomic() for
> the atomic version, and regular smp_mb() for the non-atomic version.
> So ifdef will still exist to some degree.
> 

Right, I think we can have two functions: long_add_mb() and
atomic_long_add_mb(), this part is similar to ifdef approach, but we can
make a gen_long_add_mb() based on these two functions, and
gen_long_add_mb() simply switches between those functions according to
the actual type of the field, which I think is better than ifdef
approach at readability and maintenance.

Regards,
Boqun

> thanks,
> 
>  - Joel
