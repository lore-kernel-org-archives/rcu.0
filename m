Return-Path: <SRS0=BSCp=DM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3088C4743C
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 18:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A66212CC
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 18:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn7nn+XT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgJESjW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Oct 2020 14:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgJESiz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Oct 2020 14:38:55 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F29C0613CE;
        Mon,  5 Oct 2020 11:38:54 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z5so8736669ilq.5;
        Mon, 05 Oct 2020 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=0mINoVvksqZpxSeoRlADJj7+XdiIIyUQzvACsexYEQw=;
        b=kn7nn+XTmlJZO2v/2j2Tmy3jIlpyrrrrWPx33DO4lmrqZgUYwdb/a8sNtoyfvDz1OO
         3UwPs7RxAscCE7pOVghC/bMTs1mp3PvDxShLNbA86FvVaW66U0plTCvNNadhsMUBxB0W
         KUPTDJLXJA5u//2V5nuseGGrKIdKR3tX1gFOunlYu0o0G+GkH8LZExt0l98aNuma63Qm
         WUHlA45vMTCAFJPax9yGhxpR8yJJcNQcLE080w0Xbo49IsaLBYBhCaACXbQweFmYZ3pY
         xNhUYhGalRo4rTCEtW31kbyfHsFnfAmQ6zYTqgqnlWuEHWJWegOa+Oda/L2jHCtTy6zV
         mQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=0mINoVvksqZpxSeoRlADJj7+XdiIIyUQzvACsexYEQw=;
        b=gWlab85g/W4k4ExCSPZ4tfTu2KWtZxU9ROyX9GNO5C1ygUESbGAeBlC7Lg70ahPYQv
         t6VHS3T3HDZbyWDzaFLIYBeCqSf4+xAdhPv+D2TuUwlfbJYhqQdbmIiwT2rm6vkDlLIx
         joZaly6K7iUiof1dd5HGqg7+C3TEt3SSo/R8jzH/GHCidKNm1jCvfbziYThl6HhW2/iJ
         HyXOMm9JI/A5xNWLGn6c1x8Aji1BqmVbIesamytPH4if7BWOZQMYXJr7gWXlAdHRbXwo
         phMRTNl5DXUvgXcTUmNNjmXWLaw1oRhtSJNIHsgJ+uZ2+W4tgrzD0CaDmykoebmOBciJ
         m6Mw==
X-Gm-Message-State: AOAM532eOpk70Za6PvyUL+qhmRl0/TAulFfjCkyd3NNey/uqQ1UZj/8X
        hVH+917f68X64/uRWZuxIZ8GK/jYNXQMb+y0c+M=
X-Google-Smtp-Source: ABdhPJxsJaSwN+Zw1d8zq5bm/klf9+WTqk9WtOme4Gz17IP9G/ILoYs0zpxV55VFQLFrfZkF0Y40fUFxE+mvwjz0l1Y=
X-Received: by 2002:a92:6a0a:: with SMTP id f10mr599827ilc.186.1601923133931;
 Mon, 05 Oct 2020 11:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com> <20200930204044.GZ29330@paulmck-ThinkPad-P72>
 <CAKwvOd=nabONrWyYFK7Y06TrKBOyHHfNUiiy69VJQ2NtCpbp5Q@mail.gmail.com>
 <20201002205130.GK29330@paulmck-ThinkPad-P72> <CAKwvOdkPMSwQneMLFNg3ihM5zHorFy+uGvzAL7y70+hu_1q24w@mail.gmail.com>
In-Reply-To: <CAKwvOdkPMSwQneMLFNg3ihM5zHorFy+uGvzAL7y70+hu_1q24w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 5 Oct 2020 20:38:42 +0200
Message-ID: <CA+icZUW_z5nJ1c69JS7Nm1QknF+CH+sPkhF4g2+L=d=H-vxVgw@mail.gmail.com>
Subject: Re: [PATCH v2] srcu: avoid escaped section names
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Mon, Oct 5, 2020 at 8:29 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Fri, Oct 2, 2020 at 1:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Sep 30, 2020 at 01:55:48PM -0700, Nick Desaulniers wrote:
> > > On Wed, Sep 30, 2020 at 1:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Tue, Sep 29, 2020 at 12:25:49PM -0700, Nick Desaulniers wrote:
> > > > > The stringification operator, `#`, in the preprocessor escapes strings.
> > > > > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > > > > they treat section names that contain \".
> > > > >
> > > > > The portable solution is to not use a string literal with the
> > > > > preprocessor stringification operator.
> > > > >
> > > > > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > > > > Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
> > > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > >
> > > > I am guessing that this needs to go up with other patches.  If so:
> > > >
> > > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > > >
> > > > If not, let me know and I will queue it.
> > >
> > > I could have bundled them up as a series.  I think you can pick it up,
> > > and I'll owe you a beer?
> >
> > It is queued, thank you!
> >
> > When does it need to hit mainline?  (Your default is the v5.11 merge
> > window, that is, the one following the upcoming merge window.)
>
> No rush, this patch wasn't blocking any known issue, just a cleanup
> while I was in the neighborhood.  100 years ago, I was an Eagle scout.
> Pretty sure there was a motto about "leaving things better than you
> found them."  Thanks for help resolving the merge conflict reported in
> -next related to it.
>

Wasn't there a problem with your "Fixes:" tag (Fixes: *drop word
"commit"* commit_hashid ("...")?

- Sedat -

> >
> >
> >                                                         Thanx, Paul
> >
> > > > > ---
> > > > > Changes V1->V2:
> > > > > * drop unrelated Kconfig changes accidentally committed in v1.
> > > > >
> > > > >  include/linux/srcutree.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > > index 9cfcc8a756ae..9de652f4e1bd 100644
> > > > > --- a/include/linux/srcutree.h
> > > > > +++ b/include/linux/srcutree.h
> > > > > @@ -124,7 +124,7 @@ struct srcu_struct {
> > > > >  # define __DEFINE_SRCU(name, is_static)                                      \
> > > > >       is_static struct srcu_struct name;                              \
> > > > >       struct srcu_struct * const __srcu_struct_##name                 \
> > > > > -             __section("___srcu_struct_ptrs") = &name
> > > > > +             __section(___srcu_struct_ptrs) = &name
> > > > >  #else
> > > > >  # define __DEFINE_SRCU(name, is_static)                                      \
> > > > >       static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);      \
> > > > > --
> > > > > 2.28.0.709.gb0816b6eb0-goog
> > > > >
> > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAKwvOdkPMSwQneMLFNg3ihM5zHorFy%2BuGvzAL7y70%2Bhu_1q24w%40mail.gmail.com.
