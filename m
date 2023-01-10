Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8CFC5479D
	for <rcu@archiver.kernel.org>; Tue, 10 Jan 2023 00:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjAJADE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Jan 2023 19:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbjAJADC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Jan 2023 19:03:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F3B1EEC7
        for <rcu@vger.kernel.org>; Mon,  9 Jan 2023 16:03:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 17so11437530pll.0
        for <rcu@vger.kernel.org>; Mon, 09 Jan 2023 16:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j8xKmx/6dFVmm2efFsDSsl9YQyAJHEnSGQ2/e2NGlbw=;
        b=DkbmJFj9U2D2y8oYBC4N5/IBVDLBcLwjTVMrYSBWmD5dzn6FU7B4cK/V8k4Y4G1I7F
         UnijwFmcdv47bR79JuO5ugHbnNuuZkgQ9n9Cl7DUTJTNSxq7VUmm1CAT5LViY20XrIz3
         YWtE+5qKWQFKoIHXNm8CKICk5QQMvsxoJQDgX9s333sC7ym5GyI8Ek1x3miAvP7Q7+8E
         Aj3WakOz0ksfG17g+di82TP69xYDpWh+r6mUF9PP/aYejp/G60GkJvqPTv6RKg5eFYX8
         /0VKfVL5dsvY1RHyztck/Ct3d9eqKJfr0ZuBGuACyOtjldpLLRFv/dHCQN4KpQG3RV12
         p7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8xKmx/6dFVmm2efFsDSsl9YQyAJHEnSGQ2/e2NGlbw=;
        b=BzLa7fyu3CXcx4OqwocWt9q9TOFRZTBlp4VDRkq8pyn0MYaCkv1W/zSIFHIH0YF50s
         1g0nx4S8LhA3uHBXKlYsOwH5rdHQ1WVHCLm4TfKTh4z1LAaQlWeQhYxAG9xeHy/v4ZhB
         uhRdySDZXsg30YmiTCroEYORAfyAaXui3VaHOLvth3tAVQ2pIeIT8jIbKRZA0omnus2J
         +t7WaATQoFoQ8F5afsXY5/MSntqZaVFERfThJwMR/N3jdIZqmdtU89ueo+kjc97ip8Us
         0Oo4n+Rs4ed5I8e5nWCupiZTvpwGahqi8rDCDuoGpAHACVj3GFDD3uYURmc0MMeu1slq
         wA+g==
X-Gm-Message-State: AFqh2kodk7pUO7RnInx30MR/APV7peftBuEgJpec8nn+9Ynh5Ht8Wyry
        ln9dOZIQqSfnakFFRHa7z+fO97rduqJnl7HnKXlEJw==
X-Google-Smtp-Source: AMrXdXtjmBcgdv8YybRfNjAPG3T9XcOotaMhL9vqmkJ4YtqytQW7gQEGDz3m1wjCErdeiDno1GuPOPszf1xcTBopexM=
X-Received: by 2002:a17:902:c94d:b0:191:24d1:3b31 with SMTP id
 i13-20020a170902c94d00b0019124d13b31mr2872837pla.94.1673308980354; Mon, 09
 Jan 2023 16:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1> <20230105003813.1770367-22-paulmck@kernel.org>
In-Reply-To: <20230105003813.1770367-22-paulmck@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Jan 2023 16:02:48 -0800
Message-ID: <CAKwvOdmt7mnP_dfCMO_YUV792Zgtirk=NFqe8XH0z88-b0e23A@mail.gmail.com>
Subject: Re: [PATCH rcu 22/27] init: Remove "select SRCU"
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, Tejun Heo <tj@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 4, 2023 at 4:38 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.

Looks like that's the case as of
commit 0cd7e350abc4 ("rcu: Make SRCU mandatory")
in v6.2-rc1.

>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Aaron Tomlin <atomlin@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>

Patch LGTM
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Note that there's quite a few more of these though. Perhaps best to
remove them all together? Or perhaps you already have individual
patches out already for all of these?

$ grep -rn 'select SRCU'
mm/Kconfig:670: select SRCU
kernel/power/Kconfig:121: select SRCU
arch/mips/kvm/Kconfig:29: select SRCU
arch/riscv/kvm/Kconfig:30: select SRCU
arch/s390/kvm/Kconfig:34: select SRCU
arch/powerpc/kvm/Kconfig:25: select SRCU
arch/x86/kvm/Kconfig:49: select SRCU
arch/x86/Kconfig:286: select SRCU
arch/x86/Kconfig:1941: select SRCU
arch/arm64/kvm/Kconfig:31: select SRCU
init/Kconfig:1868: select SRCU
security/tomoyo/Kconfig:9: select SRCU
fs/btrfs/Kconfig:20: select SRCU
fs/dlm/Kconfig:7: select SRCU
fs/quota/Kconfig:9: select SRCU
fs/notify/Kconfig:4: select SRCU
drivers/md/Kconfig:9: select SRCU
drivers/clk/Kconfig:26: select SRCU
drivers/dax/Kconfig:4: select SRCU
drivers/devfreq/Kconfig:4: select SRCU
drivers/net/Kconfig:337: select SRCU
drivers/hwtracing/stm/Kconfig:5: select SRCU
drivers/cpufreq/Kconfig:6: select SRCU
drivers/opp/Kconfig:4: select SRCU

> ---
>  init/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 7e5c3ddc341de..af511c726d695 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1865,7 +1865,6 @@ config PERF_EVENTS
>         default y if PROFILING
>         depends on HAVE_PERF_EVENTS
>         select IRQ_WORK
> -       select SRCU
>         help
>           Enable kernel support for various performance events provided
>           by software and hardware.
> --
> 2.31.1.189.g2e36527f23
>


-- 
Thanks,
~Nick Desaulniers
