Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DD2C07E96
	for <rcu@archiver.kernel.org>; Tue, 13 Jul 2021 06:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC3C611AB
	for <rcu@archiver.kernel.org>; Tue, 13 Jul 2021 06:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhGMGTT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Jul 2021 02:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhGMGTS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Jul 2021 02:19:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1591EC0613DD;
        Mon, 12 Jul 2021 23:16:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id dj21so11738307edb.0;
        Mon, 12 Jul 2021 23:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N755/myeCrFum8G4UCZxfG01d/TQE+qL8ItRnH1D5gI=;
        b=pXz+WHI4SxVPWbrRwY10B1qhwgIE/zrSu4mRkL0qK8d4r9paEjbkjQfkFpaZtqmVMK
         F40mIful9n8Hvv3rIK9o1hkcQOCUVWD6H+SyCWGrAkbdmR4p93+TDVpE7KJFN92zkG/E
         FyCnO2J7m+vTrYVfmo6m+ClTgGhQJm2Aatailw7a+mDrmUIFi58cjWNQQ1/pQCClfBeA
         oTyeVEoMn29b7ft9tqSRx8MT005DtAWbzCRNcj0v8GvRJOTh5TAX4QafCZLNjmZzDOG6
         OQZCr0gvK3XXzaXpVR43xFkRAZrpiCP1uaM7fposNnFK+CMVlpJQrX+LizSEqy3JqYVm
         l8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N755/myeCrFum8G4UCZxfG01d/TQE+qL8ItRnH1D5gI=;
        b=oyw8BUMnHGMtL+DjEjiuwEWfNhj9bOGsBVivudn+I7sPactiUmbVuspKXEn/di4Hbs
         a/KbBiL1G3HjNNvVr0+RjDFjIyeDU1FZuQVe0WTObPHTnMBxzPudPo9qnVD8eZUoDZft
         Jf0m2scUjDh/td1mBHDlUgHCWvJ9epyUsNk1A+Bmfygb98BhvnXEHV2+4EoidJmQYs7f
         0GzJigY7FQCp+ZaxuXlO/QaThlv51XO3aBnO2CQEzLP9Hr4jeerihWh74gcW+5rWgcV1
         p4tBHcmNBSqau7jm6uyis48yaejh1sWLUibLUGG/1YXs5hw/3JhJWwLYl1GG5jweITIb
         f7uQ==
X-Gm-Message-State: AOAM533ofEHrhVhuFQe8ndcSwuSfN2dZS1g0rtiHu0jvv+Kv4Ls1dkVq
        G8oWxspH98lg+NUrO4qyqn82Qq45S6rUspBwzCI=
X-Google-Smtp-Source: ABdhPJxb0+N6WRj/GhOgT8oAWNKUlDO67rCxa3DafGwy9Sn1/gVH+bGkHx6Xzi1nAdNDJzbcMFXTnCOalpKU40BOBb4=
X-Received: by 2002:a05:6402:3192:: with SMTP id di18mr3538469edb.186.1626156987630;
 Mon, 12 Jul 2021 23:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210713005645.8565-1-zhouzhouyi@gmail.com> <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 13 Jul 2021 14:16:15 +0800
Message-ID: <CAABZP2zzeVe07Ak0RpN6prwy2_PQoO55WG2XhVy7NG0SnasKAg@mail.gmail.com>
Subject: Re: [PATCH] RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thank you very much,
I went through the wordsmithed version, it looks exquisite!

Thank you for your encouragement.
Cheers
Zhouyi

On Tue, Jul 13, 2021 at 12:16 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Jul 13, 2021 at 08:56:45AM +0800, zhouzhouyi@gmail.com wrote:
> > From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >
> > Hi Paul,
> >
> > During my studying of RCU, I did a grep in the kernel source tree.
> > I found there are 3 places where the macro name CONFIG_TASKS_RCU_TRACE
> > should be CONFIG_TASKS_TRACE_RCU instead.
> >
> > Without memory fencing, the idle/userspace task inspection may not
> > be so accurate.
> >
> > Thanks for your constant encouragement for my studying.
> >
> > Best Wishes
> > Zhouyi
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> Good eyes, and those could cause real bugs, so thank you!
>
> Could you please check the wordsmithed version below?
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit fdcf5524b64f2cc8e6201447644079d9f8d4c821
> Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Date:   Tue Jul 13 08:56:45 2021 +0800
>
>     RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
>
>     This commit fixes several typos where CONFIG_TASKS_RCU_TRACE should
>     instead be CONFIG_TASKS_TRACE_RCU.  Among other things, these typos
>     could cause CONFIG_TASKS_TRACE_RCU_READ_MB=y kernels to suffer from
>     memory-ordering bugs that could result in false-positive quiescent
>     states and too-short grace periods.
>
>     Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index cfeb43bfc719..434d12fe2d4f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -167,7 +167,7 @@ void synchronize_rcu_tasks(void);
>  # define synchronize_rcu_tasks synchronize_rcu
>  # endif
>
> -# ifdef CONFIG_TASKS_RCU_TRACE
> +# ifdef CONFIG_TASKS_TRACE_RCU
>  # define rcu_tasks_trace_qs(t)                                         \
>         do {                                                            \
>                 if (!likely(READ_ONCE((t)->trc_reader_checked)) &&      \
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 27b74352cccf..a8e3acead6f6 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1498,17 +1498,17 @@ static void noinstr rcu_dynticks_task_exit(void)
>  /* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
>  static void rcu_dynticks_task_trace_enter(void)
>  {
> -#ifdef CONFIG_TASKS_RCU_TRACE
> +#ifdef CONFIG_TASKS_TRACE_RCU
>         if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
>                 current->trc_reader_special.b.need_mb = true;
> -#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
> +#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
>  }
>
>  /* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
>  static void rcu_dynticks_task_trace_exit(void)
>  {
> -#ifdef CONFIG_TASKS_RCU_TRACE
> +#ifdef CONFIG_TASKS_TRACE_RCU
>         if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
>                 current->trc_reader_special.b.need_mb = false;
> -#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
> +#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
>  }
