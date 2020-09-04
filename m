Return-Path: <SRS0=JZbX=CN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDECC433E2
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 19:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89CF207EA
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 19:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eero.com header.i=@eero.com header.b="G+2Q9owW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgIDTkn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgIDTkm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Sep 2020 15:40:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E694C061245
        for <rcu@vger.kernel.org>; Fri,  4 Sep 2020 12:40:42 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j11so10150482ejk.0
        for <rcu@vger.kernel.org>; Fri, 04 Sep 2020 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQjmi/PifFNlvtU6tPwiyI0gRc4cRRIjqUeDD8wy6Gg=;
        b=G+2Q9owWdzM30PTy8pZo8MI6TqVGrV0wwS2TyOL6Pd7axJjn49X/3eAkyV+7u59Tjb
         9+5zMmWqqUS9mKzg8yUgKey3Kh+7bH1tNc58c7cW8jhWJAwhxHC9n9kvbkmbzet8T8vv
         tc0Iw2sDRwQFnniUWq/t5rkt8ZYabK97DA1Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQjmi/PifFNlvtU6tPwiyI0gRc4cRRIjqUeDD8wy6Gg=;
        b=B1Ql/2XWG8UI1ctIsMIA/suxYYoxW4qVxPH+xF9Vrs/Khbj0UQvChjNmpxysx5MN6K
         mafFU6ey64kC7VOfnQrrxUkSxeEoo/9G7fJCxwJhnKpwX2cOKxiZK2cOH/t6YSgES6Wc
         SrIjNmLKL8WxsfuIRYXfUw0Oe+TjmhwR+Oz+GxzlicFwP0+G2sCHmbItgMOxNrpNn29K
         RnY5A5U7V5MwOa3a3+xwbJw9WRPkGGZroYD5lD6LV1ArrOdvLm8OeUFwJBed8dGGAgaF
         d5w0jJdlTEtD6sROhHV/emMsaA9evuapzOBPIRXVLIaFmG/3NQtmW1fo4lYKeJFhBmVo
         nM4A==
X-Gm-Message-State: AOAM532hO5rBZ5U1ENJLm4uj8Ai/GznS0O63mEZOq0a++0PAy/0+QfWs
        RmoAxsqsujVbOFX/aWrH3+UST1k7aMHLoiHFqnQwTA==
X-Google-Smtp-Source: ABdhPJyDtcPX6VXvaMLnZ91FH4O9lU7rnKE7YOOPR3GPSyYG8Zg2zU2edbOYWwypk5XnqIw/OipxoPDHtjpqG7bdiHA=
X-Received: by 2002:a17:906:6bc6:: with SMTP id t6mr5773614ejs.383.1599248441081;
 Fri, 04 Sep 2020 12:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <1598856077-58603-1-git-send-email-chao@eero.com> <20200904175007.GG29330@paulmck-ThinkPad-P72>
In-Reply-To: <20200904175007.GG29330@paulmck-ThinkPad-P72>
From:   Chao Zhou <chao@eero.com>
Date:   Fri, 4 Sep 2020 12:40:29 -0700
Message-ID: <CAOr4Z-uwhX3LY=2x84da_uqAnX3dgpsgGSztQJLE6YEduCrR0w@mail.gmail.com>
Subject: Re: [PATCH] rcu: allow multiple stalls before panic
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thanks Paul. Appreciated it.

Initial intent was to give users a way to make their system more
tolerable, but prudent enough to recover if suspicious behavior
reaches a watermark. If a system experiences multiple stalls in one
lifetime, no matter how healthy it looks or whether the stalls are
from different sources, we still want it to dramatically recover.
Please share your guidance?

eero inc.

660 3rd St, 4th Floor

San Francisco, CA 94107



On Fri, Sep 4, 2020 at 11:05 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Aug 30, 2020 at 11:41:17PM -0700, chao wrote:
> > Some stalls are transient and system can fully recover.
> > Allow users to configure the number of stalls experienced
> > to trigger kernel Panic.
> >
> > Signed-off-by: chao <chao@eero.com>
>
> Hearing no objections, I have queued this with wordsmithing as shown
> below.  Please let me know if I messed something up.
>
> One question, though.  It looks like setting this to (say) 5 would panic
> after the fifth RCU CPU stall warning message, regardless whether all
> five were reporting the same RCU CPU stall event or whether they instead
> were five widely separated transient RCU CPU stall events, where the
> system fully recovered from each event.  Is this the intent?
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit e710c928fb52d8e56bc6173515805301da6aa22b
> Author: chao <chao@eero.com>
> Date:   Sun Aug 30 23:41:17 2020 -0700
>
>     rcu: Panic after fixed number of stalls
>
>     Some stalls are transient, so that system fully recovers.  This commit
>     therefore allows users to configure the number of stalls that must happen
>     in order to trigger kernel panic.
>
>     Signed-off-by: chao <chao@eero.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 500def6..fc2dd3f 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -536,6 +536,7 @@ extern int panic_on_warn;
>  extern unsigned long panic_on_taint;
>  extern bool panic_on_taint_nousertaint;
>  extern int sysctl_panic_on_rcu_stall;
> +extern int sysctl_max_rcu_stall_to_panic;
>  extern int sysctl_panic_on_stackoverflow;
>
>  extern bool crash_kexec_post_notifiers;
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 0fde39b..228c55f 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -13,6 +13,7 @@
>
>  /* panic() on RCU Stall sysctl. */
>  int sysctl_panic_on_rcu_stall __read_mostly;
> +int sysctl_max_rcu_stall_to_panic __read_mostly;
>
>  #ifdef CONFIG_PROVE_RCU
>  #define RCU_STALL_DELAY_DELTA          (5 * HZ)
> @@ -106,6 +107,11 @@ early_initcall(check_cpu_stall_init);
>  /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
>  static void panic_on_rcu_stall(void)
>  {
> +       static int cpu_stall;
> +
> +       if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
> +               return;
> +
>         if (sysctl_panic_on_rcu_stall)
>                 panic("RCU Stall\n");
>  }
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 287862f..1bca490 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2651,6 +2651,17 @@ static struct ctl_table kern_table[] = {
>                 .extra2         = SYSCTL_ONE,
>         },
>  #endif
> +#if defined(CONFIG_TREE_RCU)
> +       {
> +               .procname       = "max_rcu_stall_to_panic",
> +               .data           = &sysctl_max_rcu_stall_to_panic,
> +               .maxlen         = sizeof(sysctl_max_rcu_stall_to_panic),
> +               .mode           = 0644,
> +               .proc_handler   = proc_dointvec_minmax,
> +               .extra1         = SYSCTL_ONE,
> +               .extra2         = SYSCTL_INT_MAX,
> +       },
> +#endif
>  #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
>         {
>                 .procname       = "stack_erasing",
