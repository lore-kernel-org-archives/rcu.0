Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712ACC4727C
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 16:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 363D720759
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 16:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjIYeO8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgI3Qlz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 12:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3Qly (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 12:41:54 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994CEC061755;
        Wed, 30 Sep 2020 09:41:54 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t76so2377512oif.7;
        Wed, 30 Sep 2020 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=5ZxDJXFnuUJY5eB85Tg10Agt73okBGLGzpTrO/59fjc=;
        b=mjIYeO8srp7sOFT5wnROdgwdF6hbMdbi704OEtviElpEDvktdl4EQLkYlDFA+fa/gc
         InBI+4CTUCx+gYl55s08RhglcpVuOpccR98Nb+IHsF5Ho3RJmYllwKgxDLYnSDkM1MeE
         2SCoP4qVQ/q8+eOkk36NWsoVuC8ad5MY0oqVEToVaiwIXfCe7gtUMELUtQuB0cQuh69A
         wCYphGitn3NGfynhRGEsW50RQfFK+lZgiitN6yz8G3EvOoNfjWoG80H54Z1a50RnaBw4
         OsYbdfEraAeJI6GjslH7aHuRQBdCmcSCXVTY2hY1+yJtujCj1hSwR7mrBaKhJmrqMP1G
         FOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=5ZxDJXFnuUJY5eB85Tg10Agt73okBGLGzpTrO/59fjc=;
        b=jlmTlEPA+5k8jvZLx84Wpqrd+GjGxDA27+XoADwei8E8v18UIUHk+9U3bMF4a9aN8y
         K5oYHVpYRJBTqQFYBw1gRTredv8tKS7Cw/90uK0LAAPi+u0nJ/KzI8Yl1H/o5gzFwx2d
         eqz8Waa3vusrHNHCgvcpYNLxFsAqbHvz1NBAl3PyvxBht7OFR9/v07GAIYZC0DZGfVM9
         roMlW3pyI9YQ6z11N9FgVfA0KfEGFgB9BtOHrHx+XWTEkETjtUKN7zDxDJrvuVjZRhtA
         tT6B0pl806uETUsDMSQz5Bqh+Mdpeat39zPJR/adf9cg6sgjrdKyC9MZa8LvwucGbCcO
         3TWg==
X-Gm-Message-State: AOAM530TcZt0sHFez1pBoJbbSxGUTq9A7nbdvUbv/ZT3owCWtMhNzjqp
        +WptzQ211tgYYWtS41kQ1ONLTCvmXr7w5n3HMk4=
X-Google-Smtp-Source: ABdhPJzFFgzz+5UFXrYvEzgeDhPbesF7QR6vaq9SWncZFfyKjuldy2iWJj8dFXzJhV2Q0kZ3nA/W5JVxNbsrp8LEJQ8=
X-Received: by 2002:aca:ec50:: with SMTP id k77mr1862213oih.35.1601484113963;
 Wed, 30 Sep 2020 09:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com>
In-Reply-To: <20200929192549.501516-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 30 Sep 2020 18:41:42 +0200
Message-ID: <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com>
Subject: Re: [PATCH v2] srcu: avoid escaped section names
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 29, 2020 at 9:25 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> The stringification operator, `#`, in the preprocessor escapes strings.
> For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> they treat section names that contain \".
>
> The portable solution is to not use a string literal with the
> preprocessor stringification operator.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Puh, remember one year ago an overnight bisecting to catch the root
cause for "escaped section names".

The two patches I see - this here and "export.h: fix section name for
CONFIG_TRIM_UNUSED_KSYMS for Clang" were new cases?

Do we have a check-script to catch/avoid such cases (Joe Perches?)?

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> ---
> Changes V1->V2:
> * drop unrelated Kconfig changes accidentally committed in v1.
>
>  include/linux/srcutree.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 9cfcc8a756ae..9de652f4e1bd 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -124,7 +124,7 @@ struct srcu_struct {
>  # define __DEFINE_SRCU(name, is_static)                                        \
>         is_static struct srcu_struct name;                              \
>         struct srcu_struct * const __srcu_struct_##name                 \
> -               __section("___srcu_struct_ptrs") = &name
> +               __section(___srcu_struct_ptrs) = &name
>  #else
>  # define __DEFINE_SRCU(name, is_static)                                        \
>         static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);      \
> --
> 2.28.0.709.gb0816b6eb0-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200929192549.501516-1-ndesaulniers%40google.com.
