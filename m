Return-Path: <SRS0=CVHC=DG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069F1C4727C
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 23:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFA8206DC
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 23:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QXOBgazQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgI2XqC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Sep 2020 19:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgI2XqB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Sep 2020 19:46:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39CBC061755
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2020 16:46:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d6so6403968pfn.9
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2020 16:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BE3IS0ree7QIjSeFdWMob24S2TufDcRFBlLIISZlO6M=;
        b=QXOBgazQg6wlfqddFVNOmR1+eQ18ANNoedSzhVTOd76Xb9OOzbsuJfr5rFfxMrMfhu
         YnIJwwUHOi0+iOL5DJILilajKT7+URNJ1ZG8ypreA9OSPm7I8EHA9g+QV2XFZMFeKA1M
         +eKJ6pajmTC/5hm6LrFI6NNsy1BbxGftvEmb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BE3IS0ree7QIjSeFdWMob24S2TufDcRFBlLIISZlO6M=;
        b=f1oTTcgUg1KnrpPcRlQcRsCvzfeqLNyU57RHPKl/i0g81AtAKC9IXQzL9WlbUfqIwf
         rAWWKYgzQb+FE52fGoLikaRkzx2W/xrEcvG4bucM37cUcVgt/w9pPpJMUPEUnNDSIu5L
         jWx8YFjjUwk7O/N/hyKaJ9R0NBsyGHvQhmDEF41THj7LqNDzWEWGwilNrWfi2ainzApV
         FybkE3iUur8YemFkVkDmrUfSvuyOelORG8moYhUrwNYlzznBf7W/qPFqKSW4HJ9hWHRi
         ntF89HHVvWuaETHaGpNUDNY/Sdu14TQY7yyGQwZfQcbODccPmMrqEhIJz/WMN0WA3odJ
         c6dg==
X-Gm-Message-State: AOAM533jaLVsQftdapsq4Q/BfFMG9L517IFYcOKBBRG+b/fhMbM+mr3y
        V9pKBf5MVMOTU0yYqgzo8iCvtQ==
X-Google-Smtp-Source: ABdhPJxIkpLcpVnapCDkZNX9W2yXBh/3YDEom0sH8C5ml1NdWeGB1F+0AyKjMGoFTKhuU1viFEF2iA==
X-Received: by 2002:a63:511d:: with SMTP id f29mr4006pgb.11.1601423161354;
        Tue, 29 Sep 2020 16:46:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i15sm6744827pfk.145.2020.09.29.16.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 16:46:00 -0700 (PDT)
Date:   Tue, 29 Sep 2020 16:45:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] srcu: avoid escaped section names
Message-ID: <202009291645.283040FE80@keescook>
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929192549.501516-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 29, 2020 at 12:25:49PM -0700, Nick Desaulniers wrote:
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

Ah, ignore my earlier question about also fixing this instance. Here it
is! ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

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

-- 
Kees Cook
