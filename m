Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80310C433EF
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 08:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B1460F3A
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 08:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhIOInt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhIOInt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 04:43:49 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D49C061574;
        Wed, 15 Sep 2021 01:42:27 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id f6so1998895vsr.3;
        Wed, 15 Sep 2021 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PbsXF7OjfzBdaKYES0LpRck88Is1bnuPC5nlsDBvF8k=;
        b=ebnGMhB4KfwqK1E3yFJJc01fG1Uf4L49/RP8ou02lQ4HBTqDruLCLLC44MGUBGkDoS
         Px7MLU+nKZFtycaBwxP7lKQNTxqsRgm71RNiCE2cJC4qKwxV6fhyB4C52Vcf/SuCGzeP
         R+7/+drcOa2/f3GRygY3Ksdl3thEfwwbnnL+ZWnJE6d/agQ2pLkJxVe4L13KWEnpHHc7
         7B0iazBO6r15u1U+oEtXk5Jr/U2pzvrmSSJSNLM2F1qU/e8FPvOZbQaAQIhBKuYmYmxH
         QuAMRLtDZ8jQbcxX932rizp/Af3XsuHy3BHpy+gFPiW75jfjT/T+nKReVUmlr9dHTSCg
         +Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbsXF7OjfzBdaKYES0LpRck88Is1bnuPC5nlsDBvF8k=;
        b=3twXRcFcH4F+Kh5ucCdk0GK1sx5iDAlXEh4JFPIxfkesSLNdlfqMkH5Qk5aG0heru+
         yq4Aasd6iMz+o08Nb0UYSHWFv6T1+I89AUzsCiReHNxbQbzoxSdGVgoslaKd/+TC+wfF
         AyHk/6Rk/iWaAplz0YUt/rObrGAhSkKhi2us79xMcZffYp52XWHrFPnuu698WzJ4+QrU
         Od6599MVHac8yh+Rvp5IIzP3KXrHnFRY3OxStPlBOl5X3wHJ2eAuAldbz9+cPMAzYMRY
         20cKSbYI20rOj7DJJbTYsoDYRPnV305XRgD5xItFKeXYHsVTI/bdwwujMdfq9Wp8gNMz
         Ov9Q==
X-Gm-Message-State: AOAM5310Necd+EpYQiQ8Zxcz8s0BVfJSodOUHBwq+nntmLkuqXToRtkH
        Q1Lps3VE058mE22bioaCICNrz7MzN2OAihdYJY+95CAelBY=
X-Google-Smtp-Source: ABdhPJx5LsE46msp++zEwgQ0Ujdk5sx719SFbAC3l2wSTIT7OmNXBaAPd7jzoxp8p6+B/S/jivsyrOaDBPoPeXrvI7A=
X-Received: by 2002:a05:6102:3099:: with SMTP id l25mr2440303vsb.49.1631695346662;
 Wed, 15 Sep 2021 01:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210912204131.93206-1-henrybear327@gmail.com>
 <20210913230430.GM4156@paulmck-ThinkPad-P17-Gen-1> <20210913231751.GA2495405@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210913231751.GA2495405@paulmck-ThinkPad-P17-Gen-1>
From:   Henry Tseng <henrybear327@gmail.com>
Date:   Wed, 15 Sep 2021 10:42:13 +0200
Message-ID: <CAA5xa-mAwyNGw5O2U400EmUNRhn4JTAiBGD7KsFEDXnUjTALpw@mail.gmail.com>
Subject: Re: [PATCH] rcu: replace _________p1 with __UNIQUE_ID(rcu)
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Huang <jserv@ccns.ncku.edu.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thank you for the feedback!!!

I will fix the kernel test bot warning, and then make a v2 of the
patch, containing a bit more detail in the commit message.

Thanks,
Henry

