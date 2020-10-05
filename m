Return-Path: <SRS0=BSCp=DM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD2FC4363A
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 18:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589EE20853
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 18:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MiJI6ey7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgJES3m (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Oct 2020 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgJES3m (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Oct 2020 14:29:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4162FC0613A7
        for <rcu@vger.kernel.org>; Mon,  5 Oct 2020 11:29:42 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e10so6939652pfj.1
        for <rcu@vger.kernel.org>; Mon, 05 Oct 2020 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGk+HufVuvkodYsqg3pTpLFvIgJAITpmfFnUXPHR2Jg=;
        b=MiJI6ey78fVDhIhjF59FHCG5aU2ZJ0H/tCC2TqgNlbFNGVW2lfcJLHEIcXsAFfkNBQ
         KOSq/2UmUdv+Vyk/r0626wy3HOT7o3BAEvhdn3VQppJwYUcvv7hL4j1s9Irdob1kIscd
         r/c4pLkjpjjYubbZFE8c+/yB8bBbQB1c3kwKIW9PgBSx+9FKZCebrX17TnXtn/BTEHut
         HirtS9Ve4Oox0qj8M0G54bhM0cYU3LwzbDPagZPYUikg4QAWNkC/68s5qW8wzzEiYDOC
         GB2C1E4fYiWZFMRxO7oDJrsFjanRSE1bXB2SaMh89FxWnjhuUIBOhQRNOlv87Eg4eA6/
         RGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGk+HufVuvkodYsqg3pTpLFvIgJAITpmfFnUXPHR2Jg=;
        b=dhGjoF025XrmKMdysaoH/qiXHeciBdRtKLgQykUd9C2kP/ZF+qI5oE+ZY6Umef+Doq
         tOpvK+SH++V37t51+N2LhHLuuH/S3UQToOLUt6OowFk7ejXrkHj+YKGHvCAul81OcFkv
         jM6KmnR5TxX8iWMuCSmGhkgl/Jq9CUpe6YEaul57kOPQyQ/mT6SpkipgUxARzrPioCMa
         17oUz1x5xOlqlSR1DiHv/QPZHNOo/Ejh/k0Z8BBq9hwl2+25VrEbMvHE/JYT+ZpbgX42
         o1ED+/Afg04JdnuMCpc9f20+qC7ItsHmdu43z3CICDS2omOFv94XrH2iPo3mMI0W1wW/
         4MUw==
X-Gm-Message-State: AOAM531opfCwz33ohQrbv2MGNuC/H0WtFrWHkkVFghuiVDqijcGYoJXX
        w1xZybOhJm4tDFofsD01n6KT4lu8FKKnVHTU1tOAJA==
X-Google-Smtp-Source: ABdhPJxgPn4EzgwTgdH06bcCDIskfp1uIx0vrMQFtnRp/o93ao3CQozz2U0i4rTOhw34+g9+ixd2I0c9QjdzoxGquAA=
X-Received: by 2002:a65:6858:: with SMTP id q24mr812037pgt.10.1601922581328;
 Mon, 05 Oct 2020 11:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com> <20200930204044.GZ29330@paulmck-ThinkPad-P72>
 <CAKwvOd=nabONrWyYFK7Y06TrKBOyHHfNUiiy69VJQ2NtCpbp5Q@mail.gmail.com> <20201002205130.GK29330@paulmck-ThinkPad-P72>
In-Reply-To: <20201002205130.GK29330@paulmck-ThinkPad-P72>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 5 Oct 2020 11:29:30 -0700
Message-ID: <CAKwvOdkPMSwQneMLFNg3ihM5zHorFy+uGvzAL7y70+hu_1q24w@mail.gmail.com>
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

On Fri, Oct 2, 2020 at 1:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Sep 30, 2020 at 01:55:48PM -0700, Nick Desaulniers wrote:
> > On Wed, Sep 30, 2020 at 1:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Tue, Sep 29, 2020 at 12:25:49PM -0700, Nick Desaulniers wrote:
> > > > The stringification operator, `#`, in the preprocessor escapes strings.
> > > > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > > > they treat section names that contain \".
> > > >
> > > > The portable solution is to not use a string literal with the
> > > > preprocessor stringification operator.
> > > >
> > > > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > > > Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
> > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > I am guessing that this needs to go up with other patches.  If so:
> > >
> > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > > If not, let me know and I will queue it.
> >
> > I could have bundled them up as a series.  I think you can pick it up,
> > and I'll owe you a beer?
>
> It is queued, thank you!
>
> When does it need to hit mainline?  (Your default is the v5.11 merge
> window, that is, the one following the upcoming merge window.)

No rush, this patch wasn't blocking any known issue, just a cleanup
while I was in the neighborhood.  100 years ago, I was an Eagle scout.
Pretty sure there was a motto about "leaving things better than you
found them."  Thanks for help resolving the merge conflict reported in
-next related to it.

>
>
>                                                         Thanx, Paul
>
> > > > ---
> > > > Changes V1->V2:
> > > > * drop unrelated Kconfig changes accidentally committed in v1.
> > > >
> > > >  include/linux/srcutree.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > index 9cfcc8a756ae..9de652f4e1bd 100644
> > > > --- a/include/linux/srcutree.h
> > > > +++ b/include/linux/srcutree.h
> > > > @@ -124,7 +124,7 @@ struct srcu_struct {
> > > >  # define __DEFINE_SRCU(name, is_static)                                      \
> > > >       is_static struct srcu_struct name;                              \
> > > >       struct srcu_struct * const __srcu_struct_##name                 \
> > > > -             __section("___srcu_struct_ptrs") = &name
> > > > +             __section(___srcu_struct_ptrs) = &name
> > > >  #else
> > > >  # define __DEFINE_SRCU(name, is_static)                                      \
> > > >       static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);      \
> > > > --
> > > > 2.28.0.709.gb0816b6eb0-goog
> > > >
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
