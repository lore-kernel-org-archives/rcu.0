Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C22C4727C
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 20:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30EB2071E
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 20:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQgOqp0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgI3U4A (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 16:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3U4A (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 16:56:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD26C0613D0
        for <rcu@vger.kernel.org>; Wed, 30 Sep 2020 13:56:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id md22so478014pjb.0
        for <rcu@vger.kernel.org>; Wed, 30 Sep 2020 13:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5AARzvPIhmrr9RKWTolOdjmp/z3TGB3+rP7VPNajPP0=;
        b=qQgOqp0hAZxPWwEzbDePhDJXvFlR2QPc3wujGt5XoQQg2XsZEcgfcpYNsgvVi3CfbM
         j9fU6bbS1AVT8Yc/f1OFUwdDYWA24CqI1KekYsI1wBRvh54jxLjNJsuZK8s/rMSzlKEX
         HswgyZB3fH5PcMiEcEkm/akmFlv3skt6ykTVKeNTVUIZBg/PeVI5FzObNxBZ9lO9bRrl
         eoCedfKPSN1ljcGe0JeBqYefR4dXheEtypOq4cOP444Me93+KrRwuiP83JO8HWbMRUL0
         x2zFgAgH1sdadVC8IALQ+Bl3NR51FSYvH3lX6tqwAdkgy8FMpwrSW5mzFn3CjCKe9IRx
         Long==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5AARzvPIhmrr9RKWTolOdjmp/z3TGB3+rP7VPNajPP0=;
        b=oZApwoSsUS6roCaXnOLzLk2XdVNiz+X0zFXqoV3JeiwUkLQ7+lXsjT1LIKIBJSbqYO
         mIFo9Bzacgr5GAhEjWrvt1P1KdAJTktgfCDcVp/zJ0qLXNZYCupfEoH6UniOUebn08Ky
         0boXtNGHAFr34ty8IsW2/a+SuX995S/3Lx9NDesO4vfpOd+WcSR+a/K/WsYSE3aVK0T6
         oYa2pWfuXzvgOzEoGXAZMPty0FXHjNxYAXLPz9IcFFdQpVVcFGX365X2nxlIsDfg/YIW
         9Z6aXJ7piKF/s//tpJmoirHYW+tM4uc3KD3U2qs+oLVMw/YIHJXb5zYk9f0+tj5n6WFm
         YcOw==
X-Gm-Message-State: AOAM5304MPsRF6Md7oRveQi9X37eaQ3kYuNtmgUnC5iR6oG15TWmIx2U
        H0cf8qdOK/4HVcp0NiaEYB/eL/+QNB9uHDJ6z2hqWA==
X-Google-Smtp-Source: ABdhPJzo/UGefrxYQ/OcLPwvOIN1JUsOUvE/hsJRFGPbrmWsiQF+9tc0XaVP7E2w3fOI+zGl57nWm2CdOIoKJjcUego=
X-Received: by 2002:a17:90a:3b48:: with SMTP id t8mr158290pjf.32.1601499359788;
 Wed, 30 Sep 2020 13:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com> <20200930204044.GZ29330@paulmck-ThinkPad-P72>
In-Reply-To: <20200930204044.GZ29330@paulmck-ThinkPad-P72>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 30 Sep 2020 13:55:48 -0700
Message-ID: <CAKwvOd=nabONrWyYFK7Y06TrKBOyHHfNUiiy69VJQ2NtCpbp5Q@mail.gmail.com>
Subject: Re: [PATCH v2] srcu: avoid escaped section names
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 30, 2020 at 1:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Sep 29, 2020 at 12:25:49PM -0700, Nick Desaulniers wrote:
> > The stringification operator, `#`, in the preprocessor escapes strings.
> > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > they treat section names that contain \".
> >
> > The portable solution is to not use a string literal with the
> > preprocessor stringification operator.
> >
> > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> I am guessing that this needs to go up with other patches.  If so:
>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
>
> If not, let me know and I will queue it.

I could have bundled them up as a series.  I think you can pick it up,
and I'll owe you a beer?

>
>                                                         Thanx, Paul
>
> > ---
> > Changes V1->V2:
> > * drop unrelated Kconfig changes accidentally committed in v1.
> >
> >  include/linux/srcutree.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index 9cfcc8a756ae..9de652f4e1bd 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -124,7 +124,7 @@ struct srcu_struct {
> >  # define __DEFINE_SRCU(name, is_static)                                      \
> >       is_static struct srcu_struct name;                              \
> >       struct srcu_struct * const __srcu_struct_##name                 \
> > -             __section("___srcu_struct_ptrs") = &name
> > +             __section(___srcu_struct_ptrs) = &name
> >  #else
> >  # define __DEFINE_SRCU(name, is_static)                                      \
> >       static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);      \
> > --
> > 2.28.0.709.gb0816b6eb0-goog
> >



-- 
Thanks,
~Nick Desaulniers