On Tue, Sep 14, 2021 at 1:17 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Sep 13, 2021 at 04:04:30PM -0700, Paul E. McKenney wrote:
> > On Mon, Sep 13, 2021 at 04:41:31AM +0800, Chun-Hung Tseng wrote:
> > > This commit replaced _________p1 with __UNIQUE_ID(rcu), which
> > > generates unique variable names during compilation. Necessary
> > > modifications due to the changes in the RCU macros have also been
> > > reflected in this commit.
> > >
> > > The same idea is used for the min/max macros (commit 589a978 and commit
> > > e9092d0), which aims to reduce variable shadowing issues caused by hard
> > > coded variable names.
> > >
> > > Signed-off-by: Jim Huang <jserv@ccns.ncku.edu.tw>
> > > Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
> >
> > OK, I will bite...
> >
> > > ---
> > >  include/linux/rcupdate.h | 44 +++++++++++++++++++++++-----------------
> > >  include/linux/srcu.h     |  3 ++-
> > >  2 files changed, 27 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 434d12fe2d4f..a5ab20822040 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -370,39 +370,41 @@ static inline void rcu_preempt_sleep_check(void) { }
> > >   * Converts @p from an __rcu pointer to a __kernel pointer.
> > >   * This allows an __rcu pointer to be used with xchg() and friends.
> > >   */
> > > -#define unrcu_pointer(p)                                           \
> > > +#define __unrcu_pointer(p, local)                                  \
> > >  ({                                                                 \
> > > -   typeof(*p) *_________p1 = (typeof(*p) *__force)(p);             \
> > > +   typeof(*p) *local = (typeof(*p) *__force)(p);                   \
> >
> > Why not like this?
> >
> >       typeof(*p) *__UNIQUE_ID(rcu) = (typeof(*p) *__force)(p);        \
> >
> > Then we don't need the extra argument and the changes to the calls.
> >
> > So what C-preprocessor subtlety am I missing?
>
> Never mind!!!  My suggested approach would generate a unique name at
> every use, except on non-gcc/non-clang compilers, which would obviously
> not do what we want.
>
>                                                         Thanx, Paul
>
> > >     rcu_check_sparse(p, __rcu);                                     \
> > > -   ((typeof(*p) __force __kernel *)(_________p1));                 \
> > > +   ((typeof(*p) __force __kernel *)(local));                       \
> > >  })
> > > +#define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
> > >
> > > -#define __rcu_access_pointer(p, space) \
> > > +#define __rcu_access_pointer(p, local, space) \
> > >  ({ \
> > > -   typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
> > > +   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> > >     rcu_check_sparse(p, space); \
> > > -   ((typeof(*p) __force __kernel *)(_________p1)); \
> > > +   ((typeof(*p) __force __kernel *)(local)); \
> > >  })
> > > -#define __rcu_dereference_check(p, c, space) \
> > > +#define __rcu_dereference_check(p, local, c, space) \
> > >  ({ \
> > >     /* Dependency order vs. p above. */ \
> > > -   typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
> > > +   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> > >     RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
> > >     rcu_check_sparse(p, space); \
> > > -   ((typeof(*p) __force __kernel *)(________p1)); \
> > > +   ((typeof(*p) __force __kernel *)(local)); \
> > >  })
> > > -#define __rcu_dereference_protected(p, c, space) \
> > > +#define __rcu_dereference_protected(p, local, c, space) \
> > >  ({ \
> > >     RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
> > >     rcu_check_sparse(p, space); \
> > >     ((typeof(*p) __force __kernel *)(p)); \
> > >  })
> > > -#define rcu_dereference_raw(p) \
> > > +#define __rcu_dereference_raw(p, local) \
> > >  ({ \
> > >     /* Dependency order vs. p above. */ \
> > > -   typeof(p) ________p1 = READ_ONCE(p); \
> > > -   ((typeof(*p) __force __kernel *)(________p1)); \
> > > +   typeof(p) local = READ_ONCE(p); \
> > > +   ((typeof(*p) __force __kernel *)(local)); \
> > >  })
> > > +#define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
> > >
> > >  /**
> > >   * RCU_INITIALIZER() - statically initialize an RCU-protected global variable
> > > @@ -489,7 +491,7 @@ do {                                                                          \
> > >   * when tearing down multi-linked structures after a grace period
> > >   * has elapsed.
> > >   */
> > > -#define rcu_access_pointer(p) __rcu_access_pointer((p), __rcu)
> > > +#define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
> > >
> > >  /**
> > >   * rcu_dereference_check() - rcu_dereference with debug checking
> > > @@ -525,7 +527,8 @@ do {                                                                          \
> > >   * annotated as __rcu.
> > >   */
> > >  #define rcu_dereference_check(p, c) \
> > > -   __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
> > > +   __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> > > +                           (c) || rcu_read_lock_held(), __rcu)
> > >
> > >  /**
> > >   * rcu_dereference_bh_check() - rcu_dereference_bh with debug checking
> > > @@ -540,7 +543,8 @@ do {                                                                          \
> > >   * rcu_read_lock() but also rcu_read_lock_bh() into account.
> > >   */
> > >  #define rcu_dereference_bh_check(p, c) \
> > > -   __rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
> > > +   __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> > > +                           (c) || rcu_read_lock_bh_held(), __rcu)
> > >
> > >  /**
> > >   * rcu_dereference_sched_check() - rcu_dereference_sched with debug checking
> > > @@ -555,7 +559,8 @@ do {                                                                          \
> > >   * only rcu_read_lock() but also rcu_read_lock_sched() into account.
> > >   */
> > >  #define rcu_dereference_sched_check(p, c) \
> > > -   __rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
> > > +   __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> > > +                           (c) || rcu_read_lock_sched_held(), \
> > >                             __rcu)
> > >
> > >  /*
> > > @@ -565,7 +570,8 @@ do {                                                                          \
> > >   * The no-tracing version of rcu_dereference_raw() must not call
> > >   * rcu_read_lock_held().
> > >   */
> > > -#define rcu_dereference_raw_check(p) __rcu_dereference_check((p), 1, __rcu)
> > > +#define rcu_dereference_raw_check(p) \
> > > +   __rcu_dereference_check((p), __UNIQUE_ID(rcu), 1, __rcu)
> > >
> > >  /**
> > >   * rcu_dereference_protected() - fetch RCU pointer when updates prevented
> > > @@ -584,7 +590,7 @@ do {                                                                          \
> > >   * but very ugly failures.
> > >   */
> > >  #define rcu_dereference_protected(p, c) \
> > > -   __rcu_dereference_protected((p), (c), __rcu)
> > > +   __rcu_dereference_protected((p), __UNIQUE_ID(rcu), (c), __rcu)
> > >
> > >
> > >  /**
> > > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > > index e6011a9975af..01226e4d960a 100644
> > > --- a/include/linux/srcu.h
> > > +++ b/include/linux/srcu.h
> > > @@ -117,7 +117,8 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
> > >   * lockdep_is_held() calls.
> > >   */
> > >  #define srcu_dereference_check(p, ssp, c) \
> > > -   __rcu_dereference_check((p), (c) || srcu_read_lock_held(ssp), __rcu)
> > > +   __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> > > +                           (c) || srcu_read_lock_held(ssp), __rcu)
> > >
> > >  /**
> > >   * srcu_dereference - fetch SRCU-protected pointer for later dereferencing
> > > --
> > > 2.25.1
> > >



-- 
Best wishes,
Henry
