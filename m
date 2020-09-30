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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11017C4727E
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 16:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AECD72085B
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 16:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOko5veG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgI3Q1Z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Q1Z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 12:27:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76CAC061755;
        Wed, 30 Sep 2020 09:27:24 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so1497670pfg.13;
        Wed, 30 Sep 2020 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=earzXYgcHhW5P7q3Fe1nQFt0BCBrbypIUJ3jhj8eCtI=;
        b=uOko5veGYfYAxeiAITpgwq2oq9YmLxIjW8sxs0ojSXRCoj1rDuNDOdJV5Sv4FF6rrs
         WWomq9t21+NwWl4AMGnvpR8o0buRjZekpMusCuIibOew6GV9110S7GWryQJxstJU/ll+
         kzYQoOzTpZb+RhhEvAl0P4niDHTIW1Gg+etJIos3KgsBvQ4sFhBe/jF0Zqs0p7mfqlmK
         D1bz4KEctA3irUIXO7teL/kNXikcnXFGksBnYGrddopH1Sawir5giGVDdr7hu1t3mA3S
         vthI6FaJQX40O1t8cnlUS3KdoS0ZIpEwTTEPmX4Q/3NksgQbb4hE3jysU5zXulgcj0Mo
         by/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=earzXYgcHhW5P7q3Fe1nQFt0BCBrbypIUJ3jhj8eCtI=;
        b=kgIFE69sD1+GK7CoRQzFBA24muEZ/vERY2kw9OrHUVRZDFkWqXFPf6ds6qzSt2nWFL
         7H4FS7mSsPdkWd+XvaX67dLcz7ye2Ufk19ANHhN9NT74NY7OFbcatklgHChgRN20lp0z
         TlIm3v6VW3FGy2DpeRcwuCqdAaG/2AG4wMXSOpL8lm4kH+UEH2EEEn4UpeY2ZacXurp0
         g0d1kGq4Rlw+EKJKZK+Iv6VQ1hH1CO1HlZ1nF2g6daGDrcM2nHqqv4q+QoIhSwYRqF1H
         5CFB4Aih+p46e6eEeTHIdC+X2M+GZaKZ0OX8XrndtF0xHJjO8orUaL9cpNHBCACsUhDq
         PHLw==
X-Gm-Message-State: AOAM530E7WZBiy7MIWBDTVJAHytZCIPRn+YF9YDL/6hizX1eNsHCT0PQ
        /bBDcNXHOkUBIh7AdIOEZiA=
X-Google-Smtp-Source: ABdhPJzzkyMHm8rzDW1vQw6MKGthxfjt7dVFJQ127HXQRXlF7hTS/LHe6CG9Uk4Sitiu0ZDGa2792A==
X-Received: by 2002:aa7:989c:0:b029:142:2501:3973 with SMTP id r28-20020aa7989c0000b029014225013973mr3508830pfl.56.1601483244237;
        Wed, 30 Sep 2020 09:27:24 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id q18sm3144759pfg.158.2020.09.30.09.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 09:27:23 -0700 (PDT)
Date:   Wed, 30 Sep 2020 09:27:22 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] srcu: avoid escaped section names
Message-ID: <20200930162722.GC236767@ubuntu-m3-large-x86>
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929192549.501516-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 29, 2020 at 12:25:49PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
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

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

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
>  # define __DEFINE_SRCU(name, is_static)					\
>  	is_static struct srcu_struct name;				\
>  	struct srcu_struct * const __srcu_struct_##name			\
> -		__section("___srcu_struct_ptrs") = &name
> +		__section(___srcu_struct_ptrs) = &name
>  #else
>  # define __DEFINE_SRCU(name, is_static)					\
>  	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);	\
> -- 
> 2.28.0.709.gb0816b6eb0-goog
> 
