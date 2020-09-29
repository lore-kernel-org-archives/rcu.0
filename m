Return-Path: <SRS0=CVHC=DG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E26C4727C
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 19:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F34820848
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 19:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MG2uhNgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgI2TXC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Sep 2020 15:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgI2TXC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Sep 2020 15:23:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F193C0613D0
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2020 12:23:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so4691495pgl.2
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2020 12:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGb7x8YUCOsUH75obTDiJ9n5ILA2CmimR4Sm9Sn083E=;
        b=MG2uhNgIoAqQ145gKQDC07A/bYdHkyq4BjCi5MOZn26OWSC3h2IphtTJdCVQgHEmvR
         OnHSlEXHyRtMoL7b+uKgsnVEO1PanhsiRC5KprBPsAk17YZFL+/n6L8oB028d/4i8HLS
         VG7u8sxK1KQ/QTcd8OYbp4s/buxbMK5QqTbkg1pWXm5wK/BsJ5C1wOks6MN05kgSxJ99
         eMrGsHJI5vtsfyxVc0EhJgFFV3UCzVL5SdzdyzD9Yj33/udqxej7F4/I5QIPAzLtVE97
         4/cHr+CBZjEnzjCxTlkSC/SODby7FLtNN7kHB2L/CYdMG5ENNYmTh4v+Xo9CdYsehwgZ
         csYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGb7x8YUCOsUH75obTDiJ9n5ILA2CmimR4Sm9Sn083E=;
        b=r+2uFojBByAxhUTQg1tpnCkyTm6T+dx6Iirutu1WHHdNvQt0nMMCdEc94aLTKLNsLc
         FwLeo0Cl5hFSclpZFD9W5h5F6x+Hq02CAtDle6BcB12C7OuKEwdP11YzeWEQZQiSy9MQ
         U21DQ6C1jeDUx37KJfRfrpG1vvpg6Wcc9CnYXEuCh1AfKBJ9LYNXZbZZ+6tbu9hZdhVh
         Yifj86VZW6KxXw+EHisLI2LWnsGB257C1KzLk3jzTlgxtZ9K/vruXbUgpY4Pwky1HVOa
         5mG0WolBE9NBgTWPFmGXcgNJ6P+7D8T/3H3nDESf6gETH2Z9xilASkxjOysGF2K4cYu/
         Sv2Q==
X-Gm-Message-State: AOAM530DxFg6/iPoRfsAzlgSnkuo7njJ+gEJpszAXAKbR+lx9BOjoWVF
        uKdbIfrEkwMW2bpRBb1HzXWsxOsCs1xljokiMDZAuA==
X-Google-Smtp-Source: ABdhPJyChWdjv4wSBHHt8wwhxCBeeusT+pYIJhoqpLnBIOnRZefz7ePm3oAHqooOXWwoLggiL4gJmRRyqKeWMQd5cAw=
X-Received: by 2002:a17:902:ed11:b029:d1:f385:f4e7 with SMTP id
 b17-20020a170902ed11b02900d1f385f4e7mr5997772pld.56.1601407381691; Tue, 29
 Sep 2020 12:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200929192204.499006-1-ndesaulniers@google.com>
In-Reply-To: <20200929192204.499006-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Sep 2020 12:22:50 -0700
Message-ID: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
Subject: Re: [PATCH] srcu: avoid escaped section names
To:     "Paul E . McKenney" <paulmck@kernel.org>
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

gah, must have had a `-a` in my `git commit --amend`...sorry, will send a v2...

On Tue, Sep 29, 2020 at 12:22 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
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
> ---
>  arch/arm/Kconfig         |  1 +
>  arch/arm/mm/Kconfig      | 11 +++++++++++
>  include/linux/srcutree.h |  2 +-
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fe2f17eb2b50..51200e371faf 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -358,6 +358,7 @@ config ARCH_EBSA110
>
>  config ARCH_EP93XX
>         bool "EP93xx-based"
> +       depends on !LD_IS_LLD
>         select ARCH_SPARSEMEM_ENABLE
>         select ARM_AMBA
>         imply ARM_PATCH_PHYS_VIRT
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 65e4482e3849..c06787c9bb48 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -9,6 +9,7 @@ comment "Processor Type"
>  config CPU_ARM7TDMI
>         bool
>         depends on !MMU
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_LV4T
>         select CPU_CACHE_V4
> @@ -23,6 +24,7 @@ config CPU_ARM7TDMI
>  # ARM720T
>  config CPU_ARM720T
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_LV4T
>         select CPU_CACHE_V4
> @@ -43,6 +45,7 @@ config CPU_ARM720T
>  config CPU_ARM740T
>         bool
>         depends on !MMU
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_LV4T
>         select CPU_CACHE_V4
> @@ -61,6 +64,7 @@ config CPU_ARM740T
>  config CPU_ARM9TDMI
>         bool
>         depends on !MMU
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_NOMMU
>         select CPU_CACHE_V4
> @@ -75,6 +79,7 @@ config CPU_ARM9TDMI
>  # ARM920T
>  config CPU_ARM920T
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_EV4T
>         select CPU_CACHE_V4WT
> @@ -94,6 +99,7 @@ config CPU_ARM920T
>  # ARM922T
>  config CPU_ARM922T
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_EV4T
>         select CPU_CACHE_V4WT
> @@ -114,6 +120,7 @@ config CPU_ARM922T
>  # ARM925T
>  config CPU_ARM925T
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_EV4T
>         select CPU_CACHE_V4WT
> @@ -153,6 +160,7 @@ config CPU_ARM926T
>  # FA526
>  config CPU_FA526
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v4
>         select CPU_ABRT_EV4
>         select CPU_CACHE_FA
> @@ -172,6 +180,7 @@ config CPU_FA526
>  config CPU_ARM940T
>         bool
>         depends on !MMU
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_NOMMU
>         select CPU_CACHE_VIVT
> @@ -278,6 +287,7 @@ config CPU_ARM1026
>  # SA110
>  config CPU_SA110
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v3 if ARCH_RPC
>         select CPU_32v4 if !ARCH_RPC
>         select CPU_ABRT_EV4
> @@ -299,6 +309,7 @@ config CPU_SA110
>  # SA1100
>  config CPU_SA1100
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v4
>         select CPU_ABRT_EV4
>         select CPU_CACHE_V4WB
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


-- 
Thanks,
~Nick Desaulniers
