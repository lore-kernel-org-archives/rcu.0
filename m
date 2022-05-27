Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D2CC433F5
	for <rcu@archiver.kernel.org>; Fri, 27 May 2022 15:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345398AbiE0PNe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 May 2022 11:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiE0PNd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 May 2022 11:13:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4416B1CFF3
        for <rcu@vger.kernel.org>; Fri, 27 May 2022 08:13:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v9so5242100lja.12
        for <rcu@vger.kernel.org>; Fri, 27 May 2022 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41SpoIfs7EY5Trq+an/hvTpst/Rhz6EiRSblcCMf3MM=;
        b=P5AegZqcwOv++9jNKTqnLq+xN7jgGedrHR2+U0Fh1x4dAj84q3BS33HBMEjahgS4UZ
         a84PpCagnD8T2Hgpg4saeC7eqsnP+zVil2Sx1gQDJMdyzzsmlo/w4cR2E8ML7NF2xrTs
         nrPFfGI1n8b+eJMpn+AUJuxSnGoCb00AcEfZI2EPk5iOWZxraYW66iDuDogoWLJ2vvU/
         77hm0S1o39krWUIwp9T0oSF1EF4GHTi585GhuPP/aAYkrlHe8F5pVJoe59jwoMEXPzPf
         ATKKsPRcSWjm+Uj3TttwKeDkY6mjBvOlAhlKv7lzVCGQBoJ1utDOE9uzfrnfsDzr/YZC
         YNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41SpoIfs7EY5Trq+an/hvTpst/Rhz6EiRSblcCMf3MM=;
        b=4BihFSFkV/vjG9hLREiJ0eJTUo7+C9SMzVJWsKWjGP/XfPO8U90/K2CTgZk4nv3gSa
         Mz2JMWRVFeZMpSkZv0gK7osbnYW+ZGipZpur74W/5eNP2Yx9ZJupGsvGrcZDau7hYLSH
         S6BtJOZptcP2I1OqHA9Ly3yTVPHJoke9TueXR4xTZXRNvfkFpbDAvJm7zTFmPhagW93k
         Yjipo1SpnSlapQyW/qb/I6uKZB/r74t06qvOclrtcsYqlW1zksEip3QgqlGU8cgV9dpE
         Dy1Qb2idsEBZi0PL20NuszwxGskJIPr5xNr6h149wpzuwsePbxR90snsD4URSlJDrqn1
         SpwA==
X-Gm-Message-State: AOAM533bAjppuBSlQ9r6EBk/hKK1bssNuoIMkVs/loYdFwHT1XwGdvxR
        RlNP/PqyPmPV74ISz+VZyRHaNA9ytqIzesKsQQ7qoQ==
X-Google-Smtp-Source: ABdhPJzc2DJgGsHOMPn0NBmPBazvr8K0v8mrx98ev2ej0DU9kTv0GJ+SEisKxOlZ9/EgzqoZw7wHXDSngUP2LesXBQU=
X-Received: by 2002:a05:651c:a04:b0:253:f0b4:a406 with SMTP id
 k4-20020a05651c0a0400b00253f0b4a406mr12950332ljq.4.1653664410294; Fri, 27 May
 2022 08:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220527170743.04c21d235467.I1f79da0f90fb9b557ec34932136c656bc64b8fbf@changeid>
In-Reply-To: <20220527170743.04c21d235467.I1f79da0f90fb9b557ec34932136c656bc64b8fbf@changeid>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 May 2022 17:13:18 +0200
Message-ID: <CACT4Y+bm++gFi8QYNk41g_ihZuvrMO5O2T_3E7r0h+_PRfShuQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: tiny: record kvfree_call_rcu() call stack for KASAN
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     rcu@vger.kernel.org, kasan-dev@googlegroups.com,
        Johannes Berg <johannes.berg@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 27 May 2022 at 17:07, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> When running KASAN with Tiny RCU (e.g. under ARCH=um, where
> a working KASAN patch is now available), we don't get any
> information on the original kfree_rcu() (or similar) caller
> when a problem is reported, as Tiny RCU doesn't record this.
>
> Add the recording, which required pulling kvfree_call_rcu()
> out of line for the KASAN case since the recording function
> (kasan_record_aux_stack_noalloc) is neither exported, nor
> can we include kasan.h into rcutiny.h.
>
> without KASAN, the patch has no size impact (ARCH=um kernel):
>     text       data         bss         dec        hex    filename
>  6151515    4423154    33148520    43723189    29b29b5    linux
>  6151515    4423154    33148520    43723189    29b29b5    linux + patch
>
> with KASAN, the impact on my build was minimal:
>     text       data         bss         dec        hex    filename
> 13915539    7388050    33282304    54585893    340ea25    linux
> 13911266    7392114    33282304    54585684    340e954    linux + patch
>    -4273      +4064         +-0        -209
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

From KASAN perspective:

Acked-by: Dmitry Vyukov <dvyukov@google.com>

What tree should it go into? mm? rcu? +Paul

> ---
>  include/linux/rcutiny.h | 11 ++++++++++-
>  kernel/rcu/tiny.c       | 14 ++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 5fed476f977f..d84e13f2c384 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -38,7 +38,7 @@ static inline void synchronize_rcu_expedited(void)
>   */
>  extern void kvfree(const void *addr);
>
> -static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +static inline void __kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
>         if (head) {
>                 call_rcu(head, func);
> @@ -51,6 +51,15 @@ static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>         kvfree((void *) func);
>  }
>
> +#ifdef CONFIG_KASAN_GENERIC
> +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> +#else
> +static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +       __kvfree_call_rcu(head, func);
> +}
> +#endif
> +
>  void rcu_qs(void);
>
>  static inline void rcu_softirq_qs(void)
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index 340b3f8b090d..58ff3721d975 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -217,6 +217,20 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
>  }
>  EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
>
> +#ifdef CONFIG_KASAN_GENERIC
> +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +       if (head) {
> +               void *ptr = (void *) head - (unsigned long) func;
> +
> +               kasan_record_aux_stack_noalloc(ptr);
> +       }
> +
> +       __kvfree_call_rcu(head, func);
> +}
> +EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> +#endif
> +
>  void __init rcu_init(void)
>  {
>         open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
> --
> 2.36.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220527170743.04c21d235467.I1f79da0f90fb9b557ec34932136c656bc64b8fbf%40changeid.
